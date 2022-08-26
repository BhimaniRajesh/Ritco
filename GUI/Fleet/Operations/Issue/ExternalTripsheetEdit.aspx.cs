using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class GUI_Fleet_Operations_Issue_ExternalTripsheetEdit : System.Web.UI.Page
{

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    int mDataCount = 0;

    string stVSlipId = "";

    MyFleetDataSet.THCContractRow datarow_THCContract;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
       
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        todDate.Value = strrightnow;

        if (!IsPostBack)
        {

            stVSlipId = Request.QueryString["id"];


            Session["Tripsheet"] = null;

            Session["Tripsheet"] = stVSlipId;


            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string sql = "select V.VSlipNo,Billed_yn,V.driver1,V.Manual_tripsheetno,Convert(varchar,VSlipDt,103) VSlipDt,V.Vehicleno as vehno"
                      + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "

                      + " ,v.driver1,v.CustCode,v.Category,v.Market_Own ,Tripsheet_StartLoc,Tripsheet_EndLoc,From_City,To_City,Route ,(Select custnm  from webx_CUSTHDR  where custcd=v.CustCode) as Custname "
                      + " FROM WEBX_FLEET_VEHICLE_ISSUE v LEFT OUTER JOIN webx_fleet_vehicle_request r ON V.VSlipNo=r.VSlipId "
                      + " where 1=1 and V.VSlipNo='" + stVSlipId + "'";

            SqlCommand cmdVI = new SqlCommand(sql, conn);
            cmdVI.CommandType = CommandType.Text;
            SqlDataReader dataReadVI = cmdVI.ExecuteReader();
            while (dataReadVI.Read())
            {
                lblIssueNo.Text = dataReadVI["VSlipNo"].ToString();
                lblTripDate.Text = dataReadVI["VSlipDt"].ToString();
                hidTripDate.Value = dataReadVI["VSlipDt"].ToString();
                
                
                lblVehicleNo.Text = dataReadVI["vehno"].ToString();
                lblBilled.Text = dataReadVI["Billed_yn"].ToString();

                lblManual.Text = dataReadVI["Manual_tripsheetno"].ToString();

                lblDriverCode.Text = dataReadVI["driver1"].ToString() + " : " + dataReadVI["driver_name"].ToString();
                if (dataReadVI["Category"].ToString().Trim() == "External Usage")
                {
                    lblCategory.Text = dataReadVI["Category"].ToString();
                    lblCustomer.Visible = true;
                    lblMarket.Visible = false;
                    lblCust_Market.Text = dataReadVI["CustCode"].ToString() + "/" + dataReadVI["custname"].ToString();

                    //lblFromCity.Text = dataReadVI["From_City"].ToString();
                    //lblToCity.Text = dataReadVI["To_City"].ToString();
                    //lblRoute.Text = dataReadVI[sss"Route"].ToString();
                }

                if (dataReadVI["Category"].ToString().Trim() == "Internal Usage")
                {
                    lblCustomer.Visible = false;
                    lblMarket.Visible = true;
                    lblCust_Market.Text = dataReadVI["Market_Own"].ToString();
                }



            }

            dataReadVI.Close();
            mDataCount = 0;
            if (mDataCount == 0)
            {

                BindGrid();
            }
            txtAddTHCrow.Text = mDataCount.ToString();
            Previous_THCContractDetail();


        }

        else
        {


            ReverseBind();
        }
     
    }


    private void ReverseBind()
    {
        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            datarow_THCContract = _dataSet.THCContract[gridrow.DataSetIndex];

            datarow_THCContract.FromCity = ((TextBox)gridrow.FindControl("txtFrom")).Text;
            datarow_THCContract.ToCity = ((TextBox)gridrow.FindControl("txtTo")).Text;
            datarow_THCContract.THCNo = ((TextBox)gridrow.FindControl("txtTHCNo")).Text;
            datarow_THCContract.THCDt = ((TextBox)gridrow.FindControl("txtTHCDt")).Text;

            datarow_THCContract.FreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
            datarow_THCContract.LabourChrg = ((TextBox)gridrow.FindControl("txtLabourChrg")).Text;
            datarow_THCContract.OtherChrg = ((TextBox)gridrow.FindControl("txtOtherChrg")).Text;
            datarow_THCContract.TotalChrg = ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text;

        }
    }


    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    public void Previous_THCContractDetail()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
     
        string str = "select  *  from   WEBX_FLEET_TRIPTHCDET  where tripsheetno='" + Session["Tripsheet"].ToString().Trim() + "'  ";
        SqlCommand strcmd = new SqlCommand(str, conn);

        Double mAmt = 0, mEAmt = 0;

        int count = 0;

        SqlDataReader strDR = strcmd.ExecuteReader();
        if (strDR.HasRows)
        {
            while (strDR.Read())
            {

                count = count + 1;
                string From = Convert.ToString(strDR["FromCity"]);
                string To = Convert.ToString(strDR["ToCity"]);
                string ThcNo = Convert.ToString(strDR["THCNo"]);
                string ThcDate = Convert.ToString(strDR["THCDt"]);
                string Freight = Convert.ToString(strDR["FreightAmt"]);
                string Lab = Convert.ToString(strDR["LabourAmt"]);
                string Other = Convert.ToString(strDR["OtherAmt"]);

                string Total = Convert.ToString(strDR["TotalAmt"]);

                _dataSet.THCContract.AddTHCContractRow(From, To, ThcNo, ThcDate, Freight, Lab, Other, Total, "", "", "");
            }

        }

        strDR.Close();
        conn.Close();


        BindGrid();

        txtAddTHCrow.Text = count.ToString();

        string mFreightAmt = "0";
        string mLabourChrg = "0";
        string mOtherChrg = "0";
        double mTotalAmt = 0;


        double mTotFreightAmt = 0;
        double mTotLabourChrg = 0;
        double mTotOtherChrg = 0;
        double mTotTotalAmt = 0;



        
         
        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            mFreightAmt = "0";
            mLabourChrg = "0";
            mOtherChrg = "0";
            mTotalAmt = 0;



            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "")
            {
                {
                    mFreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
                    mTotFreightAmt = mTotFreightAmt + Convert.ToDouble(mFreightAmt);
                }
            }

            if (((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "")
            {
                {
                    mLabourChrg = ((TextBox)gridrow.FindControl("txtLabourChrg")).Text;
                    mTotLabourChrg = mTotLabourChrg + Convert.ToDouble(mLabourChrg);
                }
            }

            if (((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                {
                    mOtherChrg = ((TextBox)gridrow.FindControl("txtOtherChrg")).Text;
                    mTotOtherChrg = mTotOtherChrg + Convert.ToDouble(mOtherChrg);
                }
            }

            mTotalAmt = Convert.ToDouble(mFreightAmt) + Convert.ToDouble(mLabourChrg) + Convert.ToDouble(mOtherChrg);
            mTotTotalAmt = mTotTotalAmt + mTotalAmt;
            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "" || ((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "" || ((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text = mTotalAmt.ToString();
            }


        }
        //TotFreightChrg.Text = mTotFreightAmt.ToString();
        //TotLabourChrg.Text = mTotLabourChrg.ToString();
        //TotOtherChrg.Text = mTotOtherChrg.ToString();
        //TotChrg.Text = mTotTotalAmt.ToString();
    }

    protected void CalcTHCContractAmt(object sender, EventArgs e)
    {
        string mFreightAmt = "0";
        string mLabourChrg = "0";
        string mOtherChrg = "0";
        double mTotalAmt = 0;


        double mTotFreightAmt = 0;
        double mTotLabourChrg = 0;
        double mTotOtherChrg = 0;
        double mTotTotalAmt = 0;

        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            mFreightAmt = "0";
            mLabourChrg = "0";
            mOtherChrg = "0";
            mTotalAmt = 0;



            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "")
            {
                {
                    mFreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
                    mTotFreightAmt = mTotFreightAmt + Convert.ToDouble(mFreightAmt);
                }
            }

            if (((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "")
            {
                {
                    mLabourChrg = ((TextBox)gridrow.FindControl("txtLabourChrg")).Text;
                    mTotLabourChrg = mTotLabourChrg + Convert.ToDouble(mLabourChrg);
                }
            }

            if (((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                {
                    mOtherChrg = ((TextBox)gridrow.FindControl("txtOtherChrg")).Text;
                    mTotOtherChrg = mTotOtherChrg + Convert.ToDouble(mOtherChrg);
                }
            }

            mTotalAmt = Convert.ToDouble(mFreightAmt) + Convert.ToDouble(mLabourChrg) + Convert.ToDouble(mOtherChrg);
            mTotTotalAmt = mTotTotalAmt + mTotalAmt;
            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "" || ((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "" || ((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text = mTotalAmt.ToString();
            }


        }
        //TotFreightChrg.Text = mTotFreightAmt.ToString();
        //TotLabourChrg.Text = mTotLabourChrg.ToString();
        //TotOtherChrg.Text = mTotOtherChrg.ToString();
        //TotChrg.Text = mTotTotalAmt.ToString();

    }

    protected void dgTHCDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_THCContract = ((MyFleetDataSet.THCContractRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtFrom")).Text = datarow_THCContract.FromCity;
            ((TextBox)e.Item.FindControl("txtTo")).Text = datarow_THCContract.ToCity;
            ((TextBox)e.Item.FindControl("txtTHCNo")).Text = datarow_THCContract.THCNo;
            ((TextBox)e.Item.FindControl("txtTHCDt")).Text = datarow_THCContract.THCDt;
            // ((TextBox)e.Item.FindControl("txtFreightAmt")).Text = datarow_THCContract.FreightAmt;
            ((TextBox)e.Item.FindControl("txtFreightAmt")).Text = datarow_THCContract.FreightAmt;

            ((TextBox)e.Item.FindControl("txtLabourChrg")).Text = datarow_THCContract.LabourChrg;
            ((TextBox)e.Item.FindControl("txtOtherChrg")).Text = datarow_THCContract.OtherChrg;


         //   ((HiddenField)e.Item.FindControl("hdTotal")).Value = datarow_THCContract.TotalChrg;
            ((TextBox)e.Item.FindControl("txtTHCTotalAmt")).Text = datarow_THCContract.TotalChrg;

        }


        if ((e.Item.ItemType == ListItemType.Footer || e.Item.ItemType == ListItemType.Footer))
        {



            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string FrtAmt = "", LabAmt = "",OthAmt="",Total="";
            string STR = "select  sum(FreightAmt)  as  FreightTotal,sum(LabourAmt)  as  LabTotal,sum(OtherAmt)  as  OtherTotal, sum(TotalAmt) as Total  from  WEBX_FLEET_TRIPTHCDET    where  tripsheetno='" + Session["Tripsheet"].ToString().Trim() + "' ";
            SqlCommand tcmd = new SqlCommand(STR, conn);
            SqlDataReader tdr = tcmd.ExecuteReader();
            if (tdr.HasRows)
            {
                while (tdr.Read())
                {
                    FrtAmt = Convert.ToString(tdr["FreightTotal"]);
                    LabAmt = Convert.ToString(tdr["LabTotal"]);
                    OthAmt = Convert.ToString(tdr["OtherTotal"]);
                    Total = Convert.ToString(tdr["Total"]);


                }



            }
            tdr.Close();

            conn.Close();
            ((TextBox)e.Item.FindControl("txtFrtTotal")).Text = FrtAmt.ToString();
            ((TextBox)e.Item.FindControl("txtLabTotal")).Text = LabAmt.ToString();

            ((TextBox)e.Item.FindControl("txtOthTotal")).Text = OthAmt.ToString();
            ((TextBox)e.Item.FindControl("txtTotal")).Text = Total.ToString();


        }





    }


    protected void add_rowTHC(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtAddTHCrow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            iroww = iroww + 1;
        }
        miroww = iroww;

        if (mroww < miroww)
        {
            miroww = mroww;
        }


        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.THCContract.RemoveTHCContractRow(_dataSet.THCContract[i]);
            }
        }



        for (i = 0 + miroww; i < Int16.Parse(txtAddTHCrow.Text); i++)
        {

            _dataSet.THCContract.AddTHCContractRow("", "", "", "", "0", "0", "0", "0", "", "", "");
        }



        BindGrid();
    }

    public void BindGrid()
    {

        dgTHC.DataSource = _dataSet.THCContract;
        dgTHC.DataBind();
        _lastEditedPage = dgTHC.CurrentPageIndex;


    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            
      //  conn.Open();
         bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {


        string sqlDEL = "Delete from WEBX_FLEET_TRIPTHCDET where TripSheetNo='" + Session["Tripsheet"].ToString().Trim() + "'";


        SqlCommand cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();



                    foreach (DataGridItem gridrow in dgTHC.Items)
                    {


                 //       ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).ReadOnly = false;


                        string sqlContract = "usp_TripTHCDetailInsert";
                        SqlCommand sqlcmdContract = new SqlCommand(sqlContract, conn, trans);
                        sqlcmdContract.CommandType = CommandType.StoredProcedure;
                        sqlcmdContract.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = Session["Tripsheet"].ToString().Trim();
                        sqlcmdContract.Parameters.Add("@Custcode", SqlDbType.VarChar).Value = lblCust_Market.Text.ToString();
                        sqlcmdContract.Parameters.Add("@FromCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtFrom")).Text;
                        sqlcmdContract.Parameters.Add("@ToCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtTo")).Text;
                        sqlcmdContract.Parameters.Add("@THCNo", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtTHCNo")).Text;
                        sqlcmdContract.Parameters.Add("@THCDt", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtTHCDt")).Text;
                        sqlcmdContract.Parameters.Add("@FreightAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtFreightAmt")).Text);
                        sqlcmdContract.Parameters.Add("@LabourCharges", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtLabourChrg")).Text);
                        sqlcmdContract.Parameters.Add("@OtherCharges", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOtherChrg")).Text);
                   //     sqlcmdContract.Parameters.Add("@TotalAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text);

                       // Double ThcTot = Convert.ToDouble(((HiddenField)gridrow.FindControl("hdTotal")).Value);

                        //sqlcmdContract.Parameters.Add("@TotalAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtFreightAmt")).Text) + Convert.ToDouble(((TextBox)gridrow.FindControl("txtLabourChrg")).Text) + Convert.ToDouble(((TextBox)gridrow.FindControl("txtOtherChrg")).Text);

                        /*sqlcmdContract.Parameters.Add("@TransType", SqlDbType.VarChar).Value = mContract_Transtype;
                        sqlcmdContract.Parameters.Add("@ChqNo", SqlDbType.VarChar).Value = mContract_Chqno;
                        sqlcmdContract.Parameters.Add("@Chqdate", SqlDbType.VarChar).Value = mContract_Chqdate;
                        sqlcmdContract.Parameters.Add("@BankName", SqlDbType.VarChar).Value = mContract_Bankname;
                        sqlcmdContract.Parameters.Add("@BankBranch", SqlDbType.VarChar).Value = mContract_BankBranch;
                        */

                        datarow_THCContract = _dataSet.THCContract[gridrow.DataSetIndex];
                        _dataSet.THCContract[gridrow.DataSetIndex].ItemArray = datarow_THCContract.ItemArray;

                        sqlcmdContract.ExecuteNonQuery();

                    }

                  trans.Commit();

                success = true;
           //     Session["strDriverCode"] = null;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
                Response.Redirect("ExternalTripEditResult.aspx?VSlipId=" + lblIssueNo.Text.ToString(), true);

        

    }

}

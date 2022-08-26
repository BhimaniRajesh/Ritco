using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Issue_frmAddNewJourney : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.JourneyTripSheetRow datarow;
    string mTripSheetId = "";
    int mDataCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {

            mTripSheetId = Request.QueryString["id"];// Session["TripSheetNo"].ToString();

            Session["TripSheetNo"] = mTripSheetId.ToString();

            RetrieveJourneyData();

            if (mDataCount == 0)
            {
                mDataCount = mDataCount + 1;
                Inetialized();
                BindGrid();
            }
            txtAddRow.Text = mDataCount.ToString();


        }
    }


    protected void RetrieveJourneyData()
    {

        conn.Open();

        string sql = "Select TripSheetNo,THCNo,Station_Dist,Arrv_Dep,convert(varchar,Arrv_Dep_Dt,103)Arrv_Dep_Dt,Arrv_Dep_Tm,KM_Reading,KM_Travelled,MFST_Nos,MFST_Destn,Load_Weight,Load_Pkgs,Unload_Weight,Unload_Pkgs,Load_Carried_Tons,Delay_Reason,Load_Carried_Tons,THC_FrtAmt,Signature from WEBX_TRIPSHEET_JOURNEY TJ where TripSheetNo='" + mTripSheetId + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.Text;
        SqlDataReader rd = sqlcmd.ExecuteReader();
        string mStation_Dist = "";
        string mArrv_Dep = "";
        string mArrv_Dep_Dt = "";
        string mArrv_Dep_Tm = "";
        string mKM_Reading = "";
        string mKM_Travelled = "";
        string mMFST_Nos = "";
        string mMFST_Destn = "";
        string mLoad_Weight = "";
        string mLoad_Pkgs = "";
        string mUnload_Weight = "";
        string mUnload_Pkgs = "";
        string mLoad_Carried_Tons = "";
        string mDelay_Reason = "";
        string mTHC_FrtAmt = "";
        string mSignature = "";
        string mTHCNo = "";
        Session["AddEdit"] = "I";

        while (rd.Read())
        {
            mDataCount = mDataCount + 1;
            mTHCNo = rd["THCNo"].ToString();
            mStation_Dist = rd["Station_Dist"].ToString();
            mArrv_Dep = rd["Arrv_Dep"].ToString();
            mArrv_Dep_Dt = rd["Arrv_Dep_Dt"].ToString();
            mArrv_Dep_Tm = rd["Arrv_Dep_Tm"].ToString();
            mKM_Reading = rd["KM_Reading"].ToString();
            mKM_Travelled = rd["KM_Travelled"].ToString();
            mMFST_Nos = rd["MFST_Nos"].ToString();
            mMFST_Destn = rd["MFST_Destn"].ToString();
            mLoad_Weight = rd["Load_Weight"].ToString();
            mLoad_Pkgs = rd["Load_Pkgs"].ToString();
            mUnload_Weight = rd["Unload_Weight"].ToString();
            mUnload_Pkgs = rd["Unload_Pkgs"].ToString();

            mLoad_Carried_Tons = rd["Load_Carried_Tons"].ToString();
            mDelay_Reason = rd["Delay_Reason"].ToString();
            mTHC_FrtAmt = rd["THC_FrtAmt"].ToString();
            mSignature = rd["Signature"].ToString();

            _dataSet.JourneyTripSheet.AddJourneyTripSheetRow(mStation_Dist, mArrv_Dep, mArrv_Dep_Dt, mArrv_Dep_Tm, mKM_Reading, mKM_Travelled, mMFST_Nos, mMFST_Destn, mLoad_Weight, mLoad_Pkgs, mUnload_Weight, mUnload_Pkgs, mLoad_Carried_Tons, mDelay_Reason, mTHCNo, mTHC_FrtAmt, mSignature);
            Session["AddEdit"] = "U";
        }
        BindGrid();
        rd.Close();
        conn.Close();
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


    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.JourneyTripSheetRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtStation_Distance")).Text = datarow.Station_Distance;
            ((DropDownList)e.Item.FindControl("cboArrival_Departure")).SelectedValue = datarow.Arrival_Departure;
            ((TextBox)e.Item.FindControl("txtArrvDepDt")).Text = datarow.Arrv_Dep_Dt;

            string mArrv_Dep_Tm = datarow.Arrv_Dep_Tm;

            string tmp_val_HHMM = "";
            string tmp_val_HH = "";
            string tmp_val_MM = "";
            string tmp_val_AMPM = "";
            string[] tmp_Arr;
            string[] tmp_Arr1;
            if (mArrv_Dep_Tm != "")
            {
                tmp_Arr = mArrv_Dep_Tm.Split(new char[] { ' ' });
                tmp_val_HHMM = tmp_Arr[0].ToString().Trim();
                tmp_val_AMPM = tmp_Arr[1].ToString().Trim();
            }

            if (tmp_val_HHMM != "")
            {
                tmp_Arr1 = tmp_val_HHMM.Split(new char[] { ':' });
                tmp_val_HH = tmp_Arr1[0].ToString().Trim();
                tmp_val_MM = tmp_Arr1[1].ToString().Trim();
            }

            ((DropDownList)e.Item.FindControl("cboArrvDepDt_HH")).SelectedItem.Text = tmp_val_HH.ToString().Trim();// datarow.Arrv_Dep_Tm;
            ((DropDownList)e.Item.FindControl("cboArrvDepDt_MM")).SelectedItem.Text = tmp_val_MM.ToString().Trim();
            ((DropDownList)e.Item.FindControl("cboArrvDepDt_AMPM")).SelectedItem.Text = tmp_val_AMPM.ToString().Trim();



            //Request_WebUserControl ctr1 = new Request_WebUserControl();
            //string str1 = "11:30 AM";
            //string str2 = "11";
            //string str3 = "30";
            //string str4 = "AM";
            //DropDownList dlst1 = ((DropDownList)ctr1.FindControl("cboTime").FindControl("cboArrvDepDt_HH"));
            //dlst1.SelectedValue = str2;



            ((TextBox)e.Item.FindControl("txtKM_Reading")).Text = datarow.KM_Reading;
            ((TextBox)e.Item.FindControl("txtKM_Travelled")).Text = datarow.KM_Travelled;
            ((TextBox)e.Item.FindControl("txtMFST_No")).Text = datarow.MFST_No;
            ((TextBox)e.Item.FindControl("txtDestn")).Text = datarow.Destn;
            ((TextBox)e.Item.FindControl("txtLoad_Weight")).Text = datarow.Load_Weight;
            ((TextBox)e.Item.FindControl("txtLoad_Pkgs")).Text = datarow.Load_Pkgs;
            ((TextBox)e.Item.FindControl("txtUnload_Weight")).Text = datarow.Unload_Weight;
            ((TextBox)e.Item.FindControl("txtUnload_Pkgs")).Text = datarow.Unload_Pkgs;
            ((TextBox)e.Item.FindControl("txtLoad_Tons")).Text = datarow.Load_Tons;
            ((TextBox)e.Item.FindControl("txtDelay_Reason")).Text = datarow.Delay_Reason;
            ((TextBox)e.Item.FindControl("txtTHCno")).Text = datarow.THCno;
            ((TextBox)e.Item.FindControl("txtFreightAmt")).Text = datarow.FreightAmt;
            ((TextBox)e.Item.FindControl("txtSignature")).Text = datarow.Signature;


        }

    }

    public void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.JourneyTripSheet;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;
    }
    public void Inetialized()
    {
        _dataSet.JourneyTripSheet.AddJourneyTripSheetRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
    }


    protected void add_row(object sender, EventArgs e)
    {
        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtAddRow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in DataGrid1.Items)
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
                _dataSet.JourneyTripSheet.RemoveJourneyTripSheetRow(_dataSet.JourneyTripSheet[i]);
            }
        }

        for (i = 0 + miroww; i < Int16.Parse(txtAddRow.Text); i++)
        {
            _dataSet.JourneyTripSheet.AddJourneyTripSheetRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        }

        BindGrid();
    }

    

    protected void SubmitData(object sender, EventArgs e)
    {


        string sql = "";
        string mTripSheetNo = Session["TripSheetNo"].ToString().Trim();

        conn.Open();
        bool success = false;
        SqlTransaction trans;

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        trans = conn.BeginTransaction();
        try
        {


            sql = "Delete from WEBX_TRIPSHEET_JOURNEY where TripSheetNo='" + mTripSheetNo + "'";
            SqlCommand JDetail = new SqlCommand(sql, conn, trans);
            JDetail.CommandType = CommandType.Text;
            JDetail.ExecuteNonQuery();


            
            foreach (DataGridItem gridrow in DataGrid1.Items)
            {


                string mStation_Distance = ((TextBox)gridrow.FindControl("txtStation_Distance")).Text;
                string mArrival_Departure = ((DropDownList)gridrow.FindControl("cboArrival_Departure")).SelectedValue;

                DateTime mArrv_Dep_Dt = new DateTime();
                mArrv_Dep_Dt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtArrvDepDt")).Text, dtfi);


                //DateTime mArrv_Dep_Tm = new DateTime();
                string mArrv_Dep_Tm = "";
                string mArrv_Dep_Tm_HH = ((DropDownList)gridrow.FindControl("cboArrvDepDt_HH")).SelectedValue;
                string mArrv_Dep_Tm_MM = ((DropDownList)gridrow.FindControl("cboArrvDepDt_MM")).SelectedValue;
                string mArrv_Dep_Tm_AMPM = ((DropDownList)gridrow.FindControl("cboArrvDepDt_AMPM")).SelectedValue;
                mArrv_Dep_Tm = mArrv_Dep_Tm_HH + ":" + mArrv_Dep_Tm_MM + " " + mArrv_Dep_Tm_AMPM;

                string mKM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
                string mKM_Travelled = ((TextBox)gridrow.FindControl("txtKM_Travelled")).Text;
                string mMFST_No = ((TextBox)gridrow.FindControl("txtMFST_No")).Text;
                string mDestn = ((TextBox)gridrow.FindControl("txtDestn")).Text;
                string mLoad_Weight = ((TextBox)gridrow.FindControl("txtLoad_Weight")).Text;
                string mLoad_Pkgs = ((TextBox)gridrow.FindControl("txtLoad_Pkgs")).Text;
                string mUnload_Weight = ((TextBox)gridrow.FindControl("txtUnload_Weight")).Text;
                string mUnload_Pkgs = ((TextBox)gridrow.FindControl("txtUnload_Pkgs")).Text;
                string mLoad_Tons = ((TextBox)gridrow.FindControl("txtLoad_Tons")).Text;

                string mDelay_Reason = ((TextBox)gridrow.FindControl("txtDelay_Reason")).Text;
                string mTHCno = ((TextBox)gridrow.FindControl("txtTHCno")).Text;
                string mFreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
                string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;



                sql = "Insert into WEBX_TRIPSHEET_JOURNEY (TripSheetNo,THCNo,Station_Dist,Arrv_Dep,Arrv_Dep_Dt,Arrv_Dep_Tm,KM_Reading, "
                      + " KM_Travelled,MFST_Nos,MFST_Destn,Load_Weight,Load_Pkgs,Unload_Weight,Unload_Pkgs,Load_Carried_Tons, "
                      + " Delay_Reason,THC_FrtAmt,Signature) values "
                      + " ( '" + mTripSheetNo + "','" + mTHCno + "','" + mStation_Distance + "','" + mArrival_Departure + "','" + mArrv_Dep_Dt + "','" + mArrv_Dep_Tm + "','" + mKM_Reading + "',"
                      + " '" + mKM_Travelled + "','" + mMFST_No + "','" + mDestn + "','" + mLoad_Weight + "','" + mLoad_Pkgs + "','" + mUnload_Weight + "','" + mUnload_Pkgs + "','" + mLoad_Tons + "',"
                      + " '" + mDelay_Reason + "','" + mFreightAmt + "','" + mSignature + "') ";
                SqlCommand Detail = new SqlCommand(sql, conn, trans);
                Detail.CommandType = CommandType.Text;


                datarow = _dataSet.JourneyTripSheet[gridrow.DataSetIndex];

                _dataSet.JourneyTripSheet[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;

                Detail.ExecuteNonQuery();
                trans.Commit();
                success = true;
            }
            //conn.Close();
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
            Response.Redirect("frmAddNewJourneyDone.aspx?TripSheetNo=" + Session["TripSheetNo"].ToString());
    }
}

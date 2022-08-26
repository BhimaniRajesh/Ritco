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

public partial class GUI_Fleet_Operations_Issue_TripsheetQuery : System.Web.UI.Page
{
    private double sum = 0;

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;

    string stVSlipId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this)");

        //string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ")";
        //cmdSubmit.Attributes.Add("onClick", aa);


        stVSlipId = Request.QueryString["id"];

        string VslipDt = "";
        string VCloseDt = "";
        string ServerDt = "";

        
        conn.Open();
        string mSTR = "select  convert(varchar,Vslipdt,103) as Vslipdt1,ISNULL(convert(varchar,End_Dt_tm,103),'') as VCloseDt ,convert(varchar,getdate(),103) as ServerDt  from webx_fleet_vehicle_issue  where Vslipno='" + stVSlipId + "'";
        SqlCommand mcmd = new SqlCommand(mSTR, conn);
        SqlDataReader mdr = mcmd.ExecuteReader();
        if (mdr.HasRows)
        {
            while (mdr.Read())
            {
                lblSlipdt.Text = Convert.ToString(mdr["Vslipdt1"]);
                VslipDt = Convert.ToString(mdr["Vslipdt1"]);
                VCloseDt = Convert.ToString(mdr["VCloseDt"]);
                ServerDt = Convert.ToString(mdr["ServerDt"]);
            }

        }
        mdr.Close();
        conn.Close();

        string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ",'" + VslipDt + "','" + VCloseDt + "','" + ServerDt + "')";
        cmdSubmit.Attributes.Add("onClick", aa);



        lblError.Text = "";
       
    
        if (!IsPostBack)
        {
          //  conn.Open();



            Session["Tripsheet"] = null;
            Session["Tripsheet"] = stVSlipId;
            lblIssueNo.Text = Session["Tripsheet"].ToString().Trim();
            Previous_advance();

         


        }


            string scr4 = @"<script>
                    function update_city1(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtFromCity').value=elemValue;
                     //document.getElementById('ctl00_MyCPH1_txtFromCity').focus();

                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city1", scr4);


            string scr5 = @"<script>
                    function update_city2(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtToCity').value=elemValue;
                     //document.getElementById('ctl00_MyCPH1_txtToCity').focus();
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city2", scr5);

            




    }

   


    public void Previous_advance()
    {
      //  hdBrCode.



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string mSTR = "  select VoucherRefNo,convert(varchar,AdvDate,103) as ADate, * from WEBX_TRIPSHEET_ADVEXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        SqlCommand cmd = new SqlCommand(mSTR, conn);

        int count = 0;
        SqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                count = count + 1;

                string place = Convert.ToString(dr1["AdvLoc"]);
                string advdt = Convert.ToString(dr1["ADate"]);
                string amt = Convert.ToString(dr1["AdvAmt"]);

                string brnch = Convert.ToString(dr1["BranchCode"]);
                string advpaidby = Convert.ToString(dr1["Signature"]);
                string VoucherRefNo = Convert.ToString(dr1["VoucherRefNo"]);

                _dataSet.AdvanceTaken.AddAdvanceTakenRow(place, advdt, amt, VoucherRefNo, brnch, advpaidby);

            }

        }
        dr1.Close();
        conn.Close();
    
        BindGrid();
        int i = 0;
        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {
            ((TextBox)gridrow.FindControl("txtAdvPlace")).ReadOnly = true;
            ((TextBox)gridrow.FindControl("txtAdvDt")).ReadOnly = true;
            ((TextBox)gridrow.FindControl("txtAdvAmt")).ReadOnly = true;

            ((TextBox)gridrow.FindControl("txtBranchCode")).ReadOnly = true;
            ((TextBox)gridrow.FindControl("txtSignature")).ReadOnly = true;
          
        }

    }
    protected void txtBranchCode_TextChanged(object sender, EventArgs e)
    {


        foreach (DataGridItem mgridrow in dgAdvanceDet.Items)
        {

            if (((TextBox)mgridrow.FindControl("txtBranchCode")).ReadOnly == false)
            {
                lblError.Text = "";
                string mBranchCode = ((TextBox)mgridrow.FindControl("txtBranchCode")).Text;
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                conn.Open();
                string DataFound = "N";

                string msql = "select  * from webx_Location  where loccode='" + mBranchCode.Trim() + "' ";
                SqlCommand cmd = new SqlCommand(msql, conn);
                SqlDataReader mdr = cmd.ExecuteReader();
                if (mdr.HasRows)
                {

                    while (mdr.Read())
                    {
                        DataFound = "Y";

                    }

                }
                mdr.Close();


                if (DataFound == "N")
                {

                    lblError.Visible = true;
                    lblError.Text = "Invalid Branch Code!  Please Enter Valid Branch code!!";
                }


                else
                {
                    lblError.Visible = false;
                    lblError.Text = "";
                }

                conn.Close();

            }
        }
    }
    protected void dgAdvanceDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            datarow_Adv = ((MyFleetDataSet.AdvanceTakenRow)((DataRowView)e.Item.DataItem).Row);

            if (e.Item.ItemIndex >= -1)
            {
                string strSelRadio = ((RadioButton)e.Item.FindControl("chksel")).ClientID;
                ((RadioButton)e.Item.FindControl("chksel")).Attributes.Add("onClick", "fnCheckSel('" + strSelRadio + "')");
            }



            ((TextBox)e.Item.FindControl("txtAdvPlace")).Text = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtAdvDt")).Text = datarow_Adv.AdvDt;
            ((TextBox)e.Item.FindControl("txtAdvAmt")).Text = datarow_Adv.AdvAmt;

            ((HiddenField)e.Item.FindControl("hdBrCode")).Value = datarow_Adv.BranchCode;
            ((HiddenField)e.Item.FindControl("hdVNo")).Value = datarow_Adv.THCno;


            ((TextBox)e.Item.FindControl("txtBranchCode")).Text = datarow_Adv.BranchCode;
            ((TextBox)e.Item.FindControl("txtSignature")).Text = datarow_Adv.Signature;


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
    public void BindGrid()
    {
        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;

    }
  

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string mTripSheetNo = "";

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        System.Globalization.DateTimeFormatInfo year = new System.Globalization.DateTimeFormatInfo();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";

        DateTime  slipdt=new DateTime();
        slipdt=Convert.ToDateTime(lblSlipdt.Text.Trim(),dtfi);

        DateTime mServerDt = DateTime.Now;

       // DateTime today = new DateTime();
      //  slipdt = Convert.ToDateTime(lblSlipdt.Text.Trim(), dtfi);

        string Select="";

        if (lblError.Text == "")
        {
            foreach (DataGridItem gridrow in dgAdvanceDet.Items)
            {
                if (((RadioButton)gridrow.FindControl("chksel")).Checked == true)
                {
                    Select = "Y";
                }
            }
            if (Select.Trim() == "")
            {
                lblError.Text = "Select Atleast one Record!";
            }
        }
        if (lblError.Text == "")
        {
            foreach (DataGridItem gridrow in dgAdvanceDet.Items)
            {
                if (((RadioButton)gridrow.FindControl("chksel")).Checked == true)
                {
                    DateTime mAdvDt1 = new DateTime();
                    mAdvDt1 = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);

                    if (mAdvDt1 < slipdt)
                    {
                        lblError.Text = "Advance Date cannot be less than Vehicle issue slip date!";
                    }
                    if (lblError.Text == "")
                    {
                        if (mAdvDt1 > mServerDt)
                        {
                            lblError.Text = "Advance Date cannot be greater than today's  date!";
                        }
                    }
                }
            }
        }
        //if (lblError.Text == "")
        //{
        //    foreach (DataGridItem mgridrow in dgAdvanceDet.Items)
        //    {
        //        if (((TextBox)mgridrow.FindControl("txtBranchCode")).ReadOnly == false)
        //        {
        //            lblError.Text = "";
        //            string mBranchCode = ((TextBox)mgridrow.FindControl("txtBranchCode")).Text;
        //            //  SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //            conn.Open();
        //            string DataFound = "N";
        //            string msql = "select  * from webx_Location  where loccode='" + mBranchCode.Trim() + "' ";
        //            SqlCommand cmd = new SqlCommand(msql, conn);
        //            SqlDataReader mdr = cmd.ExecuteReader();
        //            if (mdr.HasRows)
        //            {
        //                while (mdr.Read())
        //                {
        //                    DataFound = "Y";
        //                }
        //            }
        //            mdr.Close();
        //            if (DataFound == "N")
        //            {
        //                lblError.Visible = true;
        //                lblError.Text = "Invalid Branch Code!  Please Enter Valid Branch code!!";
        //            }
        //            else
        //            {
        //                lblError.Visible = false;
        //                lblError.Text = "";
        //            }
        //            conn.Close();
        //        }
        //    }
        //}
        if (lblError.Text == "")
        {
            mTripSheetNo = lblIssueNo.Text.ToString();

            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            string mBranchCode = "";
            try
            {

                foreach (DataGridItem gridrow in dgAdvanceDet.Items)
                {
                    if (((RadioButton)gridrow.FindControl("chksel")).Checked == true)
                    {
                     
                        string mAdvPlace = ((TextBox)gridrow.FindControl("txtAdvPlace")).Text;

                        DateTime mAdvDt = new DateTime();
                        mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);

                        string mAdvAmt = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;
 
                        mBranchCode = ((TextBox)gridrow.FindControl("txtBranchCode")).Text;
                        string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;

                      string  hiddenBranch=((HiddenField)gridrow.FindControl("hdBrCode")).Value;

                      string VoucherNo = ((HiddenField)gridrow.FindControl("hdVNo")).Value;




                      UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
                      DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
                      DropDownList dlstAcccode = (DropDownList)paymen.FindControl("dlstAcccode");

                      TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                      TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
                      TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");

                      string madv_Transtype = dlsttranstype.SelectedItem.Value;
                      if (madv_Transtype == "" || madv_Transtype == null)
                      {
                          madv_Transtype = "NULL";
                      }
                      else
                      {
                          madv_Transtype = "'" + madv_Transtype + "'";
                      }


                      string madv_Chqno = txtChqNo.Text;
                      if (madv_Chqno == "" || madv_Chqno == null)
                      {
                          madv_Chqno = "NULL";
                      }
                      else
                      {
                          madv_Chqno = "'" + madv_Chqno + "'";
                      }

                      string madv_Chqdate = txtChqDate.Text;
                      if (madv_Chqdate == "" || madv_Chqdate == null)
                      {
                          madv_Chqdate = "NULL";
                      }
                      else
                      {
                          madv_Chqdate = "'" + madv_Chqdate + "'";
                      }

                      string madv_acccode = dlstAcccode.SelectedItem.Value;
                      if (madv_acccode == "" || madv_acccode == null)
                      {
                          madv_acccode = "NULL";
                      }
                      else
                      {
                          madv_acccode = "'" + madv_acccode + "'";
                      }

                    

                      //string mEntryby1 = "'" + Session["empcd"].ToString() + "'";
                      string mEntryby1 = "'" + SessionUtilities.CurrentEmployeeID.Trim() + "'";





                      string mFinYear = "";
                      //string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
                      //SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, conn, trans);
                      //sqlcmdFinYear.CommandType = CommandType.Text;
                      //SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
                      //if (drFinYear.Read())
                      //{
                      //    mFinYear = drFinYear["YearVal"].ToString().Trim();
                      //}
                      //drFinYear.Close();
                      mFinYear = SessionUtilities.FinYear.ToString().Trim();
                      GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                      string mYearVal = "";
                      mYearVal = objFinYear.FinancialYear();
                      //string mYearVal = "";
                      //if (Session["FinYear_Change"] != null)
                      //{
                      //    mYearVal = Session["FinYear_Change"].ToString().Trim();
                      //}
 







                      if (mAdvAmt != "" && mAdvAmt != null)
                      {
                          string sqlIn = "usp_InsertAdvance";
                          SqlCommand sqlcmdIn = new SqlCommand(sqlIn, conn, trans);
                          sqlcmdIn.CommandType = CommandType.StoredProcedure;
                          sqlcmdIn.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = Session["Tripsheet"].ToString().Trim();// Session["brcd"].ToString();
                          sqlcmdIn.Parameters.Add("@AdvLoc", SqlDbType.VarChar).Value = mAdvPlace;
                          sqlcmdIn.Parameters.Add("@AdvDate", SqlDbType.DateTime).Value = mAdvDt;
                          sqlcmdIn.Parameters.Add("@AdvAmt", SqlDbType.Float).Value = Convert.ToDouble(mAdvAmt);
                          sqlcmdIn.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = mBranchCode;


                          sqlcmdIn.Parameters.Add("@AdvPaidBy", SqlDbType.VarChar).Value = mSignature;// Session["brcd"].ToString();
                          sqlcmdIn.Parameters.Add("@TranType", SqlDbType.VarChar).Value = madv_Transtype;
                          sqlcmdIn.Parameters.Add("@ChqNo", SqlDbType.VarChar).Value = madv_Chqno;
                          sqlcmdIn.Parameters.Add("@ChqDt", SqlDbType.VarChar).Value = madv_Chqdate;
                          sqlcmdIn.Parameters.Add("@Acccode", SqlDbType.VarChar).Value = madv_acccode.Replace("'", "");
                          sqlcmdIn.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = mEntryby1;

                          sqlcmdIn.Parameters.Add("@HidBranch", SqlDbType.VarChar).Value = hiddenBranch.Trim();
                          sqlcmdIn.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;


                          sqlcmdIn.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;


                          sqlcmdIn.ExecuteNonQuery();
                      }


                      //  Fleet Transaction



                      string sqlAcc = "usp_FleetTransaction";
                      SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                      sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                      sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = mBranchCode;// Session["brcd"].ToString();
                      sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "3";
                      sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                      sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                      sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                      sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                      sqlcmdAcc.ExecuteNonQuery();
                    }
                }
                trans.Commit();
                //trans.Rollback();
                success = true;
                Session["strDriverCode"] = null;
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
            {
              string mFlag = "U";
                //    Response.Redirect("~/admin/lenseprice.aspx?code=" + Code + "&LenseId=" + LenseId);
              Response.Redirect("EditTripsheetResult.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mFlag=" + mFlag, true);
            }
        }
    }
    protected void chksel_CheckedChanged(object sender, EventArgs e)
    {

        lblError.Text = "";
        lblError.Visible = false;
        foreach (DataGridItem mgridrow in dgAdvanceDet.Items)
        {


            if (((RadioButton)mgridrow.FindControl("chksel")).Checked == true)
                {


                    ((TextBox)mgridrow.FindControl("txtAdvPlace")).ReadOnly = false;
                    ((TextBox)mgridrow.FindControl("txtAdvDt")).ReadOnly = false;
                    ((TextBox)mgridrow.FindControl("txtAdvAmt")).ReadOnly = false;



                  //-----------------------------------

                    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
                    dtfi.ShortDatePattern = "dd/MM/yyyy";
                    dtfi.DateSeparator = "/";
                    dtfi.ShortTimePattern = "hh:mm tt";

                    DateTime mServerDt = DateTime.Now;

                    DateTime mIssueDt = new DateTime();
                    mIssueDt = Convert.ToDateTime(lblSlipdt.Text.ToString(), dtfi);

                    DateTime mAdvDt = new DateTime();
                    string mAdt = ((TextBox)mgridrow.FindControl("txtAdvDt")).Text;

                    if (mAdt != "" && ((TextBox)mgridrow.FindControl("txtAdvDt")).Text != "")
                    {

                        mAdvDt = Convert.ToDateTime(mAdt, dtfi);

                        DateTime dtFrom = new DateTime();
                        DateTime dtTo = new DateTime();



                        string From = "", To = "";

                        From = "01/04/" + Session["FinYear"].ToString();
                        To = "31/03/" + Convert.ToDouble(Convert.ToDouble(Session["FinYear"].ToString()) + 1);

                        dtFrom = Convert.ToDateTime(From, dtfi);
                        dtTo = Convert.ToDateTime(To, dtfi);

                        if (mAdvDt >= dtFrom && mAdvDt <= dtTo)
                        {
                            lblError.Visible = false;
                            lblError.Text = "";
                        }
                        else
                        {
                            lblError.Visible = true;
                            lblError.Text = "Advance date  should be  in the  range of selected  financial year!";

                        }

                        if (lblError.Text == "")
                        {
                            if (mAdvDt > mServerDt)
                            {
                                lblError.Visible = true;
                                lblError.Text = "Advance Date should not be greater than today's date!";
                            }

                            if (mAdvDt < mIssueDt)
                            {
                                lblError.Visible = true;
                                lblError.Text = "Advance Date should not be less than Issue Slip Date!";
                            }
                        }


                    }



                //----------------------------------






              //  string  amt= ((TextBox)mgridrow.FindControl("txtAdvAmt")).Text;


                UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
                TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");

                    if (((TextBox)mgridrow.FindControl("txtAdvAmt")).Text != "")
                    {
                        txtAmount.Text = ((TextBox)mgridrow.FindControl("txtAdvAmt")).Text;
                    }
                








                    ((TextBox)mgridrow.FindControl("txtBranchCode")).ReadOnly = false;
                    ((TextBox)mgridrow.FindControl("txtSignature")).ReadOnly = false;

                }
                else
                {

                    ((TextBox)mgridrow.FindControl("txtAdvPlace")).ReadOnly = true;
                    ((TextBox)mgridrow.FindControl("txtAdvDt")).ReadOnly = true;
                    ((TextBox)mgridrow.FindControl("txtAdvAmt")).ReadOnly = true;

                    ((TextBox)mgridrow.FindControl("txtBranchCode")).ReadOnly = true;
                    ((TextBox)mgridrow.FindControl("txtSignature")).ReadOnly = true;

                }



            
        }
    }
}

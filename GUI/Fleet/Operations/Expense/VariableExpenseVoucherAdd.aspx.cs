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

using System.IO;


public partial class GUI_Fleet_Operations_Expense_VariableExpenseVoucherAdd : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.FEnExpenseRow datarow_Exp ;

    int mDataCount = 7;

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

         
            if (mDataCount == 7)
            {
              //  BindGrid();

                txtRow.Text = mDataCount.ToString();
            }
         

            Inetial();


        }

        


    }


    public void Inetial()
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;


        rowno = txtRow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense.Items)
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
                _dataSet.FEnExpense.RemoveFEnExpenseRow(_dataSet.FEnExpense[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "","");
            }
            else
            {

                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "","");
            }

        }

        BindGrid();



    }

     


    protected void txtRow_TextChanged(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtRow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;


        int iroww = 0;
        foreach (DataGridItem gridrow in dgExpense.Items)
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
                _dataSet.FEnExpense.RemoveFEnExpenseRow(_dataSet.FEnExpense[i]);
            }
        }


        for (i = 0 + miroww; i < Int16.Parse(txtRow.Text); i++)
        {
            int j = i + 1;
            if (i == 0)
            {
                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "", "");
            }
            else
            {

                _dataSet.FEnExpense.AddFEnExpenseRow(j.ToString(), "", "", "", "", "");
            }

        }
 
        BindGrid();


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
        dgExpense.DataSource = _dataSet.FEnExpense;
        dgExpense.DataBind();
        _lastEditedPage = dgExpense.CurrentPageIndex;



    }





   
    protected void dgExpense_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct codedesc,codeid from webx_Master_General where codetype='VEXP' Order By Codeid", conn);
        conn.Close();
        da1.Fill(ds1, "webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlNature = ((DropDownList)e.Item.FindControl("ddlNature"));
            ddlNature.DataTextField = "CodeDesc";
            ddlNature.DataValueField = "CodeID";
            ddlNature.DataSource = ds1.Tables["webx_Master_General"];
            ddlNature.DataBind();
            ddlNature.Items.Insert(0, "");
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Exp = ((MyFleetDataSet.FEnExpenseRow)((DataRowView)e.Item.DataItem).Row);



        

            DataRow dr = (DataRow)((DataRowView)e.Item.DataItem).Row;

            int mm = Convert.ToInt32(dr["NExpense"].ToString());
            ((DropDownList)e.Item.FindControl("ddlNature")).SelectedIndex = mm;


          
          ((TextBox)e.Item.FindControl("txtVehNo")).Text = datarow_Exp.VehicleNo;

            ((Label)e.Item.FindControl("lbl_Popup_SKU")).Attributes.Add("OnClick", "javascript:openPopupSKU(" + ((TextBox)e.Item.FindControl("txtVehNo")).ClientID.ToString() + ");");
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Exp.Amount;

            ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_Exp.BillNo;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_Exp.EAmt;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_Exp.Remarks;


        }

    }
    protected void SubmitData(object sender, EventArgs e)
    {
        string AttachfileName = "";



        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        System.Globalization.DateTimeFormatInfo year = new System.Globalization.DateTimeFormatInfo();


        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        year.ShortDatePattern = "dd/MM/yy";

        DateTime mServerDt = DateTime.Now;
        DateTime mIssueDt = new DateTime();
        if (txtDate.Text != "")
        {
            mIssueDt = Convert.ToDateTime(txtDate.Text, dtfi);
        }

        lblError.Text = "";




        DateTime IssueYear = new DateTime();


        IssueYear = Convert.ToDateTime(txtDate.Text, year);

        string ISYear = Convert.ToString(IssueYear);

        string[] selvaluesArr;
        string mYear = "";


        selvaluesArr = ISYear.Split(new char[] { '/' });

        int maxarr = selvaluesArr.GetUpperBound(0);

        for (int i = 0; i <= maxarr; i++)
        {

            mYear = selvaluesArr[2].ToString().Trim();
        }




        string mIssueYear = "";

        mIssueYear = Convert.ToString(IssueYear);

        string mYearVal1 = "";

        {
            GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
            mYearVal1 = objFinYear.FinancialYear();

            string[] selvaluesArr1;

            string yr = "";
            selvaluesArr1 = mYearVal1.Split(new char[] { '_' });

            int maxarr1 = selvaluesArr1.GetUpperBound(0);

            for (int i = 0; i <= maxarr1; i++)
            {

                yr = selvaluesArr1[1].ToString().Trim();
            }



            if (mYear.Substring(2, 3).Trim() != mYearVal1.Substring(0, 2).Trim() && mYear.Substring(2, 3).Trim() != yr.Trim())
            {
                lblError.Text = "Selected Financial Year & Voucher Date Year should be Same";


            }

        }

        if (lblError.Text == "")
        {

            DateTime mVDt = new DateTime();

            mVDt = Convert.ToDateTime(txtDate.Text, dtfi);
            if (mVDt > mServerDt)
            {
                lblError.Text = "Voucher Date should not be greater than today's date!";
            }

        }


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string DataF = "N";
        foreach (DataGridItem gridrow in dgExpense.Items)
        {


            if (((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim() != "")
            {

                conn.Open();

                string mVehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim();
                //  ((Label)gridrow.FindControl("lblVehCheck")).Text.Trim();

                ((Label)gridrow.FindControl("lblVehCheck")).Text = "";


                string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + mVehNo.Trim() + "'";
                SqlCommand stCmd = new SqlCommand(mSTR, conn);
                SqlDataReader stDr = stCmd.ExecuteReader();
                if (stDr.HasRows)
                {
                    while (stDr.Read())
                    {

                        // mVehNo = Convert.ToString(stDr["vehno"]);

                        DataF = "Y";
                    }

                }

                stDr.Close();

                if (DataF.Trim() == "N")
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = true;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "Vehicle No. is not Valid!";

                }

                else
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = false;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "";

                }


                conn.Close();

            }


        }










        string ValError = "";
        foreach (DataGridItem mgridrow1 in dgExpense.Items)
        {

            if (((Label)mgridrow1.FindControl("lblVehCheck")).Text.Trim() != "")
            {
                ValError = "Y";

            }
        }



        //string path = Server.MapPath("~/UploadedFiles/");
        //if (fileAttach.PostedFile != null)
        //{
        //    // Get a reference to PostedFile object




        //    HttpPostedFile myFile = fileAttach.PostedFile;

        //    // Get size of uploaded file
        //    int nFileLen = myFile.ContentLength;

        //    // make sure the size of the file is > 0
        //    if (nFileLen > 0 && nFileLen < 50000)
        //    {
        //        string picname = fileAttach.PostedFile.FileName;

        //        string c = System.IO.Path.GetFileName(picname);

        //        AttachfileName = path + fileAttach.FileName;



        //    }


        //}

       

    //    if (lblError.Text == "" && lblVehCheck.Text == "")

        if (lblError.Text == "" && ValError == "")

        {

            string mDocuementNo = "", mCheck = "";

            string sql = "";
           // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            bool success = false;
            SqlTransaction trans;

            trans = conn.BeginTransaction();
            try
            {
                  
                    string YearVal = "";


                    GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                    YearVal = objFinYear.FinancialYear();

 
                    string mSTR = "WebX_SP_GetNextDocumentCode";
                    SqlCommand mcmd1 = new SqlCommand(mSTR, conn, trans);
                    mcmd1.CommandType = CommandType.StoredProcedure;


                    mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                  
                    mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();


                    mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = "VXP";


                    SqlDataReader rTS = mcmd1.ExecuteReader();
                    if (rTS.Read())
                    {
                        mDocuementNo = rTS[0].ToString().Trim();
                    }
                    rTS.Close();

                

                SqlCommand cmd = new SqlCommand("usp_VoucherExpHdr_InsertUpdate", conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = mDocuementNo;
                cmd.Parameters.Add("@VoucherDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate.Text, dtfi);
                            
               // cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehNo.Text.Trim();
                cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                 cmd.Parameters.Add("@Voucher_Loc", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                 cmd.Parameters.Add("@ExpType", SqlDbType.VarChar).Value = "Variable";
                 cmd.Parameters.Add("@Manual_Vno", SqlDbType.VarChar).Value = txtManualVno.Text;

                 cmd.Parameters.Add("@AttachFile", SqlDbType.VarChar).Value = AttachfileName.Trim();


                 cmd.Parameters.Add("@CheckedBy", SqlDbType.VarChar).Value = txtCheckedBy.Text.Trim();
                 cmd.Parameters.Add("@VerifiedBy", SqlDbType.VarChar).Value = txtVerifiedBy.Text.Trim();
                 cmd.Parameters.Add("@ReceivedBy", SqlDbType.VarChar).Value = txtReceivedBy.Text.Trim();
                 cmd.Parameters.Add("@ApprovedBy", SqlDbType.VarChar).Value = txtApprovedBy.Text.Trim();


                cmd.ExecuteNonQuery();


                string mAdvAmt = "";
                SqlCommand cmdDEL = new SqlCommand();
                string sqlDEL = "";
                sqlDEL = "Delete from WEBX_FLEET_VOUCHEREXP_DET where VoucherNo='" + mDocuementNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                double mTotExeAmt = 0;
                foreach (DataGridItem gridrow in dgExpense.Items)
                {
                    string ExpenseId = ((DropDownList)gridrow.FindControl("ddlNature")).Text;
                    string VehicleNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text;


                    string Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                    string ExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                    string BillNo = ((TextBox)gridrow.FindControl("txtBillNo")).Text;
                    string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;

                    Double mAmt = 0, mExeAmt = 0;


                    if (Amt != "")
                    {
                        mAmt = Convert.ToDouble(Amt);

                    }

                    else
                    {
                        mAmt = 0;
                    }
                    if (ExeAmt != "")
                    {
                        mExeAmt = Convert.ToDouble(ExeAmt);

                    }

                    else
                    {
                        mExeAmt = 0;
                    }

                    mTotExeAmt = mTotExeAmt + Convert.ToDouble(mExeAmt.ToString());



                    SqlCommand cmd1 = new SqlCommand("usp_VoucherExpDet_InsertUpdate", conn, trans);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = mDocuementNo;
                    cmd1.Parameters.Add("@ExpenseId", SqlDbType.VarChar).Value = ExpenseId;
                    cmd1.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehicleNo;
                    cmd1.Parameters.Add("@Amt", SqlDbType.Decimal).Value = mAmt;
                    cmd1.Parameters.Add("@ExeAmt", SqlDbType.Decimal).Value = mExeAmt;
                    cmd1.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = BillNo;
                    cmd1.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = Remarks;

                    cmd1.ExecuteNonQuery();

                }



                //------ START OF ACCOUNT TRANSACTION ----------------------------------------------------------------


                string mdlsttranstype = "";
                string mddrCashcode = "";
                string mddrBankaccode = "";
                string mtxtCashAmt = "";
                string mtxtChqAmt = "";
                string mtxtChqNo = "";
                string mtxtChqDate = "";
                string mtxtAmtApplA = "";
                string mtxtNetPay = "";
                string mtxtRecBank = "";
                string mrdDiposited = "";


                string TotalExeAmt = "";
                TotalExeAmt =txtTotalExeAmt.Text;

                //if (txtTotalExeAmt.Text != "" && TotalExeAmt != "0")
                if(mTotExeAmt>0)
                {
                    UserControls_MyPaymentControl paymen = (UserControls_MyPaymentControl)UCMyPaymentControl1;
                    DropDownList dlsttranstype = (DropDownList)paymen.FindControl("ddlPayMode");
                    DropDownList ddrCashcode = (DropDownList)paymen.FindControl("ddrCashcode");
                    DropDownList ddrBankaccode = (DropDownList)paymen.FindControl("ddrBankaccode");

                    TextBox txtCashAmt = (TextBox)paymen.FindControl("txtCashAmt");
                    TextBox txtChqAmt = (TextBox)paymen.FindControl("txtChqAmt");

                    TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                    TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");

                    TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
                    TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");

                    mdlsttranstype = dlsttranstype.SelectedValue;
                    if (mdlsttranstype == "" || mdlsttranstype == null)
                    {
                        mdlsttranstype = "NULL";
                    }
                    else
                    {
                        mdlsttranstype = "'" + mdlsttranstype + "'";
                    }
                    mddrCashcode = ddrCashcode.SelectedValue;
                    if (mddrCashcode == "" || mddrCashcode == null)
                    {
                        mddrCashcode = "NULL";
                    }
                    else
                    {
                        mddrCashcode = "'" + mddrCashcode + "'";
                    }
                    mddrBankaccode = ddrBankaccode.SelectedValue;
                    if (mddrBankaccode == "" || mddrBankaccode == null)
                    {
                        mddrBankaccode = "NULL";
                    }
                    else
                    {
                        mddrBankaccode = "'" + mddrBankaccode + "'";
                    }

                    if (dlsttranstype.SelectedValue == "Cash")
                    {
                        mtxtCashAmt = Convert.ToString(mTotExeAmt);// txtTotalExeAmt.Text;// txtCashAmt.Text;
                    }
                    else if (dlsttranstype.SelectedValue == "Both")
                    {
                        mtxtCashAmt = txtCashAmt.Text;// txtCashAmt.Text;
                    }
                    else
                    {
                        mtxtCashAmt = "";
                    }

                    if (mtxtCashAmt == "" || mtxtCashAmt == null)
                    {
                        mtxtCashAmt = "NULL";
                    }


                    //mtxtChqAmt = txtChqAmt.Text;
                    if (dlsttranstype.SelectedValue == "Bank")
                    {
                        mtxtChqAmt = Convert.ToString(mTotExeAmt);// txtTotalExeAmt.Text;
                    }
                    else if (dlsttranstype.SelectedValue == "Both")
                    {
                        mtxtChqAmt = txtChqAmt.Text;
                    }
                    else
                    {
                        mtxtChqAmt = "";
                    }
                    if (mtxtChqAmt == "" || mtxtChqAmt == null)
                    {
                        mtxtChqAmt = "NULL";
                    }
                    mtxtChqNo = txtChqNo.Text;
                    if (mtxtChqNo == "" || mtxtChqNo == null)
                    {
                        mtxtChqNo = "NULL";
                    }
                    else
                    {
                        mtxtChqNo = "'" + mtxtChqNo + "'";
                    }

                    mtxtChqDate = txtChqDate.Text;
                    if (mtxtChqDate == "" || mtxtChqDate == null)
                    {
                        mtxtChqDate = "NULL";
                    }
                    else
                    {
                        mtxtChqDate = "'" + mtxtChqDate + "'";
                    }
                    mtxtAmtApplA = txtAmtApplA.Text;
                    if (mtxtAmtApplA == "" || mtxtAmtApplA == null)
                    {
                        mtxtAmtApplA = "NULL";
                    }
                    mtxtNetPay = txtNetPay.Text;
                    if (mtxtNetPay == "" || mtxtNetPay == null)
                    {
                        mtxtNetPay = "NULL";
                    }

                    if (mtxtRecBank == "" || mtxtRecBank == null)
                    {
                        mtxtRecBank = "NULL";
                    }
                    else
                    {
                        mtxtRecBank = "'" + mtxtRecBank + "'";
                    }

                    if (mrdDiposited == "" || mrdDiposited == null)
                    {
                        mrdDiposited = "NULL";
                    }
                    else
                    {
                        mrdDiposited = "'" + mrdDiposited + "'";
                    }


                }

                 string sqlstrExp = "";
                 sqlstrExp = "Update webx_fleet_VoucherExp_hdr set Paymode="+ mdlsttranstype + ",CashAccCode=" + mddrCashcode + ",BankAccCode=" + mddrBankaccode + ",CashAmt=" + mtxtCashAmt + ",ChequeAmt=" + mtxtChqAmt + ",ChequeNo=" + mtxtChqNo + ",ChequeDate=" + mtxtChqDate + ",BankName=" + mtxtRecBank + ",Deposit_YN=" + mrdDiposited + " where VoucherNo='" + mDocuementNo + "'";
                 SqlCommand cmdExp = new SqlCommand(sqlstrExp, conn, trans);
                 cmdExp.CommandType = CommandType.Text;
                 cmdExp.ExecuteNonQuery();



                 string mFinYear = "";
                 string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
                 SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, conn, trans);
                 sqlcmdFinYear.CommandType = CommandType.Text;
                 SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
                 if (drFinYear.Read())
                 {
                     mFinYear = drFinYear["YearVal"].ToString().Trim();
                 }
                 drFinYear.Close();

                 string mYearVal = "";
                 GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                 mYearVal = objFinYear.FinancialYear();


                 string sqlAcc = "usp_FleetExpenseVoucher";
                 SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                 sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                 sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                 sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "1";
                 sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mDocuementNo;
                 sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                 sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                 sqlcmdAcc.ExecuteNonQuery();

                //----------------------------------------------------------------------









                 //trans.Rollback();
                trans.Commit();

                success = true;
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
                //Response.Redirect("frmVehicleIssueSlipNew_result.aspx?VSlipId=" + mDocuementNo.Trim(), true);
                Response.Redirect("VariableExpResult.aspx?DocNo=" + mDocuementNo.Trim(), true);

        }
    }
    protected void txtVehNo_TextChanged(object sender, EventArgs e)
    {
        string Driver_WO_Vehicle = "N";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

     

        foreach (DataGridItem gridrow in dgExpense.Items)
        {
            string DataF = "N";

            if (((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim() != "")
            {
                string mVehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text.Trim();
                //  ((Label)gridrow.FindControl("lblVehCheck")).Text.Trim();

                ((Label)gridrow.FindControl("lblVehCheck")).Text = "";


                string mSTR = "Select *  from webx_vehicle_hdr  where vehno='" + mVehNo.Trim() + "'";
                SqlCommand stCmd = new SqlCommand(mSTR, conn);
                SqlDataReader stDr = stCmd.ExecuteReader();
                if (stDr.HasRows)
                {
                    while (stDr.Read())
                    {

                        // mVehNo = Convert.ToString(stDr["vehno"]);

                        DataF = "Y";
                    }

                }

                stDr.Close();

                if (DataF.Trim() == "N")
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = true;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "Vehicle No. is not Valid!";

                }

                else
                {
                    ((Label)gridrow.FindControl("lblVehCheck")).Visible = false;

                    ((Label)gridrow.FindControl("lblVehCheck")).Text = "";

                }
            }


        }
        conn.Close();

    
    }
}

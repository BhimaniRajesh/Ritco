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

public partial class GUI_Fleet_Operations_Expense_ExpenseVoucherMain : System.Web.UI.Page
{
    public double mTotExeAmt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        string Repair = Request.QueryString["Repair"];
        if (Repair == null || Repair == "")
        {
            lblHeader.Text = "EXPENSE VOUCHER FORM - FIXED";
            lblPageHead.Text = "Fixed Expense Voucher";
        }
        else
        {
            lblHeader.Text = "EXPENSE VOUCHER FORM - VARIABLE";
            lblPageHead.Text = "Variable Expense Voucher";
        }

    }

    public void MyGridInsert(DataGrid mDataGrid, string mDocuementNo, SqlConnection conn, SqlTransaction trans, int k, string mStat, string mCrewSal, string mVehTrack, string mFinExp, string mRepair)
    {
        //double mTotExeAmt = 0;
        foreach (DataGridItem gridrow in mDataGrid.Items)
        {
            if ((mStat != "" && k == 1) || (mCrewSal != "" && k == 2) || (mVehTrack != "" && k == 3) || (mFinExp != "" && k == 4) || (mRepair != "" && k == 5))
            {
                string ExpenseId = ((DropDownList)gridrow.FindControl("ddlNature")).Text;
                string Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                string ExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                string BillNo = ((TextBox)gridrow.FindControl("txtBillNo")).Text;
                string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
                string VehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text;

                double mAmt = 0, mExeAmt = 0;
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
                mTotExeAmt = mTotExeAmt + Convert.ToDouble(mExeAmt);

                if (ExpenseId != "")
                {
                    SqlCommand cmd1 = new SqlCommand("usp_VoucherExpDet_InsertUpdate", conn, trans);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = mDocuementNo;
                    cmd1.Parameters.Add("@ExpenseId", SqlDbType.VarChar).Value = ExpenseId;
                    cmd1.Parameters.Add("@Amt", SqlDbType.Float).Value = mAmt;
                    cmd1.Parameters.Add("@ExeAmt", SqlDbType.Float).Value = mExeAmt;
                    cmd1.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = BillNo;
                    cmd1.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = Remarks;
                    cmd1.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehNo;
                    cmd1.ExecuteNonQuery();
                    cmd1.Dispose();
                }
            }
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
        mIssueDt = Convert.ToDateTime(txtDate.Text, dtfi);

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

        //if (Session["FinYear_Change"] != null)
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




            string mStat=Request.QueryString["Stat"];
            string mCrewSal = Request.QueryString["CrewSal"]; 
            string mVehTrack = Request.QueryString["VehTrack"];
            string mFinExp = Request.QueryString["FinExp"];
            string mRepair = Request.QueryString["Repair"];

            string mExpType = "";
            string mExpTypeCode = "";
            string mtransNo = "";

            if (mStat != "" || mCrewSal != "" || mVehTrack != "" || mFinExp != "")
            {
                mExpType = "Fixed";
                mExpTypeCode = "FXP";
                mtransNo = "2";
            }
            if (mRepair != "")
            {
                mExpType = "Variable";
                mExpTypeCode = "VXP";
                mtransNo = "1";
            }

            //UserControls_ExpenseVoucherFV ExpVoucher = (UserControls_ExpenseVoucherFV)UCMyExpenseVoucher1;
            UserControls_MyExpenseVoucherFV ExpVoucher = (UserControls_MyExpenseVoucherFV)UCMyExpenseVoucher1;

            DataGrid dgExpense1 = (DataGrid)ExpVoucher.FindControl("dgExpense1");
            DataGrid dgExpense2 = (DataGrid)ExpVoucher.FindControl("dgExpense2");
            DataGrid dgExpense3 = (DataGrid)ExpVoucher.FindControl("dgExpense3");
            DataGrid dgExpense4 = (DataGrid)ExpVoucher.FindControl("dgExpense4");
            DataGrid dgExpense = (DataGrid)ExpVoucher.FindControl("dgExpense");


            TextBox txtTotalExeAmt = (TextBox)ExpVoucher.FindControl("txtTotalExeAmt");





            string ValError = "";
        
            // For Fixed
            if (mStat != "")
            {
                foreach (DataGridItem mgridrow1 in dgExpense1.Items)
                {
                    if (((Label)mgridrow1.FindControl("lblVehCheck")).Text.Trim() != "")
                    {
                        ValError = "Y";
                    }
                }
            }
            if (mCrewSal != "")
            {
                foreach (DataGridItem mgridrow2 in dgExpense2.Items)
                {
                    if (((Label)mgridrow2.FindControl("lblVehCheck")).Text.Trim() != "")
                    {
                        ValError = "Y";
                    }
                }
            }
            if (mVehTrack != "")
            {
                foreach (DataGridItem mgridrow3 in dgExpense3.Items)
                {
                    if (((Label)mgridrow3.FindControl("lblVehCheck")).Text.Trim() != "")
                    {
                        ValError = "Y";
                    }
                }
            }
            if (mFinExp != "")
            {
                foreach (DataGridItem mgridrow4 in dgExpense4.Items)
                {
                    if (((Label)mgridrow4.FindControl("lblVehCheck")).Text.Trim() != "")
                    {
                        ValError = "Y";
                    }
                }
            }
        
            // For Variable
            if (mRepair != "")
            {
                foreach (DataGridItem mgridrow5 in dgExpense.Items)
                {
                    if (((Label)mgridrow5.FindControl("lblVehCheck")).Text.Trim() != "")
                    {
                        ValError = "Y";
                    }
                }
            }
  
           if (lblError.Text == "" && ValError == "")
            {

                string mDocuementNo = "", mCheck = "";
                string sql = "";
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
                    mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = mExpTypeCode;// "FXP";
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
                    cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    cmd.Parameters.Add("@Voucher_Loc", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                    cmd.Parameters.Add("@ExpType", SqlDbType.VarChar).Value = mExpType;// "Fixed";
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
                    
                   
                   
                    for (int i = 1; i < 5 ; i++)
                    {
                        DataGrid tgrdcntrl = (DataGrid)ExpVoucher.FindControl("dgExpense" + i.ToString());
                        MyGridInsert(tgrdcntrl, mDocuementNo, conn, trans, i, mStat, mCrewSal, mVehTrack, mFinExp, mRepair);
                    }

                    DataGrid Vtgrdcntrl = (DataGrid)ExpVoucher.FindControl("dgExpense");
                    if (mRepair != "")
                    {
                        MyGridInsert(Vtgrdcntrl, mDocuementNo, conn, trans, 5, mStat, mCrewSal, mVehTrack, mFinExp, mRepair);
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


                    //string TotalExeAmt = "";
                    //TotalExeAmt = txtTotalExeAmt.Text;
                    //mTotExeAmt = Convert.ToDouble(TotalExeAmt.ToString());
                    if (mTotExeAmt > 0)
                    {
                        UserControls_MyPaymentControlEXP paymen = (UserControls_MyPaymentControlEXP)UCMyPaymentControl1;
                        
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
                            mtxtCashAmt = Convert.ToString(mTotExeAmt);
                        }
                        else if (dlsttranstype.SelectedValue == "Both")
                        {
                            mtxtCashAmt = txtCashAmt.Text;
                        }
                        else
                        {
                            mtxtCashAmt = "";
                        }

                        if (mtxtCashAmt == "" || mtxtCashAmt == null)
                        {
                            mtxtCashAmt = "NULL";
                        }

                        if (dlsttranstype.SelectedValue == "Bank")
                        {
                            mtxtChqAmt = Convert.ToString(mTotExeAmt);
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
                    sqlstrExp = "Update webx_fleet_VoucherExp_hdr set Paymode=" + mdlsttranstype + ",CashAccCode=" + mddrCashcode + ",BankAccCode=" + mddrBankaccode + ",CashAmt=" + mtxtCashAmt + ",ChequeAmt=" + mtxtChqAmt + ",ChequeNo=" + mtxtChqNo + ",ChequeDate=" + mtxtChqDate + ",BankName=" + mtxtRecBank + ",Deposit_YN=" + mrdDiposited + " where VoucherNo='" + mDocuementNo + "'";
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
                 
                    //GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                    mYearVal = objFinYear.FinancialYear();


                    string sqlAcc = "usp_FleetExpenseVoucher";
                    SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                    sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                    sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                    sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = mtransNo;// "2";
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
            {
                Response.Redirect("ExpResult.aspx?DocNo=" + mDocuementNo.Trim() + "&ExpType=" + mExpType, true);
            }
   
        }

    }
}

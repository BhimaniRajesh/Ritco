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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_finance_chqMgt_onAccount : System.Web.UI.Page
{
    string connStr;
    MyFunctions myFunc;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            connStr = Session["SqlProvider"].ToString().Trim();
            txtOnAcDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

            cmdctrpopup.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=3&ctrCodeName=" + txtCustCode.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");

            myFunc = new MyFunctions();
            string maxValue, minValue;
            maxValue = DateTime.Now.ToString("dd MMM yyyy");
            if (Convert.ToDateTime(Session["FinYearEnd"].ToString()) <= Convert.ToDateTime(maxValue))
            {
                maxValue = myFunc.DatadateDDMMYYYY(Session["FinYearEnd"].ToString());
                minValue = myFunc.DatadateDDMMYYYY(Session["FinYearStart"].ToString());
            }
            else
            {
                maxValue = DateTime.Now.ToString("dd/MM/yyyy");
                minValue = myFunc.DatadateDDMMYYYY(Session["FinYearStart"].ToString());
            }
            txtOnAcDate.Attributes.Add("onblur", "javascript:" + myFunc.getDateValidateString(txtOnAcDate, minValue, maxValue));
            
            AccountTrans Acctrans = new AccountTrans();
            string validcust = Acctrans.getValidCustomer();


            string strjs = " javascript : var raisedon=document.getElementById('" + txtCustCode.ClientID + "');" +
                           " var valuetoCompare = '" + validcust + "';" +
                           " raisedon.value = raisedon.value.toUpperCase();" +
                           " alert(raisedon.value);" +
                           " alert(valuetoCompare);" +
                           " alert(valuetoCompare.indexOf(raisedon.value));" +
                           " if((valuetoCompare.indexOf(raisedon.value)<0)&&(raisedon.value!=''))  {" +
                           " alert('Invalid Customer Code !!!'); " +
                           " raisedon.focus();" +
                           " return; }";
            Acctrans = null;

            txtCustCode.Attributes.Add("OnBlur", strjs);


            string strjs1 = "<script language='javascript'> function fcheckpayment(sender,args)" +
            "{ " +
            "    custcd=document.getElementById('" + txtCustCode.ClientID + "');" +
            "    custnm=document.getElementById('" + txtCustName.ClientID + "');" +
            "    if((custcd.value=='')&&(custnm.value==''))" +
            "    {" +
            "        alert('Please select or enter customer!!!');" +
            "        args.IsValid = false;" +
            "        return;  " +
            "   } " +
            "          args.IsValid = true;" +
            "}" +
            "</script>";

            Page.RegisterClientScriptBlock("jsScript", strjs1);
            
            txtCustName.Attributes.Add("onblur", "javascript : this.value = this.value.toUpperCase();");
            txtNarration.Attributes.Add("onblur", "javascript : this.value = this.value.toUpperCase();");
            txtBankBrn.Attributes.Add("onblur", "javascript : this.value = this.value.toUpperCase();");
            txtBankName.Attributes.Add("onblur", "javascript : this.value = this.value.toUpperCase();");
            
        }

    }
    protected void txtChqDate_TextChanged(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();
       

        try
        {
            string chqno = txtChqNo.Text;
            string chqdate = fn.Mydate1(txtChqDate.Text);
            connStr = Session["SqlProvider"].ToString().Trim();
            SqlParameter[] arParms = new SqlParameter[2];
            arParms[0] = new SqlParameter("@chqno", SqlDbType.VarChar, 6);
            arParms[0].Value = chqno;

            arParms[1] = new SqlParameter("@chqdate", SqlDbType.VarChar, 12);
            arParms[1].Value = chqdate;

            SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_duplicate_cheque", arParms);
            if (rdr.Read())
            {
                if (rdr[0].ToString() == "1")
                {
                    CustomValidator2.ErrorMessage = "Duplicate Cheque No & Date found!!!";

                    txtChqDate.Focus();
                    CustomValidator2.IsValid = false;
                }
            }
            rdr.Close();
        }
        catch (Exception e1)
        {
            CustomValidator2.ErrorMessage = "Please Enter Valid Date!!!";
            txtChqDate.Focus();
            CustomValidator2.IsValid = false;

        }
        finally
        {

        }

    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        myFunc = new MyFunctions();
        string ErrorMsg = "";
        SqlParameter[] arParms = new SqlParameter[2];
        arParms[0] = new SqlParameter("@chqno", SqlDbType.VarChar, 6);
        arParms[0].Value = txtChqNo.Text;

        arParms[1] = new SqlParameter("@chqdate", SqlDbType.VarChar, 12);
        arParms[1].Value = myFunc.Mydate1(txtChqDate.Text);

        SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_duplicate_cheque", arParms);
        if (rdr.Read())
        {
            if (rdr[0].ToString() == "1")
            {
                ErrorMsg = "Duplicate Cheque No & Date found!!!";
                CustomValidator2.ErrorMessage = ErrorMsg;
                CustomValidator2.IsValid = false;
            }
        }
        rdr.Close();
        if (((txtCustCode.Text.ToString()).TrimEnd() == "") && ((txtCustName.Text.ToString()).TrimEnd() == ""))
        {
            ErrorMsg = "Please enter Customer Code or Name ";
            CustomValidator1.ErrorMessage = ErrorMsg;
            CustomValidator1.IsValid = false;
        }

        if (Page.IsValid)
        {
            bool success = false;
            string docNo = "";
            try
            {
               
               
                //Response.Redirect("../../ErrorPage.aspx?PageHead=Cheque Management : On Account Cheque Entry" + "&ErrorMsg=" + ErrorMsg);
                //if (ErrorMsg != "")
                //Server.Execute("~/GUI/ErrorPage.aspx?ErrorPage.aspx?PageHead=Cheque Management : On Account Cheque Entry" + "&ErrorMsg=" + ErrorMsg);
                AccountTrans AcctTrans = new AccountTrans();
                string Finyear = "20" + Session["FinYear"].ToString();
                string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
                if (CloseYear.Length == 1)
                    CloseYear = "0" + CloseYear;
                string yearSuffix = Session["FinYear"].ToString() + "_" + CloseYear;

                ChequeDet chqTrans = new ChequeDet();

                if ((txtCustCode.Text.ToString()).TrimEnd() != "")
                {
                    chqTrans.Ptmsptcd = txtCustCode.Text.ToString();
                    chqTrans.Ptmsptnm = AcctTrans.getCustomerDesc(txtCustCode.Text.ToString());
                }
                else if ((txtCustName.Text.ToString()).TrimEnd() != "")
                {

                    chqTrans.Ptmsptcd = "8888";
                    chqTrans.Ptmsptnm = txtCustName.Text.ToString();
                }

                chqTrans.Chqno = txtChqNo.Text;
                chqTrans.Acccode = "";
                chqTrans.Adjustamt = (float)Convert.ToDouble(txtAmount.Text.ToString());

                chqTrans.Bankbrn = "";
                chqTrans.Banknm = "";
                chqTrans.Brcd = Session["brcd"].ToString();
                chqTrans.Chq_bounce_dt = Convert.ToDateTime("01 Jan 1900");
                chqTrans.Chq_bounceamt = 0;
                chqTrans.Chq_clear = "N";
                chqTrans.Chq_depattempt = 0;
                chqTrans.Chq_flag = "";
                chqTrans.Chq_reoffer_dt = Convert.ToDateTime("01 Jan 1900");
                chqTrans.Chq_status = "SUBMITTED";
                chqTrans.Chq_trf = "N";
                chqTrans.Chqamt = (float)Convert.ToDouble(txtAmount.Text.ToString());
                chqTrans.Chqdt = Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text)); 
                chqTrans.Comments = "";
                chqTrans.Depoflag = "N";
                chqTrans.Empcd = Session["empcd"].ToString();
                chqTrans.OwnCust = "C";

                chqTrans.Recdbrcd = "";
                chqTrans.Transdate = Convert.ToDateTime(myFunc.Mydate1(txtOnAcDate.Text));
                chqTrans.Voucherno = "";
                chqTrans.Depoloccode = Session["brcd"].ToString();
                chqTrans.InsertData();
                chqTrans.OnAccountEntry();
                chqTrans = null;
                //end here        

                success = true;
                AcctTrans = null;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                Response.End();
            }
            finally
            {

            }
            if (success)
                Response.Redirect("./onAccount_done.aspx?chqno=" + txtChqNo.Text + "&chqdate=" + txtChqDate.Text);
        }
    }
}

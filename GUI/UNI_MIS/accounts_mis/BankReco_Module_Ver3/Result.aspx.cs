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
using Microsoft.ApplicationBlocks.Data;
using System.Security;
using System.IO;

public partial class GUI_Finance_Fix_Asset_aaaaa : System.Web.UI.Page
{
    SqlConnection con;
    public static string straccd, p;
    DataTable dt = new DataTable("table1");
    public DataTable dt_san = new DataTable();
    MyFunctions fn = new MyFunctions();
    
    public byte byteRadButtonSelection;
    string LO = "",RO="", Bankcode = "", Fromdate = "", Todate = "";
    string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year = "";
    string openTable = "", transTable = "", DR_CR_type = "", TranType="";
    double Total_CR_amt = 0, Total_DR_amt = 0,CR_Amount=0,DR_Amount=0;
    double open_balance = 0.00;
    string DRCR = "", DRCR1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
		umsg.Hide();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        openTable = "webx_acctopening_" + fin_year;
        transTable = "webx_acctrans_" + fin_year;

        LO = Request.QueryString["LO"].ToString().Trim();
        RO = Request.QueryString["RO"].ToString().Trim();
        Bankcode = Request.QueryString["Bankcode"].ToString().Trim();
        HndBankAcccode.Value = Bankcode;

        string FDate = "01 Apr " + Session["FinYear"].ToString();

        Fromdate = Request.QueryString["Fromdate"].ToString().Trim();
        Todate = Request.QueryString["Todate"].ToString().Trim();
        TranType = Request.QueryString["TranType"].ToString().Trim();
        Lb_RO.Text = RO;
        Lb_LO.Text = LO;
        LB_Bankcode.Text = fn.getAccountDesc("webx_acctinfo", Bankcode);
        Lb_dtaeraneg.Text = Fromdate.ToString() + "-" + Todate.ToString();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        //string tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) < convert(datetime, '" + Fromdate + "' ,106)";
        //string opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + "   With(NOLOCK) where   acccode= '" + Bankcode + "'";
        //string Total_transactional = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + Fromdate + "' ,106) and convert(datetime, '" + Todate + "' ,106) ";

        string tranjaction = "";
        if (LO == "All" && RO == "All")
            tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + FDate + "' ,106) and convert(datetime, '" + Fromdate + "' ,106)-1 ";
        else if ((LO != "All" && RO == "All") || (LO != "All" && RO != "All"))
            tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + FDate + "' ,106) and convert(datetime, '" + Fromdate + "' ,106)-1 and Brcd='" + LO + "'";
        else if (LO == "All" && RO != "All")
            tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + FDate + "' ,106) and convert(datetime, '" + Fromdate + "' ,106)-1 and Brcd in(SELECT Loccode FROM webx_location WHERE (LocCode='" + RO + "' OR Report_Loc='" + RO + "'))";

        //Response.Write("<br>tranjaction-" + tranjaction);
        string opening = "";
        if (LO == "All" && RO == "All")
            opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + "   With(NOLOCK) where   acccode= '" + Bankcode + "' ";
        else if (LO == "All" && RO != "All")
            opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + "   With(NOLOCK) where   acccode= '" + Bankcode + "' and Brcd in(SELECT Loccode FROM webx_location WHERE (LocCode='" + RO + "' OR Report_Loc='" + RO + "'))";
        else if ((LO != "All" && RO == "All") || (LO != "All" && RO != "All"))
            opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + "   With(NOLOCK) where   acccode= '" + Bankcode + "' and Brcd='" + LO + "'";

        string Total_transactional = "";
        if (LO == "All" && RO == "All")
            Total_transactional = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + Fromdate + "' ,106) and convert(datetime, '" + Todate + "' ,106)  ";
        else if ((LO != "All" && RO == "All") || (LO != "All" && RO != "All"))
            Total_transactional = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + Fromdate + "' ,106) and convert(datetime, '" + Todate + "' ,106)  and Brcd='" + LO + "'";
        else if (LO == "All" && RO != "All")
            Total_transactional = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + Fromdate + "' ,106) and convert(datetime, '" + Todate + "' ,106)  and Brcd in(SELECT Loccode FROM webx_location WHERE (LocCode='" + RO + "' OR Report_Loc='" + RO + "'))";
        
        SqlCommand Cmd = new SqlCommand(tranjaction, con);
        SqlDataReader dtr = null;
        dtr = Cmd.ExecuteReader();
        string all_tranDr = "", all_tranCr = "", all_openDr = "", all_openCr = "", Trnas_Dr = "0", Trans_Cr = "0";
        double transactionCr = 0, transactionDr = 0, openCr = 0, openDr = 0, total_Debit = 0, total_Crebit = 0, Total_Dr = 0, Total_Cr = 0;
        while (dtr.Read())
        {
            all_tranDr = dtr["Debit"].ToString();
            all_tranCr = dtr["Credit"].ToString();
        }
        dtr.Close();
        if (Convert.ToDouble(all_tranDr) < Convert.ToDouble(all_tranCr))
        {
            transactionCr = Convert.ToDouble(all_tranCr) - Convert.ToDouble(all_tranDr);
        }
        else if (Convert.ToDouble(all_tranDr) > Convert.ToDouble(all_tranCr))
        {
            transactionDr = Convert.ToDouble(all_tranDr) - Convert.ToDouble(all_tranCr);
        }
        dtr.Close();
        Cmd = new SqlCommand(opening, con);
        dtr = Cmd.ExecuteReader();
        while (dtr.Read())
        {
            all_openDr = dtr["opendebit_i"].ToString();
            all_openCr = dtr["opencredit_i"].ToString();
        }
        dtr.Close();
        if (Convert.ToDouble(all_openDr) < Convert.ToDouble(all_openCr))
        {
            openCr = Convert.ToDouble(all_openCr) - Convert.ToDouble(all_openDr);
        }
        else if (Convert.ToDouble(all_openDr) > Convert.ToDouble(all_openCr))
        {
            openDr = Convert.ToDouble(all_openDr) - Convert.ToDouble(all_openCr);
        }
        
        //***********Transaction  Balance   from Date - to date  Open ********************
        Cmd = new SqlCommand(Total_transactional, con);
        dtr = Cmd.ExecuteReader();
        while (dtr.Read())
        {
            Trnas_Dr = dtr["Debit"].ToString();
            Trans_Cr = dtr["Credit"].ToString();
        }
        dtr.Close();
        Total_Dr = 0;
        Total_Cr = 0;


        if (Convert.ToDouble(Trnas_Dr) < Convert.ToDouble(Trans_Cr))
        {
            Total_Cr = Convert.ToDouble(Trans_Cr) - Convert.ToDouble(Trnas_Dr);
        }
        else if (Convert.ToDouble(Trnas_Dr) > Convert.ToDouble(Trans_Cr))
        {
            Total_Dr = Convert.ToDouble(Trnas_Dr) - Convert.ToDouble(Trans_Cr);
        }
        //***********Transaction  Balance   from Date - to date  Open ********************

        total_Debit = transactionDr + openDr + Total_Dr;
        total_Crebit = transactionCr + openCr + Total_Cr;

        if (total_Debit > total_Crebit)
        {
            open_balance = (total_Debit - total_Crebit);
            DRCR = "DR";
            lbl_Chq_Issued.Text = "Add : Cheques Issued but not presented ";
            lbl_Chq_Recived.Text = "Less : Cheque Deposited But Not Cleared";
        }
        else if (total_Debit < total_Crebit)
        {
            open_balance = (total_Crebit - total_Debit);
            DRCR = "CR";
            lbl_Chq_Issued.Text = "Less : Cheques Issued but not presented ";
            lbl_Chq_Recived.Text = "Add : Cheque Deposited But Not Cleared";
        }
        dtr.Close();
        con.Close();
        string OpenBal = string.Format("{0:0.00}", open_balance).ToString() + " <b>" + DRCR + "</b>";
        LB_Balance_Amount.Text = OpenBal;

        if (!IsPostBack)
        {
            DipsplayReport_FOR_Presented_Chq();
        }
    }
    public void DipsplayReport_FOR_Presented_Chq()
    {    
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";

        sql = "exec USP_Bank_Reconsilation_Module_Ver4 '" + Bankcode + "','" + Fromdate + "','" + Todate + "','" + transTable + "','Credit','" + TranType + "' ";
		DataTable DtlCredit = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
        if (DtlCredit.Rows.Count > 0)
        {
            GV_CHQ_Presented.DataSource = DtlCredit;
            GV_CHQ_Presented.DataBind();
        }

        sql = "exec USP_Bank_Reconsilation_Module_Ver4 '" + Bankcode + "','" + Fromdate + "','" + Todate + "','" + transTable + "','Debit','" + TranType + "' ";
        DataTable DtlDebit = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
        if (DtlDebit.Rows.Count > 0)
        {
            GV_CHQ_Cleared.DataSource = DtlDebit;
            GV_CHQ_Cleared.DataBind();
        }
    }
    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            Total_CR_amt = Convert.ToDouble(Credit.Text.ToString()) + Total_CR_amt;
            
            TextBox Txt_ClearDate = (TextBox)(e.Row.FindControl("Txt_ClearDate"));
            TextBox Txt_Comment = (TextBox)(e.Row.FindControl("Txt_Comment"));
            
            Txt_ClearDate.CssClass = "blackfnt";
            Txt_Comment.CssClass = "blackfnt";
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTOtalCredit = (Label)(e.Row.FindControl("lblTOtalCredit"));
            lblTOtalCredit.Text = Total_CR_amt.ToString("F2");
        }
        if (DRCR == "DR")
        {

            CR_Amount = Total_CR_amt + open_balance;
            CR_AMT.Text = CR_Amount.ToString("F2") + " DR";
            DRCR1 = "DR";
        }
        else
        {
            if (Total_CR_amt > open_balance)
            {
                CR_Amount = Total_CR_amt - open_balance;
                CR_AMT.Text = CR_Amount.ToString("F2") + " DR";
                DRCR1 = "DR";
            }
            else if (Total_CR_amt < open_balance)
            {
                CR_Amount = Total_CR_amt - open_balance;
                CR_AMT.Text = CR_Amount.ToString("F2") + " CR";
                DRCR1 = "CR";
            }
        }
    }
    protected void GV_D_OnRowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            Total_DR_amt = Convert.ToDouble(Credit.Text.ToString()) + Total_DR_amt;
            
            TextBox Txt_ClearDate = (TextBox)(e.Row.FindControl("Txt_ClearDate"));
            TextBox Txt_Comment = (TextBox)(e.Row.FindControl("Txt_Comment"));
            Txt_ClearDate.CssClass = "blackfnt";
            Txt_Comment.CssClass = "blackfnt";
            
            HiddenField Hnd_Flag = (HiddenField)(e.Row.FindControl("Hnd_Flag"));
            HiddenField Hnd_Comment = (HiddenField)(e.Row.FindControl("Hnd_Comment"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTOtalCredit = (Label)(e.Row.FindControl("lblTOtalCredit"));
            lblTOtalCredit.Text = Total_DR_amt.ToString("F2");
        }
        if (DRCR == "DR")
        {
            if (Total_DR_amt > CR_Amount)
            {
                DR_Amount = Total_DR_amt - CR_Amount;
                DR_CR_type = "CR";
            }
            else
            {
                DR_Amount = CR_Amount - Total_DR_amt;
                DR_CR_type = "DR";
            }
        }
        else
        {
            DR_Amount = CR_Amount + Total_DR_amt;
            DR_CR_type = DRCR1;
        }
        DR_AMT.Text = DR_Amount.ToString("F2") + " " + DR_CR_type;
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        string Xml_ChqClear_Details = "<root>";
        string finyear = SessionUtilities.FinYear.ToString();
        string Entryby = SessionUtilities.CurrentEmployeeID.ToString();
		foreach (GridViewRow gridrow in GV_CHQ_Presented.Rows)
        {
            CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
            TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
            var CurrentDate= System.DateTime.Today.ToString("dd/MM/yyyy");
            if (chksrno.Checked)
            {
                if (System.DateTime.Now < WebXConvert.ToDateTime(Txt_ClearDate.Text, "en-GB"))
                {
                    umsg.Show("Sorry !! You Can't Select Future Date");
                   return;
                }
            }
        }

        foreach (GridViewRow gridrow in GV_CHQ_Presented.Rows)
        {
            Label lblTransdate = (Label)(gridrow.FindControl("lblTransdate"));
            Label lblVoucherno = (Label)(gridrow.FindControl("lblVoucherno"));  
            Label lblChqno = (Label)(gridrow.FindControl("lblChqno"));
            Label lblChqdate = (Label)(gridrow.FindControl("lblChqdate"));
            Label lblCredit = (Label)(gridrow.FindControl("lblCredit"));
            TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
            TextBox Txt_Comment = (TextBox)(gridrow.FindControl("Txt_Comment"));
            Label lblVouchertype = (Label)(gridrow.FindControl("lblVouchertype"));
            CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
            HiddenField HdnFlag = (HiddenField)(gridrow.FindControl("HdnFlag"));

            if (chksrno.Checked)
            {
                if (Txt_ClearDate.Text != "" && HdnFlag.Value == "N")
                {
                    Xml_ChqClear_Details += "<Cheque>";
                    Xml_ChqClear_Details += "<Transdate>" + lblTransdate.Text.Trim() + "</Transdate>";
                    Xml_ChqClear_Details += "<Voucherno>" + lblVoucherno.Text.Trim() + "</Voucherno>";
                    Xml_ChqClear_Details += "<Acccode>" + HndBankAcccode.Value.Trim() + "</Acccode>";
                    Xml_ChqClear_Details += "<Chqno>" + lblChqno.Text.ToString().Trim() + "</Chqno>";
                    Xml_ChqClear_Details += "<Chqdate>" + lblChqdate.Text.Trim() + "</Chqdate>";
                    Xml_ChqClear_Details += "<Debit>0.00</Debit>";
                    Xml_ChqClear_Details += "<Credit>" + lblCredit.Text.Trim() + "</Credit>";
                    Xml_ChqClear_Details += "<Chqcleardate>" + fn.Mydate1(Txt_ClearDate.Text).Trim() + "</Chqcleardate>";
                    Xml_ChqClear_Details += "<comment>" + Txt_Comment.Text.Trim() + "</comment>";
                    Xml_ChqClear_Details += "<Transtype>" + lblVouchertype.Text.Trim() + "</Transtype>";
                    Xml_ChqClear_Details += "<Entryby>" + Entryby.ToString().Trim() + "</Entryby>";
                    Xml_ChqClear_Details += "</Cheque>";
                }
            }
        }
		foreach (GridViewRow gridrow in GV_CHQ_Cleared.Rows)
        {
            CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
            TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
            var CurrentDate = System.DateTime.Today.ToString("dd/MM/yyyy");
            if (chksrno.Checked)
            {
                if (System.DateTime.Now < WebXConvert.ToDateTime(Txt_ClearDate.Text, "en-GB"))
                {
                    umsg.Show("Sorry !! You Can't Select Future Date");
                    return;
                }
            }
        }
        foreach (GridViewRow gridrow in GV_CHQ_Cleared.Rows)
        {
            Label lblTransdate = (Label)(gridrow.FindControl("lblTransdate"));
            Label lblVoucherno = (Label)(gridrow.FindControl("lblVoucherno"));
            Label lblChqno = (Label)(gridrow.FindControl("lblChqno"));
            Label lblChqdate = (Label)(gridrow.FindControl("lblChqdate"));
            Label lblCredit = (Label)(gridrow.FindControl("lblCredit"));
            TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
            TextBox Txt_Comment = (TextBox)(gridrow.FindControl("Txt_Comment"));
            Label lblVouchertype = (Label)(gridrow.FindControl("lblVouchertype"));
            CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
            HiddenField HdnFlag = (HiddenField)(gridrow.FindControl("HdnFlag"));

            if (chksrno.Checked)
            {
                if (Txt_ClearDate.Text != "" && HdnFlag.Value == "N")
                {
                    Xml_ChqClear_Details += "<Cheque>";
                    Xml_ChqClear_Details += "<Transdate>" + lblTransdate.Text.Trim() + "</Transdate>";
                    Xml_ChqClear_Details += "<Voucherno>" + lblVoucherno.Text.Trim() + "</Voucherno>";
                    Xml_ChqClear_Details += "<Acccode>" + HndBankAcccode.Value.Trim() + "</Acccode>";
                    Xml_ChqClear_Details += "<Chqno>" + lblChqno.Text.ToString().Trim() + "</Chqno>";
                    Xml_ChqClear_Details += "<Chqdate>" + lblChqdate.Text.Trim() + "</Chqdate>";
                    Xml_ChqClear_Details += "<Debit>" + lblCredit.Text.Trim() + "</Debit>";
                    Xml_ChqClear_Details += "<Credit>0.00</Credit>";
                    Xml_ChqClear_Details += "<Chqcleardate>" + fn.Mydate1(Txt_ClearDate.Text).Trim() + "</Chqcleardate>";
                    Xml_ChqClear_Details += "<comment>" + Txt_Comment.Text.Trim() + "</comment>";
                    Xml_ChqClear_Details += "<Transtype>" + lblVouchertype.Text.Trim() + "</Transtype>";
                    Xml_ChqClear_Details += "<Entryby>" + Entryby.ToString().Trim() + "</Entryby>";
                    Xml_ChqClear_Details += "</Cheque>";
                }
            }
        }
        Xml_ChqClear_Details += "</root>";

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlTransaction trans;

        trans = con.BeginTransaction();
        string Sql = "";

        try
        {
            Sql = "exec usp_InsertChequeClearDtl_Ver4 '" + Xml_ChqClear_Details.Replace("&", "&amp;").Replace("–", "-").Replace("'", "&apos;").Trim() + "','" + finyear + "'";
            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, Sql);
            trans.Commit();
        }
        catch (Exception e1)
        {
            string ErrorMsg = e1.Message.ToString();
            ErrorMsg = ErrorMsg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("../../../ErrorPage.aspx?PageHead=" + "Transaction Error" + "&ErrorMsg=" + ErrorMsg);
            Response.End();
        }
        con.Close();
        Response.Redirect("RE_Done.aspx", false);
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        HeaderDet.Border = 1;
        TBL_CRI.Border = 1;
        GV_CHQ_Presented.AllowPaging = false;
        GV_CHQ_Presented.BorderWidth = 1;
        GV_CHQ_Presented.CssClass = "blackfnt";
        GV_CHQ_Presented.Font.Size = 10;

        GV_CHQ_Cleared.AllowPaging = false;
        GV_CHQ_Cleared.BorderWidth = 1;
        GV_CHQ_Cleared.CssClass = "blackfnt";
        GV_CHQ_Cleared.Font.Size = 10;

        DipsplayReport_FOR_Presented_Chq();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=BankReco_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(HeaderDet);
        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(GV_CHQ_Presented);
        frm.Controls.Add(GV_CHQ_Cleared);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
}

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
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        openTable = "webx_acctopening_" + fin_year;
        transTable = "webx_acctrans_" + fin_year;

        LO = Request.QueryString["LO"].ToString().Trim();
        RO = Request.QueryString["RO"].ToString().Trim();
        Bankcode = Request.QueryString["Bankcode"].ToString().Trim();
        Fromdate = Request.QueryString["Fromdate"].ToString().Trim();
        Todate = Request.QueryString["Todate"].ToString().Trim();
        TranType = Request.QueryString["TranType"].ToString().Trim();
        Lb_RO.Text =RO;
        Lb_LO.Text = LO;
        LB_Bankcode.Text = fn.getAccountDesc("webx_acctinfo", Bankcode);
        Lb_dtaeraneg.Text = Fromdate.ToString() + "-" + Todate.ToString();
        
        lbl_Chq_Issued.Text = "Cheques Issued but not presented";
        lbl_Chq_Recived.Text = "Cheque Deposited But Not Cleared";

        if (!IsPostBack)
        {
             DipsplayReport_FOR_Presented_Chq();
        }
    }
    public void DipsplayReport_FOR_Presented_Chq()
    {   
        string sql = "";

        sql = "exec USP_Bank_Reconsilation_Module_Ver2 '" + Bankcode + "','" + Fromdate + "','" + Todate + "','O','" + TranType + "' ";
        DataTable dtcredit = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
        if (dtcredit.Rows.Count > 0)
        {
            GV_CHQ_Presented.DataSource = dtcredit;
            GV_CHQ_Presented.DataBind();
            HdnIssueGrid.Value = "Y";
        }
        sql = "exec USP_Bank_Reconsilation_Module_Ver2 '" + Bankcode + "','" + Fromdate + "','" + Todate + "','C','" + TranType + "' ";
        DataTable dtdebit = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
        if (dtdebit.Rows.Count > 0)
        {
            GV_CHQ_Cleared.DataSource = dtdebit;
            GV_CHQ_Cleared.DataBind();
            HdnRecvGrid.Value = "Y";
        }
    }
    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string VID = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("Txt_ClearDate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkBtnClearDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkBtnClearDate")).Attributes.Add("onclick", VID);
            
            Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            Total_CR_amt = Convert.ToDouble(Credit.Text.ToString()) + Total_CR_amt;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTOtalCredit = (Label)(e.Row.FindControl("lblTOtalCredit"));
            lblTOtalCredit.Text = Total_CR_amt.ToString("F2");
        }
    }
    protected void GV_D_OnRowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            Total_DR_amt = Convert.ToDouble(Credit.Text.ToString()) + Total_DR_amt;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTOtalCredit = (Label)(e.Row.FindControl("lblTOtalCredit"));
            lblTOtalCredit.Text = Total_DR_amt.ToString("F2");
        }
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlTransaction trans;
        trans = con.BeginTransaction();
        string Sql = "";
        try
        {
            foreach (GridViewRow gridrow in GV_CHQ_Presented.Rows)
            {
                TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
                TextBox Txt_Comment = (TextBox)(gridrow.FindControl("Txt_Comment"));
                HiddenField Hnd_SRNO = (HiddenField)(gridrow.FindControl("Hnd_SRNO"));
                HiddenField HdnChqdt = (HiddenField)(gridrow.FindControl("HdnChqdt"));
                CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
                Label lblChqno = (Label)(gridrow.FindControl("lblChqno"));
                Label lblChqdate = (Label)(gridrow.FindControl("lblChqdate"));
                
                if (chksrno.Checked)
                {
                    if (Txt_ClearDate.Text != "")
                    {
                        Sql = "Update webx_chq_det set chq_clear='Y',chqcleardate='" + fn.Mydate1(Txt_ClearDate.Text.ToString()) + "',Comment='" + Txt_Comment.Text.ToString() + "'  where  Chqno='" + lblChqno.Text + "' and convert(datetime,chqdt,106)=convert(varchar,'" + HdnChqdt.Value + "',106) and chqindex='" + Hnd_SRNO.Value.ToString() + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, Sql);
                    }
                }
            }
            foreach (GridViewRow gridrow in GV_CHQ_Cleared.Rows)
            {
                TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
                TextBox Txt_Comment = (TextBox)(gridrow.FindControl("Txt_Comment"));
                HiddenField Hnd_SRNO = (HiddenField)(gridrow.FindControl("Hnd_SRNO"));
                HiddenField HdnChqdt = (HiddenField)(gridrow.FindControl("HdnChqdt"));
                CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
                Label lblChqno = (Label)(gridrow.FindControl("lblChqno"));
                Label lblChqdate = (Label)(gridrow.FindControl("lblChqdate"));
                if (chksrno.Checked)
                {
                    if (Txt_ClearDate.Text != "")
                    {
                        Sql = "Update webx_chq_det set chq_clear='Y',chqcleardate='" + fn.Mydate1(Txt_ClearDate.Text.ToString()) + "',Comment='" + Txt_Comment.Text.ToString() + "'  where  Chqno='" + lblChqno.Text + "' and convert(datetime,chqdt,106)=convert(varchar,'" + HdnChqdt.Value + "',106) and chqindex='" + Hnd_SRNO.Value.ToString() + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, Sql);
                    }
                }
            }
            trans.Commit();
            con.Close();
            Response.Redirect("RE_Done.aspx", false);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.End();
        }
    }
}

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

public partial class GUI_Finance_Voucher_Edit_Voucher_Edit_step_2 : System.Web.UI.Page
{   
    public static SqlConnection conn;
    public DataSet ds = new DataSet();
    MyFunctions fn = new MyFunctions();
    public static int intTotalRecords = 0;
    public string FromDtae = "", ToDtae = "", vouchertype = "", voucherno = "", Financial_Year = "", fin_year="";
    public string id, msge;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        FromDtae = Request.QueryString["FromDtae"].ToString();
        ToDtae = Request.QueryString["ToDtae"].ToString();
        vouchertype = Request.QueryString["Vouchertype"].ToString();
        voucherno = Request.QueryString["VoucherNO"].ToString();
        
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        conn.Open();
        if (!IsPostBack)
        {
            DipsplayReport();
        }
        conn.Close();

    }
    public void DipsplayReport()
    {
        string sql = "exec USP_VoucherEdit_Listing_Ver1 '" + FromDtae + "','" + ToDtae + "','" + voucherno + "','" + vouchertype + "','" + fin_year + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        grvcontrols.DataSource = ds;
        grvcontrols.DataBind();

        conn.Close();
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {}
    protected void grvcontrols_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
        }
        catch (Exception exp)
        {
            //Response.Redirect("Message.aspx?" + exp);
        }
    }
    protected void grvcontrols_RowEditing1(object sender, GridViewEditEventArgs e)
    {
        HiddenField hdnvalue = (HiddenField)grvcontrols.Rows[e.NewEditIndex].Cells[0].FindControl("hidcode");
        id = Convert.ToString(hdnvalue.Value);

        if (vouchertype == "Debit" || vouchertype == "Debit,Debit")
            Response.Redirect("DebitVoucher_Edit.aspx?voucherno='" + id + "'");
        else if (vouchertype == "Credit" || vouchertype == "Credit,Credit")
            Response.Redirect("CreditVoucher_Edit.aspx?voucherno='" + id + "'");
        else if (vouchertype == "Contra" || vouchertype == "Contra,Contra")
            Response.Redirect("ContraVoucher_Edit.aspx?voucherno='" + id + "'");
        else if (vouchertype == "Journal" || vouchertype == "Journal,Journal")
            Response.Redirect("JournalVoucher_Edit.aspx?voucherno='" + id + "'");
    }
}

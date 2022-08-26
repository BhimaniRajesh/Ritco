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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;


public partial class GUI_UNI_Net_MIS_FollowUp_Result_Det : System.Web.UI.Page
{
    public static string strcust, dkt_call;
    SqlConnection Conn;
   

    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        BindGrid();
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string Fromdt = Request.QueryString["Fromdt"].ToString();
        string todt = Request.QueryString["todt"].ToString();
        string loc = Request.QueryString["loc"].ToString();
        string cust = Request.QueryString["cust"].ToString();
        string rpt = Request.QueryString["rpt"].ToString();
        string rptmd = Request.QueryString["rptmd"].ToString();

        LBLDATE.Text = Fromdt + " - " + todt;
        LBLRPT.Text = loc;
        lblGrp.Text = cust;

        if (rpt == "1")
            lbltypBill.Text = "Collection Follow-Up Paid";
        else
            lbltypBill.Text = "Collection Follow-Up TO Pay";


        string SQL_STR = "exec  WebxNet_FOllowUP_Paid_ToPay_det '" + Fromdt + "','" + todt + "','" + loc + "','" + cust + "','" + rpt + "','" + rptmd + "'";
        //Response.Write("<BR> SQL_STR : " + SQL_STR);
        SqlCommand CMD = new SqlCommand(SQL_STR, Conn);
        SqlDataAdapter da = new SqlDataAdapter(CMD);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = dkt_call + " No.";
                lblColDockdt.Text = dkt_call + " Date";
            }
        }
    }

    public void DWN_XLS()
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        
            dgDocket.PageIndex = e.NewPageIndex;
        
        
        BindGrid();

    }
}

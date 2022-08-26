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
public partial class GUI_UNI_MIS_Stock_Report_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    double RO_BKGSTOC = 0, RO_DLTSTOC = 0, RO_TSPSTOC = 0, RO_TOTSTOC = 0;
    double TOT_BKGSTOC = 0, TOT_DLTSTOC = 0, TOT_TSPSTOC = 0, TOT_TOTSTOC = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
        }
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string RO, LO, DateType, fromdt, todt;

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT_no = Request.QueryString["stocktype"].ToString();

        string dtFrom = fromdt;
        string dtTo = todt;

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblloc.Text = LO;
        lblro.Text = RO;

        string sqlLoc = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + LO + "'";
        SqlCommand cmdLoc = new SqlCommand(sqlLoc, conn);
        SqlDataReader drLoc;
        drLoc = cmdLoc.ExecuteReader();

        while (drLoc.Read())
        {
            lblloc.Text = Convert.ToString(drLoc["Loccode"]) + ":" + Convert.ToString(drLoc["Locname"]);
        }
        drLoc.Close();

        string sqlRegion = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + RO + "'";
        SqlCommand cmdRegion = new SqlCommand(sqlRegion, conn);
        SqlDataReader drRegion;
        drRegion = cmdRegion.ExecuteReader();

        while (drRegion.Read())
        {
            lblro.Text = Convert.ToString(drRegion["Loccode"]) + ":" + Convert.ToString(drRegion["Locname"]);
        }
        drRegion.Close();

        lblStocktype.Text = RPT_no;
        if(lblStocktype.Text == "1")
        {
            lblStocktype.Text = "Booking Stock";
        }
        else if (lblStocktype.Text=="2")
        {
            lblStocktype.Text = "Delivery Stock";
        }
        else if (lblStocktype.Text == "3")
        {
            lblStocktype.Text = "TransShipment Stock";
        }
        else
        {
            lblStocktype.Text = "ALL";
        }

        string sql_st = "exec webx_Stock_Register_Report '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RPT_no + "'";
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
	sqlcmd12.CommandTimeout = 300;
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;
        conn.Close();
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.Font.Name = "verdana";
        dgDocket.Font.Size = 8;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Stock_Register.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.Font.Name = "verdana";
        dgDocket.Font.Size = 8;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Stock_Register.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            dkt_colname.Font.Bold = true;
            dkt_colname.Text = dkt_call + " No.";
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

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
public partial class GUI_UNI_Net_MIS_TripStatement_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string trnasmode = "";
    double RO_BKGSTOC = 0, RO_DLTSTOC = 0, RO_TSPSTOC = 0, RO_TOTSTOC = 0;
    double TOT_BKGSTOC = 0, TOT_DLTSTOC = 0, TOT_TSPSTOC = 0, TOT_TOTSTOC = 0;
    public int intTotalRecords;
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
            DWN_XLS();

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
        trnasmode = Request.QueryString["transmode"].ToString();

        if (trnasmode == "1")
        {
            lblTransMode.Text = "All";
        }
        else if (trnasmode == "2")
        {
            lblTransMode.Text = "Air";
        }
        else if (trnasmode == "3")
        {
            lblTransMode.Text = "Standard";
        }
        else if (trnasmode == "4")
        {
            lblTransMode.Text = "Train";
        }
        else if (trnasmode == "5")
        {
            lblTransMode.Text = "Express";
        }
        
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

        string sql_st = "exec webx_TripStatement_Report '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + trnasmode + "'";
        //Response.Write(sql_st);
        //Response.End();
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds,"table");
        dgDocket.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        if (intTotalRecords > 0)
        {
            btn_csv.Visible = true;
            btn_csv1.Visible = true;
        }
        else
        {
            dgDocket.Width = new Unit(800);
            btn_csv.Visible = false;
            btn_csv1.Visible = false;
        }
        dgDocket.DataBind();
        dgDocket.Visible = true;
        conn.Close();

    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        dgDocket.BorderWidth = 1;
        dgDocket.Font.Size = 8;
        dgDocket.Font.Name = "verdana";
        dgDocket.AllowPaging = false;
        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TripStatement.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        Response.Write("Trip Statement");
        frm.Controls.Add(dgDocket);
        //frm.Controls.Add(TBL_Stock);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.Header)
        //{
        //    Label dkt_colname = (Label)e.Row.FindControl("lblColname");

        //    dkt_colname.Text = dkt_call + " No.";
        //}
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

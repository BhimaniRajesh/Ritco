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

public partial class GUI_UNI_MIS_RouteList_RouteList : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    double RO_BKGSTOC = 0, RO_DLTSTOC = 0, RO_TSPSTOC = 0, RO_TOTSTOC = 0;
    double TOT_BKGSTOC = 0, TOT_DLTSTOC = 0, TOT_TSPSTOC = 0, TOT_TOTSTOC = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
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
    //protected void Page_LoadComplete(object sender, EventArgs e)
    //{
    //    setWidth();    
    //}
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string startLoc, endLoc, enroute;

        startLoc = Convert.ToString(Request.QueryString["startLoc"]);
        endLoc = Convert.ToString(Request.QueryString["endLoc"]);
        enroute = Convert.ToString(Request.QueryString["enroute"]);


        lblstartLoc.Text = startLoc;
        lblendloc.Text = endLoc;
        lblenloc.Text = enroute;

        if (startLoc == "")
        {
            tr1.Visible = false;
        }
        if (endLoc == "")
        {
            tr2.Visible = false;
        }
        if (enroute == "")
        {
            tr3.Visible = false;
        }
        if (startLoc == "" && endLoc == "" && enroute == "")
        {
            tr1.Visible = true;
            tr2.Visible = true;
            tr3.Visible = true;
            lblstartLoc.Text = "ALL";
            lblendloc.Text = "ALL";
            lblenloc.Text = "ALL";
        }

        string sql_st = "exec WebxNet_RutMaster_det '" + startLoc + "%','%" + endLoc + "','%" + enroute + "%','%%'";
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
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
        Response.AddHeader("content-disposition", "attachment;filename=RoutePerformance.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        Response.Write("Route Performance Report");
        frm.Controls.Add(dgDocket);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //e.Row.Cells[4].Width = new Unit(500);
            e.Row.Cells[5].Text = e.Row.Cells[5].Text + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            e.Row.Cells[5].Text = e.Row.Cells[5].Text + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            e.Row.Cells[5].Text = e.Row.Cells[5].Text + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        }
    }

    private void setWidth()
    {
        if (dgDocket.Rows.Count > 0)
        {
            if (dgDocket.Columns.Count > 0)
            {
                dgDocket.Columns[5].HeaderStyle.Width = new Unit(100);
                dgDocket.Columns[5].ItemStyle.Width = new Unit(100);
            }
        }
    }
}

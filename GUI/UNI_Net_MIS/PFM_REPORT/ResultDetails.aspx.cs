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

public partial class GUI_UNI_MIS_Reassign_Report_ReassignReportDetails : System.Web.UI.Page
{
    public static string Type,Location,dtFrom, dtTo,ReDate,TypeD;
    public static string[] Loc;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        Location = Request.QueryString["location"].ToString();
        //Loc = Location.Split(':');

        Type = Request.QueryString["type"].ToString();
        ReDate =Convert.ToString(Session["ReDate"]);
        TypeD = Convert.ToString(Session["TypeD"]);
        string[] Dat = ReDate.Split('-');
        dtFrom = Dat[0].ToString();
        dtTo = Dat[1].ToString();
        lbldat.Text = ReDate;
        lblloc.Text = Location;
        //lblTypeD.Text = TypeD;

        if (Type == "1")
            lblStatus.Text = "Total Dockets";
        else if (Type == "2")
            lblStatus.Text = "Delivered";
        else if (Type == "3")
            lblStatus.Text = "Not Delivered";
        else if (Type == "4")
            lblStatus.Text = "Delivered and PFM Made";
        else if (Type == "5")
            lblStatus.Text = "Delivered and PFM not Made";
        else if (Type == "6")
            lblStatus.Text = "PFM Made and Recived";
        else if (Type == "7")
            lblStatus.Text = "PFM Made and not REcived";

        if (TypeD == "dockdt")
            lblTypeD.Text = "Booking Date";
        else if (TypeD == "dely_date")
            lblTypeD.Text = "Delivery Date";




        string sql_st = "webx_PFM_Report_det_net '" + dtFrom + "','" + dtTo + "','" + Location + "','" + Type + "','"+ TypeD +"'";
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;

        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=PFM_Report_Details.xls");
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
}

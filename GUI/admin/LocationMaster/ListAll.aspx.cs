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
using System.IO;

public partial class GUI_admin_VehicleMaster_ListAll : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
           bindGrid();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindGrid();
    }
    public void bindGrid()
    {
        cn.Open();
        string sql;
        sql = "select a.loccode,a.locname,a.locaddr,(select b.locname from webx_location b where b.loccode=a.report_loc) as report_loc from webx_location a where  activeflag='Y'order by a.locname";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dt.Columns.Add("Sr. No", typeof(int));
        dt.Columns["Sr. No"].AutoIncrement = true;
        dt.Columns["Sr. No"].AutoIncrementSeed = 1;
        dt.Columns["Sr. No"].AutoIncrementStep = 1;
        adp.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        cn.Close();
    }
	
	protected void lnkbtnXLS_Click(object sender, EventArgs e)
    {
        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd MMM yyyy");

        string strSQL = "exec Usp_Location_ListAll";
        CreateXLS(strSQL, "LocationDetails.xls");
    }

    public void CreateXLS(string qry, string FileName)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlDataAdapter adp = new SqlDataAdapter(qry, conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        DataTable dataTable = ds.Tables[0];  //oClientInfo.GetClientData(Convert.ToInt16(Session["UserID"].ToString()));
        Response.ContentType = "Application/x-msexcel";
        Response.AddHeader("content-disposition", "attachment; filename=\"" + FileName + "\"");
        DataGrid csvGrid = new DataGrid();
        csvGrid.DataSource = dataTable;
        csvGrid.DataBind();
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);
        csvGrid.RenderControl(htmlWriter);
        Response.Write(stringWriter.ToString());
        Response.End();
    }

	
    //protected void jump(object sender, EventArgs e)
    //{
    //    GridView1.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;

    //    Response.Redirect("LocationEdit.aspx");
    //    Session["dHir"] = "";
    //    Session["dLoc"] = "";
    //    Session["tAcLoc"];
    //}
}




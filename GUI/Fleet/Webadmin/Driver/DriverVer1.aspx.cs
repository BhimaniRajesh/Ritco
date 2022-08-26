using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Webadmin_Driver_DriverVer1 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection();//(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string DriverId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {
            //Do Work
        }
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
    protected void lnkbtnXLS_Click(object sender, EventArgs e)
    {
        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd MMM yyyy");

        string strSQL = "exec usp_Driver_List_XLS '01 jan 1950','" + strrightnow + "','',''";
        CreateXLS(strSQL, "DriverDetails.xls");
    }



    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDriver.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string DriverID = dgDriver.DataKeys[thisRow].Values[0].ToString();
            DriverID = DriverID.Trim().ToString();
            string Query = "Delete from  WEBX_FLEET_DRIVERMST where Driver_Id='" + DriverID + "'";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }

    public void BindGrid()
    {

        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string sql = "usp_Driver_List";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        string DriverName = txtDriverName.Text.Trim();
        string DriverManualCode = txtManualDriverCode.Text.Trim();

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        // if (usercode == "")
        {
            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
        }

        da.SelectCommand.Parameters.Add("@DriverName", SqlDbType.VarChar).Value = DriverName;
        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@DriverManualCode", SqlDbType.VarChar).Value = DriverManualCode;

        DataSet ds = new DataSet();
        da.Fill(ds);

        dgDriver.DataSource = ds;
        dgDriver.DataBind();

        conn.Close();


    }



    protected void btnShowDriver_OnClick(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {

    }
}
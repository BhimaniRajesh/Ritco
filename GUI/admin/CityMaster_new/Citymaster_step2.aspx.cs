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
using System.Text; 
using System.IO; 

public partial class GUI_WebAdmin_CityMaster_new_Citymaster_step2 : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            BindGrid();
        }
    }
    private void BindGrid()
    {
        // SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string sql="";
        if (cmbfiltercity.Text == "All")
        {
            //sql = "select Location,State=(select top 1 stnm from webx_STATE where stcd=l.State),Zone=(select top 1 zonename from webx_zonemaster where zonecode=l.region) from webx_citymaster l with(NOLOCK)  order by Location";
            sql = "select Location,State=(select top 1 stnm from webx_STATE where stcd=l.State),Zone=(select top 1 CODEDESC AS zonename from webx_master_GENERAL WHERE CODETYPE='ZONE' AND  codeid=l.region) from webx_citymaster l with(NOLOCK)  order by Location";
        }
        else 
        {
            //sql = "select Location,State=(select top 1 stnm from webx_STATE where stcd=l.State),Zone=(select top 1 zonename from webx_zonemaster where zonecode=l.region) from webx_citymaster l with(NOLOCK) where location like '" + cmbfiltercity.Text + "%'  order by Location";
            sql = "select Location,State=(select top 1 stnm from webx_STATE where stcd=l.State),Zone=(select top 1 CODEDESC AS zonename from webx_master_GENERAL WHERE CODETYPE='ZONE' AND  codeid=l.region) from webx_citymaster l with(NOLOCK) where location like '" + cmbfiltercity.Text + "%' order by Location";
                    
        }
        //gvVehicalPart.DataSource = null;
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        DataView dv = new DataView();
        da.Fill(ds, "webx_citymaster");
        dv = ds.Tables[0].DefaultView;
        gvVehicalPart.DataSource = dv;
        gvVehicalPart.DataBind();
        conn.Close();
    }
    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string ClassId = gvVehicalPart.DataKeys[thisRow].Values[0].ToString();
            ClassId = ClassId.Trim().ToString();
            string Query = "Delete from  webx_citymaster where pickup_loccode='" + ClassId + "'";
            //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }
    protected void cmbfiltercity_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
	protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    {
        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd MMM yyyy");

        string strSQL = "exec USP_CityMaster_XLSDownload";
        CreateXLS(strSQL, "CityMasterDetails.xls");
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
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        DataGrid csvGrid = new DataGrid();
        csvGrid.DataSource = dataTable;
        csvGrid.DataBind();
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);
        csvGrid.RenderControl(htmlWriter);
        Response.Write(stringWriter.ToString());
        Response.End();
    }
}

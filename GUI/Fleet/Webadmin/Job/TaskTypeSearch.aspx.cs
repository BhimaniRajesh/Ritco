using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class TaskTypeSearch : System.Web.UI.Page
{
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
            lnkbtnView.Attributes.Add("onClick", "window.open('TaskTypeView.aspx','new_win','width=700,height=500,scrollbars=yes');");
            lnkbtnPrint.Attributes.Add("onClick", "window.open('TaskTypeView.aspx?print=0','new_win','width=600,height=500,scrollbars=yes');");
        }
    }
    public void BindGrid()
    {
        cls_TaskType objTaskType = new cls_TaskType(Session["SqlProvider"].ToString());
        objTaskType.TaskType = ""; 
        objTaskType.BindGridTaskType(GridView1);  
    }
    protected void btnShow_OnClick(object sender, EventArgs e)
    {
        BindGrid();
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
        string strSQL = "exec [usp_GetSingletonValue] ''";
        CreateXLS(strSQL, "TaskType.xls");
    }
}

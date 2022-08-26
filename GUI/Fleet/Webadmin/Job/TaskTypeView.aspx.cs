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

public partial class TaskTypeView : System.Web.UI.Page
{

  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
            if (Request.QueryString["print"] != null)
            {
                string script;
                script = @"<SCRIPT language='javascript'> func();" + "</SCRIPT>";
                this.RegisterStartupScript("MyAlert", script);
            }
        }
    }
    public void BindGrid()
    {
        cls_TaskType objTaskType = new cls_TaskType(Session["SqlProvider"].ToString().Trim());
        objTaskType.BindGridTaskType(gvTaskType);
    }
    protected void gvTaskType_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

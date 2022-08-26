using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using ApplicationManager;
using System.IO;
using System.Data.SqlClient;

public partial class GUI_Fleet_Webadmin_Job_TaskList : System.Web.UI.Page
{
    static string str_Connetion_String;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["SqlProvider"] != null)
            {
                str_Connetion_String =Convert.ToString(Session["SqlProvider"]).Trim();
                BindGrid(gvTaskHeader, "SELECT [SMTask_Id], VEH_TYPE_CODE,(dbo.fc_VehicleModel(VEH_TYPE_CODE)) AS VEH_TYPE_NAME FROM [Webx_Fleet_SM_Task_Hdr]");
            }
        }
    }
    public void BindGrid(GridView gv, string strSql)
    {
        DataControlManager dcm = new DataControlManager(str_Connetion_String);
        dcm.DataBind(gv, CommandType.Text, strSql);  
    }
    protected void gvTaskHeader_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            GridView gvTaskDetails = (GridView)e.Row.FindControl("gvTaskDetails");
            HiddenField hfSMTaskID = (HiddenField)e.Row.FindControl("hfSMTaskID");
            string strSql = "SELECT [Task_Id], [SMTask_Id], [W_GRPCD], [TASKDESC], [Estimated_Hrs],[TASKTYP],(SELECT TaskType FROM WEBX_FLEET_TaskTypeMst WHERE TaskTypeId=[TASKTYP]) AS TASKTYPEDESC, [T_UOM], [SERVICE_INTERVALS_DAY], [SERVICE_INTERVALS_KMS], [ADV_NOTIFICATION_DAY], [ADV_NOTIFACATION_KMS],(select W_GRPDESC from Webx_Fleet_WorkGroupMst WHERE W_GRPCD=D.W_GRPCD) as W_GRPDESC FROM [Webx_Fleet_SM_Task_Det]  as D  WHERE ([SMTask_Id] = " + Convert.ToInt32(hfSMTaskID.Value) + ")";
            BindGrid(gvTaskDetails, strSql);
        }
    }
    protected void lnkbtnXLS_Click(object sender, EventArgs e)
    {
        string strSQL = "SELECT (dbo.fc_VehicleModel(VEH_TYPE_CODE)) AS VEH_TYPE_NAME,"
                       + "(Select W_GRPDESC from Webx_Fleet_WorkGroupMst WHERE W_GRPCD=D.W_GRPCD) as W_GRPDESC,"
                       + "[TASKDESC], (SELECT TaskType FROM WEBX_FLEET_TaskTypeMst WHERE TaskTypeId=[TASKTYP]) AS TASKTYPEDESC,"
                       + "[Estimated_Hrs],[TASKTYP], [T_UOM], [SERVICE_INTERVALS_DAY], [SERVICE_INTERVALS_KMS], [ADV_NOTIFICATION_DAY]," 
                       + "[ADV_NOTIFACATION_KMS] FROM [Webx_Fleet_SM_Task_Det]  as D inner join Webx_Fleet_SM_Task_Hdr as H "
                        + "on D.smtask_Id = H.smtask_ID ";

        CreateXLS(strSQL, "ScheduleMaintenceTasks.xls");
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
}

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
using DabaseAccessLayer;
using ApplicationManager;

public partial class TaskTypeAdd : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.WEBX_FLEET_TASKTYPEMSTDataTable dt_TaskType = new MyFleetDataSet.WEBX_FLEET_TASKTYPEMSTDataTable();
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
        if (!IsPostBack)
        {
            dt_TaskType.AddWEBX_FLEET_TASKTYPEMSTRow("", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["TaskTypeId"] != null)
            {
                Panel1.Visible = false;
                GetValue(Request.QueryString["TaskTypeId"].ToString());
            }
        }
    }
    public void GetValue(string strTaskTypeId)
    {
        cls_TaskType objTaskType = new cls_TaskType(Session["SqlProvider"].ToString().Trim());
        DataTable dt = new DataTable();
        objTaskType.TaskTypeID = strTaskTypeId;
        dt = objTaskType.GetData();

        foreach (GridViewRow gvr in gv_TaskType.Rows)
        {
            TextBox tb_TaskType = (TextBox)gvr.FindControl("tb_TaskType");
            TextBox tb_AccCode = (TextBox)gvr.FindControl("tb_AccCode");
            TextBox tb_Description = (TextBox)gvr.FindControl("tb_Description");
            CheckBox chk_Flag = (CheckBox)gvr.FindControl("chk_Flag");

            
            tb_TaskType.Text = dt.Rows[0]["TaskType"].ToString();
            tb_AccCode.Text = dt.Rows[0]["AccCode"].ToString();
            tb_Description.Text = dt.Rows[0]["AccDesc"].ToString();
            if (dt.Rows[0]["ActiveFlag"].ToString() == "Y")
            {
                chk_Flag.Checked = true;
            }
            else
            {
                chk_Flag.Checked = false;
            }
        }
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_TaskType.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_TaskType.AddWEBX_FLEET_TASKTYPEMSTRow("", "", "", "");
        }
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    private void BindGrid()
    {
        gv_TaskType.DataSource = dt_TaskType;
        gv_TaskType.DataBind();
    }

    protected void gv_TaskType_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox tb_TaskType = (TextBox)e.Row.FindControl("tb_TaskType");
            TextBox tb_AccCode = (TextBox)e.Row.FindControl("tb_AccCode");
            TextBox tb_Description = (TextBox)e.Row.FindControl("tb_Description");
            Button btnAccCode = (Button)e.Row.FindControl("btnAccCode");

            tb_TaskType.Attributes.Add("OnBlur", "javascript:checkTaskType(" + e.Row.DataItemIndex + "," + tb_TaskType.ClientID.ToString() + ");");
            tb_AccCode.Attributes.Add("onblur", "AccBlur(" + e.Row.DataItemIndex + "," + tb_AccCode.ClientID.ToString() + "," + tb_Description.ClientID.ToString() + "," + tb_TaskType.ClientID.ToString() + ")");
            btnAccCode.Attributes.Add("onclick", "window.open('AccCodePopUp.aspx?AccCode=" + tb_AccCode.ClientID.ToString() + "&AccDesc=" + tb_Description.ClientID.ToString() + "',null,'left=300, top=150, height=300, width= 500, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_TaskType objTaskType = new cls_TaskType(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        try
        {
            foreach (GridViewRow gvr in gv_TaskType.Rows)
            {
                TextBox tb_TaskType = (TextBox)gvr.FindControl("tb_TaskType");
                TextBox tb_AccCode = (TextBox)gvr.FindControl("tb_AccCode");
                CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");

                objTaskType.TaskType = tb_TaskType.Text;
                objTaskType.AccCode = tb_AccCode.Text;
                objTaskType.ActiveFlag = (cbFlag.Checked == true) ? "Y" : "N";
                objTaskType.EntryBy = SessionUtilities.CurrentEmployeeID.ToString();

                objTaskType.BeginTransaction();
                try
                {
                    if (Request.QueryString["TaskTypeId"] != null)
                    {
                        objTaskType.TaskTypeID = Request.QueryString["TaskTypeId"].ToString();
                        objTaskType.UpdateTaskType();
                    }
                    else
                    {
                        objTaskType.InsertTaskType();
                    }
                    IsCommitted = objTaskType.CommitTransaction();
                }
                catch (Exception ex)
                {
                    objTaskType.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }
        if (IsCommitted)
        {
            Response.Redirect("TaskTypeSearch.aspx");
        }
    }
}

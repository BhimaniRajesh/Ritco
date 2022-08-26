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
 
public partial class WorkGroup : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.Work_GroupDataTable dt_WorkGroup = new MyFleetDataSet.Work_GroupDataTable();
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
        if (!IsPostBack)
        {
            dt_WorkGroup.AddWork_GroupRow("", "", "");  
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["WorkGroupCode"] != null)
            {
                Panel1.Visible = false;
                GetValue(Request.QueryString["WorkGroupCode"].ToString());
            }
            else
            {
                Panel1.Visible = true;
            }
        }
    }
    //private void BindAccCategory(DropDownList ddl)
    //{
    //    DataControlManager dcm = new DataControlManager(Session["SqlProvider"].ToString().Trim());
    //    dcm.DataBind(ddl, CommandType.Text, "SELECT AccCode,AccDesc FROM WEBX_ACCTINFO WHERE ACCCATEGORY='EXPENSE'");
    //}
    public void GetValue(string tGroupCode)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_WorkGroupList";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@GroupCode", SqlDbType.VarChar, 10).Value = Convert.ToInt32(tGroupCode);
        //da.SelectCommand.Parameters.Add("@TyrePatId", SqlDbType.VarChar).Value = "";
        //da.SelectCommand.Parameters.Add("@POSITION", SqlDbType.VarChar).Value = "";
        
        DataSet ds = new DataSet();
        da.Fill(ds);
        foreach (GridViewRow gvr in gv_WorkGroup.Rows)
        {

            ((TextBox)gv_WorkGroup.Rows[gvr.RowIndex].FindControl("tb_workgroup_desc")).Text = ds.Tables[0].Rows[0]["W_GRPDESC"].ToString();
            //((TextBox)gv_WorkGroup.Rows[gvr.RowIndex].FindControl("tb_AccCode")).Text = ds.Tables[0].Rows[0]["Account_Category"].ToString();
            if (ds.Tables[0].Rows[0]["ACTIVE_FLAG"].ToString() == "Y")
            {
                ((CheckBox)gv_WorkGroup.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = true;
            }
            else
            {
                ((CheckBox)gv_WorkGroup.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = false;
            }

        }
        conn.Close();
    }
    
    
    
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_WorkGroup.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_WorkGroup.AddWork_GroupRow("", "", "");  
        }
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    private void BindGrid()
    {
        gv_WorkGroup.DataSource = dt_WorkGroup;
        gv_WorkGroup.DataBind();
    }

    protected void gv_WorkGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox tb_workgroup_desc = (TextBox)e.Row.FindControl("tb_workgroup_desc");
            TextBox tb_AccCode = (TextBox)e.Row.FindControl("tb_AccCode");
            TextBox tb_Description = (TextBox)e.Row.FindControl("tb_Description");
            
            Button btnAccCode = (Button)e.Row.FindControl("btnAccCode");
            tb_workgroup_desc.Attributes.Add("OnBlur", "javascript:checkWorkGroupCode(" + e.Row.DataItemIndex + "," + tb_workgroup_desc.ClientID.ToString() + ");");
            //tb_AccCode.Attributes.Add("onblur", "AccBlur(" + e.Row.DataItemIndex + "," + tb_AccCode.ClientID.ToString() + "," + tb_Description.ClientID.ToString() + "," + tb_workgroup_desc.ClientID.ToString() + ")");
            //btnAccCode.Attributes.Add("onclick", "window.open('AccCodePopUp.aspx?AccCode=" + tb_AccCode.ClientID.ToString() + "&AccDesc=" + tb_Description.ClientID.ToString() + "',null,'left=300, top=150, height=300, width= 500, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_WorkGroup WrkGroup = new cls_WorkGroup(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        try
        {
            foreach (GridViewRow gvr in gv_WorkGroup.Rows)
            {
                WrkGroup.WORK_GROUPDESC = ((TextBox)gvr.FindControl("tb_workgroup_desc")).Text;
                CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");
                //TextBox txtAccCode = (TextBox)gvr.FindControl("tb_AccCode"); 
                if (cbFlag.Checked == true)
                {
                    WrkGroup.ACTIVE_FLAG = "Y";
                }
                else
                {
                    WrkGroup.ACTIVE_FLAG = "N";
                }
                WrkGroup.ENTRY_BY = SessionUtilities.CurrentEmployeeID.ToString();
                 //WrkGroup.WORK_GROUPDESC = ((TextBox)gvr.FindControl("tb_workgroup_desc")).Text;


                if (Request.QueryString["WorkGroupCode"] != null)
                {
                    WrkGroup.WORK_GROUPCODE = Request.QueryString["WorkGroupCode"].ToString();
                }
                else
                {
                    WrkGroup.WORK_GROUPCODE = "";
                }
                //WrkGroup.Account_Category = txtAccCode.Text;
                WrkGroup.BeginTransaction();
                try
                {
                    WrkGroup.InsertWorkGroup();
                    IsCommitted = WrkGroup.CommitTransaction();
                }
                catch (Exception ex)
                {
                    WrkGroup.RollBackTransaction();
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
            Response.Redirect("WorkGroupSearch.aspx");
        }
    }
}

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

public partial class GUI_HR_Payroll_Master_LeaveMasterList : System.Web.UI.Page
{
    SqlConnection conn;
    public string Sql_Select,Code,Desc;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Code =Convert.ToString(Request.QueryString["LeaveCode"]);

        if (!IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        conn.Open();
        Sql_Select = "Webx_LeaveMaster_List";
        SqlCommand SqlCmd = new SqlCommand(Sql_Select, conn);
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(SqlCmd);

        da.SelectCommand.Parameters.Add("@Code", SqlDbType.VarChar).Value = Code.ToString().Trim();
        DataSet ds = new DataSet();
        da.Fill(ds);

        GridLeaveType.DataSource = ds;
        GridLeaveType.DataBind();

    }
    //protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (((Control)e.CommandSource).ID == "DeleteButton")
    //    {
    //        int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
    //        string LevelNo = HierarchyList.DataKeys[thisRow].Values[0].ToString();
    //        LevelNo = LevelNo.Trim().ToString();
    //        string Query = "Delete from  WEBX_Hierarchy where Level_No='" + LevelNo + "'";

    //        conn.Open();
    //        SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
    //        Command.ExecuteNonQuery();
    //        conn.Close();
    //        BindGrid();
    //    }
    //}
    protected void GridLeaveType_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string Leave_Code = GridLeaveType.DataKeys[thisRow].Values[0].ToString();
            
            Leave_Code = Leave_Code.Trim().ToString();
            string Query = "Update WEBX_LEAVETYPEMST set DELETED='Y' where LEAVE_NAME='" + Leave_Code + "'";
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindData();
        }
    }
}

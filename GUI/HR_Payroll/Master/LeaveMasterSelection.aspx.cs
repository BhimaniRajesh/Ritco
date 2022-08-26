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

public partial class GUI_HR_Payroll_Master_LeaveMasterSelection : System.Web.UI.Page
{
    SqlConnection conn;
    public string Sql_Select,Code;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            BindData();
        }
        btnAdd.Attributes.Add("onclick", "javascript:return CheckData_Add(" + cboLeaveCode.ClientID + ")");
        btnEdit.Attributes.Add("onclick", "javascript:return CheckData_Edit(" + cboLeaveCode.ClientID + ")");
        btnInactivate.Attributes.Add("onclick", "javascript:return CheckData_Inactive(" + cboLeaveCode.ClientID + ")");
        btnListing.Attributes.Add("onclick", "javascript:return CheckData_List(" + cboLeaveCode.ClientID + ")");
    }

    private void BindData()
    {
        conn.Open();
        Sql_Select = "Webx_LeaveMaster_Selection";
        SqlCommand SqlCmd = new SqlCommand(Sql_Select, conn);
        SqlCmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr = SqlCmd.ExecuteReader();
        cboLeaveCode.Items.Clear();
        cboLeaveCode.Items.Add("All");

        while(dr.Read())
        {

            cboLeaveCode.Items.Add(new ListItem(dr.GetValue(0).ToString()));
        }
        dr.Close();
        conn.Close();
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("./LeaveMasterAdd.aspx?Code=" + "0,A");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string code =  cboLeaveCode.SelectedItem.ToString();
        Response.Redirect("./LeaveMasterAdd.aspx?Code=" +code + ",E");
    }
    protected void btnInactivate_Click(object sender, EventArgs e)
    {
        //Response.Redirect("./LeaveMasterAdd.aspx?");
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Code = cboLeaveCode.SelectedItem.ToString();

        Response.Redirect("./LeaveMasterList.aspx?LeaveCode=" + Code);
    }
}

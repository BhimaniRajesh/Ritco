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

public partial class GUI_Fleet_Operations_Issue_Popup_Driver : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn.Open();
        if (Session["brcd"] != null)
        {
            if (txtDCode.Text != "" || txtDName.Text != "")
            {
                sql = "select IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y' And (Manual_Driver_Code like '" + txtDCode.Text.Trim() + "%') and (Driver_name like  '" + txtDName.Text.Trim() + "%') order by Driver_Name";
            }
            else if (txtDCode.Text != "" || txtDName.Text == "")
            {
                sql = "select IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y' And (Manual_Driver_Code like '" + txtDCode.Text.Trim() + "%') order by Driver_Name";
            }
            else if (txtDCode.Text == "" || txtDName.Text != "")
            {
                sql = "select IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y' And (Driver_name like  '" + txtDName.Text.Trim() + "%') order by Driver_Name";
            }
            else if(txtDCode.Text == "" || txtDName.Text == "")
            {
                sql = "select IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'   order by Driver_Name";
            }
            cmd = new SqlCommand(sql, cn);
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Visible = true;
            Label1.Text = "";
            cn.Close();
        }
    }


}

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

    //public static string strQSParam;
    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;


    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string Driver_WO_Vehicle = "N";
        cn.Open();
        if (Session["mBranch"] != null)
        {
            if (txtDCode.Text != "" || txtDName.Text != "")
            {

                string STR1 = "";
                string STR2 = "";
                if (txtDCode.Text != "")
                {
                    STR1 = " and Manual_Driver_Code like '" + txtDCode.Text.Trim() + "%'  ";
                }
                if (txtDName.Text != "")
                {
                    STR2 = " and  Driver_name like '" + txtDName.Text.Trim() + "%'  ";
                }

                //if (Session["mBranch"].ToString() == "ALL")
                //{
                //    sql = "  select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  " + STR1 + STR2 + " order by Driver_Name";
                //}
                //else
                //{
                //    sql = "  select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  and Driver_Location='" + Session["mBranch"].ToString().Trim() + "' " + STR1 + STR2 + " order by Driver_Name";
                //}

                if (Session["mBranch"].ToString() == "ALL")
                {
                    sql = "  select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  " + STR1 + STR2 + " order by Driver_Name";
                }
                else
                {
                    sql = "  select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'   order by Driver_Name";
                }
                cmd = new SqlCommand(sql, cn);
                adp = new SqlDataAdapter(cmd);
                ds = new DataSet();
                adp.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                GridView1.Visible = true;
                Label1.Text = "";
            }

            else
            {
                if (Session["mBranch"].ToString() == "ALL")
                {
                    sql = "  select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  order by Driver_Name";

                }
                else
                {
                    sql = "  select   IsNULL(Manual_Driver_Code,Driver_ID) as  Manual_Driver_Code,Driver_Name from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'   order by Driver_Name";
                }
                cmd = new SqlCommand(sql, cn);
                adp = new SqlDataAdapter(cmd);
                ds = new DataSet();
                adp.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                GridView1.Visible = true;
                Label1.Text = "";

            }

            cn.Close();

        }
    }
        

}

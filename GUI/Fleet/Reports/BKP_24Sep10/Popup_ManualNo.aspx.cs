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
public partial class GUI_Fleet_Reports_Popup_ManualNo : System.Web.UI.Page
{


    SqlConnection cn;
    //public static string strQSParam;
    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;


    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       // strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn.Open();
        if (Session["mBranch"] != null)
        {
            if (txtManualTrip.Text != "")
            {
                if (Session["mBranch"].ToString() == "ALL")
                {
                    sql = "  select   Manual_tripsheetno from webx_fleet_vehicle_issue where    Manual_tripsheetno  like '" + txtManualTrip.Text.Trim() + "%'  order by Manual_tripsheetno";
                }
                else
                {
                    sql = "  select   Manual_tripsheetno from webx_fleet_vehicle_issue where    Manual_tripsheetno  like '" + txtManualTrip.Text.Trim() + "%'  and Tripsheet_startLoc='" + Session["mBranch"].ToString().Trim() + "'    order by Manual_tripsheetno";
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
                    sql = "  select   Manual_tripsheetno  from webx_fleet_vehicle_issue where  1=1      order by Manual_tripsheetno";
                }
                else
                {
                    sql = "  select   Manual_tripsheetno  from webx_fleet_vehicle_issue where   Tripsheet_startLoc='" + Session["mBranch"].ToString().Trim() + "'       order by Manual_tripsheetno";
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

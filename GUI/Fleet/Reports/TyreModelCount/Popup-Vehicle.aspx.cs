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



public partial class GUI_Fleet_Operations_Issue_Popup_Vehicle : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    //public string strQSParam;
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

        if (txtVehNo.Text != "")
        {
            //if (Session["mBranch"].ToString() == "ALL")
            //{
            sql = " select VEHNO,VEH_INTERNAL_NO  from webx_vehicle_hdr where   ActiveFLAG='Y'   and     vehno like '" + txtVehNo.Text + "%' " + " order by VEHNO";
            //}
            //else
            //{
            //    sql = " select VEHNO  from webx_vehicle_hdr where   ActiveFLAG='Y'  and    conrtl_branch='" + Session["mBranch"].ToString().Trim() + "'  and     vehno like '" + txtVehNo.Text + "%' " + " order by VEHNO";
            //}
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
                //if (Session["mBranch"].ToString() == "ALL")
                //{
                    sql = " select VEHNO,VEH_INTERNAL_NO  from webx_vehicle_hdr where   ActiveFLAG='Y'  order by VEHNO";
                //}
                //else
               //{
               //     sql = " select VEHNO  from webx_vehicle_hdr where   ActiveFLAG='Y' and    conrtl_branch='" + Session["mBranch"].ToString().Trim() + "'  order by VEHNO";
               // }
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

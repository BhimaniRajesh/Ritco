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


public partial class GUI_Fleet_Reports_Popup_ModelType : System.Web.UI.Page
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

        if (txtModel.Text != "")
        {
            if (Session["mBranch"].ToString() == "ALL")
            {
                sql = " select MODEL_NO from WEBX_FLEET_TYREMODELMST where   ACTIVE_FLAG='Y'   and     MODEL_NO like '" + txtModel.Text + "%' " + " order by MODEL_NO";
            }
            else
            {
                sql = " select MODEL_NO  from WEBX_FLEET_TYREMODELMST where   ACTIVE_FLAG='Y'  and    conrtl_branch='" + Session["mBranch"].ToString().Trim() + "'  and     MODEL_NO like '" + txtModel.Text + "%' " + " order by MODEL_NO";
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
            //if (Session["mBranch"].ToString() == "ALL")
            //{
            sql = " select MODEL_NO  from WEBX_FLEET_TYREMODELMST where   ACTIVE_FLAG='Y'   order by MODEL_NO";
            //}
            //else
            //{
            //     sql = " select MODEL_NO  from WEBX_FLEET_TYREMODELMST where   ACTIVE_FLAG='Y'  and    conrtl_branch='" + Session["mBranch"].ToString().Trim() + "'  order by MODEL_NO";
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

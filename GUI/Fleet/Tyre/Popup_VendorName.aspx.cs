using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class GUI_Fleet_MovablePartMaster_Popup_VendorName : System.Web.UI.Page
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
        cn.Open();
        if (Session["brcd"] != null)
        {
            if (txtDCode.Text != "" || txtDName.Text != "")
            {

                string STR1 = "";
                string STR2 = "";
                if (txtDCode.Text != "")
                {
                    STR1 = " and VENDORCODE like '" + txtDCode.Text.Trim() + "%'  ";
                }
                if (txtDName.Text != "")
                {
                    STR2 = " and  VENDORNAME like '" + txtDName.Text.Trim() + "%'  ";
                }

                if (Session["mBranch"].ToString() == "ALL")
                {
                    sql = "  select   VENDORCODE,VENDORNAME from webx_VENDOR_HDR where Active='Y' " + STR1 + STR2 + " order by VENDORNAME";
                }
                else
                {
                    sql = "  select   VENDORCODE,VENDORNAME from webx_VENDOR_HDR where Active='Y' order by Driver_Name";
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
                if (Session["brcd"].ToString() == "ALL")
                {
                    sql = "  select   VENDORCODE,VENDORNAME from webx_VENDOR_HDR where Active='Y'  order by VENDORNAME";

                }
                else
                {
                    sql = "  select   VENDORCODE,VENDORNAME from webx_VENDOR_HDR where Active='Y'   order by VENDORNAME";
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

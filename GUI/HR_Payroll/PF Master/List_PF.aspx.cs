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

public partial class GUI_admin_CustomerMaster_ListAll : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string chkval;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            
            
            bindGrid();
        }
        btnsubmit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        
        bindGrid();
    }
    public void bindGrid()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
            string sql;


            sql = "select pf_code,PF_validity_dt from WEBX_PFMST";

           
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adp.Fill(ds);
      
             

            ddlpfcd.DataSource = ds;


            ddlpfcd.DataTextField = "pf_code";
            ddlpfcd.DataValueField = "pf_code";
  ddlpfcd.DataBind();
          cn.Close();
          ddlpfcd.Items.Insert(0, "Select");
         }

    protected void submit(object sender, EventArgs e)
    {
        Response.Redirect("PF_MASTER.aspx?pa=5&pfno="+ddlpfcd.SelectedValue.ToString());

    }
}




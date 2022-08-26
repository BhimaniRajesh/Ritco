using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class GUI_UNI_MIS_rpt_specific : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();



        String sqlstr = "Select * from webx_reports_acess_net where subtitle='s1' and activeflag='Y' order by report_code";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        myAdapter.Fill(ds, "billdata");

        Register.DataSource = ds;
        Register.DataBind();
            conn.Close();
        

    }
}

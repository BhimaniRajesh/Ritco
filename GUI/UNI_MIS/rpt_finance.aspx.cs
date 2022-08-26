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

public partial class GUI_UNI_MIS_rpt_finance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();



        String sqlstr = "Select * from webx_reports_acess_net where subtitle='F1' and activeflag='Y' order by report_code";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        myAdapter.Fill(ds, "billdata");

        Register.DataSource = ds;
        Register.DataBind();

        sqlstr = "Select * from webx_reports_acess_net where subtitle='F2' and activeflag='Y' order by report_code";
         cmd = new SqlCommand(sqlstr, conn);
         SqlDataAdapter myAdapter1 = new SqlDataAdapter(cmd);

        DataSet ds1 = new DataSet();

        myAdapter1.Fill(ds1, "billdata");

        Summary.DataSource = ds1;
        Summary.DataBind();

        sqlstr = "Select * from webx_reports_acess_net where subtitle='F3' and activeflag='Y' order by report_code";
        cmd = new SqlCommand(sqlstr, conn);
        SqlDataAdapter myAdapter2 = new SqlDataAdapter(cmd);

        DataSet ds2 = new DataSet();

        myAdapter2.Fill(ds2, "billdata");


        Accounts.DataSource = ds2;
        Accounts.DataBind();

        sqlstr = "Select * from webx_reports_acess_net where subtitle='F4' and activeflag='Y' order by report_code";
        cmd = new SqlCommand(sqlstr, conn);
        SqlDataAdapter myAdapter3 = new SqlDataAdapter(cmd);

        DataSet ds3 = new DataSet();

        myAdapter3.Fill(ds3, "billdata");


        Accounts1.DataSource = ds3;
        Accounts1.DataBind();


        sqlstr = "Select * from webx_reports_acess_net where subtitle='F5' and activeflag='Y' order by report_code";
        cmd = new SqlCommand(sqlstr, conn);
        SqlDataAdapter myAdapter4 = new SqlDataAdapter(cmd);

        DataSet ds4 = new DataSet();

        myAdapter4.Fill(ds4, "billdata");


        Accounts2.DataSource = ds4;
        Accounts2.DataBind();



      
        conn.Close();
    }
    protected void Register_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

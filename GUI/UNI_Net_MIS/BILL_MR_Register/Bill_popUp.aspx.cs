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
public partial class GUI_UNI_MIS_BILL_MR_Register_Bill_popUp : System.Web.UI.Page
{
    public static string strcust, dkt_call;
    SqlConnection Conn;
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        string Billno;
        Billno = Request.QueryString["Billno"].ToString();

        string SQL_STR = "exec  WebxNet_bill_dockDetails '"+Billno+"'";
        SqlCommand CMD = new SqlCommand(SQL_STR, Conn);
        
        SqlDataAdapter da = new SqlDataAdapter(CMD);
       
            dgDocket.AllowPaging = false;

       
        da.Fill(ds);
        da.Fill(ds, "RDATA");
        Session["DATA"] = ds;
        dgDocket.DataSource = ds.Tables["RDATA"];
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;

        Conn.Close();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = dkt_call + " No.";
                lblColDockdt.Text = dkt_call + " Date";
            }

        }
    }
}

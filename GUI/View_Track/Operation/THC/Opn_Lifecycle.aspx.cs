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

public partial class GUI_View_Track_Operation_THC_Opn_Lifecycle : System.Web.UI.Page
{
     public static string call_dkt, THC_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        call_dkt = Session["DocketCalledAs"].ToString();
        THC_call = Session["THCCalledAs"].ToString();

        string sqlstr = "exec webx_THC_TAB_Tracking '" + str_dockno + "' ";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;

    }
}

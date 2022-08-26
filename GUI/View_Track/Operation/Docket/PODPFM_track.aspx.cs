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

public partial class GUI_View_Track_Operation_Docket_PODPFM_track : System.Web.UI.Page
{
    public static string call_dkt, DocumentName;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        call_dkt = Session["DocketCalledAs"].ToString();

        string SQL_POD = "select top 1 documentname from Webx_FM_Scan_Documents where docketno='" + str_dockno + "' order by documentdate desc";
        SqlCommand cmd = new SqlCommand(SQL_POD, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            DocumentName = dr["documentname"].ToString();
            lbldockst.Text = "View POD";
            //lbldockst.Text = "<a href=\"javascript:topWindowPOD('" + DocumentName + "')\">View POD</a> ";
            lbldockst.Text = "<a href=\"./../../../Operations/FM/ViewFMScannedDocument.aspx?DocName="+DocumentName+"\"  target=\"_self\">View POD</a> ";
            


        }
        else
        {
            lbldockst.Text = "No POD Uploaded";
            lbldockst.Enabled = false;
        }

        dr.Close();


        string SQL_Time = "select id,FM_no,Manual_fm_no,FM_Date,FM_Entrydt,FWDTO,FromLoc,ToLoc,ACK,ACKDT,dockno  from  VwNet_PODPFM_Track where   dockno='" + str_dockno + "'  order by id asc";

        SqlCommand sqlcmd12 = new SqlCommand(SQL_Time, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;



        conn.Close();
    }
}

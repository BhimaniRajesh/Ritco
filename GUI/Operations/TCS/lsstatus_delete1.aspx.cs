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

public partial class GUI_Operations_TCS_lsstatus_delete1 : System.Web.UI.Page
{
    public string errMsg = "";
    public string lsno;
    protected void Page_Load(object sender, EventArgs e)
    {
        lsno = Request.QueryString["lsno"].ToString();
        string branch = Session["brcd"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "Select TCBR,FINAL_TC from webx_TCHDR_tmp where TCNO='" + lsno + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        if (dr.Read())
        {
            string tcbranch = dr["TCBR"].ToString();
            string finaltc = dr["FINAL_TC"].ToString();

            if (tcbranch != branch)
            {
                p1.Visible = true;
                p2.Visible = false;
                errMsg = "Loading Sheet doesn't belongs to this location ,therefore cann't delete !!!";
            }
            else if (finaltc == "Y")
            {
                p1.Visible = true;
                p2.Visible = false;
                errMsg = "This Loading Sheet No.: <u>" + lsno + "</u> is already converted to manifest ,therefore cann't delete !!!";
            }
            
            else
            {
                dr.Close();
                p1.Visible = false;
                string sql_delete = "Update webx_trans_docket_status set LS=NULL,Op_Status='Stock available for LS/MF' where LS='" + lsno + "'";
                SqlCommand sqlcmd1 = new SqlCommand(sql_delete, conn);
                sqlcmd1.ExecuteNonQuery();
                p2.Visible = true;

            }
        }

    }

}

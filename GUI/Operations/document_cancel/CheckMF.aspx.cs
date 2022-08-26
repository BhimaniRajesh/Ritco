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

public partial class GUI_Operations_document_cancel_CheckMF : System.Web.UI.Page
{
    public string MF;
    public string date, from, to, manualno;

    protected void Page_Load(object sender, EventArgs e)
    {
        MF = Request.QueryString["MF"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "select TCDT,TCBR,Manual_TCNO,* from webx_TCHDR where tcno='" + MF + "' and THCNO is NULL and isnull(Cancelled,'N') !='Y'";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            date = Convert.ToString(dr["TCDT"]);
            from = Convert.ToString(dr["TCBR"]);
            manualno = Convert.ToString(dr["Manual_TCNO"]);
            i = 1;
            break;
        }
        dr.Close();

        Response.Clear();
        if (i == 0)
            Response.Write("false|");
        else if (i == 1)
            Response.Write("true|" + date + "|" + from + "|" + manualno + "|");
        con.Close();
    }
    
}

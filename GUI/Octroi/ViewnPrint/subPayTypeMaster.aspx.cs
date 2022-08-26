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

public partial class GUI_Octroi_ViewnPrint_subPayTypeMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string typecode=Request.QueryString["typecode"].ToString();
        string sql = "SELECT codetype_new FROM webx_typemst";
        SqlConnection con = SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        int flag = 0;
        while (dr.Read())
        {
            if (typecode.CompareTo(dr[0].ToString()) == 0)
            {
                flag = 1;
            }
        }

        if (flag == 1)
        {
            Response.Write("|true");
        }
        else if (flag == 0)
        {
            Response.Write("|false");
        }
    }
}

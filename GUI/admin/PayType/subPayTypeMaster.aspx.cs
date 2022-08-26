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


        string typecode = Request.QueryString["typecode"].ToString();
        string mode = Request.QueryString["mode"].ToString();
        string sql="";
        if (mode.CompareTo("check") == 0)
            sql = "SELECT codetype_new FROM webx_typemst";
        else if(mode.CompareTo("data")==0)
            sql = "SELECT * FROM webx_typemst WHERE codetype_new='" + typecode + "'";

        SqlConnection con =new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        if (mode.CompareTo("check") == 0)
        {
            int flag = 0;
            while (dr.Read())
            {
                string a = dr[0].ToString();
                if (typecode.ToUpper().CompareTo(dr[0].ToString().ToUpper()) == 0)
                {
                    flag = 1;
                }
            }

            if (flag == 1)
            {
                Response.Write("true|");
            }
            else if (flag == 0)
            {
                Response.Write("false|");
            }
        }
        else if (mode.CompareTo("data") == 0)
        {
            while (dr.Read())
            {
                Response.Write(dr["codetype_new"].ToString() + "|");
                Response.Write(dr["abbr_type"].ToString() + "|");
                Response.Write(dr["typedesc"].ToString() + "|");
                Response.Write(dr["activeflag"].ToString() + "|");
            }
            
        }

        dr.Close();

    }
}

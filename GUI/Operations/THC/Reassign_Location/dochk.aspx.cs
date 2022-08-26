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

public partial class GUI_Operations_THC_Reassign_Location_dochk : System.Web.UI.Page
{
    public string sql, result = "", vehno, LocCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        string dockno = Request.QueryString["dockno"].ToString();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //sql = "select thcno,advance_paid,THCClose_Mode,thcbr,balamtbrcd from webx_THC_Summary where (advance_paid = 'Y' or advance_paid = 'F') and THCClose_Mode is null and thcno='" + dockno + "'";
        sql = "select thcno,advance_paid,THCClose_Mode,thcbr,balamtbrcd,balvoucherno from webx_THC_Summary where thcno='" + dockno + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        Int16 cnt = 0;
        if (dr.Read())
        {
            if (dr["advance_paid"].ToString() != "F" && dr["advance_paid"].ToString() != "Y")
            {
                result = "Advance Not Done";
            }
            else if (dr["balvoucherno"].ToString() !=null)
            {
                result = "Balance Done";
            }
            else
            {
                result = "OK";
                LocCode = dr["balamtbrcd"].ToString();
            }

        }
        else
        {
            result = "InValid THC No.";
        }

        dr.Close();

        Response.Write(result + "|" + dockno + "|" + LocCode);
    }


}

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

public partial class GUI_admin_AirportMaster_dyn_combo : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string result ="";
        string EditedAirport = Request.QueryString.Get("EditedAirport").Replace("'","''") ;
          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader drchq;

        string sql = "select count(*)  as cnt from webx_airport_master where airportcity='" + EditedAirport + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        drchq = cmd.ExecuteReader();
        Int16 cnt = 0;
        if  (drchq.Read())
        {
            //chqno= drchq.GetValue(0).ToString();
            //chqdate = drchq.GetValue(1).ToString();

            cnt = Convert.ToInt16(drchq.GetValue(0));
            
        }
       // Response.Write(cnt);
        if (cnt > 0)
        {
            result = "Airport Name Already Exists !!";
        }
        else
        {
            result = "OK";
        }

        drchq.Close();
        Response.Write(result);
    }
}

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
        string state = Request.QueryString.Get("state").Replace("'","''") ;
        string city = Request.QueryString.Get("city").Replace("'", "''");
        string pin = Request.QueryString.Get("pin").Replace("'", "''");
        string mode = Request.QueryString.Get("mode").Replace("'", "''");
        string edcity = Request.QueryString.Get("edcity").Replace("'", "''");
        string edpin = Request.QueryString.Get("edpin").Replace("'", "''");
        string edstate = Request.QueryString.Get("edstate").Replace("'", "''");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader drchq;
        string sql = "";
        if (mode == "add")
        {
            sql = "select count(*)  as cnt from webx_pincode_master where stastename='" + state + "' and cityname='" + city + "' and pincode='" + pin + "'";
        }
        else if (mode == "edit")
        {
            //sql = "select count(*)  as cnt from webx_pincode_master where stastename='" + state + "' and cityname='" + city + "' and pincode='" + pin + "' and stastename<>'" + edstate + "' and cityname<>'" + edcity + "' and pincode<>'" + edpin + "'";
            sql = "select count(*)  as cnt from webx_pincode_master where stastename='" + state + "' and cityname='" + city + "' and pincode='" + pin + "' and  Convert(varchar,stastename)+cityname+Convert(varchar,pincode)<>'" + edstate + edcity + edpin + "'";
            //select * from webx_pincode_master where stastename='21' and cityname='DSF' and pincode='888888' and Convert(varchar,stastename)+cityname+Convert(varchar,pincode)<>'21DSF555555'
        }
        SqlCommand cmd = new SqlCommand(sql, conn);
        drchq = cmd.ExecuteReader();
        Int16 cnt = 0;
        if  (drchq.Read() == true)
        {
            cnt = Convert.ToInt16(drchq.GetValue(0));   
        }
       // Response.Write(cnt);
        if (cnt > 0)
        {
            result = "Pincode Already Exists For " + city + " !!|";
        }
        else
        {
            result = "OK|";
        }
        drchq.Close();
        Response.Write(result);
    }
}

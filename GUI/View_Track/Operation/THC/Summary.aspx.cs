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

public partial class GUI_View_Track_Operation_THC_Summary : System.Web.UI.Page
{
   public static string call_dkt;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        //Response.Write("ABC" + Request.QueryString());
        //Response.End();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        call_dkt = Session["THCCalledAs"].ToString();
        string sqlstr = "select thcno,thc_dt,Status,CAPACITY,Payload,EntryDt,Origin,Dest,rut_cat,routecd,routename,Vehno,vehtype,vendor_code,vendor,vendtyp,driver1,driver2,DRIVER1LICNO,DRIVER2LICNO,tonage,loaded,uti from VwNet_THCTrack_Summary   where thcno='" + str_dockno + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lbldockno.Text = dr["thcno"].ToString();
            // lbldockno.Text = dr["docksf"].ToString();
            lblstatus.Text = dr["Status"].ToString();
            lblorgncd.Text = dr["Origin"].ToString();
            lbldestcd.Text = dr["Dest"].ToString();
            lbldockst.Text = dr["thc_dt"].ToString();

            lblVend.Text = dr["vendor"].ToString() + " - " + dr["vendtyp"].ToString();
            lblroute.Text = dr["rut_cat"].ToString() + " - " + dr["routecd"].ToString() + " : " + dr["routename"].ToString();
            lblDriver.Text = dr["driver1"].ToString() + " - " + dr["driver2"].ToString();

            lblveh.Text = dr["Vehno"].ToString() + " - " + dr["vehtype"].ToString();
            lbltounnage.Text = dr["tonage"].ToString() + " - " + dr["loaded"].ToString();
            lblcapacity.Text = dr["CAPACITY"].ToString() + " - " + dr["Payload"].ToString();
            lblUtilization.Text = dr["uti"].ToString();
            
        }

        dr.Close();
        conn.Close();
    }
}

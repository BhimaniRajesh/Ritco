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
using System.Text; 
public partial class GUI_MIS_Vehicle_Register_Query_Vehicle : System.Web.UI.Page
{
   // SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
         
         DDlocation.Items.Add(new ListItem("All", "All"));
         String sqlstr = "  select distinct Conrtl_branch,Conrtl_branch as Conrtl_branch1 from webx_vehicle_Hdr where Conrtl_branch is not null and Conrtl_branch<>''";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);

        conn.Open();


        SqlDataReader dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                DDlocation.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();

        DDVehicle.Items.Add(new ListItem("All", "All"));
        sqlstr = "  select distinct vehno,vehno as vehno1 from webx_vehicle_Hdr ";
         cmd = new SqlCommand(sqlstr, conn);
              

         dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                DDVehicle.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();



        conn.Close();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string location = DDlocation.SelectedValue.ToString();
        string vehicle = DDVehicle.SelectedValue.ToString();
        string vehlist = txtVehno.Text.ToString();

        string final;
        final = "?location=" + location;
        final += "&vehicle=" + vehicle;
        final += "&vehlist=" + vehlist;
        Response.Redirect("Result_vehicle.aspx" + final);
    }
}

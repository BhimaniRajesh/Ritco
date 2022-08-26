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

public partial class GUI_admin_VehicleTypeMaster_VehicleTypeMasterEdit : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            ddVehicleType.Items.Add("--Select--");
            cn.Open();
            SqlCommand cmd = new SqlCommand("select convert(varchar(10), Type_Code) + ' : ' + [Type_Name] from webx_vehicle_type order by type_code", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddVehicleType.Items.Add(new ListItem(dr.GetValue(0).ToString()));
            }
            dr.Close();
            cn.Close();
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string[] vhType = ddVehicleType.SelectedValue.Split(':');
        Session["vhType"] = vhType[0].ToString();
        Server.Transfer("VehicleTypeMasteEditData.aspx");
    }
}

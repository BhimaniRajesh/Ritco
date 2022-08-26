using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_VehicleCPKM_VehicleCPKMDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
			
			 string Type = Request.QueryString["Flag"].Trim();
			 if(Type=="A")
			 {
				 lblTitle.Text = "Vehicle Added Successfully";
				 lnkBtnAddVehicle.Text="Click Here to Add more Vehicle";
				 lnkBtnAddVehicle.PostBackUrl = "AddVehicleInCPKM.aspx";
			 }
			 else{
				 lblTitle.Text = "Vehicle Removed Successfully";
				 lnkBtnAddVehicle.Text="Click Here to Removed more Vehicle";
				 lnkBtnAddVehicle.PostBackUrl = "RemoveVehicleFromCPKM.aspx";
			 }
            
        }
    } 
}
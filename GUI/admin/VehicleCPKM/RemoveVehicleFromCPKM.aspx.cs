using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_VehicleCPKM_RemoveVehicleFromCPKM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            umsg.Hide();
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        umsg.Hide();
        try
        {
            int i = 0;
            var objVehicleCPKMController = new VehicleCPKMController();
            foreach (GridViewRow gvdr in gvVehicleCPKM.Rows)
            {
                var hdnVendor = (HiddenField)gvdr.FindControl("hdnVendor");
                var lblVehicleNo = (Label)gvdr.FindControl("lblVehicleNo");
                var txtFreezeKMs = (TextBox)gvdr.FindControl("txtFreezeKMs");
                var rdCPKM = (RadioButton)gvdr.FindControl("rdCPKM");

                if (rdCPKM.Checked)
                {
                    i++;
                    if (txtFreezeKMs.Text == "")
                    {
                        throw new Exception("Please enter Freeze KMs");
                    }
                    objVehicleCPKMController.RemoveVehicleFromCPKM(lblVehicleNo.Text, txtFreezeKMs.Text, hdnVendor.Value);
                }
            }
            if (i == 0)
            {
                throw new Exception("Please Select at least one Row");
            }
            else
            {
                umsg.Show("Vehicle Removed Successfully");
                Response.Redirect("VehicleCPKMDone.aspx?Flag=R",false);
            }
        }
        catch (Exception ex)
        {

            umsg.Show(ex.Message);
            trCriteria.Attributes.Add("style", "display:none");
            trGV.Attributes.Remove("style");
            trSBTBTN.Attributes.Remove("style");
        }
    }

    protected void btnStep1_OnClick(object sender, EventArgs e)
    {
        umsg.Hide();
        try
        {
            if (txtVehicleNo.Text == "" && txtFleetCenter.Text == "")
            {
                throw  new Exception("Please Enter either Fleet Center or Vehicle No");
            }
            var objVehicleCPKMController = new VehicleCPKMController();
            gvVehicleCPKM.DataSource = objVehicleCPKMController.GetVehicleForRemoveFromCPKM(hdnVehicleNo.Value, hdnFleetCenter.Value);
            gvVehicleCPKM.DataBind();
            trCriteria.Attributes.Add("style","display:none");
            trGV.Attributes.Remove("style");
            trSBTBTN.Attributes.Remove("style");
			
        }
        catch (Exception ex)
        {

            umsg.Show(ex.Message);
        }
    }
}
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_Admin_Vendor_contract_vendorContract_Done : System.Web.UI.Page
{
    #region Variable[s]
    protected string vehicleTypeCode = "";
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Convert.ToString(Request.QueryString["Flag"]) == "Edit")
                {
                    lblTitle.Text = "Following Vehicle Has Been Successfully Updated";
                }
                else
                {
                    lblTitle.Text = "Following Vehicle Has Been Successfully Inserted";
                }

                vehicleTypeCode = Convert.ToString(Request.QueryString["vehicleTypeCode"]);
                getData(vehicleTypeCode);
            }
        }
        catch(Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void lnkBtnEditVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("VehicleTypeMasterCriteria.aspx?Flag=Edit");
    }
    protected void lnkBtnViewVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("VehicleTypeMasterCriteria.aspx?Flag=View");
    }
    #endregion

    #region Private Function[s]
    public void getData(string vehicleTypeCode)
    {
        try
        {
            VehicleMasterController objVehicleMaster = new VehicleMasterController();
            DataTable dtVehicleTypeMaster = new DataTable();

            if (!string.IsNullOrEmpty(vehicleTypeCode))
            {
                dtVehicleTypeMaster = objVehicleMaster.getVehicleTypeByVehicleCode(vehicleTypeCode);
            }

            if (dtVehicleTypeMaster != null && dtVehicleTypeMaster.Rows.Count > 0)
            {
                // lblVehicleCode.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Code"]);
                lblVehicleNumber.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Name"]);                
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}

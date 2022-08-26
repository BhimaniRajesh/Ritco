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
using WebX.Controllers;

public partial class GUI_admin_VehicleMaster_VehicleViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            BindData();
        }   
    }

    void BindData() {
        var obj = new TripApprovalController();
        DataTable dt =obj.VehicleViewPrintDetail(Request.QueryString["VehicleNo"].ToString()).Tables[0];
        if (dt.Rows.Count > 0) {
            DataRow dr = dt.Rows[0];
            lblVehicleType.Text = Convert.ToString(dr["VehicleType"]);
            lblControllingBranch.Text = Convert.ToString(dr["Conrtl_branch"]);
            lblVhclNo.Text = Convert.ToString(dr["VEHNO"]);
            lblVendorType.Text = Convert.ToString(dr["VendorTypeDesc"]);
            lblVendorName.Text = Convert.ToString(dr["VENDORNAME"]);
            lblPermitType.Text = Convert.ToString(dr["VEHPERMITType"]);
            lblRoutes.Text = Convert.ToString(dr["RouteName"]);
            lblNoOfDrivers.Text = Convert.ToString(dr["Drivers"]);
            lblNoOfTyreAttached.Text = Convert.ToString(dr["Tyre_Attached"]);
            lblRCBookNo.Text = Convert.ToString(dr["VEHRCBKNO"]);
            lblRegistrationNo.Text = Convert.ToString(dr["VEHREGNO"]);
            lblRegistrationDate.Text = Convert.ToString(dr["VEHREGDT"]);
            lblRegisteredState.Text = Convert.ToString(dr["RegisteredState"]);
            lblRegisteredRTO.Text = Convert.ToString(dr["RegisteredRTO"]);
            lblInvoiceNo.Text = Convert.ToString(dr["invoiceno"]);
            lblVehicleInsuranceValidityDate.Text = Convert.ToString(dr["Insurance_Validity_Date"]);
            lblFitnessCertificateDate.Text = Convert.ToString(dr["Fitness_Validity_Date"]);

            lblDateOfAttaching.Text = Convert.ToString(dr["attachdt"]);

            lblChasisNo.Text = Convert.ToString(dr["VEHCHASISNO"]);
            lblEngineNo.Text = Convert.ToString(dr["VEHENGINENO"]);
            lblActiveFlag.Text = Convert.ToString(dr["ACTIVEFLAG"]);
            lblManufacturerDate.Text = Convert.ToString(dr["ManufacturerDt"]);
            lblNationalPermitDate.Text = Convert.ToString(dr["NationalPermitDt"]);
            lbl5YearPermitDate.Text = Convert.ToString(dr["FiveYearPermitDt"]);
            lblRoadTax.Text = Convert.ToString(dr["RoadTaxDt"]);
            lblFuelEfficiency.Text = Convert.ToString(dr["FuelEfficiancy"]);
            lblBodyType.Text = Convert.ToString(dr["BodyType"]);
            lblCNoPolicyNo.Text = Convert.ToString(dr["PolicyNo"]);
            lblEngineType.Text = Convert.ToString(dr["EngineType"]);
            lblHorseType.Text = Convert.ToString(dr["HorseType"]);
            lblInsuranceName.Text = Convert.ToString(dr["InsuranceName"]);
            lblManufacturerName.Text = Convert.ToString(dr["ManufacturerName"]);
            lblFuelEconommy.Text = Convert.ToString(dr["FuelEconomy"]);
            lblLength.Text = Convert.ToString(dr["length"]);
            lblWidth.Text = Convert.ToString(dr["width"]);
            lblHeight.Text = Convert.ToString(dr["Height"]);
            lblGVW.Text = Convert.ToString(dr["GVW"]);
            lblUnladen.Text = Convert.ToString(dr["Unld_Wt"]);
            lblPayload.Text = Convert.ToString(dr["Payload"]);
            lblCapacity.Text = Convert.ToString(dr["Capacity"]);
            
            


        }
    }
   

}


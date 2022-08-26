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

public partial class AJAX_Validator_wfrm_AJAX_Validator : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Function"] == "CheckDuplicateFuelBrandName") Response.Write(CheckDuplicateFuelBrandName());
        if (Request.QueryString["Function"] == "CheckDuplicateFuelCardNo") Response.Write(CheckDuplicateFuelCardNo());
        if (Request.QueryString["Function"] == "CheckDuplicateFuelManualTicketNo") Response.Write(CheckDuplicateFuelManualTicketNo());

        if (Request.QueryString["Function"] == "GetVendorDetails") Response.Write(GetVendorDetails());
        if (Request.QueryString["Function"] == "GetVehicleDetails") Response.Write(GetVehicleDetails());
        if (Request.QueryString["Function"] == "GetJourneyDetails") Response.Write(GetJourneyDetails());
    }

    private string CheckDuplicateFuelBrandName()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return (fuel_Brand.CheckDuplicateFuelBrandName(Convert.ToInt32(Request.QueryString["Fuel_Brand_ID"].ToString()), Request.QueryString["Fuel_Brand_Name"].ToString())) ? "Y" : "N";
    }
    private string CheckDuplicateFuelCardNo()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return (fuel_Brand.CheckDuplicateFuelCardNo(Convert.ToInt32(Request.QueryString["Fuel_Card_ID"].ToString()), Request.QueryString["Manual_Fuel_Card_No"].ToString())) ? "Y" : "N";
    }

    private string CheckDuplicateFuelCardNoVehicle()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return (fuel_Brand.CheckDuplicateFuelCardNoVehicle(Convert.ToInt32(Request.QueryString["Fuel_Card_ID"].ToString()), Request.QueryString["tb_Vehicle_No"].ToString())) ? "Y" : "N";
    }
    

    private string CheckDuplicateFuelManualTicketNo()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return (fuel_Brand.CheckDuplicateFuelManualTicketNo(Request.QueryString["Ticket_No"].ToString(), Request.QueryString["Manual_Ticket_No"].ToString())) ? "Y" : "N";
    }

    private string GetVendorDetails()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return fuel_Brand.GetVendorDetails(Request.QueryString["VendorCode"].ToString());
    }
    private string GetVehicleDetails()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return fuel_Brand.GetVehicleDetails(Request.QueryString["Vehicle_No"].ToString());
    }
    private string GetJourneyDetails()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        return fuel_Brand.GetJourneyDetails(Request.QueryString["Trip_Sheet_ID"].ToString());
    }
}

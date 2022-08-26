using DateTimeManager;
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

public partial class GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Ticket_Generation_Add : System.Web.UI.Page
{
    private void BindData()
    {
        BLL_Fuel fuel_Ticket = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Ticket.BindDDLFuelTypesFromFuelBrand(ddl_Fuel_Type);
        fuel_Ticket.BindDDLFuelBrandForGivenFuelType(ddl_Fuel_Brand, ddl_Fuel_Type.SelectedValue);
    }

    private void ShowData()
    {
        BLL_Fuel fuel_Ticket = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        if (Request.QueryString["Ticket_No"].ToString() != "0")
        {
            fuel_Ticket.GetFuelTicketRecord(Request.QueryString["Ticket_No"].ToString());

            lbl_Ticket_No.Text = fuel_Ticket.Ticket_No;
            tb_Manual_Ticket_No.Text = fuel_Ticket.Manual_Ticket_No;
            dp_Ticket_Date.Text = fuel_Ticket.Ticket_Date.ToString("dd/MM/yyyy");
            tb_Vehicle_No.Text = fuel_Ticket.Vehicle_No;
            hf_Vehicle_No.Value = fuel_Ticket.Vehicle_No;
            lbl_Manufacturer.Text = fuel_Ticket.Manufacturer;
            lbl_Model.Text = fuel_Ticket.Model;
            lbl_Fuel_Tank_Capacity.Text = fuel_Ticket.Fuel_Tank_Capacity;

            tb_Trip_Sheet_ID.Text = fuel_Ticket.Trip_Sheet_ID;
            lbl_Driver_Name.Text = fuel_Ticket.Driver_Name;
            tb_VendorCode.Text = fuel_Ticket.VendorCode;
            lbl_VendorName.Text = fuel_Ticket.VendorName;
            tb_Fuel_Location.Text = fuel_Ticket.Fuel_Location;
            ddl_Fuel_Type.SelectedValue = fuel_Ticket.Fuel_Type_ID;
            //  First bind the Fuel Brand DropDownList then select
            fuel_Ticket.BindDDLFuelBrandForGivenFuelType(ddl_Fuel_Brand, ddl_Fuel_Type.SelectedValue);
            ddl_Fuel_Brand.SelectedValue = fuel_Ticket.Fuel_Brand_ID.ToString();

            tb_Last_Meter_Read.Text = fuel_Ticket.Last_Meter_Read.ToString();
            hf_Last_Meter_Read.Value = fuel_Ticket.Last_Meter_Read.ToString();
            tb_Curr_Meter_Read.Text = fuel_Ticket.Curr_Meter_Read.ToString();
            lbl_Total_KMs.Text = fuel_Ticket.Total_KMs.ToString();

            tb_Qty_In_Litres.Text = fuel_Ticket.Qty_In_Litres.ToString();
            tb_Fuel_Cost.Text = fuel_Ticket.Fuel_Cost.ToString();
            tb_Fuel_Tax.Text = fuel_Ticket.Fuel_Tax.ToString();
            lbl_Fuel_Total_Cost.Text = fuel_Ticket.Fuel_Total_Cost.ToString();
            lbl_Fuel_Rate.Text = fuel_Ticket.Fuel_Rate.ToString();
            tb_Bill_No.Text = fuel_Ticket.Bill_No;
            ddl_Pay_Mode.SelectedValue = fuel_Ticket.Pay_Mode;
        }
        else
            dp_Ticket_Date.Text = DateTime.Today.ToString("dd/MM/yyyy");
    }

    private void SaveRecord()
    {
        BLL_Fuel fuel_Ticket = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        fuel_Ticket.Ticket_No = (Request.QueryString["Ticket_No"].ToString() == "0") ? "0" : lbl_Ticket_No.Text;
        fuel_Ticket.Manual_Ticket_No = tb_Manual_Ticket_No.Text;
        fuel_Ticket.Ticket_Date = DTM.ConvertToShortDate(dp_Ticket_Date.Text);
        fuel_Ticket.Vehicle_No = tb_Vehicle_No.Text;
        fuel_Ticket.Trip_Sheet_ID = tb_Trip_Sheet_ID.Text;
        fuel_Ticket.VendorCode = tb_VendorCode.Text;
        fuel_Ticket.Fuel_Location = tb_Fuel_Location.Text;
        fuel_Ticket.Fuel_Type_ID = ddl_Fuel_Type.SelectedValue;
        fuel_Ticket.Fuel_Brand_ID = Convert.ToInt32(ddl_Fuel_Brand.SelectedValue);
        fuel_Ticket.Last_Meter_Read = Convert.ToDouble(tb_Last_Meter_Read.Text);
        fuel_Ticket.Curr_Meter_Read = Convert.ToDouble(tb_Curr_Meter_Read.Text);
        fuel_Ticket.Total_KMs = fuel_Ticket.Curr_Meter_Read - fuel_Ticket.Last_Meter_Read;
        fuel_Ticket.Qty_In_Litres = Convert.ToDouble(tb_Qty_In_Litres.Text);
        fuel_Ticket.Fuel_Cost = Convert.ToDouble(tb_Fuel_Cost.Text);
        fuel_Ticket.Fuel_Tax = Convert.ToDouble(tb_Fuel_Tax.Text);
        fuel_Ticket.Fuel_Total_Cost = fuel_Ticket.Fuel_Cost + fuel_Ticket.Fuel_Tax;
        fuel_Ticket.Fuel_Rate = Math.Round((fuel_Ticket.Fuel_Total_Cost / fuel_Ticket.Qty_In_Litres), 2);
        fuel_Ticket.Bill_No = tb_Bill_No.Text;
        fuel_Ticket.Pay_Mode = ddl_Pay_Mode.SelectedValue;

        fuel_Ticket.SaveFuelTicketRecord();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tb_Manual_Ticket_No.Attributes.Add("OnBlur", "javascript:checkDuplicateFuelManualTicketNo('" + Request.QueryString["Ticket_No"].ToString() + "', this, " + lbl_Ticket_Error.ClientID + ");");
            tb_Vehicle_No.Attributes.Add("OnBlur", "javascript:getVehicleDetails(this, " + hf_Vehicle_No.ClientID + ", " + lbl_Vehicle_Error.ClientID + ", " + lbl_Manufacturer.ClientID + ", " + lbl_Model.ClientID + ", " + lbl_Fuel_Tank_Capacity.ClientID + ", " + tb_Last_Meter_Read.ClientID + ", " + hf_Last_Meter_Read.ClientID + ");");
            tb_Trip_Sheet_ID.Attributes.Add("OnBlur", "javascript:getJourneyDetails(this, " + lbl_Journey_Error.ClientID + ", " + lbl_Driver_Name.ClientID + ");");
            tb_VendorCode.Attributes.Add("OnBlur", "javascript:getVendorDetails(this, " + lbl_VendorName.ClientID + ");");
            tb_Last_Meter_Read.Attributes.Add("OnFocus", "javascript:" + tb_Curr_Meter_Read.ClientID + ".focus();");
            tb_Curr_Meter_Read.Attributes.Add("OnBlur", "javascript:calculateTotalKMs(" + tb_Last_Meter_Read.ClientID + ", this, " + lbl_Total_KMs.ClientID + ");");
            tb_Qty_In_Litres.Attributes.Add("OnBlur", "javascript:calculateTotalCostAndFuelRate(this, " + tb_Fuel_Cost.ClientID + ", " + tb_Fuel_Tax.ClientID + ", " + lbl_Fuel_Total_Cost.ClientID + ", " + lbl_Fuel_Rate.ClientID + ");");
            tb_Fuel_Cost.Attributes.Add("OnBlur", "javascript:calculateTotalCostAndFuelRate(" + tb_Qty_In_Litres.ClientID + ", this, " + tb_Fuel_Tax.ClientID + ", " + lbl_Fuel_Total_Cost.ClientID + ", " + lbl_Fuel_Rate.ClientID + ");");
            tb_Fuel_Tax.Attributes.Add("OnBlur", "javascript:calculateTotalCostAndFuelRate(" + tb_Qty_In_Litres.ClientID + ", " + tb_Fuel_Cost.ClientID + ", this, " + lbl_Fuel_Total_Cost.ClientID + ", " + lbl_Fuel_Rate.ClientID + ");");
            btn_Save_And_Resume.Attributes.Add("OnClick", "javascript:return validateFormFuelTicket();");
            btn_Save.Attributes.Add("OnClick", "javascript:return validateFormFuelTicket();");

            BindData();
            ShowData();
        }
    }

    protected void ddl_Fuel_Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        BLL_Fuel fuel_Ticket = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Ticket.BindDDLFuelBrandForGivenFuelType(ddl_Fuel_Brand, ddl_Fuel_Type.SelectedValue);
    }

    protected void btn_Save_And_Resume_Click(object sender, EventArgs e)
    {
        BLL_Fuel fuel_Ticket = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        try
        {
            SaveRecord();
            BindData();

            lbl_Ticket_No.Text = "System Generated...";
            tb_Manual_Ticket_No.Text = "";
            dp_Ticket_Date.Text = DateTime.Today.ToString("dd/MM/yyyy");
            tb_Vehicle_No.Text = "";
            hf_Vehicle_No.Value = "";
            lbl_Manufacturer.Text = "";
            lbl_Model.Text = "";
            lbl_Fuel_Tank_Capacity.Text = "";

            tb_Trip_Sheet_ID.Text = "";
            lbl_Driver_Name.Text = "";
            tb_VendorCode.Text = "";
            lbl_VendorName.Text = "";
            tb_Fuel_Location.Text = "";

            tb_Last_Meter_Read.Text = "0";
            hf_Last_Meter_Read.Value = "";
            tb_Curr_Meter_Read.Text = "0";

            lbl_Total_KMs.Text = "0";
            tb_Qty_In_Litres.Text = "0";
            tb_Fuel_Cost.Text = "0";
            tb_Fuel_Tax.Text = "0";
            lbl_Fuel_Total_Cost.Text = "0";
            lbl_Fuel_Rate.Text = "0";
            tb_Bill_No.Text = "";
            ddl_Pay_Mode.SelectedIndex= 0;

            lbl_Page_Error.Text = "";
        }
        catch (Exception exc)
        {
            lbl_Page_Error.Text = exc.Message.ToString();
        }
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        try
        {
            SaveRecord();
            Response.Redirect("wfrm_Fuel_Ticket_Generation_Edit.aspx");
        }
        catch (Exception exc)
        {
            lbl_Page_Error.Text = exc.Message.ToString();
        }
    }
}

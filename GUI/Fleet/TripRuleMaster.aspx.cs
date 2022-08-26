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

public partial class GUI_Fleet_TripRuleMaster : System.Web.UI.Page
{
    static string str_Connection_String = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Chk_Settlement_Pending.Attributes.Add("OnClick", "javascript:CheckTripsheetNo(" + Chk_Settlement_Pending.ClientID.ToString() + "," + txtTripsheetNo.ClientID.ToString() + ");");
            lbl_Page_Err.Text = "";
            str_Connection_String = Session["SqlProvider"].ToString().Trim();
            GetData();
        }
    }
    public void SaveData()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        try
        {
            objTripSheet.Auto_Vslip_Filter = (rb_Manual_TSNo.Items[0].Selected == true) ? "Y" : "N";
            objTripSheet.Vehicle_Selection = (rb_Vehicle_Select.Items[0].Selected == true) ? "Y" : "N";
            objTripSheet.THC_Attached = (rb_THC.Items[0].Selected == true) ? "Y" : "N";
            objTripSheet.Vehicle_Filter = (rb_Vehicle_Filter.Items[0].Selected == true) ? rb_Vehicle_Filter.Items[0].Value : rb_Vehicle_Filter.Items[1].Value;
            objTripSheet.UFL_Filter = (rb_UFL_Filter.Items[0].Selected == true) ? "Y" : "N";
            if (rb_Driver1_Manual.Items[0].Selected == true) { objTripSheet.Driver1_Manual = "N"; objTripSheet.Driver2_Manual = "N"; } else if (rb_Driver1_Manual.Items[1].Selected == true) { objTripSheet.Driver1_Manual = "Y"; objTripSheet.Driver2_Manual = "Y"; }
            //if (rb_Route.Items[0].Selected == true) { objTripSheet.Trip_Route_Selection = "B"; } else if (rb_Route.Items[1].Selected == true) { objTripSheet.Trip_Route_Selection = "C"; } else if (rb_Route.Items[2].Selected == true) { objTripSheet.Trip_Route_Selection = "R"; }
            objTripSheet.Trip_Route_Selection = rb_Route.SelectedValue.ToString(); 
            objTripSheet.Enter_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            objTripSheet.ExternalUsage_Category = (rb_External_Usages_Cat.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.Fuel_Bill_Entry_TSWise = (rb_Fuel_Bill_Entry_TSWise.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.VEHICLE_MODE = (rb_Vehicle_Mode.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.DOCKET_WITH_TRIPSHEET = (rb_Attached_Docket.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.LOCAL_CITY = (rb_Local_City.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.DOCKET_NO_LABEL = tb_Docket_Number_Text.Text.ToString();

            objTripSheet.TSWithVehicle_Valid = (rb_TS_Valid_Vehicle.Items[0].Selected == true ? "Y" : "N");
            //objTripSheet.TS_VehicleFilter_Loc = (rb_TS_VehicleFilter_Loc.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.Driver_WO_Vehicle = (rb_Driver_WO_Vehicle.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.THC_WO_Tripsheet = (rb_THC_WO_Tripsheet.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.Checklist = (rb_Checklist.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.Checklist_Mandatory = (rb_Checklist_Mandatory.Items[0].Selected == true ? "Y" : "N");
            objTripSheet.Driver_Photo_Rule = (Chk_Driver_Photo.Checked == true) ? "Y" : "N";
            objTripSheet.Driver_License = (Chk_Driver_License.Checked == true) ? "Y" : "N";
            objTripSheet.Settlement_Pending = (Chk_Settlement_Pending.Checked == true) ? "Y" : "N";
            objTripSheet.Tot_Tripsheet = txtTripsheetNo.Text.ToString();

            objTripSheet.UpdateTripRule();
        }
        catch (Exception Ex)
        {
            lbl_Page_Err.Text = Ex.Message.ToString();
        }
        finally
        {
            lbl_Page_Err.Text = "";
        }
    }
    public void GetData()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        objTripSheet.CheckTripRule();
        if (objTripSheet.IsRecordFound == true)
        {

            if (objTripSheet.Auto_Vslip_Filter == "Y")
            {
                rb_Manual_TSNo.Items[0].Selected = true;
            }
            else
            {
                rb_Manual_TSNo.Items[1].Selected = true;
            }

            if (objTripSheet.Vehicle_Selection == "Y")
            {
                rb_Vehicle_Select.Items[0].Selected = true;
            }
            else
            {
                rb_Vehicle_Select.Items[1].Selected = true;
            }

            if (objTripSheet.Vehicle_Selection == "Y")
            {
                rb_Vehicle_Select.Items[0].Selected = true;  
            }
            else
            {
                rb_Vehicle_Select.Items[1].Selected = true;
            }

            if (objTripSheet.Driver1_Manual == "Y" && objTripSheet.Driver2_Manual == "Y")
            {
                rb_Driver1_Manual.Items[1].Selected = true;
            }
            else
            {
                rb_Driver1_Manual.Items[0].Selected = true;
            }

            //if (objTripSheet.Driver2_Manual == "Y")
            //{
            //    rb_Driver2_Manual.Items[0].Selected = true;
            //}
            //else
            //{
            //    rb_Driver2_Manual.Items[1].Selected = true;
            //}

            if (objTripSheet.Trip_Route_Selection == "B")
            {
                rb_Route.Items[0].Selected = true;
            }
            else if (objTripSheet.Trip_Route_Selection == "C")
            {
                rb_Route.Items[1].Selected = true;
            }
            else if (objTripSheet.Trip_Route_Selection == "R")
            {
                rb_Route.Items[2].Selected = true;
            }
            else if (objTripSheet.Trip_Route_Selection == "N")
            {
                rb_Route.Items[3].Selected = true;
            }

            if (objTripSheet.THC_Attached == "Y")
            {
                rb_THC.Items[0].Selected = true;
            }
            else
            {
                rb_THC.Items[1].Selected = true;
            }
            if (objTripSheet.Vehicle_Filter == "CUR_LOC")
            {
                rb_Vehicle_Filter.Items[0].Selected = true;
            }
            else
            {
                rb_Vehicle_Filter.Items[1].Selected = true;
            }

            if (objTripSheet.UFL_Filter == "Y")
            {
                rb_UFL_Filter.Items[0].Selected = true;
            }
            else
            {
                rb_UFL_Filter.Items[1].Selected = true;
            }
            if (objTripSheet.ExternalUsage_Category == "Y")
            {
                rb_External_Usages_Cat.Items[0].Selected = true;
            }
            else
            {
                rb_External_Usages_Cat.Items[1].Selected = true;
            }
            if (objTripSheet.Fuel_Bill_Entry_TSWise == "Y")
            {
                rb_Fuel_Bill_Entry_TSWise.Items[0].Selected = true;
            }
            else
            {
                rb_Fuel_Bill_Entry_TSWise.Items[1].Selected = true;
            }

            if (objTripSheet.VEHICLE_MODE == "Y")
            {
                rb_Vehicle_Mode.Items[0].Selected = true;
            }
            else
            {
                rb_Vehicle_Mode.Items[1].Selected = true;
            }

            if (objTripSheet.DOCKET_WITH_TRIPSHEET == "Y")
            {
                rb_Attached_Docket.Items[0].Selected = true;
            }
            else
            {
                rb_Attached_Docket.Items[1].Selected = true;
            }
            if (objTripSheet.LOCAL_CITY == "Y")
            {
                rb_Local_City.Items[0].Selected = true;
            }
            else
            {
                rb_Local_City.Items[1].Selected = true;
            }
            tb_Docket_Number_Text.Text = objTripSheet.DOCKET_NO_LABEL;

            if (objTripSheet.TSWithVehicle_Valid == "Y")
            {
                rb_TS_Valid_Vehicle.Items[0].Selected = true;
            }
            else
            {
                rb_TS_Valid_Vehicle.Items[1].Selected = true;
            }

            //if (objTripSheet.TS_VehicleFilter_Loc == "Y")
            //{
            //    rb_TS_VehicleFilter_Loc.Items[0].Selected = true;
            //}
            //else
            //{
            //    rb_TS_VehicleFilter_Loc.Items[1].Selected = true;
            //}

            if (objTripSheet.Driver_WO_Vehicle == "Y")
            {
                rb_Driver_WO_Vehicle.Items[0].Selected = true;
            }
            else
            {
                rb_Driver_WO_Vehicle.Items[1].Selected = true;
            }
            if (objTripSheet.THC_WO_Tripsheet == "Y")
            {
                rb_THC_WO_Tripsheet.Items[0].Selected = true;
            }
            else
            {
                rb_THC_WO_Tripsheet.Items[1].Selected = true;
            }
            if (objTripSheet.Checklist == "Y")
            {
                rb_Checklist.Items[0].Selected = true;
            }
            else
            {
                rb_Checklist.Items[1].Selected = true;
            }
            if (objTripSheet.Checklist_Mandatory == "Y")
            {
                rb_Checklist_Mandatory.Items[0].Selected = true;
            }
            else
            {
                rb_Checklist_Mandatory.Items[1].Selected = true;
            }
            if (objTripSheet.Driver_Photo_Rule == "Y")
            {
                Chk_Driver_Photo.Checked = true;
            }
            else
            {
                Chk_Driver_Photo.Checked = false;
            }

            if (objTripSheet.Driver_License == "Y")
            {
                Chk_Driver_License.Checked = true;
            }
            else
            {
                Chk_Driver_License.Checked = false;
            }

            if (objTripSheet.Settlement_Pending == "Y")
            {
                Chk_Settlement_Pending.Checked = true;
                txtTripsheetNo.Text = objTripSheet.Tot_Tripsheet;
            }
            else
            {
                Chk_Settlement_Pending.Checked = false;
                txtTripsheetNo.Text = "";
            }
        }
    }
    protected void SubmitData(object sender, EventArgs e)
    {
        SaveData();
    }
}

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class GUI_Fleet_TripRuleMaster_TripRuleMaster : System.Web.UI.Page
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
            if (rb_Start_KM_Reading.Items[0].Selected == true)
            {
                objTripSheet.Retrieved_from_last_Trip = "Y"; 
                objTripSheet.Not_To_Be_Changed = "N"; 
                objTripSheet.Editable_Can_Be_Change = "N"; 
            }
            if (rb_Start_KM_Reading.Items[1].Selected == true)
            {
                objTripSheet.Retrieved_from_last_Trip = "N";
                objTripSheet.Not_To_Be_Changed = "Y";
                objTripSheet.Editable_Can_Be_Change = "N"; 
            }
            if (rb_Start_KM_Reading.Items[2].Selected == true)
            {
                objTripSheet.Retrieved_from_last_Trip = "N";
                objTripSheet.Not_To_Be_Changed = "N";
                objTripSheet.Editable_Can_Be_Change = "Y";
            }
            objTripSheet.Diff_Bet_CloseKM_StartKM = (rb_Close_KM_Reading.Items[0].Selected == true) ? "Y" : "N";
            objTripSheet.CloseKM_Greater_Than_StartKM = (rb_Close_KM_Reading.Items[1].Selected == true) ? "Y" : "N";
            objTripSheet.Trip_Closure_Not_Zero = (rb_Trip_Colsure.Items[0].Selected == true) ? "Y" : "N";
            objTripSheet.Trip_Closure_Zero = (rb_Trip_Colsure.Items[1].Selected == true) ? "Y" : "N";
            objTripSheet.Fuel_Bill_Entry_Trip_Date = (Chk_Trip_Date.Checked == true) ? "Y" : "N";
            objTripSheet.Fuel_Bill_Entry_Trip_Close_Date = (Chk_TripDate_Close_Date.Checked == true) ? "Y" : "N";
            objTripSheet.Fuel_Bill_Entry_Trip_settlement_Date = (Chk_TripDate_Settlmnt_Date.Checked == true) ? "Y" : "N";

            objTripSheet.Advance_Entry_Settlement_Not_Done = (rb_Advance_Entry.Items[0].Selected == true) ? "Y" : "N";
            objTripSheet.Advance_Entry_Tripsheet_Not_Closed = (rb_Advance_Entry.Items[1].Selected == true) ? "Y" : "N";
            objTripSheet.TripSheet_Name = txtTripSheet.Text.ToString();
            objTripSheet.JobSheet_Name = txtJobsheet.Text.ToString();

            //objTripSheet.TripSheet_DateRule = (rb_TripSheet_DateRule.Items[0].Selected == true) ? "Y" : "N";
            //objTripSheet.TripAdvance_DateRule_3Days = (rb_TripAdvance_DateRule.Items[0].Selected == true) ? "Y" : "N";
            //objTripSheet.TripAdvance_DateRule_Equals_Tripsheet = (rb_TripAdvance_DateRule.Items[1].Selected == true) ? "Y" : "N";

            if (rb_DriverSettlement_DateRule.Items[0].Selected == true)
            {
                objTripSheet.DriverSettlmt_DateRule_2Days = "Y";
                objTripSheet.DriverSettlmt_DateRule_Equals_CloseDate = "N";
                objTripSheet.DriverSettlmt_DateRule_Equals_LastAdvanceDate = "N";
            }
            if (rb_DriverSettlement_DateRule.Items[1].Selected == true)
            {
                objTripSheet.DriverSettlmt_DateRule_2Days = "N";
                objTripSheet.DriverSettlmt_DateRule_Equals_CloseDate = "Y";
                objTripSheet.DriverSettlmt_DateRule_Equals_LastAdvanceDate = "N";
            }
            if (rb_DriverSettlement_DateRule.Items[2].Selected == true)
            {
                objTripSheet.DriverSettlmt_DateRule_2Days = "N";
                objTripSheet.DriverSettlmt_DateRule_Equals_CloseDate = "N";
                objTripSheet.DriverSettlmt_DateRule_Equals_LastAdvanceDate = "Y";
            }

            objTripSheet.UpdateTripRule();

            lbl_Page_Err.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Err.Text = "Rule Updated Successfully";

        }
        catch (Exception Ex)
        {
            lbl_Page_Err.ForeColor = System.Drawing.Color.Red;
            lbl_Page_Err.Text = Ex.Message.ToString();
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
            if (objTripSheet.Retrieved_from_last_Trip == "Y")
            {
                rb_Start_KM_Reading.Items[0].Selected = true;
            }
            if (objTripSheet.Not_To_Be_Changed == "Y")
            {
                rb_Start_KM_Reading.Items[1].Selected = true;
            }
            if (objTripSheet.Editable_Can_Be_Change == "Y")
            {
                rb_Start_KM_Reading.Items[2].Selected = true;
            }
            if (objTripSheet.Diff_Bet_CloseKM_StartKM == "Y")
            {
                rb_Close_KM_Reading.Items[0].Selected = true;
            }
            if (objTripSheet.CloseKM_Greater_Than_StartKM == "Y")
            {
                rb_Close_KM_Reading.Items[1].Selected = true;
            }

            if (objTripSheet.Trip_Closure_Not_Zero == "Y")
            {
                rb_Trip_Colsure.Items[0].Selected = true;
            }
            if (objTripSheet.Trip_Closure_Zero == "Y")
            {
                rb_Trip_Colsure.Items[1].Selected = true;
            }

            if (objTripSheet.Fuel_Bill_Entry_Trip_Date == "Y")
            {
                Chk_Trip_Date.Checked = true;
            }
            else
            {
                Chk_Trip_Date.Checked = false;
            }

            if (objTripSheet.Fuel_Bill_Entry_Trip_Close_Date == "Y")
            {
                Chk_TripDate_Close_Date.Checked = true;
            }
            else
            {
                Chk_TripDate_Close_Date.Checked = false;
            }

            if (objTripSheet.Fuel_Bill_Entry_Trip_settlement_Date == "Y")
            {
                Chk_TripDate_Settlmnt_Date.Checked = true;
            }
            else
            {
                Chk_TripDate_Settlmnt_Date.Checked = false;
            }

            if (objTripSheet.Advance_Entry_Settlement_Not_Done == "Y")
            {
                rb_Advance_Entry.Items[0].Selected = true;
            }
            if (objTripSheet.Advance_Entry_Tripsheet_Not_Closed == "Y")
            {
                rb_Advance_Entry.Items[1].Selected = true;
            }

            txtTripSheet.Text = objTripSheet.TripSheet_Name;
            txtJobsheet.Text = objTripSheet.JobSheet_Name;

            //if (objTripSheet.TripSheet_DateRule == "Y")
            //{
            //    rb_TripSheet_DateRule.Items[0].Selected = true;
            //}
            //else
            //{
            //    rb_TripSheet_DateRule.Items[1].Selected = true;
            //}
            //if (objTripSheet.TripAdvance_DateRule_3Days == "Y")
            //{
            //    rb_TripAdvance_DateRule.Items[0].Selected = true;
            //}
            //if (objTripSheet.TripAdvance_DateRule_Equals_Tripsheet == "Y")
            //{
            //    rb_TripAdvance_DateRule.Items[1].Selected = true;
            //}

            if (objTripSheet.DriverSettlmt_DateRule_2Days == "Y")
            {
                rb_DriverSettlement_DateRule.Items[0].Selected = true;
            }
            if (objTripSheet.DriverSettlmt_DateRule_Equals_CloseDate == "Y")
            {
                rb_DriverSettlement_DateRule.Items[1].Selected = true;
            }
            if (objTripSheet.DriverSettlmt_DateRule_Equals_LastAdvanceDate == "Y")
            {
                rb_DriverSettlement_DateRule.Items[2].Selected = true;
            }
        }
    }
    protected void SubmitData(object sender, EventArgs e)
    {
        SaveData();
    }
}


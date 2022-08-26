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

public partial class GUI_Fleet_VehicleStatus_VehicleTracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnPopupVehno.Attributes.Add("OnClick", "window.open('Popup_VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + hfKm.ClientID.ToString() + "&lblErr=" + lblVehNoErr.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo(" + txtVehNo.ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + hfKm.ClientID.ToString() + "," + lblVehNoErr.ClientID.ToString() + "," + tb_Tripsheet_No.ClientID.ToString() + ");");
            //tb_Location.Attributes.Add("OnBlur", "javascript:checkLocation(" + tb_Location.ClientID.ToString() + "," + lbl_Location_Err.ClientID.ToString() + ");");
            //tb_Tripsheet_No.Attributes.Add("OnBlur", "javascript:checkTSNumber(this," + lbl_TripSheet_Err.ClientID.ToString() + "," + txtVehNo.ClientID.ToString() + "," + lblVehNoErr.ClientID.ToString() + ");");
            img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDate.ClientID + @"\')')");

            string script;
            script = @"<SCRIPT language='javascript'> HideTripsheetTb();" + "</SCRIPT>";
            this.RegisterStartupScript("MyAlert", script);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cls_VehicllTracking objVehicllTracking = new cls_VehicllTracking(Session["SqlProvider"].ToString().Trim());
        try
        {
            objVehicllTracking.VehNo = txtVehNo.Text;
            objVehicllTracking.VSLIPNO = tb_Tripsheet_No.Text.ToString().Trim();//TripsheeNo.InnerText.ToString().Trim();//
            objVehicllTracking.Locaiton = tb_Location.Text.ToString().Trim();
            objVehicllTracking.Tracking_Date = txtDate.Text.ToString().Trim();
            objVehicllTracking.Remarks = tb_Remarks.Text.ToString().Trim();
            objVehicllTracking.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            if (tb_HH.Text == "" && tb_MM.Text == "")
            {
                objVehicllTracking.Tracking_Time = "";
            }
            else if (tb_HH.Text == "" && tb_MM.Text != "")
            {
                objVehicllTracking.Tracking_Time = "00:" + tb_MM.Text;
            }
            else if (tb_HH.Text != "" && tb_MM.Text == "")
            {
                objVehicllTracking.Tracking_Time = tb_HH.Text + ":00";
            }
            else if (tb_HH.Text != "" && tb_MM.Text != "")
            {
                objVehicllTracking.Tracking_Time = tb_HH.Text + ":" + tb_MM.Text;
            }
  
            try
            {
                objVehicllTracking.Insert_Webx_Fleet_Vehicle_Tracking();
            }
            catch (Exception ex)
            {
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }
        finally
        {
            lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Error.Text = "!!    Vehicle Tracking has been saved successfully    !!";
            Clear();
            Response.Redirect("VehicleStatusView.aspx"); 
        }
    }
    private void Clear()
    {
        txtVehNo.Text = "";
        txtDate.Text = "";
        tb_Tripsheet_No.Text = "";
        TripsheeNo.Title = "";
        tb_Location.Text = "";
        tb_Remarks.Text = "";
        txtVehNo.Focus();
    }
}

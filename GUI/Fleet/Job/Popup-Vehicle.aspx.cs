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

public partial class GUI_Fleet_Operations_Issue_Popup_Vehicle : System.Web.UI.Page
{
    JobSheet objJs;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            objJs = new JobSheet(Session["SqlProvider"].ToString());
            objJs.GetJobOrderRules();
            hf_Vehicle_Attached_TS.Value = objJs.Vehicle_Attached_TS;
            hf_Vehicle_Attached_JS.Value = objJs.Vehicle_Attached_JS;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        objJs = new JobSheet(Session["SqlProvider"].ToString());
        objJs.VehicleNo = txtVehNo.Text;
        objJs.JS_TYPE = rbStatus.SelectedValue;
        objJs.Vehicle_Status = ddlVehicleStatus.SelectedValue;
        objJs.BindGVPopupVehicle(DataList1);
    }
    protected void DataListItemEventHandler(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label VehicleStatus = (Label)e.Item.FindControl("VehicleStatus");
            Label JobsheetStatus = (Label)e.Item.FindControl("JobsheetStatus");

            if (hf_Vehicle_Attached_JS.Value == "Y" && hf_Vehicle_Attached_TS.Value == "Y")
            {
                if (JobsheetStatus.Text != "Available" && JobsheetStatus.Text != "")
                {
                    RadioButton rbtn = (RadioButton)e.Item.FindControl("rbtn");
                    rbtn.Enabled = false;
                }
                if (VehicleStatus.Text != "Available")
                {
                    RadioButton rbtn = (RadioButton)e.Item.FindControl("rbtn");
                    rbtn.Enabled = false;
                }
            }

            else if (hf_Vehicle_Attached_JS.Value == "Y" && hf_Vehicle_Attached_TS.Value == "N")
            {
                if (JobsheetStatus.Text != "Available" && JobsheetStatus.Text != "")
                {
                    RadioButton rbtn = (RadioButton)e.Item.FindControl("rbtn");
                    rbtn.Enabled = false;
                }
                //if (VehicleStatus.Text != "Available")
                //{
                //    RadioButton rbtn = (RadioButton)e.Item.FindControl("rbtn");
                //    rbtn.Enabled = false;
                //}
            }

            else if (hf_Vehicle_Attached_JS.Value == "N" && hf_Vehicle_Attached_TS.Value == "Y")
            {
                //if (JobsheetStatus.Text != "Available")
                //{
                //    RadioButton rbtn = (RadioButton)e.Item.FindControl("rbtn");
                //    rbtn.Enabled = false;
                //}
                if (VehicleStatus.Text != "Available")
                {
                    RadioButton rbtn = (RadioButton)e.Item.FindControl("rbtn");
                    rbtn.Enabled = false;
                }
            }
        }
    }
}

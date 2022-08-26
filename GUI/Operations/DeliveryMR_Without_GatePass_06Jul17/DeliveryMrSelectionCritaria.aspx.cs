using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_DeliveryMR_Without_GatePass_DeliveryMrSelectionCritaria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            trstep2.Style["display"] = "none";
            trstep3.Style["display"] = "none";
            hdnfinstartyear.Value = SessionUtilities.FinYear;
        }
    }
    protected void btnstep1_Click(object sender, EventArgs e)
    {
        try
        {
            MRController.IsDocketEligibleForSeperateDelMR(txtdockno.Text.Trim(), ddlsuffix.SelectedValue, SessionUtilities.CurrentBranchCode, hdnfinstartyear.Value);
            trstep2.Style["display"] = "block";
            trstep3.Style["display"] = "block";

            DataTable MrDetail = MRController.GetMrGatePassLocationDetail(txtdockno.Text.Trim(), ddlsuffix.SelectedValue);

            LblMrStatus.Text = MrDetail.Rows[0]["MRGEN"].ToString();
            TxtMrLocation.Text = MrDetail.Rows[0]["Delivery_Mr_Location"].ToString();
            LblGatePassStatus.Text = MrDetail.Rows[0]["gatepassno"].ToString();
            TxtGatePassLocation.Text = MrDetail.Rows[0]["GatePass_Gen_Location"].ToString();

            if (LblMrStatus.Text == "Y")
                TxtMrLocation.Enabled = false;
            if (LblGatePassStatus.Text  == "Y")
                TxtGatePassLocation.Enabled = false;

            if (LblMrStatus.Text == "Y" && LblGatePassStatus.Text == "Y")
            {
                RadDeliveryMr.Enabled = false;
                RadBoth.Enabled = false;
                RadGatePass.Enabled = false;
                btnstep3.Enabled = false;
            }
            else if (LblMrStatus.Text == "Y" && LblGatePassStatus.Text == "N")
            {
                RadDeliveryMr.Enabled = false;
                RadBoth.Enabled = false;
                RadGatePass.Enabled = true;
            }
            else if (LblMrStatus.Text == "N" && LblGatePassStatus.Text == "Y")
            {
                RadDeliveryMr.Enabled = true;
                RadBoth.Enabled = false;
                RadGatePass.Enabled = false;
            }
            else if (LblMrStatus.Text == "N" && LblGatePassStatus.Text == "N")
            {
                RadDeliveryMr.Enabled = true;
                RadBoth.Enabled = true;
                RadGatePass.Enabled = true;
            }

            if (MrDetail.Rows[0]["ParcelDevisionYN"].ToString() == "Y")
            {
                TxtMrLocation.Enabled = false;
                TxtGatePassLocation.Enabled = false;
            }   
        }
        catch (Exception ex)
        {
            lblmessage.Text = ex.Message;
            return;
        }
    }

    protected void btnstep3_Click(object sender, EventArgs e)
    {
        TxtMrLocation.Enabled = true;
        TxtGatePassLocation.Enabled = true;

        try
        {
            string strSql = "Update webx_trans_docket_status set Delivery_Mr_Location='" + TxtMrLocation.Text + "',GatePass_Gen_Location='" + TxtGatePassLocation.Text + "',GatePass_Closure_Location='" + TxtGatePassLocation.Text + "' where dockno='" + txtdockno.Text.Trim() + "' and docksf='" + ddlsuffix.SelectedValue + "'";
            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, strSql);
        }
        catch (Exception ex)
        {
            lblmessage2.Text = ex.Message;
            return;
        }

        string final = "";

        string RadType = "";
        if (RadDeliveryMr.Checked)
            RadType = "DeliveryMr";
        else if (RadGatePass.Checked)
            RadType = "GatePass";
        else
            RadType = "Both";

        final = "?Dockno=" + txtdockno.Text;
        final += "&suffix=" + ddlsuffix.SelectedValue.ToString();
        final += "&MrLocation=" + TxtMrLocation.Text;
        final += "&GatePassLocation=" + TxtGatePassLocation.Text;
        final += "&Type=" + RadType;

        if (RadType == "DeliveryMr" || RadType == "Both")
        {
            Response.Redirect("DeliveryMR.aspx" + final);
        }
        else
        {
            Response.Redirect("GenGatePassEntry.aspx" + final);
        }
    }
}

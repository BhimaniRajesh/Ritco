using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Operations_Issue_RequestApproval : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack && !IsCallback)
            {
                CreateToken();
                TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
                TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
                popRO();
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    /// <summary>
    /// Submit Event
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
            RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
            string report_mode = "";
            RadioButtonList rb2 = new RadioButtonList();
            rb2 = (RadioButtonList)radDate;
            if ((rb2.Items[0].Selected))
            {
                report_mode = "Date";
            }
            if ((rb2.Items[1].Selected))
            {
                report_mode = "Week";
            }
            if ((rb2.Items[2].Selected))
            {
                report_mode = "Today";
            }

            string strrightnow, strrightnow1;
            System.DateTime righnow = System.DateTime.Today;
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
            if (report_mode == "Date")
            {
                strrightnow = txtDateFrom.Text.ToString();
                strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
            }
            else if (report_mode == "Week")
            {
                strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            else if (report_mode == "Today")
            {
                strrightnow = righnow.ToString("dd/MM/yyyy");
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            else if (report_mode == "Tilldate")
            {
                strrightnow = "01/04/1990";
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            if (strrightnow == "")
            {
                strrightnow = righnow.ToString("dd/MM/yyyy");
            }
            if (strrightnow1 == "")
            {
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }
            string[] strArrDtFrom = strrightnow.Split('/');
            string[] strArrDtTo = strrightnow1.Split('/');
            string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
            var objPushVehicleDriverRequest = new PushVehicleDriverRequest();
            DataTable dt = objPushVehicleDriverRequest.GetListingForCancellation(dtFrom.ToString(), dtTo.ToString(), ddlro.SelectedValue);
            if (dt.Rows.Count > 0)
            {
                rptFinnalIndentDktPendingList.DataSource = dt;
                rptFinnalIndentDktPendingList.DataBind();
            }
            divIndentCancelResult.Visible = true;
            divIndentCancelCriteria.Visible = false;
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    protected void lnkbtnRequestNo_Command(object sender, CommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                LinkButton lnkbtnRequestNo = (LinkButton)(sender);
                string RequestNumber = lnkbtnRequestNo.CommandArgument;
                divIndentCancelUpdate.Visible = true;
                divIndentCancelResult.Visible = false;
                hdnRequestNumber.Value = RequestNumber;
                lblRequest.Text = RequestNumber;
                var objPushVehicleDriverRequest = new PushVehicleDriverRequest();
                DataTable dt = objPushVehicleDriverRequest.GetListingForCancellationonRequestNo(RequestNumber);
                if (dt.Rows.Count > 0)
                {
                    rptRequestPendingList.DataSource = dt;
                    rptRequestPendingList.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    protected void rptFinnalIndentDktPendingList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            var lblVehicleNo = e.Item.FindControl("lblVehicleNo") as Label;
            var lblDriverName = e.Item.FindControl("lblDriverName") as Label;
            lblVehicleNoHdr.Text = lblVehicleNo.Text;
            lblDriverNameHdr.Text = lblDriverName.Text;
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    protected void rptRequestPendingList_ItemDataBound(object source, RepeaterItemEventArgs e)
    {
        try
        {
            var lblExpiryDate = e.Item.FindControl("lblExpiryDate") as Label;
            var lblMasterExpiryDate = e.Item.FindControl("lblMasterExpiryDate") as Label;
            var hdnMasterExpiryDate = e.Item.FindControl("hdnMasterExpiryDate") as HiddenField;
            var hdnForcedYN = e.Item.FindControl("hdnForcedYN") as HiddenField;
            var lblMasterValue = e.Item.FindControl("lblMasterValue") as Label;
            var lblValueGrace = e.Item.FindControl("lblValueGrace") as Label;
            var lblMessage = e.Item.FindControl("lblMessage") as Label;
            var chkRequest = e.Item.FindControl("chkRequest") as CheckBox;
            hdnForcedYN.Value = "N";
            if (lblMasterExpiryDate.Text != "")
            {
                if (Convert.ToDateTime(hdnMasterExpiryDate.Value) < DateTime.Now)
                {
                    //chkRequest.Enabled = false;
                    lblMessage.Text = "Please update expiry date in master.";
                    hdnForcedYN.Value = "Y";
                }

            }
            else
            {
                if (Convert.ToDecimal(lblValueGrace.Text) < Convert.ToDecimal(lblMasterValue.Text))
                {
                    //chkRequest.Enabled = false;
                    lblMessage.Text = "Please increase limit.";
                    hdnForcedYN.Value = "Y";
                }
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    /// <summary>
    /// Validate Request on Submit
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmitValidate_Click(object sender, EventArgs e)
    {
        int cnt = 0;
        string strRequestOrderNo = "";
        try
        {
            //foreach (RepeaterItem rptItem in rptRequestPendingList.Items)
            //{
            //    CheckBox chkRequest = (CheckBox)rptItem.FindControl("chkRequest");
            //    if (chkRequest.Checked)
            //    {
            //        cnt++;
            //    }
            //}
            //if (cnt == 0)
            //    throw new Exception("Please select al least one record !");
            if (IsTokenValid())
            {
                var objPushVehicleDriverRequest = new PushVehicleDriverRequest();
                var listDetails = new List<PushVehicleDriverRequest>();
                foreach (RepeaterItem rptItem in rptRequestPendingList.Items)
                {
                    var obj_PushVehicleDriverRequest = new PushVehicleDriverRequest();
                    Label lblRequestDate = (Label)rptItem.FindControl("lblRequestDate");
                    Label lblDocumentName = (Label)rptItem.FindControl("lblDocumentName");
                    Label lblExpiryDate = (Label)rptItem.FindControl("lblExpiryDate");
                    Label lblGracePeriod = (Label)rptItem.FindControl("lblGracePeriod");
                    Label lblValue = (Label)rptItem.FindControl("lblValue");
                    Label lblValueGrace = (Label)rptItem.FindControl("lblValueGrace");
                   // CheckBox chkRequest = (CheckBox)rptItem.FindControl("chkRequest");
                    HiddenField hdnRequestOrder = (HiddenField)rptItem.FindControl("hdnRequestOrder");
                    HiddenField hdnRequestNo = (HiddenField)rptItem.FindControl("hdnRequestNo");
                    HiddenField hdnForcedYN = (HiddenField)rptItem.FindControl("hdnForcedYN");
                    //if (chkRequest.Checked)
                    //{
                        obj_PushVehicleDriverRequest.RequestID = hdnRequestNo.Value;
                        obj_PushVehicleDriverRequest.RequestOrder = Convert.ToInt32(hdnRequestOrder.Value);
                        obj_PushVehicleDriverRequest.IsValidate = true;
                        obj_PushVehicleDriverRequest.ForcedYN = hdnForcedYN.Value;
                        listDetails.Add(obj_PushVehicleDriverRequest);
                        strRequestOrderNo = strRequestOrderNo + hdnRequestOrder.Value + ",";
                    //}
                }
                objPushVehicleDriverRequest.VehicleDriverRequestUpdate(listDetails);
                ConsumeToken();
                Response.Redirect("RequestApprovalCancel.aspx?RequestNo=" + hdnRequestNumber.Value + "&RequestOrder=" + strRequestOrderNo + "&Flag=A", false);
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    /// <summary>
    /// Cancel Request on Submit
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmitCancel_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {
                var objPushVehicleDriverRequest = new PushVehicleDriverRequest();
                objPushVehicleDriverRequest.CancelRequest(hdnRequestNumber.Value);
                ConsumeToken();
                Response.Redirect("RequestApprovalCancel.aspx?RequestNo=" + hdnRequestNumber.Value + "&RequestOrder=&Flag=C", false);
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    public void popRO()
    {
        try
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string brcd = SessionUtilities.CurrentBranchCode.ToString().Trim();
            string q1 = "Select loccode,locname from webx_location where loc_level='1'";
            SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            SqlDataReader dr;
            dr = sqlcmd1.ExecuteReader();
            dr.Read();
            string loccd = dr["loccode"].ToString();
            dr.Close();
            String SQL_LOC, sqlall1;
            if (brcd == loccd)
            {
                //ddlro.Items.Add(new ListItem("ALL", "ALL"));
                SQL_LOC = "select DISTINCT loccode,locname+' : '+loccode from webx_location INNER JOIN  webx_VEHICLE_HDR ON  loccode=Conrtl_branch where webx_location.activeFlag='Y' order by loccode";
            }
            else
            {
                //ddlro.Items.Add(new ListItem("ALL", "ALL"));
                SQL_LOC = "select DISTINCT loccode,locname+' : '+loccode from webx_location INNER JOIN  webx_VEHICLE_HDR ON  loccode=Conrtl_branch where webx_location.activeFlag='Y'  order by loccode";//and loccode='" + brcd + "'
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {
                ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
            }
            dr1.Close();
            ddlro.SelectedValue = loccd;
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
}
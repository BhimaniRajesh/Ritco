using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_ServiceTaxTransferUtility_ServiceTaxTransfer : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        if (!IsPostBack)
        {
            CreateToken();
            rptMRDetails.Visible = false;
            trNoRecords.Visible = false;
            var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
            var dt = objServiceTaxTransferUtilityController.GetDivisionList();
            ddlDivision.DataSource = dt;
            ddlDivision.DataTextField = "LocName";
            ddlDivision.DataValueField = "Loccode";
            ddlDivision.DataBind();
            ddlDivision.Items.Insert(0, new ListItem("--All--", "All"));

          //  bindCustomer();
            bindLocation();     
        }
    }

    //private void bindCustomer()
    //{
    //    var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
    //    var dtCustomer = objServiceTaxTransferUtilityController.GetCustomerList();
    //    if (dtCustomer != null && dtCustomer.Rows.Count > 0)
    //    {
    //        MultichkCustomer.DataSource = dtCustomer;
    //        MultichkCustomer.DataBind();
    //    }
    //}

    private void bindLocation()
    {
        var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
        var dt = objServiceTaxTransferUtilityController.GetLocationList();
        ddlLocation.DataSource = dt;
        ddlLocation.DataTextField = "LocName";
        ddlLocation.DataValueField = "Loccode";
        ddlLocation.DataBind();
        ddlLocation.Items.Insert(0, new ListItem("--All--", "All"));
    }


    protected void btnNext_Click(object sender, EventArgs e)
    {
        try
        {
            trMRDetails.Style.Add("display", "block");
            trSubmit.Style.Add("display", "block");
            btnNext.Enabled = false;
            rptMRDetails.Visible = true;
            trHeader.Visible = true;
            trNoRecords.Visible = false;
            var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
            var objMRCriteria = new MRCriteria();
            //var hidSelectedValue = (HtmlInputHidden)MultichkCustomer.FindControl("hidSelectedValue");
            //var hidSelectedText = (HtmlInputHidden)MultichkCustomer.FindControl("hidSelectedText");

           // objMRCriteria.CustomerCode = hidSelectedValue.Value;
            objMRCriteria.CustomerCode = hdnCustomerCode.Value;
            objMRCriteria.Location = ddlLocation.SelectedValue;
            objMRCriteria.FromDate = (DateRange.FromDate == "" ? "" : WebXConvert.ToDateTime(DateRange.FromDate, "en-GB").ToString("dd MMM yyyy"));
            objMRCriteria.ToDate = (DateRange.ToDate == "" ? "" : WebXConvert.ToDateTime(DateRange.ToDate, "en-GB").ToString("dd MMM yyyy"));
            objMRCriteria.GRNo = txtGR.Text;
            objMRCriteria.MRNo = txtDeliveryMR.Text;
            objMRCriteria.FinYear = SessionUtilities.FinYear;
            objMRCriteria.Division = ddlDivision.SelectedValue;
            var dtMRDetailList = objServiceTaxTransferUtilityController.GetMRDetailsList(objMRCriteria);

            if (dtMRDetailList.Rows.Count > 0)
            {
                rptMRDetails.DataSource = dtMRDetailList;
                rptMRDetails.DataBind();
            }
            else
            {
                rptMRDetails.Visible = false;
                trNoRecords.Visible = true;
                trHeader.Visible = false;
                trSubmit.Visible = false;
                btnNext.Enabled = true;
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.Message);
            WebX.Common.ExceptionUtils.LogException(ex, "Service Tax Transfer Utility", SessionUtilities.CurrentEmployeeID, "ServiceTaxTransferUtility.aspx");
            return;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            btnSubmit.Style[HtmlTextWriterStyle.Display] = HideStyle;
            if (IsTokenValid())
            {
                var objMRHeader = new MRHeader()
                {
                    Details = new List<MRDetails>()
                };
                foreach (RepeaterItem ri in rptMRDetails.Items)
                {
                    if ((ri.FindControl("chkSelect") as CheckBox).Checked)
                    {
                        var lblGrNo = ri.FindControl("lblGrNo") as Label;
                        var lblMrNo = ri.FindControl("lblMrNo") as Label;
                        var lblMrDate = ri.FindControl("lblMrDate") as Label;
                        var lblMrAmount = ri.FindControl("lblMrAmount") as Label;
                        var lblSTax = ri.FindControl("lblSTax") as Label;
                        var lblConsignee = ri.FindControl("lblConsignee") as Label;
                        var lblConsignor = ri.FindControl("lblConsignor") as Label;
                        var lblReceiver = ri.FindControl("lblReceiver") as Label;
                        var hdnLegerCode = ri.FindControl("hdnLegerCode") as HiddenField;
                        var hdnConsigneeCode = ri.FindControl("hdnConsigneeCode") as HiddenField;
                        var hdnConsignorCode = ri.FindControl("hdnConsignorCode") as HiddenField;
                        var hdnReceiverCode = ri.FindControl("hdnReceiverCode") as HiddenField;

                        var objMRDetailsList = new MRDetails()
                        {
                            GRNo = lblGrNo.Text,
                            MRNo = lblMrNo.Text,
                            MRDate = lblMrDate.Text,
                            MRAmount = Convert.ToDecimal(lblMrAmount.Text),
                            STax = Convert.ToDecimal(lblSTax.Text),
                            ConsigneeCode = hdnConsigneeCode.Value,
                            Consignee = lblConsignee.Text,
                            ConsignorCode = hdnConsignorCode.Value,
                            Consignor = lblConsignor.Text,
                            ReceiverCode = hdnReceiverCode.Value,
                            Receiver = lblReceiver.Text,
                            LegerCode = hdnLegerCode.Value,
                            EntryBy = SessionUtilities.CurrentEmployeeID
                        };
                        objMRHeader.Details.Add(objMRDetailsList);
                    }
                }
                var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
                objServiceTaxTransferUtilityController.ServiceTaxTransferUtilityInsert(objMRHeader);
                ConsumeToken();
                Response.Redirect("Done.aspx?TransactionAction=Service Tax Transferred Successfully……..", false);
            }
        }
        catch (Exception ex)
        {
            btnSubmit.Style[HtmlTextWriterStyle.Display] = ShowStyle;
            msgBox.Show(ex.Message);
            return;
        }
    }
}


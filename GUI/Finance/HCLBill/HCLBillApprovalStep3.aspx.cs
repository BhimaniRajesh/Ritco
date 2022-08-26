using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_HCLBillApprovalStep3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();

        if (!IsPostBack)
        {
            try
            {
                var oHCLMasterController = new HCLMasterController();
                var ds = new DataSet();

                var dt = new DataTable();
                var dtMaster = new DataTable();
                var dtDetails = new DataTable();

                var BillNo = Convert.ToString(Request.QueryString["BillNo"]);
                var BranchCode = Convert.ToString(Request.QueryString["BranchCode"]);
                ds = oHCLMasterController.GetListForHCLBillApprovalList(BillNo,BranchCode);

                dt = ds.Tables[0];
                dtMaster = ds.Tables[1];
                dtDetails = ds.Tables[2];

                if (dt.Rows.Count > 0)
                {
                    lblOutgoingTHCType.Text = dt.Rows[0]["OTHCRateType"].ToString();
                    lblOutgoingTHCRate.Text= dt.Rows[0]["OTHCRate"].ToString();
                    lblIncomingTHCType.Text = dt.Rows[0]["ITHCRateType"].ToString();
                    lblIncomingTHCRate.Text = dt.Rows[0]["ITHCRate"].ToString();
                    lblDDMRType.Text = dt.Rows[0]["DDMRRateType"].ToString();
                    lblDDMRRate.Text = dt.Rows[0]["DDMRRate"].ToString();
                    lblMRType.Text = dt.Rows[0]["MRRateType"].ToString();
                    lblMRRate.Text = dt.Rows[0]["MRRate"].ToString();

                    lblVendorName.Text= dt.Rows[0]["VendorName"].ToString();
                    lblBillNo.Text= dt.Rows[0]["BillNo"].ToString();
                    lblBillDate.Text= dt.Rows[0]["BillDate"].ToString();                 

                    lblTotalAmount.Text = dt.Rows[0]["TotalAmount"].ToString();
                    lblRebateAmount.Text = dt.Rows[0]["RebateAmount"].ToString();
                    lblNetamount.Text = dt.Rows[0]["NetAmount"].ToString();
                    lblApprovedamount.Text= dt.Rows[0]["NetAmount"].ToString();
                    ViewState["NetAmount"]= dt.Rows[0]["NetAmount"].ToString();
                    hdnApprovedAmount.Value = lblApprovedamount.Text;
                }
                if(dtMaster.Rows.Count > 0)
                {
                    lblOutgoingTHCTypeMaster.Text = dtMaster.Rows[0]["OutgoingThcType"].ToString();
                    lblOutgoingTHCRateMaster.Text = dtMaster.Rows[0]["OutgoingThcRate"].ToString();
                    lblOutgoingTHCFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["OutgoingThcFromDate"]).ToString("dd MMM yyyy");
                    lblOutgoingTHCToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["OutgoingThcToDate"]).ToString("dd MMM yyyy");

                    lblIncomingTHCTypeMaster.Text = dtMaster.Rows[0]["IncomingThcType"].ToString();
                    lblIncomingTHCRateMaster.Text = dtMaster.Rows[0]["IncomingThcRate"].ToString();
                    lblIncomingTHCFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["IncomingThcFromDate"]).ToString("dd MMM yyyy");
                    lblIncomingTHCToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["IncomingThcToDate"]).ToString("dd MMM yyyy");

                    lblDDMRTypeMaster.Text = dtMaster.Rows[0]["DDMRType"].ToString();
                    lblDDMRRateMaster.Text = dtMaster.Rows[0]["DDMRRate"].ToString();
                    lblDDMRFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["DDMRFromDate"]).ToString("dd MMM yyyy");
                    lblDDMRToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["DDMRToDate"]).ToString("dd MMM yyyy");

                    lblMRTypeMaster.Text = dtMaster.Rows[0]["MRType"].ToString();
                    lblMRRateMaster.Text = dtMaster.Rows[0]["MRRate"].ToString();
                    lblMRFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["MRFromDate"]).ToString("dd MMM yyyy");
                    lblMRToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["MRToDate"]).ToString("dd MMM yyyy");
                }
                if(dtDetails.Rows.Count>0)
                {
                    RptBillApprovalDetails.DataSource = dtDetails;
                    RptBillApprovalDetails.DataBind();
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
        }
    }

    //protected void txtDiscount_TextChanged(object sender, EventArgs e)
    //{
    //    try
    //    { 
          
    //        if (txtDiscount.Text == "")
    //        {
    //            lblApprovedamount.Text = "0.00";
    //        }
    //        else
    //        {
    //            Double discount = Convert.ToDouble(txtDiscount.Text);
    //            Double netamount = Convert.ToDouble(ViewState["NetAmount"]);
    //            Double approveamt = netamount - discount;
    //            lblApprovedamount.Text = Convert.ToString(approveamt);
    //            if (discount > netamount)
    //            {
    //                UserMessage.Show("Discount can not be greater than Net Amount.");
    //                txtDiscount.Text = "";
    //               // lblApprovedamount.Text = "";
    //            }
    //        }
            
    //    }
    //    catch (Exception Ex)
    //    {
    //        UserMessage.Show(Ex.Message);
    //    }
    //}

    protected void btnReject_Click(object sender, EventArgs e)
    {
        try
        { 
            var objHCLMasterController = new HCLMasterController();
            var objHCLApprovalDetails = new HCLBillApprovalDetail();

            var BillNo = Convert.ToString(Request.QueryString["BillNo"]);
            if (txtRejectRemark.Text == "")
            {
                UserMessage.Show("Reject Remark Can't be Blank.");
            }
            else
            {
                objHCLApprovalDetails.BillNo = BillNo;
                objHCLApprovalDetails.Discount = Convert.ToDouble(txtDiscount.Text);
                objHCLApprovalDetails.ApprovedAmount = Convert.ToDouble(lblApprovedamount.Text);
                objHCLApprovalDetails.RejectRemarks = txtRejectRemark.Text;
                objHCLApprovalDetails.ApprovalFlag = 0;

                objHCLMasterController.UpdateHCLBillApprovalDetails(objHCLApprovalDetails);
                DataTable dt = objHCLMasterController.UpdateHCLBillApprovalDetails(objHCLApprovalDetails);

                if (dt.Rows.Count > 0)
                {
                    Response.Redirect("HCLBillApprovalDone.aspx?Flag=Reject&BillNo=" + BillNo, false);
                }
            }
        }
        catch (Exception Ex)
        {
            UserMessage.Show(Ex.Message);
        }
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            var BillNo = Convert.ToString(Request.QueryString["BillNo"]);

            var objHCLMasterController = new HCLMasterController();
            var objHCLApprovalDetails = new HCLBillApprovalDetail();

            //if (txtRejectRemark.Text != "")
            //{
            //    UserMessage.Show("You Can not Enter Reject Remark.");
            //    txtRejectRemark.Text = "";
            //}
            //else
            //{
                objHCLApprovalDetails.BillNo = BillNo;
                objHCLApprovalDetails.Discount = Convert.ToDouble(txtDiscount.Text);
                objHCLApprovalDetails.ApprovedAmount = Convert.ToDouble(hdnApprovedAmount.Value);
                objHCLApprovalDetails.RejectRemarks = txtRejectRemark.Text;
                objHCLApprovalDetails.ApprovalFlag = 1;

                DataTable dt = objHCLMasterController.UpdateHCLBillApprovalDetails(objHCLApprovalDetails);

                if (dt.Rows.Count > 0)
                {
                    Response.Redirect("HCLBillApprovalDone.aspx?Flag=Approve&BillNo=" + BillNo, false);
                }
            //}
        }
        catch (Exception Ex)
        {
            UserMessage.Show(Ex.Message);
        }
    }
    protected void ExportToExcel(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=HCLBillApproval.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        RptBillApprovalDetails.RenderControl(hw);
        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();
    }
}
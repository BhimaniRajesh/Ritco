using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_BillPaymentView : System.Web.UI.Page
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
                ds = oHCLMasterController.GetListForHCLBillApprovalList(BillNo,SessionUtilities.CurrentBranchCode);

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
                    lblDiscount.Text= dt.Rows[0]["Discount"].ToString();
                    ViewState["NetAmount"]= dt.Rows[0]["NetAmount"].ToString();

					lblTDS.Text = dt.Rows[0]["TDS"].ToString();
                    lblPayableAmount.Text = dt.Rows[0]["PayableAmount"].ToString();
                    lblPaymentMode.Text = dt.Rows[0]["PaymentMode"].ToString();
                    lblInstrumentNo.Text = dt.Rows[0]["InstrumentNo"].ToString();
                    lblInstrumentDate.Text = dt.Rows[0]["InstrumentDate"].ToString();
                    lblBankName.Text = dt.Rows[0]["BankName"].ToString();
                }
                if (dtMaster.Rows.Count > 0)
                {
                    lblOutgoingTHCTypeMaster.Text = dtMaster.Rows[0]["OutgoingThcType"].ToString();
                    lblOutgoingTHCRateMaster.Text = dtMaster.Rows[0]["OutgoingThcRate"].ToString();
                    lblOutgoingTHCFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["OutgoingThcFromDate"]).ToString("dd/MM/yyyy");
                    lblOutgoingTHCToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["OutgoingThcToDate"]).ToString("dd/MM/yyyy");

                    lblIncomingTHCTypeMaster.Text = dtMaster.Rows[0]["IncomingThcType"].ToString();
                    lblIncomingTHCRateMaster.Text = dtMaster.Rows[0]["IncomingThcRate"].ToString();
                    lblIncomingTHCFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["IncomingThcFromDate"]).ToString("dd/MM/yyyy");
                    lblIncomingTHCToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["IncomingThcToDate"]).ToString("dd/MM/yyyy");

                    lblDDMRTypeMaster.Text = dtMaster.Rows[0]["DDMRType"].ToString();
                    lblDDMRRateMaster.Text = dtMaster.Rows[0]["DDMRRate"].ToString();
                    lblDDMRFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["DDMRFromDate"]).ToString("dd/MM/yyyy");
                    lblDDMRToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["DDMRToDate"]).ToString("dd/MM/yyyy");

                    lblMRTypeMaster.Text = dtMaster.Rows[0]["MRType"].ToString();
                    lblMRRateMaster.Text = dtMaster.Rows[0]["MRRate"].ToString();
                    lblMRFromDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["MRFromDate"]).ToString("dd/MM/yyyy");
                    lblMRToDateMaster.Text = Convert.ToDateTime(dtMaster.Rows[0]["MRToDate"]).ToString("dd/MM/yyyy");
                }
                if (dtDetails.Rows.Count>0)
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
}
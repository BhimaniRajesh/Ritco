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

public partial class GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THC_FIN_Updates : BasePage
{
    public string Financial_Year { get { return (ViewState["Financial_Year"] != null) ? ViewState["Financial_Year"].ToString() : ""; } set { ViewState["Financial_Year"] = value; } }
    public string fin_year { get { return (ViewState["fin_year"] != null) ? ViewState["fin_year"].ToString() : ""; } set { ViewState["fin_year"] = value; } }
    public string ThcNumber { get { return (ViewState["ThcNumber"] != null) ? ViewState["ThcNumber"].ToString() : ""; } set { ViewState["ThcNumber"] = value; } }
    public string AdvanceFlag { get { return (ViewState["AdvanceFlag"] != null) ? ViewState["AdvanceFlag"].ToString() : ""; } set { ViewState["AdvanceFlag"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        usrMsg.Hide();
        if (!IsPostBack)
        {
            try
            {
                Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
                fin_year = Session["FinYear"].ToString();
                double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
                fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

                ThcNumber = Request.QueryString.Get(0).ToString();

                lblThcNo.Text = ThcNumber;
                BindThcDetail(ThcNumber);
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                usrMsg.Show(ex.Message);
                btnSubmit.Visible = false;
                return;
            }
        }
    }

    protected void BindThcDetail(string ThcNo)
    {
        var oThc = new ThcFinancialEdit();

        var dsThcDetail = oThc.GetThcForFinancialEdit(ThcNo);

        if (dsThcDetail.Tables.Count > 0)
        {
            if (dsThcDetail.Tables[0].Rows.Count > 0)
            {
                lblThcdt.Text = dsThcDetail.Tables[0].Rows[0]["THCDT"].ToString();
                hdThcdt.Value = dsThcDetail.Tables[0].Rows[0]["THCDT"].ToString();

                var thcbr = dsThcDetail.Tables[0].Rows[0]["thcbr"].ToString();
                lblThcBr.Text = DataProvider.GetLocationString(thcbr);
                hdnThcBrcd.Value = thcbr;

                AdvanceFlag = dsThcDetail.Tables[0].Rows[0]["Advance_paid"].ToString();
                txtAdvanceAmt.Text = dsThcDetail.Tables[0].Rows[0]["Advamt"].ToString();
                hdnAdvancePaid.Value = AdvanceFlag;

                txtManualTHCNo.Text = dsThcDetail.Tables[0].Rows[0]["ManualTHCNO"].ToString();

                lblVenodorName.Text = dsThcDetail.Tables[0].Rows[0]["vendor_code"].ToString() + ":" +
                                      dsThcDetail.Tables[0].Rows[0]["vendor_name"].ToString();

                lblVehNo.Text = dsThcDetail.Tables[0].Rows[0]["vehno"].ToString();

                lblRouteName.Text = dsThcDetail.Tables[0].Rows[0]["routecd"].ToString() + " : " +
                                    dsThcDetail.Tables[0].Rows[0]["routename"].ToString();

                lblStdPcAmt.Text = dsThcDetail.Tables[0].Rows[0]["STDPCAMT"].ToString();

                txtContractAmt.Text = dsThcDetail.Tables[0].Rows[0]["Pcamt"].ToString();

                txtTelChrg.Text = dsThcDetail.Tables[0].Rows[0]["TEL_CHRG"].ToString();

                ddlLoadOpertype.SelectedValue = dsThcDetail.Tables[0].Rows[0]["LoadOpertype"].ToString();
                txtLoadChrg.Text = dsThcDetail.Tables[0].Rows[0]["LOAD_CHRG"].ToString();

                txtMamulChrg.Text = dsThcDetail.Tables[0].Rows[0]["MAMUL_CHRG"].ToString();

                txtTdsRate.Text = dsThcDetail.Tables[0].Rows[0]["Tds_rate"].ToString();
                txtTdsChrg.Text = dsThcDetail.Tables[0].Rows[0]["Tds_chrg"].ToString();

                txtSvtaxRate.Text = dsThcDetail.Tables[0].Rows[0]["Svrc_rate"].ToString();
                txtServiceTaxAmount.Text = dsThcDetail.Tables[0].Rows[0]["svrcamt"].ToString();
                txtCessAmt.Text = dsThcDetail.Tables[0].Rows[0]["cessamt"].ToString();
                txtHCessAmt.Text = dsThcDetail.Tables[0].Rows[0]["HEDU_CESS"].ToString();
                txtPanNo.Text = dsThcDetail.Tables[0].Rows[0]["pan_no"].ToString();
                txtBalAmt.Text = dsThcDetail.Tables[0].Rows[0]["netbalamt"].ToString();
                txtBalAmtBrcd.Text = dsThcDetail.Tables[0].Rows[0]["balamtbrcd"].ToString();
                txtAdvPaidBy.Text = dsThcDetail.Tables[0].Rows[0]["advpaidby"].ToString();

                hdnTdsAccCode.Value = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["TdsAccCode"]);
                hdnTdsAccDesc.Value = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["TdsAccCode"]);
                ddlTdsAcccode.Items.Insert(0, new ListItem((hdnTdsAccCode.Value + "~" + hdnTdsAccDesc.Value), hdnTdsAccCode.Value));
                hdnAdvanceVoucherNo.Value = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["AdvanceVoucherNo"]);
                txtAdvanceCash.Text = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["AdvanceCash"]);
                txtAdvanceCheque.Text = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["AdvanceCheque"]);
                txtOtherAdvance.Text = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["OtherAdvance"]);
                hdnAdvanceBillNo.Value = Convert.ToString(dsThcDetail.Tables[0].Rows[0]["AdvanceBillNo"]);

                if (AdvanceFlag == "O" || AdvanceFlag == null || (AdvanceFlag == "F" && txtAdvanceAmt.Text == "0"))
                    txtAdvanceAmt.Enabled = true;
                else
                {
                    txtAdvanceAmt.Enabled = false;
                    txtAdvanceCash.Enabled = false;
                    txtAdvanceCheque.Enabled = false;
                    txtOtherAdvance.Enabled = false;
                    txtPanNo.Enabled = false;
                    //txtTelChrg.Enabled = false;
                    //txtLoadChrg.Enabled = false;
                    //txtMamulChrg.Enabled = false;
                    txtTdsRate.Enabled = false;
                    txtSvtaxRate.Enabled = false;
                }
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            ConsumeToken();
            var oThcEdit = new ThcFinancialEdit
            {
                ThcNo = ThcNumber,
                ThcBr = hdnThcBrcd.Value,
                ManualThcNo = txtManualTHCNo.Text.Trim(),
                LoadOperType = ddlLoadOpertype.SelectedValue,
                AdvanceAmount = Convert.ToDecimal(txtAdvanceAmt.Text),
                AdvancePaidBy = txtAdvPaidBy.Text,
                ContractAmount = Convert.ToDecimal(txtContractAmt.Text),
                TelephoneCharge = Convert.ToDecimal(txtTelChrg.Text),
                MamulCharge = Convert.ToDecimal(txtMamulChrg.Text),
                LoadingCharge = Convert.ToDecimal(txtLoadChrg.Text),
                BalAmtBrcd = txtBalAmtBrcd.Text,
                TdsRate = Convert.ToDecimal(txtTdsRate.Text),
                TdsCharge = Convert.ToDecimal(txtTdsRate.Text),
                PanNo = txtPanNo.Text,
                TdsAccCode = hdnTdsAccCode.Value,
                TdsAccDesc = hdnTdsAccDesc.Value,
                TdsGroupCode = hdnTdsAccCode.Value,
                TdsGroupDesc = hdnTdsAccDesc.Value,
                TdsFor = "-",
                ServiceRate = Convert.ToDecimal(txtSvtaxRate.Text),
                CessAmount = Convert.ToDecimal(txtCessAmt.Text),
                NetBalanceAmount = Convert.ToDecimal(txtBalAmt.Text),
                AdvanceAmount_LastPaid = txtAdvanceAmt.Text,

                ServiceAmount = Convert.ToDecimal(txtServiceTaxAmount.Text),
                AdvancePaid = hdnAdvancePaid.Value,
                HEdu_Cess = Convert.ToDecimal(txtHCessAmt.Text),
                AdvanceCash = Convert.ToDecimal(txtAdvanceCash.Text),
                AdvanceCheque = Convert.ToDecimal(txtAdvanceCheque.Text),
                OtherAdvance = Convert.ToDecimal(txtOtherAdvance.Text),
                ThcNew_Mode = "F",
            };

            if (Convert.ToDouble(txtAdvanceAmt.Text) == 0)
            {
                oThcEdit.AdvancePaid = "F";
            }
            else
            {
                if (hdnAdvanceVoucherNo.Value == "NA" && hdnAdvanceBillNo.Value == "")
                {
                    oThcEdit.AdvancePaid = "O";
                }
                else
                {
                    oThcEdit.AdvancePaid = hdnAdvancePaid.Value;
                }
            }
            if (Convert.ToDecimal(txtBalAmt.Text) < 0)
            {
                usrMsg.Show("Please Enter Valid amount. Net Balance cannot be less than 0.");
                return;
            }
            if (Convert.ToDecimal(txtBalAmt.Text) > 0)
            {
                var balAmt = Convert.ToDecimal(txtContractAmt.Text) - Convert.ToDecimal(txtAdvanceAmt.Text) - 500;
                if (balAmt < 500)
                {
                    usrMsg.Show("Contract Amount should be 500Rs. More than Advance Amount Need to Increase More 'Contract Amount-Advance Amount-500'");
                    return;
                }
                if (txtBalAmtBrcd.Text == "")
                {
                    usrMsg.Show("Balance Paid By is required");
                    return;
                }
                else
                {
                    if (!DataValidations.IsValidLocation(txtBalAmtBrcd.Text))
                    {
                        usrMsg.Show("Balance Paid by is Invalid");
                        return;
                    }
                }
            }
            /*       if (txtAdvPaidBy.Text != "" || Convert.ToDouble(txtAdvanceAmt.Text) > 0)
                   {
                       if (txtAdvPaidBy.Text != "")
                       {
                           if (!DataValidations.IsValidLocation(txtAdvPaidBy.Text))
                           {
                               usrMsg.Show("Advance Paid by is Invalid");
                               return;
                           }
                       }
                   }*/

            var voucherNo = oThcEdit.UpdateThcFinDetails(oThcEdit);

            string final = "?DocumentPrint=" + Request.QueryString.Get(0).ToString();
            final += "&voucherNo=" + voucherNo;

            Response.Redirect("THC_fin_updates_done.aspx" + final, false);
        }
        catch (Exception e1)
        {
            lblMessage.Text = e1.Message.ToString();
            lblMessage.CssClass = "redfnt";
            usrMsg.Show(e1.Message);
            CreateToken();
            return;
        }
    }

}

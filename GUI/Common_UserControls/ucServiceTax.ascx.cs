using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;
using WebX.Entity;

namespace WebX.CommonControls
{
    public partial class ucServiceTax : UserControl
    {
        public ucServiceTax()
        {
            KKCessCaption = "KK Cess";
            SBCessCaption = "SB Cess";
        }

        #region Property
        public string SBCessCaption { get; set; }
        public string KKCessCaption { get; set; }

        public string TransportMode
        {
            get
            {
                return hdnTransportMode.Value;
            }
            set
            {
                hdnTransportMode.Value = value;
                //InitializeServiceTaxRates();
            }
        }
        public string ServiceTaxPayer
        {
            get
            {
                return hdnServiceTaxPayer.Value;
            }
            set
            {
                hdnServiceTaxPayer.Value = value;
                //InitializeServiceTaxRates();
            }
        }
        public string ServiceType
        {
            get
            {
                return hdnServiceType.Value;
            }
            set
            {
                hdnServiceType.Value = value;
                //InitializeServiceTaxRates();
            }
        }

        public bool IsRebateApplicable
        {
            get
            {
                return hdnIsRebateApplicable.Value == "Y";
            }
            set
            {
                try
                {
                    hdnIsRebateApplicable.Value = value ? "Y" : "N";
                }
                catch { }
            }
        }
        public bool CheckExceedAmount { get; set; }

        public DateTime TransactionDate
        {
            get
            {
                return hdnTransactionDate.Value == "" ? DateTime.MinValue : Convert.ToDateTime(hdnTransactionDate.Value, CultureInfo.InvariantCulture);
            }
            set
            {
                hdnTransactionDate.Value = value.ToString("dd MMM yyyy");
                //InitializeServiceTaxRates();
            }
        }
        public bool IsRoundOffRequired
        {
            get
            {
                return hdnIsRoundOffRequired.Value == "Y";
            }
            set
            {
                hdnIsRoundOffRequired.Value = value ? "Y" : "N";
            }
        }
        public bool IsServiceTaxExempted
        {
            get
            {
                return hdnIsServiceTaxExempted.Value == "Y";
            }
            set
            {
                hdnIsServiceTaxExempted.Value = value ? "Y" : "N";
            }
        }
        public Double ExceedAmount
        {
            get
            {
                return Convert.ToString(hdnExceedAmount.Value).Trim() != "" ? Convert.ToDouble(hdnExceedAmount.Value) : 0;
            }
            set
            {
                hdnExceedAmount.Value = value.ToString();
            }
        }
        public Double ServiceTaxRate
        {
            get
            {
                return hdnServiceTaxRateApplied.Value.Trim() != "" ? Convert.ToDouble(hdnServiceTaxRateApplied.Value.Trim()) : 0;
            }
            set
            {
                hdnServiceTaxRate.Value = lblServiceTaxRate.Text = hdnServiceTaxRateApplied.Value = value.ToString();
            }
        }
        public Double EducationCessRate
        {
            get
            {
                return hdnEducationCessRateApplied.Value.Trim() != "" ? Convert.ToDouble(hdnEducationCessRateApplied.Value.Trim()) : 0;
            }
            set
            {
                hdnEducationCessRate.Value = lblHigherEducationCessRate.Text = hdnEducationCessRateApplied.Value = value.ToString();
            }
        }
        public Double HigherEducationCessRate
        {
            get
            {
                return hdnHigherEducationCessRateApplied.Value.Trim() != "" ? Convert.ToDouble(hdnHigherEducationCessRateApplied.Value.Trim()) : 0;
            }
            set
            {
                hdnHigherEducationCessRate.Value = lblEducationCessRate.Text = hdnHigherEducationCessRateApplied.Value = value.ToString();
            }
        }
        public Double SBCessRate
        {
            get
            {
                return hdnSBCessRateApplied.Value.Trim() != "" ? Convert.ToDouble(hdnSBCessRateApplied.Value.Trim()) : 0;
            }
            set
            {
                hdnSBCessRate.Value = lblSBCessRate.Text = hdnSBCessRateApplied.Value = value.ToString();
            }
        }
        public Double KKCessRate
        {
            get
            {
                return hdnKKCessRateApplied.Value.Trim() != "" ? Convert.ToDouble(hdnKKCessRateApplied.Value.Trim()) : 0;
            }
            set
            {
                hdnKKCessRate.Value = lblKKCessRate.Text = hdnKKCessRateApplied.Value = value.ToString();
            }
        }
        public Double SubTotal
        {
            get
            {
                return hdnSubTotal.Value.Trim() != "" ? Convert.ToDouble(hdnSubTotal.Value.Trim()) : 0;
            }
            set
            {
                hdnSubTotal.Value = value.ToString();
            }
        }
        public Double ServiceTax
        {
            get
            {
                return hdnServiceTax.Value.Trim() != "" ? Convert.ToDouble(hdnServiceTax.Value.Trim()) : 0;
            }
            set
            {
                hdnServiceTax.Value = value.ToString();
            }
        }
        public Double EducationCess
        {
            get
            {
                return hdnEducationCess.Value.Trim() != "" ? Convert.ToDouble(hdnEducationCess.Value.Trim()) : 0;
            }
            set
            {
                hdnEducationCess.Value = value.ToString();
            }
        }
        public Double HigherEducationCess
        {
            get
            {
                return hdnHigherEducationCess.Value.Trim() != "" ? Convert.ToDouble(hdnHigherEducationCess.Value.Trim()) : 0;
            }
            set
            {
                hdnHigherEducationCess.Value = value.ToString();
            }
        }
        public Double SBCess
        {
            get
            {
                return hdnSBCess.Value.Trim() != "" ? Convert.ToDouble(hdnSBCess.Value.Trim()) : 0;
            }
            set
            {
                hdnSBCess.Value = value.ToString();
            }
        }
        public Double KKCess
        {
            get
            {
                return hdnKKCess.Value.Trim() != "" ? Convert.ToDouble(hdnKKCess.Value.Trim()) : 0;
            }
            set
            {
                hdnKKCess.Value = value.ToString();
            }
        }
        public Double GrandTotal
        {
            get
            {
                return hdnGrandTotal.Value.Trim() != "" ? Convert.ToDouble(hdnGrandTotal.Value.Trim()) : 0;
            }
            set
            {
                hdnGrandTotal.Value = value.ToString();
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (TransactionDate == DateTime.MinValue) TransactionDate = DateTime.Now.Date;
                InitializeServiceTaxRates();
            }
            if (IsPostBack)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadControlOnCallBack_" + txtSubTotal.ClientID, "LoadControl('" + txtSubTotal.ClientID + "');", true);
            }
        }

        public void InitializeServiceTaxRates()
        {
            DocketServiceTax dst = new DocketServiceTax()
            {
                Date = TransactionDate,
                SubTotal = 0,
                TransMode = TransportMode,
                StaxPayer = ServiceTaxPayer,
                ServiceType = ServiceType,
                IsRebateApplicable = IsRebateApplicable,
                CheckExceedAmount = CheckExceedAmount
            };

            dst = DocketController.GetServiceTax(dst);

            hdnServiceTaxRate.Value = lblServiceTaxRate.Text = hdnServiceTaxRateApplied.Value = dst.STaxRate.ToString("F2");
            hdnEducationCessRate.Value = lblEducationCessRate.Text = hdnEducationCessRateApplied.Value = dst.StdEduCessRate.ToString("F2");
            hdnHigherEducationCessRate.Value = lblHigherEducationCessRate.Text = hdnHigherEducationCessRateApplied.Value = dst.StdHEduCessRate.ToString("F2");
            hdnSBCessRate.Value = lblSBCessRate.Text = hdnSBCessRateApplied.Value = dst.SbcRate.ToString("F2");
            hdnKKCessRate.Value = lblKKCessRate.Text = hdnKKCessRateApplied.Value = dst.KKCessRate.ToString("F2");

            hdnExceedAmount.Value = dst.ExceedAmount.ToString("F2");

            CalculateServiceTaxAmount();
        }

        public void CalculateServiceTaxAmount()
        {
            SetValueToZeroIfBlank(txtSubTotal);
            SetValueToZeroIfBlank(hdnServiceTaxRate);
            SetValueToZeroIfBlank(hdnEducationCessRate);
            SetValueToZeroIfBlank(hdnHigherEducationCessRate);
            SetValueToZeroIfBlank(hdnSBCessRate);
            SetValueToZeroIfBlank(hdnKKCessRate);

            if (IsRoundOffRequired)
                txtSubTotal.Text = Math.Round(SubTotal, 0, MidpointRounding.AwayFromZero).ToString();
            else
                txtSubTotal.Text = RoundNumber(SubTotal, 2);

            Double serviceTaxRate = Convert.ToDouble(hdnServiceTaxRate.Value);
            Double educationCessRate = Convert.ToDouble(hdnEducationCessRate.Value);
            Double higherEducationCessRate = Convert.ToDouble(hdnHigherEducationCessRate.Value);
            Double sbCessRate = Convert.ToDouble(hdnSBCessRate.Value);
            Double kkCessRate = Convert.ToDouble(hdnKKCessRate.Value);

            Double subTotal = 0, serviceTax = 0, educationCess = 0, higherEducationCess = 0, sbCess = 0, kkCess = 0, grandTotal = 0;

            if (IsServiceTaxExempted || ServiceTaxPayer != "T" || SubTotal <= ExceedAmount)
                serviceTaxRate = serviceTax = educationCessRate = higherEducationCessRate = sbCessRate = kkCessRate = 0;

            subTotal = Convert.ToDouble(txtSubTotal.Text);

            serviceTax = subTotal * serviceTaxRate / 100;
            educationCess = serviceTax * educationCessRate / 100;
            higherEducationCess = serviceTax * higherEducationCessRate / 100;
            sbCess = subTotal * sbCessRate / 100;
            kkCess = subTotal * kkCessRate / 100;

            lblServiceTaxRate.Text = serviceTaxRate.ToString("F2");
            hdnServiceTaxRateApplied.Value = serviceTaxRate.ToString("F2");
            lblEducationCessRate.Text = educationCessRate.ToString("F2");
            hdnEducationCessRateApplied.Value = educationCessRate.ToString("F2");
            lblHigherEducationCessRate.Text = higherEducationCessRate.ToString("F2");
            hdnHigherEducationCessRateApplied.Value = higherEducationCessRate.ToString("F2");
            lblSBCessRate.Text = sbCessRate.ToString("F2");
            hdnSBCessRateApplied.Value = sbCessRate.ToString("F2");
            lblKKCessRate.Text = kkCessRate.ToString("F2");
            hdnKKCessRateApplied.Value = kkCessRate.ToString("F2");
            if (IsRoundOffRequired)
            {
                txtSubTotal.Text = Math.Round(subTotal, 0, MidpointRounding.AwayFromZero).ToString();
                txtServiceTax.Text = Math.Round(serviceTax, 0, MidpointRounding.AwayFromZero).ToString();
                txtEducationCess.Text = Math.Round(educationCess, 0, MidpointRounding.AwayFromZero).ToString();
                txtHigherEducationCess.Text = Math.Round(higherEducationCess, 0, MidpointRounding.AwayFromZero).ToString();
                txtSBCess.Text = Math.Round(sbCess, 0, MidpointRounding.AwayFromZero).ToString();
                txtKKCess.Text = Math.Round(kkCess, 0, MidpointRounding.AwayFromZero).ToString();
            }
            else
            {
                txtSubTotal.Text = RoundNumber(subTotal, 2);
                txtServiceTax.Text = RoundNumber(serviceTax, 2);
                txtEducationCess.Text = RoundNumber(educationCess, 2);
                txtHigherEducationCess.Text = RoundNumber(higherEducationCess, 2);
                txtSBCess.Text = RoundNumber(sbCess, 2);
                txtKKCess.Text = RoundNumber(kkCess, 2);
            }

            grandTotal = Convert.ToDouble(txtSubTotal.Text) + Convert.ToDouble(txtServiceTax.Text) + Convert.ToDouble(txtEducationCess.Text) +
                    Convert.ToDouble(txtHigherEducationCess.Text) + Convert.ToDouble(txtSBCess.Text) + Convert.ToDouble(txtKKCess.Text);

            if (IsRoundOffRequired)
                txtGrandTotal.Text = Math.Round(grandTotal, 0, MidpointRounding.AwayFromZero).ToString();
            else
                txtGrandTotal.Text = RoundNumber(grandTotal, 2);

			hdnGrandTotal.Value = txtGrandTotal.Text;
            hdnSubTotal.Value = txtSubTotal.Text;
            hdnServiceTax.Value = txtServiceTax.Text;
            hdnEducationCess.Value = txtEducationCess.Text;
            hdnHigherEducationCess.Value = txtHigherEducationCess.Text;
            hdnSBCess.Value = txtSBCess.Text;
            hdnKKCess.Value = txtKKCess.Text;

        }

        #region helper methods
        private string RoundNumber(Double amount, int decimalPlaces)
        {
            return amount.ToString("F" + decimalPlaces.ToString());
        }

        private void SetValueToZeroIfBlank(TextBox txt)
        {
            if (txt.Text.Trim() == "")
                txt.Text = "0";
        }

        private void SetValueToZeroIfBlank(HiddenField hdn)
        {
            if (hdn.Value.Trim() == "")
                hdn.Value = "0";
        }

        private void ApplyRoundOff(TextBox txt, bool roundOffRequired)
        {
            txt.Text = Math.Round(Convert.ToDouble(txt.Text), ((int)(roundOffRequired ? 0 : 2)), MidpointRounding.AwayFromZero).ToString();
        }
        #endregion

    }
}
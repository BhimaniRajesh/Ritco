using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_Finance_Billing_GST_BillGeneration_FreightBillGeneration : BasePage
{
    public string empnm;
    protected void Page_Load(object sender, EventArgs e)
    {
        empnm = Session["empnm"].ToString();
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            string billDate;
            billDate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtGenerationDate.Text = billDate.ToString();
            string billDueDate;
            billDueDate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDueDate.Text = billDueDate.ToString();
            fillHeaderData();
            int Duedays = Convert.ToInt16(hidCreditDays.Value);
            DateTime dt = DateTime.Today.AddDays(Duedays);
            txtDueDate.Text = dt.ToString("dd/MM/yyyy");
            //fillDetailData();
            //fillFooterData();
            hdnSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
            //hdnPastDate.Value = "01/07/2017";
            hidBusinessType.Value = Request.QueryString["BusinessType"];
        }
        txtGenerationDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Date_Control_Rule_Check.aspx')");
    }
    protected void fillHeaderData()
    {
        try
        {
            var oGSTMasterController = new BillGenerationGST();
            var oBillGenerationGST_Entity = new BillGenerationGST_Entity();
            oBillGenerationGST_Entity.CustomerCode = Request.QueryString["CustomerCode"];
            oBillGenerationGST_Entity.Location = SessionUtilities.CurrentBranchCode;
            oBillGenerationGST_Entity.CompanyCode = SessionUtilities.DefaultCompanyCode;
            string[] TransactionCategory = Request.QueryString["TransactionCategory"].ToString().Split('~');
            oBillGenerationGST_Entity.ServiceType = TransactionCategory[0];
            oBillGenerationGST_Entity.ProductType = TransactionCategory[1];
            oBillGenerationGST_Entity.SACType = TransactionCategory[2];
            oBillGenerationGST_Entity.BillSubmissionState = Request.QueryString["CustomerState"];
            var dt = oGSTMasterController.GetCustomerBillDetail(oBillGenerationGST_Entity);
            var CompanyStateDT = oGSTMasterController.GetFreightBillCompanyStateDetails(oBillGenerationGST_Entity);
            ddlBillGenerationState.DataSource = CompanyStateDT;
            ddlBillGenerationState.DataBind();
            var CustomerStateDT = oGSTMasterController.GetFreightBillCustomerStateDetails(oBillGenerationGST_Entity);
            ddlBillSubmissionState.DataSource = CustomerStateDT;
            ddlBillSubmissionState.DataBind();
            //ddlBillCollectionState.DataSource = CustomerStateDT;
            //ddlBillCollectionState.DataBind();
            if (dt.Tables[0].Rows.Count > 0)
            {
                lblCustomerName.Text = dt.Tables[0].Rows[0]["Custcd"].ToString() + " : " + dt.Tables[0].Rows[0]["custnm"].ToString();
                hidCustomerID.Value = dt.Tables[0].Rows[0]["Custcd"].ToString();
                //lblBillingAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["custaddress"]);
                //hidBillingAddress.Value = Convert.ToString(dt.Tables[0].Rows[0]["custaddress"]);
                //hidBillGenerationState.Value = Convert.ToString(dt.Tables[0].Rows[0]["GenStcd"]);
                //lblBillGenerationState.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenLocState"]);
                //lblBillGenerationCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenLocCity"]);
                //lblBillGenerationLocation.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenLocCode"]);
                //hidBillSubmissionState.Value = Convert.ToString(dt.Tables[0].Rows[0]["SubStcd"]);
                //lblBillSubmissionState.Text = Convert.ToString(dt.Tables[0].Rows[0]["SubLocState"]);
                //lblBillSubmissionCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["SubLocCity"]);
                //lblBillSubmissionLocation.Text = Convert.ToString(dt.Tables[0].Rows[0]["SubLocCode"]);
                //hidBillCollectionState.Value = Convert.ToString(dt.Tables[0].Rows[0]["ColStcd"]);
                //lblBillCollectionState.Text = Convert.ToString(dt.Tables[0].Rows[0]["ColLocState"]);
                //lblBillCollectionCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["ColLocCity"]);
                //lblBillCollectionLocation.Text = Convert.ToString(dt.Tables[0].Rows[0]["ColLocCode"]);
                //lblInterState.Text = Convert.ToString(dt.Tables[0].Rows[0]["InterState"]);
                lblInterState.Text = "No";
                hidInterState.Value = "No";
                //lblCustomerGSTIN.Text = Convert.ToString(dt.Tables[0].Rows[0]["CustomerGSTINNumber"]);
                lblTransporterGSTIN.Text = Convert.ToString(dt.Tables[0].Rows[0]["TransporterGSTINNumber"]);
                hidSGST.Value = Convert.ToString(dt.Tables[0].Rows[0]["SGST"]);
                hidUTGST.Value = Convert.ToString(dt.Tables[0].Rows[0]["UTGST"]);
                hidUTGSTNo.Value = Convert.ToString(dt.Tables[0].Rows[0]["UTGSTNo"]);
                hidCGST.Value = Convert.ToString(dt.Tables[0].Rows[0]["CGST"]);
                hidIGST.Value = Convert.ToString(dt.Tables[0].Rows[0]["IGST"]);
                hidIGST.Value = Convert.ToString(dt.Tables[0].Rows[0]["IGST"]);
                hidCreditDays.Value = Convert.ToString(dt.Tables[0].Rows[0]["credit_day"]);
                if (dt.Tables[1].Rows.Count > 0)
                {
                    BindHeaderData(dt.Tables[1]);
                    fillDetailData();
                }
                else
                {
                    MsgBox.Show("No Records Found.....");
                    btnSubmit.Visible = false;
                }
                if (dt.Tables[2].Rows.Count > 0)
                {
                    //lblBillSubmissionState.Text = Convert.ToString(dt.Tables[2].Rows[0]["BillingStateName"]);
                    //hidBillSubmissionState.Value = Convert.ToString(dt.Tables[2].Rows[0]["BillingStateCode"]);
                    //hidBillSubmissionStateName.Value = Convert.ToString(dt.Tables[2].Rows[0]["BillingStateName"]);
                    //hidBillSubmissionStateType.Value = Convert.ToString(dt.Tables[2].Rows[0]["BillingStateType"]);
                    //hdnBillSubmissionCity.Value = Convert.ToString(dt.Tables[2].Rows[0]["BillingCityCode"]);
                    //lblBillSubmissionCity.Text = Convert.ToString(dt.Tables[2].Rows[0]["Location"]);
                    //hdnBillSubmissionCityName.Value = Convert.ToString(dt.Tables[2].Rows[0]["Location"]);
                    //lblBillSubmissionGSTIN.Text = Convert.ToString(dt.Tables[2].Rows[0]["GSTINNumber"]);
                    //hdnBillSubmissionGSTINNumber.Value = Convert.ToString(dt.Tables[2].Rows[0]["GSTINNumber"]);
                    lblBillingAddress.Text = Convert.ToString(dt.Tables[2].Rows[0]["BillingAddress"]);
                    hidBillingAddress.Value = Convert.ToString(dt.Tables[2].Rows[0]["BillingAddress"]);
                    lblCustomerGSTIN.Text = Convert.ToString(dt.Tables[2].Rows[0]["GSTINNumber"]);
                    hidMaxDate.Value = Convert.ToString(dt.Tables[2].Rows[0]["GSTMaxDate"]);
                    hdnSysDate.Value = Convert.ToString(dt.Tables[2].Rows[0]["PastDate"]);
                }
                else
                {
                    MsgBox.Show("No Records Found.....");
                    btnSubmit.Visible = false;
                }
                if (dt.Tables[3].Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Tables[3].Rows.Count; i++)
                    {
                        if (Convert.ToString(dt.Tables[3].Rows[i]["RULEID"]) == "GST_Fre_BL_Inv_Dt_Edit")
                            hidInvoiceDateEditable.Value = Convert.ToString(dt.Tables[3].Rows[i]["RULE_Y_N"]);
                        if (Convert.ToString(dt.Tables[3].Rows[i]["RULEID"]) == "GST_Fre_BL_Inv_Dt_Back_Days")
                        {
                            hidInvoiceDateBackDaysYN.Value = Convert.ToString(dt.Tables[3].Rows[i]["RULE_Y_N"]);
                            hidInvoiceDateBackDays.Value = Convert.ToString(dt.Tables[3].Rows[i]["RULE_VALUE"]);
                        }
                        if (Convert.ToString(dt.Tables[3].Rows[i]["RULEID"]) == "GST_Fre_BL_Due_Dt")
                            hidDueDateEditable.Value = Convert.ToString(dt.Tables[3].Rows[i]["RULE_Y_N"]);
                    }
                    if (hidInvoiceDateEditable.Value == "Y")
                        txtGenerationDate.Enabled = true;
                    else
                        txtGenerationDate.Enabled = false;
                    if (hidDueDateEditable.Value == "Y")
                        txtDueDate.Enabled = true;
                    else
                        txtDueDate.Enabled = false;
                }
                else
                {
                    MsgBox.Show("No Records Found.....");
                    btnSubmit.Visible = false;
                }
            }
            else
            {
                MsgBox.Show("No Records Found.....");
                btnSubmit.Visible = false;
            }
        }
        catch (Exception Ex)
        {
            MsgBox.Show("No Records Found.....");
        }
    }
    protected void fillDetailData()
    {
        try
        {
            var oGSTMasterController = new BillGenerationGST();
            var oBillGenerationGST_Entity = new BillGenerationGST_Entity();
            string[] strArrDtFrom = Request.QueryString["FromDate"].Split('/');
            string[] strArrDtTo = Request.QueryString["ToDate"].Split('/');
            string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
            oBillGenerationGST_Entity.FromDate = dtFrom;
            oBillGenerationGST_Entity.ToDate = dtTo;
            oBillGenerationGST_Entity.CustomerCode = Request.QueryString["CustomerCode"];
            oBillGenerationGST_Entity.Location = SessionUtilities.CurrentBranchCode;
            oBillGenerationGST_Entity.Paybas = "P02";
            string[] TransactionCategory = Request.QueryString["TransactionCategory"].ToString().Split('~');
            oBillGenerationGST_Entity.ServiceType = TransactionCategory[0];
            oBillGenerationGST_Entity.ProductType = TransactionCategory[1];
            oBillGenerationGST_Entity.SACType = TransactionCategory[2];
            oBillGenerationGST_Entity.InterState = lblInterState.Text == "Yes" ? true : false;
            oBillGenerationGST_Entity.ITC = lblITC.Text == "Yes" ? true : false;
            oBillGenerationGST_Entity.GSTRate = lblGSTRate.Text == "" ? 0 : Convert.ToDecimal(lblGSTRate.Text);
            oBillGenerationGST_Entity.BillSubmissionState = Request.QueryString["CustomerState"];
            oBillGenerationGST_Entity.BillCollectionLocation = Request.QueryString["LocationState"];
            oBillGenerationGST_Entity.BusinessType = Request.QueryString["BusinessType"];
            oBillGenerationGST_Entity.CompanyCode = SessionUtilities.DefaultCompanyCode;
            var dt = oGSTMasterController.GetCustomerDocketDetail(oBillGenerationGST_Entity);
            if (dt.Tables.Count > 0)
            {
                rptDocketDetails.DataSource = dt;
                rptDocketDetails.DataBind();
                //if (dt.Tables[1].Rows.Count > 0)
                //{
                //    BindDetailData(dt.Tables[1]);
                //}
                //else
                //{
                //    msgBox.Show("No Records Found.....");
                //    btnSubmit.Visible = false;
                //}
            }
            else
            {
                MsgBox.Show("No Records Found.....");
                btnSubmit.Visible = false;
            }
        }
        catch (Exception Ex)
        {
            MsgBox.Show("No Records Found.....");
        }
    }
    protected void BindHeaderData(DataTable dt)
    {
        try
        {
            if (dt.Rows.Count > 0)
            {
                lblServiceType.Text = dt.Rows[0]["ServiceType"].ToString();
                lblSACCategory.Text = dt.Rows[0]["SACCategory"].ToString();
                hidServiceType.Value = dt.Rows[0]["ServiceTypeCode"].ToString();
                hidProductType.Value = dt.Rows[0]["ProductTypeCode"].ToString();
                hidSACType.Value = dt.Rows[0]["SACCategoryCode"].ToString();
                lblGSTRate.Text = Convert.ToString(dt.Rows[0]["GSTRate"]);
                lblITC.Text = dt.Rows[0]["IsRCMApplicable"].ToString();
            }
        }
        catch (Exception Ex)
        {
            MsgBox.Show("No Records Found.....");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (RepeaterItem rptItem in rptDocketDetails.Items)
        {
            CheckBox chkSelect = (CheckBox)rptItem.FindControl("chkSelect");
            TextBox txtReportingDate = (TextBox)rptItem.FindControl("txtReportingDate");
            TextBox txtUnloadingDate = (TextBox)rptItem.FindControl("txtUnloadingDate");
            TextBox txtReportingDateHrs = (TextBox)rptItem.FindControl("txtReportingDateHrs");
            TextBox txtReportingDateMin = (TextBox)rptItem.FindControl("txtReportingDateMin");
            TextBox txtUnloadingDateHrs = (TextBox)rptItem.FindControl("txtUnloadingDateHrs");
            TextBox txtUnloadingDateMin = (TextBox)rptItem.FindControl("txtUnloadingDateMin");

            if (chkSelect.Checked == true)
            {
                if (txtReportingDate.Text.Trim() == "" || txtUnloadingDate.Text.Trim() == "")
                {
                    MsgBox.Show("Please select Reporting Date And Unloading Date ");
                    LoadData();
                    return;
                }

                //if ( Convert.ToDateTime(getDateInddMMMyyFormat(hdnTHCDate.Value)) > Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())))
                //{
                //    MsgBox.Show("Reporting Date must be greater then or equal to THC Date : " + hdnTHCDate.Value);
                //    return;
                //}

                string ReportingDateTime = getDateInddMMMyyFormat(txtReportingDate.Text) + " " + (txtReportingDateHrs.Text == "" ? "00" : txtReportingDateHrs.Text) + ":" + (txtReportingDateMin.Text == "" ? "00" : txtReportingDateMin.Text);
                string UnloadingDateTime = getDateInddMMMyyFormat(txtUnloadingDate.Text) + " " + (txtUnloadingDateHrs.Text == "" ? "00" : txtUnloadingDateHrs.Text) + ":" + (txtUnloadingDateMin.Text == "" ? "00" : txtUnloadingDateMin.Text);

                try
                {
                    var dt = Convert.ToDateTime(ReportingDateTime);
                    var dt2 = Convert.ToDateTime(UnloadingDateTime);
                }
                catch (Exception ex)
                {
                    MsgBox.Show("Invalide Reporting Date Time Or Unloading Date Time !!! ");
                    return;
                }


                //if (Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())) > Convert.ToDateTime(getDateInddMMMyyFormat(txtUnloadingDate.Text.Trim())))
                if (Convert.ToDateTime(ReportingDateTime) > Convert.ToDateTime(UnloadingDateTime))
                {
                    MsgBox.Show("Reporting Date must be less then or equal to Unloading Date ");
                    LoadData();
                    return;
                }
            }

        }

        if (IsTokenValid())
        {
            try
            {
                bool IsValid = true;
                string msg = "";
                ValidateData(ref IsValid, ref msg);
                if (IsValid)
                {

                    MyFunctions fn = new MyFunctions();
                    var objBillGenerationGST = new BillGenerationGST_Entity();
                    objBillGenerationGST.CustomerCode = hidCustomerID.Value;
                    objBillGenerationGST.InvoiceNumber = lblInvoiceNumber.Text.Trim();
                    //objBillGenerationGST.BillingAddress = lblBillingAddress.Text.Trim();
                    objBillGenerationGST.GenerationDate = fn.Mydate1(txtGenerationDate.Text.Trim());
                    objBillGenerationGST.DueDate = fn.Mydate1(txtDueDate.Text.Trim());
                    objBillGenerationGST.BillGenerationState = hidBillGenerationState.Value;
                    objBillGenerationGST.BillGenerationCity = hdnBillGenerationCity.Value;
                    objBillGenerationGST.BillGenerationGSTINNumber = hdnBillGenerationGSTINNumber.Value;
                    objBillGenerationGST.BillGenerationLocation = hidBillGenerationLocation.Value;
                    objBillGenerationGST.BillGenerationStateType = hidBillGenerationStateType.Value;
                    objBillGenerationGST.BillSubmissionState = hidBillSubmissionState.Value;
                    objBillGenerationGST.BillSubmissionCity = hdnBillSubmissionCity.Value;
                    objBillGenerationGST.BillSubmissionGSTINNumber = hdnBillSubmissionGSTINNumber.Value;
                    objBillGenerationGST.BillSubmissionLocation = hidBillSubmissionLocation.Value.Trim();
                    objBillGenerationGST.BillSubmissionStateType = hidBillSubmissionStateType.Value;
                    objBillGenerationGST.BillCollectionState = hidBillCollectionState.Value;
                    objBillGenerationGST.BillCollectionCity = hdnBillCollectionCity.Value;
                    objBillGenerationGST.BillCollectionGSTINNumber = hdnBillCollectionGSTINNumber.Value;
                    objBillGenerationGST.BillCollectionLocation = hidBillCollectionLocation.Value.Trim();
                    objBillGenerationGST.BillCollectionStateType = hidBillCollectionStateType.Value;
                    objBillGenerationGST.ServiceType = hidServiceType.Value;
                    objBillGenerationGST.InterState = (hidInterState.Value == "Yes" ? true : false);
                    objBillGenerationGST.SACType = hidSACType.Value;
                    objBillGenerationGST.GSTRate = Convert.ToDecimal(lblGSTRate.Text.Trim());
                    objBillGenerationGST.ITC = (lblITC.Text.Trim() == "Yes" ? true : false);
                    objBillGenerationGST.CustomerGSTIN = lblCustomerGSTIN.Text.Trim();
                    objBillGenerationGST.TransporterGSTIN = lblTransporterGSTIN.Text.Trim();
                    objBillGenerationGST.SummarySubTotal = Convert.ToDecimal(hdsubTotal.Value);
                    objBillGenerationGST.SummarySGST = Convert.ToDecimal(hidSummarySGST.Value);
                    objBillGenerationGST.SummaryUTGST = Convert.ToDecimal(hidSummaryUTGST.Value);
                    objBillGenerationGST.SummaryCGST = Convert.ToDecimal(hidSummaryCGST.Value);
                    objBillGenerationGST.SummaryIGST = Convert.ToDecimal(hidSummaryIGST.Value);
                    objBillGenerationGST.SummaryGSTTotal = Convert.ToDecimal(hdgstTotal.Value);
                    objBillGenerationGST.SummaryTotal = Convert.ToDecimal(hdtotal.Value);
                    objBillGenerationGST.GeneratedBy = SessionUtilities.CurrentEmployeeID;
                    objBillGenerationGST.CompanyCode = SessionUtilities.DefaultCompanyCode;
                    objBillGenerationGST.ProductType = hidProductType.Value;
                    objBillGenerationGST.DockCount = Convert.ToInt32(hdCount.Value);
                    objBillGenerationGST.BusinessType = Request.QueryString["BusinessType"];
                    objBillGenerationGST.FinYear = SessionUtilities.FinYear;


                    var TransactionDetails = new List<BillGenerationGST_TransactionDetail>();
                    foreach (RepeaterItem item in rptDocketDetails.Items)
                    {
                        CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
                        if (chkSelect.Checked)
                        {
                            Label lblTransactionID = (Label)item.FindControl("lblTransactionID");
                            HiddenField hidTransactionIDSuffix = (HiddenField)item.FindControl("hidTransactionIDSuffix");
                            Label lblTransactionDate = (Label)item.FindControl("lblTransactionDate");
                            Label lblFromCityState = (Label)item.FindControl("lblFromCityState");
                            HiddenField hidOrigin = (HiddenField)item.FindControl("hidOrigin");
                            HiddenField hidDestination = (HiddenField)item.FindControl("hidDestination");
                            Label lblToCityState = (Label)item.FindControl("lblToCityState");
                            Label lblSubTotal = (Label)item.FindControl("lblSubTotal");
                            Label lblGSTAmount = (Label)item.FindControl("lblGSTAmount");
                            Label lblTotal = (Label)item.FindControl("lblTotal");
                            HiddenField hidSACCode = (HiddenField)item.FindControl("hidSACCode");
                            TextBox txtReportingDate = (TextBox)item.FindControl("txtReportingDate");
                            TextBox txtUnloadingDate = (TextBox)item.FindControl("txtUnloadingDate");
                            TextBox txtRARemark = (TextBox)item.FindControl("txtRARemark");

                            TextBox txtReportingDateHrs = (TextBox)item.FindControl("txtReportingDateHrs");
                            TextBox txtReportingDateMin = (TextBox)item.FindControl("txtReportingDateMin");
                            TextBox txtUnloadingDateHrs = (TextBox)item.FindControl("txtUnloadingDateHrs");
                            TextBox txtUnloadingDateMin = (TextBox)item.FindControl("txtUnloadingDateMin");
                            TextBox txtMiscCharge = (TextBox)item.FindControl("txtMiscCharge");
                            Label lblSub_Total = (Label)item.FindControl("lblSub_Total");

                            txtMiscCharge.Text = txtMiscCharge.Text == "" ? "0" : txtMiscCharge.Text;


                            string ReportingDateTime = getDateInddMMMyyFormat(txtReportingDate.Text) + " " + (txtReportingDateHrs.Text == "" ? "00" : txtReportingDateHrs.Text) + ":" + (txtReportingDateMin.Text == "" ? "00" : txtReportingDateMin.Text);
                            string UnloadingDateTime = getDateInddMMMyyFormat(txtUnloadingDate.Text) + " " + (txtUnloadingDateHrs.Text == "" ? "00" : txtUnloadingDateHrs.Text) + ":" + (txtUnloadingDateMin.Text == "" ? "00" : txtUnloadingDateMin.Text);

                            TransactionDetails.Add(new BillGenerationGST_TransactionDetail()
                            {
                                TransactionID = lblTransactionID.Text.Trim(),
                                TransactionDate = lblTransactionDate.Text.Trim(),
                                FromCityState = lblFromCityState.Text.Trim(),
                                Origin = hidOrigin.Value.Trim(),
                                Destination = hidDestination.Value.Trim(),
                                ToCityState = lblToCityState.Text.Trim(),
                                MiscCharge = Convert.ToDecimal(txtMiscCharge.Text),
                                DocketAmount = Convert.ToDecimal(lblSubTotal.Text.Trim()),
                                SubTotal = Convert.ToDecimal(lblSub_Total.Text.Trim()),
                                GSTAmount = Convert.ToDecimal(lblGSTAmount.Text.Trim()),
                                Total = Convert.ToDecimal(lblTotal.Text.Trim()),
                                SACCode = hidSACCode.Value.Trim(),
                                ReportingDate = ReportingDateTime,
                                UnloadingDate = UnloadingDateTime,
                                DeviationRemarks = txtRARemark.Text,
                            });


                        }
                    }
                    objBillGenerationGST.TransactionDetails = TransactionDetails;

                    var objBillGenerationGSTController = new BillGenerationGST();
                    var strBillNo = objBillGenerationGSTController.InsertFreightBillDetail(objBillGenerationGST, hidBillingAddress.Value);
                    if (strBillNo == "")
                    {
                        throw new Exception("Bill Generation Failed....Please try again.");
                    }
                    else
                    {
                        Response.Redirect("FreightBillGenerationDone.aspx?BillNo=" + strBillNo + "&BillType=Freight", false);
                    }
                }
                else
                {
                    MsgBox.Show(msg);
                    LoadData();
                    return;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message);
                LoadData();
                // Response.Redirect(Request.RawUrl);
                //btnSubmit.Visible = false;
            }
        }
        ConsumeToken();
        #region
        //if (IsTokenValid())
        //{
        //    try
        //    {
        //        bool IsValid = true;
        //        string msg = "";
        //        ValidateData(ref IsValid, ref msg);
        //        if (IsValid)
        //        {
        //            var objBillGenerationGST = new List<BillGenerationGST_Entity>();
        //            foreach (RepeaterItem item in rptDocketDetails.Items)
        //            {
        //                CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
        //                if (chkSelect.Checked)
        //                {
        //                    Label lblTransactionID = (Label)item.FindControl("lblTransactionID");
        //                    HiddenField hidTransactionIDSuffix = (HiddenField)item.FindControl("hidTransactionIDSuffix");
        //                    Label lblTransactionDate = (Label)item.FindControl("lblTransactionDate");
        //                    Label lblFromCityState = (Label)item.FindControl("lblFromCityState");
        //                    Label lblToCityState = (Label)item.FindControl("lblToCityState");
        //                    Label lblSubTotal = (Label)item.FindControl("lblSubTotal");
        //                    Label lblGSTAmount = (Label)item.FindControl("lblGSTAmount");
        //                    Label lblTotal = (Label)item.FindControl("lblTotal");
        //                    objBillGenerationGST.Add(new BillGenerationGST_Entity()
        //                    {
        //                        CustomerCode = hidCustomerID.Value,
        //                        InvoiceNumber = lblInvoiceNumber.Text.Trim(),
        //                        BillingAddress = lblBillingAddress.Text.Trim(),
        //                        GenerationDate = txtGenerationDate.Text.Trim(),
        //                        DueDate = txtDueDate.Text.Trim(),
        //                        BillGenerationState = hidBillGenerationState.Value,
        //                        BillGenerationCity = hdnBillGenerationCity.Value,
        //                        BillGenerationGSTINNumber=hdnBillGenerationGSTINNumber.Value,
        //                        //BillGenerationLocation = lblBillGenerationLocation.Text.Trim(),
        //                        BillSubmissionState = hidBillSubmissionState.Value,
        //                        BillSubmissionCity = hdnBillSubmissionCity.Value.Trim(),
        //                        BillSubmissionGSTINNumber = hdnBillSubmissionGSTINNumber.Value,
        //                        BillSubmissionLocation = lblBillSubmissionLocation.Text.Trim(),
        //                        BillCollectionState = hidBillCollectionState.Value,
        //                        BillCollectionCity = hdnBillCollectionCity.Value.Trim(),
        //                        BillCollectionGSTINNumber = hdnBillCollectionGSTINNumber.Value,
        //                        BillCollectionLocation = lblBillCollectionLocation.Text.Trim(),
        //                        ServiceType = hidServiceType.Value,
        //                        InterState = (hidInterState.Value == "Yes" ? true : false),
        //                        SACType = hidSACType.Value,
        //                        GSTRate = Convert.ToDecimal(lblGSTRate.Text.Trim()),
        //                        ITC = (lblITC.Text.Trim() == "Yes" ? true : false),
        //                        CustomerGSTIN = lblCustomerGSTIN.Text.Trim(),
        //                        TransporterGSTIN = lblTransporterGSTIN.Text.Trim(),
        //                        TransactionID = lblTransactionID.Text.Trim(),
        //                        TransactionDate = lblTransactionDate.Text.Trim(),
        //                        FromCityState = lblFromCityState.Text.Trim(),
        //                        ToCityState = lblToCityState.Text.Trim(),
        //                        SubTotal = Convert.ToDecimal(lblSubTotal.Text.Trim()),
        //                        GSTAmount = Convert.ToDecimal(lblGSTAmount.Text.Trim()),
        //                        Total = Convert.ToDecimal(lblTotal.Text.Trim()),
        //                        //SummarySubTotal = Convert.ToDecimal(lblSummarySubTotal.Text.Trim()),
        //                        SummarySubTotal = Convert.ToDecimal(hdsubTotal.Value),
        //                        SummarySGST = Convert.ToDecimal(hidSummarySGST.Value.Trim()),
        //                        SummaryUTGST = Convert.ToDecimal(hidSummaryUTGST.Value.Trim()),
        //                        SummaryCGST = Convert.ToDecimal(hidSummaryCGST.Value.Trim()),
        //                        SummaryIGST = Convert.ToDecimal(hidSummaryIGST.Value.Trim()),
        //                        //SummaryGSTTotal = Convert.ToDecimal(lblSummaryGSTTotal.Text.Trim()),
        //                        SummaryGSTTotal = Convert.ToDecimal(hdgstTotal.Value),
        //                        //SummaryTotal = Convert.ToDecimal(lblSummaryTotal.Text.Trim()),
        //                        SummaryTotal = Convert.ToDecimal(hdtotal.Value),
        //                        GeneratedBy = SessionUtilities.CurrentEmployeeID,
        //                        CompanyCode = SessionUtilities.DefaultCompanyCode,
        //                        BillGenerationLocation = SessionUtilities.CurrentBranchCode,
        //                        ProductType = hidProductType.Value,
        //                        DockCount = Convert.ToInt32(hdCount.Value),
        //                    });
        //                }
        //            }
        //            var objBillGenerationGSTController = new BillGenerationGST();
        //            var dt = objBillGenerationGSTController.InsertFreightBillDetail(objBillGenerationGST);
        //            if ((dt.Rows[0]["Status"]).ToString() == "1")
        //            {
        //                throw new Exception((dt.Rows[0]["MESSAGE"]).ToString());
        //            }
        //        }
        //        else
        //        {
        //            MsgBox.Show(msg);
        //            return;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        MsgBox.Show(ex.Message);
        //    }
        //}
        //ConsumeToken();
        #endregion
    }
    private void LoadData()
    {
        lblBillingAddress.Text = hidBillingAddress.Value;
        ddlBillGenerationLocation.SelectedValue = hidBillGenerationLocation.Value;
        lblBillGenerationCity.Text = hdnBillGenerationCityName.Value;
        lblBillGenerationGSTIN.Text = hdnBillGenerationGSTINNumber.Value;
        ddlBillSubmissionLocation.SelectedValue = hidBillSubmissionLocation.Value;
        lblBillSubmissionCity.Text = hdnBillSubmissionCityName.Value;
        lblBillGenerationGSTIN.Text = hdnBillSubmissionGSTINNumber.Value;
        lblBillCollectionState.Text = hidBillCollectionStateName.Value;
        lblBillCollectionLocation.Text = hidBillCollectionLocation.Value;
        lblBillCollectionCity.Text = hdnBillCollectionCityName.Value;
        lblBillCollectionGSTIN.Text = hdnBillCollectionGSTINNumber.Value;
        lblCount.Text = hdCount.Value;
        lblSummarySubTotal.Text = hdsubTotal.Value;
        lblSummarySGST.Text = hidSummarySGST.Value;
        lblSummaryUTGST.Text = hidSummaryUTGST.Value;
        lblSummaryCGST.Text = hidSummaryCGST.Value;
        lblSummaryIGST.Text = hidSummaryIGST.Value;
        lblSummaryGSTTotal.Text = hdgstTotal.Value;
        lblSummaryTotal.Text = hdsubTotal.Value;
    }
    private void ValidateData(ref bool IsValid, ref string msg)
    {
        if (String.IsNullOrEmpty((string)lblCustomerName.Text.Trim())) { IsValid = false; msg = "Customer Name not found !"; return; }
        if (String.IsNullOrEmpty((string)lblInvoiceNumber.Text.Trim())) { IsValid = false; msg = "Invoice Number not found !"; return; }
        if (String.IsNullOrEmpty((string)hidBillingAddress.Value.Trim())) { IsValid = false; msg = "Billing Address not found !"; return; }
        if (String.IsNullOrEmpty((string)txtGenerationDate.Text.Trim())) { IsValid = false; msg = "Generation Date not found !"; return; }
        if (String.IsNullOrEmpty((string)txtDueDate.Text.Trim())) { IsValid = false; msg = "Due Date not found !"; return; }
        if (String.IsNullOrEmpty((string)ddlBillGenerationState.SelectedValue.Trim())) { IsValid = false; msg = "Bill Generation State not found !"; return; }
        if (String.IsNullOrEmpty((string)hidBillGenerationLocation.Value.Trim())) { IsValid = false; msg = "Bill Generation Location not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBillGenerationCity.Value.Trim())) { IsValid = false; msg = "Bill Generation City not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBillGenerationGSTINNumber.Value.Trim())) { IsValid = false; msg = "Bill Generation GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)ddlBillSubmissionState.SelectedValue.Trim())) { IsValid = false; msg = "Bill Submission State not found !"; return; }
        if (String.IsNullOrEmpty((string)hidBillSubmissionLocation.Value.Trim())) { IsValid = false; msg = "Bill Submission Location not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBillSubmissionCity.Value.Trim())) { IsValid = false; msg = "Bill Submission City not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBillSubmissionGSTINNumber.Value.Trim())) { IsValid = false; msg = "Bill Submission GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)hidBillCollectionState.Value.Trim())) { IsValid = false; msg = "Bill Collection State not found !"; return; }
        if (String.IsNullOrEmpty((string)hidBillCollectionLocation.Value.Trim())) { IsValid = false; msg = "Bill Collection Location not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBillCollectionCity.Value.Trim())) { IsValid = false; msg = "Bill Collection City not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBillCollectionGSTINNumber.Value.Trim())) { IsValid = false; msg = "Bill Collection GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)lblServiceType.Text.Trim())) { IsValid = false; msg = "Service Type not found !"; return; }
        if (String.IsNullOrEmpty((string)lblInterState.Text.Trim())) { IsValid = false; msg = "Inter State not found !"; return; }
        if (String.IsNullOrEmpty((string)lblSACCategory.Text.Trim())) { IsValid = false; msg = "SAC Category not found !"; return; }
        if (String.IsNullOrEmpty((string)lblGSTRate.Text.Trim())) { IsValid = false; msg = "GST Rate not found !"; return; }
        if (String.IsNullOrEmpty((string)lblITC.Text.Trim())) { IsValid = false; msg = "ITC not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblCustomerGSTIN.Text.Trim())) { IsValid = false; msg = "Customer GSTIN not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblTransporterGSTIN.Text.Trim())) { IsValid = false; msg = "Transporter GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)hdsubTotal.Value.Trim())) { IsValid = false; msg = "Transaction Sub Total must be greater then 0 ! "; return; }
        if (String.IsNullOrEmpty((string)hdtotal.Value.Trim())) { IsValid = false; msg = "Transaction Total must be greater then 0 ! "; return; }
        if (Convert.ToDouble(hdsubTotal.Value.Trim()) <= 0) { IsValid = false; msg = "Transaction Sub Total must be greater then 0 ! "; return; }
        if (Convert.ToDouble(hdtotal.Value.Trim()) <= 0) { IsValid = false; msg = "Transaction Total must be greater then 0 ! "; return; }
    }
    [WebMethod]
    public static string GetLedgerDetails(double grandtotal, double gsttotal, string customercode, string interstateyesno, string billingtype, string utState, string utStateSame, string businessType)
    {
        try
        {
            var objHeader = new BillGenerationGST_LedgerDetails();
            var objBill = new BillGenerationGST();
            var dtResult = objBill.GetLedgerDetails(grandtotal, gsttotal, customercode, interstateyesno, billingtype, utState, utStateSame, businessType);
            if (dtResult.Rows.Count == 0)
                return "";
            foreach (DataRow dRow in dtResult.Rows)
            {
                var objItem = new BillGenerationGST_LedgerDetails
                {
                    Ledger = Convert.ToString(dRow["Ledger"]),
                    SubLedger = Convert.ToString(dRow["Sub-ledger"]),
                    Debit = Convert.ToString(dRow["Dr"]),
                    Credit = Convert.ToString(dRow["Cr"])
                };
                objHeader.ListItems.Add(objItem);
            }
            return JsonHelper.JavaScriptSerialize(objHeader);
        }
        catch (Exception ex)
        {
            return "";
        }
    }
    [WebMethod]
    public static string GetCustomerBillGenerationLocation(string statecd, string customercode)
    {
        try
        {
            var objBill = new BillGenerationGST();
            var dtCustomerLocation = objBill.GetCustomerBillGenerationLocation(statecd, customercode);
            var items = dtCustomerLocation.AsEnumerable().Select(row =>
                        new BillGenerationGST_CustomerState()
                        {
                            Code = row.Field<string>("Code"),
                            Name = row.Field<string>("Name")
                        }).ToList();

            return JsonHelper.JavaScriptSerialize(items);
        }
        catch (Exception ex)
        {
            return "";
        }
    }
    [WebMethod]
    public static string GetCustomerBillSubmissionLocation(string statecd, string customercode)
    {
        try
        {
            var objBill = new BillGenerationGST();
            var dtCustomerLocation = objBill.GetCustomerBillSubmissionLocation(statecd, customercode);
            var items = dtCustomerLocation.AsEnumerable().Select(row =>
                        new BillGenerationGST_CustomerState()
                        {
                            Code = row.Field<string>("Code"),
                            Name = row.Field<string>("Name")
                        }).ToList();

            return JsonHelper.JavaScriptSerialize(items);
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }

}
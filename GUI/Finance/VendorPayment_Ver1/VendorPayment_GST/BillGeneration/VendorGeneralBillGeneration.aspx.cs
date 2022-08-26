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

public partial class GUI_Finance_VendorPayment_GST_BillGeneration_VendorGeneralBillGeneration : BasePage
{
    public string filename = "CompanyGST";
    public string procedure = "Usp_CompanyGST_Upload";

    public List<GSTMasterEntity> lst_GSTMasterEntity
    {
        get { return ViewState["lst_GSTMasterEntity"] != null ? (List<GSTMasterEntity>)ViewState["lst_GSTMasterEntity"] : new List<GSTMasterEntity>(); }
        set { ViewState["lst_GSTMasterEntity"] = value; }
    }

    private DataTable ViewData
    {
        get { if (ViewState["ViewData"] != null) return ViewState["ViewData"] as DataTable; else return new DataTable(); }
        set { ViewState["ViewData"] = value; }
    }
    private DataTable dtTransactionType
    {
        get { if (ViewState["dtTransactionType"] != null) return ViewState["dtTransactionType"] as DataTable; else return new DataTable(); }
        set { ViewState["dtTransactionType"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            HdnVendorCode.Value = Convert.ToString(Request.QueryString["VendorCode"]).Trim();
            Session["AccBranchFilter"] = SessionUtilities.CurrentBranchCode.Trim();
            Session["AccCompanyFilter"] = SessionUtilities.DefaultCompanyCode.Trim();
            Session["AccPartyFilter"] = "All";

            hdnSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
            hdnPastDate.Value = "01/07/2017";

            string billDate;
            billDate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtGenerationDate.Text = billDate.ToString();
            txtVendorInvoiceDate.Text = billDate.ToString();
            string billDueDate;
            billDueDate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDueDate.Text = billDueDate.ToString();

            hdnRegisteredYN.Value = Convert.ToString(Request.QueryString["GSTCharged"]).Trim() == "4" ? "N" : "Y";
            lblUnregistered.Text = Convert.ToString(Request.QueryString["GSTCharged"]).Trim() == "4" ? "Yes" : "No";

            FillHeaderData();
            BindTransactionCategory();

            int Duedays = Convert.ToInt16(hidCreditDays.Value);
            DateTime dt = DateTime.Today.AddDays(Duedays);
            txtDueDate.Text = dt.ToString("dd/MM/yyyy");

            ViewData = new DataTable();
            ViewData.Columns.Add("AccCode");
            ViewData.Columns.Add("AccDesc");
            ViewData.Columns.Add("SACCode");
            ViewData.Columns.Add("SACDesc");
            ViewData.Columns.Add("Narration");
            ViewData.Columns.Add("Amt");
            ViewData.Columns.Add("GSTRate");
            ViewData.Columns.Add("GSTAmount");
            ViewData.Columns.Add("TotalAmount");
            for (int i = 0; i < 3; i++)
            {
                ViewData.Rows.Add("", "", "", "", "", "0.00", "0.00", "0.00", "0.00");
            }
            grvcontrols.DataSource = ViewData;
            grvcontrols.DataBind();
            txtRows.Text = "1";
        }
        if (IsPostBack || IsCallback)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "myscript", "DocumentReadyReload();", true);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        bool result = false;
        var billno = "";
        try
        {
            if (IsTokenValid())
            {
                bool IsValid = true;
                string msg = "";
                ValidateData(ref IsValid, ref msg);
                if (IsValid)
                {
                    MyFunctions fn = new MyFunctions();
                    var objBill = new VendorBillGenerationGST_GeneralBill();

                    objBill.VendorCode = HdnVendorCode.Value.Trim();
                    //objBill.BillingAddress = lblBillingAddress.Text.Trim();
                    objBill.PANNo = lblPanNumber.Text.Trim();
                    objBill.ManualBillNo = txtManualInvoiceNumber.Text.Trim();
                    objBill.InvoiceBookingDate = fn.Mydate1(txtGenerationDate.Text.Trim());
                    objBill.VendorInvoiceDate = fn.Mydate1(txtVendorInvoiceDate.Text.Trim());
                    objBill.DueDate = fn.Mydate1(txtDueDate.Text.Trim());
                    objBill.Location = SessionUtilities.CurrentBranchCode.Trim();
                    objBill.FinYear = SessionUtilities.FinYear.Trim();
                    objBill.CompanyCode = SessionUtilities.DefaultCompanyCode.Trim();

                    objBill.BillVendorState = hdnSupplyState.Value.Trim();
                    objBill.BillVendorCity = ddlSupplyCity.SelectedValue.Trim();
                    objBill.BillVendorLocation = txtInvoicedAtLocation.Text.Trim();
                    objBill.BillVendorStateType = hdnSupplyStateType.Value.Trim();
                    objBill.BillVendorGSTIN = LblInvoicedAtGSTIN.Text.Trim();
                    objBill.BillVendorAddress = hdnSupplyAddress.Value.Trim();

                    objBill.BillBookingState = hdnBookingState.Value.Trim();
                    objBill.BillBookingCity = ddlBookingCity.SelectedValue.Trim();
                    objBill.BillBookingLocation = txtBookedAtLocation.Text.Trim();
                    objBill.BillBookingStateType = hdnBookingStateType.Value.Trim();
                    objBill.BillBookingGSTIN = LblBookedAtGSTIN.Text.Trim();
                    objBill.BillBookingAddress = hdnBookingAddress.Value.Trim();

                    objBill.InterState = hdnInterState.Value.Trim();
                    objBill.RegisteredYN = hdnRegisteredYN.Value.Trim();

                    foreach (GridViewRow gridrow in grvcontrols.Rows)
                    {
                        var txtAccCode = ((TextBox)gridrow.FindControl("txtAccCode"));
                        var txtDescription = ((TextBox)gridrow.FindControl("txtDescription"));
                        var hdnDescription = ((HiddenField)gridrow.FindControl("hdnDescription"));
                        var ddlSACCode = ((DropDownList)gridrow.FindControl("ddlSACCode"));
                        var txtNarration = ((TextBox)gridrow.FindControl("txtNarration"));
                        var txtAmt = ((TextBox)gridrow.FindControl("txtAmt"));
                        var hdnAmt = ((HiddenField)gridrow.FindControl("hdnAmt"));
                        var txtGSTRate = ((TextBox)gridrow.FindControl("txtGSTRate"));
                        var hdnGSTRate = ((HiddenField)gridrow.FindControl("hdnGSTRate"));
                        var txtGSTAmount = ((TextBox)gridrow.FindControl("txtGSTAmount"));
                        var hdnGSTAmount = ((HiddenField)gridrow.FindControl("hdnGSTAmount"));
                        var txtTotal = ((TextBox)gridrow.FindControl("txtTotal"));
                        var hdnItemTotal = ((HiddenField)gridrow.FindControl("hdnItemTotal"));

                        if (txtAccCode.Text.Trim() != "")
                        {
                            string[] serviceProductSac = ddlSACCode.SelectedValue.Split('~');
                            var objAcc = new VendorBillGenerationGST_AccountDetails
                            {
                                AccCode = txtAccCode.Text.Trim(),
                                AccDesc = hdnDescription.Value.Trim(),
                                SACType = ddlSACCode.SelectedValue.Trim(),
                                Narration = txtNarration.Text.Trim(),
                                SACCode = (serviceProductSac.Length > 0 ? serviceProductSac[0] : ""),
                                SACCategory = (serviceProductSac.Length > 1 ? serviceProductSac[1] : ""),
                                ServiceType = "",
                                ProductType = "",
                                Amount = Convert.ToDouble(hdnAmt.Value.Trim() == "" ? "0" : hdnAmt.Value.Trim()),
                                GSTRate = Convert.ToDouble(hdnGSTRate.Value.Trim() == "" ? "0" : hdnGSTRate.Value.Trim()),
                                GSTAmount = Convert.ToDouble(hdnGSTAmount.Value.Trim() == "" ? "0" : hdnGSTAmount.Value.Trim()),
                                TotalAmount = Convert.ToDouble(hdnItemTotal.Value.Trim() == "" ? "0" : hdnItemTotal.Value.Trim())
                            };

                            objBill.ListItems.Add(objAcc);
                        }
                    }


                    objBill.ItemCount = Convert.ToInt32(hdnCount.Value.Trim() == "" ? "0" : hdnCount.Value.Trim());
                    objBill.SubTotal = Convert.ToDouble(hdnSubtotal.Value.Trim() == "" ? "0" : hdnSubtotal.Value.Trim());
                    objBill.SGSTAmount = Convert.ToDouble(hdnSGST.Value.Trim() == "" ? "0" : hdnSGST.Value.Trim());
                    objBill.UGSTAmount = Convert.ToDouble(hdnUGST.Value.Trim() == "" ? "0" : hdnUGST.Value.Trim());
                    objBill.CGSTAmount = Convert.ToDouble(hdnCGST.Value.Trim() == "" ? "0" : hdnCGST.Value.Trim());
                    objBill.IGSTAmount = Convert.ToDouble(hdnIGST.Value.Trim() == "" ? "0" : hdnIGST.Value.Trim());
                    objBill.GSTToal = Convert.ToDouble(hdnGSTTotal.Value.Trim() == "" ? "0" : hdnGSTTotal.Value.Trim());
                    objBill.TotalAmount = Convert.ToDouble(hdnTotal.Value.Trim() == "" ? "0" : hdnTotal.Value.Trim());
                    //Added TDS Section
                    objBill.TDSSection = ddlTdsSection.SelectedValue;
                    objBill.TDSRate = Convert.ToDouble(txtTdsRate.Text.Trim() == "" ? "0" : txtTdsRate.Text.Trim());
                    objBill.TDSAmount = Convert.ToDouble(hdnTdsAmount.Value.Trim() == "" ? "0" : hdnTdsAmount.Value.Trim());

                    objBill.EntryBy = SessionUtilities.CurrentEmployeeID.Trim();

                    var objGeneralBill = new VendorBillGenerationGST();
                    var dt = objGeneralBill.GeneralBill_Generation(objBill);

                    ConsumeToken();
                    if (dt.Rows.Count > 0)
                    {
                        result = true;
                        billno = Convert.ToString(dt.Rows[0]["BILLNO"]);
                    }
                }
                else
                {
                    msgBox.Show(msg);
                    loaddata();
                    return;
                }
            }
        }
        catch (Exception Ex)
        {
            msgBox.Show(Ex.Message);
            loaddata();
            return;
        }

        if (result)
            Response.Redirect("VendorGeneralBillGenerationDone.aspx?BillNo=" + billno + "&BillType=General", false);
    }
    protected void FillHeaderData()
    {
        try
        {
            var oGSTMasterController = new VendorBillGenerationGST();
            var oBillVendorCriteria = new VendorBillGenerationGST_Entity();

            oBillVendorCriteria.VendorCode = Request.QueryString["VendorCode"];
            oBillVendorCriteria.Location = SessionUtilities.CurrentBranchCode;
            oBillVendorCriteria.CompanyCode = SessionUtilities.DefaultCompanyCode;
            oBillVendorCriteria.SupplyState = Request.QueryString["SupplyState"];
            oBillVendorCriteria.BookingState = Request.QueryString["BookingState"];
            oBillVendorCriteria.RegisteredYN = Convert.ToString(Request.QueryString["GSTCharged"]).Trim() == "4" ? "N" : "Y";

            var dt = oGSTMasterController.Get_VendorBill_VendorDetails(oBillVendorCriteria);

            if (dt.Tables.Count > 0)
            {
                if (dt.Tables[0].Rows.Count > 0)
                {
                    lblVendorName.Text = dt.Tables[0].Rows[0]["VENDORCODE"].ToString() + " : " + dt.Tables[0].Rows[0]["VENDORNAME"].ToString();
                    hidVendorID.Value = dt.Tables[0].Rows[0]["VENDORCODE"].ToString();
                    lblPanNumber.Text = dt.Tables[0].Rows[0]["PAN_NO"].ToString();

                    hdnSupplyState.Value = dt.Tables[0].Rows[0]["SupplyStateCode"].ToString();
                    hdnSupplyStateType.Value = dt.Tables[0].Rows[0]["SupplyStateType"].ToString();
                    lblSupplyState.Text = dt.Tables[0].Rows[0]["SupplyStateName"].ToString();

                    hdnBookingState.Value = dt.Tables[0].Rows[0]["BookingStateCode"].ToString();
                    hdnBookingStateType.Value = dt.Tables[0].Rows[0]["BookingStateType"].ToString();
                    lblBookingState.Text = dt.Tables[0].Rows[0]["BookingStateName"].ToString();

                    hdnInvoicedAtLocation.Value = SessionUtilities.CurrentBranchCode;
                    txtInvoicedAtLocation.Text = SessionUtilities.CurrentBranchCode;
                    hdnBookedAtLocation.Value = SessionUtilities.CurrentBranchCode;
                    txtBookedAtLocation.Text = SessionUtilities.CurrentBranchCode;
                    hidCreditDays.Value = Convert.ToString(dt.Tables[0].Rows[0]["credit_day"]);

                    var dtSupplyCity = oGSTMasterController.Get_VendorBill_Get_SupplyCity_Details(oBillVendorCriteria);
                    ddlSupplyCity.DataSource = dtSupplyCity;
                    ddlSupplyCity.DataBind();

                    var dtBookingCity = oGSTMasterController.Get_VendorBill_Get_BookingCity_Details(oBillVendorCriteria);
                    ddlBookingCity.DataSource = dtBookingCity;
                    ddlBookingCity.DataBind();

                    if (hdnSupplyState.Value.Trim() == hdnBookingState.Value.Trim())
                    {
                        lblInterState.Text = "Yes";
                        hdnInterState.Value = "Yes";
                    }
                    else
                    {
                        lblInterState.Text = "No";
                        hdnInterState.Value = "No";
                    }
                    //Added TDSSection
                    ddlTdsSection.DataSource = oGSTMasterController.GetTdsSection();
                    ddlTdsSection.DataBind();
                }
                else
                {
                    msgBox.Show("No Data Found..Please verify Company/Vendor GST master Mappings.");
                    btnSubmit.Visible = false;
                }
            }
            else
            {
                msgBox.Show("No Data Found..");
                btnSubmit.Visible = false;
            }
        }
        catch (Exception Ex)
        {
            msgBox.Show(Ex.Message);
        }
    }

    private void ValidateData(ref bool IsValid, ref string msg)
    {
        if (String.IsNullOrEmpty((string)lblVendorName.Text.Trim())) { IsValid = false; msg = "Vendor Name not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblInvoiceNumber.Text.Trim())) { IsValid = false; msg = "Invoice Number not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblBillingAddress.Text.Trim())) { IsValid = false; msg = "Billing Address not found !"; return; }
        if (String.IsNullOrEmpty((string)txtGenerationDate.Text.Trim())) { IsValid = false; msg = "Generation Date not found !"; return; }
        if (String.IsNullOrEmpty((string)txtVendorInvoiceDate.Text.Trim())) { IsValid = false; msg = "Vendor Invoice Date not found !"; return; }
        if (String.IsNullOrEmpty((string)txtDueDate.Text.Trim())) { IsValid = false; msg = "Due Date not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnSupplyState.Value.Trim())) { IsValid = false; msg = "Vendor State not found !"; return; }
        if (String.IsNullOrEmpty((string)ddlSupplyCity.SelectedValue.Trim())) { IsValid = false; msg = "Vendor City not found !"; return; }
        //if (String.IsNullOrEmpty((string)LblInvoicedAtGSTIN.Text.Trim())) { IsValid = false; msg = "Vendor GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)txtInvoicedAtLocation.Text.Trim())) { IsValid = false; msg = "Vendor Location not found !"; return; }
        if (String.IsNullOrEmpty((string)hdnBookingState.Value.Trim())) { IsValid = false; msg = "Booking State not found !"; return; }
        if (String.IsNullOrEmpty((string)ddlBookingCity.SelectedValue.Trim())) { IsValid = false; msg = "Booking City not found !"; return; }
        //if (String.IsNullOrEmpty((string)LblBookedAtGSTIN.Text.Trim())) { IsValid = false; msg = "Booking GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)txtBookedAtLocation.Text.Trim())) { IsValid = false; msg = "Booking Location not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblInterState.Text.Trim())) { IsValid = false; msg = "Inter State not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblSummarySubTotal.Text.Trim())) { IsValid = false; msg = "Transaction Sub Total must be greater then 0 ! "; return; }
        //if (String.IsNullOrEmpty((string)lblSummaryTotal.Text.Trim())) { IsValid = false; msg = "Transaction Total must be greater then 0 ! "; return; }
    }

    public DataTable dtResultSuccess
    {
        get { return (ViewState["dtResultSuccess"] != null) ? ViewState["dtResultSuccess"] as DataTable : new DataTable(); }
        set { ViewState["dtResultSuccess"] = value; }
    }
    public DataTable dtResultFail
    {
        get { return (ViewState["dtResultFail"] != null) ? ViewState["dtResultFail"] as DataTable : new DataTable(); }
        set { ViewState["dtResultFail"] = value; }
    }
    public DataTable dtFormat
    {
        get { return (ViewState["dtFormat"] != null) ? ViewState["dtFormat"] as DataTable : new DataTable(); }
        set { ViewState["dtFormat"] = value; }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        ReverseBind();
        if (string.IsNullOrEmpty(txtRows.Text.Trim()))
            maxrows = 0;
        else
            maxrows = Convert.ToInt16(txtRows.Text);

        for (int i = 0; i < maxrows; i++)
        {
            ViewData.Rows.Add("", "", "", "", "", "0.00", "0.00", "0.00", "0.00");
        }
        grvcontrols.DataSource = ViewData;
        grvcontrols.DataBind();

        loaddata();
    }

    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {

        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox Acccode = ((TextBox)e.Row.FindControl("txtAccCode"));
            TextBox Accdesc = ((TextBox)e.Row.FindControl("txtDescription"));
            TextBox txtamt = ((TextBox)e.Row.FindControl("txtAmt"));
            DropDownList ddlSACCode = (DropDownList)e.Row.FindControl("ddlSACCode");
            TextBox txtNarration = ((TextBox)e.Row.FindControl("txtNarration"));
            TextBox txtGSTRate = ((TextBox)e.Row.FindControl("txtGSTRate"));
            TextBox txtGSTAmount = ((TextBox)e.Row.FindControl("txtGSTAmount"));
            TextBox txtTotal = ((TextBox)e.Row.FindControl("txtTotal"));

            HiddenField hdnGSTRate = ((HiddenField)e.Row.FindControl("hdnGSTRate"));
            HiddenField hdnGSTAmount = ((HiddenField)e.Row.FindControl("hdnGSTAmount"));
            HiddenField hdnItemTotal = ((HiddenField)e.Row.FindControl("hdnItemTotal"));

            Acccode.Text = DataBinder.Eval(e.Row.DataItem, "AccCode").ToString();
            Accdesc.Text = DataBinder.Eval(e.Row.DataItem, "AccDesc").ToString();
            txtNarration.Text = DataBinder.Eval(e.Row.DataItem, "Narration").ToString();
            txtamt.Text = DataBinder.Eval(e.Row.DataItem, "Amt").ToString();
            txtamt.Attributes.Add("onblur", "calculate_GST()");
            txtGSTRate.Text = DataBinder.Eval(e.Row.DataItem, "GSTRate").ToString();
            hdnGSTRate.Value = DataBinder.Eval(e.Row.DataItem, "GSTRate").ToString();
            txtGSTAmount.Text = DataBinder.Eval(e.Row.DataItem, "GSTAmount").ToString();
            hdnGSTAmount.Value = DataBinder.Eval(e.Row.DataItem, "GSTAmount").ToString();
            txtTotal.Text = DataBinder.Eval(e.Row.DataItem, "TotalAmount").ToString();
            hdnItemTotal.Value = DataBinder.Eval(e.Row.DataItem, "TotalAmount").ToString();

            ddlSACCode.DataSource = dtTransactionType;
            ddlSACCode.DataTextField = "TransactionCategoryDesc";
            ddlSACCode.DataValueField = "TransactionCategory";
            ddlSACCode.DataBind();
            try
            { ddlSACCode.SelectedValue = DataBinder.Eval(e.Row.DataItem, "SACCode").ToString(); }
            catch { }

            if (hdnRegisteredYN.Value == "Y")
            {
                txtamt.Enabled = true;
                txtTotal.Enabled = false;
            }
            else
            {
                txtamt.Enabled = false;
                txtTotal.Enabled = true;
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {

        }
    }

    private void ReverseBind()
    {
        ViewData.Rows.Clear();
        ViewData.Dispose();
        ViewData = new DataTable();
        ViewData.Columns.Add("AccCode");
        ViewData.Columns.Add("AccDesc");
        ViewData.Columns.Add("SACCode");
        ViewData.Columns.Add("SACDesc");
        ViewData.Columns.Add("Narration");
        ViewData.Columns.Add("Amt");
        ViewData.Columns.Add("GSTRate");
        ViewData.Columns.Add("GSTAmount");
        ViewData.Columns.Add("TotalAmount");
        foreach (GridViewRow gr in grvcontrols.Rows)
        {

            TextBox Acccode = ((TextBox)gr.FindControl("txtAccCode"));
            TextBox Accdesc = ((TextBox)gr.FindControl("txtDescription"));
            TextBox txtamt = ((TextBox)gr.FindControl("txtAmt"));
            DropDownList ddlSACCode = ((DropDownList)gr.FindControl("ddlSACCode"));
            TextBox txtNarration = ((TextBox)gr.FindControl("txtNarration"));
            TextBox txtGSTRate = ((TextBox)gr.FindControl("txtGSTRate"));
            TextBox txtGSTAmount = ((TextBox)gr.FindControl("txtGSTAmount"));
            TextBox txtTotal = ((TextBox)gr.FindControl("txtTotal"));

            ViewData.Rows.Add(Acccode.Text.Trim(), Accdesc.Text.Trim(), ddlSACCode.SelectedValue, "", txtNarration.Text.Trim(), txtamt.Text.Trim(), txtGSTRate.Text.Trim(), txtGSTAmount.Text.Trim(), txtTotal.Text.Trim());
        }
    }

    protected void BindTransactionCategory()
    {
        var objBillGen = new VendorBillGenerationGST();
        dtTransactionType = objBillGen.GetVendorBill_GetSACCategory();
    }

    protected void ddlVendorCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        var oGSTMasterController = new VendorBillGenerationGST();

        var dtSupplyCity = oGSTMasterController.GetSupplyCityDetails_FromCityCode(HdnVendorCode.Value.Trim(), hdnSupplyState.Value.Trim(), ddlSupplyCity.SelectedValue.Trim());
        if (dtSupplyCity.Rows.Count > 0)
        {
            //LblInvoicedAtCity.Text = dtSupplyCity.Rows[0]["Name"].ToString();
            hdnInvoicedAtCity.Value = dtSupplyCity.Rows[0]["Code"].ToString();
            LblInvoicedAtGSTIN.Text = dtSupplyCity.Rows[0]["GSTINNumber"].ToString();
            lblSupplyAddress.Text = dtSupplyCity.Rows[0]["BillingAddress"].ToString();
            hdnSupplyAddress.Value = dtSupplyCity.Rows[0]["BillingAddress"].ToString();

            if (hdnSupplyState.Value.Trim() == hdnBookingState.Value.Trim())
            {
                lblInterState.Text = "Yes";
                hdnInterState.Value = "Yes";
            }
            else
            {
                lblInterState.Text = "No";
                hdnInterState.Value = "No";
            }
        }
        else
        {
            hdnInvoicedAtCity.Value = "";
            LblInvoicedAtGSTIN.Text = "";
            lblSupplyAddress.Text = "";
            hdnSupplyAddress.Value = "";
        }
        loaddata();
    }
    protected void ddlBookingCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        var oGSTMasterController = new VendorBillGenerationGST();

        var CustomerCity_dt = oGSTMasterController.GetBookingCityDetails_FromCityCode(SessionUtilities.DefaultCompanyCode.Trim(), hdnBookingState.Value.Trim(), ddlBookingCity.SelectedValue.Trim());
        if (CustomerCity_dt.Rows.Count > 0)
        {
            //LblBookedAtCity.Text = CustomerCity_dt.Rows[0]["Name"].ToString();
            hdnBookedAtCity.Value = CustomerCity_dt.Rows[0]["Code"].ToString();
            LblBookedAtGSTIN.Text = CustomerCity_dt.Rows[0]["GSTINNumber"].ToString();
            lblBookingAddress.Text = CustomerCity_dt.Rows[0]["BillingAddress"].ToString();
            hdnBookingAddress.Value = CustomerCity_dt.Rows[0]["BillingAddress"].ToString();

            if (hdnSupplyState.Value.Trim() == hdnBookingState.Value.Trim())
            {
                lblInterState.Text = "Yes";
                hdnInterState.Value = "Yes";
            }
            else
            {
                lblInterState.Text = "No";
                hdnInterState.Value = "No";
            }
        }
        else
        {
            hdnBookedAtCity.Value = "";
            LblBookedAtGSTIN.Text = "";
            lblBookingAddress.Text = "";
            hdnBookingAddress.Value = "";
        }

        loaddata();
    }

    protected void loaddata()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "myscript" + DateTime.Now.Ticks, "calculate_GST();", true);
    }

    [WebMethod]
    public static string GetGstRate_FromServiceType(string strServiceType, string strIsRegistered)
    {
        try
        {
            var tm = new VendorBillGenerationGST_GstRate();
            var objBill = new VendorBillGenerationGST();
            //var dtResult = objBill.GetGstRate_FromServiceType(strServiceType);
            var dtResult = objBill.GetGstRate_FromSACCode(strServiceType, strIsRegistered);

            if (dtResult.Rows.Count == 0)
                return "";

            tm.GstRate = Convert.ToDouble(dtResult.Rows[0]["GSTRate"]);

            return JsonHelper.JavaScriptSerialize(tm);
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    [WebMethod]
    public static string ValidateState(string code)
    {
        try
        {
            var tv = new VendorBillGenerationGST_StateValidation();
            var objBill = new VendorBillGenerationGST();
            var dtResult = objBill.ValidateState(code.Trim());

            if (dtResult.Rows.Count == 0)
                return "";

            tv.CountFlag = Convert.ToString(dtResult.Rows[0]["CNT"]) != "0" ? "true" : "false";
            tv.StateCode = Convert.ToString(dtResult.Rows[0]["StateCode"]);
            tv.StateType = Convert.ToString(dtResult.Rows[0]["StateType"]);

            return JsonHelper.JavaScriptSerialize(tv);
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    [WebMethod]
    public static string ValidateCity(string strCityName, string strStateCode)
    {
        try
        {
            var tv = new VendorBillGenerationGST_CityValidation();
            var objBill = new VendorBillGenerationGST();
            var dtResult = objBill.ValidateCity(strCityName.Trim(), strStateCode.Trim());

            if (dtResult.Rows.Count == 0)
                return "";

            tv.CountFlag = Convert.ToString(dtResult.Rows[0]["CNT"]) != "0" ? "true" : "false";
            tv.CityCode = Convert.ToString(dtResult.Rows[0]["CityCode"]);

            return JsonHelper.JavaScriptSerialize(tv);
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    [WebMethod]
    public static string ValidateAccCode(string strAccCode)
    {
        try
        {
            var tv = new VendorBillGenerationGST_AccCodeValidation();
            var objBill = new VendorBillGenerationGST();
            var dtResult = objBill.ValidateAccCode(strAccCode.Trim());

            if (dtResult.Rows.Count == 0)
                return "";

            tv.CountFlag = Convert.ToString(dtResult.Rows[0]["CNT"]) != "0" ? "true" : "false";
            tv.AccCode = Convert.ToString(dtResult.Rows[0]["AccCode"]);
            tv.AccDesc = Convert.ToString(dtResult.Rows[0]["AccDesc"]);

            return JsonHelper.JavaScriptSerialize(tv);
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    [WebMethod]
    public static string GetLedgerDetails(double grandtotal, double gsttotal, string vendorcode, string interstateyesno, string billingtype, string utState, string utStateSame, double tdsAmount, string tdsSection)
    {
        try
        {
            var objHeader = new VendorBillGenerationGST_LedgerDetails();
            var objBill = new VendorBillGenerationGST();
            var dtResult = objBill.GetVendorLedgerDetails(grandtotal, gsttotal, vendorcode, interstateyesno, billingtype, utState, utStateSame, tdsAmount, tdsSection);

            if (dtResult.Rows.Count == 0)
                return "";

            foreach (DataRow dRow in dtResult.Rows)
            {
                var objItem = new VendorBillGenerationGST_LedgerDetails
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

}
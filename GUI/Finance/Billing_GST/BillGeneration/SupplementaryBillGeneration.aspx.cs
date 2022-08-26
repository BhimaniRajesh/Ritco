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

public partial class GUI_Finance_Billing_GST_BillGeneration_SupplementaryBillGeneration : BasePage
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
        get{ if (ViewState["ViewData"] != null) return ViewState["ViewData"] as DataTable; else return new DataTable();}
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
            HdnCustomerCode.Value = Convert.ToString(Request.QueryString["CustomerCode"]).Trim();
            Session["AccBranchFilter"] = SessionUtilities.CurrentBranchCode.Trim();
            Session["AccCompanyFilter"] = SessionUtilities.DefaultCompanyCode.Trim();
            Session["AccPartyFilter"] = "All";

            hdnSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
            hdnPastDate.Value = "01/07/2017";

            string billDate;
            billDate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtGenerationDate.Text = billDate.ToString();
            string billDueDate;
            billDueDate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDueDate.Text = billDueDate.ToString();
            
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
                    var objBill = new BillGenerationGST_GeneralBill();

                    objBill.CustomerCode = HdnCustomerCode.Value.Trim();
                    objBill.BillingAddress = lblBillingAddress.Text.Trim();

                    //objBill.InvoiceDate = Convert.ToDateTime(txtGenerationDate.Text).ToString("dd MMM yyyy");
                    //objBill.DueDate = Convert.ToDateTime(txtDueDate.Text).ToString("dd MMM yyyy");
                    objBill.InvoiceDate = fn.Mydate1(txtGenerationDate.Text.Trim());
                    objBill.DueDate = fn.Mydate1(txtDueDate.Text.Trim());
                    objBill.Location = SessionUtilities.CurrentBranchCode.Trim();
                    objBill.FinYear = SessionUtilities.FinYear.Trim();
                    objBill.CompanyCode = SessionUtilities.DefaultCompanyCode.Trim();

                    objBill.BillGenerationState = DDLBillGenerationState.SelectedValue.Trim();
                    objBill.BillGenerationCity = hdnBillGenerationCity.Value.Trim(); //LblBillGenerationCity.Text.Trim();
                    objBill.BillGenerationLocation = txtBillGenerationLocation.Text.Trim();
                    objBill.BillGenerationStateType = hdnBillGenerationStateType.Value.Trim();
                    objBill.BillGenerationGSTIN = LblBillGenerationGSTIN.Text.Trim();

                    objBill.BillSubmissionState = DDLBillSubmissionState.SelectedValue.Trim();
                    objBill.BillSubmissionCity = hdnBillSubmissionCity.Value.Trim(); //LblBillSubmissionCity.Text.Trim();
                    objBill.BillSubmissionLocation = txtBillSubmissionLocation.Text.Trim();
                    objBill.BillSubmissionStateType = hdnBillSubmissionStateType.Value.Trim();
                    objBill.BillSubmissionGSTIN = LblBillSubmissionGSTIN.Text.Trim();

                    objBill.BillCollectionState = DDLBillCollectionState.SelectedValue.Trim();
                    objBill.BillCollectionCity = hdnBillCollectionCity.Value.Trim(); //LblBillCollectionCity.Text.Trim();
                    objBill.BillCollectionLocation = txtBillCollectionLocation.Text.Trim();
                    objBill.BillCollectionStateType = hdnBillCollectionStateType.Value.Trim();
                    objBill.BillCollectionGSTIN = LblBillCollectionGSTIN.Text.Trim();

                    objBill.InterState = hdnInterState.Value.Trim();

                    foreach (GridViewRow gridrow in grvcontrols.Rows)
                    {
                        var txtAccCode = ((TextBox) gridrow.FindControl("txtAccCode"));
                        var txtDescription = ((TextBox) gridrow.FindControl("txtDescription"));
                        var hdnDescription = ((HiddenField)gridrow.FindControl("hdnDescription"));
                        var ddlSACCode = ((DropDownList) gridrow.FindControl("ddlSACCode"));
                        var txtNarration = ((TextBox)gridrow.FindControl("txtNarration"));
                        var txtAmt = ((TextBox) gridrow.FindControl("txtAmt"));
                        var txtGSTRate = ((TextBox) gridrow.FindControl("txtGSTRate"));
                        var hdnGSTRate = ((HiddenField)gridrow.FindControl("hdnGSTRate"));
                        var txtGSTAmount = ((TextBox) gridrow.FindControl("txtGSTAmount"));
                        var hdnGSTAmount = ((HiddenField)gridrow.FindControl("hdnGSTAmount"));
                        var txtTotal = ((TextBox) gridrow.FindControl("txtTotal"));
                        var hdnItemTotal = ((HiddenField)gridrow.FindControl("hdnItemTotal"));

                        if (txtAccCode.Text.Trim() != "")
                        {
                            string []serviceProductSac = ddlSACCode.SelectedValue.Split('~');
                            var objAcc = new BillGenerationGST_AccountDetails
                            {
                                AccCode = txtAccCode.Text.Trim(),
                                AccDesc = hdnDescription.Value.Trim(),
                                SACType = ddlSACCode.SelectedValue.Trim(),
                                Narration = txtNarration.Text.Trim(),
                                SACCode = (serviceProductSac.Length > 0 ? serviceProductSac[0] : ""),
                                SACCategory = (serviceProductSac.Length > 1 ? serviceProductSac[1] : ""),
                                ServiceType = "",
                                ProductType = "",
                                Amount = Convert.ToDouble(txtAmt.Text.Trim() == "" ? "0" : txtAmt.Text.Trim()),
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

                    objBill.EntryBy = SessionUtilities.CurrentEmployeeID.Trim();

                    var objGeneralBill = new BillGenerationGST();
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
            Response.Redirect("FreightBillGenerationDone.aspx?BillNo=" + billno + "&BillType=General", false);
    }
    protected void FillHeaderData()
    {
        try
        {
            var oGSTMasterController = new BillGenerationGST();
            var oBillGenerationGST_Entity = new BillGenerationGST_Entity();

            oBillGenerationGST_Entity.CustomerCode = Request.QueryString["CustomerCode"];
            oBillGenerationGST_Entity.Location = SessionUtilities.CurrentBranchCode;
            oBillGenerationGST_Entity.CompanyCode = SessionUtilities.DefaultCompanyCode;
            var dt = oGSTMasterController.Get_SupplementaryBill_CustomerDetails(oBillGenerationGST_Entity);

            var CompanyState_dt = oGSTMasterController.Get_SupplementaryBill_Company_State_Details(oBillGenerationGST_Entity);
            DDLBillGenerationState.DataSource = CompanyState_dt;
            DDLBillGenerationState.DataBind();

            var CustomerState_dt = oGSTMasterController.Get_SupplementaryBill_Customer_State_Details(oBillGenerationGST_Entity);
            DDLBillSubmissionState.DataSource = CustomerState_dt;
            DDLBillSubmissionState.DataBind();

            DDLBillCollectionState.DataSource = CustomerState_dt;
            DDLBillCollectionState.DataBind();

            if (dt.Tables.Count > 0)
            {
                if (dt.Tables[0].Rows.Count > 0)
                {
                    lblCustomerName.Text = dt.Tables[0].Rows[0]["Custcd"].ToString() + " : " + dt.Tables[0].Rows[0]["custnm"].ToString();
                    hidCustomerID.Value = dt.Tables[0].Rows[0]["Custcd"].ToString();
                    lblBillingAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["Address_Bill"]);
                    //hdnBillGenerationState.Value = Convert.ToString(dt.Tables[0].Rows[0]["GenStcd"]);
                    //txtBillGenerationState.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenLocState"]);
                    //hdnBillGenerationCity.Value = Convert.ToString(dt.Tables[0].Rows[0]["GenLocCode"]);
                    //txtBillGenerationCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenLocCity"]);
                    hdnBillGenerationLocation.Value = SessionUtilities.CurrentBranchCode; //Convert.ToString(dt.Tables[0].Rows[0]["GenLocCode"]);
                    txtBillGenerationLocation.Text = SessionUtilities.CurrentBranchCode; //Convert.ToString(dt.Tables[0].Rows[0]["GenLocCode"]);
                    //hdnBillSubmissionState.Value = Convert.ToString(dt.Tables[0].Rows[0]["SubStcd"]);
                    //txtBillSubmissionState.Text = Convert.ToString(dt.Tables[0].Rows[0]["SubLocState"]);
                    //hdnBillSubmissionCity.Value = Convert.ToString(dt.Tables[0].Rows[0]["SubLocCode"]);
                    //txtBillSubmissionCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["SubLocCity"]);
                    hdnBillSubmissionLocation.Value = SessionUtilities.CurrentBranchCode; //Convert.ToString(dt.Tables[0].Rows[0]["SubLocCode"]);
                    txtBillSubmissionLocation.Text = SessionUtilities.CurrentBranchCode; //Convert.ToString(dt.Tables[0].Rows[0]["SubLocCode"]);
                    //hdnBillCollectionState.Value = Convert.ToString(dt.Tables[0].Rows[0]["ColStcd"]);
                    //txtBillCollectionState.Text = Convert.ToString(dt.Tables[0].Rows[0]["ColLocState"]);
                    //hdnBillCollectionCity.Value = Convert.ToString(dt.Tables[0].Rows[0]["ColLocCode"]);
                    //txtBillCollectionCity.Text = Convert.ToString(dt.Tables[0].Rows[0]["ColLocCity"]);
                    hdnBillCollectionLocation.Value = SessionUtilities.CurrentBranchCode; //Convert.ToString(dt.Tables[0].Rows[0]["ColLocCode"]);
                    txtBillCollectionLocation.Text = SessionUtilities.CurrentBranchCode; //Convert.ToString(dt.Tables[0].Rows[0]["ColLocCode"]);
                    lblInterState.Text = Convert.ToString(dt.Tables[0].Rows[0]["InterState"]);
                    hdnInterState.Value = Convert.ToString(dt.Tables[0].Rows[0]["InterState"]);
                    //lblCustomerGSTIN.Text = Convert.ToString(dt.Tables[0].Rows[0]["CustomerGSTINNumber"]);
                    //lblTransporterGSTIN.Text = Convert.ToString(dt.Tables[0].Rows[0]["TransporterGSTINNumber"]);
                    hidCreditDays.Value = Convert.ToString(dt.Tables[0].Rows[0]["credit_day"]);

                    if (dt.Tables[1].Rows.Count > 0)
                    {
                        hidMaxDate.Value = Convert.ToString(dt.Tables[1].Rows[0]["GSTMaxDate"]);
                        hdnPastDate.Value = Convert.ToString(dt.Tables[1].Rows[0]["GSTMaxDate"]);
                        for (int i = 0; i < dt.Tables[1].Rows.Count; i++)
                        {
                            if (Convert.ToString(dt.Tables[1].Rows[i]["RULEID"]) == "GST_Gen_BL_Inv_Dt_Edit")
                                hidInvoiceDateEditable.Value = Convert.ToString(dt.Tables[1].Rows[i]["RULE_Y_N"]);
                            if (Convert.ToString(dt.Tables[1].Rows[i]["RULEID"]) == "GST_Gen_BL_Inv_Dt_Back_Days")
                            {
                                hidInvoiceDateBackDaysYN.Value = Convert.ToString(dt.Tables[1].Rows[i]["RULE_Y_N"]);
                                hidInvoiceDateBackDays.Value = Convert.ToString(dt.Tables[1].Rows[i]["RULE_VALUE"]);
                            }
                            if (Convert.ToString(dt.Tables[1].Rows[i]["RULEID"]) == "GST_Gen_BL_Due_Dt")
                                hidDueDateEditable.Value = Convert.ToString(dt.Tables[1].Rows[i]["RULE_Y_N"]);
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

                }
                else
                {
                    msgBox.Show("No Data Found..Please verify Company/Customer GST master Mappings.");
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
        if (String.IsNullOrEmpty((string)lblCustomerName.Text.Trim())) { IsValid = false; msg = "Customer Name not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblInvoiceNumber.Text.Trim())) { IsValid = false; msg = "Invoice Number not found !"; return; }
        if (String.IsNullOrEmpty((string)lblBillingAddress.Text.Trim())) { IsValid = false; msg = "Billing Address not found !"; return; }
        if (String.IsNullOrEmpty((string)txtGenerationDate.Text.Trim())) { IsValid = false; msg = "Generation Date not found !"; return; }
        if (String.IsNullOrEmpty((string)txtDueDate.Text.Trim())) { IsValid = false; msg = "Due Date not found !"; return; }
        if (String.IsNullOrEmpty((string)DDLBillGenerationState.SelectedValue.Trim())) { IsValid = false; msg = "BillGeneration State not found !"; return; }
        if (String.IsNullOrEmpty((string)LblBillGenerationCity.Text.Trim())) { IsValid = false; msg = "Bill Generation City not found !"; return; }
        if (String.IsNullOrEmpty((string)LblBillGenerationGSTIN.Text.Trim())) { IsValid = false; msg = "Bill Generation GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)txtBillGenerationLocation.Text.Trim())) { IsValid = false; msg = "Bill Generation Location not found !"; return; }
        if (String.IsNullOrEmpty((string)DDLBillSubmissionState.SelectedValue.Trim())) { IsValid = false; msg = "Bill Submission State not found !"; return; }
        if (String.IsNullOrEmpty((string)LblBillSubmissionCity.Text.Trim())) { IsValid = false; msg = "Bill Submission City not found !"; return; }
        if (String.IsNullOrEmpty((string)LblBillSubmissionGSTIN.Text.Trim())) { IsValid = false; msg = "Bill Submission GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)txtBillSubmissionLocation.Text.Trim())) { IsValid = false; msg = "Bill Submission Location not found !"; return; }
        if (String.IsNullOrEmpty((string)DDLBillCollectionState.SelectedValue.Trim())) { IsValid = false; msg = "Bill Collection State not found !"; return; }
        if (String.IsNullOrEmpty((string)LblBillCollectionCity.Text.Trim())) { IsValid = false; msg = "Bill Collection City not found !"; return; }
        if (String.IsNullOrEmpty((string)LblBillCollectionGSTIN.Text.Trim())) { IsValid = false; msg = "Bill Collection GSTIN not found !"; return; }
        if (String.IsNullOrEmpty((string)txtBillCollectionLocation.Text.Trim())) { IsValid = false; msg = "Bill Collection Location not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblServiceType.Text.Trim())) { IsValid = false; msg = "Service Type not found !"; return; }
        if (String.IsNullOrEmpty((string)lblInterState.Text.Trim())) { IsValid = false; msg = "Inter State not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblSACCategory.Text.Trim())) { IsValid = false; msg = "SAC Category not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblGSTRate.Text.Trim())) { IsValid = false; msg = "GST Rate not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblITC.Text.Trim())) { IsValid = false; msg = "ITC not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblCustomerGSTIN.Text.Trim())) { IsValid = false; msg = "Customer GSTIN not found !"; return; }
        //if (String.IsNullOrEmpty((string)lblTransporterGSTIN.Text.Trim())) { IsValid = false; msg = "Transporter GSTIN not found !"; return; }
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
            ViewData.Rows.Add("", "", "", "","", "0.00", "0.00", "0.00", "0.00");
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
            { ddlSACCode.SelectedValue = DataBinder.Eval(e.Row.DataItem, "SACCode").ToString();} catch {}
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
        var objBillGen = new BillGenerationGST();
        dtTransactionType = objBillGen.GetSupplementaryBill_GetSACCategory();
    }

    protected void DDLBillGenerationState_SelectedIndexChanged(object sender, EventArgs e)
    {
        var oGSTMasterController = new BillGenerationGST();

        var CompanyCity_dt = oGSTMasterController.Get_SupplementaryBill_Company_City_Details(DDLBillGenerationState.SelectedValue.ToString());
        if (CompanyCity_dt.Rows.Count > 0)
        {
            LblBillGenerationCity.Text = CompanyCity_dt.Rows[0]["Name"].ToString();
            hdnBillGenerationCity.Value = CompanyCity_dt.Rows[0]["Code"].ToString();
            LblBillGenerationGSTIN.Text = CompanyCity_dt.Rows[0]["GSTINNumber"].ToString();
            hdnBillGenerationStateType.Value = CompanyCity_dt.Rows[0]["StateType"].ToString();

            if (DDLBillGenerationState.SelectedValue.ToString() == DDLBillSubmissionState.SelectedValue.ToString())
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
            LblBillGenerationCity.Text = "";
            hdnBillGenerationCity.Value = "";
            LblBillGenerationGSTIN.Text = "";
            hdnBillGenerationStateType.Value = "";
            lblInterState.Text = "No";
            hdnInterState.Value = "No";
        }
        loaddata();
    }
    protected void DDLBillSubmissionState_SelectedIndexChanged(object sender, EventArgs e)
    {
        var oGSTMasterController = new BillGenerationGST();

        var CustomerCity_dt = oGSTMasterController.Get_SupplementaryBill_Customer_City_Details(HdnCustomerCode.Value, DDLBillSubmissionState.SelectedValue.ToString());
        if (CustomerCity_dt.Rows.Count > 0)
        {
            LblBillSubmissionCity.Text = CustomerCity_dt.Rows[0]["Name"].ToString();
            hdnBillSubmissionCity.Value = CustomerCity_dt.Rows[0]["Code"].ToString();
            LblBillSubmissionGSTIN.Text = CustomerCity_dt.Rows[0]["GSTINNumber"].ToString();
            hdnBillSubmissionStateType.Value = CustomerCity_dt.Rows[0]["StateType"].ToString();
            lblBillingAddress.Text = CustomerCity_dt.Rows[0]["Address_Bill"].ToString();

            if (DDLBillGenerationState.SelectedValue.ToString() == DDLBillSubmissionState.SelectedValue.ToString())
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
            LblBillSubmissionCity.Text = "";
            hdnBillSubmissionCity.Value = "";
            LblBillSubmissionGSTIN.Text = "";
            lblInterState.Text = "No";
            hdnInterState.Value = "No";
            hdnBillSubmissionStateType.Value = "";
        }

        loaddata();
    }
    protected void DDLBillCollectionState_SelectedIndexChanged(object sender, EventArgs e)
    {
        var oGSTMasterController = new BillGenerationGST();

        var CustomerCity_dt = oGSTMasterController.Get_SupplementaryBill_Customer_City_Details(HdnCustomerCode.Value, DDLBillCollectionState.SelectedValue.ToString());
        if (CustomerCity_dt.Rows.Count > 0)
        {
            LblBillCollectionCity.Text = CustomerCity_dt.Rows[0]["Name"].ToString();
            hdnBillCollectionCity.Value = CustomerCity_dt.Rows[0]["Code"].ToString();
            LblBillCollectionGSTIN.Text = CustomerCity_dt.Rows[0]["GSTINNumber"].ToString();
            hdnBillCollectionStateType.Value = CustomerCity_dt.Rows[0]["StateType"].ToString();
        }
        else
        {
            LblBillCollectionCity.Text = "";
            hdnBillCollectionCity.Value = "";
            LblBillCollectionGSTIN.Text = "";
            hdnBillCollectionStateType.Value = "";
        }
    }

    protected void loaddata()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "myscript" + DateTime.Now.Ticks, "calculate_GST();", true);
    }

    [WebMethod]
    public static string GetGstRate_FromServiceType(string strServiceType)
    {
        try
        {
            var tm = new BillGenerationGST_GstRate();
            var objBill = new BillGenerationGST();
            //var dtResult = objBill.GetGstRate_FromServiceType(strServiceType);
            var dtResult = objBill.GetGstRate_FromSACCode(strServiceType);

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
            var tv = new BillGenerationGST_StateValidation();
            var objBill = new BillGenerationGST();
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
    public static string ValidateCity(string strCityName,string strStateCode)
    {
        try
        {
            var tv = new BillGenerationGST_CityValidation();
            var objBill = new BillGenerationGST();
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
            var tv = new BillGenerationGST_AccCodeValidation();
            var objBill = new BillGenerationGST();
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
    public static string GetLedgerDetails(double grandtotal,double gsttotal,string customercode,string interstateyesno,string billingtype, string utState, string utStateSame)
    {
        try
        {
            var objHeader = new BillGenerationGST_LedgerDetails();
            var objBill = new BillGenerationGST();

            var dtResult = objBill.GetGeneralBillLedgerDetails(grandtotal, gsttotal, customercode, interstateyesno, billingtype, utState, utStateSame);

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

}
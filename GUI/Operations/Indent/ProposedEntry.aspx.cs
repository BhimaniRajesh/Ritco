using System;
using System.Collections.Generic;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.Services;
using System.Web.UI.WebControls;

/// <summary>
/// Create By :- Bipin Rupavatiya On 24 Aug 2015
/// Purpose :- Proposed Entry
/// </summary>
public partial class GUI_Operations_Indent_ProposedEntry : BasePage
{
    #region Public Object[s] And Variable[s]
    string ProposedIndentNumber = "";
    #endregion
    #region Page Load Event
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            DateTime stNow = DateTime.Now;
            if (Request.QueryString["Type"] == "P")
            {
                
                BindGrid();
                divIndentFinalization.Visible = false;
                lblDate.Text = stNow.ToString("dd MMM yyyy HH:MM");
                lblBranch.Text = SessionUtilities.CurrentBranchCode;
            }
            else
            {
                divProposedEntry.Visible = false;
                divIndentFinalizationSelect.Visible = true;
                divIndentFinalization.Visible = false;
                lblFDate.Text = stNow.ToString("dd MMM yyyy HH:MM");
                lblFIssuingBranch.Text = SessionUtilities.CurrentBranchCode;
            }
        }
        msgBox.Hide();
    }
    #endregion
    #region Click Events[s]
    /// <summary>
    /// Get DataTable for Bind Repeater
    /// </summary>
    /// <returns></returns>
    public DataTable GetDataTable()
    {
        var dt = new DataTable();
        WebxUtils.AddColumntoDatatable(dt, "DocketNumber", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "Location", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "DeliveryPartyName", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "BillingPartyName", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "MobileNumber", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "Remarks", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPPackates", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPPPackates", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPPackatess", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnHHPackates", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPDelPackates", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPMaterial", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPFromCity", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPToCity", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPBookingStation", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPCustomerRefrence", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPConsignor", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPConsignee", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPWeight", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnPDeliveryLocation", "System.String");
        WebxUtils.AddColumntoDatatable(dt, "hdnIsSystemDocket", "System.String");
        return dt;
    }
    /// <summary>
    /// Get Control Value in Repeater
    /// </summary>
    /// <returns></returns>
    private DataTable ReverseBind()
    {
        var dt = GetDataTable();
        foreach (RepeaterItem rptItem in rptProposed.Items)
        {
            TextBox txtDocketNumber = (TextBox)rptItem.FindControl("txtDocketNumber");
            TextBox txtLocation = (TextBox)rptItem.FindControl("txtLocation");
            TextBox txtDeliveryPartyName = (TextBox)rptItem.FindControl("txtDeliveryPartyName");
            TextBox txtBillingPartyName = (TextBox)rptItem.FindControl("txtBillingPartyName");
            TextBox txtMobileNumber = (TextBox)rptItem.FindControl("txtMobileNumber");
            TextBox txtRemarks = (TextBox)rptItem.FindControl("txtRemarks");
            HiddenField hdnPPackates = (HiddenField)rptItem.FindControl("hdnPPackates");
            HiddenField hdnPPPackates = (HiddenField)rptItem.FindControl("hdnPPPackates");
            HiddenField hdnPPackatess = (HiddenField)rptItem.FindControl("hdnPPackatess");
            HiddenField hdnHHPackates = (HiddenField)rptItem.FindControl("hdnHHPackates");
            HiddenField hdnPDelPackates = (HiddenField)rptItem.FindControl("hdnPDelPackates");
            HiddenField hdnPMaterial = (HiddenField)rptItem.FindControl("hdnPMaterial");
            HiddenField hdnPFromCity = (HiddenField)rptItem.FindControl("hdnPFromCity");
            HiddenField hdnPToCity = (HiddenField)rptItem.FindControl("hdnPToCity");
            HiddenField hdnPBookingStation = (HiddenField)rptItem.FindControl("hdnPBookingStation");
            HiddenField hdnPCustomerRefrence = (HiddenField)rptItem.FindControl("hdnPCustomerRefrence");
            HiddenField hdnPConsignor = (HiddenField)rptItem.FindControl("hdnPConsignor");
            HiddenField hdnPConsignee = (HiddenField)rptItem.FindControl("hdnPConsignee");
            HiddenField hdnPWeight = (HiddenField)rptItem.FindControl("hdnPWeight");
            HiddenField hdnPDeliveryLocation = (HiddenField)rptItem.FindControl("hdnPDeliveryLocation");
            HiddenField hdnIsSystemDocket = (HiddenField)rptItem.FindControl("hdnIsSystemDocket");
            dt.Rows.Add(txtDocketNumber.Text, txtLocation.Text, txtDeliveryPartyName.Text, txtBillingPartyName.Text, txtMobileNumber.Text, txtRemarks.Text, hdnPPackates.Value,
                hdnPPPackates.Value, hdnPPackatess.Value, hdnHHPackates.Value, hdnPDelPackates.Value, hdnPMaterial.Value, hdnPFromCity.Value,
                hdnPToCity.Value, hdnPBookingStation.Value, hdnPCustomerRefrence.Value, hdnPConsignor.Value, hdnPConsignee.Value, hdnPWeight.Value,
                hdnPDeliveryLocation.Value, hdnIsSystemDocket.Value);
        }
        return dt;
    }
    /// <summary>
    /// Add New Row in Repeater
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void txtRemarks_TextChanged(object sender, EventArgs e)
    {
        try
        {
            btnSubmit.Attributes.Add("onclick", "javascript:Validation();");
            btnIndentFinaliaztion.Attributes.Add("onclick", "javascript:ValidationWithFinalization();");
            if (hdnClickCount.Value == "0")
            {
                var dt = ReverseBind();
                int rows = 1;
            var index = dt.Rows.Count - 1;
                for (int i = 0; i < rows; i++)
                {
                dt.Rows.Add("", dt.Rows[index][1], dt.Rows[index][2], dt.Rows[index][3], dt.Rows[index][4], dt.Rows[index][5], "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                }
                rptProposed.DataSource = dt;
                rptProposed.DataBind();
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.Message);
        }
    }
    /// <summary>
    /// Bind First Row
    /// </summary>
    public void BindGrid()
    {
        var dt = ReverseBind();
        int rows = 1;
        for (int i = 0; i < rows; i++)
        {
            dt.Rows.Add("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        }
        rptProposed.DataSource = dt;
        rptProposed.DataBind();
    }

    /// <summary>
    /// Row Data Bound
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rptProposed_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                TextBox txtDocketNumber = (e.Item.FindControl("txtDocketNumber") as TextBox);
                txtDocketNumber.Attributes.Add("onblur", "javascript:CheckDuplication(" + (e.Item.ItemIndex) + ",this);");
                txtDocketNumber.Focus();
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.Message);
        }
    }
    protected void rptProposed_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Delete")
            {
                var listDetails = ReverseBind();
                int id = Convert.ToInt32(e.CommandArgument);
                if (rptProposed.Items.Count > 1)
                {
                    listDetails.Rows.RemoveAt(id);
                }
                rptProposed.DataSource = listDetails;
                rptProposed.DataBind();
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.Message);
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
            if (IsTokenValid())
            {
                var objIndentController = new IndentController();
                Indent objIndent = new Indent();
                objIndent.ProposedIndentNumber = Convert.ToString(objIndentController.GetProposedNumber("PIE"));
                objIndent.IssuingBranch = lblBranch.Text;
                objIndent.Warehouse = txtWarehouse.Text;
                objIndent.IndentDate = Convert.ToDateTime(lblDate.Text);
                objIndent.Finalized = "N";
                objIndent.FinalizedDate = Convert.ToDateTime(lblDate.Text);
                objIndent.EntryBy = SessionUtilities.CurrentEmployeeID;
                var listDetails = new List<Indent>();
                foreach (RepeaterItem rptItem in rptProposed.Items)
                {
                    Indent obj_Indent = new Indent();
                    TextBox txtDocketNumber = (TextBox)rptItem.FindControl("txtDocketNumber");
                    TextBox txtLocation = (TextBox)rptItem.FindControl("txtLocation");
                    TextBox txtDeliveryPartyName = (TextBox)rptItem.FindControl("txtDeliveryPartyName");
                    TextBox txtBillingPartyName = (TextBox)rptItem.FindControl("txtBillingPartyName");
                    TextBox txtMobileNumber = (TextBox)rptItem.FindControl("txtMobileNumber");
                    TextBox txtRemarks = (TextBox)rptItem.FindControl("txtRemarks");
                    HiddenField hdnIsSystemDocket = (HiddenField)rptItem.FindControl("hdnIsSystemDocket");
                    HiddenField hdnPPackates = (HiddenField)rptItem.FindControl("hdnPPackates");
                    HiddenField hdnPMaterial = (HiddenField)rptItem.FindControl("hdnPMaterial");
                    HiddenField hdnPFromCity = (HiddenField)rptItem.FindControl("hdnPFromCity");
                    HiddenField hdnPToCity = (HiddenField)rptItem.FindControl("hdnPToCity");
                    HiddenField hdnPBookingStation = (HiddenField)rptItem.FindControl("hdnPBookingStation");
                    HiddenField hdnPCustomerRefrence = (HiddenField)rptItem.FindControl("hdnPCustomerRefrence");
                    HiddenField hdnPConsignor = (HiddenField)rptItem.FindControl("hdnPConsignor");
                    HiddenField hdnPConsignee = (HiddenField)rptItem.FindControl("hdnPConsignee");
                    HiddenField hdnPWeight = (HiddenField)rptItem.FindControl("hdnPWeight");
                    HiddenField hdnPDeliveryLocation = (HiddenField)rptItem.FindControl("hdnPDeliveryLocation");
                    obj_Indent.DocketNumber = txtDocketNumber.Text;
                    obj_Indent.Location = txtLocation.Text;
                    obj_Indent.DeliveryPartyName = txtDeliveryPartyName.Text;
                    obj_Indent.BillingPartyName = txtBillingPartyName.Text;
                    obj_Indent.MobileNumber = txtMobileNumber.Text;
                    obj_Indent.Remarks = txtRemarks.Text;
                    obj_Indent.IsSystemDocket = hdnIsSystemDocket.Value;
                    obj_Indent.PendingPackages = Convert.ToInt32(hdnPPackates.Value);
                    obj_Indent.Material = hdnPMaterial.Value;
                    obj_Indent.FromCity = hdnPFromCity.Value;
                    obj_Indent.ToCity = hdnPToCity.Value;
                    obj_Indent.BookingDeatination = hdnPBookingStation.Value;
                    obj_Indent.CustomerRefrence = hdnPCustomerRefrence.Value;
                    obj_Indent.Consignor = hdnPConsignor.Value;
                    obj_Indent.Consignee = hdnPConsignee.Value;
                    obj_Indent.Weight = hdnPWeight.Value;
                    obj_Indent.DeliveryLocation = hdnPDeliveryLocation.Value;
                    obj_Indent.DeliveredPackages = 0;
                    obj_Indent.TotalPackages = Convert.ToInt32(hdnPPackates.Value);
                    listDetails.Add(obj_Indent);
                }
                objIndent.Details = listDetails;
                objIndentController.InsertIndent(objIndent);
                ConsumeToken();
                Response.Redirect("ProposedIndentDone.aspx?IndentNo=&ProposedIndentNo=" + objIndent.ProposedIndentNumber + "&Type=P", false);

            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.ToString());
            return;
        }
    }
    /// <summary>
    /// Search Indent Finalization
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnIndentSearch_Click(object sender, EventArgs e)
    {
        try
        {

            if (IsTokenValid())
            {
                DataTable dtSearch = new DataTable();
                var objIndentController = new IndentController();
                divProposedEntry.Visible = false;
                dtSearch = objIndentController.GetHeaderDetailsProposedIndentNumber(txtIndentNumber.Text);
                if (dtSearch != null && dtSearch.Rows.Count > 0)
                {
                    lblFIssuingBranch.Text = dtSearch.Rows[0]["Location"].ToString();
                    lblFWarehouse.Text = dtSearch.Rows[0]["Warehouse"].ToString();
                    lblFDate.Text = Convert.ToString(dtSearch.Rows[0]["IndentDate"]);
                    lblFProposedIndentNumber.Text = dtSearch.Rows[0]["ProposedIndentNumber"].ToString();
                    divIndentFinalization.Visible = true;
                    divIndentFinalizationSelect.Visible = false;
                }
                rptIndentFinalization.DataSource = dtSearch;
                rptIndentFinalization.DataBind();
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.ToString());
            return;
        }
    }
    /// <summary>
    /// Indent Finalization
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnIndentFinaliaztion_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {
                var objIndentController = new IndentController();
                divProposedEntry.Visible = false;
                divIndentFinalization.Visible = true;
                divIndentFinalizationSelect.Visible = false;
                lblFIssuingBranch.Text = lblBranch.Text;
                lblFWarehouse.Text = txtWarehouse.Text;
                lblFDate.Text = lblDate.Text;
                lblFProposedIndentNumber.Text = Convert.ToString(objIndentController.GetProposedNumber("PIE"));
                rptIndentFinalization.DataSource = ReverseBind();
                rptIndentFinalization.DataBind();
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.ToString());
            return;
        }
    }
    /// <summary>
    /// Indent Finalization Submit
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnIndentFinaliaztionSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {
                divProposedEntry.Visible = false;
                var objIndentController = new IndentController();
                Indent objIndent = new Indent();
                objIndent.ProposedIndentNumber = lblFProposedIndentNumber.Text;
                objIndent.IndentNumber = Convert.ToString(objIndentController.GetProposedNumber("Indent"));
                objIndent.IssuingBranch = lblFIssuingBranch.Text;
                objIndent.Warehouse = lblFWarehouse.Text;
                objIndent.IndentDate = Convert.ToDateTime(lblFDate.Text);
                objIndent.FinalizedDate = Convert.ToDateTime(lblFDate.Text);
                objIndent.Finalized = "Y";
                objIndent.FinalizedBy = SessionUtilities.CurrentEmployeeID;
                objIndent.EntryBy = SessionUtilities.CurrentEmployeeID;
                var listDetails = new List<Indent>();
                foreach (RepeaterItem rptItem in rptIndentFinalization.Items)
                {
                    Indent obj_Indent = new Indent();
                    TextBox txtFDocketNumber = (TextBox)rptItem.FindControl("txtFDocketNumber");
                    TextBox txtFLocation = (TextBox)rptItem.FindControl("txtFLocation");
                    TextBox txtFDeliveryPartyName = (TextBox)rptItem.FindControl("txtFDeliveryPartyName");
                    TextBox txtFBillingPartyName = (TextBox)rptItem.FindControl("txtFBillingPartyName");
                    TextBox txtFMobileNumber = (TextBox)rptItem.FindControl("txtFMobileNumber");
                    TextBox txtFRemarks = (TextBox)rptItem.FindControl("txtFRemarks");
                    TextBox txtFPackates = (TextBox)rptItem.FindControl("txtFPackates");
                    HiddenField hdnHHPackates = (HiddenField)rptItem.FindControl("hdnHHPackates");
                    HiddenField hdnFDelPackates = (HiddenField)rptItem.FindControl("hdnFDelPackates");
                    Label lblFMaterial = (Label)rptItem.FindControl("lblFMaterial");
                    Label lblFFromCity = (Label)rptItem.FindControl("lblFFromCity");
                    Label lblFToCity = (Label)rptItem.FindControl("lblFToCity");
                    Label lblFBookingStation = (Label)rptItem.FindControl("lblFBookingStation");
                    Label lblFCustomerRefrence = (Label)rptItem.FindControl("lblFCustomerRefrence");
                    Label lblFConsignor = (Label)rptItem.FindControl("lblFConsignor");
                    Label lblFConsignee = (Label)rptItem.FindControl("lblFConsignee");
                    Label lblFWeight = (Label)rptItem.FindControl("lblFWeight");
                    Label lblFDeliveryLocation = (Label)rptItem.FindControl("lblFDeliveryLocation");
                    HiddenField hdnFIsSystemDocket = (HiddenField)rptItem.FindControl("hdnFIsSystemDocket");
                    obj_Indent.DocketNumber = txtFDocketNumber.Text;
                    obj_Indent.Location = txtFLocation.Text;
                    obj_Indent.DeliveryPartyName = txtFDeliveryPartyName.Text;
                    obj_Indent.BillingPartyName = txtFBillingPartyName.Text;
                    obj_Indent.MobileNumber = txtFMobileNumber.Text;
                    obj_Indent.Remarks = txtFRemarks.Text;
                    obj_Indent.Packages = Convert.ToInt32(txtFPackates.Text);
                    obj_Indent.Material = lblFMaterial.Text;
                    obj_Indent.FromCity = lblFFromCity.Text;
                    obj_Indent.ToCity = lblFToCity.Text;
                    obj_Indent.CustomerRefrence = lblFCustomerRefrence.Text;
                    obj_Indent.BookingDeatination = lblFBookingStation.Text;
                    obj_Indent.Consignor = lblFConsignor.Text;
                    obj_Indent.Consignee = lblFConsignee.Text;
                    obj_Indent.Weight = lblFWeight.Text;
                    obj_Indent.DeliveryLocation = lblFDeliveryLocation.Text;
                    obj_Indent.IsSystemDocket = hdnFIsSystemDocket.Value;
                    if (hdnFIsSystemDocket.Value == "Y")
                    {
                        obj_Indent.PendingPackages = Convert.ToInt32(hdnHHPackates.Value) - Convert.ToInt32(txtFPackates.Text);
                        obj_Indent.DeliveredPackages = Convert.ToInt32(txtFPackates.Text);
                        obj_Indent.TotalPackages = Convert.ToInt32(hdnHHPackates.Value);
                    }
                    else
                    {
                        obj_Indent.PendingPackages = 0;
                        obj_Indent.DeliveredPackages = Convert.ToInt32(txtFPackates.Text);
                        obj_Indent.TotalPackages = Convert.ToInt32(txtFPackates.Text);
                    }
                    listDetails.Add(obj_Indent);
                }
                objIndent.Details = listDetails;
                objIndentController.InsertIndent(objIndent);
                ConsumeToken();
                Response.Redirect("ProposedIndentDone.aspx?IndentNo=" + objIndent.IndentNumber + "&ProposedIndentNo=" + objIndent.ProposedIndentNumber + "&Type=I", false);
            }
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.ToString());
            return;
        }
    }
    #endregion
    #region Methods[s]

    /// <summary>
    /// Check Docket Number
    /// </summary>
    /// <param name="strDocket"></param>
    /// <returns></returns>
    [WebMethod]
    public static string CheckDocketNumber(string stDocket)
    {
        var objIndentController = new IndentController();
        var dtResult = new DataTable();
        dtResult = objIndentController.CheckDocketNumber(stDocket);
        return jsonUtility.DataTableToJSON(dtResult);
    }
    /// <summary>
    /// Check Proposed Indent Number
    /// </summary>
    /// <param name="stProposedIndentNumber"></param>
    /// <returns></returns>
    [WebMethod]
    public static string CheckValidProposedIndentNumber(string stProposedIndentNumber)
    {
        var objIndentController = new IndentController();
        var dtResult = new DataTable();
        dtResult = objIndentController.CheckValidProposedIndentNumber(stProposedIndentNumber);
        return jsonUtility.DataTableToJSON(dtResult);
    }
    /// <summary>
    /// Search Proposed Indent Number
    /// </summary>
    /// <param name="stProposedIndentNumber"></param>
    /// <returns></returns>
    [WebMethod]
    public static string SearchProposedIndentNumber(string stProposedIndentNumber)
    {
        var objIndentController = new IndentController();
        var dtResult = new DataTable();
        dtResult = objIndentController.SearchProposedIndentNumber(stProposedIndentNumber);
        return jsonUtility.DataTableToJSON(dtResult);
    }
    /// <summary>
    /// Check Docket Number With Proposed Indent Number
    /// </summary>
    /// <param name="strDocket"></param>
    /// <param name="stPIndent"></param>
    /// <returns></returns>
    [WebMethod]
    public static string CheckDocketNumberWithPIndent(string stDocket, string stPIndent)
    {
        var objIndentController = new IndentController();
        var dtResult = new DataTable();
        dtResult = objIndentController.CheckDocketNumberWithPIndent(stDocket, stPIndent);
        return jsonUtility.DataTableToJSON(dtResult);
    }
    #endregion
}
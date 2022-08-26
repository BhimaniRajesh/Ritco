using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_HCLBillGeneration : BasePage
{
    public DataSet  ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();

        if (!IsPostBack)
        {
            try
            {
                CreateToken();
                var oHCLMasterController = new HCLMasterController();
                ds = oHCLMasterController.GetRateType();

                
                ddlOTHCRateType.DataSource = ds;
                ddlOTHCRateType.DataTextField = "CodeDesc";
                ddlOTHCRateType.DataValueField ="CodeId";
                ddlOTHCRateType.DataBind();

                ddlITHCRateType.DataSource = ds;
                ddlITHCRateType.DataTextField = "CodeDesc";
                ddlITHCRateType.DataValueField ="CodeId";
                ddlITHCRateType.DataBind();

                ddlDDMRRateType.DataSource = ds;
                ddlDDMRRateType.DataTextField = "CodeDesc";
                ddlDDMRRateType.DataValueField ="CodeId";
                ddlDDMRRateType.DataBind();

                ddlMRRateType.DataSource = ds;
                ddlMRRateType.DataTextField = "CodeDesc";
                ddlMRRateType.DataValueField ="CodeId";
                ddlMRRateType.DataBind();


                var dt = new DataTable();
                var FromDate = Convert.ToString(Request.QueryString["Fromdt"]);
                var ToDate = Convert.ToString(Request.QueryString["Todt"]);
                dt= oHCLMasterController.GetDocListForHCLBilling(FromDate, ToDate);

                if (dt.Rows.Count > 0)
                {
                    Repeater2.DataSource = dt;
                    Repeater2.DataBind();
                }
                else
                {
                    UserMessage.Show("No Records Found !");
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
        }
    }
    //public DataTable BindRepeater()
    //{
    //    var dt = new System.Data.DataTable("DocumentData");
    //    // create fields
    //    dt.Columns.Add("DocumentName", typeof(string));
    //    dt.Columns.Add("Type", typeof(string));
    //    dt.Columns.Add("Rate", typeof(string));

    //    // insert row values
    //    dt.Rows.Add(new Object[] { "Outgoing THC", "", "" });
    //    dt.Rows.Add(new Object[] { "Incoming THC", "", "" });
    //    dt.Rows.Add(new Object[] { "DDMR", "", "" });
    //    dt.Rows.Add(new Object[] { "MR", "", "" });
    //    return dt;
    //}
    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DropDownList ddlRateType = e.Item.FindControl("ddlDetRateType") as DropDownList;
            ddlRateType.DataSource = ds.Tables[0];
            ddlRateType.DataTextField = "CodeDesc";
            ddlRateType.DataValueField = "CodeId";
            ddlRateType.DataBind();
        }
    }

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (IsTokenValid())
    //        {
    //            var oHCLBillGenerationHeader = new HCLBillGenerationHeader();

    //            oHCLBillGenerationHeader.EntryBy = SessionUtilities.CurrentEmployeeID;
    //            oHCLBillGenerationHeader.CompanyCode = SessionUtilities.DefaultCompanyCode;
    //            oHCLBillGenerationHeader.FinYear = SessionUtilities.FinYear;
    //            oHCLBillGenerationHeader.VendorName = txtVendorName.Text;
    //            oHCLBillGenerationHeader.TotalAmount = Convert.ToDouble(Request.Form["txtTotAmount");
    //            oHCLBillGenerationHeader.RebateAmount = Convert.ToDouble(txtRebate.Text);
    //            oHCLBillGenerationHeader.NetAmount= Convert.ToDouble(txtNetAmount.Text);

    //            var HCLBillGenerationDetailList = new List<HCLBillGenerationDetail>();
    //            ConsumeToken();

    //            foreach (RepeaterItem ri in Repeater2.Items)
    //            {
    //                var oHCLBillGenerationDetail = new HCLBillGenerationDetail();
    //                CheckBox chkDoc = ri.FindControl("chkDoc") as CheckBox;
    //                Label lblDocNo = ri.FindControl("lblDocNo") as Label;
    //                DropDownList ddlDetRateType = ri.FindControl("ddlDetRateType") as DropDownList;
    //                TextBox txtDetRate = ri.FindControl("txtDetRate") as TextBox;
    //                TextBox txtAmount = ri.FindControl("txtAmount") as TextBox;
    //                TextBox txtRemarks = ri.FindControl("txtRemarks") as TextBox;
    //                HiddenField hdnIsEdited = ri.FindControl("hdnIsEdited") as HiddenField;

    //                if (chkDoc.Checked)
    //                {
    //                    oHCLBillGenerationDetail.DocumentNo = lblDocNo.Text;
    //                    oHCLBillGenerationDetail.RateType = ddlDDMRRateType.SelectedValue;
    //                    oHCLBillGenerationDetail.Rate = Convert.ToDouble(txtDetRate.Text);
    //                    oHCLBillGenerationDetail.Amount = Convert.ToDouble(txtAmount.Text);
    //                    oHCLBillGenerationDetail.Remarks = txtRemarks.Text;
    //                    oHCLBillGenerationDetail.Edited = hdnIsEdited.Value;
    //                    HCLBillGenerationDetailList.Add(oHCLBillGenerationDetail);
    //                }
    //            }
    //            oHCLBillGenerationHeader.BillDetails = HCLBillGenerationDetailList;

    //            var oHCLMasterController = new HCLMasterController();
    //            var BillNo = oHCLMasterController.HCLBillEntry(oHCLBillGenerationHeader);

    //            if (BillNo != "")
    //            {
    //                Response.Redirect("HCLBillGenerationDone.aspx?BillNo=" + BillNo, false);
    //            }
    //        }
    //    }
    //    catch (Exception Ex)
    //    {
    //        UserMessage.Show(Ex.Message);
    //        ExceptionUtility.LogException(Ex, "HCL Bill Generation submit button");
    //    }
    //}
}
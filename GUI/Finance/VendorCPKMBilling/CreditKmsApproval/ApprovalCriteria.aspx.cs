using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Serialization;

public partial class GUI_Finance_VendorCPKMBilling_CreditKmsApproval_ApprovalCriteria : System.Web.UI.Page
{
	double Totalmarks;
    VendorCPKMBillController objVendorCPKMBillController = new VendorCPKMBillController();
    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        if (!IsPostBack)
        {
			 Totalmarks = 0.0;
            var dt = new DataTable();
            dt = objVendorCPKMBillController.GetFleetCenterList();

            ddlFleetCenter.DataSource = dt;
            ddlFleetCenter.DataTextField = "LocName";
            ddlFleetCenter.DataValueField = "LocCode";
            ddlFleetCenter.DataBind();
			ddlFleetCenter.SelectedValue = SessionUtilities.CurrentBranchCode;
			
            tblCriteria.Attributes.Remove("disabled");
            tblCPKDTHead.Attributes.Add("style", "display:none");
            tblCPKDTDet.Attributes.Add("style", "display:none");
        }
    }
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string fromDate = RPT_Date.FromDate;
            string toDate = RPT_Date.ToDate;
            var objVendorCPKMBillController = new VendorCPKMBillController();
            var dtCPKMBill = new DataTable();
            dtCPKMBill = objVendorCPKMBillController.GetListForCreditKmsForApproval(fromDate, toDate, ddlFleetCenter.SelectedValue, txtVehicleNo.Text);
            if (dtCPKMBill.Rows.Count > 0)
            {

                gvCPKMDT.DataSource = dtCPKMBill;
                gvCPKMDT.DataBind();
                tblCriteria.Attributes.Add("disabled", "disabled");
                tblCPKDTHead.Attributes.Remove("style");
            }
            else
            {
                umsg.Show("No record found for selected criteria.!");
            }

        }
        catch (Exception ex)
        {

            ExceptionUtility.LogException(ex, "GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->btnSearch_OnClick"); ;
        }
    }


    protected void BtnStep2_Click(object sender, EventArgs e)
    {
        try
        {

            var objVendorCPKMBillController = new VendorCPKMBillController();
            var dsCPKMBill = new DataSet();
            string vehicleno = "";
            string TotalValue = "";
            string CreditKms = "";
            for (int i = 0; i <= gvCPKMDT.Rows.Count - 1; i++)
            {
                GridViewRow row = gvCPKMDT.Rows[i];
                RadioButton rdb = (RadioButton)row.FindControl("rbVehicle");

                if (rdb.Checked == true)
                {
                    Label lblvehicle = (Label)row.FindControl("lblVehicleNo");
                    Label lblTotalValue = (Label)row.FindControl("lblTotalValue");
                    Label lblCreditKms = (Label)row.FindControl("lblCreditKms");
                    vehicleno = lblvehicle.Text;
                    TotalValue = lblTotalValue.Text;
                    CreditKms = lblCreditKms.Text;
                    break;
                }

            }
            if (vehicleno == "")
            {
                umsg.Show("Please select one vehicle.!");
                return;
            }
            dsCPKMBill = objVendorCPKMBillController.GetListForCreditKmsVehicleTyreDetail(vehicleno, TotalValue, CreditKms);
            if (dsCPKMBill.Tables[0].Rows.Count > 0)
            {

                gvCPKDTdet.DataSource = dsCPKMBill.Tables[0];
                gvCPKDTdet.DataBind();
				ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "calculateGrandTotal();", true);
                
				gvTotal.DataSource = dsCPKMBill.Tables[1];
                gvTotal.DataBind();
                tblCriteria.Attributes.Add("disabled", "disabled");
                tblCPKDTHead.Attributes.Add("disabled", "disabled");
                tblCPKDTHead.Attributes.Remove("style");
                tblCPKDTDet.Attributes.Remove("style");
            }
            else
            {
                umsg.Show("No record found for selected vehicle.!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->BtnStep2_Click"); ;
        }
    }

    protected void BtnStep3_Click(object sender, EventArgs e)
    {
        try
        {
            tblCriteria.Attributes.Add("disabled", "disabled");
            tblCPKDTHead.Attributes.Add("disabled", "disabled");
            tblCPKDTDet.Attributes.Add("disabled", "disabled");
            tblCPKDTHead.Attributes.Remove("style");
            tblCPKDTDet.Attributes.Remove("style");
            var ocls_VendorCPKMBilling_Approval = new List<cls_VendorCPKMBilling_Approval>();
            for (int i = 0; i < gvCPKDTdet.Rows.Count; i++)
            {
                var obj = new cls_VendorCPKMBilling_Approval();
                obj.VehicleNo = ((Label)gvCPKDTdet.Rows[i].FindControl("lblVehicleNo")).Text;
                obj.TyreNo = ((Label)gvCPKDTdet.Rows[i].FindControl("lblTyreNo")).Text;
                obj.TyreID = ((HiddenField)gvCPKDTdet.Rows[i].FindControl("hdnTyreID")).Value;
                obj.Model = ((Label)gvCPKDTdet.Rows[i].FindControl("lblModel")).Text;
                obj.Pattern = ((Label)gvCPKDTdet.Rows[i].FindControl("lblPattern")).Text;
                obj.Size = ((Label)gvCPKDTdet.Rows[i].FindControl("lblSize")).Text;
                obj.TyreType = ((Label)gvCPKDTdet.Rows[i].FindControl("lblTyreType")).Text;
                obj.TyreMFG = ((Label)gvCPKDTdet.Rows[i].FindControl("lblTyreMFG")).Text;
                obj.FittmentDate = ((Label)gvCPKDTdet.Rows[i].FindControl("lblFittmentDate")).Text;
                obj.RemovalDate = ((Label)gvCPKDTdet.Rows[i].FindControl("lblRemovalDate")).Text;
                obj.Remarks = ((Label)gvCPKDTdet.Rows[i].FindControl("lblRemarks")).Text;
                obj.Value = ((TextBox)gvCPKDTdet.Rows[i].FindControl("txtValue")).Text;
                obj.VendorCode = ((HiddenField)gvCPKDTdet.Rows[i].FindControl("hdnDetailVendorCode")).Value;

                ocls_VendorCPKMBilling_Approval.Add(obj);
            }


            objVendorCPKMBillController.InsertCreditKmsVehicleTyreDetail(ocls_VendorCPKMBilling_Approval, "A");
            Response.Redirect("Done.aspx?Flag=A");
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->BtnStep3_Click"); ;
        }
    }
    public XmlElement Serialize(object transformObject)
    {
        XmlElement serializedElement = null;
        try
        {
            MemoryStream memStream = new MemoryStream();
            XmlSerializer serializer = new XmlSerializer(transformObject.GetType());
            serializer.Serialize(memStream, transformObject);
            memStream.Position = 0;
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(memStream);
            serializedElement = xmlDoc.DocumentElement;
        }
        catch (Exception SerializeException)
        {

        }
        return serializedElement;
    }
    protected void btnStep4_Click(object sender, EventArgs e)
    {
        try
        {
            tblCriteria.Attributes.Add("disabled", "disabled");
            tblCPKDTHead.Attributes.Add("disabled", "disabled");
            tblCPKDTDet.Attributes.Add("disabled", "disabled");
            tblCPKDTHead.Attributes.Remove("style");
            tblCPKDTDet.Attributes.Remove("style");
            var ocls_VendorCPKMBilling_Approval = new List<cls_VendorCPKMBilling_Approval>();
            for (int i = 0; i < gvCPKDTdet.Rows.Count; i++)
            {
                var obj = new cls_VendorCPKMBilling_Approval();
                obj.VehicleNo = ((Label)gvCPKDTdet.Rows[i].FindControl("lblVehicleNo")).Text;
                obj.TyreNo = ((Label)gvCPKDTdet.Rows[i].FindControl("lblTyreNo")).Text;
                obj.TyreID = ((HiddenField)gvCPKDTdet.Rows[i].FindControl("hdnTyreID")).Value;
                obj.Model = ((Label)gvCPKDTdet.Rows[i].FindControl("lblModel")).Text;
                obj.Pattern = ((Label)gvCPKDTdet.Rows[i].FindControl("lblPattern")).Text;
                obj.Size = ((Label)gvCPKDTdet.Rows[i].FindControl("lblSize")).Text;
                obj.TyreType = ((Label)gvCPKDTdet.Rows[i].FindControl("lblTyreType")).Text;
                obj.TyreMFG = ((Label)gvCPKDTdet.Rows[i].FindControl("lblTyreMFG")).Text;
                obj.FittmentDate = ((Label)gvCPKDTdet.Rows[i].FindControl("lblFittmentDate")).Text;
                obj.RemovalDate = ((Label)gvCPKDTdet.Rows[i].FindControl("lblRemovalDate")).Text;
                obj.Remarks = ((Label)gvCPKDTdet.Rows[i].FindControl("lblRemarks")).Text;
                obj.Value = ((TextBox)gvCPKDTdet.Rows[i].FindControl("txtValue")).Text;
                obj.VendorCode = ((HiddenField)gvCPKDTdet.Rows[i].FindControl("hdnDetailVendorCode")).Value;

                ocls_VendorCPKMBilling_Approval.Add(obj);
            }


            objVendorCPKMBillController.InsertCreditKmsVehicleTyreDetail(ocls_VendorCPKMBilling_Approval, "R");
            Response.Redirect("Done.aspx?Flag=R");
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->BtnStep3_Click"); ;
        }
    }
	 protected void gvCPKDTdet_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
			TextBox lblhr = (TextBox)e.Row.FindControl("txtValue");
            Totalmarks += Convert.ToDouble(lblhr.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotal = (Label)e.Row.FindControl("lblValueTotal");
            lblTotal.Text = Convert.ToString(Totalmarks);
        }
    }
}

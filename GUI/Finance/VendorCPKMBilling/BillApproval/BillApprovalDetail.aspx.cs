using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Entity;

public partial class GUI_Finance_VendorCPKMBilling_BillApproval_BillApprovalDetail : BasePage
{
    public double totalMiscAmount = 0.0;
    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        if (!IsPostBack)
        {
			CreateToken();
            if (Request.QueryString["BillNo"] != null)
            {
                BindGrid(Convert.ToString(Request.QueryString["BillNo"]));
            }
        }
    }

    public void BindGrid(string billNo)
    {
        var objVendorCPKMBillController = new VendorCPKMBillController();

        gvCPKMBillDT.DataSource = objVendorCPKMBillController.GetCPKMBillList("", "", "", billNo);
        gvCPKMBillDT.DataBind();

        var dt = objVendorCPKMBillController.GetTDSDetailsByBillNo(billNo);
        txtTDSAmount.Text = dt.Rows[0]["TDSAmount"].ToString();

        gvMiscCharge.DataSource = objVendorCPKMBillController.GetMiscChargeByBillNo(billNo);
        gvMiscCharge.DataBind();
        txtMiscAmount.Text = totalMiscAmount.ToString();
        hdnMiscAmount.Value = totalMiscAmount.ToString();
        if (gvCPKMBillDT.Rows.Count == 0)
        {
            trTotal.Attributes.Add("style", "display:none");
        }
    }

    protected void gvCPKMBillDT_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var hdnOPType = (HiddenField)e.Row.FindControl("hdnOPType");
            var ddlOperation = (DropDownList)e.Row.FindControl("ddlOperation");

            ddlOperation.SelectedValue = hdnOPType.Value;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "clearControls", "AmontCalculation('" + ddlOperation.ClientID + "');", true);
        }
    }

    protected void gvMiscCharge_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var lblAmount = (Label)e.Row.FindControl("lblAmount");
            var chkVehicleNo = (CheckBox)e.Row.FindControl("chkMiscChargeCheckNo");
            //if (!chkVehicleNo.Checked)
            //{
            totalMiscAmount += Convert.ToDouble(lblAmount.Text);
            // }

        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        try
        {
			if (IsTokenValid()){
				string strHeaderXML = "<ApproveHeader>";
            string strDetailXML = "";

            strHeaderXML += "<BillNo>" + Convert.ToString(Request.QueryString["BillNo"]) + "</BillNo>";
            strHeaderXML += "<TotalSubAmount>" + WebXConvert.ToDouble(hdnSubTotal.Value == "" ? "0" : hdnSubTotal.Value).ToString() + "</TotalSubAmount>";
            strHeaderXML += "<TotalBillAmount>" + WebXConvert.ToDouble(hdnTotalbillAmount.Value == "" ? "0" : hdnTotalbillAmount.Value).ToString() + "</TotalBillAmount>";
            strHeaderXML += "<TDSAmount>" + WebXConvert.ToDouble(txtTDSAmount.Text == "" ? "0" : txtTDSAmount.Text).ToString()  + "</TDSAmount>";
            int i = 0;
            foreach (GridViewRow dr in gvCPKMBillDT.Rows)
            {
                var chkVehicleNo = (CheckBox)dr.FindControl("chkVehicleNo");
                var lblVehicleNo = (Label)dr.FindControl("lblVehicleNo");
                var ddlOperation = (DropDownList)dr.FindControl("ddlOperation");
                var txtAddSubtractKms = (TextBox)dr.FindControl("txtAddSubtractKms");
                var hdnActualClosingKm = (HiddenField)dr.FindControl("hdnActualClosingKm");
                var hdnNetDistance = (HiddenField)dr.FindControl("hdnNetDistance");
                var hdnAmount = (HiddenField)dr.FindControl("hdnAmount");
                var txtRebate = (TextBox)dr.FindControl("txtRebate");
                var hdnNetAmount = (HiddenField)dr.FindControl("hdnNetAmount");
                var hdnFinalAmount = (HiddenField)dr.FindControl("hdnFinalAmount");
                var txtRejectRemark = (TextBox)dr.FindControl("txtRejectRemark");

                var hdnBalanceKms = (HiddenField)dr.FindControl("hdnBalanceKms");
                var hdnCreditKms = (HiddenField)dr.FindControl("hdnCreditKms");

                //if (chkVehicleNo.Checked)
                {
                    strDetailXML += "<ApproveDetail>";
                    strDetailXML += "<VehicleNo>" + lblVehicleNo.Text + "</VehicleNo>";
                    strDetailXML += "<OptType>" + ddlOperation.SelectedValue + "</OptType>";
                    strDetailXML += "<AddSubtractKms>" + txtAddSubtractKms.Text + "</AddSubtractKms>";
                    strDetailXML += "<ActualClosingKm>" + hdnActualClosingKm.Value + "</ActualClosingKm>";
                    strDetailXML += "<NetDistance>" + hdnNetDistance.Value + "</NetDistance>";
                    strDetailXML += "<Amount>" + hdnAmount.Value + "</Amount>";
                    strDetailXML += "<Rebate>" + txtRebate.Text + "</Rebate>";
                    strDetailXML += "<NetAmount>" + hdnNetAmount.Value + "</NetAmount>";
                    strDetailXML += "<FinalAmount>" + hdnFinalAmount.Value + "</FinalAmount>";
                    strDetailXML += "<RejectRemark>" + txtRejectRemark.Text + "</RejectRemark>";
                    strDetailXML += "<IsRejected>" + (chkVehicleNo.Checked == true ? "Y" : "N") + "</IsRejected>";
                    strDetailXML += "<CreditKms>" + hdnCreditKms.Value + "</CreditKms>";
                    strDetailXML += "<BalanceKms>" + hdnBalanceKms.Value + "</BalanceKms>";
                    strDetailXML += "</ApproveDetail>";
                    i++;
                }
            }

            // if (i == 0)
            // {
            // throw  new Exception("Please Select at least one Row");
            // }
            //strHeaderXML += strDetailXML + "</ApproveDetail>";
            strHeaderXML += strDetailXML + "</ApproveHeader>";
            var objVendorCPKMBillController = new VendorCPKMBillController();

            DataSet ds = objVendorCPKMBillController.CPKMBillApprove(Convert.ToString(Request.QueryString["BillNo"]), strHeaderXML, hdnMiscXML.Value);
            string success = ds.Tables[0].Rows[0]["Success"].ToString();
            if (success == "1")
            {
				ConsumeToken();
                Response.Redirect("BillDone.aspx?BillNo=" + Convert.ToString(Request.QueryString["BillNo"]), false);
            }
            else
            {
                throw new Exception("Opps! Something went wrong.Try Again");
            }
			}
            

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "BillApprovalDetail->btnSubmit_OnClick");
            umsg.Show(ex.Message);
        }
    }
}

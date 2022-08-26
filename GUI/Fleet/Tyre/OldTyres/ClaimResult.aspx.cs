using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ApplicationManager;
using System.Data;


public partial class GUI_Fleet_Tyre_OldTyres_ClaimResult : System.Web.UI.Page
{
    string VendorID = "", FromDT = "", ToDT = "", ClaimID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            VendorID = Request.QueryString["VendorID"].Trim();
            FromDT = Request.QueryString["FromDT"].Trim();
            ToDT = Request.QueryString["ToDT"].Trim();
            ClaimID = Request.QueryString["ClaimID"].Trim();
            BindGrid();
            if (GV_TyreClaim.Rows.Count == 0)
            {
                tblPayment.Visible = false;
            }
            else
            {
                tblPayment.Visible = true;
            }
        }
    }


    /// <summary>
    /// bind grid
    /// </summary>
    public void BindGrid()
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
        CTIM.VendorCode = VendorID.Trim();
        CTIM.CLAIM_REMOLD_SALE_ID = ClaimID.Trim();

        ////CTIM.BindGridTyreDetails(GV_TyreClaim);
        CTIM.BindGridCliam(GV_TyreClaim, FromDT, ToDT);
    }

    protected void RowDataBound_GV_TyreClaim(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlAction = (DropDownList)e.Row.FindControl("ddlAction");
            TextBox txtClaimAmt = (TextBox)e.Row.FindControl("txtClaimAmt");
            TextBox txtReason = (TextBox)e.Row.FindControl("txtReason");

            //txtClaimAmt.Attributes.Add("OnBlur", "javascript:FillPayment(" + e.Row.RowIndex + ");");
            txtClaimAmt.Attributes.Add("OnBlur", "javascript:FillPayment();");
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void TextChanged_ClaimAmt(object sender, EventArgs e)
    {
        Double ClaimAmt = 0.00;
        foreach (GridViewRow GV in GV_TyreClaim.Rows)
        {
            TextBox txtClaimAmt = (TextBox)GV.FindControl("txtClaimAmt");
            DropDownList ddlAction = (DropDownList)GV.FindControl("ddlAction");
            if (ddlAction.SelectedValue == "P")
            {
                if (txtClaimAmt.Text != "")
                {
                    UserControls_Webx_PaymentControl payment = (UserControls_Webx_PaymentControl)UCMyPaymentControl1;

                    TextBox txtAmtApplA = (TextBox)payment.FindControl("txtAmtApplA");
                    TextBox txtNetPay = (TextBox)payment.FindControl("txtNetPay");

                    ClaimAmt = ClaimAmt + Convert.ToDouble(txtClaimAmt.Text);

                    txtAmtApplA.Text = Convert.ToString(ClaimAmt);
                    txtNetPay.Text = Convert.ToString(ClaimAmt);
                }
            }
        }
        hdftotClaimAmt.Value = Convert.ToString(ClaimAmt);
    }
    /////// <summary>
    /////// 
    /////// </summary>
    /////// <param name="sender"></param>
    /////// <param name="e"></param>
    ////protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    ////{
    ////    foreach (GridViewRow GV in GV_TyreClaim.Rows)
    ////    {
    ////        DropDownList ddlAction = (DropDownList)GV.FindControl("ddlAction");
    ////        TextBox txtClaimAmt = (TextBox)GV.FindControl("txtClaimAmt");
    ////        TextBox txtReason = (TextBox)GV.FindControl("txtReason");

    ////        if (ddlAction.SelectedValue != "0")
    ////        {
    ////            if (ddlAction.SelectedValue == "P")
    ////            {
    ////                txtClaimAmt.Enabled = true;
    ////                txtReason.Enabled = false;
    ////                txtReason.Text = "";
    ////            }
    ////            else
    ////            {
    ////                txtClaimAmt.Enabled = false;
    ////                txtClaimAmt.Text = "";
    ////                txtReason.Enabled = true;
    ////            }
    ////        }
    ////        else
    ////        {
    ////            txtClaimAmt.Enabled = false;
    ////            txtReason.Enabled = false;
    ////            txtClaimAmt.Text = "";
    ////            txtReason.Text = "";
    ////        }
    ////    }
    ////}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();

        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "";

        Boolean IsCommited = false;
        string Reason = "", final = "", Claim_YN = "";
        Double ClaimAmt = 0.00;
        string Xml_PAY_MST = "<root><Tyre_MST>";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());

        DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
        TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
        DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
        TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
        TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
        DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
        TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");
        TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");


        foreach (GridViewRow gridrow in GV_TyreClaim.Rows)
        {
            CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;
            TextBox txtClaimID = gridrow.FindControl("txtClaimID") as TextBox;
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            TextBox txtClaim = gridrow.FindControl("txtClaim") as TextBox;
            TextBox txtClaimAmt = gridrow.FindControl("txtClaimAmt") as TextBox;
            TextBox txtReason = gridrow.FindControl("txtReason") as TextBox;
            TextBox txtClaimDT = gridrow.FindControl("txtClaimDT") as TextBox;
            HiddenField hdfSR_NO = gridrow.FindControl("hdfSR_NO") as HiddenField;
            DropDownList ddlAction = gridrow.FindControl("ddlAction") as DropDownList;
            HiddenField hdfSysTyreID = gridrow.FindControl("hdfSysTyreID") as HiddenField;

            if (txtClaimAmt.Text == "")
            {
                ClaimAmt = 0.00;
                Claim_YN = "N";
            }
            else
            {
                ClaimAmt = Convert.ToDouble(txtClaimAmt.Text);
                Claim_YN = "Y";
            }

            if (txtReason.Text == "")
            {
                Reason = Convert.ToString(DBNull.Value);
            }
            else
            {
                Reason = txtReason.Text;
            }

            //----------------------------

            if (chkSelect.Checked)
            {
                CTIM.SR_NO = Convert.ToInt32(hdfSR_NO.Value);
                CTIM.TYRE_ID = txtSysTyreNo.Text.ToString();
                CTIM.CLAIM_REMOLD_SALE_ID = txtClaimID.Text.Trim();
                CTIM.VendorCode = txtClaim.Text.Trim();
                if (ddlAction.SelectedValue == "P") { CTIM.STATUS = "PASSED"; }
                if (ddlAction.SelectedValue == "R") { CTIM.STATUS = "REJECTED"; }

                CTIM.CLAIM_AMT = ClaimAmt;
                CTIM.C_Remark = Reason;
                CTIM.Claim_YN = Claim_YN;
                CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();

                //Payment details
                CTIM.PayMode = ddlPayMode.SelectedValue.Trim();
                CTIM.Acccode = "";

                CTIM.Chqno = txtChqNo.Text.ToString();
                if (txtChqDate.Text != "") { CTIM.Chqdate = txtChqDate.Text; }
                else { CTIM.Chqdate = ""; }

                if (txtChqAmt.Text != "") { CTIM.ChqAmt = Convert.ToDouble(txtChqAmt.Text.ToString()); }
                else { CTIM.ChqAmt = 0.00; }

                if (txtCashAmt.Text != "") { CTIM.CashAmt = Convert.ToDouble(txtCashAmt.Text.ToString()); } else { CTIM.CashAmt = 0.00; }

                //CTIM.PAYDT=;
                CTIM.Cashcode = ddrCashcode.SelectedValue.ToString();
                CTIM.Bankaccode = ddrBankaccode.SelectedValue.ToString();
                CTIM.NetPay = Convert.ToDouble(txtNetPay.Text.ToString());
                //Payment details end               

                CTIM.UPDATEDBY = SessionUtilities.CurrentEmployeeID.Trim();
                CTIM.UpdateTyre_ClaimPayment();
                IsCommited = true;
            }

            ////if (txtClaim.Text != "")
            ////{
            ////    ARR_vendcd = txtClaim.Text.Split('~');
            ////    VendorCD = ARR_vendcd[0].ToString();
            ////    VendorNM = ARR_vendcd[1].ToString();
            ////}
            list.Add(txtSysTyreNo.Text.Trim());

            ////Xml_PAY_MST = Xml_PAY_MST + "<TYRE_ID>" + txtSysTyreNo.Text.ToString() + "</TYRE_ID>";
            ////Xml_PAY_MST = Xml_PAY_MST + "<Suffix>C</Suffix>";
            ////Xml_PAY_MST = Xml_PAY_MST + "<Actions>Claim</Actions>";
            ////Xml_PAY_MST = Xml_PAY_MST + "<VendorCode>" + VendorCD.Trim() + "</VendorCode>";
            ////Xml_PAY_MST = Xml_PAY_MST + "<Claim_Amt>" + ClaimAmt.Trim() + "</Claim_Amt>";
            ////Xml_PAY_MST = Xml_PAY_MST + "<Claim_DT>" + Convert.ToDateTime(txtClaimDT.Text.Trim()) + "</Claim_DT>";
            ////Xml_PAY_MST = Xml_PAY_MST + "<C_Remark>" + Reason.Trim() + "</C_Remark>";

        }
        //////Payment Details
        ////Xml_PAY_MST = Xml_PAY_MST + "<PayMode>" + ddlPayMode.SelectedValue.Trim() + "</PayMode>";
        ////if (txtCashAmt.Text != "")
        ////{
        ////    Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>" + txtCashAmt.Text.ToString() + "</CashAmt>";
        ////}
        ////else
        ////{
        ////    Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>0.00</CashAmt>";
        ////}

        ////Xml_PAY_MST = Xml_PAY_MST + "<Cashcode>" + ddrCashcode.SelectedValue.ToString() + "</Cashcode>";
        ////if (txtChqAmt.Text != "")
        ////{
        ////    Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>" + txtChqAmt.Text.ToString() + "</ChqAmt>";
        ////}
        ////else
        ////{
        ////    Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>0.00</ChqAmt>";
        ////}
        ////Xml_PAY_MST = Xml_PAY_MST + "<Chqno>" + txtChqNo.Text.ToString() + "</Chqno>";
        ////Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode>" + ddrBankaccode.SelectedValue.ToString() + "</Bankaccode>";
        ////if (txtChqDate.Text.Trim() != "")
        ////{
        ////    Xml_PAY_MST = Xml_PAY_MST + "<Chqdate>" + Convert.ToDateTime(txtChqDate.Text) + "</Chqdate>";
        ////}
        ////else
        ////{
        ////    Xml_PAY_MST = Xml_PAY_MST + "<Chqdate></Chqdate>";
        ////}
        ////Xml_PAY_MST = Xml_PAY_MST + "<NetPay>" + txtNetPay.Text.ToString() + "</NetPay>";
        ////Xml_PAY_MST = Xml_PAY_MST + "</Tyre_MST></root>";
        ////CTIM.XMLData = Xml_PAY_MST.Trim();
        ////CTIM.UpdateTyreDtl_Claim();

        if (IsCommited)
        {
            btnSubmit.Enabled = false;
            Response.Redirect("ClaimMsg.aspx?ID=" + CTIM.CLAIM_REMOLD_SALE_ID);
        }

    }
}
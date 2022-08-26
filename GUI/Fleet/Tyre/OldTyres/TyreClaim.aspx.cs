using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ApplicationManager;
using System.Data;

public partial class GUI_Fleet_Tyre_TyreClaim : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            string Str = Request.QueryString["Tyre_ID"];
            //string Str = "T0011,T0012,T0013,T0014,T0015,T0018";

            trPayment.Visible = false;
            trClaim2.Visible = false;

            CTIM.GetTyres_Claim(GV_TyreClaim, Str);

            //  btnStep.Attributes.Add("OnClick", "javascript:OnSubmitStep();");
            // btnSubmit.Attributes.Add("OnClick", "javascript:OnSubmit();");
        }
    }

    protected void GV_TyreClaim_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtClaim = (TextBox)e.Row.FindControl("txtClaim");
            //TextBox txtClaimAmt = (TextBox)e.Row.FindControl("txtClaimAmt");
            //TextBox txtReason = (TextBox)e.Row.FindControl("txtReason");

            //txtClaimAmt.Enabled = false;
            //txtReason.Enabled = false;
            //txtClaim.Attributes.Add("OnBlur", "javascript:CheckVendor();");
        }
    }

    protected void TextChanged_ClaimAmt(object sender, EventArgs e)
    {
        Double ClaimAmt = 0.00;
        foreach (GridViewRow GV in GV_TyreClaim2.Rows)
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
    protected void SelectAll(object sender, EventArgs e)
    {
        foreach (GridViewRow GV in GV_TyreClaim.Rows)
        {
            CheckBox chkSelectAll = (CheckBox)GV_TyreClaim.HeaderRow.FindControl("chkSelectAll");
            CheckBox chkSelect = (CheckBox)GV.FindControl("chkSelect");

            if (chkSelectAll.Checked)
            {
                chkSelect.Checked = true;
            }
            else
            {
                chkSelect.Checked = false;
            }
        }
    }

    protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow GV in GV_TyreClaim2.Rows)
        {
            DropDownList ddlAction = (DropDownList)GV.FindControl("ddlAction");
            TextBox txtClaimAmt = (TextBox)GV.FindControl("txtClaimAmt");
            TextBox txtReason = (TextBox)GV.FindControl("txtReason");

            if (ddlAction.SelectedValue != "0")
            {
                if (ddlAction.SelectedValue == "P")
                {
                    txtClaimAmt.Enabled = true;
                    txtReason.Enabled = false;
                    txtReason.Text = "";
                }
                else
                {
                    txtClaimAmt.Enabled = false;
                    txtClaimAmt.Text = "";
                    txtReason.Enabled = true;
                }
            }
            else
            {
                txtClaimAmt.Enabled = false;
                txtReason.Enabled = false;
                txtClaimAmt.Text = "";
                txtReason.Text = "";
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnStep_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();
        string final = "";
        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "";

        Boolean IsCommited = false;

        string Xml_PAY_MST = "<root><Tyre_MST>";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());

        foreach (GridViewRow gridrow in GV_TyreClaim.Rows)
        {
            CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;

            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            TextBox txtClaim = gridrow.FindControl("txtClaim") as TextBox;
            TextBox txtClaimDT = gridrow.FindControl("txtClaimDT") as TextBox;

            if (chkSelect.Checked)
            {
                list.Add(txtSysTyreNo.Text.Trim());

                ARR_vendcd = txtClaim.Text.Split('~');

                VendorCD = ARR_vendcd[0].ToString();
                VendorNM = ARR_vendcd[1].ToString();

                Xml_PAY_MST = Xml_PAY_MST + "<TYRE_ID>" + txtSysTyreNo.Text.ToString() + "</TYRE_ID>";
                Xml_PAY_MST = Xml_PAY_MST + "<Suffix>C</Suffix>";
                Xml_PAY_MST = Xml_PAY_MST + "<Actions>Claim</Actions>";
                Xml_PAY_MST = Xml_PAY_MST + "<VendorCode>" + VendorCD.Trim() + "</VendorCode>";
                Xml_PAY_MST = Xml_PAY_MST + "<Claim_Amt>0.00</Claim_Amt>";
                Xml_PAY_MST = Xml_PAY_MST + "<Claim_DT>" + txtClaimDT.Text.Trim() + "</Claim_DT>";
                Xml_PAY_MST = Xml_PAY_MST + "<C_Remark></C_Remark>";
            }
        }


        //Payment Details
        Xml_PAY_MST = Xml_PAY_MST + "<PayMode></PayMode>";
        Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>0.00</CashAmt>";
        Xml_PAY_MST = Xml_PAY_MST + "<Cashcode></Cashcode>";
        Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>0.00</ChqAmt>";
        Xml_PAY_MST = Xml_PAY_MST + "<Chqno></Chqno>";
        Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode></Bankaccode>";
        Xml_PAY_MST = Xml_PAY_MST + "<Chqdate></Chqdate>";
        Xml_PAY_MST = Xml_PAY_MST + "<NetPay>0.00</NetPay>";

        Xml_PAY_MST = Xml_PAY_MST + "</Tyre_MST></root>";
        CTIM.XMLData = Xml_PAY_MST.Trim();
        CTIM.UpdateTyreDtl_Claim();
        IsCommited = true;

        if (IsCommited)
        {
            btnStep.Enabled = false;
            btnSubmit.Enabled = true;
            trClaim2.Visible = true;
            trPayment.Visible = true;

            for (int i = 0; i < list.Count; i++)
            {
                if (final == "")
                {
                    final = list[i];
                }
                else
                {
                    final = final + "," + list[i];
                }
            }
            CTIM.GetTyres_Claim_New(GV_TyreClaim2, final);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();

        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "";

        Boolean IsCommited = false;
        string ClaimAmt = "", Reason = "", final = "";
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


        foreach (GridViewRow gridrow in GV_TyreClaim2.Rows)
        {
            //CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            TextBox txtClaim = gridrow.FindControl("txtClaim") as TextBox;
            TextBox txtClaimAmt = gridrow.FindControl("txtClaimAmt") as TextBox;
            TextBox txtReason = gridrow.FindControl("txtReason") as TextBox;
            TextBox txtClaimDT = gridrow.FindControl("txtClaimDT") as TextBox;

            if (txtClaimAmt.Text == "")
            {
                ClaimAmt = "0.00";
            }
            else
            {
                ClaimAmt = txtClaimAmt.Text;
            }

            if (txtReason.Text == "")
            {
                Reason = Convert.ToString(DBNull.Value);
            }
            else
            {
                Reason = txtReason.Text;
            }

            if (txtClaim.Text != "")
            {
                ARR_vendcd = txtClaim.Text.Split('~');
                VendorCD = ARR_vendcd[0].ToString();
                VendorNM = ARR_vendcd[1].ToString();
            }
            list.Add(txtSysTyreNo.Text.Trim());

            Xml_PAY_MST = Xml_PAY_MST + "<TYRE_ID>" + txtSysTyreNo.Text.ToString() + "</TYRE_ID>";
            Xml_PAY_MST = Xml_PAY_MST + "<Suffix>C</Suffix>";
            Xml_PAY_MST = Xml_PAY_MST + "<Actions>Claim</Actions>";
            Xml_PAY_MST = Xml_PAY_MST + "<VendorCode>" + VendorCD.Trim() + "</VendorCode>";
            Xml_PAY_MST = Xml_PAY_MST + "<Claim_Amt>" + ClaimAmt.Trim() + "</Claim_Amt>";
            Xml_PAY_MST = Xml_PAY_MST + "<Claim_DT>" + Convert.ToDateTime(txtClaimDT.Text.Trim()) + "</Claim_DT>";
            Xml_PAY_MST = Xml_PAY_MST + "<C_Remark>" + Reason.Trim() + "</C_Remark>";

        }

        //Payment Details
        Xml_PAY_MST = Xml_PAY_MST + "<PayMode>" + ddlPayMode.SelectedValue.Trim() + "</PayMode>";
        if (txtCashAmt.Text != "")
        {
            Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>" + txtCashAmt.Text.ToString() + "</CashAmt>";
        }
        else
        {
            Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>0.00</CashAmt>";
        }

        Xml_PAY_MST = Xml_PAY_MST + "<Cashcode>" + ddrCashcode.SelectedValue.ToString() + "</Cashcode>";
        if (txtChqAmt.Text != "")
        {
            Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>" + txtChqAmt.Text.ToString() + "</ChqAmt>";
        }
        else
        {
            Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>0.00</ChqAmt>";
        }
        Xml_PAY_MST = Xml_PAY_MST + "<Chqno>" + txtChqNo.Text.ToString() + "</Chqno>";
        Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode>" + ddrBankaccode.SelectedValue.ToString() + "</Bankaccode>";
        if (txtChqDate.Text.Trim() != "")
        {
            Xml_PAY_MST = Xml_PAY_MST + "<Chqdate>" + Convert.ToDateTime(txtChqDate.Text) + "</Chqdate>";
        }
        else
        {
            Xml_PAY_MST = Xml_PAY_MST + "<Chqdate></Chqdate>";
        }
        Xml_PAY_MST = Xml_PAY_MST + "<NetPay>" + txtNetPay.Text.ToString() + "</NetPay>";
        Xml_PAY_MST = Xml_PAY_MST + "</Tyre_MST></root>";

        CTIM.XMLData = Xml_PAY_MST.Trim();
        CTIM.UpdateTyreDtl_Claim();
        IsCommited = true;

        for (int i = 0; i < list.Count; i++)
        {
            if (final == "")
            {
                final = list[i];
            }
            else
            {
                final = final + "," + list[i];
            }
        }


        if (IsCommited)
        {
            btnSubmit.Enabled = false;
            Response.Redirect("TyreUpdate_Msg.aspx?Tyre_ID=" + final.Trim());
        }
    }

}
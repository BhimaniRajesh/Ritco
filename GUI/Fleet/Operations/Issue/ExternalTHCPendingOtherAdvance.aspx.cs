using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

public partial class GUI_Fleet_Operations_Issue_ExternalTHCPendingOtherAdvance : BasePage
{
    MyFunctions fn = new MyFunctions();
    ETHCController objETHCController = new ETHCController();
    protected void Page_Load(object sender, EventArgs e)
    {
        string Location = Request.QueryString["Location"].ToString();
        string FromDate = Request.QueryString["FromDate"].ToString();
        string ToDate = Request.QueryString["ToDate"].ToString();
        string EthcNo = Request.QueryString["EthcNo"].ToString();
        string Customer= Request.QueryString["Customer"].ToString();
        if (!IsPostBack)
        {
            CreateToken();
            DataTable dtExternalTHCList = objETHCController.GetExternalTHCListForPendingOtherAdvance(EthcNo, FromDate, ToDate, Location, Customer);
            gvETHCPayment.DataSource = dtExternalTHCList;
            gvETHCPayment.DataBind();
        }
    }



    protected void gvETHCPayment_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderGridRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell HeaderCell = new TableCell();
            HeaderCell.Text = "";
            HeaderCell.ColumnSpan = 5;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Advance Taken By";
            HeaderCell.HorizontalAlign = HorizontalAlign.Center;
            HeaderCell.Font.Bold = true;
            HeaderCell.ColumnSpan = 5;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "";
            HeaderCell.ColumnSpan = 8;
            HeaderGridRow.Cells.Add(HeaderCell);

            gvETHCPayment.Controls[0].Controls.AddAt(0, HeaderGridRow);

        }
    }

    protected void gvETHCPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            try
            {
                ConsumeToken();
                DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
                TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
                DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
                TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
                TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
                DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
                TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");

                string Cnt = "";
                Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChqNo.Text.ToString(), fn.Mydate1(txtChqDate.Text.ToString()));

                string Xml_ETHCPaymentDetail = "<root>";


                foreach (GridViewRow gridrow in gvETHCPayment.Rows)
                {
                    CheckBox chkSelect = (CheckBox)gridrow.FindControl("chkSelect");
                    if (chkSelect.Checked)
                    {
                        Label lblExternalTHCNo = (Label)gridrow.FindControl("lblExternalTHCNo");
                        Label lblOtherPandingAmount = (Label)gridrow.FindControl("lblOtherPandingAmount");
                        Label lblAdvanceAmountByOther = (Label)gridrow.FindControl("lblAdvanceAmountByOther");
                        TextBox txtPaid = (TextBox)gridrow.FindControl("txtPaid");
                        HiddenField hdnCustomerCode = (HiddenField)gridrow.FindControl("hdnCustomerCode");
                        Label lblCustomerName = (Label)gridrow.FindControl("lblCustomerName");

                        Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "<ETHCOtherPayment><ExternalTHCNo>" + lblExternalTHCNo.Text.ToString() + "</ExternalTHCNo>";
                        Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "<CustomerCode>" + hdnCustomerCode.Value.ToString() + "</CustomerCode>";
                        Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "<CustomerName>" + lblCustomerName.Text.ToString() + "</CustomerName>";
                        Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "<OtherAdvanceAmount>" + lblAdvanceAmountByOther.Text.ToString() + "</OtherAdvanceAmount>";
                        Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "<OtherPandingAmount>" + lblOtherPandingAmount.Text.ToString() + "</OtherPandingAmount>";
                        Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "<OtherPaidAmount>" + txtPaid.Text.ToString() + "</OtherPaidAmount></ETHCOtherPayment>";

                    }
                }
                Xml_ETHCPaymentDetail = Xml_ETHCPaymentDetail + "</root>";
                string Xml_PaymentDetail = "<root>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<PaymentDetail><PayMode>" + ddlPayMode.SelectedValue.ToString() + "</PayMode>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<CashAmt>" + txtCashAmt.Text.ToString() + "</CashAmt>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<Cashcode>" + ddrCashcode.SelectedValue + "</Cashcode>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<ChqAmt>" + txtChqAmt.Text.ToString() + "</ChqAmt>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<ChqNo>" + txtChqNo.Text.ToString() + "</ChqNo>";
                if (ddlPayMode.SelectedValue.ToString() == "Cash")
                {
                    Xml_PaymentDetail = Xml_PaymentDetail + "<Bankaccode>" + "" + "</Bankaccode>";
                    Xml_PaymentDetail = Xml_PaymentDetail + "<Bankaccodesc>" + "" + "</Bankaccodesc>";
                }
                else
                {
                    Xml_PaymentDetail = Xml_PaymentDetail + "<Bankaccode>" + ddrBankaccode.SelectedValue.ToString() + "</Bankaccode>";
                    Xml_PaymentDetail = Xml_PaymentDetail + "<Bankaccodesc>" + ddrBankaccode.SelectedItem.Text.ToString() + "</Bankaccodesc>";
                }
                Xml_PaymentDetail = Xml_PaymentDetail + "<ChqDate>" + fn.Mydate1(txtChqDate.Text.ToString()) + "</ChqDate>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<TotalAmount>" + lblTotalAmount.Text.ToString() + "</TotalAmount>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<TDS>" + txtTDS.Text.ToString() + "</TDS>";
                Xml_PaymentDetail = Xml_PaymentDetail + "<NetAmount>" + lblNetAmount.Text.ToString() + "</NetAmount></PaymentDetail>";
                Xml_PaymentDetail = Xml_PaymentDetail + "</root>";
                string Voucherno = "";
                DataTable dt = objETHCController.InsertETHCPaymentDetail(Xml_ETHCPaymentDetail, Xml_PaymentDetail);
                if (dt.Rows.Count > 0)
                {
                    Voucherno = dt.Rows[0][0].ToString();
                    Response.Redirect("ExternalTHCPendingOtherAdvanceDone.aspx?VoucherNo=" + Voucherno);
                }

            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message);
            }
        }
    }
}

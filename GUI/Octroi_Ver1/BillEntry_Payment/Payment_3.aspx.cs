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


public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{
    string Fromdt = "", Todate = "";
    MyFunctions fn = new MyFunctions();
    string  Vendorcode = "", AcctHead = "", VBillno = "", Billno="";
    protected void Page_Load(object sender, EventArgs e)
    {
            Fromdt = Request.QueryString["Fromdt"].ToString();
            Todate = Request.QueryString["Todate"].ToString();
            Vendorcode = Request.QueryString["Vendorcode"].ToString();
            Billno = Request.QueryString["Billno"].ToString();
            VBillno = Request.QueryString["VBillno"].ToString();

            if (VBillno != "")
                Lbl_VBillno.Text = VBillno.ToString();
            if (Billno != "")
                Lbl_Billno.Text = Billno.ToString();
            if (Vendorcode != "")
                Lbl_Vendor.Text = Vendorcode.ToString();
            if (Fromdt != "" && Todate != "")
                Lbl_Date.Text = Fromdt.ToString() + "-" + Todate.ToString();

            if (!IsPostBack)
            {
                DipsplayReport();
                TxtVoucherDT.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                Hnd_Server_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
    }
    public void DipsplayReport()
    {
        Octroi.BillEntryBindGrid(GV_BillList, Fromdt, Todate, Vendorcode, Billno, VBillno);
    }

     
 
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
        TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
        DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
        TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
        TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
        DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
        TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");
        TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");
        //  HiddenField Hnd_DocumentType = (HiddenField)this.UCMyPaymentControl1.FindControl("Hnd_DOcumentType");
        string Cnt = "";
        Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChqNo.Text.ToString(), fn.Mydate1(txtChqDate.Text.ToString()));
        if (ddlPayMode.SelectedValue != "Cash")
        {
            Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChqNo.Text.ToString(), fn.Mydate1(txtChqDate.Text.ToString()));
            if (Cnt == "F")
            {
                // Response.Write("<br><br><br><font class='blackboldfnt' color='red' ><B>Error : Duplicate Cheque Entered </b></font>");
                //  Response.End();
                string ErrorMsg = "Duplicate Cheque Entered";
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Bill Entry Payment Voucher&ErrorMsg=" + ErrorMsg);
            }
        }
        if (ddlPayMode.SelectedValue == "Cash" || ddlPayMode.SelectedValue == "Both")
        {
            Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmt.Text), fn.Mydate(TxtVoucherDT.Text.ToString()));
            if (Cnt == "F")
            {
                string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Bill Entry Payment Voucher&ErrorMsg=" + ErrorMsg);
            }
        }
        string Xml_PAY_MST = "<root><PAY_Mst>", Xml_PAY_Det = "<root>";
        TextBox[] txtcharge = new TextBox[10];
        foreach (GridViewRow gridrow in GV_BillList.Rows)
        {

            TextBox Txt_Pendamt = (TextBox)gridrow.FindControl("Txt_Pendamt");
            Label LblBillno = (Label)gridrow.FindControl("LblBillno"); 
            HiddenField Hnd_Pendamt = (HiddenField)gridrow.FindControl("Hnd_Pendamt");

            Xml_PAY_Det = Xml_PAY_Det + "<PAY_Det><Billno>" + LblBillno.Text + "</Billno>";
            Xml_PAY_Det = Xml_PAY_Det + "<PayDt>" + fn.Mydate1(TxtVoucherDT.Text)+ "</PayDt>";
            Xml_PAY_Det = Xml_PAY_Det + "<PendAmt>" + Hnd_Pendamt.Value.ToString() + "</PendAmt>";
            Xml_PAY_Det = Xml_PAY_Det + "<CurrAmt>" + Txt_Pendamt.Text.ToString() + "</CurrAmt></PAY_Det>";
        }
        Xml_PAY_Det = Xml_PAY_Det + "</root>";
        Xml_PAY_MST = Xml_PAY_MST + "<Manual_Voucherno>" + Txt_Manual_Voucherno.Text.ToString() + "</Manual_Voucherno>";
        Xml_PAY_MST = Xml_PAY_MST + "<PAYDT>" + fn.Mydate1(TxtVoucherDT.Text.ToString()) + "</PAYDT>";
        Xml_PAY_MST = Xml_PAY_MST + "<Vendorcode>" + Vendorcode.ToString() + "</Vendorcode>";
        string[] VendDetail_ARR=fn.GetVendor(Vendorcode).Split(':');
        Xml_PAY_MST = Xml_PAY_MST + "<VendorName>" + VendDetail_ARR[1].ToString() + "</VendorName>";
        Xml_PAY_MST = Xml_PAY_MST + "<PayMode>" + ddlPayMode.SelectedValue.ToString() + "</PayMode>";
        Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>" + txtCashAmt.Text.ToString() + "</CashAmt>";
        Xml_PAY_MST = Xml_PAY_MST + "<Cashcode>" + ddrCashcode.SelectedValue + "</Cashcode>";
        Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>" + txtChqAmt.Text.ToString() + "</ChqAmt>";
        Xml_PAY_MST = Xml_PAY_MST + "<ChqNo>" + txtChqNo.Text.ToString() + "</ChqNo>";
        if (ddlPayMode.SelectedValue.ToString() == "Cash")
        {
            Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode>" + "" + "</Bankaccode>";
            Xml_PAY_MST = Xml_PAY_MST + "<Bankaccodesc>" + "" + "</Bankaccodesc>";
        }
        else
        {
            Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode>" + ddrBankaccode.SelectedValue.ToString() + "</Bankaccode>";
            Xml_PAY_MST = Xml_PAY_MST + "<Bankaccodesc>" + ddrBankaccode.SelectedItem.Text.ToString() + "</Bankaccodesc>";
        }
        Xml_PAY_MST = Xml_PAY_MST + "<ChqDate>" + fn.Mydate1(txtChqDate.Text.ToString()) + "</ChqDate>";
        Xml_PAY_MST = Xml_PAY_MST + "<NetPay>" + txtNetPay.Text.ToString() + "</NetPay>";
        Xml_PAY_MST = Xml_PAY_MST + "</PAY_Mst></root>";

        string Voucherno = "";

        Voucherno = Octroi.Insert_BillEntry_Payment_Data(Xml_PAY_MST, Xml_PAY_Det, "BillPayment");
        Response.Redirect("./Payment_Done.aspx?Voucherno=" + Voucherno + "&VoucherType=BillPayment");
    }
}

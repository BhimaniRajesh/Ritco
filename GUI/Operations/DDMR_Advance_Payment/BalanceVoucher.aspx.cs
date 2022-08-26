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
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;

public partial class GUI_Finance_VendorPayment_Ver1_Advance_Balance_Payment_AdvanceVoucher : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] Voucherno_Arr = Request.QueryString["Voucherno"].ToString().Split('~');
        string Sql = "";
        string Voucherno = Voucherno_Arr[0].ToString(), VoucherType = Request.QueryString["VoucherType"].ToString();
        
        Sql = "EXEC [UspViewPaymentVoucher] '" + VoucherType + "','" + Voucherno + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        //VoucherView.DataSource = ds;
        //VoucherView.DataBind();
        if (VoucherType == "BillPayment")
        {
            VoucherView.Visible = false;
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        else
        {
            GridView1.Visible = false;
            VoucherView.DataSource = ds;
            VoucherView.DataBind();
        }

        if (VoucherType == "ADV")
        {
            Lbl_Voucher_type.Text = "Advance Payment Voucher";
            lbl_title.Text = "Advance Payment Voucher Detail";
            Lbl_Docno.Text = "Voucher No.";
            Lbl_DocDate.Text = "Voucher Date";
            TaxDetail.Visible = false;
            PaymentDetail.Visible = true;
            BillDetail.Visible = false;
        }
        else if (VoucherType == "BAL" || VoucherType == "BAL_KM")
        {
            Lbl_Voucher_type.Text = "Balance Payment Voucher";
            lbl_title.Text = "Balance Payment Voucher Detail";
            Lbl_Docno.Text = "Voucher No.";
            Lbl_DocDate.Text = "Voucher Date";
            TaxDetail.Visible = true;
            PaymentDetail.Visible = true;
            BillDetail.Visible = false;
            if (VoucherType == "BAL_KM")
            {
                TR_KM_Based_BAL_1.Visible = true;
                TR_KM_Based_BAL_2.Visible = true;
                string[] VendorBill_Detail_Arr = VendorPayment_Utility.View_BillDetails(Voucherno, VoucherType).ToString().Split('~');
                Lbl_ContractType_1.Text = DataProvider.GetGeneralMasterName("VCTYP", VendorBill_Detail_Arr[0].ToString());
                Lbl_Rate_1.Text = VendorBill_Detail_Arr[1].ToString();
                Lbl_Tot_KM_1.Text = VendorBill_Detail_Arr[2].ToString();
                Lbl_ContractAmt_1.Text = VendorBill_Detail_Arr[3].ToString();
            }
        }
        else if (VoucherType == "BE" || VoucherType == "BE_KM")
        {
            Lbl_Voucher_type.Text = "Vendor Bill Entry";
            lbl_title.Text = "Vendor Bill Entry Detail";
            Lbl_Docno.Text = "Billno No.";
            Lbl_DocDate.Text = "Bill Date";
            TaxDetail.Visible = true;
            PaymentDetail.Visible = false;
            BillDetail.Visible = true;
            string Billdetails = "";
            Sql = "EXEC [Usp_View_VendorBill] '" + VoucherType + "','" + Voucherno + "'";
            SqlDataReader DR1 = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);

            if (VoucherType == "BE" || VoucherType == "BE_KM" || VoucherType == "BA_Bill" || VoucherType == "3PL_Bill")
            {
                while (DR1.Read())
                {
                    for (int i = 0; i < 12; i++)
                    {
                        if (Billdetails == "")
                            Billdetails = DR1.GetValue(i).ToString();
                        else
                            Billdetails = Billdetails + "~" + DR1.GetValue(i).ToString();
                    }
                }
                DR1.Close();
            }
            string[] VendorBill_Detail_Arr = Billdetails.ToString().Split('~');
           // lbl_voucher_Dt.Text = VendorBill_Detail_Arr[0].ToString();
            VendorName.Text = VendorBill_Detail_Arr[1].ToString();
          //  lbl_voucher_Dt.Text = VendorBill_Detail_Arr[2].ToString();
            BillDate.Text = VendorBill_Detail_Arr[3].ToString();
            DueDays.Text = VendorBill_Detail_Arr[4].ToString();
            DueDate.Text = VendorBill_Detail_Arr[5].ToString();
            Lbl_Remarks.Text = VendorBill_Detail_Arr[6].ToString();
            Billamt.Text = VendorBill_Detail_Arr[7].ToString();
            if (VoucherType == "BE_KM")
            {
                TR_KM_Based_1.Visible = true;
                TR_KM_Based_2.Visible = true;
                //Lbl_ContractType.Text = DataProvider.GetGeneralMasterName("VCTYP", VendorBill_Detail_Arr[8].ToString());
                Lbl_Rate.Text = VendorBill_Detail_Arr[9].ToString();
                Lbl_Tot_KM.Text = VendorBill_Detail_Arr[10].ToString();
                Lbl_ContractAmt.Text = VendorBill_Detail_Arr[11].ToString();
            }

        }
        else if (VoucherType == "BillPayment")
        {
            Lbl_Voucher_type.Text = "Bill Entry Payment Voucher";
            lbl_title.Text = "Bill Entry Voucher Detail";
            Lbl_Docno.Text = "Voucher No.";
            Lbl_DocDate.Text = "Voucher Date";
            TaxDetail.Visible = false;
            PaymentDetail.Visible = true;
            BillDetail.Visible = false;
        }

        string Paymentdetails = "";
        Sql = "EXEC [Usp_View_PaymentVoucher_PaymentDetails] '" + VoucherType + "','" + Voucherno + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);

        while (DR.Read())
        {
            for (int i = 0; i < 22; i++)
            {
                if (Paymentdetails == "")
                    Paymentdetails = DR.GetValue(i).ToString();
                else
                    Paymentdetails = Paymentdetails + "~" + DR.GetValue(i).ToString();
            }
        }
        DR.Close();
        
        string[] Voucherno_Payment_Detail_Arr = Paymentdetails.ToString().Split('~');
        lbl_voucher_No.Text = Voucherno;
        lbl_voucher_Dt.Text = Voucherno_Payment_Detail_Arr[2].ToString();
        Lbl_manualVRNO.Text = Voucherno_Payment_Detail_Arr[1].ToString();
        Lbl_Vendorname.Text = Voucherno_Payment_Detail_Arr[0].ToString();
        Lbl_Paymode.Text = Voucherno_Payment_Detail_Arr[3].ToString();
        Lbl_CashAMt.Text = Voucherno_Payment_Detail_Arr[4].ToString();
        Lbl_cash_accode.Text = Voucherno_Payment_Detail_Arr[5].ToString();
        Lbl_Chqamt.Text = Voucherno_Payment_Detail_Arr[6].ToString();
        Lbl_bankCode.Text = Voucherno_Payment_Detail_Arr[7].ToString();
        Lbl_chqno.Text = Voucherno_Payment_Detail_Arr[8].ToString();
        Lbl_chqDate.Text = Voucherno_Payment_Detail_Arr[9].ToString();
        Lbl_netamt.Text = Voucherno_Payment_Detail_Arr[10].ToString();

        TdsRate.Text = Voucherno_Payment_Detail_Arr[11].ToString();
        TDSAmt.Text = Voucherno_Payment_Detail_Arr[12].ToString();
        //Lbl_netamt.Text = Voucherno_Payment_Detail_Arr[13].ToString();
        STax.Text = Voucherno_Payment_Detail_Arr[14].ToString();
        Cess.Text = Voucherno_Payment_Detail_Arr[15].ToString();
        HCess.Text = Voucherno_Payment_Detail_Arr[16].ToString();
        TDSLedger.Text = Voucherno_Payment_Detail_Arr[17].ToString();
        Stax_YN.Text = Voucherno_Payment_Detail_Arr[18].ToString();
        Tds_YN.Text = Voucherno_Payment_Detail_Arr[19].ToString();
        StaxRegNo.Text = Voucherno_Payment_Detail_Arr[20].ToString();
        PANNO.Text = Voucherno_Payment_Detail_Arr[21].ToString();
    }
}

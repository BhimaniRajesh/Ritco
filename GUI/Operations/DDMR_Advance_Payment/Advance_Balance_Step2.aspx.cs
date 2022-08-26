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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment : BasePage
{
    public string billno_nos, Branch, documentprint, voucherNo;
   // public string DOCNO_Str = "", Vendorcode = "", VendorName = "", ManualNo_Str = "", Fromdate = "", Todate = "", RouteMode = "", Trn_Typ = "", Trn_Typ_Desc = "", Trn_Doc = "", Trn_CalledAs = "", Trn_Doc_Typ = "";
    string Footer_Visibleflag = "", Trn_Typ_Desc="";
    MyFunctions fn = new MyFunctions();

    private string DOCNO_Str { get { return (ViewState["DOCNO_Str"] != null) ? ViewState["DOCNO_Str"].ToString() : ""; } set { ViewState["DOCNO_Str"] = value; } }
    private string Vendorcode { get { return (ViewState["Vendorcode"] != null) ? ViewState["Vendorcode"].ToString() : ""; } set { ViewState["Vendorcode"] = value; } }
    private string VendorName { get { return (ViewState["VendorName"] != null) ? ViewState["VendorName"].ToString() : ""; } set { ViewState["VendorName"] = value; } }
    private string ManualNo_Str { get { return (ViewState["ManualNo_Str"] != null) ? ViewState["ManualNo_Str"].ToString() : ""; } set { ViewState["ManualNo_Str"] = value; } }
    private string Fromdate { get { return (ViewState["Fromdate"] != null) ? ViewState["Fromdate"].ToString() : ""; } set { ViewState["Fromdate"] = value; } }
    private string Todate { get { return (ViewState["Todate"] != null) ? ViewState["Todate"].ToString() : ""; } set { ViewState["Todate"] = value; } }
    // private string ManualNo_Str { get { return (ViewState["ManualNo_Str"] != null) ? ViewState["ManualNo_Str"].ToString() : ""; } set { ViewState["ManualNo_Str"] = value; } }
    private string Trn_Typ { get { return (ViewState["Trn_Typ"] != null) ? ViewState["Trn_Typ"].ToString() : ""; } set { ViewState["Trn_Typ"] = value; } }
    private string Trn_Doc { get { return (ViewState["Trn_Doc"] != null) ? ViewState["Trn_Doc"].ToString() : ""; } set { ViewState["Trn_Doc"] = value; } }
    private string Trn_CalledAs { get { return (ViewState["Trn_CalledAs"] != null) ? ViewState["Trn_CalledAs"].ToString() : ""; } set { ViewState["Trn_CalledAs"] = value; } }
    private string Trn_Doc_Typ { get { return (ViewState["Trn_Doc_Typ"] != null) ? ViewState["Trn_Doc_Typ"].ToString() : ""; } set { ViewState["Trn_Doc_Typ"] = value; } }
    private string ContractID { get { return (ViewState["ContractID"] != null) ? ViewState["ContractID"].ToString() : ""; } set { ViewState["ContractID"] = value; } }
    private string ContractSubType { get { return (ViewState["ContractSubType"] != null) ? ViewState["ContractSubType"].ToString() : ""; } set { ViewState["ContractSubType"] = value; } }
    
    protected void Page_Load(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            CreateToken();
            Fromdate = Request.QueryString["Fromdate"];
            Todate = Request.QueryString["Todate"];
            //ContractID = Request.QueryString["ContractID"];
            Vendorcode = Request.QueryString["Vendorcode"];
            VendorName = Request.QueryString["VendorName"];            
            DOCNO_Str = Convert.ToString(Request.QueryString["Docnos"]);
            ManualNo_Str = Convert.ToString(Request.QueryString["ManualNo_Str"]);
            Trn_Typ = Convert.ToString(Request.QueryString["Trn_Typ"]);
            //Trn_Doc = Convert.ToString(Request.QueryString["Trn_Doc"]);
            //Trn_CalledAs = Convert.ToString(Request.QueryString["Trn_CalledAs"]);
            //Trn_Doc_Typ = Convert.ToString(Request.QueryString["Trn_Doc_Typ"]);
            //ContractSubType = Convert.ToString(Request.QueryString["ContractSubType"]);
            Branch = Session["BRCD"].ToString();
            //Hnd_Doc_type.Value = Trn_CalledAs;
            if (Trn_Typ == "A")
            {
                Trn_Typ_Desc = "Advance";
            }
            else if (Trn_Typ == "B")
            {
                Trn_Typ_Desc = "Balance";
            }
            if (ContractID != "")
            {
                View_Contract.HRef = "~/GUI/Admin/Vendor_Contract_ver1/ContractView.aspx?ContractID=" + ContractID;
            }
            Hnd_ServerDt.Value = System.DateTime.Today.ToString("dd/MM/yyyy");
            
            //if(ContractSubType=="ADH")
            //    VendorPayment_Utility.BindGrid(GV_THC_BAL_PAYMENT, Trn_Doc_Typ, Trn_Typ, Fromdate, Todate, Vendorcode, DOCNO_Str, ManualNo_Str, SessionUtilities.CurrentBranchCode, Trn_Doc_Typ, ContractSubType, "");
            //else
            //     VendorPayment_Utility.BindGrid(GV_THC_BAL_PAYMENT, Trn_Doc_Typ, Trn_Typ, Fromdate, Todate, Vendorcode, DOCNO_Str, ManualNo_Str, SessionUtilities.CurrentBranchCode, Trn_Doc_Typ, "", "");

            TxtVoucherDT.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            VendorPayment_Utility.Fill_TdsPayable(Tdssection);
            Tdssection.CssClass = "blackfnt";
            //System.DateTime.Now.ToShortDateString();
            Txt_VDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            //int Duedays = Convert.ToInt16(Txt_DueDays.Text);
            //DateTime dt = DateTime.Today.AddDays(Duedays);
            //Txt_Duedate.Text = dt.ToString("dd/MM/yyyy");
            Lbl_VendorCode.Text = Vendorcode + "~" + VendorName;
            Hnd_Server_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
            //Fill_TdsPayable

            BindGrid();
        }
        string GRID_ID = "";
        TR_THC_ADV.Visible = true;
        GRID_ID = "GV_THC_BAL_PAYMENT";
        Lbl_Title.Text = Trn_Doc + " Bill Entry " + Trn_Typ_Desc + " Vendor Payment";
        btnSubmit.Attributes.Add("onclick", "javascript:return THC_BalPayment_OnSubmit('" + GRID_ID + "','RT_Based')");
    }
    public void BindGrid()
    {
        DataTable dtDDMRList = new DataTable();

        string SQLStr = "EXEC WEBX_DDMR_Payment_Listing '" + Trn_Typ + "','" + Fromdate + "','" + Todate + "','" + Vendorcode + "','" + DOCNO_Str + "','" + ManualNo_Str + "','" + SessionUtilities.CurrentBranchCode + "'";

        dtDDMRList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GV_THC_BAL_PAYMENT.DataSource = dtDDMRList;
        GV_THC_BAL_PAYMENT.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
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
        string STaxApply = "N", TDSApply = "N";
        if (Svctax_yn.Checked)
            STaxApply = "Y";
        if (TDS_yn.Checked)
            TDSApply = "Y";
        string VoucherType = "", VoucherType_Desc = "", Betype = "", FinCloseDt = "";

        if (RD_Process_Bill.Checked)
        {
            VoucherType_Desc = "Bill Entry";
            VoucherType = "BE";
            Betype = "BE_NP";
            FinCloseDt = "NULL";
        }
        else if (RD_Process_Payment.Checked)
        {
            VoucherType_Desc = "Bill Entry";
            VoucherType = "BAL";
            Betype = "BE_FPP";
            FinCloseDt = fn.Mydate1(Txt_VDate.Text.ToString());
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
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + VoucherType_Desc + "&ErrorMsg=" + ErrorMsg);
                }
            }
            //if (ddlPayMode.SelectedValue == "Cash" || ddlPayMode.SelectedValue == "Both")
            //{
            //    Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmt.Text), fn.Mydate(TxtVoucherDT.Text.ToString()));
            //    if (Cnt == "F")
            //    {
            //        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
            //        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + VoucherType_Desc + "&ErrorMsg=" + ErrorMsg);
            //    }
            //}
        }
        string Xml_PAY_Det = "<root>";
        TextBox[] txtcharge = new TextBox[10];
       // if (Trn_CalledAs == "THC")
       // {
            foreach (GridViewRow gridrow in GV_THC_BAL_PAYMENT.Rows)
            {
                TextBox indpcamt = (TextBox)gridrow.FindControl("indpcamt");
                TextBox indothamt = (TextBox)gridrow.FindControl("indothamt");
              //  TextBox indNetPaymentAmt = (TextBox)gridrow.FindControl("indNetPaymentAmt");
                
                TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                TextBox indNetPaymentAmt = (TextBox)gridrow.FindControl("indNetPaymentAmt");
                Label docno = (Label)gridrow.FindControl("docno");
                HiddenField Hnd_DocumentType = (HiddenField)gridrow.FindControl("Hnd_DOcumentType");
                TextBox TxtIncChrg = (TextBox)gridrow.FindControl("TxtIncChrg");
                TextBox TxtPenChrg = (TextBox)gridrow.FindControl("TxtPenChrg");
                TextBox TxtDedChrg = (TextBox)gridrow.FindControl("TxtDedChrg");

                Xml_PAY_Det = Xml_PAY_Det + "<PAY_Det><EntryType>" + VoucherType_Desc + "</EntryType>";
                Xml_PAY_Det = Xml_PAY_Det + "<Betype>" + Betype + "</Betype>";
                Xml_PAY_Det = Xml_PAY_Det + "<BillAmt>" + Txt_billamt.Text.ToString() + "</BillAmt>";
                Xml_PAY_Det = Xml_PAY_Det + "<PendAmt>" + Txt_PendingAmt.Text.ToString() + "</PendAmt>";
                Xml_PAY_Det = Xml_PAY_Det + "<PayAmt>" + Txt_PaymentAmt.Text.ToString() + "</PayAmt>";
                Xml_PAY_Det = Xml_PAY_Det + "<Vendor_BE_Date>" + fn.Mydate1(Txt_VDate.Text.ToString()) + "</Vendor_BE_Date>";
                Xml_PAY_Det = Xml_PAY_Det + "<FinCloseDt>" + FinCloseDt + "</FinCloseDt>";
                Xml_PAY_Det = Xml_PAY_Det + "<DueDays>0</DueDays>";
                Xml_PAY_Det = Xml_PAY_Det + "<DueDate>" + fn.Mydate1(System.DateTime.Today.ToString("dd/MM/yyyy")) + "</DueDate>";
                Xml_PAY_Det = Xml_PAY_Det + "<PCAMT>" + indpcamt.Text.ToString() + "</PCAMT>";
                Xml_PAY_Det = Xml_PAY_Det + "<OTHAMT>0</OTHAMT>";
                Xml_PAY_Det = Xml_PAY_Det + "<ADVPAID>" + indadvamt.Text.ToString() + "</ADVPAID>";
                Xml_PAY_Det = Xml_PAY_Det + "<DocNetPay>" + indNetPaymentAmt.Text.ToString() + "</DocNetPay>";
                Xml_PAY_Det = Xml_PAY_Det + "<docno>" + docno.Text.ToString() + "</docno>";
                Xml_PAY_Det = Xml_PAY_Det + "<PAYDT>" + fn.Mydate1(TxtVoucherDT.Text.ToString()) + "</PAYDT>";
                Xml_PAY_Det = Xml_PAY_Det + "<Manual_Voucherno>" + Txt_Manual_Voucherno.Text.ToString() + "</Manual_Voucherno>";
                if (RD_Process_Payment.Checked)
                {
                    Xml_PAY_Det = Xml_PAY_Det + "<PayMode>" + ddlPayMode.SelectedValue.ToString() + "</PayMode>";
                    Xml_PAY_Det = Xml_PAY_Det + "<CashAmt>" + txtCashAmt.Text.ToString() + "</CashAmt>";
                    Xml_PAY_Det = Xml_PAY_Det + "<Cashcode>" + ddrCashcode.SelectedValue + "</Cashcode>";
                    Xml_PAY_Det = Xml_PAY_Det + "<ChqAmt>" + txtChqAmt.Text.ToString() + "</ChqAmt>";
                    Xml_PAY_Det = Xml_PAY_Det + "<ChqNo>" + txtChqNo.Text.ToString() + "</ChqNo>";
                    if (ddlPayMode.SelectedValue.ToString() == "Cash")
                    {
                        Xml_PAY_Det = Xml_PAY_Det + "<Bankaccode>" + "" + "</Bankaccode>";
                        Xml_PAY_Det = Xml_PAY_Det + "<Bankaccodesc>" + "" + "</Bankaccodesc>";
                    }
                    else
                    {
                        Xml_PAY_Det = Xml_PAY_Det + "<Bankaccode>" + ddrBankaccode.SelectedValue.ToString() + "</Bankaccode>";
                        Xml_PAY_Det = Xml_PAY_Det + "<Bankaccodesc>" + ddrBankaccode.SelectedItem.Text.ToString() + "</Bankaccodesc>";
                    }

                    Xml_PAY_Det = Xml_PAY_Det + "<ChqDate>" + fn.Mydate1(txtChqDate.Text.ToString()) + "</ChqDate>";

                    Xml_PAY_Det = Xml_PAY_Det + "<NetPay>" + txtNetPay.Text.ToString() + "</NetPay>";
                }
                /*************Balance Payment Charges Details STARTS ***************************/
                Xml_PAY_Det = Xml_PAY_Det + "<IncChrg>" + TxtIncChrg.Text.ToString() + "</IncChrg>";
                Xml_PAY_Det = Xml_PAY_Det + "<PenChrg>" + TxtPenChrg.Text.ToString() + "</PenChrg>";
                Xml_PAY_Det = Xml_PAY_Det + "<DedChrg>" + TxtDedChrg.Text.ToString() + "</DedChrg>";
                //for (int i = 1; i < 11; i++)
                //{
                //    txtcharge[i - 1] = (TextBox)gridrow.FindControl("SCHG" + i.ToString());
                //    Xml_PAY_Det = Xml_PAY_Det + "<SCHG" + i + ">" + txtcharge[i - 1].Text.ToString() + "</SCHG" + i + ">";
                //    // Tot_Ded = Tot_Ded + Convert.ToDouble(txtcharge[i - 1].Text.ToString());
                //}
                /*************Party Details  ***************************/
                Xml_PAY_Det = Xml_PAY_Det + "<Vendorcode>" + Vendorcode.ToString() + "</Vendorcode>";
                Xml_PAY_Det = Xml_PAY_Det + "<VendorName>" + VendorName.ToString() + "</VendorName>";
                /*************STax/TDS Charges Details END ***************************/
                Xml_PAY_Det = Xml_PAY_Det + "<STaxApply>" + STaxApply.ToString() + "</STaxApply>";
                Xml_PAY_Det = Xml_PAY_Det + "<TDSApply>" + TDSApply.ToString() + "</TDSApply>";
                Xml_PAY_Det = Xml_PAY_Det + "<Stax>" + txtServiceTax.Text.ToString() + "</Stax>";
                Xml_PAY_Det = Xml_PAY_Det + "<Cess>" + txtEduCess.Text.ToString() + "</Cess>";
                Xml_PAY_Det = Xml_PAY_Det + "<HCess>" + txtHEduCess.Text.ToString() + "</HCess>";
                Xml_PAY_Det = Xml_PAY_Det + "<TdsRate>" + txtTDSRate.Text.ToString() + "</TdsRate>";
                Xml_PAY_Det = Xml_PAY_Det + "<TdsAmt>" + txtTDSAmt.Text.ToString() + "</TdsAmt>";
                Xml_PAY_Det = Xml_PAY_Det + "<TdsLedger>" + Tdssection.SelectedValue.ToString() + "</TdsLedger>";
                Xml_PAY_Det = Xml_PAY_Det + "<STaxRegNo>" + txtSrvTaxNo.Text.ToString() + "</STaxRegNo>";
                Xml_PAY_Det = Xml_PAY_Det + "<PANNO>" + txtPanNo.Text.ToString() + "</PANNO>";
                Xml_PAY_Det = Xml_PAY_Det + "<Txt_Remarks>" + Txt_Remarks.Text.ToString() + "</Txt_Remarks>";
               // Xml_PAY_Det = Xml_PAY_Det + "<COMPANY_CODE>" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "</COMPANY_CODE>";
                Xml_PAY_Det = Xml_PAY_Det + "<DocumentType>" + Hnd_DocumentType.Value.ToString() + "</DocumentType></PAY_Det>";
            }
       // }
        Xml_PAY_Det = Xml_PAY_Det + "</root>";
        string Voucherno = "";
        //Voucherno = VendorPayment_Utility.Insert_Advance_Balance_BillEntry_Data(Xml_PAY_Det, "BE");

        if (IsTokenValid())
        {
            ConsumeToken();

            string Sql = "EXEC [Usp_Doc_BillEntry] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
            if (DR.Read())
            {
                Voucherno = DR[0].ToString() + "~" + DR[1].ToString();
            }
            //string VoucherType = "ADV";
            Response.Redirect("BillEntry_Done.aspx?Voucherno=" + Voucherno + "&VoucherType=" + Betype);
        }
    }
    int J = 0, RowCnt = 0;
    public void CustomersGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        RowCnt = RowCnt + 1;
        int Index_Plus = 5;
        GridView oGridView = (GridView)sender;
        if (oGridView.ID == "GridView1")
        {
            Index_Plus = 0;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
            TextBox[] txtcharge = new TextBox[23];
            Label Header_Chg;
            //HiddenField Hnd_CHG = (HiddenField)e.Row.FindControl("Hnd_SCHG");
            TextBox indNetBillPaymentAmt = (TextBox)e.Row.FindControl("indNetBillPaymentAmt");
            TextBox TxtIncChrg = (TextBox)e.Row.FindControl("TxtIncChrg");
            TextBox TxtPenChrg = (TextBox)e.Row.FindControl("TxtPenChrg");
            TextBox TxtDedChrg = (TextBox)e.Row.FindControl("TxtDedChrg");

            TxtIncChrg.Attributes.Add("onblur", "javascript:Total_calC_THC_BalPayment(this,'RT_Based')");
            TxtPenChrg.Attributes.Add("onblur", "javascript:Total_calC_THC_BalPayment(this,'RT_Based')");
            TxtDedChrg.Attributes.Add("onblur", "javascript:Total_calC_THC_BalPayment(this,'RT_Based')");
            indNetBillPaymentAmt.Attributes.Add("onblur", "javascript:Total_calC_THC_BalPayment(this,'RT_Based')");

            //for (int i = 1; i < 4; i++)
            //{
            //    txtcharge[i] = (TextBox)e.Row.FindControl("SCHG" + i.ToString());
            //    txtcharge[i].Attributes.Add("onblur", "javascript:Total_calC_THC_BalPayment(this," + RowCnt + "," + i.ToString() + ",'RT_Based')");
            //    indNetBillPaymentAmt.Attributes.Add("onblur", "javascript:Total_calC_THC_BalPayment(this," + RowCnt + "," + i.ToString() + ",'RT_Based')");
                //e.Row.Cells[i + Index_Plus].Visible = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString());
                //oGridView.HeaderRow.Cells[i + Index_Plus].Visible = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString());
                //    if (Footer_Visibleflag == "")
                //    {
                //        Footer_Visibleflag = Get_Charges_Value(Hnd_CHG.Value).ToString();
                //    }
                //    else
                //    {
                //        Footer_Visibleflag = Footer_Visibleflag + '~' + Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString()).ToString();
                //    }
                //Header_Chg = (Label)oGridView.HeaderRow.FindControl("Lbl_Chg_" + i.ToString());
                //Header_Chg.Text = Get_Charges_Header_Text(Hnd_CHG_Arr[i - 1].ToString());
            //}
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            string[] Arr_Footer_Visibleflag = Footer_Visibleflag.ToString().Split('~');
            //for (int i = 1; i < 11; i++)
            //{
            //        e.Row.Cells[i + Index_Plus].Visible = (Arr_Footer_Visibleflag[i - 1].ToString() == "False") ? false : true;
            //}
        }
    }
    public bool Get_Charges_Value(string Hnd_CHG_value)
    {
        string[] Arr_Hnd_CHG = Hnd_CHG_value.ToString().Split('~');
        //string Bill_ColFlag = Arr_Hnd_CHG[2].ToString();
        string Active_Flag = Arr_Hnd_CHG[2].ToString();
        bool Rturn_Value = false;
        if (Active_Flag == "Y")
        {
            Rturn_Value = true;
        }
        return Rturn_Value;
    }
    public string Get_Charges_Header_Text(string Hnd_CHG_value)
    {
        string[] Arr_Hnd_CHG = Hnd_CHG_value.ToString().Split('~');
        string Charges_Header_Text = Arr_Hnd_CHG[1].ToString() + "(" + Arr_Hnd_CHG[3].ToString() + ")";
        return Charges_Header_Text;
    }
}

 

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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment : System.Web.UI.Page
{
    public string billno_nos, Branch, documentprint, voucherNo;
    //public string DOCNO_Str = "", Vendorcode = "", VendorName = "", ManualNo_Str = "", Fromdate = "", Todate = "", RouteMode = "", Trn_Typ = "", Trn_Typ_Desc = "", Trn_Doc = "", Trn_CalledAs = "", Trn_Doc_Typ = "";
    string Footer_Visibleflag = "";
    MyFunctions fn = new MyFunctions();
    string Finyear = "";
    string Curr_Year = "";
    string FIN_Start = "", Flag = "", Financial_Year = "", fin_year = "", Trn_Typ_Desc="";
    private string DOCNO_Str { get { return (ViewState["DOCNO_Str"] != null) ? ViewState["DOCNO_Str"].ToString() : ""; } set { ViewState["DOCNO_Str"] = value; } }
    private string Vendorcode { get { return (ViewState["Vendorcode"] != null) ? ViewState["Vendorcode"].ToString() : ""; } set { ViewState["Vendorcode"] = value; } }
    private string VendorName { get { return (ViewState["VendorName"] != null) ? ViewState["VendorName"].ToString() : ""; } set { ViewState["VendorName"] = value; } }
    private string ManualNo_Str { get { return (ViewState["ManualNo_Str"] != null) ? ViewState["ManualNo_Str"].ToString() : ""; } set { ViewState["ManualNo_Str"] = value; } }
    private string Fromdate { get { return (ViewState["Fromdate"] != null) ? ViewState["Fromdate"].ToString() : ""; } set { ViewState["Fromdate"] = value; } }
    private string Todate { get { return (ViewState["Todate"] != null) ? ViewState["Todate"].ToString() : ""; } set { ViewState["Todate"] = value; } }
   // private string ManualNo_Str { get { return (ViewState["ManualNo_Str"] != null) ? ViewState["ManualNo_Str"].ToString() : ""; } set { ViewState["ManualNo_Str"] = value; } }
    private string Trn_Typ { get { return (ViewState["Trn_Typ"] != null) ? ViewState["Trn_Typ"].ToString() : ""; } set { ViewState["Trn_Typ"] = value; } }
    //private string Trn_Doc { get { return (ViewState["Trn_Doc"] != null) ? ViewState["Trn_Doc"].ToString() : ""; } set { ViewState["Trn_Doc"] = value; } }
    //private string Trn_CalledAs { get { return (ViewState["Trn_CalledAs"] != null) ? ViewState["Trn_CalledAs"].ToString() : ""; } set { ViewState["Trn_CalledAs"] = value; } }
    //private string Trn_Doc_Typ { get { return (ViewState["Trn_Doc_Typ"] != null) ? ViewState["Trn_Doc_Typ"].ToString() : ""; } set { ViewState["Trn_Doc_Typ"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Curr_Year = DateTime.Now.ToString("yyyy");
        if (Finyear == Curr_Year)
        {
            FIN_Start = "01 Apr " + Curr_Year.Substring(2,2);
        }
        else
        {
            FIN_Start = "01 Apr " + Financial_Year;
        }
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
       
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
        Hnd_ServerDt.Value = System.DateTime.Today.ToString("dd/MM/yyyy");
        if (!IsPostBack && !IsCallback)
        {
            Fromdate = Request.QueryString.Get("Fromdate");
            Vendorcode = Request.QueryString.Get("Vendorcode");
            VendorName = Request.QueryString.Get("VendorName");
            Todate = Request.QueryString.Get("Todate");
            if(DOCNO_Str=="")
                DOCNO_Str = Request.QueryString.Get("Docnos");
            ManualNo_Str = Request.QueryString.Get("ManualNo_Str");
            Trn_Typ = Request.QueryString.Get("Trn_Typ");
            //Trn_Doc = Request.QueryString.Get("Trn_Doc");
            //Trn_CalledAs = Request.QueryString.Get("Trn_CalledAs");
            //Trn_Doc_Typ = Request.QueryString.Get("Trn_Doc_Typ");
            BindGrid();
            //VendorPayment_Utility.BindGrid(GV_THC_ADV_PAYMENT, Trn_Doc_Typ, Trn_Typ, Fromdate, Todate, Vendorcode, DOCNO_Str, ManualNo_Str, SessionUtilities.CurrentBranchCode, Trn_Doc_Typ, "", "");
            TxtVoucherDT.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            Txt_Next_Loc.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
        }
        string GRID_ID = "";
        TR_THC_ADV.Visible = true;
        GRID_ID = "GV_THC_ADV_PAYMENT";
        //Lbl_Title.Text = Trn_Doc + " " + Trn_Typ_Desc + " Vendor Payment";
        fn.Fill_Location_Dataset();
        btnSubmit.Attributes.Add("onclick", "javascript:return THC_ADVPayment_OnSubmit('" + GRID_ID + "')");
    }
    public void BindGrid()
    {
        DataTable dtDDMRList = new DataTable();

        string SQLStr = "EXEC WEBX_DDMR_Payment_Listing '" + Trn_Typ + "','" + Fromdate + "','" + Todate + "','" + Vendorcode + "','" + DOCNO_Str + "','" + ManualNo_Str + "','" + SessionUtilities.CurrentBranchCode + "'";

        dtDDMRList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GV_THC_ADV_PAYMENT.DataSource = dtDDMRList;
        GV_THC_ADV_PAYMENT.DataBind();
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

        string[] Txt_Next_Loc_arr = Txt_Next_Loc.Text.ToString().Split('~');

        string Cnt = "";
        Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChqNo.Text.ToString(), fn.Mydate1(txtChqDate.Text.ToString()));
        //if (ddlPayMode.SelectedValue != "Cash")
        //{
        //    Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChqNo.Text.ToString(), fn.Mydate1(txtChqDate.Text.ToString()));
        //    if (Cnt == "F")
        //    {
        //        // Response.Write("<br><br><br><font class='blackboldfnt' color='red' ><B>Error : Duplicate Cheque Entered </b></font>");
        //       //  Response.End();
        //        string ErrorMsg = "Duplicate Cheque Entered";
        //        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Advance Payment" + "&ErrorMsg=" + ErrorMsg);

        //    }
        //}
        //if (ddlPayMode.SelectedValue == "Cash" || ddlPayMode.SelectedValue == "Both")
        //{
        //    Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmt.Text), fn.Mydate(TxtVoucherDT.Text.ToString()) );

        //    if (Cnt == "F")
        //    {
        //        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
        //        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Advance Payment" + "&ErrorMsg=" + ErrorMsg);
        //    }
        //} 

        string Xml_PAY_Det = "<root>";
        double Tot_Tds = 0, Tot_Ded = 0;
 
            foreach (GridViewRow gridrow in GV_THC_ADV_PAYMENT.Rows)
            {
                TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                TextBox indnetpay = (TextBox)gridrow.FindControl("Ind_BalAmt");
                Label docno = (Label)gridrow.FindControl("docno");
                //HiddenField Hnd_DocumentType = (HiddenField)gridrow.FindControl("Hnd_DocumentType");
                //TextBox[] txtcharge = new TextBox[10];
                Xml_PAY_Det = Xml_PAY_Det + "<PAY_Det><docno>" + docno.Text.ToString() + "</docno>";
                Xml_PAY_Det = Xml_PAY_Det + "<PAYDT>" + fn.Mydate1(TxtVoucherDT.Text.ToString()) + "</PAYDT>";
                Xml_PAY_Det = Xml_PAY_Det + "<Manual_Voucherno>" + Txt_Manual_Voucherno.Text.ToString() + "</Manual_Voucherno>";
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
                Xml_PAY_Det = Xml_PAY_Det + "<AdvAmt>" + indadvamt.Text.ToString() + "</AdvAmt>";
                Xml_PAY_Det = Xml_PAY_Det + "<BalAmt>" + indnetpay.Text.ToString() + "</BalAmt>";
                Xml_PAY_Det = Xml_PAY_Det + "<BalAmtBRCD>" + Txt_Next_Loc_arr[1].ToString() + "</BalAmtBRCD>";
                Xml_PAY_Det = Xml_PAY_Det + "<Vendorcode>" + Vendorcode.ToString() + "</Vendorcode>";
                Xml_PAY_Det = Xml_PAY_Det + "<VendorName>" + VendorName.ToString() + "</VendorName></PAY_Det>";
                //Xml_PAY_Det = Xml_PAY_Det + "<COMPANY_CODE>" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "</COMPANY_CODE>";
                //Xml_PAY_Det = Xml_PAY_Det + "<DocumentType>" + Hnd_DocumentType.Value.ToString() + "</DocumentType></PAY_Det>";
                
            }
        Xml_PAY_Det = Xml_PAY_Det + "</root>";
        string Voucherno = "";
        string Sql = "EXEC [Usp_DDMR_Advance_Payment] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (DR.Read())
        {
            Voucherno = DR[0].ToString() + "~" + DR[1].ToString();
        }
        string VoucherType = "ADV";
        Response.Redirect("Advance_Done.aspx?Voucherno=" + Voucherno + "&VoucherType=" + VoucherType);
    
    }
}

 

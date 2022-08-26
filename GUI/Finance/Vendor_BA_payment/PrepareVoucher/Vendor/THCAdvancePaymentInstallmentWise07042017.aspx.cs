using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePaymentInstallmentWise : System.Web.UI.Page
{
    private string billno_nos, Branch, documentprint, voucherNo;
    public string checkeddockno, fromdt, Todt, Financial_Year = "", PartyCode="";
    public int totdkt, srno;
    private int ContractAmt = 0;
    private double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, H_CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    MyFunctions fn = new MyFunctions();
    DateTime Fromdate, Todate;
    ThcInstallmentWiseAdvanceDataSet dsAdvanceCash = new ThcInstallmentWiseAdvanceDataSet();
    ThcInstallmentWiseAdvanceDataSet dsAdvanceCheque = new ThcInstallmentWiseAdvanceDataSet();
    ThcInstallmentWiseAdvanceDataSet dsOtherAdvance = new ThcInstallmentWiseAdvanceDataSet();
    
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srNoAdvanceCash = "", srNoAdvanceCheque = "", srNoOtherAdvance = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        Branch = Session["BRCD"].ToString();
        if (!IsPostBack)
        {
            btnSubmit.Enabled = true;
            billno_nos = Request.QueryString.Get("billno_nos");
            checkeddockno = Request.QueryString.Get("checkeddockno").ToString();
            HdnThcNo.Value = Request.QueryString.Get("checkeddockno").ToString();
            fromdt = Request.QueryString.Get("fromdt");
            Todt = Request.QueryString.Get("Todt");
            if (fromdt != "")
            {
                Fromdate = Convert.ToDateTime(fromdt);
                fromdt = Fromdate.ToString("dd/MM/yyyy");//Convert.ToString().ToString("dd/MM/yyyy");
            }

            if (Todt != "")
            {
                Todate = Convert.ToDateTime(Todt);
                Todt = Todate.ToString("dd/MM/yyyy");
            }
            txtVoucherDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            lblStandardAmt.Text = "0";
            //PopPaymentAcc();
            PopTDSType();
            BindGridThcAdvanceInstallmentWise();
            FillAdvanceDetails();

            PartyCode = VendorPayment_Utility.GetThcPartyCode(Request.QueryString.Get("checkeddockno").ToString());
            

            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                TextBox indpcamt = (TextBox)gridrow.FindControl("indpcamt");
                TextBox indothamt = (TextBox)gridrow.FindControl("indothamt");
                TextBox inddiscount = (TextBox)gridrow.FindControl("inddiscount");
                TextBox cboindsvctaxrate = (TextBox)gridrow.FindControl("cboindsvctaxrate");
                TextBox indsvctax = (TextBox)gridrow.FindControl("indsvctax");
                TextBox indcess = (TextBox)gridrow.FindControl("indcess");
                TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                TextBox ind_H_cess = (TextBox)gridrow.FindControl("ind_H_cess");
                TextBox indsvctaxded = (TextBox)gridrow.FindControl("indsvctaxded");
                TextBox indtds_rate = (TextBox)gridrow.FindControl("indtds_rate");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                TextBox TotalNetamt = (TextBox)gridrow.FindControl("TotalNetamt");
                HiddenField txtpendamt = (HiddenField)gridrow.FindControl("txtpendamt");
                HiddenField PANNO = (HiddenField)gridrow.FindControl("pan_no");
                ContractAmt = ContractAmt + Convert.ToInt32(indpcamt.Text);
                txtContractAmt.Text = ContractAmt.ToString();
                NetAmount1 = Convert.ToDouble(indpcamt.Text) + Convert.ToDouble(indothamt.Text) - Convert.ToDouble(indtdsded.Text) + Convert.ToDouble(indsvctax.Text) + Convert.ToDouble(indcess.Text) + Convert.ToDouble(ind_H_cess.Text) - Convert.ToDouble(indadvamt.Text);
                indnetpay.Text = NetAmount1.ToString();
                PaymentAmt = PaymentAmt + Convert.ToDouble(indadvamt.Text);
                if (indothamt.Text != "")
                {
                    OtherAmt = OtherAmt + Convert.ToDouble(indothamt.Text);
                    txtOtherAmt.Text = OtherAmt.ToString();
                }
                else
                {
                    txtOtherAmt.Text = "0.00";
                    indothamt.Text = "0.00";
                }
                if (indtdsded.Text != "")
                {
                    TDSDeduction = TDSDeduction + Convert.ToDouble(indtdsded.Text);
                    txtTDSAmt.Text = TDSDeduction.ToString();
                }
                else
                {
                    txtTDSAmt.Text = "0.00";
                    indtdsded.Text = "0.00";
                }
                if (indsvctax.Text != "")
                {
                    ServiceTax = ServiceTax + Convert.ToDouble(indsvctax.Text);
                    txtServiceTax.Text = ServiceTax.ToString();
                }
                else
                {
                    txtServiceTax.Text = "0.00";
                    indsvctax.Text = "0.00";
                }
                if (indcess.Text != "")
                {
                    CessAmount = CessAmount + Convert.ToDouble(indcess.Text);
                    cessamt.Text = CessAmount.ToString();
                }
                else
                {
                    cessamt.Text = "0.00";
                    indcess.Text = "0.00";
                }
                if (ind_H_cess.Text != "")
                {
                    H_CessAmount = H_CessAmount + Convert.ToDouble(ind_H_cess.Text);
                    H_cessamt.Text = H_CessAmount.ToString();
                }
                else
                {
                    H_cessamt.Text = "0.00";
                    ind_H_cess.Text = "0.00";
                }

                if (indadvamt.Text != "")
                {
                    AdvancePaid = AdvancePaid + Convert.ToDouble(indadvamt.Text);
                    txtAdvanceAmtPaid.Text = AdvancePaid.ToString();
                }
                else
                {
                    txtAdvanceAmtPaid.Text = "0.00";
                    indadvamt.Text = "0.00";
                }
                if (indnetpay.Text != "")
                {
                    NetAmount = NetAmount + Convert.ToDouble(indnetpay.Text);
                    txtBalanceAmt.Text = NetAmount.ToString();
                    //txtPaymentAmt.Text = NetAmount.ToString();
                }
                else
                {
                    txtBalanceAmt.Text = "0.00";
                    indnetpay.Text = "0.00";
                    //txtPaymentAmt.Text = "0.00";
                }
                //txtPaymentAmt.Text = "0.00";
                //txtCashAmount.Text = PaymentAmt.ToString();
                if (PANNO.Value == "")
                {
                    txtPANNO.Text = "PAN NOTAVL";
                }
                else
                {
                    txtPANNO.Text = Convert.ToString(PANNO.Value);
                }
            }

            //btnSubmit.Attributes.Add("onclick", "javascript:return check(" + txtAdvanceAmtPaid.ClientID + "," + txtBalanceAmt.ClientID + "," + cboModeOfTransaction.ClientID + "," + cboPaymentAccount.ClientID + "," + txtChequeNo.ClientID + "," + txtChequeDate.ClientID + "," + txtPaymentAmt.ClientID + ")");
            btnSubmit.Attributes.Add("onclick", "javascript:return check(" + txtAdvanceAmtPaid.ClientID + "," + txtBalanceAmt.ClientID + ")");
            BlankRowAdvanceCash("1");
            BindGridAdvanceCash();

            BlankRowAdvanceCheque("1");
            BindGridAdvanceCheque();

            BlankRowOtherAdvance("1");
            BindGridOtherAdvance();
        }
        txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'05','../../../../images/Date_Control_Rule_Check.aspx')");
        if (Session["empcd"].ToString() == "10001")
        {
            txtVoucherDate.Enabled = true;
        }
    }

    #region AdvanceCash
    protected void BindGridAdvanceCash()
    {
        DataView dv = dsAdvanceCash.ThcAdvanceCash.DefaultView;
        dgAdvanceCash.DataSource = dv;
        dgAdvanceCash.DataBind();
    }
    protected ThcInstallmentWiseAdvanceDataSet.ThcAdvanceCashRow GetDataRow(int rowIndex)
    {
        ThcInstallmentWiseAdvanceDataSet.ThcAdvanceCashRow _mydatarow;
        _mydatarow = dsAdvanceCash.ThcAdvanceCash[rowIndex];
        _mydatarow.SrNoAC = Convert.ToString((rowIndex + 1)).Trim();
        _mydatarow.InstallmentAmount = ((TextBox)dgAdvanceCash.Rows[rowIndex].FindControl("txtInstallmentAmount")).Text;
        return _mydatarow;
    }
    protected void MyDataRowsAdvanceCash()
    {
        srNoAdvanceCash = "";
        ThcInstallmentWiseAdvanceDataSet.ThcAdvanceCashRow datarow;
        foreach (GridViewRow gr in dgAdvanceCash.Rows)
        {
            if (gr.RowIndex != -1)
            {
                srNoAdvanceCash = Convert.ToString(gr.RowIndex + 2).Trim();
                BlankRowAdvanceCash("");
                datarow = dsAdvanceCash.ThcAdvanceCash[gr.RowIndex];
                datarow = GetDataRow(gr.RowIndex);
                dsAdvanceCash.ThcAdvanceCash[gr.RowIndex].ItemArray = datarow.ItemArray;
            }
        }
    }
    protected void BlankRowAdvanceCash(string srNoAdvanceCash)
    {
        dsAdvanceCash.ThcAdvanceCash.AddThcAdvanceCashRow(srNoAdvanceCash, "");
    }
    protected void AddNewRowAdvanceCash(Object sender, EventArgs e)
    {
        if (dgAdvanceCash.Rows.Count < 10)
        {
            MyDataRowsAdvanceCash();
            BlankRowAdvanceCash(srNoAdvanceCash);
            BindGridAdvanceCash();
        }
    }
    protected void dg_RowDataBoundAdvanceCash(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtInstallmentAmount = (TextBox)e.Row.FindControl("txtInstallmentAmount");
            txtInstallmentAmount.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');javascript:AdvCashInstallmentAmtCalc();");
        }
    }
    protected void dg_RowCommandAdvanceCash(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteRow")
        {
            MyDataRowsAdvanceCash();
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);

            if (((GridView)(sender)).Rows.Count > 1)
            {
                ThcInstallmentWiseAdvanceDataSet.ThcAdvanceCashRow dsRow;
                dsRow = dsAdvanceCash.ThcAdvanceCash[thisRow];
                dsAdvanceCash.ThcAdvanceCash.RemoveThcAdvanceCashRow(dsRow);
                BindGridAdvanceCash();
            }
        }
    }
    protected string GenerateArgumentAdvanceCash()
    {
        string arg = "";
        for (int index = 0; index < dgAdvanceCash.Rows.Count; index++)
        {
            TextBox txtInstallmentAmount = (TextBox)dgAdvanceCash.Rows[index].FindControl("txtInstallmentAmount");
            //string finyear = System.DateTime.Today.ToString("yy");
            //string Transdate = fn.Mydate(txtVoucherDate.Text);
            string finyear = Session["FinYear"].ToString().Substring(2, 2);
            string Transdate = fn.Mydate(DateTime.Now.ToString("dd/MM/yyyy"));
            if (txtInstallmentAmount.Text.Trim() != "")
            {
                if (index == 0)
                {
                    arg = HdnThcNo.Value.Trim() + "^" + "ADVCSH" + "^" + txtInstallmentAmount.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^-1";
                }
                else
                {
                    arg = arg + "," + HdnThcNo.Value.Trim() + "^" + "ADVCSH" + "^" + txtInstallmentAmount.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^-1";
                }
            }
        }
        return arg;
    }
    protected void dg_RowCreatedAdvanceCash(object sender, GridViewRowEventArgs e)
    {
    }
    #endregion

    #region AdvanceCheque
    protected void BindGridAdvanceCheque()
    {
        DataView dv = dsAdvanceCheque.ThcAdvanceCheque.DefaultView;
        dgAdvanceCheque.DataSource = dv;
        dgAdvanceCheque.DataBind();
    }
    protected ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow GetDataRowAdvanceCheque(int rowIndex)
    {
        ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow _mydatarow;
        _mydatarow = dsAdvanceCheque.ThcAdvanceCheque[rowIndex];
        _mydatarow.SrNoAdvChq = Convert.ToString((rowIndex + 1)).Trim();
        _mydatarow.ChequeNo = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtChequeNo")).Text;
        _mydatarow.BankName = ((DropDownList)dgAdvanceCheque.Rows[rowIndex].FindControl("cboBankName")).Text;
        _mydatarow.Date = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtDate")).Text;
        _mydatarow.Amount = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtAmount")).Text;
        _mydatarow.Favour = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtFavour")).Text;
        _mydatarow.CardNo = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtCardNo")).Text;
        _mydatarow.CardType = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtCardType")).Text;
        return _mydatarow;
    }
    protected void MyDataRowsAdvanceCheque()
    {
        srNoAdvanceCheque = "";
        ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow datarow;
        foreach (GridViewRow gr in dgAdvanceCheque.Rows)
        {
            if (gr.RowIndex != -1)
            {
                srNoAdvanceCheque = Convert.ToString(gr.RowIndex + 2).Trim();
                BlankRowAdvanceCheque("");
                datarow = dsAdvanceCheque.ThcAdvanceCheque[gr.RowIndex];
                datarow = GetDataRowAdvanceCheque(gr.RowIndex);
                dsAdvanceCheque.ThcAdvanceCheque[gr.RowIndex].ItemArray = datarow.ItemArray;
            }
        }
    }
    protected void BlankRowAdvanceCheque(string srNoAdvanceCheque)
    {
        dsAdvanceCheque.ThcAdvanceCheque.AddThcAdvanceChequeRow(srNoAdvanceCheque, "","", "", "", "","","");
    }
    protected void AddNewRowAdvanceCheque(Object sender, EventArgs e)
    {
        if (dgAdvanceCheque.Rows.Count < 10)
        {
            MyDataRowsAdvanceCheque();
            BlankRowAdvanceCheque(srNoAdvanceCheque);
            BindGridAdvanceCheque();
        }
    }
    protected void dg_RowDataBoundAdvanceCheque(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            txtAmount.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');javascript:AdvChqAmountAmtCalc();");

            DropDownList cbo = (DropDownList)e.Row.FindControl("cboBankName");
            //DataSet newds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "Usp_Thc_AdvanceInstallmentWise_GetBankList");
            //cbo.DataSource = newds1;
            //cbo.DataBind();
            //cbo.SelectedValue = "0Select";

            if (dsAdvanceCheque.ThcAdvanceCheque.Count > 0)
            {
                cbo.SelectedValue = dsAdvanceCheque.ThcAdvanceCheque[e.Row.RowIndex]["BankName"].ToString().Trim();
            }
        }
    }
    protected void dg_RowCommandAdvanceCheque(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteRow")
        {
            MyDataRowsAdvanceCheque();
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);

            if (((GridView)(sender)).Rows.Count > 1)
            {
                ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow dsRow;
                dsRow = dsAdvanceCheque.ThcAdvanceCheque[thisRow];
                dsAdvanceCheque.ThcAdvanceCheque.RemoveThcAdvanceChequeRow(dsRow);
                BindGridAdvanceCheque();
            }
        }
    }
    protected string GenerateArgumentAdvanceCheque()
    {
        string arg = "";
        int defaultVal = 0;
        string argVal = "";
        for (int index = 0; index < dgAdvanceCheque.Rows.Count; index++)
        {
            TextBox txtChequeNo = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtChequeNo");
            DropDownList cboBankName = (DropDownList)dgAdvanceCheque.Rows[index].FindControl("cboBankName");
            TextBox txtDate = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtDate");
            TextBox txtAmount = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtAmount");
            TextBox txtFavour = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtFavour");

            TextBox txtCardNo = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtCardNo");
            TextBox txtCardType = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtCardType");

            //string finyear = System.DateTime.Today.ToString("yy");
            //string Transdate =  fn.Mydate(txtVoucherDate.Text) ;
            string finyear = Session["FinYear"].ToString().Substring(2, 2);
            string Transdate = fn.Mydate(DateTime.Now.ToString("dd/MM/yyyy"));
            if (rbtLstAdvanceCheque.SelectedValue == "I")
            { 
            if (txtAmount.Text.Trim() != "")
            {
                if (index == 0)
                {
                    arg = HdnThcNo.Value.Trim() + "^" + "ADVCHQ" + "^" + txtAmount.Text.Trim() + "^" + txtChequeNo.Text.Trim() + "^" + cboBankName.Text.Trim() + "^" + fn.Mydate(txtDate.Text.Trim()) + "^" + txtFavour.Text.Trim() + "^" + rbtLstAdvanceCheque.SelectedValue.ToString().Trim() + "^" + txtBranchName.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^" + txtCardNo.Text.Trim() + "^" + txtCardType.Text.Trim() + "^-1";
                }
                else
                {
                    arg = arg + "," + HdnThcNo.Value.Trim() + "^" + "ADVCHQ" + "^" + txtAmount.Text.Trim() + "^" + txtChequeNo.Text.Trim() + "^" + cboBankName.Text.Trim() + "^" + fn.Mydate(txtDate.Text.Trim()) + "^" + txtFavour.Text.Trim() + "^" + rbtLstAdvanceCheque.SelectedValue.ToString().Trim() + "^" + txtBranchName.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^" + txtCardNo.Text.Trim() + "^" + txtCardType.Text.Trim() + "^-1";
                }
            }
            }
            else {
                arg = HdnThcNo.Value.Trim() + "^" + "ADVCHQ" + "^" + defaultVal + "^" + argVal + "^" + argVal + "^" + fn.Mydate(System.DateTime.Today.ToString("dd/MM/yyyy")) + "^" + argVal + "^" + rbtLstAdvanceCheque.SelectedValue.ToString().Trim() + "^" + txtBranchName.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^" + txtCardNo.Text.Trim() + "^" + txtCardType.Text.Trim() + "^-1";
            }
        }
        return arg;
    }
    protected void dg_RowCreatedAdvanceCheque(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cbo = (DropDownList)e.Row.FindControl("cboBankName");
            if (dsAdvanceCheque.ThcAdvanceCheque.Count > 0 && (cbo.SelectedValue=="0Select" || cbo.SelectedValue=="")  )
            {
                //ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "Usp_Thc_AdvanceInstallmentWise_GetBankList");
                  ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "Usp_Thc_AdvanceInstallmentWise_GetBankListNew", new SqlParameter("@brcd", Session["brcd"].ToString().Trim()));
                cbo.DataSource = ds1;
                cbo.DataBind();
            }

            
            
        }
    }
    #endregion

    #region OtherAdvance
    protected void BindGridOtherAdvance()
    {
        DataView dv = dsOtherAdvance.ThcOtherAdvance.DefaultView;
        dgOtherAdvance.DataSource = dv;
        dgOtherAdvance.DataBind();
    }
    protected ThcInstallmentWiseAdvanceDataSet.ThcOtherAdvanceRow GetDataRowOtherAdvance(int rowIndex)
    {
        ThcInstallmentWiseAdvanceDataSet.ThcOtherAdvanceRow _mydatarow;
        _mydatarow = dsOtherAdvance.ThcOtherAdvance[rowIndex];
        _mydatarow.SrNoOA = Convert.ToString((rowIndex + 1)).Trim();
        _mydatarow.Perticular = ((TextBox)dgOtherAdvance.Rows[rowIndex].FindControl("txtPerticular")).Text;
        _mydatarow.Vendor = ((TextBox)dgOtherAdvance.Rows[rowIndex].FindControl("txtVendor")).Text;
        _mydatarow.ReferenceNo = ((TextBox)dgOtherAdvance.Rows[rowIndex].FindControl("txtReferenceNo")).Text;
        _mydatarow.Unit = ((TextBox)dgOtherAdvance.Rows[rowIndex].FindControl("txtUnit")).Text;
        _mydatarow.Amount = ((TextBox)dgOtherAdvance.Rows[rowIndex].FindControl("txtAmount")).Text;
        return _mydatarow;
    }
    protected void MyDataRowsOtherAdvance()
    {
        srNoOtherAdvance = "";
        ThcInstallmentWiseAdvanceDataSet.ThcOtherAdvanceRow datarow;
        foreach (GridViewRow gr in dgOtherAdvance.Rows)
        {
            if (gr.RowIndex != -1)
            {
                srNoOtherAdvance = Convert.ToString(gr.RowIndex + 2).Trim();
                BlankRowOtherAdvance("");
                datarow = dsOtherAdvance.ThcOtherAdvance[gr.RowIndex];
                datarow = GetDataRowOtherAdvance(gr.RowIndex);
                dsOtherAdvance.ThcOtherAdvance[gr.RowIndex].ItemArray = datarow.ItemArray;
            }
        }
    }
    protected void BlankRowOtherAdvance(string srNoOtherAdvance)
    {
        dsOtherAdvance.ThcOtherAdvance.AddThcOtherAdvanceRow(srNoOtherAdvance, "", "", "", "", "");
    }
    protected void AddNewRowOtherAdvance(Object sender, EventArgs e)
    {
        if (dgOtherAdvance.Rows.Count < 10)
        {
            MyDataRowsOtherAdvance();
            BlankRowOtherAdvance(srNoOtherAdvance);
            BindGridOtherAdvance();
        }
    }
    protected void dg_RowDataBoundOtherAdvance(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtVendor = (TextBox)e.Row.FindControl("txtVendor");
            TextBox txtPerticular = (TextBox)e.Row.FindControl("txtPerticular");
            TextBox txtReferenceNo = (TextBox)e.Row.FindControl("txtReferenceNo");
            TextBox txtUnit = (TextBox)e.Row.FindControl("txtUnit");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            txtVendor.Attributes.Add("OnBlur", "javascript:CheckVendor();");
            txtPerticular.Attributes.Add("OnBlur", "javascript:PerticularLen();");
            txtReferenceNo.Attributes.Add("OnBlur", "javascript:ReferenceNoLen();");
            txtUnit.Attributes.Add("OnBlur", "javascript:UnitLen();");
            txtAmount.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');javascript:AdvOthAmountAmtCalc();");
        }
    }
    protected void dg_RowCommandOtherAdvance(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteRow")
        {
            MyDataRowsOtherAdvance();
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);

            if (((GridView)(sender)).Rows.Count > 1)
            {
                ThcInstallmentWiseAdvanceDataSet.ThcOtherAdvanceRow dsRow;
                dsRow = dsOtherAdvance.ThcOtherAdvance[thisRow];
                dsOtherAdvance.ThcOtherAdvance.RemoveThcOtherAdvanceRow(dsRow);
                BindGridOtherAdvance();
            }
        }
    }
    protected string GenerateArgumentOtherAdvance()
    {
        string arg = "";
        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "";
        for (int index = 0; index < dgOtherAdvance.Rows.Count; index++)
        {
            TextBox txtPerticular = (TextBox)dgOtherAdvance.Rows[index].FindControl("txtPerticular");
            TextBox txtVendor = (TextBox)dgOtherAdvance.Rows[index].FindControl("txtVendor");
            TextBox txtReferenceNo = (TextBox)dgOtherAdvance.Rows[index].FindControl("txtReferenceNo");
            TextBox txtUnit = (TextBox)dgOtherAdvance.Rows[index].FindControl("txtUnit");
            TextBox txtAmount = (TextBox)dgOtherAdvance.Rows[index].FindControl("txtAmount");
            if (txtVendor.Text != "") { 
            ARR_vendcd = txtVendor.Text.Split('~');
            VendorCD = ARR_vendcd[0].ToString();
            VendorNM = ARR_vendcd[1].ToString();
            }
            else
            {
                //ARR_vendcd = txtVendor.Text.Split('~');
                VendorCD = "";
                VendorNM = "";
            }
            //string finyear = System.DateTime.Today.ToString("yy");
            string finyear =Session["FinYear"].ToString().Substring(2, 2);
            string Transdate = fn.Mydate(DateTime.Now.ToString("dd/MM/yyyy"));
            if (txtAmount.Text.Trim() != "")
            {
                if (index == 0)
                {
                    arg = HdnThcNo.Value.Trim() + "^" + "ADVOTH" + "^" + txtAmount.Text.Trim() + "^" + txtPerticular.Text.Trim() + "^" + VendorCD.Trim() + "^" + txtReferenceNo.Text.Trim() + "^" + txtUnit.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^-1";
                }
                else
                {
                    arg = arg + "," + HdnThcNo.Value.Trim() + "^" + "ADVOTH" + "^" + txtAmount.Text.Trim() + "^" + txtPerticular.Text.Trim() + "^" + VendorCD.Trim() + "^" + txtReferenceNo.Text.Trim() + "^" + txtUnit.Text.Trim() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^-1";
                }
            }
        }
        return arg;
    }
    protected void dg_RowCreatedOtherAdvance(object sender, GridViewRowEventArgs e)
    {
    }
    #endregion

    //private void PopPaymentAcc()
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    string sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";

    //    SqlCommand sqlCommand = new SqlCommand(sql, conn);
    //    DataSet ds = new DataSet();

    //    SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
    //    da.Fill(ds, "tab1");

    //    cboPaymentAccount.DataSource = ds;
    //    cboPaymentAccount.DataTextField = "accdesc";
    //    cboPaymentAccount.DataValueField = "asscodeval";
    //    cboPaymentAccount.DataBind();
    //}
    //protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    if (cboModeOfTransaction.SelectedValue.ToString() != "")
    //    {
    //        string sql = "";

    //        if (cboModeOfTransaction.SelectedValue.ToString() != "Cash")
    //        {
    //            sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
    //        }
    //        else
    //        {
    //            sql = "select  acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
    //        }
    //        SqlCommand sqlCommand = new SqlCommand(sql, conn);
    //        DataSet ds = new DataSet();

    //        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
    //        da.Fill(ds, "tab1");

    //        cboPaymentAccount.DataSource = ds;
    //        cboPaymentAccount.DataTextField = "accdesc";
    //        cboPaymentAccount.DataValueField = "asscodeval";
    //        cboPaymentAccount.DataBind();
    //        cboPaymentAccount.CssClass = "blackfnt";
    //    }
    //}
    private void PopTDSType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select acccode+'~'+Accdesc as codeval,Accdesc from webx_acctinfo where acccode ='CLA0015'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboTDSType.DataSource = ds;
        cboTDSType.DataTextField = "Accdesc";
        cboTDSType.DataValueField = "codeval";
        cboTDSType.DataBind();
    }
    public void FillAdvanceDetails()
    {
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sql = "Exec Usp_ThcV2_AdvanceDetailsInstallmentWise '" + checkeddockno.ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            txtAdvanceCash.Text = dr["AdvanceCash"].ToString();
            txtAdvanceCheque.Text = dr["AdvanceCheque"].ToString();
            txtVarChqAmt.Text = dr["AdvanceCheque"].ToString();
            txtOtherAdvance.Text = dr["OtherAdvance"].ToString();
            txtTotalAdvance.Text = dr["TotalAdvance"].ToString();
        }
        dr.Close();
        con.Close();

        if (Convert.ToDouble(txtAdvanceCash.Text) <= 0)
        {
            RowAdvanceCash.Visible = false;
        }
        if (Convert.ToDouble(txtAdvanceCheque.Text) <= 0)
        {
            RowAdvanceCheque.Visible = false;
            RowAdvanceChequeGrid.Visible = false;
        }
        if (Convert.ToDouble(txtOtherAdvance.Text) <= 0)
        {
            RowOtherAdvance.Visible = false;
        }
    }
    public void BindGridThcAdvanceInstallmentWise()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlTHCPDC = "WEBX_document_Detail_m";
        SqlCommand cmd = new SqlCommand(sqlTHCPDC, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;
        myAdapter.SelectCommand.Parameters.Add("@docno", SqlDbType.VarChar).Value = checkeddockno.ToString().Trim();
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata");
        totdkt = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        btnSubmit.Enabled = false;
        btnSubmit.Visible = false;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        double cheque = Convert.ToDouble(txtAdvanceAmtPaid.Text.ToString());
        string advamtpaidBy = txtAdvanceAmtPaidBy.Text;
        string balamount = txtBalanceAmt.Text;
        string balpayat = txtBalancePayableAt.Text;
        //string chequeDate = txtChequeDate.Text;
        //string chequeNo = "'" + txtChequeNo.Text + "'",
         string adv_Chqamt = "", adv_colamt = "";
        //if (chequeNo == "")
        //{
        //    chequeNo = "Null";
        //}
        double paymentAmt = 0.00;
        string voucherDate = txtVoucherDate.Text;
        //string tranmode = cboModeOfTransaction.Text;
        //string paymentacc = cboPaymentAccount.SelectedItem.Text.ToString();
        //if (tranmode == "Cash")
        //{
        //    chequeDate = "NULL";
        //    chequeNo = "Null";
        //    paymentAmt = Convert.ToDouble(txtCashAmount.Text);
        //    if (paymentAmt > 35000)
        //    {
        //        string ErrorMsg = "Cash Amount Must Be Less Than Or Equal 35000 !!!";
        //        Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Cash limit violate" + "&ErrorMsg=" + ErrorMsg);
        //    }

        //    string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmount.Text), fn.Mydate(txtVoucherDate.Text));
        //    if (Cnt == "F")
        //    {
        //        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
        //        Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
        //    }
        //}
        //else
        //{
        //    chequeDate = "'" + fn.Mydate(chequeDate) + "'";
        //    paymentAmt = Convert.ToDouble(txtPaymentAmt.Text);
        //    string Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChequeNo.Text, fn.Mydate1(txtChequeDate.Text));
        //    if (Cnt == "F")
        //    {
        //        string ErrorMsg1 = "Duplicate Cheque Entered";
        //        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
        //    }
        //}

        string Transdate = "'" + fn.Mydate(txtVoucherDate.Text) + "'";
        //string[] Payment_acc_detail = cboPaymentAccount.SelectedValue.ToString().Split('~');
        //string BankAcccode = Payment_acc_detail[0].ToString();
        //string acccategory = Payment_acc_detail[1].ToString();
        //string Accdesc = Payment_acc_detail[2].ToString();
        //string acccode = BankAcccode;
        string PBOV_typ = "V";
        double TotChrg = 0;
        string[] tdsgrpcode_arr = cboTDSType.SelectedValue.ToString().Split('~');
        string tdsacccode = tdsgrpcode_arr[0].ToString();
        string tdsaccdesc = tdsgrpcode_arr[1].ToString();
        tdsacccode = "'" + tdsacccode + "'";
        tdsaccdesc = "'" + tdsaccdesc + "'";
        string sql_adv = "select isnull(max(srno),0) as srno  from webx_thc_AdvanceDetail";
        double Debit = 0, Credit = paymentAmt, Currbalance = 0, servicetaxCharged = 0;
        string brcd = Session["brcd"].ToString(), Deptcode = "", paid_to = "", servicetaxNo = "", bookcode = "ADVANCE VENDOR PAYMENT", svctaxacccode = "";
        SqlCommand cmd_adv = new SqlCommand(sql_adv, conn);
        SqlDataReader dr_adv;
        dr_adv = cmd_adv.ExecuteReader();
        while (dr_adv.Read())
        {
            srno = Convert.ToInt32(dr_adv[0].ToString());
            srno = srno + 1;
        }
        dr_adv.Close();

        string finyear = System.DateTime.Today.ToString("yy"); //fn.GetFinyear();

        //string s1 = "";
        //string sqlvoucher = "usp_next_VoucherNo_M";
        //SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        SqlCommand cmd_voucher = new SqlCommand();
        //cmdvou.CommandType = CommandType.StoredProcedure;
        //cmdvou.Parameters.AddWithValue("@brcd", Session["BRCD"].ToString());
        //cmdvou.Parameters.AddWithValue("@finyear", finyear);
        //cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        //SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        //DataSet dsvou = new DataSet();
        //davou.Fill(dsvou);

        //foreach (DataRow dr in dsvou.Tables[0].Rows)
        //{
        //    voucherNo = dr["vno"].ToString();
        //}


        SqlCommand Acct_cmd = new SqlCommand();
        string Vbrcd = Session["brcd"].ToString();
        //string Voucherno = fn.NextVoucherno(Session["BRCD"].ToString(), Financial_Year);
        //string Vno = fn.NextVoucherno(Session["BRCD"].ToString(), Financial_Year);
        SqlTransaction trn;
        trn = conn.BeginTransaction();

        try 
        {
            //if (paymentAmt > 0)
            //{
                // STEP 1 : ADVANCE CASH INSERT
                if (GenerateArgumentAdvanceCash() != "")
                {
                    string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtAdvanceCash.Text), fn.Mydate(txtVoucherDate.Text));
                    if (Cnt == "F")
                    {
                        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                        Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                    }
                }
                if (GenerateArgumentAdvanceCash() != "")
                {
                    string sqlAdvanceCashInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertAdvanceCash '" + GenerateArgumentAdvanceCash() + "','" + Session["empcd"].ToString() + "'";
                    SqlCommand cmdAdvanceCash = new SqlCommand(sqlAdvanceCashInsert, conn, trn);
                    cmdAdvanceCash.ExecuteNonQuery();
                }            
                // finyear,Transdate,Debit - Installment Amount,brcd,PartyCode

                // STEP 2 : ADVANCE CHEQUE INSERT
if (rbtLstAdvanceCheque.SelectedValue == "I")
                {
                if (GenerateArgumentAdvanceCheque() != "")
                {
                    foreach (GridViewRow gridrow in dgAdvanceCheque.Rows)
                    {
                        TextBox ChequeNo = (TextBox)gridrow.FindControl("txtChequeNo");
                        TextBox txtDate = (TextBox)gridrow.FindControl("txtDate");
                        string Cnt = VendorPayment_Utility.Duplicate_ChqNO(ChequeNo.Text.Trim(), fn.Mydate1(txtDate.Text));
                        if (Cnt == "F")
                        {
                            string ErrorMsg1 = "Duplicate Cheque Entered";
                            Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
                        }
                    }
                }
}
                if (GenerateArgumentAdvanceCheque() != "")
                {
                    string sqlAdvanceChequeInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertAdvanceCheque '" + GenerateArgumentAdvanceCheque() + "','" + Session["empcd"].ToString() + "'";
                    SqlCommand cmdAdvanceCheque = new SqlCommand(sqlAdvanceChequeInsert, conn, trn);
                    cmdAdvanceCheque.ExecuteNonQuery();
                }
                // finyear,Transdate,Debit - Installment Amount,brcd,PartyCode,acccode - Bank Acccode,chequeNo,chequeDate

                // STEP 3 : OTHER ADVANCE CASH INSERT
                if (GenerateArgumentOtherAdvance() != "")
                {
                    string sqlOtherAdvanceInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertOtherAdvance '" + GenerateArgumentOtherAdvance() + "','" + Session["empcd"].ToString() + "'";
                    SqlCommand cmdOtherAdvance = new SqlCommand(sqlOtherAdvanceInsert, conn, trn);
                    cmdOtherAdvance.ExecuteNonQuery();
                }

if (GenerateArgumentOtherAdvance() == "" && GenerateArgumentAdvanceCheque()=="")
                {
                    string sql2 = "update webx_thc_summary set advance_paid='Y' where THCNO='" + HdnThcNo.Value.Trim() + "' ";  
                    cmd_voucher = new SqlCommand(sql2, conn, trn);
                    cmd_voucher.ExecuteNonQuery();
                }

                // finyear,Transdate,Debit - Installment Amount,brcd,PartyCode

                //foreach (GridViewRow gridrow in dockdata.Rows)
                //{
                //    Label SrNo = (Label)gridrow.FindControl("SrNo");
                //    Label THCNO = (Label)gridrow.FindControl("THCNO");
                //    TextBox indpcamt = (TextBox)gridrow.FindControl("indpcamt");
                //    TextBox indothamt = (TextBox)gridrow.FindControl("indothamt");
                //    TextBox inddiscount = (TextBox)gridrow.FindControl("inddiscount");
                //    TextBox cboindsvctaxrate = (TextBox)gridrow.FindControl("cboindsvctaxrate");
                //    TextBox indsvctax = (TextBox)gridrow.FindControl("indsvctax");
                //    TextBox indcess = (TextBox)gridrow.FindControl("indcess");
                //    TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                //    TextBox indsvctaxded = (TextBox)gridrow.FindControl("indsvctaxded");
                //    TextBox indtds_rate = (TextBox)gridrow.FindControl("indtds_rate");
                //    TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                //    TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                //    HiddenField txtpendamt = (HiddenField)gridrow.FindControl("txtpendamt");
                //    HiddenField VendorCode = (HiddenField)gridrow.FindControl("vendor_code");
                //    HiddenField VendorName = (HiddenField)gridrow.FindControl("vendor_Name");
                //    HiddenField PANNO = (HiddenField)gridrow.FindControl("pan_no");

                //    documentprint = "'" + THCNO.Text + "',";
                //    string sql_AdvDetail = "INSERT INTO webx_thc_AdvanceDetail(srno,thcno,thcsf,adv_transtype,adv_colamt,adv_chqno,adv_chqdt,adv_chqamt,adv_voucherNo,adv_VoucherDt,adv_paidby,adv_acccode,adv_accdesc,vendor_code,vendor_name) VALUES (" + srno + ",'" + THCNO.Text + "','.','" + tranmode + "'," + paymentAmt + "," + chequeNo + "," + chequeDate + "," + cheque + ",'" + Vno + "',getdate(),'" + advamtpaidBy + "','" + paymentacc + "','" + Accdesc + "','" + VendorCode.Value + "','" + VendorName.Value + "')";
                //    SqlCommand cmd_AdvDetail = new SqlCommand(sql_AdvDetail, conn, trn);
                //    cmd_AdvDetail.ExecuteNonQuery();

                //    if (tranmode == "Cash")
                //    {
                //        chequeDate = "NULL";
                //        chequeNo = "Null";
                //        adv_Chqamt = "0.00";
                //        adv_colamt = indnetpay.Text.ToString();
                //    }
                //    else
                //    {
                //        adv_Chqamt = indnetpay.Text.ToString();
                //        adv_colamt = "0.00";
                //    }

                //    string sql = "update webx_thc_summary set pan_no='" + txtPANNO.Text + "',advamt_lastpaid='" + indadvamt.Text.ToString() + "',netbalamt='" + indnetpay.Text.ToString() + "',Advamt='" + indadvamt.Text.ToString() + "',Advance_paid='F',advvoucherNo='" + Vno + "',advvoucherdt=" + Transdate + ",advpaidat='" + brcd + "',adv_transtype='" + tranmode.ToString() + "',adv_Chqamt=" + adv_Chqamt + ",adv_colamt=" + adv_colamt + ",adv_Chqno=" + chequeNo + ",adv_Chqdate =" + chequeDate + ",adv_Acccode='" + BankAcccode + "',adv_AccCategory='" + acccategory + "' where THCNO='" + THCNO.Text + "' and thcsf='.'";  
                //    cmd_voucher = new SqlCommand(sql, conn, trn);
                //    cmd_voucher.ExecuteNonQuery();

                //    string sql_Adv_acct = "exec usp_THCTransaction 1,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                //    Acct_cmd = new SqlCommand(sql_Adv_acct, conn, trn);
                //    Acct_cmd.ExecuteNonQuery();

                //}

                //foreach (GridViewRow gridrow in dockdata.Rows)
                //{
                //    Label SrNo = (Label)gridrow.FindControl("SrNo");
                //    Label THCNO = (Label)gridrow.FindControl("THCNO");
                //    HiddenField Advance_paid = (HiddenField)gridrow.FindControl("Advance_paid");
                //    if (Advance_paid.Value == "N")
                //    {
                //        string sql_bal_acct = "exec usp_THCTransaction 2,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                //        Acct_cmd = new SqlCommand(sql_bal_acct, conn);
                //        Acct_cmd.ExecuteNonQuery();
                //    }

                //}

                //foreach (GridViewRow gridrow in dockdata.Rows)
                //{
                //    Label SrNo = (Label)gridrow.FindControl("SrNo");
                //    Label THCNO = (Label)gridrow.FindControl("THCNO");
                //    TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                //    HiddenField Advance_paid = (HiddenField)gridrow.FindControl("Advance_paid");
                //    if (Advance_paid.Value == "N")
                //    {
                //        if (Convert.ToDouble(indtdsded.Text) > 0)
                //        {
                //            string sql_bal_acct_tds = "exec usp_THCTransaction 3,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                //            Acct_cmd = new SqlCommand(sql_bal_acct_tds, conn);
                //            Acct_cmd.ExecuteNonQuery();
                //        }

                //    }
                //}
            //}
            //if (tranmode.ToString() == "Cheque")
            //{
            //    //****variable for cheque detail ************
            //    string acccodecb = BankAcccode;
            //    string depositdt = fn.Mydate(DateTime.Now.ToString("dd/MM/yyyy"));
            //    double CHQAMT = Convert.ToDouble(txtPaymentAmt.Text.ToString()), adjustamt = paymentAmt;
            //    string comments = "NULL";
            //    string bacd = "null";
            //    string banm = "null";
            //    string empnm = "null";
            //    string staffcd = "Null";
            //    string staffnm = "Null";
            //    string brnm = fn.GetLocation(Session["brcd"].ToString());
            //    string banknm = Accdesc.ToString();
            //    string BANKBRN = "";
            //    ///******************************************
            //    string sql = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt,Transtype,transdate,acccode,depoloccode,DepoFlag,voucherNo) values(" + chequeNo + "," + chequeDate + "," + CHQAMT + ",'" + banknm + "','',''," + comments + "," + bacd + "," + banm + ",'" + Session["empcd"].ToString() + "'," + empnm + ",'" + Session["brcd"].ToString() + "','" + brnm + "'," + staffcd + "," + staffnm + ",null,'O','" + BANKBRN + "'," + adjustamt + ",'Bank Payment','" + depositdt + "','" + acccodecb + "','" + brcd + "','Y','" + Vno + "')";
            //    cmd_voucher = new SqlCommand(sql, conn, trn);
            //    cmd_voucher.ExecuteNonQuery();
            //}

            //string sql2 = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged) values ";
            //sql2 = sql2 + "(" + finyear + "," + Transdate + ",'" + Vno + "','" + acccode + "','" + Accdesc + "'," + chequeNo + "," + chequeDate + "," + Debit + "," + Credit + ",'" + tranmode + "'," + Currbalance + ",'','" + brcd + "','" + Deptcode + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + paid_to + "','" + Session["empcd"].ToString() + "','" + brcd + "',0,0,0,0,0," + txtOtherAmt.Text + ",0,0,0," + PaymentAmt + ",'','','" + PBOV_typ + "','" + txtPANNO.Text + "','" + servicetaxNo + "','" + bookcode + "','" + Accdesc + "'," + cheque + ",'" + tranmode + "'," + txtTDSAmt.Text + "," + TotChrg + "," + tdsacccode + ",'" + svctaxacccode + "'," + servicetaxCharged + ")";
            //cmd_voucher = new SqlCommand(sql2, conn, trn);
            //cmd_voucher.ExecuteNonQuery();

            //sql2 = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + Vno + "'";
            //cmd_voucher = new SqlCommand(sql2, conn, trn);
            //cmd_voucher.ExecuteNonQuery();

            //sql2 = "Delete from webx_vouchertrans where voucherNo='" + Vno + "'";
            //cmd_voucher = new SqlCommand(sql2, conn, trn);
            //cmd_voucher.ExecuteNonQuery();

            trn.Commit();
            //trn.Rollback();

            conn.Close();
            voucherNo="ASSZ";
            string final = "?DocumentPrint=" + HdnThcNo.Value.Trim();
            //string final = "?DocumentPrint=THKLTBCO00030";
            Response.Redirect("THCAdvanceDoneInstallmentWise.aspx" + final);
            conn.Close();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            Response.End();
        }
    }
}
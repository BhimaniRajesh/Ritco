using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.ApplicationBlocks.Data;
using System.Globalization;

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePaymentInstallmentWise : BasePage//System.Web.UI.Page
{
    private string billno_nos, Branch, documentprint, voucherNo;
    public string checkeddockno, fromdt, Todt, Financial_Year = "", PartyCode = "";
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
            CreateToken();
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
                }
                else
                {
                    txtBalanceAmt.Text = "0.00";
                    indnetpay.Text = "0.00";
                }
                if (PANNO.Value == "")
                {
                    txtPANNO.Text = "PAN NOTAVL";
                }
                else
                {
                    txtPANNO.Text = Convert.ToString(PANNO.Value);
                }
            }

            btnSubmit.Attributes.Add("onclick", "javascript:return check()");
            //btnSubmit.Attributes.Add("onclick", "javascript:return CheckDouble()");
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
        dsAdvanceCheque.ThcAdvanceCheque.AddThcAdvanceChequeRow(srNoAdvanceCheque, "", "", "", "", "", "", "");
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
            else
            {
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
            if (dsAdvanceCheque.ThcAdvanceCheque.Count > 0 && (cbo.SelectedValue == "0Select" || cbo.SelectedValue == ""))
            {
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
            if (txtVendor.Text != "")
            {
                ARR_vendcd = txtVendor.Text.Split('~');
                VendorCD = ARR_vendcd[0].ToString();
                VendorNM = ARR_vendcd[1].ToString();
            }
            else
            {
                VendorCD = "";
                VendorNM = "";
            }
            string finyear = Session["FinYear"].ToString().Substring(2, 2);
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
        if (IsTokenValid())
        {
            btnSubmit.Enabled = false;
            btnSubmit.Visible = false;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            double cheque = Convert.ToDouble(txtAdvanceAmtPaid.Text.ToString());
            string advamtpaidBy = txtAdvanceAmtPaidBy.Text;
            string balamount = txtBalanceAmt.Text;
            string balpayat = txtBalancePayableAt.Text;
            double paymentAmt = 0.00;
            string voucherDate = txtVoucherDate.Text;
            string Transdate = "'" + fn.Mydate(txtVoucherDate.Text) + "'";
            string[] tdsgrpcode_arr = cboTDSType.SelectedValue.ToString().Split('~');
            string tdsacccode = tdsgrpcode_arr[0].ToString();
            string tdsaccdesc = tdsgrpcode_arr[1].ToString();
            tdsacccode = "'" + tdsacccode + "'";
            tdsaccdesc = "'" + tdsaccdesc + "'";
            string sql_adv = "select isnull(max(srno),0) as srno  from webx_thc_AdvanceDetail";
            double Credit = paymentAmt;
            string brcd = Session["brcd"].ToString();
            SqlCommand cmd_adv = new SqlCommand(sql_adv, conn);
            SqlDataReader dr_adv;
            dr_adv = cmd_adv.ExecuteReader();
            while (dr_adv.Read())
            {
                srno = Convert.ToInt32(dr_adv[0].ToString());
                srno = srno + 1;
            }
            dr_adv.Close();

            //string finyear = System.DateTime.Today.ToString("yy");
            var FinYear = Session["FinYear"].ToString();
            string FinYear_to = Convert.ToString(Convert.ToInt32(FinYear) + 1);

            if (Convert.ToInt32(FinYear_to) < 10)
            {
                FinYear_to = "0" + FinYear_to;
            }
            var FinYear_fromdate = "04/01/" + FinYear;
            var FinYear_todate = "03/31/" + FinYear_to;
            var Sle_finyear = FinYear + "-" + FinYear_to;
            string[] strdate = txtVoucherDate.Text.Split('/');

            DateTime vouDate = Convert.ToDateTime(strdate[1] + "/" + strdate[0] + "/" + strdate[2]);
            //DateTime vouDate = Convert.ToDateTime(voucherDate")_);

            string finyear = Session["FinYear"].ToString().Substring(2, 2);
            SqlCommand Acct_cmd = new SqlCommand();
            string Vbrcd = Session["brcd"].ToString();

            if (vouDate < Convert.ToDateTime(FinYear_fromdate) || vouDate > Convert.ToDateTime(FinYear_todate))
            {
                string ErrorMsg1 = "You have Selected Finacial Year as " + Sle_finyear + " , SO Financial Close Date Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!";
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=VoucherDate&ErrorMsg=" + ErrorMsg1, false);
                return;
            }


            if (Convert.ToDouble(txtAdvanceCash.Text) > 0)
            {

                for (int index = 0; index < dgAdvanceCash.Rows.Count; index++)
                {
                    TextBox txtInstallmentAmount = (TextBox)dgAdvanceCash.Rows[index].FindControl("txtInstallmentAmount");

                    if (txtInstallmentAmount.Text.Trim() == "")
                    {
                        lblError.Text = "For now you have submitted once please make entry again with cash advacne amount.";
                    }
                    else
                    { lblError.Text = ""; }
                }

            }
            if (Convert.ToDouble(txtAdvanceCheque.Text) > 0)
            {
                for (int index = 0; index < dgAdvanceCheque.Rows.Count; index++)
                {
                    TextBox txtAmount = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtAmount");
                    if (rbtLstAdvanceCheque.SelectedValue == "I")
                    {
                        if (txtAmount.Text.Trim() == "")
                        {
                            lblError.Text = "For now you have submitted once please make entry again with cheque advance amount.";
                        }
                        else
                        { lblError.Text = ""; }
                    }
                }

            }
            if (Convert.ToDouble(txtOtherAdvance.Text) > 0)
            {
                for (int index = 0; index < dgOtherAdvance.Rows.Count; index++)
                {
                    TextBox txtAmount = (TextBox)dgOtherAdvance.Rows[index].FindControl("txtAmount");

                    if (txtAmount.Text.Trim() == "")
                    {
                        lblError.Text = "For now you have submitted once please make entry again with other advance amount.";
                    }
                    else
                    { lblError.Text = ""; }
                }

            }
            ConsumeToken();
            SqlTransaction trn;
            var isSuccess = false;
            var final = "";


            if (lblError.Text == "")
            {
                var advCashArg = GenerateArgumentAdvanceCash();
                var advChqArg = GenerateArgumentAdvanceCheque();
                var advOthArg = GenerateArgumentOtherAdvance();
                // STEP 1 : ADVANCE CASH INSERT
                if (advCashArg != "")
                {
                    string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtAdvanceCash.Text), fn.Mydate(txtVoucherDate.Text));
                    if (Cnt == "F")
                    {
                        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                        Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg, false);
                        return;
                    }
                }
                // finyear,Transdate,Debit - Installment Amount,brcd,PartyCode

                // STEP 2 : ADVANCE CHEQUE INSERT
                if (rbtLstAdvanceCheque.SelectedValue == "I")
                {
                    if (advChqArg != "")
                    {
                        foreach (GridViewRow gridrow in dgAdvanceCheque.Rows)
                        {
                            TextBox ChequeNo = (TextBox)gridrow.FindControl("txtChequeNo");
                            TextBox txtDate = (TextBox)gridrow.FindControl("txtDate");
                            string Cnt = VendorPayment_Utility.Duplicate_ChqNO(ChequeNo.Text.Trim(), fn.Mydate1(txtDate.Text));
                            if (Cnt == "F")
                            {
                                string ErrorMsg1 = "Duplicate Cheque Entered";
                                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1, false);
                                return;
                            }
                        }
                    }
                }

                trn = conn.BeginTransaction();
                try
                {
                    if (advCashArg != "")
                    {
                        string sqlAdvanceCashInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertAdvanceCash '" + advCashArg + "','" + Session["empcd"].ToString() + "'";
                        SqlCommand cmdAdvanceCash = new SqlCommand(sqlAdvanceCashInsert, conn, trn);
                        cmdAdvanceCash.ExecuteNonQuery();
                    }

                    if (advChqArg != "")
                    {
                        string sqlAdvanceChequeInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertAdvanceCheque '" + advChqArg + "','" + Session["empcd"].ToString() + "'";
                        SqlCommand cmdAdvanceCheque = new SqlCommand(sqlAdvanceChequeInsert, conn, trn);
                        cmdAdvanceCheque.ExecuteNonQuery();
                    }
                    // finyear,Transdate,Debit - Installment Amount,brcd,PartyCode,acccode - Bank Acccode,chequeNo,chequeDate

                    // STEP 3 : OTHER ADVANCE CASH INSERT
                    if (advOthArg != "")
                    {
                        string sqlOtherAdvanceInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertOtherAdvance '" + advOthArg + "','" + Session["empcd"].ToString() + "'";
                        SqlCommand cmdOtherAdvance = new SqlCommand(sqlOtherAdvanceInsert, conn, trn);
                        cmdOtherAdvance.ExecuteNonQuery();
                    }
                    // finyear,Transdate,Debit - Installment Amount,brcd,PartyCode

                    //string sqlValidation = " SELECT COUNT(T.thcno) ThcNoCnt  FROM dbo.webx_THC_SUMMARY T " +
                    //" CROSS APPLY(Select InstalmentAmount  = SUM((CASE WHEN TAdv.InstalmentType='ADVCHQ' AND TAdv.AdvanceChequeType='L' THEN TAdv.AdvChqPending ELSE TAdv.InstalmentAmount END) ) " +
                    //" FROM    dbo.Webx_Thc_AdvanceInstalment_Det TAdv WHERE TAdv.ThcNo = T.thcno " +
                    //" )TAdv " +
                    //" WHERE   isnull(T.advamt,0) <> isnull(TAdv.InstalmentAmount,0)   AND T.thcno = '" + Request.QueryString.Get("checkeddockno").ToString() + "' ";

                    //string sqlValidation = " SELECT COUNT(T.thcno) ThcNoCnt  " +
                    //                " FROM dbo.webx_THC_SUMMARY T " +
                    //                " CROSS APPLY(SELECT  InstalmentAmount = SUM((CASE WHEN TAdv.InstalmentType = 'ADVCHQ' AND TAdv.AdvanceChequeType = 'L' THEN TAdv.AdvChqPending ELSE TAdv.InstalmentAmount END) ) " +
                    //                " FROM dbo.Webx_Thc_AdvanceInstalment_Det TAdv WHERE TAdv.ThcNo = T.thcno )TAdv " +
                    //                " WHERE T.advamt <> TAdv.InstalmentAmount AND T.thcno = '" + Request.QueryString.Get("checkeddockno").ToString() + "' ";

                    string sqlChequeValidation = " SELECT COUNT(T.thcno) ThcNoCnt FROM dbo.webx_THC_SUMMARY T  " +
                                    " CROSS APPLY( SELECT  SUM(TAdv.InstalmentAmount) InstalmentAmount FROM dbo.Webx_Thc_AdvanceInstalment_Det TAdv  WHERE TAdv.InstalmentType = 'ADVCHQ' AND TAdv.ThcNo = T.thcno )TAdv   " +
                                    " WHERE ISNULL(T.AdvanceCheque,0) <> ISNULL(TAdv.InstalmentAmount,0) AND T.thcno = '" + Request.QueryString.Get("checkeddockno").ToString() + "' ";

                    SqlCommand cmdsqlValidation = new SqlCommand(sqlChequeValidation, conn, trn);
                    int Cnt = Convert.ToInt32(cmdsqlValidation.ExecuteScalar());

                    if (Cnt > 0)
                    {
                        //throw new Exception("Duplicate Cheque Amount Entry Validation !!");
                    }
                    string sqlCashValidation = " SELECT COUNT(T.thcno) ThcNoCnt FROM dbo.webx_THC_SUMMARY T  " +
                                    " CROSS APPLY( SELECT  SUM(TAdv.InstalmentAmount) InstalmentAmount FROM dbo.Webx_Thc_AdvanceInstalment_Det TAdv  WHERE TAdv.InstalmentType = 'ADVCSH' AND TAdv.ThcNo = T.thcno )TAdv   " +
                                    " WHERE ISNULL(T.AdvanceCash,0) <> ISNULL(TAdv.InstalmentAmount,0) AND T.thcno = '" + Request.QueryString.Get("checkeddockno").ToString() + "' ";

                    Cnt = 0;
                    cmdsqlValidation = new SqlCommand(sqlCashValidation, conn, trn);
                    Cnt = Convert.ToInt32(cmdsqlValidation.ExecuteScalar());

                    if (Cnt > 0)
                    {
                        //throw new Exception("Duplicate Cash Amount Entry Validation !!");
                    }

                    trn.Commit();
                    //trn.Rollback();

                    final = "?DocumentPrint=" + HdnThcNo.Value.Trim();
                    isSuccess = true;
                    //Response.Redirect("THCAdvanceDoneInstallmentWise.aspx" + final);
                    //conn.Close();
                }
                catch (Exception e1)
                {
                    trn.Rollback();
                    btnSubmit.Enabled = true;
                    btnSubmit.Visible = true;
                    string msg = e1.Message.ToString();
                    msg = msg.Replace('\n', ' ');
                    lblError.Text = msg;
                    Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + msg + "</font>");
                    Response.End();
                }
                finally
                {
                    trn.Dispose();
                    if (conn.State == ConnectionState.Open)
                        conn.Close();
                }
            }
            else
            {
                btnSubmit.Enabled = true;
                btnSubmit.Visible = true;
            }
            if (isSuccess)
            {
                Response.Redirect("THCAdvanceDoneInstallmentWise.aspx" + final, false);
                return;
            }
        }
    }
}
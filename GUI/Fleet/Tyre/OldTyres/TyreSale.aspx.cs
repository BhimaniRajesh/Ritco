using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Fleet_Tyre_TyreSale : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            string Str = Request.QueryString["Tyre_ID"];
            // string Str = "EXEC USP_TyresList_Sale 'T0011,T0012,T0013,T0014,T0015,T0018'";
            // string Str = "T0011,T0012,T0013,T0014,T0015,T0018";
            ////BindDropDown("USP_VendorList", "Vendor", "vendorcode", ddlVendor);
            CTIM.GetTyres_Sale(GV_TyreSale, Str);
            btnSubmit.Attributes.Add("OnClick", "javascript:return OnSubmit();");

            if (GV_TyreSale.Rows.Count == 0)
            {
                Payment_Row3.Visible = false;
            }
            else
            {
                Payment_Row3.Visible = true;
            }
        }
    }
    /// <summary>
    /// Bind Vendor
    /// </summary>
    /// <param name="strProc"></param>
    /// <param name="text"></param>
    /// <param name="value"></param>
    /// <param name="Where"></param>
    /// <param name="d"></param>
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    protected void GV_TyreSale_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtSaleAmt = (TextBox)e.Row.FindControl("txtSaleAmt");
            TextBox txtVendor = (TextBox)e.Row.FindControl("txtVendor");
            TextBox txtMobileNo = (TextBox)e.Row.FindControl("txtMobileNo");

            //txtSaleAmt.Enabled = false;
            //txtVendor.Enabled = false;
            //txtMobileNo.Enabled = false;

            txtVendor.Attributes.Add("OnBlur", "javascript:return CheckVendor();");
        }
    }

    protected void SelectAll(object sender, EventArgs e)
    {
        foreach (GridViewRow GV in GV_TyreSale.Rows)
        {
            CheckBox chkSelectAll = (CheckBox)GV_TyreSale.HeaderRow.FindControl("chkSelectAll");
            CheckBox chkSelect = (CheckBox)GV.FindControl("chkSelect");
            TextBox txtSaleAmt = (TextBox)GV.FindControl("txtSaleAmt");
            TextBox txtVendor = (TextBox)GV.FindControl("txtVendor");
            TextBox txtMobileNo = (TextBox)GV.FindControl("txtMobileNo");


            if (chkSelectAll.Checked)
            {
                chkSelect.Checked = true;
                txtSaleAmt.Enabled = true;
                txtVendor.Enabled = true;
                txtMobileNo.Enabled = true;
            }
            else
            {
                chkSelect.Checked = false;

                txtSaleAmt.Enabled = false;
                txtSaleAmt.Text = "";
                txtVendor.Enabled = false;
                txtVendor.Text = "";
                txtMobileNo.Enabled = false;
                txtMobileNo.Text = "";
            }
        }
    }
    protected void CheckedChanged_Select(object sender, EventArgs e)
    {
        foreach (GridViewRow GV in GV_TyreSale.Rows)
        {
            CheckBox chkSelect = (CheckBox)GV.FindControl("chkSelect");
            TextBox txtSaleAmt = (TextBox)GV.FindControl("txtSaleAmt");
            TextBox txtVendor = (TextBox)GV.FindControl("txtVendor");
            TextBox txtMobileNo = (TextBox)GV.FindControl("txtMobileNo");

            if (chkSelect.Checked)
            {
                txtSaleAmt.Enabled = true;
                txtVendor.Enabled = true;
                txtMobileNo.Enabled = true;
            }
            else
            {
                txtSaleAmt.Enabled = false;
                txtSaleAmt.Text = "";
                txtVendor.Enabled = false;
                txtVendor.Text = "";
                txtMobileNo.Enabled = false;
                txtMobileNo.Text = "";

            }

        }
    }

    protected void txtSaleAmt_TextChanged(object sender, EventArgs e)
    {
        Double SaleAmt = 0.00;
        foreach (GridViewRow GV in GV_TyreSale.Rows)
        {
            TextBox txtSaleAmt = (TextBox)GV.FindControl("txtSaleAmt");
            CheckBox chkSelect = (CheckBox)GV.FindControl("chkSelect");
            if (chkSelect.Checked)
            {
                if (txtSaleAmt.Text != "")
                {
                    UserControls_Webx_PaymentControl payment = (UserControls_Webx_PaymentControl)UCMyPaymentControl1;

                    TextBox txtAmtApplA = (TextBox)payment.FindControl("txtAmtApplA");
                    TextBox txtNetPay = (TextBox)payment.FindControl("txtNetPay");

                    SaleAmt = SaleAmt + Convert.ToDouble(txtSaleAmt.Text);

                    txtAmtApplA.Text = Convert.ToString(SaleAmt);
                    txtNetPay.Text = Convert.ToString(SaleAmt);
                }
            }
            hdftotSaleAmt.Value = Convert.ToString(SaleAmt);

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();
        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "", final = "";
        Boolean IsCommited = false;
        string mCheck = "SALE", mDocuementNo = "";
        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));

        string Xml_PAY_MST = "<root><Tyre_MST>";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (mCheck == "SALE")
        {
            string YearVal = "";

            YearVal = objFinYear.FinancialYear();

            //string mSTR = "WebX_SP_GetNextDocumentCode";
            string mSTR = "WebX_SP_GetNextDocumentCode_FA";
            SqlCommand mcmd1 = new SqlCommand(mSTR, conn);
            mcmd1.CommandType = CommandType.StoredProcedure;
            mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
            mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();
            mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = mCheck;
            SqlDataReader rFR = mcmd1.ExecuteReader();
            if (rFR.Read())
            {
                mDocuementNo = rFR[0].ToString().Trim();
                list.Add(rFR[0].ToString().Trim());
            }
            rFR.Close();
            conn.Close();
        }



        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());

        DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
        TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
        DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
        TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
        TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
        DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
        TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");
        TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");

        CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();
        CTIM.UPDATEDBY = SessionUtilities.CurrentEmployeeID.Trim();

        foreach (GridViewRow gridrow in GV_TyreSale.Rows)
        {
            CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            TextBox txtVendor = gridrow.FindControl("txtVendor") as TextBox;
            TextBox txtSaleAmt = gridrow.FindControl("txtSaleAmt") as TextBox;
            TextBox txtMobileNo = gridrow.FindControl("txtMobileNo") as TextBox;
            HiddenField hdfTyre_Id = gridrow.FindControl("hdfTyre_Id") as HiddenField;

            if (chkSelect.Checked)
            {
                ARR_vendcd = txtVendor.Text.Split('~');
                VendorCD = ARR_vendcd[0].ToString();
                VendorNM = ARR_vendcd[1].ToString();

                list.Add(hdfTyre_Id.Value.Trim());

                CTIM.TYRE_ID = hdfTyre_Id.Value.Trim();//txtSysTyreNo.Text.Trim();
                CTIM.CLAIM_REMOLD_SALE_ID = mDocuementNo;
                CTIM.VendorCode = VendorCD;//ddlVendor.SelectedValue.Trim();
                CTIM.STATUS = "PASSED";
                CTIM.mobileNo = txtMobileNo.Text.Trim();
                if (txtSaleAmt.Text != "") { CTIM.SALE_AMT = Convert.ToDouble(txtSaleAmt.Text.ToString()); }
                else { CTIM.SALE_AMT = 0.00; }
                CTIM.PayMode = ddlPayMode.SelectedValue.Trim();
                CTIM.Acccode = ddrCashcode.SelectedValue.ToString();
                CTIM.Chqno = txtChqNo.Text.Trim();
                if (txtChqDate.Text != "") { CTIM.Chqdate = txtChqDate.Text.ToString(); } else { CTIM.Chqdate = ""; }
                if (txtChqAmt.Text != "") { CTIM.ChqAmt = Convert.ToDouble(txtChqAmt.Text.ToString()); } else { CTIM.ChqAmt = 0.00; }
                if (txtCashAmt.Text != "") { CTIM.CashAmt = Convert.ToDouble(txtCashAmt.Text.ToString()); } else { CTIM.CashAmt = 0.00; }
                CTIM.Cashcode = ddrCashcode.SelectedValue.ToString();
                CTIM.Bankaccode = ddrBankaccode.SelectedValue.ToString();
                CTIM.NetPay = Convert.ToDouble(txtNetPay.Text.ToString());

                CTIM.UpdateTyre_SalePayment();

                //Xml_PAY_MST = Xml_PAY_MST + "<TYRE_ID>" + txtSysTyreNo.Text.ToString() + "</TYRE_ID>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Suffix>S</Suffix>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Actions>Sale</Actions>";
                //Xml_PAY_MST = Xml_PAY_MST + "<VendorCode>" + VendorCD.Trim() + "</VendorCode>";
                //Xml_PAY_MST = Xml_PAY_MST + "<SaleAmt>" + Convert.ToDouble(txtSaleAmt.Text.ToString()) + "</SaleAmt>";
                //// Xml_PAY_MST = Xml_PAY_MST + "<SaleAmt>" + Convert.ToDouble(txtNetPay.Text.ToString()) + "</SaleAmt>";
                //Xml_PAY_MST = Xml_PAY_MST + "<mobileNo>" + txtMobileNo.Text.ToString() + "</mobileNo>";
            }
        }

        //Payment Details
        //Xml_PAY_MST = Xml_PAY_MST + "<PayMode>" + ddlPayMode.SelectedValue.Trim() + "</PayMode>";
        //if (txtCashAmt.Text != "")
        //{
        //    Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>" + txtCashAmt.Text.ToString() + "</CashAmt>";
        //}
        //else
        //{
        //    Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>0.00</CashAmt>";
        //}
        //Xml_PAY_MST = Xml_PAY_MST + "<Cashcode>" + ddrCashcode.SelectedValue.ToString() + "</Cashcode>";
        //if (txtChqAmt.Text != "")
        //{
        //    Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>" + txtChqAmt.Text.ToString() + "</ChqAmt>";
        //}
        //else
        //{
        //    Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>0.00</ChqAmt>";
        //}
        //Xml_PAY_MST = Xml_PAY_MST + "<Chqno>" + txtChqNo.Text.ToString() + "</Chqno>";
        //Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode>" + ddrBankaccode.SelectedValue.ToString() + "</Bankaccode>";
        //if (txtChqDate.Text != "")
        //{
        //    Xml_PAY_MST = Xml_PAY_MST + "<Chqdate>" + txtChqDate.Text.ToString() + "</Chqdate>";
        //}
        //else
        //{
        //    Xml_PAY_MST = Xml_PAY_MST + "<Chqdate></Chqdate>";
        //}
        //Xml_PAY_MST = Xml_PAY_MST + "<NetPay>" + txtNetPay.Text.ToString() + "</NetPay>";

        //Xml_PAY_MST = Xml_PAY_MST + "</Tyre_MST></root>";
        //CTIM.XMLData = Xml_PAY_MST.Trim();
        //CTIM.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();


        //CTIM.UpdateTyreDtl_Sale();
        IsCommited = true;

        for (int i = 0; i < list.Count; i++)
        {
            if (final == "")
            {
                final = list[i];
                cls_TyreIssueMaster.Tyre_IDs = list[i];
            }
            else
            {
                final = final + "," + list[i];
                cls_TyreIssueMaster.Tyre_IDs = cls_TyreIssueMaster.Tyre_IDs + "," + list[i];
            }
        }

        if (IsCommited)
        {
            btnSubmit.Enabled = false;
            //Response.Redirect("TyreUpdate_Msg.aspx?Tyre_ID=" + final.Trim());
            Response.Redirect("TyreUpdate_Msg.aspx");
        }

    }
}
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
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Finance_SP_Cost_Voucher_Special_Cost_Voucher : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    string strdt;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    string Financial_Year = "", fin_year = "", opertitle = "SPECIAL COST VOUCHER", Defaultdate = "",PBOV_TYP;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Defaultdate = Request.QueryString["Defaultdate"];
        if (Defaultdate == "")
        {
            Defaultdate = "today";
        }
        if (!IsPostBack)
        {
            FillBusDiv();
            if (Defaultdate != "today")
            {
                txtVoucherDate.Text = Defaultdate;
            }
            else
            {
                txtVoucherDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            }

            string sql = "select acccode,accdesc from webx_acctinfo where accdesc like '%tds%'";
            SqlCommand cmd1 = new SqlCommand(sql, con);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            while (dr.Read())
            {
                Tdssection.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            sql = "SELECT CodeId,CodeDesc FROM WEBX_MASTER_GENERAL WHERE CODETYPE='DOCS' AND StatusCode='Y' AND codeid in('DKT','PRS','DRS','THC','TRP','VEH')";
            cmd1 = new SqlCommand(sql, con);
            dr = cmd1.ExecuteReader();
            while (dr.Read())
            {
                if (dr["CodeId"].ToString().CompareTo("DKT") == 0)
                {
                    raddkttype.Text = dr["CodeDesc"].ToString();
                    Hdndktid.Value = dr["CodeId"].ToString();
                }
                else if (dr["CodeId"].ToString().CompareTo("PRS") == 0)
                {
                    radprstype.Text = dr["CodeDesc"].ToString();
                    Hdnprsid.Value = dr["CodeId"].ToString();
                }
                else if (dr["CodeId"].ToString().CompareTo("DRS") == 0)
                {
                    raddrstype.Text = dr["CodeDesc"].ToString();
                    Hdndrsid.Value = dr["CodeId"].ToString();
                }
                else if (dr["CodeId"].ToString().CompareTo("THC") == 0)
                {
                    radthctype.Text = dr["CodeDesc"].ToString();
                    Hdnthcid.Value = dr["CodeId"].ToString();
                }
                else if (dr["CodeId"].ToString().CompareTo("TRP") == 0)
                {
                    raddrstriptype.Text = dr["CodeDesc"].ToString();
                    Hdntripid.Value = dr["CodeId"].ToString();
                }
                else if (dr["CodeId"].ToString().CompareTo("VEH") == 0)
                {
                    radvehicletype.Text = dr["CodeDesc"].ToString();
                    Hdnvehicleid.Value = dr["CodeId"].ToString();
                }
            }
            dr.Close();

            Tdssection.CssClass = "blackfnt";
            txtPreparedLoc.Text = Session["brcd"].ToString();
            txtAccLoc.Text = Session["brcd"].ToString();
            txtPreparedBy.Text = Session["empcd"].ToString();
            
            Show_Pbov_list_Display();
            Set_Doc_Type_Display();

            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }
        if (Svctax_yn.Checked == true)
        {
            DateTime curdt;
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            curdt = Convert.ToDateTime(txtVoucherDate.Text, enGB);

            HdnServiceTaxRate.Value = Convert.ToString(TaxRateController.GetServiceTaxRate(curdt));
            HdnEduCessRate.Value = Convert.ToString(TaxRateController.GetEduCessRate(curdt));
            HdnHEduCessRate.Value = Convert.ToString(TaxRateController.GetHEduCessRate(curdt));

            if (Convert.ToDateTime(System.DateTime.Now.ToString("dd/MM/yyyy"), enGB) > Convert.ToDateTime("31/05/2015", enGB))
                txtVoucherDate.Enabled = false;

            txtServiceTax.Text = Convert.ToDecimal((Convert.ToDecimal(txtAmtAppl.Text) * Convert.ToDecimal(HdnServiceTaxRate.Value)) / 100).ToString("F2");
            txtEduCess.Text = Convert.ToDecimal((Convert.ToDecimal(txtServiceTax.Text) * Convert.ToDecimal(HdnEduCessRate.Value)) / 100).ToString("F2");
            txtHEduCess.Text = Convert.ToDecimal((Convert.ToDecimal(txtServiceTax.Text) * Convert.ToDecimal(HdnHEduCessRate.Value)) / 100).ToString("F2");
            txtAmtApplL.Text = Convert.ToDecimal(Convert.ToDecimal(txtAmtAppl.Text) + Convert.ToDecimal(txtServiceTax.Text) + Convert.ToDecimal(txtEduCess.Text) + Convert.ToDecimal(txtHEduCess.Text)).ToString("F2");
        }
        else
        {
            txtVoucherDate.Enabled = true;
            if (txtAmtAppl.Text == "")
                txtAmtAppl.Text = "0.00";
            txtServiceTax.Text = "0.00";
            txtEduCess.Text = "0.00";
            txtHEduCess.Text = "0.00";
            txtAmtApplL.Text = Convert.ToDecimal(Convert.ToDecimal(txtAmtAppl.Text)).ToString("F2");
        }

        btnPreparedLoc.Attributes.Add("onclick", "popuplist('LocCode','" + txtPreparedLoc.ClientID.ToString() + "','none')");
        txtPreparedLoc.Attributes.Add("onblur", "LocBlur('" + txtPreparedLoc.ClientID.ToString() + "')");
        txtAccLoc.Attributes.Add("onblur", "LocBlur('" + txtAccLoc.ClientID.ToString() + "')");
        txtManualNo.Attributes.Add("onblur", "Manualbillblur('" + txtManualNo.ClientID.ToString() + "')");
        btnAccLoc.Attributes.Add("onclick", "popuplist('LocCode','" + txtAccLoc.ClientID.ToString() + "','none')");
        txtServiceTax.Attributes.Add("onblur", "GetTot()");
        txtEduCess.Attributes.Add("onblur", "GetTot()");
        txtHEduCess.Attributes.Add("onblur", "GetTot()");
        txtTDSRate.Attributes.Add("onblur", "GetTot()");
        txtTDSAmt.Attributes.Add("onblur", "GetTot()");
        txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'08','../../images/Date_Control_Rule_Check.aspx')");
        //txtPanNo.Attributes.Add("onblur", "CheckPan(this)");
        //txtCashAmt.Attributes.Add("onblur", " CheckCashBank()");
        //txtChqAmt.Attributes.Add("onblur", " CheckCashBank()");

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        else
        {
            maxrows = 5;
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
    }
    private void FillBusDiv()
    {
        string strSql = "Select top 1 '-1' as CodeId ,'--Select One--' as CodeDesc Union select CodeId,CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y'";
        cmd = new SqlCommand(strSql, con);
        
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            ddlBusinessDiv.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dr.Close();
        ddlBusinessDiv.SelectedIndex = 1;
        ddlBusinessDiv.CssClass = "blackfnt";
    }

    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddldoctype = (DropDownList)e.Row.FindControl("ddldoctype");
            string sql = "Select top 1 '-1' as CodeId ,'--Select--' as CodeDesc Union SELECT CodeId,CodeDesc FROM WEBX_MASTER_GENERAL WHERE CODETYPE='DOCS' AND StatusCode='Y' AND codeid in('DKT','PRS','DRS','THC','TRP','VEH') AND codeid='" + HdnSelDocType.Value + "'";
            cmd = new SqlCommand(sql, con);
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                ddldoctype.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddldoctype.SelectedValue = "-1";
            ddldoctype.CssClass = "blackfnt";

            ((TextBox)e.Row.FindControl("txtAccCode")).Attributes.Add("onblur", "AccBlur('" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "')");
            ((Button)e.Row.FindControl("btnAccCode")).Attributes.Add("onclick", "popuplist('AccCode','" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "','none')");
            ((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot()");
            ((TextBox)e.Row.FindControl("txtDocno")).Attributes.Add("onblur", "DocNocheck('" + ((TextBox)e.Row.FindControl("txtDocno")).ClientID.ToString() + "')");
            
        }
    }
    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
            txtCashAmt.Enabled = false;
            ddrCashcode.Enabled = true;
            txtChqAmt.Enabled = false;
            txtChqNo.Enabled = false;
            txtChqAmt.Text = "0.00";
            txtChqNo.Text = "";
            txtChqAmt.Text = "";
            txtChqNo.Text = "";

            ddrBankaccode.SelectedValue = "";
            ddrBankaccode.Enabled = false;
            txtChqDate.Text = "";
            txtChqDate.Enabled = false;
            txtCashAmt.Text = Hnd_totalAmount.Value.ToString();
            ddrCashcode.Items.Clear();
            string strSql = " select '' as asscodeval,'--Select--' as accdesc Union  select acccode  as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrCashcode.CssClass = "blackfnt";
        }
        else if (ddlPayMode.SelectedItem.Text == "Bank")
        {
            txtCashAmt.Enabled = false;
            txtCashAmt.Text = "0.00";
            ddrCashcode.SelectedValue = "";
            ddrCashcode.Enabled = false;

            txtChqAmt.Enabled = false;
            txtChqNo.Enabled = true;
            txtChqAmt.Text = Hnd_totalAmount.Value.ToString();

            txtCashAmt.Text = "";

            ddrBankaccode.Enabled = true;
            txtChqDate.Enabled = true;

            ddrBankaccode.Items.Clear();

            string strSql = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddrBankaccode.CssClass = "blackfnt";

        }
        else if (ddlPayMode.SelectedItem.Text == "Both")
        {
            txtCashAmt.Enabled = true;
            txtChqAmt.Enabled = true;
            txtChqNo.Enabled = true;
            txtChqDate.Enabled = true;
            ddrBankaccode.Enabled = true;
            ddrCashcode.Enabled = true;

            ddrCashcode.Items.Clear();
            string strSql = " select '' as asscodeval,'--Select--' as accdesc Union  select acccode  as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddrBankaccode.Items.Clear();
            string strSql1 = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql1, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrCashcode.CssClass = "blackfnt";
            ddrBankaccode.CssClass = "blackfnt";
        }
    }
    protected void txtAmtApplL_TextChanged(object sender, EventArgs e)
    {}
    public void Show_Pbov_list_Display()
    {
        string sql_display_pbov = "";
        if (RAD_Customer.Checked == true)
        {
            sql_display_pbov = "select custcd as code , custnm+':'+custcd  as name from webx_custhdr WITH(NOLOCK) where CUSTCD is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0 order by CUSTNM ";
            PBOV_TYP = "P";
        }
        else if (RAD_Vendor.Checked == true)
        {
            sql_display_pbov = "select vendorCode as code , vendorname+':'+vendorCode as name from webx_VENDOR_HDR WITH(NOLOCK) where vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) order by vendorname";
            PBOV_TYP = "V";
        }
        else if (RAD_Emp.Checked == true)
        {
            sql_display_pbov = "select userid as code ,name+':'+userid as name  from webx_master_users  WITH(NOLOCK) where status='100' order by name,branchcode";
            PBOV_TYP = "E";
        }
        SqlCommand cmd_pbov = new SqlCommand(sql_display_pbov, con);
        SqlDataReader dr_pbov;
        dr_pbov = cmd_pbov.ExecuteReader();
        Dr_Pbov_list.Items.Clear();
        Dr_Pbov_list.CssClass = "blackfnt";
        Dr_Pbov_list.Items.Add(new ListItem("Select", ""));
        while (dr_pbov.Read())
        {
            Dr_Pbov_list.Items.Add(new ListItem(dr_pbov.GetValue(1).ToString(), dr_pbov.GetValue(0).ToString()));
        }
        dr_pbov.Close();
        Dr_Pbov_list.Items.ToString().ToUpper();
    }
    public void Show_Pbov_list(object sender, EventArgs e)
    {
        Show_Pbov_list_Display();
    }
    public void Set_Doc_Type(object sender, EventArgs e)
    {
        Set_Doc_Type_Display();
    }
    public void Set_Doc_Type_Display()
    {
        if (raddkttype.Checked == true)
            HdnSelDocType.Value = Hdndktid.Value;
        else if (raddrstype.Checked == true)
            HdnSelDocType.Value = Hdndrsid.Value;
        else if (radprstype.Checked == true)
            HdnSelDocType.Value = Hdnprsid.Value;
        else if (radthctype.Checked == true)
            HdnSelDocType.Value = Hdnthcid.Value;
        else if (raddrstriptype.Checked == true)
            HdnSelDocType.Value = Hdntripid.Value;
        else if (radvehicletype.Checked == true)
            HdnSelDocType.Value = Hdnvehicleid.Value;

        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {
            DropDownList ddldoctype = ((DropDownList)gridrow.FindControl("ddldoctype"));
            ddldoctype.Items.Clear();
            string sql = "Select top 1 '-1' as CodeId ,'--Select--' as CodeDesc Union SELECT CodeId,CodeDesc FROM WEBX_MASTER_GENERAL WHERE CODETYPE='DOCS' AND StatusCode='Y' AND codeid in('DKT','PRS','DRS','THC','TRP','VEH') AND codeid='" + HdnSelDocType.Value + "'";
            cmd = new SqlCommand(sql, con);
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                ddldoctype.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            
            ddldoctype.SelectedValue = "-1";
            ddldoctype.CssClass = "blackfnt";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Year = Session["FinYear"].ToString();
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        string Voucherno = fn.NextVoucherno(Session["brcd"].ToString(), Financial_Year);
        string[] VDate = txtVoucherDate.Text.Split('/');
        string EntryBy = Session["empcd"].ToString(), Transtype = "", OppaccountDesc = "", OppaccountCode = "";

        string VoucherDate = Convert.ToDateTime(VDate[1] + "/" + VDate[0] + "/" + VDate[2]).ToString("yyyy/MM/dd");
        string sql_Acccode = "";
        string[] CDate;
        string ChqDate = "", Chqno = "", OppaccountDesc_mode = "", OppaccountCode_mode = "";

        if (RAD_Customer.Checked)
            PBOV_TYP = "P";
        else if (RAD_Vendor.Checked)
            PBOV_TYP = "V";
        else if (RAD_Emp.Checked)
            PBOV_TYP = "E";

        if (ddlPayMode.SelectedItem.Text != "Cash")
        {
            Chqno = txtChqNo.Text;
            CDate = txtChqDate.Text.Split('/');
            ChqDate = Convert.ToDateTime(CDate[1] + "/" + CDate[0] + "/" + CDate[2]).ToString("yyyy/MM/dd");

            string sql_chk = "select chqamt,adjustamt,banknm from webx_chq_det where chqno='" + Chqno + "' and chqdt='" + ChqDate + "'";
            SqlCommand cmd_chk = new SqlCommand(sql_chk, con);
            SqlDataReader dr_chk = null;

            dr_chk = cmd_chk.ExecuteReader();
            string chque_yn_chk = "N";
            if (dr_chk.Read())
            {
                chque_yn_chk = "Y";
            }
            dr_chk.Close();

            if (chque_yn_chk == "Y")
            {
                Response.Write("<br><br><br><font class='blackboldfnt' color='red' ><B>Error : Duplicate Cheque Entered </b></font>");
                string msg = "Error : Duplicate Cheque Entered";
                Response.Redirect("Message.aspx?" + msg);
                Response.End();
            }
        }
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
            ChqDate = null;
            Chqno = null;//txtChqNo.Text
            txtChqAmt.Text = "0";
            txtChqNo.Text = "0";
            Transtype = "CASH PAYMENT";
            OppaccountDesc = ddrCashcode.SelectedItem.Text.ToString();
            OppaccountCode = "CAS0002";
        }
        if (ddlPayMode.SelectedItem.Text == "Bank")
        {
            Chqno = txtChqNo.Text;
            CDate = txtChqDate.Text.Split('/');
            ChqDate = Convert.ToDateTime(CDate[1] + "/" + CDate[0] + "/" + CDate[2]).ToString("yyyy/MM/dd");
            Transtype = "BANK PAYMENT";
            OppaccountDesc = ddrBankaccode.SelectedItem.Text.ToString();
            OppaccountCode = ddrBankaccode.SelectedValue.ToString();
        }
        if (ddlPayMode.SelectedItem.Text == "Both")
        {
            Transtype = "BOTH PAYMENT";
            Chqno = txtChqNo.Text;
            CDate = txtChqDate.Text.Split('/');
            ChqDate = Convert.ToDateTime(CDate[1] + "/" + CDate[0] + "/" + CDate[2]).ToString("yyyy/MM/dd");
            OppaccountDesc = ddrBankaccode.SelectedItem.Text.ToString();
            OppaccountCode = ddrBankaccode.SelectedValue.ToString();
        }

        sql_Acccode = "select accdesc from webx_acctinfo WITH(NOLOCK) where Acccode='" + OppaccountCode + "'";
        cmd = new SqlCommand(sql_Acccode, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            OppaccountDesc = dr["accdesc"].ToString().Trim();
        }
        dr.Close();

        if (HdnServiceTax.Value == "")
        {
            txtServiceTax.Text = "0.00";
            HdnServiceTax.Value = "0.00";
        }
        if (HdnEduCess.Value == "")
        {
            txtEduCess.Text = "0.00";
            HdnEduCess.Value = "0.00";
        }
        if (HdnHEduCess.Value == "")
        {
            txtHEduCess.Text = "0.00";
            HdnHEduCess.Value = "0.00";
        }
        if (HdnTDSRate.Value == "")
        {
            txtTDSRate.Text = "0";
            HdnTDSRate.Value = "0";
        }


        if (ddlPayMode.SelectedItem.Text.ToUpper() == "CASH")
        {

            string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmt.Text), fn.Mydate(txtVoucherDate.Text));
            if (Cnt == "F")
            {
                string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
            }

            SqlDataReader dtr;
            double intCASH_OPNDEBIT = 0;
            double intCASH_OPNCredit = 0;
            string str = "";
            string openBalance = "";
            string finyear = Session["FinYear"].ToString();
            string curr_year = DateTime.Now.ToString("yyyy");

            string finyearstar = "";
            if (finyear == curr_year)
            {
                finyearstar = "01 Apr " + curr_year;
            }
            else
            {
                finyearstar = "01 Apr " + finyear;
            }

            str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + fin_year + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + txtPreparedLoc.Text + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + txtPreparedLoc.Text + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + finyearstar + "',106) and convert(datetime,'" + fn.Mydate1(txtVoucherDate.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + fin_year + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + txtPreparedLoc.Text + "' and ( acccategory='CASH' OR ((bkloccode like '%" + txtPreparedLoc.Text + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
            dtr = DAccess.getreader(str);
            while (dtr.Read())
            {
                string CASH_OPNDEBIT = dtr["CASH_OPNDEBIT"].ToString();
                intCASH_OPNDEBIT = intCASH_OPNDEBIT + Convert.ToDouble(dtr["CASH_OPNDEBIT"]);
                string CASH_OPNCredit = dtr["CASH_OPNCredit"].ToString();
                intCASH_OPNCredit = intCASH_OPNCredit + Convert.ToDouble(dtr["CASH_OPNCredit"]);
                if (intCASH_OPNDEBIT > intCASH_OPNCredit)
                {
                    openBalance = Convert.ToString(intCASH_OPNDEBIT - intCASH_OPNCredit) + " " + "Dr";
                }
                else
                {
                    openBalance = Convert.ToString(intCASH_OPNCredit - intCASH_OPNDEBIT) + " " + "Cr";
                }
            }
            dtr.Close();

            double curr_val = Convert.ToDouble(txtNetPay.Text);
            double open_val = Convert.ToDouble(openBalance.Substring(0, openBalance.Length - 3));
            string open_val_str = (openBalance.Substring(openBalance.Length - 3, 3)).Trim();

            if (open_val >= curr_val && open_val_str == "Dr")
            {
                //Hashtable myHT = new Hashtable();
                //myHT.Add("", "");
            }
            else
            {
                string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
            }
        }

        SqlTransaction trans;
        trans = con.BeginTransaction();
        try
        {
            string PBOV_code = "", PBOV_Name = "";
            if (Dr_Pbov_list.SelectedValue == "" || Dr_Pbov_list.SelectedValue == "8888")
            {
                if (txtCode.Text != "")
                {
                    PBOV_code = "8888";
                    PBOV_Name = txtCode.Text;
                }
                else
                {
                    PBOV_code = "8888";
                    PBOV_Name = "Walk in Customer";
                }
                //PBOV_code = "8888";
                //PBOV_Name = txtCode.Text;
            }
            else
            {
                PBOV_code = Dr_Pbov_list.SelectedValue.ToString();
                string[] PBOV_Name_arr = Dr_Pbov_list.SelectedItem.Text.ToString().Split(':');
                PBOV_Name = PBOV_Name_arr[0].ToString();
            }

            string svrtaxno="0";
            string svrtaxrate="0";
            string srvtaxamt="0";
            string svrtaxaccountcode = "";

            string tdsrate = "0";
            string tdsamt = "0";
            string tdsacccode = "";

            if (Svctax_yn.Checked == true)
            {
                svrtaxno = txtSrvTaxNo.Text;
                svrtaxrate = "12";
                srvtaxamt = txtServiceTax.Text;
                svrtaxaccountcode = "ALS0009";
            }
            if (TDS_yn.Checked == true)
            {
                tdsrate = txtTDSRate.Text;
                tdsamt = txtTDSAmt.Text;
                tdsacccode = Tdssection.SelectedValue.ToString();
            }
            
            string strSql = "exec usp_webx_voucherheader_insertData '" + Year + "','" + VoucherDate + "','"; 
            strSql += Voucherno + "','" + Chqno + "','" + ChqDate + "','" + txtNetPay.Text + "','0.00','";
            strSql += txtNarration.Text + "','" + PBOV_code + "','" + Transtype + "','" + txtPreparedLoc.Text + "','";
            strSql += OppaccountCode + "','" + OppaccountDesc + "','" + Session["empcd"].ToString() + "','" + opertitle + "','";
            strSql += PBOV_Name + "','" + PBOV_TYP + "','" + txtPreparedFor.Text + "','" + svrtaxrate + "','";
            strSql += srvtaxamt + "','" + svrtaxaccountcode + "','" + svrtaxno + "','" + tdsrate + "','";
            strSql += tdsamt + "','" + tdsacccode + "','" + txtPanNo.Text + "','";
            strSql += txtChqAmt.Text + "','" + ddlPayMode.SelectedItem.Text + "','" + txtManualNo.Text + "','";
            strSql += ddlBusinessDiv.SelectedValue.ToString() + "','";
            strSql += txtAccLoc.Text + "','" + txtReferenceNo.Text + "','" + txtHEduCess.Text + "'";
            cmd = new SqlCommand(strSql, con, trans);
            cmd.ExecuteNonQuery();
            
            //string strSql = "exec usp_webx_voucherheader_insertData '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + txtManualNo.Text + "','" + txtPreparedLoc.Text + "','" + txtPreparedBy.Text + "','" + ddlBusinessDiv.SelectedValue + "','" + txtAccLoc.Text + "','" + txtPreparedFor.Text + "','" + txtReferenceNo.Text + "','" + txtNarration.Text + "','" + txtChqAmt.Text + "','" + txtChqNo.Text + "','" + ChqDate + "','" + VoucherDate + "','" + Transtype + "','" + opertitle + "'";

            //string strSql = "insert into webx_vouchertrans_arch(Voucherno,Transdate,Manual_Voucherno,Brcd,Entryby,Business_type,Accounting_Brcd,preparefor,Refno,Payto,Pbov_code,pbov_name,pbov_typ,Narration,";
            //strSql += "servicetax,othertax,H_edu_cess,servicetaxNo,tdsacccode,tdsrate,tds,Panno,";
            //strSql += "Transmode,CHQAMT,chqno,Acccode,bankname,Chqdate,Netamt,Debit,Credit,";
            //strSql += "voucher_cancel,finyear,srno,Transtype,Entrydt)";
            //strSql += "values('" + Voucherno + "','" + VoucherDate + "','" + txtManualNo.Text + "','" + txtPreparedLoc.Text + "','" + txtPreparedBy.Text + "','" + ddlBusinessDiv.SelectedValue + "','" + txtAccLoc.Text + "','" + txtPreparedFor.Text + "','" + txtReferenceNo.Text + "','" + PBOV_code + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtNarration.Text + "',";
            //strSql += "" + HdnServiceTax.Value + "," + HdnEduCess.Value + "," + HdnHEduCess.Value + ", '" + txtSrvTaxNo.Text + "',''," + txtTDSRate.Text + "," + HdnTdsAmt.Value + ",'" + txtPanNo.Text + "',";
            //strSql += "'" + ddlPayMode.SelectedItem.Text + "'," + txtChqAmt.Text + ",'" + txtChqNo.Text + "','','','" + ChqDate + "'," + Hnd_totalAmount.Value.ToString() + "," + Hnd_totalAmount.Value.ToString() + ",0,";
            //strSql += "'N'," + Financial_Year + ",100,'" + Transtype + "',getdate())";

            //cmd = new SqlCommand(strSql, con, trans);
            //cmd.ExecuteNonQuery();
            
            string sql_Acctrans = "", Acccode = "", Debit = "", Credit = "", Narration = "", Description = "",DocumentNo="";

            int i = 0;

            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                Acccode = ((TextBox)gridrow.FindControl("txtAccCode")).Text.ToString();
                i = i + 1;

                Debit = ((TextBox)gridrow.FindControl("txtAmt")).Text.ToString();
                Credit = "0.00";
                Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.ToString().Replace("'", "''");
                Description = ((TextBox)gridrow.FindControl("txtDescription")).Text.ToString().Replace("'", "''");
                DocumentNo = ((TextBox)gridrow.FindControl("txtDocno")).Text.ToString();
                DropDownList ddldoctype = ((DropDownList)gridrow.FindControl("ddldoctype"));

                if (Acccode != "")
                {
                    sql_Acccode = "select Acccode,accdesc from webx_acctinfo WITH(NOLOCK) where Company_Acccode='" + Acccode + "'";
                    cmd = new SqlCommand(sql_Acccode, con, trans);

                    dr = cmd.ExecuteReader();
                    string Accdesc = "";
                    while (dr.Read())
                    {
                        Acccode = dr["Acccode"].ToString().Trim();
                        Accdesc = dr["accdesc"].ToString().Trim();
                    }
                    dr.Close();
                    if (i == 1)
                    {
                        OppaccountDesc_mode = Accdesc;
                        OppaccountCode_mode = Acccode;
                    }

                    string sql_docdetail = "exec usp_update_Special_Cost_Voucher '" + ddldoctype.SelectedValue.ToString() + "','" + DocumentNo + "','" + Voucherno + "','" + Debit + "'";
                    cmd = new SqlCommand(sql_docdetail, con, trans);
                    cmd.ExecuteNonQuery();

                    sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + ddldoctype.SelectedValue.ToString() + "'";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();

                    HdnDocList.Value += DocumentNo + ",";
                }
            }

            HdnDocList.Value = HdnDocList.Value.Substring(0, HdnDocList.Value.Length - 1);

            sql_Acccode = "select Acccode from webx_acctinfo WITH(NOLOCK) where Acccode='" + OppaccountCode + "'";
            cmd = new SqlCommand(sql_Acccode, con, trans);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                OppaccountCode = dr["Acccode"].ToString().Trim();
            }
            dr.Close();

            Narration = txtNarration.Text;

            if (ddlPayMode.SelectedItem.Text != "Cash")
            {
                string acccodecb = ddrBankaccode.SelectedValue.ToString(); ;
                string depositdt = VoucherDate;
                double CHQAMT = Convert.ToDouble(txtNetPay.Text.ToString()), adjustamt = Convert.ToDouble(txtNetPay.Text.ToString());
                string comments = null;
                string bacd = null;
                string banm = null;
                string empnm = null;
                string staffcd = null;
                string staffnm = null;
                string brnm = fn.GetLocation(Session["brcd"].ToString());
                string banknm = ddrBankaccode.SelectedItem.Text.ToString();
                string BANKBRN = "";

                string sql = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt,voucherNo,transdate,acccode,depoloccode,DepoFlag) values('" + Chqno + "','" + fn.Mydate1(txtChqDate.Text) + "','" + txtChqAmt.Text + "','" + banknm + "','','','" + comments + "','" + bacd + "','" + banm + "','" + Session["empcd"].ToString() + "','" + empnm + "','" + Session["brcd"].ToString() + "','" + brnm + "','" + staffcd + "','" + staffnm + "',null,'O','" + BANKBRN + "','" + adjustamt + "','" + Voucherno + "','" + VoucherDate + "','" + acccodecb + "','" + Session["brcd"].ToString() + "','Y')";
                cmd = new SqlCommand(sql, con, trans);
                cmd.ExecuteNonQuery();

                //sql = "update webx_chq_det set voucherNo='" + Voucherno + "',transdate='" + VoucherDate + "',acccode='" + acccodecb + "',depoloccode='" + Session["brcd"].ToString() + "',DepoFlag='Y' where Chqno='" + Chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + fn.Mydate1(txtChqDate.Text) + "',106)";
                //cmd = new SqlCommand(sql, con, trans);
                //cmd.ExecuteNonQuery();
            }
            if (Svctax_yn.Checked)
            {
                if (Convert.ToDouble(HdnServiceTax.Value) > 0)
                {
                    Debit = HdnServiceTax.Value.ToString();
                    Credit = "0.00";
                    Acccode = "ALS0009";
                    //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                    sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher   '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();

                }
                if (Convert.ToDouble(HdnEduCess.Value) > 0)
                {
                    Debit = HdnEduCess.Value.ToString();
                    Credit = "0.00";
                    Acccode = "ALS0010";
                    //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                    sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher   '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();

                }
                if (Convert.ToDouble(HdnHEduCess.Value) > 0)
                {
                    Debit = HdnHEduCess.Value.ToString();
                    Credit = "0.00";
                    Acccode = "ALS0011";
                    //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                    sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();

                }
            }
            if (TDS_yn.Checked)
            {
                if (Convert.ToDouble(HdnTdsAmt.Value) > 0)
                {
                    Credit = HdnTdsAmt.Value.ToString();
                    Debit = "0.00";
                    Acccode = Tdssection.SelectedValue.ToString();
                    //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                    sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + Acccode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc + "','" + EntryBy + "','','N','N','" + OppaccountCode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();
                }
            }
            if (ddlPayMode.SelectedItem.Text != "Both")
            {
                Credit = Hnd_totalAmount.Value.ToString();
                Debit = "0.00";
                //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc_mode + "','" + EntryBy + "','','N','N','" + OppaccountCode_mode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc_mode + "','" + EntryBy + "','','N','N','" + OppaccountCode_mode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();
            }
            else
            {
                Credit = txtCashAmt.Text.ToString();
                Debit = "0.00";
                OppaccountCode = "CAS0002";
                //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc_mode + "','" + EntryBy + "','','N','N','" + OppaccountCode_mode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc_mode + "','" + EntryBy + "','','N','N','" + OppaccountCode_mode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();

                Credit = txtChqAmt.Text.ToString();
                Debit = "0.00";
                OppaccountCode = ddrBankaccode.SelectedValue.ToString();
                //sql_Acctrans = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + DocumentNo + "','" + txtAccLoc.Text + "','','" + OppaccountDesc_mode + "','" + EntryBy + "','','N','N','" + OppaccountCode_mode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "' ";
                sql_Acctrans = "exec WEBX_acctrans_insertData_SpecialVoucher  '" + Year + "','" + VoucherDate + "','" + Voucherno + "','" + OppaccountCode + "','" + Chqno + "','" + ChqDate + "','" + Debit + "','" + Credit + "','" + Narration + "','" + Transtype + "',0,'" + HdnDocList.Value + "','" + txtAccLoc.Text + "','','" + OppaccountDesc_mode + "','" + EntryBy + "','','N','N','" + OppaccountCode_mode + "',null,Null,Null,Null,Null,'','','" + Dr_Pbov_list.SelectedValue.ToString() + "','" + txtReferenceNo.Text + "','" + txtPreparedLoc.Text + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_TYP + "','" + txtPanNo.Text + "','" + txtSrvTaxNo.Text + "','" + opertitle + "','" + HdnSelDocType.Value + "'";
                cmd = new SqlCommand(sql_Acctrans, con, trans);
                cmd.ExecuteNonQuery();
            }

            double LedgerDiff=0;
            sql_Acctrans = "select sum(debit) - sum(credit) as Differance from webx_acctrans_" + fin_year + " where voucher_cancel='N' and voucherno='" + Voucherno + "'";
            cmd = new SqlCommand(sql_Acctrans, con, trans);
            SqlDataReader dr_count = cmd.ExecuteReader();
            while (dr_count.Read())
            {
                LedgerDiff = Convert.ToDouble(dr_count["Differance"].ToString().Trim());
            }
            dr_count.Close();

            if(LedgerDiff > 0)
            {
                throw new Exception("Debit Amount Should Be Equal To Payment Amount");
            }
	   else if(LedgerDiff < 0)
            {
                throw new Exception("Debit Amount Should Be Equal To Payment Amount");
            }
            else
            {
                trans.Commit();
            }

            con.Close();
            Response.Redirect("./voucher_Done.aspx?VoucherType=Special&VoucherNo=" + Voucherno + "&Defaultdate=" + txtVoucherDate.Text, false);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + msg);
            Response.End();
        }
    }
}

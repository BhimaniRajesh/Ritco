using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Octroi_Agent_Voucher_Result_Sub_Page : System.Web.UI.Page
{
    public static double s = 0; 
    string BillEntry, SubTotal;
     double Oct_Paid = 0, Totalamt=0;
     double AgeChrg=0;
     double OthChrg=0;
     double CleChrg=0;
     double FromChrg=0;
     double SundryChrg=0;
     double SvcTax=0;
     double Total=0;
     double AmtPaid=0;
    double Sub_Total = 0, TotalNetamount=0;
    int nullvalue = 0;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
         Oct_Paid=0;
         AgeChrg=0;
         OthChrg=0;
         CleChrg=0;
         FromChrg=0;
         SundryChrg=0;
         SvcTax=0;
         Total=0;
         AmtPaid=0;
         Sub_Total = 0;
         Totalamt = 0;
        if (!(IsPostBack))
        {
            
            lblDtFrom.Text = Request.QueryString["FromDt"];
            lblDtTo.Text = Request.QueryString["ToDt"];
            lblBillType.Text = Request.QueryString["BillType"];
            lblAgeType.Text = Request.QueryString["AgentType"];
            BillEntry = Request.QueryString["BillEntry"];

            BindGrid();

            PopPaymentAcc();
            PopTDSType();
            EntryDt.Text = Convert.ToDateTime(System.DateTime.Now).ToString("dd/MM/yyyy");

            btnSubmit.Attributes.Add("onclick", "javascript:return check(" + cboBankAcc.ClientID + "," + cboTDSType.ClientID + "," + cboTDSDedu.ClientID + ")");
            txtChequeDt.ReadOnly = true;
            txtChequeNo.ReadOnly = true;
            //btnSubmit.Attributes.Add("onclick", "javascript:return check(" + cboTDSType.ClientID + ")");
            //btnSubmit.Attributes.Add("onclick", "javascript:return check(" + cboTDSDedu.ClientID + ")");
            
        }
        
    }
    private void PopTDSType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select Accdesc from webx_acctinfo where acccode ='CLA0015'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");

        cboTDSType.DataSource = ds;
        cboTDSType.DataTextField = "Accdesc";
        cboTDSType.DataValueField = "Accdesc";
        cboTDSType.DataBind();
        cboTDSType.Items.Insert(0, "- Select One -");
        conn.Close();
    }
    private void PopPaymentAcc()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select acccode,accdesc,acccategory from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or bkloccode like '" + Session["BRCD"].ToString() + "%') AND acccategory='BANK')) order by accdesc asc";
        //string sql = "select top 1 '--Select--' as acccode,'--Select--' as accdesc,'--Select--' as acccategory from webx_acctinfo union select acccode,accdesc,acccategory from webx_acctinfo where( acccategory='CASH' OR ((bkloccode like 'All' or bkloccode like '%PNQA%') AND acccategory='BANK')) order by accdesc asc";

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds, "tab1");
        cboBankAcc.DataSource = ds;
        cboBankAcc.DataTextField = "accdesc";
        cboBankAcc.DataValueField = "acccode";
        cboBankAcc.DataBind();
        cboBankAcc.Items.Insert(0, "- Select One -");
        conn.Close();
    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select (isnull(OCAGOCTAMT,0)-(isnull(OCAGOTHCHRG,0)+isnull(OCAGSERCHRG,0)+isnull(sundrychrg,0)+isnull(clearchrg,0)+isnull(formchrg,0))) as oct_paid,ocbillno,ocagbillno,convert(varchar,ocagbilldt,106) as ocagbilldt,ocagoctamt,ocagserchrg,ocagothchrg,clearchrg,formchrg,sundrychrg,actserchrg,ocagserchrg,servchargeper,convert(varchar,ocduedt,106)as ocduedt,octotaldue from webx_oct_hdr where ocbillno in (" + BillEntry + ")";

        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;
        gvAgentBill.DataSource = dv;
        gvAgentBill.DataBind();
        conn.Close();

        gvAgentBill.FooterRow.Cells[4].Text = Oct_Paid.ToString("0.00");
        gvAgentBill.FooterRow.Cells[5].Text = AgeChrg.ToString("0.00");
        gvAgentBill.FooterRow.Cells[6].Text = OthChrg.ToString("0.00");
        gvAgentBill.FooterRow.Cells[7].Text = CleChrg.ToString("0.00");
        gvAgentBill.FooterRow.Cells[8].Text = FromChrg.ToString("0.00");
        gvAgentBill.FooterRow.Cells[9].Text = SundryChrg.ToString("0.00");
        gvAgentBill.FooterRow.Cells[10].Text = SvcTax.ToString("0.00");
        gvAgentBill.FooterRow.Cells[11].Text = Totalamt.ToString("0.00");
        gvAgentBill.FooterRow.Cells[12].Text = AmtPaid.ToString("0.00");
        //gvAgentBill.FooterRow.Cells[13].Text = Totalamt.ToString("0.00");
        //gvAgentBill.FooterRow.Cells[13].Text = Sub_Total.ToString("0.00");
        TextBox t = (TextBox)(gvAgentBill.FooterRow.FindControl("txtSubTot"));
        t.Text = Totalamt.ToString("0.00");
        s = Totalamt;

        txtOctAmt.Text = Oct_Paid.ToString("0.00");
        txtAgentChrg.Text = AgeChrg.ToString("0.00");
        txtOtherChrg.Text = OthChrg.ToString("0.00");
        txtSvcTax.Text = SvcTax.ToString("0.00");
        txtClearChrg.Text = CleChrg.ToString("0.00");
        txtSundryChrg.Text = SundryChrg.ToString("0.00");
        txtTotChrg.Text = Total.ToString("0.00");
        txtFromChrg.Text = FromChrg.ToString("0.00");
       
    //    gvAgentBill.SelectedIndex = datarow.RowIndex;
       
        //Label Total = ((Label)gvAgentBill.SelectedRow.FindControl("lblTotal"));
        //((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text = Total.Text;
        //SubTotal = ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
        //Sub_Total += Convert.ToDouble(SubTotal);
        //((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).Text = Sub_Total.ToString("0.00");
        txtNetPay.Text = Totalamt.ToString("0.00");

    }
    protected void HeaderChecked(object sender, EventArgs e)
    {
        Int32 i;
        i = 0;
        CheckBox AgentCh = ((CheckBox)gvAgentBill.HeaderRow.FindControl("HeaderLevelCheckBox"));

        if (AgentCh.Checked == true)
        {
            foreach (GridViewRow datarow in gvAgentBill.Rows)
            {
                gvAgentBill.SelectedIndex = i;
                CheckBox AgeChecked = ((CheckBox)gvAgentBill.SelectedRow.FindControl("RowLevelCheckBox"));
                AgeChecked.Checked = true;
                Label Total =((Label)gvAgentBill.SelectedRow.FindControl("lblTotal"));                
                ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text = Total.Text;
                SubTotal = ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
                Sub_Total += Convert.ToDouble(SubTotal);
                ((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).Text = Sub_Total.ToString("0.00");                
               // AgeChecked.Attributes.Add("onclick", "javascript:return checked(" + AgeChecked.ClientID + "," + gvAgentBill.FooterRow.Cells[13].Text + "," + txtNetPay.ClientID + ")");
                //AgeChecked.Attributes.Add("onclick", "javascript:return checked(" + AgeChecked.ClientID + "," + ((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).ClientID + "," + txtNetPay.ClientID + ")");
                i += 1;
                
            }
        }
        else if (AgentCh.Checked == false)
        {
            foreach (GridViewRow datarow in gvAgentBill.Rows)
            {
                gvAgentBill.SelectedIndex = i;
                CheckBox AgeChecked = ((CheckBox)gvAgentBill.SelectedRow.FindControl("RowLevelCheckBox"));
                AgeChecked.Checked = false;                
                ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text = "";                
                ((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).Text = ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
                //AgeChecked.Attributes.Add("onclick", "javascript:return checked(" + AgeChecked.ClientID + "," + ((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).ClientID + "," + txtNetPay.ClientID + ")");
                i += 1;
            }
        }
    }
    protected void RowChecked(object sender, EventArgs e)
    {
        foreach (GridViewRow datarow in gvAgentBill.Rows)
        {
            CheckBox AgeChecked = ((CheckBox)datarow.FindControl("RowLevelCheckBox"));
            if (AgeChecked.Checked == true)
            {
                gvAgentBill.SelectedIndex = datarow.RowIndex;
                Label Total = ((Label)gvAgentBill.SelectedRow.FindControl("lblTotal"));
                ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text = Total.Text;
                SubTotal = ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
                Sub_Total += Convert.ToDouble(SubTotal);
                ((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).Text = Sub_Total.ToString("0.00");
                txtNetPay.Text = Sub_Total.ToString("0.00");  
            }
            else if (AgeChecked.Checked == false)
            {
                gvAgentBill.SelectedIndex = datarow.RowIndex;
                Label Total = ((Label)gvAgentBill.SelectedRow.FindControl("lblTotal"));
                ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text = "0.00";
                SubTotal = "0.00";//((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
                Sub_Total += Convert.ToDouble(SubTotal);
                ((TextBox)gvAgentBill.FooterRow.FindControl("txtSubTot")).Text = ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
                txtNetPay.Text = ((TextBox)gvAgentBill.SelectedRow.FindControl("txtCurrAmt")).Text;
            }
            string js = "<script language=\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00_MyCPH1_txtNetPay\").value=document.getElementById(\"ctl00$MyCPH1$gvAgentBill$ctl05$txtSubTot\").value</script>";
            Page.RegisterStartupScript("abc", js);
            AgeChecked.Attributes.Add("onclick","javascript:total()");
        }

        
    }   
    
 
    protected void gvAgentBill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Oct_Paid += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "ocagoctamt"));
        Totalamt += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "octotaldue"));
        AgeChrg += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "ocagserchrg"));
        OthChrg += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "ocagothchrg"));
        CleChrg += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "clearchrg"));
        FromChrg += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "formchrg"));
        SundryChrg += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "sundrychrg"));
        SvcTax += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "actserchrg"));
        Total += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "ocagserchrg"));
        AmtPaid += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "servchargeper"));
    }
    protected void TextBox13_TextChanged(object sender, EventArgs e)
    {
       
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        DateTime dtFrom = new DateTime();
        string dtFrom2 = "";
        if (txtChequeDt.Text != "")
        {
            dtFrom = Convert.ToDateTime(txtChequeDt.Text, dtfi);
            dtFrom2 = dtFrom.ToString();
        }
        else
        {
            dtFrom2 = null;
        }
        string VoucherNo = getBillno();
        string sql1 = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sql1 = "Insert into webx_vouchertrans (Voucherno,chqno,chqdate,tdsrate,tds,othertaxrate,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,BANKNAME,DEDUCTION,TotChrg,servicetaxCharged,Entrydt,Transdate,finyear,Transtype,brcd,Entryby,Voucher_Cancel,acccode,transmode)  values ('" + VoucherNo + "','" + txtChequeNo.Text + "','" + dtFrom2 + "','" + txtTDSRate.Text + "','" + txtTDSAmt.Text + "','" + txtSerTaxDedu.Text + "','" + txtOctAmt.Text + "','" + txtAgentChrg.Text + "','" + txtSvcTax.Text + "','" + TextBox13.Text + "','" + txtNetPay.Text + "','" + cboBankAcc.SelectedItem.Text + "','" + txtDedu.Text + "','" + txtTotChrg.Text + "','" + txtSvcTax.Text + "',getdate(),'" + fn.Mydate1(EntryDt.Text) + "','" + "2007" + "','" + "Expenses" + "','" + Session["BRCD"] + "','" + "10003" + "','N','" + cboBankAcc.SelectedValue.ToString() + "','" + DropDownList1.SelectedItem.Text + "')";
        //Response.Write(sql1);
       // Response.End();
        SqlCommand cmd = new SqlCommand(sql1, conn);
        cmd.ExecuteNonQuery();        
        conn.Close();

        conn.Open();
        sql1 = "insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + VoucherNo + "'";
        SqlCommand cmd1 = new SqlCommand(sql1, conn);
        cmd1.ExecuteNonQuery();

        foreach (GridViewRow datarow in gvAgentBill.Rows)
        {
            string bno = datarow.Cells[1].Text;

           string sql123 = "update webx_oct_hdr set voucherNo='" +VoucherNo+ "',PayDt=getdate() where ocBillNo='"+ bno+ "'";
            SqlCommand cmd123 = new SqlCommand(sql123, conn);
            cmd123.ExecuteNonQuery();

            string sql1234 = "update webx_oct_det set voucherNo='" + VoucherNo + "',PAYDT=getdate()  where ocBillNo='" + bno + "'";
            SqlCommand cmd1234 = new SqlCommand(sql1234, conn);
            cmd1234.ExecuteNonQuery();

        }
         string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);

         sql1 = "exec usp_Octroi_Agentbill_Transaction 2,'" + VoucherNo + "','" + Financial_Year + "'";
         cmd1 = new SqlCommand(sql1, conn);
        cmd1.ExecuteNonQuery();



        conn.Close();


        Response.Redirect("doc_gen.aspx?ocbillno="+VoucherNo);
    }

    public string getBillno()
    {
        string finyear = System.DateTime.Today.ToString("yy");

        string voucherNo = "";
        string s1 = "";

        string sqlvoucher = "usp_next_VoucherNo_M";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        cmdvou.CommandType = CommandType.StoredProcedure;
        cmdvou.Parameters.AddWithValue("@brcd", Session["BRCD"]);
        cmdvou.Parameters.AddWithValue("@finyear", finyear);
        cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        DataSet dsvou = new DataSet();
        davou.Fill(dsvou);

        foreach (DataRow dr in dsvou.Tables[0].Rows)
        {
            voucherNo = dr["vno"].ToString();
        }
        return voucherNo;
        conn.Close();
    }
    protected void TextBox13_TextChanged1(object sender, EventArgs e)
    {
        double DeduChrg, TDSChrg, TDSAmtChrg, SvcTaxChrg, TotDude, NetPayChrg, AgeChrg, OthChrg, Net_PayChrg;

        string Dedu_Chrg = txtDedu.Text;
        string TDS_Chrg = txtTDSRate.Text;
        string TDSAmt_Chrg = txtTDSAmt.Text;
        string SvcTax_Chrg = txtSerTaxDedu.Text;
        string Age_Chrg = txtAgentChrg.Text;
        string Oth_Chrg = txtOtherChrg.Text;


        if (Dedu_Chrg == "0" && Dedu_Chrg=="")
        {
            DeduChrg = nullvalue;
        }
        else
        {
            DeduChrg = Convert.ToDouble(Dedu_Chrg);
        }
        if (TDS_Chrg == "0" && TDS_Chrg=="")
        {
            TDSChrg = nullvalue;
        }
        else
        {
            TDSChrg = Convert.ToDouble(TDS_Chrg);
        }
        if (TDSAmt_Chrg == "0" && TDSAmt_Chrg=="")
        {
            TDSAmtChrg = nullvalue;
        }
        else
        {
            TDSAmtChrg = Convert.ToDouble(TDSAmt_Chrg);
        }
        if (SvcTax_Chrg == "0" && SvcTax_Chrg=="")
        {
            SvcTaxChrg = nullvalue;
        }
        else
        {
            SvcTaxChrg = Convert.ToDouble(SvcTax_Chrg);
        }
        if (Age_Chrg == "0" && Age_Chrg=="")
        {
            AgeChrg = nullvalue;
        }
        else
        {
            AgeChrg = Convert.ToDouble(Age_Chrg);
        }
        if (Oth_Chrg == "0" && Oth_Chrg=="")
        {
            OthChrg = nullvalue;
        }
        else
        {
            OthChrg = Convert.ToDouble(Oth_Chrg);
        }
        TDSAmtChrg = ((AgeChrg + OthChrg) * TDSChrg) / 100;
        txtTDSAmt.Text = TDSAmtChrg.ToString("0.00");
        TotDude = DeduChrg + SvcTaxChrg + TDSAmtChrg;
        TextBox13.Text = TotDude.ToString();
        if (txtNetPay.Text == "")
        {
            NetPayChrg = nullvalue;
        }
        else
        {
            NetPayChrg = Convert.ToDouble(txtNetPay.Text);
        }
        //TotalNetamount = NetPayChrg;
        NetPayChrg = s - TotDude;

        if (NetPayChrg > 0)
        {
            txtNetPay.Text = NetPayChrg.ToString();
            txtPayAmt.Text = txtNetPay.Text;
        }
        else
        {
            txtNetPay.Text = "0.00";
            txtPayAmt.Text = txtNetPay.Text;
        }
        txtTDSRate.Focus();        
    }
    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (DropDownList1.SelectedValue.ToString() != "")
        {

            string sql = "";

            if (DropDownList1.SelectedValue.ToString() != "Cash")
            {

                sql = "select acccode,accdesc from webx_acctinfo where (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
                //sql = "select acccode,accdesc from webx_acctinfo where  (((bkloccode like 'All' or bkloccode like '" + Session["brcd"].ToString() + "%') AND acccategory='BANK')) order by accdesc asc";
                txtChequeDt.ReadOnly = false;
                txtChequeNo.ReadOnly = false;

            }
            else
            {
               // txtCashAmount.Text = txtadv.Text;
               sql = "select  acccode,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
                //sql = "select acccode+'~'+acccategory+'~'+accdesc as acccode,accdesc from webx_acctinfo where acccategory='CASH' order by accdesc asc";
                txtChequeDt.ReadOnly = true;
                txtChequeNo.ReadOnly = true;
            }
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds, "tab1");

            cboBankAcc.DataSource = ds;
            cboBankAcc.DataTextField = "accdesc";
            cboBankAcc.DataValueField = "acccode";
            cboBankAcc.DataBind();
            cboBankAcc.CssClass = "blackfnt";
            cboBankAcc.Items.Insert(0,"- Select One -");
        }
    }
}

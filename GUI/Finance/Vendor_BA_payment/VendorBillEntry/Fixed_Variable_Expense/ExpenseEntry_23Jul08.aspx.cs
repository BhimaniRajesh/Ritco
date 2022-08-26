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

public partial class GUI_Finance_Vendor_BA_payment_ExpenseEntry : System.Web.UI.Page
{
    public string Branch, voucherNo, VENDORNAME, BILLNO;
    MyFunctions fn = new MyFunctions();
    public static string Year = "";
    DataSet ds2 = new DataSet();
    DataTable dt = new DataTable();
    public static string mRepair = "";
    public static string mExpenseType = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Year = Session["FinYear"].ToString();
        mRepair = Request.QueryString["Repair"];
        if (mRepair == "" || mRepair == null)
        {
            mExpenseType = "Fixed";
        }
        else
        {
            mExpenseType = "Variable";
        }

        if (!(Page.IsPostBack))
        {
            Branch = Session["brcd"].ToString();
            lblServiceTax1.Text = "SERVICE TAX ( CENVET )";
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            txtBillEntryDate.Text = strrightnow;
            txtBillDt.Text = strrightnow;
            popVendor();
            //popAccountGroup();

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string sql = "select acccode,accdesc,groupcode from webx_acctinfo where acccode like 'ALS0010'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();

            while (dr.Read())
            {
                lblEducationCess.Text = dr["accdesc"].ToString();
            }
            dr.Close();
            sql = "select acccode,accdesc,groupcode from webx_acctinfo where acccode like 'ALS0011'";
             sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd.ExecuteReader();

            while (dr1.Read())
            {
                lbl_H_EducationCess.Text = dr1["accdesc"].ToString();
            }
            dr1.Close();
            conn.Close();

            txtServiceTaxRate.Attributes.Add("onblur", "javascript:return ratecalculation(" + txtServiceTaxRate.ClientID + "," + txtServiceTaxValue.ClientID + "," + txtNetAmt.ClientID + "," + txtEduCessRate.ClientID + "," + txtEduCessValue.ClientID + "," + txtTDSRate.ClientID + "," + txtTDSValue.ClientID + "," + txt_H_EduCessRate.ClientID + "," + txt_H_EduCessValue.ClientID + "," + txtOtherDedudction.ClientID + "," + txtDiscRecvd.ClientID + ")");
            txtEduCessRate.Attributes.Add("onblur", "javascript:return ratecalculation(" + txtServiceTaxRate.ClientID + "," + txtServiceTaxValue.ClientID + "," + txtNetAmt.ClientID + "," + txtEduCessRate.ClientID + "," + txtEduCessValue.ClientID + "," + txtTDSRate.ClientID + "," + txtTDSValue.ClientID + "," + txt_H_EduCessRate.ClientID + "," + txt_H_EduCessValue.ClientID + "," + txtOtherDedudction.ClientID + "," + txtDiscRecvd.ClientID + ")");
            txt_H_EduCessRate.Attributes.Add("onblur", "javascript:return ratecalculation(" + txtServiceTaxRate.ClientID + "," + txtServiceTaxValue.ClientID + "," + txtNetAmt.ClientID + "," + txtEduCessRate.ClientID + "," + txtEduCessValue.ClientID + "," + txtTDSRate.ClientID + "," + txtTDSValue.ClientID + "," + txt_H_EduCessRate.ClientID + "," + txt_H_EduCessValue.ClientID + "," + txtOtherDedudction.ClientID + "," + txtDiscRecvd.ClientID + ")");

            txtTDSRate.Attributes.Add("onblur", "javascript:return ratecalculation(" + txtServiceTaxRate.ClientID + "," + txtServiceTaxValue.ClientID + "," + txtNetAmt.ClientID + "," + txtEduCessRate.ClientID + "," + txtEduCessValue.ClientID + "," + txtTDSRate.ClientID + "," + txtTDSValue.ClientID + "," + txt_H_EduCessRate.ClientID + "," + txt_H_EduCessValue.ClientID + "," + txtOtherDedudction.ClientID + "," + txtDiscRecvd.ClientID + ")");
            txtDiscRecvd.Attributes.Add("onblur", "javascript:return ratecalculation(" + txtServiceTaxRate.ClientID + "," + txtServiceTaxValue.ClientID + "," + txtNetAmt.ClientID + "," + txtEduCessRate.ClientID + "," + txtEduCessValue.ClientID + "," + txtTDSRate.ClientID + "," + txtTDSValue.ClientID + "," + txt_H_EduCessRate.ClientID + "," + txt_H_EduCessValue.ClientID + "," + txtOtherDedudction.ClientID + "," + txtDiscRecvd.ClientID + ")");
            txtOtherDedudction.Attributes.Add("onblur", "javascript:return ratecalculation(" + txtServiceTaxRate.ClientID + "," + txtServiceTaxValue.ClientID + "," + txtNetAmt.ClientID + "," + txtEduCessRate.ClientID + "," + txtEduCessValue.ClientID + "," + txtTDSRate.ClientID + "," + txtTDSValue.ClientID + "," + txt_H_EduCessRate.ClientID + "," + txt_H_EduCessValue.ClientID + "," + txtOtherDedudction.ClientID + "," + txtDiscRecvd.ClientID + ")");


            //string js = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00$MyCPH1$txtNetPayableAmt\").disabled = true;</script>";
            //Page.RegisterStartupScript("aaa", js);


            btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit(" + cboVendorType.ClientID + "," + cboVendor.ClientID + "," + txtBillNumber.ClientID + "," + txtNetPayableAmt.ClientID + "," + cboTDS.ClientID + "," + cboCorporate.ClientID + ")");

        }
    }
    //private void popAccountGroup()
    //{
    //    dt.Clear();
    //    Int32 i;
    //    DataRow drow;

    //    for (i = 0; i < 5; i++)
    //    {
    //    drow = dt.NewRow();
    //    dt.Rows.Add(drow);
    //    }
    //    Grid1.DataSource = dt;
    //    Grid1.DataBind();
    //}


        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        ////string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_groups union select groupcode as c1 ,groupdesc as c2 from webx_groups where parentcode like 'Exp%' order by c2";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //DataTable t = new DataTable();
        //da.Fill(ds2, "tab1");

        //Grid1.DataSource = ds2;
        ////cboGroup1.DataTextField = "c2";
        ////cboGroup1.DataValueField = "c1";
        //Grid1.DataBind();
    


    //private void popAccountGroup()
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_groups union select groupcode as c1 ,groupdesc as c2 from webx_groups where parentcode like 'Exp%' order by c2";

    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //    DataSet ds = new DataSet();
    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //    da.Fill(ds, "tab1");
    //    cboGroup1.DataSource = ds;
    //    cboGroup1.DataTextField = "c2";
    //    cboGroup1.DataValueField = "c1";
    //    cboGroup1.DataBind();
        
    //    cboGroup2.DataSource = ds;
    //    cboGroup2.DataTextField = "c2";
    //    cboGroup2.DataValueField = "c1";
    //    cboGroup2.DataBind();

    //    cboGroup3.DataSource = ds;
    //    cboGroup3.DataTextField = "c2";
    //    cboGroup3.DataValueField = "c1";
    //    cboGroup3.DataBind();

    //    cboGroup4.DataSource = ds;
    //    cboGroup4.DataTextField = "c2";
    //    cboGroup4.DataValueField = "c1";
    //    cboGroup4.DataBind();

    //    cboGroup5.DataSource = ds;
    //    cboGroup5.DataTextField = "c2";
    //    cboGroup5.DataValueField = "c1";
    //    cboGroup5.DataBind();

    //    conn.Close();
    //}

    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

       // string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid not in ('02','03','04','05','08','09','10')";
        string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendorType.Items.Clear();
        cboVendorType.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cboVendorType.Items.Add(new ListItem(dr["Type_name"].ToString(), dr["Type_Code"].ToString()));
        }
        dr.Close();

        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();

        //string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_Vendor_Type union select Type_name as c2,Type_Code as c1 from webx_Vendor_Type";

        //SqlCommand sqlcmd = new SqlCommand(sql, conn);

        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        //da.Fill(ds, "tab1");
        //cboVendorType.DataSource = ds;
        //cboVendorType.DataTextField = "c1";
        //cboVendorType.DataValueField = "c2";
        //cboVendorType.DataBind();

        //conn.Close();
    }
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
        string sql = "select top 1 '' as c1,'-Select-' as c2 from webx_vendor_hdr WITH(NOLOCK) Union select distinct m.vendorcode as c1 ,m.vendorname +':'+ m.vendorcode  as c2 from webx_vendor_hdr m  WITH(NOLOCK) ,webx_vendor_det d  WITH(NOLOCK)  where m.vendorcode=d.vendorcode and vendor_type=" + strvendor + "";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "c2";
        cboVendor.DataValueField = "c1";

        cboVendor.DataBind();
        sql = "select * from webx_AcctHead WITH(NOLOCK) where codeid=" + strvendor + " and accthead is not null";
       
        sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        string acccode="", accdesc="";

        while (dr.Read())
        {
            if (dr["accthead"].ToString()!="")
            {
                acccode = dr["accthead"].ToString();
                accdesc = fn.getAccountDesc("webx_acctinfo",acccode);
               // crediit_account.Text=dr["accthead"].ToString()+":"+fn.getAccountDesc(dr["accthead"].ToString());
            }
        }
        crediit_account.Text = acccode + ":" + accdesc;
        dr.Close();

        conn.Close();


        
    }
    //protected void cboGroup(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    foreach (GridViewRow gridrow in Grid1.Rows)
    //    {
    //        DropDownList AccGroupCode = (DropDownList)gridrow.FindControl("cboAccGroupCode");
    //        DropDownList cboAccHeads = (DropDownList)gridrow.FindControl("cboAccHeads");

    //        string acctype = AccGroupCode.SelectedValue.ToString();

    //        string sql = "select top 1 '' as c1,'-Select-' as c2 from webx_acctinfo union select Acccode as c1,Accdesc +':'+ Acccode as c2 from webx_acctinfo where groupcode='" + acctype + "' order by c1";
    //        SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //        DataSet ds = new DataSet();
    //        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //        da.Fill(ds, "tab1");
    //        //cboAccHeads.Items.Add("Select");
    //        cboAccHeads.DataSource = ds;
    //        cboAccHeads.DataTextField = "c2";
    //        cboAccHeads.DataValueField = "c1";


    //        cboAccHeads.DataBind();

    //    }
    //    conn.Close();
    //}
    //protected void cboGroup1_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string acctype = cboGroup1.SelectedValue.ToString();
    //    int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
    //    string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_acctinfo union select Acccode as c1,Accdesc as c2 from webx_acctinfo where groupcode='" + acctype + "' order by c1";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
        
    //    DataSet ds = new DataSet();
    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //    da.Fill(ds, "tab1");
    //    cboHeads1.Items.Add("Select");
    //    cboHeads1.DataSource = ds;
    //    cboHeads1.DataTextField = "c2";
    //    cboHeads1.DataValueField = "c1";

    //    cboHeads1.DataBind();

    //    conn.Close();
    //}
    //protected void cboGroup2_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string acctype = cboGroup2.SelectedValue.ToString();
    //    int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
    //    string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_acctinfo union select Acccode as c1,Accdesc as c2 from webx_acctinfo where groupcode='" + acctype + "' order by c1";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //    DataSet ds = new DataSet();
    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //    da.Fill(ds, "tab1");
    //    cboHeads2.DataSource = ds;
    //    cboHeads2.DataTextField = "c2";
    //    cboHeads2.DataValueField = "c1";

    //    cboHeads2.DataBind();

    //    conn.Close();
    //}
    //protected void cboGroup3_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string acctype = cboGroup3.SelectedValue.ToString();
    //    int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
    //    string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_acctinfo union select Acccode as c1,Accdesc as c2 from webx_acctinfo where groupcode='" + acctype + "' order by c1";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //    DataSet ds = new DataSet();
    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //    da.Fill(ds, "tab1");
    //    cboHeads3.DataSource = ds;
    //    cboHeads3.DataTextField = "c2";
    //    cboHeads3.DataValueField = "c1";

    //    cboHeads3.DataBind();

    //    conn.Close();
    //}
    //protected void cboGroup4_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string acctype = cboGroup4.SelectedValue.ToString();
    //    int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
    //    string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_acctinfo union select Acccode as c1,Accdesc as c2 from webx_acctinfo where groupcode='" + acctype + "' order by c1";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //    DataSet ds = new DataSet();
    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //    da.Fill(ds, "tab1");
    //    cboHeads4.DataSource = ds;
    //    cboHeads4.DataTextField = "c2";
    //    cboHeads4.DataValueField = "c1";

    //    cboHeads4.DataBind();

    //    conn.Close();
    //}
    //protected void cboGroup5_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string acctype = cboGroup5.SelectedValue.ToString();
    //    int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
    //    string sql = "select top 1 '-Select-' as c1,'-Select-' as c2 from webx_acctinfo union select Acccode as c1,Accdesc as c2 from webx_acctinfo where groupcode='" + acctype + "' order by c1";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);

    //    DataSet ds = new DataSet();
    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //    da.Fill(ds, "tab1");
    //    cboHeads5.DataSource = ds;
    //    cboHeads5.DataTextField = "c2";
    //    cboHeads5.DataValueField = "c1";

    //    cboHeads5.DataBind();

    //    conn.Close();
    //}



    //protected void Grid1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        DropDownList d1 = (DropDownList)e.Row.FindControl("cboAccGroupCode");

    //        string sql = "select top 1 '' as c1,'  -Select- ' as c2 from webx_groups union select groupcode as c1 ,groupdesc +':'+ groupcode as c2 from webx_groups where parentcode like 'Exp%' order by c2";
    //        SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
    //        DataSet ds = new DataSet();
    //        da.Fill(ds, "tab1");

    //        d1.DataSource = ds;
    //        d1.DataTextField = "c2";
    //        d1.DataValueField = "c1";
    //        d1.DataBind();
    //    }
    //    conn.Close();
    //}

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //HQTR/BE/0700417
        string branchCode = Session["brcd"].ToString();
        string finyear = System.DateTime.Today.ToString("yy"); //fn.GetFinyear();

        string mNewCode;
        string sql = "exec WebX_SP_GetNextDocumentCode '" + Session["brcd"].ToString() + "','" + Session["FinYear"].ToString() + "','BE'";
        SqlCommand sqlcmd1 = new SqlCommand(sql, conn);

        SqlDataReader r1 = sqlcmd1.ExecuteReader();
        if (r1.Read())
        {
            BILLNO = r1[0].ToString();
        }
        r1.Close();
        

        string s1 = "";
        string sqlvoucher = "exec WebX_SP_GetNextDocumentCode '" + Session["brcd"].ToString() + "','" + Session["FinYear"].ToString() + "','VR'";
        SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);

        SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        DataSet dsvou = new DataSet();
        davou.Fill(dsvou);

        foreach (DataRow dr in dsvou.Tables[0].Rows)
        {
            voucherNo = dr[0].ToString();
        }

        string PBOV_typ = "V";
        string BILLDT = txtBillDt.Text;
        string VENDORCODE = cboVendor.SelectedValue.ToString();
        if (VENDORCODE != "")
        {
            VENDORNAME = fn.GetVendor(VENDORCODE);
            string[] venname;
            venname = VENDORNAME.Split(':');
            VENDORNAME = venname[1];
        }
       
        
        string VENDORBILLDT = txtBillEntryDate.Text;
        string VENDORBILLNO = txtBillNumber.Text;
        double PCAMT =Convert.ToDouble(txtBillAmt.Text);
        double ADVAMT = 0, OTHAMT = 0;
        double SVCTAX = Convert.ToDouble(txtServiceTaxValue.Text);
        string DUEDT = txtDueDate.Text;
        string ENTRYBY = Session["empcd"].ToString();
        string REMARK = txtRemarks.Text;
        string PAYDT = txtBillEntryDate.Text;
        double OTHERDED = 0;
        double TDSRATE = Convert.ToDouble(txtTDSRate.Text);
        double TDS = Convert.ToDouble(txtTDSValue.Text);
        double SVCTAXDED = 0;
        double OTHERCHRG = 0;
        string tdsfor = cboCorporate.SelectedValue.ToString();
        string cessamt = "0";
        string tdsgrpcode = cboTDS.SelectedValue.ToString();
        string tdsgrpdesc = cboTDS.SelectedItem.ToString();
        string betype = mExpenseType + " Expense";
        string tdsacccode = "CLA0015", tdsaccdesc = fn.getAccountDesc("webx_acctinfo", tdsacccode);
        string REFNO = txtRefNo.Text;
        double servicetaxrate = Convert.ToDouble(txtServiceTaxRate.Text);
        double othertax = Convert.ToDouble(txtEduCessRate.Text);
        double ACTothertax = Convert.ToDouble(txtEduCessValue.Text);
        double DEDUCTION_CHRG = Convert.ToDouble(txtOtherDedudction.Text);
        double discount = Convert.ToDouble(txtDiscRecvd.Text);
        double NETAMT = Convert.ToDouble(txtNetPayableAmt.Text);
        double acct_credit=0, acct_debit=0;
        string acct_acccode="", acct_Oppaccount="", acct_oppacccode="";
        string Narration = "When Expence Entry Done ,Bill is generated : " + BILLNO;
        string opertitle = mExpenseType + " Expense Bill Entry ";
        string TransNo = "1";
        string transdt = "";
        string[] exp_accdoe = crediit_account.Text.ToString().Split(':');
        string expenseacccode = exp_accdoe[0].ToString(), expenseaccdesc = exp_accdoe[1].ToString();
        string current_acccode = "", current_accdesc = "";
        string seviceacccode = "ALS0009";
         string seviceaccdesc = fn.getAccountDesc("webx_acctinfo",seviceacccode);
         string cessacccode = "ALS0010", cessaccdesc = fn.getAccountDesc("webx_acctinfo", cessacccode);
         string H_cessacccode = "ALS0011", H_cessaccdesc = fn.getAccountDesc("webx_acctinfo", H_cessacccode);
         string othincacccode = "IOT0007", othincaccdesc = fn.getAccountDesc("webx_acctinfo", othincacccode);
         string discacccode = "INC0002", discaccdesc = fn.getAccountDesc("webx_acctinfo", discacccode);
        //string BILLNO = "";

        BILLDT = fn.Mydate1(BILLDT);
        VENDORBILLDT = fn.Mydate1(VENDORBILLDT);

        PAYDT = fn.Mydate1(PAYDT);

        DUEDT = fn.Mydate1(DUEDT);
        SqlTransaction trn;
        trn = conn.BeginTransaction();


        try  //  try FOR ALL
        {


            string sqlInsert = "INSERT INTO WEBX_VENDORBILL_HDR (BILLNO, BILLSF, BRCD, BILLDT, VENDORCODE, VENDORNAME, VENDORBILLDT,VENDORBILLNO, PCAMT, ADVAMT, OTHAMT, SVCTAX, DUEDT,ENTRYBY, ENTRYDT, REMARK, PAYDT, VOUCHERNO, OTHERDED, TDSRATE, TDS,SVCTAXDED, OTHERCHRG, NETAMT,tdsfor,cessamt,tdsgrpcode,tdsgrpdesc,betype,acccode,accdesc,REFNO,tdsacccode,tdsaccdesc,servicetaxrate,othertaxrate,othertax,DEDUCTION_CHRG,discount,PENDAMT,Hedu_cess,hdu_cessrate) VALUES('" + BILLNO + "','.','" + Session["brcd"].ToString() + "','" + BILLDT + "','" + VENDORCODE + "','" + VENDORNAME + "','" + VENDORBILLDT + "','" + VENDORBILLNO + "'," + PCAMT + "," + ADVAMT + "," + OTHAMT + "," + SVCTAX + ",'" + DUEDT + "','" + ENTRYBY + "',getdate(),'" + REMARK + "','" + PAYDT + "','" + voucherNo + "'," + OTHERDED + "," + TDSRATE + "," + TDS + "," + SVCTAXDED + "," + OTHERCHRG + "," + NETAMT + ",'" + tdsfor + "'," + cessamt + ",'" + tdsgrpcode + "','" + tdsgrpdesc + "','" + betype + "','" + expenseacccode + "','" + expenseaccdesc + "','" + REFNO + "','" + tdsacccode + "','" + tdsaccdesc + "'," + servicetaxrate + "," + othertax + "," + ACTothertax + "," + DEDUCTION_CHRG + "," + discount + "," + NETAMT + ",'"+txt_H_EduCessRate.Text+"','"+txt_H_EduCessValue.Text+"')";

            SqlCommand sqlcmd_Insert = new SqlCommand(sqlInsert, conn, trn);
            sqlcmd_Insert.ExecuteNonQuery();
            transdt = fn.Mydate1(txtBillEntryDate.Text);
            string v_approve_reject_by = "null";
            //string v_approve_reject_branch = "";
            string v_closed_by = "null";
            string v_closed_branch = "null";
            string oppacccode = "null";
            string v_approve_reject_dt = "null";
            string prepareByLoc = Branch;
            string Payto = "NUll";
            string v_approve_reject_branch = Session["brcd"].ToString(), panno = "", servicetaxNo = "";
            string entryfor = Session["empcd"].ToString(), Entryby = Session["empcd"].ToString();
            string PBOV_code = VENDORCODE, PBOV_Name = VENDORNAME;
            string Deptcode = "";
            Branch = Session["brcd"].ToString();
            //foreach (GridViewRow gridrow in Grid1.Rows)
            //{
            //    DropDownList AccGroupCode = (DropDownList)gridrow.FindControl("cboAccGroupCode");
            //    DropDownList cboAccHeads = (DropDownList)gridrow.FindControl("cboAccHeads");
            //    TextBox debit = (TextBox)gridrow.FindControl("txtDebit");
            //    TextBox narration1 = (TextBox)gridrow.FindControl("txtNarration");


            //    double debitamt = Convert.ToDouble(debit.Text);
            //    string narration = narration1.Text;
            //    if (debitamt > 0 && AccGroupCode.SelectedItem.ToString() != "")
            //    {
            //        string AccCode = cboAccHeads.SelectedValue.ToString();
            //        string[] groupdesc_acrr = cboAccHeads.SelectedItem.ToString().Split(':');
            //        string AccDesc = groupdesc_acrr[0];//cboAccHeads.SelectedItem.ToString();// AccGroupCode.SelectedItem.ToString();
            //        string AccHeadCode = AccGroupCode.SelectedValue.ToString();
            //        string AccHead =  fn.getAccountDesc("webx_acctinfo", AccCode);
            //        current_acccode = AccHeadCode;
            //        current_accdesc = fn.getAccountDesc("webx_acctinfo", current_acccode);//cboAccHeads.SelectedItem.ToString();
            //        double PCAMT1 = 0;
            //        double OTHAMT1 = 0;
            //        double SVCTAX1 = 0;
            //        double CESS1 = 0;
            //        double ADVPAID1 = 0;
            //        double OTHDED1 = 0;
            //        double SVCTAXDED1 = 0;
            //        double netpay1 = 0;
            //        double tdsded1 = 0;
            //        string DOCNO = "";

            //        string sql_Detail = "INSERT INTO WEBX_VENDORBILL_DET (BILLNO, BILLSF, DOCNO, DOCSF, PCAMT, OTHAMT, SVCTAX, CESS, ADVPAID,OTHDED, SVCTAXDED, voucherNo, paydt,netpay,tdsded,groupcode,groupdesc,acccode,accdesc,narration,debit)VALUES('" + BILLNO + "','.','" + DOCNO + "','.'," + PCAMT1 + "," + OTHAMT1 + "," + SVCTAX1 + "," + CESS1 + "," + ADVPAID1 + "," + OTHDED1 + "," + SVCTAXDED1 + ",null,null," + netpay1 + "," + tdsded1 + ",'" + AccHeadCode + "','" + AccHead + "','" + AccCode + "','" + AccDesc + "','" + narration + "'," + debitamt + ")";
            //        SqlCommand sqlcmd_InsertDetail = new SqlCommand(sql_Detail, conn, trn);
            //        sqlcmd_InsertDetail.ExecuteNonQuery();

            //    }

            //    if (debitamt > 0)
            //    {

            //        acct_credit = debitamt - Convert.ToDouble(txtTDSValue.Text);
            //        acct_debit = 0;
            //        acct_acccode = expenseacccode;
            //        acct_Oppaccount = cboAccHeads.SelectedItem.ToString();
            //        acct_oppacccode = cboAccHeads.SelectedValue.ToString();

            //        string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','OTHER BILL ENTRY' ";
            //        Response.Write("<br> sql_colamt : " + sql_Bookamt);

            //        SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
            //        //sqlcmd.Transaction = trans;
            //        sqlcmd.ExecuteNonQuery();


                    
            //        acct_acccode = cboAccHeads.SelectedValue.ToString();
            //        acct_Oppaccount = expenseaccdesc;
            //        acct_oppacccode = expenseacccode;
            //        acct_credit = 0;
            //        acct_debit = debitamt - Convert.ToDouble(txtTDSValue.Text);
            //        sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','OTHER BILL ENTRY' ";
            //        /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
            //        Response.Write("<br> sql_colamt : " + sql_Bookamt);
            //        sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
            //        //sqlcmd.Transaction = trans;
            //        sqlcmd.ExecuteNonQuery();
            //    }

            //}

            if (Convert.ToDouble(txtServiceTaxValue.Text) > 0)
            {
                acct_credit = Convert.ToDouble(txtServiceTaxValue.Text);
                acct_debit = 0;
                acct_acccode = expenseacccode;
                acct_Oppaccount = seviceaccdesc;
                acct_oppacccode = seviceacccode;

                string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);

                SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();



                acct_acccode = seviceacccode;
                acct_Oppaccount = expenseaccdesc;
                acct_oppacccode = expenseacccode;
                acct_credit = 0;
                acct_debit = Convert.ToDouble(txtServiceTaxValue.Text);
                sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);
                sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();
            
            }
            if (Convert.ToDouble(txtEduCessValue.Text) > 0)
            {
                acct_credit = Convert.ToDouble(txtEduCessValue.Text);
                acct_debit = 0;
                acct_acccode = expenseacccode;
                acct_Oppaccount = cessaccdesc;
                acct_oppacccode = cessacccode;

                string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);

                SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();



                acct_acccode = cessacccode;
                acct_Oppaccount = expenseaccdesc;
                acct_oppacccode = expenseacccode;
                acct_credit = 0;
                acct_debit = Convert.ToDouble(txtEduCessValue.Text);
                sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);
                sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txt_H_EduCessValue.Text) > 0)
            {
                acct_credit = Convert.ToDouble(txt_H_EduCessValue.Text);
                acct_debit = 0;
                acct_acccode = expenseacccode;
                acct_Oppaccount = H_cessaccdesc;
                acct_oppacccode = H_cessacccode;

                string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);

                SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();



                acct_acccode = H_cessacccode;
                acct_Oppaccount = expenseaccdesc;
                acct_oppacccode = expenseacccode;
                acct_credit = 0;
                acct_debit = Convert.ToDouble(txt_H_EduCessValue.Text);
                sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);
                sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txtTDSValue.Text) > 0)
            {
                acct_credit = Convert.ToDouble(txtTDSValue.Text);
                acct_debit = 0;
                acct_acccode = tdsacccode;
                acct_Oppaccount = current_accdesc;
                acct_oppacccode = current_acccode;

                string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);

                SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();



                acct_acccode = current_acccode;
                acct_Oppaccount = tdsaccdesc;
                acct_oppacccode = tdsacccode;
                acct_credit = 0;
                acct_debit = Convert.ToDouble(txtTDSValue.Text);
                sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);
                sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txtOtherDedudction.Text) > 0)
            {
                // current_acccode = tdsacccode;
                // current_accdesc = cboAccHeads.SelectedItem.ToString();
                acct_credit = Convert.ToDouble(txtOtherDedudction.Text);
                acct_debit = 0;
                acct_acccode = othincacccode;
                acct_Oppaccount = expenseaccdesc;
                acct_oppacccode = expenseacccode;

                string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);

                SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();



                acct_acccode = expenseacccode;
                acct_Oppaccount = othincaccdesc;
                acct_oppacccode = othincacccode;
                acct_credit = 0;
                acct_debit = Convert.ToDouble(txtOtherDedudction.Text);
                sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);
                sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();

            }
            if (Convert.ToDouble(txtDiscRecvd.Text) > 0)
            {
                // current_acccode = tdsacccode;
                // current_accdesc = cboAccHeads.SelectedItem.ToString();
                acct_credit = Convert.ToDouble(txtDiscRecvd.Text);
                acct_debit = 0;
                acct_acccode = discacccode;
                acct_Oppaccount = expenseaccdesc;
                acct_oppacccode = expenseacccode;

                string sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);

                SqlCommand sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();



                acct_acccode = expenseacccode;
                acct_Oppaccount = discaccdesc;
                acct_oppacccode = discacccode;
                acct_credit = 0;
                acct_debit = Convert.ToDouble(txtDiscRecvd.Text);
                sql_Bookamt = "exec WEBX_acctrans_insertData_ManualVoucher '" + Year + "','" + transdt + "','" + voucherNo + "','" + acct_acccode + "',Null,Null,'" + acct_debit + "','" + acct_credit + "','" + Narration + "','',0,'" + BILLNO + "','" + Branch + "','" + Deptcode + "','" + acct_Oppaccount + "','" + Entryby + "','','N','Y','" + acct_oppacccode + "',null,'" + v_approve_reject_by + "','" + v_approve_reject_branch + "','" + v_closed_by + "','" + v_closed_branch + "','','','" + Payto + "','" + entryfor + "','" + prepareByLoc + "','" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + panno + "','" + servicetaxNo + "','" + opertitle + "'";//'OTHER BILL ENTRY' ";
                /// Response.Write("<br> sql_colamt : " + sql_Bookamt1);
                //Response.Write("<br> sql_colamt : " + sql_Bookamt);
                sqlcmd = new SqlCommand(sql_Bookamt, conn, trn);
                //sqlcmd.Transaction = trans;
                sqlcmd.ExecuteNonQuery();

            }
            //trn.Commit();
            trn.Rollback();
            conn.Close();

       
        string final = "?BillNo=" + BILLNO;
        final += "&voucherNo=" + voucherNo;
        Response.Redirect("ExpenseEntryDone.aspx" + final);
             
         }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();

        }
    }

    //protected void Grid1_RowCreated(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        int no = e.Row.RowIndex + 2;
    //        String a, b, c, d, f, g, E;

    //        a = "'ctl00_MyCPH1_Grid1_ctl0" + Convert.ToString(no) + "_txtDebit'";
    //        c = "'ctl00_MyCPH1_Grid1_ctl0" + Convert.ToString(no) + "_txttotalDebit'";

    //        //TextBox t = (TextBox)(e.Row.FindControl("txtDebit"));

    //        ((TextBox)(e.Row.FindControl("txtDebit"))).Attributes.Add("onblur", "return AddNo('_txtDebit','_txttotalDebit'," + txtNetAmt.ClientID + ","+ txtBillAmt.ClientID +"),AddRowNo(" + a + "," + c + ")");
    //    }
    //}
}

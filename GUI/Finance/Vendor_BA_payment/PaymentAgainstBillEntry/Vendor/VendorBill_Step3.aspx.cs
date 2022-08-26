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

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_Vendor_VendorBill_Step3 : System.Web.UI.Page
{
    public static string billno_nos, vendortype, vendor, fromdate, todt, fromdate1, todt1, checkeddockno, RouteMode = "", Financial_Year="";
    public int totdkt = 0;
    public int totcontractamt = 0;
    public int totaldiscount = 0;
    public double totother = 0;
    public int totaladvance = 0;
    public double totnet = 0;
    public int servicetax1 = 0;
    DateTime Fromdate, Todate;

    public double totindpcamt,  totservicestax, totdiscount1, totservicetaxrate, totcess_1, totadvanceamt, tototherdeduction, totsvctdeduction, tottdsrate, tottdsdeduction, totnetpayment;
    public string thc_no, indpcamt, otheramount, servicestax, discount, servicetaxrate, cess_1, advanceamt, otherdeduction, svctdeduction, tdsrate, tdsdeduction, netpayment, documenttype;
    public static string sqlTHCPDC, fromdt, Todt, voucherNo;


    string billno;
    MyFunctions fn = new MyFunctions();
    double daxamt = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        billno_nos = Request.QueryString.Get("billno_nos");
        
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        vendortype = Request.QueryString.Get("vendortype");
        vendor = Request.QueryString.Get("vendor");
        fromdate = Request.QueryString.Get("fromdate").ToString();
        todt = Request.QueryString.Get("todt").ToString();
        documenttype = Request.QueryString.Get("documenttype").ToString();
        checkeddockno = Request.QueryString.Get("checkeddockno").ToString();
        fromdate1 = fn.Mydate1(fromdate);
        todt1 = fn.Mydate1(todt);
        fromdt = Request.QueryString.Get("fromdate");
        RouteMode = Request.QueryString.Get("RouteMode");
        Todt = Request.QueryString.Get("todt");


        //Response.Write(checkeddockno);
        //Response.End();

        if (!IsPostBack)
        {
            
            if (fromdt != "")
            {
                Fromdate = Convert.ToDateTime(fromdate1);
                fromdt = Fromdate.ToString("dd/MM/yyyy");//Convert.ToString().ToString("dd/MM/yyyy");
            }

            if (Todt != "")
            {
                Todate = Convert.ToDateTime(todt1);
                Todt = Todate.ToString("dd/MM/yyyy");
            }
            lblDocDate.Text = fromdate1.Trim() + "-" + todt1.Trim();
            lblVendor.Text = fn.GetVendor(vendor);
            lblVendorType.Text = fn.GetVendorType(vendortype);
            lblVendorName.Text = fn.GetVendor(vendor);

            System.DateTime rightnow = System.DateTime.Today;

            billdt.Text = rightnow.ToString("dd/MM/yyyy");
            vendorbilldt.Text = rightnow.ToString("dd/MM/yyyy");
            BindGrid();

            string varothamr = othamt.Text.ToString();
            if (varothamr == "")
            {
                varothamr = "0";
            }
            totother = Convert.ToDouble(varothamr.ToString());
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
           
            conn.Open();

            SqlDataReader dr_TDS;
            //******************Starts TDSpaybas*************************************
            string sql = "select * from webx_acctinfo where acccode ='CLA0015'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr_TDS = cmd.ExecuteReader();

            tdsacccode.Items.Clear();
            tdsacccode.Items.Add(new ListItem("Select", ""));
            while (dr_TDS.Read())
            {
                tdsacccode.Items.Add(new ListItem(dr_TDS.GetValue(1).ToString(), dr_TDS.GetValue(0).ToString()));

            }

            dr_TDS.Close();

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
                TextBox indothded = (TextBox)gridrow.FindControl("indothded");
                TextBox indsvctaxded = (TextBox)gridrow.FindControl("indsvctaxded");
                TextBox indtds_rate = (TextBox)gridrow.FindControl("indtds_rate");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                TextBox ind_H_cess = (TextBox)gridrow.FindControl("ind_H_cess");
                HiddenField txtpendamt = (HiddenField)gridrow.FindControl("txtpendamt");



                //string thc = indnetpay.ID;
                //textbox2.Attributes.Add("onblur", "javascript:return CalcpayloadTotal(" + textbox1.ClientID + "," + textbox1.ClientID + "," + textbox3.ClientID + ")");
                //indpcamt.Attributes.Add("onblur", "javascript:return calcolamt(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + ")");
                indpcamt.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indothamt.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                inddiscount.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                cboindsvctaxrate.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indsvctax.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");

                indcess.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indadvamt.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                //indadvamt.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + ")");
                indothded.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indsvctaxded.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indtds_rate.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indtdsded.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");
                indnetpay.Attributes.Add("onblur", "javascript:return calculation(" + indothamt.ClientID + "," + othamt.ClientID + "," + inddiscount.ClientID + "," + totdiscount.ClientID + "," + cboindsvctaxrate.ClientID + "," + indsvctax.ClientID + "," + indcess.ClientID + "," + indadvamt.ClientID + "," + indothded.ClientID + "," + indsvctaxded.ClientID + "," + indtds_rate.ClientID + "," + indtdsded.ClientID + "," + indnetpay.ClientID + "," + indpcamt.ClientID + "," + advamt.ClientID + "," + netamt.ClientID + "," + pcamt.ClientID + "," + cessamt.ClientID + "," + tdsded.ClientID + "," + othded.ClientID + "," + svctaxded.ClientID + "," + svctax.ClientID + "," + ind_H_cess.ClientID + ")");



                indpcamt.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indothamt.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                inddiscount.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                cboindsvctaxrate.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indsvctax.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indcess.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                ind_H_cess.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indadvamt.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indothded.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indsvctaxded.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indtds_rate.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indtdsded.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");
                indnetpay.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(this)");

                indsvctax.Attributes.Add("onfocus", "this.focus()");
                indcess.Attributes.Add("onfocus", "this.blur()");
                indtdsded.Attributes.Add("onfocus", "this.blur()");
                indnetpay.Attributes.Add("onfocus", "this.blur()");
                totcontractamt = Convert.ToInt32(indpcamt.Text) + totcontractamt;
                pcamt.Text = totcontractamt.ToString();

                daxamt = Convert.ToDouble(indothamt.Text) + daxamt;
                othamt.Text = Convert.ToString(daxamt);
            }
        }
        Button1.Attributes.Add("onclick", "javascript:return fsubmit()");
    }
    public void BindGrid()
    {

        //string sConn;

        //SqlConnection conn;
        //sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        //conn = new SqlConnection(sConn);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
       // if (documenttype == "THC")
       // {
            sqlTHCPDC = "WEBX_document_Detail_m";
       // }
      //  else if (documenttype == "Run Sheet")
       // {
           // sqlTHCPDC = "WEBX_document_Detail_m1";
      //  }
        
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

    protected void dockdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        BindGrid();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

       // Response.Write("hi..");
       // Response.End();
        string branchcode = Session["brcd"].ToString();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string finyear = System.DateTime.Today.ToString("yy");

        string s1 = "";
        string sqlvoucher = "usp_next_VoucherNo_M";
        SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        cmdvou.CommandType = CommandType.StoredProcedure;
        cmdvou.Parameters.AddWithValue("@brcd", branchcode);
        cmdvou.Parameters.AddWithValue("@finyear", finyear);
        cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        DataSet dsvou = new DataSet();
        davou.Fill(dsvou);

        foreach (DataRow dr in dsvou.Tables[0].Rows)
        {
            voucherNo = dr["vno"].ToString();
        }


        string GenerateBillNo;
        string sql = "sp_get_next_be_code";
        SqlCommand sqlcmd1 = new SqlCommand(sql, conn);
        sqlcmd1.CommandType = CommandType.StoredProcedure;
        sqlcmd1.Parameters.Add("@loccode", SqlDbType.VarChar).Value = branchcode;
        SqlDataReader r1 = sqlcmd1.ExecuteReader();
        if (r1.Read())
        {
            billno = r1["NewCode"].ToString();
        }
        r1.Close();
        double hedu_cess = 0, total_hedu_cess = 0, tototheramount=0;
        GenerateBillNo = billno;
        SqlTransaction trn;
        trn = conn.BeginTransaction();
        try
        {

            foreach (GridViewRow gridrow in dockdata.Rows)
            {

                Label THCNO = (Label)gridrow.FindControl("THCNO");
                TextBox indpcamt1 = (TextBox)gridrow.FindControl("indpcamt");
                TextBox indothamt = (TextBox)gridrow.FindControl("indothamt");
                TextBox inddiscount = (TextBox)gridrow.FindControl("inddiscount");
                TextBox cboindsvctaxrate = (TextBox)gridrow.FindControl("cboindsvctaxrate");
                TextBox indsvctax = (TextBox)gridrow.FindControl("indsvctax");
                TextBox indcess = (TextBox)gridrow.FindControl("indcess");
                TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                TextBox indothded = (TextBox)gridrow.FindControl("indothded");
                TextBox indsvctaxded = (TextBox)gridrow.FindControl("indsvctaxded");
                TextBox indtds_rate = (TextBox)gridrow.FindControl("indtds_rate");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                TextBox ind_H_cess = (TextBox)gridrow.FindControl("ind_H_cess");

                thc_no = THCNO.Text;
                indpcamt = indpcamt1.Text;
                otheramount = indothamt.Text;
                discount = inddiscount.Text;
                servicetaxrate = cboindsvctaxrate.Text;
                servicestax = indsvctax.Text;
                cess_1 = indcess.Text;
                advanceamt = indadvamt.Text;
                otherdeduction = indothded.Text;
                svctdeduction = indsvctaxded.Text;
                tdsrate = indtds_rate.Text;
                tdsdeduction = indtdsded.Text;
                netpayment = indnetpay.Text;
                hedu_cess = Convert.ToDouble(ind_H_cess.Text);

                totindpcamt += Convert.ToDouble(indpcamt);
                tototheramount += Convert.ToDouble(otheramount);
                totservicestax += Convert.ToDouble(servicestax);
                totdiscount1 += Convert.ToDouble(discount);
                totservicetaxrate += Convert.ToDouble(servicetaxrate);
                totcess_1 += Convert.ToDouble(cess_1);
                totadvanceamt += Convert.ToDouble(advanceamt);
                tototherdeduction += Convert.ToDouble(otherdeduction);
                totsvctdeduction += Convert.ToDouble(svctdeduction);
                tottdsrate += Convert.ToDouble(tdsrate);
                tottdsdeduction += Convert.ToDouble(tdsdeduction);
                totnetpayment += Convert.ToDouble(netpayment);
                total_hedu_cess += hedu_cess;



                string sqlBill_Det = "INSERT INTO WEBX_VENDORBILL_DET (BILLNO, BILLSF, DOCNO, DOCSF, PCAMT, OTHAMT, SVCTAX, CESS, ADVPAID,OTHDED, SVCTAXDED, paydt,netpay,tdsded,tds_rate,svctaxrate,discount,Hedu_cess) VALUES('" + GenerateBillNo + "','" + "." + "','" + thc_no + "','" + "." + "','" + indpcamt + "','" + otheramount + "','" + servicestax + "','" + cess_1 + "','" + advanceamt + "','" + otherdeduction + "','" + svctdeduction + "','" + "" + "','" + netpayment + "','" + tdsdeduction + "','" + tdsrate + "','" + servicetaxrate + "','" + discount + "'," + hedu_cess + ")";
                SqlCommand sqlcmd2 = new SqlCommand(sqlBill_Det, conn, trn);

                //Response.Write("sqlBill_Det" + sqlBill_Det);

                sqlcmd2.ExecuteNonQuery();

                string sqlTHC = "update WEBX_thc_summary set svctaxrate='" + servicetaxrate + "',discount='" + discount + "',PaymentDt=getdate(),vendorbillNo='" + GenerateBillNo + "',vendorBENo='" + "" + "' where thcno='" + thc_no + "'";
                SqlCommand sqlcmd4 = new SqlCommand(sqlTHC, conn, trn);

                //Response.Write("sqlTHC" + sqlTHC);

                sqlcmd4.ExecuteNonQuery();

            }


            // Response.Write("tototheramount--" + tototheramount);
            // Response.End();

            string sqlBill_HDR = "INSERT INTO WEBX_VENDORBILL_HDR (BILLNO, BILLSF, BRCD, BILLDT, VENDORCODE, VENDORNAME, VENDORBILLDT,VENDORBILLNO, PCAMT, ADVAMT, OTHAMT, SVCTAX, DUEDT,ENTRYBY, ENTRYDT, REMARK, PAYDT, OTHERDED, TDSRATE, TDS,SVCTAXDED, OTHERCHRG, NETAMT,tdsfor,cessamt,tdsgrpcode,tdsgrpdesc,betype,tdsacccode,tdsaccdesc,discount,pendamt,hedu_cess,trn_mode) VALUES ('" + GenerateBillNo + "','" + "." + "','" + branchcode + "','" + fn.Mydate1(billdt.Text) + "','" + vendor + "','" + fn.GetVendor(vendor) + "','" + fn.Mydate1(vendorbilldt.Text) + "','" + vendorbillno.Text + "','" + totindpcamt + "','" + totadvanceamt + "'," + tototheramount + ",'" + totservicestax + "','" + fn.Mydate1(duedt.Text) + "','" + Session["empcd"].ToString() + "',getdate(),'" + Remarks.Text.ToString() + "','" + "" + "','" + tototherdeduction + "','" + tottdsrate + "','" + tottdsdeduction + "','" + totsvctdeduction + "'," + tototheramount + ",'" + totnetpayment + "','" + "" + "','" + totcess_1 + "','" + tdsacccode.SelectedValue.ToString() + "','" + tdsacccode.SelectedItem.Text.ToString() + "','THC','" + tdsacccode.SelectedValue.ToString() + "','" + tdsacccode.SelectedItem.Text.ToString() + "'," + totdiscount1 + ",'" + totnetpayment + "'," + total_hedu_cess + ",'" + RouteMode.ToString() + "')";
            //Response.Write("sqlBill_HDR" + sqlBill_HDR);
            // Response.End();


            SqlCommand sqlcmd3 = new SqlCommand(sqlBill_HDR, conn, trn);

            //Response.Write("sqlBill_HDR" + sqlBill_HDR);

            sqlcmd3.ExecuteNonQuery();

            string sql_Acct_entry = "exec usp_Vendor_Payment_transaction 1,'" + GenerateBillNo + "','" + Session["brcd"].ToString() + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "',''";
            sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
            // Response.Write("<br>" + sql_bal_acct_oth);
            sqlcmd3.ExecuteNonQuery();
            sql_Acct_entry = "exec usp_Vendor_Payment_transaction 2,'" + GenerateBillNo + "','" + Session["brcd"].ToString() + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "',''";
            sqlcmd3 = new SqlCommand(sql_Acct_entry, conn, trn);
            // Response.Write("<br>" + sql_bal_acct_oth);
            sqlcmd3.ExecuteNonQuery();
            sql_Acct_entry = "exec usp_Vendor_Payment_transaction 3,'" + GenerateBillNo + "','" + Session["brcd"].ToString() + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "',''";
            sqlcmd3 = new SqlCommand(sql_Acct_entry, conn,trn);
            // Response.Write("<br>" + sql_bal_acct_oth);
            sqlcmd3.ExecuteNonQuery();

            trn.Commit();
            //trn.Rollback();
            conn.Close();
            Response.Redirect("VendorBill_Done.aspx?GenerateBillNo=" + GenerateBillNo);
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
}

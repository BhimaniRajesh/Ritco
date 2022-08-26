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


public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{
    SqlConnection con;
     string strDateRange, strven, strpo;
    DataSet ds1 = new DataSet();
    MyFunctions fn = new MyFunctions();
    string Fromdt = "", Todate = "";
    string strvendor = "", Vendorcode = "", VendorName = "", MatCat = "", MatCatAcctHead = "", AcctHead = "";
    protected void Page_Load(object sender, EventArgs e)
    {
         con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
         con.Open();
         string sql = "";
         SqlCommand sqlcmd;
         SqlDataReader dr;
         Fromdt = Request.QueryString["Fromdt"].ToString();
         Todate = Request.QueryString["Todate"].ToString();
         strven = Request.QueryString["Vendorcode"].ToString();
         VendorName = Request.QueryString["VendorName"].ToString();
         strpo = Request.QueryString["POno"].ToString();
         MatCat = Request.QueryString["MatCat"].ToString(); ;
         MatCatAcctHead = Request.QueryString["MatCatAcctHead"].ToString();
        if (!IsPostBack)
        {
            TxtVoucherDT.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            Txt_VendorBillDt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");

            lblVendor.Text = fn.GetVendor(strven);
            Vendorcode = strven;
            
            string Panno = "", servtaxno = "";
            sql = "select Pan_no,servtaxno from webx_vendor_hdr A With(NOLOCK) Inner join webx_AcctHead  B With(NOLOCK) on B.Codeid=A.vendor_type where Vendorcode='" + Vendorcode + "'";
            sqlcmd = new SqlCommand(sql, con);
            dr = sqlcmd.ExecuteReader();
            while (dr.Read())
            {
                Panno = dr["Pan_no"].ToString();
                servtaxno = dr["servtaxno"].ToString();
            }
            dr.Close();
            HND_CR_Account.Value = "UNS0004";
            LblCr_Account.Text = "UNS0004" + ":" + "Sundry Creditors - Others";
            V_Staxno.Text = servtaxno;
            V_PANNO.Text = Panno;
            DipsplayReport();
        }
        TxtVoucherDT.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'13','../../../images/Date_Control_Rule_Check.aspx')");
        Txt_VendorBillDt.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'13','../../../images/Date_Control_Rule_Check.aspx')");
    }


    public void DipsplayReport()
    {
        string Sql = "Exec usp_PO_Listing_BillEntry_Ver1 '" + strpo + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);

        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_Booking.DataSource = ds;
            GV_Booking.DataBind();
            btn_submit.Enabled = true;
        }
        else
            btn_submit.Enabled = false;
       
    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Booking.PageIndex = e.NewPageIndex;
        DipsplayReport();
    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Booking.PageCount;
        GV_Booking.PageIndex = i;
        DipsplayReport();
    }
    public void fst(object sender, EventArgs e)
    {
        GV_Booking.PageIndex = 0;
        DipsplayReport();
    }

   protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GV_Booking.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=ServiceTax_Regester.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            DipsplayReport();
            GV_Booking.RenderControl(hw);
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "";
        string[] ARR_vendcd = lblVendor.Text.Split(':');
        string ptmsptcd = ARR_vendcd[0].ToString(), ptmsptnm = ARR_vendcd[1].ToString();
        string[] ARR_Credit_ledger = LblCr_Account.Text.Split(':');
        string Acccode = ARR_Credit_ledger[0].ToString(), Accdesc = ARR_Credit_ledger[1].ToString();
        SqlCommand sqlcmd;
        Sql = "exec WebX_SP_GetNextDocumentCode_FA '" + Session["brcd"].ToString() + "','" + Session["finyear"].ToString() + "','POBE'";
        sqlcmd = new SqlCommand(Sql, con);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        string Billno = "";
        while (dr.Read())
        {
            Billno = dr[0].ToString();
        }
        dr.Close();
        double CurrPayment = 0, PendPaymt = 0, Total = 0;   
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        string Accdesc_Det="";
        if (MatCatAcctHead!="")
        {
            Accdesc_Det = fn.getAccountDesc("webx_acctinfo", MatCatAcctHead);
        }
        try
        {
            string Xml_POBill_MST = "<root><PO_Mst>", Xml_POBill_Det = "<root>";
            foreach (GridViewRow gridrow in GV_Booking.Rows)
            {
                Label LblPOCODE = (Label)gridrow.FindControl("LblPOCODE");
                Label LblPendamt = (Label)gridrow.FindControl("LblPendamt");
                Label LblPaidamt = (Label)gridrow.FindControl("LblPaidamt");
                HiddenField Hnd_totalAmt = (HiddenField)gridrow.FindControl("Hnd_totalAmt");
                CheckBox chksrno = (CheckBox)gridrow.FindControl("chksrno");
                TextBox TXTCurramt = (TextBox)gridrow.FindControl("TXTCurramt");

                Xml_POBill_Det = Xml_POBill_Det + "<PO_Det>";
                Xml_POBill_Det = Xml_POBill_Det + "<BILLNO>" + Billno + "</BILLNO>";
                Xml_POBill_Det = Xml_POBill_Det + "<DOCNO>" + LblPOCODE.Text + "</DOCNO>";
                Xml_POBill_Det = Xml_POBill_Det + "<ADVPAID>" + Convert.ToDecimal(LblPaidamt.Text) + "</ADVPAID>";
                //Xml_POBill_Det = Xml_POBill_Det + "<netpay>" + Convert.ToDecimal(Hnd_totalAmt.Value) + "</netpay>";
                Xml_POBill_Det = Xml_POBill_Det + "<netpay>" + Convert.ToDecimal(TXTCurramt.Text) + "</netpay>";
                Xml_POBill_Det = Xml_POBill_Det + "<acccode>" + MatCatAcctHead + "</acccode>";
                Xml_POBill_Det = Xml_POBill_Det + "<accdesc>" + Accdesc_Det.ToString() + "</accdesc>";
                Xml_POBill_Det = Xml_POBill_Det + "<narration>" + Txt_Remarks.Text.ToString() + "</narration>";
                Xml_POBill_Det = Xml_POBill_Det + "<pendamt>" + Convert.ToDecimal(LblPendamt.Text) + "</pendamt>";
                Xml_POBill_Det = Xml_POBill_Det + "<paidamt>" + Convert.ToDecimal(LblPaidamt.Text) + "</paidamt>";
                Xml_POBill_Det = Xml_POBill_Det + "</PO_Det>";

            }
            Xml_POBill_Det = Xml_POBill_Det + "</root>";

            Xml_POBill_MST = Xml_POBill_MST + "<FinYear>" + Session["Finyear"].ToString() + "</FinYear>";
            Xml_POBill_MST = Xml_POBill_MST + "<BILLNO>" + Billno + "</BILLNO>";
            Xml_POBill_MST = Xml_POBill_MST + "<BRCD>" + Session["brcd"].ToString() + "</BRCD>";
            Xml_POBill_MST = Xml_POBill_MST + "<BILLDT>" + fn.Mydate1(TxtVoucherDT.Text.ToString()) + "</BILLDT>";
            Xml_POBill_MST = Xml_POBill_MST + "<VENDORCODE>" + ptmsptcd + "</VENDORCODE>";
            Xml_POBill_MST = Xml_POBill_MST + "<VENDORNAME>" + ptmsptnm + "</VENDORNAME>";
            Xml_POBill_MST = Xml_POBill_MST + "<VENDORBILLDT>" + fn.Mydate1(Txt_VendorBillDt.Text) + "</VENDORBILLDT>";
            Xml_POBill_MST = Xml_POBill_MST + "<VENDORBILLNO>" + Txt_vendorbillno.Text.ToString() + "</VENDORBILLNO>";
            Xml_POBill_MST = Xml_POBill_MST + "<ADVAMT>" + Convert.ToDecimal(Hnd_AdvAmt.Value) + "</ADVAMT>";
            Xml_POBill_MST = Xml_POBill_MST + "<DUEDT>" + fn.Mydate1(Txt_Duedate.Text.ToString()) + "</DUEDT>";
            Xml_POBill_MST = Xml_POBill_MST + "<DUEDAY>" + Txt_DueDays.Text.ToString().Trim() + "</DUEDAY>";
            Xml_POBill_MST = Xml_POBill_MST + "<ENTRYBY>" + Session["Empcd"].ToString() + "</ENTRYBY>";
            Xml_POBill_MST = Xml_POBill_MST + "<REMARK>" + Txt_Remarks.Text.ToString() + "</REMARK>";
            Xml_POBill_MST = Xml_POBill_MST + "<NETAMT>" + Convert.ToDecimal(Hnd_NetAmt.Value.ToString()) + "</NETAMT>";
            Xml_POBill_MST = Xml_POBill_MST + "<betype>" + "PO BILL ENTRY" + "</betype>";
            Xml_POBill_MST = Xml_POBill_MST + "<acccode>" + Acccode + "</acccode>";
            Xml_POBill_MST = Xml_POBill_MST + "<accdesc>" + Accdesc + "</accdesc>";
            Xml_POBill_MST = Xml_POBill_MST + "<bill_cancel>"+"N"+"</bill_cancel>";
            Xml_POBill_MST = Xml_POBill_MST + "<pendamt>" + Convert.ToDecimal(Hnd_PendAmt.Value.ToString()) + "</pendamt>";
            Xml_POBill_MST = Xml_POBill_MST + "<COMPANY_CODE>" + SessionUtilities.DefaultCompanyCode.ToString() + "</COMPANY_CODE>";
            Xml_POBill_MST = Xml_POBill_MST + "</PO_Mst>";
            Xml_POBill_MST = Xml_POBill_MST + "</root>";

            string Voucherno = "";
            Sql = "EXEC [Usp_POBillEntry_Generated] '" + Xml_POBill_Det + "','" + Xml_POBill_MST + "'";
            SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
            if (DR.Read())
            {
                Voucherno = DR[0].ToString();
            }
            DR.Close();
            //trans.Commit();
            trans.Rollback();
            conn.Close();
            Response.Redirect("./PO_BillEntry_Done.aspx?Billno=" + Billno);

        }
         catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }


    }
}

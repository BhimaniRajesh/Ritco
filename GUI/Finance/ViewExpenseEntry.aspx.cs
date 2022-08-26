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

public partial class GUI_Finance_Vendor_BA_payment_ViewExpenseEntry : System.Web.UI.Page
{
    public static string strSQL,expBillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            expBillNo = Convert.ToString(Request.QueryString["expBillNo"]);

            string[] Split = expBillNo.Split(new Char[] { ',' });
            expBillNo = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);
            //expBillNo = "BEHQTR00028";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

//            select top 10 b.BillNo as BillNo,b.BILLDT as BILLDT,b.VENDORCODE as VENDORCODE,b.VENDORNAME as VENDORNAME,b.acccode as acccode,
//b.accdesc as accdesc,b.VENDORBILLNO as VENDORBILLNO ,b.PCAMT as PCAMT,b.VENDORBILLDT as VENDORBILLDT,b.DUEDT as DUEDT,
//b.REFNO as REFNO,b.REMARK as REMARK,b.DEDUCTION_CHRG as DEDUCTION_CHRG,b.discount as discount,b.NETAMT as NETAMT,* 
//from webx_vendorbill_det a , webx_vendorbill_hdr b where a.billno = b.billno


            strSQL = "select (b.PCAMT-b.DEDUCTION_CHRG-b.discount) as Net_Amt,a.groupcode + ':' + a.groupdesc as groupdesc,a.acccode+ ':' +a.accdesc as accdesc,b.BillNo as BillNo,convert(varchar,b.BILLDT,106) as BILLDT,b.VENDORCODE as VENDORCODE,b.VENDORNAME as VENDORNAME,b.acccode as acccode,b.accdesc as accdesc,b.VENDORBILLNO as VENDORBILLNO ,b.PCAMT as PCAMT,convert(varchar,b.VENDORBILLDT,106) as VENDORBILLDT,convert(varchar,b.DUEDT,106) as DUEDT,b.REFNO as REFNO,b.REMARK as REMARK,b.DEDUCTION_CHRG as DEDUCTION_CHRG,b.discount as discount,b.NETAMT as NETAMT,a.debit as debit,a.acccode as acccode,a.Narration as Narration,b.servicetaxrate as servicetaxrate,b.SVCTAX as SVCTAX,b.othertaxrate as othertaxrate,b.othertax as othertax,b.tdsaccdesc as tdsaccdesc,b.NetAmt as NetAmt,b.Hedu_Cess as Hedu_Cess,b.hdu_cessrate as hdu_cessrate,b.hedu_cess as hedu_cess,b.TDSRATE as TDSRATE,b.TDS as TDS, * from webx_vendorbill_det a , webx_vendorbill_hdr b where a.billno = b.billno and a.billno='" + expBillNo + "'";
            SqlCommand sqlcmd2 = new SqlCommand(strSQL, conn);
            SqlDataReader dr;
            dr = sqlcmd2.ExecuteReader();

            while (dr.Read())
            {
                lblBillNo.Text = dr["BillNo"].ToString();
                lblBillEntryDt.Text = dr["BILLDT"].ToString();
                string vendorCode = dr["VENDORCODE"].ToString();
                lblVendorName.Text = vendorCode + ":" + dr["VENDORNAME"].ToString();
                lblVendorAccTo.Text = dr["acccode"].ToString() + ":" + dr["accdesc"].ToString();
                lblVendorBillNo.Text = dr["VENDORBILLNO"].ToString();
                lblVendorBillAmt.Text = dr["PCAMT"].ToString();
                lblVendorBillDt.Text = dr["VENDORBILLDT"].ToString();
                lblDueDt.Text = dr["DUEDT"].ToString();
                lblRefNo.Text = dr["REFNO"].ToString();
                lblRemarks.Text = dr["REMARK"].ToString();
                lblOtherDeduction.Text = dr["DEDUCTION_CHRG"].ToString();
                lblDiscountRecvd.Text = dr["discount"].ToString();
                lblNetAmt.Text = dr["Net_Amt"].ToString();
                lblHigherEduValue.Text = dr["Hedu_Cess"].ToString();

                //othertaxrate,othertax,deduction_chrg,discount,hedu_cess,hdu_cessrate
                lblServiceTaxRate.Text = dr["servicetaxrate"].ToString();
                lblServiceTaxValue.Text = dr["svctax"].ToString();

                lblEduCessRate.Text = dr["othertaxrate"].ToString();
                lblEduCessValue.Text = dr["othertax"].ToString();

                lblHigherEduRate.Text = dr["hdu_cessrate"].ToString();
                lblHigherEduValue.Text = dr["hedu_cess"].ToString();

                lblTDSRate.Text = dr["TDSRATE"].ToString();
                lblTDSValue.Text = dr["TDS"].ToString();

                lblNetPayableAmt.Text = dr["NETAMT"].ToString();


            }

            dr.Close();
            DataSet ds = new DataSet();
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlcmd2);

            sqlDA.Fill(ds, "tbl1");

            gvpdclist.DataSource = ds;
            gvpdclist.DataBind();

            conn.Close();
        }
    }
}

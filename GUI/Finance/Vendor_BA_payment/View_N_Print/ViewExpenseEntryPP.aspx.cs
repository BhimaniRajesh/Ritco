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

public partial class GUI_Finance_Vendor_BA_payment_View_N_Print_ViewExpenseEntryFV : System.Web.UI.Page
{
    string VoucherNo = "";
    public static string strSQL, expBillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        VoucherNo = Request.QueryString["VNo"];

        if (!(Page.IsPostBack))
        {
            expBillNo = Convert.ToString(Request.QueryString["expBillNo"]);
           
            string[] Split = expBillNo.Split(new Char[] { ',' });
            expBillNo = Convert.ToString(Split[0]);
            VoucherNo = expBillNo;
            string print_yn = Convert.ToString(Split[1]);
            //expBillNo = "BEHQTR00028";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            strSQL = "select (b.PCAMT-b.DEDUCTION_CHRG-b.discount) as Net_Amt,''+ ':' + '' as groupdesc,b.acccode+ ':' +b.accdesc as accdesc,b.BillNo as BillNo,convert(varchar,b.BILLDT,106) as BILLDT,b.VENDORCODE as VENDORCODE,b.VENDORNAME as VENDORNAME,b.acccode as acccode,b.accdesc as accdesc,b.VENDORBILLNO as VENDORBILLNO ,b.PCAMT as PCAMT,convert(varchar,b.VENDORBILLDT,106) as VENDORBILLDT,convert(varchar,b.DUEDT,106) as DUEDT,b.REFNO as REFNO,b.REMARK as REMARK,b.DEDUCTION_CHRG as DEDUCTION_CHRG,b.discount as discount,b.NETAMT as NETAMT,b.servicetaxrate as servicetaxrate,b.SVCTAX as SVCTAX,b.othertaxrate as othertaxrate,b.othertax as othertax,b.tdsaccdesc as tdsaccdesc,b.NetAmt as NetAmt,b.Hedu_Cess as Hedu_Cess,b.hdu_cessrate as hdu_cessrate,b.hedu_cess as hedu_cess,b.TDSRATE as TDSRATE,b.TDS as TDS,b.betype, * from  webx_vendorbill_hdr b where b.billno='" + expBillNo + "'";
            SqlCommand sqlcmd2 = new SqlCommand(strSQL, conn);
            SqlDataReader dr;
            dr = sqlcmd2.ExecuteReader();
            string mBE_type = "";
            while (dr.Read())
            {
                lblBillNo.Text = dr["BillNo"].ToString();
                lblBillEntryDt.Text = dr["VENDORBILLDT"].ToString();
                string vendorCode = dr["VENDORCODE"].ToString();
                lblVendorName.Text = vendorCode + ":" + dr["VENDORNAME"].ToString();
                lblVendorAccTo.Text = dr["accdesc"].ToString();//dr["acccode"].ToString() + ":" +
                lblVendorBillNo.Text = dr["VENDORBILLNO"].ToString();
                lblVendorBillAmt.Text = dr["PCAMT"].ToString();
                lblVendorBillDt.Text = dr["BILLDT"].ToString();
                lblDueDt.Text = dr["DUEDT"].ToString();
                lblRefNo.Text = dr["REFNO"].ToString();
                lblRemarks.Text = dr["REMARK"].ToString();
                //lblOtherDeduction.Text = dr["DEDUCTION_CHRG"].ToString();
                //lblDiscountRecvd.Text = dr["discount"].ToString();
                lblNetAmt.Text = dr["Net_Amt"].ToString();
                lblHigherEduValue.Text = dr["Hedu_Cess"].ToString();

                lblServiceTaxRate.Text = dr["servicetaxrate"].ToString();
                lblServiceTaxValue.Text = dr["svctax"].ToString();

                lblEduCessRate.Text = dr["othertaxrate"].ToString();
                lblEduCessValue.Text = dr["othertax"].ToString();

                lblHigherEduRate.Text = dr["hdu_cessrate"].ToString();
                lblHigherEduValue.Text = dr["hedu_cess"].ToString();

                lblTDSRate.Text = dr["TDSRATE"].ToString();
                lblTDSValue.Text = dr["TDS"].ToString();

                lblNetPayableAmt.Text = dr["NETAMT"].ToString();
                mBE_type = dr["betype"].ToString();

                lblDiscountType.Text = dr["DISCOUNT_TYPE"].ToString();
                lblDiscount.Text =dr["discount"].ToString();
                lblPerc.Text= dr["DIS_PERC_VAL"].ToString();

                lblSBRate.Text = dr["SBCRATE"].ToString();//changed by Anupam kkc
                lblSBValue.Text = dr["SBCAMT"].ToString();//changed by Anupam kkc


                LblKKCessRate.Text = dr["KKCRATE"].ToString();//changed by Anupam kkc
                LblKKCessAmt.Text = dr["KKCAMT"].ToString();//changed by Anupam kkc
                

            }

            dr.Close();


            /*DataSet ds = new DataSet();
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlcmd2);
            sqlDA.Fill(ds, "tbl1");
            gvpdclist.DataSource = ds;
            gvpdclist.DataBind();*/
            conn.Close();

            
                BindGrid(VoucherNo);
              
            //ShowTotal(VoucherNo);

           
        }
    }

    public void BindGrid(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string sql = "Select manual_TripSheetNo as TripSheetNo,Place,(select CodeDesc from webx_master_general where CodeType='FUELTY' and CodeId=FuelType)as FuelType,Last_Km_Read,KM_Reading,o.BillNo,convert(varchar,BillDt,103) as BillDt ,Diesel_Ltr,Diesel_Rate,Amount,EXE_AMT,Remark from WEBX_VENDORBILL_DET_FUEL o, webx_fleet_vehicle_issue i where i.vslipno=o.tripsheetno and Vendor_billno ='" + VoucherNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.Text;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense.DataSource = ds;
        dgExpense.DataBind();
        
        conn.Close();





    }

    

    

   /* public void ShowTotal(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string STR = "select sum(Amt) as Amt , sum(ExeAmt) as ExeAmt from WEBX_FLEET_VOUCHEREXP_det where VoucherNo='" + VoucherNo + "'";
        SqlCommand mcmd = new SqlCommand(STR, conn);
        SqlDataReader mdr = mcmd.ExecuteReader();
        if (mdr.HasRows)
        {
            while (mdr.Read())
            {

                lblTotalAmt.Text = Convert.ToString(mdr["Amt"]);

                lblTotalExeAmt.Text = Convert.ToString(mdr["ExeAmt"]);
            }


        }

        mdr.Close();
        conn.Close();





    }*/
}

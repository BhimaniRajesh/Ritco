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


public partial class GUI_Finance_Vendor_BA_payment_View_N_Print_ViewExpenseEntryJob : System.Web.UI.Page
{
    string VoucherNo = "";
    Double Partsum = 0;
    Double Laboursum = 0;
    Double Jobsum = 0;
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

            strSQL = "select (b.PCAMT-b.DEDUCTION_CHRG-b.discount) as Net_Amt,''+ ':' + '' as groupdesc,b.acccode+ ':' +b.accdesc as accdesc,b.BillNo as BillNo,convert(varchar,b.BILLDT,106) as BILLDT,b.VENDORCODE as VENDORCODE,b.VENDORNAME as VENDORNAME,b.acccode as acccode,b.accdesc as accdesc,b.VENDORBILLNO as VENDORBILLNO ,b.PCAMT as PCAMT,convert(varchar,b.VENDORBILLDT,106) as VENDORBILLDT,convert(varchar,b.DUEDT,106) as DUEDT,b.REFNO as REFNO,b.REMARK as REMARK,b.DEDUCTION_CHRG as DEDUCTION_CHRG,b.discount as discount,b.NETAMT as NETAMT,b.servicetaxrate as servicetaxrate,b.SVCTAX as SVCTAX,b.othertaxrate as othertaxrate,b.othertax as othertax,b.tdsaccdesc as tdsaccdesc,b.NetAmt as NetAmt,b.Hedu_Cess as Hedu_Cess,b.hdu_cessrate as hdu_cessrate,b.hedu_cess as hedu_cess,b.TDSRATE as TDSRATE,b.TDS as TDS,b.betype,(case when bill_cancel='Y' then 'Yes' else 'No' end) bill_cancel,* from  webx_vendorbill_hdr b where b.billno='" + expBillNo + "'";
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
                //lblHigherEduValue.Text = dr["Hedu_Cess"].ToString();

                 LblSVCTAXRate.Text = dr["servicetaxrate"].ToString();
                 LblSVCTAXAmt.Text = dr["svctax"].ToString();

                 LblEduCessRate.Text = dr["othertaxrate"].ToString();
                 LblEduCessAmt.Text = dr["cessamt"].ToString();//othertax

                 LblHEduCessRate.Text = dr["hdu_cessrate"].ToString();
                 LblHEduCessAmt.Text = dr["hedu_cess"].ToString();

                 LblTotalTAX.Text = Convert.ToString(Convert.ToDouble(dr["svctax"].ToString()) + Convert.ToDouble(dr["cessamt"].ToString()) + Convert.ToDouble(dr["hedu_cess"].ToString()) + Convert.ToDouble(dr["SBCAMT"].ToString()) + Convert.ToDouble(dr["KKCAMT"].ToString()));// Changed By Anupam

                 LblTDSRate.Text = dr["TDSRATE"].ToString();
                 LblTDSAmt.Text = dr["TDS"].ToString();

                 LblVATRate.Text = dr["vatrate"].ToString();
                 LblVATAmt.Text = dr["vatamt"].ToString();

                 LblLabourTaxAmt.Text = LblTotalTAX.Text;
                 LblPartsTaxAmt.Text = LblVATAmt.Text;
                 LblLabourTDSAmt.Text = LblTDSAmt.Text;

                 LblTDSSection.Text = dr["tdsgrpdesc"].ToString();

                 LblSBCessRate.Text = dr["SBCRATE"].ToString(); // Added By Anupam
                 LblSBCessAmt.Text = dr["SBCAMT"].ToString();// Added By Anupam
                 LblKKCessRate.Text = dr["KKCRATE"].ToString();// Added By Anupam
                 LblKKCessAmt.Text = dr["KKCAMT"].ToString();// Added By Anupam

                //lblNetPayableAmt.Text = dr["NETAMT"].ToString();
                mBE_type = dr["betype"].ToString();
                if (dr["bill_cancel"].ToString() == "Yes") { lblCancel.Text = "(Cancelled)"; } else { lblCancel.Text = ""; }

            }

            dr.Close();



            string sql1 = "usp_JobOrderListofBill";
            SqlCommand cmd1 = new SqlCommand(sql1, conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add("@JobOrderBillNo", SqlDbType.VarChar).Value = VoucherNo;
            SqlDataReader mydr;
            mydr = cmd1.ExecuteReader();
            double TOT_ACT_LABOUR_COST = 0;
            double TOT_ACT_PART_COST = 0;
            while (mydr.Read())
            {
                TOT_ACT_LABOUR_COST = TOT_ACT_LABOUR_COST + Convert.ToDouble(mydr["TOT_ACT_LABOUR_COST"].ToString());
                TOT_ACT_PART_COST = TOT_ACT_PART_COST + Convert.ToDouble(mydr["TOT_ACT_PART_COST"].ToString());
            }
            mydr.Close();
            LblVATApplAmt.Text = Convert.ToString(TOT_ACT_PART_COST);
            LblSTAXApplAmt.Text = Convert.ToString(TOT_ACT_LABOUR_COST);
            LblTDSApplAmt.Text = Convert.ToString(TOT_ACT_LABOUR_COST);

            LblLabourApplAmt.Text = Convert.ToString(TOT_ACT_LABOUR_COST);
            LblPartsApplAmt.Text = Convert.ToString(TOT_ACT_PART_COST);

            LblLabourTotAmt.Text = Convert.ToString(Convert.ToDouble(LblLabourApplAmt.Text) + Convert.ToDouble(LblLabourTaxAmt.Text) - Convert.ToDouble(LblLabourTDSAmt.Text));
            LblPartsTotAmt.Text = Convert.ToString(Convert.ToDouble(LblPartsApplAmt.Text) + Convert.ToDouble(LblPartsTaxAmt.Text));

            LblNetPayable.Text = Convert.ToString(Convert.ToDouble(LblLabourTotAmt.Text) + Convert.ToDouble(LblPartsTotAmt.Text));
            conn.Close();

            BindGrid(VoucherNo);

        }
    }


    public void BindGrid(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string sql = "usp_JobOrderListofBill";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@JobOrderBillNo", SqlDbType.VarChar).Value = VoucherNo;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense.DataSource = ds;
        dgExpense.DataBind();

        conn.Close();

    }

    protected void dgExpense_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string labourcell = Convert.ToString(e.Item.Cells[6].Text);
            string partcell = Convert.ToString(e.Item.Cells[7].Text);
            string jobcell = Convert.ToString(e.Item.Cells[8].Text);


            if (labourcell == "")
            {
                labourcell = "0";
            }
            Double labour_cellValue = Convert.ToDouble(labourcell);
            Laboursum = Laboursum + Convert.ToDouble(labour_cellValue);


            if (partcell == "")
            {
                partcell = "0";
            }
            Double part_cellValue = Convert.ToDouble(partcell);
            Partsum = Partsum + Convert.ToDouble(part_cellValue);


           

            if (jobcell == "")
            {
                jobcell = "0";
            }
            Double job_cellValue = Convert.ToDouble(jobcell);
            Jobsum = Jobsum + Convert.ToDouble(job_cellValue);

           
        }

        if (e.Item.ItemType == ListItemType.Footer)
        {

            e.Item.Cells[6].Text = (Laboursum).ToString();
            e.Item.Cells[7].Text = (Partsum).ToString();
            e.Item.Cells[8].Text = (Jobsum).ToString();
            
        }
    }
}

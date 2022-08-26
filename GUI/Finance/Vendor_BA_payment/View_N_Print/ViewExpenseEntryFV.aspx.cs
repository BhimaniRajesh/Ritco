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
            hdfldPrint_YN.Value = print_yn;
            //expBillNo = "BEHQTR00028";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            strSQL = "select (b.PCAMT-b.DEDUCTION_CHRG-b.discount) as Net_Amt,a.groupcode + ':' + a.groupdesc as groupdesc,b.acccode+ ':' +b.accdesc as accdesc,b.BillNo as BillNo,convert(varchar,b.BILLDT,106) as BILLDT,b.VENDORCODE as VENDORCODE,b.VENDORNAME as VENDORNAME,b.acccode as acccode,b.accdesc as accdesc,b.VENDORBILLNO as VENDORBILLNO ,b.PCAMT as PCAMT,convert(varchar,b.VENDORBILLDT,106) as VENDORBILLDT,convert(varchar,b.DUEDT,106) as DUEDT,b.REFNO as REFNO,b.REMARK as REMARK,b.DEDUCTION_CHRG as DEDUCTION_CHRG,b.discount as discount,b.NETAMT as NETAMT,a.debit as debit,a.acccode as acccode,a.Narration as Narration,b.servicetaxrate as servicetaxrate,b.SVCTAX as SVCTAX,b.othertaxrate as othertaxrate,b.othertax as othertax,b.tdsaccdesc as tdsaccdesc,b.NetAmt as NetAmt,b.Hedu_Cess as Hedu_Cess,b.hdu_cessrate as hdu_cessrate,b.hedu_cess as hedu_cess,b.TDSRATE as TDSRATE,b.TDS as TDS,b.betype, * from webx_vendorbill_det a , webx_vendorbill_hdr b where a.billno = b.billno and a.billno='" + expBillNo + "'";
            SqlCommand sqlcmd2 = new SqlCommand(strSQL, conn);
            SqlDataReader dr;
            dr = sqlcmd2.ExecuteReader();
            string mBE_type = "";
            while (dr.Read())
            {
                lblBillNo.Text = dr["BillNo"].ToString();
                
                
                //lblBillEntryDt.Text = dr["VENDORBILLDT"].ToString();
                lblBillEntryDt.Text = dr["BILLDT"].ToString();
                
                string vendorCode = dr["VENDORCODE"].ToString();
                lblVendorName.Text = vendorCode + ":" + dr["VENDORNAME"].ToString();
                lblVendorAccTo.Text = dr["accdesc"].ToString();//dr["acccode"].ToString() + ":" +
                lblVendorBillNo.Text = dr["VENDORBILLNO"].ToString();
                lblVendorBillAmt.Text = dr["PCAMT"].ToString();
                //lblVendorBillDt.Text = dr["BILLDT"].ToString();
                lblVendorBillDt.Text = dr["VENDORBILLDT"].ToString();
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

            if (mBE_type == "Fixed Expense")
            {
                BindGrid1(VoucherNo);
                BindGrid2(VoucherNo);
                BindGrid3(VoucherNo);
                BindGrid4(VoucherNo);
                dgExpense.Visible = false;
                RepairExp.Visible = false;
            }
            if (mBE_type == "Variable Expense")
            {
                BindGrid(VoucherNo);
                dgExpense1.Visible = false;
                dgExpense2.Visible = false;
                dgExpense3.Visible = false;
                dgExpense4.Visible = false;
                StatExp.Visible = false;
                CrewExp.Visible = false;
                VehExp.Visible = false;
                FinExp.Visible = false;
            }
            ShowTotal(VoucherNo);

           
        }
    }

    public void BindGrid(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        SqlCommand cmd = new SqlCommand("usp_ViewVoucherDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "ABC";
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense.DataSource = ds;
        dgExpense.DataBind();
        if (ds.Tables[0].Rows.Count <= 0)
        {
            dgExpense.Visible = false;
            RepairExp.Visible = false;
        }
        conn.Close();





    }

    public void BindGrid1(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        SqlCommand cmd = new SqlCommand("usp_ViewVoucherDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "A";
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense1.DataSource = ds;
        dgExpense1.DataBind();
        if (ds.Tables[0].Rows.Count <= 0)
        {
            dgExpense1.Visible = false;
            StatExp.Visible = false;
        }
        conn.Close();





    }

    public void BindGrid2(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        SqlCommand cmd = new SqlCommand("usp_ViewVoucherDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "B";
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense2.DataSource = ds;
        dgExpense2.DataBind();
        if (ds.Tables[0].Rows.Count <= 0)
        {
            dgExpense2.Visible = false;
            CrewExp.Visible = false;
        }
        conn.Close();
    }
    public void BindGrid3(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand("usp_ViewVoucherDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "C";
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense3.DataSource = ds;
        dgExpense3.DataBind();
        if (ds.Tables[0].Rows.Count <= 0)
        {
            dgExpense3.Visible = false;
            VehExp.Visible = false;
        }
        conn.Close();

    }
    public void BindGrid4(string VoucherNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand("usp_ViewVoucherDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "D";
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgExpense4.DataSource = ds;
        dgExpense4.DataBind();
        if (ds.Tables[0].Rows.Count <= 0)
        {
            dgExpense4.Visible = false;
            FinExp.Visible = false;
        }
        conn.Close();


    }

    public void ShowTotal(string VoucherNo)
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





    }
}

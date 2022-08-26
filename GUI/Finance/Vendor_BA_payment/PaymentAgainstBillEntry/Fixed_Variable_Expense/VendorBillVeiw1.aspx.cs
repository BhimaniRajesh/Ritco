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

public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_VendorBillVeiw1 : System.Web.UI.Page
{
    public static string voucherNo;
    public double totnetpayment = 0.00;
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            voucherNo = Convert.ToString(Request.QueryString["strGenerateBillNo"]);
            string[] Split = voucherNo.Split(new Char[] { ',' });
            voucherNo = Convert.ToString(Split[0]);
            lblVoucherNo.Text = voucherNo;
            string print_yn = Convert.ToString(Split[1]);

            /*string voucherDT = Convert.ToString(Split[2]);
            string mode = Convert.ToString(Split[3]);
            string chequeNo = Convert.ToString(Split[4]);
            string chequeDt = Convert.ToString(Split[5]);
            string amount = Convert.ToString(Split[6]);
            string accCode = Convert.ToString(Split[7]);*/

            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn1.Open();

            //string sql2 = "select convert(varchar,chqdate,106) as chqdt,chqno,TRANSMODE,* from webx_vouchertrans";
            //string sql1 = "select  convert(varchar,adv_Chqdate,106) as adv_Chqdate,* from WEBX_VendorBill_hdr where voucherNo='" + voucherNo + "'";
            //string sql1 = "select * from WEBX_vendorbill_hdr where voucherNo='" + voucherNo + "'";
            //SqlCommand cmd1 = new SqlCommand(sql1, conn1);
            //SqlDataReader dr;
            //dr = cmd1.ExecuteReader();
            //if (dr.Read())
            // {


            string voucherDT = "";
            string mode = "";
            string chequeNo = "";
            string chequeDt = "";
            string amount = "";
            string accCode = "";

            string sql1 = "select convert(varchar,transdate,103)transdate,chqno,convert(varchar,chqdate,106)chqdate,transtype,oppacccode,credit,* from webx_vouchertrans_arch where voucherno='" + voucherNo + "'";
            SqlCommand cmd1 = new SqlCommand(sql1, conn1);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            if (dr.Read())
            {
                voucherDT = dr["transdate"].ToString();
                mode = dr["transtype"].ToString();
                chequeNo = dr["chqno"].ToString();
                chequeDt = dr["chqdate"].ToString();
                amount = dr["credit"].ToString();
                accCode = dr["oppacccode"].ToString();
            }
            dr.Close();

            lblVoucherDt.Text = fn.Mydate1(voucherDT);

            lblMode.Text = mode;
            if (lblMode.Text == "Cash")
            {
                lblPaymentAmt.Text = amount;
                lblChequeNo.Text = "--";
                lblChequeDt.Text = "--";
            }
            else
            {
                lblPaymentAmt.Text = amount;
                lblChequeNo.Text = chequeNo;
                lblChequeDt.Text = chequeDt;
            }
            NumberToText m = new NumberToText();
            lblWords.Text = m.numberToText(amount);

            SqlConnection conn_code = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn_code.Open();

            string sql_code = "select Accdesc from webx_acctinfo where acccode ='" + accCode + "'";
            SqlCommand sqlcmd1 = new SqlCommand(sql_code, conn_code);
            SqlDataReader dr1;
            dr1 = sqlcmd1.ExecuteReader();
            if (dr1.Read())
            {
                lblPaymentAcc.Text = dr1["Accdesc"].ToString();
            }
            dr1.Close();
            conn_code.Close();
        }


        BindGrid();
    }

    protected void dockdata_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dockdata.PageIndex = e.NewPageIndex;
        dockdata.DataBind();

        //BindGrid();
    }


    private void BindGrid()
    {
        //foreach (GridViewRow gridrow in dockdata.Rows)
        //{
        //    Label TotNet = (Label)gridrow.FindControl("TotalNetamt");

        //    if (TotNet.Text != "")
        //    {
        //        totnetpayment = totnetpayment + Convert.ToDouble(TotNet.Text);
        //        TotNet.Text = totnetpayment.ToString();
        //    }
        //    else
        //    {
        //        totnetpayment = 0.00;
        //        TotNet.Text = "0.00";
        //    }
        //}

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid,(select SERVTAXNO from webx_vendor_hdr where vendorcode=h.vendorcode) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=h.vendorcode) as PAN_NO, * from WEBX_VendorBill_hdr h where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is not null and voucherNo='" + voucherNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");


        int intTotalRecords = ds.Tables[0].Rows.Count;

        if (intTotalRecords > 0)
        {
            lblServiceTaxNo.Text = ds.Tables[0].Rows[0][3].ToString();
            lblPANNo.Text = ds.Tables[0].Rows[0][4].ToString();

            lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][9].ToString());
        }

        //totdkt = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
}

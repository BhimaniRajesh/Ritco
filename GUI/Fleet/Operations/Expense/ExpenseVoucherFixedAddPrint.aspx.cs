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

public partial class GUI_Fleet_Operations_Expense_ExpenseVoucherFixedAddPrint : System.Web.UI.Page
{
    string VoucherNo = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;


        VoucherNo = Request.QueryString["VNo"];

        if (!IsPostBack )
        {
            
            Inetialzed();
            BindGrid1();
            BindGrid2();
            BindGrid3();
            BindGrid4();
            ShowTotal();
            ShowPaymentDetail();

     
        }

         

    }

    public void ShowPaymentDetail()
    { 
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "select *,(select accdesc from webx_acctinfo where acccode=CashAccCode) CashAccName,(select accdesc from webx_acctinfo where acccode=BankAccCode) BankAccName  from WEBX_FLEET_VOUCHEREXP_HDR  where  VoucherNo='" + VoucherNo + "'";
        SqlCommand cmd = new SqlCommand(str, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlPayMode.Text = dr["Paymode"].ToString();
                if(ddlPayMode.Text=="Cash")
                {
                    txtCashAmt.Text = lblTotalExeAmt.Text;
                    txtAmtApplA.Text = lblTotalExeAmt.Text;
                    txtNetPay.Text = lblTotalExeAmt.Text;
                    ddrCashcode.Text = dr["CashAccName"].ToString();
                }
                else if(ddlPayMode.Text=="Bank")
                {
                    txtChqAmt.Text = lblTotalExeAmt.Text;
                    txtChqNo.Text = dr["ChequeNo"].ToString();
                    txtChqDate.Text = dr["ChequeDate"].ToString();
                    ddrBankaccode.Text = dr["BankAccName"].ToString();
                }

            }

        }

        dr.Close();
    }

    
    public void ShowTotal()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string STR = "select sum(Amt) as Amt , sum(ExeAmt) as ExeAmt from WEBX_FLEET_VOUCHEREXP_det where VoucherNo='"+VoucherNo+"'";
        SqlCommand mcmd = new SqlCommand(STR,conn);
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

    public void Inetialzed()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string str = "select convert(varchar,VoucherDt,103) as Vdt, *  from WEBX_FLEET_VOUCHEREXP_HDR  where  VoucherNo='" + VoucherNo + "'";
        SqlCommand cmd = new SqlCommand(str,conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                lblDate.Text = Convert.ToString(dr["Vdt"]);
             //   lblVehicleNo.Text = Convert.ToString(dr["Vehicleno"]);
                lblVerifiedBy.Text = Convert.ToString(dr["Verified_By"]);
                lblReceivedBy.Text = Convert.ToString(dr["Received_By"]);
                lblApprovedBy.Text = Convert.ToString(dr["Approved_By"]);
                lblCheckedBy.Text = Convert.ToString(dr["Checked_By"]);
                lblManfNo.Text = Convert.ToString(dr["Manual_Voucher_No"]);

            }


        }

        dr.Close();

    }

    public void BindGrid1()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        
        SqlCommand cmd = new SqlCommand("usp_ViewVoucherDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo;
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "A";
        SqlDataAdapter  da= new SqlDataAdapter(cmd);
        DataSet  ds= new DataSet();
        da.Fill(ds);
        dgExpense1.DataSource=ds;
        dgExpense1.DataBind();
        conn.Close();

         

       

    }

    public void BindGrid2()
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
        conn.Close();
   }
    public void BindGrid3()
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
        conn.Close();

    }
    public void BindGrid4()
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
        conn.Close();


    }

}
          
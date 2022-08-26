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

public partial class GUI_Operations_Crossing_ViewChallanPayment : System.Web.UI.Page
{
    public string VoucherNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            VoucherNo = Convert.ToString(Request.QueryString["VoucherNo"]);
            string[] Split = VoucherNo.Split(new Char[] { ',' });
            VoucherNo = Convert.ToString(Split[0]);
            lblVoucherno.Text = VoucherNo;
            string print_yn = Convert.ToString(Split[1]);

            BindGrid();

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string sql = "select Convert(varchar,EntryDate,06) as EntryDate,Convert(varchar,ChequeDate,06) as ChequeDate,* from Webx_CrossingChallan_Payment_Master where VoucherNo='" + VoucherNo + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                lblVoucherDt.Text = Convert.ToString(dr["EntryDate"]);
                lblModeofPayments.Text = Convert.ToString(dr["PayMode"]);
                lblTotalAmountPayables.Text = Convert.ToString(dr["TotalAmtPayable"]);
                lblTotaldeductions.Text = Convert.ToString(dr["TotalDeduction"]);
                lblChqNo.Text = Convert.ToString(dr["ChequeNo"]);
                lblTotalNetPayables.Text = Convert.ToString(dr["TotalNetPayable"]);
                lblDate.Text = Convert.ToString(dr["ChequeDate"]);
                lblCashAmt.Text = Convert.ToString(dr["BankAccCode"]);
            }
            dr.Close();
            conn.Close();
        }
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select Convert(varchar,ChallanDate,06) as ChallanDate,*  from Webx_CrossingChallan_Payment_Detail where VoucherNo='" + VoucherNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        CrossingChallanDetail.DataSource = ds;
        CrossingChallanDetail.DataBind();
        conn.Close();
    }
}

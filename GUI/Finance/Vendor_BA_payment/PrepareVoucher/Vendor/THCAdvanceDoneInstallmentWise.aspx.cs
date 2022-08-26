using System;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvanceDoneInstallmentWise : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dv,dvBill;
    DataSet ds,dsBill;
    string thcno, voucherNo, DocumentPrint;
    protected void Page_Load(object sender, EventArgs e)
    {
        DocumentPrint = Request.QueryString["DocumentPrint"].ToString();
        lblTHCNo.Text = DocumentPrint;
        RetrieveGridDataVoucher();
        DataGrid1.DataSource = dv;
        DataGrid1.DataBind();
        RetrieveGridDataBill();
        DataGrid2.DataSource = dvBill;
        DataGrid2.DataBind();
    }
    public void RetrieveGridDataVoucher()
    {
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_Thc_GetVoucherListInstallmetnWise";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@Thcno", SqlDbType.VarChar).Value = DocumentPrint.ToString().Trim();
        ds = new DataSet();
        da.Fill(ds);

        dv = ds.Tables[0].DefaultView;
        conn.Close();
    }
    public void RetrieveGridDataBill()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlBill = "usp_Thc_GetBillListInstallmetnWise";
        SqlCommand sqlcmdBill = new SqlCommand(sqlBill, conn);
        sqlcmdBill.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter daBill = new SqlDataAdapter(sqlcmdBill);
        daBill.SelectCommand.Parameters.Add("@Thcno", SqlDbType.VarChar).Value = DocumentPrint.ToString().Trim();
        dsBill = new DataSet();
        daBill.Fill(dsBill);
        dvBill = dsBill.Tables[0].DefaultView;
        conn.Close();
    }
}
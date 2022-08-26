using System;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_THCPendingChequeDoneInstallmentWise : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dv, dvBill;
    DataSet ds, dsBill;
    string thcno, voucherNo, DocumentPrint;
    protected void Page_Load(object sender, EventArgs e)
    {
        DocumentPrint = Request.QueryString["DocumentPrint"].ToString();
        lblTHCNo.Text = DocumentPrint;
        RetrieveGridDataVoucher();
        DataGrid1.DataSource = dv;
        DataGrid1.DataBind();
    }

    public void RetrieveGridDataVoucher()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_Thc_GetVoucherListPengingCheque";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@Thcno", SqlDbType.VarChar).Value = DocumentPrint.ToString().Trim();
        ds = new DataSet();
        da.Fill(ds);

        dv = ds.Tables[0].DefaultView;
        conn.Close();
    }
   
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string final = "?DocumentNo=" + "";
        final += "&VendorBill=" + "";
        final += "&dtFrom=" + "01 JAN 2008";
        final += "&dtTo=" + DateTime.Now.ToString("dd MMM yyyy");
        final += "&VehicleNo=" + "";
        final += "&vendor=0";
        final += "&Location=" + SessionUtilities.CurrentBranchCode;

        Response.Redirect("PendingTHCAdvanceCheque.aspx" + final);
    } 	

}
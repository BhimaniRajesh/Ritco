using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Drawing;
using System.Linq;
public partial class GUI_Operations_THC_ViewPrint_THCAdvanceVoucherDetailsViewPrint : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dv, dvBill;
    DataSet ds, dsBill;
    string thcno, voucherNo, DocumentPrint;

    DataTable dt;
    double total = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        DocumentPrint = Request.QueryString["DocumentPrint"].ToString();
        lblTHCNo.Text = DocumentPrint;
        RetrieveGridDataVoucher();
        //DataGrid1.DataSource = dv;
        //DataGrid1.DataBind();

        GridView1.DataSource = dv;
        GridView1.DataBind();
    }
    public void RetrieveGridDataVoucher()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString().Trim());
        conn.Open();
        string sql = "Usp_ThcAdvance_AllVoucherDetailsViewPrint";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@ThcNo", SqlDbType.VarChar).Value = DocumentPrint.ToString().Trim();
        ds = new DataSet();
        da.Fill(ds);
        dv = ds.Tables[0].DefaultView; 

        double totalSalary = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            totalSalary += Convert.ToDouble(dr["Debit"]);
        }  
        GridView1.Columns[1].FooterText = totalSalary.ToString(); 
        conn.Close();
    }
     
}
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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    SqlConnection cn;
    string status;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        status = Request.QueryString["status"];
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            Array str, str1;
            String fdate, tdate;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            
            TxtDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtRO.Text = Request.QueryString["RO"];
            txtLocation.Text = Request.QueryString["Location"];
            lblDateRange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            Lblstatus.Text = Request.QueryString["statusname"];
            LblAdviceNO.Text = Request.QueryString["AdviceNO"];
            BindTheData();
        }
    }
    public void BindTheData()
    {
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        string fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_Advice_Register_net";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", "");
        cmd.Parameters.AddWithValue("@STATUS", status);
        cmd.Parameters.AddWithValue("@advicelist", LblAdviceNO.Text);
        cmd.Parameters.AddWithValue("@finyear", fin_year);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State==ConnectionState.Closed)
        {  
            cn.Open();
        }
        sqlDA.Fill(ds, "AdvReg");
        GrdPaidFollow.DataSource = ds.Tables["AdvReg"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["AdvReg"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;  
        }
    }
    public void BindXlsData()
    {
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        string fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_Advice_Register_net";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", "");
        cmd.Parameters.AddWithValue("@STATUS", status);
        cmd.Parameters.AddWithValue("@advicelist", LblAdviceNO.Text);
        cmd.Parameters.AddWithValue("@finyear", fin_year);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "AdvReg");
        DataXlsGrid.DataSource = ds.Tables["AdvReg"];
        DataXlsGrid.DataBind();
        if (ds.Tables["AdvReg"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;
        }
    }
    public void PageIndexChanged_Click(object sender, DataGridPageChangedEventArgs e)
    {
        GrdPaidFollow.CurrentPageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        DataView dv = new DataView();
        dv = ds.Tables["AdvReg"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["AdvReg"];
        GrdPaidFollow.DataBind();  
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
    }
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {   
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {    
        DataXlsGrid.Visible = true;
        DataXlsGrid.AllowPaging = false;
        DataXlsGrid.BorderWidth = 1;
        BindXlsData();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Advicelist.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(DataXlsGrid);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}

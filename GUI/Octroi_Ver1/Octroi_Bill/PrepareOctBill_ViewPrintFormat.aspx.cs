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
using Microsoft.ApplicationBlocks.Data;
using System.Globalization;   

public partial class GUI_Octroi_Ver1_Octroi_Bill_PrepareOctBill_ViewPrintFormat : System.Web.UI.Page
{
    public string printyn = "";
    private static int PageCnt = 1;
    private DataTable DataToView
    {
        get { return (ViewState["DataToView"] != null) ? ViewState["DataToView"] as DataTable : new DataTable(); }
        set { ViewState["DataToView"] = value; }
    }  

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack && !IsCallback)
            {
                GetViewData();
                PageCnt = 1;                 
                reptMain.DataSource = GenerateData();
                reptMain.DataBind();
            }
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Error in data retrival.&detail1=Error in data retrival.&detail2=" + strex);
            return;
        }
    }
    private void GetViewData()
    {
        try
        {
            string BillNo = Request.QueryString["billno"].ToString();
            printyn = Request.QueryString["printyn"].ToString();
            string str = "exec usp_PrepareOct_BillViewPrint '" + BillNo + "'";
            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
            DataToView = dt;
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Error in data retrival.&detail1=Error in data retrival.&detail2=" + strex);
            return;
        }
    }
    private DataTable GenerateData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ID");
        dt.Columns.Add("DESC");
        dt.Rows.Add("1", "HO COPY");
        dt.Rows.Add("2", "CUSTOMER COPY");
        dt.Rows.Add("3", "ACKNOWLEDGMENT COPY ");
        return dt;
    }
    protected void reptMain_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblTitle1 = (Label)e.Item.FindControl("lblTitle1");
                HtmlControl div = (HtmlControl)e.Item.FindControl("dvPage");
                Label lblConsgnName = (Label)e.Item.FindControl("lblConsgnName");
                Label lblConsgnAdd = (Label)e.Item.FindControl("lblConsgnAdd");
                Label lblInvoiceNo = (Label)e.Item.FindControl("lblInvoiceNo");
                Label lblInvoiceDate = (Label)e.Item.FindControl("lblInvoiceDate");
                Label lblMonthof = (Label)e.Item.FindControl("lblMonthof");                
                Label lblOctTotal = (Label)e.Item.FindControl("lblOctTotal");
                Label lblServiceCharge = (Label)e.Item.FindControl("lblServiceCharge");
                Label lblSubTotal = (Label)e.Item.FindControl("lblSubTotal");
                Label lblAmtStax = (Label)e.Item.FindControl("lblAmtStax");
                Label lblStax = (Label)e.Item.FindControl("lblStax");
                Label lblCess = (Label)e.Item.FindControl("lblCess");
                Label lblHcess = (Label)e.Item.FindControl("lblHcess");
                Label lblTotal = (Label)e.Item.FindControl("lblTotal");
                Label lblAmtInWord = (Label)e.Item.FindControl("lblAmtInWord");                

                if (PageCnt < 3)
                {
                    div.Style.Add("page-break-after", "always");
                    PageCnt = PageCnt + 1;
                }

                DataRow dr = (e.Item.DataItem as DataRowView).Row as DataRow;
                if (dr.ItemArray[1] != null && lblTitle1 != null)
                    lblTitle1.Text = Convert.ToString(dr.ItemArray[1]);

                RupeesToWords objRupeesToWords = new RupeesToWords();
                if (DataToView.Rows.Count > 0)
                {

                    lblConsgnName.Text = DataToView.Rows[0]["CUSTNM"].ToString();
                    lblConsgnAdd.Text = DataToView.Rows[0]["CUSTADDRESS"].ToString();
                    lblInvoiceNo.Text = "Invoice No :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + DataToView.Rows[0]["BILLNO"].ToString();
                    lblInvoiceDate.Text = "Invoice Date : &nbsp;" + DataToView.Rows[0]["BillDate"].ToString();
                    lblMonthof.Text = "Month of : &nbsp;&nbsp;" + DataToView.Rows[0]["MonthOf"].ToString();
                    lblOctTotal.Text = Convert.ToDouble(DataToView.Rows[0]["OCTAMT"]).ToString("#,#0.00", CultureInfo.InvariantCulture);
                    lblServiceCharge.Text = Convert.ToDouble(DataToView.Rows[0]["Service_Charge"]).ToString("#,#0.00", CultureInfo.InvariantCulture);
                    lblSubTotal.Text = Convert.ToDouble(DataToView.Rows[0]["SubTotal"]).ToString("#,#0.00", CultureInfo.InvariantCulture);
                    lblAmtStax.Text = DataToView.Rows[0]["RoundServiceCharge"].ToString();
                    lblStax.Text = Convert.ToDouble(DataToView.Rows[0]["ServiceTax"]).ToString("#,#0.00", CultureInfo.InvariantCulture);
                    lblCess.Text = Convert.ToDouble(DataToView.Rows[0]["Cess"]).ToString("#,#0.00", CultureInfo.InvariantCulture);
                    lblHcess.Text = Convert.ToDouble(DataToView.Rows[0]["HCess"]).ToString("#,#0.00", CultureInfo.InvariantCulture);
                    lblTotal.Text = DataToView.Rows[0]["GrandTotal"].ToString();
                    lblAmtInWord.Text = "Rupees " + objRupeesToWords.NumberToText(Convert.ToInt64(Math.Round(Convert.ToDouble(DataToView.Rows[0]["GrandTotal"].ToString()), 0, MidpointRounding.AwayFromZero))) + " Only"; ;
                } 
            }
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Error in data retrival.&detail1=Error in data retrival.&detail2=" + strex);
            return;
        }
    }
}

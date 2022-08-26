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

public partial class GUI_Operations_Crossing_ViewPrint_CrossingChallanPaymentView2 : System.Web.UI.Page
{
    public string DocumentNo, ManualNo, dtFrom, dtTo, VehicleNo, sql, SessionBranch, fromdt, todt, s2 = "", RouteMode = "";
    public static string doctype = "";
    public string[] VehicleArray, DocumentArray, ManualNoArray;
    public int intTotalRecords;
    int i;
    SqlCommand cmd;
    SqlDataAdapter sqlDA;
    DataSet ds;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        fromdt = Request.QueryString["dtFrom"];
        fromdt = fn.Mydate(fromdt);
        todt = Request.QueryString["dtTo"];
        todt = fn.Mydate(todt);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
        SessionBranch = Session["BRCD"].ToString();

        lblDocDate.Text = fromdt + " TO " + todt;
        lblDocNo.Text = DocumentNo;
        string docno_str = "", datecls = "";

        if (Session["BRCD"].ToString() == "HQTR")
        {
            if (DocumentNo != "")
            {
                sql = "select Voucherno,(VendorCode + ':' + VendorName) as Vendor,EntryBy as Branch,TotalNetPayable,Convert(varchar,EntryDate,06) as VoucherDate from Webx_CrossingChallan_Payment_Master where voucherno='" + DocumentNo + "'";
            }
            else
            {
                sql = "select Voucherno,(VendorCode + ':' + VendorName) as Vendor,EntryBy as Branch,TotalNetPayable,Convert(varchar,EntryDate,06) as VoucherDate from Webx_CrossingChallan_Payment_Master where Convert(varchar,EntryDate,06) between Convert(datetime,'" + fromdt + "',103) and Convert(datetime,'" + todt + "',103)";
            }
        }
        else
        {
            if (DocumentNo != "")
            {
                sql = "select Voucherno,(VendorCode + ':' + VendorName) as Vendor,EntryBy as Branch,TotalNetPayable,Convert(varchar,EntryDate,06) as VoucherDate from Webx_CrossingChallan_Payment_Master where voucherno='" + DocumentNo + "' and EntryBy='" + Session["BRCD"].ToString() + "'";
            }
            else
            {
                sql = "select Voucherno,(VendorCode + ':' + VendorName) as Vendor,EntryBy as Branch,TotalNetPayable,Convert(varchar,EntryDate,06) as VoucherDate from Webx_CrossingChallan_Payment_Master where Convert(varchar,EntryDate,06) between Convert(datetime,'" + fromdt + "',103) and Convert(datetime,'" + todt + "',103) and EntryBy='" + Session["BRCD"].ToString() + "'";
            }
        }
        //Response.Write(sql);
        //Response.End();
        DipsplayReport();
    }
    public void DipsplayReport()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        cmd = new SqlCommand(sql, conn);
        sqlDA = new SqlDataAdapter(cmd);
        ds = new DataSet();
        sqlDA.Fill(ds);

        GridVoucherList.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        GridVoucherList.DataBind();
        conn.Close();
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridVoucherList.PageIndex = e.NewPageIndex;
        DipsplayReport();
    }
}

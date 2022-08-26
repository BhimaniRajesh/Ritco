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
using System.Globalization;

public partial class REPORT_SalesSummary_SalesPerson3 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string fromdt, todt, fdate, tdate, daterange, stremployee, callType;
    Array str, str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //fromdt = Request.QueryString["fromdt"].ToString();
        //todt = Request.QueryString["todt"].ToString();
        stremployee = Request.QueryString["entryby"].ToString();
        callType = Request.QueryString["callType"].ToString();

        fromdt = HttpUtility.UrlDecode(Request.QueryString["fromdt"].ToString());
        todt = HttpUtility.UrlDecode(Request.QueryString["todt"].ToString());

        DateTime f = Convert.ToDateTime(fromdt);
        DateTime t = Convert.ToDateTime(todt);

        string fd = f.ToString("dd/MM/yyyy");
        string td = t.ToString("dd/MM/yyyy");

        str = fd.Split('/');
        str1 = td.Split('/');

        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name


        daterange = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
        fromdt = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        todt = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        BindGrid();
    }
    private void BindGrid()
    {
        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";

        //{
        //    if (fromdt != "")
        //    {
        //        dtFrom = Convert.ToDateTime(fromdt, dtfi);
        //        dtTo = Convert.ToDateTime(todt, dtfi);
        //    }
        //    else
        //    {
        //        System.DateTime nowdate = System.DateTime.Today;
        //        string todate = nowdate.ToString("dd/MM/yyyy");
        //        dtFrom = Convert.ToDateTime("01/01/1950");
        //        dtTo = Convert.ToDateTime(todate);
        //    }
        //}
        conn.Open();
        string sql = "select a.callcode,convert(varchar,a.calldt,106) as calldt,a.calltime,a.personcalled, a.prospectcode + ' : ' + (select companyName from webx_prospectCustomer where prospectCode=a.ProspectCode) as prospectcode, callduration,discpoint,acctcategory from webx_callentry a where a.entryby like '" + stremployee + "%' and a.calltype like '" + callType + "%' and convert(varchar,a.calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallSummary.DataSource = dv;
        dgCallSummary.DataBind();

        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgCallSummary.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

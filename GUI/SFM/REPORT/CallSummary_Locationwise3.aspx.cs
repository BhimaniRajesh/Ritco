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

public partial class REPORT_CallSummary_Locationwise3 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string fromdt, todt, fdate, tdate, daterange, strlocation, callType, Branch;
    Array str, str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //fromdt = Request.QueryString["fromdt"].ToString();
        //todt = Request.QueryString["todt"].ToString();
        fromdt = HttpUtility.UrlDecode(Request.QueryString["fromdt"].ToString());
        todt = HttpUtility.UrlDecode(Request.QueryString["todt"].ToString());
        strlocation = Request.QueryString["location"].ToString();
        callType = Request.QueryString["callType"].ToString();
        //strtxtloccode = Request.QueryString["strtxtloccode"].ToString();
        Branch = Session["brcd"].ToString();

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
        conn.Open();
        string sql="";
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl == 1)
        {
            sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, prospectcode, callduration,discpoint,acctcategory,entryby=(select name from WebX_Master_Users where UserId=A.entryby),prospectname=(select distinct companyname from webx_ProspectCustomer   WITH(NOLOCK) where prospectcode=a.prospectcode) from webx_callentry A WITH(NOLOCK)where loccode like '" + strlocation + "%' and calltype like '" + callType + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) order by calldt";
        }
        else if(Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, prospectcode, callduration,discpoint,acctcategory,entryby=(select name from WebX_Master_Users where UserId=A.entryby),prospectname=(select distinct companyname from webx_ProspectCustomer   WITH(NOLOCK) where prospectcode=a.prospectcode) from webx_callentry A WITH(NOLOCK)where loccode like '" + strlocation + "%' and calltype like '" + callType + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and EntryBy='" + Session["empcd"].ToString() + "' order by calldt";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
        //string sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, prospectcode, callduration,discpoint,acctcategory,prospectname=(select distinct companyname from webx_ProspectCustomer   WITH(NOLOCK) where prospectcode=a.prospectcode) from webx_callentry A WITH(NOLOCK)where loccode like '" + strlocation + "%' and calltype like '" + callType + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";
            sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, prospectcode, callduration,discpoint,acctcategory,entryby=(select name from WebX_Master_Users where UserId=A.entryby),prospectname=(select distinct companyname from webx_ProspectCustomer   WITH(NOLOCK) where prospectcode=a.prospectcode) from webx_callentry A WITH(NOLOCK)where loccode like '" + strlocation + "%' and calltype like '" + callType + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and EntryBy='" + Session["empcd"].ToString() + "' order by calldt";
        }
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

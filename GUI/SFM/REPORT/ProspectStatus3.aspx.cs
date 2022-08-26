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

public partial class REPORT_ProspectStatus3 : System.Web.UI.Page
{ 
    public static SqlConnection conn;
    public static string prospect, entryby, fromdt, todt, daterange, ProspectType, value, Location, empcode, fdate, tdate, fd, td, sql1="";
    Array str, str1;
    Array entryby1;
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        prospect = Request.QueryString["pro"].ToString();

        entryby = Request.QueryString["entryby"].ToString();
        entryby1 = entryby.Split(':');
        empcode = ((string[])(entryby1))[0];
        ProspectType = Request.QueryString["ProspectType"].ToString();
        value = Request.QueryString["value"].ToString();
        Location = Request.QueryString["Location"].ToString();
        fdate = HttpUtility.UrlDecode(Request.QueryString["fromdt"].ToString());
        todt = HttpUtility.UrlDecode(Request.QueryString["todt"].ToString());
        //String[] a1, a2;
        //String fdt, tdt;
        //a1 = fdate.Split('/');
        //a2 = todt.Split('/');

        //fdate = Convert.ToString(a1[0]) + "/" + Convert.ToString(a1[1]) + "/" + Convert.ToString(a1[2]);
        //tdate = Convert.ToString(a2[0]) + "/" + Convert.ToString(a2[1]) + "/" + Convert.ToString(a2[2]);

        DateTime f = Convert.ToDateTime(fdate);
        DateTime t = Convert.ToDateTime(todt);

        fd = f.ToString("dd/MM/yyyy");
        td = t.ToString("dd/MM/yyyy");



        str = fd.Split('/');
        str1 = td.Split('/');

        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name


        daterange = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
        fromdt = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        todt = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];


        
        //fromdt = ((string[])(str))[0] + " " + FmonthName + " " + ((string[])(str))[2];
        //todt = ((string[])(str1))[0] + " " + TmonthName + " " + ((string[])(str1))[2];
        if (Location == "")
        {
            lblLocation.Text = "All";
        }
        else
        {
            lblLocation.Text = Location;
        }
        
        
        lblProspect.Text = prospect;
        lblValue.Text = value;
        lblDate.Text = fromdt + " : " + todt;

        BindGrid();

        
    }

    private void BindGrid()
    {
        if (ProspectType == "" || ProspectType == null)
        {
            lblProspectType.Text = "All";
            conn.Open();
           //string sql1 = "select a.callcode,convert(varchar,a.calldt,106) as calldt,a.calltime,a.personcalled, a.callduration,a.discpoint,a.acctcategory from webx_callentry a , webx_ProspectCustomer b where a.entryby like '" + empcode + "%'  and convert(varchar,a.calldt,106) between convert(varchar,'" + From.ToString("dd MMM yyyy") + "',106) and convert(varchar,'" + To.ToString("dd MMM yyyy") + "',106)  and b.loccode='" + Location + "' and a.ProspectCode=b.ProspectCode";
            //string sql = "SELECT prospectcode,pros.AcctCategory,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,pros.valpmonth,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and loccode like '" + location + "%'), entryby+' :'+(select top 1 empnm from webx_empmst where empcd=entryby) as entryby from webx_location L, (select callcode, a.prospectcode, entryby, AcctCategory, valpmonth, Loccode from webx_CallEntry a, (select prospectcode,max(calldt+calltime)as c_date from webx_CallEntry group by prospectcode) as b where a.prospectcode=b.prospectcode and b.c_date=a.calldt +a.calltime and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode  and L.loccode like '" + location + "%' group by pros.prospectcode,pros.valpmonth,L.LocCode,entryby,pros.AcctCategory";
            if (Location == "")
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and p.entryby='" + empcode + "'";
            }
            else
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and p.loccode='" + Location + "' and p.entryby='" + empcode + "'";
            }
            

            SqlCommand sqlcmd1 = new SqlCommand(sql1, conn);

            SqlDataAdapter da1 = new SqlDataAdapter(sqlcmd1);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);

            DataView dv1 = ds1.Tables[0].DefaultView;

            GridView1.DataSource = dv1;
            GridView1.DataBind();

            conn.Close();
        }
        else if (ProspectType == "S")
        {
            lblProspectType.Text = "Pending";
            conn.Open();
            //string sql = "select distinct a.callcode,convert(varchar,a.calldt,106) as calldt,a.calltime,a.personcalled, a.callduration,a.discpoint,a.acctcategory from webx_callentry a , webx_ProspectCustomer b where a.entryby like '" + empcode + "%'  and convert(varchar,a.calldt,106) between convert(varchar,'" + From.ToString("dd MMM yyyy") + "',106) and convert(varchar,'" + To.ToString("dd MMM yyyy") + "',106) and b.StateSub='U' or b.StateSub='S' and b.loccode='" + Location + "' and a.ProspectCode=b.ProspectCode";
            if (Location == "")
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)  and p.entryby='" + empcode + "' and Statesub = 'S'";
            }
            else
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and p.loccode='" + Location + "'  and p.entryby='" + empcode + "' and Statesub = 'S'";
            }
            SqlCommand sqlcmd = new SqlCommand(sql1, conn);
            

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            GridView1.DataSource = dv;
            GridView1.DataBind();

            conn.Close();
        }
        else if (ProspectType == "U")
        {
            lblProspectType.Text = "Lost";
            conn.Open();
            //string sql = "select a.callcode,convert(varchar,a.calldt,106) as calldt,a.calltime,a.personcalled, a.callduration,a.discpoint,a.acctcategory from webx_callentry a , webx_ProspectCustomer b where a.entryby like '" + empcode + "%'  and convert(varchar,a.calldt,106) between convert(varchar,'" + From.ToString("dd MMM yyyy") + "',106) and convert(varchar,'" + To.ToString("dd MMM yyyy") + "',106) and b.StateSub='" + ProspectType + "' and b.loccode='" + Location + "' and a.ProspectCode=b.ProspectCode";
            if (Location == "")
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and Statesub='U' and p.entryby='" + empcode + "'";
            }
            else
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and p.loccode='" + Location + "' and Statesub='U' and p.entryby='" + empcode + "'";
            }
            SqlCommand sqlcmd = new SqlCommand(sql1, conn);


            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            GridView1.DataSource = dv;
            GridView1.DataBind();

            conn.Close();
        }
        else
        {
            lblProspectType.Text = "Won";
            conn.Open();
            //string sql = "select a.callcode,convert(varchar,a.calldt,106) as calldt,a.calltime,a.personcalled, a.callduration,a.discpoint,a.acctcategory from webx_callentry a , webx_ProspectCustomer b where a.entryby like '" + empcode + "%'  and convert(varchar,a.calldt,106) between convert(varchar,'" + From.ToString("dd MMM yyyy") + "',106) and convert(varchar,'" + To.ToString("dd MMM yyyy") + "',106) and b.StateSub='" + ProspectType + "' and b.loccode='" + Location + "' and a.ProspectCode=b.ProspectCode";
            //string sql = "select * from webx_ProspectCustomer where entryby='" + empcode + "' and loccode='" + Location + "' and Statesub='A'";
            if (Location == "")
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and p.Statesub = 'A' and p.entryby='" + empcode + "'";
            }
            else
            {
                sql1 = "select (p.prospectcode+ ' : ' + p.CompanyName) as ProspectCode,CallMade=(Select count(*) from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode),(select top 1 valpmonth from webx_callentry where entryby=p.entryby and prospectcode=p.prospectcode) as OrderValue,Empcd=(Select top 1 UserId + ':' + Name from WebX_Master_Users where UserId=p.entryby) from webx_ProspectCustomer p where convert(varchar,p.registerDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) and p.loccode='" + Location + "' and p.Statesub = 'A' and p.entryby='" + empcode + "'";
            }
            SqlCommand sqlcmd = new SqlCommand(sql1, conn);


            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            GridView1.DataSource = dv;
            GridView1.DataBind();

            conn.Close();
        }
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

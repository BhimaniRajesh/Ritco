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

public partial class REPORT_sfm_funnel_report_loc_wise3 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string prospect, location, calltype, value, fdate, tdate, fromdt, todt, daterange, Branch, employeeCode,sql;
    Array str, str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Branch = Session["brcd"].ToString();
        employeeCode = Session["empcd"].ToString();
        prospect = Request.QueryString["pro"].ToString();
        location = Request.QueryString["location"].ToString();
        calltype = Request.QueryString["calltype"].ToString();
        value = Request.QueryString["value"].ToString();
        fdate = HttpUtility.UrlDecode( Request.QueryString["fromdt"].ToString());
        todt = HttpUtility.UrlDecode( Request.QueryString["todt"].ToString());

        DateTime f = Convert.ToDateTime(fdate);
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

        lblDate.Text = fromdt + " : " + todt;
        lbllocation.Text = location;
        lblProspect.Text = prospect;

        if (calltype == "")
        {
            lblProspectType.Text = "All";
        }
        else
        {
            lblProspectType.Text = calltype;
        }

        //lblProspectType.Text = calltype;
        lblValue.Text = value;

        BindGrid();
        
    }

    private void BindGrid()
    {
        

        conn.Open();
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
            if (calltype == "")
            {
                sql = "SELECT pros.prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,webx_ProspectCustomer abc,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p where a.prospectcode=p.prospectcode and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND pros.AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and convert(varchar,abc.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) group by pros.prospectcode,L.LocCode,pros.entryby ";
                //sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' group by pros.prospectcode,L.LocCode,entryby";
            }
            else
            {
                sql = "SELECT pros.prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,webx_ProspectCustomer abc,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p where a.prospectcode=p.prospectcode and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND pros.AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and convert(varchar,abc.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) group by pros.prospectcode,L.LocCode,pros.entryby ";
                //sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory ='" + calltype + "' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory = '" + calltype + "' and L.loccode like '" + location + "%' group by pros.prospectcode,L.LocCode,entryby";
            }
            
             //sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L, (select callcode, a.prospectcode, entryby, AcctCategory, valpmonth, Loccode from webx_CallEntry a, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' group by pros.prospectcode,L.LocCode,entryby";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
             sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L, (select callcode, a.prospectcode, entryby, AcctCategory, valpmonth, Loccode from webx_CallEntry a, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' group by pros.prospectcode,L.LocCode,entryby";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            if (calltype == "")
            {
                sql = "SELECT pros.prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,webx_ProspectCustomer abc,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p where a.prospectcode=p.prospectcode and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND pros.AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and pros.Entryby='" + employeeCode + "' and convert(varchar,abc.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) group by pros.prospectcode,L.LocCode,pros.entryby ";
                //sql = "SELECT pros.prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,webx_ProspectCustomer abc,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p where a.prospectcode=p.prospectcode and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND pros.AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and convert(varchar,abc.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) group by pros.prospectcode,L.LocCode,pros.entryby ";
                //sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '%" + location + "%' and Entryby='" + employeeCode + "' group by pros.prospectcode,L.LocCode,entryby";
              //sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L, (select callcode, a.prospectcode, entryby, AcctCategory, valpmonth, Loccode from webx_CallEntry a, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and Entryby='" + employeeCode + "' group by pros.prospectcode,L.LocCode,entryby";
            }
            else
            {
                sql = "SELECT pros.prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,webx_ProspectCustomer abc,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p where a.prospectcode=p.prospectcode and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND pros.AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and pros.Entryby='" + employeeCode + "' and convert(varchar,abc.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) group by pros.prospectcode,L.LocCode,pros.entryby ";
                //sql = "SELECT prospectcode,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect ,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L,(select callcode,p.RegisterDt, a.prospectcode, a.entryby, a.AcctCategory, a.valpmonth, a.Loccode from webx_CallEntry a,webx_ProspectCustomer p, (select prospectcode from webx_CallEntry ) as b where a.prospectcode=b.prospectcode  and convert(varchar,p.RegisterDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '%" + location + "%' and Entryby='" + employeeCode + "' group by pros.prospectcode,L.LocCode,entryby";
                //sql = "SELECT prospectcode,pros.AcctCategory,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and prospectcode=pros.prospectcode and AcctCategory = '" + calltype + "' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L, (select callcode, a.prospectcode, entryby, AcctCategory, valpmonth, Loccode from webx_CallEntry a, (select prospectcode from webx_CallEntry) as b where a.prospectcode=b.prospectcode and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and Entryby='" + employeeCode + "' group by pros.prospectcode,L.LocCode,entryby,pros.AcctCategory";
                //sql = "SELECT prospectcode,pros.AcctCategory,pros.prospectcode + ' : ' +(select CompanyName as Prospect from webx_ProspectCustomer where prospectcode=pros.prospectcode)  as Prospect,L.locCode,callmade= (select count(*) from webx_callentry where entryby=pros.entryby and AcctCategory like '" + calltype + "%' and loccode like '" + location + "%'), pros.entryby+' :'+(select top 1 Name from WebX_Master_Users where UserId=pros.entryby) as entryby from webx_location L, (select callcode, a.prospectcode, entryby, AcctCategory, valpmonth, Loccode from webx_CallEntry a, (select prospectcode,max(calldt+calltime)as c_date from webx_CallEntry group by prospectcode) as b where a.prospectcode=b.prospectcode and b.c_date=a.calldt +a.calltime and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)) pros where L.loccode=pros.LocCode AND AcctCategory like '" + calltype + "%' and L.loccode like '" + location + "%' and Entryby='" + employeeCode + "' group by pros.prospectcode,L.LocCode,entryby,pros.AcctCategory";
            }
            
        }
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        GridFunnle_Location_2.DataSource = dv;
        GridFunnle_Location_2.DataBind();

        conn.Close();
        
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {



    }
}

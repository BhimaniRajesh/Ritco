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

public partial class REPORT_Prospect_RegisterReport2 : System.Web.UI.Page
{
    string strCompanyName, txtempcd;
    DateTime dFromDate, dTodate, dtToDate, dtFromDate;
    SqlDataReader drRo, drLocation, drCallSummary;
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string industry, empcd, sql_register;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        industry = Convert.ToString(Request.QueryString["strIndustry"]);
        empcd = Convert.ToString(Request.QueryString["strEmpcd"]);

        if (industry == "--All--")
        {
            industry = "";
        }
        if (empcd == "")
        {

        }
        else
        {
            empcd = empcd;
        }
        //txtempcd = Convert.ToString(Request.QueryString["txtempcd"]);

        BindGrid();
    }

    public void BindGrid()
    {
        if (txtempcd == null || txtempcd == "")
        {
            conn.Open();
            //conn.Open();
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
                sql_register = "select distinct c.ProspectCode,companyName,compCity,convert(varchar,RegisterDt,106) as RegisterDt,LocCode,(select top 1 Name from WebX_Master_Users  where UserId=c.entryby) as empcd,(select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode) as no_calls , c.entryby from webx_ProspectCustomer c where c.entryby like '" + empcd + "%' and industryCode like '" + industry + "%' ";
            }
            else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
            {
                sql_register = "select distinct c.ProspectCode,companyName,compCity,convert(varchar,RegisterDt,106) as RegisterDt,LocCode,(select top 1 Name from WebX_Master_Users  where UserId=c.entryby) as empcd,(select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode) as no_calls , c.entryby from webx_ProspectCustomer c where c.entryby like '" + empcd + "%' and industryCode like '" + industry + "%'";
            }
            else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
            {
                sql_register = "select distinct c.ProspectCode,companyName,compCity,convert(varchar,RegisterDt,106) as RegisterDt,LocCode,(select top 1 Name from WebX_Master_Users  where UserId=c.entryby) as empcd,(select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode) as no_calls , c.entryby from webx_ProspectCustomer c where c.entryby='" + empcd + "' and industryCode like '" + industry + "%'";
            }
            //string sql = "select c.ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,a.EntryBy,a.LocCode,a.calldt, a.acctcategory, a.valpmonth, lastorderdt, compaddr, compCity, comppin, compphone, compwebsite, contperson, contdesign, compemail, comment,(select Name from WebX_Master_Users  where UserId=c.entryby) as empcd, (select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode ) as no_calls , c.entryby from webx_ProspectCustomer c left outer join webx_CallEntry a on c.ProspectCode=a.ProspectCode Group by c.ProspectCode,companyName,RegisterDt,a.EntryBy,a.LocCode,c.entryby,c.entryby,a.calldt, a.acctcategory, a.valpmonth, lastorderdt, compaddr, compCity, comppin, compphone, compwebsite, contperson, contdesign, compemail, comment";

            //string sql = "webx_ProspectRegisterReport";
            SqlCommand cmd = new SqlCommand(sql_register, conn);
            //cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            //da.SelectCommand.Parameters.Add("@industry", SqlDbType.VarChar).Value = industry;
            //da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = empcd;

            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgProspectRegister.DataSource = dv;
            dgProspectRegister.DataBind();

            conn.Close();
        }
        else
        {
            //conn.Open();
            //string sql = "select a.ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,a.EntryBy,a.LocCode,(select Name from WebX_Master_Users where UserId=c.entryby) as empcd, (select count(*) from webx_CallEntry where ProspectCode=a.ProspectCode ) as no_calls, a.calldt, a.acctcategory, a.valpmonth, lastorderdt, compaddr, compCity, comppin, compphone, compwebsite, contperson, contdesign, compemail, comment  from webx_callentry a, (select prospectcode,max(calldt+calltime)as c_date from webx_CallEntry  group by prospectcode) as  b , webx_ProspectCustomer c where a.prospectcode=b.prospectcode and b.c_date=a.calldt +a.calltime and a.ProspectCode=c.ProspectCode and c.entryby='" + txtempcd + "' order by RegisterDt";
            //string sql = "select c.ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,a.EntryBy,a.LocCode,a.calldt, a.acctcategory, a.valpmonth, lastorderdt, compaddr, compCity, comppin, compphone, compwebsite, contperson, contdesign, compemail, comment,(select Name from WebX_Master_Users  where UserId=c.entryby) as empcd, (select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode ) as no_calls , c.entryby from webx_ProspectCustomer c left outer join webx_CallEntry a on c.ProspectCode=a.ProspectCode where c.entryby='" + txtempcd + "' Group by c.ProspectCode,companyName,RegisterDt,a.EntryBy,a.LocCode,c.entryby ,c.entryby,a.calldt, a.acctcategory, a.valpmonth, lastorderdt, compaddr, compCity, comppin, compphone, compwebsite, contperson, contdesign, compemail, comment";
            conn.Open();

            //conn.Open();
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
                sql_register = "select distinct c.ProspectCode,companyName,compCity,convert(varchar,RegisterDt,106) as RegisterDt,LocCode,(select top 1 Name from WebX_Master_Users  where UserId=c.entryby) as empcd,(select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode) as no_calls , c.entryby from webx_ProspectCustomer c where industryCode like '" + industry + "%'";
            }
            else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
            {
                sql_register = "select distinct c.ProspectCode,companyName,compCity,convert(varchar,RegisterDt,106) as RegisterDt,LocCode,(select top 1 Name from WebX_Master_Users  where UserId=c.entryby) as empcd,(select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode) as no_calls , c.entryby from webx_ProspectCustomer c where industryCode like '" + industry + "%'";
            }
            else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
            {
                sql_register = "select distinct c.ProspectCode,companyName,compCity,convert(varchar,RegisterDt,106) as RegisterDt,LocCode,(select top 1 Name from WebX_Master_Users  where UserId=c.entryby) as empcd,(select count(*) from webx_CallEntry b where c.ProspectCode=b.ProspectCode) as no_calls , c.entryby from webx_ProspectCustomer c where c.entryby='" + empcd + "' and industryCode like '" + industry + "%'";
            }
            SqlCommand cmd = new SqlCommand(sql_register, conn);
            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgProspectRegister.DataSource = dv;
            dgProspectRegister.DataBind();

            conn.Close();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgProspectRegister.PageIndex = e.NewPageIndex;
        BindGrid();
    }

}

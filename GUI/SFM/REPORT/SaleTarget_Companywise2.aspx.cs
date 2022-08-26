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

public partial class REPORT_SaleTarget_Companywise2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string indCode1, Status, Comapny, Period, ind, Location, fdate, tdate, fromdt, todt, year, daterange;
    public static Array str, str1, str2;
    function2 fn = new function2();

    protected void Page_Load(object sender, EventArgs e)
    {   

        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        indCode1 = Request.QueryString["indCode1"].ToString();
        Status = Request.QueryString["Status"].ToString();
        Comapny = Request.QueryString["Comapny"].ToString();
        Period = Request.QueryString["Period"].ToString();
        year = Request.QueryString["year"].ToString();
        Location = Request.QueryString["Location"].ToString().Substring(0,3);

        if (Location == "All")
        {
            Location = "";
        }

        if (indCode1 == "All")
        {
            indCode1 = "";
            ind = "All";
            lblIndustry.Text = ind + ":" + fn.GetIndustryName(ind);
        }
        else
        {
            lblIndustry.Text = indCode1 + ":" + fn.GetIndustryName(indCode1);
        }

        

        if (Status == "")
        {
            lblStatus.Text = "All";
        }
        else
        {
            lblStatus.Text = Status;
        }
        if (Comapny == "")
        {
            lblCompany.Text = "All";
        }
        else
        {
            lblCompany.Text = Comapny;
        }
        
        lblPeriod.Text = Period;
        
        str2 = year.Split('-');
        fromdt = ((string[])(str2))[0];
        todt = ((string[])(str2))[1];

        str = fromdt.Split('/');
        str1 = todt.Split('/');

        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name


        daterange = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
        fdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        tdate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        if (!IsPostBack)
        {
            if (Period == "Monthly")
            {
                GridMonthly.Visible = true;
                BindMonthlyGrid();
            }
            else if (Period == "Quarterly")
            {
                GridQuartely.Visible = true;
                BindQuartlyGrid();
            }
            else
            {
                GridYearly.Visible = true;
                BindYearlyGrid();
            }
        }

    }

    private void BindYearlyGrid()
    {
        if (Status == "All")
        {
            Status = "";
        }
        if (Comapny == "All")
        {
            Comapny = "";
        }
        conn.Open();
        string sql_yearly = "select prospectid+':'+companyname as prospectcode1,empname,* from abc where industryCode like '" + indCode1 + "%' and companyName like '" + Comapny + "%' and TotalYearValue is not null and loccode like '" + Location + "%' and convert(varchar,registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and ProspectStatus like '" + Status + "%'"; //"select ProspectId,ProspectStatus,(select empnm from webx_empmst e where e.empcd = s.EntryBy) as empname, * from WEBX_SalesTarget s";
        SqlCommand sqlcmd_yearly = new SqlCommand(sql_yearly, conn);

        SqlDataAdapter da2 = new SqlDataAdapter(sqlcmd_yearly);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2, "table1");

        DataRow dr;
        sqlcmd_yearly = new SqlCommand("select prospectid+':'+companyname as prospectcode1,AcctCategory,empname,Year_total=(isnull(january,0)+isnull(february,0)+isnull(march,0))+ (isnull(April,0)+isnull(may,0)+isnull(june,0)) + (isnull(july,0)+isnull(august,0)+isnull(september,0))+(isnull(october,0)+isnull(november,0)+isnull(december,0)),total=(isnull(january,0)+isnull(february,0)+isnull(march,0))+ (isnull(April,0)+isnull(may,0)+isnull(june,0)) + (isnull(july,0)+isnull(august,0)+isnull(september,0))+(isnull(october,0)+isnull(november,0)+isnull(december,0)) from abc  where ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and industryCode like '" + indCode1 + "%'  and TotalMonthValue is not null and loccode like '" + Location + "%' and convert(varchar,registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and ProspectStatus like '" + Status + "%'", conn);
        SqlDataReader dreader;
        dreader = sqlcmd_yearly.ExecuteReader();
        while (dreader.Read())
        {
            dr = ds2.Tables["table1"].NewRow();
            dr["prospectcode1"] = Convert.ToString(dreader["prospectcode1"]);
            dr["ProspectStatus"] = Convert.ToString(dreader["AcctCategory"]);
            dr["empname"] = Convert.ToString(dreader["empname"]);
            dr["Year_no"] = Convert.ToInt32(dreader["total"]);
            dr["TotalYearValue"] = Convert.ToInt32(dreader["total"]);
            ds2.Tables["table1"].Rows.Add(dr);

        }
        dreader.Close();


        DataRow dr1;
        sqlcmd_yearly = new SqlCommand("select prospectid+':'+companyname as prospectcode1,AcctCategory,empname,Year_total=(isnull(Quater1,0)+isnull(Quater2,0)+isnull(Quater3,0))+ (isnull(Quater4,0)),total=(isnull(Quater1,0)+isnull(Quater2,0)+isnull(Quater3,0))+ (isnull(Quater4,0)) from abc  where ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and industryCode like '" + indCode1 + "%' and TotalQuaterValue is not null and loccode like '" + Location + "%' and convert(varchar,registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and ProspectStatus like '" + Status + "%'", conn);
        SqlDataReader dreader1;
        dreader1 = sqlcmd_yearly.ExecuteReader();
        while (dreader1.Read())
        {
            dr1 = ds2.Tables["table1"].NewRow();
            dr1["prospectcode1"] = Convert.ToString(dreader1["prospectcode1"]);
            dr1["ProspectStatus"] = Convert.ToString(dreader1["AcctCategory"]);
            dr1["empname"] = Convert.ToString(dreader1["empname"]);
            dr1["Year_no"] = Convert.ToInt32(dreader1["total"]);
            dr1["TotalYearValue"] = Convert.ToInt32(dreader1["total"]);
            ds2.Tables["table1"].Rows.Add(dr1);

        }
        dreader1.Close();

        GridYearly.DataSource = ds2.Tables["table1"];
        GridYearly.DataBind();

        conn.Close();
    }

    private void BindQuartlyGrid()
    {
        if (Status == "All")
        {
            Status = "";
        }
        if (Comapny == "All")
        {
            Comapny = "";
        }

        conn.Open();
        string sql_quartely = "select prospectid+':'+companyname as prospectcode1,empname,* from abc where industryCode like '" + indCode1 + "%' and companyName like '" + Comapny + "%' and TotalQuaterValue is not null and loccode like '" + Location + "%' and convert(varchar,registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and ProspectStatus like '" + Status + "%'"; //"select ProspectId,ProspectStatus,(select empnm from webx_empmst e where e.empcd = s.EntryBy) as empname, * from WEBX_SalesTarget s";
        SqlCommand sqlcmd_quartely = new SqlCommand(sql_quartely, conn);

        SqlDataAdapter da1 = new SqlDataAdapter(sqlcmd_quartely);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1, "table1");

        DataRow dr;
        sqlcmd_quartely = new SqlCommand("select prospectid+':'+companyname as prospectcode1,AcctCategory,empname,qt4=(isnull(january,0)+isnull(february,0)+isnull(march,0)), qt1=(isnull(April,0)+isnull(may,0)+isnull(june,0)), qt2=(isnull(july,0)+isnull(august,0)+isnull(september,0)), qt3=(isnull(october,0)+isnull(november,0)+isnull(december,0)),total=(isnull(january,0)+isnull(february,0)+isnull(march,0))+ (isnull(April,0)+isnull(may,0)+isnull(june,0)) + (isnull(july,0)+isnull(august,0)+isnull(september,0))+(isnull(october,0)+isnull(november,0)+isnull(december,0)) from abc  where ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and industryCode like '" + indCode1 + "%' and TotalMonthValue is not null and loccode like '" + Location + "%' and convert(varchar,registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and ProspectStatus like '" + Status + "%'", conn);
        SqlDataReader dreader;
        dreader = sqlcmd_quartely.ExecuteReader();
        while (dreader.Read())
        {
            dr = ds1.Tables["table1"].NewRow();
            dr["prospectcode1"] = Convert.ToString(dreader["prospectcode1"]);
            dr["ProspectStatus"] = Convert.ToString(dreader["AcctCategory"]);
            dr["empname"] = Convert.ToString(dreader["empname"]);
            dr["Quater1"] = Convert.ToInt32(dreader["qt1"]);
            dr["Quater2"] = Convert.ToInt32(dreader["qt2"]);
            dr["Quater3"] = Convert.ToInt32(dreader["qt3"]);
            dr["Quater4"] = Convert.ToInt32(dreader["qt4"]);
            dr["TotalQuaterValue"] = Convert.ToInt32(dreader["total"]);
            ds1.Tables["table1"].Rows.Add(dr);

        }
        dreader.Close();
        //DataView dv1 = ds1.Tables[0].DefaultView;

        GridQuartely.DataSource = ds1.Tables["table1"];
        GridQuartely.DataBind();

        conn.Close();
    }

    private void BindMonthlyGrid()
    {
        if (Status == "All")
        {
            Status = "";
        }
        if (Comapny == "All")
        {
            Comapny = "";
        }
        conn.Open();
        string sql_monthly = "select prospectid+':'+companyname as prospectcode1,empname,* from abc where industryCode like '" + indCode1 + "%' and companyName like '" + Comapny + "%' and TotalMonthValue is not null and loccode like '" + Location + "%' and convert(varchar,registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and ProspectStatus like '" + Status + "%'";
        SqlCommand sqlcmd_monthly = new SqlCommand(sql_monthly, conn);

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd_monthly);
        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        GridMonthly.DataSource = dv;
        GridMonthly.DataBind();

        conn.Close();

    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridMonthly.PageIndex = e.NewPageIndex;
        BindMonthlyGrid();
    }
}

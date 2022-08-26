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

public partial class REPORT_SaleTargetEmployeewise2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string indCode1, Status, Comapny, Period, Empcd, employeename, locationname;
    function2 fn = new function2();

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        indCode1 = Request.QueryString["indCode1"].ToString();
        Status = Request.QueryString["Status"].ToString();
        Comapny = Request.QueryString["Comapny"].ToString();
        Period = Request.QueryString["Period"].ToString();
        Empcd = Request.QueryString["Empcd"].ToString();
        locationname = Request.QueryString["locationname"].ToString();

        //conn.Open();
        //string sql = "Select empnm from webx_empmst where empcd='" + Empcd + "'";
        //SqlCommand cmd = new SqlCommand(sql, conn);
        //SqlDataReader dr;
        //dr = cmd.ExecuteReader();

        //while (dr.Read())
        //{
        //    employeename = dr[0].ToString();
        //}
        //dr.Close();
        //conn.Close();
        lblEmployee.Text = Empcd ;//+":"+ fn.GetEmployeeName(Empcd);
        //lblIndustry.Text = indCode1;

        if (Status == "")
        {
            lblStatus.Text = "All";
        }
        else
        {
            lblStatus.Text = Status;
            //if (Status == "Customer")
            //{
            //    Status = "A";
            //}
            
            
        }
        if (Comapny == "")
        {
            lblCompany.Text = "All";
        }
        else
        {
            lblCompany.Text = Comapny;
        }

        if (locationname == "")
        {
            lblLocation.Text = "All";
        }
        else
        {
            lblLocation.Text = locationname;
        }


        lblPeriod.Text = Period;
        if (Empcd == "")
        {
            lblEmployee.Text = "All";
        }
        else
        {
            lblEmployee.Text = Empcd;
        }


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
        if (indCode1 == "All")
        {
            indCode1 = "";
        }

        conn.Open();

        string sql_yearly = "select prospectid+':'+companyname as prospectcode1,* from abc where industryCode like '" + indCode1 + "%' and AcctCategory like '" + Status + "%' and companyName like '" + Comapny + "%' and empcode like '" + Empcd + "%' and TotalYearValue is not null"; //"select ProspectId,ProspectStatus,(select empnm from webx_empmst e where e.empcd = s.EntryBy) as empname, * from WEBX_SalesTarget s";
        SqlCommand sqlcmd_yearly = new SqlCommand(sql_yearly, conn);

        SqlDataAdapter da2 = new SqlDataAdapter(sqlcmd_yearly);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2, "table1");

        DataRow dr;
        sqlcmd_yearly = new SqlCommand("select prospectid+':'+companyname as prospectcode1,AcctCategory,Year_total=(isnull(january,0)+isnull(february,0)+isnull(march,0))+ (isnull(April,0)+isnull(may,0)+isnull(june,0)) + (isnull(july,0)+isnull(august,0)+isnull(september,0))+(isnull(october,0)+isnull(november,0)+isnull(december,0)),total=(isnull(january,0)+isnull(february,0)+isnull(march,0))+ (isnull(April,0)+isnull(may,0)+isnull(june,0)) + (isnull(july,0)+isnull(august,0)+isnull(september,0))+(isnull(october,0)+isnull(november,0)+isnull(december,0)) from abc  where ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and industryCode like '" + indCode1 + "%' and empcode like '" + Empcd + "%' and TotalMonthValue is not null", conn);
        SqlDataReader dreader;
        dreader = sqlcmd_yearly.ExecuteReader();
        while (dreader.Read())
        {
            dr = ds2.Tables["table1"].NewRow();
            dr["prospectcode1"] = Convert.ToString(dreader["prospectcode1"]);
            dr["ProspectStatus"] = Convert.ToString(dreader["AcctCategory"]);
            dr["Year_no"] = Convert.ToInt32(dreader["total"]);
            dr["TotalYearValue"] = Convert.ToInt32(dreader["total"]);
            ds2.Tables["table1"].Rows.Add(dr);

        }
        dreader.Close();


        DataRow dr1;
        sqlcmd_yearly = new SqlCommand("select prospectid+':'+companyname as prospectcode1,AcctCategory,Year_total=(isnull(Quater1,0)+isnull(Quater2,0)+isnull(Quater3,0))+ (isnull(Quater4,0)),total=(isnull(Quater1,0)+isnull(Quater2,0)+isnull(Quater3,0))+ (isnull(Quater4,0)) from abc  where ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and industryCode like '" + indCode1 + "%' and empcode like '" + Empcd + "%' and TotalQuaterValue is not null", conn);
        SqlDataReader dreader1;
        dreader1 = sqlcmd_yearly.ExecuteReader();
        while (dreader1.Read())
        {
            dr1 = ds2.Tables["table1"].NewRow();
            dr1["prospectcode1"] = Convert.ToString(dreader1["prospectcode1"]);
            dr1["ProspectStatus"] = Convert.ToString(dreader1["AcctCategory"]);
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
        if (indCode1 == "All")
        {
            indCode1 = "";
        }

        conn.Open();
        //string sql_quartely = "select * from abc where industryCode like '" + indCode1 + "%' and ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and empcode='" + Empcd + "' and TotalQuaterValue is not null"; //"select ProspectId,ProspectStatus,(select empnm from webx_empmst e where e.empcd = s.EntryBy) as empname, * from WEBX_SalesTarget s";
        string sql_quartely = "select prospectid+':'+companyname as prospectcode1,* from abc where industryCode like '" + indCode1 + "%' and ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and empcode like '" + Empcd + "%' and TotalQuaterValue is not null"; 
        SqlCommand sqlcmd_quartely = new SqlCommand(sql_quartely, conn);

        SqlDataAdapter da1 = new SqlDataAdapter(sqlcmd_quartely);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1,"table1");

        DataRow dr;
        sqlcmd_quartely = new SqlCommand("select prospectid+':'+companyname as prospectcode1,AcctCategory,qt4=(isnull(january,0)+isnull(february,0)+isnull(march,0)), qt1=(isnull(April,0)+isnull(may,0)+isnull(june,0)), qt2=(isnull(july,0)+isnull(august,0)+isnull(september,0)), qt3=(isnull(october,0)+isnull(november,0)+isnull(december,0)),total=(isnull(january,0)+isnull(february,0)+isnull(march,0))+ (isnull(April,0)+isnull(may,0)+isnull(june,0)) + (isnull(july,0)+isnull(august,0)+isnull(september,0))+(isnull(october,0)+isnull(november,0)+isnull(december,0)) from abc  where ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and industryCode like '" + indCode1 + "%' and empcode like '" + Empcd + "%' and TotalMonthValue is not null", conn);
        SqlDataReader dreader;
        dreader = sqlcmd_quartely.ExecuteReader();
        while (dreader.Read())
        {
            dr = ds1.Tables["table1"].NewRow();
            dr["prospectcode1"] = Convert.ToString(dreader["prospectcode1"]);
            dr["ProspectStatus"] = Convert.ToString(dreader["AcctCategory"]);
            dr["Quater1"] = Convert.ToInt32(dreader["qt1"]);
            dr["Quater2"] = Convert.ToInt32(dreader["qt2"]);
            dr["Quater3"] = Convert.ToInt32(dreader["qt3"]);
            dr["Quater4"] = Convert.ToInt32(dreader["qt4"]);
            dr["TotalQuaterValue"] = Convert.ToInt32(dreader["total"]); 
            ds1.Tables["table1"].Rows.Add(dr);   
 
        }
        dreader.Close();  
        //DataView dv1 = ds1.Tables[0].DefaultView;

        GridQuartely.DataSource = ds1.Tables["table1"] ;
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
        if (indCode1 == "All")
        {
            indCode1 = "";
        }
        conn.Open();
        //string sql_monthly = "select ProspectId,ProspectStatus,(select empnm from webx_empmst e where e.empcd = s.EntryBy) as empname, * from WEBX_SalesTarget s";
        string sql_monthly = "select * from abc where industryCode like '" + indCode1 + "%' and ProspectStatus like '" + Status + "%' and companyName like '" + Comapny + "%' and empcode like '" + Empcd + "%' and TotalMonthValue is not null";
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

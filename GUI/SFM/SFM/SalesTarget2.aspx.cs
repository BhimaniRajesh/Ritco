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

public partial class SFM_SalesTarget2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string Industry, year, acccategory, period, fdate, tdate, fromdt, todt, entryby, employee;
    public string ProspectId, daterange, mProspectCode, mStatus, TagetId, mProspectCode1, mStatus1, TagetId1,mProspectCode2,mStatus2,TagetId2;
    public int totrows = 0;
    public int totrowsQ = 0;
    public int totrowsY = 0;
    public int totAprilVal, totMayVal, totJuneVal, totJulyVal, totAugVal, totSeptVal, totOctVal, totNovVal, totDecVal, totJanVal, totFebVal, totMarchVal;
    public int mAprilVal, mMayVal, mJuneVal, mJulyVal, mAugVal, mSeptVal, mOctVal, mNovVal, mDecVal, mJanVal, mFebVal, mMarchVal, mtotalVal, mQuater1Val, mQuater2Val, mQuater3Val, mQuater4Val, mtotalVal1, mYear2, mtotalVal2;
    public static Array str, str1, str2, mPro1, mPro2, QPro1, QPro2, yPro1, yPro2, onebyeoneProspect;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            entryby = Session["empcd"].ToString();
            employee = Request.QueryString["employee"].ToString();
            ProspectId = Request.QueryString["ProspectId"].ToString();
            Industry = Request.QueryString["Industry"].ToString();
            year = Request.QueryString["year"].ToString();
            //acccategory = Request.QueryString["acccategory"].ToString();
            period = Request.QueryString["period"].ToString();

            lblIndustry.Text = Industry;
            if (Industry == "All")
            {
                Industry = "";
                lblIndustry.Text = "All";
            }
            
            lblPeriod.Text = period;
            lblYear.Text = year;

            if (ProspectId=="All")
            {
            lblProspectId.Text = "All";
            }
            else
            {
            lblProspectId.Text = ProspectId;
            }

            if (ProspectId == "All")
            {
                ProspectId = "%";
            }
            if (ProspectId == "")
            {
                ProspectId = "%";
            }


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


            if (period == "Monthly")
            {
                BindGrid();
            }
            else if (period == "Quarterly")
            {
                BindGridQuaterly();
            }
            else if (period == "Yearly")
            {
                BindGridYearly();
            }

        }

    }

    private void BindGrid()
    {
        MonthlyData.Visible = true;
        btnSubmit.Visible = true;
        //ProspectId

        onebyeoneProspect = ProspectId.Split(',');

        conn.Open();
        DataTable dt = new DataTable();
        DataColumn dc0 = new DataColumn("ProspectCode",typeof (string));
        DataColumn dc1 = new DataColumn("companyName", typeof(string));
        DataColumn dc2 = new DataColumn("AcctCategory", typeof(string));
        DataRow dr;
        dt.Columns.Add(dc0);
        dt.Columns.Add(dc1);
        dt.Columns.Add(dc2);
        for (int i = 0; i < onebyeoneProspect.Length; i++)
        {
            string a = ((string[])(onebyeoneProspect))[i];
            string sql = "select p.ProspectCode,p.companyName,(select top 1 AcctCategory from webx_CallEntry where ProspectCode=p.ProspectCode) as AcctCategory from webx_ProspectCustomer p where p.ProspectCode like '" + a + "' and industryCode like '" + Industry + "%' and convert(varchar,p.registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and p.flag is null and p.entryby='" + employee + "'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dreader;
            dreader = sqlcmd.ExecuteReader();
            while (dreader.Read())
            {
                dr = dt.NewRow();
                dr["ProspectCode"] = Convert.ToString(dreader["ProspectCode"]);
                dr["companyName"] = Convert.ToString(dreader["companyName"]);
                dr["AcctCategory"] = Convert.ToString(dreader["AcctCategory"]);
                dt.Rows.Add(dr);  
            }
            dreader.Close();  
        }

        MonthlyData.DataSource = dt;
        MonthlyData.DataBind();
        //MonthlyData.FooterRow.CssClass = "blackfnt";

        conn.Close();
    }

    private void BindGridQuaterly()
    {
        QuaterlyData.Visible = true;
        btnQuartly.Visible = true;

        onebyeoneProspect = ProspectId.Split(',');

        conn.Open();
        DataTable dt = new DataTable();
        DataColumn dc0 = new DataColumn("ProspectCode", typeof(string));
        DataColumn dc1 = new DataColumn("companyName", typeof(string));
        DataColumn dc2 = new DataColumn("AcctCategory", typeof(string));
        DataRow dr;
        dt.Columns.Add(dc0);
        dt.Columns.Add(dc1);
        dt.Columns.Add(dc2);
        for (int i = 0; i < onebyeoneProspect.Length; i++)
        {
            string a = ((string[])(onebyeoneProspect))[i];
            string sql = "select p.ProspectCode,p.companyName,(select top 1 AcctCategory from webx_CallEntry where ProspectCode=p.ProspectCode) as AcctCategory from webx_ProspectCustomer p where p.ProspectCode like '" + a + "' and p.industryCode like '" + Industry + "%' and convert(varchar,p.registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and p.flag is null and p.entryby='" + employee + "'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dreader;
            dreader = sqlcmd.ExecuteReader();
            while (dreader.Read())
            {
                dr = dt.NewRow();
                dr["ProspectCode"] = Convert.ToString(dreader["ProspectCode"]);
                dr["companyName"] = Convert.ToString(dreader["companyName"]);
                dr["AcctCategory"] = Convert.ToString(dreader["AcctCategory"]);
                dt.Rows.Add(dr);
            }
            dreader.Close();
        }

        QuaterlyData.DataSource = dt;
        QuaterlyData.DataBind();
        
        conn.Close();
    }

    private void BindGridYearly()
    {
        YearlyData.Visible = true;
        btnYearly.Visible = true;

        onebyeoneProspect = ProspectId.Split(',');

        conn.Open();
        DataTable dt = new DataTable();
        DataColumn dc0 = new DataColumn("ProspectCode", typeof(string));
        DataColumn dc1 = new DataColumn("companyName", typeof(string));
        DataColumn dc2 = new DataColumn("AcctCategory", typeof(string));
        DataRow dr;
        dt.Columns.Add(dc0);
        dt.Columns.Add(dc1);
        dt.Columns.Add(dc2);
        for (int i = 0; i < onebyeoneProspect.Length; i++)
        {
            string a = ((string[])(onebyeoneProspect))[i];
            string sql = "select p.ProspectCode,p.companyName,(select top 1 AcctCategory from webx_CallEntry where ProspectCode=p.ProspectCode) as AcctCategory from webx_ProspectCustomer p where p.ProspectCode like '" + a + "' and p.industryCode like '" + Industry + "%' and convert(varchar,p.registerDt,106) between convert(varchar,'" + fromdt + "',106) and  convert(varchar,'" + todt + "',106) and p.flag is null and p.entryby='" + employee + "'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dreader;
            dreader = sqlcmd.ExecuteReader();
            while (dreader.Read())
            {
                dr = dt.NewRow();
                dr["ProspectCode"] = Convert.ToString(dreader["ProspectCode"]);
                dr["companyName"] = Convert.ToString(dreader["companyName"]);
                dr["AcctCategory"] = Convert.ToString(dreader["AcctCategory"]);
                dt.Rows.Add(dr);
            }
            dreader.Close();
        }

        YearlyData.DataSource = dt;
        YearlyData.DataBind();

        conn.Close();
    }

    
    protected void MonthlyData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        MonthlyData.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string final = "";
            foreach (GridViewRow gridrow in MonthlyData.Rows)
            {

                Label ProspectId = (Label)gridrow.FindControl("lblProspectId");
                Label status = (Label)gridrow.FindControl("lblStatus");
                TextBox AprilVal = (TextBox)gridrow.FindControl("txtAprilVal");
                TextBox MayVal = (TextBox)gridrow.FindControl("txtMayVal");
                TextBox JuneVal = (TextBox)gridrow.FindControl("txtJuneVal");
                TextBox JulyVal = (TextBox)gridrow.FindControl("txtJulyVal");
                TextBox AugVal = (TextBox)gridrow.FindControl("txtAugVal");
                TextBox SeptVal = (TextBox)gridrow.FindControl("txtSeptVal");
                TextBox OctVal = (TextBox)gridrow.FindControl("txtOctVal");
                TextBox NovVal = (TextBox)gridrow.FindControl("txtNovVal");
                TextBox DecVal = (TextBox)gridrow.FindControl("txtDecVal");
                TextBox JanVal = (TextBox)gridrow.FindControl("txtJanVal");
                TextBox FebVal = (TextBox)gridrow.FindControl("txtFebVal");
                TextBox MarchVal = (TextBox)gridrow.FindControl("txtMarchVal");
                TextBox totalVal = (TextBox)gridrow.FindControl("txttotalVal");

                mProspectCode = ProspectId.Text;

                mPro2 = mProspectCode.Split(':');
                string OnlyProspectCode = ((string[])(mPro2))[0];
                string OnlyCompany = ((string[])(mPro2))[1];
                
                mStatus = status.Text;
                mAprilVal = Convert.ToInt32(AprilVal.Text);
                mMayVal = Convert.ToInt32(MayVal.Text);
                mJuneVal = Convert.ToInt32(JuneVal.Text);
                mJulyVal = Convert.ToInt32(JulyVal.Text);
                mAugVal = Convert.ToInt32(AugVal.Text);
                mSeptVal = Convert.ToInt32(SeptVal.Text);
                mOctVal = Convert.ToInt32(OctVal.Text);
                mNovVal = Convert.ToInt32(NovVal.Text);
                mDecVal = Convert.ToInt32(DecVal.Text);
                mJanVal = Convert.ToInt32(JanVal.Text);
                mFebVal = Convert.ToInt32(FebVal.Text);
                mMarchVal = Convert.ToInt32(MarchVal.Text);
                mtotalVal = Convert.ToInt32(totalVal.Text);

                
                if (mtotalVal != 0)
                {

                    string mNewCode;
                    string sql1 = "select max(SaleTagetId) from WEBX_SalesTarget ";
                    SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
                    string i;
                    if (conn.State == ConnectionState.Open)
                    { }
                    else
                    {
                        conn.Open();
                    }
                    i = Command.ExecuteScalar().ToString();

                    if (i == "")
                    {
                        i = "ST00000";
                    }
                    int j = Convert.ToInt16(i.Substring(2, 5));
                    int k = j + 1;
                    string m = k.ToString();

                    if (m.Length == 1)
                    {
                        m = "0000" + m;
                    }
                    else if (m.Length == 2)
                    {
                        m = "000" + m;
                    }
                    else if (m.Length == 3)
                    {
                        m = "00" + m;
                    }
                    else if (m.Length == 4)
                    {
                        m = "0" + m;
                    }
                    else if (m.Length == 5)
                    {
                        m = m;
                    }


                    mNewCode = "ST" + m.ToString();
                    TagetId = mNewCode;


                    string sql = "Insert Into WEBX_SalesTarget (SaleTagetId,ProspectId,ProspectStatus,EntryBy,SaleTargetDt,April,May,June,July,August,September,October,November,December,January,February,March,TotalMonthValue) Values ('" + TagetId + "','" + OnlyProspectCode + "','" + mStatus + "','" + employee + "',getDate()," + mAprilVal + "," + mMayVal + "," + mJuneVal + "," + mJulyVal + "," + mAugVal + "," + mSeptVal + "," + mOctVal + "," + mNovVal + "," + mDecVal + "," + mJanVal + "," + mFebVal + "," + mMarchVal + "," + mtotalVal + ")";
                    SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
                    sqlcmd2.ExecuteNonQuery();

                    string sqlUpdate = "Update webx_ProspectCustomer set flag='Y' where ProspectCode='" + OnlyProspectCode + "'";
                    SqlCommand sqlcmd3 = new SqlCommand(sqlUpdate, conn);
                    sqlcmd3.ExecuteNonQuery();

                    final = "?ProspectId=" + OnlyProspectCode;

                    final += "," + "&SaleTargetCode=" + TagetId;

                    
                }

            }
            Response.Redirect("SaleTargetDone.aspx" + final);
          conn.Close();
    }
    protected void btnQuartly_Click(object sender, EventArgs e)
    {
        string final = "";
        
        foreach (GridViewRow gridrow in QuaterlyData.Rows)
        {
            Label ProspectId1 = (Label)gridrow.FindControl("lblProspectId1");
            Label status1 = (Label)gridrow.FindControl("lblStatus1");
            TextBox Quater1 = (TextBox)gridrow.FindControl("txtQuater1");
            TextBox Quater2 = (TextBox)gridrow.FindControl("txtQuater2");
            TextBox Quater3 = (TextBox)gridrow.FindControl("txtQuater3");
            TextBox Quater4 = (TextBox)gridrow.FindControl("txtQuater4");

            TextBox totalVal1 = (TextBox)gridrow.FindControl("txttotalVal1");

            mProspectCode1 = ProspectId1.Text;

            QPro2 = mProspectCode1.Split(':');
            string OnlyProspectCode1 = ((string[])(QPro2))[0];
            string OnlyCompany1 = ((string[])(QPro2))[1];

            mStatus1 = status1.Text;
            mQuater1Val = Convert.ToInt32(Quater1.Text);
            mQuater2Val = Convert.ToInt32(Quater2.Text);
            mQuater3Val = Convert.ToInt32(Quater3.Text);
            mQuater4Val = Convert.ToInt32(Quater4.Text);

            mtotalVal1 = Convert.ToInt32(totalVal1.Text);

            

            if (mtotalVal1 != 0)
            {

                string mNewCode;
                string sql1 = "select max(SaleTagetId) from WEBX_SalesTarget ";
                SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
                string i;

                if (conn.State == ConnectionState.Open)
                { }
                else
                {
                    conn.Open();
                }

                i = Command.ExecuteScalar().ToString();

                if (i == "")
                {
                    i = "ST00000";
                }
                int j = Convert.ToInt16(i.Substring(2, 5));
                int k = j + 1;
                string m = k.ToString();

                if (m.Length == 1)
                {
                    m = "0000" + m;
                }
                else if (m.Length == 2)
                {
                    m = "000" + m;
                }
                else if (m.Length == 3)
                {
                    m = "00" + m;
                }
                else if (m.Length == 4)
                {
                    m = "0" + m;
                }
                else if (m.Length == 5)
                {
                    m = m;
                }


                mNewCode = "ST" + m.ToString();
                TagetId1 = mNewCode;


                string sql = "Insert Into WEBX_SalesTarget (SaleTagetId,ProspectId,ProspectStatus,EntryBy,SaleTargetDt,Quater1,Quater2,Quater3,Quater4,TotalQuaterValue) Values ('" + TagetId1 + "','" + OnlyProspectCode1 + "','" + mStatus1 + "','" + employee + "',getDate()," + mQuater1Val + "," + mQuater2Val + "," + mQuater3Val + "," + mQuater4Val + "," + mtotalVal1 + ")";
                SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
                sqlcmd2.ExecuteNonQuery();

                string sqlUpdate = "Update webx_ProspectCustomer set flag='Y' where ProspectCode='" + OnlyProspectCode1 + "'";
                SqlCommand sqlcmd3 = new SqlCommand(sqlUpdate, conn);
                sqlcmd3.ExecuteNonQuery();

                 
                final += TagetId1 + ",";

               
            }
            

           
        }
             conn.Close();
             Response.Redirect("SaleTargetDone.aspx?SaleTargetCode=" + final);
    }
    protected void btnYearly_Click(object sender, EventArgs e)
    {
        string final = "";
        foreach (GridViewRow gridrow in YearlyData.Rows)
        {

            Label ProspectId2 = (Label)gridrow.FindControl("lblProspectId2");
            Label status2 = (Label)gridrow.FindControl("lblStatus2");
            TextBox Year2 = (TextBox)gridrow.FindControl("txtYear");

            TextBox totalVal2 = (TextBox)gridrow.FindControl("txttotalVal2");

            mProspectCode2 = ProspectId2.Text;

            yPro2 = mProspectCode2.Split(':');
            string OnlyProspectCode2 = ((string[])(yPro2))[0];
            string OnlyCompany2 = ((string[])(yPro2))[1];

            mStatus2 = status2.Text;
            mYear2 = Convert.ToInt32(Year2.Text);

            mtotalVal2 = Convert.ToInt32(totalVal2.Text);

            

            if (mtotalVal2 != 0)
            {

                string mNewCode;
                string sql1 = "select max(SaleTagetId) from WEBX_SalesTarget ";
                SqlCommand Command = new System.Data.SqlClient.SqlCommand(sql1, conn);
                string i;

                if (conn.State == ConnectionState.Open)
                { }
                else
                {
                    conn.Open();
                }

                i = Command.ExecuteScalar().ToString();

                if (i == "")
                {
                    i = "ST00000";
                }
                int j = Convert.ToInt16(i.Substring(2, 5));
                int k = j + 1;
                string m = k.ToString();

                if (m.Length == 1)
                {
                    m = "0000" + m;
                }
                else if (m.Length == 2)
                {
                    m = "000" + m;
                }
                else if (m.Length == 3)
                {
                    m = "00" + m;
                }
                else if (m.Length == 4)
                {
                    m = "0" + m;
                }
                else if (m.Length == 5)
                {
                    m = m;
                }


                mNewCode = "ST" + m.ToString();
                TagetId2 = mNewCode;


                string sql = "Insert Into WEBX_SalesTarget (SaleTagetId,ProspectId,ProspectStatus,EntryBy,SaleTargetDt,Year_no,TotalYearValue) Values ('" + TagetId2 + "','" + OnlyProspectCode2 + "','" + mStatus2 + "','" + employee + "',getDate()," + mYear2 + "," + mtotalVal2 + ")";
                SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
                sqlcmd2.ExecuteNonQuery();

                string sqlUpdate = "Update webx_ProspectCustomer set flag='Y' where ProspectCode='" + OnlyProspectCode2 + "'";
                SqlCommand sqlcmd3 = new SqlCommand(sqlUpdate, conn);
                sqlcmd3.ExecuteNonQuery();

                final = "?ProspectId=" + OnlyProspectCode2;
                final += "," + "&SaleTargetCode=" + TagetId2;

                

            }
            

            
            
        }
        conn.Close();
        Response.Redirect("SaleTargetDone.aspx" + final);
    }
    protected void MonthlyData_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        int no = e.Row.RowIndex + 2;
        String a, b, c, d,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,E;
        if (no < 10)
        {
            
            a = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtAprilVal'";
            b = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtMayVal'";
            d = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtJuneVal'";
            f = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtJulyVal'";
            g = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtAugVal'";
            h = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtSeptVal'";
            i = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtOctVal'";
            j = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtNovVal'";
            k = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtDecVal'";
            l = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtJanVal'";
            m = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtFebVal'";
            n = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txtMarchVal'";
            c = "'ctl00_MyCPH1_MonthlyData_ctl0" + Convert.ToString(no) + "_txttotalVal'";
           
        }
        else
        {
            a = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtAprilVal'";
            b = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtMayVal'";
            d = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtJuneVal'";
            f = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtJulyVal'";
            g = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtAugVal'";
            h = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtSeptVal'";
            i = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtOctVal'";
            j = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtNovVal'";
            k = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtDecVal'";
            l = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtJanVal'";
            m = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtFebVal'";
            n = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txtMarchVal'";
            c = "'ctl00_MyCPH1_MonthlyData_ctl" + Convert.ToString(no) + "_txttotalVal'";
            
        }
        

        ((TextBox)(e.Row.FindControl("txtAprilVal"))).Attributes.Add("onblur", "return AddNo('_txtAprilVal','_FooApriltot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtMayVal"))).Attributes.Add("onblur", "return AddNo('_txtMayVal','_FooMaytot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtJuneVal"))).Attributes.Add("onblur", "return AddNo('_txtJuneVal','_FooJunetot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtJulyVal"))).Attributes.Add("onblur", "return AddNo('_txtJulyVal','_FooJulytot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtAugVal"))).Attributes.Add("onblur", "return AddNo('_txtAugVal','_FooAugtot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtSeptVal"))).Attributes.Add("onblur", "return AddNo('_txtSeptVal','_FooSepttot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtOctVal"))).Attributes.Add("onblur", "return AddNo('_txtOctVal','_FooOcttot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtNovVal"))).Attributes.Add("onblur", "return AddNo('_txtNovVal','_FooNovtot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtDecVal"))).Attributes.Add("onblur", "return AddNo('_txtDecVal','_FooDectot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtJanVal"))).Attributes.Add("onblur", "return AddNo('_txtJanVal','_FooJantot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtFebVal"))).Attributes.Add("onblur", "return AddNo('_txtFebVal','_FooFebtot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
        ((TextBox)(e.Row.FindControl("txtMarchVal"))).Attributes.Add("onblur", "return AddNo('_txtMarchVal','_FooMarchtot'),AddRowNo(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");


        }
        
    }
    protected void QuaterlyData_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            int no = e.Row.RowIndex + 2;
            String a, b, c, d,f,E;
            if (no < 10)
            {

                a = "'ctl00_MyCPH1_QuaterlyData_ctl0" + Convert.ToString(no) + "_txtQuater1'";
                b = "'ctl00_MyCPH1_QuaterlyData_ctl0" + Convert.ToString(no) + "_txtQuater2'";
                d = "'ctl00_MyCPH1_QuaterlyData_ctl0" + Convert.ToString(no) + "_txtQuater3'";
                f = "'ctl00_MyCPH1_QuaterlyData_ctl0" + Convert.ToString(no) + "_txtQuater4'";

                c = "'ctl00_MyCPH1_QuaterlyData_ctl0" + Convert.ToString(no) + "_txttotalVal1'";

            }
            else
            {
                a = "'ctl00_MyCPH1_QuaterlyData_ctl" + Convert.ToString(no) + "_txtQuater1'";
                b = "'ctl00_MyCPH1_QuaterlyData_ctl" + Convert.ToString(no) + "_txtQuater2'";
                d = "'ctl00_MyCPH1_QuaterlyData_ctl" + Convert.ToString(no) + "_txtQuater3'";
                f = "'ctl00_MyCPH1_QuaterlyData_ctl" + Convert.ToString(no) + "_txtQuater4'";

                c = "'ctl00_MyCPH1_QuaterlyData_ctl" + Convert.ToString(no) + "_txttotalVal1'";

            }


            ((TextBox)(e.Row.FindControl("txtQuater1"))).Attributes.Add("onblur", "return AddNoQ('_txtQuater1','_FooQuarter1'),AddRowNoQ(" + a + "," + b + "," + d + "," + f + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
            ((TextBox)(e.Row.FindControl("txtQuater2"))).Attributes.Add("onblur", "return AddNoQ('_txtQuater2','_FooQuarter2'),AddRowNoQ(" + a + "," + b + "," + d + "," + f + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");//(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");//(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + c + ")"); //," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
            ((TextBox)(e.Row.FindControl("txtQuater3"))).Attributes.Add("onblur", "return AddNoQ('_txtQuater3','_FooQuarter3'),AddRowNoQ(" + a + "," + b + "," + d + "," + f + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");(" + a + "," + b + "," + d + "," + f + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");//(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
            ((TextBox)(e.Row.FindControl("txtQuater4"))).Attributes.Add("onblur", "return AddNoQ('_txtQuater4','_FooQuarter4'),AddRowNoQ(" + a + "," + b + "," + d + "," + f + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");//(" + a + "," + b + "," + d + "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + c + ")"); //+ "," + f + "," + g + "," + h + "," + i + "," + j + "," + k + "," + l + "," + m + "," + n + "," + c + ")");
            

        }
    }
    protected void YearlyData_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            int no = e.Row.RowIndex + 2;
            String a,c,E;
            if (no < 10)
            {

                a = "'ctl00_MyCPH1_YearlyData_ctl0" + Convert.ToString(no) + "_txtYear'";

                c = "'ctl00_MyCPH1_YearlyData_ctl0" + Convert.ToString(no) + "_txttotalVal2'";

            }
            else
            {
                a = "'ctl00_MyCPH1_YearlyData_ctl" + Convert.ToString(no) + "_txtYear'";

                c = "'ctl00_MyCPH1_YearlyData_ctl" + Convert.ToString(no) + "_txttotalVal2'";

            }


            ((TextBox)(e.Row.FindControl("txtYear"))).Attributes.Add("onblur", "return AddNoY('_txtYear','_FooYeartot'),AddRowNoY(" + a + "," + c + ")"); 
            

        }
    }
}

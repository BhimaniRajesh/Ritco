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

public partial class REPORT_SalesSummary_SalesPerson2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string fromdt, todt, stremployee, strtxtempcd, strRegion, strLocation, sql_All;
    public string strActualFromDate, strActualToDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        fromdt = Request.QueryString["strFromDt"].ToString();
        todt = Request.QueryString["strToDt"].ToString();
        stremployee = Request.QueryString["entryby"].ToString();
        strRegion = Request.QueryString["strRegion"].ToString();
        strLocation = Request.QueryString["strLocation"].ToString();
        strtxtempcd = Request.QueryString["strtxtempcd"].ToString();

        if (fromdt == "" && todt == "")
        {
            lblDate.Text = "All";
        }
        else
        {
            lblDate.Text = fromdt + " TO " + todt;
        }
        if (strRegion == "")
        {
            lblRegion.Text = "All";
        }
        else
        {
            lblRegion.Text = strRegion;
        }
        if (strLocation == "--All--")
        {
            lblLocation.Text = "All";
            strLocation = "";
        }
        else
        {
            lblLocation.Text = strLocation;
        }

        BindGrid();
    }
    public void BindGrid()
    {   //SELECT d.entryby,d.BranchCode,sum(case when (CallType = 'VISIT') then 1 else 0 end)  as VISIT, sum(case when (CallType = 'PHONE') then 1 else 0 end)  as PHONE, sum(case when (CallType = 'SMS') then 1 else 0 end)  as SMS, sum(case when (CallType = 'CHAT') then 1 else 0 end)  as CHAT, sum(case when (CallType = 'E-MAIL') then 1 else 0 end)  as EMAIL, COUNT(CallType) AS ALLTYPE from Vw_CallSummary_person_new d group by d.entryby,d.BranchCode

        if (strRegion == "All" && strLocation == "--All--" && stremployee == "")
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
                sql_All = "SELECT d.entryby,d.BranchCode,sum(case when (CallType = 'VISIT') then 1 else 0 end)  as VISIT, sum(case when (CallType = 'PHONE') then 1 else 0 end)  as PHONE, sum(case when (CallType = 'SMS') then 1 else 0 end)  as SMS, sum(case when (CallType = 'CHAT') then 1 else 0 end)  as CHAT, sum(case when (CallType = 'E-MAIL') then 1 else 0 end)  as EMAIL, COUNT(CallType) AS ALLTYPE from Vw_CallSummary_person_new d group by d.entryby,d.BranchCode";
            }
            SqlCommand sqlcmd_All = new SqlCommand(sql_All, conn);

            SqlDataAdapter da1 = new SqlDataAdapter(sqlcmd_All);

            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd MMM yyyy");

            DateTime dtFrom1 = new DateTime();
            DateTime dtTo1 = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi1 = new System.Globalization.DateTimeFormatInfo();
            dtfi1.ShortDatePattern = "dd MMM yyyy";
            dtfi1.DateSeparator = "/";

            {
                if (fromdt != "")
                {
                    dtFrom1 = Convert.ToDateTime(fromdt, dtfi1);
                    dtTo1 = Convert.ToDateTime(todt, dtfi1);
                }
                else
                {
                    System.DateTime nowdate1 = System.DateTime.Today;
                    string todate1 = nowdate1.ToString("dd MMM yyyy");
                    dtFrom1 = Convert.ToDateTime("01 Jan 1950");
                    dtTo1 = Convert.ToDateTime(todate1);
                }
            }
            strActualFromDate = dtFrom1.ToString("dd MMM yyyy");
            strActualToDate = dtTo1.ToString("dd MMM yyyy");

            DataSet ds1 = new DataSet();
            da1.Fill(ds1);

            DataView dv1 = ds1.Tables[0].DefaultView;

            dgCallsummaryPerson.DataSource = dv1;
            dgCallsummaryPerson.DataBind();

            conn.Close();

        }
        else
        {
            string branch = Session["brcd"].ToString();
            conn.Open();
            string sql = "webx_call_summery_person_mukesh";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd MMM yyyy");

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd MMM yyyy";
            dtfi.DateSeparator = "/";

            {
                if (fromdt != "")
                {
                    dtFrom = Convert.ToDateTime(fromdt, dtfi);
                    dtTo = Convert.ToDateTime(todt, dtfi);
                }
                else
                {
                    System.DateTime nowdate = System.DateTime.Today;
                    string todate = nowdate.ToString("dd MMM yyyy");
                    dtFrom = Convert.ToDateTime("01 Jan 1950");
                    dtTo = Convert.ToDateTime(todate);
                }
            }
            strActualFromDate = dtFrom.ToString("dd MMM yyyy");
            strActualToDate = dtTo.ToString("dd MMM yyyy");

            string employee;

            employee = stremployee;

            if (employee == "--All--")
            {
                employee = "";
            }
            else
            {
                employee = stremployee;

            }


            if (strtxtempcd == "")
            {

                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                da.SelectCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = strLocation;

            }
            else
            {

                employee = strtxtempcd;
                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                da.SelectCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = strLocation;

            }

            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgCallsummaryPerson.DataSource = dv;
            dgCallsummaryPerson.DataBind();

            conn.Close();
        }
        

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgCallsummaryPerson.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void dgCallsummaryPerson_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l1;
            l1 = (Label)(e.Row.FindControl("lblsalesperson"));
            string code = ((Label)(e.Row.FindControl("lblsalesperson"))).Text;
            //conn.Open();
            string sql = "select UserId+':'+Name as emp from WebX_Master_Users where UserId='" + code + "'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            l1.Text = Convert.ToString(sqlcmd.ExecuteScalar());
        }
    }
}

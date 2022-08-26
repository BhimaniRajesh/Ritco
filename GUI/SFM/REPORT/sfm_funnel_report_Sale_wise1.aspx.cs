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

public partial class REPORT_sfm_funnel_report_Sale_wise1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string DtFromM, DtToM, employee, Region, location, empcd, fromdt, todt;
    public string strActualFromDate;
    public string strActualToDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DtFromM = Request.QueryString["DtFrom"].ToString();
        DtToM = Request.QueryString["DtTo"].ToString();
        employee = Request.QueryString["emp"].ToString();
        Region = Request.QueryString["Region"].ToString();
        location = Request.QueryString["location"].ToString() == "" ? "ALL" : Request.QueryString["location"].ToString();

        empcd = Request.QueryString["empcd"].ToString();

        fromdt = DtFromM;
        todt = DtToM;

        if (Region == "--All--")
        {
            lblRegion.Text = "ALL";
        }
        else
        {
            lblRegion.Text = Region;
        }

        if (location == "--All--")
        {
            lblLocation.Text = "ALL";
        }
        else
        {
            lblLocation.Text = location;
        }

        if (employee == "--All--" || employee == null && empcd == "")
        {
            lblSalesPerson.Text = "ALL";
        }
        else
        {
            lblSalesPerson.Text = employee;
        }
        lblDateRange.Text = DtFromM + "  To  " + DtToM;

        if (empcd != "" || empcd != null)
        {
            lblSalesPerson.Text = empcd;
        }
        //lblSapesPerson.Text = empcd;
        BindGrid();
    }

    public void BindGrid()
    {
        //if (Region == "All" && location == "--All--" && employee == "")
        //{
        //    conn.Open();

        //    //string branch = Session["brcd"].ToString();

        //    DateTime dtFrom = new DateTime();
        //    DateTime dtTo = new DateTime();

        //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //    dtfi.ShortDatePattern = "dd MMM yyyy";
        //    dtfi.DateSeparator = "/";

        //    {
        //        if (DtFromM != "")
        //        {
        //            dtFrom = Convert.ToDateTime(DtFromM, dtfi);
        //            dtTo = Convert.ToDateTime(DtToM, dtfi);
        //        }
        //        else
        //        {
        //            System.DateTime nowdate = System.DateTime.Today;
        //            string todate = nowdate.ToString("dd MMM yyyy");
        //            dtFrom = Convert.ToDateTime("01 Jan 1950");
        //            dtTo = Convert.ToDateTime(todate);
        //        }
        //    }
        //    strActualFromDate = dtFrom.ToString("dd MMM yyyy");
        //    strActualToDate = dtTo.ToString("dd MMM yyyy");


        //    string sql = "SELECT e.UserID,e.Name, sum(case when (AcctCategory = 'HOT') then 1 else 0 end)  as HotKount, sum(case when (AcctCategory = 'HOT') then valpmonth else 0 end)  as HotWalue, sum(case when (AcctCategory = 'WARM') then 1 else 0 end)  as WarmKount, sum(case when (AcctCategory = 'WARM') then valpmonth else 0 end)  as WarmWalue, sum(case when (AcctCategory = 'COLD') then 1 else 0 end)  as ColdKount, sum(case when (AcctCategory = 'COLD') then valpmonth else 0 end)  as ColdWalue, COUNT(AcctCategory) AS AllKount, SUM(valpmonth) AS AllWalue from WebX_Master_Users E,  (select callcode, a.prospectcode,  entryby, AcctCategory, valpmonth  from webx_CallEntry a, (select prospectcode,calldt+calltime as c_date from webx_CallEntry) as  b where a.prospectcode=b.prospectcode and b.c_date=a.calldt +a.calltime )  pros where E.UserID=pros.entryby group by UserID,Name ";
        //    SqlCommand cmd = new SqlCommand(sql, conn);
        //    SqlDataAdapter da = new SqlDataAdapter(cmd);

        //    DataSet ds = new DataSet();
        //    da.Fill(ds);

        //    DataView dv = ds.Tables[0].DefaultView;

        //    dgfunnel.DataSource = dv;
        //    dgfunnel.DataBind();

        //    conn.Close();
        //}
        //else
        //{
            conn.Open();
            string sql = "webx_funnal_person_abc";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            string branch = Session["brcd"].ToString();

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd MMM yyyy";
            dtfi.DateSeparator = "/";

            {
                if (DtFromM != "")
                {
                    dtFrom = Convert.ToDateTime(DtFromM, dtfi);
                    dtTo = Convert.ToDateTime(DtToM, dtfi);
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

            if (employee == "--All--")
            {
                employee = "";
            }
            else
            {
                employee = employee;
            }

            if (empcd == "")
            {
                if (location == "--All--")
                {
                    branch = "";
                    da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                    da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                    da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                    da.SelectCommand.Parameters.Add("@branch", SqlDbType.VarChar).Value = branch;
                }
                else
                {
                    da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                    da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                    da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                    da.SelectCommand.Parameters.Add("@branch", SqlDbType.VarChar).Value = location;
                }
                
            }
            else
            {
                employee = empcd;
                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                da.SelectCommand.Parameters.Add("@branch", SqlDbType.VarChar).Value = branch;
            }
            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgfunnel.DataSource = dv;
            dgfunnel.DataBind();

            conn.Close();


       // }



    }
    public void pgChange(object source, DataGridPageChangedEventArgs e)
    {
        dgfunnel.CurrentPageIndex = e.NewPageIndex;
        BindGrid();

    }
    protected void dgfunnel_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

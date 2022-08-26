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

public partial class REPORT_AppointmentSchedule2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string EmployeeCode, fromdt, todt, stremployee, strRegion, strLocation, strtxtempcd, daterange, emp, sql_Select;
    public Array str, str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        stremployee = Request.QueryString["entryby"].ToString();
        strRegion = Request.QueryString["strRegion"].ToString();
        strLocation = Request.QueryString["strLocation"].ToString();

        conn.Open();
        string employeename = "Select Name from WebX_Master_Users where UserId='" + stremployee + "'";
        SqlCommand cmdemp = new SqlCommand(employeename, conn);
        SqlDataReader dr;
        dr = cmdemp.ExecuteReader();

        while (dr.Read())
        {
            emp = dr["Name"].ToString();
        }
        dr.Close();
        conn.Close();

        if (stremployee == "--All--")
        {
            lblEmployee.Text = "All";
            stremployee = "";
        }
        else
        {
            lblEmployee.Text = stremployee + " : " + emp;
        }
        if (strLocation == "--All--")
        {
            lblLocation.Text = "All";
        }
        else
        {
            lblLocation.Text = strLocation;
        }
        if (strRegion == "--All--")
        {
            lblRegion.Text = "All";
        }
        else
        {
            lblRegion.Text = strRegion;
        }


        fromdt = HttpUtility.UrlDecode(Request.QueryString["strFromDt"].ToString());
        todt = HttpUtility.UrlDecode(Request.QueryString["strToDt"].ToString());

        str = fromdt.Split('/');
        str1 = todt.Split('/');

        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name

        daterange = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
        fromdt = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        todt = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        lblDate.Text = fromdt + " : " + todt;

        BindGrid();
    }
    public void BindGrid()
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
            if (stremployee == "")
            {
                sql_Select = "select ProspectCode,convert(varchar,AppointmentDt,106) as AppointmentDt,AppTime,(select ProspectCode +':'+ companyName from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as Prospect,(select AcctCategory from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as status,PersonToMet,Department,Designation,Purpose,Remarks from Webx_Appointment a where convert(varchar,a.AppointmentDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ORDER BY AppointmentDt asc";
            }
            else
            {
                sql_Select = "select ProspectCode,convert(varchar,AppointmentDt,106) as AppointmentDt,AppTime,(select ProspectCode +':'+ companyName from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as Prospect,(select AcctCategory from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as status,PersonToMet,Department,Designation,Purpose,Remarks from Webx_Appointment a where a.entryby like '" + stremployee + "%' and convert(varchar,a.AppointmentDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ORDER BY AppointmentDt asc";
            }
            
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            sql_Select = "select ProspectCode,convert(varchar,AppointmentDt,106) as AppointmentDt,AppTime,(select ProspectCode +':'+ companyName from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as Prospect,(select AcctCategory from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as status,PersonToMet,Department,Designation,Purpose,Remarks from Webx_Appointment a where a.entryby like '" + stremployee + "%' and convert(varchar,a.AppointmentDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ORDER BY AppointmentDt asc";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            sql_Select = "select ProspectCode,convert(varchar,AppointmentDt,106) as AppointmentDt,AppTime,(select ProspectCode +':'+ companyName from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as Prospect,(select AcctCategory from webx_ProspectCustomer where ProspectCode = a.ProspectCode) as status,PersonToMet,Department,Designation,Purpose,Remarks from Webx_Appointment a where a.entryby = '" + Session["empcd"].ToString() + "' and convert(varchar,a.AppointmentDt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106) ORDER BY AppointmentDt asc";
        }
        SqlCommand sqlcmd = new SqlCommand(sql_Select, conn);

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgAppointment.DataSource = dv;
        dgAppointment.DataBind();

        conn.Close();

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgAppointment.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

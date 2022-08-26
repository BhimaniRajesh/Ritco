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

public partial class GUI_SFM_SFM_AppointmentView : System.Web.UI.Page
{
    public static SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strProspectCode = Request.QueryString.Get("strProspectCode");
        string[] Split = strProspectCode.Split(new Char[] { ',' });
        strProspectCode = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);

        string sql = "select a.AppointmentCode,(select top 1 ProspectCode +':'+ CompanyName from webx_ProspectCustomer p where p.ProspectCode=a.ProspectCode) as company,convert(varchar,a.AppointmentDt,106) as AppointmentDt,a.AppTime,a.PersonToMet,a.ContactNo,a.Department,a.Designation,a.Purpose,a.Remarks from Webx_Appointment a where a.AppointmentCode='" + strProspectCode + "'";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        SqlDataReader dr = null;
        dr = sqlcmd2.ExecuteReader();
        try
        {
            if (dr.Read())
            {
                string AppointmentCode = dr["AppointmentCode"].ToString().Trim();
                string ProspectCode = dr["company"].ToString().Trim();
                string AppDT = dr["AppointmentDt"].ToString().Trim();
                string AppTime = dr["AppTime"].ToString().Trim();
                string PersonToMet = dr["PersonToMet"].ToString().Trim();
                string ContactNo = dr["ContactNo"].ToString().Trim();
                string Dept = dr["Department"].ToString().Trim();
                string Designation = dr["Designation"].ToString().Trim();
                string Purpose = dr["Purpose"].ToString().Trim();
                string Remarks = dr["Remarks"].ToString().Trim();

                lblCompany.Text = ProspectCode;
                lblDate.Text = AppDT;
                lblAppTime.Text = AppTime;
                lblPersonTomet.Text = PersonToMet;
                lblContact.Text = ContactNo;
                lblDept.Text = Dept;
                lblDesignation.Text = Designation;
                lblPurpose.Text= Purpose;
                lblRemarks.Text= Remarks;
               
            }
            else
            {

            }
        }
        finally
        {
            conn.Close();
        }
    }
}

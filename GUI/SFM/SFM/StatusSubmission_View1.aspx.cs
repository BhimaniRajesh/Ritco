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

public partial class SFM_StatusSubmission_View1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strProspectCode = Request.QueryString.Get("strProspectCode");

        string sql = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND' and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment from webx_ProspectCustomer a  where ProspectCode='" + strProspectCode + "'");
        //string sql = ("Sp_prospect_viwedetail");

        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        //sqlcmd2.CommandType = CommandType.StoredProcedure;
        //sqlcmd2.Parameters.Add("@ProspectCode", SqlDbType.VarChar).Value = strProspectCode;
        SqlDataReader dr = null;
        dr = sqlcmd2.ExecuteReader();

        try
        {
            if (dr.Read())
            {
                string ProspectCode = dr[0].ToString().Trim();
                string registerdt = dr[1].ToString().Trim();
                string companyname = dr[2].ToString().Trim();
                string industryname = dr[3].ToString().Trim();
                string compAddr = dr[4].ToString().Trim();
                string contPerson = dr[9].ToString().Trim();
                string compCity = dr[5].ToString().Trim();
                string compPin = dr[6].ToString().Trim();
                string contDesign = dr[10].ToString().Trim();
                string compPhone = dr[7].ToString().Trim();
                string compEmail = dr[8].ToString().Trim();

                lblProspect.Text = ProspectCode;
                lblDate.Text = registerdt;
                lblAddress.Text = compAddr;
                lblcity.Text = compCity + "-" + compPin;
                lblIndustry.Text = industryname;
                lblPhone.Text = compPhone;
                lblEmail.Text = compEmail;
                lblCompany.Text = companyname;
                lblContact.Text = contPerson;
                lblDesignation.Text = contDesign;
                
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

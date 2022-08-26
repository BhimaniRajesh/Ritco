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

public partial class REPORT_pros_reg_detail : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string Prospect;
    public string sql_Insert;
    public static string ClientName;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Prospect = Request.QueryString["ProspectCode"].ToString();

        string[] strProspectCode = Prospect.Split(':');
        string Prospect_Code = strProspectCode[0].ToString();

        conn.Open();
        //string sql = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND'and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment from webx_ProspectCustomer a  where ProspectCode='" + Prospect + "'");

        //ClientName = Session["Client"].ToString();
        //if (ClientName == "Varuna")
        //{
            loadpyament.Visible = true;
            routes.Visible = true;
        //}
        //else
        //{
        //    loadpyament.Visible = false;
        //    routes.Visible = false;
        //}
        //if (ClientName == "Varuna")
        //{
            sql_Insert = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND' and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment,LoadType,PaymentSystem,MainRoute from webx_ProspectCustomer a  where ProspectCode='" + Prospect_Code + "'");
        //}
        //else
        //{
        //    sql_Insert = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND' and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment from webx_ProspectCustomer a  where ProspectCode='" + Prospect_Code + "'");
        //}
        SqlCommand sqlcmd2 = new SqlCommand(sql_Insert, conn);
       
        SqlDataReader dr = null;
        dr = sqlcmd2.ExecuteReader();
        try
        {
            //if (ClientName == "Varuna")
            //{
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
                    string compwebsite = dr["compwebsite"].ToString().Trim();
                    string comments = dr["comment"].ToString().Trim();
                    string LoadType = dr["LoadType"].ToString().Trim();
                    string Payment = dr["PaymentSystem"].ToString().Trim();
                    string MainRoutes = dr["MainRoute"].ToString().Trim();

                    lblDate.Text = registerdt;
                    lblAddress.Text = compAddr;
                    lblcity.Text = compCity + "-" + compPin;
                    lblIndustry.Text = industryname;
                    lblPhone.Text = compPhone;
                    lblEmail.Text = compEmail;
                    lblCompany.Text = companyname;
                    lblContact.Text = contPerson;
                    lblDesignation.Text = contDesign;
                    lblComments.Text = comments;
                    lblWebsite.Text = compwebsite;
                    lblLoadType.Text = LoadType;
                    lblPaymentSystem.Text = Payment;
                    lblMainRoutes.Text = MainRoutes;

                }
                else
                {

                }
                dr.Close();
            //}
            //else
            //{
            //    if (dr.Read())
            //    {
            //        string ProspectCode = dr[0].ToString().Trim();
            //        string registerdt = dr[1].ToString().Trim();
            //        string companyname = dr[2].ToString().Trim();
            //        string industryname = dr[3].ToString().Trim();
            //        string compAddr = dr[4].ToString().Trim();
            //        string contPerson = dr[9].ToString().Trim();
            //        string compCity = dr[5].ToString().Trim();
            //        string compPin = dr[6].ToString().Trim();
            //        string contDesign = dr[10].ToString().Trim();
            //        string compPhone = dr[7].ToString().Trim();
            //        string compEmail = dr[8].ToString().Trim();
            //        string compwebsite = dr["compwebsite"].ToString().Trim();
            //        string comments = dr["comment"].ToString().Trim();


            //        lblDate.Text = registerdt;
            //        lblAddress.Text = compAddr;
            //        lblcity.Text = compCity + "-" + compPin;
            //        lblIndustry.Text = industryname;
            //        lblPhone.Text = compPhone;
            //        lblEmail.Text = compEmail;
            //        lblCompany.Text = companyname;
            //        lblContact.Text = contPerson;
            //        lblDesignation.Text = contDesign;
            //        lblComments.Text = comments;
            //        lblWebsite.Text = compwebsite;
                    
            //    }
            //    else
            //    {

            //    }
            //    dr.Close();
            //}

        }
        finally
        {
            conn.Close();
        }

    }
}

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

public partial class SFM_Prosp_View : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string sql_Insert;
    public static string ClientName;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strProspectCode = Request.QueryString.Get("strProspectCode");
        string[] Split = strProspectCode.Split(new Char[] { ',' });
        strProspectCode=Convert.ToString(Split[0]);
        string print_yn=Convert.ToString(Split[1]);

        //ClientName = Session["Client"].ToString();
        //if (ClientName == "1")
        //{
            loadpyament.Visible = true;
            routes.Visible = true;
        //}
        //else
        //{
        //    loadpyament.Visible = false;
        //    routes.Visible = false;
        //}
        //if (ClientName == "1")
        //{
            sql_Insert = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND' and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment,LoadType,PaymentSystem,MainRoute from webx_ProspectCustomer a  where ProspectCode='" + strProspectCode + "'");
        //}
        //else
        //{
        //    sql_Insert = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND' and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment from webx_ProspectCustomer a  where ProspectCode='" + strProspectCode + "'");
        //}
        //string sql = ("select ProspectCode,convert(varchar,RegisterDt,106),companyName,(select CodeDesc from Webx_Master_General b where CodeType='IND' and a.industryCode=b.CodeId) as industryname,compAddr,compCity,compPin,compPhone,CompEmail,contPerson,contDesign,contPhone,contEmail,entryby,EntryDt,updateby,updatedt,companyStatus,LastVisitDt,AcctCategory,loccode,tonpmonth,valpmonth,compwebsite,comment,LoadType,PaymentSystem,MainRoute from webx_ProspectCustomer a  where ProspectCode='" + strProspectCode + "'");

        SqlCommand sqlcmd2 = new SqlCommand(sql_Insert, conn);
        SqlDataReader dr = null;
        dr = sqlcmd2.ExecuteReader();
        try
        {
            //if (ClientName == "1")
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

            //        /*--------------   This code for dynamic HTML table -------------------- */

            //        //Response.Write("<table border=1 cellspacing=1  align='center' class='boxbg' style='width: 85%'><tr><td>");
            //        //Response.Write("ProspectCode :");
            //        //Response.Write("</td><td>");
            //        //Response.Write(ProspectCode);
            //        //Response.Write("</td><td>");
            //        //Response.Write("date :");
            //        //Response.Write("</td><td>");
            //        //Response.Write("");
            //        //Response.Write("</td></tr><table>");
            //        // Response.Write(companyname);
            //        //Response.End();
            //        //Session["empnm"] = dr[1].ToString().Trim();
            //        //Response.Write("<script type='text/javascript'>popup=window.open('./welcome.aspx','my_gf_start','scrollbars=yes,resizable=yes,width=400,height=500');window.close();</script>");
            //        //Response.End();
            //        //Server.Transfer("welcome.aspx");
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

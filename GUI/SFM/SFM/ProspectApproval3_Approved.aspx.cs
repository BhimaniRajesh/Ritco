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
using System.Net.Mail;

public partial class SFM_ProspectApproval3_Approved : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string prospect, sql_Insert, ManagerMail;
    public static string ClientName;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            //ClientName = Session["Client"].ToString();
            prospect = Request.QueryString["prospect"].ToString();
            //if (ClientName == "Varuna")
            //{
            //    SendMail();
            //}
            BindGrid();
        }
    }

    //private void SendMail()
    //{
    //    conn.Open();
    //    sql_Insert = "select compEmail from webx_ProspectCustomer a  where ProspectCode='" + prospect + "'";
    //    SqlCommand sqlcmd2 = new SqlCommand(sql_Insert, conn);
    //    SqlDataReader dr = null;
    //    dr = sqlcmd2.ExecuteReader();
    //    if (dr.Read())
    //    {
    //        ManagerMail = dr["compEmail"].ToString().Trim();
    //    }
    //    dr.Close();
    //    MailAddressCollection EAddress = new MailAddressCollection();

    //    MailMessage Email = new MailMessage();
    //    Email.Body = "Your Prospect : " + prospect + " has been Successfully Approved";
    //    Email.Subject = "Prospect Approved";
    //    //Email.To = new MailAddress(ManagerMail);
    //    //foreach (MailAddress EmailAddress in EAddress)
    //    //{
    //    Email.To.Add(ManagerMail);
    //    //}

    //    Email.From = new MailAddress("abc@yahoo.com");
    //    Email.IsBodyHtml = false;
    //    Email.Priority = MailPriority.High;
    //    SmtpClient Client = new SmtpClient();
    //    //Email.
    //    Client.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;
    //    Client.Host = "smtp.mail.yahoo.com";

    //    Client.Send(Email);
    //    conn.Close();
    //}
    private void BindGrid()
    {
        conn.Open();
        string sql = "select ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,convert(varchar,LastVisitDt,106) as LastVisitDt,entryby,(select a.CodeDesc from Webx_Master_General a where a.Codetype='IND' and a.CodeId=industryCode) as industryCode,compCity,contPerson,acctCategory,companyStatus,comment,statesub,CustCode from webx_ProspectCustomer where ProspectCode in ('" + prospect + "') order by CompanyName";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        ProspectApproved.DataSource = dv;
        ProspectApproved.DataBind();

        conn.Close();
    }
}

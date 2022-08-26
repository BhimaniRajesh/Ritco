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

public partial class REPORT_ProspectHistory2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string ProspectCode,ProspectCode1, flag;
    public static string prcd;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ProspectCode = Request.QueryString["ProspectCode"].ToString();
        lblProspectId.Text = ProspectCode;
        //Session["ProspectCode1"] = ProspectCode;
        conn.Open();
        string sql = "select (select Name from WebX_Master_Users where UserId=p.entryby)as empnm,convert(varchar,RegisterDt,106) as RegisterDt,convert(varchar,ApprovalDt,106) as ApprovalDt,convert(varchar,submissionDt,106) as submissionDt,* from webx_ProspectCustomer p where p.ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();

        while (dr.Read())
        { 
            lblCustomerName.Text = dr["companyName"].ToString();
            lblValperMonth.Text = dr["valpmonth"].ToString();
            lblRegDt.Text = dr["RegisterDt"].ToString();
            lblSalesPerson.Text = dr["empnm"].ToString();
            lblSubmissionDt.Text = dr["submissionDt"].ToString();
            lblApprovalDt.Text = dr["ApprovalDt"].ToString();

            string status = dr["statesub"].ToString();
            if (status == "U")
            {
                lblSubmissionStatus.Text = "Unsubmitted";
            }
            else if (status == "S")
            {
                lblSubmissionStatus.Text = "Submitted";
            }
            else if (status == "R")
            {
                lblSubmissionStatus.Text = "Rejected";
            }

            if (status == "A")
            {
                lblApprovalStatus.Text = "Approved";
            }
            else
            {
                lblApprovalStatus.Text = "Not Approved";
            }
            string customercode = dr["custcode"].ToString();
            if (customercode == "" || customercode == null)
            {
                lblCustomerCode.Text = "----";
            }
            else
            {
                lblCustomerCode.Text = customercode;
            }
        }
        dr.Close();

        string sql1 = "select count(*) as Call from webx_CallEntry where ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd1 = new SqlCommand(sql1, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd1.ExecuteReader();

        while (dr1.Read())
        {
            //lblTotalCall.Text = dr1["Call"].ToString();
            lnkCall.Text = dr1["Call"].ToString();
        }
        dr1.Close();

        string sql2 = "select top 1 convert(varchar,LastOrderDt,106) as LastOrderDt from webx_CallEntry where ProspectCode='" + ProspectCode + "'";
        SqlCommand sqlcmd2 = new SqlCommand(sql2, conn);
        SqlDataReader dr2;
        dr2 = sqlcmd2.ExecuteReader();

        while (dr2.Read())
        {
            lblLikelyDt.Text = dr2["LastOrderDt"].ToString();   
        }
        dr2.Close();
    }
    //public void callReg(object sender, EventArgs e)
    //{
    //Response.Redirect("CallRegister_SalesPersonWiseReport2.aspx");
    //}
}

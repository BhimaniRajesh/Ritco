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

public partial class GUI_Fleet_Job_JobOrderResult : System.Web.UI.Page
{

    string OrderNo = "", Flag = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        OrderNo = Request.QueryString["OrderNo"];
        Flag = Request.QueryString["Flag"];
        if (Flag.Trim() == "C")
        {
            lblHeader1.Visible = true;
            lblHeader.Visible = false;
            //  td1.Visible = false;
        }
        if (Flag.Trim() == "P")
        {
            lblHeader.Visible = true;
            lblHeader1.Visible = false;
        }
        lblDocNo.Text = OrderNo;
        if (!IsPostBack)
        {
            //JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
            //DataTable dtBranch = new DataTable();
            //dtBranch = objJs.GetDataTable("Select *,dbo.GetUserEmailId(USERID_TO,Loc_Code) + ',' + dbo.GetUserEmailId(USERID_CC,Loc_Code)  As EmailUserID From Webx_Fleet_JobOrder_Approval_Mst Where Job_Order_No ='" + lblDocNo.Text.Trim() + "' And Flag='Generate' And Loc_Code='" + Session["brcd"].ToString() + "'");
            //DataTable dtRegional = new DataTable();
            //dtRegional = objJs.GetDataTable("Select *,dbo.GetUserEmailId(USERID_TO,Loc_Code) + ',' + dbo.GetUserEmailId(USERID_CC,Loc_Code)  As EmailUserID From Webx_Fleet_JobOrder_Approval_Mst Where Job_Order_No ='" + lblDocNo.Text.Trim() + "' And Flag='Generate' And Loc_Code=(Select Report_Loc From Webx_Location Where LocCode='" + Session["brcd"].ToString() + "')");
            //DataTable dtLoginUsesDet = new DataTable();
            //dtLoginUsesDet = objJs.GetDataTable("Select * From Webx_Master_Users Where USERID='" + Session["empcd"].ToString() + "'");

            //if (dtBranch.Rows.Count > 0)
            //{
            //    double vActual_Amt = Convert.ToDouble(dtBranch.Rows[0]["Actual_Amt"].ToString()); 
            //    double vApproved_Amt = Convert.ToDouble(dtBranch.Rows[0]["Approved_Amt"].ToString());
            //    if (vActual_Amt > vApproved_Amt)
            //    {
            //        SendMail(lblDocNo.Text, dtBranch.Rows[0]["EmailUserID"].ToString(), dtLoginUsesDet.Rows[0]["EmailID"].ToString(), dtLoginUsesDet.Rows[0]["Name"].ToString(), dtLoginUsesDet.Rows[0]["PhoneNo"].ToString());
            //        SendMail(lblDocNo.Text, dtRegional.Rows[0]["EmailUserID"].ToString(), dtLoginUsesDet.Rows[0]["EmailID"].ToString(), dtLoginUsesDet.Rows[0]["Name"].ToString(), dtLoginUsesDet.Rows[0]["PhoneNo"].ToString());
            //    }
            //}
        }
    }
    public void SendMail(string strJobOrderNo, string strTO, string strFrom, string strName, string strContact)
    {
        //string strBody = "";

        //strBody = " <html> ";
        //strBody = strBody + "<body> ";
        //strBody = strBody + "<table style='font-family: Calibri; font-size: 16px; color: darkblue;'> ";
        //strBody = strBody + "<tr> ";
        //strBody = strBody + "<td> ";
        //strBody = strBody + "Dear Sir,<br /> ";
        //strBody = strBody + "</td> ";
        //strBody = strBody + "</tr> ";
        //strBody = strBody + "<tr> ";
        //strBody = strBody + "<td> ";
        //strBody = strBody + "<br /> ";
        //strBody = strBody + "Location : " + Session["brcd"].ToString();
        //strBody = strBody + "<br /> ";
        //strBody = strBody + "Job Order Number " + strJobOrderNo;
        //strBody = strBody + "<br /> ";
        //strBody = strBody + "Remarks : Job Order is pending for approval";
        //strBody = strBody + "</td> ";
        //strBody = strBody + "</tr> ";
        //strBody = strBody + "<tr> ";
        //strBody = strBody + "<td> ";
        //strBody = strBody + "<br /> ";
        //strBody = strBody + "Regards,<br /> ";
        //strBody = strBody + strName + "<br />";
        //strBody = strBody + "Mobile + 91-" + strContact + "<br /> ";
        //strBody = strBody + "Agility";
        //strBody = strBody + "</td> ";
        //strBody = strBody + "</tr> ";
        //strBody = strBody + "</table> ";
        //strBody = strBody + "</body> ";
        //strBody = strBody + "</html>";

        //string[] ToMail = strTO.Replace(",,", ",").Split(',');

        //MailMessageFleet msg = new MailMessageFleet();
        //msg.EmailFrom = strFrom;

        //if (ToMail.Length > 0)
        //{
        //    for (int i = 0; i < ToMail.Length; i++)
        //    {
        //        if (ToMail[i] != "")
        //        {
        //            msg.AddEmailTo(ToMail[i]);
        //        }
        //    }
        //}

        //msg.EmailMessageType = MessageType.HTML;
        //msg.EmailSubject = "Job Order Awaiting for Approval";
        //msg.EmailMessage = strBody;

        //Smtp smtp = new Smtp();
        //smtp.SmtpServer = "202.144.65.93";
        //smtp.SmtpUser = "TMSAutoMails@agilitylogistics.in";
        //smtp.SmtpPassword = "pass1234";
        //smtp.SendEmail(msg);
    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;

public partial class GUI_Fleet_JobOrderClosure : System.Web.UI.Page
{
    string str_Connection_String;
    JobSheet objJs;
    public static DataTable dtMail;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (Session["SqlProvider"] != null)
        {
            str_Connection_String = Convert.ToString(Session["SqlProvider"]);
            objJs = new JobSheet(str_Connection_String);
        }
        if (!IsPostBack)
        {
            AddJobCardType();
            btnSubmit.Visible = false;
            GetMailData();
        }
    }
    public void GetMailData()
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        DataTable dt = new DataTable();
        objJs.Entry_By = Session["empcd"].ToString();
        dt = objJs.GetMailData();
        if (dt.Rows.Count > 0)
        {
            hfFrom.Value = dt.Rows[0]["EmailId"].ToString();
            hfFromName.Value = dt.Rows[0]["name"].ToString();
            hfFromContact.Value = dt.Rows[0]["mobileno"].ToString();
        }
    }
    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {
        RetrieveGridData();
    }
    public void RetrieveGridData()
    {
        objJs = new JobSheet(str_Connection_String);
        objJs.JobOrderNo = txtJobOrderNo.Text.ToString().Trim();
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        objJs.JobOrderFromDt = txtDateFrom.Text;
        objJs.JobOrderToDt = txtDateTo.Text;

        objJs.JobCardType = cboJobCardType.SelectedValue.ToString().Trim();
        objJs.JS_BRCD = Convert.ToString(Session["brcd"]);
        objJs.BindGVJSCloseJobSheet(gvJobOrder);

        if (gvJobOrder.Rows.Count > 0)
        {
            btnSubmit.Visible = true;
        }
        else
        {
            btnSubmit.Visible = false;
        }
        //GetMailData();        
    }
    public void AddJobCardType()
    {
        objJs = new JobSheet(str_Connection_String);
        objJs.BindDropDown(cboJobCardType, "select CodeId,CodeDesc from webx_master_general where codetype= 'JOBCARDTYP' and StatusCode='Y' order by CodeDesc");
    }
    protected void gvJobOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowType == DataControlRowType.DataRow))
        {
            CheckBox chkApprove = (CheckBox)e.Row.FindControl("chkApprove");
            CheckBox ckhReject = (CheckBox)e.Row.FindControl("ckhReject");
            chkApprove.Attributes.Add("onClick", "javascript:ApproveCheck(" + chkApprove.ClientID.ToString() + "," + ckhReject.ClientID.ToString() + ");");
            ckhReject.Attributes.Add("onClick", "javascript:RejectCheck(" + chkApprove.ClientID.ToString() + "," + ckhReject.ClientID.ToString() + ");");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        for(int i=0;i<gvJobOrder.Rows.Count;i++)
        {
            HyperLink HyperLink1 = (HyperLink)gvJobOrder.Rows[i].FindControl("HyperLink1");
            CheckBox chkApprove = (CheckBox)gvJobOrder.Rows[i].FindControl("chkApprove");
            CheckBox ckhReject = (CheckBox)gvJobOrder.Rows[i].FindControl("ckhReject");
            TextBox tb_Remarks = (TextBox)gvJobOrder.Rows[i].FindControl("tb_Remarks");
            JobSheet objJs = new JobSheet(str_Connection_String);
            HiddenField hf_EmailID_To = (HiddenField)gvJobOrder.Rows[i].FindControl("hf_EmailID_To");
            HiddenField hf_EmailID_CC = (HiddenField)gvJobOrder.Rows[i].FindControl("hf_EmailID_CC");

            objJs.JobOrderNo = HyperLink1.Text;
            objJs.JS_BRCD = Convert.ToString(Session["brcd"]);
            objJs.JS_Approval_Remarks = tb_Remarks.Text.Trim(); 
            if (chkApprove.Checked == true)
            {
                objJs.JS_Approve = "Yes";
                objJs.JS_Approve_By = Session["empcd"].ToString().Trim();
            }
            else
            {
                objJs.JS_Approve = "";
                objJs.JS_Approve_By = "";
            }
            if (ckhReject.Checked == true)
            {
                objJs.JS_Reject = "Yes";
                objJs.JS_Reject_By = Session["empcd"].ToString().Trim();
            }
            else
            {
                objJs.JS_Reject = "";
                objJs.JS_Reject_By = "";
            }
            try
            {
                objJs.BeginTransaction();
                if (chkApprove.Checked == true)
                {
                    objJs.UpdateJobsheetApprovalClosure();
                    AwaitingApprovalMail(HyperLink1.Text, "Y");
                    //if (hf_EmailID_To.Value != "")
                    //{
                    //    ApprovalSendMail(HyperLink1.Text, hf_EmailID_To.Value + "," + hf_EmailID_CC.Value, hfFrom.Value, tb_Remarks.Text, hfFromName.Value, hfFromContact.Value);
                    //}
                }
                if (ckhReject.Checked == true)
                {
                    objJs.UpdateJobsheetApprovalClosure();
                    AwaitingApprovalMail(HyperLink1.Text, "N");
                    //if (hf_EmailID_To.Value != "")
                    //{
                    //    RejectSendMail(HyperLink1.Text, hf_EmailID_To.Value + "," + hf_EmailID_CC.Value, hfFrom.Value, tb_Remarks.Text, hfFromName.Value, hfFromContact.Value);
                    //}
                }
                //objJs.RollBackTransaction();
                objJs.CommitTransaction();

                lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
                lbl_Page_Error.Text = "Job Order successfully updated.";
            }
            catch(Exception ex)
            {
                objJs.RollBackTransaction();
                Response.Write(ex.Message.ToString());
            }
        }
        RetrieveGridData();
    }

    public void AwaitingApprovalMail(string strJobOrderNo, string Status)
    {
        JobSheet objJs = new JobSheet(Convert.ToString(Session["SqlProvider"]));
        DataTable dtCheckAmt = new DataTable();
        dtCheckAmt = objJs.GetDataTable("Select *,dbo.GetUserEmailId(USERID_TO,Loc_Code) + ',' + dbo.GetUserEmailId(USERID_CC,Loc_Code)  As EmailUserID From Webx_Fleet_JobOrder_Approval_Mst  with(nolock) Where Job_Order_No ='" + strJobOrderNo.Trim() + "' And Flag='Closure' And Loc_Code='" + Session["brcd"].ToString() + "'");

        DataTable dtLoginUsesDet = new DataTable();
        dtLoginUsesDet = objJs.GetDataTable("Select * From Webx_Master_Users  with(nolock) Where USERID='" + Session["empcd"].ToString() + "'");

        if (dtCheckAmt.Rows.Count > 0)
        {
            double vActual_Amt = Convert.ToDouble(dtCheckAmt.Rows[0]["Actual_Amt"].ToString());
            double vApproved_Amt = Convert.ToDouble(dtCheckAmt.Rows[0]["Approved_Amt"].ToString());
            double vLoc_Level = Convert.ToDouble(dtCheckAmt.Rows[0]["Loc_Level"].ToString());

            if (vActual_Amt > vApproved_Amt)
            {
                DataTable dtEmails = new DataTable();
                dtEmails = objJs.GetDataTable("Select *,dbo.GetUserEmailId(USERID_TO,Loc_Code) + ',' + dbo.GetUserEmailId(USERID_CC,Loc_Code)  As EmailUserID From Webx_Fleet_JobOrder_Approval_Mst  with(nolock) Where Job_Order_No ='" + strJobOrderNo.Trim() + "' And Flag='Closure' And (Loc_Level = " + vLoc_Level + " Or Loc_Level > " + vLoc_Level + " Or Loc_Level = " + (vLoc_Level - 1) + ")");
                string strEmails = "";
                if (dtEmails.Rows.Count > 0)
                {
                    foreach (DataRow row in dtEmails.Rows)
                    {
                        strEmails += row["EmailUserID"].ToString() + ",";
                    }
                }
                SendMailAwaiting(strJobOrderNo, strEmails, dtLoginUsesDet.Rows[0]["EmailID"].ToString(), dtLoginUsesDet.Rows[0]["Name"].ToString(), dtLoginUsesDet.Rows[0]["PhoneNo"].ToString(), Status, vLoc_Level);
            }
            else
            {
                DataTable dtEmails = new DataTable();
                dtEmails = objJs.GetDataTable("Select *,dbo.GetUserEmailId(USERID_TO,Loc_Code) + ',' + dbo.GetUserEmailId(USERID_CC,Loc_Code)  As EmailUserID From Webx_Fleet_JobOrder_Approval_Mst  with(nolock) Where Job_Order_No ='" + strJobOrderNo.Trim() + "' And Flag='Closure' And (Loc_Level = " + vLoc_Level + " Or Loc_Level > " + vLoc_Level + ")");
                string strEmails = "";
                if (dtEmails.Rows.Count > 0)
                {
                    foreach (DataRow row in dtEmails.Rows)
                    {
                        strEmails += row["EmailUserID"].ToString() + ",";
                    }
                }
                SendMailApproved(strJobOrderNo, strEmails, dtLoginUsesDet.Rows[0]["EmailID"].ToString(), dtLoginUsesDet.Rows[0]["Name"].ToString(), dtLoginUsesDet.Rows[0]["PhoneNo"].ToString(), Status);
            }
        }
    }
    public void SendMailAwaiting(string strJobOrderNo, string strTO, string strFrom, string strName, string strContact, string Status, double vLoc_Level)
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
        //if (Status == "Y" && vLoc_Level !=1)
        //{
        //    strBody = strBody + "Remarks : Job Order is pending for approval";
        //}
        //else if (Status == "N" && vLoc_Level !=1)
        //{
        //    strBody = strBody + "Remarks : Job Order was Rejected";
        //}
        //else if (vLoc_Level == 1)
        //{
        //    strBody = strBody + "Remarks : Job Order Approved"; 
        //}
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
        //if (Status == "Y" && vLoc_Level != 1)
        //{
        //    msg.EmailSubject = "Job Order Awaiting for Approval";
        //}
        //else if (Status == "N" && vLoc_Level != 1)
        //{
        //    msg.EmailSubject = "Job Order Rejected";
        //}
        //else if (vLoc_Level == 1)
        //{
        //    msg.EmailSubject = "Job Order Approved";
        //}
        //msg.EmailMessage = strBody;

        ////Smtp smtp = new Smtp();
        ////smtp.SmtpServer = "202.144.65.93";
        ////smtp.SmtpUser = "TMSAutoMails@agilitylogistics.in";
        ////smtp.SmtpPassword = "pass1234";

        ////smtp.SendEmail(msg);
    }
    public void SendMailApproved(string strJobOrderNo, string strTO, string strFrom, string strName, string strContact, string Status)
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
        //if (Status == "Y")
        //{
        //    strBody = strBody + "Remarks : Job Order was approved and get for Bill Entry.";
        //}
        //else
        //{
        //    strBody = strBody + "Remarks : Job Order was rejected";
        //}
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
        //if (Status == "Y")
        //{
        //    msg.EmailSubject = "Job Order Approved";
        //}
        //else
        //{
        //    msg.EmailSubject = "Job Order Rejected";
        //}
        //msg.EmailMessage = strBody;
        ////Smtp smtp = new Smtp();
        ////smtp.SmtpServer = "202.144.65.93";
        ////smtp.SmtpUser = "TMSAutoMails@agilitylogistics.in";
        ////smtp.SmtpPassword = "pass1234";
        ////smtp.SendEmail(msg);
    }
    //public void ApprovalSendMail(string strJobOrderNo, string strTO, string strFrom, string strRemarks, string strName, string strContact)
    //{
    //    string strBody = "";

    //    strBody = " <html> ";
    //    strBody = strBody + "<body> ";
    //    strBody = strBody + "<table style='font-family: Calibri; font-size: 16px; color: darkblue;'> ";
    //    strBody = strBody + "<tr> ";
    //    strBody = strBody + "<td> ";
    //    strBody = strBody + "Dear Sir,<br /> ";
    //    strBody = strBody + "</td> ";
    //    strBody = strBody + "</tr> ";
    //    strBody = strBody + "<tr> ";
    //    strBody = strBody + "<td> ";
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Location : " + Session["brcd"].ToString();
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Job Order Number " + strJobOrderNo + " was Approved by " + Session["empcd"].ToString() + " for bill entry.";
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Remarks : " + strRemarks;
    //    strBody = strBody + "</td> ";
    //    strBody = strBody + "</tr> ";
    //    strBody = strBody + "<tr> ";
    //    strBody = strBody + "<td> ";
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Regards,<br /> ";
    //    strBody = strBody + "Jiten Khatri<br />";
    //    strBody = strBody + "(ECFY) ";
    //    strBody = strBody + "</td> ";
    //    strBody = strBody + "</tr> ";
    //    strBody = strBody + "</table> ";
    //    strBody = strBody + "</body> ";
    //    strBody = strBody + "</html>";


    //    string[] ToMail = strTO.Replace(",,",",").Split(',');

    //    MailMessageFleet msg = new MailMessageFleet();
    //    msg.EmailFrom = strFrom;
    //    if (ToMail.Length > 0)
    //    {
    //        for (int i = 0; i < ToMail.Length; i++)
    //        {
    //            if (ToMail[i] != "")
    //            {
    //                msg.AddEmailTo(ToMail[i]);
    //            }
    //        }
    //    }
    //    msg.EmailMessageType = MessageType.HTML;
    //    msg.EmailSubject = "Job Order Approval";
    //    msg.EmailMessage = strBody;

    //    Smtp smtp = new Smtp();
    //    smtp.SmtpServer = "202.144.65.93";
    //    smtp.SmtpUser = "TMSAutoMails@agilitylogistics.in";
    //    smtp.SmtpPassword = "pass1234";
    //    smtp.SendEmail(msg);

    //    lblStatus.Text = "Sending...";
    //    lblStatus.Text = "mail sent";
    //}
    //public void RejectSendMail(string strJobOrderNo, string strTO, string strFrom, string strRemarks)
    //{
    //    string strBody = "";
    //    strBody = " <html> ";
    //    strBody = strBody + "<body> ";
    //    strBody = strBody + "<table style='font-family: Calibri; font-size: 16px; color: darkblue;'> ";
    //    strBody = strBody + "<tr> ";
    //    strBody = strBody + "<td> ";
    //    strBody = strBody + "Dear Sir,<br /> ";
    //    strBody = strBody + "</td> ";
    //    strBody = strBody + "</tr> ";
    //    strBody = strBody + "<tr> ";
    //    strBody = strBody + "<td> ";
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Location : " + Session["brcd"].ToString();
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Job Order Number " + strJobOrderNo + " was Rejected by " + Session["empcd"].ToString();
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Remarks : " + strRemarks;
    //    strBody = strBody + "</td> ";
    //    strBody = strBody + "</tr> ";
    //    strBody = strBody + "<tr> ";
    //    strBody = strBody + "<td> ";
    //    strBody = strBody + "<br /> ";
    //    strBody = strBody + "Regards,<br /> ";
    //    strBody = strBody + "Jiten Khatri<br /> ";
    //    strBody = strBody + "(ECFY) ";
    //    strBody = strBody + "</td> ";
    //    strBody = strBody + "</tr> ";
    //    strBody = strBody + "</table> ";
    //    strBody = strBody + "</body> ";
    //    strBody = strBody + "</html>";
    //    string[] ToMail = strTO.Split(',');


    //    MailMessageFleet msg = new MailMessageFleet();
    //    msg.EmailFrom = strFrom;
    //    if (ToMail.Length > 0)
    //    {
    //        for (int i = 0; i < ToMail.Length; i++)
    //        {
    //            if (ToMail[i] != "")
    //            {
    //                msg.AddEmailTo(strTO);
    //            }
    //        }
    //    }
    //    msg.EmailMessageType = MessageType.HTML;
    //    msg.EmailSubject = "Job Order Rejected";
    //    msg.EmailMessage = strBody;

    //    Smtp smtp = new Smtp();
    //    smtp.SmtpServer = "202.144.65.93";
    //    smtp.SmtpUser = "TMSAutoMails@agilitylogistics.in";
    //    smtp.SmtpPassword = "pass1234";
    //    smtp.SendEmail(msg);


    //    lblStatus.Text = "Sending...";
    //    lblStatus.Text = "mail sent.";
    //}
}

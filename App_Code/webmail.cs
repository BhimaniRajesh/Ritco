using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Net;

/// <summary>
/// Summary Description for webmail
/// </summary>
#region Sending Mail
public sealed class webmail
{
    #region Variable
    string _strfrom, _strTo, _strCC, _strBCC, _strSubject, _strBody, _strLocAttch;
    #endregion

    #region constractor
    public webmail()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    #endregion

    #region Property
    public string Mail_From
    {
        get
        {
            return _strfrom;
        }
        set
        {
            _strfrom = value;
        }
    }
    public string Mail_To
    {
        get
        {
            return _strTo;
        }
        set
        {
            _strTo = value;
        }
    }
    public string Mail_CC
    {
        get
        {
            return _strCC;
        }
        set
        {
            _strCC = value;
        }
    }
    public string Mail_BCC
    {
        get
        {
            return _strBCC;
        }
        set
        {
            _strBCC = value;
        }
    }
    public string Mail_Subject
    {
        get
        {
            return _strSubject;
        }
        set
        {
            _strSubject = value;
        }
    }
    public string Mail_Body
    {
        get
        {
            return _strBody;
        }
        set
        {
            _strBody = value;
        }
    }
    public string Mail_LocAttch
    {
        get
        {
            return _strLocAttch;
        }
        set
        {
            _strLocAttch = value;
        }
    }
    #endregion

    #region Send Mail Methods
    /// <summary>
    /// This Method will use when Sending Mail using Property
    /// </summary>
    public void sendmail()
    {
        //MailMessage Msg = new MailMessage();
        //SmtpMail sm;
        //Msg.From = _strfrom;
        //Msg.To = _strTo;
        //Msg.Cc = _strCC;
        //Msg.Bcc = _strBCC;
        //if (_strLocAttch != "")
        //{
        //    Msg.Attachments.Add(new MailAttachment(_strLocAttch));
        //}
        //Msg.BodyFormat = MailFormat.Html;
        //Msg.Subject = _strSubject;
        //SmtpMail.SmtpServer = "";
        //Msg.Body = _strBody;
        //SmtpMail.Send(Msg);

        sendmail(_strfrom, _strTo, _strCC, _strBCC, _strSubject, _strBody, _strLocAttch);
    }
    /// <summary>
    /// This Method will use when Sending Mail using Parameter
    /// </summary>
    public void sendmail(string strfrom, string strTo, string strCC, string strBCC, string strSubject, string strBody, string strLocAttch)
    {
        try
        {
            SmtpClient smtp = new SmtpClient("smtpauth.webxpress.in", 587);
            //smtp.Credentials = new NetworkCredential("erpalerts@ritcologistics.com", "Ritcoerp@336");
            smtp.Credentials = new NetworkCredential("info@webxpress.in", "info2018");
            MailMessage Msg = new MailMessage();
            strTo += ";"; strCC += ";"; strBCC += ";";

            Msg.From = new MailAddress(strfrom);
            string[] to = strTo.Split(';');
            foreach (string s in to)
            {
                if (s != "")
                    Msg.To.Add(new MailAddress(s));
            }
            string[] cc = strCC.Split(';');
            foreach (string s in cc)
            {
                if (s != "")
                    Msg.CC.Add(new MailAddress(s));
            }
            string[] bcc = strBCC.Split(';');
            foreach (string s in bcc)
            {
                if (s != "")
                    Msg.Bcc.Add(new MailAddress(s));
            }

            if (strLocAttch != "")
            {
                Msg.Attachments.Add(new Attachment(strLocAttch));
            }
            Msg.IsBodyHtml = true;
            Msg.Subject = strSubject;
            Msg.Body = strBody;
            Msg.ReplyTo = new MailAddress("info@webxpress.in");

            smtp.Send(Msg);
        }
        catch (Exception ex)
        {
            try
            {
                SmtpClient smtp = new SmtpClient("smtpauth.webxpress.in", 587);
                smtp.Credentials = new NetworkCredential("info@webxpress.in", "info2018");

                MailMessage Msg = new MailMessage();
                Msg.To.Add(new MailAddress("ronak@webxpress.in"));

                Msg.Body = "To : " + strTo + "<br /> CC : " + strCC + "<br /> BCC : " + strBCC + "< br/>" + ex.Message + "< br/>" + ex.StackTrace;
                Msg.IsBodyHtml = true;
                Msg.Subject = "IMS : Error Sending Mail";

                smtp.Send(Msg);
            }
            catch (Exception exc)
            { }
        }
    }
    public void sendmail(string strfrom, string strTo, string strCC, string strBCC, string strSubject, string strBody, string[] strLocAttch)
    {
        try
        {
            SmtpClient smtp = new SmtpClient("smtpauth.webxpress.in", 587);
            smtp.Credentials = new NetworkCredential("info@webxpress.in", "info2018");
            MailMessage Msg = new MailMessage();
            strTo += ";"; strCC += ";"; strBCC += ";";

            Msg.From = new MailAddress(strfrom);
            string[] to = strTo.Split(';');
            foreach (string s in to)
            {
                if (s != "")
                    Msg.To.Add(new MailAddress(s));
            }
            string[] cc = strCC.Split(';');
            foreach (string s in cc)
            {
                if (s != "")
                    Msg.CC.Add(new MailAddress(s));
            }
            string[] bcc = strBCC.Split(';');
            foreach (string s in bcc)
            {
                if (s != "")
                    Msg.Bcc.Add(new MailAddress(s));
            }
            foreach (string s in strLocAttch)
            {
                if (s != "")
                    Msg.Attachments.Add(new Attachment(s));
            }

            Msg.IsBodyHtml = true;
            Msg.Subject = strSubject;
            Msg.Body = strBody;
            Msg.ReplyTo = new MailAddress("info@webxpress.in");

            smtp.Send(Msg);
        }
        catch (Exception ex)
        {
            try
            {
                SmtpClient smtp = new SmtpClient("smtpauth.webxpress.in", 587);
                smtp.Credentials = new NetworkCredential("info@webxpress.in", "info2018");

                MailMessage Msg = new MailMessage();
                Msg.To.Add(new MailAddress("ronak@webxpress.in"));

                Msg.Body = "To : " + strTo + "<br /> CC : " + strCC + "<br /> BCC : " + strBCC + "< br/>" + ex.Message + "< br/>" + ex.StackTrace;
                Msg.IsBodyHtml = true;
                Msg.Subject = "IMS : Error Sending Mail";

                smtp.Send(Msg);
            }
            catch (Exception exc)
            { }
        }
    }
    public void sendmail(string strBillSubmission,string strfrom, string strTo, string strCC, string strBCC, string strSubject, string strBody, string[] strLocAttch)
    {
        try
        {
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("iansari@indiantankers.com", "itpl1386");
            MailMessage Msg = new MailMessage();
            strTo += ";"; strCC += ";"; strBCC += ";";

            smtp.EnableSsl = true;

            Msg.From = new MailAddress(strfrom,"ITPL : TMS Auto E-Mail");
            string[] to = strTo.Split(';');
            foreach (string s in to)
            {
                if (s != "")
                    Msg.To.Add(new MailAddress(s));
            }
            string[] cc = strCC.Split(';');
            foreach (string s in cc)
            {
                if (s != "")
                    Msg.CC.Add(new MailAddress(s));
            }
            string[] bcc = strBCC.Split(';');
            foreach (string s in bcc)
            {
                if (s != "")
                    Msg.Bcc.Add(new MailAddress(s));
            }
            foreach (string s in strLocAttch)
            {
                if (s != "")
                    Msg.Attachments.Add(new Attachment(s));
            }
            Msg.IsBodyHtml = true;
            Msg.Subject = strSubject;
            Msg.Body = strBody;
            Msg.ReplyTo = new MailAddress("noreply@gmail.com");

            smtp.Send(Msg);
        }
        catch (Exception ex)
        {
            try
            {
                SmtpClient smtp = new SmtpClient("smtp.net4india.com", 25);
                smtp.Credentials = new NetworkCredential("vpatel@webxpress.in", "vp2012");

                MailMessage Msg = new MailMessage();
                Msg.From = new MailAddress(strfrom);
                Msg.To.Add(new MailAddress("vpatel@webxpress.in"));
                Msg.Body = "To : " + strTo + "<br /> CC : " + strCC + "<br /> BCC : " + strBCC + "< br/>" + ex.Message + "< br/>" + ex.StackTrace;
                Msg.IsBodyHtml = true;
                Msg.Subject = "IMS : Error Sending Mail";

                smtp.Send(Msg);
            }
            catch (Exception exc)
            { }
        }
    }

    #endregion
}
#endregion
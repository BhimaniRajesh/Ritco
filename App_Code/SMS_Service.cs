using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Text;
using System.Configuration;
using System.Net;
using System.IO;
using System.Xml;

/// <summary>
/// Summary description for SMS_Service
/// </summary>
[WebService(Namespace = "http://www.webxpress.in/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]

public class SMS_Service : System.Web.Services.WebService
{
    //private string Service_URL = "http://instant.sinfini.com/web2sms.php?username={0}&password={1}&to={4}&sender={2}&message={3}";
    //private string Service_URL = "http://www.k3digitalmedia.in/sendsms/sendsms.php?username={0}&password={1}&type={5}&sender={2}&mobile={4}&message={3}";
    private string Service_URL = "http://sms.bizgrow.in/api/sendmsg.php?user={0}&pass={1}&sender={2}&phone={3}&text={4}&priority={5}&stype={6}";
    private string UserName = "shailesh.latad";
    private string Password = "Bizgrow7@";
    private string SenterId = "demo";

    private string EnableProxy = ConfigurationManager.AppSettings["EnableProxy"];
    private string ProxyHost = ConfigurationManager.AppSettings["ProxyHost"];
    private int ProxyPort = Convert.ToInt32(ConfigurationManager.AppSettings["ProxyPort"]);
    private string ProxyUserName = ConfigurationManager.AppSettings["ProxyUserName"];
    private string ProxyPassword = ConfigurationManager.AppSettings["ProxyPassword"];

    public SMS_Service()
    {
        //Uncomment the following line if using designed components s
        //InitializeComponent(); 
    }

    [WebMethod]
    public string SendSMS(string MobileNos, string SmsText)
    {
        string strRet = "";
        XmlDocument DocRet = new XmlDocument();

        string MessageResult = SendSMSMessage(MobileNos, SmsText);

        string status = "0";
        if (MessageResult == "Message Successfully Sent")
        {
            status = "1";
        }
        else
        {
            status = "0";
        }
        strRet = "<Result>" +
                 "<Status>" + status + "</Status>" +
                 "<Message>" + MessageResult + "</Message>" +
                 "</Result>";

        return strRet;
    }

    private string SendSMSMessage(string MobileNos, string SmsText)
    {
        string SmsResult = "";

        string[] Numbers = MobileNos.Split(',');
        foreach (string s in Numbers)
        {
            if (!s.Trim().Equals(""))
            {
                string responce = GetHttpResponce(string.Format(Service_URL, UserName, Password, SenterId, s, SmsText, "dnd", "normal"));

                if (responce.Substring(0, 2).Trim().Equals("S."))//S.188416
                {
                    SmsResult = "Message Successfully Sent";
                }
                else
                {
                    throw new Exception(responce.Trim());
                }
            }
        }


        return SmsResult;
    }

    private string GetHttpResponce(string URL)
    {
        StringBuilder sb = new StringBuilder();
        byte[] buf = new byte[8192];

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(URL);
        if (EnableProxy.Equals("1"))
        {
            IWebProxy proxyObject = new WebProxy(ProxyHost, ProxyPort);
            if (ProxyUserName.Trim() != "")
                proxyObject.Credentials = new NetworkCredential(ProxyUserName, ProxyPassword);
            request.Proxy = proxyObject;
        }
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        Stream resStream = response.GetResponseStream();

        string tempString = null;
        int count = 0;
        do
        {
            count = resStream.Read(buf, 0, buf.Length);
            if (count != 0)
            {
                tempString = Encoding.ASCII.GetString(buf, 0, count);
                sb.Append(tempString);
            }
        }
        while (count > 0);

        return sb.ToString();
    }

}


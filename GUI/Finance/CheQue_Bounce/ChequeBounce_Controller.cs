using System;
using System.Data;
using System.Data.SqlClient;
using WebX.Common;

/// <summary>
/// Summary description for ChequeBounce_Controller
/// </summary>
public class ChequeBounce_Controller:Base
{
    public ChequeBounce_Controller()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable GetListCheque(string BankName, string ChequeNo, decimal Amount,DateTime ChequeDate)
    {
        try
        {
            return ExecuteDataTable("USP_ChequeBounce_GetListCheque",
                new SqlParameter[] { new SqlParameter("@BankName", BankName),
                new SqlParameter("@ChequeNo", ChequeNo),
                new SqlParameter("@ChequeAmount", Amount),
                new SqlParameter("@ChequeDate", ChequeDate.ToString("dd MMM yyyy"))
                }
                );
        }
        catch (Exception)
        {
            throw;
        }
    }
    public DataTable GetPaymentListCheque(string FromDate, string ToDate,string ROLocation,string Loccode,string Customer,string ChequeNo)
    {
        try
        {
            return ExecuteDataTable("Usp_ChequeBounce_PaymentCollection_GetBounceCheque",
                new SqlParameter[] { new SqlParameter("@FromDate", FromDate),
                new SqlParameter("@ToDate", ToDate),
                new SqlParameter("@RO", ROLocation),
                new SqlParameter("@LO", Loccode),
                new SqlParameter("@Customer", Customer),
                new SqlParameter("@ChequeNo", ChequeNo)
                }
                );
        }
        catch (Exception)
        {
            throw;
        }
    }
    #region 
    public void SendEmailForCheque()
    {

        string srno = "";
        string strSubject = "";
        try
        {
            DataTable dtComplaint = ExecuteDataTable("Usp_ChequeBounce_Automail", null);

            srno = "";
            strSubject = "";
            foreach (DataRow dr in dtComplaint.Rows)
            {
                var strMailMsg = "";
                string strEmailFrom = "", strEmailTo = "", strEmailCc = "", strEmailBcc = "", strHeaderText = "";
                strSubject = "Cheque Bounced of   " + dr["CustomerName"].ToString();

                strMailMsg = "<head>" +
                    " <style>" +
                    "         p.MsoNormal, li.MsoNormal, div.MsoNormal {" +
                    "             margin: 0in;" +
                    "             margin-bottom: .0001pt;" +
                    "             font-size: 12.0pt;" +
                    "             font-family: \"Verdana\",\"serif\";" +
                    "         }" +

                    "         a:link, span.MsoHyperlink {" +
                    "             color: blue;" +
                    "             text-decoration: underline;" +
                    "         }" +

                    "         span.style1 {" +
                    "             font-family: \"Verdana\",\"sans-serif\";" +
                    "             font-size: 9.0pt;" +
                    "             color: #002060;" +
                    "         }" +

                    "         span.style2 {" +
                    "             font-family: \"Verdana\",\"sans-serif\";" +
                    "             font-size: 9.0pt;" +
                    "             color: black;" +
                    "             line-height: 150%;" +
                    "         }" +

                    "         span.styleRed {" +
                    "             font-family: \"Verdana\",\"sans-serif\";" +
                    "             font-size: 9.0pt;" +
                    "             color: red;" +
                    "             line-height: 150%;" +
                    "         }" +

                    "         td.styleTdLable {" +
                    "             width: 207px;" +
                    "             border: solid windowtext 1.0pt;" +
                    "             border-top: solid windowtext 1.0pt;" +
                    "             padding: 0in 5.4pt 0in 5.4pt;" +
                    "             vertical-align: central;" +
                    "             " +
                    "         }" +

                    "         td.styleTdValue {" +
                    "             width: 416px;" +
                    "             border-top: solid windowtext 1.0pt;" +
                    "             border-left: none;" +
                    "             border-bottom: solid windowtext 1.0pt;" +
                    "             border-right: solid windowtext 1.0pt;" +
                    "             padding: 0in 5.4pt 0in 5.4pt;" +
                    "             vertical-align: central;" +
                    "             " +
                    "         }" +

                    "         tr.stylTr {" +
                    "              line-height: 20px;" +
                    "              vertical-align:central;" +
                    "         }" +

                    "         @page WordSection1 {" +
                    "             size: 8.5in 11.0in;" +
                    "             margin: 1.0in 1.0in 1.0in 1.0in;" +
                    "         }" +

                    "         div.WordSection1 {" +
                    "             page: WordSection1;" +
                    "         }" +
                    "     </style>" +
                 "</head>" +

                     "<body>" +
                         "<div class=\"WordSection1\">" +
                             "<span style='font-size: 9.0pt; font-family: \"Verdana\",\"sans-serif\"'>&nbsp; </span>" +
                             "<table class=\"MsoNormalTable\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style='width: 100.0%; background: #8BA0E5'>" +
                                
                                " <tr style='height: 14.25pt'>" +
                                    " <td style='background: white; padding: 1.5pt 1.5pt 1.5pt 1.5pt; height: 14.25pt'>" +
                                       "  <span class=\"style1\">" + strHeaderText +
                                       "  </span>" +
                                        "  <span class=\"style1\">" +
                                       "  </span>" +
                                        " <table class=\"MsoNormalTable\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style='border-collapse: collapse'>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Cheque No  </span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["ChequeNo"] + "</span></td>" +
                                            " </tr>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Customer Name</span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["CustomerName"] + "  </span></td>" +
                                            " </tr>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Deposite Date</span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["DepositeDate"] + "  </span></td>" +
                                            " </tr>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Amount  </span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["Amount"] + "</span></td>" +
                                            " </tr>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Remarks  </span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["Remarks"] + "  </span></td>" +
                                            " </tr>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Bounced By </span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["Bounced By"] + "  </span></td>" +
                                            " </tr>" +
                                            " <tr class=\"stylTr\">" +
                                            "     <td class=\"styleTdLable\"><span class=\"style2\">Bounced Date </span></td>" +
                                            "     <td class=\"styleTdValue\"><span class=\"style2\">" + dr["Bounced Date"] + "  </span></td>" +
                                            " </tr>" +
                                         " </table>" +

                         "  <b><span class=\"style2\">&nbsp; " +
                         " <br />" +
                         " Thanks & Regards,  " +
                         " <br />" +
                         " Ritco IT Team  " +
                         " <br />" +
                         " <b>This is an auto generated e-mail sent from TMS, pls do not reply back. </b>  " +
                         " <br />" +
                         " Powered by:<a href='www.WebXpress.in'>www.WebXpress.in</a>   " +
                         " </td>" +
                         " </tr>" +
                         " </table>" +
                         "</div>" +
                         "</body>";

                //string strBody = "<html><head><style type='text/css'>tr{font-family:verdana;font-size:12px;}</style></head><body><table><tr><td>";
                //strMailMsg = strBody + dtComplaint + "</td></tr><tr><td><br><b>Thanks & Regards,</b></td></tr><tr><td><br>Ritco IT Team</td></tr><tr><td><b>This is an auto generated e-mail sent from TMS, pls do not reply back. </b></td></tr><tr><td><br/>Powered by: <a href='www.WebXpress.in'></a></td></tr></table></html></body>";



                //strEmailFrom = "erpalerts@ritcologistics.com";
                strEmailFrom = "info@webxpress.in";
                strEmailBcc = "ronak@webxpress.in";
                strEmailFrom = "info@webxpress.in";
                strEmailTo = dr["EmailId"].ToString();
                strEmailCc = dr["CcEmail"].ToString();
                Sendmail(strEmailFrom, strEmailTo, strEmailCc, strEmailBcc, strSubject, strMailMsg, "");

                if (srno == "") { srno = dr["SrNo"].ToString(); } else { srno = srno + "," + dr["SrNo"].ToString(); }

            }//end foreach loop

            //update sent mail status 
            if (srno != "")
            {
                ExecuteDataTable("Usp_ChequeBounce_AutomailStatusUpdate", new SqlParameter[] { new SqlParameter("@SrNo", srno) });
            }

        }
        catch (Exception ex)
        {
            Sendmail("ronak@webxpress.in", "ronak@webxpress.in", "", "", "Error In Cheque Bounce", strSubject + "->" + ex.ToString(), "");
            ExceptionUtility.LogException(ex, "Error In Cheque Bounce Sent Mail => " + strSubject);
        }

    }

    public void Sendmail(string strfrom, string strTo, string strCc, string strBcc, string strSubject, string strBody, string strLocAttch)
    {
        try
        {
            var smsService = new SMS_Service();
            var wm = new webmail();
            wm.sendmail(strfrom, strTo, strCc, strBcc, strSubject, strBody, strLocAttch);
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "Cheque Bounce Controller--> sendmail", "Cheque BounceController");
        }
    }
    #endregion


}
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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Billing_BillEdit_BringDocDetails : System.Web.UI.Page
{
    public static string Financial_Year = "", fin_year = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (mode.CompareTo("date") == 0)
        {
            string voucherno = Request.QueryString["code"].ToString();
            string yearsuffix = "";

            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

            DataTable vdtl = new DataTable();
            DataTable cdtl = new DataTable();
            DataTable onAccdtl = new DataTable();

            vdtl.Rows.Clear();
            cdtl.Rows.Clear();
            onAccdtl.Rows.Clear();

            string qry = "SELECT distinct voucherno,convert(varchar,transdate,103) as transdate,voucher_cancel,Transtype FROM webx_acctrans_" + fin_year + " WITH(NOLOCK) WHERE voucherno='" + voucherno + "' AND isnull(COMMENT,'')='' and (opertitle like '%manual%' or opertitle like '%special%')";
            vdtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, qry).Tables[0];
            if (vdtl.Rows.Count > 0)
            {
                string CaseFlag = "N";
                if (vdtl.Rows[0]["voucher_cancel"].ToString().CompareTo("Y") == 0)
                {
                    Response.Write("false|Voucher No Is Already Cancelled...|");
                    CaseFlag = "Y";
                }
                if (vdtl.Rows[0]["TRANSTYPE"].ToString().CompareTo("BANK RECEIPT") == 0 || vdtl.Rows[0]["TRANSTYPE"].ToString().CompareTo("BOTH RECEIPT") == 0)
                {
                    if (CaseFlag == "N")
                    {
                        qry = "SELECT DISTINCT A.CHQNO,CHQDATE=CONVERT(VARCHAR,A.CHQDATE,106),B.DEPOFLAG,B.ONACCOUNT_YN FROM webx_acctrans_" + fin_year + " A WITH(NOLOCK) INNER JOIN WEBX_CHQ_DET B ON A.CHQNO=B.CHQNO AND A.CHQDATE=B.CHQDT AND A.VOUCHERNO='" + voucherno + "' AND A.VOUCHER_CANCEL='N'";
                        cdtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, qry).Tables[0];
                        if (cdtl.Rows.Count > 0)
                        {
                            string chqno = cdtl.Rows[0]["CHQNO"].ToString();
                            string chqdt = cdtl.Rows[0]["CHQDATE"].ToString();
                            if (cdtl.Rows[0]["ONACCOUNT_YN"].ToString().CompareTo("Y") == 0)
                            {
                                qry = "SELECT COUNT(*) FROM WEBX_BILLCHQDETAIL WHERE CHQNO='" + chqno + "' AND CHQDT='" + chqdt + "'";
                                double count = 0;
                                count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, qry));
                                if (count > 0)
                                {
                                    Response.Write("false|On Account Cheque Entered In This Credit Voucher Is Used In Bill Collection So You Cant Cancel This Credit Voucher...|");
                                    CaseFlag = "Y";
                                }
                            }
                            if (cdtl.Rows[0]["DEPOFLAG"].ToString().CompareTo("Y") == 0)
                            {
                                if (CaseFlag == "N")
                                {
                                    qry = "SELECT COUNT(*) FROM webx_acctrans_" + fin_year + " WITH(NOLOCK) WHERE VOUCHERNO='" + voucherno + "' AND ACCCODE='ACA0002' AND VOUCHER_CANCEL='N'";
                                    double count = 0;
                                    count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, qry));
                                    if (count > 0)
                                    {
                                        Response.Write("false|Cheque Deposit Voucher Is Generated For Used Cheque In Credit Voucher So, You Cant Cancel This Voucher ...|");
                                        CaseFlag = "Y";
                                    }
                                }
                            }
                        }
                    }
                }
                if (CaseFlag == "N")
                {
                    Response.Write("true|" + vdtl.Rows[0]["transdate"].ToString() + "|");
                }
            }
            else
            {
                Response.Write("false|InValid Voucher No....\n\n Or \n\nPlz Enter\nCredit Voucher\nDebit Voucher\nContra Entry\nJournal Voucher|");   
            }
        }
        else if (mode.CompareTo("bill") == 0)
        {
           
        }
        con.Close();
    }
}

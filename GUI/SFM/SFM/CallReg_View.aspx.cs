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

public partial class SFM_CallReg_View : System.Web.UI.Page
{
    public static SqlConnection conn;
    function2 fn = new function2();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        
        string strCallCode = Request.QueryString.Get("strCallCode");
        string[] Split = strCallCode.Split(new Char[] { ',' });
        strCallCode = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        string sql = "select callCode,convert(varchar,callDt,106) as CallDt,prospectCode,convert(varchar,EntryDt,106),PersonCalled,CallTime,discPoint,callDuration,AcctCategory,Apprstatus,CallType,convert(varchar,lastOrderdt,106) as lastOrderdt,valpmonth from webx_CallEntry a  where CallCode='" + strCallCode + "'";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        SqlDataReader dr = null;
        dr = sqlcmd2.ExecuteReader();
        try
        {
            if (dr.Read())
            {
                string callCode = dr[0].ToString().Trim();
                string callDt = dr["CallDt"].ToString().Trim();
                string ProspectCode = dr["prospectCode"].ToString().Trim();
                string EntryDt = dr[3].ToString().Trim();
                string PersonCalled = dr[4].ToString().Trim();
                string CallTime = dr[5].ToString().Trim();
                string discPoint = dr[6].ToString().Trim();
                string callDuration = dr[7].ToString().Trim();
                string AcctCategory = dr[8].ToString().Trim();
                string CallType = dr["CallType"].ToString().Trim();
                string lastOrderDt = dr["lastOrderdt"].ToString();
                string valpmonth = dr["valpmonth"].ToString();

                lblDate.Text = callDt;
                lblProspect.Text = ProspectCode + ":" + fn.GetCompanyName(ProspectCode);
                lblEntryDate.Text = EntryDt;
                lblPersonCalled.Text = PersonCalled;
                lblTime.Text = CallTime;
                lblDiscuss.Text = discPoint;
                lblDuration.Text = callDuration;
                lblCategory.Text = AcctCategory;
                lblCallType.Text = CallType;
                lblLastOrderDt.Text = lastOrderDt;
                lblOrderValue.Text = valpmonth;

            }
            else
            {

            }
        }
        finally
        {
            conn.Close();
        }
    }
}

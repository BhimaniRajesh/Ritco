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

public partial class Clients_1_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Client"] = "PTN";
        Session["RedirectURL"] = "~/login.aspx";
        Session["SqlProvider"] = "Data Source=localhost;Initial Catalog=ptn_live_net;UID=sa;pwd=@ptn$ecfy";
        getFinYear();

        Session["HeadOfficeCode"] = "HOO";
	Session["YearVal"] = "07_08";
	Session["Dktlength"] = "7";
        Session["FinYearStart"] = "1 Apr " + Session["FinYear"];
        Session["logofile"] = "ptn_logo.gif";
        Session["DocketCalledAs"] = "CNote";
        Session["THCCalledAs"] = "THC";

        Response.Redirect("~/GUI/default.aspx");
    }

private void getFinYear()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        string sql = "usp_Get_Finacial_Years";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr = sqlCmd.ExecuteReader();

        while (dr.Read())
        {
            if (Session["FinYear"] == null)
            {
                Session["FinYear"] = dr["FinYear"].ToString().Trim();
                Session["YearVal"] = dr["YearVal"].ToString().Trim();
                string yearval = Session["YearVal"].ToString();
                string finYear = Session["FinYear"].ToString();
                string info = finYear;
                string strStartVal = "";
                string strEndVal = "";
                string[] arInfo = new string[1];
                char[] splitter = { '-' };
                arInfo = info.Split(splitter);
                for (int x = 0; x < arInfo.Length; x++)
                {
                    strStartVal = arInfo[0];
                    Session["FinYearStart"] = "1 Apr " + strStartVal;
                    Session["FinYear"] = strStartVal;
                    strEndVal = arInfo[1];
                    Session["FinYearEnd"] = "31 Mar " + strEndVal;
                }

                string strStartVal1 = "";
                string strEndVal1 = "";
                string info1 = yearval;
                string[] arInfo1 = new string[1];
                char[] splitter1 = { '_' };
                arInfo1 = info1.Split(splitter1);
                for (int x1 = 0; x1 < arInfo1.Length; x1++)
                {
                    strStartVal1 = arInfo1[0];
                    Session["FinYearStart1"] = strStartVal1;
                    Session["FinYear1"] = strStartVal;
                    strEndVal1 = arInfo1[1];
                    Session["FinYearEnd1"] = strEndVal1;
                }
            }
        }
    }

}

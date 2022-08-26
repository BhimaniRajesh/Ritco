using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for DriverBalance
/// </summary>
public class DriverBalance
{
	public DriverBalance()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string GetDriverBalanceAmt(string DriverCode, string TranDt)
    {
        string NewBalamt = "0.00";

        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //HttpContext.Current.Session["SqlProvider"].ToString().Trim()


        //------------------------------------------------------------

        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(HttpContext.Current.Session["SqlProvider"]));
        string mYearVal = "";
        //if (HttpContext.Current.Session["FinYear_Change"] != null)
        //{
        //    mYearVal = HttpContext.Current.Session["FinYear_Change"].ToString().Trim();
        //}
        mYearVal = objFinYear.FinancialYear();
        string mFinYear = "";
        string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
        SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, conn);
        sqlcmdFinYear.CommandType = CommandType.Text;
        SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
        if (drFinYear.Read())
        {
            mFinYear = drFinYear["YearVal"].ToString().Trim();
        }
        drFinYear.Close();

        //SELECT * FROM Webx_Fleet_Trip_Expense_Master where Code_Type='OEXP' and Code_Id='02'

        string mDB_AccCode = "";
        string sqlDB = "SELECT AccCode FROM Webx_Fleet_Trip_Expense_Master where Code_Type='OEXP' and Code_Id='02'";
        SqlCommand sqlcmdDB = new SqlCommand(sqlDB, conn);
        sqlcmdDB.CommandType = CommandType.Text;
        SqlDataReader drDB = sqlcmdDB.ExecuteReader();
        if (drDB.Read())
        {
            mDB_AccCode = drDB["AccCode"].ToString().Trim();
        }
        drDB.Close();


        string mFromDt = "01 Apr " + mFinYear.ToString();
        string mToDt = TranDt;

        //string DrverSQL = "WebxNet_GeneralLedger_RS_WISE '" + mFromDt + "','" + mToDt + "','Y','" + mYearVal + "','LIA0057','All','All','" + mDriverId1  + "','HQTR','1',1,5000000,'CL'";
        //string DrverSQL = "WebxNet_GeneralLedger_RS_WISE";
        string DrverSQL = "WebxNet_GeneralLedger_RS_WISE_DriverBalance";

        SqlCommand sqlcmdDrver = new SqlCommand(DrverSQL, conn);
        sqlcmdDrver.CommandType = CommandType.StoredProcedure;

        sqlcmdDrver.Parameters.AddWithValue("@from_date", mFromDt);
        sqlcmdDrver.Parameters.AddWithValue("@to_date", mToDt);
        sqlcmdDrver.Parameters.AddWithValue("@Cumilative", "Y");
        sqlcmdDrver.Parameters.AddWithValue("@Fin_Year", mYearVal);
        //sqlcmdDrver.Parameters.AddWithValue("@accode", "LIA0057");
        sqlcmdDrver.Parameters.AddWithValue("@accode", mDB_AccCode.ToString());
        sqlcmdDrver.Parameters.AddWithValue("@groupcode", "All");
        sqlcmdDrver.Parameters.AddWithValue("@category", "All");
        sqlcmdDrver.Parameters.AddWithValue("@CUST_EMP_VEND_CD", DriverCode);
        sqlcmdDrver.Parameters.AddWithValue("@brcd", "HQTR");
        //sqlcmdDrver.Parameters.AddWithValue("@RPT", "1");
        sqlcmdDrver.Parameters.AddWithValue("@RPT", "1");
        sqlcmdDrver.Parameters.AddWithValue("@Page", 1);
        sqlcmdDrver.Parameters.AddWithValue("@PageSize", 5000000);
        sqlcmdDrver.Parameters.AddWithValue("@TYPE", "CL");

        SqlDataReader drDrver = sqlcmdDrver.ExecuteReader();
        string Driver_Debit = "", Driver_Credit = "", DriverBalance = ""; ;
        if (drDrver.Read())
        {
            Driver_Debit = drDrver["Debit"].ToString().Trim();
            Driver_Credit = drDrver["Credit"].ToString().Trim();

            if (Driver_Debit == "0.00")
            {
                DriverBalance = Driver_Credit + " CR";
            }

            if (Driver_Credit == "0.00")
            {
                DriverBalance = Driver_Debit + " DR";
            }
            //LblDriverBalance.Text = DriverBalance;
            NewBalamt = DriverBalance;
        }
        drDrver.Close();
        conn.Close();


        //------------------------------------------------------------





        if (NewBalamt == null) NewBalamt = "";
        return NewBalamt;


    }
}

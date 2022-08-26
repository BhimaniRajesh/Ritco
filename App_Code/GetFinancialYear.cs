using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using ApplicationManager;
/// <summary>
/// Summary description for GetFinancialYear
/// </summary>
public class GetFinancialYear : DataAccessLayer 
{
    private string _Connection_String;

    public GetFinancialYear(string ConnectionString) : base(ConnectionString) 
	{
        _Connection_String = ConnectionString;
	}   
    public string FinancialYear()
    {
        string strFinYear = "";
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, "SELECT DBO.FINANCIAL_YEAR('" + SessionUtilities.FinYear.ToString().Trim() + "') AS FINANCIAL_YEAR");
        if (dt.Rows.Count > 0)
        {
            strFinYear = dt.Rows[0]["FINANCIAL_YEAR"].ToString();
        }
        return strFinYear;
    }
}

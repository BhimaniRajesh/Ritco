using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for FuelAccounting
/// </summary>
public class FuelAccounting : DataAccessLayer
{

    #region Private Declaration
    private string _Connection_String,_BillNo;
    #endregion
    #region Properties
    public string BillNo { get { return _BillNo; } set { _BillNo = value; } }
    #endregion
    public FuelAccounting(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}

    /// <summary>
    /// GENERATE BILL NO IN CASE OF Fuel Accounting
    /// </summary>
    /// <param name="Brcd"></param>
    /// <param name="Finyear"></param>
    public void GENERATE_BILLNO(string Brcd, string Finyear)
    {

        DataTable dt = new DataTable();
        string SQL = "EXEC USP_GEN_BILLNO '" + Brcd + "','" + Finyear + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);
        if (dt.Rows.Count > 0)
        {
            BillNo = dt.Rows[0]["BILLNO"].ToString();
        }
        else
        {
            BillNo = "";
        }
    }
}
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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using Microsoft.ApplicationBlocks.Data;

/// <summary>
/// Summary description for Octroi
/// </summary>
public class Octroi
{
	public Octroi()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void BillEntryBindGrid(GridView GridDocList, string Fromdate, string Todate, string Vendorcode, string Billno, string VendorBillno)
    {
        string Sql = "EXEC usp_Bill_Listing '" + Billno + "','" + Vendorcode + "','" + Fromdate + "','" + Todate + "','" + SessionUtilities.CurrentBranchCode + "','" + VendorBillno + "','OCT'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        GridDocList.DataSource = ds;
        GridDocList.DataBind();
    }
    public static string Insert_BillEntry_Payment_Data(string Xml_PAY_MST, string Xml_PAY_Det, string EntryType)
    {
        string Voucherno = "";
        string Sql = "";
        Sql = "EXEC [Usp_Octroi_BillEntry_Payment] '" + SessionUtilities.CurrentBranchCode + "','" + Xml_PAY_Det + "','" + Xml_PAY_MST + "','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
        SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (DR.Read())
        {
            Voucherno = DR[0].ToString() + "~" + DR[1].ToString();
        }
        DR.Close();
        return Voucherno;
    }
    public static void VoucherView(GridView GridDocList, string Voucherno, string VoucherType)
    {
        string Sql = "EXEC [Usp_View_Octroi_PaymentVoucher] 'OctroiBillPayment','" + Voucherno + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        GridDocList.DataSource = ds;
        GridDocList.DataBind();
    }
}

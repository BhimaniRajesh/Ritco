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

public partial class GUI_Operations_DRS_DRSUpdateResult : System.Web.UI.Page
{
    public static string DRSCode = "";

    public static string drsDate = "";
    public static string deliveredBy = "";
    public static string ba_staff = "";
    public static string driverName = "";
    public static string vehicleno = "";
    public static string totalDkts = "";
    public static string startKM = "";
    public static string closeKM = "";
    public static string Updated = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        DRSCode = Request.QueryString["DRSCode"].ToString().Trim();
        GetDRSHeaderInfo();
    }


    protected void GetDRSHeaderInfo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        string strSQL = "Exec  usp_DRS_Summary '" + DRSCode + "'";
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlCommand.CommandType = CommandType.Text;
        SqlDataReader dr = sqlCommand.ExecuteReader();
        while (dr.Read())
        {
            drsDate = dr["PDC_Dt"].ToString().Trim();
            deliveredBy = dr["deliveryBy"].ToString().Trim();

            ba_staff = dr["Staff"].ToString().Trim().ToUpper();
            if (deliveredBy.ToUpper().Trim() == "BA")
            {
                ba_staff = dr["BA_Vendor_Code"].ToString().Trim().ToUpper();
            }
            driverName = dr["DriverName"].ToString().Trim().ToUpper();
            vehicleno = dr["VEHNO"].ToString().Trim().ToUpper();
            totalDkts = dr["Total_Dockets_In_DRS"].ToString().Trim();
            startKM = dr["Start_KM"].ToString().Trim();
            closeKM = dr["CloseKM"].ToString().Trim();
            Updated = dr["PDC_Updated"].ToString().Trim();
        }
        dr.Close();
    }
}

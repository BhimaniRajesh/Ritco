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


public partial class GUI_Operations_DRS_UpdateDRS : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;

    public static string drsCode = "";
    public static string drsDate = "";
    public static string deliveredBy = "";
    public static string ba_staff = "";
    public static string driverName = "";
    public static string vehicleno = "";
    public static string totalDkts = "";
    public static string startKM = "";
    public static string Updated = "";

    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();
    DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        dtToday = DateTime.Now.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        MySQLDataSource_DelyReasons.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (!IsPostBack)
        {
            hDRS.Value = Request.QueryString["DRSCode"];
        }

        drsCode = hDRS.Value.Trim();

        if (!IsPostBack)
        {
            GetDRSHeaderInfo();
            if (Updated == "Yes")
            {
                btnUpdateDRS.Text = "<< DRS already updated >>";
                btnUpdateDRS.Enabled = false;
            }
            ShowDocketsInDRS();
            txtCloseKM.Focus();
        }
    }

    protected void GetDRSHeaderInfo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        string strSQL = "Exec  usp_DRS_Summary '" + hDRS.Value.Trim() + "'";
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
            Updated = dr["PDC_Updated"].ToString().Trim();
        }
        dr.Close();
    }

    //protected string GetControlName(string repeaterName, string txtBoxName, int DataItemIndex)
    //{
    //    return "ctl00_MyCPH1_" + repeaterName.Trim() + "_ctl" + (DataItemIndex > 9 ? "" : "0") + DataItemIndex.ToString() + "_" + txtBoxName.Trim();
    //}


    protected void ShowDocketsInDRS()
    {

        SetDataSet();
        rptDocketList.DataSource = ds;
        rptDocketList.DataBind();
    }

    protected void UpdateDRS(object sender, EventArgs e)
    {
        //for (int i = 0; i < rptDocketList.Items.Count; i++)
        //{

        //}
        //Response.Redirect("~/GUI/Welcome.aspx");
    }

    protected void SetDataSet()
    {
        int RecFound = 0;

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_dockets_for_drs_updation";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        sqlCmd.Parameters.AddWithValue("@pdcno", drsCode.Trim());

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;
        hDktsInDRS.Value = RecFound.ToString().Trim();
        //tblSubmitBtn.Visible = true;
        if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
        {
            //tblSubmitBtn.Visible = false;
        }

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------
    }
}

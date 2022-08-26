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


public partial class GUI_Operations_THC_THCDepartureSubmit : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;

    public static string THCNo = "";
    public static DateTime THCDate;
    public static string THCDateStr = "";
    public static string vehicleno = "";
    public static string Route = "";
    public static DateTime ATA;
    public static string ATADate;
    public static string ATATime;
    public static DateTime ETD;
    public static string ETDDate;
    public static string ETDTime;
    public static string DepartingTo = "";


    public static string xmlTC = "";

    public static string brcd = "";

    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();
    DataSet ds = new DataSet();

    public bool departed = false;    
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
        if (!IsPostBack)
        {
            hTHCNo.Value = Request.QueryString["THCNO"];
            hBrCd.Value = Request.QueryString["BRCD"];
        }

        THCNo = hTHCNo.Value.Trim();
        brcd = hBrCd.Value.Trim();
        MySQLDataSource_MFAvailable.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (!IsPostBack)
        {
            hSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
            hATADate.Value = ATADate;
            hATATime.Value = ATATime;
            txtATD.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtHHMM.Text = DateTime.Now.ToString("HH:mm");
            txtEmpCode.Text = Session["empcd"].ToString().Trim();

            txtVFS.Text = "0";
            GetTHCInfo();
            if (departed)
            {
                btnDepartTHC.Text = "<< THC Already Departed >>";
                btnDepartTHC.Enabled = false;
            }
        }
    }

    protected void DepartTHC(object sender, EventArgs e)
    {
        GenerateXML();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";


        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_do_THC_Departure";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@thcno", SqlDbType.VarChar).Value = THCNo.Trim(); 
        sqlCmd.Parameters.Add("@deptdt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtATD.Text, dtfi);
        sqlCmd.Parameters.Add("@depttm", SqlDbType.Text).Value = txtHHMM.Text.Trim();
        sqlCmd.Parameters.Add("@sealno", SqlDbType.Text).Value = txtSeal.Text.Trim();
        sqlCmd.Parameters.Add("@outremark", SqlDbType.Text).Value = txtOutgoingRemarks.Value.Trim();
        sqlCmd.Parameters.Add("@empcd", SqlDbType.VarChar).Value = txtEmpCode.Text.Trim();
        sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = hBrCd.Value; //Session["brcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@xmlData", SqlDbType.Text).Value = xmlTC.Trim();

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //string THCCodeGenerated = "";
        //string Tranzaction = "";

        //THCCodeGenerated = ds.Tables[0].Rows[0]["THCNo"].ToString();
        //Tranzaction = ds.Tables[0].Rows[0]["TranXaction"].ToString().Trim();

        Response.Redirect("THCDepartureResult.aspx");
    }

    protected void GenerateXML()
    {
        xmlTC = "<root>";
        for (int index = 0; index < dgMFs.Rows.Count; index++)
        {
            CheckBox chkMFs = (CheckBox)dgMFs.Rows[index].FindControl("chkMF");

            if (chkMFs.Checked == true)
            {
                xmlTC = xmlTC + "<tc>" +
                                      "<TCNO>" + dgMFs.DataKeys[index].Values[0].ToString().Trim() + "</TCNO>" +
                                      "<THCNO>" + THCNo.Trim() + "</THCNO>" +
                "</tc>";
            }
        }
        xmlTC = xmlTC + "</root>";
    }
    protected void GetTHCInfo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        string strSQL = "Exec  usp_THC_For_Departure_Summary '" + hTHCNo.Value.Trim() + "','" + hBrCd.Value.Trim() + "'";
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlCommand.CommandType = CommandType.Text;
        SqlDataReader dr = sqlCommand.ExecuteReader();
        while (dr.Read())
        {
            THCDate = (DateTime)dr["THCDT"];
            THCDateStr = THCDate.ToString("dd/MM/yyyy");
            vehicleno = dr["VEHNO"].ToString().Trim().ToUpper();
            Route = dr["Route"].ToString().Trim().ToUpper();
            ATA = (DateTime)dr["ATA"];
            ATADate = ATA.ToString("dd/MM/yyyy");
            ATATime = ATA.ToString("HH:mm");

            ETD = (DateTime)dr["ETD"];
            ETDDate = ETD.ToString("dd/MM/yyyy");
            ETDTime = ETD.ToString("HH:mm");
            DepartingTo = dr["tobh_code"].ToString().Trim().ToUpper();
        }
        dr.Close();

        if (THCDateStr == "") { departed = true; }
    }

}

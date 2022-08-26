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

public partial class GUI_Operations_DRS_DRSUpdateMain : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;
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
        
        //if(!IsPostBack)   BindGrid();
    }

    protected void ShowDRSForUpdate(object sender, EventArgs e)
    {
        BindGrid();
    }

    protected void PassSelectedDRSForUpdate(object sender, EventArgs e)
    {
        Response.Redirect("UpdateDRS.aspx?DRSCode=" + hDRSSelected.Value);
    }

    protected void BindGrid()
    {

        SetDataSet();
        dgDRS.DataSource = ds;
        dgDRS.DataBind();
    }

    protected void SetDataSet()
    {
        int RecFound = 0;

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        FromToDateProc();


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        string sql = "usp_drs_for_updation";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        sqlCmd.Parameters.AddWithValue("@pdclist", txtDRSList.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@pdcdtfrom", dtFrom );
        sqlCmd.Parameters.AddWithValue("@pdcdtto", dtTo);
        sqlCmd.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;

        tblDRSList.Visible = true;
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

    protected void FromToDateProc()
    {
        //int RecFound = 0;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        //From - To Date Range
        if (hDateRange.Value=="0")
        {
            try
            {
                dtFrom = Convert.ToDateTime(txtFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtTo.Text, dtfi);
            }
            catch (Exception ex)
            {
                //radToday.Checked = true;
                dtFrom = Convert.ToDateTime(dtToday, dtfi);
                dtTo = Convert.ToDateTime(dtToday, dtfi);

            }
        }
        //--------------------------------

        //Today Date
        if (hDateRange.Value == "1")
        {
            dtFrom = Convert.ToDateTime(dtToday, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Last Week Date
        if (hDateRange.Value == "2")
        {
            string dt2Str;

            dt2 = DateTime.Now.AddDays(-6);
            dt2Str = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();

            dtFrom = Convert.ToDateTime(dt2Str, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Till Date
        if (hDateRange.Value == "3")
        {
            dtFrom = Convert.ToDateTime("01/01/2000");
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------
    }
}

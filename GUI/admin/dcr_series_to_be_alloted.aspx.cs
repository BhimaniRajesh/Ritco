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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_dcr_series_to_be_alloted : System.Web.UI.Page
{
    public static string dtToday="";
    public static string dtLastWeek = "";

    public static DateTime dt1, dt2;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        dtToday = DateTime.Now.Day.ToString() + '/' +  DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        if (!Page.IsPostBack)
        {
            BindBusinessType();
            BindRepeater(null,null);            
        }
    }

    protected void BindRepeater(object sender, EventArgs e)
    {
        int RecFound = 0;

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        //From - To Date Range
        if (radFromToDate.Checked)
        {
            try
            {
                dtFrom = Convert.ToDateTime(txtFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtTo.Text, dtfi);
            }
            catch (Exception ex)
            {
                radToday.Checked = true;
            }
        }
        //--------------------------------

        //Today Date
        if (radToday.Checked)
        {
            dtFrom = Convert.ToDateTime(dtToday, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------

        
        //Last Week Date
        if (radLastWeek.Checked)
        {
            string dt2Str;

            dt2 = DateTime.Now.AddDays(-6);
            dt2Str = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();

            dtFrom = Convert.ToDateTime(dt2Str, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Till Date
        if (radTillDate.Checked)
        {
            dtFrom = Convert.ToDateTime("01/01/1900");
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------

        
        //Make & Open Connection
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        //--------------------------------

        string sql = "usp_Series_ToBe_Alloted";
        SqlCommand sqlCmd = new SqlCommand(sql,sqlConn);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@dcr_date_from", SqlDbType.DateTime).Value = dtFrom;
        sqlCmd.Parameters.Add("@dcr_date_to", SqlDbType.DateTime).Value = dtTo;
        sqlCmd.Parameters.Add("@alloted_by", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();

        int busType = Convert.ToInt32(ddlBusType.SelectedValue);
        if (busType > 0)
            sqlCmd.Parameters.Add("@bus_type", SqlDbType.Int).Value = busType;
        else
            sqlCmd.Parameters.Add("@bus_type", SqlDbType.Int).Value = DBNull.Value;

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Close Connection
        sqlConn.Close();
        sqlConn = null;
        //--------------------------------

        ds.DataSetName = "dsn_DCRSeries";
        ds.Tables[0].TableName = "tbl_DCRSeries";

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;
        
        NoRecFound.Visible = false;
        if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
        {
            NoRecFound.Visible = true;
        }

        DataTable dt = new DataTable();
        DataRow dr;

        dt.Columns.Add("BookCode", typeof(string));
        dt.Columns.Add("DOC_SR_FROM", typeof(string));
        dt.Columns.Add("DOC_SR_TO", typeof(string));
        dt.Columns.Add("TOT_LEAF", typeof(string));
        dt.Columns.Add("DCR_Date", typeof(string));
        dt.Columns.Add("DOC_KEY", typeof(string));
        dt.Columns.Add("BUSINESS_TYPE", typeof(string));

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();
            dr["BookCode"] = drRows["BookCode"].ToString().Trim();
            dr["DOC_SR_FROM"] = drRows["DOC_SR_FROM"].ToString().Trim();
            dr["DOC_SR_TO"] = drRows["DOC_SR_TO"].ToString().Trim();
            dr["TOT_LEAF"] = drRows["TOT_LEAF"].ToString().Trim();
            dr["DCR_Date"] = drRows["DCR_Date"].ToString().Trim();
            dr["DOC_KEY"] = drRows["DOC_KEY"].ToString().Trim();
            dr["BUSINESS_TYPE"] = drRows["BUSINESS_TYPE"];

            dt.Rows.Add(dr);
        }

        rptSeriesList.DataSource = dt;
        rptSeriesList.DataBind();

        SeriesList.Visible = true;
        rptSeriesList.Visible = true;
    }

    private void BindBusinessType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = SqlHelper.ExecuteDataset(conn, CommandType.Text, "SELECT CodeId, CodeDesc FROM webx_master_general WHERE CodeType='BUT'");
        ddlBusType.DataSource = ds;
        ddlBusType.DataTextField = "CodeDesc";
        ddlBusType.DataValueField = "CodeId";
        ddlBusType.DataBind();
        ddlBusType.Items.Insert(0, new ListItem("ALL", "0"));
        ddlBusType.SelectedIndex = 0;
    }
}

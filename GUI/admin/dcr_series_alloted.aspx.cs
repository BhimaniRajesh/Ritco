using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_DCR_Series_Alloted : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;

    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
        
        this.Title = pagetitle;
        
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        dtToday = DateTime.Now.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.ToString("dd/MM/yyyy");// dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        hdtToday.Value = dtToday;
        hdt2.Value = dt2.ToString("dd/MM/yyyy");
        hdt1.Value = dt1.ToString("dd/MM/yyyy");
        hdt.Value = "01/01/2000";

        if (!IsPostBack)
        {
            BindBusinessType();
        }
        //SqlDataSource1.SelectCommand = "Exec usp_DCR_Series_ForReDeAllocate '01 January 1990','" + dt1.ToString("dd MMMM yyyy") + "'";
        //tblDCR.Visible = true;
        //FromToDateProc();
        //SqlDataSource1.SelectCommand = "Exec usp_DCR_Series_Alloted '" + dtFrom.ToString("dd MMMM yyyy") + "','" + dtTo.ToString("dd MMMM yyyy") + "','" + Session["brcd"].ToString().Trim() + "'";
        ////SqlDataSource1.SelectCommand = "Select * From vw_DCR_Series_ForReDeAllocate";
    }

    protected void ShowDCRs(object sender, EventArgs e)
    {
        tblDCR.Visible = true;
        FromToDateProc();

        string strCMD = "Exec usp_DCR_Series_Alloted '" + dtFrom.ToString("dd MMMM yyyy") + "','" + dtTo.ToString("dd MMMM yyyy") + "','" + Session["brcd"].ToString().Trim() + "'";
        
        int busType = Convert.ToInt32(ddlBusinessType.SelectedValue);
        if (busType > 0)
            strCMD += "," + busType.ToString();
        else
            strCMD += ",NULL";
        
        SqlDataSource1.SelectCommand = strCMD;
        //dgGeneral.DataSource = SqlDataSource1;
        //dgGeneral.DataBind();
    }


    protected void FromToDateProc()
    {
        //int RecFound = 0;
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
                //radToday.Checked = true;
                dtFrom = Convert.ToDateTime(dtToday, dtfi);
                dtTo = Convert.ToDateTime(dtToday, dtfi);

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
            dtFrom = Convert.ToDateTime("01/01/2000");
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------
    }
    private void BindBusinessType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = SqlHelper.ExecuteDataset(conn, CommandType.Text, "SELECT CodeId, CodeDesc FROM webx_master_general WHERE CodeType='BUT'");
        ddlBusinessType.DataSource = ds;
        ddlBusinessType.DataTextField = "CodeDesc";
        ddlBusinessType.DataValueField = "CodeId";
        ddlBusinessType.DataBind();
        ddlBusinessType.Items.Insert(0, new ListItem("ALL", "0"));
        ddlBusinessType.SelectedIndex = 0;
    }
}

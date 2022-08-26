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

public partial class GUI_Operations_UpdateDocketArrivalStatus_StockUpdateMain : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static string brcd = "";
    public static DateTime dt1, dt2;
    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();
    DataSet ds = new DataSet();

    string title = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        brcd = Session["brcd"].ToString().Trim();

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

    protected void ShowTHCForStockUpdate(object sender, EventArgs e)
    {
        BindGrid();
    }

    protected void PassSelectedTHCForStockUpdate(object sender, EventArgs e)
    {
        Response.Redirect("StockUpdateList.aspx?THCNO=" + hTHCSelected.Value + "&BRCD=" + Session["brcd"].ToString().Trim());
    }

    protected void BindGrid()
    {

        SetDataSet();
        dgTHC.DataSource = ds;
        dgTHC.DataBind();
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

        string sql = "usp_Stock_For_Update";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        sqlCmd.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
        sqlCmd.Parameters.AddWithValue("@thcnoCSV", txtTHCList.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@mfnoCSV", txtMFList.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@docknoCSV", txtDocketList.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@dockDestCSV", txtToHubList.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@fromDate", dtFrom);
        sqlCmd.Parameters.AddWithValue("@toDate", dtTo);

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;

        tblTHCList.Visible = true;
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
        if (hDateRange.Value == "0")
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


    protected void GVRowDB(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label titleLabel = (Label)e.Row.FindControl("lnk0");
            string strval = ((Label)(titleLabel)).Text;
            title = (string)ViewState["lnk0"];
            if (title == strval && e.Row.RowIndex>0)
            {
                titleLabel.Visible = false;
                titleLabel.Text = string.Empty;
            }
            else
            {
                title = strval;
                ViewState["lnk0"] = title;
                titleLabel.Visible = true;
                titleLabel.Text = "<b>" + title + "</b>";
            }
        }
    }

}

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
using Microsoft.ApplicationBlocks.Data;
using System.Text.RegularExpressions;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class GUI_admin_dcr_ChangeBusType_List : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;
    private string connString = "";
    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();

    private DataSet ListDCR
    {
        get
        {
            if (ViewState["ListDCR"] != null)
                return ViewState["ListDCR"] as DataSet;
            else
                return new DataSet();
        }
        set { ViewState["ListDCR"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        connString = Session["SqlProvider"].ToString().Trim();

        dtToday = DateTime.Now.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.ToString("dd/MM/yyyy");// dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        hdtToday.Value = dtToday;
        hdt2.Value = dt2.ToString("dd/MM/yyyy");
        hdt1.Value = dt1.ToString("dd/MM/yyyy");
        hdt.Value = "01/01/2000";

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        this.Title = pagetitle;

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
            BindBusinessType();

        trSubmit.Visible = true;
    }
    protected void ShowDCRs(object sender, EventArgs e)
    {
        getList();
        bindData(0);
    }

    protected void dgGeneral_PageIndexChanged(object sender, EventArgs e)
    {
    }
    protected void dgGeneral_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //dgGeneral.PageIndex = e.NewPageIndex;
        bindData(e.NewPageIndex);
    }

    private void getList()
    {
        string cmd = BuildCommand();
        ListDCR = SqlHelper.ExecuteDataset(connString, CommandType.Text, cmd);
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
                if (txtTo.Text.Trim() != "")
                    dtTo = Convert.ToDateTime(txtTo.Text, dtfi);
                else
                    dtTo = Convert.ToDateTime(dtToday, dtfi);
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
    private void bindData(int pageIndex)
    {
        dgGeneral.DataSource = ListDCR;
        dgGeneral.PageIndex = pageIndex;
        dgGeneral.DataBind();
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
    private string BuildCommand()
    {
        FromToDateProc();

        string cmd = "Exec usp_DCRSeries_ForBUTChange '" + dtFrom.ToString("dd MMMM yyyy") + " 00:00:00','" + dtTo.ToString("dd MMMM yyyy") + " 23:59:59'";

        //SrFrom,SrTo,SrList,BookCode
        if (radDocSrFrom.Checked)
        {
            if (txtDocSrFrom.Value.Trim() != "")
                cmd += ", " + txtDocSrFrom.Value.Trim();
            else
                cmd += ", NULL";

            if (txtDocSrTo.Value.Trim() != "")
                cmd += ", " + txtDocSrTo.Value.Trim();
            else
                cmd += ", NULL";

            cmd += ", NULL";
        }
        else if (radDecSrContains.Checked)
        {
            string strDocNos = txtDecSrContains.Value.Trim();
            try
            {
                if (strDocNos != "")
                {
                    strDocNos = "'" + strDocNos + "'";
                    strDocNos = Regex.Replace(strDocNos, "\\s.*,\\s*", ",");
                }
                else
                    strDocNos = "NULL";
            }
            catch (Exception ex)
            {
                strDocNos = "NULL";
            }
            cmd += ", NULL, NULL ," + strDocNos;
        }

        string strBC = txtBookCode.Text.Trim();
        if (strBC != "")
        {
            try
            {
                strBC = "'" + strBC + "'";
                strBC = Regex.Replace(strBC, "\\s*,\\s*", ",");
            }
            catch (Exception ex)
            {
                strBC = "NULL";
            }
        }
        else
            strBC = "NULL";

        cmd += ", " + strBC;

        int busTypeId = Convert.ToInt32(ddlBusinessType.SelectedValue);
        if (busTypeId > 0)
            cmd += "," + busTypeId.ToString();
        else
            cmd += ",NULL";

        return cmd;
    }   
}

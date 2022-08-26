using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using Microsoft.ApplicationBlocks.Data;
using System.IO;

public partial class GUI_ReAllocateUnusedSeries : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;
    private string connString = "", currBranch="";
    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();

    private DataSet ListDCR
    {
        get
        {
            if (ViewState["DCRList"] != null)
                return ViewState["DCRList"] as DataSet;
            else
                return new DataSet();
        }
        set { ViewState["DCRList"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        connString = Session["SqlProvider"].ToString().Trim();
        currBranch = Session["brcd"].ToString().Trim();
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

        if (!IsPostBack && !IsCallback)
        {
            BindBusinessType();
            btnExport.Visible = false;
        }
        
        trSubmit.Visible = true;
        SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();        
        string cmd = BuildCommand();
        SqlDataSource1.SelectCommand = cmd;
        if (!IsPostBack && !IsCallback)
        {
            BindData();
        }
    }

    protected void BindData()
    {
        this.dgGeneral.PageIndex = 0;
        this.dgGeneral.DataBind();
        if(dgGeneral.Rows.Count > 0)
            btnExport.Visible = true;
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

    protected void ShowDCRs(object sender, EventArgs e)
    {
        //Data will be bind at page Load
        //string cmd = BuildCommand();
        //ListDCR = SqlHelper.ExecuteDataset(connString, CommandType.Text, cmd);
        BindData();
        ViewHideExport();        
    }

    private void ViewHideExport()
    {
        if (dgGeneral.Rows.Count > 0)
            btnExport.Visible = true;
        else
            btnExport.Visible = false;
        //if (ListDCR.Tables.Count > 0)
        //{
        //    if (ListDCR.Tables[0].Rows.Count > 0)
        //    {
        //        btnExport.Visible = true;
        //    }
        //    else
        //        btnExport.Visible = false;
        //}
        //else
        //    btnExport.Visible = false;
    }
    private string BuildCommand()
    {
        FromToDateProc();

        string cmd = "Exec usp_DCR_UnusedSeries_ForReAllote '" + dtFrom.ToString("dd MMMM yyyy") + " 00:00:00','" + dtTo.ToString("dd MMMM yyyy") + " 23:59:59'";
       
        //SrFrom,SrTo,SrList,BookCode
        if (radDocSrFrom.Checked)
        {
            if (txtDocSrFrom.Value.Trim() != "")
                cmd += ", '" + txtDocSrFrom.Value.Trim() + "'";
            else
                cmd += ", NULL";

            if (txtDocSrTo.Value.Trim() != "")
                cmd += ", '" + txtDocSrTo.Value.Trim() + "'";
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

        if (currBranch.ToUpper() == "HQTR")
            cmd += ",NULL";
        else
            cmd += ",'" + currBranch + "'";
        return cmd;
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

    protected void btnExport_Click(object sender, EventArgs e)
    {
        string folder = Server.MapPath("~/GUI/Images/TEMP");
        string filename = "SeriesForReOrDe-Allotement.xls";
        string fullpath = folder + "\\" + filename;

        //if (ListDCR.Tables.Count > 0)
        //{
        //    if (ListDCR.Tables[0].Rows.Count > 0)
        //    {
        //        ExportDataSetToXLS.exportToExcel(ListDCR, fullpath);
        //        Response.Redirect("~/GUI/Images/TEMP/" + filename);
        //    }
        //}
     
        dgGeneral.AllowPaging = false;
        dgGeneral.BorderStyle = BorderStyle.Solid;
        dgGeneral.Columns[0].Visible = false;
        dgGeneral.Columns[1].Visible = false;
        System.Drawing.Color myColor = System.Drawing.ColorTranslator.FromHtml("#d4e0e7");
        for (int i = 0; i < dgGeneral.Columns.Count; i++)
        {
            dgGeneral.Columns[i].HeaderStyle.BackColor = myColor;
        }
        dgGeneral.DataBind();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + filename);
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgGeneral);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
}

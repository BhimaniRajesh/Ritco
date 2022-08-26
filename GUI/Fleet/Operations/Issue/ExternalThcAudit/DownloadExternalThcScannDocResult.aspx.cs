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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_DownloadExternalThcScannDocResult : System.Web.UI.Page
{
    public string DateType,  fromdt, todt,   St_paylist, st_trnlist, st_delist, st_mode, st_status;
    public string ExternalThcNo, dtFrom, dtTo;
    private DateFunction df = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        ExternalThcNo = Convert.ToString(Request.QueryString["ExternalThcNo"]);

        lblExternalThcNo.Text = ExternalThcNo;
        lblDt.Text = Convert.ToDateTime(df.returnmmddyyyy_format(fromdt)).ToString("dd MMM yy") + " - " + Convert.ToDateTime(df.returnmmddyyyy_format(todt)).ToString("dd MMM yy");
        BindGrid();
    }

    public void BindGrid()
    {
        if (ExternalThcNo == "")
        {
            dtFrom = Convert.ToDateTime(df.returnmmddyyyy_format(fromdt)).ToString("dd MMM yy");
            dtTo = Convert.ToDateTime(df.returnmmddyyyy_format(todt)).ToString("dd MMM yy");
        }

        string sql_st = "exec Webx_FleetExternalThc_DownloadScaneDocument '" + dtFrom + "','" + dtTo + "','" + ExternalThcNo + "'";    
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql_st);
        dgExternalThc.DataSource = ds;
        dgExternalThc.DataBind();
        dgExternalThc.Visible = true;
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgExternalThc.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void dgDocket_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DownloadFile(object sender, EventArgs e)
    {
        string filePath = (sender as LinkButton).CommandArgument;
        string filePaths = Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages/Ritco" + "//" + filePath);
        Response.ContentType = ContentType;
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePaths));
        Response.WriteFile(filePaths);
        Response.End();
    }
}
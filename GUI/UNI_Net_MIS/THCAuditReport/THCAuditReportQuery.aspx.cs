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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_Operations_THCAudit_THCAuditReportQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DT.EnableTillDate = true;

        if (!IsPostBack) {
            cboLoc.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_locations_all_ver1").Tables[0];
            cboLoc.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string report_mode = "", final="";

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");

        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";

        }
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Tilldate";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString();
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
       
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        final += "?FromDate=" + dtFrom;
        final += "&ToDate="+ dtTo;
        final += "&ThcNo="+txtTHCno.Text.Trim();
        final += "&Status=" + ddlStatus.SelectedValue;
        final += "&Location=" + cboLoc.SelectedValue;

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("window.open('./THCAuditReportResult.aspx" + final + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");

        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }
        //Response.Redirect("THCAuditReportResult.aspx" + final);
    }
}

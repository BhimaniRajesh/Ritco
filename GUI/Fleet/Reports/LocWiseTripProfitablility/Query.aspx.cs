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

public partial class GUI_UNI_Net_MIS_Trip_Profitablility_Report_Query : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 20/5/2014
            txtLocs.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            BindCheckBox();
        }
    }
    protected void btnShow2_Click(object sender, EventArgs e)
    {
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        string QStrig = "Result.aspx";
        if (ddlDocType.SelectedValue == "1")
            QStrig += "?TSNo=" + txtDocNo.Text.Trim();
        else
            QStrig += "?TSNo=";
        if (ddlDocType.SelectedValue == "2")
            QStrig += "&VHNo=" + txtDocNo.Text.Trim();
        else
            QStrig += "&VHNo=";
        QStrig += "&FDT=";
        QStrig += "&TDT=";
        QStrig += "&PSTS=";
        QStrig += "&MRF=";
        QStrig += "&MRT=";
        QStrig += "&RO=ALL";
        QStrig += "&LO=ALL";
        QStrig += "&LO_List=" + txtLocs.Text;
        QStrig += "&Company_Code=ALL";
        QStrig += "&hdnRptId=" + hdnRptId.Value.ToString();  // added by Manisha 29/4/2014

        Response.Redirect(QStrig, false);
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        string QStrig = "Result.aspx";
        QStrig += "?TSNo=";
        QStrig += "&VHNo=";
        QStrig += "&FDT=" + dtFromTo.DateFrom.ToString("dd MMM yy");
        QStrig += "&TDT=" + dtFromTo.DateTo.ToString("dd MMM yy");
        QStrig += "&PSTS=" + ddlProfStatus.SelectedValue;        
        QStrig += "&MRF=";
        if (txtMRFrom.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRFrom.Text.Trim();
        QStrig += "&MRT=";
        if (txtMRTo.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRTo.Text.Trim();
        //QStrig += "&RO="+lhLoc.SelectedRO;
        //QStrig += "&LO="+lhLoc.SelectedLocation;
        QStrig += "&RO=ALL";
        QStrig += "&LO=ALL";
        QStrig += "&LO_List=" + txtLocs.Text;
        QStrig += "&Company_Code=ALL";
        QStrig += "&hdnRptId=" + hdnRptId.Value.ToString();  // added by Manisha 29/4/2014

        Response.Redirect(QStrig, false);
    }

    private void BindCheckBox()
    {
        string strQ = "SELECT LocCode, LocName FROM dbo.webx_location WHERE LocCode IN (SELECT DISTINCT TripSheet_StartLoc FROM dbo.WEBX_FLEET_VEHICLE_ISSUE) AND ISNULL(ActiveFlag,'N')='Y'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        chklstLocation.DataSource = ds;
        chklstLocation.DataValueField = "LocCode";
        chklstLocation.DataTextField = "LocCode";
        chklstLocation.DataBind();               
    }
}

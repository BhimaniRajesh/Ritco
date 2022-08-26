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

public partial class GUI_UNI_Net_MIS_Trip_Profitablility_Report_Query : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {

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
        QStrig += "&PSTS=" + ddlProfStatus.SelectedValue;
        QStrig += "&MRF=";
        QStrig += "&MRT=";
        QStrig += "&Company_Code=" + company.SelectedValue;
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
        QStrig += "&Company_Code=" + company.SelectedValue;
        Response.Redirect(QStrig, false);
    }    
}

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
        if (!IsPostBack)
        {

            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 20/5/2014

 
        }
    }
    protected void btnShow2_Click(object sender, EventArgs e)
    {
        //string QStrig = "Result.aspx";
		string QStrig = "";
        if (ddlDocType.SelectedValue == "1")
            QStrig += "?TSNo=" + txtDocNo.Text.Trim();
        else
            QStrig += "?TSNo=";
        if (ddlDocType.SelectedValue == "2")
            QStrig += "&VHNo=" + txtDocNo.Text.Trim();
        else
            QStrig += "&VHNo=";
        QStrig += "&FDT=" + dtFromTo.DateFrom.ToString("dd MMM yy");
        QStrig += "&TDT=" + dtFromTo.DateTo.ToString("dd MMM yy");
        QStrig += "&PSTS=" + ddlProfStatus.SelectedValue;
        if (txtMRFrom.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRFrom.Text.Trim();
        QStrig += "&MRT=";
        if (txtMRTo.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRTo.Text.Trim();
        QStrig += "&DD=" + ddlDate.SelectedValue;
        //QStrig += "&FDT=";
        //QStrig += "&TDT=";
        //QStrig += "&PSTS=";
       // QStrig += "&MRF=";
       // QStrig += "&MRT=";
        QStrig += "&hdnRptId=" + hdnRptId.Value.ToString();  // added by Manisha 29/4/2014

        //Response.Redirect(QStrig, false);
		
		
        //Response.Redirect("Result.aspx" + final);
		  System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("function NoConfirm()");
        sb.Append("{");
        sb.Append("win = top;");
        sb.Append("win.opener = top;");
        sb.Append("win.close ();");
        sb.Append("}");
        sb.Append("window.open('./Result.aspx" + QStrig + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");
        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        //string QStrig = "Result.aspx";
		string QStrig = "";
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
        QStrig += "&DD=" + ddlDate.SelectedValue;
        QStrig += "&hdnRptId=" + hdnRptId.Value.ToString();  // added by Manisha 29/4/2014
        //Response.Redirect(QStrig, false);
		
		
        //Response.Redirect("Result.aspx" + final);
		  System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("function NoConfirm()");
        sb.Append("{");
        sb.Append("win = top;");
        sb.Append("win.opener = top;");
        sb.Append("win.close ();");
        sb.Append("}");
        sb.Append("window.open('./Result.aspx" + QStrig + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");
        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }
    }
    
}

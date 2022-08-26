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

public partial class GUI_UNI_Net_MIS_PODReports_Query : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnRptId.Value = Convert.ToString(Request.QueryString["RPTID"]); // added by Manisha 23/5/2014

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        string st_ro = cboRO.SelectedValue.ToString();
        if (cboRO.SelectedValue.ToString() == "")
        {
            st_ro = "All";
        }

        string st_lo = cboLO.SelectedValue.ToString();
        if (cboLO.SelectedValue.ToString() == "")
        {
            st_lo = "All";
        }


        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
            report_mode = "Date";
        if ((rb2.Items[1].Selected))
            report_mode = "Week";
        if ((rb2.Items[2].Selected))
            report_mode = "Today";

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
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
            strrightnow = righnow.ToString("dd/MM/yyyy");

        if (strrightnow1 == "")
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string strDocNo = string.Empty;
        string strDocBill = string.Empty;




        
        string final = string.Empty;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;
        final += "&CustomerCode=" + hdnCust.Value.ToString();
        final += "&Orgin=" + hdnOrigin.Value;
        final += "&Destination=" + hdnDestination.Value;
        final += "&Type=" + rbType.SelectedItem.Value;
        final += "&Aging=" + DDLAgingList.SelectedValue;
        final += "&Status=" + ddlStatus.SelectedValue;

        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 23/5/2014

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");

        sb.Append("function NoConfirm()");
        sb.Append("{");
        sb.Append("win = top;");
        sb.Append("win.opener = top;");
        sb.Append("win.close ();");
        sb.Append("}");
        if (rbType.SelectedItem.Value == "R") {
            sb.Append("window.open('./ResultRegister.aspx" + final + "', '_blank',");
        }
        else
        {
            sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
        }

        sb.Append("'top=0, left=0, width=1000, height=750, scrollbars=no, menubar=no,toolbar=no,status=1,resizable=yes');");

        sb.Append("<");
        sb.Append("/script>");

        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }

    }
}

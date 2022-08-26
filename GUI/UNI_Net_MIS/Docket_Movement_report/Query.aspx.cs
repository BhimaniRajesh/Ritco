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

public partial class GUI_Operations_Enroute_Status_Update_Vehicle_Movement_Report_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 26/5/2014
            optselect.Items[0].Text = SessionUtilities.DocketCalledAs + " Number";
            applySettings();
            trPL_1.Style["display"] = "none";
            trPL_2.Style["display"] = "none";
        }
    }
    protected void applySettings()
    {
        if (optselect.SelectedValue == "CN")
        {
            trDocket_1.Style["display"] = "block";
            trDocket_2.Style["display"] = "block";

            trPL_1.Style["display"] = "none";
            trPL_2.Style["display"] = "none";
        }
        else if (optselect.SelectedValue == "MN")
        {
            trDocket_1.Style["display"] = "none";
            trDocket_2.Style["display"] = "none";

            trPL_1.Style["display"] = "block";
            trPL_2.Style["display"] = "block";
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", VendorCode = "", VendorName = "", CustomerCode = "", CustomerName = "", DocketNo = "", PLNo = "", Type = "";

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
        
        if (txtCustCode.Text.Trim() != "")
        {
            CustomerCode = txtCustCode.Text.Trim();
            CustomerName = txtCustName.Text.Trim();
        }
        else
        {
            CustomerCode = "";
            CustomerName = "";
        }

        if (txtDocketNo.Text.Trim() != "")
        {
            DocketNo = txtDocketNo.Text.Trim();
        }
        else
        {
            DocketNo = "";
        }

        if (txtPLPartner.Text.Trim() != "")
        {
            VendorCode = txtPLPartner.Text.Trim();
            VendorName = txtPLPartnernm.Text.Trim();
        }
        else
        {
            VendorCode = "";
            VendorName = "";
        }

        if (txtPLNo.Text.Trim() != "")
        {
            PLNo = txtPLNo.Text.Trim();
        }
        else
        {
            PLNo = "";
        }


        string final;
        final = "?FromDT=" + dtFrom.ToString();
        final += "&ToDT=" + dtTo.ToString();
        if (optselect.SelectedValue == "CN")
        {
            final += "&Type=DKT";
            final += "&PartyCode=" + CustomerCode.ToString();
            final += "&PartyName=" + CustomerName.ToString();
            final += "&DocumentNo=" + DocketNo.ToString(); 
        }
        else if (optselect.SelectedValue == "MN")
        {
            final += "&Type=PL";
            final += "&PartyCode=" + VendorCode.ToString();
            final += "&PartyName=" + VendorName.ToString();
            final += "&DocumentNo=" + PLNo.ToString(); 
        }
        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 26/5/2014
        Response.Redirect("Result.aspx" + final);
		
        // System.Text.StringBuilder sb = new System.Text.StringBuilder();
        // sb.Append("<");
        // sb.Append("script language='javascript'>");
        // sb.Append("function NoConfirm()");
        // sb.Append("{");
        // sb.Append("win = top;");
        // sb.Append("win.opener = top;");
        // sb.Append("win.close ();");
        // sb.Append("}");
        // sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
        // sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        // sb.Append("<");
        // sb.Append("/script>");
        // if (!this.IsStartupScriptRegistered("PopupWindow"))
        // {
            // //Register the script
            // this.RegisterStartupScript("PopupWindow", sb.ToString());
        // }
    }
}

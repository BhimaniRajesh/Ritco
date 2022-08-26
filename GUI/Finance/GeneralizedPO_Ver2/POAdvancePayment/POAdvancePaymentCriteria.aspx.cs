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
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRNCriteria : System.Web.UI.Page
{
    string Type = "";
    MyFunctions fn = new MyFunctions();
    string TP;
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Request.QueryString.Get("type");
        if (!IsPostBack)
        {
            try
            {
                fn.Fill_Vendor_Dataset();
            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }
        }
    }
    protected void ButSubmit_Click(object sender, EventArgs e)
    {
        string report_mode = "";
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
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

        string FromDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd/MM/yyyy");
        string Todate = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd/MM/yyyy");

        string PONO = PONo.Text.ToString();
        string POMANUALNO = POManualNo.Text.ToString();

		string Vendor = Txt_Custcd.Text.Replace("&", "AND").Trim();
        string Qstring = "";
        Qstring = "VendorCode=" + Vendor;
        Qstring = Qstring + "&PONo=" + PONO;
        Qstring = Qstring + "&ManualPONo=" + POMANUALNO;
        Qstring = Qstring + "&FromDate=" + FromDate;
        Qstring = Qstring + "&ToDate=" + Todate;
        Response.Redirect("POAdvancePayment_Step1.aspx?" + Qstring);
    }
}

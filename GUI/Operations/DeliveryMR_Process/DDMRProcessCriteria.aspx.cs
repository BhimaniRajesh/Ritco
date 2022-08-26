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

public partial class GUI_Operations_DocketNonDeliveryUpdate_DocketNonDeliveryCriteria : System.Web.UI.Page
{
    SqlConnection conn;
    string TP;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                rdDateRange.Checked = true;
            }
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            if (rdDateRange.Checked == true)
            {
                TP = "0";
            }
            else if (rdDocketCri.Checked == true)
            {
                TP = "1";
            }

            conn.Close();
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";
        string report_mode = "";
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


        string final = "";
        if (TP == "0")
        {
            final = "?Type=" + TP;
            final += "&fromdt=" + dtFrom;
            final += "&todt=" + dtTo;
            final += "&DocketNo=" + txtDocketNo.Text;
        }
        else if (TP == "1")
        {
            final = "?Type=" + TP;
            final += "&fromdt=NA&todt=NA";
            final += "&DocketNo=" + txtDocketNo.Text;
        }
        Response.Redirect("DDMRProcessResult.aspx" + final);
    }

}

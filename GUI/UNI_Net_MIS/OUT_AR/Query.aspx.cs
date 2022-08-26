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

public partial class GUI_UNI_Net_MIS_OUT_AR_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            txtasondt_to.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            string Year = Session["FinYear"].ToString().Substring(2, 2);
            txtasondt.Text = "31/03/20" + Year;
            //txtasondt.Text = "";// "31/03/2008";
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");
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


        string st_ro = cboRO.SelectedValue.ToString();
        string st_lo = cboLO.SelectedValue.ToString();
        string rmd = rptmd.SelectedValue.ToString();
        string final, st_orderlist="";
        string rpttyp1="";

        RadioButtonList rb1 = new RadioButtonList();
        rb1 = (RadioButtonList)rpttyp;
        if ((rb1.Items[0].Selected))
        {
            rpttyp1 = "L";
        }
        if ((rb1.Items[1].Selected))
        {
            rpttyp1 = "C";
        }

        string St_custcd = txtCustomer.Text.ToString();

        RadioButtonList rb21 = new RadioButtonList();
        rb21 = (RadioButtonList)RadioRPT_SUBTYP;
        if ((rb21.Items[0].Selected))
        {
            st_orderlist = "B";

        }
        if ((rb21.Items[1].Selected))
        {
            st_orderlist = "M";
        }
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RMD=" + rpttyp1;
        final += "&St_custcd=" + St_custcd;
        final += "&st_asondt=" + txtasondt.Text;
        final += "&st_asondtTo=" + txtasondt_to.Text;
        final += "&st_orderlist=" + st_orderlist;
        Response.Redirect("Result.aspx" + final);

    }
}

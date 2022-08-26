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

public partial class GUI_UNI_Net_MIS_CHQ_register_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (RPT.Items[0].Selected == true)
        {
            TR1.Style["display"] = "block";
            TR2.Style["display"] = "none";
            TR3.Style["display"] = "none";
        }
        else
        {
            TR1.Style["display"] = "none";
            TR2.Style["display"] = "block";
            TR3.Style["display"] = "block";
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
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
        string rpt=RPT.SelectedValue.ToString();
        string rpt_str=RPT.SelectedItem.ToString();
        string rmd = rptmd.SelectedValue.ToString();
        string banklist = txtBank.Text.ToString();
        string CHQ_DEPOST = DLLCHQDEPST.SelectedValue.ToString();
        string CHQ_DEPOST_str = DLLCHQDEPST.SelectedItem.ToString();
        string CHQ_AccSt = DLLAccSt.SelectedValue.ToString();
        string CHQ_AccSt_str = DLLAccSt.SelectedItem.ToString();
        string CHQ_REcoSt = CLLBamcReco.SelectedValue.ToString();
        string CHQ_REcoSt_str = CLLBamcReco.SelectedItem.ToString();
        string amtfrm = chqamtfrm.Text.ToString();
        string amtto = chqamtto.Text.ToString();
        string chqnolist = txtChqno.Text.ToString();
        string DTSTR = DTTYP.SelectedValue.ToString();
        string DTSTR_str = DTTYP.SelectedItem.ToString();


        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPT=" + rpt;
        final += "&RPT_STR=" + rpt_str;
        final += "&RMD=" + rmd;
        final += "&banklist=" + banklist;
        final += "&CHQ_DEPOST=" + CHQ_DEPOST;
        final += "&CHQ_DEPOST_str=" + CHQ_DEPOST_str;
        final += "&CHQ_AccSt=" + CHQ_AccSt;
        final += "&CHQ_AccSt_str=" + CHQ_AccSt_str;
        final += "&CHQ_REcoSt=" + CHQ_REcoSt;
        final += "&CHQ_REcoSt_str=" + CHQ_REcoSt_str;
        final += "&amtfrm=" + amtfrm;
        final += "&amtto=" + amtto;
        final += "&chqnolist=" + chqnolist;
        final += "&DTSTR=" + DTSTR;
        final += "&DTSTR_str=" + DTSTR_str;


        Response.Redirect("Result.aspx" + final);

    }
}

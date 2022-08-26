using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_THC_ArrivalUpdate_THC_ArrivalUpdate : System.Web.UI.Page
{
    string process = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        lblPageHead.Text = Session["THCCalledAs"]+ " Arrival/Update";
        process = Request.QueryString["process"].ToString();
         btnShow.Text="Show "+Session["THCCalledAs"] + " List"; 
        lbldt.Text = Session["THCCalledAs"] + " Date";
        lbkThcno.Text = Session["THCCalledAs"] + " No(s)";
        lbkdktno.Text = Session["THCCalledAs"] + "(s) having " + Session["DocketCalledAs"] + " No(s)";
        lblVEHNO.Text = Session["THCCalledAs"] + "(s) having Vehicle No(s)";
        lbllastlog.Text = Session["THCCalledAs"] + "(s) Departed From Locations(s)";
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", st_doctyp = "", report_Subtype = "", report_type = "", st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_ro = "", st_lo = "", st_ro_to = "", st_lo_to = "";
        string fromdt = "", todt = "";

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

        string final;
        final = "?fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&thcnolist=" + txtThcnos.Text.ToString();
        final += "&dktnolist=" + txtDKTnos.Text.ToString();
        final += "&vehnolist=" + txtVEHnos.Text.ToString();
        final += "&lastloc=" + txtLSTLOCnos.Text.ToString();
        final += "&TYP=" + RDBLIST.SelectedValue.ToString();
        final += "&process=" + process;

        Response.Redirect("THCResult_ArrivalUpdate.aspx" + final);
    }
}

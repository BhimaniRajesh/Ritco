using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
public partial class GUI_UNI_MIS_OCT_RPT_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        string brcd, empcd, selyear;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        THC_Call = Session["THCCalledAs"].ToString();

        if (!IsPostBack)
        {
            //TRDWN.Visible = false;
            //string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            //// Response.Write("<br>sqlstr : " + sqlstr);
            //SqlCommand cmd = new SqlCommand(sqlstr, conn);
            //SqlDataReader dread = cmd.ExecuteReader();

            //dread.Read();
            //loclevel = Convert.ToInt32(dread.GetValue(0).ToString());

            //dread.Close();

            //documet_type.Items.Add(new ListItem(dkt_Call, "DKT"));
            //documet_type.Items.Add(new ListItem("Loading Sheet", "LS"));
            //documet_type.Items.Add(new ListItem("Manifest", "MF"));
           // documet_type.Items.Add(new ListItem(THC_Call, "THC"));
            //documet_type.Items.Add(new ListItem("DRS", "DRS"));
            //documet_type.Items.Add(new ListItem("PRS", "PRS"));
           // documet_type.SelectedValue = "DKT";

        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", st_doctyp = "", report_Subtype = "", report_type = "", st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_ro = "", st_lo = "", st_ro_to = "", st_lo_to = "";
        string fromdt = "", todt = "";

        //DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        //DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        //DropDownList cboRO_to = (DropDownList)Tolc.FindControl("cboRO");
        //DropDownList cboLO_to = (DropDownList)Tolc.FindControl("cboLO");

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

        //st_doctyp = documet_type.SelectedValue.ToString();
        //st_ro = cboRO.SelectedValue.ToString();
        //st_lo = cboLO.SelectedValue.ToString();
        //st_ro_to = cboRO_to.SelectedValue.ToString();
        //st_lo_to = cboLO_to.SelectedValue.ToString();

        st_Docnolist = txtsysno.Text.ToString();
        St_Manualnolist = txtOctBILLno.Text.ToString();
        st_Vehnolist = txtOctMrno.Text.ToString();
       // st_Freetext = txtFreeText.Text.ToString();

        string rmd = rptmd.SelectedValue.ToString();
        string STATUS = documet_type.SelectedValue.ToString();
        string STR_STATUS = documet_type.SelectedItem.ToString();
        string final;
        final = "?DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&st_Docnolist=" + st_Docnolist;
        final += "&St_OCTBILLlist=" + St_Manualnolist;
        final += "&st_OCTMRlist=" + st_Vehnolist;
        final += "&RMD=" + rmd;
        final += "&STATUS=" + STATUS;
        final += "&STR_STATUS=" + STR_STATUS;
        Response.Redirect("Result.aspx" + final);


    }
}

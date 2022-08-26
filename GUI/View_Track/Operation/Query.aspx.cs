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

public partial class GUI_Tracking_ver1_Query : System.Web.UI.Page
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
            //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //conn.Open();
            //LT_CUST_VEND.Items.Clear();
            //LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select DOCNO,DOCNO_ID,DOC_Called_AS from [Webx_View_Track] where  title='O' and srno in (select reportid from Webx_Master_View_TracksAccess where HasAccess='Y' and Userid='" + Session["empcd"].ToString() + "') and activeflag='Y' order by title";
            //SqlCommand cmd = new SqlCommand(sqlstr, conn);
            //SqlDataReader dread = cmd.ExecuteReader();
            //while (dread.Read())
            //{
            //    LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //}
            //LT_CUST_VEND.SelectedValue = "All";
            //dread.Close();


            documet_type.Items.Clear();
          
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                documet_type.Items.Add(new ListItem(dread.GetValue(2).ToString(), dread.GetValue(1).ToString()));
            }
            //documet_type.SelectedValue = "All";
            dread.Close();

            if (documet_type.SelectedValue == "DKT")
            {
                TRN1.Style["display"] = "block";
                TRN2.Style["display"] = "block";
                TRN3.Style["display"] = "block";
                TRN4.Style["display"] = "block";
            }
            else if (documet_type.SelectedValue == "THC" || documet_type.SelectedValue == "DRS")
            {
                TRN1.Style["display"] = "block";
                TRN2.Style["display"] = "block";
                TRN3.Style["display"] = "block";
                TRN4.Style["display"] = "none";
            }
            else if (documet_type.SelectedValue == "LS" || documet_type.SelectedValue == "MF" || documet_type.SelectedValue == "PFM")
            {
                TRN1.Style["display"] = "block";
                TRN2.Style["display"] = "block";
                TRN3.Style["display"] = "none";
                TRN4.Style["display"] = "none";
            }

            //documet_type.Items.Add(new ListItem(dkt_Call, "DKT"));            
            ////documet_type.Items.Add(new ListItem("Loading Sheet", "LS"));
            ////documet_type.Items.Add(new ListItem("Manifest", "MF"));
            //documet_type.Items.Add(new ListItem(THC_Call, "THC"));
            ////documet_type.Items.Add(new ListItem("DRS", "DRS"));
            ////documet_type.Items.Add(new ListItem("PRS", "PRS"));
            //documet_type.SelectedValue = "DKT";
           
        }
        conn.Close();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", st_doctyp = "", report_Subtype = "", report_type = "", st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_ro = "", st_lo = "", st_ro_to = "", st_lo_to = "";
        string fromdt = "", todt = "";

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        DropDownList cboRO_to = (DropDownList)Tolc.FindControl("cboRO");
        DropDownList cboLO_to = (DropDownList)Tolc.FindControl("cboLO");

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

        st_doctyp = documet_type.SelectedValue.ToString();
        string str_doctyp = documet_type.SelectedItem.ToString();
        st_ro = cboRO.SelectedValue.ToString();
        st_lo = cboLO.SelectedValue.ToString();
        st_ro_to = cboRO_to.SelectedValue.ToString();
        st_lo_to = cboLO_to.SelectedValue.ToString();

        st_Docnolist = txtsysno.Text.ToString();
        St_Manualnolist = txtmanno.Text.ToString();
        st_Vehnolist = txtCustRefno.Text.ToString();
        st_Freetext = txtFreeText.Text.ToString();

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&RO_TO=" + st_ro_to;
        final += "&LO_TO=" + st_lo_to;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&st_Docnolist=" + st_Docnolist;
        final += "&St_Manualnolist=" + St_Manualnolist;
        final += "&st_Vehnolist=" + st_Vehnolist;
        final += "&st_Freetext=" + st_Freetext;
        final += "&st_doctyp=" + st_doctyp;
        final += "&str_doctyp=" + str_doctyp;
        final += "&pagecnt=" + "1";
        final += "&DWN_XLS=" + "N";


        if (st_doctyp == "DKT" || st_doctyp == "THC")
            Response.Redirect("Result.aspx" + final);
        else
            Response.Redirect("Result_LS_MF_PDRS_PFM.aspx" + final);


    }
}

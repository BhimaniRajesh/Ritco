using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_UNI_Net_MIS_Voucher_register_Query : System.Web.UI.Page
{
    public static string  dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dkt_Call = Session["DocketCalledAs"].ToString();
            THC_Call = Session["THCCalledAs"].ToString();
            //imgfrm.ImageUrl= "../../images/calendar.jpg";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            //LT_CUST_VEND.Items.Clear();
            // LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " ";
            DLLVRtyp.Items.Clear();
            DLLVRtyp.Items.Add(new ListItem("All", "All"));
            sqlstr = "select codeid,codedesc from webx_master_general where codetype='VRTYpe' order by codedesc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                DLLVRtyp.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            DLLVRtyp.SelectedValue = "All";
            dread.Close();

            DLLTRtyp.Items.Clear();
            DLLTRtyp.Items.Add(new ListItem("All", "All"));
            sqlstr = "select codeid,codedesc from webx_master_general where codetype='TRNTYPE' order by codedesc";
             cmd = new SqlCommand(sqlstr, conn);
             dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                DLLTRtyp.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            DLLTRtyp.SelectedValue = "All";
            dread.Close();

            conn.Close();
        }
    }
    protected void ViewRefno(object sender, EventArgs e)
    {
        string trtype = DLLTRtyp.SelectedValue.ToString();
        if (trtype == "8" || trtype == "9" || trtype == "10" || trtype == "18")
        {
            trrefno.Visible = true;
            trstatus.Visible = true;
        }
        else
        {
            trrefno.Visible = false;
            trstatus.Visible = false; 
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
       
        string rmd = rptmd.SelectedValue.ToString();
        string VRLIST = txtVRnolist.Text.ToString();
        string doclist = txtDocno.Text.ToString();
        string VRTY = DLLVRtyp.SelectedValue.ToString();
        string VRTY_str = DLLVRtyp.SelectedItem.ToString();
        string TRTY = DLLTRtyp.SelectedValue.ToString();
        string TRTY_str = DLLTRtyp.SelectedItem.ToString();
        string VRREFNO = txtRefno.Text.ToString();
        string VRSTATUS = DLLVRSTATUS.SelectedValue.ToString();

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&VRLIST=" + VRLIST;
        final += "&doclist=" + doclist;
        final += "&RMD=" + rmd;
        final += "&VRTY=" + VRTY;
        final += "&VRTY_str=" + VRTY_str;
        final += "&TRTY=" + TRTY;
        final += "&TRTY_str=" + TRTY_str;
        final += "&VRREFNO=" + VRREFNO;
        final += "&VRSTATUS=" + VRSTATUS;

        Response.Redirect("Result.aspx" + final);

    }
   
}

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
public partial class GUI_UNI_Net_MIS_TDS_REgister_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //imgfrm.ImageUrl= "../../images/calendar.jpg";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            //ListBox LT_CUST_VEND = (ListBox)MS1.FindControl("listEmp");
            DLL_TDS_REC.Items.Clear();
            DLL_TDS_REC.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select acccode , accdesc+ ' : ' +isnull(company_acccode,acccode)  from webx_acctinfo a with(NOLOCK) inner join webx_groups g with(NOLOCK) on a.groupcode=g.groupcode  where acccategory='TDS' and main_category='ASSET'    order  by accdesc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                DLL_TDS_REC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            DLL_TDS_REC.SelectedValue = "All";
            dread.Close();

            DLL_TDS_Pay.Items.Clear();
            DLL_TDS_Pay.Items.Add(new ListItem("All", "All"));
             sqlstr = " select acccode , accdesc+ ' : ' +isnull(company_acccode,acccode)  from webx_acctinfo a with(NOLOCK) inner join webx_groups g with(NOLOCK) on a.groupcode=g.groupcode  where acccategory='TDS' and main_category='LIABILITY'    order  by accdesc";
             cmd = new SqlCommand(sqlstr, conn);
             dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                DLL_TDS_Pay.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            DLL_TDS_Pay.SelectedValue = "All";
            dread.Close();
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
        string rpt = documet_type.SelectedValue.ToString();
        string rpt_str ="TDS "+ documet_type.SelectedItem.ToString();
        string cust_vendcd = "", cust_vendnm = "",acccd="",accnm="";

        if (rpt == "R")
        {
            cust_vendcd = txtCustomer.Text.ToString().Trim();
            cust_vendnm = txtCustnm.Text.ToString().Trim();
            acccd = DLL_TDS_REC.SelectedValue.ToString();
            accnm = DLL_TDS_REC.SelectedItem.ToString();
        }
        else
        {
            cust_vendcd = txtVendor.Text.ToString().Trim();
            cust_vendnm = txtVendnm.Text.ToString().Trim();
            acccd = DLL_TDS_Pay.SelectedValue.ToString();
            accnm = DLL_TDS_Pay.SelectedItem.ToString();
        }

        string VRnolist = txtVRno.Text.ToString().Trim();
        string amt_frm = amtfrm.Text.ToString().Trim();
        string amt_to = amtto.Text.ToString().Trim();
       


        string final;
        final = "?Location=" + st_ro;
        final += "&loclevel=" + st_lo;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPT=" + rpt;
        final += "&RTP_DT_str=" + rpt_str;
        final += "&cust_vendcd=" + cust_vendcd;
        final += "&cust_vendnm=" + cust_vendnm;
        final += "&acccd=" + acccd;
        final += "&accnm=" + accnm;
        final += "&VRnolist=" + VRnolist;
        final += "&amt_frm=" + amt_frm;
        final += "&amt_to=" + amt_to;       

        Response.Redirect("Result.aspx" + final);
    }
}

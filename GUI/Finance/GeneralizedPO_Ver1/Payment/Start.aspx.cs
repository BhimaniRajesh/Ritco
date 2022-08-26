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


public partial class GUI_Finance_GeneralizedPO_Payment_Start : System.Web.UI.Page
{
    public static string straccd, p;
    string TP;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fn.Fill_Vendor_Dataset();
            rdDateRange.Checked = true;
            lblDocketNo.Text = "Enter PO Number";
        }        
        btnShow.Attributes.Add("onclick", "javascript:return Submit()");
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            string report_mode = "", st_ro = "", st_lo = "", st_Ao = "";
            DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
            DropDownList cboAO = (DropDownList)Fromlc.FindControl("cboAO");
            DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

            st_ro = cboRO.SelectedValue.ToString();
            string st_ro1 = cboRO.SelectedItem.ToString();
            if (cboRO.SelectedValue.ToString() == "")
            {
                st_ro = "All";
            }

            st_lo = cboLO.SelectedValue.ToString();
            string st_lo1 = cboLO.SelectedItem.ToString();
            if (cboLO.SelectedValue.ToString() == "")
            {
                st_lo = "All";
            }

            st_Ao = cboAO.SelectedValue.ToString();
            if (cboAO.SelectedValue.ToString() == "")
            {
                st_Ao = "All";
            }

            if (rdDateRange.Checked == true)
            {
                TP = "0";
            }
            else if (rdDocketCri.Checked == true)
            {
                TP = "1";
            }

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
            string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
            
            string final = "";
            final = "?RO=" + st_ro;
            final += "&LO=" + st_lo;
            final += "&ROText=" + st_ro1;
            final += "&LOText=" + st_lo1;
            if (TP == "0")
            {
                final += "&Type=" + TP;
                final += "&Party=" + txtPartyCode.Text;
                final += "&fromdt=" + dtFrom;
                final += "&todt=" + dtTo;
                final += "&POCode=" + txtPONo.Text;
            }
            else if (TP == "1")
            {
                final += "&Type=" + TP;
                final += "&Party=NA&Fromdt=NA&Todt=NA";
                final += "&POCode=" + txtPONo.Text;
            }
            Response.Redirect("GPO_List_For_Payment.aspx" + final, false);
        }
        catch (Exception ex)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + ex.Message + "</b></font></center>");
            string msg = ex.Message.ToString();
            msg = msg.Replace('\n', ' ');
        }
    }
}

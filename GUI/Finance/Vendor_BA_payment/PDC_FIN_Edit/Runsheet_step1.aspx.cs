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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCSearch : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        btnsubmit1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtDocNo.ClientID + "," + txtManualNo.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + txtVehicleNo.ClientID + ")");
        if (!(Page.IsPostBack))
        {
            ddlRouteMode.Items.Clear();
            ddlRouteMode.CssClass = "blackfnt";
            //ddlRouteMode.Items.Add(new ListItem("Select", ""));

            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("1") + "," + fn.Gettrnmod("3") + "," + fn.Gettrnmod("4"), "All"));
            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("2"), "2"));
        }
    }

    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;
       
        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
     
        }
    }

    protected void btnsubmit1_Click(object sender, EventArgs e)
    {
        string docno = "", manno = "", vehno = "", tp = "0"; ;

        if (optdoc.Checked == true)
        {
            docno = txtDocNo.Text;
            tp = "1";
        }
        else if (optman.Checked == true)
        {
            tp = "2";
            manno = txtManualNo.Text;
        }
        else if (optman.Checked == true)
        {
            tp = "3";
            vehno = txtVehicleNo.Text;
        }

        string final = "tp=" + tp;
        final += "&docno=" + docno;
        final += "&manno=" + manno;
        final += "&date1=" + txtDateFrom.Text;
        final += "&date2=" + txtDateTo.Text;
        final += "&vehno=" + vehno;
        final += "&advbal=A";
        final += "&RouteMode=" + ddlRouteMode.SelectedValue.ToString();
        final += "&Pdcty=" + CBOPdcty.SelectedValue.ToString();
        Response.Redirect("RunSheetList.aspx?" + final);
    }
}

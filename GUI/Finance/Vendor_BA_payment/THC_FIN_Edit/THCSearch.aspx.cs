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

public partial class GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THCSearch : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow1;
            txtDateTo.Text = strrightnow1;
          //  ddlRouteMode.Items.Clear();
           // ddlRouteMode.Items.Add(new ListItem("Select", ""));
           // ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("1"), "A"));
           // ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("2"), "S"));
           // ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("3"), "R"));

        }

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        btnsubmit1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtDocNo.ClientID + "," + txtManualNo.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + txtVehicleNo.ClientID + ")");

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
        string final = "?DocumentNo=" + txtDocNo.Text;
        final += "&ManualNo=" + txtManualNo.Text;
        final += "&dtFrom=" + txtDateFrom.Text;
        final += "&dtTo=" + txtDateTo.Text;
        final += "&VehicleNo=" + txtVehicleNo.Text;
        //final += "&AdvanceBalance=" + cboAdvanceorBalance.SelectedValue.ToString();
       // final += "&RouteMode=" + ddlRouteMode.SelectedValue.ToString();
        Response.Redirect("THCSelection.aspx" + final);
    }
}

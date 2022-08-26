using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCSearchInstallmentWiseBalancePayment : System.Web.UI.Page
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
            ddlRouteMode.Items.Clear();
            //ddlRouteMode.Items.Add(new ListItem("Select", ""));
            BindDropDown("USP_VENDOR_List_For_Payment", "VENDORNAME", "VENDORCODE", ddlVendor);

            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("2"), "S"));
            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("1"), "A"));
            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("3"), "R"));

        }

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        btnsubmit1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtDocNo.ClientID + "," + txtManualNo.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + "," + txtVehicleNo.ClientID + ")");

    }


    public void BindDropDown(string strProc, string text, string value, DropDownList d)
{
    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    string STR = strProc;
    conn.Open();
    SqlCommand cmd = new SqlCommand(STR, conn);
    cmd.CommandType = CommandType.StoredProcedure;
    SqlDataReader dr = cmd.ExecuteReader();
    if (dr.HasRows)
    {
        while (dr.Read())
        {
            d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
        }
    }
    dr.Close();
    conn.Close();
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
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }
    protected void btnsubmit1_Click(object sender, EventArgs e)
    {
        string final = "?VendorCode="+ddlVendor.SelectedValue.ToString();
        final += "&DocumentNo=" + txtDocNo.Text; 
        final += "&ManualNo=" + txtManualNo.Text;
        final += "&dtFrom=" + txtDateFrom.Text;
        final += "&dtTo=" + txtDateTo.Text;
        final += "&VehicleNo=" + txtVehicleNo.Text;
        final += "&AdvanceBalance=" + cboAdvanceorBalance.SelectedValue.ToString();
        final += "&RouteMode=" + ddlRouteMode.SelectedValue.ToString();
        Response.Redirect("THCSelectionInstallmentWise.aspx" + final);
    }
}
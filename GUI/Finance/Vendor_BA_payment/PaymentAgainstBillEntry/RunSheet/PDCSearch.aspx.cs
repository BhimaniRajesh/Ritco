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

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_RunSheet_PDCSearch : System.Web.UI.Page
{
    public string vendorCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            popVendor();
        }
    }
    public void popVendor()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //string sql = "select Type_name,Type_Code from webx_Vendor_Type";
        string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cbovendortype.Items.Clear();
        cbovendortype.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cbovendortype.Items.Add(new ListItem(dr["Type_name"].ToString(), dr["Type_Code"].ToString()));
        }
        dr.Close();


        //SqlCommand sqlcmd = new SqlCommand(sql, conn);

        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        //da.Fill(ds, "tab1");

        //cbovendortype.DataSource = ds;
        //cbovendortype.DataTextField = "Type_name";
        //cbovendortype.DataValueField = "Type_Code";
        //cbovendortype.DataBind();
    }
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        int strvendor = Convert.ToInt16(cbovendortype.SelectedValue);
        if (strvendor.ToString().Length == 1)
        {
            vendorCode = "0" + Convert.ToString(strvendor);
        }
        string sql = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + vendorCode + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cbovendor.DataSource = ds;
        cbovendor.DataTextField = "vendorname";
        cbovendor.DataValueField = "vendorcode";



        cbovendor.DataBind();
        if ((Page.IsPostBack))
        {
            //cbodoctype.Items.Clear();
            //popdoc(strvendor);
        }
    }
    //private void popdoc(int strvendor)
    //{
    //    int abc = strvendor;
    //    if (abc == 3)
    //    {

    //        cbodoctype.Items.Add("THC");
    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 1)
    //    {

    //        cbodoctype.Items.Add("Dockets");
    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 2)
    //    {

    //        cbodoctype.Items.Add("Run Sheet");

    //        selecttype.Enabled = false;

    //    }
    //    else if (abc == 4)
    //    {
    //        cbodoctype.Items.Add("--Select--");
    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 5)
    //    {
    //        cbodoctype.Items.Add("--Select--");

    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 6)
    //    {

    //        cbodoctype.Items.Add("THC");
    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 7)
    //    {

    //        cbodoctype.Items.Add("Expense Bill Entry");

    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 8)
    //    {

    //        selecttype.Enabled = true;

    //        cbodoctype.Items.Add("Dockets");
    //        selecttype.Items.Clear();
    //        selecttype.Items.Add("--Select--");
    //        selecttype.Items.Add("For Booking");
    //        selecttype.Items.Add("For Delivery");

    //    }
    //    else if (abc == 9)
    //    {
    //        cbodoctype.Items.Add("--Select--");
    //        cbodoctype.Items.Add("THC-Air");
    //        cbodoctype.Items.Add("ACN");
    //        selecttype.Enabled = false;
    //    }
    //    else if (abc == 10)
    //    {
    //        cbodoctype.Items.Add("THC-Rail");
    //        selecttype.Enabled = false;
    //    }
    //}
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string documenttype, docno1, vendortype, vendor;

        //documenttype = cbodoctype.SelectedValue.ToString();
        //docno1 = txtdocno.Text;
        vendortype = cbovendortype.SelectedValue.ToString();
        vendor = cbovendor.SelectedValue.ToString();

        //string final = "?documenttype=" + documenttype;
        //final += "&docno1=" + docno1;
        string final = "?vendortype=" + vendortype;
        final += "&vendor=" + vendor;
        final += "&fromdate=" + txtDateFrom.Text.ToString();
        final += "&todt=" + txtDateTo.Text.ToString();
        final += "&RouteMode=" + ddlRouteMode.SelectedValue.ToString();
        final += "&Pdcty=" + CBOPdcty.SelectedValue.ToString();
        
        Response.Redirect("vendorBill_step2.aspx" + final);


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
}

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

public partial class VendorPayment_new_vendorBill_vpstep1 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    string strsession1, strsession2;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            popVendor();
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

    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sConn;
        SqlConnection conn;
        sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        conn = new SqlConnection(sConn);
        conn.Open();


        int strvendor = Convert.ToInt16(cbovendortype.SelectedValue);
        string sql = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + strvendor + "'";
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
    public void popVendor()
    {
        string sConn;
        SqlConnection conn;
        sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        conn = new SqlConnection(sConn);
        conn.Open();

        string sql = "select Type_name,Type_Code from webx_Vendor_Type";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");

        cbovendortype.DataSource = ds;
        cbovendortype.DataTextField = "Type_name";
        cbovendortype.DataValueField = "Type_Code";
        cbovendortype.DataBind();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string documenttype, BillNo1, vendortype, vendor;

        documenttype = cboDocumentType.SelectedItem.ToString();
        vendortype = cbovendortype.SelectedValue.ToString();
        vendor = cbovendor.SelectedValue.ToString();
        BillNo1 = txtdocno.Text;
        string final = "?documenttype=" + documenttype;
        final += "&BillNo1=" + BillNo1;
        final += "&vendortype=" + vendortype;
        final += "&vendor=" + vendor;
        final += "&fromdate=" + txtDateFrom.Text.ToString();
        final += "&todt=" + txtDateTo.Text.ToString();

        Response.Redirect("vendorBill_vpstep2.aspx" + final);
    }
}

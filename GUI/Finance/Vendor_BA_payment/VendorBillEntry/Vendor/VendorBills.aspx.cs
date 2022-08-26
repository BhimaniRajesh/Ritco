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

public partial class VendorPayment_new_VendorBills : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    //string strsession1, strsession2;

    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick", "javascript:return fsubmit(" + txtdocno.ClientID + "," + cbovendortype.ClientID + "," + cbovendor.ClientID + "," + cbodoctype.ClientID + "," + selecttype.ClientID + ")");

        //strsession1 = "PNQA";
        //strsession2 = "P1438";

        if (!(Page.IsPostBack))
        {
            popRO();
            popVendor();
        }
        selecttype.Enabled = false;
    }
    public void popRO()
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        //conn = new SqlConnection(sConn);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
        //string sql = "select loccode,locname from webx_location where report_loc='PRHO' or report_loc=loccode order by locname";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab");
        cboRo.DataSource = ds;
        cboRo.DataTextField = "c1";
        cboRo.DataValueField = "c2";
        cboRo.DataBind();
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

    protected void cboRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        //conn = new SqlConnection(sConn);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string strro = cboRo.SelectedValue.ToString();
        string sql = "select loccode+' : '+locname c1,loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboLocation.DataSource = ds;
        cboLocation.DataTextField = "c1";
        cboLocation.DataValueField = "loccode";
        cboLocation.DataBind();
    }
    protected void cboLocation_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    public void popVendor()
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        //conn = new SqlConnection(sConn);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=PRRL_TEST;";

        //conn = new SqlConnection(sConn);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
            cbodoctype.Items.Clear();
            popdoc(strvendor);
        }
    }
    private void popdoc(int strvendor)
    {
        int abc = strvendor;
        if (abc == 3)
        {
            //cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("THC");
            selecttype.Enabled = false;
        }
        else if (abc == 1)
        {
            //cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("Dockets");
            selecttype.Enabled = false;
        }
        else if (abc == 2)
        {
            //cbodoctype.Items.Add("--Select--");
            //cboDocument.Items.Add("Both");
            cbodoctype.Items.Add("Run Sheet");
            //cboDocument.Items.Add("DRS");
            selecttype.Enabled = false;

        }
        else if (abc == 4)
        {
            cbodoctype.Items.Add("--Select--");
            selecttype.Enabled = false;
        }
        else if (abc == 5)
        {
            cbodoctype.Items.Add("--Select--");
            //cbodoctype.Items.Add("");
            selecttype.Enabled = false;
        }
        else if (abc == 6)
        {
            //cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("THC");
            selecttype.Enabled = false;
        }
        else if (abc == 7)
        {
            //cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("Expense Bill Entry");
            //cbodoctype.Items.Add("");
            selecttype.Enabled = false;
        }
        else if (abc == 8)
        {
            //string strMessage = "Please select type  !!!";
            selecttype.Enabled = true;
            //cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("Dockets");
            selecttype.Items.Clear();
            selecttype.Items.Add("--Select--");
            selecttype.Items.Add("For Booking");
            selecttype.Items.Add("For Delivery");
            //Response.Write("<script language=JavaScript >");
            
            //Response.Write("alert('" + selecttype=="--Select--" + "');");
            //Response.Write("alert('" + strMessage + "');");
            //Response.Write("</script>");
        }
        else if (abc == 9)
        {
            cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("THC-Air");
            cbodoctype.Items.Add("ACN");
            selecttype.Enabled = false;
        }
        else if (abc == 10)
        {
            //cbodoctype.Items.Add("--Select--");
            cbodoctype.Items.Add("THC-Rail");
            selecttype.Enabled = false;
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string documenttype, docno1, vendortype, vendor;

        documenttype = cbodoctype.SelectedValue.ToString();
        docno1 = txtdocno.Text;
        vendortype = cbovendortype.SelectedValue.ToString();
        vendor = cbovendor.SelectedValue.ToString();

        string final = "?documenttype=" + documenttype;
        final += "&docno1=" + docno1;
        final += "&vendortype=" + vendortype;
        final += "&vendor=" + vendor;
        final += "&fromdate=" + txtDateFrom.Text.ToString();
        final += "&todt=" + txtDateTo.Text.ToString();

        Response.Redirect("vendorBill_step2.aspx" + final);

        //string vendor = cboVendor2.SelectedItem.ToString();
        //string doc = "";
        //string final = "?vendor=" + vendor;
        //final += "&doc=" + doc;
        ////final += "&strDate=" + strDate;
        //final += "&dtFrom=" + dtFrom;
        //final += "&dtTo=" + dtTo;
        //Response.Redirect("VendorPayment_new/thccontract_step2.aspx" + final);
    }
}

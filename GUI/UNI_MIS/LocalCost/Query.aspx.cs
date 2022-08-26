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

public partial class GUI_UNI_MIS_LocalCost_Query : System.Web.UI.Page
{
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!(Page.IsPostBack))
        {
            LocalCost();
        }
    }

    private void LocalCost()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        //da = new SqlDataAdapter("select Type_Name from webx_Vendor_Type where Type_Name='VENDOR - ROAD - LOCAL' Order By Type_Name", conn);
        da = new SqlDataAdapter("select codedesc from webx_master_general where codedesc='Vendor - Road - Local' Order By codedesc", conn);
        da.Fill(ds, "webx_master_general");
        cboVendorType.DataSource = ds;
        cboVendorType.DataTextField = "codedesc";
        cboVendorType.DataBind();
        cboVendorType.Items.Insert(0, "Select One");
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
    protected void btnShowVendor_OnClick(object sender, EventArgs e)
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
        dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);

        string VendorType = cboVendorType.SelectedItem.Text;
        string Vendor = cboVendor.SelectedItem.Text;
        string VendorCode = cboVendor.SelectedItem.Value;

        Response.Redirect("LocalCost_Rpt.aspx?VendorCode=" + VendorCode + "&VendorType=" + VendorType + "&Vendor=" + Vendor + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo);
        
    }
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Local = cboVendorType.SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ds = new DataSet();
        string Sql = "select vh.VENDORCODE +' : '+ vh.VENDORNAME as Comman,vh.VENDORCODE as VENDORCODE from webx_VENDOR_HDR vh,webx_master_general vt where vt.codeid=vh.Vendor_Type and vt.codedesc='" + Local + "' Order by VENDORCODE";
        da = new SqlDataAdapter(Sql, conn);
        da.Fill(ds, "webx_VENDOR_HDR");
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "Comman";
        cboVendor.DataValueField = "VENDORCODE";
        cboVendor.DataBind();
        cboVendor.Items.Insert(0, "Select One");       
    }
}

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

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_Vendor_THCSearch : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick", "javascript:return fsubmit()");
        
       if (!(Page.IsPostBack))
        {
            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");

            txtDateFrom.Text = strrightnow1;
            txtDateTo.Text = strrightnow1;
            popVendor();
        }
        //selecttype.Enabled = false;
        
    }
    
    public void popVendor()
    {
       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid in ('03','04','09','10')";

        //string sql = "select Type_name,Type_Code from webx_Vendor_Type";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cbovendortype.Items.Clear();
        cbovendortype.CssClass = "blackfnt";
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
    protected void cbovendortype_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        int strvendor = Convert.ToInt16(cbovendortype.SelectedValue);
        string sql = "select distinct m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type=" + strvendor + "  and (vendorbrcd='ALL' or vendorbrcd='" + Session["brcd"].ToString() + "' or  patindex('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 )";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cbovendor.Items.Clear();
        cbovendor.CssClass = "blackfnt";
        cbovendor.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cbovendor.Items.Add(new ListItem(dr["vendorname"].ToString(), dr["vendorcode"].ToString()));
        }
        dr.Close();

        ddlRouteMode.Items.Clear();
        if (cbovendortype.SelectedValue == "03" || cbovendortype.SelectedValue == "04")
        {

            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("2"), "S"));
        }
        else if (cbovendortype.SelectedValue == "09")
        {

            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("1"), "A"));
        }
        else if (cbovendortype.SelectedValue == "10")
        {

            ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("3"), "R"));
        }

        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        //da.Fill(ds, "tab1");
        //cbovendor.DataSource = ds;
        //cbovendor.DataTextField = "vendorname";
        //cbovendor.DataValueField = "vendorcode";



        //cbovendor.DataBind();
        //if ((Page.IsPostBack))
        //{
        //    //cbodoctype.Items.Clear();
        //    //popdoc(strvendor);
        //}
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

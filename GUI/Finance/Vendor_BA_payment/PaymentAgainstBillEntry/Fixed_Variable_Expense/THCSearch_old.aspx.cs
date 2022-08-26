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

public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_THCSearch : System.Web.UI.Page
{
    public string Branch;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            Branch = Session["BRCD"].ToString();
            //popVendor();

            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow1;
            txtDateTo.Text = strrightnow1;

            string sql = "select Type_name,Type_Code from webx_Vendor_Type";
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
            conn.Close();
        }
        
    }

    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and VENDORBRCD='" + Branch + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendor2.Items.Clear();
        cboVendor2.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cboVendor2.Items.Add(new ListItem(dr["vendorname"].ToString(), dr["vendorcode"].ToString()));
        }
        dr.Close();
        
        //DataSet ds = new DataSet();
        
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        
        //da.Fill(ds, "tab1");
        
        //cboVendor2.DataSource = ds;
        //cboVendor2.DataTextField = "vendorname";
        //cboVendor2.DataValueField = "vendorcode";
        //cboVendor2.DataBind();

        conn.Close();
    }
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        int strvendor = Convert.ToInt16(cbovendortype.SelectedValue);
        string sql = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + strvendor + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendor2.Items.Clear();
        cboVendor2.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cboVendor2.Items.Add(new ListItem(dr["vendorname"].ToString(), dr["vendorcode"].ToString()));
        }
        dr.Close();

       
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
        final += "&VendorBill=" + txtVendorBillNo.Text;
        final += "&dtFrom=" + txtDateFrom.Text;
        final += "&dtTo=" + txtDateTo.Text;
        final += "&VehicleNo=" + txtVehicleNo.Text;
        final += "&vendor=" + cboVendor2.SelectedValue.ToString();

        Response.Redirect("vendorpayvoucher_Step2.aspx" + final);
    }
}

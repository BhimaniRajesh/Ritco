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
    public string Branch,doctype="";
    protected void Page_Load(object sender, EventArgs e)
    {

        string tmpStr = "javascript:return validcheck()";
        btnsubmit1.Attributes.Add("onClick", tmpStr);

        doctype = Request.QueryString.Get("doctype");
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
            string sql = "";
            if (doctype == "THC")
            {
                 sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid in ('03','04','09','10')";

            }
            else if (doctype == "PDC")
            {
                 sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid in ('02','03')";

            }
            else if (doctype == "BA")
            {
                 sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid in ('08')";

            }
            else if (doctype == "GENEXP")
            {
                sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY'  and codeid  not in ('01','02','03','04','05','06','08','09','10','12','13')";

            }
            else if (doctype == "FUEL")
            {
                sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY'  and codeid ='12'";// not in ('02','03','04','05','08','09','10')";

            }

            else if (doctype == "JOB")
            {
                sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY'  and codeid ='14'";// not in ('02','03','04','05','08','09','10')";

            }
            
            //string sql = "select Type_name,Type_Code from webx_Vendor_Type";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            cbovendortype.Items.Clear();
            cbovendortype.CssClass = "blackfnt";
            if (doctype != "FUEL")
            {
                cbovendortype.Items.Add(new ListItem("Select", "0"));
                //popVendor();
            }
            else
            {
                //cbovendortype.Items.Add(new ListItem("Select", "0"));
            }
            while (dr.Read())
            {
                cbovendortype.Items.Add(new ListItem(dr["Type_name"].ToString(), dr["Type_Code"].ToString()));
            }
            dr.Close();
            conn.Close();
            popVendor();
                
        }
        
    }

    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select distinct m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + cbovendortype.SelectedItem.Value + "' and (vendorbrcd='ALL' or vendorbrcd='" + SessionUtilities.CurrentBranchCode.ToString() + "' or  patindex('%" + SessionUtilities.CurrentBranchCode.ToString() + "%',vendorbrcd)>0 ) ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendor2.Items.Clear();
        cboVendor2.CssClass = "blackfnt";
        cboVendor2.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cboVendor2.Items.Add(new ListItem(dr["vendorname"].ToString(), dr["vendorcode"].ToString()));
        }
        dr.Close();
        conn.Close();
    }
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string strvendor = (cbovendortype.SelectedValue);
        string sql = "select distinct m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + strvendor + "' and (vendorbrcd='ALL' or vendorbrcd='" + SessionUtilities.CurrentBranchCode.ToString() + "' or  patindex('%" + SessionUtilities.CurrentBranchCode.ToString() + "%',vendorbrcd)>0 ) ";

        //string sql = "SELECT DISTINCT m.VENDORCODE, m.VENDORNAME + ':' + m.VENDORCODE AS vendorname FROM webx_VENDOR_HDR AS m INNER JOIN webx_VENDOR_DET AS d ON m.VENDORCODE = d.VENDORCODE WHERE (m.Vendor_Type = " + strvendor + ") AND (d.VENDORBRCD = 'ALL' OR d.VENDORBRCD = '" + Session["brcd"].ToString() + "' OR PATINDEX('%" + Session["brcd"].ToString() + "%', d.VENDORBRCD) > 0) ORDER BY m.VENDORNAME";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendor2.Items.Clear();
        cboVendor2.CssClass = "blackfnt";
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

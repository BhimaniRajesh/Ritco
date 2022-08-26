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

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_THCSearch : System.Web.UI.Page
{
    public string Branch, doctype = "";
    public static string lv;
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
            popVendor();

            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow1;
            txtDateTo.Text = strrightnow1;
            string sql = "";
            if (doctype == "AdvanceTHCVendorPaymentInstallmentWise")
            {
                sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid in ('19')";

            }
            else if (doctype == "PDC")
            {
                sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid in ('19')";

            }

            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            cbovendortype.Items.Clear();
            cbovendortype.CssClass = "blackfnt";
            while (dr.Read())
            {
                cbovendortype.Items.Add(new ListItem(dr["Type_name"].ToString(), dr["Type_Code"].ToString()));
            }
            dr.Close();
            conn.Close();
            popVendor();

            SqlConnection connBr = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            connBr.Open();
            string brcd = Session["brcd"].ToString();
            string sql_level = "select isnull(loc_level,1) from webx_location with(NOLOCK) where activeFlag='Y' and loccode='" + brcd + "' ";
            SqlCommand cmd_level = new SqlCommand(sql_level, connBr);
            SqlDataReader dr_level = cmd_level.ExecuteReader();
            while (dr_level.Read())
            {
                lv = dr_level[0].ToString();
            }
            dr_level.Close();
            string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
            SqlCommand sqlcmd1 = new SqlCommand(q1, connBr);
            SqlDataReader drBr;
            drBr = sqlcmd1.ExecuteReader();
            drBr.Read();
            string loccd = drBr["loccode"].ToString();
            drBr.Close();
            String SQL_LOC, sqlall1;
            if (brcd == loccd)
            {
                SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y'  order by locName";
                sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            }
            else
            {
                SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
                sqlall1 = "select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, connBr);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {

                ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
                ddlro.SelectedValue = Session["HeadOfficeCode"].ToString();
            }
            dr1.Close();
            ddlro.Items.Add(new ListItem("All", "All"));
            ddlro.SelectedValue = loccd;
            connBr.Close();
        }
    }
    private void popVendor()
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
        string vedor = "0";

        if (cbovendor.SelectedValue.ToString() == " Select ")
        {
            vedor = "0";
        }
        string final = "?DocumentNo=" + txtDocNo.Text;
        final += "&VendorBill=" + txtVendorBillNo.Text;
        final += "&dtFrom=" + txtDateFrom.Text;
        final += "&dtTo=" + txtDateTo.Text;
        final += "&VehicleNo=" + txtVehicleNo.Text;
        final += "&vendor=" + vedor ;
        final += "&Location=" + ddlro.SelectedValue.ToString();

        Response.Redirect("PendingTHCAdvanceCheque.aspx" + final);
    }
}
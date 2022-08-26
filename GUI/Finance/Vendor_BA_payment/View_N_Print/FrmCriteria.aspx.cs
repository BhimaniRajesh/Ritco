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
using Microsoft.VisualBasic;  

public partial class GUI_Finance_voucher_FrmCriteria : System.Web.UI.Page
{
    SqlConnection cn;
    public string client,DocumentType;
    protected void Page_Load(object sender, EventArgs e)
    {
        client = Session["Client"].ToString();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            string sql = "";
            //sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY'  and codeid in ('02','03','04','05','08','09','10')";
            sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY'";
            SqlCommand sqlcmd = new SqlCommand(sql, cn);
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
            cn.Close();
            popVendor();
        }
    }
    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strvendortype = cbovendortype.SelectedItem.Value;
        string sql = "select distinct m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + strvendortype + "' and (vendorbrcd='ALL' or vendorbrcd='" + SessionUtilities.CurrentBranchCode.ToString() + "' or  patindex('%" + SessionUtilities.CurrentBranchCode.ToString() + "%',vendorbrcd)>0 )"; //order by m.vendorname;
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


        string strvendor = cbovendortype.SelectedValue;
        string sql = "select distinct m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type='" + strvendor + "' and (vendorbrcd='ALL' or vendorbrcd='" + SessionUtilities.CurrentBranchCode.ToString() + "' or  patindex('%" + SessionUtilities.CurrentBranchCode.ToString() + "%',vendorbrcd)>0 )";// order by m.vendorname";
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
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string documenttype, docno1, vendortype, vendor;
            vendortype = cbovendortype.SelectedValue.ToString();
            vendor = cboVendor2.SelectedValue.ToString();

            string final = "?vendortype=" + vendortype;
            final += "&vendor=" + vendor;
            final += "&fromdate=" + txtDateFrom.Text.ToString();
            final += "&todt=" + txtDateTo.Text.ToString();
            final += "&VoucherNo=" + txtVoucherNo.Text.Trim().Replace("'", "''");
            final += "&DocumentType=" + cboDocType.SelectedValue.ToString();
            Response.Redirect("FrmVoucherDetail.aspx" + final);
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
}

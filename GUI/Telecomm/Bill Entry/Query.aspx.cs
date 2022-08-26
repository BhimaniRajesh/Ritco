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

public partial class Bill_Entry_Query : System.Web.UI.Page
{
    int loclevel;
    public string brcd = "";
    string sqlstr = "";
    DataSet ds;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!(IsPostBack))
        {
            Vendor();
            Region();
            ddlLoc.Items.Insert(0, "All");
            cboVendor.Focus();
        }
    }

    private void Region()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        brcd = Session["brcd"].ToString();
        sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        dread.Close();

        if (loclevel == 1)
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname", conn);
        }
        else
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where  loccode='" + brcd + "'", conn);
        }
        ds = new DataSet();
        da.Fill(ds, "webx_location");
        cboRegion.DataSource = ds;
        cboRegion.DataTextField = "Location";
        cboRegion.DataValueField = "loccode";
        cboRegion.DataBind();
        cboRegion.Items.Insert(0, "All");
    }   

    protected void cboRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        brcd = Session["brcd"].ToString();
        conn.Open();        
        if (loclevel <= 2)
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where report_loc='" + cboRegion.SelectedValue.ToString() + "' or loccode='" + cboRegion.SelectedValue.ToString() + "'", conn);
        }
        else
        {
            da = new SqlDataAdapter("select loccode,loccode + ' : '+ locname as Location from webx_location where  loccode='" + brcd + "'", conn);
        }
        ds = new DataSet();
        da.Fill(ds, "webx_location");
        ddlLoc.DataSource = ds;
        ddlLoc.DataTextField = "Location";
        ddlLoc.DataBind();
        ddlLoc.Items.Insert(0, "All");
        conn.Close();
        string Region = cboRegion.SelectedItem.Text == "All" ? "%" : cboRegion.SelectedItem.Text;
        string RegLoc = ddlLoc.SelectedItem.Text == "All" ? "%" : ddlLoc.SelectedItem.Text;
        
        conn.Open();
        //da = new SqlDataAdapter("select vh.Vendor_Type,vh.VENDORNAME from webx_VENDOR_HDR vh,webx_Vendor_Type vt,webx_VENDOR_DET vd,webx_location wl where vd.vendorbrcd=wl.LocCode and vd.Vendorcode = vh.Vendorcode and vt.Type_Code=vh.Vendor_Type and vt.Type_Code=vh.vendcat and vt.Type_Name ='Service Provider-Communication' and wl.LocCity like '" + Region + "' and wl.LocName +' : '+wl.LocCode like '" + RegLoc + "' and loccode='" + brcd + "'", conn);
        da = new SqlDataAdapter("select vh.Vendor_Type,vh.VENDORNAME from webx_VENDOR_HDR vh,Webx_Master_General vt,webx_VENDOR_DET vd,webx_location wl where vd.vendorbrcd=wl.LocCode and vd.Vendorcode = vh.Vendorcode and vt.CodeId=vh.Vendor_Type and vt.CodeId=vh.vendcat and vt.CodeDesc ='Service Provider' and wl.LocCity like '" + Region + "' and wl.LocName +' : '+wl.LocCode like '" + RegLoc + "' and loccode='" + brcd + "' and vt.CodeType='VENDTY'", conn);
        ds = new DataSet();
        da.Fill(ds);
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "VENDORNAME";
        cboVendor.DataValueField = "VENDORNAME";
        cboVendor.DataBind();
        cboVendor.Items.Insert(0, "--Select--");
        conn.Close();
    }

    private void Vendor()
    {
        brcd = Session["brcd"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter("select vh.Vendor_Type,vh.VENDORNAME from webx_VENDOR_HDR vh,Webx_Master_General vt,webx_VENDOR_DET vd,webx_location wl where vd.vendorbrcd=wl.LocCode and vd.Vendorcode = vh.Vendorcode and vt.CodeId=vh.Vendor_Type and vt.CodeId=vh.vendcat and vt.CodeDesc ='Service Provider' and loccode='" + brcd + "' and vt.CodeType='VENDTY'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "VENDORNAME";
        cboVendor.DataValueField = "VENDORNAME";
        cboVendor.DataBind();
        cboVendor.Items.Insert(0, "--Select--");
        conn.Close();
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string Vendor = cboVendor.SelectedItem.Text;
        Response.Redirect("~/GUI/Telecomm/Bill Entry/CommunicationExpenseBillEntry.aspx?Vendor=" + Vendor);
    }
    protected void ddlLoc_SelectedIndexChanged(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        string Region = cboRegion.SelectedItem.Text == "All" ? "%" : cboRegion.SelectedItem.Text;
        string RegLoc = ddlLoc.SelectedItem.Text == "All" ? "%" : ddlLoc.SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter("select vh.Vendor_Type,vh.VENDORNAME from webx_VENDOR_HDR vh,Webx_Master_General vt,webx_VENDOR_DET vd,webx_location wl where vd.vendorbrcd=wl.LocCode and vd.Vendorcode = vh.Vendorcode and vt.CodeId=vh.Vendor_Type and vt.CodeId=vh.vendcat and vt.CodeDesc ='Service Provider' and wl.LocCity like '" + Region + "' and wl.LocName +' : '+wl.LocCode like '" + RegLoc + "' and vt.CodeType='VENDTY'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "VENDORNAME";
        cboVendor.DataValueField = "VENDORNAME";
        cboVendor.DataBind();
        cboVendor.Items.Insert(0, "--Select--");
        conn.Close();
    }
}

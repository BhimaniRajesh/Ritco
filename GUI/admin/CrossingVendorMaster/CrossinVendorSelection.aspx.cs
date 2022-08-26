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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_CrossingVendorMaster_CrossinVendorSelection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sql = "select codeid,codedesc from webx_master_general where codetype='VENDTY' and codeid in ('18')";
            DataSet ds = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString(), CommandType.Text, sql);

            cboVendorType.DataSource = ds;
            cboVendorType.DataTextField = "codedesc";
            cboVendorType.DataValueField = "codeid";
            cboVendorType.DataBind();
            cboVendorType.Items.Insert(0, new ListItem("Select", "0"));
            cboVendorType.SelectedValue = "0";

        }
    }
    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
        //string sql = "select m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname   from webx_vendor_hdr m ,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type=" + strvendor + " and (vendorbrcd='ALL' or vendorbrcd='" + Session["brcd"].ToString() + "' or  patindex('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) order by m.vendorname";
        string sql = "select m.vendorcode,m.vendorname+':'+m.vendorcode as vendorname   from webx_vendor_hdr m where vendor_type=" + strvendor + "";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendor.Items.Clear();
        cboVendor.CssClass = "blackfnt";
        cboVendor.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cboVendor.Items.Add(new ListItem(dr["vendorname"].ToString(), dr["vendorcode"].ToString()));
        }
        dr.Close();


    }
    protected void btn_Submit(object sender, EventArgs e)
    {
        string final;
        final = "vendor=" + cboVendor.SelectedValue.ToString();
        final += "&vendorType=" + cboVendorType.SelectedItem.ToString();

        if (cboAddEdit.SelectedValue.ToString() == "E")
        {
            final += "&AddEdit=" + cboAddEdit.SelectedValue.ToString();
            Response.Redirect("UpdateDeleteCrossingVendorContract.aspx?" + final);
        }
        else
        {
            Response.Redirect("AddCrossingVendorContract.aspx?" + final);
        }





    }
}

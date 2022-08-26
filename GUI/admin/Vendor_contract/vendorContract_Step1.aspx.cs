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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Admin_Vendor_contract_vendorContract_Step1 : System.Web.UI.Page
{

    SqlConnection conn;

    protected void Page_Load(object sender, EventArgs e)
    {

         conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (!IsPostBack)
        {
            String sqlstr = "Select top 1 '' as [type_name] ,'--Select One--' as type_code Union select codeid as [type_name] , codedesc as type_code  from webx_master_general where codetype='vendty' and statuscode='Y' and codeid in ('02','03','05','04','08','09','10') ";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            //cbovendortype.Items.Clear();
            {

                while (dread.Read())
                {
                    cbovendortype.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();
        }

        conn.Close();
    }
    protected void cbovendortype_SelectedIndexChanged(object sender, EventArgs e)
    {

        conn.Open();
        string vehty = "";
        if (cbovendortype.SelectedValue.ToString().Length == 2)
        {
             vehty = cbovendortype.SelectedValue.ToString().Substring(1,1);
        }

        String sqlstr = "Select top 1 '' as vendorcode ,'--Select One--' as [vendorname]   from webx_vendor_hdr union  select vendorcode,vendorname + ' : ' + vendorcode as [vendorname] from webx_vendor_hdr where ( contract_YN='N' or contract_YN is null) and (vendor_type='" + cbovendortype.SelectedValue.ToString() + "' or  vendor_type='" + vehty + "') and vendorcode not in (select distinct vendorcode from webx_vendor_contract_summary ) order by vendorname";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cbovendortype1.Items.Clear();
        {

            while (dread.Read())
            {
                cbovendortype1.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();

        sqlstr = "Select top 1 '' as [contractcd] ,'--Select One--' as vendorcode  from webx_vendor_hdr union  select contractcd,vendorname + ' : ' + vendorcode  as vendorcode  from webx_vendor_contract_summary where vendor_type='" + cbovendortype.SelectedValue.ToString() + "' or vendor_type='" + vehty + "' order by vendorcode";
         cmd = new SqlCommand(sqlstr, conn);
         dread = cmd.ExecuteReader();
        cbovendortype2.Items.Clear();
        {

            while (dread.Read())
            {
                cbovendortype2.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();

        sqlstr = "Select top 1 '' as [contractcd] ,'--Select One--' as vendorcode  from webx_vendor_hdr union  select contractcd,vendorname + ' : ' + vendorcode  as vendorcode from webx_vendor_contract_summary where vendor_type='" + cbovendortype.SelectedValue.ToString() + "' order by vendorcode";
        cmd = new SqlCommand(sqlstr, conn);
        dread = cmd.ExecuteReader();
        cbovendortype3.Items.Clear();
        {

            while (dread.Read())
            {
                cbovendortype3.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();

        cbovendortype1.SelectedValue = "";
        cbovendortype2.SelectedValue = "";
        cbovendortype3.SelectedValue = "";

        conn.Close();

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string VendorADD = cbovendortype1.SelectedValue.ToString();
        string VendorEdit = cbovendortype2.SelectedValue.ToString();
        string VendorView = cbovendortype3.SelectedValue.ToString();

        

        string final,Flag;
        final = "?VendorADD=" + VendorADD;
        final += "&VendorEdit=" + VendorEdit;
        final += "&VendorView=" + VendorView;

        if (VendorADD == "")
        {
            Flag="Y";
            final += "&Flag=" + Flag;

            String abcd = cbovendortype3.SelectedValue.ToString();
            if (abcd != "")
            {
                Response.Redirect("vendorcontract_VIEW.aspx" + final);
            }
            else
            {
                Response.Redirect("vendorcontract_profile.aspx" + final);
            }


           
        }
        else
        {
            Flag = "N";
            final += "&Flag=" + Flag;
            Response.Redirect("vendorcontract_profile.aspx" + final);
        }

        
       
    }
}

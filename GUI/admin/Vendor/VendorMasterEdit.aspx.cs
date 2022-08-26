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

public partial class GUI_admin_Vendor_VendorMasterEdit : System.Web.UI.Page
{
        SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
        
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            if (IsPostBack == false)
            {
                                        //ddVendorType.Items.Add("--Select--");
                                        //ddVendor.Items.Add("--Select--");
                                        //cn.Open();
                                        //SqlCommand cmd = new SqlCommand("Select Type_Name + ' : ' + Type_Code From webx_Vendor_Type",cn);
                                        //SqlDataReader dr = cmd.ExecuteReader();
                                        //while (dr.Read())
                                        //{
                                        //    ddVendorType.Items.Add(new ListItem(dr.GetValue(0).ToString()));
                                        //}
                                        //dr.Close();
                                        //cn.Close();
                popVentype();

            }
        }

    public void popVentype()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //  string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_VENDOR_type  union select type_name + ' : ' + type_code as a, type_code as b from webx_VENDOR_type";

        string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_master_general  union select codeid as a,codedesc as b from webx_master_general where codetype='VENDTY'  AND StatusCode='Y' ";
        SqlCommand cmd = new SqlCommand(sqldd, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddVendorType.DataSource = ds;
        ddVendorType.DataTextField = "b";
        ddVendorType.DataValueField = "a";
        ddVendorType.DataBind();

    }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //string[] strVndrTypeSS = ddVendorType.SelectedValue.Split(':');
            //Session["strVndrType"] = strVndrTypeSS[1].Trim();
            //string[] strVndrCdPp = ddVendor.SelectedValue.Split(':');
            //Session["popCustCd"] = strVndrCdPp[1].Trim();
            Server.Transfer("VendorMaster.aspx");
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //string[] strVndrTypeSS = ddVendorType.SelectedValue.Split(':');
            //Session["strVndrType"] = strVndrTypeSS[1].Trim();
            string[] strVndrCdPp = ddVendor.SelectedValue.Split(':');
            //Session["vndrCd"] = strVndrCdPp[1].Trim();
            Session["txtVndrCdSS"] = "";
            Session["vencd"] = ddVendor.SelectedValue.ToString();
            Server.Transfer("VendorEdit.aspx?para="+"1");


        }
        protected void btnQckEdit_Click(object sender, EventArgs e)
        {
            Session["vencd"] = txtVendorCd.Text.Trim();
            Session["txtVndrCdSS"] = txtVendorCd.Text.Trim();
            //Session["strVndrType"] = "";
            Session["vndrCd"] = "";
            Server.Transfer("VendorEdit.aspx?para="+"1");
        }
        protected void btnQckLstAll_Click(object sender, EventArgs e)
        {
            Server.Transfer("ListAll.aspx");
        }
        protected void btnListing_Click(object sender, EventArgs e)
        {
            Server.Transfer("ListAll.aspx");
        }
    protected void ddVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddVendorType.SelectedIndex == 0)
        {
            ddVendor.Items.Clear();
        }
        else
        {
            string[] strVndrCd = ddVendorType.SelectedValue.Split(':');
            cn.Open();
            SqlCommand cmd = new SqlCommand("select vendorname + ' : ' + vendorcode as a,vendorcode as b from webx_VENDOR_HDR where Vendor_Type='" + ddVendorType.SelectedValue.ToString() + "' order by vendorname", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddVendor.DataSource = ds;
            ddVendor.DataTextField = "a";
            ddVendor.DataValueField="b";
            ddVendor.DataBind();
            cn.Close();
        }
    }
    protected void btnQckAdd_Click(object sender, EventArgs e)
    {
        Server.Transfer("VendorMaster.aspx");
    }
}
    


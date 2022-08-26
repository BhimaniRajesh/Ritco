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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_CrossingVendorMaster_vendorContract_Step1 : System.Web.UI.Page
{
    private DataTable dt
    {
        get { return (ViewState["VendorsList"] != null) ? ViewState["VendorsList"] as DataTable : new DataTable(); }
        set { ViewState["VendorsList"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string Sql = "select * from vw_Vendor_For_Crossing";
            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
            
        }
    }
    protected void Step1_Click(object sender, EventArgs e)
    {
        string VendorName = "", VendorCode = "", VendorTypeID = "", PageName = "", Add_Edit_Flag = "", ContractType = "";

        
        if (Rd_Add.Checked)
            Add_Edit_Flag = "A";
        if (Rd_Edit.Checked)
            Add_Edit_Flag = "E";

        PageName = "vendorContract_Step2.aspx";

        string Qstring = "?VendorTypeID=" + VendorTypeID;
        Qstring += "&VendorTypeDesc=" + DDL_Vendor_Type.SelectedItem.Text.ToString();
        Qstring += "&VendorID=" + ((string[]) txtVedor.Text.Split(':'))[1];
        Qstring += "&VendorDesc=" + VendorName;
        Qstring += "&Add_Edit_Flag=" + Add_Edit_Flag;
        //Qstring += "&ContractCode=" + ;
        //Qstring += "&ContractType=" + ;
        Response.Redirect(PageName + Qstring);
        
    }

   protected void txtVedor_TextChanged(object source, Anthem.AutoSuggestEventArgs e)
    {
        string Add_Edit_Flag = "Add";
        if (Rd_Add.Checked)
            Add_Edit_Flag = "Add";
        if (Rd_Edit.Checked)
            Add_Edit_Flag = "Edit";
        DataView dv = new DataView(dt);

        dv.RowFilter = string.Format("(vendorcode LIKE '{0}%' OR vendorname LIKE '{0}%') AND contract_YN='{1}' ", e.CurrentText, Add_Edit_Flag);

        txtVedor.DataSource = dv;
        txtVedor.DataBind();
    }
}

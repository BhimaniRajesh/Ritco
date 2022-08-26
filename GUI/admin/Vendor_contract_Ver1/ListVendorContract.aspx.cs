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
    private DataTable VendorsList
    {
        get { return (ViewState["VendorsList"] != null) ? ViewState["VendorsList"] as DataTable : new DataTable(); }
        set { ViewState["VendorsList"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            //txtVedor.UpdateAfterCallBack = true;
            VendorsList = Vendor_Contract.GetVendors();
            Vendor_Contract.Fill_VendorContract_Selection(Ddl_Contract_For, "VENDTY");
            TR_VendDetail.Style["display"] = "none";
            //TR_VendDetail_1.Style["display"] = "none";
            //TR_VendDetail_2.Style["display"] = "none";
            TR_VendDetail_3.Style["display"] = "none";
            TR_Attached.Style["display"] = "none";
            TR_BA.Style["display"] = "none";
            TR_3PL.Style["display"] = "none";
            TR_ContrFor.Style["display"] = "none";
            Rd_Add.Checked = true;
            Rd_Contract_Attached.Checked = true;
        }
    }
    protected void Step1_Click(object sender, EventArgs e)
    {
        string VendorName = "", VendorCode = "", VendorTypeID = "", PageName = "", Add_Edit_Flag = "", ContractType = "";

        VendorTypeID = Ddl_Contract_For.SelectedValue.ToString();
        VendorCode = txtVedor.SelectedValue;
        VendorName = txtVedor.Text.Remove(txtVedor.Text.IndexOf(":"));
        if (Rd_Add.Checked)
            Add_Edit_Flag = "A";
        if(Rd_Edit.Checked)
            Add_Edit_Flag = "E";

        PageName = "vendorContract_profile.aspx";

        string Qstring = "?VendorTypeID=" + VendorTypeID;
        Qstring += "&VendorTypeDesc=" + Ddl_Contract_For.SelectedItem.Text.ToString();
        Qstring += "&VendorID=" + VendorCode.ToString();
        Qstring += "&VendorDesc=" + VendorName;
        Qstring += "&Add_Edit_Flag=" + Add_Edit_Flag;

        //Attached
        if (VendorTypeID == "01")
        {
            if (Rd_Contract_Attached.Checked) //Route Based for THC AND Distance Based for DRS/PRS
            {
                //PageName = "Route_Based_Contract.aspx";
                //Vendor
                if (Ddl_Contract_For.SelectedValue == "1")
                    ContractType = "01";
                //FTL Type
                if (Ddl_Contract_For.SelectedValue == "2")
                    ContractType = "02";
                //Vehicle
                if (Ddl_Contract_For.SelectedValue == "3")
                    ContractType = "03";
            }
            else if (Rd_Contract_Attached1.Checked) //Distance Based for THC/DRS/PRS
            {
                //PageName = "Distance_Based_Contract.aspx";
                //Vendor
                if (Ddl_Contract_For.SelectedValue == "1")
                    ContractType = "04";
                //FTL Type
                if (Ddl_Contract_For.SelectedValue == "2")
                    ContractType = "05";
                //Vehicle
                if (Ddl_Contract_For.SelectedValue == "3")
                    ContractType = "06";
                //PageName = "Route_Based_Contract.aspx";
            }
        }
        else if (VendorTypeID == "08") //BA
        {
            //PageName = "Docket_Based_Contract.aspx";
            //Docket Based
            ContractType = "07"; 
        } 
        else if (VendorTypeID == "03") //3PL
        {
            //PageName = "3PL_Based_Contract.aspx";
            //3PL Based
            ContractType = "08";
        }
        Qstring += "&ContractType=" + ContractType;
        

        Response.Redirect(PageName + Qstring);
    }

    protected void txtVedor_TextChanged(object source, Anthem.AutoSuggestEventArgs e)
    {
        string Add_Edit_Flag = "Add";
        if (Rd_Add.Checked)
            Add_Edit_Flag = "Add";
        if (Rd_Edit.Checked)
            Add_Edit_Flag = "Edit";
        DataView dv = new DataView(VendorsList);

        dv.RowFilter = string.Format("(vendorcode LIKE '{0}%' OR vendorname LIKE '{0}%') AND contract_YN='{1}' AND VendorTypeCode='{2}'", e.CurrentText, Add_Edit_Flag, Ddl_Contract_For);
        		
        txtVedor.DataSource = dv;
        txtVedor.DataBind();
    }
    
}

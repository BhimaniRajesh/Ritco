using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Tyre_OldTyres_ClaimQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            txtVendor.Attributes.Add("OnBlur", "javascript:CheckVendor()");
            ////btnSubmit.Attributes.Add("OnClick", "javascript:ChecKOnSubmit()");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string VendorCD = "", VendorNM = "", FromDT = "", ToDT="",ClaimID="";
        string[] ARR_vendcd;

        if (txtVendor.Text != "")
        {
            ARR_vendcd = txtVendor.Text.Split('~');
            VendorCD = ARR_vendcd[0].ToString();
            VendorNM = ARR_vendcd[1].ToString();           
        }
        else
        {
            VendorCD = "";
            VendorNM = "";
        }

        if(txtClaimID.Text!=""){        
        ClaimID=txtClaimID.Text.Trim();
        FromDT = ""; 
        ToDT = "";
        VendorCD = "";        
        }
        else{
        ClaimID="";
        FromDT = DT.DateFrom.ToString("dd MMM yyyy");
        ToDT = DT.DateTo.ToString("dd MMM yyyy");        
        }
        Response.Redirect("ClaimResult.aspx?VendorID=" + VendorCD.Trim() + "&FromDT=" + FromDT + "&ToDT=" + ToDT + "&ClaimID=" + ClaimID);
    }
}
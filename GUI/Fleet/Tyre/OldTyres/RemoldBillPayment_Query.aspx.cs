using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Tyre_OldTyres_RemoldBillPayment_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            txtVendor.Attributes.Add("OnBlur", "javascript:return CheckVendor()");
            txtBillNo.Attributes.Add("OnBlur", "javascript:return Check_BILLNO()");
            btnSubmit.Attributes.Add("OnClick", "javascript:return ChecKOnSubmit()");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        btnSubmit.Enabled = false;

        string VendorCD = "", VendorNM = "", FromDT = "", ToDT = "", BillNo = "";
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

        if (txtBillNo.Text != "")
        {
            BillNo = txtBillNo.Text.Trim();
            FromDT = "";
            ToDT = "";
            VendorCD = "";
        }
        else
        {
            BillNo = "";
            FromDT = DT.DateFrom.ToString("dd MMM yyyy");
            ToDT = DT.DateTo.ToString("dd MMM yyyy");
        }
        Response.Redirect("RemoldBillPayment.aspx?VendorID=" + VendorCD.Trim() + "&FromDT=" + FromDT + "&ToDT=" + ToDT + "&BillNo=" + BillNo);
    }
}

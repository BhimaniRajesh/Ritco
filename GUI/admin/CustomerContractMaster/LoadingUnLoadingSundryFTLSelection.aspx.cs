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

public partial class LoadingUnLoadingSundryFTLSelection : System.Web.UI.Page
{
    protected string contractid = "", custcode = "", requestid = "";
    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["ContractID"].ToString();
        requestid = Request.QueryString["requestid"].ToString();

        lblcontractid.Text = contractid;
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            if (requestid.CompareTo("locloading") == 0)
            {
                lblheader.Text = "Location Wise Loading Charge Selection";
            }
            else if (requestid.CompareTo("locunloading") == 0)
            {
                lblheader.Text = "Location Wise UnLoading Charge Selection";
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }

        fn = new MyFunctions();
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (requestid.CompareTo("locloading") == 0)
        {
            if (optsundry.Checked == true)
                Response.Redirect("LoadingSundryCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (optftl.Checked == true)
                Response.Redirect("LoadingFTLCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
        }
        else if (requestid.CompareTo("locunloading") == 0)
        {
            if (optsundry.Checked == true)
                Response.Redirect("UnLoadingSundryCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (optftl.Checked == true)
                Response.Redirect("UnLoadingFTLCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
        }

    }


}

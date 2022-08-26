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

public partial class GUI_admin_CustomerContractMaster_StepSelection : System.Web.UI.Page
{
    string custcode,contractid;
    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();

        MyFunctions fn=new MyFunctions();
        lblcontractid.Text = contractid;
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

        string strsundry = "N", strftl = "N", strflatmultipoint = "N", stroda = "N", strflatloading = "N", strflatunloading = "N";
        string strlocmultipoint = "N", strlocloading = "N", strlocunloading = "N";
        strsundry = Request.QueryString["sundry"].ToString();
        strftl = Request.QueryString["ftl"].ToString();
        strflatmultipoint = Request.QueryString["flatmultipoint"].ToString();
        strflatloading = Request.QueryString["flatloading"].ToString();
        strflatunloading = Request.QueryString["flatunloading"].ToString();
        strlocmultipoint = Request.QueryString["locmultipoint"].ToString();
        strlocloading = Request.QueryString["locloading"].ToString();
        strlocunloading = Request.QueryString["locunloading"].ToString();
        stroda = Request.QueryString["oda"].ToString();


        if (strsundry.CompareTo("N") == 0)
        {
            trsundry.Style["display"] = "none";
        }

        if (strftl.CompareTo("N") == 0)
        {
            trftl.Style["display"] = "none";
        }

        if (stroda.CompareTo("N") == 0)
        {
            troda.Style["display"] = "none";
        }

        if (strflatmultipoint.CompareTo("N") == 0)
        { 
            trflatmultipoint.Style["display"] = "none";
        }

        if (strflatloading.CompareTo("N") == 0)
        {
            trflatloading.Style["display"] = "none";
        }

        if (strflatunloading.CompareTo("N") == 0)
        {
            trflatunloading.Style["display"] = "none";
        }

        if (strlocmultipoint.CompareTo("N") == 0)
        {
            trlocmultipoint.Style["display"] = "none";
        }

        if (strlocloading.CompareTo("N") == 0)
        {
            trlocloading.Style["display"] = "none";
        }

        if (strlocunloading.CompareTo("N") == 0)
        {
            trlocunloading.Style["display"] = "none";
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (optsundry.Checked == true)
        {
            Response.Redirect("SundrySlabSelection.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optftl.Checked == true)
        {
            Response.Redirect("MatrixSelection.aspx?servicecode=2.1&custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optoda.Checked == true)
        {
            Response.Redirect("EditCCMODA.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }
       
        else if (optflatmultipoint.Checked == true)
        {
            Response.Redirect("FlatMultiPointCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=flatmultipoint");
        }
        else if (optflatloading.Checked == true)
        {
            Response.Redirect("FlatLoadingCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=flatloading");
        }
        else if (optflatunloading.Checked == true)
        {
            Response.Redirect("FlatUnLoadingCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=flatunloading");
        }
        else if (optlocmultipoint.Checked == true)
        {
            Response.Redirect("MultiPointCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=locmultipoint");
        }
        else if (optlocloading.Checked == true)
        {
            Response.Redirect("FTLSundryChoice.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=locloading");
        }
        else if (optlocunloading.Checked == true)
        {
            Response.Redirect("FTLSundryChoice.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=locunloading");
        }
    }

}

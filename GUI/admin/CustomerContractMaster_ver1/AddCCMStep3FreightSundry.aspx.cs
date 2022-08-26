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

public partial class AddCCMStep3FreightSundry : System.Web.UI.Page
{
    protected string contractid = "",custcode="";
    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {

        contractid = Request.QueryString["contractid"].ToString();
        custcode = Request.QueryString["custcode"].ToString();

        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }
        
        fn = new MyFunctions();
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

      

        HidTL.Value = Request.QueryString["TL"].ToString();
        HidFTL.Value = Request.QueryString["FTL"].ToString();
        HidODA.Value = Request.QueryString["ODA"].ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (radSingle.Checked == true)
            updateSlabInfo("S");
        else
            updateSlabInfo("M");
        
        if (radSingle.Checked == true)
        {
            Response.Redirect("AddCCMStep3ASSC.aspx?contractid=" + contractid + "&custcode=" + custcode + "&Slab=S" + "&FTL=" + HidFTL.Value + "&ODA=" + HidODA.Value);
        }
        else
        {
            Response.Redirect("AddCCMStep3BMSC.aspx?contractid=" + contractid + "&custcode=" + custcode + "&Slab=M" + "&FTL=" + HidFTL.Value + "&ODA=" + HidODA.Value);
        }
    }

    private void updateSlabInfo(string flag)
    {

        string str = "";
        if (flag.CompareTo("M") == 0)
            str = "UPDATE webx_custcontract_hdr SET multiple_slab_yn = 'Y',single_slab_yn='N' WHERE custcode = '" + custcode + "'";
        else
            str = "UPDATE webx_custcontract_hdr SET multiple_slab_yn = 'N',single_slab_yn='Y' WHERE custcode = '" + custcode + "'";

        SqlCommand sqlCommand = new SqlCommand(str, con);
        sqlCommand.ExecuteNonQuery();
    }
}

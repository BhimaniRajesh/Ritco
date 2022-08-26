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

public partial class SundrySlabSelection : System.Web.UI.Page
{
    protected string contractid = "", custcode = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["ContractID"].ToString();
        
        cstheader.CustCode = custcode;
        cstheader.ContractID = contractid;
        
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }

        if (!IsPostBack)
        {
            PopulateHiddenVars();
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (optsingle.Checked == true)
            updateSlabInfo("S");
        else
            updateSlabInfo("M");

        if (optsingle.Checked == true)
            Response.Redirect("MatrixSelection.aspx?servicecode=1.1" + "&contractid=" + contractid + "&custcode=" + custcode);
        else if (optmultiple.Checked == true)
            Response.Redirect("MatrixSelection.aspx?servicecode=1.2" + "&contractid=" + contractid + "&custcode=" + custcode);
        else if (optrange.Checked == true)
            Response.Redirect("MultipleSlabSundryRange.aspx?servicecode=1.2" + "&contractid=" + contractid + "&custcode=" + custcode);
    }

    private void updateSlabInfo(string flag)
    {

        string strsql = "";
        if (flag.CompareTo("M") == 0 || flag.CompareTo("R") == 0)
            strsql = "UPDATE webx_custcontract_hdr SET multiple_slab_yn = 'Y',single_slab_yn='N' WHERE contractid='" + contractid + "'";
        else
            strsql = "UPDATE webx_custcontract_hdr SET multiple_slab_yn = 'N',single_slab_yn='Y' WHERE contractid='" + contractid + "'";

        SqlCommand sqlCommand = new SqlCommand(strsql, con);
        sqlCommand.ExecuteNonQuery();
    }

    private void PopulateHiddenVars()
    {
        string strsql = "SELECT ISNULL(single_slab_yn, 'N') AS singleslab, ISNULL(multiple_slab_yn, 'N') AS multipleslab FROM webx_custcontract_hdr WHERE  contractid='" + contractid + "'";

        SqlCommand cmd = new SqlCommand(strsql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["singleslab"].ToString().Trim().CompareTo("Y") == 0)
            {
                optsingle.Checked = true;
            }
            else if (dr["multipleslab"].ToString().Trim().CompareTo("Y") == 0)
            {
                optmultiple.Checked = true;
            }
            else
            {
                optsingle.Checked = false;
                optmultiple.Checked = false;
            }

        }
        dr.Close();
    }
}

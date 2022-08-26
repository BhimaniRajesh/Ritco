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

public partial class EditCCMStep3FreightSundry : System.Web.UI.Page
{
    protected string contractid = "", custcode = "";
    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {


        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["ContractID"].ToString();

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

        if (!IsPostBack)
        {
            PopulateHiddenVars();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (radSingle.Checked == true)
            updateSlabInfo("S");
        else
            updateSlabInfo("M");

        if (radSingle.Checked == true)
            Response.Redirect("EditCCMStep3ASSC.aspx?&Slab=S" + "&contractid=" + contractid + "&custcode=" + custcode);
        else
            Response.Redirect("EditCCMStep3BMSC.aspx?Slab=M" + "&contractid=" + contractid + "&custcode=" + custcode);
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

    private void PopulateHiddenVars()
    {
        string strSQL = "SELECT ISNULL(single_slab_yn, 'N') AS singleslab, ISNULL(multiple_slab_yn, 'N') AS MultipleSlab from WEBX_CUSTCONTRACT_HDR where custcode = '" + custcode + "'";

            SqlCommand cmd = new SqlCommand(strSQL,con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr["singleslab"].ToString().Trim().CompareTo("Y") == 0)
                {
                    radSingle.Checked = true;
                }
                else if (dr["multipleslab"].ToString().Trim().CompareTo("Y") == 0)
                {
                    radMultiple.Checked = true;
                }
                else
                {
                    radMultiple.Checked = false;
                    radSingle.Checked = false;
                }

            }
            dr.Close();
    }
}

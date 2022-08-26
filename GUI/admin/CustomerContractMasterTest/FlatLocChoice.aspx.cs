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

public partial class MultiPointChoice : System.Web.UI.Page
{
    protected string contractid = "", custcode = "", requestid = "";
    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {

        requestid = Request.QueryString["requestid"].ToString().ToUpper();
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["ContractID"].ToString();

        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = Request.QueryString["contractid"].ToString();
        
        if (requestid.ToUpper().CompareTo("LOADING") == 0)
        {
            lblstepfname.Text = " Loading ";
            lblsteplname.Text = " Loading ";
            lblstepname.Text = " Loading ";
        }
        else if (requestid.ToUpper().CompareTo("UNLOADING") == 0)
        {
            lblstepfname.Text = " UnLoading ";
            lblsteplname.Text = " UnLoading ";
            lblstepname.Text = " UnLoading ";
        }
        else if (requestid.ToUpper().CompareTo("MULTIPOINT") == 0)
        {
            lblstepfname.Text = " MultiPoint ";
            lblsteplname.Text = " MultiPoint ";
            lblstepname.Text = " MultiPoint ";
        }

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

        if (!IsPostBack)
        {
            PopulateHiddenVars();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (radSingle.Checked == true)
            updateSlabInfo("F");
        else
            updateSlabInfo("L");

        if (radSingle.Checked == true)
            Response.Redirect("FlatMultiPointCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
        else
            Response.Redirect("MultiPointCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
    }

    private void updateSlabInfo(string flag)
    {
      
        string str = "";
        if (flag.CompareTo("F") == 0)
            str = "UPDATE webx_custcontract_hdr SET flatmultipoint_yn='Y',locmultipoint_yn='N' WHERE contractid = '" + contractid + "'";
        else
            str = "UPDATE webx_custcontract_hdr SET flatmultipoint_yn='N',locmultipoint_yn='Y' WHERE contractid = '" + contractid + "'";

        SqlCommand sqlCommand = new SqlCommand(str, con);
        sqlCommand.ExecuteNonQuery();
    }

    private void PopulateHiddenVars()
    {
        string strSQL = "SELECT ISNULL(locmultipoint_yn, 'N') AS locwise, ISNULL(flatmultipoint_yn, 'N') AS flat from webx_custcontract_hdr WHERE contractid = '" + contractid + "'";

            SqlCommand cmd = new SqlCommand(strSQL,con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr["flat"].ToString().Trim().CompareTo("Y") == 0)
                {
                    radSingle.Checked = true;
                }
                else if (dr["locwise"].ToString().Trim().CompareTo("Y") == 0)
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

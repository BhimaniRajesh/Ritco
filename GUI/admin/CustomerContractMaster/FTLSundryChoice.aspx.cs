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

        requestid = Request.QueryString["requestid"].ToString();
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["ContractID"].ToString();



        if (!IsPostBack)
        {
            try
            {
                con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();
                int c = 0;
                string sqlstr = "SELECT sundry_yn,ftl_yn FROM webx_custcontract_charge WHERE custcode='" + custcode + "'";
                SqlCommand cmd = new SqlCommand(sqlstr, con);
                SqlDataReader dr=cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (dr["sundry_yn"].ToString().CompareTo("Y") == 0)
                    {
                        trsundry.Style["display"] = "block";
                        optsundry.Checked = true;
                        c++;
                    }

                    if (dr["ftl_yn"].ToString().CompareTo("Y") == 0)
                    {
                        trftl.Style["display"] = "block";
                        optftl.Checked = true;
                        c++;
                    }
                }
                dr.Close();

                if (c == 0)
                {
                    Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=Improper Contract Entered");
                    return;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=Improper Contract Entered");
            }
        }
        fn = new MyFunctions();
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (optsundry.Checked == true)
        {
            if (requestid.ToUpper().CompareTo("FLATLOADING") == 0)
                Response.Redirect("FlatMultiPointCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (requestid.ToUpper().CompareTo("FLATUNLOADING") == 0)
                Response.Redirect("FlatMultiPointCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (requestid.ToUpper().CompareTo("LOCLOADING") == 0)
                Response.Redirect("LoadingSundryCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (requestid.ToUpper().CompareTo("LOCUNLOADING") == 0)
                Response.Redirect("UnLoadingSundryCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);

        }
        else if (optftl.Checked == true)
        {
            if (requestid.ToUpper().CompareTo("FLATLOADING") == 0)
                Response.Redirect("FlatMultiPointCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (requestid.ToUpper().CompareTo("FLATUNLOADING") == 0)
                Response.Redirect("FlatMultiPointCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (requestid.ToUpper().CompareTo("LOCLOADING") == 0)
                Response.Redirect("LoadingFTLCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
            else if (requestid.ToUpper().CompareTo("LOCUNLOADING") == 0)
                Response.Redirect("UnLoadingFTLCharges.aspx?contractid=" + contractid + "&custcode=" + custcode);
        }
    }

    private void updateSlabInfo(string flag)
    {
      
        string str = "";
        if (flag.CompareTo("F") == 0)
            str = "UPDATE webx_custcontract_hdr SET flatmultipoint_yn = 'Y',locmultipoint_yn='N' WHERE custcode = '" + custcode + "'";
        else
            str = "UPDATE webx_custcontract_hdr SET flatmultipoint_yn = 'N',locmultipoint_yn='Y' WHERE custcode = '" + custcode + "'";

        SqlCommand sqlCommand = new SqlCommand(str, con);
        sqlCommand.ExecuteNonQuery();
    }

}

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
using System.Data.SqlClient;

public partial class GUI_admin_CustomerContractMaster_StepSelection : System.Web.UI.Page
{
    string custcode, contractid;
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();

        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = Request.QueryString["contractid"].ToString();

        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();


        string strsundry = "N", strftl = "N", strflatmultipoint = "N", stroda = "N", strflatloading = "N", strflatunloading = "N";
        string strlocmultipoint = "N", strlocloading = "N", strlocunloading = "N";

        string sqlstr = "";
        SqlCommand cmd;
        SqlDataReader dr;

        sqlstr = "SELECT * FROM webx_custcontract_hdr h,webx_custcontract_charge c";
        sqlstr = sqlstr + " WHERE h.contractid=c.contractid AND h.contractid='" + contractid + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            strsundry = Convert.ToString(dr["sundry_yn"]);
            strftl = Convert.ToString(dr["ftl_yn"]);
            strflatmultipoint = Convert.ToString(dr["flatmultipickup_yn"]);
            strflatloading = Convert.ToString(dr["flatloading_yn"]);
            strflatunloading = Convert.ToString(dr["flatunloading_yn"]);
            strlocmultipoint = Convert.ToString(dr["locmultipickup_yn"]);
            strlocloading = Convert.ToString(dr["locloading_yn"]);
            strlocunloading = Convert.ToString(dr["locunloading_yn"]);
            stroda = Convert.ToString(dr["oda_yn"]);
        }
        dr.Close();

        sqlstr = "SELECT defaultvalue FROM webx_rules_docket WHERE code='FLAG_MULTI_PICKUPDEL'";
        cmd = new SqlCommand(sqlstr, con);
        string flag_multi = Convert.ToString(cmd.ExecuteScalar());
        if (flag_multi.CompareTo("Y") != 0)
        {
            strflatunloading = "N";
            strlocunloading = "N";

            strflatloading = "N";
            strlocloading = "N";

            strflatmultipoint = "N";
            strlocmultipoint = "N";
        }


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
        if (optintro.Checked == true)
        {
            Server.Transfer("CCMStep1.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optservices.Checked == true)
        {
            Server.Transfer("CCMStep2.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optcharges.Checked == true)
        {
            Server.Transfer("CCMStep3.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optsundry.Checked == true)
        {
            Server.Transfer("SundrySlabSelection.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optftl.Checked == true)
        {
            Server.Transfer("MatrixSelection.aspx?servicecode=2.1&custcode=" + custcode + "&contractid=" + contractid);
        }
        else if (optoda.Checked == true)
        {
            Server.Transfer("EditCCMODA.aspx?custcode=" + custcode + "&contractid=" + contractid);
        }

        else if (optflatmultipoint.Checked == true)
        {
            Server.Transfer("FlatMultiPointCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=flatmultipoint");
        }
        else if (optflatloading.Checked == true)
        {
            Server.Transfer("FlatLoadingCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=flatloading");
        }
        else if (optflatunloading.Checked == true)
        {
            Server.Transfer("FlatUnLoadingCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=flatunloading");
        }
        else if (optlocmultipoint.Checked == true)
        {
            Server.Transfer("MultiPointCharges.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=locmultipoint");
        }
        else if (optlocloading.Checked == true)
        {
            Server.Transfer("LoadingUnLoadingSundryFTLSelection.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=locloading");
        }
        else if (optlocunloading.Checked == true)
        {
            Server.Transfer("LoadingUnLoadingSundryFTLSelection.aspx?custcode=" + custcode + "&contractid=" + contractid + "&requestid=locunloading");
        }
       
    }

}

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

public partial class GUI_Finance_Billing_BillEdit_BringBillDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
  
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();
        string desc = "";

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
        if (mode.CompareTo("EmpCode") == 0)
            qry = "select EmpId from WebX_Master_Users WITH(NOLOCK)";
        else if (mode.CompareTo("AccCode") == 0)
            qry = "select distinct company_Acccode,Accdesc from webx_acctinfo WITH(NOLOCK)";
        else if (mode.CompareTo("Manualbill") == 0)
            qry = "select Manual_Voucherno from webx_vouchertrans_arch WITH(NOLOCK) where Manual_Voucherno != 'NA'";
        else if (mode.CompareTo("DKT") == 0)
            //qry = "select DOCKNO from webx_trans_docket_status WITH(NOLOCK) where isnull(Cancelled,'N') = 'N' and SP_Vrno is null and SP_VrAmt is null and DOCKNO = '" + code + "'";
            qry = "select DOCKNO from webx_trans_docket_status WITH(NOLOCK) where isnull(Cancelled,'N') = 'N' and DOCKNO = '" + code + "'";
        else if (mode.CompareTo("PRS") == 0 || mode.CompareTo("DRS") == 0)
            //qry = "select PDCNO from webx_PDCHDR WITH(NOLOCK) where isnull(Cancelled,'N') = 'N' and SP_Vrno is null and SP_VrAmt is null and PDCNO = '" + code + "'";
            qry = "select PDCNO from webx_PDCHDR WITH(NOLOCK) where isnull(Cancelled,'N') = 'N' and PDCNO = '" + code + "'";
        else if (mode.CompareTo("THC") == 0)
            //qry = "select THCNO from webx_THC_SUMMARY WITH(NOLOCK) where isnull(Cancelled,'N') = 'N' and SP_Vrno is null and SP_VrAmt is null and THCNO = '" + code + "'";
            qry = "select THCNO from webx_THC_SUMMARY WITH(NOLOCK) where isnull(Cancelled,'N') = 'N' and THCNO = '" + code + "'";
        else if (mode.CompareTo("TRP") == 0)
            //qry = "select vslipno from WEBX_FLEET_VEHICLE_ISSUE WITH(NOLOCK) where SP_Vrno is null and SP_VrAmt is null and vslipno = '" + code + "'";
            qry = "select vslipno from WEBX_FLEET_VEHICLE_ISSUE WITH(NOLOCK) where vslipno = '" + code + "'";
        else
            qry = "SELECT loccode FROM webx_location";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
            while (dr.Read())
            {
              if(dr[0].ToString().CompareTo(code)==0)
              {
                  if (mode.CompareTo("AccCode") == 0)
                  {
                      desc = dr[1].ToString();
                      i = 1;
                      break;
                  }
                  i = 1;
                  break;
              }
            }
            dr.Close();

       if(i==0)
           Response.Write("false|");
       else if (i == 1)
           Response.Write("true|" + desc + "|");

        con.Close();
    }
 
}

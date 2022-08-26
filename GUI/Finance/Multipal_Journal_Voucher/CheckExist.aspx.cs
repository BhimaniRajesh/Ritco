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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Billing_BillEdit_BringBillDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
  
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();
        string desc = "";

        double count = 0;
        hdnbrcdcheck.Value = "N";
        count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select count(*) from webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'"));
        if (count > 0)
        {
            hdnbrcdcheck.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N from webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'").ToString();
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
        if (mode.CompareTo("EmpCode") == 0)
            qry = "select EmpId from WebX_Master_Users WITH(NOLOCK)";
        else if (mode.CompareTo("AccCode") == 0 && hdnbrcdcheck.Value.CompareTo("N") == 0)
            qry = "select distinct company_Acccode,Accdesc from webx_acctinfo WITH(NOLOCK) where acccategory not in('BANK','CASH')";
        else if (mode.CompareTo("AccCode") == 0 && hdnbrcdcheck.Value.CompareTo("Y") == 0)
            qry = "select distinct company_Acccode,Accdesc from webx_acctinfo WITH(NOLOCK) where acccategory not in('BANK','CASH') and (brcd like 'All' or PATINDEx ('%" + SessionUtilities.CurrentBranchCode + "%',brcd)>0)";
        else if (mode.CompareTo("Manualbill") == 0)
            qry = "select Manual_Voucherno from webx_vouchertrans_arch WITH(NOLOCK) where Manual_Voucherno != 'NA'";
        else if (mode.CompareTo("CheckPartPO") == 0)
            qry = "select docno from WEBX_PAYMENT_VOUCHERTRANS WITH(NOLOCK) where vouchertype='Part PO'";
        else if (mode.CompareTo("Customer") == 0)
            qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where custcd = '" + code + "'";
        else if (mode.CompareTo("Vendor") == 0)
            qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) where vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) and vendorCode = '" + code + "'";
        else if (mode.CompareTo("Employee") == 0)
            qry = "select userid,name from webx_master_users  WITH(NOLOCK) where status='100' and userid = '" + code + "'";
        else if (mode.CompareTo("Driver") == 0)
            qry = "select Manual_Driver_Code,Driver_Name from webx_fleet_drivermst WITH(NOLOCK) where ActiveFlag='Y' and Manual_Driver_Code='" + code + "'";
        else if (mode.CompareTo("Vehicle") == 0)
            qry = "select Vehno as Vehicleno,Vehno as Vehiclename from webx_vehicle_hdr WITH(NOLOCK) where ActiveFlag='Y' and PATINDEx ('%" + Session["brcd"].ToString() + "%',Conrtl_branch)>0 and Vehno='" + code + "'";
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
                  if (mode.CompareTo("Customer") == 0 || mode.CompareTo("Vendor") == 0 || mode.CompareTo("Employee") == 0 || mode.CompareTo("Driver") == 0 || mode.CompareTo("Vehicle") == 0)
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

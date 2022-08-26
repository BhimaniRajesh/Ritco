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
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();
        string desc = "", Pbov_type ="" ,VendorCode = "";
        
        double count = 0;
        hdnbrcdcheck.Value = "N";
        count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select count(*) from webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'"));
        if (count > 0)
        {
            hdnbrcdcheck.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N from webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'").ToString();
        }
        if (mode.CompareTo("PanNo") == 0)
        {
            Pbov_type = Request.QueryString["Pbov_type"].ToString();
            VendorCode = Request.QueryString["VendorCode"].ToString();
        }
        
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
        if (mode.CompareTo("EmpCode") == 0)
            qry = "select EmpId from WebX_Master_Users WITH(NOLOCK)";
        else if (mode.CompareTo("AccCode") == 0 && hdnbrcdcheck.Value.CompareTo("N") == 0)
            qry = "select distinct company_Acccode,Accdesc from webx_acctinfo where acccategory not in('CASH','BANK') AND Company_acccode='" + code + "'";
        else if (mode.CompareTo("AccCode") == 0 && hdnbrcdcheck.Value.CompareTo("Y") == 0)
            qry = "select distinct company_Acccode,Accdesc from webx_acctinfo where acccategory not in('CASH','BANK') AND Company_acccode='" + code + "' and (brcd like 'All' or PATINDEx ('%" + SessionUtilities.CurrentBranchCode + "%',brcd)>0)";
        else if (mode.CompareTo("Manualbill") == 0)
            qry = "select Manual_Voucherno from webx_vouchertrans_arch WITH(NOLOCK) where Manual_Voucherno != 'NA'";
        else if (mode.CompareTo("PanNo") == 0 && Pbov_type.CompareTo("V") == 0)
            qry = "SELECT UPPER(PAN_NO),VENDORCODE FROM WEBX_VENDOR_HDR WHERE PAN_NO='" + code + "' and VENDORCODE='" + VendorCode + "'";
        else if (mode.CompareTo("chq") == 0)
        {
            string[] codearr = code.Split(',');
            qry = "select chqamt,adjustamt,banknm from webx_chq_det where chqno='" + codearr[0] + "' and convert(varchar,chqdt,106)=convert(datetime,'" + fn.Mydate1(codearr[1]) + "',106)";
        }
        else
            qry = "SELECT loccode FROM webx_location";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
            while (dr.Read())
            {
              //string panno = dr[0].ToString();
              if(dr[0].ToString().CompareTo(code)==0)
              {
                  if (mode.CompareTo("AccCode") == 0 || mode.CompareTo("PanNo") == 0)
                  {
                      desc = dr[1].ToString();
                      i = 1;
                      break;
                  }
                  i = 1;
                  break;
                  
              }
              if (mode.CompareTo("chq") == 0)
              {
                  desc = "Duplicate Cheque No Entered";
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

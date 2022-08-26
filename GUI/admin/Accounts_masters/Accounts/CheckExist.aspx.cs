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
        string value = Request.QueryString["val"].ToString();
        string accode = Request.QueryString["accode"].ToString();
        string desc = "";

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
        if (mode.CompareTo("EmpCode") == 0)
            qry = "select EmpId from WebX_Master_Users WITH(NOLOCK)";
        else if (mode.CompareTo("AccCode") == 0 && value.CompareTo("new") == 0)
            qry = "select distinct company_Acccode,Acccode,Accdesc from webx_acctinfo WITH(NOLOCK)";
        else if (mode.CompareTo("AccCode") == 0 && value.CompareTo("edit") == 0)
            qry = "select distinct company_Acccode,Acccode,Accdesc from webx_acctinfo WITH(NOLOCK) where Acccode != '" + accode + "'";
        else if (mode.CompareTo("Acccategory") == 0 && value.CompareTo("new") == 0)
            qry = "select distinct Acccategory,Acccategory as Acccategory from webx_Acccategory_master WITH(NOLOCK)";
        else if (mode.CompareTo("Acccategory") == 0 && value.CompareTo("edit") == 0)
            qry = "select distinct Acccategory,Acccategory as Acccategory from webx_Acccategory_master WITH(NOLOCK) where Acccategory != '" + accode + "'";
        else if (mode.CompareTo("Manualbill") == 0)
            qry = "select Manual_Voucherno from webx_vouchertrans_arch WITH(NOLOCK) where Manual_Voucherno != 'NA'";
        else if (mode.CompareTo("CheckPartPO") == 0)
            qry = "select docno from WEBX_PAYMENT_VOUCHERTRANS WITH(NOLOCK) where vouchertype='Part PO'";
        else if (mode.CompareTo("CheckBalPO") == 0)
            qry = "select docno from WEBX_PAYMENT_VOUCHERTRANS WITH(NOLOCK) where vouchertype='Balance PO'";
        else
            qry = "SELECT loccode FROM webx_location";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
            while (dr.Read())
            {
              if(dr[0].ToString().CompareTo(code) == 0)
              {
                  if (mode.CompareTo("AccCode") == 0)
                  {
                      desc = "Selected Manual Code Is Already Used As Manual Code";
                      i = 1;
                      break;
                  }
                  if (mode.CompareTo("Acccategory") == 0)
                  {
                      desc = "Selected Account Category Is Already Used";
                      i = 1;
                      break;
                  }
                  
                  i = 1;
                  break;
                  
              }
              if (dr[1].ToString().CompareTo(code) == 0)
              {
                  if (mode.CompareTo("AccCode") == 0)
                  {
                      desc = "Selected Manual Code Is Already Used As System Code";
                      i = 1;
                      break;
                  }
                  if (mode.CompareTo("Acccategory") == 0)
                  {
                      desc = "Selected Account Category Is Already Used";
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

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
        string chqno = "";
        string chqdt = "";    
        string mode = Request.QueryString["mode"].ToString();
        if (mode.CompareTo("chq") == 0)
        {
            chqno = Request.QueryString["code"].ToString();
            chqdt = Request.QueryString["chqdt"].ToString();
        }
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
        else if (mode.CompareTo("CheckPartPO") == 0)
            qry = "select docno from WEBX_PAYMENT_VOUCHERTRANS WITH(NOLOCK) where vouchertype='Part PO'";
        else if (mode.CompareTo("CheckBalPO") == 0)
            qry = "select docno from WEBX_PAYMENT_VOUCHERTRANS WITH(NOLOCK) where vouchertype='Balance PO'";
        else if (mode.CompareTo("chq") == 0)
            //qry = "select chqno,chqdt from webx_billchqdetail WITH(NOLOCK) where chqno='" + chqno + "' and convert(varchar,chqdt,103)='" + chqdt + "'";
            qry = "select a.chqno,convert(varchar,a.chqdt,106) as chqdt from webx_billchqdetail a where (a.chqno='" + chqno + "' and a.chqdt=convert(datetime,'" + chqdt + "',103)) or (a.chqno in(select b.chqno from webx_chq_det b where b.chqno='" + chqno + "' and b.chqdt=convert(datetime,'" + chqdt + "',103)) and a.chqdt in(select b.chqdt from webx_chq_det b where b.chqno='" + chqno + "' and b.chqdt=convert(datetime,'" + chqdt + "',103)))";
        else
            qry = "SELECT loccode,locname FROM webx_location where ActiveFlag='Y' and loccode='" + code + "'";

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
                  else
                  {
                      i = 1;
                      desc = dr[1].ToString();
                      break;
                  }
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

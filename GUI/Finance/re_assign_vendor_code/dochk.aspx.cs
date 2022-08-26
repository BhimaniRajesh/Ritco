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

public partial class GUI_Finance_re_assign_vendor_code_dochk : System.Web.UI.Page
{
    public string sql,result = "",vehno,vendorCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        string dockno = Request.QueryString["dockno"].ToString();
        string Search = Request.QueryString["Search"].ToString();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        
        if(Search == "T")
        {
            sql = "select THCNO,vendorcode,vehno from webx_thc_summary where THCNO='" + dockno + "' and isNULL(advvoucherno,'')='' and isNULL(balvoucherno,'')='' and isNULL(VendorBENo,'')=''";
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr = cmd.ExecuteReader();
            Int16 cnt = 0;
            if(dr.Read())
            {
                Response.Write("OK");
                result = "OK";
                dockno = dr["THCNO"].ToString();
                vendorCode = dr["vendorcode"].ToString();
                vehno = dr["vehno"].ToString();
            }
            else
            {
                Response.Write("Invalid THC No.");
            }
            dr.Close();

        }
        else if(Search == "PD")
        {
            sql = "select PDCNO,vendorcode,VEHNO from webx_PDCHDR where PDCNO='" + dockno + "' and isNULL(adv_voucherno,'')='' and isNULL(bal_voucherno,'')=''";
            SqlDataReader dr1;
            SqlCommand cmd1 = new SqlCommand(sql, conn);
            dr1 = cmd1.ExecuteReader();
            Int16 cnt = 0;
            if (dr1.Read())
            {
                Response.Write("OK");
                result = "OK";
                dockno = dr1["PDCNO"].ToString();
                vendorCode = dr1["vendorcode"].ToString();
                vehno = dr1["VEHNO"].ToString();
            }
            else
            {
                Response.Write("Invalid PDC No.");
            }
            dr1.Close();
        }
        Response.Write(result + "|" + dockno + "|" + vendorCode + "|" + vehno + "|");
    }
}

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

public partial class wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Request.QueryString["ConnStr"].ToString();
        if (Request.QueryString["Function"] == "CheckBillNumber") { Response.Write(CheckBillNumber()); }
    }
   
    private string CheckBillNumber()
    {
        General gen = new General(str_Connection_String);
        gen.CheckBillNumber(Request.QueryString["VENDORCODE"].ToString(), Request.QueryString["BillNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y";
        }
        else
        {
            return "N";
        }
    }
}

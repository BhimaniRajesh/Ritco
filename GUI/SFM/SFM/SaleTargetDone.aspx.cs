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

public partial class SFM_SaleTargetDone : System.Web.UI.Page
{
    public static SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strSaleTargetCode = Request.QueryString.Get("SaleTargetCode");
       // string strProspectCode = Request.QueryString.Get("ProspectId");
        conn.Close();
    }
}

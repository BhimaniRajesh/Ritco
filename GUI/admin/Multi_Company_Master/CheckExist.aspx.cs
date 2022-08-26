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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_DD_Management_CheckExist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();

        string qry = "";
        double Count = 0;

        if (mode.CompareTo("LocCode") == 0)
            qry = "select distinct count(LocCode) from webx_location WITH(NOLOCK) where ActiveFlag='Y' and LocCode='" + code + "'";
        else if (mode.CompareTo("Company") == 0)
            qry = "select distinct count(COMPANY_CODE) from webx_company_master WITH(NOLOCK) where COMPANY_CODE='" + code + "'";
        else if (mode.CompareTo("EmpCode") == 0)
            qry = "select distinct count(UserId) from webx_master_users WITH(NOLOCK) where status='100' and UserId='" + code + "'";

        Count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, qry));

        if (Count > 0)
            Response.Write("true|");
        else
            Response.Write("false|");
    }
}

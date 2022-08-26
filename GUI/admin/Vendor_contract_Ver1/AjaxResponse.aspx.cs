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

public partial class GUI_admin_Vendor_contract_Ver1_AjaxResponse : System.Web.UI.Page
{
    string strFunction = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Function"] == "IsValidLocation") SendResult(IsValidLocation());
        if (Request.QueryString["Function"] == "IsValidCity") SendResult(IsValidCity());
    }

    private void SendResult(string strRes)
    {
        Response.Clear();
        Response.Write(strRes);
        Response.End();
    }
    private string IsValidLocation()
    {
        string strRet = "N";
        string strLoc = Request.QueryString["LocCode"].Trim();
        string Query = "Select Count(*) from WebX_Location Where LocCode='" + strLoc.ToString() + "' And ISNULL(ActiveFlag,'N')='Y'";

        object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Query);
        if (obj != null)
        {
            int cnt = Convert.ToInt32(obj);
            if (cnt > 0)
                strRet = "Y";           
        }

        return strRet;
    }

    private string IsValidCity()
    {
        string strRet = "N";
        string strLoc = Request.QueryString["City"].Trim();
        string Query = "SELECT Count(*) From WebX_CityMaster Where Location='" + strLoc + "' AND ISNULL(ActiveFlag,'N')='Y'";

        object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Query);
        if (obj != null)
        {
            int cnt = Convert.ToInt32(obj);
            if (cnt > 0)
                strRet = "Y";
        }

        return strRet;
    }
}

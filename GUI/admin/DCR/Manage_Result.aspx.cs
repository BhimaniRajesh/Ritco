using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_DCR_Manage_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string bookcode = Request.QueryString["BC"].ToString();
            string fromto = Request.QueryString["FROMTO"].ToString();
            string action = Request.QueryString["action"].ToString();

            lblBookCode.Text = bookcode;
            lblFromTo.Text = fromto;
            lblAction.Text = GetActionDesc(action);
        }
        catch (Exception ex)
        {

        }
    }

    private string GetActionDesc(string action)
    {
        string strRet = "";

        string query = "SELECT TOP 1 CodeDesc FROM WebX_Master_General Where CodeID='{0}' AND CodeType='DCRAC'";
        query = string.Format(query, action);

        object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, query);
        if (obj != null)
        {
            strRet = obj.ToString();
        }
        return strRet;
    }
}

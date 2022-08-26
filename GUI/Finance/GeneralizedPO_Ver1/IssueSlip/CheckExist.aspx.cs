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

public partial class GUI_Finance_GeneralizedPO_POGeneration_CheckExist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();

        if (code.ToString()!="")
        {
            string str = "SELECT ICODE,TotalAvailableQTY FROM WEBX_SKU_GRN_ISSUE_STOCK Where ICODE='" + code + "' AND BBRCD='" + SessionUtilities.CurrentBranchCode.ToString() + "'";
            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
            if (dt.Rows.Count > 0)
            {
                Response.Write("true|" + dt.Rows[0]["TotalAvailableQTY"].ToString() + "|");
            }
            else
            {
                Response.Write("false|");
            }  
        }
        else
        {
            Response.Write("true|");
        } 
        
    }
}

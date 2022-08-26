using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;
using WebX.Controllers;
/// <summary>
/// Summary description for ViewPrintController
/// </summary>
namespace WebX.Controllers
{
    public class ViewPrintController
    {
        public ViewPrintController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static string GetNavigationURL(string code)
        {
            string sqlstr = "SELECT navigationurl FROM webx_viewprint WHERE code='" + code + "' AND activeflag='Y'";
            string url = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            return url;
        }
    }

   
}

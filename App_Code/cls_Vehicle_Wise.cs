using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for cls_Vehicle_Wise
/// </summary>
public class cls_Vehicle_Wise : DataAccessLayer
{
    public static string strVehNo = "", strStartDt_From = "", strEndDt_To = "", strDriver = "", strCompany = "";

    public cls_Vehicle_Wise(string ConnectionString)
        : base(ConnectionString)
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

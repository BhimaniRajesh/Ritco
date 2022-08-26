using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Common
/// </summary>
public class Common : System.Web.UI.Page
{
	public Common()
	{
	}

    public void doCacheRoutine()
    {
        if (Session["empcd"] == null)
        {
            Server.Transfer("~/GUI/TimeOut.aspx");
        }
    }


}

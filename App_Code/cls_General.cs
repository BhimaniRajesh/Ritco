using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using ApplicationManager;
using System.Globalization;
using System.Threading;

/// <summary>
/// Summary description for cls_General
/// </summary>
public class cls_General
{
	public cls_General()
	{
		
	}

    public static bool IsDecimal(string theValue)
    {
        try
        {
            Convert.ToDecimal(theValue);
            return true;
        }
        catch
        {
            return false;
        }
    }

    public static bool IsDouble(string theValue)
    {
        try
        {
            Convert.ToDouble(theValue);
            return true;
        }
        catch
        {
            return false;
        }
    }

    public static bool IsInt(string theValue)
    {
        try
        {
            Convert.ToInt32(theValue);
            return true;
        }
        catch
        {
            return false;
        }
    }
}

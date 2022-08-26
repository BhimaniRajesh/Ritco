using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Caching;
using System.Text;
using System.Security.Cryptography;


/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    public const string ShowStyle = "MARKER";//Add By jalpa
    public const string HideStyle = "NONE";//Add By jalpa

    protected void CreateToken()
    {
        string token = new Guid().ToString();
        SessionUtilities.DuplicateToken = token;
        SessionUtilities.HiddenToken = token;
    }

    // Call this method to validate the token before continuing workflow.
    protected bool IsTokenValid()
    {
        string expectedToken = (string)SessionUtilities.DuplicateToken;
        if (expectedToken == null)
            return false;

        string actualToken = (string)SessionUtilities.HiddenToken;

        return expectedToken == actualToken;
    }

    // Call this method when the page submission is complete to prevent re-submission.
    protected void ConsumeToken()
    {
        SessionUtilities.DuplicateToken = null;
    }

	public BasePage()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

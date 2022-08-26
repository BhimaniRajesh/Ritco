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

public partial class GUI_UNI_MIS_RPT_Date : System.Web.UI.UserControl
{

    public string FinYear = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        FinYear = Session["FinYear"].ToString().Substring(2, 2);
    }
}

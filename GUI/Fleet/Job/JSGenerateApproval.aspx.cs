using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class GUI_Fleet_Webadmin_Job_JSApprovalAmt : System.Web.UI.Page
{
    string str_Connection_String;
    JobSheet objJs;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SqlProvider"] != null)
        {
            str_Connection_String = Convert.ToString(Session["SqlProvider"]);
            objJs = new JobSheet(str_Connection_String);
        }
        if (!IsPostBack)
        {
            objJs.BindLocationHierarchy(ddlLocationHierarchy);
        }
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        
    }
}

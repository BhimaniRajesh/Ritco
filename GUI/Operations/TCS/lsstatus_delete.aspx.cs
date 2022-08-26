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

public partial class GUI_Operations_TCS_lsstatus_delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        submit2.Attributes.Add("onclick", "javascript:return LSNo_Submit(" + lsno.ClientID + ")");
    }
    protected void submit2_Click(object sender, EventArgs e)
    {
        string lsno1 = lsno.Text;
        string final = "?lsno=" + lsno1;
        Response.Redirect("lsstatus_delete1.aspx" + final);
    }
}

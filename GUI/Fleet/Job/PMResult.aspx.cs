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

public partial class GUI_Fleet_Job_PMResult : System.Web.UI.Page
{
    string PM = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        PM = Request.QueryString["PMSCH_CODE"];
        lblDocNo.Text = PM;
    }
}

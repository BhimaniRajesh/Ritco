using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_ExternalThcDone : System.Web.UI.Page
{
    public static string ExternalThcnos = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        ExternalThcnos = Request.QueryString.Get("ExternalThcnos");
        lblExternalThcNo.Text = ExternalThcnos.ToString();
    }
}
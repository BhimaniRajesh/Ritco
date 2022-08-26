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

public partial class GUI_Operations_document_cancel_Document_Cancel_Done : System.Web.UI.Page
{
    public string errMsg = "";
    public string doctype;

    protected void Page_Load(object sender, EventArgs e)
    {
        doctype = Request.QueryString["doctype"].ToString();
    }
}

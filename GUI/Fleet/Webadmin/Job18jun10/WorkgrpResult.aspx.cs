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

public partial class GUI_Job_WorkgrpResult : System.Web.UI.Page
{
    string w_grpcd = "";
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
       w_grpcd=Request.QueryString["WGrp"];

      lblDocNo.Text = w_grpcd;
        if (!IsPostBack)
        {


        }



    }
}

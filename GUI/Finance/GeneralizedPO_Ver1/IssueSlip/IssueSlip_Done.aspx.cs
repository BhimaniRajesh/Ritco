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

public partial class GUI_finance_voucher_voucher_done : System.Web.UI.Page
{
    string IssueSlipNO = "" ;
    protected void Page_Load(object sender, EventArgs e)
    {
        IssueSlipNO = Request.QueryString["IssueSlipNo"];
        if (!Page.IsPostBack)
        {
            LblIssueSlipNo.Text = IssueSlipNO.ToString();
            LblIssueSlipNo.CssClass = "blackfnt";
        }
    }
}

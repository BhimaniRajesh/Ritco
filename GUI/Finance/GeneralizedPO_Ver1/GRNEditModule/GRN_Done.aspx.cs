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


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRN_Done : System.Web.UI.Page
{
    string GRNNO = "", vendorcd = "";
    MyFunctions fn = new MyFunctions();
    public static string ToolTip_Str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        GRNNO = Request.QueryString["GrnList"];
        
        if (!Page.IsPostBack)
        {
            lblDocName.Text = GRNNO;
            lblDocName.CssClass = "blackfnt";
        }
    }
}

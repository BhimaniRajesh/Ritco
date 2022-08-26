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

public partial class GUI_Operations_Crossing_CrossingChallanDone : System.Web.UI.Page
{
    string CrossingCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        CrossingCode = Request.QueryString["CrossingChallanNo"].ToString();
        lblCrossingChallanNo.Text = CrossingCode;
    }
}

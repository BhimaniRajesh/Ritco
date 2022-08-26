using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_NET_MIS_LRWiseCollection_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 26/5/2014
            DT.FindControl("radDate").Focus();
        }
    }
}

using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Mobile;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class MobileTrack : System.Web.UI.MobileControls.MobilePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
       Response .Redirect("MobileTrack_Result.aspx?RT="+listRefType.Selection.Value+"&DN="+txtNumber.Text);
    }
}

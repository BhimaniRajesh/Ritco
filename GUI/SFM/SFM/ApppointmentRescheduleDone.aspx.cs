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

public partial class SFM_ApppointmentRescheduleDone : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    public string Prospect1, Prospect2;
    protected void Page_Load(object sender, EventArgs e)
    {

        Prospect1 = Convert.ToString(Request.QueryString["Prospect1"]);
        Prospect2 = Convert.ToString(Request.QueryString["Prospect2"]);

        if (Prospect1 == "" || Prospect1 == null)
        {
            prospectid.Text = Prospect2;
            Panel2.Visible = true;
            Panel1.Visible = false;
        }
        if (Prospect2 == "" || Prospect2 == null)
        {
            ProspectCode.Text = Prospect1;
            Panel1.Visible = true;
            Panel2.Visible = false;
        }

    }
}

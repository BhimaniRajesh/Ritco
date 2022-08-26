using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["SqlProvider"] = "Data Source=202.87.45.69;Initial Catalog=WebXpress_New;UID=sa;pwd=!@ECfy#$";
        //Session["SqlProvider"] = "Data Source=ECFY110;Initial Catalog=Webxnet;UID=sa;pwd=sa";
    }
}

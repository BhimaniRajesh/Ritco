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

public partial class GUI_CustomerLogin_FrmStart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["SqlProvider"] = "Data Source=202.87.45.69;Initial Catalog=TLL.Net;UID=sa;pwd=!@ecfy#$";
        //Session["SqlProvider"] = "Data Source=192.168.0.3;Initial Catalog=TLL.Net;UID=sa;pwd=!@ecfy#$";
        Session["SqlProvider"] = "Data Source=192.168.0.14;Initial Catalog=Ritco_Live;UID=sa;pwd=SQL$Adm!n$123.";
        Session["DocketCalledAs"] = "Docket";
        Session["Client"] = "RITCO";
        Session["logofile"] = "WebXpress_logo.gif";
        Response.Redirect("~/GUI/CustomerLogin/FrmLogin.aspx");
    }
}

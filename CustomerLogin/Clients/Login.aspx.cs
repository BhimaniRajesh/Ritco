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

public partial class Clients_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Client"] = "RITCO";
        //Session["SqlProvider"] = "Data Source=localhost;Initial Catalog=Relog_Live_31July08;UID=sa;pwd=sa";
       // Session["SqlProvider"] = "Data Source=ECFY110\\SQLEXPRESS;Initial Catalog=RLL;Integrated Security=True;";
        Session["SqlProvider"] = "Data Source=localhost;Initial Catalog=Ritco_Live;UID=sa;pwd=R1i2T3c4O5;Max Pool Size=80000";
        

        Session["HeadOfficeCode"] = "HOO";
        Session["YearVal"] = "07_08";
        Session["CUSTCD"] = "07_08";
        Session["Dktlength"] = "7";
        Session["FinYearStart"] = "1 Apr " + Session["FinYear"];
        Session["FinYear"] = "08_09";
        Session["DocketCalledAs"] = "Docket";
        Session["logofile"] = "WebXpress_logo.gif";
        Session["THCCalledAs"] = "THC";
        Response.Redirect("~/CustomerLogin/GUI/default.aspx");
    }
}

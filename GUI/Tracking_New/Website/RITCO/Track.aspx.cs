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
public partial class GUI_Tracking_New_Webxsite_EXL_Track : System.Web.UI.Page
{
   
       
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Client"] = "RITCO";

        Session["SqlProvider"] = "Data Source=103.13.99.179;Initial Catalog=Ritco_Live;UID=RitcO;pwd=RitcO";
        string st_Docnolist = Request.QueryString.Get("strDckNo");
        //Response.Write("<br>st_Docnolist : " + st_Docnolist);
        //Response.Write("<br>DB : " + Session["SqlProvider"].ToString());
       // Response.End();
        Session["HeadOfficeCode"] = "HQTR";
        Session["YearVal"] = "07_08";
        Session["Dktlength"] = "7";
        Session["FinYearStart"] = "1 Apr " + Session["FinYear"];
        Session["logofile"] = "WebXpress_logo.jpg";
        Session["DocketCalledAs"] = "Docket";
        Session["THCCalledAs"] = "THC";
        string final;
        final = "?st_Docnolist=" + st_Docnolist;

        Response.Redirect("../DocketTrack.aspx" + final);
    }
}

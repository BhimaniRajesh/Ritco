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

public partial class AjaxResponse : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();

        if (Request.QueryString["Function"] == "CheckValidCityCode") { Response.Write(CheckValidCityCode()); }
        
       
    }

   

    private string CheckValidCityCode()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.City_Name = Request.QueryString["CityName"].ToString();
        objTs.CheckValidCityCode();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.city_code + "~"; } else { return "N~"; }
    }

   

}

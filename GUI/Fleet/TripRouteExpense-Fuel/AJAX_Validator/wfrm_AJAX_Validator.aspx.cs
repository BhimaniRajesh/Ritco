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

public partial class GUI_Fleet_TripRouteExpense_Fuel_wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckValidVehType") { Response.Write(CheckValidVehType()); }
    }
    private string CheckValidVehType()
    {
        TripRouteFuelExp objTRE = new TripRouteFuelExp(str_Connection_String);
        
        objTRE.ROUTE_CODE = Request.QueryString["RouteCode"].ToString();
        objTRE.Vehicle_Type_Code = Request.QueryString["FTLtype"].ToString();

        if (Request.QueryString["Id"].ToString() != "undefined")
        {
            objTRE.Id = Request.QueryString["Id"].ToString();
            objTRE.CheckValidVehType();
        }
        else
        {
            objTRE.Id = strNullVal;
            objTRE.CheckValidVehType();
        }
        if (objTRE.IsRecordFound == true)
        {
            return "Y~" + objTRE.Vehicle_Type_Code + "~";
        }
        else
        {
            return "N~";
        }
    }
}

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
        if (Request.QueryString["Function"] == "CheckValidVehicleType") { Response.Write(CheckValidVehicleType()); }
        if (Request.QueryString["Function"] == "CheckValidFuelType") { Response.Write(CheckValidFuelType()); }
    }
    private string CheckValidVehicleType()
    {
        cls_TripRouteExp objTRE = new cls_TripRouteExp(str_Connection_String);

        objTRE.ROUTE_CODE = Request.QueryString["RouteCode"].ToString();
        objTRE.EXP_RATE_CODE = "";
        objTRE.VEHICLE_TYPE = Request.QueryString["FTLtype"].ToString();
        objTRE.FULEXP_CODE = Request.QueryString["FueExp"].ToString();

        if (Request.QueryString["Id"].ToString() != "undefined")
        {
            objTRE.ID = Request.QueryString["Id"].ToString();
            objTRE.CheckValidVehicleType();
        }
        else
        {
            objTRE.ID = strNullVal;
            objTRE.CheckValidVehicleType();
        }
        if (objTRE.IsRecordFound == true)
        {
            return "Y~" + objTRE.VEHICLE_TYPE + "~"; 
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidFuelType()
    {
        cls_TripRouteExp objTRE = new cls_TripRouteExp(str_Connection_String);

        objTRE.ROUTE_CODE = Request.QueryString["RouteCode"].ToString();
        objTRE.EXP_RATE_CODE = "";
        objTRE.VEHICLE_TYPE = Request.QueryString["FTLtype"].ToString();
        objTRE.FULEXP_CODE = Request.QueryString["FueExp"].ToString();

        if (Request.QueryString["Id"].ToString() != "undefined")
        {
            objTRE.ID = Request.QueryString["Id"].ToString();
            objTRE.CheckValidFuelType();
        }
        else
        {
            objTRE.ID = strNullVal;
            objTRE.CheckValidFuelType();
        }
        if (objTRE.IsRecordFound == true)
        {
            return "Y~" + objTRE.FULEXP_CODE + "~"; 
        }
        else
        {
            return "N~";
        }
    }
}

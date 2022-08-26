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

public partial class GUI_Fleet_VehicleTracking_wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckValidVehNoRotate") { Response.Write(CheckValidVehNoRotate()); }
        if (Request.QueryString["Function"] == "checkLocation") { Response.Write(checkLocation()); }
        if (Request.QueryString["Function"] == "checkTSNumber") { Response.Write(checkTSNumber()); }
        
        
    }
    private string CheckValidVehNoRotate()
    {
        cls_VehicllTracking obj_VehicllTracking = new cls_VehicllTracking(str_Connection_String);
        obj_VehicllTracking.CheckValidVehNo(Request.QueryString["VehNo"].ToString());
        if (obj_VehicllTracking.IsRecordFound == true)
        {
            return "Y~" + obj_VehicllTracking.VehNo + "~" + obj_VehicllTracking.VEH_INTERNAL_NO + "~" + obj_VehicllTracking.CURRENT_KM_READ + "~" + obj_VehicllTracking.VSLIPNO + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string checkLocation()
    {
        cls_VehicllTracking obj_VehicllTracking = new cls_VehicllTracking(str_Connection_String);
        obj_VehicllTracking.checkLocation(Request.QueryString["Location"].ToString());
        if (obj_VehicllTracking.IsRecordFound == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }
    private string checkTSNumber()
    {
        cls_VehicllTracking obj_VehicllTracking = new cls_VehicllTracking(str_Connection_String);
        obj_VehicllTracking.checkTSNumber(Request.QueryString["VehNo"].ToString(), Request.QueryString["TSNo"].ToString());
        if (obj_VehicllTracking.IsRecordFound == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }
    
}

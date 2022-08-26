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

public partial class GUI_Fleet_Tyre_Tyre_Tracking_wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "GetTyreNo") { Response.Write(GetTyreNo()); }
        if (Request.QueryString["Function"] == "GetVehNo") { Response.Write(GetVehNo()); }
    }

    private string GetTyreNo()
   {
        cls_Tyre_Tracking tyre = new cls_Tyre_Tracking(str_Connection_String);
        tyre.TYRE_NO = Request.QueryString["TYRE_NO"].ToString();
        tyre.CheckTyreNo();
        if (tyre.IsRecordFound == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }


    private string GetVehNo()
    {
        cls_Tyre_Tracking vehno = new cls_Tyre_Tracking(str_Connection_String);
        vehno.TYRE_VEHNO = Request.QueryString["TYRE_VEHNO"].ToString();
        vehno.CheckVehNo();
        if (vehno.IsRecordFound == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }
}

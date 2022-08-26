using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_KPI_Master_Ajax_Validation_AjaxResponse : System.Web.UI.Page
{
    string str_Connection_String = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();

        if (Request.QueryString["Function"] == "CheckVehicle") { Response.Write(CheckVehicle()); }
        if (Request.QueryString["Function"] == "CheckTyre_KM") { Response.Write(CheckTyre_KM()); }
    }
    private string CheckVehicle()
    {
        cls_TyreIssueMaster objJs = new cls_TyreIssueMaster(str_Connection_String);
        objJs.VEH_NO = Request.QueryString["VEH_NO"].ToString();
        objJs.CheckValidVehicle();
        
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.VEH_NO ; } else { return "N~"; }

        // if (objJs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }

    private string CheckTyre_KM()
    {
        cls_TyreIssueMaster objJs = new cls_TyreIssueMaster(str_Connection_String);
        objJs.VEH_NO = Request.QueryString["VEH_NO"].ToString();
        objJs.Check_KM();

        if (objJs.IsRecordFound == true) { return "Y~" + objJs.KM; } else { return "N~"; }
    } 

}
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

        if (Request.QueryString["Function"] == "Check_Vendor") { Response.Write(Check_Vendor()); }
        if (Request.QueryString["Function"] == "Check_RemoldNO") { Response.Write(Check_RemoldNO()); }
        if (Request.QueryString["Function"] == "Check_BillNO") { Response.Write(Check_BillNO()); }
        
    }
    private string Check_Vendor()
    {
        cls_TyreIssueMaster objJs = new cls_TyreIssueMaster(str_Connection_String);
        objJs.Tyre_Vendor = Request.QueryString["VENDOR"].ToString();

        objJs.CheckValidVendor();
        
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.Tyre_Vendor ; } else { return "N~"; }

        // if (objJs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }

    private string Check_RemoldNO()
    {
        cls_TyreIssueMaster objJs = new cls_TyreIssueMaster(str_Connection_String);
        objJs.CLAIM_REMOLD_SALE_ID = Request.QueryString["RemoldNO"].ToString();

        objJs.CheckValidRemoldNO();

        if (objJs.IsRecordFound == true) { return "Y~" + objJs.CLAIM_REMOLD_SALE_ID; } else { return "N~"; }

        // if (objJs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }

    private string Check_BillNO()
    {
        cls_TyreIssueMaster objJs = new cls_TyreIssueMaster(str_Connection_String);
        objJs.BILL_NO = Request.QueryString["BILLNO"].ToString();

        objJs.CheckValid_BILLNO();

        if (objJs.IsRecordFound == true) { return "Y~" + objJs.BILL_NO; } else { return "N~"; }

        // if (objJs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    } 
}
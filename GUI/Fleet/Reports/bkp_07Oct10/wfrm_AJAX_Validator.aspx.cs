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

public partial class wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Request.QueryString["ConnStr"].ToString();
        if (Request.QueryString["Function"] == "GetTyreDetRepoTyrePosChangeHis") { Response.Write(GetTyreDetRepoTyrePosChangeHis()); }
        if (Request.QueryString["Function"] == "CheckValidVehNo") { Response.Write(CheckValidVehNo()); }
    }

    private string GetTyreDetRepoTyrePosChangeHis()
    {
        cls_ReportTyrePosChangeHistory cRepoTyreDet = new cls_ReportTyrePosChangeHistory(str_Connection_String);
        cRepoTyreDet.TyreNo = Request.QueryString["TyreNo"].ToString();
        cRepoTyreDet.GetTyreDetails();
        if (cRepoTyreDet.Is_Record_Found == true)
        {
            return "Y~" + cRepoTyreDet.Manufacturer + "~" + cRepoTyreDet.TyreModel + "~" + cRepoTyreDet.TyreSize + "~" + cRepoTyreDet.TyrePattern + "~" + cRepoTyreDet.TyreType + "~" + cRepoTyreDet.TyreId;
        }
        else
        {
            return "N";
        }
    }
    private string CheckValidVehNo()
    {
        cls_DocumentEntry docEntry = new cls_DocumentEntry(str_Connection_String);
        docEntry.CheckValidVehNoRotate(Request.QueryString["VehNo"].ToString());
        if (docEntry.IsRecordFound == true)
        {
            return "Y~" + docEntry.VehNo + "~" + docEntry.VEH_INTERNAL_NO + "~" + docEntry.CURRENT_KM_READ + "~" + docEntry.VehType;
        }
        else
        {
            return "N";
        }
    }
}

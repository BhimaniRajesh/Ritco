using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for cls_DocumentRegisterVariable
/// </summary>
public class cls_DocumentRegisterVariable
{

    public static string strVehicleNumber = "", strVehicleType = "", strDocumentType = "";
    public static string strDocumentDescription = "",strDocumentNumber="",strRenewalAuturity="",strRenewalAuturityName="";
    public static string strStartDate = "", strExpiryDate = "", strCost="", strStates="",strScannedDocument="";

    public static string strVEHNO = "", strDOC_TYPE = "", strRENEW_AUTH = "", strEXP_STATUS = "", strEXP_DT = "", strOP_FORMAT = "", strExDt = "";

	public cls_DocumentRegisterVariable()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

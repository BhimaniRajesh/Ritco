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
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckVehNo") { Response.Write(CheckVehNo()); }
        if (Request.QueryString["Function"] == "CheckBillNumber") { Response.Write(CheckBillNumber()); }

        if (Request.QueryString["Function"] == "GetSTAXDetails") { Response.Write(GetSTAXDetails()); }//Added by Manisha on 30-May-15
 

    }
    //Added by Manisha on 30-May-15
    private string GetSTAXDetails()
    {

        cls_GetSTAXDetail STAX = new cls_GetSTAXDetail(str_Connection_String);
        STAX.TransDt = Request.QueryString["BillEntryDate"].ToString();
        STAX.GetSTAXDetail();
        if (STAX.Is_Record_Found == true)
        {
            return "Y~" + STAX.STax + "~" + STAX.EduCess + "~" + STAX.HEduCess+ "~" + STAX.SBCess + "~" + STAX.KKCess + "~"; //added BY Anupam 
        }
        else
        {
            return "N~";
        }
    }
    private string CheckVehNo()
    {
        General gen = new General(str_Connection_String);
        gen.CheckVehNo(Request.QueryString["Vehno"].ToString(), Request.QueryString["LocBranch"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VehNo + "~"; 
        }
        else
        {
            return "N~";
        }
    }
    private string CheckBillNumber()
    {
        General gen = new General(str_Connection_String);
        gen.CheckBillNumber(Request.QueryString["VENDORCODE"].ToString(), Request.QueryString["BillNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }
}

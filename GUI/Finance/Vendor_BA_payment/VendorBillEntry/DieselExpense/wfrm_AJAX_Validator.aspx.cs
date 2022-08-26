
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
        //str_Connection_String = Request.QueryString["ConnStr"].ToString();
        str_Connection_String = Session["SqlProvider"].ToString();

        if (Request.QueryString["Function"] == "CheckBillNumber") { Response.Write(CheckBillNumber()); }
        if (Request.QueryString["Function"] == "CheckTSNumber") { Response.Write(CheckTSNumber()); }
        if (Request.QueryString["Function"] == "GetTripDate") { Response.Write(GetTripDate()); }

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
            return "Y~" + STAX.STax + "~" + STAX.EduCess + "~" + STAX.HEduCess + "~" + STAX.SBCess + "~" + STAX.KKCess + "~"; //added BY Anupam 
        }
        else
        {
            return "N~";
        }
    }
    private string GetTripDate()
    {
        General gen = new General(str_Connection_String);
        gen.GetTripDate(Request.QueryString["TripsheetNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VSLIPDT + "~" + gen.Oper_Close_Dt + "~";
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

    private string CheckTSNumber()
    {
        General gen = new General(str_Connection_String);
        gen.CheckTSNumber(Request.QueryString["TripsheetNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VehNo + "~" + gen.CURRENT_KM_READ + "~" + gen.End_Dt_Tm + "~" + gen.Drive_Settle_Dt + "~";
        }
        else
        {
            return "N~";
        }
    }
}

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

        if (Request.QueryString["Function"] == "GetSTAXDetails") { Response.Write(GetSTAXDetails()); }
    }

    private string GetSTAXDetails()
    {
        cls_GetSTAXDetail STAX = new cls_GetSTAXDetail(str_Connection_String);
        STAX.TransDt = Request.QueryString["BillEntryDate"].ToString();
        STAX.GetSTAXDetail();
        //Response.Write("Is_Record_Found : " + Is_Record_Found);
        if (STAX.Is_Record_Found == true)
        {
            return "Y~" + STAX.STax + "~" + STAX.EduCess + "~" + STAX.HEduCess + "~" + STAX.SBCess + "~" + STAX.KKCess + "~"; //added BY Anupam 
        }
        else
        {
            return "N~";
        }
    }
    
}

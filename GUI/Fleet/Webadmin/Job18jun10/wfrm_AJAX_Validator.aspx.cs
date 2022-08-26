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
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckValidWorkGroup") { Response.Write(CheckValidWorkGroup()); }
        if (Request.QueryString["Function"] == "CheckValidAccCode") { Response.Write(CheckValidAccCode()); }
    }

    private string CheckValidWorkGroup()
    {
        cls_WorkGroup WrkGrp = new cls_WorkGroup(str_Connection_String);
        //tyrepat.WORK_GROUPCODE = Request.QueryString["WorkGroupCode"].ToString();
        WrkGrp.WORK_GROUPDESC = Request.QueryString["WorkGroupDesc"].ToString();
        if (Request.QueryString["WorkGroupCode"].ToString() != "undefined")
        {
            WrkGrp.CheckValidWorkGroup(Request.QueryString["WorkGroupCode"].ToString());
        }
        else
        {
            WrkGrp.CheckValidWorkGroup(strNullVal);
        }
        if (WrkGrp.IsRecordFound == true)
        {
            return "Y~" + WrkGrp.WORK_GROUPDESC + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidAccCode()
    {
        cls_WorkGroup WrkGrp = new cls_WorkGroup(str_Connection_String);
        if (Request.QueryString["AccCode"].ToString() != null)
        {
            WrkGrp.CheckValidAccCode(Request.QueryString["AccCode"].ToString());
        }
        if (WrkGrp.IsRecordFound == true)
        {
            return "Y~" + WrkGrp.Account_Category + "~";
        }
        else
        {
            return "N~";
        }
    }
    
   
    
   
   
   
    
   
    
  
   
}

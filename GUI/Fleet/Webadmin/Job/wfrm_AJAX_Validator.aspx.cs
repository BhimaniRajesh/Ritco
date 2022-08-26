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
        if (Request.QueryString["Function"] == "CheckValidTaskType") { Response.Write(CheckValidTaskType()); }
		if (Request.QueryString["Function"] == "CheckApprove_UserID") { Response.Write(CheckApprove_UserID()); }
        if (Request.QueryString["Function"] == "CheckCC_UserID") { Response.Write(CheckCC_UserID()); }
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
            return "Y~" + WrkGrp.WORK_GROUPDESC + "~" ;
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidTaskType()
    {
        cls_TaskType objTaskType = new cls_TaskType(str_Connection_String);
        objTaskType.TaskType = Request.QueryString["TaskType"].ToString();
        if (Request.QueryString["TaskTypeId"].ToString() != "undefined")
        {
            objTaskType.CheckValidTaskType(Request.QueryString["TaskTypeId"].ToString());
        }
        else
        {
            objTaskType.CheckValidTaskType(strNullVal);
        }
        if (objTaskType.IsRecordFound == true)
        {
            return "Y~" + objTaskType.TaskType + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidAccCode()
    {
        cls_TaskType objTaskType = new cls_TaskType(str_Connection_String);
        if (Request.QueryString["AccCode"].ToString() != null)
        {
            objTaskType.CheckValidAccCode(Request.QueryString["AccCode"].ToString());
        }
        if (objTaskType.IsRecordFound == true)
        {
            return "Y~" + objTaskType.AccCode + "~";
        }
        else
        {
            return "N~";
        }
    }
	 public string CheckApprove_UserID()
    {
        JobSheet objJS = new JobSheet(str_Connection_String);
        objJS.CheckUserID(Request.QueryString["UserId"].ToString());
        if (objJS.IsRecordFound == true)
        {
            return "Y~" + objJS.UserID + "~" + objJS.EmailId + "~";
        }
        else
        {
            return "N~";
        }
    }
    public string CheckCC_UserID()
    {
        JobSheet objJS = new JobSheet(str_Connection_String);
        objJS.CheckUserID(Request.QueryString["UserId"].ToString());
        if (objJS.IsRecordFound == true)
        {
            return "Y~" + objJS.UserID + "~" + objJS.EmailId + "~";
        }
        else
        {
            return "N~";
        }
    }
}

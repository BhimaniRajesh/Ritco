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

public partial class AjaxResponse : System.Web.UI.Page
{
    string str_Connection_String = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "OnTaskDescChange") { Response.Write(OnTaskDescChange()); }
        if (Request.QueryString["Function"] == "OnPartDescChange") { Response.Write(OnPartDescChange()); }
        if (Request.QueryString["Function"] == "CheckValidData") { Response.Write(CheckValidData()); }
        if (Request.QueryString["Function"] == "CheckVehicleNo") { Response.Write(CheckVehicleNo()); }
        if (Request.QueryString["Function"] == "OnTaskDescChangeClose") { Response.Write(OnTaskDescChangeClose()); }
        if (Request.QueryString["Function"] == "OnPartDescChangeClose") { Response.Write(OnPartDescChangeClose()); }
        if (Request.QueryString["Function"] == "GetJobOrderCancelDetails") { Response.Write(GetJobOrderCancelDetails()); }
        if (Request.QueryString["Function"] == "GetCancelDate") { Response.Write(GetCancelDate()); }
    }

    private string OnPartDescChangeClose()
    {
        JobSheet objJs = new JobSheet(str_Connection_String);
        objJs.PartCode = Request.QueryString["PartCode"].ToString();
        objJs.OnPartDescChangeClose();
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.Selling_Price + "~"; } else { return "N~"; }
    }
    private string OnTaskDescChangeClose()
    {
        JobSheet objJs = new JobSheet(str_Connection_String);
        objJs.JobOrderNo = Request.QueryString["JobOrderNo"].ToString();
        objJs.taskcd = Request.QueryString["TaskId"].ToString();
        objJs.OnTaskDescChangeClose();
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.tasktyp + "~" + objJs.LABOUR_HRS + "~"; } else { return "N~"; }
    }
    private string CheckVehicleNo()
    {
        JobSheet objJs = new JobSheet(str_Connection_String);
        objJs.VehNo = Request.QueryString["VehNo"].ToString();
        objJs.CheckVehicleNo();
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.Current_KM_Read + "~" + objJs.Vehicle_Status + "~" + objJs.Made_by + "~" + objJs.Model_No + "~" + objJs.Type_Name + "~" + objJs.Type_Code + "~" + objJs.Tmp_Current_KM_Read + "~" + objJs.JS_Maintainance_Status + "~" + objJs.JobOrderNo + "~"; } else { return "N~"; }
    }
    private string OnTaskDescChange()
    {
        JobSheet objJs = new JobSheet(str_Connection_String);
        objJs.taskcd = Request.QueryString["TaskId"].ToString();
        objJs.OnTaskDescChange();
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.tasktyp + "~" + objJs.LABOUR_HRS + "~"; } else { return "N~"; }
    }
    private string OnPartDescChange()
    {
        JobSheet objJs = new JobSheet(str_Connection_String);
        objJs.PartId = Request.QueryString["PartId"].ToString();
        objJs.OnPartDescChange();
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.PartCost + "~" + objJs.taskcd + "~"; } else { return "N~"; }
    }
    private string CheckValidData()
    {
        JobSheet objJs = new JobSheet(str_Connection_String);
        objJs.CheckValidData(Request.QueryString["LocHierarchy"].ToString(), Request.QueryString["JobSheetType"].ToString());
        if (objJs.IsRecordFound == true) { return "Y~" + objJs.ID + "~"; } else { return "N~"; }
    }
    private string GetJobOrderCancelDetails()
    {
        cls_JobOrderCancel jobordercancel = new cls_JobOrderCancel(str_Connection_String);
        jobordercancel.Job_Order_No = Request.QueryString["JobOrderNo"].ToString();
        jobordercancel.GetJobOrderNo();
        if (jobordercancel.IsRecordFound == true)
        {
            return "Y~" + jobordercancel.Job_Order_No + "~" + jobordercancel.Job_Order_Dt + "~" + jobordercancel.VEHNO + "~" + jobordercancel.JS_BRCD + "~" + jobordercancel.ORDER_STATUS + "~" + jobordercancel.Cancel_Status + "~" + jobordercancel.Cancel_Dt + "~" + jobordercancel.Cancel_Actual_Dt + "~";
        }
        else
        {
            return "N~";
        }
    }

    private string GetCancelDate()
    {
        cls_JobOrderCancel canceldate = new cls_JobOrderCancel(str_Connection_String);
        canceldate.Job_Order_No = Request.QueryString["JobOrderNo"].ToString();
        canceldate.Cancel_Dt = Request.QueryString["CancelDt"].ToString();

        canceldate.GetCancel_Date();
        if (canceldate.IsRecordFound == true)
        {
            return "Y~";// +canceldate.Job_Order_No + "~" + canceldate.Job_Order_Dt + "~" + canceldate.Cancel_Dt + "~" + canceldate.Cancel_Actual_Dt + "~";

        }
        else
        {
            return "N~";
        }
    }
}

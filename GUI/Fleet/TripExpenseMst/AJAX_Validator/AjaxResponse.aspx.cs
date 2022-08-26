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
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckValidExp") { Response.Write(CheckValidExp()); }
        if (Request.QueryString["Function"] == "CheckValidAccCode") { Response.Write(CheckValidAccCode()); }
    }
    private string CheckValidExp()
    {
        TripExpense objTripExpense = new TripExpense(str_Connection_String);

        objTripExpense.ID = Request.QueryString["Id"].ToString();
        objTripExpense.Trip_Exp_Header = Request.QueryString["Exp"].ToString();

        if (Request.QueryString["Id"].ToString() != "")
        {
            objTripExpense.ID = Request.QueryString["Id"].ToString();
            objTripExpense.CheckValidExp();
        }
        else
        {
            objTripExpense.ID = strNullVal;
            objTripExpense.CheckValidExp();
        }
        if (objTripExpense.IsRecordFound == true)
        {
            return "Y~" + objTripExpense.Trip_Exp_Header + "~"; 
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
}

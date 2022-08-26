using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;


public partial class GUI_admin_DCR_AjaxResponce : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string functionName = "";
        if (Request.QueryString["function"] != null)
            functionName = Request.QueryString["function"].Trim();

        if (functionName == "IsValidDCRSeries") IsValidDCRSeries();
        if (functionName == "IsValidDCRBookCode") IsValidDCRBookCode();
        if (functionName == "IsValidBranchCode") IsValidBranchCode();

    }

    private void IsValidDCRSeries()
    {
        string strRet = "1|Valid Series", _SereisFrom = "", _TotalLeafs = "", DocType="";

        try
        {
            if (Request.QueryString["SeriesFrom"] != null)
                _SereisFrom = Request.QueryString["SeriesFrom"].Trim();
            if (Request.QueryString["TotalLeafs"] != null)
                _TotalLeafs = Request.QueryString["TotalLeafs"].Trim();
            if (Request.QueryString["DocType"] != null)
                DocType = Request.QueryString["DocType"].Trim();

            string query = "EXEC IsValiedDCRSeries '{0}','{1}','{2}'";
            query = String.Format(query, DocType, _SereisFrom, _TotalLeafs);

            object objR = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, query);
            if (objR != null)
            {
                strRet = objR.ToString();
            }
        }
        catch (Exception ex)
        {
            strRet = "0|" + ex.Message;
        }

        Response.Clear();
        Response.Write(strRet);
        Response.End();
    }

    private void IsValidDCRBookCode()
    {
        string strRet = "1|Valid BookCode", _BookCode = "", DocType = "";

        try
        {
            if (Request.QueryString["BookCode"] != null)
                _BookCode = Request.QueryString["BookCode"].Trim();
            
            if (Request.QueryString["DocType"] != null)
                DocType = Request.QueryString["DocType"].Trim();

            string query = "EXEC IsValiedDCRBookCode '{0}','{1}'";
            query = String.Format(query, DocType, _BookCode);

            object objR = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, query);
            if (objR != null)
            {
                strRet = objR.ToString();
            }
        }
        catch (Exception ex)
        {
            strRet = "0|" + ex.Message;
        }

        Response.Clear();
        Response.Write(strRet);
        Response.End();
    }

    private void IsValidBranchCode()
    {
        string strBranchCode = "select CNT = Count(*) from webx_location where ActiveFlag='Y' and LocCode = '" + Request.QueryString["BranchCode"].Trim() + "'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strBranchCode).Tables[0];
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["CNT"].ToString() == "0")
            {
                Response.Write("0|InValid Branch Code");
            }
            else
            {
                Response.Write("1|Valid Branch Code");
            }
        }
    }
}
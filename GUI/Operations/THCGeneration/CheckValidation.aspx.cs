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


public partial class GUI_Operations_THCGeneration_CheckValidation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string functionName = "";
        if (Request.QueryString["function"] != null)
            functionName = Request.QueryString["function"].Trim();

        if (functionName == "GetContractActiveType") GetContractActiveType();
        if (functionName == "IsValiedSealNo") IsValiedSealNo();
        if (functionName == "IsValiedTAMNo") IsValiedTAMNo();
    }

    private void GetContractActiveType()
    {
        string strRet = "0", VendorCode = "";
        if (Request.QueryString["VendorCode"] != null)
            VendorCode = Request.QueryString["VendorCode"].Trim();

        strRet = Vendor_Contract.GetActiveContractType(VendorCode);

        Response.Clear();
        Response.Write(strRet);
        Response.End();
    }

    private void IsValiedSealNo()
    {
        string strRet = "0|Invalid Seal No", _SEALNO = "", _Branch = "";

        try
        {
            if (Request.QueryString["SEALNO"] != null)
                _SEALNO = Request.QueryString["SEALNO"].Trim();
            if (Request.QueryString["LOC"] != null)
                _Branch = Request.QueryString["LOC"].Trim();

            string query = "EXEC IsValidSealNo '{0}','{1}'";
            query = String.Format(query, _SEALNO, _Branch);

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

    private void IsValiedTAMNo()
    {
        string strRet = "0|Invalid TAM No", _TAMNO = "", _Branch = "";

        try
        {
            if (Request.QueryString["TAMNO"] != null)
                _TAMNO = Request.QueryString["TAMNO"].Trim();
            if (Request.QueryString["LOC"] != null)
                _Branch = Request.QueryString["LOC"].Trim();

            string query = "EXEC IsValidTAM_ForTHC '{0}','{1}'";
            query = String.Format(query, _TAMNO, _Branch);

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
}

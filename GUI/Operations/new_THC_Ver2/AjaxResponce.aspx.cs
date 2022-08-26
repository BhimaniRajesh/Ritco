using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;


public partial class GUI_Operations_THC_PDC_WithFin_DET_AjaxResponce : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string functionName = "", mode = "";

        //if (Request.QueryString["function"] != null)
        //    functionName = Request.QueryString["function"].Trim();

        //if (functionName == "GetContractActiveType") GetContractActiveType();

        mode = Request.QueryString["mode"].ToString();
        if (mode.CompareTo("ManualDOCNo") == 0)
        {
            string code1 = Request.QueryString["code1"].ToString().Trim();

            string strManualDOCNo = "select Cnt=Count(*) from webx_THC_SUMMARY where ManualTHCNo not in ('NA') and ManualTHCNo = '" + code1.ToString().Trim() + "'";
            DataTable dtManualDOCNo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strManualDOCNo).Tables[0];
            if (dtManualDOCNo.Rows.Count > 0)
            {
                if (dtManualDOCNo.Rows[0]["Cnt"].ToString() == "0")
                {
                    Response.Write("True|");
                }
                else
                {
                    Response.Write("False|");
                }
            }
        } // check ENDS HERE
    }

    //private void GetContractActiveType()
    //{
    //    string strRet = "0", VendorCode="";
    //    if (Request.QueryString["VendorCode"] != null)
    //        VendorCode = Request.QueryString["VendorCode"].Trim();

    //    strRet = Vendor_Contract.GetActiveContractType(VendorCode);

    //    Response.Clear();
    //    Response.Write(strRet);
    //    Response.End();
    //}
}

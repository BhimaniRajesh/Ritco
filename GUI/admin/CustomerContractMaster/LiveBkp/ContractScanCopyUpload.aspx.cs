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
using System.IO;
 
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_ContractScanCopyUpload : System.Web.UI.Page
{
    #region Variable[s]
    private static string ErrorMsg = string.Empty;    
    #endregion

    #region Form Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["ContractID"] != null)
                {
                    cstheader.ContractID = Convert.ToString(Request.QueryString["ContractID"]);
                    hdnContractID.Value = Convert.ToString(Request.QueryString["ContractID"]);
                }

                if (Request.QueryString["CustCode"] != null)
                {
                    cstheader.CustCode = Convert.ToString(Request.QueryString["CustCode"]);
                }             
               
                                        
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnUploadFile_Click(object sender, EventArgs e)
    {
        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {                
                string strBaseLocation = Server.MapPath("~/UploadedImages/") + SessionUtilities.Client + "//";
                string FilePath = strBaseLocation + hdnContractID.Value + Path.GetExtension(uplTheFile.PostedFile.FileName); 
                try
                {
                    if (!Directory.Exists(strBaseLocation))
                    {
                        Directory.CreateDirectory(strBaseLocation);
                    }                    
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error to create directory.&detail1=" + ex.Message.Replace('\n', '_'), false);                    
                }


                if (null != uplTheFile.PostedFile)
                {                   
                   uplTheFile.PostedFile.SaveAs(FilePath);                       
                }
                Response.Write("<script language='javascript'> { window.close();}</script>");
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    } 
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        try
        {
            if (string.IsNullOrEmpty(uplTheFile.PostedFile.FileName))
            {
                ErrorMsg = "Please browse file to upload.";
                return;
            }                  
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}

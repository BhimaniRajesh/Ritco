using System;
using System.Configuration;
using System.Web;

public partial class GUI_AzureBaseDownloadFile : System.Web.UI.Page
{      
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
        {
            try
            {
                var docName = Request.QueryString["DocName"];
                if (AzureStorageHelper.IsBlobExists(AzureStorageHelper.AzureContainerName, docName))
                {
                    Response.Clear();
                    AzureStorageHelper.DownloadBlob(docName, Response);
                }
                else
                {
                    lblErrorMessage.Visible = true;
                    lblErrorMessage.InnerHtml = "<b>Missing or Invalid Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                    btnCloseWindow.Visible = true;
                }
            }
            catch (Exception)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.InnerHtml = "<b>Missing or Invalid Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                btnCloseWindow.Visible = true;
            }
        }
    }
}
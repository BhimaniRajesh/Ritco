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
using System.IO;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Operations_Issue_ViewETScammedDocument : System.Web.UI.Page
{
    public string strFMScannedDocument;
    public string clintName = "";
    public const string ETDocumentDirectory = @"UploadedImages";
    public DateTime AzureStorageDate = Convert.ToDateTime(ConfigurationManager.AppSettings["CloudStorageDate"]);
    protected void Page_Load(object sender, EventArgs e)
    {
        clintName = SessionUtilities.Client;
        if (!IsPostBack)
        {
            try
            {
                var docName = Request.QueryString["DocName"];
                strFMScannedDocument = Server.MapPath(".") + "\\" + ETDocumentDirectory + "\\" + clintName + "\\" + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString());

                FileInfo FMScanDocument = new FileInfo(strFMScannedDocument);
                if (isAzureDocument(docName))
                {
                    if (AzureStorageHelper.IsBlobExists(AzureStorageHelper.AzureContainerName, docName))
                    {
                        Response.Clear();
                        AzureStorageHelper.DownloadBlob(docName, Response);
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerHtml = "<b>Missing or Invalid FM Scanned Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                        btnCloseWindow.Visible = true;
                    }
                }
                else
                {
                    if (FMScanDocument.Exists)
                    {
                        Response.Clear();
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + strFMScannedDocument);
                        Response.AddHeader("Content-Length", FMScanDocument.Length.ToString());
                        Response.ContentType = "application/octet-stream";
                        Response.WriteFile(FMScanDocument.FullName);
                        Response.End();
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerHtml = "<b>Missing or Invalid FM Scanned Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                        btnCloseWindow.Visible = true;
                    }
                }
            }
            catch (Exception)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.InnerHtml = "<b>Missing or Invalid FM Scanned Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                btnCloseWindow.Visible = true;
            }
        }
    }
    public bool isAzureDocument(string documentName)
    {
        return (SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "usp_Webx_Check_POD_AzureStorage '" + documentName + "'").Tables[0].Rows.Count > 0);
    }
}
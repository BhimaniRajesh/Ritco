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

public partial class GUI_Operations_FM_ViewFMScannedDocument : System.Web.UI.Page
{
    public string strFMScannedDocument;
    public string clintName = "";
    public DateTime AzureStorageDate = Convert.ToDateTime(ConfigurationManager.AppSettings["CloudStorageDate"]);

    protected void Page_Load(object sender, EventArgs e)
    {
        clintName = SessionUtilities.Client;
        if (!IsPostBack)
        {
            try
            {
                strFMScannedDocument = Server.MapPath(".") + "\\" + FMUtility.FMDocumentDirectory + "\\" + clintName + "\\" + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString());

                FileInfo FMScanDocument = new FileInfo(strFMScannedDocument);
                var docName = Request.QueryString["DocName"];
                if (isAzureDocument(HttpUtility.UrlDecode(docName)))
                {
                    if (AzureStorageHelper.IsBlobExists(AzureStorageHelper.AzureContainerName, HttpUtility.UrlDecode(docName)))
                    {
                        Response.Clear();
                        AzureStorageHelper.DownloadBlob(HttpUtility.UrlDecode(docName), Response);
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerHtml = "<b>Missing or Invalid FM Scanned Document: " + HttpUtility.UrlDecode(docName) + "</b>";
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
            catch (Exception Ex)
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

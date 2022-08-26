using System;
using System.Web;
using System.IO;

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_ViewExternalThcScannedDocument : System.Web.UI.Page
{
    public string strExternalThcScannedDocument;
    public string clintName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        clintName = SessionUtilities.Client;
        if (!IsPostBack)
        {
            try
            {
                strExternalThcScannedDocument = Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages/Ritco" + "//" + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()));
                FileInfo ExternalThcScanDocument = new FileInfo(strExternalThcScannedDocument);
                if (ExternalThcScanDocument.Exists)
                {
                    Response.Clear();
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + strExternalThcScannedDocument);
                    Response.AddHeader("Content-Length", ExternalThcScanDocument.Length.ToString());
                    Response.ContentType = "application/octet-stream";
                    Response.WriteFile(ExternalThcScanDocument.FullName);
                    Response.End();
                }
                else
                {
                    lblErrorMessage.Visible = true;
                    lblErrorMessage.InnerHtml = "<b>Missing or Invalid External Thc Scanned Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                    btnCloseWindow.Visible = true;
                }
            }
            catch (Exception Ex)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.InnerHtml = "<b>Missing or Invalid External Thc Scanned Document: " + HttpUtility.UrlDecode(Request.QueryString["DocName"].ToString()) + "</b>";
                btnCloseWindow.Visible = true;
            }
        }
    }
}
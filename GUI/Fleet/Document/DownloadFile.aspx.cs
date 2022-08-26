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
using System.Drawing; 

public partial class GUI_Fleet_Document_DownloadFile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string strPath = "";
            if (Request.QueryString["FileName"] != null)
            {
                if (Request.QueryString["FileName"] != "")
                {
                    string[] fileType = Request.QueryString["FileName"].ToString().Split('.');
                    if (fileType[fileType.Length - 1].ToLower() == "xls")
                    {
                        Response.ContentType = "Application/x-msexcel";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Excel\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if (fileType[fileType.Length - 1].ToLower() == "doc")
                    {
                        Response.ContentType = "application/ms-word";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Word\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if (fileType[fileType.Length - 1].ToLower() == "gif")
                    {
                        Response.ContentType = "image/gif";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if ((fileType[fileType.Length - 1].ToLower() == "jpg") || (fileType[fileType.Length - 1].ToLower() == "jpeg") || (fileType[fileType.Length - 1].ToLower() == "jpe"))
                    {
                        Response.ContentType = "image/jpeg";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if (fileType[fileType.Length - 1].ToLower() == "pdf")
                    {
                        Response.ContentType = "application/vnd.pdf";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if (fileType[fileType.Length - 1].ToLower() == "tiff" || fileType[fileType.Length - 1].ToLower() == "tif")
                    {
                        Response.ContentType = "Application/image/tiff";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else
                    {
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    Response.AddHeader("content-disposition", "attachment; filename=\"" + Request.QueryString["FileName"].ToString() + "\"");
                    Response.TransmitFile(strPath);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    Response.End();
                }
            }
        }
    }
}

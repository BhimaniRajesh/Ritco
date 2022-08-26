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
                        Response.ContentType = "Application/image/gif";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if ((fileType[fileType.Length - 1].ToLower() == "jpg") || (fileType[fileType.Length - 1].ToLower() == "jpeg") || (fileType[fileType.Length - 1].ToLower() == "jpe"))
                    {
                        Response.ContentType = "Application/image/jpeg";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if (fileType[fileType.Length - 1].ToLower() == "pdf")
                    {
                        Response.ContentType = "application/vnd.pdf";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    else if (fileType[fileType.Length - 1].ToLower()  == "tiff" || fileType[fileType.Length - 1].ToLower()  == "tif")
                    {
                        Response.ContentType = "Application/image/tiff";
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                        //GetImage(strPath);
                    }
                    else
                    {
                        strPath = (Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + Request.QueryString["FileName"].ToString()));
                    }
                    Response.AddHeader("Content-Disposition", "inline;filename=\"" + Request.QueryString["FileName"].ToString() + "\"");
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
    private void GetImage(string sFileName)
    {
        string sDocPath = sFileName;

        System.Drawing.Image image = System.Drawing.Image.FromFile(sDocPath);

        int pageCount = image.GetFrameCount(System.Drawing.Imaging.FrameDimension.Page);

        // make a memory stream to work with the image bytes
        MemoryStream imageStream = new MemoryStream();

        // put the image into the memory stream
        for (int i = 0; i < pageCount; i++)
        {
            image.SelectActiveFrame(System.Drawing.Imaging.FrameDimension.Page, i);

            byte[] byteImage = ConvertImageToByteArray(image, System.Drawing.Imaging.ImageFormat.Tiff);
            imageStream.Write(byteImage, 0, byteImage.Length);

        }

        // make byte array the same size as the image
        byte[] imageContent = new Byte[imageStream.Length];

        // rewind the memory stream
        imageStream.Position = 0;

        // load the byte array with the image
        imageStream.Read(imageContent, 0, (int)imageStream.Length);

        // return byte array to caller with image type
        Response.ContentType = "image/tiff";
        Response.BinaryWrite(imageContent);
        Response.AddHeader("Content-Disposition", "inline;filename=" + sFileName + ".tiff");

    }

    private static byte[] ConvertImageToByteArray(System.Drawing.Image imageToConvert, System.Drawing.Imaging.ImageFormat formatOfImage)
    {
        byte[] Ret;

        try
        {
            using (MemoryStream ms = new MemoryStream())
            {
                imageToConvert.Save(ms, formatOfImage);
                Ret = ms.ToArray();
            }
        }
        catch (Exception) { throw; }

        return Ret;
    } 

 
}

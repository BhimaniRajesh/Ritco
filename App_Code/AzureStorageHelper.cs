using System;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.StorageClient;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

/// <summary>
/// AzureStorage Helper
/// </summary>
public class AzureStorageHelper
{
    public AzureStorageHelper()
    {
        // TODO: Add constructor logic here
    }
    /// <summary>
    /// Get Azure ContainerName
    /// </summary>
    public static string AzureContainerName
    {
        get { return ConfigurationManager.AppSettings["SOPContainerName"]; }
        //get { return SessionUtilities.Client.ToLower(); }
        //get { return "rcpllive"; }
    }

    /// <summary>
    /// Get Deployment Type
    /// </summary>
    private static string DeploymentType
    {
        get { return ConfigurationManager.AppSettings["DeploymentType"]; }
    }

    /// <summary>
    /// Get Azure ConnectionString From Configuration Manager
    /// </summary>
    public static string AzureConnectionString
    {
        get { return ConfigurationManager.ConnectionStrings[DeploymentType + "StorageConnectionString"].ConnectionString; }
    }

    /// <summary>
    /// Get Blob Container Detail
    /// </summary>
    /// <param name="containerName">ContainerName</param>
    /// <returns>CloudBlobContainer</returns>
    public static CloudBlobContainer GetBlobContainer(string containerName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(AzureConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

        return blobClient.GetContainerReference(containerName);
    }

    /// <summary>
    /// Check Specific Blob Exists or not
    /// </summary>
    /// <param name="blob">CloudBlockBlob</param>
    /// <returns>bool</returns>
    public static bool IsBlobExists(CloudBlockBlob blob)
    {
        try
        {
            blob.FetchAttributes();
            return true;
        }
        catch (StorageClientException e)
        {
            if (e.ErrorCode != StorageErrorCode.ResourceNotFound) throw;
            return false;
        }
    }

    /// <summary>
    /// Check Specific Blob Exists or not
    /// </summary>
    /// <param name="ContainerName">ContainerName</param>
    /// <param name="BlobUri">BlobUri</param>
    /// <returns>bool</returns>
    public static bool IsBlobExists(string ContainerName, string BlobUri)
    {
        try
        {
            CloudBlobContainer container = GetBlobContainer(AzureContainerName);
            CloudBlob blockBlob = container.GetBlobReference(BlobUri);
            blockBlob.FetchAttributes();
            return true;
        }
        catch (StorageClientException e)
        {
            if (e.ErrorCode != StorageErrorCode.ResourceNotFound) throw;
            return false;
        }
    }

    /// <summary>
    /// Delete Specific Blob From Storage
    /// </summary>
    /// <param name="ContainerName">ContainerName</param>
    /// <param name="BlobUri">BlobUri</param>
    public static void DeleteBlob(string ContainerName, string BlobUri)
    {
        try
        {
            CloudBlobContainer container = GetBlobContainer(AzureContainerName);
            CloudBlob blockBlob = container.GetBlobReference(BlobUri);
            blockBlob.DeleteIfExists();
        }
        catch (StorageClientException e)
        {
            ExceptionUtility.LogException(e, "DeleteBlob", SessionUtilities.CurrentEmployeeID, "AzureStorageHelper");
            throw;
        }
    }

    /// <summary>
    /// Create Client's Azure Container if not Exists
    /// </summary>
    public static void CreateContainer()
    {
        try
        {
            var container = GetBlobContainer(AzureContainerName);
            container.CreateIfNotExist();
        }
        catch (Exception e)
        {
            ExceptionUtility.LogException(e, "CreateContainer", SessionUtilities.CurrentEmployeeID, "AzureStorageHelper");
        }
    }

    /// <summary>
    /// Upload Blob item To Storage
    /// </summary>
    /// <param name="DocumentType">v</param>
    /// <param name="upLoadFile">upLoadFile</param>
    /// <param name="fileName">fileName</param>
    /// <returns>string(Uploaded BlobUri)</returns>
    public static string UploadBlob(string DocumentType, FileUpload upLoadFile, string fileName)
    {
        DeleteOldFiles(DocumentType);
        string sopFileLocation = string.Empty;
        try
        {
            sopFileLocation = DocumentType + "/" + SessionUtilities.Now.ToString("yyyy/MMM") + "/" + fileName;

            if (!string.IsNullOrEmpty(upLoadFile.PostedFile.FileName))
            {
                if (IsBlobExists(AzureContainerName, sopFileLocation))
                    DeleteBlob(AzureContainerName, sopFileLocation);
                CloudBlobContainer container = GetBlobContainer(AzureContainerName);
                CloudBlob blockBlob = container.GetBlobReference(sopFileLocation);

                string extn, name;
                Match m = Regex.Match(upLoadFile.PostedFile.FileName, @"(?'Name'[^\\]+)\.(?'Ext'.*)");
                extn = m.Groups["Ext"].Value;
                name = m.Groups["Name"].Value;
                string path = HttpContext.Current.Server.MapPath("~/UploadedFiles/" + DocumentType + "/" + name + "." + extn);
                upLoadFile.PostedFile.SaveAs(path);
                blockBlob.Properties.ContentType = IOHelper.GetContentType(Path.GetExtension(upLoadFile.PostedFile.FileName));
                blockBlob.UploadFile(path);
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "UploadBlob - " + fileName, SessionUtilities.CurrentEmployeeID, "AzureStorageHelper");
            sopFileLocation = string.Empty;
        }
        return sopFileLocation;
    }

    /// <summary>
    /// Download Specific Blob item From Storage at Specific Path
    /// </summary>
    /// <param name="BlobUri">BlobUri</param>
    /// <param name="FileLocation">FileLocation</param>
    public static void DownloadBlob(string BlobUri, string FileLocation)
    {
        CloudBlobContainer container = GetBlobContainer(AzureContainerName);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(container.Uri + "/" + BlobUri);
        if (IsBlobExists(blockBlob))
        {
            blockBlob.DownloadToFile(FileLocation);
        }
    }

    /// <summary>
    /// Download Specific Blob item in MemoryStream
    /// </summary>
    /// <param name="BlobUri">BlobUri</param>
    /// <param name="response">response</param>
    public static void DownloadBlob(string BlobUri, HttpResponse response)
    {
        CloudBlobContainer container = GetBlobContainer(AzureContainerName);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(container.Uri + "/" + BlobUri);
        {
            using (var memStream = new MemoryStream())
            {
                blockBlob.DownloadToStream(memStream);
                response.Clear();
                response.ClearContent();
                response.ClearHeaders();
                response.Buffer = true;
                response.Expires = -1;
                response.ContentType = blockBlob.Properties.ContentType;
                response.AddHeader("Content-Disposition", "Attachment; filename=" + blockBlob.Name);
                response.AddHeader("Content-Length", blockBlob.Properties.Length.ToString());
                response.BinaryWrite(memStream.ToArray());
                response.Flush();
                response.Close();
                response.End();

                //blockBlob.DownloadToStream(memStream);
                //response.ContentType = blockBlob.Properties.ContentType;
                //response.AddHeader("Content-Disposition", "Attachment; filename=" + blockBlob.Name);
                //response.AddHeader("Content-Length", blockBlob.Properties.Length.ToString());
                //response.BinaryWrite(memStream.ToArray());
                //response.Flush();
            }
        }
    }

    /// <summary>
    /// Delete Old Files Less than 1 hour From Download Directory of Specific Document Type
    /// </summary>
    /// <param name="DocumentType">DocumentType</param>
    private static void DeleteOldFiles(string DocumentType)
    {
        try
        {
            string BasePath = HttpContext.Current.Server.MapPath("~/UploadedFiles");
            if (Directory.Exists(BasePath + @"\" + DocumentType))
            {
                DirectoryInfo dir = new DirectoryInfo(BasePath + @"\" + DocumentType);
                FileInfo[] fiList = dir.GetFiles();
                foreach (FileInfo fi in fiList)
                {
                    if (fi.CreationTime <= SessionUtilities.Now.AddHours(-1))
                        fi.Delete();
                }

                DirectoryInfo[] dirList = dir.GetDirectories();
                foreach (DirectoryInfo di in dirList)
                {
                    if (di.CreationTime <= SessionUtilities.Now.AddHours(-1))
                        di.Delete(true);
                }
            }
            else
                Directory.CreateDirectory(BasePath + @"\" + DocumentType);
        }
        catch (Exception e)
        {
            ExceptionUtility.LogException(e, "DeleteOldFiles", SessionUtilities.CurrentEmployeeID, "AzureStorageHelper");
            throw;
        }
    }
    
    /// <summary>
    /// View stored blob file (will work only if container is set to "Public Blob")
    /// </summary>
    /// <param name="blobName"></param>
    /// <returns></returns>
    public static string GetBlobViewLink(string blobName)
    {
        string blobConString = ConfigurationManager.ConnectionStrings["CloudStorageConnectionString"].ConnectionString;

        Match m = Regex.Match(blobConString, "AccountName=(?'AccountName'[A-Za-z0-9_.]+)");
        string accName = m.Groups["AccountName"].Value;
        string containerName = ConfigurationManager.AppSettings["SOPContainerName"];

        return string.Format("https://{0}.blob.core.windows.net/{1}/{2}", accName, containerName, blobName);
    }


}

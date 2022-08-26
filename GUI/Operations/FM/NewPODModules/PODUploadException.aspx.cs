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
using WebX.Controllers;
using System.Text.RegularExpressions;

public partial class GUI_Operations_FM_NewPODModules_PODHandoverCriteria : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        var obj = new NewPODModuleController();
        var dtResult = obj.PODExceptionDocketDetails(txtdocno.Text);

        if (dtResult.Rows.Count <= 0)
        {
            msgBox.Show("Invalid Docket !!");
            return;
        }
        if (dtResult.Rows[0]["POD"].ToString() == "")
        {
            msgBox.Show("POD is not uploaded against the Docket !!");
            return;
        }
        // if (dtResult.Rows[0]["PDHNo"].ToString() != "")
        // {
            // msgBox.Show("POD Handover Is Done!! " + dtResult.Rows[0]["PDHNo"].ToString());
            // return;
        // }
        if (dtResult.Rows[0]["Billed"].ToString() == "Y")
        {
            msgBox.Show("Bill is already generated  !! ");
            return;
        }

        lblDocketNo.Text = dtResult.Rows[0]["DOCKNO"].ToString();
        hdnPOD.Value = dtResult.Rows[0]["POD"].ToString();
        tr1.Visible = true;
        tr2.Visible = true;
        tr3.Visible = true;

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            if (!fileUploadPOD.HasFile)
            {
                msgBox.Show("Please Select POD File  !! ");
                return;
            }

            var newFName = "";
            string DocumentUploadedFile = "";
            if (fileUploadPOD.HasFile)
            {
                newFName = GetFileName(fileUploadPOD.PostedFile.FileName, lblDocketNo.Text.Trim(), FMUtility.GetFMDocketTypeSuffix("1"));

                double dblFileSize = Math.Ceiling(Convert.ToDouble(fileUploadPOD.PostedFile.ContentLength) / 1000);
                DFMRules objDFR = DFMRules.GetByCodeID("UP_FILE_SIZE");
                double MaxSize = 1024; //1MB
                if (objDFR.DefaultValue != "NA" && objDFR.DefaultValue != "")
                    MaxSize = Convert.ToDouble(objDFR.DefaultValue);

                if (dblFileSize > MaxSize)
                {
                    //lblUloadLink.Text = "<label class='blackfnt' runat='server' style='color: Red;'><br style='font-size: 1pt;'/>Select Document of Size <= " + MaxSize.ToString("0") + " KB!</label>";
                    //throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                }
                DocumentUploadedFile = AzureStorageHelper.UploadBlob("POD", fileUploadPOD, newFName);
                if (string.IsNullOrEmpty(DocumentUploadedFile))
                {
                    throw new Exception("Failed to upload Document");
                }
            }

            if (!string.IsNullOrEmpty(DocumentUploadedFile))
            {
                var obj = new NewPODModuleController();
                obj.PODExceptionUploadPOD(lblDocketNo.Text, DocumentUploadedFile);
                Response.Redirect("PODUploadResult.aspx", false);
            }
            
        }
        catch (Exception ex)
        {
            msgBox.Show(ex.Message);
            return;
        }
    }
    
    private string GetFileName(string fileName, string docno, string pref)
    {
        string strRet = fileName;

        string pat = @"(?:.+)(.+)\.(.+)";
        Regex r = new Regex(pat);
        //run
        Match m = r.Match(fileName);
        string file_ext = m.Groups[2].Captures[0].ToString();
        string filename = m.Groups[1].Captures[0].ToString();
        docno = docno.Replace("/", "$");

        strRet = pref + "_" + docno + "." + file_ext;

        return strRet;
    }
}

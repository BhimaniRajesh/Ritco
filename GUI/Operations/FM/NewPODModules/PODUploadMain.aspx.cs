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
using System.Text.RegularExpressions;
using WebX.Controllers;

public partial class GUI_Operations_FM_NewPODModules_PODUploadMain : BasePage
{
    public string brcd, empcd, selyear, dkt_Call, empnm;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        empnm = Session["empnm"].ToString();


        dkt_Call = Session["DocketCalledAs"].ToString();
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            var obj = new NewPODModuleController();
            var dt = obj.GetDocketListForPODUpload(Request.QueryString["Location"].ToString(), Request.QueryString["FromDate"].ToString(), Request.QueryString["ToDate"].ToString(), Request.QueryString["DocketNo"].ToString());
            dgDockets.DataSource = dt;
            dgDockets.DataBind();
            if (dt.Rows.Count > 0) { btnSubmit.Visible = true; } else { btnSubmit.Visible = false; }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            try
            {
                foreach (GridViewRow gridrow in dgDockets.Rows)
                {
                    CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                    TextBox txtReportingDate = (TextBox)gridrow.FindControl("txtReportingDate");
                    TextBox txtUnloadingDate = (TextBox)gridrow.FindControl("txtUnloadingDate");
                    TextBox txtPODReceivingDate = (TextBox)gridrow.FindControl("txtPODReceivingDate");
                    FileUpload fileUploadPOD = (FileUpload)gridrow.FindControl("fileUploadPOD");
                    Label lnkDocketDate = (Label)gridrow.FindControl("lnkDocketDate");

                    TextBox txtReportingDateHrs = (TextBox)gridrow.FindControl("txtReportingDateHrs");
                    TextBox txtReportingDateMin = (TextBox)gridrow.FindControl("txtReportingDateMin");
                    TextBox txtUnloadingDateHrs = (TextBox)gridrow.FindControl("txtUnloadingDateHrs");
                    TextBox txtUnloadingDateMin = (TextBox)gridrow.FindControl("txtUnloadingDateMin");

                    HiddenField hdnArrivalUpdatePODFile = (HiddenField)gridrow.FindControl("hdnArrivalUpdatePODFile");


                    if (chkDocket.Checked == true)
                    {

                        if (fileUploadPOD.HasFile == false && hdnArrivalUpdatePODFile.Value == "")
                        {
                            msgBox.Show("Please select POD !!");
                            return;
                        }

                        if (txtReportingDate.Text.Trim() == "" || txtUnloadingDate.Text.Trim() == "")
                        {
                            msgBox.Show("Please select Reporting Date And Unloading Date !!");
                            return;
                        }

                        if (txtPODReceivingDate.Text.Trim() == "")
                        {
                            msgBox.Show("Please select POD Recieving Date !!");
                            return;
                        }

                        if (Convert.ToDateTime(getDateInddMMMyyFormat(lnkDocketDate.Text.Trim())) > Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())))
                        {
                            msgBox.Show("Reporting Date must be greater then or equal to Docket Date ");
                            return;
                        }

                        //if (Convert.ToDateTime(hdnTHCDate.Value.Trim()) > Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())))
                        //{
                        //    msgBox.Show("Reporting Date must be greater then or equal to THC Date ");
                        //    return;
                        //}

                        string ReportingDateTime = getDateInddMMMyyFormat(txtReportingDate.Text) + " " + (txtReportingDateHrs.Text == "" ? "00" : txtReportingDateHrs.Text) + ":" + (txtReportingDateMin.Text == "" ? "00" : txtReportingDateMin.Text);
                        string UnloadingDateTime = getDateInddMMMyyFormat(txtUnloadingDate.Text) + " " + (txtUnloadingDateHrs.Text == "" ? "00" : txtUnloadingDateHrs.Text) + ":" + (txtUnloadingDateMin.Text == "" ? "00" : txtUnloadingDateMin.Text);

                        try
                        {
                            var dt = Convert.ToDateTime(ReportingDateTime);
                            var dt2 = Convert.ToDateTime(UnloadingDateTime);
                        }
                        catch (Exception ex)
                        {
                            msgBox.Show("Invalide Reporting Date Time Or Unloading Date Time !!! ");
                            return;
                        }


                        //if (Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())) > Convert.ToDateTime(getDateInddMMMyyFormat(txtUnloadingDate.Text.Trim())))
                        if (Convert.ToDateTime(ReportingDateTime) > Convert.ToDateTime(UnloadingDateTime))
                        {
                            msgBox.Show("Reporting Date must be less then or equal to Unloading Date !!");
                            return;
                        }
                    }
                }

                int docketCnt = 0;
                var strDocketXML = "<DocketList>";
                foreach (GridViewRow gridrow in dgDockets.Rows)
                {
                    CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                    HiddenField hdnDocketNo = (HiddenField)gridrow.FindControl("hdnDocketNo");
                    TextBox txtReportingDate = (TextBox)gridrow.FindControl("txtReportingDate");
                    TextBox txtUnloadingDate = (TextBox)gridrow.FindControl("txtUnloadingDate");
                    TextBox txtPODReceivingDate = (TextBox)gridrow.FindControl("txtPODReceivingDate");
                    TextBox txtRemark = (TextBox)gridrow.FindControl("txtRemark");
                    FileUpload fileUploadPOD = (FileUpload)gridrow.FindControl("fileUploadPOD");

                    TextBox txtReportingDateHrs = (TextBox)gridrow.FindControl("txtReportingDateHrs");
                    TextBox txtReportingDateMin = (TextBox)gridrow.FindControl("txtReportingDateMin");
                    TextBox txtUnloadingDateHrs = (TextBox)gridrow.FindControl("txtUnloadingDateHrs");
                    TextBox txtUnloadingDateMin = (TextBox)gridrow.FindControl("txtUnloadingDateMin");
                    HiddenField hdnArrivalUpdatePODFile = (HiddenField)gridrow.FindControl("hdnArrivalUpdatePODFile");

                    if (chkDocket.Checked == true)
                    {

                        string ReportingDateTime = getDateInddMMMyyFormat(txtReportingDate.Text) + " " + (txtReportingDateHrs.Text == "" ? "00" : txtReportingDateHrs.Text) + ":" + (txtReportingDateMin.Text == "" ? "00" : txtReportingDateMin.Text);
                        string UnloadingDateTime = getDateInddMMMyyFormat(txtUnloadingDate.Text) + " " + (txtUnloadingDateHrs.Text == "" ? "00" : txtUnloadingDateHrs.Text) + ":" + (txtUnloadingDateMin.Text == "" ? "00" : txtUnloadingDateMin.Text);

                        docketCnt = docketCnt + 1;
                        var newFName = "";
                        string DocumentUploadedFile = "";
                        if (fileUploadPOD.HasFile)
                        {
                            docketCnt = docketCnt + 1;
                            newFName = GetFileName(fileUploadPOD.PostedFile.FileName, hdnDocketNo.Value.Trim(), FMUtility.GetFMDocketTypeSuffix("1"));

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
                        }
                        if (fileUploadPOD.HasFile == false) { DocumentUploadedFile = hdnArrivalUpdatePODFile.Value; }

                        if (!string.IsNullOrEmpty(DocumentUploadedFile))
                        {
                            strDocketXML += "<Docket><DocketNo>" + hdnDocketNo.Value + "</DocketNo>";
                            strDocketXML += "<ReportingDate>" + ReportingDateTime + "</ReportingDate>";
                            strDocketXML += "<UnloadingDate>" + UnloadingDateTime + "</UnloadingDate>";
                            strDocketXML += "<PODReceivingDate>" + getDateInddMMMyyFormat(txtPODReceivingDate.Text) + "</PODReceivingDate>";
                            strDocketXML += "<PODFile>" + DocumentUploadedFile + "</PODFile>";
                            strDocketXML += "<EntryBy>" + SessionUtilities.CurrentEmployeeID + "</EntryBy>";
                            strDocketXML += "<Remark>" + txtRemark.Text + "</Remark></Docket>";

                        }
                        else
                        {
                            throw new Exception("Failed to upload Document");
                        }

                    }
                }
                strDocketXML += "</DocketList>";

                if (docketCnt > 0)
                {
                    var obj = new NewPODModuleController();
                    obj.DocketPODUpload(strDocketXML);
                    Response.Redirect("PODUploadResult.aspx", false);
                }
                else
                {
                    msgBox.Show("Please select At Least On Docket !!");
                }



            }
            catch (Exception ex)
            {
                msgBox.Show(ex.Message);
                return;
            }
        }
        else
        {
            //msgBox.Show("Can't click Twise !!");
            //return;
        }
    }

    protected void dgDockets_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            FileUpload fileUploadPOD = (FileUpload)e.Row.FindControl("fileUploadPOD");
            HiddenField hdnArrivalUpdatePODFile = (HiddenField)e.Row.FindControl("hdnArrivalUpdatePODFile");
            Label lblPOD = (Label)e.Row.FindControl("lblPOD");
            HiddenField hdnPODRejected = (HiddenField)e.Row.FindControl("hdnPODRejected");

            if (hdnPODRejected.Value.ToLower() == "yes")
            {
                // e.Row.BackColor = System.Drawing.Color.LightGoldenrodYellow;
                e.Row.Attributes["style"] = "background-color: #FF9966";
            }

            if (hdnArrivalUpdatePODFile.Value != "")
            {
                lblPOD.Visible = true;
            }
            else
            {
                lblPOD.Visible = false;
            }
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

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Xml;

public partial class GUI_Operations_THC_ArrivalUpdate_THC_ArrivalProcess : System.Web.UI.Page
{
    public string FinYear = "", currdate;

    #region/*Added By : Juhi Patel (P008303)*/
    public string brcd, empcd, selyear, dkt_Call, empnm;
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        #region/*Added By : Juhi Patel (P008303)*/
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        empnm = Session["empnm"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        #endregion

        currdate = DateTime.Now.ToString("dd/MM/yyyy");

        lblPageHead.Text = Session["THCCalledAs"] + " Arrival/Update";
        lbkThcno.Text = Session["THCCalledAs"] + " No #";
        lblTHCNO.Text = Request.QueryString["THCNO"].ToString();
        btnSubmit.Text = "Update " + Session["THCCalledAs"];
        lbltotMF.Text = "Total MF For " + Session["brcd"] + " #";
        lbltotDKT.Text = "Total " + Session["DocketCalledAs"] + " For " + Session["brcd"] + " #";

        PRSTYP.Value = Request.QueryString["TYP"].ToString();

        MySQLDataSource_DelyReasons.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_ArrivalConditions.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Godowns.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (Request.QueryString["TYP"].ToString() == "S")
        {
            ViewArrivalDetails("none");
        }
        else
        {
            ViewArrivalDetails("block");
            tr7.Style["display"] = "none";
        }

        if (Request.QueryString["TYP"].ToString() == "A")
        {
            ViewUpdateDetails("none");
        }
        else
        {
            ViewUpdateDetails("block");
        }


        if (!IsPostBack)
        {
            umsg.Hide();

            txtarrvdt.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtStockUpdateDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtArrivalTimeHH.Text = System.DateTime.Now.ToString("HH");
            txtArrivalTimeMM.Text = System.DateTime.Now.ToString("mm");
            txtUnloader.Text = Session["EMPCD"].ToString();
            string strquery = "select *,ETA1=convert(varchar,ETA,6) + ' ' + convert(varchar,ETA,108) from VWNET_THC_Arrival_update where thcno='" + Request.QueryString["THCNO"].ToString() + "' and (Arr_loc='" + Session["brcd"] + "'  or Stock_loc='" + Session["brcd"] + "') and (Arr_status='Arrival'  or Stock_Status='Stock Update' or Stock_Status='Pending Arrival')";

            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand CMD = new SqlCommand(strquery, sqlConn);
            SqlDataReader dr = CMD.ExecuteReader();

            while (dr.Read())
            {
                lblvehicledep.Text = dr["PreviousBranch"].ToString() + " @ " + dr["ATD"].ToString();
                hdnDeptDate.Value = dr["ATD1"].ToString();
                lblexparr.Text = dr["ETA1"].ToString();
                lblopnekm.Text = "( <b>Opening KM # </b> " + dr["OPENKM"].ToString() + " )";
                lblopnekm.Font.Bold = true;
                lblopnekm.ForeColor = System.Drawing.Color.Red;
                lblCntMF.Text = dr["MF"].ToString();
                lblCntDKt.Text = dr["DKT"].ToString();
                lblvehicle.Text = dr["Vehicle"].ToString();
                lblarrrvatDt.Text = dr["ATA"].ToString();
                HDKM.Value = dr["OPENKM"].ToString();
                hdnTHCDate.Value = dr["THCDate"].ToString();
            }

            dr.Close();
            sqlConn.Close();

            GetDocketDetails();

        }


    }

    public void GetDocketDetails()
    {
        using (WebX.Common.WebXHelper dbobject = new WebX.Common.WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@THCNO", Request.QueryString["THCNO"].ToString());
            dgDockets.DataSource = dbobject.ExecuteDataSet(CommandType.StoredProcedure, "USP_ArrivalUpdate_THCFromCnote_GetDocketList", param);
            dgDockets.DataBind();
        }
    }

    public void ViewUpdateDetails(string abcd)
    {
        Table1.Style["display"] = abcd;
    }
    public void ViewArrivalDetails(string abcd)
    {
        tr1.Style["display"] = abcd;
        tr2.Style["display"] = abcd;
        tr3.Style["display"] = abcd;
        // tr4.Style["display"] = abcd;
        tr5.Style["display"] = abcd;
        tr6.Style["display"] = abcd;

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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow gridrow in dgDockets.Rows)
            {
                CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                TextBox txtReportingDate = (TextBox)gridrow.FindControl("txtReportingDate");
                TextBox txtReportingDateHrs = (TextBox)gridrow.FindControl("txtReportingDateHrs");
                TextBox txtReportingDateMin = (TextBox)gridrow.FindControl("txtReportingDateMin");
                TextBox txtUnloadingDate = (TextBox)gridrow.FindControl("txtUnloadingDate");
                TextBox txtUnloadingDateHrs = (TextBox)gridrow.FindControl("txtUnloadingDateHrs");
                TextBox txtUnloadingDateMin = (TextBox)gridrow.FindControl("txtUnloadingDateMin");
                FileUpload fileUploadPOD = (FileUpload)gridrow.FindControl("fileUploadPOD");
                //if (chkDocket.Checked == true)
                //{
                if (txtReportingDate.Text.Trim() == "" || txtUnloadingDate.Text.Trim() == "")
                {
                    umsg.Show("Please select Reporting Date And Unloading Date ");
                    return;
                }

                //if (Convert.ToDateTime(hdnTHCDate.Value.Trim()) > Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())))
                //{
                //    umsg.Show("Reporting Date must be greater then or equal to THC Date ");
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
                    umsg.Show("Invalide Reporting Date Time Or Unloading Date Time !!! ");
                    return;
                }

                //if (Convert.ToDateTime(getDateInddMMMyyFormat(txtReportingDate.Text.Trim())) > Convert.ToDateTime(getDateInddMMMyyFormat(txtUnloadingDate.Text.Trim())))
                if (Convert.ToDateTime(ReportingDateTime) > Convert.ToDateTime(UnloadingDateTime))
                {
                    umsg.Show("Reporting Date must be less then or equal to Unloading Date ");
                    return;
                }
                if (fileUploadPOD.Visible)
                {
                    if (!fileUploadPOD.HasFile)
                    {
                        umsg.Show("Kindly Upload POD!!!");
                        return;
                    }
                }
                //}

            }


            #region /*START- Added By Juhi Patel P008303-Upload POD*/
            int docketCnt = 0;
            var podDocketXML = "<DocketList>";
            foreach (GridViewRow gridrow in dgDockets.Rows)
            {
                CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                HiddenField hdnDocketNo = (HiddenField)gridrow.FindControl("hdnDocketNo");
                FileUpload fileUploadPOD = (FileUpload)gridrow.FindControl("fileUploadPOD");

                if (fileUploadPOD.Visible)
                {
                    var newFName = "";
                    string DocumentUploadedFile = "";
                    try
                    {

                        if (fileUploadPOD.HasFile)
                        {
                            docketCnt = docketCnt + 1;
                            newFName = GetFileName(fileUploadPOD.PostedFile.FileName, hdnDocketNo.Value.Trim(), FMUtility.GetFMDocketTypeSuffix("1"));

                            //double dblFileSize = Math.Ceiling(Convert.ToDouble(fileUploadPOD.PostedFile.ContentLength) / 1000);
                            //DFMRules objDFR = DFMRules.GetByCodeID("UP_FILE_SIZE");
                            //double MaxSize = 1024; //1MB
                            //if (objDFR.DefaultValue != "NA" && objDFR.DefaultValue != "")
                            //    MaxSize = Convert.ToDouble(objDFR.DefaultValue);

                            //if (dblFileSize > MaxSize)
                            //{
                            //    //lblUloadLink.Text = "<label class='blackfnt' runat='server' style='color: Red;'><br style='font-size: 1pt;'/>Select Document of Size <= " + MaxSize.ToString("0") + " KB!</label>";
                            //    //throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                            //}
                            DocumentUploadedFile = AzureStorageHelper.UploadBlob("POD", fileUploadPOD, newFName);
                        }

                    }
                    catch (Exception ex)
                    {
                        DocumentUploadedFile = "";
                    }
                    if (string.IsNullOrEmpty(DocumentUploadedFile) == true)
                    {
                        umsg.Show("Error While Uploading PODs!!!");
                        return;
                    }else{
						podDocketXML += "<Docket><DocketNo>" + hdnDocketNo.Value + "</DocketNo>";
                        podDocketXML += "<PODFile>" + DocumentUploadedFile + "</PODFile></Docket>";
					}
                }

            }
            podDocketXML += "</DocketList>";
            #endregion



            string strArrivalXML = "<root><THCarrival>";
            strArrivalXML += "<sealno_in>" + txtIncomingSealNo.Text.ToString() + "</sealno_in>";
            strArrivalXML += "<THCNO>" + Request.QueryString["THCNO"].ToString() + "</THCNO>";
            strArrivalXML += "<actarrv_dt>" + getDateInddMMMyyFormat(txtarrvdt.Text.ToString()) + "</actarrv_dt>";
            strArrivalXML += "<actarrv_tm>" + txtArrivalTimeHH.Text.ToString() + ":" + txtArrivalTimeMM.Text.ToString() + "</actarrv_tm>";
            strArrivalXML += "<thc_inrem>" + txtIncrmk.Text.ToString() + "</thc_inrem>";
            strArrivalXML += "<unloader>" + txtUnloader.Text.ToString() + "</unloader>";
            strArrivalXML += "<LateArrivalReason>" + ddlLateArrivalReason.SelectedValue.ToString() + "</LateArrivalReason>";
            strArrivalXML += "<closekm>" + txtopenkm.Text.ToString() + "</closekm>";
            strArrivalXML += "</THCarrival></root>";

            string strStockXML = "<root><THCStock>";
            strStockXML += "<StockUpDt>" + getDateInddMMMyyFormat(txtStockUpdateDate.Text.ToString()) + "</StockUpDt>";
            strStockXML += "<THCNO>" + Request.QueryString["THCNO"].ToString() + "</THCNO>";
            strStockXML += "<StockCondition>" + cboArrivalConditions_All.SelectedValue.ToString() + "</StockCondition>";
            strStockXML += "<Godown>" + cboGodowns_All.SelectedValue.ToString() + "</Godown>";
            strStockXML += "</THCStock></root>";
            //SqlTransaction trans;

            var strDocketXML = "<DocketList>";
            foreach (GridViewRow gridrow in dgDockets.Rows)
            {
                CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                HiddenField hdnDocketNo = (HiddenField)gridrow.FindControl("hdnDocketNo");
                HiddenField hdnDocketSF = (HiddenField)gridrow.FindControl("hdnDocketSF");
                TextBox txtReportingDate = (TextBox)gridrow.FindControl("txtReportingDate");
                TextBox txtUnloadingDate = (TextBox)gridrow.FindControl("txtUnloadingDate");

                TextBox txtReportingDateHrs = (TextBox)gridrow.FindControl("txtReportingDateHrs");
                TextBox txtReportingDateMin = (TextBox)gridrow.FindControl("txtReportingDateMin");
                TextBox txtUnloadingDateHrs = (TextBox)gridrow.FindControl("txtUnloadingDateHrs");
                TextBox txtUnloadingDateMin = (TextBox)gridrow.FindControl("txtUnloadingDateMin");

                string ReportingDateTime = getDateInddMMMyyFormat(txtReportingDate.Text) + " " + (txtReportingDateHrs.Text == "" ? "00" : txtReportingDateHrs.Text) + ":" + (txtReportingDateMin.Text == "" ? "00" : txtReportingDateMin.Text);
                string UnloadingDateTime = getDateInddMMMyyFormat(txtUnloadingDate.Text) + " " + (txtUnloadingDateHrs.Text == "" ? "00" : txtUnloadingDateHrs.Text) + ":" + (txtUnloadingDateMin.Text == "" ? "00" : txtUnloadingDateMin.Text);

                //if (chkDocket.Checked == true)
                //{
                strDocketXML += "<Docket><DocketNo>" + hdnDocketNo.Value + "</DocketNo>";
                strDocketXML += "<DocSF>" + hdnDocketSF.Value + "</DocSF>";
                strDocketXML += "<ReportingDate>" + ReportingDateTime + "</ReportingDate>";
                strDocketXML += "<UnloadingDate>" + UnloadingDateTime + "</UnloadingDate></Docket>";
                //}
            }
            strDocketXML += "</DocketList>";

            string strquery = "exec Usp_THC_Arrival_update '" + strArrivalXML + "','" + strStockXML + "','" + Session["brcd"].ToString() + "','" + Session["FinYear"].ToString() + "','" + Request.QueryString["TYP"].ToString() + "','" + Session["empcd"].ToString() + "','" + strDocketXML + "'";
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            sqlConn.Open();

            //Response.Write("strquery "+strquery );
            //Response.End();
            //trans = sqlConn.BeginTransaction();
            try
            {

                SqlCommand CMD = new SqlCommand(strquery, sqlConn);

                //CMD.Transaction = trans;
                CMD.ExecuteNonQuery();
                //trans.Commit();
                // trans.Rollback();
                sqlConn.Close();



                if (docketCnt > 0)
                {
                    try
                    {
                        var obj = new WebX.Controllers.NewPODModuleController();
                        obj.ArrivalUpdateDocketPODUpload(podDocketXML);
                    }
                    catch (Exception ex) { ExceptionUtility.LogException(ex, "THC Arrival->POD Upload"); }
                }
            }
            catch (Exception e1)
            {
                if (e1.Message == "")
                {
                    //abc = "Insert Susccessfully !!!!!!!";
                }
                //trans.Rollback();
                //trans.Commit();


                sqlConn.Close();
                //Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
                //Response.End();
                string msg = e1.Message.ToString();
                msg = msg.Replace('\n', ' ');
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Error in THC Arrival Update&ErrorMsg=" + msg);
                Response.End();
            }

            // trans.Rollback();
            //sqlConn.Open();
            //EmailSmsAccess();
            //sqlConn.Close();
            Response.Redirect("StockUpdateResult.aspx");
        }
        catch (Exception ex)
        {
            umsg.Show(ex.Message);
            return;
        }
    }

    #region Sms Access
    /// <summary>
    /// data to send as auto mail
    /// </summary>
    public void EmailSmsAccess()
    {
        string MsgText = "", CsnrresponseMessage = "";
        string strEmailFrom = "", str_Email = "", strEmailCc = "", strEmailBcc = "", strSubject = "", CustCode = "";

        try
        {

            using (WebX.Common.WebXHelper dbobject = new WebX.Common.WebXHelper())
            {

                using (var dr = dbobject.ExecuteReader(CommandType.StoredProcedure, "USP_DOCKET_ARRIVAL_SMS", new[] { new SqlParameter("@thcno", lblTHCNO.Text.ToString()), new SqlParameter("@branchCode", Session["brcd"].ToString()) }))
                {

                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {

                            var DocketNo = Convert.ToString(dr["DockNo"]);
                            var Arrival_Date = Convert.ToString(dr["Arrival_Date"]);
                            var Arrival_Location = Convert.ToString(dr["Arrival_Location"]);
                            var MobileNo = Convert.ToString(dr["Mobileno"]);

                            //This Code Is Used For Sending SMS To Consigner
                            MsgText = "Dear Customer," + Environment.NewLine + "Your Consignment No. : " + DocketNo.Trim() + Environment.NewLine + "Has Reached At : " + Arrival_Location.Trim() + Environment.NewLine + "On Dated : " + Arrival_Date.Trim() + Environment.NewLine + "Please Get The Delivery " + Environment.NewLine + "Thanks RITCO. ";
                            CsnrresponseMessage = SendSmsMessage(MobileNo.Trim(), MsgText.Trim());
                            Save_SMS_Data(MsgText, MobileNo.Trim(), CsnrresponseMessage, strEmailFrom, str_Email, strEmailCc, strEmailBcc, strSubject, CustCode);
                        }
                    }

                    dr.Close();
                }
            }
        }

        catch (Exception ex)
        {
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + ex.Message.Replace('\n', '_'));
        }
    }


    public void Save_SMS_Data(string msgtxtbk, string mobileno, string responseMessage, string strEmailFrom, string str_Email, string strEmailCc, string strEmailBcc, string strSubject, string CustCode)
    {
        try
        {
            using (WebX.Common.WebXHelper dbobject = new WebX.Common.WebXHelper())
            {
                //string strMailData = "exec USP_WEBX_AutoEmail_New ";

                var param = new SqlParameter[12];
                param[0] = new SqlParameter("@EVENT_ID", "1");
                param[1] = new SqlParameter("@DOCUMENT_NO", Request.QueryString["THCNO"].ToString().Trim());
                param[2] = new SqlParameter("@EVENT_NAME", "Docket Arrival");
                param[3] = new SqlParameter("@SMS_MESSAGE", msgtxtbk);
                param[4] = new SqlParameter("@MOBILE_NO", mobileno);
                param[5] = new SqlParameter("@RESPONSE", responseMessage);
                param[6] = new SqlParameter("@EMAIL_FROM", strEmailFrom);
                param[7] = new SqlParameter("@EMAIL_ID", str_Email);
                param[8] = new SqlParameter("@EMAIL_CC", strEmailCc);
                param[9] = new SqlParameter("@EMAIL_BCC", strEmailBcc);
                param[10] = new SqlParameter("@EMAIL_SUBJECT", strSubject);
                param[11] = new SqlParameter("@CUSTCODE", CustCode);

                using (var dr = dbobject.ExecuteReader(CommandType.StoredProcedure, "usp_Add_SMS_To_Log", param))
                {
                    dr.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + ex.Message.Replace('\n', '_'));
        }

    }

    public string SendSmsMessage(string mobileNo, string smsText)
    {
        var Message = "";
        try
        {
            /* Using Web Referance */

            var proxy = new SMS_Service();
            var responceText = proxy.SendSMS(mobileNo.Trim(), smsText.Trim());
            /* end */

            /* Using Class
            SMS_Service SendSms = new SMS_Service();
            string responceText = SendSms.SendSMS(txtMobileNo.Text, txtMessage.Text);
            end */

            if (responceText != "")
            {
                var resDoc = new XmlDocument();
                resDoc.LoadXml(responceText);
                XmlNode result = resDoc.DocumentElement;
                if (result != null)
                {
                    var status = result.ChildNodes[0];

                    if (status.InnerText.Trim() == "1")
                    {
                        var message = result.ChildNodes[1];
                        Message = message.InnerText;
                        return Message;
                    }
                    else
                    {
                        var message = result.ChildNodes[1];
                        throw new Exception(message.InnerText);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Message = ex.Message;
        }
        return Message;
    }

    #endregion

    #region/*Added By : Juhi Patel (P008303)*/
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


    protected void dgDockets_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            FileUpload fileUploadPOD = (FileUpload)e.Row.FindControl("fileUploadPOD");
            HiddenField hdnPODFile = (HiddenField)e.Row.FindControl("hdnPODFile");
            Label lblPOD = (Label)e.Row.FindControl("lblPOD");
            Label ValSign = (Label)e.Row.FindControl("ValSign");

            if (hdnPODFile.Value != "")
            {
                //lblPOD.Attributes.Add("style", "display:none");
                lblPOD.Visible = true;
                fileUploadPOD.Visible = false;
                ValSign.Visible = false;
            }
            else
            {
                fileUploadPOD.Visible = true;
                lblPOD.Visible = false;
                ValSign.Visible = true;
            }
        }
    }
    #endregion
}

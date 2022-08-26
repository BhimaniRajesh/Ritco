using System;
using System.IO;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Text.RegularExpressions;
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Operations_FM_ScanFMDocuments : System.Web.UI.Page
{
    public string clintName = "";
    public fm _dataSet = new fm();

    string strDocumentName;
    string strDocumentNo;
    string upload_file, headerDocType="";
    string connStr = "", brcd="", headOffice="";
    DataGrid OldGid = new DataGrid();
    int _lastEditedPage;

    private string SelectedHeader
    {
        get 
        {
            if (ViewState["SelectedHeader"] != null)
            {
                return ViewState["SelectedHeader"].ToString();
            }
            else
            {
                return "";
            }
        }
        set 
        {
            ViewState["SelectedHeader"] = value;
        }
    }

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((fm)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = SessionUtilities.CurrentBranchCode;
        headOffice = SessionUtilities.HeadOfficeCode;
        clintName = SessionUtilities.Client;
        connStr = SessionUtilities.ConnectionString;
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            Inetialized();
            BindGrid();
        }
        else
        {
            ReverseBind();
        }
    }

    protected void ddlDocType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;

        TextBox txtDocketNo = (TextBox)ddl.Parent.FindControl("txtDocketNo");
        TextBox txtdoc = (TextBox)ddl.Parent.FindControl("txtDocNo");
        Label lbldoc1 = (Label)ddl.Parent.FindControl("lblDocNo");

        txtDocketNo.Text = "";
        txtdoc.Text = "";
        if (ddl.SelectedValue == "")
        {
            lbldoc1.Visible = false;
        }
        else if (ddl.SelectedValue == FMUtility.POD || ddl.SelectedValue == FMUtility.Bill)
        {
            txtdoc.Visible = false;
            lbldoc1.Visible = true;
        }
        else if (ddl.SelectedValue == FMUtility.Octroi || ddl.SelectedValue == FMUtility.COD_DOD)
        {
            txtdoc.Visible = true;
            lbldoc1.Visible = false;
        }

        Label lblDocketNo = (Label)ddl.Parent.FindControl("lblDocketNo");
        Label lblScanStatus = (Label)ddl.Parent.FindControl("lblScanStatus_new");
        HyperLink hylView = (HyperLink)ddl.Parent.FindControl("hylView");
        FileUpload fileUpload = ((FileUpload)ddl.Parent.FindControl("fileUpload"));

        lblScanStatus.Text = "Not Scanned";
        hylView.Visible = false;
        lblDocketNo.Visible = false;
        lblDocketNo.Text = "";
        fileUpload.Enabled = true;
    }
    protected void ddlHDocType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        SelectedHeader = ddl.SelectedValue;
        foreach (DataGridItem gridrow in myGrid.Items)
        {                
            DropDownList ddlDocType = (DropDownList)gridrow.FindControl("ddlDocType");
            ddlDocType.SelectedValue = ddl.SelectedValue;
            //ddlDocType.Enabled = false;
            ddlDocType_SelectedIndexChanged(ddlDocType, new EventArgs());
        } 
    }
    protected void txtDocketNo_TextChanged(object sender, EventArgs e)
    {
        TextBox txtdoc = (TextBox)sender;

        DropDownList ddl = (DropDownList)txtdoc.Parent.FindControl("ddlDocType");
        Label lblDocketNo = (Label)txtdoc.Parent.FindControl("lblDocketNo");
        Label lblScanStatus = (Label)txtdoc.Parent.FindControl("lblScanStatus_new");
        HyperLink hylView = (HyperLink)txtdoc.Parent.FindControl("hylView");
        FileUpload fileUpload = ((FileUpload)txtdoc.FindControl("fileUpload"));

        if (txtdoc.Text == "")
        {
            lblDocketNo.Visible = false;
            lblDocketNo.Text = "Invalid Cnote No.! or Not Delivered at " + brcd;
            return;
        }

        byte byteDocketExistance = CheckDocketExistace(txtdoc.Text, ddl.SelectedValue);

        if (byteDocketExistance == 0)
        {
            lblScanStatus.Text = "";
            hylView.Visible = false;
            lblDocketNo.Visible = true;
            lblDocketNo.Text = "Invalid Cnote No.! or Not Delivered at " + brcd;
            txtdoc.Focus();
            fileUpload.Enabled = false;
        }

        else if (byteDocketExistance == 1)
        {
            lblScanStatus.Text = "Not Scanned";            
            hylView.Visible = false;
            lblDocketNo.Visible = false;
            lblDocketNo.Text = "";
            fileUpload.Enabled = true;
        }
        else if (byteDocketExistance == 2)
        {
            lblScanStatus.Text = "Scanned";
            lblDocketNo.Visible = false;
            hylView.Visible = true;
            hylView.NavigateUrl = "ViewFMScannedDocument.aspx?DocName=" + strDocumentName;
            fileUpload.Enabled = false;
        }
        else if (byteDocketExistance == 3)
        {
            lblScanStatus.Text = "POD Already Uploaded, you can overwrite";
            lblDocketNo.Visible = false;
            lblDocketNo.Text = "";
            hylView.Visible = true;
            hylView.NavigateUrl = "ViewFMScannedDocument.aspx?DocName=" + strDocumentName;
            fileUpload.Enabled = true;
        }
    }    

    protected void txtnorwos_TextChanged(object sender, EventArgs e)
    {
        int maxrows = 0;
        if (txtnorwos.Text != "" || txtnorwos.Text != null)
        {
            OldGid = myGrid;
            try
            {
                if (Convert.ToInt32(txtnorwos.Text) != 0)
                {
                    int rowno = Convert.ToInt32(txtnorwos.Text);
                    int cnt = _dataSet.scanDocument.Rows.Count;
                    if (rowno > cnt)
                    {
                        for (int i = 0; i < (rowno - cnt) + 1; i++)
                        {
                            _dataSet.scanDocument.AddscanDocumentRow("", "", "", "", "");
                        }
                    }
                    else
                    { 
                        fm _newdataSet = new fm();
                        for (int i = 0; i < rowno; i++)
                        {                                                  
                            DataRow dr = _dataSet.scanDocument.Rows[i];
                            _newdataSet.scanDocument.AddscanDocumentRow(dr["docu_type"].ToString(), dr["number"].ToString(), dr["docu_number"].ToString(), dr["scan_status"].ToString(), dr["docu_select"].ToString());
                        }
                        _dataSet = _newdataSet;
                    }

                    BindGrid();                    
                }
            }
            catch (Exception ex)
            {
                txtnorwos.Text = "";
                txtnorwos.Focus();
            }
        }
    }

    protected void myGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        fm.scanDocumentRow datarow;
        if (e.Item.ItemType == ListItemType.Header)
        {
            DropDownList ddlHDocType = (DropDownList)e.Item.FindControl("ddlHDocType");
            FMUtility.BindFMDocTypes(ddlHDocType, SelectedHeader);
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            upload_file = ((FileUpload)e.Item.FindControl("fileUpload")).FileName.ToString();
            datarow = ((fm.scanDocumentRow)((DataRowView)e.Item.DataItem).Row);
            DropDownList ddlDocType = (DropDownList)e.Item.FindControl("ddlDocType");
            FMUtility.BindFMDocTypes(ddlDocType, datarow.docu_type);
            //FMUtility.BindFMDocTypes(ddlDocType, SelectedHeader);
            //ddlDocType.Enabled = false;
            if (datarow.docu_type == "")
                ddlDocType.SelectedValue = SelectedHeader;
            ((TextBox)e.Item.FindControl("txtDocketNo")).Text = datarow.number;
            ((TextBox)e.Item.FindControl("txtDocNo")).Text = datarow.docu_number;
            ((TextBox)e.Item.FindControl("lblScanStatus")).Text = datarow.scan_status;
                       
            TextBox txtdoc = (TextBox)e.Item.FindControl("txtDocNo");
            Label lbldoc1 = (Label)e.Item.FindControl("lblDocNo");
            
            
            txtdoc.Text = datarow.docu_number;
            if (ddlDocType.SelectedValue == "")
            {
                lbldoc1.Visible = false;
            }
            else if (ddlDocType.SelectedValue == FMUtility.POD || ddlDocType.SelectedValue == FMUtility.Bill)
            {
                txtdoc.Visible = false;
                lbldoc1.Visible = true;
            }
            else if (ddlDocType.SelectedValue == FMUtility.Octroi || ddlDocType.SelectedValue == FMUtility.COD_DOD)
            {
                txtdoc.Visible = true;
                lbldoc1.Visible = false;
            }

            Label lblDocketNo = (Label)e.Item.FindControl("lblDocketNo");
            Label lblScanStatus = (Label)e.Item.FindControl("lblScanStatus_new");
            HyperLink hylView = (HyperLink)e.Item.FindControl("hylView");
            FileUpload fileUpload = ((FileUpload)e.Item.FindControl("fileUpload"));

            lblScanStatus.Text = "Not Scanned";
            hylView.Visible = false;
            lblDocketNo.Visible = false;
            lblDocketNo.Text = "";
            fileUpload.Enabled = true;
        }
    }
        
    protected void btnSubmit_Click(object sender, EventArgs e)
    {       
        fm.scanDocumentRow datarow;        
        try
        {
            string st_dokcno = "", st_docno = "", st_doctyp = "", st_filenm = "";
            string ex_DockNo = "", ex_docno = "", ex_doctyp = "", ex_reason = "";
            string C_dockno = "", C_docno = "", C_doctyp = "";
            foreach (DataGridItem gridrow in myGrid.Items)
            {
                SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                cn.Open();
                SqlTransaction trans = cn.BeginTransaction();
                try
                {
                    FileUpload upload_file = ((FileUpload)gridrow.FindControl("fileUpload"));
                    DropDownList dll_doctyp = ((DropDownList)gridrow.FindControl("ddlDocType"));
                    TextBox txt_document_no = (TextBox)gridrow.FindControl("txt_document_no");
                    TextBox txtdockno = ((TextBox)gridrow.FindControl("txtDocketNo"));
                    Label lbl_document_no = (Label)gridrow.FindControl("lbl_document_no");
                    TextBox txtdoc_no = ((TextBox)gridrow.FindControl("txtDocNo"));
                    Label lblScanStatus = ((Label)gridrow.FindControl("lblScanStatus_new"));
                    Label lblUloadLink = ((Label)gridrow.FindControl("lblUloadLink"));
                    string docval = "", docval1 = "";
                    bool IsValid = false;

                    byte byteDocketExistance = CheckDocketExistace(txtdockno.Text, dll_doctyp.SelectedValue);
                    if (byteDocketExistance == 1)
                        IsValid = true;
                    else if (byteDocketExistance == 2)
                        IsValid = false;
                    else if (byteDocketExistance == 3)
                        IsValid = true;

                    if (txtdockno.Text == "")
                    {
                        docval = "NA";
                    }
                    else
                    {
                        docval = txtdockno.Text.ToString();
                    }
                    if (txtdoc_no.Text == "")
                    {
                        docval1 = "NA";
                    }
                    else
                    {
                        docval1 = txtdoc_no.Text.ToString();
                    }
                    string newFName = "";
                    C_dockno = docval;
                    C_docno = docval1;
                    C_doctyp = dll_doctyp.SelectedValue;                    

                    if (IsValid)
                    {
                        if (upload_file.HasFile)
                        {                           
                            newFName = GetFileName(upload_file.PostedFile.FileName, txtdockno.Text.Trim(), FMUtility.GetFMDocketTypeSuffix(dll_doctyp.SelectedValue));
                            if (CheckDocumentExistance(newFName) == true)
                            {
                                //throw new Exception("Document already exist.");
                            }

                            double dblFileSize = Math.Ceiling(Convert.ToDouble(upload_file.PostedFile.ContentLength) / 1000);
                            DFMRules objDFR = DFMRules.GetByCodeID("UP_FILE_SIZE");
                            double MaxSize = 1024; //1MB
                            if (objDFR.DefaultValue != "NA" && objDFR.DefaultValue != "")
                                MaxSize = Convert.ToDouble(objDFR.DefaultValue);
                            if (CheckFMDocumentsDirectory() == false)
                            {
                                throw new Exception("Fail to create directory ");
                            }
                            if (dblFileSize > MaxSize)
                            {
                                lblUloadLink.Text = "<label class='blackfnt' runat='server' style='color: Red;'><br style='font-size: 1pt;'/>Select Document of Size <= " + MaxSize.ToString("0") + " KB!</label>";
                                throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                            }
                            upload_file.SaveAs(Server.MapPath(".") + @"\" + FMUtility.FMDocumentDirectory + @"\" + clintName + @"\" + newFName);

                            string sp = "Webx_SP_FM_ScanDocuments_new";
                            if (byteDocketExistance == 3)
                                sp = "Webx_SP_FM_ScanDocuments_Update";
                            
                            string SubmitData = "exec " + sp + " '" + dll_doctyp.SelectedValue.ToString() + "','" + txtdockno.Text + "','" + txtdoc_no.Text + "','0','" + newFName + "',''";
                            SqlCommand cmd_subdata = new SqlCommand(SubmitData, cn);
                            cmd_subdata.Transaction = trans;
                            cmd_subdata.ExecuteNonQuery();

                            trans.Commit();                            
                        }
                        else
                            throw new Exception("File is not selected");

                        if (st_dokcno == "")
                            st_dokcno = docval;
                        else
                            st_dokcno = st_dokcno + "~" + docval;

                        if (st_docno == "")
                            st_docno = docval1;
                        else
                            st_docno = st_docno + "~" + docval1;

                        if (st_doctyp == "")
                            st_doctyp = dll_doctyp.SelectedValue.ToString();
                        else
                            st_doctyp = st_doctyp + "~" + dll_doctyp.SelectedValue.ToString();

                        string st_filename = newFName;

                        if (st_filenm == "")
                            st_filenm = st_filename;
                        else
                            st_filenm = st_filenm + "~" + st_filename;
                    }
                }
                catch (Exception exp)
                {
                    if (trans != null)
                        trans.Rollback();

                    if (ex_DockNo == "")
                        ex_DockNo = C_dockno;
                    else
                        ex_DockNo = ex_DockNo + "~" + C_dockno;

                    if (ex_docno == "")
                        ex_docno = C_docno;
                    else
                        ex_docno = ex_docno + "~" + C_docno;

                    if (ex_doctyp == "")
                        ex_doctyp = C_doctyp;
                    else
                        ex_doctyp = ex_doctyp + "~" + C_doctyp;
                    if (ex_reason == "")
                        ex_reason = exp.Message;
                    else
                        ex_reason = ex_reason + "~" + exp.Message;
                }
                finally
                {
                    if (cn.State == ConnectionState.Open)
                    { cn.Close(); cn.Dispose(); }
                }
            }           
            string final;
            final = "?st_dokcno=" + st_dokcno;
            final += "&st_docno=" + st_docno;
            final += "&st_doctyp=" + st_doctyp;
            final += "&st_filenm=" + st_filenm;
            final += "&ex_dokcno=" + ex_DockNo;
            final += "&ex_docno=" + ex_docno;
            final += "&ex_doctyp=" + ex_doctyp;
            final += "&ex_reason=" + ex_reason;
            //Response.Write("DisplayFMScannedDocuments.aspx" + final);
            Response.Redirect("DisplayFMScannedDocuments.aspx" + final);
        }
        catch (Exception Ex)
        {
            lblMsg.Text = Ex.Message;
            lblMsg.Visible = true;
        }       
    }

    private void Inetialized()
    {
        txtnorwos.Text = "1";
        _dataSet.scanDocument.AddscanDocumentRow("","","","","");       
    }

    private void BindGrid()
    {
        myGrid.DataSource = _dataSet.scanDocument;        
        myGrid.DataBind();
        _lastEditedPage = myGrid.CurrentPageIndex;

        CheckAfterDataBind();
    }    

    private void ReverseBind()
    {
        try
        {   
            fm.scanDocumentRow datarow;           
            foreach (DataGridItem gridrow in myGrid.Items)
            {
                datarow = _dataSet.scanDocument[gridrow.DataSetIndex];
                upload_file = ((FileUpload)gridrow.FindControl("fileUpload")).FileName.ToString();
                datarow.docu_type = ((DropDownList)gridrow.FindControl("ddlDocType")).SelectedValue;
                datarow.number = ((TextBox)gridrow.FindControl("txtDocketNo")).Text;
                datarow.docu_number = ((TextBox)gridrow.FindControl("txtDocNo")).Text;
                datarow.scan_status = ((TextBox)gridrow.FindControl("lblScanStatus")).Text;
                datarow.docu_select = upload_file;
                _dataSet.scanDocument[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
            }
        }
        catch (Exception Ex)
        {
            lblMsg.Text = Ex.Message;
            lblMsg.Visible = true;
        }      
    }   

    private byte CheckDocketExistace(string DocketNo, string DocumentTypeValue)
    {
        //byteDocketNoExists = 0 -> Docket No. does not exist in Webx_Master_Docket table
        //byteDocketNoExists = 1 -> Docket No. exists in Webx_Master_Docket table but document is not scanned for docket no. & document type
        //byteDocketNoExists = 2 -> Docket No. exists in Webx_Master_Docket table and document is scanned for docket no. & document type
        //byteDocketNoExists = 3 -> Document is Exist, it can be updated by HQTR

        byte byteDocketNoExists = 0;

        string strSQL = "SELECT WMD.DOCKNO, WFD.DocType, WFD.DocketNo, WFD.DocumentNo, WFD.DocumentName, WFD.ScanStatus  " +
               "FROM  webx_Master_DOCKET  WMD INNER JOIN dbo.WebX_Trans_Docket_Status WDS "+
               "ON WMD.DOCKNO=WDS.DOCKNO LEFT OUTER JOIN Webx_FM_Scan_Documents WFD ON WMD.DOCKNO = WFD.DocketNo, "+
               "(SELECT SetValue FROM WebX_DFM_RULES_DET WHERE RuleID='FIRST_FM_LOC' and DocType='" + DocumentTypeValue + "' and ActiveFlag='Y' and [Enable]='Y') RL, " +
               "(SELECT SetValue FROM WebX_DFM_RULES_DET WHERE RuleID='SCAN_DOC_AT_HQ' and DocType='" + DocumentTypeValue + "' and ActiveFlag='Y' and [Enable]='Y') RS," +
               "(SELECT SetValue FROM WebX_DFM_RULES_DET WHERE RuleID='OVER_DOC_AT_HQ' and DocType='" + DocumentTypeValue + "' and ActiveFlag='Y' and [Enable]='Y') RO " +
               " WHERE WMD.DOCKNO = '" + DocketNo + "' and  (WFD.DocType='" + DocumentTypeValue + "' or  WFD.DocType is null) "+
               " and  ISNULL(WDS.Delivered,'N')='Y'" +
               "and " +
               "(" +
                "	CASE  WHEN WFD.DocType is not null THEN " +
                "	(" +
                "		CASE WHEN (case when RL.SetValue='DOC_ORG_LOC' then orgncd else reassign_destcd end )='" + brcd + "' THEN 'Y'" +
                "		ELSE ( Case When RO.SetValue='YES' AND '" + headOffice + "'='" + brcd + "' THEN 'Y' ELSE 'N' END ) END" +
                "	)" +
                "	ELSE  " +
                "	(" +
                "  		CASE WHEN (case when RL.SetValue='DOC_ORG_LOC' then orgncd else reassign_destcd end )='" + brcd + "' THEN 'Y'" +
                "		ELSE ( Case When RS.SetValue='YES' AND '" + headOffice + "'='" + brcd + "' THEN 'Y' ELSE 'N' END ) END" +
                "	)	" +
                "	END" +
                ")='Y'";
        if (DocumentTypeValue == FMUtility.POD)
        {
            strSQL += "";
        }
        if (DocumentTypeValue == FMUtility.COD_DOD)
        {
            strSQL += " and WMD.COD_DOD = 'Y'";
        }
        if (DocumentTypeValue == FMUtility.Bill)
        {
            strSQL = "SELECT BM.BillNo, WFD.DocType, WFD.DocketNo, WFD.DocumentNo, WFD.DocumentName, WFD.ScanStatus " +
                     "FROM  Webx_Billmst BM LEFT OUTER JOIN Webx_FM_Scan_Documents WFD ON BM.BillNo = WFD.DocketNo and WFD.DocType='" + DocumentTypeValue + "'," +
                     "(SELECT SetValue FROM WebX_DFM_RULES_DET WHERE RuleID='FIRST_FM_LOC' and DocType='" + DocumentTypeValue + "' and ActiveFlag='Y' and [Enable]='Y') RL, " +
                     "(SELECT SetValue FROM WebX_DFM_RULES_DET WHERE RuleID='SCAN_DOC_AT_HQ' and DocType='" + DocumentTypeValue + "' and ActiveFlag='Y' and [Enable]='Y') RS," +
                     "(SELECT SetValue FROM WebX_DFM_RULES_DET WHERE RuleID='OVER_DOC_AT_HQ' and DocType='" + DocumentTypeValue + "' and ActiveFlag='Y' and [Enable]='Y') RO " +
                     " WHERE BM.BillNo = '" + DocketNo + "' "+
                     " and " +
                     "(" +
                     "	CASE  WHEN WFD.DocType is not null THEN " +
                     "	(" +
                     "		CASE WHEN (case when RL.SetValue='BILL_SUB_LOC' then billsubbrcd else bbrcd end )='" + brcd + "' THEN 'Y'" +
                     "		ELSE ( Case When RO.SetValue='YES' AND '" + headOffice + "'='" + brcd + "' THEN 'Y' ELSE 'N' END ) END" +
                     "	)" +
                     "	ELSE  " +
                     "	(" +
                     "  		CASE WHEN (case when RL.SetValue='BILL_SUB_LOC' then billsubbrcd else bbrcd end )='" + brcd + "' THEN 'Y'" +
                     "		ELSE ( Case When RS.SetValue='YES' AND '" + headOffice + "'='" + brcd + "' THEN 'Y' ELSE 'N' END ) END" +
                     "	)	" +
                     "	END" +
                     ")='Y'";
        }

        DataSet dsDocket = SqlHelper.ExecuteDataset(connStr, CommandType.Text, strSQL);

        if (dsDocket.Tables[0].Rows.Count > 0)
        {
            byteDocketNoExists = 1;
            foreach (DataRow dr in dsDocket.Tables[0].Rows)
            {
                if (dr["DocType"] != System.DBNull.Value)
                {
                    if (headOffice != brcd)
                    {
                        byteDocketNoExists = 2;
                        strDocumentName = dr["DocumentName"].ToString();
                        strDocumentNo = dr["DocumentNo"].ToString();
                        break;
                    }
                    else
                    {
                        byteDocketNoExists = 3;
                        strDocumentName = dr["DocumentName"].ToString();
                        strDocumentNo = dr["DocumentNo"].ToString();
                        break;
                    }
                }
            }
        }
        return byteDocketNoExists;
    }
    
    private bool CheckFMDocumentsDirectory()
    {
        try
        {
            string strDirectoryName = Server.MapPath(".") + @"\" + FMUtility.FMDocumentDirectory + @"\" + clintName + "";
            if (Directory.Exists(strDirectoryName))
            {
                return true;
            }
            else
            {
                Directory.CreateDirectory(strDirectoryName);
                return true;
            }
        }
        catch (Exception Ex)
        {
            return false;
        }
    }

    private bool CheckDocumentExistance(string FileName)
    {
        try
        {
            return File.Exists(Server.MapPath(".") + @"\" + FMUtility.FMDocumentDirectory + @"\" + FileName);
        }
        catch (Exception Ex)
        {
            return true;
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

    private void CheckAfterDataBind()
    {
        foreach (DataGridItem gridrow in myGrid.Items)
        {
            TextBox txtdoc = (TextBox)gridrow.FindControl("txtDocketNo");

            DropDownList ddl = (DropDownList)gridrow.FindControl("ddlDocType");
            Label lblDocketNo = (Label)gridrow.FindControl("lblDocketNo");
            Label lblScanStatus = (Label)gridrow.FindControl("lblScanStatus_new");
            HyperLink hylView = (HyperLink)gridrow.FindControl("hylView");
            FileUpload fileUpload = ((FileUpload)gridrow.FindControl("fileUpload"));
            
            if (txtdoc.Text == "")
            {
                lblDocketNo.Visible = false;
                lblDocketNo.Text = "";
                continue;
            }

            byte byteDocketExistance = CheckDocketExistace(txtdoc.Text, ddl.SelectedValue);

            if (byteDocketExistance == 0)
            {
                lblScanStatus.Text = "";
                hylView.Visible = false;
                lblDocketNo.Visible = true;
                lblDocketNo.Text = "Invalid Cnote No.! or Not Delivered at " + brcd;
                txtdoc.Focus();
                fileUpload.Enabled = false;
            }
            else if (byteDocketExistance == 1)
            {
                lblScanStatus.Text = "Not Scanned";
                hylView.Visible = false;
                lblDocketNo.Visible = false;
                lblDocketNo.Text = "";
                fileUpload.Enabled = true;
            }
            else if (byteDocketExistance == 2)
            {
                lblScanStatus.Text = "Scanned";
                lblDocketNo.Visible = false;
                hylView.Visible = true;
                hylView.NavigateUrl = "ViewFMScannedDocument.aspx?DocName=" + strDocumentName;
                fileUpload.Enabled = false;
            }
            else if (byteDocketExistance == 3)
            {
                lblScanStatus.Text = "POD Already Uploaded, you can overwrite";
                lblDocketNo.Visible = false;
                lblDocketNo.Text = "";
                hylView.Visible = true;
                hylView.NavigateUrl = "ViewFMScannedDocument.aspx?DocName=" + strDocumentName;
                fileUpload.Enabled = true;
            }

            foreach (DataGridItem gr in OldGid.Items)
            {
                TextBox txtdoc1 = (TextBox)gr.FindControl("txtDocketNo");
                if (txtdoc.Text == txtdoc1.Text)
                {
                    FileUpload fu = ((FileUpload)gr.FindControl("fileUpload"));
                    fileUpload = fu;
                    break;
                }
            }
        }
    }
}
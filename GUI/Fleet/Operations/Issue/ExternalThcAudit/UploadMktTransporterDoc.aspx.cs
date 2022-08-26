using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_UploadMktTransporterDoc : System.Web.UI.Page
{
    public string clintName = "", path = "UploadedImages";
    public MyFleetDataSet _dataSet = new MyFleetDataSet();

    string strDocumentName;
    string strDocumentNo;
    string upload_file;
    string connStr = "", brcd = "", headOffice = "";

    int _lastEditedPage;

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
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
    protected void txtExternalThcNo_TextChanged(object sender, EventArgs e)
    {
        TextBox txtdoc = (TextBox)sender;
        Label lblExternalThcNo = (Label)txtdoc.Parent.FindControl("lblExternalThcNo");
        Label lblScanStatus = (Label)txtdoc.Parent.FindControl("lblScanStatus_new");
        HyperLink hylView = (HyperLink)txtdoc.Parent.FindControl("hylView");
        FileUpload fileUpload = ((FileUpload)txtdoc.FindControl("fileUpload"));

        if (txtdoc.Text == "")
        {
            lblExternalThcNo.Visible = false;
            lblExternalThcNo.Text = "Invalid External Thc No.! ";
            return;
        }

        byte byteDocketExistance = CheckDocketExistace(txtdoc.Text);

        if (byteDocketExistance == 0)
        {
            lblScanStatus.Text = "";
            hylView.Visible = false;
            lblExternalThcNo.Visible = true;
            lblExternalThcNo.Text = "Invalid External Thc No.! ";
            txtdoc.Focus();
            fileUpload.Enabled = false;
        }

        else if (byteDocketExistance == 1)
        {
            lblScanStatus.Text = "Not Scanned";
            hylView.Visible = false;
            lblExternalThcNo.Visible = false;
            lblExternalThcNo.Text = "";
            fileUpload.Enabled = true;
        }
        else if (byteDocketExistance == 3)
        {
            lblScanStatus.Text = "File Already Uploaded, you can overwrite";
            lblExternalThcNo.Visible = false;
            lblExternalThcNo.Text = "";
            hylView.Visible = true;
            hylView.NavigateUrl = "ViewExternalThcScannedDocument.aspx?DocName=" + strDocumentName;
            fileUpload.Enabled = true;
        }
    }

    protected void txtnorwos_TextChanged(object sender, EventArgs e)
    {
        int maxrows = 0;
        if (txtnorwos.Text != "" || txtnorwos.Text != null)
        {
            try
            {
                if (Convert.ToInt16(txtnorwos.Text) != 0)
                {
                    string rowno;
                    rowno = txtnorwos.Text;

                    for (int i = 0; i < Int16.Parse(txtnorwos.Text); i++)
                    {
                        _dataSet.UploadMktTransporterDoc.AddUploadMktTransporterDocRow("", "", "");
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
        MyFleetDataSet.UploadMktTransporterDocRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            upload_file = ((FileUpload)e.Item.FindControl("fileUpload")).FileName.ToString();
            datarow = ((MyFleetDataSet.UploadMktTransporterDocRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtExternalThcNo")).Text = datarow.ExternalThcNo;
            ((TextBox)e.Item.FindControl("lblScanStatus")).Text = datarow.ScanStatus;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

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
                    TextBox txtExternalThcNo = ((TextBox)gridrow.FindControl("txtExternalThcNo"));
                    Label lbl_document_no = (Label)gridrow.FindControl("lbl_document_no");
                    Label lblScanStatus = ((Label)gridrow.FindControl("lblScanStatus_new"));
                    Label lblUloadLink = ((Label)gridrow.FindControl("lblUloadLink"));
                    string docval = "", docval1 = "";
                    bool IsValid = false;
                    byte byteDocketExistance = CheckDocketExistace(txtExternalThcNo.Text);
                    if (byteDocketExistance == 1)
                        IsValid = true;
                    else if (byteDocketExistance == 3)
                        IsValid = true;

                    if (txtExternalThcNo.Text == "")
                    {
                        docval = "NA";
                    }
                    else
                    {
                        docval = txtExternalThcNo.Text.ToString();
                    }
                    
                    string newFName = "";
                    C_dockno = docval;
                    C_docno = docval1;

                    if (IsValid)
                    {
                        if (upload_file.HasFile)
                        {
                            //newFName = GetFileName(upload_file.PostedFile.FileName, txtExternalThcNo.Text.Trim());
				string ImgName = upload_file.PostedFile.FileName;
				int lastIndex = ImgName.LastIndexOf('.');
				var name = ImgName.Substring(0,lastIndex);
				var ext = ImgName.Substring(lastIndex + 1);
      				string  docno = txtExternalThcNo.Text.Trim().Replace("/", "$");
      				newFName = docno + "." + ext;
                            if (CheckDocumentExistance(newFName) == true)
                            {
                            }

                            double dblFileSize = Math.Ceiling(Convert.ToDouble(upload_file.PostedFile.ContentLength) / 1000);
                            double MaxSize = 1024; //1MB
                            if (CheckUploadedImagesDirectory() == false)
                            {
                                throw new Exception("Fail to create directory ");
                            }
                            if (dblFileSize > MaxSize)
                            {
                                lblUloadLink.Text = "<label class='blackfnt' runat='server' style='color: Red;'><br style='font-size: 1pt;'/>Select Document of Size <= " + MaxSize.ToString("0") + " KB!</label>";
                                throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                            }
                            //upload_file.SaveAs(Server.MapPath("../") + @"\" + path + @"\" + clintName + @"\" + newFName);
                            upload_file.SaveAs(Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + @"\" + newFName);
                            
                        }

                        string sp;
                            sp = "USP_FLEETExternalTHC_UploadMktTransporterDoc";
                        string SubmitData = "exec " + sp + " '" + txtExternalThcNo.Text + "','" + newFName + "'";
                        SqlCommand cmd_subdata = new SqlCommand(SubmitData, cn);
                        cmd_subdata.Transaction = trans;
                        cmd_subdata.ExecuteNonQuery();
                        trans.Commit();

                        if (st_dokcno == "")
                            st_dokcno = docval;
                        else
                            st_dokcno = st_dokcno + "~" + docval;

                        if (st_docno == "")
                            st_docno = docval1;
                        else
                            st_docno = st_docno + "~" + docval1;
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
 //final += "&st_filenm=" + "asdasdas";
            final += "&ex_dokcno=" + ex_DockNo;
            final += "&ex_docno=" + ex_docno;
            final += "&ex_doctyp=" + ex_doctyp;
            final += "&ex_reason=" + ex_reason;

            Response.Redirect("UploadMktTransporterDocDone.aspx" + final);
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
        _dataSet.UploadMktTransporterDoc.AddUploadMktTransporterDocRow("", "", "");
    }

    private void BindGrid()
    {
        myGrid.DataSource = _dataSet.UploadMktTransporterDoc;
        myGrid.DataBind();
        _lastEditedPage = myGrid.CurrentPageIndex;
    }

    private void ReverseBind()
    {
        MyFleetDataSet.UploadMktTransporterDocRow datarow;
        foreach (DataGridItem gridrow in myGrid.Items)
        {
            datarow = _dataSet.UploadMktTransporterDoc[gridrow.DataSetIndex];
            upload_file = ((FileUpload)gridrow.FindControl("fileUpload")).FileName.ToString();
            datarow.ExternalThcNo = ((TextBox)gridrow.FindControl("txtExternalThcNo")).Text;
            datarow.ScanStatus = ((TextBox)gridrow.FindControl("lblScanStatus")).Text;
            datarow.DocumentSelect = upload_file;
            _dataSet.UploadMktTransporterDoc[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
        }
    }

    private byte CheckDocketExistace(string ExternalThcNo)
    {
        //byteDocketNoExists = 0 -> Docket No. does not exist in External Thc table
        //byteDocketNoExists = 1 -> Docket No. exists in External Thc table but document is not scanned for docket no. & document type
        //byteDocketNoExists = 2 -> Docket No. exists in External Thc table and document is scanned for docket no. & document type
        //byteDocketNoExists = 3 -> Document is Exist, it can be updated by HQTR

        byte byteDocketNoExists = 0;

        string strSQL = "SELECT ExternalTHCNo,Audit,UploadFileName" +
               " FROM  WEBX_FLEET_ExternalTHC" +
               " WHERE ExternalTHCNo = '" + ExternalThcNo + "'";
        DataSet dsExternalThc = SqlHelper.ExecuteDataset(connStr, CommandType.Text, strSQL);

        if (dsExternalThc.Tables[0].Rows.Count > 0)
        {
            byteDocketNoExists = 1;
            foreach (DataRow dr in dsExternalThc.Tables[0].Rows)
            {
                if (dr["UploadFileName"].ToString() != "")
                {
                    byteDocketNoExists = 3;
                    strDocumentName = dr["UploadFileName"].ToString();
                    strDocumentNo = dr["ExternalTHCNo"].ToString();
                    break;
                }
            }
        }
        return byteDocketNoExists;
    }

    private bool CheckUploadedImagesDirectory()
    {
        try
        {
            //string strDirectoryName = Server.MapPath("../") + @"\" + path + @"\" + clintName + "";
            string strDirectoryName = Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + "";
            
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
            //return File.Exists(Server.MapPath("../") + @"\" + path + @"\" + FileName);
            return File.Exists(Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + FileName);
            
        }
        catch (Exception Ex)
        {
            return true;
        }
    }

    private string GetFileName(string fileName, string docno)
    {
        string strRet = fileName;
        string pat = @"\\(?:.+)\\(.+)\.(.+)";
        Regex r = new Regex(pat);
        Match m = r.Match(fileName);
        string file_ext = m.Groups[2].Captures[0].ToString();
        string filename = m.Groups[1].Captures[0].ToString();
        docno = docno.Replace("/", "$");
        strRet = docno + "." + file_ext;
        return strRet;
    }
}
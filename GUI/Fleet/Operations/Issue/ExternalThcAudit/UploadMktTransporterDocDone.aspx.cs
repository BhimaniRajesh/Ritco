using System;
using System.Data;

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_UploadMktTransporterDocDone : System.Web.UI.Page
{
    static string strFMScanDocumentDetails;
    public string st_dokcno = "", st_docno = "", st_doctyp = "", st_filenm = "";
    public string ex_DockNo = "", ex_docno = "", ex_doctyp = "", ex_reason = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        trFail.Visible = false;
        if (!IsPostBack)
        {
            st_dokcno = Request.QueryString["st_dokcno"].ToString();
            st_docno = Request.QueryString["st_docno"].ToString();
            st_doctyp = Request.QueryString["st_doctyp"].ToString();
            st_filenm = Request.QueryString["st_filenm"].ToString();
            ex_DockNo = Request.QueryString["ex_dokcno"].ToString();
            ex_docno = Request.QueryString["ex_docno"].ToString();
            ex_doctyp = Request.QueryString["ex_doctyp"].ToString();
            ex_reason = Request.QueryString["ex_reason"].ToString();
            DisplayExternalThcScannedDetails();
            DisplayExternalThcScannedFailDetails();
        }
    }
    private void DisplayExternalThcScannedDetails()
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("SrNo", typeof(string));
        dt.Columns.Add("ExternalThcNo", typeof(string));
        dt.Columns.Add("NavURL", typeof(string));
        DataRow dr;
        int i = 1;
        string[] st_dokcno_arr = st_dokcno.Split('~');
        string[] st_docno_arr = st_docno.Split('~');
        string[] st_doctyp_arr = st_doctyp.Split('~');
        string[] st_filenm_arr = st_filenm.Split('~');
        for (int intLoopCounter = 0; intLoopCounter < st_dokcno_arr.Length; intLoopCounter++)
        {
            dr = dt.NewRow();
            dr["SrNo"] = i.ToString();
            i++;
            dr["ExternalThcNo"] = st_dokcno_arr[intLoopCounter];
            dr["NavURL"] = "ViewExternalThcScannedDocument.aspx?DocName=" + st_filenm_arr[intLoopCounter];

            dt.Rows.Add(dr);
        }
        gvSuccess.DataSource = dt;
        gvSuccess.DataBind();
    }
    private void DisplayExternalThcScannedFailDetails()
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("SrNo", typeof(string));
        dt.Columns.Add("ExternalThcNo", typeof(string));
        dt.Columns.Add("Reason", typeof(string));
        DataRow dr;
        int i = 1;
        string[] ex_dokcno_arr = ex_DockNo.Split('~');
        string[] ex_docno_arr = ex_docno.Split('~');
        string[] ex_doctyp_arr = ex_doctyp.Split('~');
        string[] ex_reason_arr = ex_reason.Split('~');

        for (int intLoopCounter = 0; intLoopCounter < ex_dokcno_arr.Length; intLoopCounter++)
        {
            if (ex_dokcno_arr[intLoopCounter].Trim() != "")
            {
                dr = dt.NewRow();
                dr["SrNo"] = (intLoopCounter + 1).ToString();
                dr["ExternalThcNo"] = ex_docno_arr[intLoopCounter];
                dr["Reason"] = ex_reason_arr[intLoopCounter];

                dt.Rows.Add(dr);
            }
        }
        if (dt.Rows.Count > 0)
            trFail.Visible = true;
        else
            trFail.Visible = false;
        gvFail.DataSource = dt;
        gvFail.DataBind();
    }
}
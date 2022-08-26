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
using System.Data.SqlClient;
using System.IO;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_FM_Scan_Report_Result : System.Web.UI.Page
{
    string strConnString = "", dkt_call = "", RO = "", RO_Text = "", LO = "", LO_Text = "", FromDT = "", ToDT = "", DOC_Type = "", Doc_No = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["RO"] != null)
            RO = Request.QueryString["RO"].ToString();
        if (Request.QueryString["RO_Text"] != null)
            RO_Text = Request.QueryString["RO_Text"].ToString();
        if (Request.QueryString["LO"] != null)
            LO = Request.QueryString["LO"].ToString();
        if (Request.QueryString["LO_Text"] != null)
            LO_Text = Request.QueryString["LO_Text"].ToString();
        if (Request.QueryString["FromDT"] != null)
            FromDT = Request.QueryString["FromDT"].ToString();
        if (Request.QueryString["ToDT"] != null)
            ToDT = Request.QueryString["ToDT"].ToString();
        if (Request.QueryString["DOC_Type"] != null)
            DOC_Type = Request.QueryString["DOC_Type"].ToString();
        if (Request.QueryString["Doc_No"] != null)
            Doc_No = Request.QueryString["Doc_No"].ToString();

        strConnString = SessionUtilities.ConnectionString;
        dkt_call = SessionUtilities.DocketCalledAs;

        if (!IsPostBack)
        {
            BindFilter();
            BindData();
        }
    }

    private void BindData()
    {
        DataSet ds = GetData();
        if (ds.Tables.Count > 0)
        {
            ShowHideDownload((ds.Tables[0].Rows.Count > 0));
        }
        if (DOC_Type == FMUtility.POD)
        {
            trDocket.Visible = true;
            trdg_bill.Visible = false;
            trdg_coddod.Visible = false;

            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            
        }
        else if (DOC_Type == FMUtility.COD_DOD)
        {
            trDocket.Visible = false;
            trdg_bill.Visible = false;
            trdg_coddod.Visible = true;

            dg_coddod.DataSource = ds;
            dg_coddod.DataBind();           
        }
        else if (DOC_Type == FMUtility.Bill)
        {
            trDocket.Visible = false;
            trdg_bill.Visible = true;
            trdg_coddod.Visible = false;

            dg_bill.DataSource = ds;
            dg_bill.DataBind();            
        }
    }

    private void BindFilter()
    {
        lblDocType.Text = GetDocTypeDesc();
        if (Doc_No == "")
        {
            lblDate.Text = FromDT + " - " + ToDT;
            lblRO.Text = RO_Text;
            lblLO.Text = LO_Text;
        }
        else
        {
            lblDocNos.Text = Doc_No;
        }
    }

    private string GetDocTypeDesc()
    {
        string fileName = "";
        if (DOC_Type == FMUtility.POD)
            fileName = "POD";
        if (DOC_Type == FMUtility.Bill)
            fileName = "Bill";
        if (DOC_Type == FMUtility.COD_DOD)
            fileName = "COD/DOD";
        if (DOC_Type == FMUtility.Octroi)
            fileName = "Octroi";
        return fileName;
    }

    private DataSet GetData()
    {
        string sp = "usp_Get_Scaned_Documents";
        SqlParameter[] prm = new SqlParameter[6];
        prm[0] = new SqlParameter("@DOC_TYPE", DOC_Type);
        prm[1] = new SqlParameter("@DOC_NOS", Doc_No);
        prm[2] = new SqlParameter("@Region", RO);
        prm[3] = new SqlParameter("@Location", LO);
        prm[4] = new SqlParameter("@FromDate", FromDT);
        prm[5] = new SqlParameter("@ToDate", ToDT);

        return SqlHelper.ExecuteDataset(strConnString, CommandType.StoredProcedure, sp, prm);
    }
    private DataSet GetExportData()
    {
        string sp = "usp_Get_Scaned_Documents_Export";
        SqlParameter[] prm = new SqlParameter[6];
        prm[0] = new SqlParameter("@DOC_TYPE", DOC_Type);
        prm[1] = new SqlParameter("@DOC_NOS", Doc_No);
        prm[2] = new SqlParameter("@Region", RO);
        prm[3] = new SqlParameter("@Location", LO);
        prm[4] = new SqlParameter("@FromDate", FromDT);
        prm[5] = new SqlParameter("@ToDate", ToDT);

        return SqlHelper.ExecuteDataset(strConnString, CommandType.StoredProcedure, sp, prm);
    }

    protected void GV_D_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            dkt_colname.Text = dkt_call;
        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView gv = sender as GridView;
        gv.PageIndex = e.NewPageIndex;
        BindData();
    }
    
    protected void btnXLS_Click(object sender, EventArgs e)
    {
        string fileName = GetDocTypeDesc();
        fileName = fileName.Replace("/", "_");
        fileName += "_Scan_Report";

        GridView grdResult = new GridView();
        if (DOC_Type == FMUtility.POD)
            grdResult = dgDocket;
        if (DOC_Type == FMUtility.COD_DOD)
            grdResult = dg_coddod;
        if (DOC_Type == FMUtility.Bill)
            grdResult = dg_bill;
       
        grdResult.AllowPaging = false;
        grdResult.GridLines = GridLines.Both;
        grdResult.DataSource = GetData();
        grdResult.DataBind();
        BindFilter();
        TBL_CRI.Border = 1;

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(grdResult);
        frm.RenderControl(htmlWrite);

        if (ConfigurationManager.AppSettings["ZipDownload"].ToLower() == "true")
        {
            DataTableHelper.ExportToZipXLS(stringWrite, Response, fileName);
        }
        else
        {
            DataTableHelper.ExportToXLS(stringWrite, Response, fileName);
        }
    }

    protected void btnCSV_Click(object sender, EventArgs e)
    {
        string fileName = GetDocTypeDesc();
        fileName = fileName.Replace("/", "_");
        fileName += "_Scan_Report";

        string sFilter = "";

        if (Doc_No.Trim() == "")
        {
            sFilter += "Type," + GetDocTypeDesc() + Environment.NewLine;
            sFilter = "Date," + FromDT + " - " + ToDT + Environment.NewLine;
            sFilter += "Region," + RO_Text + Environment.NewLine;
            sFilter += "Location," + LO_Text + Environment.NewLine;            
        }
        else
        {
            sFilter += "Type," + GetDocTypeDesc() + Environment.NewLine;
            sFilter += "Documents," + Doc_No.Replace(","," - ") + Environment.NewLine;
        }        

        DataSet ds = GetExportData();
        if (ConfigurationManager.AppSettings["ZipDownload"].ToLower() == "true")
        {
            DataTableHelper.ExportToZipCSV(ds.Tables[0], Response, fileName, sFilter);
        }
        else
        {
            DataTableHelper.ExportToCSV(ds.Tables[0], Response, fileName, sFilter);
        } 
    }

    private void ShowHideDownload(bool show)
    {
        btnCSV.Visible = show;
        btnCSV_1.Visible = show;
        btnXLS.Visible = show;
        btnXLS_1.Visible = show;
    }
}

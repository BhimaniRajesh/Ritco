using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_FM_AcknowledgeFMDocumentsMain_new : System.Web.UI.Page
{
    public string mHeadOfficeCode = "", brcd = "", dkt_call = "", st_fmnolist, st_dtfrom, st_dtto, st_ddlDocType, st_fwd_st, st_doc_fwd;
    public byte byteRadButtonSelection;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = SessionUtilities.CurrentBranchCode;
        mHeadOfficeCode = SessionUtilities.HeadOfficeCode;
        dkt_call = SessionUtilities.DocketCalledAs;
        if (!IsPostBack)
        {
            FMUtility.BindFMDocTypes(ddlDocType, "");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        st_dtfrom = DT.DateFrom.ToString("dd MMM yyyy");
        st_dtto = DT.DateTo.ToString("dd MMM yyyy");
        st_ddlDocType = ddlDocType.SelectedValue.ToString();
        st_fwd_st = "";//ddlFMStatus.SelectedValue.ToString();
        st_doc_fwd = ddlFwdDocTo.SelectedValue.ToString();

        st_fmnolist = txtFMNo.Text.ToString();     
          
        BindGrid();
    }

    public void BindGrid()
    {
        String SQL_grid = "exec webx_FM_DOC_FOR_ACk '" + st_dtfrom + "','" + st_dtto + "','" + st_ddlDocType + "','" + st_doc_fwd + "','" + st_fwd_st + "','" + st_fmnolist + "','','" + brcd + "'";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);
        dgDocket.Visible = true;

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Style["display"] = "block";
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

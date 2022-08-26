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
using System.IO;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_FM_Track_POD : System.Web.UI.Page
{
    public string mHeadOfficeCode = "", brcd = "", dkt_call = "", st_fmnolist, st_dtfrom, st_dtto, st_ddlDocType, st_fwd_st, st_doc_fwd;
  
    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = SessionUtilities.ConnectionString;
        dkt_call = SessionUtilities.DocketCalledAs;
        if (!IsPostBack & !IsCallback)
        {
            FMUtility.BindFMDocTypes(ddlDocType, "");
            ddlDocType.Items.RemoveAt(0);           
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    private void BindGrid()
    {
        string st_dktno = txtdktno.Text.ToString();
        string DocType = ddlDocType.SelectedValue.ToString();
        string query = "";
        if (DocType == FMUtility.POD)
        {
            query = "select dockno,fm_doc_type,fm_no,fmdt,fromloc=(select loccode +':' + locname from webx_location where loccode=FM_crrloc),toLoc=loc_cust_code+ ' -('+doc_fwd_to+')',doc_status,Ack_Date from VW_FM_TRACK_Report where dockno='" + st_dktno + "' and fm_doc_type='" + FMUtility.POD + "'";
            //Response.Write("<br> SQL_grid : " + query);
        }
        if (DocType == FMUtility.COD_DOD)
        {
            query = "select dockno,fm_doc_type,DocumentNo,Convert(varchar,DocumentDate,6) as DocumentDate,fm_no,fmdt,fromloc=(select loccode +':' + locname from webx_location where loccode=FM_crrloc),toLoc=loc_cust_code+ ' -('+doc_fwd_to+')',doc_status,Ack_Date from VW_FM_TRACK_Report where dockno='" + st_dktno + "' and fm_doc_type='" + FMUtility.COD_DOD + "'";
            //Response.Write("<br> SQL_grid : " + query);
        }
        if (DocType == FMUtility.Bill)
        {
            query = "select Bill_No,fm_doc_type,fm_no,fmdt,fromloc=(select loccode +':' + locname from webx_location where loccode=FM_crrloc),toLoc=loc_cust_code+ ' -('+doc_fwd_to+')',doc_status,Ack_Date from VW_FM_TRACK_Report where Bill_No='" + st_dktno + "' and fm_doc_type='" + FMUtility.Bill + "'";
        }
        if (query != "")
        {
            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, query);
            dgDocket.Visible = true;

            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            dgDocket.Style["display"] = "block";
        }    
    }

    protected void btnXLS_Click(object sender, EventArgs e)
    {
        dgDocket.AllowPaging = false;
        dgDocket.GridLines = GridLines.Both;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=DFM_TRACK_Result.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
}

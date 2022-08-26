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
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Operations_PFM_pfm_print : System.Web.UI.Page
{
    public string strPFMNo = "", strDocTyp = "", print_yn="", strSQL = "", PFMNO="";
    protected void Page_Load(object sender, EventArgs e)
    {
        string strPFMNo = Convert.ToString(Request.QueryString["strPFMNo"]);
        
        //lblPFMNo.Text = strPFMNo;

        string[] Split = strPFMNo.Split(new Char[] { ',' });
        PFMNO = Convert.ToString(Split[0]);
        strDocTyp = Convert.ToString(Split[1]);
        print_yn = Convert.ToString(Split[2]);

        strSQL = "select fm_no,fmdt,fm_fwd_loccode,FM_CrrLoc,courier_code,courier_way_bill_no,waybilldate,FM_Next_loc,Orgn_Dest,Total_Documents,convert(varchar,dockDt,106) as dockDt,* from VW_FM_View where fm_no ='" + PFMNO + "'";
        //Response.Write(strSQL);
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL);
        if(ds.Tables.Count >0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                lblPFMDt.Text = dr["fmdt"].ToString();
                lblPrepareAt.Text = dr["fm_fwd_loccode"].ToString();
                lblPFMFrom.Text = dr["FM_CrrLoc"].ToString();
                lblForwardedTo.Text = dr["loc_cust_code"].ToString() + "  (" + dr["doc_fwd_to"].ToString() + ")";
                lblTotalCN.Text = dr["Total_Documents"].ToString();
                lblCourierName.Text = dr["courier_code"].ToString();
                lblWayBillNo.Text = dr["courier_way_bill_no"].ToString();
                lblWayBillDt.Text = dr["waybilldate"].ToString();
            }
        }
        if (print_yn == "1")
        {
            gvpdclist.CellSpacing = 0;
            gvpdclist.GridLines = GridLines.Both;
            gvpdclist.HeaderStyle.BackColor = System.Drawing.Color.White;
            
            gv_bill.CellSpacing = 0;
            gv_bill.HeaderStyle.BackColor = System.Drawing.Color.White;
            gv_bill.GridLines = GridLines.Both;

            gv_CODDOD.CellSpacing = 0;
            gv_CODDOD.HeaderStyle.BackColor = System.Drawing.Color.White;
            gv_CODDOD.GridLines = GridLines.Both;
        }
        if (strDocTyp == FMUtility.POD)
        {
            gvpdclist.Visible = true;
            gv_bill.Visible = false;
            gv_CODDOD.Visible = false;

            strSQL = "select ID, HDR_ID, DockNo,convert(varchar, DockDt,6) as bookdate, Amount, Orgn_Dest, From_To,convert(varchar,Dely_Date,6) as deldt,Scan_Status=(case when (select top 1 documentname from Webx_FM_Scan_Documents where docketno=a.DockNo) is NULL then 'N' when (select top 1 documentname from Webx_FM_Scan_Documents where docketno=a.DockNo) <> '' then 'Y' end), Doc_Recieved=(Case when a.FM_ack_status='Y' then 'Yes' when a.FM_ack_status<>'Y' then 'No' else 'No' end) FROM webx_fm_fwd_doc_detail a WHERE HDR_ID=(select top 1 id from webx_fm_fwd_doc_master WHERE fm_no ='" + PFMNO + "')";
            //Response.Write(strSQL);
            ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL);
            gvpdclist.DataSource = ds;
            gvpdclist.DataBind();
        }
        if (strDocTyp == FMUtility.Bill)
        {
            gvpdclist.Visible = false;
            gv_bill.Visible = true;
            gv_CODDOD.Visible = false;

            strSQL = "select ID,HDR_ID,Bill_No,Manual_Bill_No,Bill_Date=Convert(varchar,Bill_Date,6),Billing_Party,Bill_Amount,Submission_Location,Scan_Status=(case when (select top 1 documentname from Webx_FM_Scan_Documents where docketno=a.DockNo) is NULL then 'N' when (select top 1 documentname from Webx_FM_Scan_Documents where docketno=a.DockNo) <> '' then 'Y' end),Doc_Recieved=(Case when a.FM_ack_status='Y' then 'Yes' when a.FM_ack_status<>'Y' then 'No' else 'No' end) FROM webx_fm_fwd_doc_detail a WHERE HDR_ID=(select top 1 id from webx_fm_fwd_doc_master WHERE fm_no ='" + PFMNO + "')";
            ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL);
            gv_bill.DataSource = ds;
            gv_bill.DataBind();
        }
        if (strDocTyp == FMUtility.COD_DOD)
        {
            gvpdclist.Visible = false;
            gv_bill.Visible = false;
            gv_CODDOD.Visible = true;

            strSQL = "select ID, HDR_ID, DockNo,DocumentNo, convert(varchar, DocumentDate,6) as DocumentDate, convert(varchar, DockDt,6) as bookdate, Amount, Orgn_Dest, From_To,convert(varchar,Dely_Date,6) as deldt,Scan_Status=(case when (select top 1 documentname from Webx_FM_Scan_Documents where docketno=a.DockNo) is NULL then 'N' when (select top 1 documentname from Webx_FM_Scan_Documents where docketno=a.DockNo) <> '' then 'Y' end), Doc_Recieved=(Case when a.FM_ack_status='Y' then 'Yes' when a.FM_ack_status<>'Y' then 'No' else 'No' end) FROM webx_fm_fwd_doc_detail a WHERE HDR_ID=(select top 1 id from webx_fm_fwd_doc_master WHERE fm_no ='" + PFMNO + "')";
            ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL);
            gv_CODDOD.DataSource = ds;
            gv_CODDOD.DataBind();
        }
    }
}

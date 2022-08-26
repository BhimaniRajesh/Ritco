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

public partial class GUI_Operations_FM_AcknowledgeFMDocumentsMain_Det_new : System.Web.UI.Page
{
    public int intTotalRecords;
    public string mHeadOfficeCode = "", brcd = "",dkt_call="" ;

    public string strFMType { get { return (ViewState["FMType"] != null) ? ViewState["FMType"].ToString() : ""; } set { ViewState["FMType"] = value; } }
    public string strFMNo { get { return (ViewState["FMNo"] != null) ? ViewState["FMNo"].ToString() : ""; } set { ViewState["FMNo"] = value; } }
    public string str_fin_fwd { get { return (ViewState["str_fin_fwd"] != null) ? ViewState["str_fin_fwd"].ToString() : ""; } set { ViewState["str_fin_fwd"] = value; } }
    public string st_id { get { return (ViewState["st_id"] != null) ? ViewState["st_id"].ToString() : ""; } set { ViewState["st_id"] = value; } }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = SessionUtilities.CurrentBranchCode;
        mHeadOfficeCode = SessionUtilities.HeadOfficeCode;
        dkt_call = SessionUtilities.DocketCalledAs;
        if (!IsPostBack)
        {
            string[] str_arr = HttpUtility.UrlDecode(Request.QueryString["FMN"].ToString()).Split('~');

            strFMNo = str_arr[0].ToString().Replace("%2f", "/");
            strFMType = str_arr[1].ToString();

            getFmDetail();
            if (strFMType.Trim() == FMUtility.POD)
            {
                BindGrid();
            }
            if (strFMType.Trim() == FMUtility.Bill)
            {
                BindGrid_Bill();
            }
            if (strFMType.Trim() == FMUtility.COD_DOD)
            {
                BindCODDODGrid();
            }
        }
    }

    public  void getFmDetail()
    {
        string sql_fm_details = "SELECT ID, FM_No, Manual_FM_No, convert(varchar,FM_Date,6) as  fmdt, convert(varchar,FM_Entry_Date,6) as fmentrydt,(Case Doc_FWD_To WHEN 1 THEN 'Customer' WHEN 2 THEN 'Location' END) AS Doc_FWD_To,loc_cust_code=(case when doc_fwd_to='1' then (select top 1 custcd +' : '+custnm from webx_custhdr with(NOLOCK) where custcd=loc_cust_code) when doc_fwd_to='2' then (select top 1 loccode +' : '+locname from webx_location with(NOLOCK) where loccode=loc_cust_code) end), (case FM_Doc_Type WHEN 1 THEN 'POD' WHEN 2 THEN 'Bill' WHEN 3 THEN 'Octroi Receipt' WHEN 4 THEN 'COD/DOD' END) AS FM_Doc_Type, Courier_Code, Courier_Way_Bill_No, convert(varchar,Courier_Way_Bill_Date,6) as waybiidt, isnull(FM_Ack_Status,'N'), FM_FWD_LocCode, FM_FWD_CurrYear FROM webx_fm_fwd_doc_master   with(NOLOCK) where fm_no='" + strFMNo + "'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql_fm_details).Tables[0];
        if(dt.Rows.Count > 0)
        {
            DataRow dr_details = dt.Rows[0];
            lblfmno.Text = dr_details["FM_No"].ToString();
            lblfm_cust_location.Text = dr_details["loc_cust_code"].ToString();
            lblfm_doc_typ.Text = dr_details["FM_Doc_Type"].ToString();
            lblfm_wayBilldate.Text = dr_details["waybiidt"].ToString();
            lblfm_wayBillno.Text = dr_details["Courier_Way_Bill_No"].ToString();
            lblfmCouriour.Text = dr_details["Courier_Code"].ToString();
            lblfmdt.Text = dr_details["fmdt"].ToString();
            lblfmEntrydt.Text = dr_details["fmentrydt"].ToString();
            lblfmFWDto.Text = dr_details["Doc_FWD_To"].ToString();
            lblManualfmno.Text = dr_details["Manual_FM_No"].ToString();
            st_id= dr_details["ID"].ToString();
            str_fin_fwd = dr_details["Doc_FWD_To"].ToString();
        }
    }

    protected void GV_D_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            dkt_colname.Text = dkt_call;
        }
    }
    private void BindGrid_Bill()
    {
        dgDocket.Visible = false;
        dg_bill.Visible = true;
        gv_coddod.Visible = false;

        string SQL_grid = "select ID, HDR_ID, Bill_No, Manual_Bill_No, convert(varchar,Bill_Date,6) as Bill_Date, Billing_Party, Bill_Amount, Submission_Location FROM webx_fm_fwd_doc_detail WHERE HDR_ID=(select top 1  id from webx_fm_fwd_doc_master WHERE fm_no='" + strFMNo + "' order by FM_Entry_Date desc )";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);

        dg_bill.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        dg_bill.DataBind();        
    }

    private void BindGrid()
    {
        dgDocket.Visible = true;
        dg_bill.Visible = false;
        gv_coddod.Visible = false;

        string SQL_grid = "select ID, HDR_ID, DockNo,convert(varchar, DockDt,6),   Amount, Orgn_Dest, From_To, convert(varchar,Dely_Date,6) as deldt FROM webx_fm_fwd_doc_detail WHERE HDR_ID=(select top 1  id from webx_fm_fwd_doc_master WHERE fm_no='" + strFMNo + "' order by FM_Entry_Date desc )";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);

        dgDocket.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        dgDocket.DataBind();        
    }

    private void BindCODDODGrid()
    {
        gv_coddod.Visible = true;
        dgDocket.Visible = false;
        dg_bill.Visible = false;

        string SQL_grid = "select ID, HDR_ID, DockNo,DocumentNo,convert(varchar, DocumentDate,6) as DocumentDate,convert(varchar, DockDt,6),   Amount, Orgn_Dest, From_To, convert(varchar,Dely_Date,6) as deldt FROM webx_fm_fwd_doc_detail WHERE HDR_ID=(select top 1  id from webx_fm_fwd_doc_master WHERE fm_no='" + strFMNo + "' order by FM_Entry_Date desc )";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);

        gv_coddod.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        gv_coddod.DataBind();
    }

    protected void btnUpdt_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        string st_status = "Received At";
        string sql_FM_header="";
        SqlTransaction trans = conn.BeginTransaction();;
        try
        {
            if (str_fin_fwd == "Location")
            {
                sql_FM_header = "update webx_fm_fwd_doc_master set FM_Ack_Status='Y',FM_Rec_dt=getdate(),FM_Status='Received At',FM_Close='N'  where ID='" + st_id + "'";
                st_status = "Received At";
            }
            else if (str_fin_fwd == "Customer")
            {
                sql_FM_header = "update webx_fm_fwd_doc_master set FM_Ack_Status='Y',FM_Rec_dt=getdate(),FM_Status='Received By ',FM_Close='Y'  where ID='" + st_id + "'";
                st_status = "Received By";
            }
            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_FM_header);
            if (strFMType == FMUtility.POD || strFMType == FMUtility.COD_DOD)
            {
                GridView gv = dgDocket;
                if (strFMType == FMUtility.POD)
                    gv = dgDocket;
                else if (strFMType == FMUtility.COD_DOD)
                    gv = gv_coddod;

                foreach (GridViewRow GDV in gv.Rows)
                {
                    CheckBox dkt_chk = (CheckBox)GDV.FindControl("chkOrderNo");
                    HiddenField hdval = (HiddenField)GDV.FindControl("hdncomm");
                    Label dkt_Docket = (Label)GDV.FindControl("lbldockno");

                    if (dkt_chk.Checked)
                    {
                        string sql_pod_entry = "update WebX_FM_FWD_DOC_Detail set FM_Ack_Status='Y',Updt=getdate() ,doc_status='" + st_status + "', CurrLoc=(select top 1 Loc_Cust_Code from WebX_FM_FWD_DOC_Master where id=hdr_id) where id='" + hdval.Value.ToString() + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_pod_entry);
                    }
                    else
                    {
                        string sql_pod_entry = "update WebX_FM_FWD_DOC_Detail set FM_Ack_Status='N',Updt=getdate() ,doc_status='Not Received',CurrLoc=(select top 1 FM_FWD_LocCode from WebX_FM_FWD_DOC_Master where id=hdr_id)  where id='" + hdval.Value.ToString() + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_pod_entry);
                    }
                }
            }
            if (strFMType == FMUtility.Bill)
            {
                foreach (GridViewRow GDV in dg_bill.Rows)
                {
                    CheckBox dkt_chk = (CheckBox)GDV.FindControl("chkOrderNo");
                    HiddenField hdval = (HiddenField)GDV.FindControl("hdncomm");
                    Label lblBillNo = (Label)GDV.FindControl("lblBillNo");

                    if (dkt_chk.Checked)
                    {
                        string sql_pod_entry = "update WebX_FM_FWD_DOC_Detail set FM_Ack_Status='Y',Updt=getdate() ,doc_status='" + st_status + "', CurrLoc=(select top 1 Loc_Cust_Code from WebX_FM_FWD_DOC_Master where id=hdr_id) where id='" + hdval.Value.ToString() + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_pod_entry);
                    }
                    else
                    {
                        string sql_pod_entry = "update WebX_FM_FWD_DOC_Detail set FM_Ack_Status='N',Updt=getdate() ,doc_status='Not Received',CurrLoc=(select top 1 FM_FWD_LocCode from WebX_FM_FWD_DOC_Master where id=hdr_id)  where id='" + hdval.Value.ToString() + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_pod_entry);
                    }
                }
            }
            trans.Commit();
            conn.Close();
            Response.Redirect("DisplayFMAckDocumentsResult.aspx?FMNo=" + strFMNo + "&FMID=" + strFMType);
        }
        catch (Exception Ex)
        {
            trans.Rollback();

            lblerrro.Style["display"] = "block";
            lblerrro.Text = Ex.Message;
            lblerrro.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }
}

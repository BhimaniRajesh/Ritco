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

public partial class GUI_Operations_FM_ForwardFMDocumentsMain_new : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    public string mHeadOfficeCode = "", brcd = "", dkt_call = "", currdate = DateTime.Now.ToString("dd/MM/yyyy");
    public string val_doctyp { get { return (ViewState["val_doctyp"] != null) ? ViewState["val_doctyp"].ToString() : ""; } set { ViewState["val_doctyp"] = value; } }
    public string st_docklist { get { return (ViewState["st_docklist"] != null) ? ViewState["st_docklist"].ToString() : ""; } set { ViewState["st_docklist"] = value; } }
    public string val_ddlpaybas { get { return (ViewState["val_ddlpaybas"] != null) ? ViewState["val_ddlpaybas"].ToString() : ""; } set { ViewState["val_ddlpaybas"] = value; } }
    public string st_dtfrom { get { return (ViewState["st_dtfrom"] != null) ? ViewState["st_dtfrom"].ToString() : ""; } set { ViewState["st_dtfrom"] = value; } }
    public string st_dtto { get { return (ViewState["st_dtto"] != null) ? ViewState["st_dtto"].ToString() : ""; } set { ViewState["st_dtto"] = value; } }
    
    SqlConnection conn;
    DateFunction df = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        /// lblToday.InnerHtml = "Today: " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
        /// 
        brcd = SessionUtilities.CurrentBranchCode;
        mHeadOfficeCode = SessionUtilities.HeadOfficeCode;
        dkt_call = SessionUtilities.DocketCalledAs;
        if (!IsPostBack)
        {
            lblFMEntryDate.InnerHtml = System.DateTime.Today.ToString("dd MMM yy");
            FMUtility.BindFMDocTypes(ddlDocType, "");
            FMUtility.BindPayBas(dllPaybas, "All");
        }
        btnUpdt.Style["display"] = "none";
        dgDocket.Style["display"] = "none";
        dg_bill.Style["diaplay"] = "none";
        // lblerrro.Style["display"] = "none";
        lblerrro.Text = "";          
    }

    protected void ddlFwdDocTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCustomerLocation.Items.Clear();

        switch (ddlFwdDocTo.SelectedValue)
        {
            case "":
                break;
            case "1":
                PopulateCustomer();
                ddlCustomerLocation.Focus();
                break;
            case "2":
                PopulateLocation();
                ddlCustomerLocation.Focus();
                break;
        }
    }

    private void PopulateCustomer()
    {
        FMUtility.BindCustomer(ddlCustomerLocation, "");
    }

    private void PopulateLocation()
    {
        //FMUtility.BindLocation(ddlCustomerLocation, "", SessionUtilities.CurrentBranchCode);
        if (ddlDocType.SelectedValue == "1")
        {
            DFMRules_Details rule = DFMRules_Details.GetByRuleIDDocType("FWD_LOC_REST", ddlDocType.SelectedValue);
            if (rule.ActiveFlag == "Y")
            {
                if (rule.SetValue.ToUpper() == "NONE" || rule.SetValue.ToUpper() == "NA")
                    FMUtility.BindLocation(ddlCustomerLocation, "", SessionUtilities.CurrentBranchCode);
                else
                    FMUtility.BindSelectedLocation(ddlCustomerLocation, "", rule.SetValue);
            }
            else { FMUtility.BindLocation(ddlCustomerLocation, "", SessionUtilities.CurrentBranchCode); }
        }
        else { FMUtility.BindLocation(ddlCustomerLocation, "", SessionUtilities.CurrentBranchCode); }
    }

    protected void btnShowList_Click(object sender, EventArgs e)
    {
        val_doctyp = ddlDocType.SelectedValue.ToString();
        val_ddlpaybas = dllPaybas.SelectedValue.ToString();
        st_docklist = txtDockets.Text.ToString();

        st_dtfrom = DT.DateFrom.ToString("dd MMM yy");
        st_dtto = DT.DateTo.ToString("dd MMM yy");
       
        switch (val_doctyp)
        {
            case FMUtility.POD:
                BindGrid();
                break;
            case FMUtility.Bill:
                Bindgrid_for_bill();
                break;
            case FMUtility.Octroi:
                break;
            case FMUtility.COD_DOD:
                BindGrid_for_CODDOD();
                break;
        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    public void BindGrid()
    {
        string SQL_grid = "exec webx_pods_for_pfm '" + st_docklist + "','" + val_ddlpaybas + "','" + brcd + "','" + st_dtfrom + "','" + st_dtto + "'";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);
        dgDocket.Visible = true;
        dg_bill.Visible = false;
        dg_coddod.Visible = false;

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Style["display"] = "block";       
        if (dgDocket.Rows.Count > 0)
        {
            trSub.Visible = true;
            btnUpdt.Visible = true;
            btnUpdt.Style["display"] = "block";
            lblerrro.Style["display"] = "block";
        }
    }

    private void BindGrid_for_CODDOD()
    {
        dg_bill.Visible = false;
        dgDocket.Visible = false;
        dg_coddod.Visible = true;

        string SQL_grid = "exec webx_DocList_for_pfm '" + st_docklist + "','4','" + brcd + "','" + st_dtfrom + "','" + st_dtto + "',NULL,NULL,'" + val_ddlpaybas + "'";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);       

        dg_coddod.DataSource = ds;
        dg_coddod.DataBind();
        dg_coddod.Style["display"] = "block";
        if (dg_coddod.Rows.Count > 0)
        {
            trSub.Visible = true;
            btnUpdt.Visible = true;
            btnUpdt.Style["display"] = "block";
            lblerrro.Style["display"] = "block";
        }
    }

    private void Bindgrid_for_bill()
    {
        dg_bill.Visible = true;
        dgDocket.Visible = false;
        dg_coddod.Visible = false;

        string SQL_grid = "exec webx_DocList_for_pfm '" + st_docklist + "','2','" + brcd + "','" + st_dtfrom + "','" + st_dtto + "'";
        if (ddlFwdDocTo.SelectedValue == "1")
            SQL_grid += ",'" + ddlCustomerLocation.SelectedValue + "',NULL,NULL";
        else if (ddlFwdDocTo.SelectedValue == "2")
            SQL_grid += ",NULL,'" + ddlCustomerLocation.SelectedValue + "',NULL";
        else
            SQL_grid += ",NULL,NULL,NULL";

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL_grid);
        dgDocket.Visible = false;
        dg_bill.Visible = true;

        dg_bill.DataSource = ds;
        dg_bill.DataBind();
        dg_bill.Style["display"] = "block";
        if (dg_bill.Rows.Count > 0)
        {
            trSub.Visible = true;
            btnUpdt.Visible = true;
            btnUpdt.Style["display"] = "block";
            lblerrro.Style["display"] = "block";
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

    protected void btnUpdt_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trans = conn.BeginTransaction();

        int cnt = 0;
        GridView gv = dgDocket;
        string DocType = "";
        switch (val_doctyp)
        {
            case FMUtility.POD:
                DocType = "PFM";
                gv = dgDocket;
                break;
            case FMUtility.Bill:
                DocType = "Bill";
                gv = dg_bill;
                break;
            case FMUtility.Octroi:
                break;
            case FMUtility.COD_DOD:
                DocType = "COD";
                gv = dg_coddod;
                break;
        }

        foreach (GridViewRow GDV in gv.Rows)
        {
            CheckBox dkt_chk1 = (CheckBox)GDV.FindControl("chkOrderNo");
            if (dkt_chk1.Checked == true)
            { cnt = cnt + 1; }
        }
        try
        {   //string Year = SessionUtilities.FinYear.Substring(2, 2);            
            string Year = System.DateTime.Today.Year.ToString().Substring(2);
            //if(DateTime.Now.Month > 3)
            //    Year = SessionUtilities.FinYear.Substring(2, 2);
            //else
            //    Year = SessionUtilities.FinYear.Substring(0, 2);

            string srno = "";

            string SQL_MAXFMNO = "select dbo.WebX_FN_FM_FWD_Get_Next_FM_No('" + brcd + "','" + Year + "','" + FMUtility.GetFMDocketTypeSuffix(val_doctyp) + "'," + val_doctyp + ")";

            string FMno = SqlHelper.ExecuteScalar(trans, CommandType.Text, SQL_MAXFMNO).ToString();

            string st_doc_type = ddlDocType.SelectedValue.ToString();

            string st_fmdt = DateFunction.ConvertStringToDate(txtFMDate.Text.Trim()).ToString("dd MMM yyyy");
            string st_couior = txtCourier.Text.ToString();
            string st_waybillno = txtWayBillNo.Text.ToString();
            string st_waybilldate = DateFunction.ConvertStringToDate(txtWayBillDate.Text.Trim()).ToString("dd MMM yyyy");
            string st_cust_loc = ddlCustomerLocation.SelectedValue.ToString();
            string curr_year = System.DateTime.Today.Year.ToString().Substring(2);
            string St_manualfmno = txtManualFMNo.Text.ToString();
            string fwd_to = ddlFwdDocTo.SelectedValue.ToString();

            string sql_FM_header = "exec Webx_SP_FM_ForwardDocuments_new '" + FMno + "','" + st_fmdt + "','" + St_manualfmno + "','','" + fwd_to + "','" + st_cust_loc + "','" + st_doc_type + "','" + st_couior + "','" + st_waybillno + "','" + st_waybilldate + "','" + brcd + "','" + curr_year + "','" + cnt + "'";
            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_FM_header);

            string SQL_SRNO = "select top 1 id from WebX_FM_FWD_DOC_Master where FM_NO='" + FMno + "'";
            srno = SqlHelper.ExecuteScalar(trans, CommandType.Text, SQL_SRNO).ToString();

            if (st_doc_type == FMUtility.POD || st_doc_type == FMUtility.COD_DOD)
            {
                foreach (GridViewRow GDV in gv.Rows)
                {
                    CheckBox dkt_chk = (CheckBox)GDV.FindControl("chkOrderNo");
                    Label dkt_Docket = (Label)GDV.FindControl("lbldockno");
                    Label lblorgdest_val = (Label)GDV.FindControl("lblorgdest_val");
                    Label lblfrom_to_val = (Label)GDV.FindControl("lblfrom_to_val");
                    Label lbldely_date_val = (Label)GDV.FindControl("lbldely_date_val");
                    Label dkt_amt = (Label)GDV.FindControl("lbldkttot_val");
                    Label lblScaned_val = (Label)GDV.FindControl("lblScaned_val");
                    HiddenField st_dockdt = (HiddenField)GDV.FindControl("hdncomm");
                    HiddenField hidDocumentNo = (HiddenField)GDV.FindControl("hidDocumentNo");
                    HiddenField hidDocumentDate = (HiddenField)GDV.FindControl("hidDocumentDate");

                    if (dkt_chk.Checked)
                    {
                        string sql_pod_entry = "exec Webx_SP_FM_ForwardDocuments_Docket_new '" + srno + "','" + dkt_Docket.Text.ToString() + "','" + st_dockdt.Value + "','N/A',NULL,'" + dkt_amt.Text.ToString() + "','" + lblorgdest_val.Text.ToString() + "','" + lblfrom_to_val.Text.ToString() + "','" + lbldely_date_val.Text.ToString() + "','" + lblScaned_val.Text.ToString() + "','" + brcd + "'";
                        if (st_doc_type == FMUtility.COD_DOD)
                        { sql_pod_entry = "exec Webx_SP_FM_ForwardDocuments_Docket_new '" + srno + "','" + dkt_Docket.Text.ToString() + "','" + st_dockdt.Value + "','" + hidDocumentNo.Value + "'," + ((hidDocumentDate.Value.Trim() == "") ? "NULL" : "'" + hidDocumentDate.Value.Trim() + "'") + ",'" + dkt_amt.Text.ToString() + "','" + lblorgdest_val.Text.ToString() + "','" + lblfrom_to_val.Text.ToString() + "','" + lbldely_date_val.Text.ToString() + "','" + lblScaned_val.Text.ToString() + "','" + brcd + "'"; }
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_pod_entry);
                    }
                }
            }
            else if (st_doc_type == FMUtility.Bill)
            {
                foreach (GridViewRow GDV in gv.Rows)
                {
                    CheckBox dkt_chk = (CheckBox)GDV.FindControl("chkOrderNo");
                    if (dkt_chk.Checked == true)
                    {
                        Label lbl_SrNo = (Label)GDV.FindControl("Lbl_Srno");
                        Label lbl_BillNo = (Label)GDV.FindControl("Lbl_Billno");
                        Label lbl_ManualBillNo = (Label)GDV.FindControl("Lbl_Manualbillno");
                        Label lbl_BillDate = (Label)GDV.FindControl("lbl_Billdate");
                        Label Lbl_billingParty = (Label)GDV.FindControl("Lbl_Billingparty");
                        Label lbl_billAmountNo = (Label)GDV.FindControl("Lbl_Billamountno");
                        Label lbl_SubmissionLocation = (Label)GDV.FindControl("Lbl_Submissionlocation");
                        Label lbl_ScanedVal = (Label)GDV.FindControl("lblScaned_val");
                        string[] Loccode_name = lbl_SubmissionLocation.Text.Split(new char[] { ':' });
                        String locCode = Loccode_name.GetValue(0).ToString();

                        string Sql_Bill_Entry = "exec Webx_SP_FM_InsertDetail_For_Bill '" + srno + "','" + lbl_BillNo.Text + "','" + lbl_ManualBillNo.Text + "','" + Convert.ToDateTime(lbl_BillDate.Text).ToString("dd MMM yyyy") + "' ,'" + Lbl_billingParty.Text + "', '" + lbl_billAmountNo.Text + "','" + locCode + " ','" + lbl_ScanedVal.Text.ToString() + "','" + brcd + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, Sql_Bill_Entry);
                    }
                }
            }
            trans.Commit();
            conn.Close();
            Response.Redirect("DisplayFMFWDDocumentsResult.aspx?FMNo=" + FMno + "&FMID=" + st_doc_type);
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
    protected void ddlDocType_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (ddlDocType.SelectedValue)
        { 
            case FMUtility.POD:
                FMUtility.BindPayBas(dllPaybas, "All");
                break;
            case FMUtility.Bill:
                FMUtility.BindBillPayBas(dllPaybas, "All");
                break;
            case FMUtility.COD_DOD:
                FMUtility.BindPayBas(dllPaybas, "All");
                break;
        }
    }
}

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_PrintDcr : System.Web.UI.Page
{
    SqlConnection con;

    private DataTable DCR_Details
    {
        get { return (ViewState["DCR_Details"] != null) ? ViewState["DCR_Details"] as DataTable : new DataTable(); }
        set { ViewState["DCR_Details"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        try
        {
            if (!IsPostBack && !IsCallback)
            {

                int DOC_KEY = Convert.ToInt32(Request.QueryString["DOCKEY"]);

                getDCRDetails("", "", DOC_KEY);
                if (DCR_Details.Rows.Count > 0)
                {
                    string DOC_Type = DCR_Details.Rows[0]["DOC_TYPE"].ToString();
                    string BookCode = DCR_Details.Rows[0]["BookCode"].ToString();
                    string Suffix = DCR_Details.Rows[0]["Suffix"].ToString();
                    lblBookCode.Text = BookCode;
                    lblBookCode.Text += ((Suffix == ".") ? "" : Suffix);
                    hidSuffix.Value = Suffix;
                    txtTotalLeaf.Text = "0";

                    string cmd = "SELECT CodeId,CodeDesc FROM webx_master_general WHERE codetype='DOCS' AND statusCode='Y'";
                    DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, cmd);
                    ddlDocType.DataSource = ds;
                    ddlDocType.DataTextField = "CodeDesc";
                    ddlDocType.DataValueField = "CodeId";
                    ddlDocType.DataBind();

                    PopulateBusinessType();
                    //PopulateAllotTo();
                    BindLocaitons("");
                    BindAllotCategory("");

                    ddlDocType.SelectedValue = DOC_Type;
                    ddlDocType.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }
    }
    protected void txtSeriesFrom_onTextChanged(object sender, EventArgs e)
    {
        string seriesFrom = txtSeriesFrom.Text.Trim();
        string dockType = ddlDocType.SelectedItem.Value.Trim();
        try
        {
            if (dockType == "" && seriesFrom != "")
            {
                txtSeriesFrom.Text = "";
                ddlDocType.Focus();
                throw new Exception("Please Select Document Type.");
            }
            else if (seriesFrom != "")
            {
                if (DCR_Details.Rows.Count > 0)
                {
                    string DOC_SR_FROM = DCR_Details.Rows[0]["DOC_SR_FROM"].ToString();
                    string DOC_SR_TO = DCR_Details.Rows[0]["DOC_SR_TO"].ToString();
                    string MaxUsed = DCR_Details.Rows[0]["MaxUsed"].ToString();
                    int UsedCount = Convert.ToInt32(DCR_Details.Rows[0]["UsedCount"]);

                    string nextCode = "";
                    if (MaxUsed != "")
                        nextCode = StringFunctions.NextKeyCode(MaxUsed);
                    else
                        nextCode = StringFunctions.NextKeyCode(DOC_SR_FROM);

                    double TOT_LEAF = StringFunctions.GetDiff(DOC_SR_FROM, DOC_SR_TO);
                    double maxAvailable = StringFunctions.GetDiff(nextCode, DOC_SR_TO);

                    if (MaxUsed != "")
                    {
                        if (StringFunctions.IsBetween(seriesFrom, DOC_SR_FROM, MaxUsed))
                            throw new Exception("Docuement No " + MaxUsed + " is already used. Please enter document no grater than " + MaxUsed);
                    }
                    double diff = StringFunctions.GetDiff(seriesFrom, DOC_SR_TO);
                    txtTotalLeaf.Text = diff.ToString("0");
                    txtTotalLeaf.Enabled = false;
                }
                else
                {
                    txtSeriesFrom.Text = "";
                    txtSeriesFrom.Focus();
                    throw new Exception("No series found containing entered " + ddlDocType.SelectedItem.Text);
                }
            }
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }
    }

    protected void txtTotalLeaf_onTextChanged(object sender, EventArgs e)
    {
        //txtSeriesFrom.Text = DCR_Details.Rows[0][5].ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string seriesFrom = txtSeriesFrom.Text.Trim();
        string dockType = ddlDocType.SelectedItem.Value.Trim();
        try
        {
            if (dockType == "" && seriesFrom != "")
            {
                txtSeriesFrom.Text = "";
                ddlDocType.Focus();
                throw new Exception("Please Select Document Type.");
            }
            else if (seriesFrom != "")
            {
                if (DCR_Details.Rows.Count > 0)
                {
                    string DOC_KEY = DCR_Details.Rows[0]["DOC_KEY"].ToString();
                    string BookCode = DCR_Details.Rows[0]["BookCode"].ToString();
                    string Suffix = DCR_Details.Rows[0]["Suffix"].ToString();
                    string DOC_SR_FROM = DCR_Details.Rows[0]["DOC_SR_FROM"].ToString();
                    string DOC_SR_TO = DCR_Details.Rows[0]["DOC_SR_TO"].ToString();
                    string MaxUsed = DCR_Details.Rows[0]["MaxUsed"].ToString();
                    string MaxSuffix = DCR_Details.Rows[0]["MaxSuffix"].ToString();
                    int UsedCount = Convert.ToInt32(DCR_Details.Rows[0]["UsedCount"]);
                    string nextCode = "";
                    if (MaxUsed != "")
                        nextCode = StringFunctions.NextKeyCode(MaxUsed);
                    else
                        nextCode = StringFunctions.NextKeyCode(DOC_SR_FROM);

                    double TOT_LEAF = StringFunctions.GetDiff(DOC_SR_FROM, DOC_SR_TO);
                    double maxAvailable = StringFunctions.GetDiff(nextCode, DOC_SR_TO);

                    if (MaxUsed != "")
                    {
                        if (StringFunctions.IsBetween(seriesFrom, DOC_SR_FROM, MaxUsed))
                            throw new Exception("Docuement No " + MaxUsed + " is already used. Please enter document no grater than " + MaxUsed);
                    }

                    double totInNew = StringFunctions.GetDiff(seriesFrom, DOC_SR_TO);
                    double totDKT = StringFunctions.GetDiff(DOC_SR_FROM, DOC_SR_TO);

                    double diffQty = totDKT - totInNew;
                    string LastDocNo = StringFunctions.NextKeyCode(DOC_SR_FROM, Convert.ToInt32(diffQty.ToString("0")) - 1);

                    msgBox.ShowInfo(LastDocNo);

                    string sp = "usp_DCR_Split";
                    SqlParameter[] prms = new SqlParameter[13];
                    prms[0] = new SqlParameter("@Original_DOC_KEY", DOC_KEY);
                    prms[1] = new SqlParameter("@Original_BookCode", BookCode);
                    prms[2] = new SqlParameter("@NewSeriesTo", LastDocNo);
                    prms[3] = new SqlParameter("@RemLeafs", diffQty);
                    prms[4] = new SqlParameter("@BookCode", BookCode);
                    prms[5] = new SqlParameter("@Suffix", getNextSuffix(MaxSuffix));
                    prms[6] = new SqlParameter("@SeriesFrom", txtSeriesFrom.Text.Trim());
                    prms[7] = new SqlParameter("@TotLeafs", txtTotalLeaf.Text.Trim());
                    prms[8] = new SqlParameter("@Alloted_To_Loc", ddlLocations.SelectedValue);
                    prms[9] = new SqlParameter("@Alloted_To_Cat", ddlAllotCat.SelectedValue);
                    prms[10] = new SqlParameter("@Alloted_To", ddlAlloteTo.SelectedValue);
                    prms[11] = new SqlParameter("@Business_Type", ddlBusType.SelectedValue);
                    prms[12] = new SqlParameter("@entryby", SessionUtilities.CurrentEmployeeID);

                    SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
                    conn.Open();
                    SqlTransaction trans = conn.BeginTransaction();
                    try
                    {
                        DataTable dt = SqlHelper.ExecuteDataset(trans, CommandType.StoredProcedure, sp, prms).Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            if (dt.Rows[0]["Status"] != DBNull.Value)
                            {
                                if (dt.Rows[0]["Status"].ToString() == "F")
                                    throw new Exception(dt.Rows[0]["Message"].ToString());
                                else
                                {
                                    trans.Commit();
                                    string url = "Manage_Result.aspx?BC=" + BookCode + Suffix;
                                    url += "&FROMTO=" + DOC_SR_FROM + "-" + DOC_SR_TO;
                                    url += "&action=" + "5";
                                    Response.Redirect(url, false);
                                }
                            }
                            else
                                throw new Exception("Operation fail: Unknown Exception");  
                        }
                        else
                            throw new Exception("Operation fail: Unknown Exception");  
                    }
                    catch (Exception ex)
                    {
                        if (conn.State == ConnectionState.Open)
                            trans.Rollback();                            
                        throw ex;
                    }
                    finally
                    {
                        if (conn.State == ConnectionState.Open)
                            conn.Close();
                        conn.Dispose();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }
    }
   
    private void PopulateBusinessType()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string cmd = "SELECT CodeId,CodeDesc FROM webx_master_general where CodeType='BUT'";
        DataSet dset = SqlHelper.ExecuteDataset(sqlCon, CommandType.Text, cmd);

        ddlBusType.DataSource = dset;
        ddlBusType.DataTextField = "CodeDesc";
        ddlBusType.DataValueField = "CodeId";
        ddlBusType.DataBind();

        ddlBusType.Items.Insert(0, new ListItem("--Select--", "0"));
    }
    private void getDCRDetails(string DOC_Type, string SeriesFrom, int DOC_KEY)
    {
        string cmd = "usp_get_DCR_Status";

        SqlParameter[] prm = new SqlParameter[3];
        prm[0] = new SqlParameter("@Doc_Type", DOC_Type);
        prm[1] = new SqlParameter("@SeriesFrom", SeriesFrom);
        prm[2] = new SqlParameter("@DOC_KEY", DOC_KEY);

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, cmd, prm);
        if (ds.Tables.Count > 0)
        { DCR_Details = ds.Tables[0]; }
        else
        { DCR_Details = new DataTable(); }
    }

    private string getNextSuffix(string suffix)
    {
        string str = suffix;

        if (str == ".")
            str = "A";
        else
            str = StringFunctions.NextKeyCode(suffix, 1);
        return str;
    }

    private void BindLocaitons(string Selected)
    {
        string strQ = "SELECT LocCode,LocName=LocCode+':'+LocName FROM WebX_Location L WHERE ActiveFlag='Y' ORDER BY L.LocName";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        bool isExist = false;
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                isExist = true;
                ddlLocations.DataSource = ds;
                ddlLocations.DataTextField = "LocName";
                ddlLocations.DataValueField = "LocCode";
                ddlLocations.DataBind();
                ddlLocations.Items.Insert(0, new ListItem("--SELECT--", ""));
                ddlLocations.SelectedValue = Selected;
            }
        }
        if (!isExist)
        {
            ddlLocations.Items.Clear();
            ddlLocations.Items.Add(new ListItem("--SELECT--", ""));
            ddlLocations.SelectedValue = "";
        }

    }
    private void BindUsers(string Selected)
    {
        string strQ = "SELECT AlloteTo=UserId,AlloteToName=UserId+':'+[Name] FROM Webx_Master_Users WHERE BranchCode='{0}' ORDER BY [Name]";
        strQ = string.Format(strQ, ddlLocations.SelectedValue);
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        bool isExist = false;
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                isExist = true;
                ddlAlloteTo.DataSource = ds;
                ddlAlloteTo.DataTextField = "AlloteToName";
                ddlAlloteTo.DataValueField = "AlloteTo";
                ddlAlloteTo.DataBind();
                ddlAlloteTo.Items.Insert(0, new ListItem("--SELECT--", ""));
                ddlAlloteTo.SelectedValue = Selected;
            }
        }
        if (!isExist)
        {
            ddlAlloteTo.Items.Clear();
            ddlAlloteTo.Items.Add(new ListItem("--SELECT--", ""));
            ddlAlloteTo.SelectedValue = "";
        }
    }
    private void BindBA(string Selected)
    {
        string strQ = "Select AlloteTo=H.VENDORCODE,AlloteToName=H.VENDORCODE+':'+H.VENDORNAME From " +
                      "webx_vendor_hdr H INNER JOIN webx_vendor_det D on H.VENDORCODE=D.VENDORCODE " +
                      "where (H.vendor_type='8' or H.vendor_type='08' ) " +
                      "AND '{0}' in (SELECT Items FROM dbo.split(D.vendorbrcd,',')) and IsNull(Active,'Y')='Y' and " +
                      "(Select Loc_Level From webx_location where loccode=ltrim(rtrim('{0}')) )>1 " +
                      "Order By H.VENDORNAME ";
        strQ = string.Format(strQ, ddlLocations.SelectedValue);
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        bool isExist = false;
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                isExist = true;
                ddlAlloteTo.DataSource = ds;
                ddlAlloteTo.DataTextField = "AlloteToName";
                ddlAlloteTo.DataValueField = "AlloteTo";
                ddlAlloteTo.DataBind();
                ddlAlloteTo.Items.Insert(0, new ListItem("--SELECT--", ""));
                ddlAlloteTo.SelectedValue = Selected;
            }
        }
        if (!isExist)
        {
            ddlAlloteTo.Items.Clear();
            ddlAlloteTo.Items.Add(new ListItem("--SELECT--", ""));
            ddlAlloteTo.SelectedValue = "";
        }
    }
    private void BindAllotCategory(string Selected)
    {
        ddlAllotCat.Items.Clear();
        ddlAllotCat.Items.Add(new ListItem("--SELECT--", ""));
        ddlAllotCat.Items.Add(new ListItem("Employee", "E"));
        ddlAllotCat.Items.Add(new ListItem("BA", "B"));
        ddlAllotCat.Items.Add(new ListItem("Location", "L"));
        ddlAllotCat.SelectedValue = Selected;
    }
    protected void ddlLocations_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlLocations.SelectedValue != "")
            {
                BindAllotCategory("");
                if (ddlAllotCat.SelectedValue != "")
                {
                    if (ddlAllotCat.SelectedValue == "B")
                        BindBA("");
                    if (ddlAllotCat.SelectedValue == "E")
                        BindUsers("");
                }
                else
                {
                    ddlAlloteTo.Items.Clear();
                    ddlAlloteTo.Items.Add(new ListItem("--SELECT--", ""));
                }
            }
            else
            {
                ddlAllotCat.Items.Clear();
                ddlAllotCat.Items.Add(new ListItem("--SELECT--", ""));
                ddlAlloteTo.Items.Clear();
                ddlAlloteTo.Items.Add(new ListItem("--SELECT--", ""));
            }
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }

    }
    protected void ddlAllotCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlLocations.SelectedValue != "")
            {
                if (ddlAllotCat.SelectedValue != "")
                {
                    if (ddlAllotCat.SelectedValue == "B")
                        BindBA("");
                    if (ddlAllotCat.SelectedValue == "E")
                        BindUsers("");
                }
                else
                {
                    ddlAlloteTo.Items.Clear();
                    ddlAlloteTo.Items.Add(new ListItem("--SELECT--", ""));
                }
            }
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }
    }
}

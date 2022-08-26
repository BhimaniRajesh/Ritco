using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_DCR_Manage_DCR : System.Web.UI.Page
{
    DataTable DCR_Data 
    {
        get { return (ViewState["DCR_Data"] != null) ? ViewState["DCR_Data"] as DataTable : new DataTable(); }
        set { ViewState["DCR_Data"] = value; } 
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            dvFilter.Visible = true;
            dvDetails.Visible = false;
            dvAllocate.Visible = false;
            BindDocumetTypes();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlDocType.SelectedValue == "")
            {
                ddlDocType.Focus();
                throw new Exception("Please Select Documet Type");
            }
            if (txtDocNo.Text.Trim() == "")
            {
                txtDocNo.Focus();
                throw new Exception("Please Enter Documet Number");
            }
            string strQuery = "SELECT * FROM vw_DCR_Register WHERE DOC_TYPE='{0}' AND '{1}' BETWEEN DOC_SR_FROM AND DOC_SR_TO AND LEN('{1}')=LEN(DOC_SR_FROM)";
            strQuery = string.Format(strQuery, ddlDocType.SelectedValue, txtDocNo.Text);

            DataSet DS = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQuery);
            if (DS.Tables.Count > 0)
            {
                DCR_Data = DS.Tables[0];
                if (DCR_Data.Rows.Count > 0)
                {
                    dvFilter.Visible = false;
                    DataRow dr = DCR_Data.Rows[0];
                    dvDetails.Visible = true;

                    lblDocType.Text = ddlDocType.SelectedItem.Text;
                    lblQNo.Text = txtDocNo.Text.Trim();
                    lblBookCode.Text = dr["BookCode"].ToString();
                    hidDocKey.Value = dr["DOC_KEY"].ToString();

                    if (dr["Suffix"] != DBNull.Value)
                        lblBookCode.Text += ((dr["Suffix"].ToString() == ".") ? "" : dr["Suffix"].ToString());

                    double TOT_LEAF = Convert.ToDouble(dr["TOT_LEAF"]);
                    double Used = Convert.ToDouble(dr["Used"]);

                    lblFromTo.Text = dr["DOC_SR_FROM"].ToString() + " - " + dr["DOC_SR_TO"].ToString();
                    lblTotLeaves.Text = TOT_LEAF.ToString("0");
                    lblUsedLeaves.Text = Used.ToString("0");
                    lblAllotedToLoc.Text = dr["Alloted_By"].ToString() + " : " + dr["Alloted_By_Name"].ToString();

                    if (dr["Alloted_To"] != DBNull.Value)
                    {
                        lblAllotedToPer.Text = dr["Alloted_To"].ToString() + " : " + dr["Alloted_To_Name"].ToString();

                        if (dr["Alloted_Type"] != DBNull.Value)
                            lblAllotedType.Text = dr["Alloted_Type"].ToString();
                    }
                    lblLocHierarchy.Text = dr["LocationHierarchy"].ToString();
                    lblStatus.Text = dr["Status"].ToString();

                    if (Used == TOT_LEAF)
                    {
                        ddlAction.Items.Clear();
                        ddlAction.Items.Add(new ListItem("--SELECT--", ""));
                        ddlAction.Enabled = false;
                    }
                    else if (TOT_LEAF > Used && Used > 0)
                    {
                        ddlAction.Items.Clear();
                        ddlAction.Items.Add(new ListItem("--SELECT--", ""));
                        ddlAction.Items.Add(new ListItem("Split", "1"));
                    }
                    //else if (Used == 0 && dr["Alloted_To"] == DBNull.Value)
                    //{
                    //    ddlAction.Items.Clear();
                    //    ddlAction.Items.Add(new ListItem("--SELECT--", ""));
                    //    ddlAction.Items.Add(new ListItem("Split", "1"));
                    //    ddlAction.Items.Add(new ListItem("Allot", "2"));
                    //}
                }
                else
                    msgBox.ShowInfo("No Record Found");
            }
            else
                msgBox.ShowInfo("No Record Found");
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }
    }
    protected void btnDoAction_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlAction.SelectedValue == "")
            {
                ddlAction.Focus();
                throw new Exception("Please Select Action.");
            }
            else
            {
                if (ddlAction.SelectedValue == "3")
                {
                    DataRow dr = DCR_Data.Rows[0];
                    dvAllocate.Visible = true;
                    BindLocaitons(dr["Alloted_By"].ToString());                    
                    BindAllotCategory(dr["Alloted_Type_ID"].ToString());                   
                    if (dr["Alloted_Type_ID"].ToString() == "B")
                    {
                        BindBA(dr["Alloted_To"].ToString());
                    }
                    if (dr["Alloted_Type_ID"].ToString() == "E")
                    {
                        BindUsers(dr["Alloted_To"].ToString());
                    }
                }
                if (ddlAction.SelectedValue == "1")
                {
                    dvAllocate.Visible = false;
                    Response.Redirect("Split_DCR.aspx?DOCKEY=" + hidDocKey.Value);
                }
            }
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }
    }
    protected void btnReAllocate_Click(object sender, EventArgs e)
    {
        try
        {
            string sp="usp_Series_ReAllocate_new";
            SqlParameter[] prms = new SqlParameter[5];
            prms[0] = new SqlParameter("@doc_key", hidDocKey.Value);
            prms[1] = new SqlParameter("@reallot_to_loc", ddlNewAllotLoc.SelectedValue);
            prms[2] = new SqlParameter("@reallot_cat", ddlAllotCat.SelectedValue);
            prms[3] = new SqlParameter("@reallot_to", ddlAllotPerson.SelectedValue);
            prms[4] = new SqlParameter("@empcd", SessionUtilities.CurrentEmployeeID);

            DataSet DS = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp, prms);
            if (DS.Tables.Count > 0)
            {
                if (DS.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = DS.Tables[0].Rows[0];
                    if (dr["Status"].ToString() == "0")
                        throw new Exception(dr["Message"].ToString());
                    else
                    {
                        string url = "Manage_Result.aspx?BC=" + lblBookCode.Text;
                        url += "&FROMTO=" + lblFromTo.Text;
                        url += "&action=" + "3";
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
            msgBox.ShowError(ex.Message);
        }
    }
    private void BindDocumetTypes()
    {
        DataSet newds1 = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Documents");
        ddlDocType.DataSource = newds1;
        ddlDocType.DataTextField = "CodeDesc";
        ddlDocType.DataValueField = "CodeID";
        ddlDocType.DataBind();
    }
    private void BindLocaitons(string Selected)
    {
        string strQ = "SELECT LocCode,LocName=LocCode+':'+LocName FROM WebX_Location L WHERE ActiveFlag='Y' ORDER BY L.LocName";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        bool isExist = false;
        if(ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                isExist = true;
                ddlNewAllotLoc.DataSource = ds;
                ddlNewAllotLoc.DataTextField = "LocName";
                ddlNewAllotLoc.DataValueField = "LocCode";
                ddlNewAllotLoc.DataBind();
                ddlNewAllotLoc.Items.Insert(0, new ListItem("--SELECT--", ""));
                //DataRow dr = DCR_Data.Rows[0];
                //ddlNewAllotLoc.SelectedValue = dr["Alloted_By"].ToString();
                ddlNewAllotLoc.SelectedValue = Selected;
            }
        }
        if (!isExist)
        {
            ddlNewAllotLoc.Items.Clear();
            ddlNewAllotLoc.Items.Add(new ListItem("--SELECT--", ""));
            ddlNewAllotLoc.SelectedValue = "";
        }
        
    }
    private void BindUsers(string Selected)
    {
        string strQ = "SELECT AlloteTo=UserId,AlloteToName=UserId+':'+[Name] FROM Webx_Master_Users WHERE BranchCode='{0}' ORDER BY [Name]";
        strQ = string.Format(strQ, ddlNewAllotLoc.SelectedValue);
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        bool isExist = false;
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                isExist = true;
                ddlAllotPerson.DataSource = ds;
                ddlAllotPerson.DataTextField = "AlloteToName";
                ddlAllotPerson.DataValueField = "AlloteTo";
                ddlAllotPerson.DataBind();
                ddlAllotPerson.Items.Insert(0, new ListItem("--SELECT--", ""));
                //DataRow dr = DCR_Data.Rows[0];
                //ddlAllotPerson.SelectedValue = dr["Alloted_To"].ToString();
                ddlAllotPerson.SelectedValue = Selected;
            }
        }
        if (!isExist)
        {
            ddlAllotPerson.Items.Clear();
            ddlAllotPerson.Items.Add(new ListItem("--SELECT--", ""));
            ddlAllotPerson.SelectedValue = "";
        }
    }
    private void BindBA(string Selected)
    {
        string strQ = "Select AlloteTo=H.VENDORCODE,AllotToName=H.VENDORCODE+':'+H.VENDORNAME From " +
                      "webx_vendor_hdr H INNER JOIN webx_vendor_det D on H.VENDORCODE=D.VENDORCODE " +
                      "where (H.vendor_type='8' or H.vendor_type='08' ) "+
                      "AND '{0}' in (SELECT Items FROM dbo.split(D.vendorbrcd,',')) and IsNull(Active,'Y')='Y' and "+
                      "(Select Loc_Level From webx_location where loccode=ltrim(rtrim('{0}')) )>1 " +
                      "Order By H.VENDORNAME ";
        strQ = string.Format(strQ, ddlNewAllotLoc.SelectedValue);
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        bool isExist = false;
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                isExist = true;
                ddlAllotPerson.DataSource = ds;
                ddlAllotPerson.DataTextField = "AlloteToName";
                ddlAllotPerson.DataValueField = "AlloteTo";
                ddlAllotPerson.DataBind();
                ddlAllotPerson.Items.Insert(0, new ListItem("--SELECT--", ""));
                //DataRow dr = DCR_Data.Rows[0];
                //ddlAllotPerson.SelectedValue = dr["Alloted_To"].ToString();
                ddlAllotPerson.SelectedValue = Selected;
            }
        }
        if (!isExist)
        {
            ddlAllotPerson.Items.Clear();
            ddlAllotPerson.Items.Add(new ListItem("--SELECT--", ""));
            ddlAllotPerson.SelectedValue = "";
        }
    }
    private void BindAllotCategory(string Selected)
    {
        ddlAllotCat.Items.Clear();
        ddlAllotCat.Items.Add(new ListItem("--SELECT--", ""));
        ddlAllotCat.Items.Add(new ListItem("Employee", "E"));
        ddlAllotCat.Items.Add(new ListItem("BA", "B"));
        ddlAllotCat.Items.Add(new ListItem("Location", "L"));
        //DataRow dr = DCR_Data.Rows[0];
        //if (dr["Alloted_Type_ID"].ToString() == "B" || dr["Alloted_Type_ID"].ToString() == "E")
        //    ddlAllotCat.SelectedValue = dr["Alloted_Type_ID"].ToString();
        ddlAllotCat.SelectedValue = Selected;
    }
    protected void ddlNewAllotLoc_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlNewAllotLoc.SelectedValue != "")
            {
                BindAllotCategory("");
                DataRow dr = DCR_Data.Rows[0];
                if (dr["Alloted_Type_ID"].ToString() == "B")
                    BindBA("");
                if (dr["Alloted_Type_ID"].ToString() == "E")
                    BindUsers("");
            }
            else
            {
                ddlAllotCat.Items.Clear();
                ddlAllotCat.Items.Add(new ListItem("--SELECT--", ""));
                ddlAllotPerson.Items.Clear();
                ddlAllotPerson.Items.Add(new ListItem("--SELECT--", ""));
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
            if (ddlNewAllotLoc.SelectedValue != "")
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
                    ddlAllotPerson.Items.Clear();
                    ddlAllotPerson.Items.Add(new ListItem("--SELECT--", ""));
                }
            }   
        }
        catch (Exception ex)
        {
            msgBox.ShowError(ex.Message);
        }              
    }
}
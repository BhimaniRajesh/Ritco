using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_DCR_Track_DCR : System.Web.UI.Page
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
                    lblBookCode.Text = dr["Book_Number"].ToString();

                    double TOT_LEAF = Convert.ToDouble(dr["TOT_LEAF"]);
                    double Used = Convert.ToDouble(dr["Used"]);

                    lblFromTo.Text = dr["FROM_TO"].ToString();
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

                    gvResult.DataSource = GetManagementHistory(dr["DOC_KEY"].ToString());
                    gvResult.DataBind();
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

    private DataSet GetManagementHistory(string DOC_KEY)
    {
        DataSet ds = new DataSet();

        string sQuery = "SELECT Action_Desc,Action_Date,Book_Number,FROM_TO,Alloted_Type_Desc," +
                        " Alloted_Loc=(CASE WHEN ISNULL(Alloted_Loc,'')='' THEN '' ELSE Alloted_Loc+' : '+Alloted_Loc_Name END), "+
                        " Alloted_To=(CASE WHEN ISNULL(Alloted_To,'')='' THEN '' ELSE Alloted_To+' : '+Alloted_To_Name END) FROM vw_DCR_Management_History WHERE DOC_KEY='{0}'";
        sQuery = string.Format(sQuery, DOC_KEY);

        ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sQuery);

        return ds;
    }
    private void BindDocumetTypes()
    {
        DataSet newds1 = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Documents");
        ddlDocType.DataSource = newds1;
        ddlDocType.DataTextField = "CodeDesc";
        ddlDocType.DataValueField = "CodeID";
        ddlDocType.DataBind();
    }
}

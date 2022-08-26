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

public partial class DocumentTypeEntry : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;    
    //int mDataCount = 0;
    //MyFleetDataSet.TYREREMOULDINGRow datarow_remould;
    MyFleetDataSet.DocumentTypeMstDataTable dt_DocuType = new MyFleetDataSet.DocumentTypeMstDataTable();  
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dt_DocuType.AddDocumentTypeMstRow("", "", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["DOCUTYPEID"] != null)
            {
                Table3.Visible = false;
                FillData();

            }
            else
            {
                Table3.Visible = true;
            }
        }
        //btn_Submit.Attributes.Add("OnClick", "javascript:return checkTyreId1();");
    }

    private void BindGrid()
    {
        gvDocuType.DataSource = dt_DocuType;
        gvDocuType.DataBind();
    }
    public void FillData()
    {
        foreach (GridViewRow row in gvDocuType.Rows)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "usp_document_type_list";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            //SqlDataAdapter adp = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@DOCU_TYPE_ID", Request.QueryString["DOCUTYPEID"].ToString());
            cmd.Parameters.AddWithValue("@DOCU_TYPE", "");
            //DataSet ds = new DataSet();
            //adp.Fill(ds);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                TextBox txtDocType = (TextBox)row.FindControl("txtDocType");
                TextBox txtTypeDesc = (TextBox)row.FindControl("txtTypeDesc");
                CheckBox chkApplicableStatus = (CheckBox)row.FindControl("chkApplicableStatus");
                DropDownList ddlRenewqlAutu = (DropDownList)row.FindControl("ddlRenewqlAutu");
                CheckBox chkCostCap = (CheckBox)row.FindControl("chkCostCap");
                txtDocType.Text = dr["DOCU_TYPE"].ToString();
                txtTypeDesc.Text = dr["DECS"].ToString();
                if (dr["APPLICABLE_STATE"].ToString() == "Yes") { chkApplicableStatus.Checked = true; } else { chkApplicableStatus.Checked = false; }
                ddlRenewqlAutu.SelectedValue = dr["RENEW_AUTH_ID"].ToString();
                if (dr["COST_CAPTURED"].ToString() == "Yes") { chkCostCap.Checked = true; } else { chkCostCap.Checked = false; }
            }
        }
    }
    protected void gvDocuType_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            ((TextBox)e.Row.FindControl("txtDocType")).Attributes.Add("OnBlur", "javascript:checkDocType(" + e.Row.DataItemIndex + "," + ((TextBox)e.Row.FindControl("txtDocType")).ClientID.ToString() + ");");
            DropDownList ddlRenewqlAutu = (DropDownList)e.Row.FindControl("ddlRenewqlAutu");
            BindDropDown("USP_RENEWAUCODE", "CodeDesc", "CodeId", ddlRenewqlAutu);
        }
    }

    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_DocuType.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_DocuType.AddDocumentTypeMstRow("", "", "", "", "");
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_DocumentType docu_type = new cls_DocumentType(Session["SqlProvider"].ToString());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        try
        {
            foreach (GridViewRow gvr in gvDocuType.Rows)
            {
                if (Request.QueryString["DOCUTYPEID"] != null)
                {
                    docu_type.DOCU_TYPE_ID = Request.QueryString["DOCUTYPEID"].ToString();
                }
                else
                {
                    docu_type.DOCU_TYPE_ID = "";
                }
                docu_type.DOCU_TYPE = ((TextBox)gvr.FindControl("txtDocType")).Text;
                docu_type.DECS = ((TextBox)gvr.FindControl("txtTypeDesc")).Text;
                CheckBox chkApplicableStatus = (CheckBox)gvr.FindControl("chkApplicableStatus");
                if (chkApplicableStatus.Checked == true)
                {
                    docu_type.APPLICABLE_STATE = "Yes";
                }
                else
                {
                    docu_type.APPLICABLE_STATE = "No";
                }

                docu_type.RENEW_AUTH_ID = ((DropDownList)gvr.FindControl("ddlRenewqlAutu")).SelectedValue;
                CheckBox chkCostCap = (CheckBox)gvr.FindControl("chkCostCap");
                if (chkCostCap.Checked == true)
                {
                    docu_type.COST_CAPTURED = "Yes";
                }
                else
                {
                    docu_type.COST_CAPTURED = "No";
                }

                docu_type.BeginTransaction();
                try
                {
                    docu_type.InsertDocumentType();
                    IsCommitted = docu_type.CommitTransaction();
                }
                catch (Exception ex)
                {
                    docu_type.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted)
        {
            //tb_Row_No.Text = "0";
            dt_DocuType.Rows.Clear();
            dt_DocuType.AddDocumentTypeMstRow("", "", "", "", "");
            BindGrid();

            lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Error.Text = "!!    Document Type has been saved successfully    !!";
            Response.Redirect("DocumentTypeSearch.aspx");
        }
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;

        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

  
}
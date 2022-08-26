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

public partial class Tyre_Model : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.TYREMODELDataTable dt_TypeModel = new MyFleetDataSet.TYREMODELDataTable(); 
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
        if (!IsPostBack)
        {
            dt_TypeModel.AddTYREMODELRow("", "", "", "", "", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["TyreModelId"] != null)
            {
                Panel1.Visible = false;
                GetValue(Request.QueryString["TyreModelId"].ToString());
            }
        }
        //cls_TyreModel c = new cls_TyreModel(Session["SqlProvider"].ToString().Trim());
        //c.CheckValidTyreModelNo(); 
    }
    public void GetValue(string tModelId)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_TyreModel_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@TYRE_MODEL_ID", SqlDbType.VarChar, 10).Value = tModelId;
        da.SelectCommand.Parameters.Add("@TYRE_MODELNO", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_MFG", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_PAT_CATEGORY", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_SIZE", SqlDbType.VarChar).Value = "";

        DataSet ds = new DataSet();
        da.Fill(ds);
        foreach (GridViewRow gvr in gv_TyreModel.Rows)
        {
            DropDownList ddlMFG = (DropDownList)gv_TyreModel.Rows[gvr.RowIndex].FindControl("ddlManufacturer");
            DropDownList ddlPattern = (DropDownList)gv_TyreModel.Rows[gvr.RowIndex].FindControl("ddlPattern");
            DropDownList ddlSize = (DropDownList)gv_TyreModel.Rows[gvr.RowIndex].FindControl("ddlSize");


            ((TextBox)gv_TyreModel.Rows[gvr.RowIndex].FindControl("tb_tyremodel_no")).Text = ds.Tables[0].Rows[0]["MODEL_NO"].ToString();
            ((TextBox)gv_TyreModel.Rows[gvr.RowIndex].FindControl("tb_tyremodel_desc")).Text = ds.Tables[0].Rows[0]["MODEL_DESC"].ToString();
            ((TextBox)gv_TyreModel.Rows[gvr.RowIndex].FindControl("tb_tread_depth")).Text = ds.Tables[0].Rows[0]["TREAD_DEPTH"].ToString();
            
            ddlMFG.SelectedValue = ds.Tables[0].Rows[0]["MFG_ID"].ToString().Trim();
            ddlPattern.SelectedValue = ds.Tables[0].Rows[0]["TYRE_PATTERNID"].ToString().Trim();
            ddlSize.SelectedValue = ds.Tables[0].Rows[0]["TYRE_SIZEID"].ToString().Trim();
            if (ds.Tables[0].Rows[0]["ACTIVE_FLAG"].ToString() == "Y")
            {
                ((CheckBox)gv_TyreModel.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = true;
            }
            else
            {
                ((CheckBox)gv_TyreModel.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = false;
            }
        }
        conn.Close();
    }
    
   
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_TypeModel.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_TypeModel.AddTYREMODELRow("", "", "", "", "", "", "", ""); 
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    private void BindGrid()
    {
        gv_TyreModel.DataSource = dt_TypeModel;
        gv_TyreModel.DataBind();
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (strProc == "USP_TYRESIZE")
        {
            cmd.Parameters.AddWithValue("@TYRE_MODEL_ID", "");
        }
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
    protected void gv_TyreModel_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            ((TextBox)e.Row.FindControl("tb_tyremodel_no")).Attributes.Add("OnBlur", "javascript:checkModelNo(" + e.Row.DataItemIndex + "," + ((TextBox)e.Row.FindControl("tb_tyremodel_no")).ClientID.ToString() + ");");
            BindDropDown("USP_TYREMANUFACTURER", "MFG_Name", "MFG_ID", (DropDownList)e.Row.FindControl("ddlManufacturer"));
            BindDropDown("USP_TYRESIZE", "TYRE_SIZENAME", "TYRE_SIZEID", (DropDownList)e.Row.FindControl("ddlSize"));
            BindDropDown("USP_TYREPATTERN", "TYREPAT_CODE", "TYRE_PATTERNID", (DropDownList)e.Row.FindControl("ddlPattern")); 
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        cls_TyreModel TyreModel = new cls_TyreModel(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        TyreModel.BeginTransaction();
        try
        {
            foreach (GridViewRow gvr in gv_TyreModel.Rows)
            {
                TyreModel.MFG_ID = ((DropDownList)gvr.FindControl("ddlManufacturer")).SelectedValue; 
                TyreModel.MODEL_NO = ((TextBox)gvr.FindControl("tb_tyremodel_no")).Text;
                TyreModel.MODEL_DESC = ((TextBox)gvr.FindControl("tb_tyremodel_desc")).Text;
                TyreModel.TREAD_DEPTH = ((TextBox)gvr.FindControl("tb_tread_depth")).Text;
                TyreModel.TYRE_PATTERNID = ((DropDownList)gvr.FindControl("ddlPattern")).SelectedValue;
                TyreModel.TYRE_SIZEID = ((DropDownList)gvr.FindControl("ddlSize")).SelectedValue;  
                CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");
                if (cbFlag.Checked == true)
                {
                    TyreModel.ACTIVE_FLAG = "Y";
                }
                else
                {
                    TyreModel.ACTIVE_FLAG = "N";
                }
                if (Request.QueryString["TyreModelId"] != null)
                {
                    TyreModel.TYRE_MODEL_ID = Request.QueryString["TyreModelId"].ToString();
                }
                else
                {
                    TyreModel.TYRE_MODEL_ID = "";
                }
                try
                {
                    TyreModel.InsertTyreModel();
                    IsCommitted = TyreModel.CommitTransaction();
                }
                catch (Exception ex)
                {
                    TyreModel.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }
        if (IsCommitted) Response.Redirect("TireModelSearch.aspx");
    }
   
}
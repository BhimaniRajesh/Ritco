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

public partial class Tyre_Pattern : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.TYREPATTERNDataTable dt_TypePat = new MyFleetDataSet.TYREPATTERNDataTable(); 
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        conn.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
        if (!IsPostBack)
        {
            dt_TypePat.AddTYREPATTERNRow("","","","","");  
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["TyrePatId"] != null)
            {
                Panel1.Visible = false;
                GetValue(Request.QueryString["TyrePatId"].ToString());
            }
        }
    }
    public void GetValue(string tPatId)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_TyrePat_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@PatId", SqlDbType.VarChar, 10).Value = Convert.ToInt32(tPatId);
        da.SelectCommand.Parameters.Add("@TyrePatId", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@POSITION", SqlDbType.VarChar).Value = "";
        
        DataSet ds = new DataSet();
        da.Fill(ds);
        foreach (GridViewRow gvr in gv_TyrePat.Rows)
        {
            ((TextBox)gv_TyrePat.Rows[gvr.RowIndex].FindControl("tb_tyrepat_code")).Text = ds.Tables[0].Rows[0]["TyrePat_CODE"].ToString();
            ((TextBox)gv_TyrePat.Rows[gvr.RowIndex].FindControl("tb_tyrepat_desc")).Text = ds.Tables[0].Rows[0]["TYRE_PATTERN_DESC"].ToString();
            if (ds.Tables[0].Rows[0]["ACTIVE_FLAG"].ToString() == "Y")
            {
                ((CheckBox)gv_TyrePat.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = true;
            }
            else
            {
                ((CheckBox)gv_TyrePat.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = false;
            }
            DropDownList ddlPosAllo = (DropDownList)gv_TyrePat.Rows[gvr.RowIndex].FindControl("ddl_Pos_Allowed");
            ddlPosAllo.SelectedValue = ds.Tables[0].Rows[0]["POS_ALLOWED"].ToString().Trim();

        }
        conn.Close();
    }
    
    public void BindPosAllowed(DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "USP_TYRE_POS";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
      
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }
        dr.Close();
        conn.Close();
        
    }
    
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_TypePat.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_TypePat.AddTYREPATTERNRow("", "", "", "", "");  
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    private void BindGrid()
    {
        gv_TyrePat.DataSource = dt_TypePat;
        gv_TyrePat.DataBind();
    }

    protected void gv_TyrePat_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            ((TextBox)e.Row.FindControl("tb_tyrepat_code")).Attributes.Add("OnBlur", "javascript:checkPatCode(" + e.Row.DataItemIndex + "," + ((TextBox)e.Row.FindControl("tb_tyrepat_code")).ClientID.ToString() + ");");
            BindPosAllowed((DropDownList)e.Row.FindControl("ddl_Pos_Allowed"));
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        cls_TyrePattern TyrePat = new cls_TyrePattern(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        try
        {
            foreach (GridViewRow gvr in gv_TyrePat.Rows)
            {
                TyrePat.TYREPAT_CODE = ((TextBox)gvr.FindControl("tb_tyrepat_code")).Text;
                TyrePat.TYRE_PATTERN_DESC = ((TextBox)gvr.FindControl("tb_tyrepat_desc")).Text;
                TyrePat.POS_ALLOWED = ((DropDownList)gvr.FindControl("ddl_Pos_Allowed")).SelectedValue;

                CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");
                if (cbFlag.Checked == true)
                {
                    TyrePat.ACTIVE_FLAG = "Y";
                }
                else
                {
                    TyrePat.ACTIVE_FLAG = "N";
                }
                if (Request.QueryString["TyrePatId"] != null)
                {
                    TyrePat.TYRE_PATTERNID = Request.QueryString["TyrePatId"].ToString();
                }
                else
                {
                    TyrePat.TYRE_PATTERNID = "";
                }
                TyrePat.BeginTransaction();
                try
                {
                    TyrePat.InsertTyrePattern();
                    IsCommitted = TyrePat.CommitTransaction();
                }
                catch (Exception ex)
                {
                    TyrePat.RollBackTransaction();
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
            Response.Redirect("TirePatternSearch.aspx");
        }
    }
}
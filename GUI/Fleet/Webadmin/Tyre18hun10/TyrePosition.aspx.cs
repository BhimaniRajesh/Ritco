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

public partial class Tyre_Position : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.TYREPOSDataTable dt_TypePos = new MyFleetDataSet.TYREPOSDataTable();
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        conn.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
        if (!IsPostBack)
        {
            dt_TypePos.AddTYREPOSRow("", "", "", "", "","","");  
            BindGrid();
            lbl_Page_Error.Text = "";
            if (Request.QueryString["TyrePosId"] != null)
            {
                Panel1.Visible = false;
                GetValue(Request.QueryString["TyrePosId"].ToString());
            }
            
            
        }
    }
    public void GetValue(string tPosId)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_TyrePos_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@TyrePosId", SqlDbType.VarChar,10).Value = Convert.ToInt32(tPosId);
        da.SelectCommand.Parameters.Add("@TyrePosCode", SqlDbType.VarChar,20).Value = "";
        da.SelectCommand.Parameters.Add("@TyrePos", SqlDbType.VarChar,20).Value = "All";
        da.SelectCommand.Parameters.Add("@VehCategory", SqlDbType.VarChar,20).Value = "All";

        DataSet ds = new DataSet();
        da.Fill(ds);
        foreach (GridViewRow gvr in gv_TyrePos.Rows)
        {
            ((TextBox)gv_TyrePos.Rows[gvr.RowIndex].FindControl("tb_tyrepos_code")).Text = ds.Tables[0].Rows[0]["TYREPOS_CODE"].ToString();
            ((TextBox)gv_TyrePos.Rows[gvr.RowIndex].FindControl("tb_tyrepos_desc")).Text = ds.Tables[0].Rows[0]["TYREPOS_DESC"].ToString();
            if (ds.Tables[0].Rows[0]["ACTIVE_FLAG"].ToString() == "Y")
            {
                ((CheckBox)gv_TyrePos.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = true;
            }
            else
            {
                ((CheckBox)gv_TyrePos.Rows[gvr.RowIndex].FindControl("chk_Flag")).Checked = false;
            }
            //DropDownList ddlVehType = (DropDownList)gv_TyrePos.Rows[gvr.RowIndex].FindControl("ddl_Vehicel_type");
            //BindDropDown(ddlVehType);
            //ddlVehType.SelectedValue = ds.Tables[0].Rows[0]["VEHICLE_TYPE"].ToString().Trim();
            DropDownList ddlPosAllo = (DropDownList)gv_TyrePos.Rows[gvr.RowIndex].FindControl("ddl_Pos_Allowed");
            DropDownList ddlTruTra = (DropDownList)gv_TyrePos.Rows[gvr.RowIndex].FindControl("ddl_Truck_Trailer");
            ddlPosAllo.SelectedValue = ds.Tables[0].Rows[0]["POS_ALLOWED"].ToString().Trim();
            ddlTruTra.SelectedValue = ds.Tables[0].Rows[0]["TRUCK_TRAILER"].ToString().Trim(); 

        }
        conn.Close();
    }
    //public void BindDropDown(DropDownList d)
    //{
    //    d.Items.Clear();
    //    string strSQL = "SELECT Type_Code as VEHICLE_TYPE,Type_Name FROM webx_Vehicle_Type WHERE ActiveFlag='Y' UNION SELECT 0,'Select Vehicel Type' FROM webx_Vehicle_Type";
    //    SqlDataAdapter adp = new SqlDataAdapter(strSQL, conn);
    //    DataSet ds = new DataSet();
    //    adp.Fill(ds);
    //    d.DataSource = ds;
    //    d.DataTextField = "Type_Name";
    //    d.DataValueField = "VEHICLE_TYPE";
    //    d.DataBind();
    //}
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        //if (strProc == "USP_TYRE_MODEL")
        //{
        //    cmd.Parameters.AddWithValue("@MFG_ID", ddlManufacturer.SelectedValue);
        //}
        //if (strProc == "USP_TYRESIZE")
        //{
        //    cmd.Parameters.AddWithValue("@TYRE_MODEL_ID", ddlTyreModel.SelectedValue);
        //}
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
    //public void BindPosAllowed(DropDownList d)
    //{
    //    d.Items.Clear();
    //    d.Items.Add(new ListItem("Select", "0"));
    //    //d.Items.Add(new ListItem("Both", "Both"));
    //    d.Items.Add(new ListItem("Front", "Front"));
    //    d.Items.Add(new ListItem("Rear", "Rear"));
    //    d.Items.Add(new ListItem("Spare", "Spare"));
    //}
    //public void BindTruckTriler(DropDownList d)
    //{
    //    d.Items.Clear();
    //    d.Items.Add(new ListItem("Select", "0"));
    //    d.Items.Add(new ListItem("Truck", "Truck"));
    //    d.Items.Add(new ListItem("Trailer", "Trailer"));
    //}
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_TypePos.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_TypePos.AddTYREPOSRow("", "", "", "", "","","");  
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    private void BindGrid()
    {
        gv_TyrePos.DataSource = dt_TypePos;
        gv_TyrePos.DataBind();
    }

    protected void gv_TyrePos_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            ((TextBox)e.Row.FindControl("tb_tyrepos_code")).Attributes.Add("OnBlur", "javascript:checkPosCode(" + e.Row.DataItemIndex + "," + ((TextBox)e.Row.FindControl("tb_tyrepos_code")).ClientID.ToString() + "," + ((DropDownList)e.Row.FindControl("ddl_Truck_Trailer")).ClientID.ToString() + ");");
           // BindDropDown((DropDownList)e.Row.FindControl("ddl_Vehicel_type"));
            DropDownList dPos = (DropDownList)e.Row.FindControl("ddl_Pos_Allowed");
            DropDownList dTT = (DropDownList)e.Row.FindControl("ddl_Truck_Trailer");
            BindDropDown("USP_TYRE_POS", "CodeDesc", "CodeId", dPos);
            BindDropDown("USP_VEH_CAT", "CodeDesc", "CodeId", dTT);
            dTT.Attributes.Add("onChange", "return CheckTyrePos(" + ((TextBox)e.Row.FindControl("tb_tyrepos_code")).ClientID.ToString() + ");");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_TyrePosition TyrePos = new cls_TyrePosition(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        try
        {
            foreach (GridViewRow gvr in gv_TyrePos.Rows)
            {
                TyrePos.TYREPOS_CODE = ((TextBox)gvr.FindControl("tb_tyrepos_code")).Text;
                TyrePos.TYREPOS_DESC = ((TextBox)gvr.FindControl("tb_tyrepos_desc")).Text;
                TyrePos.POS_ALLOWED = ((DropDownList)gvr.FindControl("ddl_Pos_Allowed")).SelectedValue;
                TyrePos.TRUCK_TRAILER = ((DropDownList)gvr.FindControl("ddl_Truck_Trailer")).SelectedValue;

                CheckBox cbFlag = (CheckBox)gvr.FindControl("chk_Flag");
                if (cbFlag.Checked == true)
                {
                    TyrePos.ACTIVE_FLAG = "Y";
                }
                else
                {
                    TyrePos.ACTIVE_FLAG = "N";
                }
                TyrePos.VEHICLE_TYPE = "";//((DropDownList)gvr.FindControl("ddl_Vehicel_type")).SelectedValue;
                if (Request.QueryString["TyrePosId"] != null)
                {
                    TyrePos.TYREPOS_ID = Request.QueryString["TyrePosId"].ToString();
                }
                else
                {
                    TyrePos.TYREPOS_ID = "";
                }
                TyrePos.BeginTransaction();
                try
                {
                    TyrePos.InsertTyrePosition();
                    IsCommitted = TyrePos.CommitTransaction();
                }
                catch (Exception ex)
                {
                    TyrePos.RollBackTransaction();
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
            Response.Redirect("TirepositionSearch.aspx");
        }
    }
}
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

public partial class Tyre_Remould : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;    
    MyFleetDataSet.TYREREMOULDDataTable dt_TyreRemould = new MyFleetDataSet.TYREREMOULDDataTable();  
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dt_TyreRemould.AddTYREREMOULDRow("", "", "", "", "", "", "", "", "", "");
            BindGrid();
            lbl_Page_Error.Text = "";
            lbl_Sumit.Text = "";
        }
    }
    private void BindGrid()
    {
        gv_Remould.DataSource = dt_TyreRemould;
        gv_Remould.DataBind();
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
    protected void gv_Remould_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox tb_tyre_no = (TextBox)e.Row.FindControl("tb_tyre_no");
            Button btnPopupTyre = (Button)e.Row.FindControl("btnPopupTyre");
            TextBox tb_Current_KM = (TextBox)e.Row.FindControl("tb_Current_KM");
            TextBox tb_Purchase_Cost = (TextBox)e.Row.FindControl("tb_Purchase_Cost");
            TextBox tb_Current_TDM = (TextBox)e.Row.FindControl("tb_Current_TDM");
            TextBox tb_Pattern = (TextBox)e.Row.FindControl("tb_Pattern");
            HiddenField hf_tyre_id = (HiddenField)e.Row.FindControl("hf_tyre_id");
            DropDownList ddl_Tyre_Pattern = (DropDownList)e.Row.FindControl("ddl_Tyre_Pattern");
            Label lbl_Tyre_No_Error = (Label)e.Row.FindControl("lbl_Tyre_No_Error");
            //Image img_Calendar = (Image)e.Row.FindControl("img_Calendar");
            TextBox tb_Remould_Date = (TextBox)e.Row.FindControl("tb_Remould_Date");
            TextBox tb_Avg_TWI_Remould = (TextBox)e.Row.FindControl("tb_Avg_TWI_Remould");
            TextBox tb_Remould_Cost = (TextBox)e.Row.FindControl("tb_Remould_Cost");
            DropDownList ddl_Vendor = (DropDownList)e.Row.FindControl("ddl_Vendor");
            
            Label lbl_Remould_Date_Err = (Label)e.Row.FindControl("lbl_Remould_Date_Err");
            Label lbl_Remould_Cost_Err = (Label)e.Row.FindControl("lbl_Remould_Cost_Err");
            Label lbl_Avg_TWI_Remould_Err = (Label)e.Row.FindControl("lbl_Avg_TWI_Remould_Err");
            Label lbl_Tyre_Pattern_Err = (Label)e.Row.FindControl("lbl_Tyre_Pattern_Err");
            

            tb_tyre_no.Attributes.Add("OnBlur", "javascript:CheckTyreNo(" + e.Row.DataItemIndex + "," + tb_tyre_no.ClientID.ToString() + "," + tb_Current_KM.ClientID.ToString() + "," + tb_Purchase_Cost.ClientID.ToString() + "," + hf_tyre_id.ClientID.ToString() + "," + tb_Pattern.ClientID.ToString() + "," + tb_Current_TDM.ClientID.ToString() + "," + lbl_Tyre_No_Error.ClientID.ToString() + ");");

            tb_Remould_Date.Attributes.Add("OnBlur", "javascript:return chkValidRemouldDate(this," + lbl_Remould_Date_Err.ClientID.ToString() + ")");
            tb_Remould_Cost.Attributes.Add("OnBlur", "javascript:return chkValidRemouldCost(this," + lbl_Remould_Cost_Err.ClientID.ToString() + ")");
            tb_Avg_TWI_Remould.Attributes.Add("OnBlur", "javascript:return chkValidTWI(this," + lbl_Avg_TWI_Remould_Err.ClientID.ToString() + ")");
            ddl_Tyre_Pattern.Attributes.Add("OnChange", "javascript:return checkValidPattern(this," + lbl_Tyre_Pattern_Err.ClientID.ToString() + ")");

            tb_Current_KM.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Remould_Date.ClientID.ToString() + "').focus();");
            tb_Pattern.Attributes.Add("OnFocus", "javascript:document.getElementById('" + ddl_Tyre_Pattern.ClientID.ToString() + "').focus();");
            tb_Purchase_Cost.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Remould_Cost.ClientID.ToString() + "').focus();");
            tb_Current_TDM.Attributes.Add("OnFocus", "javascript:document.getElementById('" + tb_Avg_TWI_Remould.ClientID.ToString() + "').focus();");
            BindDropDown("USP_VENDOR", "VENDORNAME", "VENDORCODE", ddl_Vendor);
            
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + tb_Remould_Date.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + tb_Remould_Date.ClientID + @"\')')");
            
            btnPopupTyre.Attributes.Add("OnClick", "window.open('../../../GUI/popups/popup_TyreRemould.aspx?tyreno=" + tb_tyre_no.ClientID.ToString() + "&km=" + tb_Current_KM.ClientID.ToString() + "&tyre_cost=" + tb_Purchase_Cost.ClientID.ToString() + "&tyreid=" + hf_tyre_id.ClientID.ToString() + "&TyrePattern=" + tb_Pattern.ClientID.ToString() + "&TyreTDM=" + tb_Current_TDM.ClientID.ToString() + "&TyreErr="+ lbl_Tyre_No_Error.ClientID.ToString() +"',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=no, toolbar=no,location=no, menubar= no');return false;");
            BindDropDown("USP_TYREPATTERN", "TYREPAT_CODE", "TYRE_PATTERNID", ddl_Tyre_Pattern); 

        }
    }

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_TyreRemould.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_TyreRemould.AddTYREREMOULDRow("", "", "", "", "", "", "", "", "", "");
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        #region comment
        //bool a=true;
        //foreach (GridViewRow gvr in gv_Remould.Rows)
        //{
        //    TextBox t1 = (TextBox)gv_Remould.Rows[gvr.RowIndex].Cells[1].FindControl("tb_tyre_no"); 
        //    for (int i = 0; i < gv_Remould.Rows.Count; i++)
        //    {
        //        TextBox t2 = (TextBox)gv_Remould.Rows[i].Cells[1].FindControl("tb_tyre_no");
        //        if (gvr.RowIndex != i)
        //        {
        //            if (t1.Text == t2.Text)
        //            {
        //                a = false;
        //                break;
        //            }
        //        }
        //    }
        //    if (a == false)
        //    {
        //        break; 
        //    }
        //}
        //if (a == false)
        //{
        //    lbl_Page_Error.Text = "!!   Mistake in user input - Duplicate Tire Id   !!";
        //}
        //else
        //{
        //    lbl_Page_Error.Text = "";
        //}

        #endregion

        cls_Tyre_Remould TyreRemould = new cls_Tyre_Remould(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        TyreRemould.RemouldId = "";
        try
        {
            foreach (GridViewRow gvr in gv_Remould.Rows)
            {
                TextBox tb_tyre_no = (TextBox)gvr.FindControl("tb_tyre_no");
                Button btnPopupTyre = (Button)gvr.FindControl("btnPopupTyre");
                TextBox tb_Current_KM = (TextBox)gvr.FindControl("tb_Current_KM");
                TextBox tb_Purchase_Cost = (TextBox)gvr.FindControl("tb_Purchase_Cost");
                TextBox tb_Current_TDM = (TextBox)gvr.FindControl("tb_Current_TDM");
                TextBox tb_Pattern = (TextBox)gvr.FindControl("tb_Pattern");
                HiddenField hf_tyre_id = (HiddenField)gvr.FindControl("hf_tyre_id");
                DropDownList ddl_Tyre_Pattern = (DropDownList)gvr.FindControl("ddl_Tyre_Pattern");
                Label lbl_Tyre_No_Error = (Label)gvr.FindControl("lbl_Tyre_No_Error");
                TextBox tb_Remould_Date = (TextBox)gvr.FindControl("tb_Remould_Date");
                TextBox tb_Avg_TWI_Remould = (TextBox)gvr.FindControl("tb_Avg_TWI_Remould");
                TextBox tb_Remould_Cost = (TextBox)gvr.FindControl("tb_Remould_Cost");
                DropDownList ddl_Vendor = (DropDownList)gvr.FindControl("ddl_Vendor");

                TyreRemould.TyreId = tb_tyre_no.Text.Trim();
                TyreRemould.CaptureKM = tb_Current_KM.Text.Trim();
                TyreRemould.RemouldDate = tb_Remould_Date.Text.Trim();
                TyreRemould.tyre_pattern = tb_Pattern.Text.Trim();
                TyreRemould.New_Tyre_Pattern = ddl_Tyre_Pattern.SelectedValue;
                TyreRemould.Cost = tb_Purchase_Cost.Text.Trim();
                TyreRemould.Remould_Cost = tb_Remould_Cost.Text.Trim();
                TyreRemould.TYRE_TREAD_DEPTH_32NDS = tb_Current_TDM.Text.Trim();
                TyreRemould.Avg_TWI = tb_Avg_TWI_Remould.Text.Trim();
                TyreRemould.EnterBy = SessionUtilities.CurrentEmployeeID.ToString();
                TyreRemould.VendorCode = ddl_Vendor.SelectedValue;
                if (TyreRemould.TyreId != "")
                {
                    TyreRemould.BeginTransaction();
                    try
                    {
                        TyreRemould.InsertTyreRemould();
                        IsCommitted = TyreRemould.CommitTransaction();
                    }
                    catch (Exception ex)
                    {
                        TyreRemould.RollBackTransaction();
                        pnl_Error_List.Visible = true;
                        row_Page_Error.Visible = true;
                        lbl_Page_Error.Text = ex.Message.ToString();
                        lbl_Sumit.Text = "";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            pnl_Error_List.Visible = true;
            row_Page_Error.Visible = true;
            lbl_Page_Error.Text = ex.Message.ToString();
            lbl_Sumit.Text = "";
        }

        if (IsCommitted)
        {
            //tb_Row_No.Text = "0";
            dt_TyreRemould.Rows.Clear();
            dt_TyreRemould.AddTYREREMOULDRow("", "", "", "", "", "", "", "", "", "");
            BindGrid();

            pnl_Error_List.Visible = false;
            row_Page_Error.Visible = false;

            lbl_Sumit.ForeColor = System.Drawing.Color.Green;
            lbl_Sumit.Text = "!!    Tyre Remould has been saved successfully    !!";
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

    protected void gv_Remould_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        // BindGrid();
    }
    protected void gv_Remould_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // BindGrid();
    }
}

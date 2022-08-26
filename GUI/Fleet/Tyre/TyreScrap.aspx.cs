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
using ApplicationManager;

public partial class Tyre_Scrap : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.Webx_Fleet_TyresSrapDataTable dt_Scrap = new MyFleetDataSet.Webx_Fleet_TyresSrapDataTable();  
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dt_Scrap.AddWebx_Fleet_TyresSrapRow("", "", "", "", "", "", "", "", "", "", "", "","");
            BindGrid();
            lbl_Page_Error.Text = ""; 
        }
    }
    private void BindGrid()
    {
        gvScrap.DataSource = dt_Scrap;
        gvScrap.DataBind();
    }

    protected void gvScrap_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            HiddenField hfTyreid = (HiddenField)e.Row.FindControl("hfTyreid");

            TextBox tb_Tyre_No = (TextBox)e.Row.FindControl("tb_Tyre_No");
            TextBox tb_Tyre_MFG = (TextBox)e.Row.FindControl("tb_Tyre_MFG");
            TextBox tb_tyre_Model = (TextBox)e.Row.FindControl("tb_tyre_Model");
            TextBox tb_Tyre_Cost = (TextBox)e.Row.FindControl("tb_Tyre_Cost");
            TextBox tb_Tyre_Purchase_KM = (TextBox)e.Row.FindControl("tb_Tyre_Purchase_KM");
            TextBox tb_Current_KM = (TextBox)e.Row.FindControl("tb_Current_KM");
            TextBox tb_Tread_Depth_Read = (TextBox)e.Row.FindControl("tb_Tread_Depth_Read");
            TextBox tb_Scrap_Date = (TextBox)e.Row.FindControl("tb_Scrap_Date");
            TextBox tb_Scrap_Vendor = (TextBox)e.Row.FindControl("tb_Scrap_Vendor");
            TextBox tb_Scrap_Value = (TextBox)e.Row.FindControl("tb_Scrap_Value");
            TextBox tb_Estimated_Scrap_Value = (TextBox)e.Row.FindControl("tb_Estimated_Scrap_Value");
            TextBox tb_Remarks = (TextBox)e.Row.FindControl("tb_Remarks");
            Button btnPopupTyre = (Button)e.Row.FindControl("btnPopupTyre");
            DropDownList ddlReason = (DropDownList)e.Row.FindControl("ddlReason");
            Image img_cal = (Image)e.Row.FindControl("img_cal");
            Button btn_PopUp1 = (Button)e.Row.FindControl("btn_PopUp1");
            HiddenField hfVendorCode = (HiddenField)e.Row.FindControl("hfVendorCode");

            btn_PopUp1.Attributes.Add("OnClick", "javascript:window.open('Popup_VendorName.aspx?OpenerCtl=" + tb_Scrap_Vendor.ClientID.Trim() + "&OpenerCtl1=" + hfVendorCode.ClientID.Trim() + "',null,'left=300, top=150, height=300, width=450, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            tb_Scrap_Vendor.Attributes.Add("OnBlur", "javascript:CheckVendorName(" + tb_Scrap_Vendor.ClientID.ToString() + "," + hfVendorCode.ClientID.ToString() + ");");

            //tb_Scrap_Date.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
            img_cal.Attributes.Add("OnClick", "javascript:cal.select(" + tb_Scrap_Date.ClientID + ",'" + img_cal.ClientID + "','dd/MM/yyyy');");
            tb_Tyre_No.Attributes.Add("OnBlur", "javascript:FillTyreDetails(" + e.Row.RowIndex + ",this," + hfTyreid.ClientID + "," + tb_Tyre_MFG.ClientID + "," + tb_tyre_Model.ClientID + "," + tb_Tyre_Cost.ClientID + "," + tb_Tyre_Purchase_KM.ClientID + "," + tb_Current_KM.ClientID + "," + tb_Tread_Depth_Read.ClientID.Trim() + ");");
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + tb_Scrap_Date.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + tb_Tyre_No.ClientID + @"\')')");
            btnPopupTyre.Attributes.Add("OnClick", "window.open('../../../GUI/popups/popup_TyreNo_Scrap.aspx?TyreNo=" + tb_Tyre_No.ClientID + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        }
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_Scrap.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dt_Scrap.AddWebx_Fleet_TyresSrapRow("", "", "", "", "", "", "", "", "", "", "", "","");
        }
        tb_Row_No.Text = "0";
        BindGrid();
        lbl_Page_Error.Text = "";
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_Tyre_Scrap objTyreScrap = new cls_Tyre_Scrap(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        DataRow dr;
        try
        {
            foreach (GridViewRow gvr in gvScrap.Rows)
            {
                TextBox tb_Tyre_No = (TextBox)gvr.FindControl("tb_Tyre_No");
                TextBox tb_Scrap_Date = (TextBox)gvr.FindControl("tb_Scrap_Date");
                TextBox tb_Scrap_Vendor = (TextBox)gvr.FindControl("tb_Scrap_Vendor");
                HiddenField hfVendorCode = (HiddenField)gvr.FindControl("hfVendorCode");
                TextBox tb_Scrap_Value = (TextBox)gvr.FindControl("tb_Scrap_Value");
                TextBox tb_Estimated_Scrap_Value = (TextBox)gvr.FindControl("tb_Estimated_Scrap_Value");
                TextBox tb_Remarks = (TextBox)gvr.FindControl("tb_Remarks");

                objTyreScrap.Tyre_No = tb_Tyre_No.Text.Trim();
                objTyreScrap.Scrap_Date = DTM.ConvertToDate(tb_Scrap_Date.Text.Trim());
                objTyreScrap.Scrap_Vendor = tb_Scrap_Vendor.Text.Trim();
                objTyreScrap.VENDORCODE = hfVendorCode.Value;
                objTyreScrap.Scrap_Value = tb_Scrap_Value.Text != "" ? Convert.ToDouble(tb_Scrap_Value.Text.Trim()) : 0;
                objTyreScrap.Estimated_Scrap_Value = tb_Estimated_Scrap_Value.Text != "" ? Convert.ToDouble(tb_Estimated_Scrap_Value.Text.Trim()) : 0;
                objTyreScrap.Remarks = tb_Remarks.Text.Trim();
                objTyreScrap.Entry_By = SessionUtilities.CurrentEmployeeID.ToString();  

                objTyreScrap.BeginTransaction();

                try
                {
                    if (tb_Tyre_No.Text != "")
                    {
                        objTyreScrap.InsertTyreScrap();
                        IsCommitted = objTyreScrap.CommitTransaction();
                    }
                }
                catch (Exception ex)
                {
                    objTyreScrap.RollBackTransaction();
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            //lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted)
        {
            tb_Row_No.Text = "0";
            dt_Scrap.Rows.Clear();
            dt_Scrap.AddWebx_Fleet_TyresSrapRow("", "", "", "", "", "", "", "", "", "", "", "","");
            BindGrid();

            lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Error.Text = "!!    Tyre Scrap has been saved successfully   !!";
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
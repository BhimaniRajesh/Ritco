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

public partial class GUI_Fleet_DriverSettlementDate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData(gvDriverSettlementDate);
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + tb_Driver_Settlement_Date.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + tb_Driver_Settlement_Date.ClientID + @"\')')");
        }
    }
    public void BindData(GridView gv)
    {
        cls_DriverSettlementDate objDriverSettlementDate = new cls_DriverSettlementDate(Session["SqlProvider"].ToString().Trim());
        objDriverSettlementDate.BindGridDriverSettlementDate(gv);
        gv.SelectedIndex = -1;
        
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        cls_DriverSettlementDate objDriverSettlementDate = new cls_DriverSettlementDate(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        try
        {
            objDriverSettlementDate.DriverSettlementDate = tb_Driver_Settlement_Date.Text;
            objDriverSettlementDate.EntryBy = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            
            objDriverSettlementDate.BeginTransaction(); 
            try
            {
                objDriverSettlementDate.UpdateDriverSettlementDate();
                IsCommitted = objDriverSettlementDate.CommitTransaction();
            }
            catch (Exception ex)
            {
                objDriverSettlementDate.RollBackTransaction();
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        catch (Exception ex)
        {
            lbl_Page_Error.Text = ex.Message.ToString();
        }

        if (IsCommitted)
        {
            lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Error.Text = "Driver Settlement Date is Successfully Updated.";
            BindData(gvDriverSettlementDate);
            tb_Driver_Settlement_Date.Text = "";
            RowNo.Visible = false;
        }
    }
    protected void gvDriverSettlementDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RowNo.Visible = true;
        Label lblDriverSettlementDateId = (Label)gvDriverSettlementDate.Rows[gvDriverSettlementDate.SelectedIndex].FindControl("lblDriverSettlementDateId");
        tb_Driver_Settlement_Date.Text = lblDriverSettlementDateId.Text;
        tb_Driver_Settlement_Date.Focus();
    }
    protected void lnk_btn_Add_Click(object sender, EventArgs e)
    {
        RowNo.Visible = true;
    }
    protected void btn_Cencel_Click(object sender, EventArgs e)
    {
        RowNo.Visible = false;
        BindData(gvDriverSettlementDate);
        tb_Driver_Settlement_Date.Text = "";
        lbl_Driver_Settlement_Date_Err.Text = "";
        lbl_Page_Error.Text = "";
    }
    protected void gvDriverSettlementDate_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gvDriverSettlementDate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDriverSettlementDate.PageIndex = e.NewPageIndex;
        BindData(gvDriverSettlementDate);
    }
}

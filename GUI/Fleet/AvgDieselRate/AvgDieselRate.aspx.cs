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

public partial class GUI_Fleet_AvgDieselRate_AvgDieselRate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hfId.Value = "0";  
            BindData(gvDieselRate);
        }
    }
    public void BindData(GridView gv)
    {
        AvgDieselRate objDieselRate = new AvgDieselRate(Session["SqlProvider"].ToString().Trim());
        objDieselRate.BindGridAvgDieselRate(gv);
        gv.SelectedIndex = -1;
        
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        AvgDieselRate objDieselRate = new AvgDieselRate(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        try
        {
            
            objDieselRate.AvgDieRate = tb_Avg_Diesel_Rate.Text.ToString().Trim();
            objDieselRate.Entry_By = SessionUtilities.CurrentEmployeeID.ToString().Trim();

            objDieselRate.BeginTransaction(); 
            try
            {
                if (hfId.Value == "0")
                {
                    objDieselRate.InsertAvgDieselRate();
                }
                else
                {
                    objDieselRate.AvgDieselRateId = Convert.ToInt32(hfId.Value);
                    objDieselRate.UpdateAvgDieselRate();  
                }
                IsCommitted = objDieselRate.CommitTransaction();
            }
            catch (Exception ex)
            {
                objDieselRate.RollBackTransaction();
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
            lbl_Page_Error.Text = "Average Diesel Rate is Successfully Updated.";
            BindData(gvDieselRate);
            tb_Avg_Diesel_Rate.Text = "0.00";
            hfId.Value = "0";
            RowNo.Visible = false;
        }
    }
    protected void gvDieselRate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RowNo.Visible = true;
        Label lblAvgDieselRateId = (Label)gvDieselRate.Rows[gvDieselRate.SelectedIndex].FindControl("lblAvgDieselRateId");
        HiddenField hfAvgDieselRateId = (HiddenField)gvDieselRate.Rows[gvDieselRate.SelectedIndex].FindControl("hfAvgDieselRateId");
        tb_Avg_Diesel_Rate.Text = lblAvgDieselRateId.Text;
        hfId.Value = hfAvgDieselRateId.Value;
        tb_Avg_Diesel_Rate.Focus();
    }
    protected void lnk_btn_Add_Click(object sender, EventArgs e)
    {
        RowNo.Visible = true;
    }
    protected void btn_Cencel_Click(object sender, EventArgs e)
    {
        RowNo.Visible = false;
        BindData(gvDieselRate);
        tb_Avg_Diesel_Rate.Text = "0.00";
        hfId.Value = "0";
    }
    protected void gvDieselRate_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gvDieselRate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDieselRate.PageIndex  = e.NewPageIndex;
        BindData(gvDieselRate);
    }
}

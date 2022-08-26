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

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_VehicleMaster_VehicleMasterEdSelect : System.Web.UI.Page
{
    #region Variable[s]  
    private string ErrorMsg = string.Empty;  
    #endregion

    #region Form Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        VehicleMasterController objVehicleMaster = new VehicleMasterController();
        DataTable dtVehicleList = new DataTable(); 

        try
        {           
            if (Request.QueryString["Flag"] != null)
            {
                if (Request.QueryString["Flag"] == "Edit")
                {
                    btnEdit.Visible = true;
                }
                else if (Request.QueryString["Flag"] == "View")
                {
                    btnView.Visible = true;
                }                    
            }                        

            if (!IsPostBack)
            {
                dtVehicleList = objVehicleMaster.getAllVehicleTypeList();

                if (dtVehicleList != null && dtVehicleList.Rows.Count > 0)
                {                  
                    ddVehicleType.DataTextField = "VehicleType";
                    ddVehicleType.DataValueField = "Type_Code";
                    ddVehicleType.DataSource = dtVehicleList;
                    ddVehicleType.DataBind();                    
                }
                ddVehicleType.Items.Insert(0, new ListItem("Select", "0"));
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in Data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            return;
        }
    }   
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {  
             Validation();

             if (string.IsNullOrEmpty(ErrorMsg))
             {
                 Response.Redirect("VehicleTypeMaster.aspx?Flag=Edit&vehicleTypeCode=" + ddVehicleType.SelectedValue.Trim(), false);
             }
             else
             {
                 Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);                 
             }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired&detail1=" + Exc.Message.Replace('\n', '_'));            
        }
    }      
  
    protected void btnView_Click(object sender, EventArgs e)
    {
        try
        {      
             Validation();

             if (string.IsNullOrEmpty(ErrorMsg))
             {
                 Response.Redirect("VehicleTypeMasterView.aspx?print=N&vehicleTypeCode=" + ddVehicleType.SelectedValue, false);
             }
             else
             {
                 Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);                
             }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired&detail1=" + Exc.Message.Replace('\n', '_'));           
        }
    }
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        ErrorMsg = string.Empty;

        if (ddVehicleType.SelectedValue == "0")
        {
            ErrorMsg = "Please select Vehicle Type Name.";
            return;
        }    
    }
    #endregion
}

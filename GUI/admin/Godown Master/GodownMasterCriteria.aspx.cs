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

public partial class GUI_admin_VendorMaster_GodownMasterCriteria : System.Web.UI.Page
{

    #region Variable[s]
    private string ErrorMsg = string.Empty;
    #endregion

    #region Form Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["Flag"] != null)
            {
                if (Request.QueryString["Flag"] == "Edit")               
                    btnEdit.Visible = true;                
                else if (Request.QueryString["Flag"] == "View")                
                    btnView.Visible = true;                         
            }

            if (!IsPostBack)            
                bindLocationDDL();           
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in Data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }   
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))            
                Response.Redirect("GodownMaster.aspx?Flag=Edit&LocCode=" + ddlLocation.SelectedValue.ToString(), false);
            else
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);            
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        ErrorMsg = string.Empty;  
        if (ddlLocation.SelectedValue == "0")
        {
            ErrorMsg = "Please select Warehouse Location.";
            return;
        }      
    }
    private void bindLocationDDL()
    {
        try
        {
            GodownMasterController objGodownMaster = new GodownMasterController();
            DataTable dtLocationList = new DataTable();

            ddlLocation.Items.Clear();
            dtLocationList = objGodownMaster.getAllLocationList();

            if (dtLocationList != null && dtLocationList.Rows.Count > 0)
            {
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "spdbrcd";
                ddlLocation.DataSource = dtLocationList;
                ddlLocation.DataBind();               
            }
            ddlLocation.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion 
    
}
    


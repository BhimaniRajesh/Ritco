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

public partial class GUI_admin_VendorMaster_RouteMasterCriteria : System.Web.UI.Page
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
                bindRouteTypeDDL(ddlRouteMode.SelectedItem.Text);
            }
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
            {
                if (rdRouteType.Checked == true)
                {
                    Response.Redirect("RouteMaster.aspx?Flag=Edit&routeCode=" + ddlRoute.SelectedValue.ToString(), false);
                }
                else if (rdRouteCode.Checked == true)
                {
                    if (!string.IsNullOrEmpty(txtRouteCode.Text.Trim()))
                    {
                        Response.Redirect("RouteMaster.aspx?Flag=Edit&routeCode=" + txtRouteCode.Text.Trim(), false);
                    }
                }
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {
                if (rdRouteType.Checked == true)
                {
                    Response.Redirect("RouteMaster.aspx?print=N&routeCode=" + ddlRoute.SelectedValue.Trim(), false);
                }
                else if (rdRouteCode.Checked == true)
                {
                    if (!string.IsNullOrEmpty(txtRouteCode.Text.Trim()))
                    {
                        Response.Redirect("RouteMaster.aspx?print=N&routeCode=" + txtRouteCode.Text.Trim(), false);
                    }
                }
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void ddlRouteMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindRouteTypeDDL(ddlRouteMode.SelectedValue.Trim());
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error to get Route list by route mode.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        if (rdRouteType.Checked)
        {           
            if (ddlRoute.SelectedValue == "0")
            {
                ErrorMsg = "Please select Route.";
                return;                  
            }            
        }
        else
        {            
            if (txtRouteCode.Text == "")
            {
                ErrorMsg = "Please enter Route Code.";
                return;                 
            }      
        }
    }
    private void bindRouteTypeDDL(string strRouteMode)
    {
        TripRouteMasterController objRouteMaster = new TripRouteMasterController();
        DataTable dtRouteMaster = new DataTable();

        try
        {
            ddlRoute.Items.Clear();

            dtRouteMaster = objRouteMaster.getAllCityRouteByRouteMode(strRouteMode.Trim());
   
            if (dtRouteMaster != null && dtRouteMaster.Rows.Count > 0)
            {
                ddlRoute.DataTextField = "Route";
                ddlRoute.DataValueField = "RouteCode";
                ddlRoute.DataSource = dtRouteMaster;
                ddlRoute.DataBind();
                ddlRoute.Items.Insert(0, new ListItem("Select", "0"));
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion 
    
}
    


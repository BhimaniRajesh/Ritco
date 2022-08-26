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

public partial class GUI_admin_StateMaster_StateMasterCriteria : System.Web.UI.Page
{
    #region Variable[s]
    private string ErrorMsg = string.Empty;  
    #endregion

    #region Form Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        StateMasterController objStateMaster = new StateMasterController();
        DataTable dtStateList = new DataTable();
       
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

        if (!Page.IsPostBack)
        {
            dtStateList = objStateMaster.getAllStateDistinct();

            if (dtStateList != null && dtStateList.Rows.Count > 0)
            {
                ddState.DataTextField = "STdetail";
                ddState.DataValueField = "STCD";
                ddState.DataSource = dtStateList;
                ddState.DataBind();                
            }
            ddState.Items.Insert(0, new ListItem("Select", "0"));
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {                
                Response.Redirect("StateMaster.aspx?Flag=Edit&state=" + ddState.SelectedValue.Trim(), true);
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, true);
            }
        }
        catch (Exception Exc)
        {
        }
    }   
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        ErrorMsg = string.Empty;

        if (ddState.SelectedValue == "0")
        {
            ErrorMsg = "Please select state.";
            return;
        }
    }
    #endregion
}

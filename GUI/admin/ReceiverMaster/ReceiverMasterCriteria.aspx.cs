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

public partial class GUI_admin_ReceiverMasterCriteria : System.Web.UI.Page
{
    #region Variable[s]
    private string ErrorMsg = string.Empty;  
    #endregion

    #region Form Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        ReceiverMasterController objReceiverMasterController = new ReceiverMasterController();
        DataTable dtReceiverList = new DataTable();
       
        if (Request.QueryString["Flag"] != null)
        {
            if (Request.QueryString["Flag"] == "Edit")
            {
                btnEdit.Visible = true;
            }          
        }       

        if (!Page.IsPostBack)
        {
            dtReceiverList = objReceiverMasterController.getAllReceiverInfo();

            if (dtReceiverList != null && dtReceiverList.Rows.Count > 0)
            {
                ddlReceiver.DataTextField = "Receiver";
                ddlReceiver.DataValueField = "ReceiverCode";
                ddlReceiver.DataSource = dtReceiverList;
                ddlReceiver.DataBind();                
            }

            ddlReceiver.Items.Insert(0, new ListItem("Select", "0"));
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {
                Response.Redirect("ReceiverMaster.aspx?Flag=Edit&receiverCode=" + ddlReceiver.SelectedValue.Trim(), true);
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
        if (ddlReceiver.SelectedValue == "0")
        {
            ErrorMsg = "Please select Receiver.";
            return;
        }
    }
    #endregion
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_Admin_ReceiverMasterDone : System.Web.UI.Page
{
    #region Variable[s]
    protected string receiverCode = "";
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Convert.ToString(Request.QueryString["Flag"]) == "Edit")
                {
                    lblTitle.Text = "Following Receiver Has Been Successfully Updated";
                }
                else
                {
                    lblTitle.Text = "Following Receiver Has Been Successfully Inserted";
                }

                lblReceiverName.Text = Convert.ToString(Request.QueryString["receiverCode"]);// getState(Convert.ToString(Request.QueryString["state"]));
                receiverCode = Convert.ToString(Request.QueryString["receiverCode"]);
            }
        }
        catch(Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void lnkBtnEditVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReceiverMasterCriteria.aspx?Flag=Edit");
    }
    protected void lnkBtnViewVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReceiverMasterCriteria.aspx?Flag=View");
    }
    #endregion  
}

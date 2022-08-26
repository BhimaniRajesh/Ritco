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

public partial class GUI_Admin_GodownMaster : System.Web.UI.Page
{
    #region Variable[s]
    protected string LocCode = "";
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Convert.ToString(Request.QueryString["Flag"]) == "Edit")                
                    lblTitle.Text = "Warehouse details successfully updated for below location";                
                else
                    lblTitle.Text = "Warehouse details successfully inserted for below location";                

                lblLocName.Text = Convert.ToString(Request.QueryString["LocCode"]);
                LocCode = Convert.ToString(Request.QueryString["LocCode"]);
            }
        }
        catch(Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void lnkBtnEditVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("GodownMasterCriteria.aspx?Flag=Edit");
    }
    //protected void lnkBtnViewVehicle_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("StateMasterCriteria.aspx?Flag=View");
    //}
    #endregion

    #region Private Function[s]
    public string getState(string strStateCode)
    {
        StateMasterController objStateMaster = new StateMasterController();
        DataTable dtStateMaster = new DataTable();

        try
        {
            if (!string.IsNullOrEmpty(strStateCode))
            {
                dtStateMaster = objStateMaster.getStateByStateCode(strStateCode);
            }

            if (dtStateMaster != null && dtStateMaster.Rows.Count > 0)
            {
                // lblStateCode.Text = Convert.ToString(dtStateMaster.Rows[0]["STCD"]);
                return Convert.ToString(dtStateMaster.Rows[0]["STNM"]);
            }
            else
            {
                return "";
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}

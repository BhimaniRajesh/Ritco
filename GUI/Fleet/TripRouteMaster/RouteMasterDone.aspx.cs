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


public partial class GUI_Admin_Vendor_contract_vendorContract_RouteMasterDone : System.Web.UI.Page
{
    protected string routeCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Convert.ToString(Request.QueryString["Flag"]) == "Edit")
                {
                    lblTitle.Text = "Following Trip Route Has Been Successfully Updated";
                }
                else
                {
                    lblTitle.Text = "Following Trip Route Has Been Successfully Inserted";
                }

                lblRouteCode.Text = Convert.ToString(Request.QueryString["routeCode"]);
                routeCode = lblRouteCode.Text;
            }
        }         
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }

    protected void lnkBtnEditVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("RouteMasterCriteria.aspx?Flag=Edit");
    }

    protected void lnkBtnViewVehicle_Click(object sender, EventArgs e)
    {
        Response.Redirect("RouteMasterCriteria.aspx?Flag=View");        
    }   
}

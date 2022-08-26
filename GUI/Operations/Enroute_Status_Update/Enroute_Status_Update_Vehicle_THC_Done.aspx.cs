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

public partial class GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Vehicle_THC_Done : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack && !IsCallback)
            {
                lblTitle.Text = "Following Document has Successfully Generated/Updated";
                lblDockno.Text = Convert.ToString(Request.QueryString["No"]);

                if(Request.QueryString["Type"]=="2")
                    lblHeader.Text = "Enroute Status Update - " + SessionUtilities.THCCalledAs;
                else if (Request.QueryString["Type"] == "3")
                    lblHeader.Text = "Enroute Status Update - Vehicle";
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
}

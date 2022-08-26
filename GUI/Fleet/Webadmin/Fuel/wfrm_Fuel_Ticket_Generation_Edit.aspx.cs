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

public partial class GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Ticket_Generation_Edit : System.Web.UI.Page
{
    private void BindData()
    {
        BLL_Fuel fuel_Ticket = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Ticket.BindGridFuelTicket(gv_Fuel_Ticket);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindData();
    }
}

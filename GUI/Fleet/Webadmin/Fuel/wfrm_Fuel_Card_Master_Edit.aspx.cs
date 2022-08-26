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

public partial class GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Card_Master_Edit : System.Web.UI.Page
{
    private void BindData()
    {
        BLL_Fuel fuel_Card = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Card.BindGridFuelCard(gv_Fuel_Card);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindData();
    }
}

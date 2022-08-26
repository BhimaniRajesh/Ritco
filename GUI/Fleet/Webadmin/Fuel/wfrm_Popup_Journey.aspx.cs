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

public partial class GUI_Fleet_Webadmin_Fuel_wfrm_Popup_Journey : System.Web.UI.Page
{
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        BLL_Fuel fuel_Popup = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Popup.BindDLJourney(dl_Journey, tb_VEHNO.Text);
    }
}

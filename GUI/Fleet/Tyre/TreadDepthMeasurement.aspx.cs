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

public partial class GUI_Fleet_Tyre_TreadDepthMeasurement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex == 0)
        {
            Response.Redirect("TreadDepthVehicleWise.aspx");
        }
        else
        {
            Response.Redirect("TreadDepthTyreWise.aspx");
        }
    }
}

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class GUI_Fleet_Reports_TyreModelCount_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //VehNo.Attributes.Add("OnClick", "window.open('../TyreModelCount/Popup-Vehicle.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btn_PopUp1.Attributes.Add("OnClick", "javascript:window.open('Popup-Vehicle.aspx?OpenerCtl=" + txtVehNo.ClientID.Trim() + "&OpenerCtl1=" + hfVehIntId.ClientID.Trim() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        }
    }
}

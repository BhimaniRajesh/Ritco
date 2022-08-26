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
using System.Data.SqlClient;

public partial class GUI_Fleet_TripRuleMaster_TripFinanceMst : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //hfId.Value = "";  
            BindData(gvExpFinance);
            //RowNo.Style["display"] = "none";
            //tb_AccCode.Attributes.Add("onblur", "AccBlur(" + tb_AccCode.ClientID.ToString() + "," + tb_Description.ClientID.ToString() + ")");
            //btnAccCode.Attributes.Add("onclick", "window.open('AccCodePopUp.aspx?AccCode=" + tb_AccCode.ClientID.ToString() + "&AccDesc=" + tb_Description.ClientID.ToString() + "',null,'left=300, top=150, height=300, width= 500, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");
        }
    }
    public void BindData(GridView gv)
    {
        TripExpense objTripExpense = new TripExpense(Session["SqlProvider"].ToString().Trim());
        objTripExpense.BindGridTripFinance(gv);
        gv.SelectedIndex = -1;
    }
}

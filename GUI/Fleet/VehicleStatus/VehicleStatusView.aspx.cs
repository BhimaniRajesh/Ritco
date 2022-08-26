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

public partial class GUI_Fleet_VehicleStatus_VehicleStatusView : System.Web.UI.Page
{
    static string str_Connection_String;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SqlProvider"] != null)
        {
            str_Connection_String = Session["SqlProvider"].ToString().Trim();
        }
        if (!IsPostBack)
        {
            BindGrid();
            btnPopupVehno.Attributes.Add("OnClick", "window.open('Popup_VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + hfKm.ClientID.ToString() + "&lblErr=" + lblVehNoErr.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            //txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo(" + txtVehNo.ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + hfKm.ClientID.ToString() + "," + lblVehNoErr.ClientID.ToString() + "," + tb_Tripsheet_No.ClientID.ToString() + ");");
            //string script;
            //script = @"<SCRIPT language='javascript'> HideTripsheet();" + "</SCRIPT>";
            //this.RegisterStartupScript("MyAlert", script);
        }
    }
    public void BindGrid()
    {
        cls_VehicllTracking objVehicleTracking = new cls_VehicllTracking(str_Connection_String);
        objVehicleTracking.VehNo = txtVehNo.Text.ToString().Trim();
        objVehicleTracking.BindGrid(gvVehicleStatus);
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvVehicleStatus.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

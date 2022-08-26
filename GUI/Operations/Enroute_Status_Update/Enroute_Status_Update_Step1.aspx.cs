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
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Step1 : System.Web.UI.Page
{
    protected string dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = SessionUtilities.DocketCalledAs;
        if (!IsPostBack && !IsCallback)
        {
            ddlRefType.Items[0].Text = SessionUtilities.DocketCalledAs + " Number";
            ddlRefType.Items[1].Text = SessionUtilities.THCCalledAs + " Number";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if(ddlRefType.SelectedValue=="1")
            {
                if (ddlRefUpdateMethod.SelectedValue == "1")
                {
                    Response.Redirect("Enroute_Status_Update_Docket.aspx", false);
                }
                if (ddlRefUpdateMethod.SelectedValue == "2")
                {
                    Response.Redirect("ImportEnrouteStatusUpdateFromXLS_Docket.aspx", false);
                }
            }
            else if (ddlRefType.SelectedValue == "2")
            {
                if (ddlRefUpdateMethod.SelectedValue == "1")
                {
                    Response.Redirect("Enroute_Status_Update_Vehicle_THC.aspx?Type=2", false);
                }
                if (ddlRefUpdateMethod.SelectedValue == "2")
                {
                    Response.Redirect("ImportEnrouteStatusUpdateFromXLS_THCVehicle.aspx", false);
                }
            }
            else if (ddlRefType.SelectedValue == "3")
            {
                if (ddlRefUpdateMethod.SelectedValue == "1")
                {
                    Response.Redirect("Enroute_Status_Update_Vehicle_THC.aspx?Type=3", false);
                }
                if (ddlRefUpdateMethod.SelectedValue == "2")
                {
	                Response.Redirect("ImportEnrouteStatusUpdateFromXLS_THCVehicle.aspx", false);
                }
            }
        }
        catch (Exception Exc)
        {
            string strex = Exc.Message.Replace('\n', '_');
            Response.Redirect("ErrorPage.aspx?heading=Enroute Status Update Criteria Error&detail1=Enroute Status Update Criteria Error&detail2=" + strex, false);
        }
    }
}

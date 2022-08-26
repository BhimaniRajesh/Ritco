using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_MISCreditKMS_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindVehicle();
        }
    }

    public void BindVehicle()
    {
        var dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT Vehno FROM dbo.webx_VEHICLE_HDR WITH (NOLOCK) WHERE ACTIVEFLAG='Y'").Tables[0];

        ddlVehicle.DataSource = dt;
        ddlVehicle.DataTextField = "Vehno";
        ddlVehicle.DataValueField = "Vehno";
        ddlVehicle.DataBind();
        ddlVehicle.Items.Insert(0, new ListItem("ALL", ""));
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            string final;
            final = "Result.aspx?VehicleNo=" + ddlVehicle.SelectedValue;
            final += "&Balance=" + ddlBalance.SelectedValue;
            Page.RegisterStartupScript("MIS for Credit KMS Report", @"<script language='JavaScript' type='text/javascript'>window.open('" + final + "', '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800 ,height=600,status=no,left=60,top=50');</script>");
        }
        catch (Exception)
        {

        }
    }
}
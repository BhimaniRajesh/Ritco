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

public partial class GUI_UNI_Net_MIS_Trip_Profitablility_Report_Query : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            BindVehicleModels();
        }
    }
    protected void btnShow2_Click(object sender, EventArgs e)
    {
        string QStrig = "Result.aspx";
        QStrig += "?VHModel=" + ddlVHModel.SelectedValue;
        QStrig += "&FDT=";
        QStrig += "&TDT=";
        QStrig += "&PSTS=";
        QStrig += "&MRF=";
        QStrig += "&MRT=";

        Response.Redirect(QStrig, false);
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string QStrig = "Result.aspx";
        QStrig += "?VHModel=";        
        QStrig += "&FDT=" + dtFromTo.DateFrom.ToString("dd MMM yy");
        QStrig += "&TDT=" + dtFromTo.DateTo.ToString("dd MMM yy");
        QStrig += "&PSTS=" + ddlProfStatus.SelectedValue;        
        QStrig += "&MRF=";
        if (txtMRFrom.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRFrom.Text.Trim();
        QStrig += "&MRT=";
        if (txtMRTo.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRTo.Text.Trim();

        Response.Redirect(QStrig, false);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string QStrig = "Result_Test.aspx";
        QStrig += "?VHModel=";        
        QStrig += "&FDT=" + dtFromTo.DateFrom.ToString("dd MMM yy");
        QStrig += "&TDT=" + dtFromTo.DateTo.ToString("dd MMM yy");
        QStrig += "&PSTS=" + ddlProfStatus.SelectedValue;        
        QStrig += "&MRF=";
        if (txtMRFrom.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRFrom.Text.Trim();
        QStrig += "&MRT=";
        if (txtMRTo.Text.Trim() == "")
            QStrig += "0";
        else
            QStrig += txtMRTo.Text.Trim();

        Response.Redirect(QStrig, false);
    }

    

    private void BindVehicleModels()
    {
        string strQ = "SELECT DISTINCT VEHMODEL FROM webx_VEHICLE_HDR WHERE ISNULL(VEHMODEL,'')<>''";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        ddlVHModel.DataSource = ds;
        ddlVHModel.DataTextField = "VEHMODEL";
        ddlVHModel.DataValueField = "VEHMODEL";
        ddlVHModel.DataBind();
        ddlVHModel.Items.Insert(0, new ListItem("--Select--", ""));
        ddlVHModel.SelectedValue = "";
    }
}

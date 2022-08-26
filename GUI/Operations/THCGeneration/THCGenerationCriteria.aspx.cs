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
using System.Data.SqlClient;
using System.IO;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;

using System.Xml;

public partial class GUI_Operations_THCGeneration_THCGenerationCriteria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack && !IsCallback)
        {
            DataSet ds = THCController.GetQueryDetails();

        ddlPaymentBasis.DataSource = ds.Tables[0];
        ddlPaymentBasis.DataBind();

        dllModeBasis.DataSource = ds.Tables[1];
        dllModeBasis.DataBind();

        dlllServiceClass.DataSource = ds.Tables[2];
        dlllServiceClass.DataBind();

        dllBusinessTYpe.DataSource = ds.Tables[3];
        dllBusinessTYpe.DataBind();

   
            dllModeBasis.SelectedValue = "0";
            ddlPaymentBasis.SelectedValue = "0";
            dlllServiceClass.SelectedValue = "0";
            dllBusinessTYpe.SelectedValue = "0";
        }
    }

    protected void OnLocationTYpeChange(object sender, EventArgs e)
    {
        dllDateType.Items.Clear();
        dllDateType.Items.Add(new ListItem("Booking Date", "dockdt"));
        if (rdltype.SelectedValue == "2")
                    dllDateType.Items.Add(new ListItem("Arrived Date", "arrived_dt"));
     

    }

    protected void btnSubmitClick(object sender, EventArgs e)
    {
        string strValue;
        strValue = "?PayBasis=" + ddlPaymentBasis.SelectedValue.ToString();
        strValue += "&TrnMode=" + dllModeBasis.SelectedValue.ToString();
        strValue += "&BookingType=" + dlllServiceClass.SelectedValue.ToString();
        strValue += "&BusinessTYpe=" + dllBusinessTYpe.SelectedValue.ToString();
        strValue += "&LocationType=" + rdltype.SelectedValue.ToString();
        strValue += "&DateType=" + dllDateType.SelectedValue.ToString();
        strValue += "&FromDate=" + DT.FromDate;
        strValue += "&ToDate=" + DT.ToDate;
        strValue += "&Destintion=" + txtstartBranch.Text.ToString();
        
        strValue += "&THCType=2" ;

        Response.Redirect("THCGeneration.aspx" + strValue);
    }
}

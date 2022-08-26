using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_UNI_NET_MIS_GSTInvoiceRegisterReport_VendorWise_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindState();
        BindSacCode();
    }

    public void BindState()
    {
        try
        {
            DataTable dataTable;
            var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
            dataTable = objDbFactory.ExecuteDataTable("Usp_Get_StateList", null);
            ddlState.DataTextField = "STNAME";
            ddlState.DataValueField = "STCODE";
            ddlState.DataSource = dataTable;
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("--All--", "All"));
        }
        catch (Exception Exc)
        {
            throw Exc;
        }

    }

    public void BindSacCode()
    {
        try
        {
            DataTable dataTable;
            var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
            dataTable = objDbFactory.ExecuteDataTable("Usp_Get_SaccodeList", null);
            ddlSacCode.DataTextField = "SacDesc";
            ddlSacCode.DataValueField = "SacCode";
            ddlSacCode.DataSource = dataTable;
            ddlSacCode.DataBind();
            ddlSacCode.Items.Insert(0, new ListItem("--All--", "All"));
        }
        catch (Exception Exc)
        {
            throw Exc;
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string quryString = "";
        quryString = quryString + "FromDate=" + dtBookingDate.FromDate;
        quryString = quryString + "&ToDate=" + dtBookingDate.ToDate;
        quryString = quryString + "&State=" + ddlState.SelectedValue;
        quryString = quryString + "&DocType=" + ddlDocType.SelectedValue;
        quryString = quryString + "&PartyCode=" + txtVendorCode.Text;
        quryString = quryString + "&SACCode=" + ddlSacCode.SelectedValue;
        quryString = quryString + "&DocumentNo=" + txtDockNo.Text;

        Response.Redirect("Result.aspx?" + quryString, false);
    }
}
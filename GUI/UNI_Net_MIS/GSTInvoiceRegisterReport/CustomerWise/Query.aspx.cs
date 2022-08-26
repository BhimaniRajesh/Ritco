using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_UNI_NET_MIS_GSTInvoiceRegisterReport_CustomerWise_Query : System.Web.UI.Page
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
        quryString = quryString + "?FromDate=" + dtBookingDate.FromDate;
        quryString = quryString + "&ToDate=" + dtBookingDate.ToDate;
        quryString = quryString + "&State=" + ddlState.SelectedValue;
        quryString = quryString + "&DocType=" + ddlDocType.SelectedValue;
        quryString = quryString + "&PartyCode=" + txtCustomerCode.Text;
        quryString = quryString + "&SACCode=" + ddlSacCode.SelectedValue;
        quryString = quryString + "&DocumentNo=" + txtDockNo.Text;

        //Response.Redirect("Result.aspx?" + quryString, false);

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");

        sb.Append("function NoConfirm()");
        sb.Append("{");
        sb.Append("win = top;");
        sb.Append("win.opener = top;");
        sb.Append("win.close ();");
        sb.Append("}");

        sb.Append("window.open('./Result.aspx" + quryString + "', '_blank',");

        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, addressbar=yes, menubar=no,toolbar=no,status=1,resizable=yes');");

        sb.Append("<");
        sb.Append("/script>");

        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }

    }
}
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Finance_Vendor_BA_payment_Fixed_Variable_Expense_ExpenseQuey : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string tmpStr = "javascript:return validcheck()";
        btnSubmit.Attributes.Add("onClick", tmpStr);


    }

    protected void ddlExpVoucherType_OnSelectedIndexChange(object sender, EventArgs e)
    {
        chkStat.Checked = false;
        chkDriver.Checked = false;
        chkVehicleTrack.Checked = false;
        chkFin.Checked = false;
        chkRepair.Checked = false;


        if (ddlExpVoucherType.SelectedItem.Value == "F")
        {
            tblVariableVoucherHeads.Visible = false;
            tblFixedVoucherHeads.Visible = true;
        }
        else if (ddlExpVoucherType.SelectedItem.Value == "V")
        {
            tblVariableVoucherHeads.Visible = true;
            tblFixedVoucherHeads.Visible = false;
        }
        else
        {
            tblFixedVoucherHeads.Visible = false;
            tblVariableVoucherHeads.Visible = false;
        }
    }

    protected void SubmitData(object sender, EventArgs e)
    {
        string Stat = "";
        string CrewSal = "";
        string VehTrack = "";
        string FinExp = "";
        string Repair = "";

        if (chkStat.Checked == true)
        {
            Stat = "S";
        }

        if (chkDriver.Checked == true)
        {
            CrewSal = "C";
        }

        if (chkVehicleTrack.Checked == true)
        {
            VehTrack = "V";
        }

        if (chkFin.Checked == true)
        {
            FinExp = "F";
        }

        if (chkRepair.Checked == true)
        {
            Repair = "R";
        }

        string strval = "ExpMode=" + ddlExpVoucherType.SelectedItem.Value + "&Stat=" + Stat + "&CrewSal=" + CrewSal + "&VehTrack=" + VehTrack + "&FinExp=" + FinExp + "&Repair=" + Repair;
        Response.Redirect("ExpenseEntry.aspx?" + strval);
    }
}

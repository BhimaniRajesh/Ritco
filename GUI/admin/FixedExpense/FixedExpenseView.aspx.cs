using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;
using WebX.Controllers;

public partial class GUI_admin_FixedExpense_FixedExpenseView : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindLocation();
            BindVehicle();
            BindSelectOption();
        }
    }
    public void BindLocation()
    {
        var oLocationMaster = new LocationMasterController();
        var dt = new DataTable();
        dt = oLocationMaster.getAllLocations();

		ddlBranch.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_locations_all_ver1").Tables[0];
        ddlBranch.DataBind();
        // ddlBranch.DataSource = dt;
        // ddlBranch.DataTextField = "LocName";
        // ddlBranch.DataValueField = "LocCode";
        // ddlBranch.DataBind();
        
    }

    public void BindVehicle()
    {
        var oFixedExpenseController = new FixedExpenseController();
        var dt = new DataTable();
        dt = oFixedExpenseController.GetBranchWiseVehicleDetails(SessionUtilities.CurrentBranchCode);

        ddlVehicle.DataSource = dt;
        ddlVehicle.DataTextField = "VehNo";
        ddlVehicle.DataValueField = "VehNo";
        ddlVehicle.DataBind();
        ddlVehicle.Items.Insert(0, new ListItem("--All--", ""));
    }
    public void BindSelectOption()
    {
        var dt = new DataTable();
        dt = GeneralMasterUtilities.GetGeneralMaster("TyreOPT");

        ddlOption.DataSource = dt;
        ddlOption.DataTextField = "CodeDesc";
        ddlOption.DataValueField = "CodeId";
        ddlOption.DataBind();
        ddlOption.Items.Insert(0, new ListItem("--All--", ""));
    }

    protected void btnStep1_Click(object sender, EventArgs e)
    {
        trxsl.Visible = true;
        view.Visible = true;
        XlSDownload.Visible = true;
        FixedExpenseController obj = new FixedExpenseController();

        ds = obj.GetFixedExpenseAllDetails(ddlBranch.SelectedItem.Value, ddlVehicle.SelectedItem.Value,ddlOption.SelectedItem.Value);
        BindFixedExpenseDetails.DataSource = ds;
        BindFixedExpenseDetails.DataBind();
    }

    protected void XlSDownload_Click(object sender, EventArgs e)
    {
        try
        {
            FixedExpenseController obj = new FixedExpenseController();
            ds = obj.GetFixedExpenseAllDetails(ddlBranch.SelectedItem.Value, ddlVehicle.SelectedItem.Value, ddlOption.SelectedItem.Value);
            ExcelUtilities Exlobj = new ExcelUtilities();
            Exlobj.ExportExcel(ds, "FixedExpense.xls");
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "XlSDownload_Click");
        }
    }
}
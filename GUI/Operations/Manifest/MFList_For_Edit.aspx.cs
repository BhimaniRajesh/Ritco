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
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

public partial class GUI_Operations_Manifest_MFList_For_Edit : System.Web.UI.Page
{
    string EmployeeID = "", BranchCode="";
    private DataTable ListData
    {
        get { return (ViewState["ListData"] != null) ? ViewState["ListData"] as DataTable : new DataTable(); }
        set { ViewState["ListData"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        EmployeeID = SessionUtilities.CurrentEmployeeID;
        BranchCode = SessionUtilities.CurrentBranchCode;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sp = "usp_Get_MF_For_Edit";
        SqlParameter[] prms = new SqlParameter[6];
        prms[0] = ControllersHelper.GetSqlParameter("@BRCD", BranchCode);
        prms[1] = ControllersHelper.GetSqlParameter("@FromDate", ucDT.DateFrom);
        prms[2] = ControllersHelper.GetSqlParameter("@ToDate", ucDT.DateTo);
        prms[3] = ControllersHelper.GetSqlParameter("@NextStop", txtNextStop.Text.Trim());
        prms[4] = ControllersHelper.GetSqlParameter("@MFList", txtMFNos.Text.Trim());
        prms[5] = ControllersHelper.GetSqlParameter("@DockList", txtDockNos.Text.Trim());

        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp, prms);
        if (ds.Tables.Count > 0)
        {
            ListData = ds.Tables[0];
        }
        BindGrid();
    }

    private void BindGrid()
    {
        gvResult.DataSource = ListData;
        gvResult.DataBind();
    }
    protected void gvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvResult.DataSource = ListData;
        gvResult.PageIndex = e.NewPageIndex;
        gvResult.DataBind();
    }
}

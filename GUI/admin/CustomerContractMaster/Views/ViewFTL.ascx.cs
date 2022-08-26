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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_CustomerContractMaster_Views_ViewFTL : System.Web.UI.UserControl
{
    public string ContractID { get { return (ViewState["SC_ContractID"] != null) ? ViewState["SC_ContractID"].ToString() : ""; } set { ViewState["SC_ContractID"] = value; } }

    private DataTable dtcharges
    {
        get { return (ViewState["dtcharges"] != null) ? ViewState["dtcharges"] as DataTable : new DataTable(); }
        set { ViewState["dtcharges"] = value; }
    }
    private string[] ftlvalues
    {
        get { return (ViewState["ftlvalues"] != null) ? ViewState["ftlvalues"] as string[] : new string[0]; }
        set { ViewState["ftlvalues"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ucfilter.FlagBasedOn1 = "N";
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
            e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
        }
    }

    protected void grvcharges_PageIndexChanged(object sender, GridViewPageEventArgs e)
    {
        grvcharges.PageIndex = e.NewPageIndex;
        DataBinder();
    }

    protected void lnksubmit_Click(object sender, EventArgs e)
    {
        trheader.Visible = true;
        DataBinder();
    }
    private void DataBinder()
    {
        string sqlstr = "SELECT from_loccode AS 'From',to_loccode AS 'To',";
        sqlstr = sqlstr + "(SELECT codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND codeid=ftltype) AS 'FTL Type',";
        sqlstr = sqlstr + "ftl1_trip_rate AS 'FTL Rate',";
        sqlstr = sqlstr + "(CASE ftl1_trip_ratetype WHEN 'W' THEN 'Per KG' WHEN 'P' THEN 'Per PKG' WHEN 'T' THEN 'Per Ton' WHEN 'F' THEN 'Flat(in Rs)' END ) AS 'Rate Type'";
        sqlstr = sqlstr + " FROM webx_custcontract_frtmatrix_ftlslabhdr";
        sqlstr = sqlstr + " WHERE contractid='" + ContractID + "'";
        sqlstr = sqlstr + " AND PATINDEX('%' + trans_type + '%','" + ucfilter.TransMode + "')>0 AND  PATINDEX('%' + loc_reg + '%','" + ucfilter.MatrixType + "')>0";
        sqlstr = sqlstr + " AND from_loccode LIKE '" + ucfilter.From + "%'";
        sqlstr = sqlstr + " AND to_loccode LIKE '" + ucfilter.To + "%' AND ftltype<>'0' AND ftltype IS NOT NULL";
        sqlstr = sqlstr + " ORDER BY srno";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

        grvcharges.DataSource = dt;
        grvcharges.DataBind();

    }

}

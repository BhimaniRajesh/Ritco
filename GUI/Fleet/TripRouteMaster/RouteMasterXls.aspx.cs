using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ApplicationManager;
using WebX.Entity;
using WebX.Controllers;
using System.Data;

public partial class GUI_Fleet_TripRouteMaster_RouteMasterXls : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                TripRouteMasterController objRouteMaster = new TripRouteMasterController();
                DataTable dtRouteHdrDetails = new DataTable();
                dtRouteHdrDetails = objRouteMaster.getRouteHdrDetails();
                Repeater1.DataSource = dtRouteHdrDetails;
                Repeater1.DataBind();
                ExportToExcel();
            }
            catch (Exception Exc)
            {                                                                                                                                                                                  
                throw Exc;
            }
        }
    }
    decimal totalDistKM = 0;
    decimal totalTRHR = 0;
    decimal totalTRMin = 0;
    decimal totalSTHR = 0;
    decimal totalSTMin = 0;

    protected void gvTripRoute_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();

            oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            oTableCell = new TableCell();

            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Transit Time";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oGridViewRow.Cells.Add(oTableCell);
            // oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Stoppage Time";
            oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totalDistKM += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DIST_KM"));
            totalTRHR += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TRTIME_HR"));
            totalTRMin += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TRTIME_MIN"));
            totalSTHR += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "STTIME_HR"));
            totalSTMin += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "STTIME_MIN"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[2].Text = totalDistKM.ToString();
            e.Row.Cells[3].Text = totalTRHR.ToString();
            e.Row.Cells[4].Text = totalTRMin.ToString();
            e.Row.Cells[5].Text = totalSTHR.ToString();
            e.Row.Cells[6].Text = totalSTMin.ToString();

            totalDistKM = 0;
            totalTRHR = 0;
            totalTRMin = 0;
            totalSTHR = 0;
            totalSTMin = 0;
        } 
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        GridView gvRutDetails = (GridView)e.Item.FindControl("gvRutDetails");
        Label lblRutcd = (Label)e.Item.FindControl("lblRutcd");
        if (gvRutDetails != null)
        {
            TripRouteMasterController objRouteMaster = new TripRouteMasterController();
            DataTable dtRouteDet = new DataTable();
            dtRouteDet = objRouteMaster.getRouteDet(lblRutcd.Text.Trim());
            gvRutDetails.DataSource = dtRouteDet;
            gvRutDetails.DataBind();
        }
    }
    private void ExportToExcel()
    {
        DataExportManager dem = new DataExportManager();
        dem.ExportToExcel(Page, "RouteMaster.xls");
    }
}
using System;
using System.Data;
using System.IO;  
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_CustomerMaster_RouteMasterView : System.Web.UI.Page
{

    #region Variable[s]
    public string routeCode;   
    protected static string boxbg, bgbluegrey;
    #endregion

    #region Event[e]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                hdnflagprint.Value = Convert.ToString(Request.QueryString["print"]);

                if (hdnflagprint.Value.CompareTo("Y") == 0)
                {
                    setBorderWidth();
                    lnkBtnDownloadXLS.Visible = false;
                    lnkBtnPrint.Visible = false;
                    boxbg = "bgwhite";
                    bgbluegrey = "bgwhite";
                    tblMain.BorderWidth = 1;
                    tblMain.BackColor = System.Drawing.Color.Black;
                    trRouteMaster.BackColor = System.Drawing.Color.White;
                    //trGroupCode.BackColor = System.Drawing.Color.White;
                    //trCustomerName.BackColor = System.Drawing.Color.White;
                    //trCustCat.BackColor = System.Drawing.Color.White;
                    //trMobileService.BackColor = System.Drawing.Color.White;              
                    //trLastUpdateBY.BackColor = System.Drawing.Color.White;

                    gvRoutePaid.BorderColor = System.Drawing.Color.Black;
                    gvRoutePaid.Columns[0].HeaderStyle.CssClass = "bgwhite";
                    gvRoutePaid.Columns[1].HeaderStyle.CssClass = "bgwhite";
                    gvRoutePaid.Columns[2].HeaderStyle.CssClass = "bgwhite";
                    gvRoutePaid.Columns[3].HeaderStyle.CssClass = "bgwhite";
                    gvRoutePaid.Columns[4].HeaderStyle.CssClass = "bgwhite";
                    gvRoutePaid.Columns[5].HeaderStyle.CssClass = "bgwhite"; 
                }
                else
                {
                    if (Convert.ToString(Request.QueryString["print"]).CompareTo("N") == 0)
                    {
                        lnkBtnDownloadXLS.Visible = true;
                        lnkBtnPrint.Visible = true;
                        boxbg = "boxbg";
                        bgbluegrey = "bgbluegrey";
                        tblMain.CssClass = "boxbg";
                        trRouteMaster.CssClass = bgbluegrey;
                        gvRoutePaid.CssClass = "boxbg";
                        gvRoutePaid.HeaderStyle.CssClass = "bgbluegrey"; 
                    }
                }

                if (Request.QueryString["routeCode"] != null)
                {                    
                    routeCode = Convert.ToString(Request.QueryString["routeCode"]);
                    getData();               
                }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    {
        try
        {
            setBorderWidth();
            DownloadXLS();
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in download excel file.&detail1=" + Exc.Message.Replace('\n', '_'), true);
        }
        finally
        {
            Response.End();
        }
    }
    protected void gvRoutePaid_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (hdnflagprint.Value.CompareTo("N") == 0)
            {
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

                //oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                //oTableCell.HorizontalAlign = HorizontalAlign.Center;
                //oTableCell.Text = "Route Master Detail";
                //oTableCell.Font.Bold = true;
                //oTableCell.ColumnSpan = 6;
                //oTableCell.CssClass = "blackfnt";               
                //oGridViewRow.Cells.Add(oTableCell);
                //oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);

                oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                
                oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.ColumnSpan = 2; 
                oTableCell.Text = " ";                      
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);                     

                oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.Text = "Transition Time";
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
            }
            else
            {
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

                oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                // oTableCell = new TableCell();

                TableCell oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.Text = " ";
                oTableCell.ColumnSpan = 2; 
                oTableCell.BorderWidth = 1;
                oTableCell.BackColor = System.Drawing.Color.White;
                oTableCell.BorderColor = System.Drawing.Color.Black;
                oTableCell.CssClass = "bgwhite";
                oGridViewRow.Cells.Add(oTableCell);             

                oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.Text = "Transition Time";
                oTableCell.ColumnSpan = 2;
                oTableCell.BorderWidth = 1;
                oTableCell.BackColor = System.Drawing.Color.White;
                // oTableCell.BorderColor = System.Drawing.Color.Black;
                oTableCell.CssClass = "bgwhite";
                oTableCell.Font.Bold = true;
                oGridViewRow.Cells.Add(oTableCell);
                // oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);

                oTableCell = new TableCell();
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.Text = "Stoppage Time";
                oTableCell.BorderWidth = 1;
                oTableCell.BackColor = System.Drawing.Color.White;
                // oTableCell.BorderColor = System.Drawing.Color.Black;
                oTableCell.Font.Bold = true;
                oTableCell.ColumnSpan = 2;
                oTableCell.CssClass = "bgwhite";
                oGridViewRow.Cells.Add(oTableCell);
                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            }
        }
    }
    #endregion

    #region Private Function[s]
    public void getData()
    {
        try
        {
            TripRouteMasterController objRouteMaster = new TripRouteMasterController();
            DataTable dtRouteMaster = new DataTable();
            DataTable dtRouteTranMaster = new DataTable();


            if (!string.IsNullOrEmpty(routeCode))
            {
                dtRouteMaster = objRouteMaster.getCityRouteByRouteCode(routeCode);
                dtRouteTranMaster = objRouteMaster.getRouteTransitionByRouteCode(routeCode);
            }

            if (dtRouteMaster != null && dtRouteMaster.Rows.Count > 0)
            {
                lblRouteCode.Text = Convert.ToString(dtRouteMaster.Rows[0]["RUTCD"]);         
              
                if(Convert.ToString(dtRouteMaster.Rows[0]["RUTMOD"]) == "S")
                {
                    lblRouteMode.Text = "Road";
                }
                else if(Convert.ToString(dtRouteMaster.Rows[0]["RUTMOD"]) == "R")
                {
                    lblRouteMode.Text = "Rail";
                }
                else
                {   // For A
                    lblRouteMode.Text = "Air";
                }            

                if(Convert.ToString(dtRouteMaster.Rows[0]["RUTCAT"]) == "L")
                {
                    //lblRouteCategory.Text = "Long Haul";
                }               
                else
                {   // For S
                    //lblRouteCategory.Text = "Short Haul";
                }
                lblRouteDistance.Text = Convert.ToString(dtRouteMaster.Rows[0]["RUTKM"]) + " / " + Convert.ToString(dtRouteMaster.Rows[0]["TransHrs"]);  
                lblRouteDepartureTime.Text = Convert.ToString(dtRouteMaster.Rows[0]["SCHDEP_HR"]) + " : " + Convert.ToString(dtRouteMaster.Rows[0]["SCHDEP_MIN"]);
                lblStandardRate.Text = Convert.ToString(dtRouteMaster.Rows[0]["STD_CONTAMT"]);

                lblLocation.Text = Convert.ToString(dtRouteMaster.Rows[0]["ControlLoc"]);
                lblActiveFlag.Text = Convert.ToString(dtRouteMaster.Rows[0]["ACTIVEFLAG"]);             
                lblLastUpdateBy.Text = Convert.ToString(dtRouteMaster.Rows[0]["UPDTBY"]);                

                if (!string.IsNullOrEmpty(Convert.ToString(dtRouteMaster.Rows[0]["UPDTON"])))
                {
                    if (DateTime.Compare(Convert.ToDateTime(dtRouteMaster.Rows[0]["UPDTON"]), DateTime.MinValue.AddYears(1754)) != 0)
                        lblLastUpdateDate.Text = dtRouteMaster.Rows[0]["UPDTON"] != null ? Convert.ToDateTime(dtRouteMaster.Rows[0]["UPDTON"].ToString()).ToString("dd/MM/yyyy") : "";

                }                             
            }

            if (dtRouteTranMaster != null && dtRouteTranMaster.Rows.Count > 0)
            {
                gvRoutePaid.DataSource = dtRouteTranMaster;
                gvRoutePaid.DataBind();
            }

        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void setBorderWidth()
    {
        tdRouteMaster.BorderWidth = 1;
        tdGroupCode.BorderWidth = 1;
        tdlblGroupCode.BorderWidth = 1;
        tdCustCode.BorderWidth = 1;
        tdlblCustCode.BorderWidth = 1;
        //tdCustomerName.BorderWidth = 1;
        //tdlblCustomerName.BorderWidth = 1;
        tdSvcOptFor.BorderWidth = 1;
        tdlblSvcOptFor.BorderWidth = 1;
        tdCustCat.BorderWidth = 1;
        tdlblCustCat.BorderWidth = 1;
        tdActiveFlag.BorderWidth = 1;
        tdlblActiveFlag.BorderWidth = 1;
        tdMobileService.BorderWidth = 1;
        tdlblMobileService.BorderWidth = 1;
        tdMobileNo.BorderWidth = 1;
        tdlblMobileNo.BorderWidth = 1;      
        tdLastUpdateBY.BorderWidth = 1;
        tdlblLastUpdateBY.BorderWidth = 1;
        tdLastUpdateDate.BorderWidth = 1;
        tdlblLastUpdateDate.BorderWidth = 1;
        gvRoutePaid.Columns[0].HeaderStyle.BorderWidth = 1;
        gvRoutePaid.Columns[1].HeaderStyle.BorderWidth = 1;
        gvRoutePaid.Columns[2].HeaderStyle.BorderWidth = 1;
        gvRoutePaid.Columns[3].HeaderStyle.BorderWidth = 1;
        gvRoutePaid.Columns[4].HeaderStyle.BorderWidth = 1;
        gvRoutePaid.Columns[5].HeaderStyle.BorderWidth = 1;
        gvRoutePaid.Columns[0].ItemStyle.BorderWidth = 1;
        gvRoutePaid.Columns[1].ItemStyle.BorderWidth = 1;
        gvRoutePaid.Columns[2].ItemStyle.BorderWidth = 1;
        gvRoutePaid.Columns[3].ItemStyle.BorderWidth = 1;
        gvRoutePaid.Columns[4].ItemStyle.BorderWidth = 1;
        gvRoutePaid.Columns[5].ItemStyle.BorderWidth = 1;
        gvRoutePaid.CellSpacing = 0; 
    }
    private void DownloadXLS()
    {
        try
        {
            //export to excel
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Request.QueryString["routeCode"]) + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            frm.Controls.Add(tblMain);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}

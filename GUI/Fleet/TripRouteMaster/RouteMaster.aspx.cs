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

using WebX.Entity;
using WebX.Controllers; 

public partial class GUI_admin_TripRouteMaster : System.Web.UI.Page
{
    #region Variable[s]
    bool isEdit = false;
    string ErrorMsg;
    string routeCode;
    //public static 
    string strRutCd;
    static DataTable dtRouteTranMaster = new DataTable();
    DataRow drow;
    decimal tranHH = 0.0M, tranMM = 0.0M, stopHH = 0.0M, stopMM = 0.0M, DisTot = 0.0M;
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           
            if (!IsPostBack)
            {
                if (Request.QueryString["Flag"] == "Edit")
                {
                    isEdit = true;
                    routeCode = Request.QueryString["routeCode"].ToString();
                    addRows(0, true);
                }
                else
                {
                    routeCode = "";
                    dtRouteTranMaster.Rows.Clear();
                    //addRows(1, false);
                }
                txtRouteDesc.Attributes.Add("OnFocus", "javascript:document.getElementById('" + ddlRouteMode.ClientID.ToString() + "').focus();");
            }
            txtDistance.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtCity.ClientID.ToString() + "').focus();");
            txttransithrs.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtCity.ClientID.ToString() + "').focus();");
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    //protected DataTable GetRouteTable()
    //{
    //    DataTable dt = new DataTable();
    //    return dt;
    //}
    protected void CmdAddRows_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(TxtRows.Text))
        {
            if (Convert.ToInt32(TxtRows.Text) > 0)
            {
                Int32 i;

                if (!isEdit)
                    dtRouteTranMaster.Rows.Clear();

                if (dtRouteTranMaster != null)
                {
                    i = Convert.ToInt32(TxtRows.Text);

                    for (Int32 j = i; j > 0; j--)
                    {
                        drow = dtRouteTranMaster.NewRow();
                        dtRouteTranMaster.Rows.Add(drow);
                    }
                }
                gvTripRoute.DataSource = dtRouteTranMaster;
                gvTripRoute.DataBind();
                //txtRouteDesc.Text = "";
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["Flag"].ToString() == "Edit")
        {
            isEdit = true;
            routeCode = Request.QueryString["routeCode"].ToString();
        }
        decimal routeTotalKM = 0.0M;
        decimal routeTransitionH = 0.0M, routeTransitionM = 0.0M;
        string nextRouteCode = string.Empty, RouteName = string.Empty;
        Int32 cnt = 0;
        TripRouteMasterController objRouteMaster = new TripRouteMasterController();
        TripRouteMaster objectRouteMaster = new TripRouteMaster();
        //HiddenField hdfRutNo;

        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {
                int a = gvTripRoute.Rows.Count;
 

                foreach (GridViewRow gridrow in gvTripRoute.Rows)
                {
                    HiddenField hdfRutCode = (HiddenField)gridrow.FindControl("hdfRutCode");
                    HiddenField hdfRutNo = (HiddenField)gridrow.FindControl("hdfRutNo");
                    routeCode = hdfRutCode.Value;
                    lblRouteCode.Text = hdfRutCode.Value; 
                    if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
                    {
                        //routeCode = getNextRouteCode("R");



                        TextBox txtGvDistance = (TextBox)gridrow.FindControl("txtdistance");
                        TextBox txtttimehr = (TextBox)gridrow.FindControl("txtttimehr");
                        TextBox txtttimemn = (TextBox)gridrow.FindControl("txtttimemn");
                        TextBox txtstimehr = (TextBox)gridrow.FindControl("txtstimehr");
                        TextBox txtstimemn = (TextBox)gridrow.FindControl("txtstimemn");
                        TextBox txtbranchname = (TextBox)gridrow.FindControl("txtbranchname");
                        DropDownList ddlOnwardReturn = (DropDownList)gridrow.FindControl("ddlOnwardReturn");
                        // Transition Time Hour
                        if (!string.IsNullOrEmpty(txtttimehr.Text))
                        {
                            routeTransitionH = routeTransitionH + Convert.ToDecimal(txtttimehr.Text);
                        }

                        // Stoppage Time Hour
                        if (!string.IsNullOrEmpty(txtstimehr.Text))
                        {
                            routeTransitionH = routeTransitionH + Convert.ToDecimal(txtstimehr.Text);
                        }

                        // Transition Time Minutes
                        if (!string.IsNullOrEmpty(txtttimemn.Text))
                        {
                            routeTransitionM = routeTransitionM + Convert.ToDecimal(txtttimemn.Text);
                        }

                        // Stoppage Time Minutes
                        if (!string.IsNullOrEmpty(txtstimemn.Text))
                        {
                            routeTransitionM = routeTransitionM + Convert.ToDecimal(txtstimemn.Text);
                        }

                        // Total Distance
                        if (!string.IsNullOrEmpty(txtGvDistance.Text))
                        {
                            routeTotalKM = routeTotalKM + Convert.ToInt32(txtGvDistance.Text);
                        }

                        // Converting total minutes into hours.
                        routeTransitionM = Math.Round(routeTransitionM / 60);

                        routeTransitionH = routeTransitionH + routeTransitionM;

                        if (!string.IsNullOrEmpty(txtbranchname.Text))
                        {
                            cnt += 1;

                            if (string.IsNullOrEmpty(RouteName))
                                RouteName = txtbranchname.Text;
                            else
                                RouteName = RouteName + "~" + txtbranchname.Text;
                            
                            objectRouteMaster.RouteNumber = cnt;
                            objectRouteMaster.RouteCode = routeCode;
                            objectRouteMaster.LocationCode = txtbranchname.Text;
                            objectRouteMaster.Distance = txtGvDistance.Text != "" ? Convert.ToDecimal(txtGvDistance.Text) : 0;
                            objectRouteMaster.TRTIME_HR = txtttimehr.Text;
                            objectRouteMaster.TRTIME_MIN = txtttimemn.Text;
                            objectRouteMaster.STTIME_HR = txtstimehr.Text;
                            objectRouteMaster.STTIME_MIN = txtstimemn.Text;
                            objectRouteMaster.ONW_RET = ddlOnwardReturn.SelectedItem.Text.ToString();

                            if (isEdit)
                            {
                                //if (!string.IsNullOrEmpty(hdfRutNo.Value))
                                if (hdfRutNo.Value != "")
                                {
                                    objectRouteMaster.RouteCode = hdfRutCode.Value;   // lblRouteCode.Text.ToString();
                                    objectRouteMaster.RUTDESC = txtRouteDesc.Text;
                                    if (chkRoundTrip.Checked == true) { objectRouteMaster.ROUND_TRIP = "Y"; } else { objectRouteMaster.ROUND_TRIP = "N"; }
                                    objectRouteMaster.RouteNumber = Convert.ToInt32(hdfRutNo.Value);
                                    objRouteMaster.updateRouteMasterCity(objectRouteMaster, "N");
                                }
                                else
                                {
                                    objectRouteMaster.RouteCode = lblRouteCode.Text.ToString();
                                    objRouteMaster.insertRouteMasterCity(objectRouteMaster, "N");
                                    //objRouteMaster.updateRouteMasterCity(objectRouteMaster, "N");
                                }
                            }
                            else
                            {
                                objRouteMaster.insertRouteMasterCity(objectRouteMaster, "N");
                            }
                        }
                    }
                    else
                    {
                        // if edit row and if not checked delete from database
                        if (!string.IsNullOrEmpty(hdfRutNo.Value))
                        {
                            objRouteMaster.deleteCityRouteMaster(Convert.ToInt32(routeCode), lblRouteCode.Text.ToString());
                        }
                    }
                }

                Array arrRoute;
                arrRoute = RouteName.Split('~');
                String RUTSTBR = ((string[])(arrRoute))[0];
                String RUTENDBR = ((string[])(arrRoute))[arrRoute.Length - 1];

                objectRouteMaster.RouteStBranch = RUTSTBR;
                objectRouteMaster.RouteEdBranch = RUTENDBR;
                objectRouteMaster.RouteCategory = "";// ddlRouteCategory.SelectedValue;
                objectRouteMaster.RouteKM = routeTotalKM;
                // objectRouteMaster.RouteKM = txtDistance.Text != "" ? Convert.ToInt32(txtDistance.Text) : routeTotalKM;  
                objectRouteMaster.ActiveFlag = chkActiveFlag.Checked == true ? "Y" : "N";
                objectRouteMaster.RouteName = RouteName.Trim();
                objectRouteMaster.RouteSchDepHour = txtSchHH.Text != "" ? Convert.ToDecimal(txtSchHH.Text) : 0;
                objectRouteMaster.RouteSchDepMin = txtSchMM.Text != "" ? Convert.ToDecimal(txtSchMM.Text) : 0;
                objectRouteMaster.STD_CONTAMT = Convert.ToDecimal("0");
                //objectRouteMaster.STD_CONTAMT = txtStandRate.Text != "" ? Convert.ToDecimal(txtStandRate.Text) : 0;
                objectRouteMaster.RouteMode = ddlRouteMode.Text;
                objectRouteMaster.ControlLocation = txtCity.Text;
                //objectRouteMaster.TransitionHour = routeTransitionH;

                objectRouteMaster.TransitionHour = txttransithrs.Text != "" ? Convert.ToDecimal(txttransithrs.Text) : 0;

                objectRouteMaster.RUTDESC = txtRouteDesc.Text;
                if (chkRoundTrip.Checked == true) { objectRouteMaster.ROUND_TRIP = "Y"; } else { objectRouteMaster.ROUND_TRIP = "N"; }
                //objectRouteMaster.TransitionHour = txttransithrs.Text != "" ? Convert.ToDecimal(Decimal.Round(Convert.ToDecimal(txttransithrs.Text),2)) : routeTransitionH;  
                //objectRouteMaster.TransitionHour = Convert.ToDecimal("0");

                try
                {
                    objectRouteMaster.UpdateBy = SessionUtilities.CurrentBranchCode.ToString().Trim();
                }
                catch (Exception Ex)
                {
                    Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
                }

                if (Request.QueryString["Flag"].ToString() == "Edit")
                {

                    objectRouteMaster.UpdateOnDate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy"));
                }
                else
                {
                    objectRouteMaster.UpdateOnDate = DateTime.MinValue.AddYears(1754);
                }

                if (isEdit)
                {
                    objectRouteMaster.RouteCode =  lblRouteCode.Text.Trim().ToString();
                    objRouteMaster.updateRouteMasterCity(objectRouteMaster, "Y");
                    Response.Redirect("RouteMasterDone.aspx?Flag=Edit&routeCode=" + lblRouteCode.Text.Trim().ToString(), false);
                }
                else
                {
                    
                    objRouteMaster.insertRouteMasterCity(objectRouteMaster, "Y");
                    routeCode = objRouteMaster.GetLastRoucdCode();
                    Response.Redirect("RouteMasterDone.aspx?Flag=Add&routeCode=" + routeCode, false);
                }
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
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
    }
    protected void gvTripRoute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowIndex == 0)
            {
                CheckBox c1;
                c1 = (CheckBox)e.Row.FindControl("chkSelect");
                c1.Checked = true;
                c1.Enabled = false;
                TextBox t0, t1, t2, t3, t4;
                t0 = (TextBox)e.Row.FindControl("txtdistance");
                t1 = (TextBox)e.Row.FindControl("txtttimehr");
                t2 = (TextBox)e.Row.FindControl("txtttimemn");
                t3 = (TextBox)e.Row.FindControl("txtstimehr");
                t4 = (TextBox)e.Row.FindControl("txtstimemn");
                t0.Text = "0";
                t1.Text = "0";
                t2.Text = "0";
                t3.Text = "0";
                t4.Text = "0";
                t0.ReadOnly = true;
                t1.ReadOnly = true;
                t2.ReadOnly = true;
                t3.ReadOnly = true;
                t4.ReadOnly = true;              
            }

            CheckBox c2;
            c2 = (CheckBox)e.Row.FindControl("chkSelect");
            c2.Checked = true;

            HiddenField hdfRutNo = (HiddenField)e.Row.FindControl("hdfRutNo");
            HiddenField hdfRutCode = (HiddenField)e.Row.FindControl("hdfRutCode");
            
            ((CheckBox)e.Row.FindControl("chkSelect")).Attributes.Add("onclick", ""
                + "totalDistance(),totalHour(),footerTotal(),"
                + "checkDuplicate(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + "," + chkRoundTrip.ClientID + ")");
            
            ((TextBox)e.Row.FindControl("txtbranchname")).Attributes.Add("onblur", ""
                + "checkCity(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + ", 'FALSE');"
                + "checkDuplicate(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + "," + chkRoundTrip.ClientID + ");"
                + "FillRouteDesc(" + ((TextBox)e.Row.FindControl("txtbranchname")).ClientID + "," + txtRouteDesc.ClientID + ")");

            ((TextBox)e.Row.FindControl("txtdistance")).Attributes.Add("onblur", ""
                + "checkDecimal(" + ((TextBox)e.Row.FindControl("txtdistance")).ClientID + ");"
                + "footerTotal()");
            

            //////////////////// FOOTER ROWS  /////////////////////////////////////////////////////
            ((TextBox)e.Row.FindControl("txtttimehr")).Attributes.Add("onblur", ""
                + "checkDecimal(" + ((TextBox)e.Row.FindControl("txtttimehr")).ClientID + ");"
                + "totalHour();footerTotal()");
            
            ((TextBox)e.Row.FindControl("txtttimemn")).Attributes.Add("onblur", ""
                + "checkDecimal(" + ((TextBox)e.Row.FindControl("txtttimemn")).ClientID + ");"
                + "footerTotal();totalHour()");

            ((TextBox)e.Row.FindControl("txtstimehr")).Attributes.Add("onblur", ""
                + "checkDecimal(" + ((TextBox)e.Row.FindControl("txtstimehr")).ClientID + ");"
                + "footerTotal();totalHour()");

            ((TextBox)e.Row.FindControl("txtstimemn")).Attributes.Add("onblur", ""
                + "checkDecimal(" + ((TextBox)e.Row.FindControl("txtstimemn")).ClientID + ");"
                + "footerTotal();totalHour()");



            if (isEdit)
            {
                if (dtRouteTranMaster.Rows[e.Row.RowIndex]["RUTNO"] != System.DBNull.Value)
                {
                    hdfRutCode.Value = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["RUTCD"]);
                    hdfRutNo.Value = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["RUTNO"]);
                    tranHH = tranHH + Convert.ToDecimal(dtRouteTranMaster.Rows[e.Row.RowIndex]["TRTIME_HR"]);
                    tranMM = tranMM + Convert.ToDecimal(dtRouteTranMaster.Rows[e.Row.RowIndex]["TRTIME_MIN"]);
                    stopHH = stopHH + Convert.ToDecimal(dtRouteTranMaster.Rows[e.Row.RowIndex]["STTIME_HR"]);
                    stopMM = stopMM + Convert.ToDecimal(dtRouteTranMaster.Rows[e.Row.RowIndex]["STTIME_MIN"]);
                    DisTot = DisTot + Convert.ToDecimal(dtRouteTranMaster.Rows[e.Row.RowIndex]["DIST_KM"]);


                    //string strLocName = "SELECT LOCNAME FROM WEBX_LOCATIONS WHERE LOC_CODE='" + Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["LOCCD"]);
                    TripRouteMasterController objRouteMaster = new TripRouteMasterController();

                    //objRouteMaster.getLocName(Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["LOCCD"]));

                    //((TextBox)e.Row.FindControl("txtbranchname")).Text = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["LOCCD"]);
                    ((TextBox)e.Row.FindControl("txtbranchname")).Text = objRouteMaster.getLocName(Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["LOCCD"]));

                    ((TextBox)e.Row.FindControl("txtdistance")).Text = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["DIST_KM"]);
                    ((TextBox)e.Row.FindControl("txtttimehr")).Text = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["TRTIME_HR"]);
                    ((TextBox)e.Row.FindControl("txtttimemn")).Text = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["TRTIME_MIN"]);
                    ((TextBox)e.Row.FindControl("txtstimehr")).Text = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["STTIME_HR"]);
                    ((TextBox)e.Row.FindControl("txtstimemn")).Text = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["STTIME_MIN"]);
                    ((DropDownList)e.Row.FindControl("ddlOnwardReturn")).SelectedValue = Convert.ToString(dtRouteTranMaster.Rows[e.Row.RowIndex]["ONW_RET"]);
                }
            }
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            if (isEdit)
            {
                ((TextBox)e.Row.FindControl("txtthtotal")).Text = Convert.ToString(tranHH);
                ((TextBox)e.Row.FindControl("txttmtotal")).Text = Convert.ToString(tranMM);
                ((TextBox)e.Row.FindControl("txtshtotal")).Text = Convert.ToString(stopHH);
                ((TextBox)e.Row.FindControl("txtsmtotal")).Text = Convert.ToString(stopMM);
                ((TextBox)e.Row.FindControl("txtDistTotal")).Text = Convert.ToString(DisTot);
            }
        }
    }
    #endregion

    #region Private Function[s]
    private void addRows(int numRows, bool isEdit)
    {
        try
        {
            if (isEdit)
                getData();

            for (int i = 0; i < numRows; i++)
            {
                dtRouteTranMaster.Rows.Add();
            }

            gvTripRoute.DataSource = dtRouteTranMaster;
            gvTripRoute.DataBind();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void Validation()
    {
        string RouteName = string.Empty;
        ErrorMsg = string.Empty;

        try
        {
            if (string.IsNullOrEmpty(txtSchHH.Text))
            {
                ErrorMsg = "Please Enter Valid Hour.";
                return;
            }

            if (string.IsNullOrEmpty(txtSchMM.Text))
            {
                ErrorMsg = "Please Enter Valid Minutes.";
                return;
            }

            //if (string.IsNullOrEmpty(txtStandRate.Text))
            //{
            //    ErrorMsg = "Please Enter Valid Standard Rate.";
            //    return;
            //}

            if (string.IsNullOrEmpty(txtCity.Text))
            {
                ErrorMsg = "Please Enter Valid Location.";
                return;
            }
            else
            {
                // pls take active city after complete 
                if (!TripRouteValidations.IsValidLocaton(txtCity.Text.Trim()))
                {
                    ErrorMsg = "Please enter active City.";
                    return;
                }
            }

            foreach (GridViewRow gridrow in gvTripRoute.Rows)
            {
                if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
                {
                    TextBox txtbranchname = (TextBox)gridrow.FindControl("txtbranchname");

                    if (!string.IsNullOrEmpty(txtbranchname.Text))
                    {
                        if (!TripRouteValidations.IsValidCity(txtbranchname.Text.Trim()))
                        {
                            ErrorMsg = "Please enter active city " + txtbranchname.Text;
                            return;
                        }

                        if (string.IsNullOrEmpty(RouteName))
                            RouteName = txtbranchname.Text;
                        else
                            RouteName = RouteName + "~" + txtbranchname.Text;
                    }
                }
            }

            if (!isEdit)
            {
                if (TripRouteValidations.IsValidRouteName(RouteName, ddlRouteMode.Text))
                {
                    ErrorMsg = "City based Route Already Exists.";
                    return;
                }
            }

        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    public void getData()
    {
        try
        {
            TripRouteMasterController objRouteMaster = new TripRouteMasterController();
            DataTable dtRouteMaster = new DataTable();

            if (!string.IsNullOrEmpty(routeCode))
            {
                dtRouteMaster = objRouteMaster.getCityRouteByRouteCode(routeCode);
                dtRouteTranMaster = objRouteMaster.getRouteTransitionByRouteCode(routeCode);
            }

            if (dtRouteMaster != null && dtRouteMaster.Rows.Count > 0)
            {
                lblRouteCode.Text = Convert.ToString(dtRouteMaster.Rows[0]["RUTCD"]);

                ddlRouteMode.SelectedValue = Convert.ToString(dtRouteMaster.Rows[0]["RUTMOD"]);
                //ddlRouteCategory.SelectedValue = Convert.ToString(dtRouteMaster.Rows[0]["RUTCAT"]);

                txtDistance.Text = Convert.ToString(dtRouteMaster.Rows[0]["RUTKM"]);
                txttransithrs.Text = Convert.ToString(dtRouteMaster.Rows[0]["TransHrs"]);

                txtSchHH.Text = Convert.ToString(dtRouteMaster.Rows[0]["SCHDEP_HR"]);
                txtSchMM.Text = Convert.ToString(dtRouteMaster.Rows[0]["SCHDEP_MIN"]);
                //txtStandRate.Text = Convert.ToString(dtRouteMaster.Rows[0]["STD_CONTAMT"]);
                txtCity.Text = Convert.ToString(dtRouteMaster.Rows[0]["ControlLoc"]);

                txtRouteDesc.Text = Convert.ToString(dtRouteMaster.Rows[0]["RUTDESC"]);
                if (Convert.ToString(dtRouteMaster.Rows[0]["ROUND_TRIP"]) == "Y")
                {
                    chkRoundTrip.Checked = true;
                }
                else
                {
                    chkRoundTrip.Checked = false;
                }
                if (Convert.ToString(dtRouteMaster.Rows[0]["ACTIVEFLAG"]) == "Y")
                {
                    chkActiveFlag.Checked = true;
                }
                else
                {
                    chkActiveFlag.Checked = false;
                }
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    public string getNextRouteCode(string strRouteCategory)
    {
        TripRouteMasterController objTripRouteMaster = new TripRouteMasterController();
        int intRouteCode = 1;

        try
        {
            intRouteCode = objTripRouteMaster.getNextRouteCode(strRouteCategory);
            return strRouteCategory + intRouteCode.ToString().PadLeft(4, '0');
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}


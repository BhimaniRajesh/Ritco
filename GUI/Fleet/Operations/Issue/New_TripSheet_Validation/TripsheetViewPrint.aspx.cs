using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using WebX.Controllers;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripsheetViewPrint : System.Web.UI.Page
{
    string VSlipNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        VSlipNo = Request.QueryString["VSlipNo"].ToString();

        if (!IsPostBack)
        {
            umsg.Hide();
            ShowData();
        }
    }
    protected void ShowData()
    {
        var  obj = new TripSubmissionOperationFinancialClosureController();
        DataSet ds = obj.GetTripsheetViewPrint(Request.QueryString["VSlipNo"].ToString());

        
        var dtHeaderDetail = new DataTable();
        dtHeaderDetail = ds.Tables[0];

        if (dtHeaderDetail.Rows.Count > 0)
        {
            DataRow dr = dtHeaderDetail.Rows[0];
            lblTripSheetNo.Text = dr["vslipNo"].ToString();
            lblControlBranch.Text = dr["tripsheet_startLoc"].ToString();
            lblRouteTp.Text = dr["Trip_Route_Type_Desc"].ToString();
            lblRouteTypeDetail.Text = dr["route"].ToString();
            lblManualTripSheetNo.Text = dr["manual_tripsheetno"].ToString();

            lblTripSheetDate.Text = dr["start_Dt_tm"].ToString();
            lblVehicleNo.Text = dr["vehicleno"].ToString();
            lblDriverName1.Text = dr["Driver_Name"].ToString();
            lblTripEndDate.Text = dr["end_dt_tm"].ToString();
            lblVehicleType.Text = dr["Type_name"].ToString();
            txtTripEndKm.Text = dr["f_closure_closekm"].ToString();
            lblTripStartKm.Text = dr["f_issue_startkm"].ToString();
            lblVehicleCapacity.Text = dr["Capacity"].ToString();
            lblTotalTripKm.Text = dr["TotalKM"].ToString();
            lblEntryBy.Text = dr["Entryby"].ToString();
            lblEntryDateTime.Text = dr["Entrydt"].ToString();

            lblTotalCash.Text = dr["TotalCash"].ToString();
            lblTotalDiesel.Text = dr["TotalDieselAmt"].ToString();
            lblTotalDieselLtr.Text = dr["TotalDieselLtr"].ToString();
            lblTotalAddBlue.Text = dr["TotalAddBlueAmt"].ToString();
            lblTotalAddBlueLtr.Text = dr["TotalAddBlueLtr"].ToString();
            lblTotalCNG.Text = dr["TotalCNGAmt"].ToString();
            lblTotalCNGLtr.Text = dr["TotalCNGLtr"].ToString();
            lblTotalAdvance.Text = dr["TotalDriverAdvance"].ToString();
            lblCheckList.Text = dr["CheckListFile"].ToString();
            lblDriverSettle.Text = (dr["DriverSettle"].ToString() == "0" ? "Pending" : "Done");
            if (dr["DriverSettle"].ToString() == "0")
                lblDriverSettle.Style.Remove("text-decoration");
            lblDriverSettle.Enabled = (dr["DriverSettle"].ToString() != "0");
        }

        var dtCreditFuel = new DataTable();
        dtCreditFuel = ds.Tables[1];
        grdCreditFuel.DataSource = dtCreditFuel;
        grdCreditFuel.DataBind();

        var dtFuelCard = new DataTable();
        dtFuelCard = ds.Tables[2];
        grdFuelCardDetails.DataSource = dtFuelCard;
        grdFuelCardDetails.DataBind();


        var dtDriverAdvance = new DataTable();
        dtDriverAdvance = ds.Tables[3];
        grdDriverAdvance.DataSource = dtDriverAdvance;
        grdDriverAdvance.DataBind();

        var dtThc = new DataTable();
        dtThc = ds.Tables[4];
        dgExternalThc.DataSource = dtThc;
        dgExternalThc.DataBind();

        var dtTollDetail = new DataTable();
        dtTollDetail = ds.Tables[5];

        if (dtTollDetail.Rows.Count > 0)
        {
            DataRow dr = dtTollDetail.Rows[0];
            lblByCard.Text = dr["ByCard"].ToString();
            hdnTollDocument.Value = dr["TollFileDocument"].ToString();
			lblByCash.Text = dr["ByCash"].ToString();

            lblFuelCardNo.Text = dr["FuelCardNo"].ToString();
            lblLastRefNo.Text = dr["LastRefNo"].ToString();
            lblLastDate.Text = dr["LastDate"].ToString();
            lblThisRefNo.Text = dr["ThisRefNo"].ToString();
            lblThisDate.Text = dr["ThisDate"].ToString();
            lblToll_ByCard.Text = dr["ByCard"].ToString();
            lblToll_ByCash.Text = dr["ByCash"].ToString();
            lblToll_Total.Text = dr["Total"].ToString();
        }

        var dtCashfuel = new DataTable();
        dtCashfuel = ds.Tables[6];
        gvCashFuel.DataSource = dtCashfuel;
        gvCashFuel.DataBind();
    }


    protected void DownloadFile(object sender, EventArgs e)
    {
        try
        {
            string filePath = (sender as LinkButton).CommandArgument;
            string filePaths = Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages/Ritco" + "//" + filePath);
            if (File.Exists(filePaths))
            {
                Response.ContentType = ContentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePaths));
                Response.WriteFile(filePaths);
                Response.End();
            }
            else
            {
                umsg.Show("File Not Found OR Not Uploaded !!");
                return;
            }
        }
        catch (Exception ex) {
            umsg.Show("POD Not Available !!");
            return;
        } 
    }
}
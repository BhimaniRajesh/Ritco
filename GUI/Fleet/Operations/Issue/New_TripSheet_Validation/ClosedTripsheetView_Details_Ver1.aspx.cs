using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_ClosedTripsheetView_Details_Ver1 : BasePage
{
    string VSlipNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        VSlipNo = Request.QueryString["VSlipNo"].ToString();
        if (!IsPostBack)
        {
            ShowData();
        }
    }
    protected void ShowData()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmdTrip = new SqlCommand("usp_ClosedTripsheetView_GetDetails", con);
        cmdTrip.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpTrip = new SqlDataAdapter(cmdTrip);
        cmdTrip.Parameters.AddWithValue("@TripsheetNo", VSlipNo);
        DataSet dsTrip = new DataSet();
        adpTrip.Fill(dsTrip);



        if (dsTrip.Tables[0].Rows.Count > 0)
        {
            DataRow dr = dsTrip.Tables[0].Rows[0];
            lblTripsheetNo.Text = dr["VSlipNo"].ToString();
            lblTotDiesel.Text = dr["TotalDieselCredit"].ToString();
            lblOpenDate.Text = dr["StartDate"].ToString();
            lblSubmittedDate.Text = dr["SubmissionDate"].ToString();
            //lblCashAdv.Text = dr["AdvAmt"].ToString();
            lblFinCloseDate.Text = dr["EndDate"].ToString();
            //lblTotAdvance.Text = dr["TotalAdvAmt"].ToString();
            lblOperCloseDate.Text = dr["Oper_Close_Dt"].ToString();
            //lblExpApproved.Text = dr["ExpApproved"].ToString();
            lblApprovedDt.Text = dr["isApprovedDate"].ToString();
            lblDieselApproved.Text = dr["DieselApproved"].ToString() + " Ltrs.";
            lblVehicleNo.Text = dr["VehicleNo"].ToString();
            lblDieselCF.Text = dr["ApprovedFuel_CF"].ToString();
            lblCashCF.Text = dr["DriverBalCF"].ToString();
            lblCashBF.Text = dr["DriverBalBF"].ToString();
            lblDieselBF.Text = dr["ApprovedFuel_BF"].ToString();
            //lblManualTripNo.Text = dr["Manual_TripSheetNo"].ToString();
            //lblDriverBalCF.Text = dr["DriverBalCF"].ToString();
            lblControllingBranch.Text = dr["TripSheet_StartLoc"].ToString();
            //lblBalPaid.Text = dr["BalPaid"].ToString();
            lblRouteOperated.Text = dr["RouteOperated"].ToString();
            //lblVoucherNo.Text = dr["VoucherNo"].ToString();
            //lblDate.Text = dr["VoucherDate"].ToString();
            lblDriverName.Text = dr["Driver_Name"].ToString();
            lblOpenKms.Text = dr["f_Issue_StartKm"].ToString();
            lblCloseKms.Text = dr["f_Closure_CloseKm"].ToString();
            lblDistance.Text = dr["Distance"].ToString();

            lblFuelEconomy.Text = dr["FuelEconomy"].ToString();
            lblAddBlueRatio.Text = dr["AddBlueRatio"].ToString();
            lblDieselAmount.Text = dr["DieselAmount"].ToString();
            lblEnrouteAmount.Text = dr["EnrouteAmount"].ToString();
            lblPerKMExpense.Text = dr["PerKMExpense"].ToString();
            lblDriverSettelement.Text = dr["DriverSettlement"].ToString();

            lblFixedExpenseTypre.Text = dr["FixedTyre"].ToString();
            lblFixedExpenseAMC.Text = dr["FixedAMC"].ToString();
            lblFixedExpenseDocument.Text = dr["FixedDocument"].ToString();
            lblFixedExpenseOtherI.Text = dr["FixedOtherI"].ToString();
            lblFixedExpenseOtherII.Text = dr["FixedOtherII"].ToString();

            lblTotalExpense.Text = (Convert.ToDecimal(dr["TotalExpense"].ToString())).ToString();
            lblTotalExpensePerKM.Text = Convert.ToDecimal(dr["Distance"].ToString()) == 0 ? "0".ToString() : Math.Round(Convert.ToDecimal(((Convert.ToDecimal(dr["TotalExpense"].ToString())) / Convert.ToDecimal(dr["Distance"].ToString())).ToString()), 2).ToString();
            lblTotalRevenue.Text = dr["TotalRevenue"].ToString();
            lblTotalRevenuePerKM.Text = dr["TotalRevenuePerKm"].ToString();
            lblTotalIncome.Text = dr["TotalIncome"].ToString();
            lblTotalIncomePerKm.Text = dr["TotalIncomePerKm"].ToString();


        }

        grdDetention.DataSource = dsTrip.Tables[1];
        grdDetention.DataBind();

        dgExternalThc.DataSource = dsTrip.Tables[2];
        dgExternalThc.DataBind();

        con.Close();
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
        catch (Exception ex)
        {
            return;
        }
    }
}
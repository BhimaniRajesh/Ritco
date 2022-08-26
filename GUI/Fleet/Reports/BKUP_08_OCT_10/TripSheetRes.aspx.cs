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
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TripSheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string strConnStr = Session["SqlProvider"].ToString();
           
            ReportViewer1.Visible = true;


            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            //ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

            ReportViewer1.ServerReport.ReportPath = "/Report Project1/Tripsheet";
            ReportParameter[] parameters = new ReportParameter[68];
            //for show/hide columns

            parameters[0] = new ReportParameter("TripsheetNo", cls_Report_TripSheet.strTripsheetNo.ToString().Trim());
            parameters[1] = new ReportParameter("TripsheetStartDate", cls_Report_TripSheet.strTripsheetStartDate.ToString().Trim());
            parameters[2] = new ReportParameter("TripsheetEndDate", cls_Report_TripSheet.strTripsheetEndDate.ToString().Trim());
            parameters[3] = new ReportParameter("StartLocation", cls_Report_TripSheet.strStartLocation.ToString().Trim());

            parameters[4] = new ReportParameter("EndLocation", cls_Report_TripSheet.strEndLocation.ToString().Trim());
            parameters[5] = new ReportParameter("Category", cls_Report_TripSheet.strCategory.ToString().Trim());
            parameters[6] = new ReportParameter("TotalKms", cls_Report_TripSheet.strTotalKms.ToString().Trim());
            parameters[7] = new ReportParameter("VehicleNo_R", cls_Report_TripSheet.strVehicleNo.ToString().Trim());

            parameters[8] = new ReportParameter("VehicleCateGory", cls_Report_TripSheet.strVehicleCateGory.ToString().Trim());
            parameters[9] = new ReportParameter("DriverName", cls_Report_TripSheet.strDriverName.ToString().Trim());
            parameters[10] = new ReportParameter("Status_R", cls_Report_TripSheet.strStatus.ToString().Trim());
            parameters[11] = new ReportParameter("StartingKM", cls_Report_TripSheet.strStartingKM.ToString().Trim());

            parameters[12] = new ReportParameter("ClosingKM", cls_Report_TripSheet.strClosingKM.ToString().Trim());
            parameters[13] = new ReportParameter("TotalKM", cls_Report_TripSheet.strTotalKM.ToString().Trim());
            parameters[14] = new ReportParameter("ApprovedKMPL", cls_Report_TripSheet.strApprovedKMPL.ToString().Trim());
            parameters[15] = new ReportParameter("ActualKMPL", cls_Report_TripSheet.strActualKMPL.ToString().Trim());

            parameters[16] = new ReportParameter("DieselQuantity", cls_Report_TripSheet.strDieselQuantity.ToString().Trim());
            parameters[17] = new ReportParameter("BillPrepared", cls_Report_TripSheet.strBillPrepared.ToString().Trim());
            parameters[18] = new ReportParameter("BillNo", cls_Report_TripSheet.strBillNo.ToString().Trim());
            parameters[19] = new ReportParameter("ThcAttached", cls_Report_TripSheet.strThcAttached.ToString().Trim());

            parameters[20] = new ReportParameter("Customername", cls_Report_TripSheet.strCustomername.ToString().Trim());
            parameters[21] = new ReportParameter("TotalTHCAmount", cls_Report_TripSheet.strTotalTHCAmount.ToString().Trim());



            parameters[22] = new ReportParameter("Advance", cls_Report_TripSheet.strAdvance.ToString().Trim());
            parameters[23] = new ReportParameter("Repair", cls_Report_TripSheet.strRepair.ToString().Trim());
            parameters[24] = new ReportParameter("Claims", cls_Report_TripSheet.strClaims.ToString().Trim());
            parameters[25] = new ReportParameter("Fuel", cls_Report_TripSheet.strFuel.ToString().Trim());

            parameters[26] = new ReportParameter("Incded", cls_Report_TripSheet.strIncded.ToString().Trim());
            parameters[27] = new ReportParameter("Spare", cls_Report_TripSheet.strSpare.ToString().Trim());



            parameters[28] = new ReportParameter("RTO", cls_Report_TripSheet.strRTO.ToString().Trim());
            parameters[29] = new ReportParameter("BorderCheckPost", cls_Report_TripSheet.strBorderCheckPost.ToString().Trim());
            parameters[30] = new ReportParameter("Toll", cls_Report_TripSheet.strToll.ToString().Trim());
            parameters[31] = new ReportParameter("SalesTaxseal", cls_Report_TripSheet.strSalesTaxseal.ToString().Trim());

            parameters[32] = new ReportParameter("Escorts", cls_Report_TripSheet.strEscorts.ToString().Trim());
            parameters[33] = new ReportParameter("Octroi", cls_Report_TripSheet.strOctroi.ToString().Trim());
            parameters[34] = new ReportParameter("Loading", cls_Report_TripSheet.strLoading.ToString().Trim());
            parameters[35] = new ReportParameter("Unloading", cls_Report_TripSheet.strUnloading.ToString().Trim());

            parameters[36] = new ReportParameter("EnrouteRapairs", cls_Report_TripSheet.strEnrouteRapairs.ToString().Trim());
            parameters[37] = new ReportParameter("Penalty", cls_Report_TripSheet.strPenalty.ToString().Trim());
            parameters[38] = new ReportParameter("TyrePuncture", cls_Report_TripSheet.strTyrePuncture.ToString().Trim());
            parameters[39] = new ReportParameter("WeighBridgeExpenses", cls_Report_TripSheet.strWeighBridgeExpenses.ToString().Trim());

            parameters[40] = new ReportParameter("Parking", cls_Report_TripSheet.strParking.ToString().Trim());
            parameters[41] = new ReportParameter("Telephone", cls_Report_TripSheet.strTelephone.ToString().Trim());
            parameters[42] = new ReportParameter("TemporaryPermit", cls_Report_TripSheet.strTemporaryPermit.ToString().Trim());
            parameters[43] = new ReportParameter("DriverDailyAllowance", cls_Report_TripSheet.strDriverDailyAllowance.ToString().Trim());

            parameters[44] = new ReportParameter("IncentivePayable", cls_Report_TripSheet.strIncentivePayable.ToString().Trim());
            parameters[45] = new ReportParameter("OtherExpense", cls_Report_TripSheet.strOtherExpense.ToString().Trim());
            parameters[46] = new ReportParameter("BrokerCommission", cls_Report_TripSheet.strBrokerCommission.ToString().Trim());

            //for search criteria

            parameters[47] = new ReportParameter("CreatedFrom", cls_Report_TripSheet.strDateFrom.ToString().Trim());
            parameters[48] = new ReportParameter("CreatedTo", cls_Report_TripSheet.strDateTo.ToString().Trim());
            parameters[49] = new ReportParameter("Status", cls_Report_TripSheet.strStatus1.ToString().Trim());
            parameters[50] = new ReportParameter("Branch", cls_Report_TripSheet.strBranch.ToString().Trim());
            parameters[51] = new ReportParameter("VehicleNo", cls_Report_TripSheet.strVehicleNo1.ToString().Trim());
            parameters[52] = new ReportParameter("Driver", cls_Report_TripSheet.strDriver.ToString().Trim());
            parameters[53] = new ReportParameter("Manual", cls_Report_TripSheet.strManual.ToString().Trim());
            parameters[54] = new ReportParameter("Tripsheet", cls_Report_TripSheet.strTripsheet.ToString().Trim());
            parameters[55] = new ReportParameter("DateGNorCL", cls_Report_TripSheet.strDateGNorCL.ToString().Trim());


            parameters[56] = new ReportParameter("FROM_CITY", cls_Report_TripSheet.strFromCity.ToString().Trim());
            parameters[57] = new ReportParameter("TO_CITY", cls_Report_TripSheet.strToCity.ToString().Trim());
            parameters[58] = new ReportParameter("ACTUAL_EXP", cls_Report_TripSheet.strACTUAL_EXP.ToString().Trim());
            parameters[59] = new ReportParameter("ACTUAL_LOADUNLOAD", cls_Report_TripSheet.strACTUAL_LOADUNLOAD.ToString().Trim());
            parameters[60] = new ReportParameter("ACTUAL_BROKERAGE", cls_Report_TripSheet.strACTUAL_BROKERAGE.ToString().Trim());
            parameters[61] = new ReportParameter("ACTUAL_REPAIR", cls_Report_TripSheet.strACTUAL_REPAIR.ToString().Trim());
            parameters[62] = new ReportParameter("ACTUAL_OCTROI", cls_Report_TripSheet.strACTUAL_OCTROI.ToString().Trim());
            parameters[63] = new ReportParameter("ACTUAL_DRIVERALLOWANCE", cls_Report_TripSheet.strACTUAL_DRIVERALLOWANCE.ToString().Trim());
            parameters[64] = new ReportParameter("ACTUAL_ClaimsAmt", cls_Report_TripSheet.strACTUAL_ClaimsAmt.ToString().Trim());
            parameters[65] = new ReportParameter("ACTUAL_TOT_EXP", cls_Report_TripSheet.strACTUAL_TOT_EXP.ToString().Trim());
            parameters[66] = new ReportParameter("TRIPSHEET_INCOME", cls_Report_TripSheet.strTRIPSHEET_INCOME.ToString().Trim());

            parameters[67] = new ReportParameter("ConnStr", strConnStr);

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
           // UpdatePanel1.Update();
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("TripsheetQuery.aspx");
    }
}

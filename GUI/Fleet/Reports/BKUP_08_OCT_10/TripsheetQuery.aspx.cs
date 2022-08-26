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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;


public partial class GUI_Fleet_Reports_TripsheetQueryNew : System.Web.UI.Page
{

    string status = "";
    string Exp = "";
    string Enroute = "";


    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

      
         //Session["Status"] = null;

        
        if (!IsPostBack)
        {
               popRO();
               FillDDLDate();

               chkTripAll.Attributes.Add("OnClick", "javascript:SelectAll(" + chkTripAll.ClientID.ToString() + "," + chklstTripsheetDet.ClientID.ToString() + ");");
               chkExpAll.Attributes.Add("OnClick", "javascript:SelectAll(" + chkExpAll.ClientID.ToString() + "," + chklstExpDet.ClientID.ToString() + ");");
               chkEnExp.Attributes.Add("OnClick", "javascript:SelectAll(" + chkEnExp.ClientID.ToString() + "," + chklstEnrouteExp.ClientID.ToString() + ");");
               chkAllActExp.Attributes.Add("OnClick", "javascript:SelectAll(" + chkAllActExp.ClientID.ToString() + "," + chklstActExp.ClientID.ToString() + ");");
               Session["mBranch"] = ddlro.SelectedItem.Value.Trim();
            //Do Work
        }
            
    
    }

    public void popRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string brcd = SessionUtilities.CurrentBranchCode.ToString().Trim();

        string q1 = "Select loccode,locname from webx_location where loc_level='1'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();


        dr.Read();
       
        string loccd = dr["loccode"].ToString();
        dr.Close();

        String SQL_LOC,sqlall1;
      

        if (brcd == loccd)
        {
            ddlro.Items.Add(new ListItem("-- Select -- ", ""));
            ddlro.Items.Add(new ListItem("ALL", "ALL"));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' order by locName";
     
        }
        else
        {
            //ddlro.Items.Add(new ListItem("ALL", "ALL"));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
      
        }


        SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd2.ExecuteReader();

        while (dr1.Read())
        {
            
            ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
            
        }
        dr1.Close();

        ddlro.SelectedValue = loccd;
    }

      
    
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {

        //TripSheet Details 24
        //string strTripsheetNo = "", strTripsheetStartDate = "", strTripsheetEndDate = "", strStartLocation = "";
        //string strEndLocation = "", strFromCity="",strToCity="", strCategory = "", strTotalKms = "", strVehicleNo = "";
        //string strVehicleCateGory = "", strDriverName = "", strStatus = "", strStartingKM = "";
        //string strClosingKM = "", strTotalKM = "", strApprovedKMPL = "", strActualKMPL = "";
        //string strDieselQuantity = "", strBillPrepared = "", strBillNo = "", strThcAttached = "";
        //string strCustomername = "", strTotalTHCAmount = "";

        if (chklstTripsheetDet.Items[0].Selected == true) { cls_Report_TripSheet.strTripsheetNo = "TripsheetNo"; }
        if (chklstTripsheetDet.Items[1].Selected == true) { cls_Report_TripSheet.strTripsheetStartDate = "TripsheetStartDate"; }
        if (chklstTripsheetDet.Items[2].Selected == true) { cls_Report_TripSheet.strTripsheetEndDate = "TripsheetEndDate"; }
        if (chklstTripsheetDet.Items[3].Selected == true) { cls_Report_TripSheet.strStartLocation = "StartLocation"; }


        if (chklstTripsheetDet.Items[4].Selected == true) { cls_Report_TripSheet.strEndLocation = "EndLocation"; }
        if (chklstTripsheetDet.Items[5].Selected == true) { cls_Report_TripSheet.strFromCity = "FromCity"; }
        if (chklstTripsheetDet.Items[6].Selected == true) { cls_Report_TripSheet.strToCity = "ToCity"; }
        if (chklstTripsheetDet.Items[7].Selected == true) { cls_Report_TripSheet.strCategory = "Category"; }
        if (chklstTripsheetDet.Items[8].Selected == true) { cls_Report_TripSheet.strTotalKms = "TotalKms"; }
        if (chklstTripsheetDet.Items[9].Selected == true) { cls_Report_TripSheet.strVehicleNo = "VehicleNo"; }

        if (chklstTripsheetDet.Items[10].Selected == true) { cls_Report_TripSheet.strVehicleCateGory = "VehicleCateGory"; }
        if (chklstTripsheetDet.Items[11].Selected == true) { cls_Report_TripSheet.strDriverName = "DriverName"; }
        if (chklstTripsheetDet.Items[12].Selected == true) { cls_Report_TripSheet.strStatus = "Status"; }
        if (chklstTripsheetDet.Items[13].Selected == true) { cls_Report_TripSheet.strStartingKM = "StartingKM"; }


        if (chklstTripsheetDet.Items[14].Selected == true) { cls_Report_TripSheet.strClosingKM = "ClosingKM"; }
        if (chklstTripsheetDet.Items[15].Selected == true) { cls_Report_TripSheet.strTotalKM = "TotalKM"; }
        if (chklstTripsheetDet.Items[16].Selected == true) { cls_Report_TripSheet.strApprovedKMPL = "ApprovedKMPL"; }
        if (chklstTripsheetDet.Items[17].Selected == true) { cls_Report_TripSheet.strActualKMPL = "ActualKMPL"; }

        if (chklstTripsheetDet.Items[18].Selected == true) { cls_Report_TripSheet.strDieselQuantity = "DieselQuantity"; }
        if (chklstTripsheetDet.Items[19].Selected == true) { cls_Report_TripSheet.strBillPrepared = "BillPrepared"; }
        if (chklstTripsheetDet.Items[20].Selected == true) { cls_Report_TripSheet.strBillNo = "BillNo"; }
        if (chklstTripsheetDet.Items[21].Selected == true) { cls_Report_TripSheet.strThcAttached = "ThcAttached"; }


        if (chklstTripsheetDet.Items[22].Selected == true) { cls_Report_TripSheet.strCustomername = "Customername"; }
        if (chklstTripsheetDet.Items[23].Selected == true) { cls_Report_TripSheet.strTotalTHCAmount = "TotalTHCAmount"; }

        //Expense Details 6
        //string strAdvance = "", strRepair = "", strClaims = "", strFuel = "", strIncded = "", strSpare = "";

        if (chklstExpDet.Items[0].Selected == true) { cls_Report_TripSheet.strAdvance = "Advance"; }
        if (chklstExpDet.Items[1].Selected == true) { cls_Report_TripSheet.strRepair = "Repair"; }
        if (chklstExpDet.Items[2].Selected == true) { cls_Report_TripSheet.strClaims = "Claims"; }
        if (chklstExpDet.Items[3].Selected == true) { cls_Report_TripSheet.strFuel = "Fuel"; }

        if (chklstExpDet.Items[4].Selected == true) { cls_Report_TripSheet.strIncded = "Incded"; }
        if (chklstExpDet.Items[5].Selected == true) { cls_Report_TripSheet.strSpare = "Spare"; }

        //Enroute Expense Details 19
        //string strRTO = "", strBorderCheckPost = "", strToll = "", strSalesTaxseal = "";
        //string strEscorts = "", strOctroi = "", strLoading = "", strUnloading = "";
        //string strEnrouteRapairs = "", strPenalty = "", strTyrePuncture = "", strWeighBridgeExpenses = "";
        //string strParking = "", strTelephone = "", strTemporaryPermit = "", strDriverDailyAllowance = ""; ;
        //string strIncentivePayable = "", strOtherExpense = "", strBrokerCommission = "";


        if (chklstEnrouteExp.Items[0].Selected == true) { cls_Report_TripSheet.strRTO = "RTO"; }
        if (chklstEnrouteExp.Items[1].Selected == true) { cls_Report_TripSheet.strBorderCheckPost = "BorderCheckPost"; }
        if (chklstEnrouteExp.Items[2].Selected == true) { cls_Report_TripSheet.strToll = "Toll"; }
        if (chklstEnrouteExp.Items[3].Selected == true) { cls_Report_TripSheet.strSalesTaxseal = "SalesTaxseal"; }


        if (chklstEnrouteExp.Items[4].Selected == true) { cls_Report_TripSheet.strEscorts = "Escorts"; }
        if (chklstEnrouteExp.Items[5].Selected == true) { cls_Report_TripSheet.strOctroi = "Octroi"; }
        if (chklstEnrouteExp.Items[6].Selected == true) { cls_Report_TripSheet.strLoading = "Loading"; }
        if (chklstEnrouteExp.Items[7].Selected == true) { cls_Report_TripSheet.strUnloading = "Unloading"; }


        if (chklstEnrouteExp.Items[8].Selected == true) { cls_Report_TripSheet.strEnrouteRapairs = "EnrouteRapairs"; }
        if (chklstEnrouteExp.Items[9].Selected == true) { cls_Report_TripSheet.strPenalty = "Penalty"; }
        if (chklstEnrouteExp.Items[10].Selected == true) { cls_Report_TripSheet.strTyrePuncture = "TyrePuncture"; }
        if (chklstEnrouteExp.Items[11].Selected == true) { cls_Report_TripSheet.strWeighBridgeExpenses = "WeighBridgeExpenses"; }


        if (chklstEnrouteExp.Items[12].Selected == true) { cls_Report_TripSheet.strParking = "Parking"; }
        if (chklstEnrouteExp.Items[13].Selected == true) { cls_Report_TripSheet.strTelephone = "Telephone"; }
        if (chklstEnrouteExp.Items[14].Selected == true) { cls_Report_TripSheet.strTemporaryPermit = "TemporaryPermit"; }
        if (chklstEnrouteExp.Items[15].Selected == true) { cls_Report_TripSheet.strDriverDailyAllowance = "DriverDailyAllowance"; }

        if (chklstEnrouteExp.Items[16].Selected == true) { cls_Report_TripSheet.strIncentivePayable = "IncentivePayable"; }
        if (chklstEnrouteExp.Items[17].Selected == true) { cls_Report_TripSheet.strOtherExpense = "OtherExpense"; }
        if (chklstEnrouteExp.Items[18].Selected == true) { cls_Report_TripSheet.strBrokerCommission = "BrokerCommission"; }


        //Actual Expense 8

        //string strTRIPSHEET_INCOME="",strACTUAL_EXP = "", strACTUAL_LOADUNLOAD = "", strACTUAL_BROKERAGE = "", strACTUAL_REPAIR = "";
        //string strACTUAL_OCTROI = "", strACTUAL_DRIVERALLOWANCE = "", strACTUAL_ClaimsAmt = "", strACTUAL_TOT_EXP = "";


        if (chklstActExp.Items[0].Selected == true) { cls_Report_TripSheet.strTRIPSHEET_INCOME = "TRIPSHEET_INCOME"; }
        if (chklstActExp.Items[1].Selected == true) { cls_Report_TripSheet.strACTUAL_EXP = "ACTUAL_EXP"; }
        if (chklstActExp.Items[2].Selected == true) { cls_Report_TripSheet.strACTUAL_LOADUNLOAD = "ACTUAL_LOADUNLOAD"; }
        if (chklstActExp.Items[3].Selected == true) { cls_Report_TripSheet.strACTUAL_BROKERAGE = "ACTUAL_BROKERAGE"; }
        if (chklstActExp.Items[4].Selected == true) { cls_Report_TripSheet.strACTUAL_REPAIR = "ACTUAL_REPAIR"; }
        if (chklstActExp.Items[5].Selected == true) { cls_Report_TripSheet.strACTUAL_OCTROI = "ACTUAL_OCTROI"; }
        if (chklstActExp.Items[6].Selected == true) { cls_Report_TripSheet.strACTUAL_DRIVERALLOWANCE = "ACTUAL_DRIVERALLOWANCE"; }
        if (chklstActExp.Items[7].Selected == true) { cls_Report_TripSheet.strACTUAL_ClaimsAmt = "ACTUAL_ClaimsAmt"; }
        if (chklstActExp.Items[8].Selected == true) { cls_Report_TripSheet.strACTUAL_TOT_EXP = "ACTUAL_TOT_EXP"; }



        cls_Report_TripSheet.strDateFrom = txtDateFrom.Text.ToString().Trim();
        cls_Report_TripSheet.strDateTo = txtDateTo.Text.ToString().Trim();
        cls_Report_TripSheet.strStatus1 = ddlStatus.SelectedItem.Text.ToString().Trim();
        cls_Report_TripSheet.strBranch = ddlro.SelectedValue.ToString().Trim();
        cls_Report_TripSheet.strVehicleNo1 = txtVehNo.Text.ToString().Trim();
        cls_Report_TripSheet.strDriver = hfDriverCode.Value;
        cls_Report_TripSheet.strManual = txtManual.Text.ToString().Trim();
        cls_Report_TripSheet.strTripsheet = txtTripsheetNo.Text.ToString().Trim();
        cls_Report_TripSheet.strDateGNorCL = ddlDate.SelectedItem.Text.ToString().Trim();

        Response.Redirect("TripSheetRes.aspx");

        //string strConnStr = Session["SqlProvider"].ToString();
        //string[] arrConnStr = strConnStr.Split(';');
        //string[] arrSrv = arrConnStr[0].Split('=');
        //string[] arrDb = arrConnStr[1].Split('=');

        //ReportViewer1.Visible = true;


        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

        ////ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        //ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ////ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";



        //ReportViewer1.ServerReport.ReportPath = "/Report Project1/Tripsheet";
        //ReportParameter[] parameters = new ReportParameter[69];
        ////for show/hide columns

        //parameters[0] = new ReportParameter("TripsheetNo", strTripsheetNo.ToString().Trim());
        //parameters[1] = new ReportParameter("TripsheetStartDate", strTripsheetStartDate.ToString().Trim());
        //parameters[2] = new ReportParameter("TripsheetEndDate", strTripsheetEndDate.ToString().Trim());
        //parameters[3] = new ReportParameter("StartLocation", strStartLocation.ToString().Trim());

        //parameters[4] = new ReportParameter("EndLocation", strEndLocation.ToString().Trim());
        //parameters[5] = new ReportParameter("Category", strCategory.ToString().Trim());
        //parameters[6] = new ReportParameter("TotalKms", strTotalKms.ToString().Trim());
        //parameters[7] = new ReportParameter("VehicleNo_R", strVehicleNo.ToString().Trim());

        //parameters[8] = new ReportParameter("VehicleCateGory", strVehicleCateGory.ToString().Trim());
        //parameters[9] = new ReportParameter("DriverName", strDriverName.ToString().Trim());
        //parameters[10] = new ReportParameter("Status_R", strStatus.ToString().Trim());
        //parameters[11] = new ReportParameter("StartingKM", strStartingKM.ToString().Trim());

        //parameters[12] = new ReportParameter("ClosingKM", strClosingKM.ToString().Trim());
        //parameters[13] = new ReportParameter("TotalKM", strTotalKM.ToString().Trim());
        //parameters[14] = new ReportParameter("ApprovedKMPL", strApprovedKMPL.ToString().Trim());
        //parameters[15] = new ReportParameter("ActualKMPL", strActualKMPL.ToString().Trim());

        //parameters[16] = new ReportParameter("DieselQuantity", strDieselQuantity.ToString().Trim());
        //parameters[17] = new ReportParameter("BillPrepared", strBillPrepared.ToString().Trim());
        //parameters[18] = new ReportParameter("BillNo", strBillNo.ToString().Trim());
        //parameters[19] = new ReportParameter("ThcAttached", strThcAttached.ToString().Trim());

        //parameters[20] = new ReportParameter("Customername", strCustomername.ToString().Trim());
        //parameters[21] = new ReportParameter("TotalTHCAmount", strTotalTHCAmount.ToString().Trim());



        //parameters[22] = new ReportParameter("Advance", strAdvance.ToString().Trim());
        //parameters[23] = new ReportParameter("Repair", strRepair.ToString().Trim());
        //parameters[24] = new ReportParameter("Claims", strClaims.ToString().Trim());
        //parameters[25] = new ReportParameter("Fuel", strFuel.ToString().Trim());

        //parameters[26] = new ReportParameter("Incded", strIncded.ToString().Trim());
        //parameters[27] = new ReportParameter("Spare", strSpare.ToString().Trim());



        //parameters[28] = new ReportParameter("RTO", strRTO.ToString().Trim());
        //parameters[29] = new ReportParameter("BorderCheckPost", strBorderCheckPost.ToString().Trim());
        //parameters[30] = new ReportParameter("Toll", strToll.ToString().Trim());
        //parameters[31] = new ReportParameter("SalesTaxseal", strSalesTaxseal.ToString().Trim());

        //parameters[32] = new ReportParameter("Escorts", strEscorts.ToString().Trim());
        //parameters[33] = new ReportParameter("Octroi", strOctroi.ToString().Trim());
        //parameters[34] = new ReportParameter("Loading", strLoading.ToString().Trim());
        //parameters[35] = new ReportParameter("Unloading", strUnloading.ToString().Trim());

        //parameters[36] = new ReportParameter("EnrouteRapairs", strEnrouteRapairs.ToString().Trim());
        //parameters[37] = new ReportParameter("Penalty", strPenalty.ToString().Trim());
        //parameters[38] = new ReportParameter("TyrePuncture", strTyrePuncture.ToString().Trim());
        //parameters[39] = new ReportParameter("WeighBridgeExpenses", strWeighBridgeExpenses.ToString().Trim());

        //parameters[40] = new ReportParameter("Parking", strParking.ToString().Trim());
        //parameters[41] = new ReportParameter("Telephone", strTelephone.ToString().Trim());
        //parameters[42] = new ReportParameter("TemporaryPermit", strTemporaryPermit.ToString().Trim());
        //parameters[43] = new ReportParameter("DriverDailyAllowance", strDriverDailyAllowance.ToString().Trim());

        //parameters[44] = new ReportParameter("IncentivePayable", strIncentivePayable.ToString().Trim());
        //parameters[45] = new ReportParameter("OtherExpense", strOtherExpense.ToString().Trim());
        //parameters[46] = new ReportParameter("BrokerCommission", strBrokerCommission.ToString().Trim());

        ////for search criteria

        //parameters[47] = new ReportParameter("CreatedFrom", txtDateFrom.Text.ToString().Trim());
        //parameters[48] = new ReportParameter("CreatedTo", txtDateTo.Text.ToString().Trim());
        //parameters[49] = new ReportParameter("Status", ddlStatus.SelectedItem.Text.ToString().Trim());
        //parameters[50] = new ReportParameter("Branch", ddlro.SelectedValue.ToString().Trim());
        //parameters[51] = new ReportParameter("VehicleNo", txtVehNo.Text.ToString().Trim());
        //parameters[52] = new ReportParameter("Driver", hfDriverCode.Value);
        //parameters[53] = new ReportParameter("Manual", txtManual.Text.ToString().Trim());
        //parameters[54] = new ReportParameter("Tripsheet", txtTripsheetNo.Text.ToString().Trim());
        //parameters[55] = new ReportParameter("DateGNorCL", ddlDate.SelectedItem.Text.ToString().Trim());


        //parameters[56] = new ReportParameter("FROM_CITY", strFromCity.ToString().Trim());
        //parameters[57] = new ReportParameter("TO_CITY", strToCity.ToString().Trim());
        //parameters[58] = new ReportParameter("ACTUAL_EXP", strACTUAL_EXP.ToString().Trim());
        //parameters[59] = new ReportParameter("ACTUAL_LOADUNLOAD", strACTUAL_LOADUNLOAD.ToString().Trim());
        //parameters[60] = new ReportParameter("ACTUAL_BROKERAGE", strACTUAL_BROKERAGE.ToString().Trim());
        //parameters[61] = new ReportParameter("ACTUAL_REPAIR", strACTUAL_REPAIR.ToString().Trim());
        //parameters[62] = new ReportParameter("ACTUAL_OCTROI", strACTUAL_OCTROI.ToString().Trim());
        //parameters[63] = new ReportParameter("ACTUAL_DRIVERALLOWANCE", strACTUAL_DRIVERALLOWANCE.ToString().Trim());
        //parameters[64] = new ReportParameter("ACTUAL_ClaimsAmt", strACTUAL_ClaimsAmt.ToString().Trim());
        //parameters[65] = new ReportParameter("ACTUAL_TOT_EXP", strACTUAL_TOT_EXP.ToString().Trim());
        //parameters[66] = new ReportParameter("TRIPSHEET_INCOME", strTRIPSHEET_INCOME.ToString().Trim());

        ////parameters[67] = new ReportParameter("ServerName", "10.138.79.152");
        //parameters[67] = new ReportParameter("ServerName", arrSrv[1].ToString());
        //parameters[68] = new ReportParameter("DatabaseName", arrDb[1].ToString());

        //ReportViewer1.ServerReport.SetParameters(parameters);
        //ReportViewer1.ServerReport.Refresh();
        //UpdatePanel3.Update();
    }

    public void RetrieveDriverDataInfo1(object sender, EventArgs e)
    {
        //if (txtDriver1.Text.Trim() != "")
        //{
        //    string DataFound = "N";
        //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //    string mDriverId1 = "";
        //    lblD1Error.Text = "";
        //    conn.Open();
        //    string sqlD1 = "Select Driver_Id from WEBX_FLEET_DRIVERMST where Manual_Driver_Code='" + txtDriver1.Text.Trim() + "'";
        //    SqlCommand cmdD1 = new SqlCommand(sqlD1, conn);
        //    cmdD1.CommandType = CommandType.Text;
        //    SqlDataReader drD1 = cmdD1.ExecuteReader();
        //    while (drD1.Read())
        //    {
        //        DataFound = "Y";
        //        mDriverId1 = Convert.ToString(drD1["Driver_ID"]);
        //    }
        //    drD1.Close();
        //    if (DataFound == "N")
        //    {
        //        lblD1Error.Visible = true;
        //        lblD1Error.Text = "Driver1 Code Is InValid!";
        //    }
        //    else
        //    {
        //        lblD1Error.Visible = false;
        //        lblD1Error.Text = "";
        //    }
        //}

    }

    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["mBranch"] = null;
        Session["mBranch"] = ddlro.SelectedItem.Value.Trim();
    }
    public void FillDDLDate()
    {
        ddlDate.Items.Clear();
        ddlDate.Items.Add("Generation");
        ddlDate.Items.Add("Closure");
    }

}

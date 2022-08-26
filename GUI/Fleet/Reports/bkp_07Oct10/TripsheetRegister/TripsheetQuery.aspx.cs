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

        string brcd = Session["brcd"].ToString();

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
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        if (chklstTripsheetDet.Items[0].Selected == true) { cls_Report_TripSheet.strTripsheetNo = "TripsheetNo"; } else { cls_Report_TripSheet.strTripsheetNo = ""; }
        if (chklstTripsheetDet.Items[1].Selected == true) { cls_Report_TripSheet.strTripsheetStartDate = "TripsheetStartDate"; } else { cls_Report_TripSheet.strTripsheetStartDate = ""; }
        if (chklstTripsheetDet.Items[2].Selected == true) { cls_Report_TripSheet.strTripsheetEndDate = "TripsheetEndDate"; } else { cls_Report_TripSheet.strTripsheetEndDate = ""; }
        if (chklstTripsheetDet.Items[3].Selected == true) { cls_Report_TripSheet.strStartLocation = "StartLocation"; } else { cls_Report_TripSheet.strStartLocation = ""; }

        if (chklstTripsheetDet.Items[4].Selected == true) { cls_Report_TripSheet.strEndLocation = "EndLocation"; } else { cls_Report_TripSheet.strEndLocation = ""; }
        if (chklstTripsheetDet.Items[5].Selected == true) { cls_Report_TripSheet.strFromCity = "FromCity"; } else { cls_Report_TripSheet.strFromCity = ""; }
        if (chklstTripsheetDet.Items[6].Selected == true) { cls_Report_TripSheet.strToCity = "ToCity"; } else { cls_Report_TripSheet.strToCity = ""; }
        if (chklstTripsheetDet.Items[7].Selected == true) { cls_Report_TripSheet.strCategory = "Category"; } else { cls_Report_TripSheet.strCategory = ""; }
        if (chklstTripsheetDet.Items[8].Selected == true) { cls_Report_TripSheet.strTotalKms = "TotalKms"; } else { cls_Report_TripSheet.strTotalKms = ""; }
        if (chklstTripsheetDet.Items[9].Selected == true) { cls_Report_TripSheet.strVehicleNo = "VehicleNo"; } else { cls_Report_TripSheet.strVehicleNo = ""; }

        if (chklstTripsheetDet.Items[10].Selected == true) { cls_Report_TripSheet.strVehicleCateGory = "VehicleCateGory"; } else { cls_Report_TripSheet.strVehicleCateGory = ""; }
        if (chklstTripsheetDet.Items[11].Selected == true) { cls_Report_TripSheet.strDriverName1 = "DriverName1"; } else { cls_Report_TripSheet.strDriverName1 = ""; }
        if (chklstTripsheetDet.Items[12].Selected == true) { cls_Report_TripSheet.strStatus = "Status"; } else { cls_Report_TripSheet.strStatus = ""; }
        if (chklstTripsheetDet.Items[13].Selected == true) { cls_Report_TripSheet.strStartingKM = "StartingKM"; } else { cls_Report_TripSheet.strStartingKM = ""; }

        if (chklstTripsheetDet.Items[14].Selected == true) { cls_Report_TripSheet.strClosingKM = "ClosingKM"; } else { cls_Report_TripSheet.strClosingKM = ""; }
        if (chklstTripsheetDet.Items[15].Selected == true) { cls_Report_TripSheet.strTotalKM = "TotalKM"; } else { cls_Report_TripSheet.strTotalKM = ""; }
        if (chklstTripsheetDet.Items[16].Selected == true) { cls_Report_TripSheet.strApprovedKMPL = "ApprovedKMPL"; } else { cls_Report_TripSheet.strApprovedKMPL = ""; }
        if (chklstTripsheetDet.Items[17].Selected == true) { cls_Report_TripSheet.strActualKMPL = "ActualKMPL"; } else { cls_Report_TripSheet.strActualKMPL = ""; }

        if (chklstTripsheetDet.Items[18].Selected == true) { cls_Report_TripSheet.strDieselQuantity = "DieselQuantity"; } else { cls_Report_TripSheet.strDieselQuantity = ""; }
        if (chklstTripsheetDet.Items[19].Selected == true) { cls_Report_TripSheet.strBillPrepared = "BillPrepared"; } else { cls_Report_TripSheet.strBillPrepared = ""; }
        if (chklstTripsheetDet.Items[20].Selected == true) { cls_Report_TripSheet.strBillNo = "BillNo"; } else { cls_Report_TripSheet.strBillNo = ""; }
        if (chklstTripsheetDet.Items[21].Selected == true) { cls_Report_TripSheet.strThcAttached = "ThcAttached"; } else { cls_Report_TripSheet.strThcAttached = ""; }

        if (chklstTripsheetDet.Items[22].Selected == true) { cls_Report_TripSheet.strCustomername = "Customername"; } else { cls_Report_TripSheet.strCustomername = ""; }
        if (chklstTripsheetDet.Items[23].Selected == true) { cls_Report_TripSheet.strTotalTHCAmount = "TotalTHCAmount"; } else { cls_Report_TripSheet.strTotalTHCAmount = ""; }

        if (chklstTripsheetDet.Items[24].Selected == true) { cls_Report_TripSheet.strDriverName2 = "DriverName2"; } else { cls_Report_TripSheet.strDriverName2 = ""; }

        if (chklstTripsheetDet.Items[25].Selected == true) { cls_Report_TripSheet.strPrevDriver1 = "PrevDriver1"; } else { cls_Report_TripSheet.strPrevDriver1 = ""; }
        if (chklstTripsheetDet.Items[26].Selected == true) { cls_Report_TripSheet.strPrevDriver2 = "PrevDriver2"; } else { cls_Report_TripSheet.strPrevDriver2 = ""; }
        if (chklstTripsheetDet.Items[27].Selected == true) { cls_Report_TripSheet.strDRIVER_SETTLE_STATUS = "DRIVER_SETTLE_STATUS"; } else { cls_Report_TripSheet.strDRIVER_SETTLE_STATUS = ""; }
        if (chklstTripsheetDet.Items[28].Selected == true) { cls_Report_TripSheet.strDRIVER_SETTLE_DT = "DRIVER_SETTLE_DT"; } else { cls_Report_TripSheet.strDRIVER_SETTLE_DT = ""; }


        if (chklstExpDet.Items[0].Selected == true) { cls_Report_TripSheet.strAdvance = "Advance"; } else { cls_Report_TripSheet.strAdvance = ""; }
        if (chklstExpDet.Items[1].Selected == true) { cls_Report_TripSheet.strRepair = "Repair"; } else { cls_Report_TripSheet.strRepair = ""; }
        if (chklstExpDet.Items[2].Selected == true) { cls_Report_TripSheet.strClaims = "Claims"; } else { cls_Report_TripSheet.strClaims = ""; }
        if (chklstExpDet.Items[3].Selected == true) { cls_Report_TripSheet.strFuel = "Fuel"; } else { cls_Report_TripSheet.strFuel = ""; }

        if (chklstExpDet.Items[4].Selected == true) { cls_Report_TripSheet.strIncded = "Incded"; } else { cls_Report_TripSheet.strIncded = ""; }
        if (chklstExpDet.Items[5].Selected == true) { cls_Report_TripSheet.strSpare = "Spare"; } else { cls_Report_TripSheet.strSpare = ""; }

        if (chklstEnrouteExp.Items[0].Selected == true) { cls_Report_TripSheet.strRTO = "RTO"; } else { cls_Report_TripSheet.strRTO = ""; }
        if (chklstEnrouteExp.Items[1].Selected == true) { cls_Report_TripSheet.strBorderCheckPost = "BorderCheckPost"; } else { cls_Report_TripSheet.strBorderCheckPost = ""; }
        if (chklstEnrouteExp.Items[2].Selected == true) { cls_Report_TripSheet.strToll = "Toll"; } else { cls_Report_TripSheet.strToll = ""; }
        if (chklstEnrouteExp.Items[3].Selected == true) { cls_Report_TripSheet.strSalesTaxseal = "SalesTaxseal"; } else { cls_Report_TripSheet.strSalesTaxseal = ""; }

        if (chklstEnrouteExp.Items[4].Selected == true) { cls_Report_TripSheet.strEscorts = "Escorts"; } else { cls_Report_TripSheet.strEscorts = ""; }
        if (chklstEnrouteExp.Items[5].Selected == true) { cls_Report_TripSheet.strOctroi = "Octroi"; } else { cls_Report_TripSheet.strOctroi = ""; }
        if (chklstEnrouteExp.Items[6].Selected == true) { cls_Report_TripSheet.strLoading = "Loading"; } else { cls_Report_TripSheet.strLoading = ""; }
        if (chklstEnrouteExp.Items[7].Selected == true) { cls_Report_TripSheet.strUnloading = "Unloading"; } else { cls_Report_TripSheet.strUnloading = ""; }

        if (chklstEnrouteExp.Items[8].Selected == true) { cls_Report_TripSheet.strEnrouteRapairs = "EnrouteRapairs"; } else { cls_Report_TripSheet.strEnrouteRapairs = ""; }
        if (chklstEnrouteExp.Items[9].Selected == true) { cls_Report_TripSheet.strPenalty = "Penalty"; } else { cls_Report_TripSheet.strPenalty = ""; }
        if (chklstEnrouteExp.Items[10].Selected == true) { cls_Report_TripSheet.strTyrePuncture = "TyrePuncture"; } else { cls_Report_TripSheet.strTyrePuncture = ""; }
        if (chklstEnrouteExp.Items[11].Selected == true) { cls_Report_TripSheet.strWeighBridgeExpenses = "WeighBridgeExpenses"; } else { cls_Report_TripSheet.strWeighBridgeExpenses = ""; }

        if (chklstEnrouteExp.Items[12].Selected == true) { cls_Report_TripSheet.strParking = "Parking"; } else { cls_Report_TripSheet.strParking = ""; }
        if (chklstEnrouteExp.Items[13].Selected == true) { cls_Report_TripSheet.strTelephone = "Telephone"; } else { cls_Report_TripSheet.strTelephone = ""; }
        if (chklstEnrouteExp.Items[14].Selected == true) { cls_Report_TripSheet.strTemporaryPermit = "TemporaryPermit"; } else { cls_Report_TripSheet.strTemporaryPermit = ""; }
        if (chklstEnrouteExp.Items[15].Selected == true) { cls_Report_TripSheet.strDriverDailyAllowance = "DriverDailyAllowance"; } else { cls_Report_TripSheet.strDriverDailyAllowance = ""; }

        if (chklstEnrouteExp.Items[16].Selected == true) { cls_Report_TripSheet.strIncentivePayable = "IncentivePayable"; } else { cls_Report_TripSheet.strIncentivePayable = ""; }
        if (chklstEnrouteExp.Items[17].Selected == true) { cls_Report_TripSheet.strOtherExpense = "OtherExpense"; } else { cls_Report_TripSheet.strOtherExpense = ""; }
        if (chklstEnrouteExp.Items[18].Selected == true) { cls_Report_TripSheet.strBrokerCommission = "BrokerCommission"; } else { cls_Report_TripSheet.strBrokerCommission = ""; }

        if (chklstActExp.Items[0].Selected == true) { cls_Report_TripSheet.strTRIPSHEET_INCOME = "TRIPSHEET_INCOME"; } else { cls_Report_TripSheet.strTRIPSHEET_INCOME = ""; }
        if (chklstActExp.Items[1].Selected == true) { cls_Report_TripSheet.strACTUAL_EXP = "ACTUAL_EXP"; } else { cls_Report_TripSheet.strACTUAL_EXP = ""; }
        if (chklstActExp.Items[2].Selected == true) { cls_Report_TripSheet.strACTUAL_LOADUNLOAD = "ACTUAL_LOADUNLOAD"; } else { cls_Report_TripSheet.strACTUAL_LOADUNLOAD = ""; }
        if (chklstActExp.Items[3].Selected == true) { cls_Report_TripSheet.strACTUAL_BROKERAGE = "ACTUAL_BROKERAGE"; } else { cls_Report_TripSheet.strACTUAL_BROKERAGE = ""; }
        if (chklstActExp.Items[4].Selected == true) { cls_Report_TripSheet.strACTUAL_REPAIR = "ACTUAL_REPAIR"; } else { cls_Report_TripSheet.strACTUAL_REPAIR = ""; }
        if (chklstActExp.Items[5].Selected == true) { cls_Report_TripSheet.strACTUAL_OCTROI = "ACTUAL_OCTROI"; } else { cls_Report_TripSheet.strACTUAL_OCTROI = ""; }
        if (chklstActExp.Items[6].Selected == true) { cls_Report_TripSheet.strACTUAL_DRIVERALLOWANCE = "ACTUAL_DRIVERALLOWANCE"; } else { cls_Report_TripSheet.strACTUAL_DRIVERALLOWANCE = ""; }
        if (chklstActExp.Items[7].Selected == true) { cls_Report_TripSheet.strACTUAL_ClaimsAmt = "ACTUAL_ClaimsAmt"; } else { cls_Report_TripSheet.strACTUAL_ClaimsAmt = ""; }
        if (chklstActExp.Items[8].Selected == true) { cls_Report_TripSheet.strACTUAL_TOT_EXP = "ACTUAL_TOT_EXP"; } else { cls_Report_TripSheet.strACTUAL_TOT_EXP = ""; }

        cls_Report_TripSheet.strCompany = company.SelectedValue.ToString().Trim();
        cls_Report_TripSheet.strDateFrom = txtDateFrom.Text.ToString().Trim();
        cls_Report_TripSheet.strDateTo = txtDateTo.Text.ToString().Trim();
        cls_Report_TripSheet.strStatus1 = ddlStatus.SelectedItem.Text.ToString().Trim();
        cls_Report_TripSheet.strBranch = ddlro.SelectedValue.ToString().Trim();
        cls_Report_TripSheet.strVehicleNo1 = txtVehNo.Text.ToString().Trim();
        cls_Report_TripSheet.strDriver = txtDriver1.Text.ToString().Trim();
        
        cls_Report_TripSheet.strManual = txtManual.Text.ToString().Trim();
        cls_Report_TripSheet.strTripsheet = txtTripsheetNo.Text.ToString().Trim();
        cls_Report_TripSheet.strDateGNorCL = ddlDate.SelectedItem.Text.ToString().Trim();

        Response.Redirect("TripSheetRes.aspx");
    }

    public void RetrieveDriverDataInfo1(object sender, EventArgs e)
    {
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

    protected void btnSubmitThc_Click(object sender, EventArgs e)
    {
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        cls_Report_TripSheet.strCompany = company.SelectedValue.ToString().Trim();
      	cls_Report_TripSheet.strDateFrom = txtDateFrom.Text.ToString().Trim();
        cls_Report_TripSheet.strDateTo = txtDateTo.Text.ToString().Trim();
        cls_Report_TripSheet.strStatus = ddlStatus.SelectedItem.Text.ToString().Trim();
        cls_Report_TripSheet.strBranch = ddlro.SelectedValue.ToString().Trim();
        cls_Report_TripSheet.strDriver = txtDriver1.Text.ToString().Trim();
        cls_Report_TripSheet.strVehicleNo = txtVehNo.Text.Trim();
        cls_Report_TripSheet.strManual = txtManual.Text.ToString().Trim();
        cls_Report_TripSheet.strTripsheet = txtTripsheetNo.Text.ToString().Trim();

        Response.Redirect("TripSheetTHCRes.aspx");
    }
}

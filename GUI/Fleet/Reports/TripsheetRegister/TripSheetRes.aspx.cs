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
using ApplicationManager;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System.Xml;
public partial class GUI_Fleet_Reports_TripSheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strhdnRpt = cls_Report_TripSheet.strhdn;
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("TripsheetNo", cls_Report_TripSheet.strTripsheetNo.ToString().Trim()));
            parameters.Add(new ReportParameter("TripsheetStartDate", cls_Report_TripSheet.strTripsheetStartDate.ToString().Trim()));
            parameters.Add(new ReportParameter("TripsheetEndDate", cls_Report_TripSheet.strTripsheetEndDate.ToString().Trim()));
            parameters.Add(new ReportParameter("StartLocation", cls_Report_TripSheet.strStartLocation.ToString().Trim()));

            parameters.Add(new ReportParameter("EndLocation", cls_Report_TripSheet.strEndLocation.ToString().Trim()));
            parameters.Add(new ReportParameter("Category", cls_Report_TripSheet.strCategory.ToString().Trim()));
            parameters.Add(new ReportParameter("TotalKms", cls_Report_TripSheet.strTotalKms.ToString().Trim()));
            parameters.Add(new ReportParameter("VehicleNo_R", cls_Report_TripSheet.strVehicleNo.ToString().Trim()));

            parameters.Add(new ReportParameter("VehicleCateGory", cls_Report_TripSheet.strVehicleCateGory.ToString().Trim()));
            parameters.Add(new ReportParameter("DriverName1", cls_Report_TripSheet.strDriverName1.ToString().Trim()));
            parameters.Add(new ReportParameter("Status_R", cls_Report_TripSheet.strStatus.ToString().Trim()));
            parameters.Add(new ReportParameter("StartingKM", cls_Report_TripSheet.strStartingKM.ToString().Trim()));

            parameters.Add(new ReportParameter("ClosingKM", cls_Report_TripSheet.strClosingKM.ToString().Trim()));
            parameters.Add(new ReportParameter("TotalKM", cls_Report_TripSheet.strTotalKM.ToString().Trim()));
            parameters.Add(new ReportParameter("ApprovedKMPL", cls_Report_TripSheet.strApprovedKMPL.ToString().Trim()));
            parameters.Add(new ReportParameter("ActualKMPL", cls_Report_TripSheet.strActualKMPL.ToString().Trim()));

            parameters.Add(new ReportParameter("DieselQuantity", cls_Report_TripSheet.strDieselQuantity.ToString().Trim()));
            parameters.Add(new ReportParameter("BillPrepared", cls_Report_TripSheet.strBillPrepared.ToString().Trim()));
            parameters.Add(new ReportParameter("BillNo", cls_Report_TripSheet.strBillNo.ToString().Trim()));
            parameters.Add(new ReportParameter("ThcAttached", cls_Report_TripSheet.strThcAttached.ToString().Trim()));

            parameters.Add(new ReportParameter("Customername", cls_Report_TripSheet.strCustomername.ToString().Trim()));
            parameters.Add(new ReportParameter("TotalTHCAmount", cls_Report_TripSheet.strTotalTHCAmount.ToString().Trim()));



            parameters.Add(new ReportParameter("Advance", cls_Report_TripSheet.strAdvance.ToString().Trim()));
            parameters.Add(new ReportParameter("Repair", cls_Report_TripSheet.strRepair.ToString().Trim()));
            parameters.Add(new ReportParameter("Claims", cls_Report_TripSheet.strClaims.ToString().Trim()));
            parameters.Add(new ReportParameter("Fuel", cls_Report_TripSheet.strFuel.ToString().Trim()));

            parameters.Add(new ReportParameter("Incded", cls_Report_TripSheet.strIncded.ToString().Trim()));
            parameters.Add(new ReportParameter("Spare", cls_Report_TripSheet.strSpare.ToString().Trim()));



            parameters.Add(new ReportParameter("RTO", cls_Report_TripSheet.strRTO.ToString().Trim()));
            parameters.Add(new ReportParameter("BorderCheckPost", cls_Report_TripSheet.strBorderCheckPost.ToString().Trim()));
            parameters.Add(new ReportParameter("Toll", cls_Report_TripSheet.strToll.ToString().Trim()));
            parameters.Add(new ReportParameter("SalesTaxseal", cls_Report_TripSheet.strSalesTaxseal.ToString().Trim()));

            parameters.Add(new ReportParameter("Escorts", cls_Report_TripSheet.strEscorts.ToString().Trim()));
            parameters.Add(new ReportParameter("Octroi", cls_Report_TripSheet.strOctroi.ToString().Trim()));
            parameters.Add(new ReportParameter("Loading", cls_Report_TripSheet.strLoading.ToString().Trim()));
            parameters.Add(new ReportParameter("Unloading", cls_Report_TripSheet.strUnloading.ToString().Trim()));

            parameters.Add(new ReportParameter("EnrouteRapairs", cls_Report_TripSheet.strEnrouteRapairs.ToString().Trim()));
            parameters.Add(new ReportParameter("Penalty", cls_Report_TripSheet.strPenalty.ToString().Trim()));
            parameters.Add(new ReportParameter("TyrePuncture", cls_Report_TripSheet.strTyrePuncture.ToString().Trim()));
            parameters.Add(new ReportParameter("WeighBridgeExpenses", cls_Report_TripSheet.strWeighBridgeExpenses.ToString().Trim()));

            parameters.Add(new ReportParameter("Parking", cls_Report_TripSheet.strParking.ToString().Trim()));
            parameters.Add(new ReportParameter("Telephone", cls_Report_TripSheet.strTelephone.ToString().Trim()));
            parameters.Add(new ReportParameter("TemporaryPermit", cls_Report_TripSheet.strTemporaryPermit.ToString().Trim()));
            parameters.Add(new ReportParameter("DriverDailyAllowance", cls_Report_TripSheet.strDriverDailyAllowance.ToString().Trim()));

            parameters.Add(new ReportParameter("IncentivePayable", cls_Report_TripSheet.strIncentivePayable.ToString().Trim()));
            parameters.Add(new ReportParameter("OtherExpense", cls_Report_TripSheet.strOtherExpense.ToString().Trim()));
            parameters.Add(new ReportParameter("BrokerCommission", cls_Report_TripSheet.strBrokerCommission.ToString().Trim()));

            //for search criteria

            parameters.Add(new ReportParameter("CreatedFrom", cls_Report_TripSheet.strDateFrom.ToString().Trim()));
            parameters.Add(new ReportParameter("CreatedTo", cls_Report_TripSheet.strDateTo.ToString().Trim()));
            parameters.Add(new ReportParameter("Status", cls_Report_TripSheet.strStatus1.ToString().Trim()));
            parameters.Add(new ReportParameter("Branch", cls_Report_TripSheet.strBranch.ToString().Trim()));
            parameters.Add(new ReportParameter("VehicleNo", cls_Report_TripSheet.strVehicleNo1.ToString().Trim()));
            parameters.Add(new ReportParameter("Driver", cls_Report_TripSheet.strDriver.ToString().Trim()));
            parameters.Add(new ReportParameter("Manual", cls_Report_TripSheet.strManual.ToString().Trim()));
            parameters.Add(new ReportParameter("Tripsheet", cls_Report_TripSheet.strTripsheet.ToString().Trim()));
            parameters.Add(new ReportParameter("DateGNorCL", cls_Report_TripSheet.strDateGNorCL.ToString().Trim()));


            parameters.Add(new ReportParameter("FROM_CITY", cls_Report_TripSheet.strFromCity.ToString().Trim()));
            parameters.Add(new ReportParameter("TO_CITY", cls_Report_TripSheet.strToCity.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_EXP", cls_Report_TripSheet.strACTUAL_EXP.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_LOADUNLOAD", cls_Report_TripSheet.strACTUAL_LOADUNLOAD.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_BROKERAGE", cls_Report_TripSheet.strACTUAL_BROKERAGE.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_REPAIR", cls_Report_TripSheet.strACTUAL_REPAIR.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_OCTROI", cls_Report_TripSheet.strACTUAL_OCTROI.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_DRIVERALLOWANCE", cls_Report_TripSheet.strACTUAL_DRIVERALLOWANCE.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_ClaimsAmt", cls_Report_TripSheet.strACTUAL_ClaimsAmt.ToString().Trim()));
            parameters.Add(new ReportParameter("ACTUAL_TOT_EXP", cls_Report_TripSheet.strACTUAL_TOT_EXP.ToString().Trim()));
            parameters.Add(new ReportParameter("TRIPSHEET_INCOME", cls_Report_TripSheet.strTRIPSHEET_INCOME.ToString().Trim()));
            parameters.Add(new ReportParameter("DriverName2", cls_Report_TripSheet.strDriverName2.ToString().Trim()));
            parameters.Add(new ReportParameter("ConnString", Convert.ToString(Session["SqlProvider"])));
            parameters.Add(new ReportParameter("PrevDriver1", cls_Report_TripSheet.strPrevDriver1.ToString().Trim()));
            parameters.Add(new ReportParameter("PrevDriver2", cls_Report_TripSheet.strPrevDriver2.ToString().Trim()));
            parameters.Add(new ReportParameter("DRIVER_SETTLE_STATUS", cls_Report_TripSheet.strDRIVER_SETTLE_STATUS.ToString().Trim()));
            parameters.Add(new ReportParameter("DRIVER_SETTLE_DT", cls_Report_TripSheet.strDRIVER_SETTLE_DT.ToString().Trim()));
            parameters.Add(new ReportParameter("Company_Code", cls_Report_TripSheet.strCompany.ToString().Trim()));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "Tripsheet";
            
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);

            //LnkRPT1.xml_EmailParameter = XDOC.InnerXml;

            List<MyRSService.ParameterValue> pList = new List<MyRSService.ParameterValue>();
            foreach (ReportParameter rp in parameters)
            {
                MyRSService.ParameterValue p = new MyRSService.ParameterValue();
                p.Name = rp.Name;
                p.Value = "";
                foreach (string s in rp.Values)
                {
                    if (p.Value == "")
                        p.Value = s;
                    else
                        p.Value += "," + s;
                }
                pList.Add(p);
            }

            XmlDocument XDOC = new XmlDocument();
            XmlElement xParameters = XDOC.CreateElement("Parameters");
            foreach (MyRSService.ParameterValue p in pList)
            {
                XmlElement nParameter = XDOC.CreateElement("Parameter");
                XmlElement nName = XDOC.CreateElement("Name");
                nName.InnerText = p.Name;
                nParameter.AppendChild(nName);

                XmlElement nDefaultValues = XDOC.CreateElement("DefaultValues");
                XmlElement nValues = XDOC.CreateElement("Values");
                XmlElement nValue = XDOC.CreateElement("Value");

                //if (p.Name != "Company_Code")
                //    nValue.InnerText = p.Value;
                //else
                //    nValue.InnerText = cls_Report_TripSheet.strCompany.Trim();

                nDefaultValues.AppendChild(nValue);
                nValues.AppendChild(nValue);

                nParameter.AppendChild(nDefaultValues);
                nParameter.AppendChild(nValues);
                xParameters.AppendChild(nParameter);
            }
            XDOC.AppendChild(xParameters);


            //LnkRPT1.xml_EmailParameter = XDOC.InnerXml;
            //TextBox txtReportName = (TextBox)LnkRPT1.FindControl("txtReportName");
            //LnkRPT1.Report_NM =  txtReportName.Text.Trim();
            //LnkRPT1.Report_URL = ReportServiceUtilities.ReportLinkPathPrefix; //+ txtReportName.Text.Trim();



            LnkRPT1.xml_EmailParameter = XDOC.InnerXml;
            LnkRPT1.Report_NM = "SalesRegister_Ver2_1";
            LnkRPT1.Report_URL = ReportServiceUtilities.ReportPathPrefix + "/SalesRegister_Ver2_1";
            //added By Manisha 20/5/2014
            DataTable dtRptInsert = ReportCounter.InsertReportCounter(strhdnRpt, SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  


        }
    }
    protected void imgbtnBack_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("TripsheetQuery.aspx");
    }
}

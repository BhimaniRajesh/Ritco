using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;
using System.Xml;
namespace WebX.Controllers
{

    public class DriverSettlementController:Base
    {
        public DriverSettlementController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable GetDriverSettlementTripsheetDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_DriverSettlement_GetTripsheetDetails",
                new SqlParameter[] { 
                    new SqlParameter("@TripSheetNo", TripsheetNo) 
            }, false).Tables[0];
        }

        public DataTable GetTripsheetEnRouteExpenseDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_DriverSettlement_GetEnRouteExpenseDetails",
                new SqlParameter[] { 
                    new SqlParameter("@TripSheetNo", TripsheetNo) 
            }, false).Tables[0];
        }

        public DataSet GetDriverSettlementDetailsViewPrint(string TripsheetNo)
        {
            return ExecuteDataSet("USP_DriverSettlement_ViewPrint",
                new SqlParameter[] { 
                    new SqlParameter("@TripSheetNo", TripsheetNo) 
            }, false);

        }
		
		public DataSet GetMultiDriverSettlementDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_MultiDriverSettlement_Details",
                new SqlParameter[] {
                    new SqlParameter("@TripSheetNo", TripsheetNo)
            }, false);
        }

        public DataSet GetMultiDriverSettlementDetailsViewPrint(string TripsheetNo)
        {
            return ExecuteDataSet("USP_Multi_DriverSettlement_ViewPrint",
                new SqlParameter[] {
                    new SqlParameter("@TripSheetNo", TripsheetNo)
            }, false);

        }
		
		 public void AutoDriverSettlement(string TripsheetNo, DateTime SettlementDate)
        {
            ExecuteDataSet("USP_DriverSettlement_TripsheetAutoSettlement",
                new SqlParameter[] {
                    new SqlParameter("@TripsheetNo", TripsheetNo),
                    new SqlParameter("@DriverSettleDt", SettlementDate),
					new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
            }, true);

        }
		
		public DataSet GetDriverSettlementTripsheetAmountView(string TripsheetNo)
        {
            return ExecuteDataSet("USP_DriverSettlementTripsheetAmountView",
                new SqlParameter[] {
                    new SqlParameter("@TripSheetNo", TripsheetNo)
            }, false);

        }

        public DataSet GetProtsahanRashiPopUpGridDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_DriverSettlement_GetETHCListForProtsahanRashi",
                new SqlParameter[] {
                    new SqlParameter("@TripSheetNo", TripsheetNo)
            }, false);
        }
    }
}
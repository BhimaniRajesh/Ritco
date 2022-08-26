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
using System.Collections.Generic;
using WebX.Common;

namespace WebX.Controllers
{

    public class NewPODModuleController : Base
    {
        public NewPODModuleController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable GetDocketListForPODUpload(string Location, string FromDate, string ToDate, string DocketNo)
        {
            return ExecuteDataSet("USP_PODUpload_GetDocketList",
                new SqlParameter[] {
                    new SqlParameter("@Location", Location),
                    new SqlParameter("@FromDate", FromDate),
                    new SqlParameter("@ToDate", ToDate),
                    new SqlParameter("@DocketNo", DocketNo)
            }, false).Tables[0];
        }

        public void DocketPODUpload(string DocketListXML)
        {
            ExecuteDataSet("USP_PODUpload_Entry",
                new SqlParameter[] {
                    new SqlParameter("@DocketListXML", DocketListXML),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID),

            }, true);
        }

        public DataTable GetDocketListForPODHandOver(string Location, string FromDate, string ToDate, string DocketNo)
        {
            // return ExecuteDataSet("USP_PODHandover_GetDocketList",
                // new SqlParameter[] {
                    // new SqlParameter("@Location", Location),
                    // new SqlParameter("@FromDate", FromDate),
                    // new SqlParameter("@ToDate", ToDate),
                    // new SqlParameter("@DocketNo", DocketNo)
            // }, false).Tables[0];
			using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ToString()))
            {
                SqlDataAdapter adapter;
                DataSet ds = new DataSet();
                connection.Open();
                SqlCommand command = new SqlCommand("USP_PODHandover_GetDocketList", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@Location", Location));
                command.Parameters.Add(new SqlParameter("@FromDate", FromDate));
                command.Parameters.Add(new SqlParameter("@ToDate", ToDate));
                command.Parameters.Add(new SqlParameter("@DocketNo", DocketNo));
                // Setting command timeout to 1 second  
                command.CommandTimeout = 300;
                try
                {

                    adapter = new SqlDataAdapter(command);
                    adapter.Fill(ds);
                }
                catch (Exception e)
                {
                    throw e;
                }
                finally
                {
                    connection.Close();
                }

                return ds.Tables[0];
            }
        }

        public DataTable DocketPODHandover(string DocketListXML)
        {
            return ExecuteDataSet("USP_PODHandover_Insert",
                 new SqlParameter[] {
                    new SqlParameter("@DocketListXML", DocketListXML),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID),
                    new SqlParameter("@EntryBranch", SessionUtilities.CurrentBranchCode)
             }, true).Tables[0];
        }

        public DataTable GetDocketListForPODHandOverReprint(string Location, string FromDate, string ToDate, string HandoverNo)
        {
            return ExecuteDataSet("USP_PODHandover_GetRePrintList",
                new SqlParameter[] {
                    new SqlParameter("@Location", Location),
                    new SqlParameter("@FromDate", FromDate),
                    new SqlParameter("@ToDate", ToDate),
                    new SqlParameter("@PDHNo", HandoverNo)
            }, false).Tables[0];
        }

        public DataTable PODExceptionDocketDetails(string DocketNo)
        {
            return ExecuteDataSet("USP_PODUploadException_DocketDetails",
                 new SqlParameter[] {
                    new SqlParameter("@DocketNo", DocketNo)
             }, true).Tables[0];
        }

        public void PODExceptionUploadPOD(string DocketNo,string POD)
        {
             ExecuteDataSet("USP_PODUploadException_DocketPODUpload",
                 new SqlParameter[] {
                    new SqlParameter("@DocketNo", DocketNo),
                    new SqlParameter("@POD", POD),
             }, true);
        }

        public DataTable GetDocketListForReportingUnloadingDeviation(string Location, string FromDate, string ToDate)
        {
            return ExecuteDataSet("USP_DocketReportingUnloadingDeviation_GetDocketDetails",
                new SqlParameter[] {
                    new SqlParameter("@Location", Location),
                    new SqlParameter("@FromDate", FromDate),
                    new SqlParameter("@ToDate", ToDate)
            }, false).Tables[0];
        }

        public void DocketReportingUnloadingDeviationEntry(string DocketList, string Status)
        {
            ExecuteDataSet("USP_DocketReportingUnloadingDeviation_Entry",
                new SqlParameter[] {
                    new SqlParameter("@DeviationList", DocketList),
                    new SqlParameter("@Status", Status),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
            }, true);
        }

        #region POD HandOver Acknowledgement - Added By Juhi Patel 22 Oct 2019 1:22 PM (P008303)

        public void ArrivalUpdateDocketPODUpload(string DocketListXML)
        {
            ExecuteDataSet("USP_ArrivalUpdate_DocketPODUpload",
                new SqlParameter[] {
                    new SqlParameter("@DocketListXML", DocketListXML),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID),

            }, true);
        }


        public DataTable GetPODHandOverNumber(string HO, string RO, string Location, string FromDate, string ToDate, string PODHandOverNo)
		{
			return ExecuteDataSet("USP_PODHandOverAcknowledgement_GetPODHandOverNoList",
				new SqlParameter[] {
					new SqlParameter("@HO", HO),
					new SqlParameter("@RO", RO),
					new SqlParameter("@Location", Location),
					new SqlParameter("@FromDate", FromDate),
					new SqlParameter("@ToDate", ToDate),
					new SqlParameter("@PODHandOverNo", PODHandOverNo)
			}, false).Tables[0];
		}

		public DataTable DocketPODHandOverAcknowledgement(List<PODHandOverAcknowledgement> objPODHandOverAcknowledgement)
		{
			return ExecuteDataSet("USP_PODHandOverAcknowledgement_Insert",
				 new SqlParameter[] {
					 new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objPODHandOverAcknowledgement)),
			new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID),
			new SqlParameter("@EntryBranch", SessionUtilities.CurrentBranchCode),
			 }, true).Tables[0];
		}

		public DataTable GetDocketListForPODHandOverAcknowledgement(string PODNo)
		{
			return ExecuteDataSet("USP_PODHandOverAcknowledgement_GetDocketList",
			new SqlParameter[] {
			 new SqlParameter("@PODNo", PODNo)
			}, false).Tables[0];
		}
		#endregion POD HandOver Acknowledgement 
		
		public DataTable GetAllLocationLoginBranchWise(string CurrBrcd, string MainBrcd)
        {
            return ExecuteDataSet("usp_WorkingLocations_MVC",
                new SqlParameter[] {
                    new SqlParameter("@curr_brcd", CurrBrcd),
                    new SqlParameter("@main_brcd", MainBrcd),
            }, false).Tables[0];
        }

	}
}
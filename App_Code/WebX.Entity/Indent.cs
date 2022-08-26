using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for Indent
/// </summary>
public class Indent
{
    public Indent()
    {

    }
    /// <summary>
    /// Header
    /// </summary>
    public string ProposedIndentNumber { get; set; }
    public string IndentNumber { get; set; }
    public string IssuingBranch { get; set; }
    public DateTime IndentDate { get; set; }
    public string Warehouse { get; set; }
    public string Finalized { get; set; }
    public string FinalizedBy { get; set; }
    public DateTime FinalizedDate { get; set; }
    public string EntryBy { get; set; }
    public string GrNumber { get; set; }
    public string Status { get; set; }

    /// <summary>
    /// Details
    /// </summary>
    public List<Indent> Details { get; set; }
    public string DocketNumber { get; set; }
    public string Location { get; set; }
    public string DeliveryPartyName { get; set; }
    public string BillingPartyName { get; set; }
    public string MobileNumber { get; set; }
    public string Remarks { get; set; }
    public int Packages { get; set; }
    public int PendingPackages { get; set; }
    public int DeliveredPackages { get; set; }
    public int TotalPackages { get; set; }
    public string Material { get; set; }
    public string FromCity { get; set; }
    public string ToCity { get; set; }
    public string BookingDeatination { get; set; }
    public string CustomerRefrence { get; set; }
    public string Consignor { get; set; }
    public string Consignee { get; set; }
    public string Weight { get; set; }
    public string DeliveryLocation { get; set; }
    public string IsSystemDocket { get; set; }
}
public class Location
{
    public string LocationCode { get; set; }
    public string LocationName { get; set; }
}
public class IndentController : Base
{
    /// <summary>
    /// Check Docket Number in System Or Not For Indent Entry
    /// </summary>
    /// <param name="strDocket"></param>
    /// <returns></returns>
    public DataTable CheckDocketNumber(string strDocket)
    {
        return ExecuteDataTable("Usp_Check_Docket",
                new SqlParameter[] 
                    {                       
                        new SqlParameter("@Docket", strDocket)
                    });
    }
    /// <summary>
    /// Check Proposed Indent Number in System Or Not For Indent Entry
    /// </summary>
    /// <param name="stProposedIndentNumber"></param>
    /// <returns></returns>
    public DataTable CheckValidProposedIndentNumber(string stProposedIndentNumber)
    {
        return ExecuteDataTable("Usp_Check_ProposedIndentNumber",
                new SqlParameter[] 
                    {                       
                        new SqlParameter("@ProposedIndentNumber", stProposedIndentNumber)
                    });
    }
    /// <summary>
    /// Search Proposed Indent Number in System Or Not For Indent Entry
    /// </summary>
    /// <param name="stProposedIndentNumber"></param>
    /// <returns></returns>
    public DataTable SearchProposedIndentNumber(string stProposedIndentNumber)
    {
        return ExecuteDataTable("Usp_Search_ProposedIndentNumber",
                new SqlParameter[] 
                    {                       
                        new SqlParameter("@ProposedIndentNumber", stProposedIndentNumber)
                    });
    }
    /// <summary>
    /// Get Header/Details Proposed Entry Details
    /// </summary>
    /// <param name="stProposedIndentNumber"></param>
    /// <returns></returns>
    public DataTable GetHeaderDetailsProposedIndentNumber(string stProposedIndentNumber)
    {
        return ExecuteDataTable("Usp_Get_Indent_HeaderDetails",
                new SqlParameter[] 
                    {                       
                        new SqlParameter("@ProposedIndentNumber", stProposedIndentNumber)
                    });
    }
    /// <summary>
    /// Get Proposed Indent Number
    /// </summary>
    /// <param name="IndentType">IndentType</param>
    /// <returns></returns>
    public object GetProposedNumber(string IndentType)
    {
        return ExecuteScalar("Usp_Get_Indent_Number",
                new SqlParameter[] 
                    {                       
                       new SqlParameter("@IndentType", IndentType),
                        new SqlParameter("@FinncialYear", SessionUtilities.FinYear),
                        new SqlParameter("@Location", SessionUtilities.CurrentBranchCode)
                    });
    }
    /// <summary>
    /// Insert Proposed Indent Entry
    /// </summary>
    public string InsertIndent(Indent objIndent)
    {
        string stPrposedIndentNo = string.Empty;
        try
        {
            stPrposedIndentNo = InsertHelper("Indent", "USP_Proposed_Indent_Entry",
                new SqlParameter[] {
                new SqlParameter("@xmlIndent", XmlUtility.XmlSerializeToString(objIndent)) });
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "Indent Entry");
        }
        return stPrposedIndentNo;
    }
    public DataTable GetListingForCancellation(string stFromDate, string stToDate, string stIndentNumber)
    {
        return ExecuteDataTable("Usp_Listing_Indent_Details_Cancellation",
            new SqlParameter[] { new SqlParameter("@FromDate", stFromDate),
                                 new SqlParameter("@ToDate", stToDate),
                                 new SqlParameter("@IndentNo", stIndentNumber) });
    }
    /// <summary>
    /// Insert Proposed Indent Entry
    /// </summary>
    public string CancelIndent(string stIndentNumber, string stCancelReason, string stCancelledOn)
    {
        string stPrposedIndentNo = string.Empty;
        try
        {
            stPrposedIndentNo = InsertHelper("Indent", "USP_Cancel_Proposed_Indent",
                new SqlParameter[] {new SqlParameter("@IndentNumber", stIndentNumber),
                                    new SqlParameter("@CancelReason", stCancelReason),
                                    new SqlParameter("@CancelledOn", stCancelledOn),
                                    new SqlParameter("@CancelledBy", SessionUtilities.CurrentEmployeeID) });
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "Indent Cancellation");
        }
        return stPrposedIndentNo;
    }
    /// <summary>
    /// Check Docket Number and Proposed Indent in System Or Not For Indent Entry
    /// </summary>
    /// <param name="strDocket"></param>
    /// /// <param name="stPIndents"></param>
    /// <returns></returns>
    public DataTable CheckDocketNumberWithPIndent(string strDocket, string stPIndent)
    {
        return ExecuteDataTable("Usp_Check_Docket_With_Indent",
                new SqlParameter[] 
                    {                       
                        new SqlParameter("@Docket", strDocket),
                        new SqlParameter("@PIndentNo", stPIndent)
                    });
    }


    /// <summary>
    /// IndentList
    /// </summary>
    /// <param name="strRo"></param>
    /// <param name="strLo"></param>
    /// <param name="strFromDate"></param>
    /// <param name="strToDate"></param>
    /// <param name="objIndent"></param>
    /// <returns></returns>
    public DataTable IndentList(string strRo, string strLo, string strFromDate, string strToDate, Indent objIndent)
    {
        return ExecuteDataTable("USP_Indent_IndentLists",
                new SqlParameter[] {new SqlParameter("@Ro", strRo),
                                    new SqlParameter("@LO", strLo),
                                    new SqlParameter("@FromDate", strFromDate),
                                    new SqlParameter("@ToDate", strToDate),
                                    new SqlParameter("@IndentNo", objIndent.IndentNumber)
                                   });
    }

    /// <summary>
    /// Final Indent PendingdDetails
    /// </summary>
    /// <param name="strRo"></param>
    /// <param name="strLo"></param>
    /// <param name="strFromDate"></param>
    /// <param name="strToDate"></param>
    /// <param name="objIndent"></param>
    /// <returns></returns>
    public DataTable FinalIndentPendingdDetails(string strRo, string strLo, string strFromDate, string strToDate, Indent objIndent)
    {
        return ExecuteDataTable("USP_Indent_FinalIndentPendingDetails",
                new SqlParameter[] {new SqlParameter("@Ro", strRo),
                                    new SqlParameter("@LO", strLo),
                                    new SqlParameter("@FromDate", strFromDate),
                                    new SqlParameter("@ToDate", strToDate),
                                    new SqlParameter("@IndentNo", objIndent.IndentNumber)
                                   });
    }


    /// <summary>
    /// Final Indent PendingdDetails Gr Wise
    /// </summary>
    /// <param name="strRo"></param>
    /// <param name="strLo"></param>
    /// <param name="strFromDate"></param>
    /// <param name="strToDate"></param>
    /// <param name="objIndent"></param>
    /// <returns></returns>
    public DataTable FinalIndentPendingdDetailsGrWise(string strRo, string strLo, string strFromDate, string strToDate, Indent objGr)
    {
        return ExecuteDataTable("USP_Indent_FinalIndentPendingDetailsGrWise",
                new SqlParameter[] {new SqlParameter("@Ro", strRo),
                                    new SqlParameter("@LO", strLo),
                                    new SqlParameter("@FromDate", strFromDate),
                                    new SqlParameter("@ToDate", strToDate),
                                    new SqlParameter("@GrNo", objGr.GrNumber)
                                   });
    }


    /// <summary>
    /// FinalIndentPendingDoketDetails
    /// </summary>
    /// <param name="objIndent"></param>
    /// <returns></returns>
    public DataTable FinalIndentPendingDoketDetails(Indent objIndent)
    {
        return ExecuteDataTable("USP_Indent_FinalIndentPendingDocketDetails",
                new SqlParameter[] { new SqlParameter("@IndentNo", objIndent.IndentNumber) });
    }

    /// <summary>
    /// FinalGRPendingDoketDetails
    /// </summary>
    /// <param name="objIndent"></param>
    /// <returns></returns>
    public DataTable FinalGRPendingDoketDetails(Indent objGR)
    {
        return ExecuteDataTable("USP_Indent_FinalGrPendingDocketDetails",
                new SqlParameter[] { new SqlParameter("@GrNo", objGR.GrNumber) });
    }

    public List<Location> GetLocationList(string searchText)
    {
        return ExecuteDataTable("Usp_Indent_GetLocationist", new SqlParameter[] 
            { 
                new SqlParameter("@Location", searchText)              
            }).ToList<Location>();
    }

    public string IsExistLocation(string LocationName)
    {
        return Convert.ToString(ExecuteScalar("Usp_Indent_IsExistLocation", new[]
            { 
                new SqlParameter("@Location",LocationName)
            }));
    }

    /// <summary>
    /// Execution Indent Details
    /// </summary>
    /// <param name="strFromDate"></param>
    /// <param name="strToDate"></param>
    /// <param name="objIndent"></param>
    /// <returns></returns>
    public DataTable ExecutionIndentDetails(string strFromDate, string strToDate, Indent objIndent)
    {
        return ExecuteDataTable("USP_Indent_ExecutionIndentDetails",
                new SqlParameter[] {new SqlParameter("@FromDate", strFromDate),
                                    new SqlParameter("@ToDate", strToDate),
                                    new SqlParameter("@IndentNo", objIndent.IndentNumber),
                                    new SqlParameter("@DocketNo", objIndent.DocketNumber),
                                    new SqlParameter("@DeliveryPartyName", objIndent.DeliveryPartyName),
                                    new SqlParameter("@BillingPartyName", objIndent.BillingPartyName),
                                    new SqlParameter("@Status", objIndent.Status)
                                   });
    }
}
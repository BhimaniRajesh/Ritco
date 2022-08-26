using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using WebX.Common;

/// <summary>
/// Summary description for TripSheetAuditController
/// </summary>
public class TripSheetAuditController : Base
{
	public TripSheetAuditController()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// TripSheet Detail for Audit
    /// </summary>
    /// <param name="fromDate"> From date</param>
    /// <param name="toDate"> To Date </param>
    /// <param name="brcd"> Location</param>
    /// <param name="tripSheetNo"> TripSheet No</param>
    /// <returns> Financial Closed Trip Sheet list</returns>
    public DataTable getTripSheetDetail(string fromDate,string toDate,string brcd,string tripSheetNo)
    {
       return ExecuteDataSet("usp_GetTripsheet_for_audit",new SqlParameter[]{new SqlParameter("@FromDate",fromDate),new SqlParameter("@ToDate",toDate),
            new SqlParameter("@brcd",brcd),new SqlParameter("@tripSheet",tripSheetNo)}).Tables[0];
       
       

    }

    /// <summary>
    /// TripSheet Detail for Deviation Audit
    /// </summary>
    /// <param name="fromDate"> From date</param>
    /// <param name="toDate"> To Date </param>
    /// <param name="brcd"> Location</param>
    /// <param name="tripSheetNo"> TripSheet No</param>
    /// <returns> Panding Audit Trip Sheet list</returns>
    public DataTable getPandingAuditTripSheetDetail(string fromDate, string toDate, string brcd, string tripSheetNo)
    {
        return ExecuteDataSet("usp_GetTripsheet_for_DeviationAudit", new SqlParameter[]{new SqlParameter("@FromDate",fromDate),new SqlParameter("@ToDate",toDate),
            new SqlParameter("@brcd",brcd),new SqlParameter("@tripSheet",tripSheetNo)}).Tables[0];



    }

    /// <summary>
    /// Insert TripSheet Audit Data
    /// </summary>
    /// <param name="objTriplst"> List object</param>
    /// <param name="brcd">Location</param>
    /// <returns></returns>
    public string insertTripSheetAudit(List<TripsheetAudit> objTriplst, string brcd)
    {
        return InsertHelper("Trip", "Usp_Fleet_Insert_TripsheetAudit", new SqlParameter[]{new SqlParameter("@xmlTripList",XmlUtility.XmlSerializeToString(objTriplst)),new SqlParameter("@Location",brcd),
            new SqlParameter("@entryBy",SessionUtilities.CurrentEmployeeID)});
    }

    /// <summary>
    /// Insert TripSheet Deviation Audit Data
    /// </summary>
    /// <param name="objTriplst"> List object</param>
    /// <param name="brcd">Location</param>
    /// <returns></returns>
    public string insertTripSheetDeviationAudit(List<TripsheetAudit> objTriplst, string brcd)
    {
        return InsertHelper("Trip", "Usp_Fleet_Insert_DeviationTripsheetAudit", new SqlParameter[]{new SqlParameter("@xmlTripList",XmlUtility.XmlSerializeToString(objTriplst)),new SqlParameter("@Location",brcd),
            new SqlParameter("@entryBy",SessionUtilities.CurrentEmployeeID)});
    }
}
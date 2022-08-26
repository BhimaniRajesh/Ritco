using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TripsheetAudit
/// </summary>
public class TripsheetAudit
{
	public TripsheetAudit()
	{
		TripSheetNo= string.Empty;
        AuditLocation= string.Empty;
        AuditRemark= string.Empty;
        IsSelect= string.Empty;
        IsPending= string.Empty;
        IsDeviation= string.Empty;
        DeviationLocation= string.Empty;
        DeviationRemark = string.Empty;
        TripSheetStatus = string.Empty;
        IsKeepPending = string.Empty;
	}
    public string TripSheetNo { get; set; }
    public string AuditLocation { get; set; }
    public string AuditRemark { get; set; }
    public string IsSelect { get; set; }
    public string IsPending { get; set; }
    public string IsDeviation { get; set; }
    public string IsKeepPending { get; set; }
    public string DeviationLocation { get; set; }
    public string DeviationRemark { get; set; }
    public string TripSheetStatus { get; set; }
   
}
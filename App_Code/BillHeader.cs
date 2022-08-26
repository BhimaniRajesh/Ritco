using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BillHeader
/// </summary>
public class BillHeader : Base
{
    public BillHeader()
    {
        BillNo = "";
    }

    public string BillNo { get; set; }
    public string PartyCode { get; set; }
    public string TrnMode { get; set; }
    public string BusinessType { get; set; }
    public DateTime FromDate { get; set; }
    public DateTime ToDate { get; set; }

    public void GenerateBill(string strXml)
    {
        var prm = new SqlParameter[] 
         {
             new SqlParameter("@XML", strXml),
             new SqlParameter("@Location", Location),
             new SqlParameter("@EntryBy", EntryBy) ,
             new SqlParameter("@FinYear", FinYear) ,
             //new SqlParameter("@CompanyCode", CompanyCode) ,
             new SqlParameter("@FromDate", FromDate) ,
             new SqlParameter("@ToDate", ToDate) 
         };
        BillNo = InsertHelper("Bill", "Usp_Bill_Generation", prm);
    }

    public DataSet GetSummary()
    {
        var prmList = new SqlParameter[]
        {
            new SqlParameter("@Location", Location),
            new SqlParameter("@FromDate", FromDate),
            new SqlParameter("@ToDate", ToDate),
            new SqlParameter("@PartyCode", PartyCode) 
        };
        return ExecuteDataSet("Usp_Get_Summary_For_Bill_Generation", prmList);
    }

    public DataTable GetDocketList()
    {
        var prmList = new SqlParameter[]
        {
            new SqlParameter("@Location", Location),
            new SqlParameter("@FromDate", FromDate),
            new SqlParameter("@ToDate", ToDate),
            new SqlParameter("@PartyCode", PartyCode),
            new SqlParameter("@TrnMode", TrnMode),
            new SqlParameter("@BusinessType", BusinessType)
        };
        return ExecuteDataTable("Usp_Get_Details_For_Bill_Generation", prmList);
    }

    public DataTable GetBillDetailsForDonePageListing()
    {
        var prmList = new SqlParameter[4];
        prmList[0] = new SqlParameter("@BillNo", BillNo);
        return ExecuteDataTable("Usp_Get_Bill_Details", prmList);
    }

    public bool IsModuleRuleActive(string moduleId, string ruleId)
    {
        var prmList = new SqlParameter[2];
        prmList[0] = new SqlParameter("@ModuleId", moduleId);
        prmList[1] = new SqlParameter("@RuleId", ruleId);
        return (ExecuteScalar("Usp_Get_Module_Rule_By_Id", prmList).ToString() == "Y");
    }
}


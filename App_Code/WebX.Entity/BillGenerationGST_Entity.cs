using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BillGenerationGST_Entity
/// </summary>
public class BillGenerationGST_Entity
{
    public string CustomerCode = string.Empty;
    public string Location = string.Empty;
    public string CompanyCode = string.Empty;
    public string FromDate = string.Empty;
    public string ToDate = string.Empty;
    public string Paybas = string.Empty;
    public string ServiceType = string.Empty;
    public string ProductType = string.Empty;
    public string SACType = string.Empty;
    public string FinYear = string.Empty;
    public bool InterState = false;
    public bool ITC = false;
    public decimal GSTRate = 0;
    public string CustomerGSTIN = string.Empty;
    public string TransporterGSTIN = string.Empty;
    public string GeneratedBy = string.Empty;
    public string BusinessType = string.Empty;


    public string InvoiceNumber = string.Empty;
    public string BillingAddress = string.Empty;
    public string GenerationDate = string.Empty;
    public string DueDate = string.Empty;

    public string BillGenerationState = string.Empty;
    public string BillGenerationCity = string.Empty;
    public string BillGenerationGSTINNumber = string.Empty;
    public string BillGenerationLocation = string.Empty;
    public string BillGenerationStateType = string.Empty;

    public string BillSubmissionState = string.Empty;
    public string BillSubmissionCity = string.Empty;
    public string BillSubmissionGSTINNumber = string.Empty;
    public string BillSubmissionLocation = string.Empty;
    public string BillSubmissionStateType = string.Empty;

    public string BillCollectionState = string.Empty;
    public string BillCollectionCity = string.Empty;
    public string BillCollectionGSTINNumber = string.Empty;
    public string BillCollectionLocation = string.Empty;
    public string BillCollectionStateType = string.Empty;

    public int DockCount = 0;
    public decimal SummarySubTotal = 0;
    public decimal SummarySGST = 0;
    public decimal SummaryUTGST = 0;
    public decimal SummaryCGST = 0;
    public decimal SummaryIGST = 0;
    public decimal SummaryGSTTotal = 0;
    public decimal SummaryTotal = 0;

    public BillGenerationGST_Entity()
    {

    }
    public List<BillGenerationGST_TransactionDetail> TransactionDetails;
}
/// <summary>
/// For Docket Details
/// </summary>
public class BillGenerationGST_TransactionDetail
{
    public BillGenerationGST_TransactionDetail()
    {

    }

    public string TransactionID = string.Empty;
    public string TransactionDate = string.Empty;
    public string FromCityState = string.Empty;
    public string ToCityState = string.Empty;
    public string Origin = string.Empty;
    public string Destination = string.Empty;
    public decimal SubTotal = 0;
    public decimal GSTAmount = 0;
    public decimal Total = 0;
    public string SACCode = string.Empty;
    public string ReportingDate = string.Empty;
    public string UnloadingDate = string.Empty;
    public string DeviationRemarks = string.Empty;
    public decimal MiscCharge = 0;
    public decimal DocketAmount = 0;
    public List<BillGenerationGST_TransactionDetail> ListItems = new List<BillGenerationGST_TransactionDetail>();
}
/// <summary>
/// For GST Rate
/// </summary>
public class BillGenerationGST_GstRate
{
    public double GstRate = 0.0;
}
/// <summary>
/// For State Validation by Service
/// </summary>
public class BillGenerationGST_StateValidation
{
    public string CountFlag = string.Empty;
    public string StateCode = string.Empty;
    public string StateType = string.Empty;
}
/// <summary>
/// For City Validation by Service
/// </summary>
public class BillGenerationGST_CityValidation
{
    public string CountFlag = string.Empty;
    public string CityCode = string.Empty;
}
/// <summary>
/// For Account Validation by Service
/// </summary>
public class BillGenerationGST_AccCodeValidation
{
    public string CountFlag = string.Empty;
    public string AccCode = string.Empty;
    public string AccDesc = string.Empty;
}
/// <summary>
/// Get Customer State by Service
/// </summary>
public class BillGenerationGST_CustomerState
{
    public string Code = string.Empty;
    public string Name = string.Empty;
}

/// <summary>
/// For Ledger Details
/// </summary>
public class BillGenerationGST_LedgerDetails
{
    public string Ledger = string.Empty;
    public string SubLedger = string.Empty;
    public string Debit = string.Empty;
    public string Credit = string.Empty;
    public List<BillGenerationGST_LedgerDetails> ListItems = new List<BillGenerationGST_LedgerDetails>();
}
/// <summary>
/// For Supply Bill Details
/// </summary>
public class BillGenerationGST_GeneralBill
{
    public string CustomerCode = string.Empty;
    public string BillingAddress = string.Empty;
    public string InvoiceDate = string.Empty;
    public string DueDate = string.Empty;
    public string Location = string.Empty;
    public string FinYear = string.Empty;
    public string CompanyCode = string.Empty;

    public string BillGenerationState = string.Empty;
    public string BillGenerationCity = string.Empty;
    public string BillGenerationLocation = string.Empty;
    public string BillGenerationStateType = string.Empty;
    public string BillGenerationGSTIN = string.Empty;

    public string BillSubmissionState = string.Empty;
    public string BillSubmissionCity = string.Empty;
    public string BillSubmissionLocation = string.Empty;
    public string BillSubmissionStateType = string.Empty;
    public string BillSubmissionGSTIN = string.Empty;

    public string BillCollectionState = string.Empty;
    public string BillCollectionCity = string.Empty;
    public string BillCollectionLocation = string.Empty;
    public string BillCollectionStateType = string.Empty;
    public string BillCollectionGSTIN = string.Empty;

    public string InterState = string.Empty;

    public Int32 ItemCount = 0;
    public double SubTotal = 0.00;
    public double SGSTAmount = 0.00;
    public double UGSTAmount = 0.00;
    public double CGSTAmount = 0.00;
    public double IGSTAmount = 0.00;
    public double GSTToal = 0.00;
    public double TotalAmount = 0.00;

    public List<BillGenerationGST_AccountDetails> ListItems = new List<BillGenerationGST_AccountDetails>();

    public string EntryBy = string.Empty;
    public string EntryDate = string.Empty;

}
/// <summary>
///  For Account Ledger Details
/// </summary>
public class BillGenerationGST_AccountDetails
{
    public string AccCode = string.Empty;
    public string AccDesc = string.Empty;
    public string SACType = string.Empty;
    public string Narration = string.Empty;
    public string ServiceType = string.Empty;
    public string ProductType = string.Empty;
    public string SACCode = string.Empty;
    public string SACCategory = string.Empty;
    public double Amount = 0.00;
    public double GSTRate = 0.00;
    public double GSTAmount = 0.00;
    public double TotalAmount = 0.00;
}
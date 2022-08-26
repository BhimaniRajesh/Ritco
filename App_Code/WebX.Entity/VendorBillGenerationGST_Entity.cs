using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VendorBillGenerationGST_Entity
/// </summary>
public class VendorBillGenerationGST_Entity
{   
    public string VendorCode = string.Empty;
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

    public string SupplyState = string.Empty;
    public string SupplyCity = string.Empty;
    public string SupplyGSTINNumber = string.Empty;
    public string SupplyAddress = string.Empty;
    public string SupplyLocation = string.Empty;
    public string SupplyStateType = string.Empty;

    public string BookingState = string.Empty;
    public string BookingCity = string.Empty;
    public string BookingGSTINNumber = string.Empty;
    public string BookingAddress = string.Empty;
    public string BookingLocation = string.Empty;
    public string BookingStateType = string.Empty;
    public string RegisteredYN = string.Empty;


    public int DockCount = 0;
    public decimal SummarySubTotal = 0;
    public decimal SummarySGST = 0;
    public decimal SummaryUTGST = 0;
    public decimal SummaryCGST = 0;
    public decimal SummaryIGST = 0;
    public decimal SummaryGSTTotal = 0;
    public decimal SummaryTotal = 0;

    public VendorBillGenerationGST_Entity()
    {

    }
    public List<BillGenerationGST_TransactionDetail> TransactionDetails;
}
/// <summary>
/// For Docket Details
/// </summary>
public class VendorBillGenerationGST_TransactionDetail
{
    public VendorBillGenerationGST_TransactionDetail()
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
    public List<BillGenerationGST_TransactionDetail> ListItems = new List<BillGenerationGST_TransactionDetail>();
}
/// <summary>
/// For GST Rate
/// </summary>
public class VendorBillGenerationGST_GstRate
{
    public double GstRate = 0.0;
}
/// <summary>
/// For State Validation by Service
/// </summary>
public class VendorBillGenerationGST_StateValidation
{
    public string CountFlag = string.Empty;
    public string StateCode = string.Empty;
    public string StateType = string.Empty;
}
/// <summary>
/// For City Validation by Service
/// </summary>
public class VendorBillGenerationGST_CityValidation
{
    public string CountFlag = string.Empty;
    public string CityCode = string.Empty;
}
/// <summary>
/// For Account Validation by Service
/// </summary>
public class VendorBillGenerationGST_AccCodeValidation
{
    public string CountFlag = string.Empty;
    public string AccCode = string.Empty;
    public string AccDesc = string.Empty;
}
/// <summary>
/// Get Customer State by Service
/// </summary>
public class VendorBillGenerationGST_CustomerState
{
    public string Code = string.Empty;
    public string Name = string.Empty;
}

/// <summary>
/// For Ledger Details
/// </summary>
public class VendorBillGenerationGST_LedgerDetails
{
    public string Ledger = string.Empty;
    public string SubLedger = string.Empty;
    public string Debit = string.Empty;
    public string Credit = string.Empty;
    public List<VendorBillGenerationGST_LedgerDetails> ListItems = new List<VendorBillGenerationGST_LedgerDetails>();
}
/// <summary>
/// For Supply Bill Details
/// </summary>
public class VendorBillGenerationGST_GeneralBill
{
    public string VendorCode = string.Empty;
    public string ManualBillNo = string.Empty;
    public string BillingAddress = string.Empty;
    public string InvoiceBookingDate = string.Empty;
    public string VendorInvoiceDate = string.Empty;
    public string DueDate = string.Empty;
    public string Location = string.Empty;
    public string FinYear = string.Empty;
    public string CompanyCode = string.Empty;
    public string PANNo = string.Empty;

    public string BillVendorState = string.Empty;
    public string BillVendorCity = string.Empty;
    public string BillVendorLocation = string.Empty;
    public string BillVendorStateType = string.Empty;
    public string BillVendorGSTIN = string.Empty;
    public string BillVendorAddress = string.Empty;

    public string BillBookingState = string.Empty;
    public string BillBookingCity = string.Empty;
    public string BillBookingLocation = string.Empty;
    public string BillBookingStateType = string.Empty;
    public string BillBookingGSTIN = string.Empty;
    public string BillBookingAddress = string.Empty;

    public string InterState = string.Empty;
    public string RegisteredYN = string.Empty;

    public Int32 ItemCount = 0;
    public double SubTotal = 0.00;
    public double SGSTAmount = 0.00;
    public double UGSTAmount = 0.00;
    public double CGSTAmount = 0.00;
    public double IGSTAmount = 0.00;
    public double GSTToal = 0.00;
    public double TotalAmount = 0.00;
    //Added TDS Section
    public double TDSAmount = 0.00;
    public double TDSRate = 0.00;
    public string TDSSection = string.Empty;

    public List<VendorBillGenerationGST_AccountDetails> ListItems = new List<VendorBillGenerationGST_AccountDetails>();

    public string EntryBy = string.Empty;
    public string EntryDate = string.Empty;
    
}
/// <summary>
///  For Account Ledger Details
/// </summary>
public class VendorBillGenerationGST_AccountDetails
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
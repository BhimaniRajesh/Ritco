using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VendorBillGenerationGST_Entity
/// </summary>
public class GeneralizePOGST_Entity
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
    public double GSTRate = 0;
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
    public double SummarySubTotal = 0;
    public double SummarySGST = 0;
    public double SummaryUTGST = 0;
    public double SummaryCGST = 0;
    public double SummaryIGST = 0;
    public double SummaryGSTTotal = 0;
    public double SummaryTotal = 0;

    public GeneralizePOGST_Entity()
    {

    }
    
}

/// <summary>
/// For GST Rate
/// </summary>
public class GeneralizePOGST_GstRate
{
    public double GstRate = 0.0;
    public bool IsRcmApplicable = false;
}


public class GeneralizePOGST_PoHeader
{
    public string POCode = string.Empty;
    public string PODate = string.Empty;
    public string ManualPOCode = string.Empty;
    public string VendorCode = string.Empty;
    public string VendorName = string.Empty;
    public int TotalQty = 0;
    public double Amount = 0;
    public double DiscountAmount = 0;
    public string Attn = string.Empty;
    public string POStatus = string.Empty;
    public double PendAmount = 0;
    public string Brcd = string.Empty;
    public string ChqDate = string.Empty;
    public string ChqNo = string.Empty;
    public string PayMode = string.Empty;
    public double PaidAmount = 0;
    public string TermsCondition = string.Empty;
    public double ChqAmount = 0;
    public double CashAmount = 0;
    public double PO_Adv_Amount = 0;
    public double PO_Bal_Amount = 0;
    public string BankAccode = string.Empty;
    public string CashAccode = string.Empty;
    public string CompanyCode = string.Empty;
    public string AccCode = string.Empty;
    public string AccDesc = string.Empty;
    public string MaterialCategory = string.Empty;
    
    public string FinYear = string.Empty;
    public bool InterState = false;

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
    public string RegisteredYN = string.Empty;
    public string GSTChargedType = string.Empty;


    public Int32 ItemCount = 0;
    public double SubTotal = 0.00;
    public double SGSTAmount = 0.00;
    public double UGSTAmount = 0.00;
    public double CGSTAmount = 0.00;
    public double IGSTAmount = 0.00;
    public double GSTTotal = 0.00;
    public double Total = 0.00;

    public string GstExemptedCategory = string.Empty;
    public string GstExemptedFilePath = string.Empty;
    public string GstExemptedFileName = string.Empty;

    public List<GeneralizePOGST_PoDetails> ListItems = new List<GeneralizePOGST_PoDetails>();

    public string EntryBy = string.Empty;
    public string EntryDate = string.Empty;
}

public class GeneralizePOGST_PoDetails
{
    public bool IsGstExempted = false;
    //public bool IsTdsExempted = false;
    public bool IsGoodsProduct = false;
    public string SACCode = string.Empty;
    public string SACCategory = string.Empty;
    public string HSNCode = string.Empty;
    public string POCode = string.Empty;
    public string PODate = string.Empty;
    public string AssetCd = string.Empty;
    public double Qty = 0.00;
    public double Rate = 0.00;
    public double Amount = 0.00;
    public double DiscountPer = 0.00;
    public double DiscountAmount = 0.00;
    public double SubTotal = 0.00;
    public double GSTRate = 0.00;
    public double GSTAmount = 0.00;
    public double TotalAmount = 0.00;
    public string Brcd = string.Empty;
    public string Narration = string.Empty;
    public double BalanceQty = 0.00;
    public string TyreSizeCode = string.Empty;
    public string TyreMFG_Code = string.Empty;
    public string TyreTypeCode = string.Empty;
    public bool IsRcmApplicable = false;
    public string EntryBy = string.Empty;
    public string EntryDate = string.Empty;
}

public class GeneralizePOGST_LedgerDetails
{
    public string Ledger = string.Empty;
    public string SubLedger = string.Empty;
    public string Debit = string.Empty;
    public string Credit = string.Empty;
    public List<GeneralizePOGST_LedgerDetails> ListItems = new List<GeneralizePOGST_LedgerDetails>();
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for cls_VehicleCPKM
/// </summary>
public class cls_VehicleCPKM
{
	public cls_VehicleCPKM()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    [DataMember]
    public string ContractID { get; set; }
    public string VendorName { get; set; }
    public string VendorCode { get; set; }
     public string Station { get; set; }
     public string StationID { get; set; }
     public string StartDate { get; set; }
     public string EndDate { get; set; }
     public double BaseRate { get; set; }
     public double GSTPer { get; set; }
     public double GStAmount { get; set; }
     public double NetRate { get; set; }
     public string GstCredit { get; set; }


}

public class cls_VehicleCPKM_BillGeneration
{
    public cls_VehicleCPKM_BillGeneration()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    [DataMember]
    public string BillNo { get; set; }
    public string VehicleNo { get; set; } 
    public string PreviousTripsheetNo { get; set; }
    public string PreviousTripsheetDate { get; set; }
    public string OpeningKM  { get; set; }
    public string ClosingTripsheetNo { get; set; }
    public string ClosingTripsheetDate { get; set; }
    public string ClosingKm  { get; set; }
    public string KMS  { get; set; }
    public string OPType  { get; set; }
    public string ActualClosingKM  { get; set; }
    public string NetDistance   { get; set; }
    public string BaseRate  { get; set; }
    public string Amount  { get; set; }
    public string Rebate  { get; set; }
    public string NEtAmount  { get; set; }
    public string GStType { get; set; }
    public string GStPersantage { get; set; }
    public string IGST  { get; set; }
    public string CGST  { get; set; }
    public string SGST  { get; set; }
    public string FinalAmount  { get; set; }
    public string RejectType   { get; set; }
    public string RejectRemarks   { get; set; }
    public string EntryBy  { get; set; }
    public string EntryDate { get; set; }
    public string Subtotal { get; set; }
    public string MiscTotal { get; set; }
    public string TotalAmount { get; set; }
    public string VendorCode { get; set; }
    public string VendorName { get; set; }
    public string CreditKms { get; set; }
    public string BalanceKms { get; set; }
    public string BillingMonth { get; set; }
    public string BillingYear { get; set; }
    //Add by Minesh
    public decimal TDSAmount { get; set; }
}

public class cls_VehicleCPKM_BillPayment
{
    public cls_VehicleCPKM_BillPayment()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    [DataMember]
    public string BillNo { get; set; }
    public string NetBillAmount { get; set; }
    public string NoVehicle { get; set; }
    public string VendorCode { get; set; }
    public string VendorName { get; set; }
    public string EntryBy { get; set; }
    public string EntryDate { get; set; }

    public string TotalBillAmount { get; set; }
    public string FinalRebateAmount { get; set; }
    public string NetBill { get; set; }
    public string BankOption { get; set; }
    public string Amount { get; set; }
    public string CreditAmount { get; set; }
    public string InstrumentDate { get; set; }
    public string InstrumentNo { get; set; }
    public string BankCode { get; set; }
    public string CreditAccount { get; set; }
    public string ConfirmedCreditAccount { get; set; }
    public string NetPaybleAmount { get; set; }
    //Add by Minesh
    public string TDSAmount { get; set; }
}

public class cls_VendorCPKMBilling_Approval
{
    public cls_VendorCPKMBilling_Approval()
    {
        //
        // TODO: Add constructor logic here
        //
    }
     
    [DataMember]
    public string VehicleNo { get; set; }
    public string TyreNo { get; set; }
    public string TyreID { get; set; }
    public string Model { get; set; }
    public string Pattern { get; set; }
    public string Size { get; set; }
    public string TyreType { get; set; }
    public string TyreMFG { get; set; }
    public string FittmentDate { get; set; }
    public string RemovalDate { get; set; }
    public string Remarks { get; set; }
    public string Value { get; set; }
    public string VendorCode { get; set; }
   
}

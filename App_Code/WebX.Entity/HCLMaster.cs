using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;
using System.Globalization;


/// <summary>
/// Summary description for HCLMaster
/// </summary>
public class HCLMaster
{
    public HCLMaster()
    {
        //
        // TODO: Add constructor logic here
        //
    }

}
[DataContract]
public class BranchResult
{
    [DataMember]
    public string BranchCode { get; set; }
    [DataMember]
    public string IsBranchExist { get; set; }
}

[DataContract]
public class AutoCompleteResult
{
    [DataMember]
    public string Value { get; set; }
    [DataMember]
    public string Name { get; set; }
    [DataMember]
    public string Description { get; set; }

    public AutoCompleteResult()
    {
        Name = string.Empty;
        Value = string.Empty;
        Description = string.Empty;
    }
}
[DataContract]
public class HCLDetail
{
    [DataMember]
    public string BranchCode { get; set; }
    [DataMember]
    public int OutgoingThcType { get; set; }
    [DataMember]
    public double OutgoingThcRate { get; set; }
    [DataMember]
    public string OutgoingThcFromDate { get; set; }
    [DataMember]
    public string OutgoingThcToDate { get; set; }
    [DataMember]
    public int IncomingThcType { get; set; }
    [DataMember]
    public double IncomingThcRate { get; set; }
    [DataMember]
    public string IncomingThcFromDate { get; set; }
    [DataMember]
    public string IncomingThcToDate { get; set; }
    [DataMember]
    public int DDMRType { get; set; }
    [DataMember]
    public double DDMRRate { get; set; }
    [DataMember]
    public string DDMRFromDate { get; set; }
    [DataMember]
    public string DDMRToDate { get; set; }
    [DataMember]
    public int MRType { get; set; }
    [DataMember]
    public double MRRate { get; set; }
    [DataMember]
    public string MRFromDate { get; set; }
    [DataMember]
    public string MRToDate { get; set; }
    [DataMember]
    public string EntryBy { get; set; }

    [DataMember]
    public string UpdateBy { get; set; }
}
[DataContract]
public class HCLUpdateDetail
{
    [DataMember]
    public string BranchCode { get; set; }
    [DataMember]
    public int OutgoingThcType { get; set; }
    [DataMember]
    public double OutgoingThcRate { get; set; }
    [DataMember]
    public DateTime OutgoingThcFromDate { get; set; }
    [DataMember]
    public DateTime OutgoingThcToDate { get; set; }
    [DataMember]
    public int IncomingThcType { get; set; }
    [DataMember]
    public double IncomingThcRate { get; set; }
    [DataMember]
    public DateTime IncomingThcFromDate { get; set; }
    [DataMember]
    public DateTime IncomingThcToDate { get; set; }

    [DataMember]
    public int DDMRType { get; set; }
    [DataMember]
    public double DDMRRate { get; set; }
    [DataMember]
    public DateTime DDMRFromDate { get; set; }
    [DataMember]
    public DateTime DDMRToDate { get; set; }
    [DataMember]
    public int MRType { get; set; }
    [DataMember]
    public double MRRate { get; set; }
    [DataMember]
    public DateTime MRFromDate { get; set; }
    [DataMember]
    public DateTime MRToDate { get; set; }
    [DataMember]
    public string EntryBy { get; set; }

    [DataMember]
    public string UpdateBy { get; set; }

    [DataMember]
    public DateTime EntryDate { get; set; }
    [DataMember]
    public DateTime UpdateDate { get; set; }
}
public class HCLBillGenerationHeader
{
    [DataMember]
    public double TotalAmount { get; set; }
    [DataMember]
    public double RebateAmount { get; set; }
    [DataMember]
    public double NetAmount { get; set; }
    [DataMember]
    public string OTHCRateType { get; set; }
    [DataMember]
    public double OTHCRate { get; set; }
    [DataMember]
    public string ITHCRateType { get; set; }
    [DataMember]
    public double ITHCRate { get; set; }
    [DataMember]
    public string DDMRRateType { get; set; }
    [DataMember]
    public double DDMRRate { get; set; }
    [DataMember]
    public string MRRateType { get; set; }
    [DataMember]
    public double MRRate { get; set; }
    [DataMember]
    public string VendorName { get; set; }
    [DataMember]
    public string Branch { get; set; }
    [DataMember]
    public string FinYear { get; set; }
    [DataMember]
    public string EntryBy { get; set; }
    [DataMember]
    public string CompanyCode { get; set; }
    [DataMember]
    public List<HCLBillGenerationDetail> BillDetails { get; set; }

}
public class HCLBillGenerationDetail
{
    [DataMember]
    public string DocumentNo { get; set; }
    [DataMember]
    public string RateType { get; set; }
    [DataMember]
    public double Rate { get; set; }
    [DataMember]
    public double Amount { get; set; }
    [DataMember]
    public string Remarks { get; set; }
    [DataMember]
    public string Edited { get; set; }
    [DataMember]
    public double TOTWT { get; set; }
    [DataMember]
    public double TOTPKGS { get; set; }
}

public class HCLBillPaymenentDetails
{
    [DataMember]
    public string BillNo { get; set; }
    [DataMember]
    public double Tds { get; set; }
    [DataMember]
    public double PayableAmount { get; set; }
    [DataMember]
    public string PayMode { get; set; }
    [DataMember]
    public string InstrumentNo { get; set; }
    [DataMember]
    public double InstrumentAmount { get; set; }
    [DataMember]
    public string InstrumentDate { get; set; }
    [DataMember]
    public string BankName { get; set; }
    [DataMember]
    public string PaymentBy { get; set; }
    [DataMember]
    public string Branch { get; set; }
    [DataMember]
    public string FinYear { get; set; }
}

public class ChequeRequest
{
    [DataMember]
    public string chequeNo { get; set; }
    [DataMember]
    public string chequedate { get; set; }
}
public class HCLBillApprovalDetail
{
    [DataMember]
    public string BillNo { get; set; }
    [DataMember]
    public double ApprovedAmount { get; set; }
    [DataMember]
    public double Discount { get; set; }
    [DataMember]
    public string RejectRemarks { get; set; }

    [DataMember]
    public int ApprovalFlag { get; set; }

}

public class Response
{
    public Response()
        {
            VoucherNo = string.Empty; ErrorMessage = string.Empty; IsSuccess = false;
        }
        [DataMember]
    public string VoucherNo { get; set; }
        [DataMember]
        public bool IsSuccess { get; set; }
        [DataMember]
        public string ErrorMessage { get; set; }
    
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for ServiceTaxTransferUtility
/// </summary>
public class MRCriteria
{
    public string Ledger { get; set; }
    public string CustomerCode { get; set; }
    public string Location { get; set; }
    public string FromDate { get; set; }
    public string ToDate { get; set; }
    public string Division { get; set; }
    public string GRNo { get; set; }
    public string MRNo { get; set; }
    public string FinYear { get; set; }
}

public class MRHeader
{
    public List<MRDetails> Details { get; set; }
}
public class MRDetails
{
    public string GRNo { get; set; }
    public string MRNo { get; set; }
    public string MRDate { get; set; }
    public decimal MRAmount { get; set; }
    public decimal STax { get; set; }
    public string ConsigneeCode { get; set; }
    public string Consignee { get; set; }
    public string ConsignorCode { get; set; }
    public string Consignor { get; set; }
    public string ReceiverCode { get; set; }
    public string Receiver { get; set; }
    public string LegerCode { get; set; }
    public string EntryBy { get; set; }
}

public class LegerList
{
    public string LegerCode { get; set; }
    public string LegerName { get; set; }
}

[DataContract]
public class LegerResult
{
    [DataMember]
    public string LegerCode { get; set; }
}

public class CustomerList
{
    public string CustomerCode { get; set; }
    public string CustomerName { get; set; }
}
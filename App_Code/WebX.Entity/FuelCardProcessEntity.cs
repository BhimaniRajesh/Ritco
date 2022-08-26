using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;
using System.Globalization;


/// <summary>
/// Summary description for FualCardProcessEntity
/// </summary>
public class FuelCardProcessEntity
{
    public FuelCardProcessEntity()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    
    
}
[DataContract]
public class FuelCardProcessData
{
     [DataMember]
    public int FuelCardProcessId { get; set; }
    [DataMember]
    public string TripsheetNo { get; set; }
    [DataMember]
    public string FuelAccCode { get; set; }
    [DataMember]
    public string FuelCardProcessDate { get; set; }
    [DataMember]
    public string VehicleNo { get; set; }
    [DataMember]
    public string TripSheetNo { get; set; }
    [DataMember]
    public string TripSheetDateTime { get; set; }
    [DataMember]
    public string FuelCardNo { get; set; }
    [DataMember]
    public string FuelType { get; set; }
    [DataMember]
    public string City { get; set; }
    [DataMember]
    public string SwappingDate { get; set; }
    [DataMember]
    public string TransactionId { get; set; }
    [DataMember]
    public decimal QTY { get; set; }
    [DataMember]
    public decimal Rate { get; set; }
    [DataMember]
    public decimal Amount { get; set; }
    [DataMember]
    public string Remarks { get; set; }
    [DataMember]
    public string EntryBy { get; set; }
	
}
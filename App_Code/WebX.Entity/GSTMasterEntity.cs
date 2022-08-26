using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;



/// <summary>
/// Summary description for GSTMasterEntity
/// </summary>

[Serializable]
public class GSTMasterEntity
{
    public GSTMasterEntity()
    {

        StateTypeCode = string.Empty;
        StateType = string.Empty;
        StateName = string.Empty;
        StateCode = string.Empty;
        Address = string.Empty;
        CityCode = string.Empty;
        City = string.Empty;
        ProvisionalNumber = string.Empty;
        GSTTypeCode = string.Empty;
        GSTType = string.Empty;
        GSTINumber = string.Empty;
        EntryBy = string.Empty;
        LocationCode = Location = string.Empty;
    }
    public string StateTypeCode { get; set; }
    public string StateType { get; set; }
    public string StateName { get; set; }
    public string StateCode { get; set; }
    public string Address { get; set; }
    public string CityCode { get; set; }
    public string City { get; set; }
    public string LocationCode { get; set; }
    public string Location { get; set; }
    public string ProvisionalNumber { get; set; }
    public string GSTType { get; set; }
    public string GSTTypeCode { get; set; }
    public string GSTINumber { get; set; }
    public string GSTTiNumber { get; set; }
    public string EntryBy { get; set; }
    public DateTime EntryDate { get; set; }

}

[Serializable]
public class GSTCustomerMasterEntity
{
    public GSTCustomerMasterEntity()
    {

        CustomerCode = string.Empty;
        StateCode = string.Empty;
        Address = string.Empty;
        CityCode = string.Empty;
        CGSTNumber = string.Empty;
        IGSTNumber = string.Empty;
        Preference = string.Empty;
        PreferenceType = string.Empty;
        EntryBy = string.Empty;

    }
    public string CustomerCode { get; set; }
    public string StateCode { get; set; }
    public string Address { get; set; }
    public string CityCode { get; set; }
    public string CGSTNumber { get; set; }
    public string IGSTNumber { get; set; }
    public string Preference { get; set; }
    public string PreferenceType { get; set; }
    public string EntryBy { get; set; }
    public DateTime EntryDate { get; set; }

     public List<GSTMasterEntity> ListGSTMasterEntity { get; set; }

}


[Serializable]
public class GSTSacMasterEntity
{
    public GSTSacMasterEntity()
    {
        SACCategory = SACCode = EntryBy = string.Empty;
        IsRCMApplicable = false;
        GSTRate = 0;
    }
    public string SACCategory { get; set; }
    public string SACCode { get; set; }
    public decimal GSTRate { get; set; }
    public bool IsRCMApplicable { get; set; }
    public string EntryBy { get; set; }
}

[Serializable]
public class GSTSacProductMappingMasterEntity
{
    public GSTSacProductMappingMasterEntity()
    {
        SACCategory = SACCategory = EntryBy = string.Empty;
    }
    public string ServiceType { get; set; }
    public string SACCategory { get; set; }
    public string EntryBy { get; set; }
}

[Serializable]
public class GSTCompanyMasterEntity
{
    public GSTCompanyMasterEntity()
    {
        CompanyCode = string.Empty;
        StateCode = string.Empty;
        Address = string.Empty;
        CityCode = string.Empty;
        CGSTNumber = string.Empty;
        IGSTNumber = string.Empty;
        EntryBy = string.Empty;

    }
    public string CompanyCode { get; set; }
    public string StateCode { get; set; }
    public string Address { get; set; }
    public string CityCode { get; set; }
    public string CGSTNumber { get; set; }
    public string IGSTNumber { get; set; }
    public string EntryBy { get; set; }
    public DateTime EntryDate { get; set; }

    public List<GSTMasterEntity> ListGSTMasterEntity { get; set; }

}


[Serializable]
public class GSTVendorMasterEntity
{
    public GSTVendorMasterEntity()
    {
        VendorCode = string.Empty;
        StateCode = string.Empty;
        Address = string.Empty;
        CityCode = string.Empty;
        CGSTNumber = string.Empty;
        IGSTNumber = string.Empty;
        EntryBy = string.Empty;

    }
    public string VendorCode { get; set; }
    public string StateCode { get; set; }
    public string Address { get; set; }
    public string CityCode { get; set; }
    public string CGSTNumber { get; set; }
    public string IGSTNumber { get; set; }
    public string EntryBy { get; set; }
    public DateTime EntryDate { get; set; }
    public List<GSTMasterEntity> ListGSTMasterEntity { get; set; }
}

[Serializable]
public class ProductServiceMappingMasterEntity
{
    public ProductServiceMappingMasterEntity()
    {
        ProductType = ServiceType = EntryBy = string.Empty;
    }
    public string ProductType { get; set; }
    public string ServiceType { get; set; }
    public string EntryBy { get; set; }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for VehicleCKPM
/// </summary>

[DataContract]
public class VehicleCKPM
{
    #region Properties
    public string VehicleNo { get; set; }
    public string CPKMDate { get; set; }
    public string KMs { get; set; }
    public string VendorCode { get; set; }
    public string VendorName { get; set; }

    #endregion
    public VehicleCKPM()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

public class CPKMVenodorList
{
    public string VENDORCODE { get; set; }
    public string VENDORNAME { get; set; }
}

public class AutoCompleteRequest
{
    public string Prefix { get; set; }
}
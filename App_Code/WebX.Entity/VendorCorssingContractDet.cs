using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Summary description for VendorCorssingContractDet
/// </summary>
[Serializable]
public class VendorCorssingContractDet
{
    private string _ContractID = "", _VendorCode = "", _Origin = "", _DestCity = "", _ratetype = "", _ActiveFlag = "", _EntryBy = "", _UpdatedBy = "";
    private double _ID=-1, _rate = 0.0, _doordeliveryCharge = 0.0, _otherCharge = 0.0;
    private DateTime _EntryDate = DateTime.MinValue, _UpdatedDate = DateTime.MinValue;
    private bool _Deleted = false;

	public VendorCorssingContractDet()
	{
		//
		// TODO: Add constructor logic here
		//
	}
   
    public string ContractID { get { return _ContractID; } set { _ContractID = value; } }
    public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
    public string Origin { get { return _Origin; } set { _Origin = value; } }
    public string DestCity { get { return _DestCity; } set { _DestCity = value; } }
    public string RateType { get { return _ratetype; } set { _ratetype = value; } }
    public string ActiveFlag { get { return _ActiveFlag; } set { _ActiveFlag = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public string UpdatedBy { get { return _UpdatedBy; } set { _UpdatedBy = value; } }

    public double ID { get { return _ID; } set { _ID = value; } }
    public double Rate { get { return _rate; } set { _rate = value; } }
    public double DoorDeliveryCharge { get { return _doordeliveryCharge; } set { _doordeliveryCharge = value; } }
    public double OtherCharge { get { return _otherCharge; } set { _otherCharge = value; } }

    public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }
    public DateTime UpdatedDate { get { return _UpdatedDate; } set { _UpdatedDate = value; } }

    public bool Deleted { get { return _Deleted; } set { _Deleted = value; } }

}
public enum VendorCorssingContractDet_Columns
{
    ID = 0,
    ContractID,
    VendorCode,
    Origin,
    DestCity,
    RateType,
    Rate,
    DoorDeliveryCharge,
    OtherCharge,
    ActiveFlag,
    EntryBy,
    EntryDate,
    UpdatedBy,
    UpdatedDate
}

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
/// Summary description for VendorCorssingContract
/// </summary>
[Serializable]
public class VendorCorssingContract
{
    private string _ContractID = "", _VendorCode = "", _ActiveFlag = "", _EntryBy = "", _UpdatedBy = "";
    private DateTime _EntryDate = DateTime.MinValue, _UpdatedDate = DateTime.MinValue;
    private List<VendorCorssingContractDet> _Details = new List<VendorCorssingContractDet>();

	public VendorCorssingContract()
	{
		//
		// TODO: Add constructor logic here
		//
	}   

    public string ContractID { get { return _ContractID; } set { _ContractID = value; } }
    public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
    public string ActiveFlag { get { return _ActiveFlag; } set { _ActiveFlag = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public string UpdatedBy { get { return _UpdatedBy; } set { _UpdatedBy = value; } }
    public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }
    public DateTime UpdatedDate { get { return _UpdatedDate; } set { _UpdatedDate = value; } }
    public List<VendorCorssingContractDet> Details { get { return _Details; } set { _Details = value; } }
}

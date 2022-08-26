using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Crossing
/// </summary>
public class Crossing
{
    private string _DockNo="",_Origin="",_Destination="",_Paybas="",_Ratetype="",_EntryBY="",_CrossingChallanNo="";
    private string _ChallanLocCode = "", _VehicleNo = "", _VendorCode = "", _VendorName = "", _Cancel = "", _PaymentFlag="";
    //private string Cancel = "";
    private double _DKTTOT=0.0,_Pkgs=0.0,_ActuWeight=0.0,_VendorRate=0.0,_CrossingChrg=0.0,_DoorDelyChrg=0.0,_TotalToPay=0.0,_BulkyCharge=0.0;
    private double _TotalCrossing = 0.0, _TotalDoorDelyChrg = 0.0, _NetPayable = 0.0, _TotalBulkyCharge = 0.0, _TotalBalance = 0.0, _TotalTruckFreight = 0.0, _TotalAdvanceFreight = 0.0;
    private DateTime _ChallanDate,_DockDate,_EntryDate;
    public Crossing()
    {

    }
    /* Master Entry */
    
    public string CrossingChallanNo { get { return _CrossingChallanNo; } set { _CrossingChallanNo = value; } }
    public string ChallanLocCode { get { return _ChallanLocCode; } set { _ChallanLocCode = value; } }
    public string VehicleNo { get { return _VehicleNo; } set { _VehicleNo = value; } }
    public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
    public string VendorName { get { return _VendorName; } set { _VendorName = value; } }
    public string Cancel { get { return _Cancel; } set { _Cancel = value; } }
    public string PaymentFlag { get { return _PaymentFlag; } set { _PaymentFlag = value; } }

    public double TotalToPay { get { return _TotalToPay; } set { _TotalToPay = value; } }
    public double TotalCrossing { get { return _TotalCrossing; } set { _TotalCrossing = value; } }
    public double TotalDoorDelyChrg { get { return _TotalDoorDelyChrg; } set { _TotalDoorDelyChrg = value; } }
    public double TotalBulkyCharge { get { return _TotalBulkyCharge; } set { _TotalBulkyCharge = value; } }
    public double TotalTruckFreight { get { return _TotalTruckFreight; } set { _TotalTruckFreight = value; } }
    public double TotalAdvanceFreight { get { return _TotalAdvanceFreight; } set { _TotalAdvanceFreight = value; } }
    public double TotalBalance { get { return _TotalBalance; } set { _TotalBalance = value; } }

    public double NetPayable { get { return _NetPayable; } set { _NetPayable = value; } }

    public DateTime ChallanDate { get { return _ChallanDate; } set { _ChallanDate = value; } }

    /* Detail Entry*/
    
    public string DockNo { get { return _DockNo; } set { _DockNo = value; } }
    public string Origin { get { return _Origin; } set { _Origin = value; } }
    public string Destination { get { return _Destination; } set { _Destination = value; } }
    public string Paybas { get { return _Paybas; } set { _Paybas = value; } }
    public string Ratetype { get { return _Ratetype; } set { _Ratetype = value; } }
    public string EntryBY { get { return _EntryBY; } set { _EntryBY = value; } }
    
    public double DKTTOT { get { return _DKTTOT; } set { _DKTTOT = value; } }
    public double Pkgs { get { return _Pkgs; } set { _Pkgs = value; } }
    public double ActuWeight { get { return _ActuWeight; } set { _ActuWeight = value; } }
    public double VendorRate { get { return _VendorRate; } set { _VendorRate = value; } }
    public double CrossingChrg { get { return _CrossingChrg; } set { _CrossingChrg = value; } }
    public double DoorDelyChrg { get { return _DoorDelyChrg; } set { _DoorDelyChrg = value; } }
    public double BulkyCharge { get { return _BulkyCharge; } set { _BulkyCharge = value; } }
    
    public DateTime DockDate { get { return _DockDate; } set { _DockDate = value; } }
    public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }



}

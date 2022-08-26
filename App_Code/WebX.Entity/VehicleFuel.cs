using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for VehicleFuel
/// </summary>
/// 

public class VehicleFuel
{
    #region Properties
    [DataMember]
    public string VehicleNo { get; set; }
    [DataMember]
    public string FuelWallet { get; set; }
    [DataMember]
    public string FuelDate { get; set; }
    [DataMember]
    public string CardNo { get; set; }
    [DataMember]
    public string ConfirmCardNo { get; set; }
    [DataMember]
    public string SrNo { get; set; }
    [DataMember]
    public bool ActiveFlag { get; set; }
    #endregion

    public VehicleFuel()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for FixedExpense
/// </summary>
public class FixedExpense
{
    public FixedExpense()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Properties
    [DataMember]
    public string OptionType { get; set; }
    [DataMember]
    public string TyreExp { get; set; }
    [DataMember]
    public string AMC { get; set; }
    [DataMember]
    public string Document { get; set; }
    [DataMember]
    public string OtherI { get; set; }
    [DataMember]
    public string OtherII { get; set; }
    [DataMember]
    public string VehicleNo { get; set; }
    #endregion
}
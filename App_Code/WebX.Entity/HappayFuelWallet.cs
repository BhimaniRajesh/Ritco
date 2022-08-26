using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for HappayFuelWallet
/// </summary>
namespace WebX.Entity
{
    public class HappayFuelWallet
    {
        public HappayFuelWallet()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
    [DataContract]
    public class BankFuelTypeRequest
    {
        [DataMember]
        public string WalletType { get; set; }
        [DataMember]
        public string BankName { get; set; }
        [DataMember]
        public string AccountNo { get; set; }
        [DataMember]
        public string BankLeadgerCode { get; set; }
        [DataMember]
        public bool IsActive { get; set; }
    }
}
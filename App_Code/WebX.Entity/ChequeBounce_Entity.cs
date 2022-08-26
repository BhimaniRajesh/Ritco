using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace WebX.Entity
{
    public class ChequeBounce_Entity
    {
        public ChequeBounce_Entity()
        {
            //
            // TODO: Add constructor logic here
            //
        }

    }
    [DataContract]
    public class PaymentCheque
    {
        [DataMember]
        public List<ChequBouncePaymentRequest> DetailListChequBouncePaymentRequest { get; set; }
    }

    [DataContract]
    public class ChequBounceRequest
    {
        [DataMember]
        public string BankName { get; set; }
        [DataMember]
        public string ROLocation { get; set; }
        [DataMember]
        public string Loccode { get; set; }
        [DataMember]
        public string ChequeNo { get; set; }
        [DataMember]
        public decimal Amount { get; set; }
        [DataMember]
        public DateTime ChequeDate { get; set; }
        [DataMember]
        public string CustomerCode { get; set; }
        [DataMember]
        public string CustomerName { get; set; }
        [DataMember]
        public string Remarks { get; set; }
        [DataMember]
        public string EmailID { get; set; }
        [DataMember]
        public string EntryBy { get; set; }
        [DataMember]
        public string FinYear { get; set; }
        [DataMember]
        public string EntryBranch { get; set; }
    }

    [DataContract]
    public class ChequBounceResponse
    {
        [DataMember]
        public string VoucherNumber { get; set; }
        [DataMember]
        public bool IsSuccess { get; set; }
        [DataMember]
        public string Message { get; set; }

    }

    [DataContract]
    public class ChequBouncePaymentRequest
    {
        [DataMember]
        public string FromDate { get; set; }
        [DataMember]
        public string ToDate { get; set; }
        [DataMember]
        public string BankName { get; set; }
        [DataMember]
        public string ROLocation { get; set; }
        [DataMember]
        public string Loccode { get; set; }
        [DataMember]
        public string Customer { get; set; }
        [DataMember]
        public string ChequeNo { get; set; }
        [DataMember]
        public decimal ChequeAmount { get; set; }
        [DataMember]
        public decimal ReceiveAmount { get; set; }
        [DataMember]
        public decimal BalanceAmount { get; set; }
        [DataMember]
        public decimal CaseAmount { get; set; }
        [DataMember]
        public decimal InstrumentAmount { get; set; }
        [DataMember]
        public decimal TotalAmount { get; set; }
        [DataMember]
        public string InstrumentType { get; set; }
        [DataMember]
        public string InstrumentNo { get; set; }
        [DataMember]
        public DateTime ChequeDate { get; set; }
        [DataMember]
        public DateTime DepositDate { get; set; }
        [DataMember]
        public string InstrumentDate { get; set; }
        [DataMember]
        public string CustomerCode { get; set; }
        [DataMember]
        public string CustomerName { get; set; }
        [DataMember]
        public string BounceBy { get; set; }
        [DataMember]
        public DateTime BounceDate { get; set; }
        [DataMember]
        public string EmailID { get; set; }
        [DataMember]
        public string EntryBy { get; set; }
        [DataMember]
        public string FinYear { get; set; }
        [DataMember]
        public string EntryBranch { get; set; }

    }
}
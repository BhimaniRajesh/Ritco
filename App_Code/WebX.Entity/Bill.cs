using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace WebX.Entity
{
    /// <summary>
    /// Summary description for Bill
    /// </summary>
    public class Bill
    {
         #region Variable[s]

         #region BillMst
         private string m_BillNo;
         private DateTime m_BillGenDate;
         private DateTime m_BillSubDate;
         private DateTime m_BillDueDate;
         private DateTime m_BillCollDate;
         private DateTime m_BillCBSDate;
         private string m_BillBranch;       
         private string m_BillType; 
         private string m_PartyCode;
         private string m_PartyName;
         private string m_PartyPhoneNo;
         private string m_PartyEmail;
         private string m_PartyAddress;
         private string m_Remark;
         private double m_BillAmount;
         private double m_PendingAmount;
         private string m_BillStatus;
         private string m_BillSubTo;
         private string m_SubTotal;
         private string m_SupBillNoFor;
         private double m_SupBillAmount;
         private string m_FlagBillCommit;
         private string m_FlagBillClose;
         private string m_PayMode;
         private string m_ChequeNo;
         private DateTime m_ChequeDate;
         private double m_ChequeAmount;
         private double m_BillCollAmount;
         private double m_BillDeduction; 
         private string m_BankName;
         private string m_BillGenEmpCode;
         private string m_BillSubEmpCode;
         private string m_BillCollEmpCode;
         private string m_BillCBSEmpCode;
         private string m_PartyBranch;
         private string m_Comment; 
         private string m_FlagBillCancel;
         private string m_BillSubBRCD;
         private string m_BillColBRCD;
         private string m_BillAO;
         private string m_BillSubType;
         private string m_BillCanEmpCode;        
         private DateTime  m_BillCancelDate;
         private string m_BillCancelComment;
         private DateTime m_FinCloseDate;
         private double m_BillTDS;
         private string m_BillCollPartyCode;
         private string m_BADDEBTS;    
         private DateTime m_BillDateFrom;
         private DateTime m_BillDateTo;
         private string m_BankAccCode;         
         private double m_ServiceTax; 
         private double m_EduCess;             
         private string m_AcctGNEffect;
         private double m_WareCharge;
         private double m_VehDetailCharge;
         private double m_DisCharge;
         private double m_HandlingCharge;
         private string m_ManualBillNo;
         private double m_RentalCharge;
         private double m_OtherCharge;
         private string m_AggrementNo;
         private double m_ServiceTaxRate;
         private double m_EduCessRate;
         private double m_HEduCessRate;
         private double m_HEduCess;
         private string m_BusinessType;
         private string m_Narration;
         #endregion

         #region BillDet      
         private string m_DocketNo;
         private string m_DocketSF;
         private string m_OrgnLoc;
         private string m_ReassignDestCode;
         private DateTime m_DocketDate;
         private DateTime m_CDELDT;
         private DateTime m_DeliveryDate;
         private double m_ChargeWeight;
         private double m_DocketAmount;        
         private double m_DocketTotal;
         private double m_FreightDeduction;     
         private double m_otherDeduction;
         private double m_TDS;
         private double m_OnAccount;
         private double m_TotalDeduction; 
         private string m_OctroiReceiptNo;
         private double m_OctroiServiceCharge;
         private double m_OctroiAmount;         
         private double m_TotalAmount;
         private double m_DeclaredValue;        
         private double m_DocketCharge;
         private double m_FOVCharge;
         private double m_ProcessingCharge;
         private double m_DemurrageCharge;
         private double m_OctroiPer;
         private double m_ClearanceCharge;
         private double m_ProcessingPer;
         private DateTime m_ReceiptDate;
         private double m_OctroiCess;
         private double m_OctroiHCess;
         private double m_OctroiServiceTax;
         private string m_AccountCode;
         private string m_AccountName; 
         private string m_DocType;
         #endregion

         #endregion

         #region Constructor
         public Bill()
         {
            //
            // TODO: Add constructor logic here
            //
              #region BillMst
              m_BillNo = string.Empty;
              m_BillGenDate = DateTime.MinValue;
              m_BillSubDate = DateTime.MinValue;
              m_BillDueDate = DateTime.MinValue;
              m_BillCollDate = DateTime.MinValue;
              m_BillCBSDate = DateTime.MinValue;
              m_BillBranch = string.Empty;
              m_BillType = string.Empty;
              m_PartyCode = string.Empty;
              m_PartyName = string.Empty;
              m_PartyPhoneNo = string.Empty;
              m_PartyEmail = string.Empty;
              m_PartyAddress = string.Empty;
              m_Remark = string.Empty;
              m_BillAmount = 0.0;
              m_PendingAmount = 0.0;
              m_BillStatus = string.Empty;
              m_BillSubTo = string.Empty;
              m_SubTotal = string.Empty;
              m_SupBillNoFor = string.Empty;
              m_SupBillAmount = 0.0;
              m_FlagBillCommit = string.Empty;
              m_FlagBillClose = string.Empty;
              m_PayMode = string.Empty;
              m_ChequeNo = string.Empty;
              m_ChequeDate = DateTime.MinValue;
              m_ChequeAmount = 0.0;
              m_BillCollAmount = 0.0;
              m_BillDeduction = 0.0;
              m_BankName = string.Empty;
              m_BillGenEmpCode = string.Empty;
              m_BillSubEmpCode = string.Empty; 
              m_BillCollEmpCode = string.Empty;
              m_BillCBSEmpCode = string.Empty;
              m_PartyBranch = string.Empty;
              m_Comment = string.Empty;
              m_FlagBillCancel = string.Empty;
              m_BillSubBRCD = string.Empty;
              m_BillColBRCD = string.Empty;
              m_BillAO = string.Empty;
              m_BillSubType = string.Empty;
              m_BillCanEmpCode = string.Empty;             
              m_BillCancelDate = DateTime.MinValue;
              m_BillCancelComment = string.Empty;
              m_FinCloseDate = DateTime.MinValue;
              m_BillTDS = 0.0;
              m_BillCollPartyCode = string.Empty;
              m_BADDEBTS = string.Empty;
              m_BillDateFrom = DateTime.MinValue;
              m_BillDateTo = DateTime.MinValue;
              m_BankAccCode = string.Empty;
              m_ServiceTax = 0.0;
              m_EduCess = 0.0;             
              m_AcctGNEffect = string.Empty;
              m_WareCharge = 0.0;
              m_VehDetailCharge = 0.0;
              m_DisCharge = 0.0;
              m_HandlingCharge = 0.0;
              m_ManualBillNo = string.Empty;
              m_RentalCharge = 0.0;
              m_OtherCharge = 0.0;
              m_AggrementNo = string.Empty;
              m_ServiceTaxRate = 0.0;
              m_EduCessRate = 0.0;
              m_HEduCessRate = 0.0;
              m_HEduCess = 0.0;
              m_BusinessType = string.Empty;
              m_Narration = string.Empty;
              #endregion
              #region BillDet      
              m_DocketNo = string.Empty;
              m_DocketSF = string.Empty;
              m_OrgnLoc = string.Empty;
              m_ReassignDestCode = string.Empty;
              m_DocketDate = DateTime.MinValue;
              m_CDELDT = DateTime.MinValue;
              m_DeliveryDate = DateTime.MinValue;
              m_ChargeWeight = 0.0;
              m_DocketAmount = 0.0;
              m_DocketTotal = 0.0;
              m_FreightDeduction = 0.0;
              m_otherDeduction = 0.0;
              m_TDS = 0.0;
              m_OnAccount = 0.0;
              m_TotalDeduction = 0.0;
              m_OctroiReceiptNo = string.Empty;
              m_OctroiServiceCharge = 0.0;
              m_OctroiAmount = 0.0;
              m_TotalAmount = 0.0;
              m_DeclaredValue = 0.0;
              m_DocketCharge = 0.0;
              m_FOVCharge = 0.0;
              m_ProcessingCharge = 0.0;
              m_DemurrageCharge = 0.0;
              m_OctroiPer = 0.0;
              m_ClearanceCharge = 0.0;
              m_ProcessingPer = 0.0;
              m_ReceiptDate = DateTime.MinValue;
              m_OctroiCess = 0.0;
              m_OctroiHCess = 0.0;
              m_OctroiServiceTax = 0.0;
              m_AccountCode = string.Empty;
              m_AccountName = string.Empty;
              m_DocType = string.Empty;
              #endregion
         }
         #endregion

        #region Property 
        public string BillNo { get { return m_BillNo; } set { m_BillNo = value; } }
        public DateTime BillGenDate { get { return m_BillGenDate; } set { m_BillGenDate = value; } }
        public DateTime BillSubDate { get { return m_BillSubDate; } set { m_BillSubDate = value; } }
        public DateTime BillDueDate { get { return m_BillDueDate; } set { m_BillDueDate = value; } }
        public DateTime BillCollDate { get { return m_BillCollDate; } set { m_BillCollDate = value; } }
        public DateTime BillCBSDate { get { return m_BillCBSDate; } set { m_BillCBSDate = value; } }
        public string BillBranch { get { return m_BillBranch; } set { m_BillBranch = value; } }
        public string BillType { get { return m_BillType; } set { m_BillType = value; } }
        public string PartyCode { get { return m_PartyCode; } set { m_PartyCode = value; } }
        public string PartyName { get { return m_PartyName; } set { m_PartyName = value; } }
        public string PartyPhoneNo { get { return m_PartyPhoneNo; } set { m_PartyPhoneNo = value; } }
        public string PartyEmail { get { return m_PartyEmail; } set { m_PartyEmail = value; } }
        public string PartyAddress { get { return m_PartyAddress; } set { m_PartyAddress = value; } }
        public string Remark { get { return m_Remark; } set { m_Remark = value; } }
        public double BillAmount { get { return m_BillAmount; } set { m_BillAmount = value; } }
        public double PendingAmount { get { return m_PendingAmount; } set { m_PendingAmount = value; } }
        public string BillStatus { get { return m_BillStatus; } set { m_BillStatus = value; } }
        public string BillSubTo { get { return m_BillSubTo; } set { m_BillSubTo = value; } }
        public string SubTotal { get { return m_SubTotal; } set { m_SubTotal = value; } }
        public string SupBillNoFor { get { return m_SupBillNoFor; } set { m_SupBillNoFor = value; } }
        public double SupBillAmount { get { return m_SupBillAmount; } set { m_SupBillAmount = value; } }
        public string FlagBillCommit { get { return m_FlagBillCommit; } set { m_FlagBillCommit = value; } }
        public string FlagBillClose { get { return m_FlagBillClose; } set { m_FlagBillClose = value; } }
        public string PayMode { get { return m_PayMode; } set { m_PayMode = value; } }
        public string ChequeNo { get { return m_ChequeNo; } set { m_ChequeNo = value; } }
        public DateTime ChequeDate { get { return m_ChequeDate; } set { m_ChequeDate = value; } }
        public double ChequeAmount { get { return m_ChequeAmount; } set { m_ChequeAmount = value; } }
        public double BillCollAmount { get { return m_BillCollAmount; } set { m_BillCollAmount = value; } }
        public double BillDeduction { get { return m_BillDeduction; } set { m_BillDeduction = value; } }
        public string BillGenEmpCode { get { return m_BillGenEmpCode; } set { m_BillGenEmpCode = value; } }
        public string BillSubEmpCode { get { return m_BillSubEmpCode; } set { m_BillSubEmpCode = value; } }
        public string BillCollEmpCode { get { return m_BillCollEmpCode; } set { m_BillCollEmpCode = value; } }
        public string BillCBSEmpCode { get { return m_BillCBSEmpCode; } set { m_BillCBSEmpCode = value; } }
        public string PartyBranch { get { return m_PartyBranch; } set { m_PartyBranch = value; } }
        public string Comment { get { return m_Comment; } set { m_Comment = value; } }
        public string FlagBillCancel { get { return m_FlagBillCancel; } set { m_FlagBillCancel = value; } }
        public string BillSubBRCD { get { return m_BillSubBRCD; } set { m_BillSubBRCD = value; } }
        public string BillColBRCD { get { return m_BillColBRCD; } set { m_BillColBRCD = value; } }
        public string BillAO { get { return m_BillAO; } set { m_BillAO = value; } }
        public string BillSubType { get { return m_BillSubType; } set { m_BillSubType = value; } }
        public string BillCanEmpCode { get { return m_BillCanEmpCode; } set { m_BillCanEmpCode = value; } }       
        public DateTime BillCancelDate { get { return m_BillCancelDate; } set { m_BillCancelDate = value; } }
        public string BillCancelComment { get { return m_BillCancelComment; } set { m_BillCancelComment = value; } }
        public DateTime FinCloseDate { get { return m_FinCloseDate; } set { m_FinCloseDate = value; } }
        public double BillTDS { get { return m_BillTDS; } set { m_BillTDS = value; } }
        public string BillCollPartyCode { get { return m_BillCollPartyCode; } set { m_BillCollPartyCode = value; } }
        public string BADDEBTS { get { return m_BADDEBTS; } set { m_BADDEBTS = value; } }
        public DateTime BillDateFrom { get { return m_BillDateFrom; } set { m_BillDateFrom = value; } }
        public DateTime BillDateTo { get { return m_BillDateTo; } set { m_BillDateTo = value; } }
        public string BankAccCode { get { return m_BankAccCode; } set { m_BankAccCode = value; } }
        public string BankName { get { return m_BankName; } set { m_BankName = value; } }
        public double ServiceTax { get { return m_ServiceTax; } set { m_ServiceTax = value; } }
        public double EduCess { get { return m_EduCess; } set { m_EduCess = value; } }        
        public string AcctGNEffect { get { return m_AcctGNEffect; } set { m_AcctGNEffect = value; } }
        public double WareCharge { get { return m_WareCharge; } set { m_WareCharge = value; } }
        public double VehDetailCharge { get { return m_VehDetailCharge; } set { m_VehDetailCharge = value; } }
        public double DisCharge { get { return m_DisCharge; } set { m_DisCharge = value; } }
        public double HandlingCharge { get { return m_HandlingCharge; } set { m_HandlingCharge = value; } }
        public string ManualBillNo { get { return m_ManualBillNo; } set { m_ManualBillNo = value; } }
        public double RentalCharge { get { return m_RentalCharge; } set { m_RentalCharge = value; } }
        public double OtherCharge { get { return m_OtherCharge; } set { m_OtherCharge = value; } }
        public string AggrementNo { get { return m_AggrementNo; } set { m_AggrementNo = value; } }
        public double ServiceTaxRate { get { return m_ServiceTaxRate; } set { m_ServiceTaxRate = value; } }
        public double EduCessRate { get { return m_EduCessRate; } set { m_EduCessRate = value; } }
        public double HEduCessRate { get { return m_HEduCessRate; } set { m_HEduCessRate = value; } }
        public double HEduCess { get { return m_HEduCess; } set { m_HEduCess = value; } }
        public string BusinessType { get { return m_BusinessType; } set { m_BusinessType = value; } }
        public string Narration { get { return m_Narration; } set { m_Narration = value; } }
        public string DocketNo { get { return m_DocketNo; } set { m_DocketNo = value; } }
        public string DocketSF { get { return m_DocketSF; } set { m_DocketSF = value; } }
        public string OrgnLoc { get { return m_OrgnLoc; } set { m_OrgnLoc = value; } }
        public string DelLoc { get { return m_ReassignDestCode; } set { m_ReassignDestCode = value; } }
        public DateTime DocketDate { get { return m_DocketDate; } set { m_DocketDate = value; } }
        // CDELDT 
        public DateTime EDD { get { return m_CDELDT; } set { m_CDELDT = value; } } 
        public DateTime DeliveryDate { get { return m_DeliveryDate; } set { m_DeliveryDate = value; } }
        public double ChargedWeight { get { return m_ChargeWeight; } set { m_ChargeWeight = value; } }
        public double DocketAmount { get { return m_DocketAmount; } set { m_DocketAmount = value; } }
        public double DocketTotal{ get { return m_DocketTotal; } set { m_DocketTotal = value; }        }
        public double FreightDeduction { get { return m_FreightDeduction; } set { m_FreightDeduction = value; } }
        public double OtherDeduction { get { return m_otherDeduction; } set { m_otherDeduction = value; } }
        public double TDS { get { return m_TDS; } set { m_TDS = value; } }
        public double OnAccount { get { return m_OnAccount; } set { m_OnAccount = value; } }
        public double TotalDeduction { get { return m_TotalDeduction; } set { m_TotalDeduction = value; } }
        public string OctroiReceiptNo { get { return m_OctroiReceiptNo; } set { m_OctroiReceiptNo = value; } }
        public double OctroiServiceCharge { get { return m_OctroiServiceCharge; } set { m_OctroiServiceCharge = value; } }
        public double OctroiAmount { get { return m_OctroiAmount; } set { m_OctroiAmount = value; } }
        public double TotalAmount { get { return m_TotalAmount; } set { m_TotalAmount = value; } }
        public double DeclaredValue { get { return m_DeclaredValue; } set { m_DeclaredValue = value; } }
        public double DocketCharge { get { return m_DocketCharge; } set { m_DocketCharge = value; } }
        public double FOVCharge { get { return m_FOVCharge; } set { m_FOVCharge = value; } }
        public double ProcessingCharge { get { return m_ProcessingCharge; } set { m_ProcessingCharge = value; } }
        public double DemurrageCharge { get { return m_DemurrageCharge; } set { m_DemurrageCharge = value; } }
        public double OctroiPer { get { return m_OctroiPer; } set { m_OctroiPer = value; } }
        public double ClearanceCharge { get { return m_ClearanceCharge; } set { m_ClearanceCharge = value; } }
        public double ProcessingPer { get { return m_ProcessingPer; } set { m_ProcessingPer = value; } }
        public DateTime ReceiptDate { get { return m_ReceiptDate; } set { m_ReceiptDate = value; } }
        public double OctroiCess { get { return m_OctroiCess; } set { m_OctroiCess = value; } }
        public double OctroiHCess { get { return m_OctroiHCess; } set { m_OctroiHCess = value; } }
        public double OctroiServiceTax { get { return m_OctroiServiceTax; } set { m_OctroiServiceTax = value; } }
        public string AccountCode { get { return m_AccountCode; } set { m_AccountCode = value; } }
        public string AccountName { get { return m_AccountName; } set { m_AccountName = value; } }
        public string DocType { get { return m_DocType; } set { m_DocType = value; } }
        #endregion
    }
}

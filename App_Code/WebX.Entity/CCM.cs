using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;
using WebX.Controllers;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
/// <summary>
/// Summary description for CCMModeWiseServices
/// </summary>
namespace WebX.Entity
{
    public class CCMBasicDetails
    {
        #region Variable[s]
        // private string _CustCodeName, _ContractID, _ContractType;

        private string _CustCodeName, _ContractID, _CustCode, _CustomerCategoty, _ContractCategory, _ContractType;
        private string _CustomerRepresentative, _CompanyEmployeeName, _CustomerDesignation, _CompanyDesignation;
        private string _CustomerWitness, _CompanyWitness, _BillingAddress, _BillingCity, _BillingPincode, _EntryBy, _ContractSignLocCode, _AccountRepresentative;
        private string _Remarks;
        private string _LastEditBy, _ContractMode, _CustomerEmail, _CustomerPhoneNo, _AccountPersonEmail;
        private string _AccountPersonPhoneNo, _CustomerAccountPerson, _CompanyPhoneNo, _ConsigneeName, _CompanyEmail;
        private string _ConsigneePhoneNo, _StaxYN, _ConsigneeEmail, _ActiveFlag, _ScanCopyName, _ManualContractId, _ContractName, _AccountManager;
        private DateTime _ContractStartDate, _ContractEndDate, _ContractEffectDate, _EntryDate, _LastEditDate;
        #endregion

        #region Constructor
        public CCMBasicDetails()
        {
            _CustCodeName = "";
            _ContractID = "";
            _CustCode = "";
            _CustomerCategoty = "";
            _ContractCategory = "";
            _ContractType = "";
            _CustomerRepresentative = "";
            _CompanyEmployeeName = "";
            _CustomerDesignation = "";
            _CompanyDesignation = "";
            _CustomerWitness = "";
            _CompanyWitness = "";
            _BillingAddress = "";
            _BillingCity = "";
            _BillingPincode = "";
            _EntryBy = "";
            _ContractSignLocCode = "";
            _AccountRepresentative = "";
            _Remarks = "";
            _LastEditBy = "";
            _ContractMode = "";
            _CustomerEmail = "";
            _CustomerPhoneNo = "";
            _AccountPersonEmail = "";
            _AccountPersonPhoneNo = "";
            _CustomerAccountPerson = "";
            _CompanyPhoneNo = "";
            _ConsigneeName = "";
            _CompanyEmail = "";
            _ConsigneePhoneNo = "";
            _ConsigneeEmail = "";
            _ActiveFlag = "";
            _ScanCopyName = "";
            _ManualContractId = "";
            _ContractName = "";
            _AccountManager = "";
            _StaxYN = "";

            _ContractStartDate = DateTime.MinValue;
            _ContractEndDate = DateTime.MinValue;
            _ContractEffectDate = DateTime.MinValue;
            _EntryDate = DateTime.MinValue;
            _LastEditDate = DateTime.MinValue;


        }

        #endregion

        #region Property
        public string ConsigneeName { get { return _ConsigneeName; } set { _ConsigneeName = value; } }
        public string CustCodeName { get { return _CustCodeName; } set { _CustCodeName = value; } }
        public string ContractID { get { return _ContractID; } set { _ContractID = value; } }
        public string CustCode { get { return _CustCode; } set { _CustCode = value; } }

        public string ContractType { get { return _ContractType; } set { _ContractType = value; } }
        public string CustomerCategoty { get { return _CustomerCategoty; } set { _CustomerCategoty = value; } }
        public string ContractCategory { get { return _ContractCategory; } set { _ContractCategory = value; } }
        public string CustomerRepresentative { get { return _CustomerRepresentative; } set { _CustomerRepresentative = value; } }
        public string CompanyEmployeeName { get { return _CompanyEmployeeName; } set { _CompanyEmployeeName = value; } }
        public string CustomerDesignation { get { return _CustomerDesignation; } set { _CustomerDesignation = value; } }
        public string CompanyDesignation { get { return _CompanyDesignation; } set { _CompanyDesignation = value; } }
        public string CustomerWitness { get { return _CustomerWitness; } set { _CustomerWitness = value; } }
        public string CompanyWitness { get { return _CompanyWitness; } set { _CompanyWitness = value; } }
        public string BillingAddress { get { return _BillingAddress; } set { _BillingAddress = value; } }
        public string BillingCity { get { return _BillingCity; } set { _BillingCity = value; } }
        public string BillingPincode { get { return _BillingPincode; } set { _BillingPincode = value; } }
        public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
        public string ContractSignLocCode { get { return _ContractSignLocCode; } set { _ContractSignLocCode = value; } }
        public string AccountRepresentative { get { return _AccountRepresentative; } set { _AccountRepresentative = value; } }
        public string Remarks { get { return _Remarks; } set { _Remarks = value; } }
        public string LastEditBy { get { return _LastEditBy; } set { _LastEditBy = value; } }
        public string ContractMode { get { return _ContractMode; } set { _ContractMode = value; } }
        public string CustomerEmail { get { return _CustomerEmail; } set { _CustomerEmail = value; } }
        public string CustomerPhoneNo { get { return _CustomerPhoneNo; } set { _CustomerPhoneNo = value; } }
        public string AccountPersonEmail { get { return _AccountPersonEmail; } set { _AccountPersonEmail = value; } }
        public string AccountPersonPhoneNo { get { return _AccountPersonPhoneNo; } set { _AccountPersonPhoneNo = value; } }
        public string CustomerAccountPerson { get { return _CustomerAccountPerson; } set { _CustomerAccountPerson = value; } }
        public string CompanyPhoneNo { get { return _CompanyPhoneNo; } set { _CompanyPhoneNo = value; } }
        public string CompanyEmail { get { return _CompanyEmail; } set { _CompanyEmail = value; } }
        public string ConsigneePhoneNo { get { return _ConsigneePhoneNo; } set { _ConsigneePhoneNo = value; } }
        public string ConsigneeEmail { get { return _ConsigneeEmail; } set { _ConsigneeEmail = value; } }
        public string ActiveFlag { get { return _ActiveFlag; } set { _ActiveFlag = value; } }
        public string ScanCopyName { get { return _ScanCopyName; } set { _ScanCopyName = value; } }
        public string ManualContractId { get { return _ManualContractId; } set { _ManualContractId = value; } }
        public string ContractName { get { return _ContractName; } set { _ContractName = value; } }
        public string AccountManager { get { return _AccountManager; } set { _AccountManager = value; } }

        public string StaxYN { get { return _StaxYN; } set { _StaxYN = value; } }


        public DateTime ContractStartDate { get { return _ContractStartDate; } set { _ContractStartDate = value; } }
        public DateTime ContractEndDate { get { return _ContractEndDate; } set { _ContractEndDate = value; } }
        public DateTime ContractEffectDate { get { return _ContractEffectDate; } set { _ContractEffectDate = value; } }
        public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }
        public DateTime LastEditDate { get { return _LastEditDate; } set { _LastEditDate = value; } }

        #endregion

        #region Methods

        public static CCMBasicDetails GetCCMBasicDetails(string ContractID)
        {
            CCMBasicDetails ccmb = new CCMBasicDetails();
            string SQLQuery = @"SELECT *,ContractType=dbo.FN_GET_MSTR_TYP('PAYTYP',Contract_Type)
                                FROM Webx_CustContract_HDR 
                                WHERE ContractID='" + ContractID + "'";
            DataTable BasicDetailsTable = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLQuery).Tables[0];

            if (BasicDetailsTable.Rows.Count > 0)
            {
                ccmb.ContractID = ContractID;
                ccmb.ContractType = BasicDetailsTable.Rows[0]["Contract_Type"].ToString();
            }
            return ccmb;
        }

        public static void CCMBasicDetailsEntry(CCMBasicDetails CCMBasicDetail)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(CCMBasicDetail.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, CCMBasicDetail);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string strXMLCCMBasicDetails = xd.InnerXml;

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLCCMBasicDetails", strXMLCCMBasicDetails, SqlDbType.Xml);


                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_CCMBasicDetails_Update", paramsToStore);

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();
                throw ex;
            }
            trn.Commit();
            con.Close();

        }


        #endregion
    }
	 public class CCMProductType
    {
        string transmode, custcode, contractid, producttype, cftmeasure;
        public CCMProductType()
        {
            transmode = ""; custcode = ""; contractid = ""; producttype = ""; cftmeasure = "";
        }
        public string TransMode { get { return transmode; } set { transmode = value; } }
        public string CustCode { get { return custcode; } set { custcode = value; } }
        public string ContractID { get { return contractid; } set { contractid = value; } }
        public string Producttype { get { return producttype; } set { producttype = value; } }
        public string VolMeasure { get { return cftmeasure; } set { cftmeasure = value; } }
    }
    public class CCMModeWiseService
    {
        #region Variable[s]
        string transmode, custcode, contractid, fuelsurchrgbas, min_frtbas, cftmeasure, vol_yn;
        double cftratio, min_frtbasrate, min_fuelsurchrg, max_fuelsurchrg;
        double fuelsurchrg, min_frtrate_per, min_subtot_per, lowlim_frt, upplim_frt, lowlim_subtot,_MinFrieghtBaseRs;
        double upplim_subtot, cutoff_hrs, cutoff_min, cutoff_trdays;
        string _STaxPaidby, _STaxPaidByOpts;
        bool _STaxPaidByEnabled;
        #endregion

        #region Constructor
        public CCMModeWiseService()
        {
            transmode = ""; custcode = ""; contractid = ""; cftmeasure = ""; fuelsurchrgbas = ""; min_frtbas = "";vol_yn = "";
            cftratio = 0; min_frtbasrate = 0; min_fuelsurchrg = 0; max_fuelsurchrg = 0;
            fuelsurchrg = 0; min_frtrate_per = 0; min_subtot_per = 0; lowlim_frt = 0; upplim_frt = 0;
            lowlim_subtot = 0; upplim_subtot = 0; cutoff_hrs = 0; cutoff_min = 0; cutoff_trdays = 0; _MinFrieghtBaseRs = 0;
            _STaxPaidby = ""; _STaxPaidByOpts = ""; _STaxPaidByEnabled = false;
        }
        #endregion

        #region Property
        public string TransMode { get { return transmode; } set { transmode = value; } }
        public string CustCode { get { return custcode; } set { custcode = value; } }
        public string ContractID { get { return contractid; } set { contractid = value; } }
	     public string vol_yn1 { get { return vol_yn; } set { vol_yn = value; } }
        public string FuelSurchargeBase { get { return fuelsurchrgbas; } set { fuelsurchrgbas = value; } }
        public string MinFreightBase { get { return min_frtbas; } set { min_frtbas = value; } }
        public string STaxPaidBy { get { return _STaxPaidby; } set { _STaxPaidby = value; } }
        public string STaxPaidByOpts { get { return _STaxPaidByOpts; } set { _STaxPaidByOpts = value; } }
        public bool STaxPaidByEnabled { get { return _STaxPaidByEnabled; } set { _STaxPaidByEnabled = value; } }

        public string VolMeasure { get { return cftmeasure; } set { cftmeasure = value; } }
        public double VolRatio { get { return cftratio; } set { cftratio = value; } }
        public double MinFreightBaseRate { get { return min_frtbasrate; } set { min_frtbasrate = value; } }
        public double MinFuelSurcharge { get { return min_fuelsurchrg; } set { min_fuelsurchrg = value; } }
        public double MaxFuelSurcharge { get { return max_fuelsurchrg; } set { max_fuelsurchrg = value; } }
        public double FuelSurchargeRate { get { return fuelsurchrg; } set { fuelsurchrg = value; } }
        public double MinFreightPer { get { return min_frtrate_per; } set { min_frtrate_per = value; } }
        public double MinSubtotalPer { get { return min_subtot_per; } set { min_subtot_per = value; } }
        public double FreightLowerLimit { get { return lowlim_frt; } set { lowlim_frt = value; } }
        public double FreightUpperLimit { get { return upplim_frt; } set { upplim_frt = value; } }
        public double SubtotalLowerLimit { get { return lowlim_subtot; } set { lowlim_subtot = value; } }
        public double SubtotalUpperLimit { get { return upplim_subtot; } set { upplim_subtot = value; } }
        public double CutoffHours { get { return cutoff_hrs; } set { cutoff_hrs = value; } }
        public double CutoffMinutes { get { return cutoff_min; } set { cutoff_min = value; } }
        public double CutoffTrdays { get { return cutoff_trdays; } set { cutoff_trdays = value; } }

        public double MinFrieghtBaseRs { get { return _MinFrieghtBaseRs; } set { _MinFrieghtBaseRs = value; } }
        
        
        #endregion

    }

    public class CCMFOVMatrix
    {
        #region Variable[s]
        private string custcode, contractid, risktype, ratetype;
        double rate;
        Int64 slabfrom, slabto;
        #endregion

        #region Property
        public string CustCode { get { return custcode; } set { custcode = value; } }
        public string ContractID { get { return contractid; } set { contractid = value; } }

        public string RiskType { get { return risktype; } set { risktype = value; } }
        public Int64 SlabFrom { get { return slabfrom; } set { slabfrom = value; } }
        public Int64 SlabTo { get { return slabto; } set { slabto = value; } }

        public double FOVRate { get { return rate; } set { rate = value; } }
        public string RateType { get { return ratetype; } set { ratetype = value; } }
        #endregion
    }

    public class CCMServices
    {
        #region Variable[s]
        private string custcode, contractid, chargebas, slabtype, _CODRateType, _DACCRateType;

        string _TransMode, _ServiceType, _PickupDelivery, _RateType, _MatrixType;
        bool bFlatMpick, bFlatMdel, bLocMpick, bLocMdel, bFlatLoad, bLocLoad;
        bool bFlatUnload, bLocUnload, bFuelSurcharge, bOctroiSurcharge, bDeferment, bFreightDiscount;
        bool bVolumetric, bCODDOD, bDACC, bODA, bSKUWise, bFrtLimAppl, bSubLimAppl, bFlagFreightPerInv;
        bool bUseInvNo, bUseInvDate, _bFlagAllowDeliveryBeforeDemurrageBill, FREFDOC;
        bool _FlagReattempt;
        private string REFDOC_t;

        private bool _FlagBillSubLocSameAsGenLoc;
        private string volweight, risktype, minfreighttype, genloc, subloc, colloc, billinst, staxpayer;
        private string _DemurrageCalculationBas,_BillLocRule;
        private string octbas, mp_chrg_appl, frt_disc_ratetype, frt_disc_contractid, bil_schedule;
        private double mincod, codper, mindacc, daccper, minoct, maxoct, octrate, deferper, frt_disc_rate;
        private double creditlim, committedbus, frt_inv_per,_ReattemptCharge;
        private double _MinDemurrageCharge, _MaxDemurrageCharge, _DemurrageRate;
        private int _DemurrageDays, creditdays, deferdays;
        private string _DemurrageRateType;
        #endregion

        #region Constructor

        public CCMServices()
        {
            bFlatMpick = false; bFlatMdel = false;
            bLocMpick = false; bLocMdel = false; bFlatLoad = false; bLocLoad = false;
            bFlatUnload = false; bLocUnload = false; bFuelSurcharge = false; bOctroiSurcharge = false;
            bVolumetric = false; bCODDOD = false; bDACC = false; bODA = false; bSKUWise = false;
            bFrtLimAppl = false; bSubLimAppl = false; bDeferment = false; bFreightDiscount = false; FREFDOC = false;
            _TransMode = ""; _ServiceType = ""; _RateType = ""; _MatrixType = "";
            custcode = ""; contractid = ""; slabtype = "";
            volweight = ""; risktype = ""; minfreighttype = ""; genloc = ""; subloc = ""; colloc = "";
            billinst = ""; staxpayer = ""; octbas = ""; frt_disc_ratetype = ""; REFDOC_t = "";
            _BillLocRule = "";
            mincod = 0; codper = 0; mindacc = 0; daccper = 0; minoct = 0; maxoct = 0; octrate = 0;
            creditlim = 0; committedbus = 0; creditdays = 0; deferdays = 0; deferper = 0;
            frt_disc_rate = 0; _FlagBillSubLocSameAsGenLoc = false;
        }
        #endregion

        #region Property


        public bool FlagBillSubLocSameAsGenLoc { get { return _FlagBillSubLocSameAsGenLoc; } set { _FlagBillSubLocSameAsGenLoc = value; } }
        public string CustCode { get { return custcode; } set { custcode = value; } }
        public string ContractID { get { return contractid; } set { contractid = value; } }
        public string ServiceType { get { return _ServiceType; } set { _ServiceType = value; } }
        public string TransMode { get { return _TransMode; } set { _TransMode = value; } }
        public string PickupDelivery { get { return _PickupDelivery; } set { _PickupDelivery = value; } }
        public string RateType { get { return _RateType; } set { _RateType = value; } }
        public string MatrixType { get { return _MatrixType; } set { _MatrixType = value; } }

        public bool FlagReattempt { get { return _FlagReattempt; } set { _FlagReattempt = value; } }
        public double ReattemptCharge { get { return _ReattemptCharge; } set { _ReattemptCharge = value; } }

        public bool FlagUseInvNo { get { return bUseInvNo; } set { bUseInvNo = value; } }
        public bool FlagUseInvDate { get { return bUseInvDate; } set { bUseInvDate = value; } }

        public bool FlagFlatMultiPickup { get { return bFlatMpick; } set { bFlatMpick = value; } }
        public bool FlagLocMultiPickup { get { return bLocMpick; } set { bLocMpick = value; } }
        public bool FlagFlatMultiDelivery { get { return bFlatMdel; } set { bFlatMdel = value; } }
        public bool FlagLocMultiDelivery { get { return bLocMdel; } set { bLocMdel = value; } }
        public bool FlagFlatLoading { get { return bFlatLoad; } set { bFlatLoad = value; } }
        public bool FlagLocLoading { get { return bLocLoad; } set { bLocLoad = value; } }
        public bool FlagFlatUnLoading { get { return bFlatUnload; } set { bFlatUnload = value; } }
        public bool FlagLocUnLoading { get { return bLocUnload; } set { bLocUnload = value; } }
        public bool FlagFuelSurcharge { get { return bFuelSurcharge; } set { bFuelSurcharge = value; } }
        public bool FlagOctroiSurcharge { get { return bOctroiSurcharge; } set { bOctroiSurcharge = value; } }
        public bool FlagFreightPerInvoice { get { return bFlagFreightPerInv; } set { bFlagFreightPerInv = value; } }
        public double FreightRatePerInvoice { get { return frt_inv_per; } set { frt_inv_per = value; } }

        public string FreightDiscContractID { get { return frt_disc_contractid; } set { frt_disc_contractid = value; } }

        public bool FlagVolumetric { get { return bVolumetric; } set { bVolumetric = value; } }
        public bool FlagCODDOD { get { return bCODDOD; } set { bCODDOD = value; } }
        public bool FlagDACC { get { return bDACC; } set { bDACC = value; } }
        public bool FlagODA { get { return bODA; } set { bODA = value; } }

        public bool FlagREFDOC { get { return FREFDOC; } set { FREFDOC = value; } }
        public string REFDOC_txt { get { return REFDOC_t; } set { REFDOC_t = value; } }

        public bool FlagSKUWise { get { return bSKUWise; } set { bSKUWise = value; } }
        public bool FlagDeferment { get { return bDeferment; } set { bDeferment = value; } }
        public string MPChargeApplTo { get { return mp_chrg_appl; } set { mp_chrg_appl = value; } }

        public string VolumetricWeightType { get { return volweight; } set { volweight = value; } }
        public string RiskType { get { return risktype; } set { risktype = value; } }
        public string MinFreightType { get { return minfreighttype; } set { minfreighttype = value; } }
        public bool FlagFreightLimAppl { get { return bFrtLimAppl; } set { bFrtLimAppl = value; } }
        public bool FlagSubTotalLimAppl { get { return bSubLimAppl; } set { bSubLimAppl = value; } }
        public string BillGenLoc { get { return genloc; } set { genloc = value; } }
        public string BillSubLoc { get { return subloc; } set { subloc = value; } }
        public string BillColLoc { get { return colloc; } set { colloc = value; } }

        public string BillLocRule { get { return _BillLocRule; } set { _BillLocRule = value; } }
        
        public string BillInstance { get { return billinst; } set { billinst = value; } }
        public string BillSchedule { get { return bil_schedule; } set { bil_schedule = value; } }
        public string STaxPayer { get { return staxpayer; } set { staxpayer = value; } }
        public string OctroiRateType { get { return octbas; } set { octbas = value; } }
        public bool FlagFreightDiscount { get { return bFreightDiscount; } set { bFreightDiscount = value; } }
        public string FreightDiscountRateType { get { return frt_disc_ratetype; } set { frt_disc_ratetype = value; } }


        public double MinCODCharge { get { return mincod; } set { mincod = value; } }
        public double CODRate { get { return codper; } set { codper = value; } }
        public string CODRateType { get { return _CODRateType; } set { _CODRateType = value; } }
        public string DACCRateType { get { return _DACCRateType; } set { _DACCRateType = value; } }

        public double MinDACCCharge { get { return mindacc; } set { mindacc = value; } }
        public double DACCRate { get { return daccper; } set { daccper = value; } }
        public double MinOctroiCharge { get { return minoct; } set { minoct = value; } }
        public double MaxOctroiCharge { get { return maxoct; } set { maxoct = value; } }
        public double OctroiRate { get { return octrate; } set { octrate = value; } }
        public double CreditLimit { get { return creditlim; } set { creditlim = value; } }
        public double CommittedBusiness { get { return committedbus; } set { committedbus = value; } }
        public double FreightDiscountRate { get { return frt_disc_rate; } set { frt_disc_rate = value; } }

        public int DemurrageDays { get { return _DemurrageDays; } set { _DemurrageDays = value; } }
        public double MinDemurrageCharge { get { return _MinDemurrageCharge; } set { _MinDemurrageCharge = value; } }
        public double MaxDemurrageCharge { get { return _MaxDemurrageCharge; } set { _MaxDemurrageCharge = value; } }
        public double DemurrageRate { get { return _DemurrageRate; } set { _DemurrageRate = value; } }
        public string DemurrageRateType { get { return _DemurrageRateType; } set { _DemurrageRateType = value; } }
        public string DemurrageCalculationBas { get { return _DemurrageCalculationBas; } set { _DemurrageCalculationBas = value; } }

        public bool FlagDeliveryBeforeDemurrage { get { return _bFlagAllowDeliveryBeforeDemurrageBill; } set { _bFlagAllowDeliveryBeforeDemurrageBill = value; } }


        public int CreditDays { get { return creditdays; } set { creditdays = value; } }

        public double DefermentPercent { get { return deferper; } set { deferper = value; } }
        public int DefermentDay { get { return deferdays; } set { deferdays = value; } }

        #endregion

    }

    public class CCMChargeConstraint
    {
        #region Variable[s]
        bool bUseTransMode, bUseRateType, bUseFrom, bUseTo;
        string contractid, chargebas, chargecode, chargetype, slabtype, useslab;
        #endregion

        #region Constructor
        public CCMChargeConstraint()
        {
            bUseTransMode = false; bUseRateType = false; bUseFrom = false; bUseTo = false;
            contractid = ""; chargebas = "NONE"; chargecode = ""; chargetype = ""; slabtype = "";
        }
        #endregion

        #region Property
        public string ContractID { get { return contractid; } set { contractid = value; } }
        public string ChargeBas { get { return chargebas; } set { chargebas = value; } }
        public string ChargeCode { get { return chargecode; } set { chargecode = value; } }
        public string ChargeType { get { return chargetype; } set { chargetype = value; } }

        public bool UseTransMode { get { return bUseTransMode; } set { bUseTransMode = value; } }
        public bool UseRateType { get { return bUseRateType; } set { bUseRateType = value; } }
        public bool UseFrom { get { return bUseFrom; } set { bUseFrom = value; } }
        public bool UseTo { get { return bUseTo; } set { bUseTo = value; } }
        public string SlabType { get { return slabtype; } set { slabtype = value; } }


        #endregion

        #region Method
        public static void CCMChargeConstraintEntry(CCMChargeConstraint[] CCMChargeConstraints, string SavingBy)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(CCMChargeConstraints.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, CCMChargeConstraints);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string strxml = xd.InnerXml;

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strxml", strxml, SqlDbType.Xml);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@SavingBy", SavingBy, SqlDbType.VarChar);
                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_CustContractChargeconstraint_Entry", paramsToStore);

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();
                throw ex;
            }
            trn.Commit();
            con.Close();

        }

        #endregion


    }

    public class CCMFTLMatix
    {
        #region Variable[s]
        string sContractID, sRateType, sMatrixType, sFromLoc, sToLoc, sFTLType, sTransMode, sFlagInsert, sOldFTLType;
        string sOldFromLoc, sOldToLoc,sBillLoc;
        double dRate;
        Int32 iTRDays;
        #endregion

        #region Constructor
        public CCMFTLMatix()
        {
            sContractID = ""; sRateType = ""; sMatrixType = ""; sFromLoc = ""; sToLoc = "";
            sFTLType = ""; sTransMode = ""; sFlagInsert = ""; sOldFTLType = "";
            dRate = 0; iTRDays = 0; sOldFromLoc = ""; sOldToLoc = ""; sBillLoc = "";
        }
        #endregion

        #region Property
        public string ContractID { get { return sContractID; } set { sContractID = value; } }
        public string RateType { get { return sRateType; } set { sRateType = value; } }
        public string MatrixType { get { return sMatrixType; } set { sMatrixType = value; } }
        public string TransMode { get { return sTransMode; } set { sTransMode = value; } }
        public string FromLoc { get { return sFromLoc; } set { sFromLoc = value; } }
        public string ToLoc { get { return sToLoc; } set { sToLoc = value; } }
        public string FTLType { get { return sFTLType; } set { sFTLType = value; } }
        public string OldFTLType { get { return sOldFTLType; } set { sOldFTLType = value; } }
        public string OldToLoc { get { return sOldToLoc; } set { sOldToLoc = value; } }
        public string OldFromLoc { get { return sOldFromLoc; } set { sOldFromLoc = value; } }
        public string FlagInsert { get { return sFlagInsert; } set { sFlagInsert = value; } }
        public string BillLoc { get { return sBillLoc; } set { sBillLoc = value; } }

        
        public double Rate { get { return dRate; } set { dRate = value; } }
        public Int32 TRDays { get { return iTRDays; } set { iTRDays = value; } }
        #endregion
    }

    public class CCMFCLMatix
    {
        #region Variable[s]
        string sContractID, sRateType, sMatrixType, sFromLoc, sToLoc, sFTLType, sTransMode, sFlagInsert, sOldFTLType;
        string sOldFromLoc, sOldToLoc, sBillLoc, sProRataApp, sProRataMethod, sBasedOn1, sBaseCode1, sBasedOn2, sBaseCode2;
        double sProRata;
        double dRate;
        Int32 iTRDays;
        #endregion

        #region Constructor
        public CCMFCLMatix()
        {
            sContractID = ""; sRateType = ""; sMatrixType = ""; sFromLoc = ""; sToLoc = "";
            sFTLType = ""; sTransMode = ""; sFlagInsert = ""; sOldFTLType = "";
            dRate = 0; iTRDays = 0; sOldFromLoc = ""; sOldToLoc = ""; sBillLoc = "";
            sProRataApp = ""; sProRataMethod = ""; sProRata = 0;
            sBasedOn1 = ""; sBaseCode1 = ""; sBasedOn2 = ""; sBaseCode2 = "";
        }
        #endregion

        #region Property
        public string ContractID { get { return sContractID; } set { sContractID = value; } }
        public string RateType { get { return sRateType; } set { sRateType = value; } }
        public string MatrixType { get { return sMatrixType; } set { sMatrixType = value; } }
        public string TransMode { get { return sTransMode; } set { sTransMode = value; } }
        public string FromLoc { get { return sFromLoc; } set { sFromLoc = value; } }
        public string ToLoc { get { return sToLoc; } set { sToLoc = value; } }
        public string FTLType { get { return sFTLType; } set { sFTLType = value; } }
        public string OldFTLType { get { return sOldFTLType; } set { sOldFTLType = value; } }
        public string OldToLoc { get { return sOldToLoc; } set { sOldToLoc = value; } }
        public string OldFromLoc { get { return sOldFromLoc; } set { sOldFromLoc = value; } }
        public string FlagInsert { get { return sFlagInsert; } set { sFlagInsert = value; } }
        public string BillLoc { get { return sBillLoc; } set { sBillLoc = value; } }

        public string ProRataApp { get { return sProRataApp; } set { sProRataApp = value; } }
        public string ProRataMethod { get { return sProRataMethod; } set { sProRataMethod = value; } }
        public double ProRata { get { return sProRata; } set { sProRata = value; } }

        public double Rate { get { return dRate; } set { dRate = value; } }
        public Int32 TRDays { get { return iTRDays; } set { iTRDays = value; } }

        public string BasedOn1 { get { return sBasedOn1; } set { sBasedOn1 = value; } }
        public string BaseCode1 { get { return sBaseCode1; } set { sBaseCode1 = value; } }
        public string BasedOn2 { get { return sBasedOn2; } set { sBasedOn2 = value; } }
        public string BaseCode2 { get { return sBaseCode2; } set { sBaseCode2 = value; } }

        #endregion
    }

    public class CCMChargeMatrix
    {
        #region Variable[s]
        string _ContractID, _BasedOn1, _BaseCode1, _BasedOn2, _BaseCode2, _FlagInsert;
        string _ChargeType, _ChargeCode, _FromLoc, _ToLoc, _RateType, _TransMode, _MatrixType;

        string _OldToLoc, _OldFromLoc, _OldRateType, _OldTransMode,_BillLoc;
        Int32 _TrDays;
        double _Rate;

        #endregion

        #region Constructor

        public CCMChargeMatrix()
        {
            _ContractID = ""; _BasedOn1 = ""; _BaseCode1 = ""; _BasedOn2 = ""; _BaseCode2 = "";
            _ChargeType = ""; _ChargeCode = ""; _FromLoc = ""; _ToLoc = ""; _RateType = ""; _TransMode = ""; _MatrixType = "";
            _OldToLoc = ""; _OldFromLoc = ""; _OldRateType = ""; _OldTransMode = ""; _FlagInsert = "N"; _BillLoc = "";
            _TrDays = 0; _Rate = 0;
        }
        #endregion

        #region Property
        public string ContractID { get { return _ContractID; } set { _ContractID = value; } }
        public string BasedOn1 { get { return _BasedOn1; } set { _BasedOn1 = value; } }
        public string BaseCode1 { get { return _BaseCode1; } set { _BaseCode1 = value; } }
        public string BasedOn2 { get { return _BasedOn2; } set { _BasedOn2 = value; } }
        public string BaseCode2 { get { return _BaseCode2; } set { _BaseCode2 = value; } }

        public string ChargeType { get { return _ChargeType; } set { _ChargeType = value; } }
        public string ChargeCode { get { return _ChargeCode; } set { _ChargeCode = value; } }
        public string FromLoc { get { return _FromLoc; } set { _FromLoc = value; } }
        public string ToLoc { get { return _ToLoc; } set { _ToLoc = value; } }
        public string RateType { get { return _RateType; } set { _RateType = value; } }
        public string TransMode { get { return _TransMode; } set { _TransMode = value; } }
        public string MatrixType { get { return _MatrixType; } set { _MatrixType = value; } }

        public Int32 TrDays { get { return _TrDays; } set { _TrDays = value; } }
        public double Rate { get { return _Rate; } set { _Rate = value; } }

        public string OldToLoc { get { return _OldToLoc; } set { _OldToLoc = value; } }
        public string OldFromLoc { get { return _OldFromLoc; } set { _OldFromLoc = value; } }
        public string OldTransMode { get { return _OldTransMode; } set { _OldTransMode = value; } }
        public string FlagInsert { get { return _FlagInsert; } set { _FlagInsert = value; } }
        public string BillLoc { get { return _BillLoc; } set { _BillLoc = value; } }
        
        #endregion

        #region Methods

        public static void CCMChargeMatrixEntry(CCMChargeMatrix[] ccmc, string SavingBy)
        {

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(ccmc.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, ccmc);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string sRates = xd.InnerXml;

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[3];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ChargeMatrix", sRates, SqlDbType.Xml);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@SavingBy", SavingBy, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@OutPut", "<root></root>", SqlDbType.Xml, ParameterDirection.Output);


                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_CHARGEMATRIX_ENTRY", paramsToStore);

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();
                throw ex;
            }
            trn.Commit();
            con.Close();
        }

        public static DataTable GetCCMChargeMatrix(string ContractID, string BasedOn1, string BaseCode1, string BasedOn2, string BaseCode2, string ChargeType, string ChargeCode, string MatrixType, string TransMode, string From, string To)
        {
            DataTable CCMChargeMatrix;
            string SQLQuery = "SELECT ";
            if (MatrixType == "R")
            {
                SQLQuery = SQLQuery + "(SELECT CodeDesc FROM Webx_Master_General WHERE CodeType='ZONE' AND CodeID=FromLoc) AS FromLoc,";
                SQLQuery = SQLQuery + "(SELECT CodeDesc FROM Webx_Master_General WHERE CodeType='ZONE' AND CodeID=ToLoc) AS ToLoc,";
            }
            else
            {
                SQLQuery = SQLQuery + "FromLoc,ToLoc,";
            }
            SQLQuery = SQLQuery + "BillLoc,Rate,RateType,TrDays,Trans_Type";
            SQLQuery = SQLQuery + " FROM dbo.Webx_CustContract_FRTMatrix_SingleSlab";
            SQLQuery = SQLQuery + " WHERE Contractid='" + ContractID + "'";
            SQLQuery = SQLQuery + " AND BasedOn1='" + BasedOn1 + "' AND BaseCode1='" + BaseCode1 + "'";
            SQLQuery = SQLQuery + " AND BasedOn2='" + BasedOn2 + "' AND BaseCode2='" + BaseCode2 + "'";
            SQLQuery = SQLQuery + " AND ChargeType='" + ChargeType + "' AND ChargeCode='" + ChargeCode + "'";
            SQLQuery = SQLQuery + " AND Loc_Reg='" + MatrixType + "'";
            SQLQuery = SQLQuery + " AND FromLoc LIKE '" + From + "%'";
            SQLQuery = SQLQuery + " AND ToLoc LIKE '" + To + "%'";
            if (TransMode != "A")
                SQLQuery = SQLQuery + " AND Trans_Type LIKE '" + TransMode + "'";
            CCMChargeMatrix = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLQuery).Tables[0];
            return CCMChargeMatrix;
        }



        #endregion

    }

    public class CCMMultipleSlabSundryRange
    {
        #region Variable[s]
        string _ContractId, _SlabCode, _RateType, _TransType;
        Int32 _SlabFrom, _SlabTo;
        #endregion

        #region Constructor

        public CCMMultipleSlabSundryRange()
        {
            _ContractId = "";
            _SlabCode = "";
            _RateType = "";
            _TransType = "";
            _SlabFrom = 0;
            _SlabTo = 0;
        }

        #endregion

        #region Property
        public string ContractId { get { return _ContractId; } set { _ContractId = value; } }
        public string SlabCode { get { return _SlabCode; } set { _SlabCode = value; } }
        public string RateType { get { return _RateType; } set { _RateType = value; } }
        public string TransType { get { return _TransType; } set { _TransType = value; } }

        public Int32 SlabFrom { get { return _SlabFrom; } set { _SlabFrom = value; } }
        public Int32 SlabTo { get { return _SlabTo; } set { _SlabTo = value; } }

        #endregion

        #region Methods
        public static void CCMMultipleSlabSundryRangeEntry(CCMMultipleSlabSundryRange[] CCMSlabSundryRange, string SavingBy)
        {

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(CCMSlabSundryRange.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, CCMSlabSundryRange);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string strxml = xd.InnerXml;

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strxml", strxml, SqlDbType.Xml);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@SavingBy", SavingBy, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "Usp_CCMMultipleSlabSundryRange_Entry", paramsToStore);

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();
                throw ex;
            }
            trn.Commit();
            con.Close();
        }
        #endregion
    }

    public class CCMMultipleSlabSundryMatrix
    {
        #region Variable[s]
        string _ContractId, _BasedOn1, _BaseCode1, _BasedOn2, _BasedCode2;
        string _FromLoc, _ToLoc, _SlabCode, _MatrixType, _TransType;
        Int32 _TRDays, _SlabTo;
        double _Rate;

        #endregion

        #region Constructor

        public CCMMultipleSlabSundryMatrix()
        {
            _ContractId = ""; _BasedOn1 = ""; _BaseCode1 = ""; _BasedOn2 = ""; _BasedCode2 = "";
            _FromLoc = ""; _ToLoc = ""; _SlabCode = ""; _MatrixType = "";
            _TransType = ""; _TRDays = 0;

        }

        #endregion

        #region Property
        public string ContractId { get { return _ContractId; } set { _ContractId = value; } }
        public string BasedOn1 { get { return _BasedOn1; } set { _BasedOn1 = value; } }
        public string BaseCode1 { get { return _BaseCode1; } set { _BaseCode1 = value; } }
        public string BasedOn2 { get { return _BasedOn2; } set { _BasedOn2 = value; } }
        public string BaseCode2 { get { return _BasedCode2; } set { _BasedCode2 = value; } }


        public string FromLoc { get { return _FromLoc; } set { _FromLoc = value; } }
        public string ToLoc { get { return _ToLoc; } set { _ToLoc = value; } }
        public string SlabCode { get { return _SlabCode; } set { _SlabCode = value; } }
        public string MatrixType { get { return _MatrixType; } set { _MatrixType = value; } }
        public string TransType { get { return _TransType; } set { _TransType = value; } }

        public Int32 TRDays { get { return _TRDays; } set { _TRDays = value; } }
        public Int32 SlabTo { get { return _SlabTo; } set { _SlabTo = value; } }

        #endregion

        #region Methods
        public static void CCMMultipleSlabSundryRangeEntry(CCMMultipleSlabSundryRange[] CCMSlabSundryRange, string SavingBy)
        {

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(CCMSlabSundryRange.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, CCMSlabSundryRange);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string strxml = xd.InnerXml;

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strxml", strxml, SqlDbType.Xml);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@SavingBy", SavingBy, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "Usp_CCMMultipleSlabSundryRange_Entry", paramsToStore);

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();
                throw ex;
            }
            trn.Commit();
            con.Close();
        }
        #endregion
    }

    public class CCMMatrixCombination
    {
        #region Variable[s]
        string _FromLoc, _ToLoc, _MatrixType, _BillLoc, _FlagInsert;


        #endregion

        #region Constructor

        public CCMMatrixCombination()
        {
            _FromLoc = "";
            _ToLoc = "";
            _MatrixType = "";
            _BillLoc = "";
            _FlagInsert = "";
        }
        #endregion

        #region Property

        public string FromLoc { get { return _FromLoc; } set { _FromLoc = value; } }
        public string ToLoc { get { return _ToLoc; } set { _ToLoc = value; } }
        public string MatrixType { get { return _MatrixType; } set { _MatrixType = value; } }
        public string BillLoc { get { return _BillLoc; } set { _BillLoc = value; } }
        public string FlagInsert { get { return _FlagInsert; } set { _FlagInsert = value; } }

        #endregion

        #region Methods
        public static WebxError CCMMatrixCombinationValidation(CCMMatrixCombination[] CCMMatrix)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(CCMMatrix.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, CCMMatrix);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string sRates = xd.InnerXml;

            WebxError werr = new WebxError();

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXML", sRates, SqlDbType.VarChar);
                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_CCM_Validate_MatrixCombination", paramsToStore);

                werr.Message = "All Okay";

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();

                string[] Message = ex.Message.ToString().Trim().Split('|');
                werr.Key = Message[0];
                werr.Message = Message[1] + "|" + Message[2];
                return werr;
            }

            trn.Commit();
            con.Close();
            return werr;

        }
        #endregion

    }
    
    public class CCMFCLMatrixCombination
    {
        #region Variable[s]
        string _FromLoc, _ToLoc, _MatrixType, _BillLoc, _FlagInsert;


        #endregion

        #region Constructor

        public CCMFCLMatrixCombination()
        {
            _FromLoc = "";
            _ToLoc = "";
            _MatrixType = "";
            _BillLoc = "";
            _FlagInsert = "";
        }
        #endregion

        #region Property

        public string FromLoc { get { return _FromLoc; } set { _FromLoc = value; } }
        public string ToLoc { get { return _ToLoc; } set { _ToLoc = value; } }
        public string MatrixType { get { return _MatrixType; } set { _MatrixType = value; } }
        public string BillLoc { get { return _BillLoc; } set { _BillLoc = value; } }
        public string FlagInsert { get { return _FlagInsert; } set { _FlagInsert = value; } }

        #endregion

        #region Methods
        public static WebxError CCMMatrixCombinationValidation(CCMFCLMatrixCombination[] CCMMatrix)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(CCMMatrix.GetType());
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            x.Serialize(stream, CCMMatrix);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            string sRates = xd.InnerXml;

            WebxError werr = new WebxError();

            SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXML", sRates, SqlDbType.VarChar);
                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_CCM_Validate_MatrixCombination", paramsToStore);

                werr.Message = "All Okay";

            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();

                string[] Message = ex.Message.ToString().Trim().Split('|');
                werr.Key = Message[0];
                werr.Message = Message[1] + "|" + Message[2];
                return werr;
            }

            trn.Commit();
            con.Close();
            return werr;

        }
        #endregion

    }

}

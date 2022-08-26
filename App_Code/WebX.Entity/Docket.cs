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


    public class WebxError
    {
        public string Key;
        public string Message;

        public WebxError()
        {
            Key = "";
            Message = "";
        }
        public WebxError(string key)
        {
            Key = key;
        }

        public WebxError(string key, string msg)
        {
            Key = key; Message = msg;
        }
    }



    /// <summary>
    /// Summary description for Docket
    /// </summary>
    public class Docket
    {
        public Docket()
        {
            //
            // TODO: Add constructor logic here
            //
            custrefdelno = ""; custrefgpno = "";
			/* Add GST wise Change */
            GSTParty = ""; GSTState = ""; GSTIN = ""; SACCategory = ""; GSTServiceType = ""; ISRCMApplicable = ""; IsGSTPartyRegistered = "";
            IsGStDocumentScan = ""; GSTRemark = ""; EntryFrom = ""; SACCode = "";
            /* Add GST wise Change */
        }
		/* Add GST wise Change */
        public string GSTParty { get; set; }
        public string GSTState { get; set; }
        public string GSTIN { get; set; }
        public string SACCategory { get; set; }
        public string GSTServiceType { get; set; }
        public string ISRCMApplicable { get; set; }
        public string IsGSTPartyRegistered { get; set; }
        public string IsGStDocumentScan { get; set; }
        public string GSTRemark { get; set; }
        public string SACCode { get; set; }
        public string GSTExempted { get; set; }
        public string GSTExemptionCategory { get; set; }
        public string EntryFrom { get; set; }
        public string PlaceOfSupply { get; set; }
        /* Add GST wise Change */
        private string dockno = "", paybas = "", partycode = "", orgnloc = "", delloc = "", transmode = "", servicetype = "", ftltype = "", pickupdel = "";
        DateTime dockdate = DateTime.MinValue, permitdate = DateTime.MinValue, permitvaliditydate = DateTime.MinValue, permitrecvdate = DateTime.MinValue, policydate = DateTime.MinValue, invdate = DateTime.MinValue;
        DateTime edd = DateTime.MinValue, entrydate = DateTime.MinValue, custrefdate = DateTime.MinValue;

        private string fromcity = "", tocity = "", packtype = "", prodtype = "", flagvolumetric = "", flagcoddod = "", flagdacc = "", flagoda = "", flaglocal = "";
        private string flagpermit = "", loadtype = "", dopino = "", businesstype = "", remarks = "", mrno = "";
        private string csgncd = "", csgnname = "", csgnaddr = "", csgncity = "", csgnpincode = "", csgnteleno = "", csgnemail = "";
        private string csgecd = "", csgename = "", csgeaddr = "", csgecity = "", csgepincode = "", csgeteleno = "", csgeemail = "";
        private string obdno = "", entrysheetno = "", permitno = "", permitrecvdat = "", custrefdelno, custrefgpno;
        private string invno = "", risktype = "";
        private double coddodcharged, coddodamount, dacccharged;
        private Int64 invamt, actualweight, chargedweight, noofpkgs;
        private string bacode = "", policyno = "", custrefno = "", privatemark = "", tpnumber = "", staxpaidby = "", staxregno = "", billedat = "";
        private double internalcovers = 0.0, modvatecovers = 0.0;
        private string sourcedockno = "", flagmultipickup = "", flagmultidelivery = "", flagstaxexmpt = "", partyas = "", doctype = "", entryby = "";

        public string DockNo { get { return dockno; } set { dockno = value; } }
        public string MRNo { get { return mrno; } set { mrno = value; } }
        public DateTime DockDate { get { return dockdate; } set { dockdate = value; } }
        public string PayBase { get { return paybas; } set { paybas = value; } }
        public string PartyCode { get { return partycode; } set { partycode = value; } }
        public string OrgnLoc { get { return orgnloc; } set { orgnloc = value; } }
        public string DelLoc { get { return delloc; } set { delloc = value; } }
        public string TransMode { get { return transmode; } set { transmode = value; } }
        public string ServiceType { get { return servicetype; } set { servicetype = value; } }
        public string FTLType { get { return ftltype; } set { ftltype = value; } }
        public string PickUpDel { get { return pickupdel; } set { pickupdel = value; } }
        public string FromCity { get { return fromcity; } set { fromcity = value; } }
        public string ToCity { get { return tocity; } set { tocity = value; } }
        public string PackType { get { return packtype; } set { packtype = value; } }
        public string ProdType { get { return prodtype; } set { prodtype = value; } }
        public string Remarks { get { return remarks; } set { remarks = value; } }

        public string FlagVolumetric { get { return flagvolumetric; } set { flagvolumetric = value; } }
        public string FlagCODDOD { get { return flagcoddod; } set { flagcoddod = value; } }
        public string FlagDACC { get { return flagdacc; } set { flagdacc = value; } }
        public string FlagODA { get { return flagoda; } set { flagoda = value; } }
        public string FlagLocal { get { return flaglocal; } set { flaglocal = value; } }
        public string FlagPermit { get { return flagpermit; } set { flagpermit = value; } }

        public string LoadType { get { return loadtype; } set { loadtype = value; } }
        public string DopiNo { get { return dopino; } set { dopino = value; } }
        public string BusinessType { get { return businesstype; } set { businesstype = value; } }

        public string ConsignorCode { get { return csgncd; } set { csgncd = value; } }
        public string ConsignorName { get { return csgnname; } set { csgnname = value; } }
        public string ConsignorAddress { get { return csgnaddr; } set { csgnaddr = value; } }
        public string ConsignorCity { get { return csgncity; } set { csgncity = value; } }
        public string ConsignorPinCode { get { return csgnpincode; } set { csgnpincode = value; } }
        public string ConsignorPhone { get { return csgnteleno; } set { csgnteleno = value; } }
        public string ConsignorEmail { get { return csgnemail; } set { csgnemail = value; } }

        public string ConsigneeCode { get { return csgecd; } set { csgecd = value; } }
        public string ConsigneeName { get { return csgename; } set { csgename = value; } }
        public string ConsigneeAddress { get { return csgeaddr; } set { csgeaddr = value; } }
        public string ConsigneeCity { get { return csgecity; } set { csgecity = value; } }
        public string ConsigneePinCode { get { return csgepincode; } set { csgepincode = value; } }
        public string ConsigneePhone { get { return csgeteleno; } set { csgeteleno = value; } }
        public string ConsigneeEmail { get { return csgeemail; } set { csgeemail = value; } }

        public string EntrySheetNo
        {
            get { return entrysheetno; }
            set { entrysheetno = value; }
        }
        public string OBDNo
        {
            get { return obdno; }
            set { obdno = value; }
        }
        public string PermitNo
        {
            get { return permitno; }
            set { permitno = value; }
        }
        public DateTime PermitDate
        {
            get { return permitdate; }
            set { permitdate = value; }
        }
        public DateTime PermitValidityDate
        {
            get { return permitvaliditydate; }
            set { permitvaliditydate = value; }


        }
        public DateTime PermitRecieveDate
        {
            get { return permitrecvdate; }
            set { permitrecvdate = value; }
        }
        public string PermitRecievedAt
        {
            get { return permitrecvdat; }
            set { permitrecvdat = value; }
        }
        public string InvoiceNo
        {
            get { return invno; }
            set { invno = value; }
        }
        public DateTime InvoiceDate
        {
            get { return invdate; }
            set { invdate = value; }
        }
        public Int64 InvoiceAmount
        {
            get { return invamt; }
            set { invamt = value; }

        }
        public string BACode
        {
            get { return bacode; }
            set { bacode = value; }
        }
        public string PolicyNo
        {
            get { return policyno; }
            set { policyno = value; }
        }
        public DateTime PolicyDate
        {
            get { return policydate; }
            set { policydate = value; }
        }
        public double InternalCovers
        {
            get { return internalcovers; }
            set { internalcovers = value; }
        }
        public double ModvatCovers
        {
            get { return modvatecovers; }
            set { modvatecovers = value; }
        }
        public string CustomerRefNo
        {
            get { return custrefno; }
            set { custrefno = value; }
        }
        public string CustRefGPNo
        {
            get { return custrefgpno; }
            set { custrefgpno = value; }
        }

        public string CustRefDelNo
        {
            get { return custrefdelno; }
            set { custrefdelno = value; }
        }
        public DateTime CustomerRefDate
        {
            get { return custrefdate; }
            set { custrefdate = value; }
        }
        public string PrivateMark
        {
            get { return privatemark; }
            set { privatemark = value; }
        }
        public string TPNumber
        {
            get { return tpnumber; }
            set { tpnumber = value; }
        }
        public string RiskType
        {
            get { return risktype; }
            set { risktype = value; }
        }
        public Int64 NoOfPkgs
        {
            get { return noofpkgs; }
            set { noofpkgs = value; }
        }
        public Int64 ActualWeight
        {
            get { return actualweight; }
            set { actualweight = value; }
        }
        public Int64 ChargedWeight
        {
            get { return chargedweight; }
            set { chargedweight = value; }
        }
        public double CODDODCharged
        {
            get { return coddodcharged; }
            set { coddodcharged = value; }
        }
        public double CODDODAmount
        {
            get { return coddodamount; }
            set { coddodamount = value; }
        }
        public double DACCCharged
        {
            get { return dacccharged; }
            set { dacccharged = value; }
        }
        public DateTime EDD
        {
            get { return edd; }
            set { edd = value; }
        }
        public string STaxPaidBy
        {
            get { return staxpaidby; }
            set { staxpaidby = value; }
        }
        public string STaxRegNo
        {
            get { return staxregno; }
            set { staxregno = value; }
        }
        public string BilledAt
        {
            get { return billedat; }
            set { billedat = value; }
        }
        public string SourceDockNo
        {
            get { return sourcedockno; }
            set { sourcedockno = value; }
        }
        public string FlagMultiPickUp
        {
            get { return flagmultipickup; }
            set { flagmultipickup = value; }
        }
        public string FlagMultiDelivery
        {
            get { return flagmultidelivery; }
            set { flagmultidelivery = value; }
        }
        public string FlagStaxExmpt
        {
            get { return flagstaxexmpt; }
            set { flagstaxexmpt = value; }
        }
        public string PartyAs
        {
            get { return partyas; }
            set { partyas = value; }
        }
        public string DocType
        {
            get { return doctype; }
            set { doctype = value; }
        }
        public string EntryBy
        {
            get { return entryby; }
            set { entryby = value; }
        }
        public DateTime EntryDate
        {
            get { return entrydate; }
            set { entrydate = value; }
        }
    }

    public class DocketCharges
    {
        /* SB Cess */
        public DocketCharges()
        {
            SBCess = 0; SbcRate = 0;
            /* KK Cess*/
            KKCess = 0; KKCessRate = 0;
            /* KK Cess*/
			/* Add GST wise Change */
            GSTRate = 0; GSTAmount = 0; GSTCharged = 0;
            /* Add GST wise Change */
        }
        /* SB Cess */

        private double[] schg = new double[34];
        private double freight, subtotal, servicetax, educess, heducess, dockettotal, freightrate, _ServiceTaxRate;
        string ratetype, dockno;
        double discount, discountRate;
        string discountType;
		/* Add GST wise Change */
        public double GSTRate { get; set; }
        public double GSTAmount { get; set; }
        public double GSTCharged { get; set; }
        /* Add GST wise Change */

        /* SB Cess */
        public double SbcRate { get; set; }
        public double SBCess { get; set; }
        /* SB Cess */

        /* KK Cess*/
        public double KKCessRate { get; set; }
        public double KKCess { get; set; }
        /* KK Cess */
        public string DockNo
        {
            get { return dockno; }
            set { dockno = value; }
        }

        public double[] Charges
        {
            get { return schg; }
            set { schg = value; }
        }

        public double Discount
        {
            get { return discount; }
            set { discount = value; }
        }
        public string DiscountType
        {
            get { return discountType; }
            set { discountType = value; }
        }
        public double DiscountRate
        {
            get { return discountRate; }
            set { discountRate = value; }
        }

        public double FreightRate
        {
            get { return freightrate; }
            set { freightrate = value; }
        }

        public string RateType
        {
            get { return ratetype; }
            set { ratetype = value; }
        }

        public double Freight
        {
            get { return freight; }
            set { freight = value; }
        }

        public double SubTotal
        {
            get { return subtotal; }
            set { subtotal = value; }
        }

        public double ServiceTax
        {
            get { return servicetax; }
            set { servicetax = value; }
        }

        public double EduCess
        {
            get { return educess; }
            set { educess = value; }
        }

        public double HEduCess
        {
            get { return heducess; }
            set { heducess = value; }
        }

        public double DocketTotal
        {
            get
            { return dockettotal; }
            set { dockettotal = value; }
        }

		public double ServiceTaxRate
        {
            get
            { return _ServiceTaxRate; }
            set { _ServiceTaxRate = value; }
        }
    }

    public class DocketInvoice
    {

        private string dockno, invno;
        DateTime invdate;
        private double declval, pkgsno, invamt, actualweight, vol_l, vol_b, vol_h, cfttot;

        public string DockNo
        {
            get
            { return dockno; }
            set { dockno = value; }
        }
        public string InvoiceNo
        {
            get
            { return invno; }
            set { invno = value; }
        }

        public DateTime InvoiceDate
        {
            get { return invdate; }
            set { invdate = value; }
        }

        public double DeclaredValue
        {
            get { return declval; }
            set { declval = value; }
        }
        public double NoOfPkgs
        {
            get { return pkgsno; }
            set { pkgsno = value; }
        }

        public double InvoiceAmount
        {
            get { return invamt; }
            set { invamt = value; }
        }

        public double ActualWeight
        {
            get { return actualweight; }
            set { actualweight = value; }
        }

        public double Vol_Length
        {
            get { return vol_l; }
            set { vol_l = value; }
        }

        public double Vol_Breadth
        {
            get { return vol_b; }
            set { vol_b = value; }
        }

        public double Vol_Height
        {
            get { return vol_h; }
            set { vol_h = value; }
        }

        public double Vol_CFT
        {
            get { return cfttot; }
            set { cfttot = value; }
        }
    }

    public class DocketDocument
    {
        private string dockno, docksf, documentno;
        private double srno;
        public string DockNo
        {
            get
            { return dockno; }
            set { dockno = value; }
        }
        public string DockSF
        {
            get
            { return docksf; }
            set { docksf = value; }
        }
        public double SRNo
        {
            get
            { return srno; }
            set { srno = value; }
        }
        public string DocumentNo
        {
            get
            { return documentno; }
            set { documentno = value; }
        }

    }

    public class ContractServices
    {
        private bool flag_found, air_yn, road_yn, train_yn, express_yn;
        private bool sundry_yn, ftl_yn;
        private bool volumetric_yn, coddod_enable_yn, dacc_enable_yn;
        private string pickupdel, risktype, volmeasuretype, fovtype, billingloc;
        private double cft2kg, cubicrate, fovcharge, fovownerrate, fovcarrierrate, coddodcharged, dacccharged;

        public ContractServices()
        {
            flag_found = false; air_yn = false; road_yn = false; train_yn = false; express_yn = false;
            sundry_yn = false; ftl_yn = false;
            volumetric_yn = false; coddod_enable_yn = false; dacc_enable_yn = false;
            pickupdel = ""; risktype = ""; volmeasuretype = ""; fovtype = ""; billingloc = "";
            cft2kg = 0; cubicrate = 0; fovcharge = 0; fovownerrate = 0; fovcarrierrate = 0; coddodcharged = 0;
            dacccharged = 0;
        }


        public bool FlagFound
        {
            get { return flag_found; }
            set { flag_found = value; }
        }
        public bool FlagAir
        {
            get { return air_yn; }
            set { air_yn = value; }
        }
        public bool FlagRoad
        {
            get { return road_yn; }
            set { road_yn = value; }
        }
        public bool FlagTrain
        {
            get { return train_yn; }
            set { train_yn = value; }
        }
        public bool FlagExpress
        {
            get { return express_yn; }
            set { express_yn = value; }
        }
        public bool FlagSundry
        {
            get { return sundry_yn; }
            set { sundry_yn = value; }
        }
        public bool FlagFTL
        {
            get { return ftl_yn; }
            set { ftl_yn = value; }
        }
        public bool FlagVolumetric
        {
            get { return volumetric_yn; }
            set { volumetric_yn = value; }
        }
        public bool FlagCODDODEnable
        {
            get { return coddod_enable_yn; }
            set { coddod_enable_yn = value; }
        }
        public bool FlagDACCEnable
        {
            get { return dacc_enable_yn; }
            set { dacc_enable_yn = value; }
        }
        public string PickUpDel
        {
            get { return pickupdel; }
            set { pickupdel = value; }
        }
        public string RiskType
        {
            get { return risktype; }
            set { risktype = value; }
        }
        public string VolMeasureType
        {
            get { return volmeasuretype; }
            set { volmeasuretype = value; }
        }
        public string FOVType
        {
            get { return fovtype; }
            set { fovtype = value; }
        }
        public string BillingLoc
        {
            get { return billingloc; }
            set { billingloc = value; }
        }
        public double CFT2KG
        {
            get { return cft2kg; }
            set { cft2kg = value; }
        }
        public double CubicRate
        {
            get { return cubicrate; }
            set { cubicrate = value; }
        }
        public double FOVCharge
        {
            get { return fovcharge; }
            set { fovcharge = value; }
        }
        public double FOVOwnerRate
        {
            get { return fovownerrate; }
            set { fovownerrate = value; }
        }
        public double FOVCarrierRate
        {
            get { return fovcarrierrate; }
            set { fovcarrierrate = value; }
        }
        public double CODDODCharged
        {
            get { return coddodcharged; }
            set { coddodcharged = value; }
        }
        public double DACCCharged
        {
            get { return dacccharged; }
            set { dacccharged = value; }
        }

    }

    public class DocketServiceTax
    {
        public DocketServiceTax()
        {

			/* KK Cess*/
            transmode = "2"; staxpayer = "T"; servicetype = "1"; exceedamt = 0;
            date = DateTime.Now.Date;
            /* KK Cess*/
			
            /* SB Cess*/
            SbcRate = 0; SBCess = 0;
            /* SB Cess*/
			/* KK Cess*/
            KKCessRate = 0; KKCess = 0;
            IsRebateApplicable = true;
            CheckExceedAmount = true;
            /* KK Cess*/
        }
        private double subtotal, servicetax = 0, educess = 0, heducess = 0, staxrate = 0, staxratestd = 0, cessrate = 0, hcessrate = 0;
        private double cessratestd = 0, hecessratestd = 0, exceedamt=0, sbcessratestd = 0, kkcessratestd = 0, rebatePercentage = 0;
        private string transmode = "", staxpayer = "", servicetype = "";
        private DateTime date;

        /* SB Cess*/
        public double SbcRate { get; set; }
        public double SBCess { get; set; }
        /* SB Cess*/
		
		/* KK Cess*/
        public double KKCessRate { get; set; }
        public double KKCess { get; set; }
        /* KK Cess*/

        /* KK Cess*/
        public bool IsRebateApplicable { get; set; }
        public bool CheckExceedAmount { get; set; }
        /* KK Cess*/
        public double RebatePercentage
        {
            get { return rebatePercentage; }
            set { rebatePercentage = value; }
        }

        public string TransMode
        {
            get { return transmode; }
            set { transmode = value; }
        }

        public string StaxPayer
        {
            get { return staxpayer; }
            set { staxpayer = value; }
        }

        public string ServiceType
        {
            get { return servicetype; }
            set { servicetype = value; }
        }

        public double SubTotal
        {
            get { return subtotal; }
            set { subtotal = value; }
        }

        public double ExceedAmount
        {
            get { return exceedamt; }
            set { exceedamt = value; }
        }

        public double StdSTaxRate
        {
            get { return staxratestd; }
            set { staxratestd = value; }
        }

        public double StdEduCessRate
        {
            get { return cessratestd; }
            set { cessratestd = value; }
        }

        public double StdHEduCessRate
        {
            get { return hecessratestd; }
            set { hecessratestd = value; }
        }

        public double StdSbCessRate
        {
            get { return sbcessratestd; }
            set { sbcessratestd = value; }
        }

        public double StdKKCessRate
        {
            get { return kkcessratestd; }
            set { kkcessratestd = value; }
        }

        public double STaxRate
        {
            get { return staxrate; }
            set { staxrate = value; }
        }

        public double EduCessRate
        {
            get { return cessrate; }
            set { cessrate = value; }
        }

        public double HEduCessRate
        {
            get { return hcessrate; }
            set { hcessrate = value; }
        }

        public double ServiceTax
        {
            get { return servicetax; }
            set { servicetax = value; }
        }

        public double EduCess
        {
            get { return educess; }
            set { educess = value; }
        }

        public double HEduCess
        {
            get { return heducess; }
            set { heducess = value; }
        }

        public DateTime Date
        {
            get { return date; }
            set { date = value; }
        }

    }

    public class FOVTable
    {
        private string flag = "N";
        private string chargerule = "N";
        private string basecode = "N";
        private string risktype = "N";
        private string fovtype = "N";
        private double declaredvalue = 0;
        private double ownerrate = 0;
        private double carrierrate = 0;
        private double fovrate = 0;
        private double fovcharge = 0;

        public string FlagFOV
        {
            get { return flag; }
            set { flag = value; }
        }
        public string ChargeRule
        {
            get { return chargerule; }
            set { chargerule = value; }
        }
        public string BaseCode
        {
            get { return basecode; }
            set { basecode = value; }
        }
        public string RiskType
        {
            get { return risktype; }
            set { risktype = value; }
        }
        public string FOVType
        {
            get { return fovtype; }
            set { fovtype = value; }
        }

        public double DeclareValue
        {
            get { return declaredvalue; }
            set { declaredvalue = value; }
        }
        public double OwenerRate
        {
            get { return ownerrate; }
            set { ownerrate = value; }
        }
        public double CarrierRate
        {
            get { return carrierrate; }
            set { carrierrate = value; }
        }
        public double FOVRate
        {
            get { return fovrate; }
            set { fovrate = value; }
        }
        public double FOVCharge
        {
            get { return fovcharge; }
            set { fovcharge = value; }
        }
    }

    public class ContractKeys
    {
        private DateTime dockdate;
        private string status = "", description = "", contractid = "", foundcontract = "", flagproceed = "", depth = "", paybas = "";
        private string fromcity = "", tocity = "", orgnloc = "", delloc = "";
        private string basedon1 = "", basecode1 = "", basedon2 = "", basecode2 = "";
        private string servicetype = "", ftltype = "", transmode = "";
        private double freightcharge = 0, freightrate = 0;
        private int trdays = 0;
        private string ratetype = "", flagprorata = "N";
        private double chargedweight = 0, noofpkgs = 0, fovcharge = 0;
        private string minfreighttype = "", minfreightbas = "";
        private double minfreightbasrate = 0;
        private double minfreightrate = 0, freightratelowerlimit = 0, freightrateupperlimit = 0;
        private double minsubtotal = 0, subtotallowerlimit = 0, subtotalupperlimit = 0;
        private string flag_freight = "", flag_subtotal = "";
        private string discountType = "";
        private double discountAmount = 0, discountRate = 0;


        public DateTime DockDt
        {
            get { return dockdate; }
            set { dockdate = value; }
        }
        public string Status
        {
            get { return status; }
            set { status = value; }
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        public string ContractID
        {
            get { return contractid; }
            set { contractid = value; }
        }
        public string FoundContract
        {
            get { return foundcontract; }
            set { foundcontract = value; }
        }
        public string FlagProceed
        {
            get { return flagproceed; }
            set { flagproceed = value; }
        }
        public string Depth
        {
            get { return depth; }
            set { depth = value; }
        }
        public string PayBase
        {
            get { return paybas; }
            set { paybas = value; }
        }

        public string BasedOn1
        {
            get { return basedon1; }
            set { basedon1 = value; }
        }

        public string BaseCode1
        {
            get { return basecode1; }
            set { basecode1 = value; }
        }

        public string BasedOn2
        {
            get { return basedon2; }
            set { basedon2 = value; }
        }

        public string BaseCode2
        {
            get { return basecode2; }
            set { basecode2 = value; }
        }

        public string FromCity
        {
            get { return fromcity; }
            set { fromcity = value; }
        }
        public string ToCity
        {
            get { return tocity; }
            set { tocity = value; }
        }
        public string OrgnLoc
        {
            get { return orgnloc; }
            set { orgnloc = value; }
        }
        public string DelLoc
        {
            get { return delloc; }
            set { delloc = value; }
        }
        public string ServiceType
        {
            get { return servicetype; }
            set { servicetype = value; }
        }
        public string FTLType
        {
            get { return ftltype; }
            set { ftltype = value; }
        }
        public string TransMode
        {
            get { return transmode; }
            set { transmode = value; }
        }

        public double FreightCharge
        {
            get { return freightcharge; }
            set { freightcharge = value; }
        }
        public double FreightRate
        {
            get { return freightrate; }
            set { freightrate = value; }
        }
        public int TRDays
        {
            get { return trdays; }
            set { trdays = value; }
        }

        public string RateType
        {
            get { return ratetype; }
            set { ratetype = value; }
        }
        public string FlagProrata
        {
            get { return flagprorata; }
            set { flagprorata = value; }
        }

        public double ChargedWeight
        {
            get { return chargedweight; }
            set { chargedweight = value; }
        }
        public double NoOfPkgs
        {
            get { return noofpkgs; }
            set { noofpkgs = value; }
        }
        public double FOVCharge
        {
            get { return fovcharge; }
            set { fovcharge = value; }
        }

        public string MinFreightType
        {
            get { return minfreighttype; }
            set { minfreighttype = value; }
        }
        public string MinFreightBase
        {
            get { return minfreightbas; }
            set { minfreightbas = value; }
        }
        public double MinFreightBaseRate
        {
            get { return minfreightbasrate; }
            set { minfreightbasrate = value; }
        }

        public double MinFreightRate
        {
            get { return minfreightrate; }
            set { minfreightrate = value; }
        }
        public double FreightRateLowerLimit
        {
            get { return freightratelowerlimit; }
            set { freightratelowerlimit = value; }
        }
        public double FreightRateUpperLimit
        {
            get { return freightrateupperlimit; }
            set { freightrateupperlimit = value; }
        }

        public double MinSubTotal
        {
            get { return minsubtotal; }
            set { minsubtotal = value; }
        }
        public double SubTotalLowerLimit
        {
            get { return subtotallowerlimit; }
            set { subtotallowerlimit = value; }
        }
        public double SubTotalUpperLimit
        {
            get { return subtotalupperlimit; }
            set { subtotalupperlimit = value; }
        }

        public string FlagFreight
        {
            get { return flag_freight; }
            set { flag_freight = value; }
        }
        public string FlagSutotal
        {
            get { return flag_subtotal; }
            set { flag_subtotal = value; }
        }

        public string DiscountType
        {
            get { return discountType; }
            set { discountType = value; }
        }
        public double DiscountAmount
        {
            get { return discountAmount; }
            set { discountAmount = value; }
        }

        public double DiscountRate
        {
            get { return discountRate; }
            set { discountRate = value; }
        }
    }
	/* Add GST wise Change */
    public class DocketGSTDetails
    {

        public DocketGSTDetails() {
            Module = "";
        }

        public string GSTPaymentPartyCode { get; set; }        
        public string GSTProductID { get; set; }
        public string GSTPayBaseId { get; set; }
        public string FromCityId { get; set; }
        public string DestinatonCity { get; set; }
        public string BookingBranch { get; set; }
        public string DestinatonionBranch { get; set; }
        public string BilledAtBranch { get; set; }
        public string PartyAs { get; set; }
        public string ChangedStateId { get; set; }
        public string Module { get; set; }
    }

    public class CustomerGSTDetail
    {
        public string CUSTCD { get; set; }
        public string GRPCD { get; set; }
        public string CUSTNM { get; set; }
        public string CUSTPASS { get; set; }
        public string CUSTCAT { get; set; }        
        public string ServiceOptFor { get; set; }
        public string GSTBillingState { get; set; }
        public string GSTBillingCity { get; set; }
        public string CGSTnumber { get; set; }
        public string IGSTnumber { get; set; }
        public string GSTBillingAddress { get; set; }
        public string BillingStateCode { get; set; }
        public string BillingAddress { get; set; }
        public string BillingCityCode { get; set; }
        public string ProvisionalNumber { get; set; }
        public string GSTINNumber { get; set; }
        public string DeclarationFile { get; set; }
        /*Added location details. */
        public string FromCityId { get; set; }
        public string BookingBranch { get; set; }
        public string DestinatonCity { get; set; }
        public string DestinatonionBranch { get; set; }
        public string BilledAtBranch { get; set; }
        public string PartyAs { get; set; }
        public string GstPincode { get; set; }
    }
    /* Add GST wise Change */
}



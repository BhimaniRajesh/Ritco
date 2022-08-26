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
    /// Summary description for VendorContractSummary
    /// </summary>
    [Serializable]
    public class VendorContractSummary
    {
        #region Private Members

        private string _VendorCode = "";
        private string _VendorName = "";
        private string _Vendor_Type = "";
        private string _CONTRACTCD = "";
        private DateTime _ContractDt = DateTime.MinValue;
        private string _Contract_loccode = "";
        private DateTime _Valid_uptodt = DateTime.MinValue;
        private DateTime _Start_Dt = DateTime.MinValue;
        private string _VendorPerName = "";
        private string _VendorPerDesg = "";
        private string _VendorWitness = "";
        private string _CompEmpName = "";
        private string _CompEmpDesg = "";
        private string _CompWitness = "";
        private string _Vendor_Address = "";
        private string _VendorCity = "";
        private string _VendorPin = "";
        private string _VendorCategory = "";
        private string _VendorContractCat = "";
        private string _TDSAppl_YN = "";
        private Double _TDS_Rate = -1;
        private string _Security_deposit_chq = "";
        private DateTime _Security_deposit_date = DateTime.MinValue;
        private Double _Security_deposit_Amt = -1;
        private string _Payment_interval = "";
        private string _Payment_Basis = "";
        private string _Payment_loc = "";
        private Double _Monthly_Phone_Charges = -1;
        private string _EntryBy = "";
        private DateTime _EntryDt = DateTime.MinValue;
        private string _UpdateBy = "";
        private DateTime _UpdateDt = DateTime.MinValue;
        private string _MetrixType = "";
        private string _Status = "";
        private Double _Default_Charge = -1;


        #endregion

        public VendorContractSummary()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        #region Public Properties

        public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
        public string VendorName { get { return _VendorName; } set { _VendorName = value; } }
        public string Vendor_Type { get { return _Vendor_Type; } set { _Vendor_Type = value; } }
        public string CONTRACTCD { get { return _CONTRACTCD; } set { _CONTRACTCD = value; } }
        public DateTime ContractDt { get { return _ContractDt; } set { _ContractDt = value; } }
        public string Contract_loccode { get { return _Contract_loccode; } set { _Contract_loccode = value; } }
        public DateTime Valid_uptodt { get { return _Valid_uptodt; } set { _Valid_uptodt = value; } }
        public DateTime Start_Dt { get { return _Start_Dt; } set { _Start_Dt = value; } }
        public string VendorPerName { get { return _VendorPerName; } set { _VendorPerName = value; } }
        public string VendorPerDesg { get { return _VendorPerDesg; } set { _VendorPerDesg = value; } }
        public string VendorWitness { get { return _VendorWitness; } set { _VendorWitness = value; } }
        public string CompEmpName { get { return _CompEmpName; } set { _CompEmpName = value; } }
        public string CompEmpDesg { get { return _CompEmpDesg; } set { _CompEmpDesg = value; } }
        public string CompWitness { get { return _CompWitness; } set { _CompWitness = value; } }
        public string Vendor_Address { get { return _Vendor_Address; } set { _Vendor_Address = value; } }
        public string VendorCity { get { return _VendorCity; } set { _VendorCity = value; } }
        public string VendorPin { get { return _VendorPin; } set { _VendorPin = value; } }
        public string VendorCategory { get { return _VendorCategory; } set { _VendorCategory = value; } }
        public string VendorContractCat { get { return _VendorContractCat; } set { _VendorContractCat = value; } }
        public string TDSAppl_YN { get { return _TDSAppl_YN; } set { _TDSAppl_YN = value; } }
        public Double TDS_Rate { get { return _TDS_Rate; } set { _TDS_Rate = value; } }
        public string Security_deposit_chq { get { return _Security_deposit_chq; } set { _Security_deposit_chq = value; } }
        public DateTime Security_deposit_date { get { return _Security_deposit_date; } set { _Security_deposit_date = value; } }
        public Double Security_deposit_Amt { get { return _Security_deposit_Amt; } set { _Security_deposit_Amt = value; } }
        public string Payment_interval { get { return _Payment_interval; } set { _Payment_interval = value; } }
        public string Payment_Basis { get { return _Payment_Basis; } set { _Payment_Basis = value; } }
        public string Payment_loc { get { return _Payment_loc; } set { _Payment_loc = value; } }
        public Double Monthly_Phone_Charges { get { return _Monthly_Phone_Charges; } set { _Monthly_Phone_Charges = value; } }
        public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
        public DateTime EntryDt { get { return _EntryDt; } set { _EntryDt = value; } }
        public string UpdateBy { get { return _UpdateBy; } set { _UpdateBy = value; } }
        public DateTime UpdateDt { get { return _UpdateDt; } set { _UpdateDt = value; } }
        public string MetrixType { get { return _MetrixType; } set { _MetrixType = value; } }
        public string Status { get { return _Status; } set { _Status = value; } }
        public Double Default_Charge { get { return _Default_Charge; } set { _Default_Charge = value; } }
        
        #endregion
    }
    public enum VendorContractSummary_Columns
    {
        VendorCode = 0,
        VendorName,
        Vendor_Type,
        CONTRACTCD,
        ContractDt,
        Contract_loccode,
        Valid_uptodt,
        Start_Dt,
        VendorPerName,
        VendorPerDesg,
        VendorWitness,
        CompEmpName,
        CompEmpDesg,
        CompWitness,
        Vendor_Address,
        VendorCity,
        VendorPin,
        VendorCategory,
        VendorContractCat,
        TDSAppl_YN,
        TDS_Rate,
        Security_deposit_chq,
        Security_deposit_date,
        Security_deposit_Amt,
        Payment_interval,
        Payment_Basis,
        Payment_loc,
        Monthly_Phone_Charges,
        EntryBy,
        EntryDt,
        UpdateBy,
        UpdateDt,
        MetrixType,
        Status,
        Default_Charge
    }
}
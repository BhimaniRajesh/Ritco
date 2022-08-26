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
    /// Summary description for ObjVendorMaster
    /// </summary>
    public class VendorMaster
    {
        #region Variable[s]

        #region Table - webx_VENDOR_HDR
        private string m_Vendor_Type;
        private string m_Vendor_Code;
        private string m_VENDORTYPE;
        private string m_Vendor_Name;
        private DateTime m_Contract_St_Date;
        private DateTime m_Contract_Ed_Date;
        private string m_Vendor_Remarks;
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private string m_Vendor_Category;
        private string m_Pan_No;
        private string m_Service_Tax_No;
        private string m_Vendor_Bst_No;
        private string m_Vendor_Cst_No;
        private string m_Vendor_Address;
        private string m_IsActiveFlag;
        private string m_Contract_Market;
        private string m_Contract_YN;
        private DateTime m_Contract_Date;
        private decimal m_OpenDebit;
        private decimal m_OpenCredit;
        #endregion

        #region Table - webx_VENDOR_DET
        private string m_Vendor_Branch_Code;
        private string m_Vendor_Contract;
        private string m_Vendor_City;
        private string m_Vendor_Pin_Code;
        private string m_Vendor_Phone_No;
        private string m_Vendor_Mobile_No;
        private string m_Vender_Email;
        private string m_IsBlackListed;
        private decimal m_CostPerMonth;
        #endregion

        #endregion

        #region Constructor
        public VendorMaster()
        {
                //
                // TODO: Add constructor logic here
                //
               #region Table - webx_VENDOR_HDR
                 m_Vendor_Type = string.Empty;
                 m_Vendor_Code = string.Empty;
                 m_VENDORTYPE = string.Empty;
                 m_Vendor_Name = string.Empty;
                 m_Contract_St_Date = DateTime.MinValue.AddYears(1754);
                 m_Contract_Ed_Date = DateTime.MinValue.AddYears(1754);
                 m_Vendor_Remarks = string.Empty;
                 m_UpdateBy = string.Empty;
                 m_UpdateOnDate = DateTime.MinValue.AddYears(1754);
                 m_Vendor_Category = string.Empty;
                 m_Pan_No = string.Empty;
                 m_Service_Tax_No = string.Empty;
                 m_Vendor_Bst_No = string.Empty;
                 m_Vendor_Cst_No = string.Empty;
                 m_Vendor_Address = string.Empty;
                 m_IsActiveFlag = string.Empty;
                 m_Contract_Market = string.Empty;
                 m_Contract_YN = string.Empty;
                 m_Contract_Date = DateTime.MinValue.AddYears(1754);
                 m_OpenDebit = 0.0M;
                 m_OpenCredit = 0.0M;
               #endregion

               #region Table - webx_VENDOR_DET
                 m_Vendor_Branch_Code = string.Empty;
                 m_Vendor_Contract = string.Empty;
                 m_Vendor_City = string.Empty;
                 m_Vendor_Pin_Code = string.Empty;
                 m_Vendor_Phone_No = string.Empty;
                 m_Vendor_Mobile_No = string.Empty;
                 m_Vender_Email = string.Empty;
                 m_IsBlackListed = string.Empty;
                 m_CostPerMonth = 0.0M;
               #endregion
        }
        #endregion

        #region Property

        // Vendor_Type
        public string Vendor_Type
        {
            get
            {
                return m_Vendor_Type;
            }
            set
            {
                m_Vendor_Type = value;
            }
        }

        // Vendor_Code
        public string Vendor_Code
        {
            get
            {
                return m_Vendor_Code;
            }
            set
            {
                m_Vendor_Code = value;
            }
        }

        // VENDOR TYPE
        public string VENDORTYPE
        {
            get
            {
                return m_VENDORTYPE;
            }
            set
            {
                m_VENDORTYPE = value;
            }
        }

        // Vendor_Name 
        public string Vendor_Name
        {
            get
            {
                return m_Vendor_Name;
            }
            set
            {
                m_Vendor_Name = value;
            }
        }

        // Contract Start Date
        public DateTime Contract_St_Date
        {
            get
            {
                return m_Contract_St_Date;
            }
            set
            {
                m_Contract_St_Date = value;
            }
        }

        // Contract End Date
        public DateTime Contract_Ed_Date
        {
            get
            {
                return m_Contract_Ed_Date;
            }
            set
            {
                m_Contract_Ed_Date = value;
            }
        }

        // Vendor_Remarks
        public string Vendor_Remarks
        {
            get
            {
                return m_Vendor_Remarks;
            }
            set
            {
                m_Vendor_Remarks = value;
            }
        }
        
        // Record is updateby Userid : Username
        public string UpdateBy
        {
            get
            {
                return m_UpdateBy;
            }
            set
            {
                m_UpdateBy = value;
            }
        }

        // Record is update on date
        public DateTime UpdateOnDate
        {
            get
            {
                return m_UpdateOnDate;
            }
            set
            {
                m_UpdateOnDate = value;
            }
        }

        // Vendor Category
        public string Vendor_Category
        {
            get
            {
                return m_Vendor_Category;
            }
            set
            {
                m_Vendor_Category = value;
            }
        }

        // Pan Card No
        public string Pan_No
        {
            get
            {
                return m_Pan_No;
            }
            set
            {
                m_Pan_No = value;
            }
        }

        // Service Tax Number
        public string Service_Tax_No
        {
            get
            {
                return m_Service_Tax_No;
            }
            set
            {
                m_Service_Tax_No = value;
            }
        }

        // Vendor_Bst_No
        public string Vendor_Bst_No
        {
            get
            {
                return m_Vendor_Bst_No;
            }
            set
            {
                m_Vendor_Bst_No = value;
            }
        }

        // Vendor_Cst_No
        public string Vendor_Cst_No
        {
            get
            {
                return m_Vendor_Cst_No;
            }
            set
            {
                m_Vendor_Cst_No = value;
            }
        }

        // Vendor Address
        public string Vendor_Address
        {
            get
            {
                return m_Vendor_Address;
            }
            set
            {
                m_Vendor_Address = value;
            }
        }
      
        // Active or not
        public string IsActiveFlag
        {
            get
            {
                return m_IsActiveFlag;
            }
            set
            {
                m_IsActiveFlag = value;
            }
        }

        // Contract Market
        public string Contract_Market
        {
            get
            {
                return m_Contract_Market;
            }
            set
            {
                m_Contract_Market = value;
            }
        }

        // Contract_YN
        public string Contract_YN
        {
            get
            {
                return m_Contract_YN;
            }
            set
            {
                m_Contract_YN = value;
            }
        }

        // Contract Date
        public DateTime Contract_Date
        {
            get
            {
                return m_Contract_Date;
            }
            set
            {
                m_Contract_Date = value;
            }
        }

        //Open Debit
        public decimal OpenDebit
        {
            get
            {
                return m_OpenDebit;
            }
            set
            {
                m_OpenDebit = value;
            }
        }

        // Open Credit
        public decimal OpenCredit
        {
            get
            {
                return m_OpenCredit;
            }
            set
            {
                m_OpenCredit = value;
            }
        }

        // Vendor Branch Code
        public string Vendor_Branch_Code
        {
            get
            {
                return m_Vendor_Branch_Code;
            }
            set
            {
                m_Vendor_Branch_Code = value;
            }
        }

        // Vendor Contract
        public string Vendor_Contract
        {
            get
            {
                return m_Vendor_Contract;
            }
            set
            {
                m_Vendor_Contract = value;
            }
        }

        // Vendor City
        public string Vendor_City
        {
            get
            {
                return m_Vendor_City;
            }
            set
            {
                m_Vendor_City = value;
            }
        }

        // Vendor Pin Code Number
        public string Vendor_Pin_Code
        {
            get
            {
                return m_Vendor_Pin_Code;
            }
            set
            {
                m_Vendor_Pin_Code = value;
            }
        }



        // Vendor Phone Number
        public string Vendor_Phone_No
        {
            get
            {
                return m_Vendor_Phone_No;
            }
            set
            {
                m_Vendor_Phone_No = value;
            }
        }

        // Vendor Mobile Number
        public string Vendor_Mobile_No
        {
            get
            {
                return m_Vendor_Mobile_No;
            }
            set
            {
                m_Vendor_Mobile_No = value;
            }
        }

        // Vender Email
        public string Vender_Email
        {
            get
            {
                return m_Vender_Email;
            }
            set
            {
                m_Vender_Email = value;
            }
        }

        // Is BlackListed Vendor
        public string IsBlackListed
        {
            get
            {
                return m_IsBlackListed;
            }
            set
            {
                m_IsBlackListed = value;
            }
        }

        // Cost Per Month
        public decimal CostPerMonth
        {
            get
            {
                return m_CostPerMonth;
            }
            set
            {
                m_CostPerMonth = value;
            }
        }

        #endregion
    }
}

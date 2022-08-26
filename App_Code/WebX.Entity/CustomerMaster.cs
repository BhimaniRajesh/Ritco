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
    /// Summary description for ObjCustomerMaster
    /// </summary>
    public class CustomerMaster
    {
        #region Variable[s]
        private string m_CustomerCode;
        private string m_CompanyCustomerCode;
        private string m_GroupCode;
        private string m_CustomerName;
        private string m_CustomerPassword;
        private string m_CustomerCategory;
        private decimal m_TBBCRDAYS;
        private decimal m_TOPAYCRDAYS;
        private decimal m_OCTCRDAYS;
        private string m_TBBELEGIBILITY;
        private string m_TOPAYELEGIBILITY;
        private string m_OCTROIELIGIBILITY;
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private decimal m_DKTCHG;
        private decimal m_FOVOWNER;
        private decimal m_FOVCARRIER;
        private string m_RATETYPE;
        private string m_RATEMATRIX;
        private string m_SERVICETAX;
        private string m_BDEREF;
        private string m_CSTNO;
        private string m_EmailID;
        private string m_ActiveFlag;
        private string m_MobileServiceEnable;
        private string m_MobileNo;
        private string m_STNUM;
        private string m_OldGroupCode;
        private string m_OldCustomerCode;
        private decimal m_OpenDebit;
        private decimal m_OpenCredit;
        private string m_ContractMade;
        private string m_CustomerLocation;
        private string m_InvoicewiseBill_YN;
        private string m_Address;
        private string m_City;        
        private string m_TelephoneNo;
        private string m_PinCode;
        private string m_PanCardNo;
        private string m_ServiceOptedFor; 
        #endregion        

        #region Constructor
        public CustomerMaster()
        {
            //
            // TODO: Add constructor logic here
            //
            m_CustomerCode = string.Empty;
            m_CompanyCustomerCode = string.Empty;  
            m_GroupCode = string.Empty;
            m_CustomerName = string.Empty;
            m_CustomerPassword = string.Empty;
            m_CustomerCategory = string.Empty;
            m_TBBCRDAYS = 0.0M;
            m_TOPAYCRDAYS = 0.0M;
            m_OCTCRDAYS = 0.0M;
            m_TBBELEGIBILITY = string.Empty;
            m_TOPAYELEGIBILITY = string.Empty;
            m_OCTROIELIGIBILITY = string.Empty;
            m_UpdateBy = string.Empty;
            m_UpdateOnDate = System.DateTime.MinValue;
            m_DKTCHG = 0.0M;
            m_FOVOWNER = 0.0M;
            m_FOVCARRIER = 0.0M;
            m_RATETYPE = string.Empty;
            m_RATEMATRIX = string.Empty;
            m_SERVICETAX = string.Empty;
            m_BDEREF = string.Empty;
            m_CSTNO = string.Empty;
            m_EmailID = string.Empty;
            m_ActiveFlag = string.Empty;
            m_MobileServiceEnable = string.Empty;
            m_MobileNo = string.Empty;
            m_STNUM = string.Empty;
            m_OldGroupCode = string.Empty;
            m_OldCustomerCode = string.Empty;
            m_OpenDebit = 0.0M;
            m_OpenCredit = 0.0M;
            m_ContractMade = string.Empty;
            m_CustomerLocation = string.Empty;
            m_InvoicewiseBill_YN = string.Empty;
            m_Address = string.Empty;
            m_City = string.Empty;
            m_TelephoneNo = string.Empty;
            m_PinCode = string.Empty;
            m_PanCardNo = string.Empty;
            m_ServiceOptedFor = string.Empty;  
        }
        #endregion

        #region Property

        // Customer Code
        public string CustomerCode 
        {
            get
            {
                return m_CustomerCode;
            }
            set
            {
                m_CustomerCode = value;
            }
        }

        // Company Customer Code
        public string CompanyCustomerCode
        {
            get
            {
                return m_CompanyCustomerCode;
            }
            set
            {
                m_CompanyCustomerCode = value;
            }
        }

        // Group Code
        public string GroupCode 
        {
            get
            {
                return m_GroupCode;
            }
            set
            {
                m_GroupCode = value;
            }
        }

        // Customer Name
        public string CustomerName
        {
            get
            {
                return m_CustomerName;
            }
            set
            {
                m_CustomerName = value;
            }
        }

        // Customer Password 
        public string CustomerPassword
        {
            get
            {
                return m_CustomerPassword;
            }
            set
            {
                m_CustomerPassword = value;
            }
        }

        // Customer Category
        public string CustomerCategory
        {
            get
            {
                return m_CustomerCategory;
            }
            set
            {
                m_CustomerCategory = value;
            }
        }

        // Tbb Credit Days 
        public decimal TBBCRDAYS
        {
            get
            {
                return m_TBBCRDAYS;
            }
            set
            {
                m_TBBCRDAYS = value;
            }
        }

        // 
        public decimal TOPAYCRDAYS
        {
            get
            {
                return m_TOPAYCRDAYS;
            }
            set
            {
                m_TOPAYCRDAYS = value;
            }
        }

        // Octroy Credit Days
        public decimal OCTCRDAYS
        {
            get
            {
                return m_OCTCRDAYS;
            }
            set
            {
                m_OCTCRDAYS = value;
            }
        }

        // 
        public string TBBELEGIBILITY
        {
            get
            {
                return m_TBBELEGIBILITY;
            }
            set
            {
                m_TBBELEGIBILITY = value;
            }
        }

        // 
        public string TOPAYELEGIBILITY
        {
            get
            {
                return m_TOPAYELEGIBILITY;
            }
            set
            {
                m_TOPAYELEGIBILITY = value;
            }
        }

        //
        public string OCTROIELIGIBILITY 
        {
            get
            {
                return m_OCTROIELIGIBILITY;
            }
            set
            {
                m_OCTROIELIGIBILITY = value;
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

        // 
        public decimal DKTCHG
        {
            get
            {
                return m_DKTCHG;
            }
            set
            {
                m_DKTCHG = value;
            }
        }

        // 
        public decimal FOVOWNER
        {
            get
            {
                return m_FOVOWNER;
            }
            set
            {
                m_FOVOWNER = value;
            }
        }

        // 
        public decimal FOVCARRIER
        {
            get
            {
                return m_FOVCARRIER;
            }
            set
            {
                m_FOVCARRIER = value;
            }
        }

        // 
        public string RATETYPE
        {
            get
            {
                return m_RATETYPE;
            }
            set
            {
                m_RATETYPE = value;
            }
        }

        // 
        public string RATEMATRIX
        {
            get
            {
                return m_RATEMATRIX;
            }
            set
            {
                m_RATEMATRIX = value;
            }
        }

        //
        public string SERVICETAX
        {
            get
            {
                return m_SERVICETAX;
            }
            set
            {
                m_SERVICETAX = value;
            }
        }

        // 
        public string BDEREF 
        {
            get
            {
                return m_BDEREF;
            }
            set
            {
                m_BDEREF = value;
            }
        }

        // 
        public string CSTNO
        {
            get
            {
                return m_CSTNO;
            }
            set
            {
                m_CSTNO = value;
            }
        }

        // Email ID
        public string EmailID 
        {
            get
            {
                return m_EmailID;
            }
            set
            {
                m_EmailID = value;
            }
        }

        // Customer active or not 
        public string ActiveFlag 
        {
            get
            {
                return m_ActiveFlag;
            }
            set
            {
                m_ActiveFlag = value;
            }
        }

        // Mobile Service Enable or not
        public string MobileServiceEnable 
        {
            get
            {
                return m_MobileServiceEnable;
            }
            set
            {
                m_MobileServiceEnable = value;
            }
        }

        // Mobile Number 
        public string MobileNo 
        {
            get
            {
                return m_MobileNo;
            }
            set
            {
                m_MobileNo = value;
            }
        }

        // 
        public string STNUM 
        {
            get
            {
                return m_STNUM;
            }
            set
            {
                m_STNUM = value;
            }
        }

        // Old Group Code 
        public string OldGroupCode 
        {
            get
            {
                return m_OldGroupCode;
            }
            set
            {
                m_OldGroupCode = value;
            }
        }

        // Old Customer Code
        public string OldCustomerCode 
        {
            get
            {
                return m_OldCustomerCode;
            }
            set
            {
                m_OldCustomerCode = value;
            }
        }

        // Open Debit
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


        // Contract Made
        public string ContractMade 
        {
            get
            {
                return m_ContractMade;
            }
            set
            {
                m_ContractMade = value;
            }
        }

        // Location of Cuctomer
        public string CustomerLocation 
        {
            get
            {
                return m_CustomerLocation;
            }
            set
            {
                m_CustomerLocation = value;
            }
        }

        // 
        public string InvoicewiseBill_YN 
        {
            get
            {
                return m_InvoicewiseBill_YN;
            }
            set
            {
                m_InvoicewiseBill_YN = value;
            }
        }

        // Customer Address 
        public string Address 
        {
            get
            {
                return m_Address;
            }
            set
            {
                m_Address = value;
            }
        }

        // Customer City
        public string City 
        {
            get
            {
                return m_City;
            }
            set
            {
                m_City = value;
            }
        }

        // Telephone Number
        public string TelephoneNo 
        {
            get
            {
                return m_TelephoneNo;
            }
            set
            {
                m_TelephoneNo = value;
            }
        }

        // Pin Code 
        public string PinCode 
        {
            get
            {
                return m_PinCode;
            }
            set
            {
                m_PinCode = value;
            }
        }

        // Pan Card Number
        public string PanCardNo 
        {
            get
            {
                return m_PanCardNo;
            }
            set
            {
                m_PanCardNo = value;
            }
        }

        // Service Opted For
        public string ServiceOptedFor
        {
            get
            {
                return m_ServiceOptedFor;
            }
            set
            {
                m_ServiceOptedFor = value;
            }
        }
        #endregion
    }
}

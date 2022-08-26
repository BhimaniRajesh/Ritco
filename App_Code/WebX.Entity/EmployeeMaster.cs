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
    /// Summary description for ObjEmployeeMaster
    /// </summary>
    public class EmployeeMaster
    {
        #region Variable[s]
        private string m_UserID;
        private string m_User_Type;
        private string m_UserPassword;
        private string m_BranchCode;
        private string m_UserName;
        private string m_PasswordQ;
        private string m_PasswordA;
        private string m_EmployeeId;
        private string m_ManagerId;
        private string m_EmailId;
        private string m_PhoneNo;
        private DateTime m_ActiveTillDate;
        private DateTime m_PwdLastChangeOn;
        private string m_LastPwd;
        private string m_Status;
        private DateTime m_EntryDate;
        private string m_EntryBy;
        private DateTime m_LastUpdatedDate;
        private string m_LastUpdatedBy;
        private string m_MobileNo;
        private string m_Gender;
        private string m_Address;
        private DateTime m_DOB;
        private DateTime m_DOJ_ORG;
        private string m_IsPassEncrypted;
        #endregion

        #region Constructor
        public EmployeeMaster()
        {
            //
            // TODO: Add constructor logic here
            //
            m_UserID = string.Empty;
            m_User_Type = string.Empty;;
            m_UserPassword = string.Empty;
            m_BranchCode = string.Empty;
            m_UserName = string.Empty;
            m_PasswordQ = string.Empty;
            m_PasswordA = string.Empty;
            m_EmployeeId = string.Empty;
            m_ManagerId = string.Empty;
            m_EmailId = string.Empty;
            m_PhoneNo = string.Empty;
            m_ActiveTillDate = System.DateTime.MinValue;
            m_PwdLastChangeOn = System.DateTime.MinValue;
            m_LastPwd = string.Empty;
            m_Status = string.Empty;
            m_EntryDate = System.DateTime.MinValue;
            m_EntryBy = string.Empty;
            m_LastUpdatedDate = System.DateTime.MinValue;
            m_LastUpdatedBy = string.Empty;
            m_MobileNo = string.Empty;
            m_Gender = string.Empty;
            m_Address = string.Empty;
            m_DOB = System.DateTime.MinValue;
            m_DOJ_ORG = System.DateTime.MinValue;
            m_IsPassEncrypted = string.Empty;
        }
        #endregion

        #region Property
        public string UserID
        {
            get
            {
                return m_UserID;
            }
            set
            {
                m_UserID = value;
            }
        }
        public string User_Type
        {
            get
            {
                return m_User_Type;
            }
            set
            {
                m_User_Type = value;
            }
        }
        public string UserPassword
        {
            get
            {
                return m_UserPassword;
            }
            set
            {
                m_UserPassword = value;
            }
        }
        public string BranchCode
        {
            get
            {
                return m_BranchCode;
            }
            set
            {
                m_BranchCode = value;
            }
        }
        public string UserName
        {
            get
            {
                return m_UserName;
            }
            set
            {
                m_UserName = value;
            }
        }
        public string PasswordQ
        {
            get
            {
                return m_PasswordQ;
            }
            set
            {
                m_PasswordQ = value;
            }
        }
        public string PasswordA
        {
            get
            {
                return m_PasswordA;
            }
            set
            {
                m_PasswordA = value;
            }
        }
        public string EmployeeId
        {
            get
            {
                return m_EmployeeId;
            }
            set
            {
                m_EmployeeId = value;
            }
        }
        public string ManagerId
        {
            get
            {
                return m_ManagerId;
            }
            set
            {
                m_ManagerId = value;
            }
        }
        public string EmailId
        {
            get
            {
                return m_EmailId;
            }
            set
            {
                m_EmailId = value;
            }
        }
        public string PhoneNo
        {
            get
            {
                return m_PhoneNo;
            }
            set
            {
                m_PhoneNo = value;
            }
        }
        public DateTime ActiveTillDate
        {
            get
            {
                return m_ActiveTillDate;
            }
            set
            {
                m_ActiveTillDate = value;
            }
        }
        public DateTime PwdLastChangeOn
        {
            get
            {
                return m_PwdLastChangeOn;
            }
            set
            {
                m_PwdLastChangeOn = value;
            }
        }
        public string LastPwd
        {
            get
            {
                return m_LastPwd;
            }
            set
            {
                m_LastPwd = value;
            }
        }
        public string Status
        {
            get
            {
                return m_Status;
            }
            set
            {
                m_Status = value;
            }
        }
        public DateTime EntryDate
        {
            get
            {
                return m_EntryDate;
            }
            set
            {
                m_EntryDate = value;
            }
        }
        public string EntryBy
        {
            get
            {
                return m_EntryBy;
            }
            set
            {
                m_EntryBy = value;
            }
        }
        public DateTime LastUpdatedDate
        {
            get
            {
                return m_LastUpdatedDate;
            }
            set
            {
                m_LastUpdatedDate = value;
            }
        }
        public string LastUpdatedBy
        {
            get
            {
                return m_LastUpdatedBy;
            }
            set
            {
                m_LastUpdatedBy = value;
            }
        }
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
        public string Gender
        {
            get
            {
                return m_Gender;
            }
            set
            {
                m_Gender = value;
            }
        }
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
        public DateTime DOB
        {
            get
            {
                return m_DOB;
            }
            set
            {
                m_DOB = value;
            }
        }
        public DateTime DOJ_ORG
        {
            get
            {
                return m_DOJ_ORG;
            }
            set
            {
                m_DOJ_ORG = value;
            }
        }
        public string IsPassEncrypted
        {
            get
            {
                return m_IsPassEncrypted;
            }
            set
            {
                m_IsPassEncrypted = value;
            }
        } 
        #endregion
    }
}

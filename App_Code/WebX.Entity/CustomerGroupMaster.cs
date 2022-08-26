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
    /// Summary description for ObjCustomerGroupMaster
    /// </summary>
    public class CustomerGroupMaster
    {
        #region Variable[s]
        private string m_GroupCode;
        private string m_GroupName;
        private string m_Password;
        private string m_LocationRegion;
        private string m_ActiveFlag;
        private string m_Old_GroupCode;
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;     
        #endregion        

        #region Constructor
        public CustomerGroupMaster()
        {
            //
            // TODO: Add constructor logic here
            //
            m_GroupCode = string.Empty;
            m_GroupName = string.Empty;
            m_Password = string.Empty;
            m_LocationRegion = string.Empty;
            m_ActiveFlag = string.Empty;
            m_Old_GroupCode = string.Empty;
            m_UpdateBy = string.Empty;
            m_UpdateOnDate = DateTime.MinValue.AddYears(1754);         
        }
        #endregion

        #region Property

        // Cusromer Group Code
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

        // Cusromer Group Name
        public string GroupName
        {
            get
            {
                return m_GroupName;
            }
            set
            {
                m_GroupName = value;
            }
        }

        // Password
        public string Password
        {
            get
            {
                return m_Password;
            }
            set
            {
                m_Password = value;
            }
        }

        // Location Region 
        public string LocationRegion
        {
            get
            {
                return m_LocationRegion;
            }
            set
            {
                m_LocationRegion = value;
            }
        }

        // Customer Active Flag
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

        // OLD Cusromer Group Code
        public string Old_GroupCode
        {
            get
            {
                return m_Old_GroupCode;
            }
            set
            {
                m_Old_GroupCode = value;
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
        #endregion
    }
}

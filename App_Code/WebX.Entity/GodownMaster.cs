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
    /// Summary description for ObjGodownMaster
    /// </summary>
    public class GodownMaster
    {
        #region Variable[s]
        private double m_SrNo;
        private string m_BranchCode;
        private string m_Name;
        private string m_Description;       
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private string m_ActiveFlag;

        private string m_Area;
        private string m_Address;
        private string m_ValidityDate;
        #endregion

        #region Constructor
        public GodownMaster()
        {
            //
            // TODO: Add constructor logic here
            //  
            m_SrNo = 0;
            m_BranchCode = string.Empty;
            m_Name = string.Empty;
            m_Description = string.Empty;         
            m_UpdateBy = string.Empty;
            m_UpdateOnDate = DateTime.MinValue.AddYears(1754);
            m_ActiveFlag = string.Empty;
            m_Area = string.Empty;
            m_Address = string.Empty;
            m_ValidityDate = string.Empty;
        }
        #endregion

        #region Property

        // Serial Number
        public double SrNo
        {
            get
            {
                return m_SrNo;
            }
            set
            {
                m_SrNo = value;
            }
        }

        // Branch Code 
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

        // Godown Name 
        public string Name
        {
            get
            {
                return m_Name;
            }
            set
            {
                m_Name = value;
            }
        }

        // Godown Description
        public string Description
        {
            get
            {
                return m_Description;
            }
            set
            {
                m_Description = value;
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

        // Godown is active or not 
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

        // Godown is active or not 
        public string Area
        {
            get
            {
                return m_Area;
            }
            set
            {
                m_Area = value;
            }
        }
        // Godown is active or not 
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
        // Godown is active or not 
        public string ValidityDate
        {
            get
            {
                return m_ValidityDate;
            }
            set
            {
                m_ValidityDate = value;
            }
        }

        #endregion
    }
}

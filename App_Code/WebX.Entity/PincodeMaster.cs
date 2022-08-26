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
    /// Summary description for PincodeMaster
    /// </summary>
    public class PincodeMaster
    {
        #region Variable[s]
        private int m_Pincode;
        private string m_CityName;
        private string m_StateCode;
        private int m_PincodeOld;
        private string m_CityNameOld;
        private string m_StateCodeOld;  
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private string m_ActiveFlag; 
        private string m_Area;
        #endregion
        
        #region Constructor
        public PincodeMaster()
        {
            //
            // TODO: Add constructor logic here
            //
            m_Pincode = 0;
            m_CityName = string.Empty;
            m_StateCode = string.Empty;
            m_PincodeOld = 0;
            m_CityNameOld = string.Empty;
            m_StateCodeOld = string.Empty; 
            m_UpdateBy = string.Empty;
            m_UpdateOnDate = DateTime.MinValue.AddYears(1754); 
            m_ActiveFlag = string.Empty;
            m_Area = string.Empty;
        }
        #endregion

        #region Property

        // Pincode Number
        public int Pincode
        {
            get
            {
                return m_Pincode;
            }
            set
            {
                m_Pincode = value;
            }
        }

        // City Name
        public string CityName
        {
            get
            {
                return m_CityName;
            }
            set
            {
                m_CityName = value;
            }
        }

        // State Code
        public string StateCode
        {
            get
            {
                return m_StateCode;
            }
            set
            {
                m_StateCode = value;
            }
        }

        // Pincode Number Old
        public int PincodeOld
        {
            get
            {
                return m_PincodeOld;
            }
            set
            {
                m_PincodeOld = value;
            }
        }

        // City Name Old
        public string CityNameOld
        {
            get
            {
                return m_CityNameOld;
            }
            set
            {
                m_CityNameOld = value;
            }
        }

        // State Name Old
        public string StateCodeOld
        {
            get
            {
                return m_StateCodeOld;
            }
            set
            {
                m_StateCodeOld = value;
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

        // Active Flag
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

        // AREA
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
        #endregion
    }
}

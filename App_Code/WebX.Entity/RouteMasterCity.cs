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
    /// Summary description for ObjRouteMaster
    /// </summary>
    public class RouteMasterCity
    {
        #region Variable[s]
        private string m_RouteCode;
        private string m_RouteStBranch;
        private string m_RouteEdBranch;
        private string m_RouteCategory;
        private decimal m_RouteKM;
        private DateTime m_RouteStDate;
        private DateTime m_RouteEdDate;
        private string m_ActiveFlag;
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private string m_RouteName;
        private decimal m_RouteSchDepHour;
        private decimal m_RouteSchDepMin;
        private decimal m_STD_CONTAMT;
        private string m_RouteMode;
        private string m_ControlLocation;
        private decimal m_TransitionHour;
        private int m_RouteNumber;
        private string m_LocationCode;
        private decimal m_Distance;
        private string m_TRTIME_HR;
        private string m_TRTIME_MIN;
        private string m_STTIME_HR;
        private string m_STTIME_MIN; 
        #endregion

        #region Constructor
        public RouteMasterCity()
        {
            //
            // TODO: Add constructor logic here
            //
            m_RouteCode = string.Empty;
            m_RouteStBranch = string.Empty;
            m_RouteEdBranch = string.Empty;
            m_RouteCategory = string.Empty;
            m_RouteKM = 0.0M;
            m_RouteStDate = DateTime.MinValue.AddYears(1754);
            m_RouteEdDate = DateTime.MinValue.AddYears(1754);
            m_ActiveFlag = string.Empty;
            m_UpdateBy = string.Empty;
            m_UpdateOnDate = DateTime.MinValue.AddYears(1754);
            m_RouteName = string.Empty;
            m_RouteSchDepHour = 0.0M;
            m_RouteSchDepMin = 0.0M;
            m_STD_CONTAMT = 0.0M;
            m_RouteMode = string.Empty;
            m_ControlLocation = string.Empty;
            m_TransitionHour = 0.0M;
            m_RouteNumber = 0;
            m_LocationCode = string.Empty;
            m_Distance = 0.0M;
            m_TRTIME_HR = string.Empty;
            m_TRTIME_MIN = string.Empty;
            m_STTIME_HR = string.Empty;
            m_STTIME_MIN = string.Empty;  
        }
        #endregion

        #region Property

        // Route Code
        public string RouteCode
        {
            get
            {
                return m_RouteCode;
            }
            set
            {
                m_RouteCode = value;
            }
        }

        // Route Start Branch
        public string RouteStBranch
        {
            get
            {
                return m_RouteStBranch;
            }
            set
            {
                m_RouteStBranch = value;
            }
        }

        // Route End Branch
        public string RouteEdBranch
        {
            get
            {
                return m_RouteEdBranch;
            }
            set
            {
                m_RouteEdBranch = value;
            }
        }

        // Route Category
        public string RouteCategory
        {
            get
            {
                return m_RouteCategory;
            }
            set
            {
                m_RouteCategory = value;
            }
        }

        // Route KM
        public decimal RouteKM
        {
            get
            {
                return m_RouteKM;
            }
            set
            {
                m_RouteKM = value;
            }
        }

        // Route Start Date
        public DateTime RouteStDate
        {
            get
            {
                return m_RouteStDate;
            }
            set
            {
                m_RouteStDate = value;
            }
        }

        // Route End Date
        public DateTime RouteEdDate
        {
            get
            {
                return m_RouteEdDate;
            }
            set
            {
                m_RouteEdDate = value;
            }
        }

        // Route Active Flag
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

        // Route Update By
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

        // Route Update On Date
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

        // Route Name
        public string RouteName
        {
            get
            {
                return m_RouteName;
            }
            set
            {
                m_RouteName = value;
            }
        }

        // Route Schedule Departure Hour
        public decimal RouteSchDepHour
        {
            get
            {
                return m_RouteSchDepHour;
            }
            set
            {
                m_RouteSchDepHour = value;
            }
        }

        // Route Schedule Departure Min
        public decimal RouteSchDepMin
        {
            get
            {
                return m_RouteSchDepMin;
            }
            set
            {
                m_RouteSchDepMin = value;
            }
        }

        // Route Contract
        public decimal STD_CONTAMT
        {
            get
            {
                return m_STD_CONTAMT;
            }
            set
            {
                m_STD_CONTAMT = value;
            }
        }

        // Route Mode
        public string RouteMode
        {
            get
            {
                return m_RouteMode;
            }
            set
            {
                m_RouteMode = value;
            }
        }

        // Route Controll Location
        public string ControlLocation
        {
            get
            {
                return m_ControlLocation;
            }
            set
            {
                m_ControlLocation = value;
            }
        }

        // Route Transition Hour
        public decimal TransitionHour
        {
            get
            {
                return m_TransitionHour;
            }
            set
            {
                m_TransitionHour = value;
            }
        }

        // Route Number
        public int RouteNumber
        {
            get
            {
                return m_RouteNumber;
            }
            set
            {
                m_RouteNumber = value;
            }
        }

        // Location Code
        public string LocationCode
        {
            get
            {
                return m_LocationCode;
            }
            set
            {
                m_LocationCode = value;
            }
        }

        // Distance
        public decimal Distance 
        {
            get
            {
                return m_Distance;
            }
            set
            {
                m_Distance = value;
            }
        }

        // Transition Time Hour
        public string TRTIME_HR
        {
            get
            {
                return m_TRTIME_HR;
            }
            set
            {
                m_TRTIME_HR = value;
            }
        }

        // Transition Time Minute
        public string TRTIME_MIN
        {
            get
            {
                return m_TRTIME_MIN;
            }
            set
            {
                m_TRTIME_MIN = value;
            }
        }

        // Stoppege Time Hour
        public string STTIME_HR
        {
            get
            {
                return m_STTIME_HR;
            }
            set
            {
                m_STTIME_HR = value;
            }
        }

        // Stoppege Time Minute
        public string STTIME_MIN
        {
            get
            {
                return m_STTIME_MIN;
            }
            set
            {
                m_STTIME_MIN = value;
            }
        }
        #endregion
    }
}

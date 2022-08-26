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
    /// Summary description for ReceiverMaster
    /// </summary>
    public class ReceiverMaster
    {
        #region Variable[s]
        private string m_ReceiverCode;
        private string m_ReceiverName;
        private string m_LocCode;
        private string m_ActiveFlag;        
        private DateTime m_EntryDate;
        private string m_EntryBy;
        private DateTime m_UpdateOnDate;        
        private string m_UpdateBy;       
        #endregion   

        #region Constructor
        public ReceiverMaster()
        {
            //
            // TODO: Add constructor logic here
            //
            m_ReceiverCode = string.Empty;  
            m_ReceiverName = string.Empty;  
            m_LocCode = string.Empty;  
            m_ActiveFlag = string.Empty;  
            m_EntryDate = DateTime.MinValue.AddYears(1754); 
            m_EntryBy = string.Empty;  
            m_UpdateOnDate = DateTime.MinValue.AddYears(1754);  
            m_UpdateBy = string.Empty;  
        }
        #endregion

        #region Property
     
        // Receiver Code
        public string ReceiverCode
        {
            get
            {
                return m_ReceiverCode;
            }
            set
            {
                m_ReceiverCode = value;
            }
        }

        // Receiver Name
        public string ReceiverName
        {
            get
            {
                return m_ReceiverName;
            }
            set
            {
                m_ReceiverName = value;
            }
        }    

        // Location Code
        public string LocationCode
        {
            get
            {
                return m_LocCode;
            }
            set
            {
                m_LocCode = value;
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

          // Record is insert on date
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

        // Record is insert by Userid : Username
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

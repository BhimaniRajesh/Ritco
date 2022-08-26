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
    /// Summary description for LocationMaster
    /// </summary>
    public class LocationMaster
    {
        #region Variable[s]
        private decimal m_LocationLevel;
        private decimal m_Report_Level;
        private string m_LocationCode;
        private string m_LocationName;
        private string m_Report_Location;
        private string m_LocationAddress;
        private string m_LocationState;
        private string m_LocationCity;
        private string m_LocationPincode;
        private string m_LocationSTDCode;
        private string m_LocationTelephoneNo;
        private string m_LocationFaxNo;
        private string m_LocationMobileNo;
        private string m_LocationEmail;
        private string m_Location_Account;
        private string m_ActiveFlag;
        private string m_Op_Bkg;
        private string m_Op_Dly;
        private string m_Op_Tranship;
        private string m_OutSource_Own;
        private string m_Octroi_IO;
        private string m_AirService;
        private string m_RailService;
        private string m_Default_NextLocation;
        private string m_Nearest_PrevLocation;
        private string m_CutOff_YN;
        private DateTime m_Bkg_CutOffTime;
        private string m_DocketGen_Auto;
        private string m_LocationAbbr;
        private string m_LocationRegion;
        private DateTime m_OP_startdt;
        private DateTime m_OP_enddt;
        private string m_Computerised;
        private string m_DataEntry;
        private DateTime m_Location_StartDt;
        private DateTime m_Location_EndDt;
        private string m_Payment_Type;
        private string m_Delivery_Type;
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private string m_DKT_PFX;
        private string m_Mode_Surface;
        private string m_Mode_Sea;
        private string m_Pickup_Door;
        private string m_Pickup_Godown;
        private string m_BilledAt;
        private string m_Vol;
        private string m_COD_DOD;
        private string m_ODA;
        private string m_Octroi_Area;
        private DateTime m_Dly_StartDt;
        private DateTime m_Dly_EndDt;
        private DateTime m_Transshipment_StartDt;
        private DateTime m_Transshipment_EndDt;
        private string m_CPC;
        private string m_cn_prefixcode;
        private string m_OP_UGD;
        #endregion

        #region Constructor
        public LocationMaster()
        {
             //
             // TODO: Add constructor logic here
             //
             m_LocationLevel = 0.0M;
             m_Report_Level = 0.0M;
             m_LocationCode = string.Empty;
             m_LocationName = string.Empty;
             m_Report_Location = string.Empty;
             m_LocationAddress = string.Empty;
             m_LocationState = string.Empty;
             m_LocationCity = string.Empty;
             m_LocationPincode = string.Empty;
             m_LocationSTDCode = string.Empty;
             m_LocationTelephoneNo = string.Empty;
             m_LocationFaxNo = string.Empty;
             m_LocationMobileNo = string.Empty;
             m_LocationEmail = string.Empty;
             m_Location_Account = string.Empty;
             m_ActiveFlag = string.Empty;
             m_Op_Bkg = string.Empty;
             m_Op_Dly = string.Empty;
             m_Op_Tranship = string.Empty;
             m_OutSource_Own = string.Empty;
             m_Octroi_IO = string.Empty;
             m_AirService = string.Empty;
             m_RailService = string.Empty;
             m_Default_NextLocation = string.Empty;
             m_Nearest_PrevLocation = string.Empty;
             m_CutOff_YN = string.Empty;
             m_Bkg_CutOffTime = DateTime.MinValue.AddYears(1754);
             m_DocketGen_Auto = string.Empty;
             m_LocationAbbr = string.Empty;
             m_LocationRegion = string.Empty;
             m_OP_startdt = DateTime.MinValue.AddYears(1754);
             m_OP_enddt = DateTime.MinValue.AddYears(1754);
             m_Computerised = string.Empty;
             m_DataEntry = string.Empty;
             m_Location_StartDt = DateTime.MinValue.AddYears(1754);
             m_Location_EndDt = DateTime.MinValue.AddYears(1754);
             m_Payment_Type = string.Empty;
             m_Delivery_Type = string.Empty;
             m_UpdateBy = string.Empty;
             m_UpdateOnDate = DateTime.MinValue.AddYears(1754);            
             m_DKT_PFX = string.Empty;
             m_Mode_Surface = string.Empty;
             m_Mode_Sea = string.Empty;
             m_Pickup_Door = string.Empty;
             m_Pickup_Godown = string.Empty;
             m_BilledAt = string.Empty;
             m_Vol = string.Empty;
             m_COD_DOD = string.Empty;
             m_ODA = string.Empty;
             m_Octroi_Area = string.Empty;
             m_Dly_StartDt = DateTime.MinValue.AddYears(1754);
             m_Dly_EndDt = DateTime.MinValue.AddYears(1754);
             m_Transshipment_StartDt = DateTime.MinValue.AddYears(1754);
             m_Transshipment_EndDt = DateTime.MinValue.AddYears(1754);        
             m_CPC = string.Empty;
             m_cn_prefixcode = string.Empty;
             m_OP_UGD = string.Empty;
        }
        #endregion

        #region Property

        // Location Level
        public decimal LocationLevel
        {
            get
            {
                return m_LocationLevel;
            }
            set
            {
                m_LocationLevel = value;
            }
        }

        // Report Level
        public decimal Report_Level
        {
            get
            {
                return m_Report_Level;
            }
            set
            {
                m_Report_Level = value;
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

        // Location Name
        public string LocationName
        {
            get
            {
                return m_LocationName;
            }
            set
            {
                m_LocationName = value;
            }
        }

        // Report_Location
        public string Report_Location
        {
            get
            {
                return m_Report_Location;
            }
            set
            {
                m_Report_Location = value;
            }
        }

        // Location Address
        public string LocationAddress
        {
            get
            {
                return m_LocationAddress;
            }
            set
            {
                m_LocationAddress = value;
            }
        }

        // Location State
        public string LocationState
        {
            get
            {
                return m_LocationState;
            }
            set
            {
                m_LocationState = value;
            }
        }

        // Location City
        public string LocationCity
        {
            get
            {
                return m_LocationCity;
            }
            set
            {
                m_LocationCity = value;
            }
        }

        // Location Pincode
        public string LocationPincode
        {
            get
            {
                return m_LocationPincode;
            }
            set
            {
                m_LocationPincode = value;
            }
        }

        // Location STDCode
        public string LocationSTDCode
        {
            get
            {
                return m_LocationSTDCode;
            }
            set
            {
                m_LocationSTDCode = value;
            }
        }

        // Location Telephone No.
        public string LocationTelephoneNo
        {
            get
            {
                return m_LocationTelephoneNo;
            }
            set
            {
                m_LocationTelephoneNo = value;
            }
        }

        // Location Fax No
        public string LocationFaxNo
        {
            get
            {
                return m_LocationFaxNo;
            }
            set
            {
                m_LocationFaxNo = value;
            }
        }

        // Location Mobile No
        public string LocationMobileNo
        {
            get
            {
                return m_LocationMobileNo;
            }
            set
            {
                m_LocationMobileNo = value;
            }
        }

        // Location Email
        public string LocationEmail
        {
            get
            {
                return m_LocationEmail;
            }
            set
            {
                m_LocationEmail = value;
            }
        }

        // Location Account
        public string Location_Account
        {
            get
            {
                return m_Location_Account;
            }
            set
            {
                m_Location_Account = value;
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

        // Is Booking at this Location 
        public string Op_Bkg
        {
            get
            {
                return m_Op_Bkg;
            }
            set
            {
                m_Op_Bkg = value;
            }
        }

        // Is Delivery at this Location
        public string Op_Dly
        {
            get
            {
                return m_Op_Dly;
            }
            set
            {
                m_Op_Dly = value;
            }
        }

        // Is Tranship at this Location
        public string Op_Tranship
        {
            get
            {
                return m_Op_Tranship;
            }
            set
            {
                m_Op_Tranship = value;
            }
        }

        // Location Ownership
        public string OutSource_Own
        {
            get
            {
                return m_OutSource_Own;
            }
            set
            {
                m_OutSource_Own = value;
            }
        }

        // Octroi_IO
        public string Octroi_IO
        {
            get
            {
                return m_Octroi_IO;
            }
            set
            {
                m_Octroi_IO = value;
            }
        }

        // Air Service
        public string AirService
        {
            get
            {
                return m_AirService;
            }
            set
            {
                m_AirService = value;
            }
        }

        // Rail Service
        public string RailService
        {
            get
            {
                return m_RailService;
            }
            set
            {
                m_RailService = value;
            }
        }

        // Default Next Location
        public string Default_NextLocation
        {
            get
            {
                return m_Default_NextLocation;
            }
            set
            {
                m_Default_NextLocation = value;
            }
        }

        // Nearest Previous Location
        public string Nearest_PrevLocation
        {
            get
            {
                return m_Nearest_PrevLocation;
            }
            set
            {
                m_Nearest_PrevLocation = value;
            }
        }

        // CutOff Yes / No
        public string CutOff_YN
        {
            get
            {
                return m_CutOff_YN;
            }
            set
            {
                m_CutOff_YN = value;
            }
        }

        // Booking Cut Off Time
        public DateTime Bkg_CutOffTime
        {
            get
            {
                return m_Bkg_CutOffTime;
            }
            set
            {
                m_Bkg_CutOffTime = value;
            }
        }

        // Docket Generation Automatic
        public string DocketGen_Auto
        {
            get
            {
                return m_DocketGen_Auto;
            }
            set
            {
                m_DocketGen_Auto = value;
            }
        }

        // Location Abbrevation
        public string LocationAbbr
        {
            get
            {
                return m_LocationAbbr;
            }
            set
            {
                m_LocationAbbr = value;
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

        // Start Date
        public DateTime OP_startdt
        {
            get
            {
                return m_OP_startdt;
            }
            set
            {
                m_OP_startdt = value;
            }
        }

        // End Date
        public DateTime OP_enddt
        {
            get
            {
                return m_OP_enddt;
            }
            set
            {
                m_OP_enddt = value;
            }
        }

        // Computerised
        public string Computerised
        {
            get
            {
                return m_Computerised;
            }
            set
            {
                m_Computerised = value;
            }
        }

        // Data Entry
        public string DataEntry
        {
            get
            {
                return m_DataEntry;
            }
            set
            {
                m_DataEntry = value;
            }
        }

        // Location Start Date
        public DateTime Location_StartDt
        {
            get
            {
                return m_Location_StartDt;
            }
            set
            {
                m_Location_StartDt = value;
            }
        }

        // Location End Date
        public DateTime Location_EndDt
        {
            get
            {
                return m_Location_EndDt;
            }
            set
            {
                m_Location_EndDt = value;
            }
        }

        // Payment_Type
        public string Payment_Type
        {
            get
            {
                return m_Payment_Type;
            }
            set
            {
                m_Payment_Type = value;
            }
        }

        // Delivery Type
        public string Delivery_Type
        {
            get
            {
                return m_Delivery_Type;
            }
            set
            {
                m_Delivery_Type = value;
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

        // Docket Prefix
        public string DKT_PFX
        {
            get
            {
                return m_DKT_PFX;
            }
            set
            {
                m_DKT_PFX = value;
            }
        }

        // Mode Prefix
        public string Mode_Surface
        {
            get
            {
                return m_Mode_Surface;
            }
            set
            {
                m_Mode_Surface = value;
            }
        }

        // Mode Sea
        public string Mode_Sea
        {
            get
            {
                return m_Mode_Sea;
            }
            set
            {
                m_Mode_Sea = value;
            }
        }

        // Pickup Door
        public string Pickup_Door
        {
            get
            {
                return m_Pickup_Door;
            }
            set
            {
                m_Pickup_Door = value;
            }
        }

        // Pickup Godown 
        public string Pickup_Godown
        {
            get
            {
                return m_Pickup_Godown;
            }
            set
            {
                m_Pickup_Godown = value;
            }
        }

        // Billed At Location
        public string BilledAt
        {
            get
            {
                return m_BilledAt;
            }
            set
            {
                m_BilledAt = value;
            }
        }

        // Vol
        public string Vol
        {
            get
            {
                return m_Vol;
            }
            set
            {
                m_Vol = value;
            }
        }

        // COD_DOD
        public string COD_DOD
        {
            get
            {
                return m_COD_DOD;
            }
            set
            {
                m_COD_DOD = value;
            }
        }

        // ODA
        public string ODA
        {
            get
            {
                return m_ODA;
            }
            set
            {
                m_ODA = value;
            }
        }

        // Octroi_Area
        public string Octroi_Area
        {
            get
            {
                return m_Octroi_Area;
            }
            set
            {
                m_Octroi_Area = value;
            }
        }

        // Delivery Start Date
        public DateTime Dly_StartDt
        {
            get
            {
                return m_Dly_StartDt;
            }
            set
            {
                m_Dly_StartDt = value;
            }
        }

        // Delivery End Date
        public DateTime Dly_EndDt
        {
            get
            {
                return m_Dly_EndDt;
            }
            set
            {
                m_Dly_EndDt = value;
            }
        }

        // Transshipment Start Date
        public DateTime Transshipment_StartDt
        {
            get
            {
                return m_Transshipment_StartDt;
            }
            set
            {
                m_Transshipment_StartDt = value;
            }
        }

        // Transshipment End Date
        public DateTime Transshipment_EndDt
        {
            get
            {
                return m_Transshipment_EndDt;
            }
            set
            {
                m_Transshipment_EndDt = value;
            }
        }

        // CPC
        public string CPC
        {
            get
            {
                return m_CPC;
            }
            set
            {
                m_CPC = value;
            }
        }

        // Prefix Code
        public string cn_prefixcode
        {
            get
            {
                return m_cn_prefixcode;
            }
            set
            {
                m_cn_prefixcode = value;
            }
        }

        // OP_UGD
        public string OP_UGD
        {
            get
            {
                return m_OP_UGD;
            }
            set
            {
                m_OP_UGD = value;
            }
        }
        #endregion
    }
}

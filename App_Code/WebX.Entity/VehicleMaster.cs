using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Runtime.Serialization;

namespace WebX.Entity
{
    /// <summary>
    /// Summary description for VehicleHDR
    /// </summary>
    public class VehicleMaster
    {
        #region Variable[s]
        private string m_VehicleType;
        private string m_VehicleNumber;
        private string m_VendorType;
        private string m_VendorCode;
        private decimal m_VehicleTons;
        private string m_VehiclePermit;
        private string m_VehicleRouteCode;
        private string m_VehicleMadeBy;
        private string m_VehicleModel;
        private string m_VehicleRCBookNo;
        private string m_VehicleRegistrationNo;
        private DateTime m_VehicleRegistrationDate;
        private string m_VehicleChasisNo;
        private string m_VehicleEngineNo;
        private string m_ActiveFlag;
        private string m_UpdateBy;
        private DateTime m_UpdateOnDate;
        private string m_VendorOwner;
        private DateTime m_InsuranceDate;
        private DateTime m_FitnessDate;
        private decimal m_UsedCapecity;
        private decimal m_Mileage;
        private string m_ControlBranch;
        private string m_VehicleCategory;
        private decimal m_Drivers;
        private decimal m_Length;
        private decimal m_Height;
        private decimal m_GVW;
        private decimal m_Payload;
        private decimal m_UnloadWeight;
        private decimal m_Payloadl;
        private decimal m_Rate;
        private decimal m_Width;
        private decimal m_Capacity;
        private string m_VehicleStatus;
        private string m_Vehicle_Attached_YN;
        private DateTime m_AttachDate;
        private string m_GPS_Device_Enabled;
        private string m_FTLType;
        private DateTime m_PermitValidityDate;
        private decimal m_CFT;

        // Vehicle Type Master 
        private int m_VehicleTypeCode;
        private string m_VehicleTypeDescription;
        private string m_FuelType;
        private string m_FleetType;
        private string m_Vehicle_Type_Category;
        private decimal m_TyreRotate_KM;
        private decimal m_veh_type_GVW;
        private decimal m_Unld_wt;
        #endregion

        #region Constructor
        public VehicleMaster()
        {
            //
            // TODO: Add constructor logic here
            //
            m_VehicleType = string.Empty;
            m_VehicleNumber = string.Empty;
            m_VendorType = string.Empty;
            m_VendorCode = string.Empty;
            m_VehicleTons = 0.0M;
            m_VehiclePermit = string.Empty;
            m_VehicleRouteCode = string.Empty;
            m_VehicleMadeBy = string.Empty;
            m_VehicleModel = string.Empty;
            m_VehicleRCBookNo = string.Empty;
            m_VehicleRegistrationNo = string.Empty;
            m_VehicleRegistrationDate = System.DateTime.MinValue;
            m_VehicleChasisNo = string.Empty;
            m_VehicleEngineNo = string.Empty;
            m_ActiveFlag = "Y";
            m_UpdateBy = string.Empty;
            m_UpdateOnDate = System.DateTime.MinValue;
            m_VendorOwner = string.Empty;
            m_InsuranceDate = System.DateTime.MinValue;
            m_FitnessDate = System.DateTime.MinValue;
            m_UsedCapecity = 0.0M;
            m_Mileage = 0.0M;
            m_ControlBranch = string.Empty;
            m_VehicleCategory = string.Empty;
            m_Drivers = 0.0M;
            m_Length = 0.0M;
            m_Height = 0.0M;
            m_GVW = 0.0M;
            m_Payload = 0.0M;
            m_UnloadWeight = 0.0M;
            m_Payloadl = 0.0M;
            m_Rate = 0.0M;
            m_Width = 0.0M;
            m_Capacity = 0.0M;
            m_VehicleStatus = string.Empty;
            m_Vehicle_Attached_YN = string.Empty;
            m_AttachDate = System.DateTime.MinValue;
            m_GPS_Device_Enabled = string.Empty;
            m_FTLType = string.Empty;
            m_PermitValidityDate = DateTime.MinValue;
            m_CFT = 0.0M;

            m_VehicleTypeDescription = string.Empty;
            m_FuelType = string.Empty;
            m_FleetType = string.Empty;
            m_VehicleTypeCode = 0;
            m_Vehicle_Type_Category = string.Empty;
            m_TyreRotate_KM = 0.0M;
            m_veh_type_GVW = 0.0M;
            m_Unld_wt = 0.0M;
        }
        #endregion

        #region Property

        // Vehicle CFT
        public decimal CFT
        {
            get
            {
                return m_CFT;
            }
            set
            {
                m_CFT = value;
            }
        }


        // FTL Type
        public string FTLType
        {
            get
            {
                return m_FTLType;
            }
            set
            {
                m_FTLType = value;
            }
        }

        // Vehicle Type
        public string VehicleType
        {
            get
            {
                return m_VehicleType;
            }
            set
            {
                m_VehicleType = value;
            }
        }

        // Vehicle Number
        public string VehicleNumber
        {
            get
            {
                return m_VehicleNumber;
            }
            set
            {
                m_VehicleNumber = value;
            }
        }

        // Vendor Type
        public string VendorType
        {
            get
            {
                return m_VendorType;
            }
            set
            {
                m_VendorType = value;
            }
        }

        // Vendor Code
        public string VendorCode
        {
            get
            {
                return m_VendorCode;
            }
            set
            {
                m_VendorCode = value;
            }
        }

        // Vehicle Tons
        public decimal VehicleTons
        {
            get
            {
                return m_VehicleTons;
            }
            set
            {
                m_VehicleTons = value;
            }
        }

        // Vehicle Permits
        public string VehiclePermit
        {
            get
            {
                return m_VehiclePermit;
            }
            set
            {
                m_VehiclePermit = value;
            }
        }

        // Vehicle Route Code
        public string VehicleRouteCode
        {
            get
            {
                return m_VehicleRouteCode;
            }
            set
            {
                m_VehicleRouteCode = value;
            }
        }

        // Vehicle Made BY
        public string VehicleMadeBy
        {
            get
            {
                return m_VehicleMadeBy;
            }
            set
            {
                m_VehicleMadeBy = value;
            }
        }

        // Vehicle Model
        public string VehicleModel
        {
            get
            {
                return m_VehicleModel;
            }
            set
            {
                m_VehicleModel = value;
            }
        }

        // Vehicle RC Book Number
        public string VehicleRCBookNo
        {
            get
            {
                return m_VehicleRCBookNo;
            }
            set
            {
                m_VehicleRCBookNo = value;
            }
        }

        // Vehicle Registration Number
        public string VehicleRegistrationNo
        {
            get
            {
                return m_VehicleRegistrationNo;
            }
            set
            {
                m_VehicleRegistrationNo = value;
            }
        }

        // Vehicle Registration Date
        public DateTime VehicleRegistrationDate
        {
            get
            {
                return m_VehicleRegistrationDate;
            }
            set
            {
                m_VehicleRegistrationDate = value;
            }
        }

        // Vehicle Chasis Number
        public string VehicleChasisNo
        {
            get
            {
                return m_VehicleChasisNo;
            }
            set
            {
                m_VehicleChasisNo = value;
            }
        }

        // Vehicle Engine Number
        public string VehicleEngineNo
        {
            get
            {
                return m_VehicleEngineNo;
            }
            set
            {
                m_VehicleEngineNo = value;
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

        // Update By
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

        // Update On Date
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

        // Update Owner
        public string VendorOwner
        {
            get
            {
                return m_VendorOwner;
            }
            set
            {
                m_VendorOwner = value;
            }
        }

        // Insurance Validity Date
        public DateTime InsuranceDate
        {
            get
            {
                return m_InsuranceDate;
            }
            set
            {
                m_InsuranceDate = value;
            }
        }

        // Fitness Validity Date
        public DateTime FitnessDate
        {
            get
            {
                return m_FitnessDate;
            }
            set
            {
                m_FitnessDate = value;
            }
        }

        // Used Capecity
        public decimal UsedCapecity
        {
            get
            {
                return m_UsedCapecity;
            }
            set
            {
                m_UsedCapecity = value;
            }
        }

        // Mileage
        public decimal Mileage
        {
            get
            {
                return m_Mileage;
            }
            set
            {
                m_Mileage = value;
            }
        }

        // Control Branch
        public string ControlBranch
        {
            get
            {
                return m_ControlBranch;
            }
            set
            {
                m_ControlBranch = value;
            }
        }

        // Vehicle Category
        public string VehicleCategory
        {
            get
            {
                return m_VehicleCategory;
            }
            set
            {
                m_VehicleCategory = value;
            }
        }

        // Drivers
        public decimal Drivers
        {
            get
            {
                return m_Drivers;
            }
            set
            {
                m_Drivers = value;
            }
        }

        // Vehicle length
        public decimal Length
        {
            get
            {
                return m_Length;
            }
            set
            {
                m_Length = value;
            }
        }

        // Vehicle Height
        public decimal Height
        {
            get
            {
                return m_Height;
            }
            set
            {
                m_Height = value;
            }
        }

        // Vehicle GVW
        public decimal GVW
        {
            get
            {
                return m_GVW;
            }
            set
            {
                m_GVW = value;
            }
        }

        // Vehicle Unload Weight
        public decimal UnloadWeight
        {
            get
            {
                return m_UnloadWeight;
            }
            set
            {
                m_UnloadWeight = value;
            }
        }

        // Vehicle Payload
        public decimal Payload
        {
            get
            {
                return m_Payload;
            }
            set
            {
                m_Payload = value;
            }
        }

        // Vehicle Rate
        public decimal Rate
        {
            get
            {
                return m_Rate;
            }
            set
            {
                m_Rate = value;
            }
        }

        // Width
        public decimal Width
        {
            get
            {
                return m_Width;
            }
            set
            {
                m_Width = value;
            }
        }

        // Capacity
        public decimal Capacity
        {
            get
            {
                return m_Capacity;
            }
            set
            {
                m_Capacity = value;
            }
        }

        // Vehicle Status
        public string VehicleStatus
        {
            get
            {
                return m_VehicleStatus;
            }
            set
            {
                m_VehicleStatus = value;
            }
        }

        // Vehicle Attached
        public string Vehicle_Attached_YN
        {
            get
            {
                return m_Vehicle_Attached_YN;
            }
            set
            {
                m_Vehicle_Attached_YN = value;
            }
        }

        // Attach Date
        public DateTime AttachDate
        {
            get
            {
                return m_AttachDate;
            }
            set
            {
                m_AttachDate = value;
            }
        }

        // Vehicle Type Description
        public string VehicleTypeDescription
        {
            get
            {
                return m_VehicleTypeDescription;
            }
            set
            {
                m_VehicleTypeDescription = value;
            }
        }

        // Vehicle Fuel Type
        public string FuelType
        {
            get
            {
                return m_FuelType;
            }
            set
            {
                m_FuelType = value;
            }
        }

        // Vehicle Fleet Type
        public string FleetType
        {
            get
            {
                return m_FleetType;
            }
            set
            {
                m_FleetType = value;
            }
        }

        // GPS Device Enabled or Not
        public string GPS_Device_Enabled
        {
            get
            {
                return m_GPS_Device_Enabled;
            }
            set
            {
                m_GPS_Device_Enabled = value;
            }
        }

          // Vehicle Type Code
        public int VehicleTypeCode
        {
            get
            {
                return m_VehicleTypeCode;
            }
            set
            {
                m_VehicleTypeCode = value;
            }
        }

        // Vehicle Type Category
        public string Vehicle_Type_Category
        {
            get
            {
                return m_Vehicle_Type_Category;
            }
            set
            {
                m_Vehicle_Type_Category = value;
            }
        }

        // Tyre Rotate KM
        public decimal TyreRotate_KM
        {
            get
            {
                return m_TyreRotate_KM;
            }
            set
            {
                m_TyreRotate_KM = value;
            }
        }



        // Fitness Validity Date
        public DateTime PermitValidityDate
        {
            get
            {
                return m_PermitValidityDate;
            }
            set
            {
                m_PermitValidityDate = value;
            }
        }

        // Vehicle Type GVW
        public decimal VehicleTypeGVW
        {
            get
            {
                return m_veh_type_GVW;
            }
            set
            {
                m_veh_type_GVW = value;
            }
        }

        // Vehicle Type Unladen weight
        public decimal  UnladenWeight
        {
            get
            {
                return m_Unld_wt;
            }
            set
            {
                m_Unld_wt = value;
            }
        }



        #endregion
    }
    [DataContract]
    public class StateResult
    {
        [DataMember]
        public string StateCode { get; set; }
        [DataMember]
        public string IsStateExist { get; set; }
    }

}

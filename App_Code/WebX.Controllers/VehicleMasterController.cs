using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

using WebX.Entity;
using System.Collections.Generic;

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for VehicleMasterController
    /// </summary>
    public class VehicleMasterController : Base
    {
        #region Constructor
        public VehicleMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        #region Vehicle Master
        // insert new record into webx_VEHICLE_HDR table
        public int insertVehicleMaster(VehicleMaster objectVehicleMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_VEHICLE_HDR_Insert", saveVehicleMasterParam(objectVehicleMaster));
            return result;
        }

        // update new record into webx_VEHICLE_HDR table
        public int updateVehicleMaster(VehicleMaster objectVehicleMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_VEHICLE_HDR_Update", saveVehicleMasterParam(objectVehicleMaster));
            return result;
        }

        // Get All Vehicle information from webx_VEHICLE_HDR table
        public DataTable getAllVehicleList()
        {
            DataSet dsVehicleList = new DataSet();
            dsVehicleList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT Type_name as VehicleType,CodeDesc AS VendorType,convert(varchar,attachdt,106) as attachedDate,convert(varchar,VEHREGDT,106) as VEHREGDate,convert(varchar,Insurance_Validity_Date,106) as Insurance_Validity_Dt,convert(varchar,Fitness_Validity_Date,106) as Fitness_Validity_Dt,convert(varchar,Permit_Validity_Date,106) as Permit_Validity_Dt,* FROM webx_VEHICLE_HDR INNER JOIN webx_vehicle_type ON webx_VEHICLE_HDR.vehicle_type = webx_vehicle_type.Type_Code LEFT OUTER JOIN webx_master_general ON webx_VEHICLE_HDR.VendorType = webx_master_general.codeid AND codetype='VENDTY' ORDER BY Vehno");
            return dsVehicleList.Tables[0];
        }

        // Get FTL Type
        public DataTable getAllFTLType()
        {
            DataSet dsFTLType = new DataSet();
            dsFTLType = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CodeID, CodeDesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y' ORDER BY codeid");
            return dsFTLType.Tables[0];
        }

        // Get All Vendor information from Genaral Master
        public DataTable getAllVendorListGenaralMaster()
        {
            DataSet dsVendorList = new DataSet();
            dsVendorList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT TOP 1 'Select' AS VendorName,'0' AS VendorCode FROM  webx_master_general UNION SELECT codedesc + ' : ' + codeid AS a, codeid AS b FROM webx_master_general WHERE codetype='VENDTY' and statuscode='Y'");
            return dsVendorList.Tables[0];
        }

        // Get All Vendor information from webx_VENDOR_HDR table   
        public DataTable getAllVendorList()
        {
            DataSet dsVendorList = new DataSet();
            dsVendorList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT VENDORNAME, vendorcode FROM webx_VENDOR_HDR ORDER BY VENDORNAME");
            return dsVendorList.Tables[0];
        }

        // Get All Vehicle Type information from webx_vehicle_type table     
        public DataTable getAllVehicleTypeList()
        {
            DataSet dsVehicleTypeList = new DataSet();
            dsVehicleTypeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT *, Type_Code, [Type_Name] AS VehicleType FROM webx_vehicle_type");
            return dsVehicleTypeList.Tables[0];
        }

        // Get Vehicle Type information from webx_vehicle_type by VehicleNumber       
        public DataTable getVehicleTypeByVehicleNumber(string VehicleNumber)
        {
            DataSet dsVehicleList = new DataSet();
            // dsVehicleList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy, *, webx_Vehicle_Type.Type_Name as Vehicle_Type_Name, codedesc + ' : ' + codeid AS Vendor_Type FROM webx_VEHICLE_HDR LEFT OUTER JOIN webx_Vehicle_Type ON webx_VEHICLE_HDR.Vehicle_Type = webx_Vehicle_Type.Type_Code LEFT OUTER JOIN webx_master_general ON webx_VEHICLE_HDR.VENDORTYPE = webx_master_general.codeID and codetype='VENDTY' LEFT OUTER JOIN WebX_Master_Users ON webx_VEHICLE_HDR.UPDTBY = WebX_Master_Users.UserID LEFT OUTER JOIN webx_VENDOR_HDR ON webx_VEHICLE_HDR.VENDORCODE = webx_VENDOR_HDR.VENDORCODE WHERE vehno='" + VehicleNumber + "'");
            dsVehicleList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT GFTLType.CodeID as FTLTypeID, GFTLType.CodeDESC as FTLType, Permit_Validity_DateV = CONVERT(VARCHAR,Permit_Validity_Date,106), UPDTONV = CONVERT(VARCHAR,webx_VEHICLE_HDR.UPDTON,106), VEHREGDTV = CONVERT(VARCHAR,VEHREGDT,106), attachdtV = CONVERT(VARCHAR,attachdt,106), Fitness_Validity_DateV = CONVERT(VARCHAR,Fitness_Validity_Date,106), Insurance_Validity_DateV = CONVERT(VARCHAR,Insurance_Validity_Date,106), UserID + ' : ' + [Name] As UpdateBy, *, webx_Vehicle_Type.Type_Name as Vehicle_Type_Name, GVEDType.codedesc + ' : ' + GVEDType.codeid AS Vendor_Type FROM webx_VEHICLE_HDR LEFT OUTER JOIN webx_Vehicle_Type ON webx_VEHICLE_HDR.Vehicle_Type = webx_Vehicle_Type.Type_Code LEFT OUTER JOIN webx_master_general AS GVEDType ON webx_VEHICLE_HDR.VENDORTYPE = GVEDType.codeID and GVEDType.codetype='VENDTY' LEFT OUTER JOIN webx_master_general AS GFTLType ON webx_VEHICLE_HDR.FTLType = GFTLType.codeID and GFTLType.codetype='FTLTYP' LEFT OUTER JOIN WebX_Master_Users ON webx_VEHICLE_HDR.UPDTBY = WebX_Master_Users.UserID LEFT OUTER JOIN webx_VENDOR_HDR ON webx_VEHICLE_HDR.VENDORCODE = webx_VENDOR_HDR.VENDORCODE WHERE vehno='" + VehicleNumber.Trim() + "'");
            return dsVehicleList.Tables[0];
        }

        // Get Vehicle Type information from webx_vehicle_type by VehicleNumber       
        public DataTable getVehicleNumberByVehicleType(string VehicleType)
        {
            DataSet dsVehicleList = new DataSet();
            dsVehicleList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT VEHNO + ' : ' + VENDORCODE AS VehicleType FROM webx_VEHICLE_HDR WHERE vehicle_type='" + VehicleType + "' ORDER BY VEHNO");
            return dsVehicleList.Tables[0];
        }

        // Get Location information from webx_location by locationcode       
        public DataTable getLocationByLocationCode(string strLocationCode)
        {
            DataSet dsLocationList = new DataSet();
            dsLocationList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_location WHERE ActiveFlag = 'Y' AND loccode='" + strLocationCode + "'");
            return dsLocationList.Tables[0];
        }

        // Get Vendor Name by Vendor Type
        public DataTable getVendorNameByVendorType(string VendorName)
        {
            DataSet dsVendorList = new DataSet();
            dsVendorList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select VENDORNAME,vendorcode from webx_VENDOR_HDR where vendor_type='" + VendorName + "' order by VENDORNAME");
            return dsVendorList.Tables[0];
        }

        // Get All State  
        public DataTable getAllStateList()
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT STNM AS StatePermit, STCD FROM webx_STATE ORDER BY STNM");
            return dsStateList.Tables[0];
        }

        // Get State by State Code 
        public DataTable getStateByStateCode(string StateCode)
        {
            DataSet dsStateList = new DataSet();
            dsStateList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT STNM FROM webx_STATE WHERE stcd IN (" + StateCode + ")");
            return dsStateList.Tables[0];
        }

        // Get All Route
        public DataTable getAllRouteList()
        {
            DataSet dsRouteList = new DataSet();
            dsRouteList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT(RUTCD + ' : ' + RUTNM) AS Rut,rutcd FROM webx_RUTMAS WHERE RUTNM IS NOT NULL ORDER BY Rut,rutcd");
            return dsRouteList.Tables[0];
        }

        // Get Route by Route Code 
        public DataTable getRouteByRouteCode(string RouteCode)
        {
            DataSet dsRouteList = new DataSet();
            dsRouteList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT RUTNM FROM webx_RUTMAS WHERE RUTCD IN (" + RouteCode + ")");
            return dsRouteList.Tables[0];
        }


        // Get All Vehicles
        public DataTable getAllVehicle()
        {
            DataSet dsVehicle = new DataSet();
            dsVehicle = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT vehno FROM webx_vehicle_hdr");
            return dsVehicle.Tables[0];
        }


        // Get All Routes
        public DataTable getAllRoutes()
        {
            DataSet dsRoute = new DataSet();
            dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "Select RouteNo, RouteName from StandardExpense_FixedRoute_HDR");
            return dsRoute.Tables[0];
        }


        #endregion

        #region Vehicle Type Master
        // Get Vehicle Type by Vehicle Type Name
        public DataTable getVehicleTypeByVehicleTypeName(string VehicleTypeName)
        {
            DataSet dsVehicleTypeList = new DataSet();
            dsVehicleTypeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy, * FROM webx_vehicle_type LEFT OUTER JOIN WebX_Master_Users ON webx_vehicle_type.UPDTBY = WebX_Master_Users.UserID WHERE type_name='" + VehicleTypeName + "'");
            return dsVehicleTypeList.Tables[0];
        }

        // Get Vehicle Type by Vehicle Code
        public DataTable getVehicleTypeByVehicleCode(string VehicleCode)
        {
            DataSet dsVehicleTypeList = new DataSet();
            dsVehicleTypeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy, *, CodeDesc as Vehicle_Type_Category_Name FROM webx_vehicle_type LEFT OUTER JOIN WebX_Master_Users ON webx_vehicle_type.UPDTBY = WebX_Master_Users.UserID LEFT OUTER JOIN Webx_Master_General ON webx_vehicle_type.Vehicle_Type_Category = Webx_Master_General.CodeID AND Webx_Master_General.CODETYPE='VHCAT' WHERE type_code='" + VehicleCode + "'");
            return dsVehicleTypeList.Tables[0];
        }

        // Get Vehicle Type Category from Webx_Master_General
        public DataTable getVehicleTypeCategory()
        {
            DataSet dsVehicleTypeCat = new DataSet();
            dsVehicleTypeCat = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CodeId, CodeDesc FROM Webx_Master_General WHERE CODETYPE='VHCAT'");
            return dsVehicleTypeCat.Tables[0];
        }

        // insert new record into webx_Vehicle_Type table
        public int insertVehicleTypeMaster(VehicleMaster objectVehicleMaster)
        {
            try
            {
                object result;
                result = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Vehicle_Type_Insert", saveVehicleTypeMasterParam(objectVehicleMaster));
                return Convert.ToInt32(result);
            }
            catch (Exception Exc)
            {
                return 1;
            }
        }

        // update new record into webx_VEHICLE_HDR table
        public int updateVehicleTypeMaster(VehicleMaster objectVehicleMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Vehicle_Type_Update", saveVehicleTypeMasterParam(objectVehicleMaster));
            return result;
        }
        #endregion
        #endregion

        #region  Private Function[s]
        private SqlParameter[] saveVehicleTypeMasterParam(VehicleMaster objectVehicleMaster)
        {
            SqlParameter[] arParms = {    
                                    new SqlParameter ("@Type_Code", SqlDbType.VarChar, 50),        
                                    new SqlParameter ("@Type_Name", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@Made_By", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@Model_No", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@Type_Desc", SqlDbType.VarChar, 100),
                                    new SqlParameter ("@Capacity", SqlDbType.Decimal),
                                    new SqlParameter ("@Rate_Per_KM", SqlDbType.Decimal),
                                    new SqlParameter ("@Fuel_Type", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@ActiveFlag", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@UPDTBY", SqlDbType.Char, 50),
                                    new SqlParameter ("@UPDTON", SqlDbType.DateTime),
                                    new SqlParameter ("@usedcapacity", SqlDbType.Decimal),
                                    new SqlParameter ("@Payload", SqlDbType.Decimal),
                                    new SqlParameter ("@length", SqlDbType.Decimal),
                                    new SqlParameter ("@width", SqlDbType.Decimal),  
                                    new SqlParameter ("@Height", SqlDbType.Decimal),
                                    new SqlParameter ("@Vehicle_Type_Category", SqlDbType.VarChar, 2),  
                                    new SqlParameter ("@TyreRotate_KM", SqlDbType.Decimal),
                                    new SqlParameter ("@GVW", SqlDbType.Decimal),  
                                    new SqlParameter ("@unld_wt", SqlDbType.Decimal)
    
                                 };

            arParms[0].Value = objectVehicleMaster.VehicleTypeCode;
            arParms[1].Value = objectVehicleMaster.VehicleType;
            arParms[2].Value = objectVehicleMaster.VehicleMadeBy;
            arParms[3].Value = objectVehicleMaster.VehicleModel;
            arParms[4].Value = objectVehicleMaster.VehicleTypeDescription;
            arParms[5].Value = objectVehicleMaster.Capacity;
            arParms[6].Value = objectVehicleMaster.Rate;
            arParms[7].Value = objectVehicleMaster.FuelType;
            arParms[8].Value = objectVehicleMaster.ActiveFlag;
            arParms[9].Value = objectVehicleMaster.UpdateBy;
            arParms[10].Value = objectVehicleMaster.UpdateOnDate;
            arParms[11].Value = objectVehicleMaster.UsedCapecity;
            arParms[12].Value = objectVehicleMaster.Payload;
            arParms[13].Value = objectVehicleMaster.Length;
            arParms[14].Value = objectVehicleMaster.Width;
            arParms[15].Value = objectVehicleMaster.Height;
            arParms[16].Value = objectVehicleMaster.Vehicle_Type_Category;
            arParms[17].Value = objectVehicleMaster.TyreRotate_KM;
            arParms[18].Value = objectVehicleMaster.VehicleTypeGVW;
            arParms[19].Value = objectVehicleMaster.UnladenWeight;
            return arParms;
        }

        private SqlParameter[] saveVehicleMasterParam(VehicleMaster objectVehicleMaster)
        {
            SqlParameter[] arParms = {                                 
                                    new SqlParameter ("@Vehicle_Type", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@VEHNO", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@VENDORTYPE", SqlDbType.VarChar, 3),
                                    new SqlParameter ("@VENDORCODE", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@VEHTONS", SqlDbType.Decimal),
                                    new SqlParameter ("@VEHPERMIT", SqlDbType.VarChar, 100),
                                    new SqlParameter ("@VEHROUTECD", SqlDbType.VarChar, 400),
                                    new SqlParameter ("@VEHMADEBY", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@VEHMODEL", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@VEHRCBKNO", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@VEHREGNO", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@VEHREGDT", SqlDbType.DateTime),
                                    new SqlParameter ("@VEHCHASISNO", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@VEHENGINENO", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@ACTIVEFLAG", SqlDbType.VarChar, 1),  
                                    new SqlParameter ("@UPDTBY", SqlDbType.Char, 50),            
                                    new SqlParameter ("@UPDTON", SqlDbType.DateTime),
                                    new SqlParameter ("@Vendor_Own", SqlDbType.VarChar, 1), 
                                    new SqlParameter ("@Insurance_Validity_Date", SqlDbType.DateTime),            
                                    new SqlParameter ("@Fitness_Validity_Date", SqlDbType.DateTime),                                   
                                    new SqlParameter ("@Usedcapacity", SqlDbType.Decimal),
                                    new SqlParameter ("@Mileage", SqlDbType.Decimal),
                                    new SqlParameter ("@Conrtl_branch", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@VEHT_CAT", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@Drivers", SqlDbType.Decimal),
                                    new SqlParameter ("@Length", SqlDbType.Decimal),
                                    new SqlParameter ("@Height", SqlDbType.Decimal),                          
                                    new SqlParameter ("@GVW", SqlDbType.Decimal),            
                                    new SqlParameter ("@Unld_Wt", SqlDbType.Decimal),
                                    new SqlParameter ("@Payload", SqlDbType.Decimal),            
                                    new SqlParameter ("@Rate_km", SqlDbType.Decimal),
                                    new SqlParameter ("@width", SqlDbType.Decimal),                           
                                    new SqlParameter ("@Capacity", SqlDbType.Decimal),
                                    new SqlParameter ("@Vehicle_Status", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@THC_Attached_YN", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Attachdt", SqlDbType.DateTime),    
                                    new SqlParameter ("@GPS_Device_Enabled", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@FTLType", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@Permit_Validity_Date",SqlDbType.DateTime),
                                    new SqlParameter ("@CFT", SqlDbType.Decimal)
                                 };

            arParms[0].Value = objectVehicleMaster.VehicleType;
            arParms[1].Value = objectVehicleMaster.VehicleNumber;
            arParms[2].Value = objectVehicleMaster.VendorType;
            arParms[3].Value = objectVehicleMaster.VendorCode;
            arParms[4].Value = objectVehicleMaster.VehicleTons;
            arParms[5].Value = objectVehicleMaster.VehiclePermit;
            arParms[6].Value = objectVehicleMaster.VehicleRouteCode;
            arParms[7].Value = objectVehicleMaster.VehicleMadeBy;
            arParms[8].Value = objectVehicleMaster.VehicleModel;
            arParms[9].Value = objectVehicleMaster.VehicleRCBookNo;
            arParms[10].Value = objectVehicleMaster.VehicleRegistrationNo;
            arParms[11].Value = objectVehicleMaster.VehicleRegistrationDate;
            arParms[12].Value = objectVehicleMaster.VehicleChasisNo;
            arParms[13].Value = objectVehicleMaster.VehicleEngineNo;
            arParms[14].Value = objectVehicleMaster.ActiveFlag;
            arParms[15].Value = objectVehicleMaster.UpdateBy;
            arParms[16].Value = objectVehicleMaster.UpdateOnDate;
            arParms[17].Value = objectVehicleMaster.VendorOwner;
            arParms[18].Value = objectVehicleMaster.InsuranceDate;
            arParms[19].Value = objectVehicleMaster.FitnessDate;
            arParms[20].Value = objectVehicleMaster.UsedCapecity;
            arParms[21].Value = objectVehicleMaster.Mileage;
            arParms[22].Value = objectVehicleMaster.ControlBranch;
            arParms[23].Value = objectVehicleMaster.VehicleCategory;
            arParms[24].Value = objectVehicleMaster.Drivers;
            arParms[25].Value = objectVehicleMaster.Length;
            arParms[26].Value = objectVehicleMaster.Height;
            arParms[27].Value = objectVehicleMaster.GVW;
            arParms[28].Value = objectVehicleMaster.UnloadWeight;
            arParms[29].Value = objectVehicleMaster.Payload;
            arParms[30].Value = objectVehicleMaster.Rate;
            arParms[31].Value = objectVehicleMaster.Width;
            arParms[32].Value = objectVehicleMaster.Capacity;
            arParms[33].Value = objectVehicleMaster.VehicleStatus;
            arParms[34].Value = objectVehicleMaster.Vehicle_Attached_YN;
            arParms[35].Value = objectVehicleMaster.AttachDate;
            arParms[36].Value = objectVehicleMaster.GPS_Device_Enabled;
            arParms[37].Value = objectVehicleMaster.FTLType;
            arParms[38].Value = objectVehicleMaster.PermitValidityDate;
            arParms[39].Value = objectVehicleMaster.CFT;
            return arParms;
        }
        #endregion

        public List<StateResult> GetState(string prefixText, string isCheck)
        {
            try
            {
                return ExecuteDataTable("Usp_Master_GetState", new SqlParameter[]
                {
                    new SqlParameter("@SearchText", prefixText),
                    new SqlParameter("@IsCheck", isCheck) }).ToList<StateResult>();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public DataTable IsStateExist(string StateCode)
        {
            try
            {
                return ExecuteDataTable("USP_Master_IsStateExist", new[]
                {
                new SqlParameter("@StateCode",StateCode)
                });
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}

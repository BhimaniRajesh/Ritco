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

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for LocationMasterController
    /// </summary>
    public class LocationMasterController
    {
        #region Constructor
        public LocationMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into webx_location table
        public int insertLocationMaster(LocationMaster objLocationMaster)
        {          
            try
            {
                return SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Location_Insert", saveLocationMasterParam(objLocationMaster));
            }
            catch (Exception Exc)
            {
                throw Exc;
            }
        }      

        // update new record into webx_location table
        public int updateLocationMaster(LocationMaster objLocationMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Location_Update", saveLocationMasterParam(objLocationMaster));
            return result;
        }

        // Get All Location information from webx_location     
        public DataTable getAllLocations()
        {
            DataSet dsLocationList = new DataSet();
            dsLocationList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_location ORDER BY LocName");
            return dsLocationList.Tables[0];
        }

        // Get All Zone from webx_master_general     
        public DataTable getAllZone()
        {
            DataSet dsZoneList = new DataSet();
            dsZoneList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT codedesc AS ZoneName, codeid AS ZoneCode, * FROM webx_master_general WHERE codetype='zone' AND StatusCode='Y'");
            return dsZoneList.Tables[0];
        }

        // Get Payment Type from webx_master_general     
        public DataTable getPaymentType()
        {
            DataSet dsPaymentTypeList = new DataSet();
            dsPaymentTypeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT codeid AS CodeType_New, codedesc AS Abbr_Type,statuscode AS ActiveFlag FROM webx_master_general WHERE LEFT(codeid, 1)='P' AND codetype='PAYTYP' Order By CodeType_New");
            return dsPaymentTypeList.Tables[0];
        }

        // Get Location from webx_location by Location Code     
        public DataTable getLocationByLocationLevel(string strLocLevel)
        {
            DataSet dsLocationList = new DataSet();
            dsLocationList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT LocName + ' : ' + LocCode As LocName, Loccode FROM webx_Location WHERE Loc_Level='" + strLocLevel + "' AND activeflag='Y'");
            return dsLocationList.Tables[0];
        }

        // Get Location from webx_location by Location Code     
        public DataTable getLocationByLocationCode(string strLocCode)
        {
            DataSet dsLocationList = new DataSet();
            dsLocationList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_location LEFT OUTER JOIN webx_state ON webx_location.LocState = webx_state.SrNo WHERE Loccode ='" + strLocCode + "' ORDER BY LocName");
            return dsLocationList.Tables[0];
        }

        // Get Location from webx_location by Location Code For View     
        public DataTable getLocationByLocationCodeView(string strLocCode)
        {
            DataSet dsLocation = new DataSet();
            dsLocation = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT Loc_EdDt=CONVERT(VARCHAR,webx_Location.loc_enddt,106), Loc_StDt=CONVERT(VARCHAR,webx_Location.loc_startdt,106), webx_master_Users.UserID + ' : ' + webx_master_Users.Name AS UpdateBY, UpdateDate=CONVERT(VARCHAR,webx_Location.UPDTON,106), GZ.codedesc AS Region, GH.codedesc AS Hierarchy, GR.codedesc as ReportTo,Report_Loc, STATE.stnm as StateName,* FROM webx_location LEFT OUTER JOIN webx_state ON webx_location.LocState = webx_state.SrNo LEFT OUTER JOIN webx_master_general GH ON webx_location.Loc_Level = GH.codeid AND GH.codetype='HRCHY' AND  GH.StatusCode='Y' LEFT OUTER JOIN webx_master_general GR ON webx_location.Report_Level = GR.codeid AND GR.codetype='HRCHY' AND  GR.StatusCode='Y' LEFT OUTER JOIN webx_master_general GZ ON webx_location.LocRegion = GZ.codeid AND GZ.codetype='zone' AND  GZ.StatusCode='Y' LEFT OUTER JOIN webx_master_Users ON webx_location.UPDTBY = webx_master_Users.UserID cross apply (select top 1 STNM from webx_state where webx_state.STCD = webx_location.Locstate) STATE WHERE webx_location.Loccode ='" + strLocCode + "' ORDER BY webx_location.LocName");
            return dsLocation.Tables[0];
        }
        #endregion

        #region  Private Function[s]
        private SqlParameter[] saveLocationMasterParam(LocationMaster objLocationMaster)
        {
            try
            {
                SqlParameter[] arParms = {   
                                    new SqlParameter ("@Loc_Level", SqlDbType.Decimal),              
                                    new SqlParameter ("@Report_Level", SqlDbType.Decimal), 
                                    new SqlParameter ("@LocCode", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@LocName", SqlDbType.VarChar, 100),
                                    new SqlParameter ("@Report_Loc", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@LocAddr", SqlDbType.VarChar, 500),                             
                                    new SqlParameter ("@LocState", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@LocCity", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@LocPincode", SqlDbType.VarChar, 6),
                                    new SqlParameter ("@LocSTDCode", SqlDbType.VarChar, 10),   
                                    new SqlParameter ("@LocTelno", SqlDbType.VarChar, 50),              
                                    new SqlParameter ("@LocFaxno", SqlDbType.VarChar, 50), 
                                    new SqlParameter ("@Locmobile", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@LocEmail", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@Loc_Account", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@ActiveFlag", SqlDbType.VarChar, 2),                             
                                    new SqlParameter ("@Op_Bkg", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Op_Dly", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Op_Tranship", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@OutSource_Own", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Octroi_IO", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@AirService", SqlDbType.VarChar, 1),                             
                                    new SqlParameter ("@RailService", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Default_NextLoc", SqlDbType.VarChar, 500),
                                    new SqlParameter ("@Nearest_PrevLoc", SqlDbType.VarChar, 500),
                                    new SqlParameter ("@CutOff_YN", SqlDbType.VarChar, 1), 
                                    new SqlParameter ("@Bkg_CutOffTime", SqlDbType.DateTime),
                                    new SqlParameter ("@DocketGen_Auto", SqlDbType.VarChar,1),
                                    new SqlParameter ("@LocAbbrev", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@LocRegion", SqlDbType.VarChar, 2), 
                                    new SqlParameter ("@OP_startdt", SqlDbType.DateTime), 
                                    new SqlParameter ("@OP_enddt", SqlDbType.DateTime),
                                    new SqlParameter ("@Computerised", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Dataentry", SqlDbType.VarChar, 500), 
                                    new SqlParameter ("@loc_startdt", SqlDbType.DateTime), 
                                    new SqlParameter ("@loc_enddt", SqlDbType.DateTime),
                                    new SqlParameter ("@payment_type", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@delivery_type", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@UPDTBY", SqlDbType.VarChar, 50), 
                                    new SqlParameter ("@UPDTON", SqlDbType.DateTime),                                    
                                    new SqlParameter ("@DKT_PFX", SqlDbType.VarChar, 25),                             
                                    new SqlParameter ("@Mode_Surface", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Mode_Sea", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Pickup_Door", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Pickup_Godown", SqlDbType.VarChar, 1),   
                                    new SqlParameter ("@BilledAt", SqlDbType.VarChar, 10),        
                                    new SqlParameter ("@Vol", SqlDbType.VarChar, 1), 
                                    new SqlParameter ("@COD_DOD", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@ODA", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@Octroi_Area", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@Dly_StartDt", SqlDbType.DateTime),                             
                                    new SqlParameter ("@Dly_EndDt", SqlDbType.DateTime),
                                    new SqlParameter ("@Transshipment_StartDt", SqlDbType.DateTime),
                                    new SqlParameter ("@Transshipment_EndDt", SqlDbType.DateTime),                 
                                    new SqlParameter ("@CPC", SqlDbType.VarChar, 5),                             
                                    new SqlParameter ("@cn_prefixcode", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@OP_UGD", SqlDbType.VarChar, 1)         
                                 };

                arParms[0].Value = objLocationMaster.LocationLevel;
                arParms[1].Value = objLocationMaster.Report_Level;
                arParms[2].Value = objLocationMaster.LocationCode;
                arParms[3].Value = objLocationMaster.LocationName;
                arParms[4].Value = objLocationMaster.Report_Location;
                arParms[5].Value = objLocationMaster.LocationAddress;
                arParms[6].Value = objLocationMaster.LocationState;
                arParms[7].Value = objLocationMaster.LocationCity;
                arParms[8].Value = objLocationMaster.LocationPincode;
                arParms[9].Value = objLocationMaster.LocationSTDCode;
                arParms[10].Value = objLocationMaster.LocationTelephoneNo;
                arParms[11].Value = objLocationMaster.LocationFaxNo;
                arParms[12].Value = objLocationMaster.LocationMobileNo;
                arParms[13].Value = objLocationMaster.LocationEmail;
                arParms[14].Value = objLocationMaster.Location_Account;
                arParms[15].Value = objLocationMaster.ActiveFlag;
                arParms[16].Value = objLocationMaster.Op_Bkg;
                arParms[17].Value = objLocationMaster.Op_Dly;
                arParms[18].Value = objLocationMaster.Op_Tranship;
                arParms[19].Value = objLocationMaster.OutSource_Own;
                arParms[20].Value = objLocationMaster.Octroi_IO;
                arParms[21].Value = objLocationMaster.AirService;
                arParms[22].Value = objLocationMaster.RailService;
                arParms[23].Value = objLocationMaster.Default_NextLocation;
                arParms[24].Value = objLocationMaster.Nearest_PrevLocation;
                arParms[25].Value = objLocationMaster.CutOff_YN;
                arParms[26].Value = objLocationMaster.Bkg_CutOffTime;
                arParms[27].Value = objLocationMaster.DocketGen_Auto;
                arParms[28].Value = objLocationMaster.LocationAbbr;
                arParms[29].Value = objLocationMaster.LocationRegion;
                arParms[30].Value = objLocationMaster.OP_startdt;
                arParms[31].Value = objLocationMaster.OP_enddt;
                arParms[32].Value = objLocationMaster.Computerised;
                arParms[33].Value = objLocationMaster.DataEntry;
                arParms[34].Value = objLocationMaster.Location_StartDt;
                arParms[35].Value = objLocationMaster.Location_EndDt;
                arParms[36].Value = objLocationMaster.Payment_Type;
                arParms[37].Value = objLocationMaster.Delivery_Type;
                arParms[38].Value = objLocationMaster.UpdateBy;
                arParms[39].Value = objLocationMaster.UpdateOnDate;
                arParms[40].Value = objLocationMaster.DKT_PFX;
                arParms[41].Value = objLocationMaster.Mode_Surface;
                arParms[42].Value = objLocationMaster.Mode_Sea;
                arParms[43].Value = objLocationMaster.Pickup_Door;
                arParms[44].Value = objLocationMaster.Pickup_Godown;
                arParms[45].Value = objLocationMaster.BilledAt;
                arParms[46].Value = objLocationMaster.Vol;
                arParms[47].Value = objLocationMaster.COD_DOD;
                arParms[48].Value = objLocationMaster.ODA;
                arParms[49].Value = objLocationMaster.Octroi_Area;
                arParms[50].Value = objLocationMaster.Dly_StartDt;
                arParms[51].Value = objLocationMaster.Dly_EndDt;
                arParms[52].Value = objLocationMaster.Transshipment_StartDt;
                arParms[53].Value = objLocationMaster.Transshipment_EndDt;
                arParms[54].Value = objLocationMaster.CPC;
                arParms[55].Value = objLocationMaster.cn_prefixcode;
                arParms[56].Value = objLocationMaster.OP_UGD;
                return arParms;
            }
            catch (Exception Ex)
            {
                throw Ex; 
            }
        }
        #endregion
    }    
}

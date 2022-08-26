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
    /// Summary description for PincodeMasterController
    /// </summary>
     
    public class PincodeMasterController
    {
        #region Constructor
        public PincodeMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into webx_pincode_master table
        public int insertPincodeMaster(PincodeMaster objPincodeMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Pincode_Master_Insert", savePincodeMasterParam(objPincodeMaster));
            return result;
        }

        // update new record into webx_pincode_master table
        public int updatePincodeMaster(PincodeMaster objPincodeMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Pincode_Master_Update", savePincodeMasterParam(objPincodeMaster));
            return result;
        }

        // Get All City information from webx_citymaster     
        public DataTable getAllCityByState(string strState)
        {
            DataSet dsCityList = new DataSet();
            dsCityList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT DISTINCT Location,Region,book_loc,Del_loc,state,oda_yn,odakm,activeflag,city_code FROM webx_citymaster WHERE state='" + strState + "' ORDER BY Location");
            return dsCityList.Tables[0];
        }

        // Get Pincode from webx_pincode_master     
        public DataTable getPincodeByStateAndCity(string strState, string strCity)
        {
            DataSet dsPincodeList = new DataSet();
            dsPincodeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT *, (SELECT TOP 1 stnm FROM webx_state WHERE stcd= p.[StateCode]) AS StateName FROM webx_pincode_master p WHERE cityname = '" + strCity.Trim() + "' AND StateCode = '" + strState.Trim() + "'");
            // dsPincodeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_pincode_master WHERE cityname = '" + strCity.Trim() +"' AND Stastename = '" + strState.Trim() + "' AND ActiveFlag = 'Y'");
            return dsPincodeList.Tables[0];
        }

        // Get All Pincode Information from webx_pincode_master     
        public DataTable getAllPincodeInfo()
        {
            DataSet dsPincodeList = new DataSet();
            dsPincodeList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT *,(SELECT TOP 1 stnm FROM webx_state WHERE stcd= p.[StateCode]) AS StateName FROM webx_pincode_master p ");
            return dsPincodeList.Tables[0];
        }
        #endregion            

        #region  Private Function[s]
        private SqlParameter[] savePincodeMasterParam(PincodeMaster objPincodeMaster)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@pincode", SqlDbType.Int),              
                                    new SqlParameter ("@cityname", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@StateCode", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@EntryBy", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@Entrydt", SqlDbType.DateTime),                               
                                    new SqlParameter ("@ActiveFlag", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@citynameold", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@StateCodeold", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@pincodeold", SqlDbType.Int),
                                    new SqlParameter ("@Area", SqlDbType.VarChar, 10)                        
                                 };

            arParms[0].Value = objPincodeMaster.Pincode;
            arParms[1].Value = objPincodeMaster.CityName;
            arParms[2].Value = objPincodeMaster.StateCode;
            arParms[3].Value = objPincodeMaster.UpdateBy;
            arParms[4].Value = objPincodeMaster.UpdateOnDate;
            arParms[5].Value = objPincodeMaster.ActiveFlag;
            arParms[6].Value = objPincodeMaster.CityNameOld;
            arParms[7].Value = objPincodeMaster.StateCodeOld;
            arParms[8].Value = objPincodeMaster.PincodeOld;
            arParms[9].Value = objPincodeMaster.Area; 
            return arParms;
        }
        #endregion
    }   
}


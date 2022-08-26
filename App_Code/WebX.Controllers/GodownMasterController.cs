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
    /// Summary description for GodownMasterController
    /// </summary>
    public class GodownMasterController
    {
        #region Constructor
        public GodownMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s] 
        // insert new record into [dbo].[webx_GODOWNMST]  table
        public int insertGodownMaster(GodownMaster objectGodownMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Godown_Master_Insert", saveGodownMasterParam(objectGodownMaster));
            return result;
        }

        // update new record into [dbo].[webx_GODOWNMST]  table
        public int updateGodownMaster(GodownMaster objectGodownMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Godown_Master_Update", saveGodownMasterParam(objectGodownMaster));
            return result;
        }
     
        // Get Godown information from webx_Godownmst table   
        public DataTable getGodownByLocation(string strLocation)
        {
            DataSet dsGodownList = new DataSet();
            dsGodownList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT godown_srno,spdbrcd,godown_name,godown_desc,ActiveFlag,isnull(Area,'') AS Area,isnull(Godown_Address,'') AS GodownAddress, isnull(Convert(VARCHAR(20),Validity_Date,103),'')  ValidityDate FROM webx_Godownmst WHERE spdbrcd='" + strLocation + "' ORDER BY spdbrcd");
            return dsGodownList.Tables[0];
        }

        // Get All Godown information from webx_godownmst table   
        public DataTable getAllGodownInfo()
        {
            DataSet dsLocationList = new DataSet();
            dsLocationList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_Godownmst ORDER BY spdbrcd");
            return dsLocationList.Tables[0];
        }

        // Get All Location information from webx_location table   
        public DataTable getAllLocationList()
        {
            DataSet dsLocationList = new DataSet();
            dsLocationList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT loccode +':'+ locname as Location, loccode as SPDBRCD FROM webx_location where activeflag='y' order by location,spdbrcd");
            return dsLocationList.Tables[0];
        }
        #endregion

        #region  Private Function[s]
        private SqlParameter[] saveGodownMasterParam(GodownMaster objectGodownMaster)
        {
            SqlParameter[] arParms = {   
                                        new SqlParameter ("@godown_srno", SqlDbType.Decimal),   
                                        new SqlParameter ("@SPDBRCD", SqlDbType.VarChar, 10),              
                                        new SqlParameter ("@godown_name", SqlDbType.VarChar, 50),
                                        new SqlParameter ("@godown_desc", SqlDbType.VarChar, 100),                                    
                                        new SqlParameter ("@UPDTBY", SqlDbType.VarChar, 50),
                                        new SqlParameter ("@UPDTON", SqlDbType.DateTime),
                                        new SqlParameter ("@ActiveFlag", SqlDbType.VarChar,2),
                                        new SqlParameter ("@Area", SqlDbType.VarChar, 100),
                                        new SqlParameter ("@Address", SqlDbType.VarChar, 100),
                                        new SqlParameter ("@ValidityDate", SqlDbType.VarChar, 100),
                                     };

            arParms[0].Value = objectGodownMaster.SrNo;
            arParms[1].Value = objectGodownMaster.BranchCode;
            arParms[2].Value = objectGodownMaster.Name;
            arParms[3].Value = objectGodownMaster.Description;
            arParms[4].Value = objectGodownMaster.UpdateBy;
            arParms[5].Value = objectGodownMaster.UpdateOnDate;
            arParms[6].Value = objectGodownMaster.ActiveFlag;
            arParms[7].Value = objectGodownMaster.Area;
            arParms[8].Value = objectGodownMaster.Address;
            arParms[9].Value = objectGodownMaster.ValidityDate;

            return arParms;
        }
        #endregion
    }
}

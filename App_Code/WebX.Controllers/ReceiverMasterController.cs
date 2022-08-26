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
    /// Summary description for ReceiverMasterController
    /// </summary>
    public class ReceiverMasterController
    {
        #region Constructor
        public ReceiverMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into WebX_Master_Receiver table
        public int insertReceiverMaster(ReceiverMaster objReceiverMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_WebX_Master_Receiver_Insert", saveReceiverMasterParam(objReceiverMaster));
            return result;
        }

        // update new record into WebX_Master_Receiver table
        public int updateReceiverMaster(ReceiverMaster objReceiverMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_WebX_Master_Receiver_Update", saveReceiverMasterParam(objReceiverMaster));
            return result;
        }

        // Get Receiver Information by Receiver Code from WebX_Master_Receiver
        public DataTable getReceiverInfoByReceiverCode(string ReceiverCode)
        {
            DataSet dsReceiverInfo = new DataSet();
            dsReceiverInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy, * from webx_Master_Receiver LEFT OUTER JOIN WebX_Master_Users ON webx_Master_Receiver.UpdateBy = WebX_Master_Users.UserID where webx_Master_Receiver.ReceiverCode = '" + ReceiverCode + "'");
            return dsReceiverInfo.Tables[0];
        }

        // Get All Receiver Information from WebX_Master_Receiver
        public DataTable getAllReceiverInfo()
        {
            DataSet dsReceiverInfo = new DataSet();
            dsReceiverInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT ReceiverName + ' : ' + ReceiverCode AS Receiver, * FROM webx_Master_Receiver ORDER BY ReceiverName");
            return dsReceiverInfo.Tables[0];
        }
     
        // Get next ReceiverCode    
        public int getNextReceiverCode()
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select cast(right(max(ReceiverCode), 5) as numeric(18, 0)) + 1 from webx_Master_Receiver");

                if (obj is DBNull)
                    return 1;
                else
                    return Convert.ToInt32(obj);
            }
            catch (Exception Exc)
            {
                return 1;
            }
        }
        #endregion

        #region  Private Function[s]
        private SqlParameter[] saveReceiverMasterParam(ReceiverMaster objReceiverMaster)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@ReceiverCode", SqlDbType.VarChar, 10),              
                                    new SqlParameter ("@ReceiverName", SqlDbType.VarChar, 250),
                                    new SqlParameter ("@LocCode", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@ActiveFlag", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@EntryBy", SqlDbType.VarChar, 50), 
                                    new SqlParameter ("@EntryDate", SqlDbType.DateTime),
                                    new SqlParameter ("@UpdateDate", SqlDbType.DateTime),
                                    new SqlParameter ("@UpdateBy", SqlDbType.VarChar, 50)                                 
                                    };

            arParms[0].Value = objReceiverMaster.ReceiverCode;
            arParms[1].Value = objReceiverMaster.ReceiverName;
            arParms[2].Value = objReceiverMaster.LocationCode;
            arParms[3].Value = objReceiverMaster.ActiveFlag ;
            arParms[4].Value = objReceiverMaster.EntryBy;
            arParms[5].Value = objReceiverMaster.EntryDate;
            arParms[6].Value = objReceiverMaster.UpdateOnDate;
            arParms[7].Value = objReceiverMaster.UpdateBy;           

            return arParms;
        }
        #endregion
    }
}

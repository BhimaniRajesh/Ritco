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
    /// Summary description for CustomerGroupMaster
    /// </summary>
    public class CustomerGroupMasterController
    {
        #region Constructor
        public CustomerGroupMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into webx_GRPMST table
        public int insertCustomerGroupMaster(CustomerGroupMaster objectCustomerGroupMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Customer_Group_Master_Insert", saveCustomerGroupMasterParam(objectCustomerGroupMaster));
            return result;
        }

        // update record into webx_GRPMST table
        public int updateCustomerGroupMaster(CustomerGroupMaster objectCustomerGroupMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_Customer_Group_Master_Update", saveCustomerGroupMasterParam(objectCustomerGroupMaster));
            return result;
        }

        // Get Customer information from Webx_CUSTHDR By Customer Code       
        public DataTable getCustomerGroupInfoByGroupCode(string strCustomerGroupCode)
        {
            DataSet dsCustomerGroupInfo = new DataSet();
            dsCustomerGroupInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy, GRPCD, GRP_Pwd, GRPNM, ActiveFlag, UPDTON = CONVERT(VARCHAR, webx_GRPMST.UPDTON,106) FROM webx_GRPMST LEFT OUTER JOIN WebX_Master_Users ON webx_GRPMST.UPDTBY = WebX_Master_Users.UserID WHERE GRPCD = '" + strCustomerGroupCode + "'");
            return dsCustomerGroupInfo.Tables[0];
        }

        // Get next customer group code     
        public string getNextCustomerGroupCode()
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT MAX(RIGHT(grpcd, 4)) FROM webx_GRPMST");

                if (obj is DBNull)
                    return "";
                else
                    return Convert.ToString(obj);
            }
            catch (Exception Exc)
            {
                return "";
            }
        }

        // Get All Customer Group from webx_GRPMST       
        public DataTable getAllCustomerGroup()
        {
            DataSet dsCustomer = new DataSet();
            dsCustomer = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT GRPNM + ' : ' + GRPCD as GroupCodeName, grpcd, * FROM webx_GRPMST order by GRPNM");
            return dsCustomer.Tables[0];
        }    

        #endregion

        #region  Private Function[s]
        private SqlParameter[] saveCustomerGroupMasterParam(CustomerGroupMaster objectCustomerGroupMaster)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@GRPCD", SqlDbType.VarChar, 10),              
                                    new SqlParameter ("@GRPNM", SqlDbType.VarChar, 100),
                                    new SqlParameter ("@GRP_Pwd", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@locregion", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@ActiveFlag", SqlDbType.VarChar, 2),                               
                                    new SqlParameter ("@OLD_GRPCD", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@UPDTBY", SqlDbType.VarChar, 50)                                                                                            
                                 };

            arParms[0].Value = objectCustomerGroupMaster.GroupCode;
            arParms[1].Value = objectCustomerGroupMaster.GroupName;
            arParms[2].Value = objectCustomerGroupMaster.Password;
            arParms[3].Value = objectCustomerGroupMaster.LocationRegion;
            arParms[4].Value = objectCustomerGroupMaster.ActiveFlag;
            arParms[5].Value = objectCustomerGroupMaster.Old_GroupCode;
            arParms[6].Value = objectCustomerGroupMaster.UpdateBy;                 

            return arParms;
        }
        #endregion
    }
}

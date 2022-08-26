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
    /// Summary description for CustomerMasterController
    /// </summary>
    public class CustomerMasterController
    {
        #region Constructor
        public CustomerMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into Webx_CUSTHDR table
        public int insertCustomerMaster(CustomerMaster objectCustomerMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Webx_CUSTHDR_Insert", saveCustomerMasterParam(objectCustomerMaster));
            return result;
        }

        // update new record into Webx_CUSTHDR table
        public int updateCustomerMaster(CustomerMaster objectCustomerMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Webx_CUSTHDR_Update", saveCustomerMasterParam(objectCustomerMaster));
            return result;
        }

        // Get Customer information from Webx_CUSTHDR By Customer Code       
        public DataTable getCustomerInfoByCustomerCode(string strCustomerCode)
        {
            DataSet dsCustomerInfo = new DataSet();
            dsCustomerInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT UserID + ' : ' + [Name] As UpdateBy, * FROM webx_CUSTHDR LEFT OUTER JOIN WebX_Master_Users ON webx_CUSTHDR.UPDTBY = WebX_Master_Users.UserID WHERE CUSTCD = '" + strCustomerCode + "'");
            return dsCustomerInfo.Tables[0];
        }

        // Get All Customer Group from webx_GRPMST       
        public DataTable getAllCustomerGroup()
        {
            DataSet dsCustomer = new DataSet();
            dsCustomer = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT GRPNM + ' : ' + GRPCD as GroupCodeName, grpcd FROM webx_GRPMST WHERE activeflag='Y' order by GRPNM");
            return dsCustomer.Tables[0];
        }

        // Get All Customer from webx_CUSTHDR by Customer Group       
        public DataTable getAllCustomerByGroupCode(string strGroupCode)
        {
            DataSet dsCustomer = new DataSet();
            if (strGroupCode == "All")
                dsCustomer = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CUSTNM + ' : ' + CUSTCD AS CustomerName, CUSTCD FROM webx_CUSTHDR order by CUSTNM");
            else
                dsCustomer = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CUSTNM + ' : ' + CUSTCD AS CustomerName, CUSTCD FROM webx_CUSTHDR WHERE GRPCD='" + strGroupCode + "'  order by CUSTNM");
                    
            return dsCustomer.Tables[0];
        }

        // Get All City information from Webx_CUSTHDR       
        public DataTable getAllCustomer()
        {
            DataSet dsCustomer = new DataSet();
            dsCustomer = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT GRPCD,CUSTCD,CUSTNM,CUSTCAT,Cust_Active FROM webx_CUSTHDR ORDER BY CUSTNM");
            return dsCustomer.Tables[0];
        }

        // Get All Customer information from webx_citymaster       
        public DataTable getAllCity()
        {
            DataSet dsCity = new DataSet();
            dsCity = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT Location FROM webx_citymaster ORDER BY Location");
            return dsCity.Tables[0];
        }

        // Get Service Opted for list from webx_master_general       
        public DataTable getAllSvcOptFor()
        {
            DataSet dsSvcOpt = new DataSet();
            dsSvcOpt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT codeid, codedesc FROM webx_master_general WHERE codetype='SVCOPT' AND statuscode='Y' ORDER BY codeid");
            return dsSvcOpt.Tables[0];
        }

        // Get State by State Code 
        public DataTable getSvcOptForByCode(string Code)
        {
            DataSet dsSvcOpt = new DataSet();
            dsSvcOpt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='SVCOPT' AND statuscode='Y' AND codeid IN (" + Code + ") ORDER BY codeid");
            return dsSvcOpt.Tables[0];
        }

        // Get next customer code     
        public int getNextCustomerCode(string strGroupCode)
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select cast(right(max(custcd), 4) as numeric(18, 0)) + 1 from webx_CUSTHDR where grpcd='" + strGroupCode + "'");

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

		// Get next customer code     
        public int getNextSecondoryCustomerCode(string strGroupCode)
        {
            try
            {
				object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select cast(right(max(custcd), 4) as numeric(18, 0)) + 1 from webx_CUSTHDR where grpcd='" + strGroupCode + "' AND CUSTCD LIKE grpcd+'%'");
                //object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT isnull(MAX(CONVERT(INT,SUBSTRING(CUSTCD, (len(grpcd)+1),10))),0)+1 FROM webx_custhdr where isSysGenerated='Y' and grpcd='" + strGroupCode + "'");
                //object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT MAX(CONVERT(INT,RIGHT (CUSTCD, 5)))+1 FROM webx_custhdr where SUBSTRING(CUSTCD, 1,2)='SC'");
                // object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT MAX(CONVERT(INT,SUBSTRING(CUSTCD, 6,4)))+1 FROM webx_custhdr where GRPCD = SUBSTRING(CUSTCD, 1,5) AND grpcd='" + strGroupCode + "'");

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
        private SqlParameter[] saveCustomerMasterParam(CustomerMaster objectCustomerMaster)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@GRPCD", SqlDbType.VarChar, 10),              
                                    new SqlParameter ("@CUSTCD", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@Company_Custcd", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@CUSTNM", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@CUSTPASS", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@CUSTCAT", SqlDbType.VarChar, 25),                               
                                    new SqlParameter ("@TBBCRDAYS", SqlDbType.Decimal),
                                    new SqlParameter ("@TOPAYCRDAYS", SqlDbType.Decimal),
                                    new SqlParameter ("@OCTCRDAYS", SqlDbType.Decimal),
                                    new SqlParameter ("@TBBELEGIBILITY", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@TOPAYELEGIBILITY", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@OCTROIELIGIBILITY", SqlDbType.VarChar, 1),                                   
                                    new SqlParameter ("@UPDTBY", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@UPDTON", SqlDbType.DateTime),  
                                    new SqlParameter ("@DKTCHG", SqlDbType.Decimal),              
                                    new SqlParameter ("@FOVOWNER", SqlDbType.Decimal),
                                    new SqlParameter ("@FOVCARRIER", SqlDbType.Decimal),
                                    new SqlParameter ("@RATETYPE", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@RATEMATRIX", SqlDbType.VarChar, 1),                               
                                    new SqlParameter ("@SERVICETAX", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@BDEREF", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@CSTNO", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@EMAILIDS", SqlDbType.VarChar, 100),
                                    new SqlParameter ("@CUST_ACTIVE", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@MOBSERV_ENABLED", SqlDbType.VarChar, 1),                                   
                                    new SqlParameter ("@MOBILENO", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@STNUM", SqlDbType.VarChar, 20),    
                                    new SqlParameter ("@OLD_GRPCD", SqlDbType.VarChar, 10),  
                                    new SqlParameter ("@OLD_CUSTCD", SqlDbType.VarChar, 10),              
                                    new SqlParameter ("@opendebit", SqlDbType.Decimal),
                                    new SqlParameter ("@opencredit", SqlDbType.Decimal),
                                    new SqlParameter ("@contract_made", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@CUSTLOC", SqlDbType.VarChar, 2500),                               
                                    new SqlParameter ("@InvoicewiseBill_YN", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@CustAddress", SqlDbType.VarChar, 250),
                                    new SqlParameter ("@city", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@telno", SqlDbType.VarChar, 100),
                                    new SqlParameter ("@pincode", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@pan_no", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@ServiceOptFor", SqlDbType.VarChar, 50)                       
                                 };

            arParms[0].Value = objectCustomerMaster.GroupCode;
            arParms[1].Value = objectCustomerMaster.CustomerCode;
            arParms[2].Value = objectCustomerMaster.CompanyCustomerCode;
            arParms[3].Value = objectCustomerMaster.CustomerName;
            arParms[4].Value = objectCustomerMaster.CustomerPassword;
            arParms[5].Value = objectCustomerMaster.CustomerCategory;
            arParms[6].Value = objectCustomerMaster.TBBCRDAYS;
            arParms[7].Value = objectCustomerMaster.TOPAYCRDAYS;
            arParms[8].Value = objectCustomerMaster.OCTCRDAYS;
            arParms[9].Value = objectCustomerMaster.TBBELEGIBILITY;
            arParms[10].Value = objectCustomerMaster.TOPAYELEGIBILITY;
            arParms[11].Value = objectCustomerMaster.OCTROIELIGIBILITY;
            arParms[12].Value = objectCustomerMaster.UpdateBy;
            arParms[13].Value = objectCustomerMaster.UpdateOnDate;
            arParms[14].Value = objectCustomerMaster.DKTCHG;
            arParms[15].Value = objectCustomerMaster.FOVOWNER;
            arParms[16].Value = objectCustomerMaster.FOVCARRIER;
            arParms[17].Value = objectCustomerMaster.RATETYPE;
            arParms[18].Value = objectCustomerMaster.RATEMATRIX;
            arParms[19].Value = objectCustomerMaster.SERVICETAX;
            arParms[20].Value = objectCustomerMaster.BDEREF;
            arParms[21].Value = objectCustomerMaster.CSTNO;
            arParms[22].Value = objectCustomerMaster.EmailID;
            arParms[23].Value = objectCustomerMaster.ActiveFlag;
            arParms[24].Value = objectCustomerMaster.MobileServiceEnable;
            arParms[25].Value = objectCustomerMaster.MobileNo;
            arParms[26].Value = objectCustomerMaster.STNUM;
            arParms[27].Value = objectCustomerMaster.OldGroupCode;
            arParms[28].Value = objectCustomerMaster.OldCustomerCode;
            arParms[29].Value = objectCustomerMaster.OpenDebit;
            arParms[30].Value = objectCustomerMaster.OpenCredit;
            arParms[31].Value = objectCustomerMaster.ContractMade;
            arParms[32].Value = objectCustomerMaster.CustomerLocation;
            arParms[33].Value = objectCustomerMaster.InvoicewiseBill_YN;
            arParms[34].Value = objectCustomerMaster.Address;
            arParms[35].Value = objectCustomerMaster.City;
            arParms[36].Value = objectCustomerMaster.TelephoneNo;
            arParms[37].Value = objectCustomerMaster.PinCode;
            arParms[38].Value = objectCustomerMaster.PanCardNo;
            arParms[39].Value = objectCustomerMaster.ServiceOptedFor;

            return arParms;
        }
        #endregion
    }
}

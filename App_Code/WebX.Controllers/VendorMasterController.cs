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
    /// Summary description for VendorMasterController
    /// </summary>
    public class VendorMasterController
    {
        #region Constructor
        public VendorMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into webx_VENDOR_HDR table
        public int insertVendorMaster(VendorMaster objectVendorMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_VENDOR_MASTER_Insert", saveVendorMasterParam(objectVendorMaster));
            return result;
        }

        // update new record into webx_VENDOR_HDR table
        public int updateVendorMaster(VendorMaster objectVendorMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_VENDOR_MASTER_Update", saveVendorMasterParam(objectVendorMaster));
            return result;
        }

        // Get Vendor Type from webx_master_general
        public DataTable getAllVendorType()
        {
            DataSet dsVendorList = new DataSet();
            dsVendorList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT codeid as VendorCode, codedesc as VendorName FROM webx_master_general WHERE codetype='VENDTY'");
            return dsVendorList.Tables[0];
        }

        // Get Vendor Information by Vendor Type from webx_master_general 
        public DataTable getVendorByVendorType(string VendorType)
        {
            DataSet dsVendorType = new DataSet();
            dsVendorType = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT vendorname + ' : ' + vendorcode as Vendor, vendorcode as VendorCode from webx_VENDOR_HDR WHERE Vendor_Type='" + VendorType + "' ORDER BY vendorname");
            return dsVendorType.Tables[0];
        }

        // Get Vendor Information by Vendor Code from webx_VENDOR_HDR and webx_VENDOR_DET 
        public DataTable getVendorInfoByVendorCode(string VendorCode)
        {
            DataSet dsVendorInfo = new DataSet();
            dsVendorInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select CodeDesc as VendorTypeName, UserID + ' : ' + [Name] As UpdateBy, * from webx_VENDOR_HDR left outer join webx_VENDOR_DET ON webx_VENDOR_HDR.VENDORCODE = webx_VENDOR_DET.VENDORCODE left outer join webx_master_general ON webx_VENDOR_HDR.Vendor_Type = webx_master_general.codeid AND codetype='VENDTY' LEFT OUTER JOIN WebX_Master_Users ON webx_VENDOR_HDR.UPDTBY = WebX_Master_Users.UserID where webx_VENDOR_HDR.VENDORCODE = '" + VendorCode + "'");
            return dsVendorInfo.Tables[0];
        }

        // Get All Vendor Information from webx_VENDOR_HDR and webx_VENDOR_DET 
        public DataTable getAllVendorInfo()
        {
            DataSet dsVendorInfo = new DataSet();
            //dsVendorInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CodeDesc as VendorTypeName, * FROM webx_VENDOR_HDR left outer join webx_VENDOR_DET ON webx_VENDOR_HDR.VENDORCODE = webx_VENDOR_DET.VENDORCODE left outer join webx_master_general ON webx_VENDOR_HDR.Vendor_Type = webx_master_general.codeid AND codetype='VENDTY'");
			dsVendorInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CodeDesc as VendorTypeName, * FROM webx_VENDOR_HDR OUTER APPLY (	select top 1 * from webx_VENDOR_DET Where webx_VENDOR_HDR.VENDORCODE = webx_VENDOR_DET.VENDORCODE)webx_VENDOR_DET left outer join webx_master_general ON webx_VENDOR_HDR.Vendor_Type = webx_master_general.codeid AND codetype='VENDTY'");
            return dsVendorInfo.Tables[0];
        }

        // Get All Active Location from webx_Location
        public DataTable getAllLocation()
        {
            DataSet dsLocation = new DataSet();
            dsLocation = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT loccode,locname FROM webx_Location WHERE activeflag='Y' order by locname");
            return dsLocation.Tables[0];
        }

        // Get next Vendor code     
        public int getNextVendorerCode()
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select cast(right(max(vendorcode), 5) as numeric(18, 0)) + 1 from webx_VENDOR_HDR Where Len(vendorcode)='6'");

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
        private SqlParameter[] saveVendorMasterParam(VendorMaster objectVendorMaster)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@Vendor_Type", SqlDbType.VarChar, 5),              
                                    new SqlParameter ("@VENDORCODE", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@VENDORTYPE", SqlDbType.VarChar, 3),
                                    new SqlParameter ("@VENDORNAME", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@CONTRACTSTDT", SqlDbType.DateTime),                               
                                    new SqlParameter ("@CONTRACTENDDT", SqlDbType.DateTime),
                                    new SqlParameter ("@VENDORREMARKS", SqlDbType.Text),
                                    new SqlParameter ("@UPDTBY", SqlDbType.VarChar, 50),                                  
                                    new SqlParameter ("@UPDTON", SqlDbType.DateTime),
                                    new SqlParameter ("@vendcat", SqlDbType.VarChar, 10),                                   
                                    new SqlParameter ("@PAN_NO", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@SERVTAXNO", SqlDbType.VarChar, 25),                
                                    new SqlParameter ("@vendorbstno", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@vendorcstno", SqlDbType.VarChar, 25),                               
                                    new SqlParameter ("@Default_Addr", SqlDbType.VarChar, 255),
                                    new SqlParameter ("@Active", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@Contract_Market", SqlDbType.VarChar, 15),                                  
                                    new SqlParameter ("@Contract_YN", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@Contract_Dt", SqlDbType.DateTime),                                   
                                    new SqlParameter ("@opendebit", SqlDbType.Decimal),
                                    new SqlParameter ("@opencredit", SqlDbType.Decimal),                            
                                    new SqlParameter ("@VENDORBRCD", SqlDbType.VarChar, 2000),
                                    new SqlParameter ("@VENDORCONTACT", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@VENDORADDRESS", SqlDbType.VarChar, 500),
                                    new SqlParameter ("@VENDORCITY", SqlDbType.VarChar, 20),                               
                                    new SqlParameter ("@VENDORPIN", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@VENDORPHONE", SqlDbType.VarChar, 30),
                                    new SqlParameter ("@VENDORMOBILE", SqlDbType.VarChar, 15),
                                    new SqlParameter ("@VENDOREMAIL", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@ACTIVEFLAG", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@BLACKLISTED", SqlDbType.VarChar, 2),                                   
                                    new SqlParameter ("@COST_PERMONTH", SqlDbType.Decimal)       
                                 };

            arParms[0].Value = objectVendorMaster.Vendor_Type;
            arParms[1].Value = objectVendorMaster.Vendor_Code;
            arParms[2].Value = objectVendorMaster.VENDORTYPE ;
            arParms[3].Value = objectVendorMaster.Vendor_Name;
            arParms[4].Value = objectVendorMaster.Contract_St_Date;
            arParms[5].Value = objectVendorMaster.Contract_Ed_Date;
            arParms[6].Value = objectVendorMaster.Vendor_Remarks;
            arParms[7].Value = objectVendorMaster.UpdateBy;
            arParms[8].Value = objectVendorMaster.UpdateOnDate;
            arParms[9].Value = objectVendorMaster.Vendor_Category;
            arParms[10].Value = objectVendorMaster.Pan_No;
            arParms[11].Value = objectVendorMaster.Service_Tax_No;
            arParms[12].Value = objectVendorMaster.Vendor_Bst_No;
            arParms[13].Value = objectVendorMaster.Vendor_Cst_No;
            arParms[14].Value = objectVendorMaster.Vendor_Address;
            arParms[15].Value = objectVendorMaster.IsActiveFlag;          
            arParms[16].Value = objectVendorMaster.Contract_Market;
            arParms[17].Value = objectVendorMaster.Contract_YN;
            arParms[18].Value = objectVendorMaster.Contract_Date;
            arParms[19].Value = objectVendorMaster.OpenDebit;
            arParms[20].Value = objectVendorMaster.OpenCredit;            
            arParms[21].Value = objectVendorMaster.Vendor_Branch_Code;
            arParms[22].Value = objectVendorMaster.Vendor_Contract;
            arParms[23].Value = objectVendorMaster.Vendor_Address;
            arParms[24].Value = objectVendorMaster.Vendor_City;
            arParms[25].Value = objectVendorMaster.Vendor_Pin_Code;
            arParms[26].Value = objectVendorMaster.Vendor_Phone_No;
            arParms[27].Value = objectVendorMaster.Vendor_Mobile_No;
            arParms[28].Value = objectVendorMaster.Vender_Email;
            arParms[29].Value = objectVendorMaster.IsActiveFlag;
            arParms[30].Value = objectVendorMaster.IsBlackListed;
            arParms[31].Value = objectVendorMaster.CostPerMonth;   

            return arParms;
        }       
        #endregion
    }
}

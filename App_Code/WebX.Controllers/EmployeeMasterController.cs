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
    /// Summary description for EmployeeMasterController
    /// </summary>
    public class EmployeeMasterController
    {
        #region Constructor
        public EmployeeMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]

        // insert new record into WEBX_MASTER_USERS table
        public int insertEmployeeMaster(EmployeeMaster objectEmployeeMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Webx_Master_Users_Insert", saveEmployeeMasterParam(objectEmployeeMaster));
            return result;
        }

        // update new record into WEBX_MASTER_USERS table
        public int updateEmployeeMaster(EmployeeMaster objectEmployeeMaster)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Webx_Master_Users_Update", saveEmployeeMasterParam(objectEmployeeMaster));
            return result;
        }

        // Get Employee Information from webx_master_Users by EmployeeID    
        public DataTable getEmployeeByEmployeeID(string strEmployeeID)
        {
            DataSet dsEmployee = new DataSet();
            dsEmployee = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT TOP 1 *, tempUserName.UserID + ' : ' + tempUserName.[Name] As UpdateBy FROM webx_master_users LEFT OUTER JOIN webx_master_general ON webx_master_users.User_Type = webx_master_general.CodeID LEFT OUTER JOIN WebX_Master_Users as tempUserName ON WebX_Master_Users.LastUpdatedBy = tempUserName.UserID WHERE webx_master_users.empid='" + strEmployeeID + "'");
            return dsEmployee.Tables[0];
        }

        // Get Employee Information from webx_master_Users by UserID    
        public DataTable getEmployeeByUserID(string strUserID)
        {
            DataSet dsEmployee = new DataSet();
            dsEmployee = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT TOP 1 *, tempUserName.UserID + ' : ' + tempUserName.[Name] As UpdateBy FROM webx_master_users LEFT OUTER JOIN webx_master_general ON webx_master_users.User_Type = webx_master_general.CodeID LEFT OUTER JOIN WebX_Master_Users as tempUserName ON WebX_Master_Users.LastUpdatedBy = tempUserName.UserID WHERE webx_master_users.userid='" + strUserID + "'");
            return dsEmployee.Tables[0];
        }

        // Get All User Information from webx_master_Users    
        public DataTable getAllUser()
        {
            DataSet dsUserList = new DataSet();
            // dsUserList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM WEBX_MASTER_USERS ORDER BY empid");
            // dsUserList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "Select *, ActiveFlag = CASE status WHEN '100' THEN 'Y' ELSE 'N' END from webx_master_users LEFT OUTER JOIN webx_master_general ON webx_master_users.User_Type = webx_master_general.CodeID WHERE webx_master_general.codetype LIKE 'EMPST' ORDER BY empid");
            dsUserList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "Select EmpID, UserID, [Name], BranchCode, ActiveFlag = CASE status WHEN '100' THEN 'Y' ELSE 'N' END, LastUpdatedDT=CONVERT(VARCHAR,webx_master_users.LastUpdatedDate,106), webx_master_general.CodeDesc as UserType, PasswordQues, PasswordAns,ManagerID, EmailID, PhoneNo, MobileNo, Gender = CASE gender WHEN 'M' THEN 'MALE' ELSE 'FEMALE' END, EntryDate=CONVERT(VARCHAR,webx_master_users.EntryDate,106), resi_addr as Address, webx_master_users.EntryBy, webx_master_users.LastUpdatedBY, DOB=CONVERT(VARCHAR,webx_master_users.DOB,106), DOJ_ORG=CONVERT(VARCHAR,webx_master_users.DOJ_ORG,106) from webx_master_users LEFT OUTER JOIN webx_master_general ON webx_master_users.User_Type = webx_master_general.CodeID AND webx_master_general.codetype LIKE 'EMPST' ORDER BY empid");
            return dsUserList.Tables[0];
        }

        // Get Employee Code Rule from WebX_Setup_Fields    
        public DataTable getEmployeeCodeRule()
        {
            DataSet dsEmployeeCodeRule = new DataSet();
            dsEmployeeCodeRule = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM WebX_Setup_Fields WHERE fieldcode='EMP'");
            return dsEmployeeCodeRule.Tables[0];
        }

        // Get Employee Status from webx_master_general    
        public DataTable getEmployeeStatus()
        {
            DataSet dsEmployeeStatus = new DataSet();
            dsEmployeeStatus = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_master_general WHERE codetype LIKE 'EMPST'");
            return dsEmployeeStatus.Tables[0];
        }

        // Get Hierarchy from webx_master_general    
        public DataTable getHierarchy()
        {
            DataSet dsHierarchy = new DataSet();
            dsHierarchy = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT codedesc AS level_type,codeid AS level_no FROM webx_master_general WHERE codetype='HRCHY' AND  StatusCode='Y' order by codeid asc");
            return dsHierarchy.Tables[0];
        }

        // Get Location from webx_master_general for Head Office    
        public DataTable getLocationForHeadOffice()
        {
            DataSet dsHierarchy = new DataSet();
            dsHierarchy = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and level_no='1' and statuscode='Y' order by level_no asc");
            return dsHierarchy.Tables[0];
        }

        // Get Location from webx_master_general By Branch   
        public DataTable getLocationBYLocationLevel(string strLocationLevel)
        {
            DataSet dsHierarchy = new DataSet();
            dsHierarchy = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select distinct LocName + ' : ' + LocCode as LocationName, LocCode from webx_Location where Loc_Level='" + strLocationLevel + "'");
            return dsHierarchy.Tables[0];
        }

        // Get Employee from webx_master_Users By Branch Code  
        public DataTable getEmployeeBYBranchCode(string strBranchCode)
        {
            DataSet dsHierarchy = new DataSet();
            dsHierarchy = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "select  name + ' : ' +  empid + ' : ' + userid  as Name, EmpID from webx_master_users  where BranchCode='" + strBranchCode + "' order by name");
            return dsHierarchy.Tables[0];
        }

        // Get Employee ID, User ID, Name from webx_master_Users    
        public DataTable getAllEmployeeID()
        {
            DataSet dsUserList = new DataSet();
            // dsUserList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM WEBX_MASTER_USERS ORDER BY empid");
            dsUserList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "Select EmpID, UserID, Name, ActiveFlag = CASE status WHEN '100' THEN 'Y' ELSE 'N' END from webx_master_users ORDER BY empid");
            return dsUserList.Tables[0];
        }

        // update new record into WEBX_MASTER_USERS table
        public int updateEmployeePassword(string newPassword, string lastPassword, string userID)
        {
            string sqlQuery = string.Format("UPDATE webx_master_users SET userpwd='{0}', lastpwd='{1}', pwdlastchangeon=getdate() WHERE userid='{2}'", newPassword, lastPassword, userID);    
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, sqlQuery);
            return result;
        }
        #endregion

        #region  Private Function[s]
        private SqlParameter[] saveEmployeeMasterParam(EmployeeMaster objectEmployeeMaster)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@UserId", SqlDbType.VarChar, 20),              
                                    new SqlParameter ("@User_Type", SqlDbType.VarChar, 5),
                                    new SqlParameter ("@UserPwd", SqlDbType.VarChar, 500),
                                    new SqlParameter ("@BranchCode", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@Name", SqlDbType.VarChar, 50),                               
                                    new SqlParameter ("@PasswordQues", SqlDbType.VarChar, 150),
                                    new SqlParameter ("@PasswordAns", SqlDbType.VarChar, 150),
                                    new SqlParameter ("@EmpId", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@ManagerId", SqlDbType.VarChar, 20),
                                    new SqlParameter ("@EmailId", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@PhoneNo", SqlDbType.VarChar, 20),                                   
                                    new SqlParameter ("@ActiveTillDate", SqlDbType.DateTime),
                                    new SqlParameter ("@PwdLastChangeOn", SqlDbType.DateTime),                
                                    new SqlParameter ("@LastPwd", SqlDbType.VarChar, 500),
                                    new SqlParameter ("@Status", SqlDbType.VarChar, 5),
                                    new SqlParameter ("@EntryDate", SqlDbType.DateTime),
                                    new SqlParameter ("@EntryBy", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@LastUpdatedDate", SqlDbType.DateTime),
                                    new SqlParameter ("@LastUpdatedBy", SqlDbType.VarChar, 50),                                   
                                    new SqlParameter ("@mobileno", SqlDbType.VarChar, 15),                 
                                    new SqlParameter ("@gender", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@resi_addr", SqlDbType.VarChar, 250),
                                    new SqlParameter ("@DOB", SqlDbType.DateTime),
                                    new SqlParameter ("@DOJ_ORG", SqlDbType.DateTime),                                   
                                    new SqlParameter ("@IsPassEncrypted", SqlDbType.VarChar, 1)
                                 };

            arParms[0].Value = objectEmployeeMaster.UserID;
            arParms[1].Value = objectEmployeeMaster.User_Type;
            arParms[2].Value = objectEmployeeMaster.UserPassword;
            arParms[3].Value = objectEmployeeMaster.BranchCode;
            arParms[4].Value = objectEmployeeMaster.UserName;
            arParms[5].Value = objectEmployeeMaster.PasswordQ;
            arParms[6].Value = objectEmployeeMaster.PasswordA;
            arParms[7].Value = objectEmployeeMaster.EmployeeId;
            arParms[8].Value = objectEmployeeMaster.ManagerId;
            arParms[9].Value = objectEmployeeMaster.EmailId;
            arParms[10].Value = objectEmployeeMaster.PhoneNo;
            arParms[11].Value = objectEmployeeMaster.ActiveTillDate;
            arParms[12].Value = objectEmployeeMaster.PwdLastChangeOn;
            arParms[13].Value = objectEmployeeMaster.LastPwd;
            arParms[14].Value = objectEmployeeMaster.Status;
            arParms[15].Value = objectEmployeeMaster.EntryDate;
            arParms[16].Value = objectEmployeeMaster.EntryBy;
            arParms[17].Value = objectEmployeeMaster.LastUpdatedDate;
            arParms[18].Value = objectEmployeeMaster.LastUpdatedBy;
            arParms[19].Value = objectEmployeeMaster.MobileNo;
            arParms[20].Value = objectEmployeeMaster.Gender;
            arParms[21].Value = objectEmployeeMaster.Address;
            arParms[22].Value = objectEmployeeMaster.DOB;
            arParms[23].Value = objectEmployeeMaster.DOJ_ORG;
            arParms[24].Value = objectEmployeeMaster.IsPassEncrypted;

            return arParms;
        }
        #endregion
    }        
}

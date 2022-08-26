using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;

/// <summary>
/// Summary description for Company_Master
/// </summary>
public class Company_Master
{
	public Company_Master()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public string InsertUpdateCompanyMaster(string Xml_Company_Details,SqlTransaction trans)
    {
        SqlParameter[] arParms = new SqlParameter[1];
        arParms[0] = ControllersHelper.GetSqlParameter("@Xml_Company_Details", Xml_Company_Details, SqlDbType.Text);

        string Company_Code = "";
        string sql = "usp_Insert_Update_Company_Master";
        try
        {
            Company_Code = SqlHelper.ExecuteScalar(trans,CommandType.StoredProcedure, sql, arParms).ToString();
        }
        catch(Exception e)
        {
            throw e;
        }

        return Company_Code;
    }
    public DataTable CompanyMasterEmpLocLoadData(string EmpLocCode, string Type)
    {
        string Sql = "";
        if (Type.CompareTo("Employee") == 0)
        {
            Sql = "SELECT A.COMPANY_CODE,A.COMPANY_NAME,";
            Sql += "CHECKYN=(SELECT CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END FROM WEBX_EMPLOYEE_COMPANY_MAPPING B WHERE B.EMP_CODE='" + EmpLocCode + "' AND B.COMPANY_LIST LIKE '%'+ A.COMPANY_CODE + '%' ),";
            Sql += "DEFAULTYN=(SELECT CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END FROM WEBX_EMPLOYEE_COMPANY_MAPPING C WHERE C.EMP_CODE='" + EmpLocCode + "' AND C.DEFAULT_COMPANY LIKE '%'+ A.COMPANY_CODE +'%' )";
            Sql += "FROM WEBX_COMPANY_MASTER A WITH(NOLOCK) WHERE ACTIVEFLAG='Y' ORDER BY SRNO";
        }
        else
        {
            Sql = "SELECT A.COMPANY_CODE,A.COMPANY_NAME,";
            Sql += "CHECKYN=(SELECT CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END FROM WEBX_LOCATION_COMPANY_MAPPING B WHERE B.LOCCODE='" + EmpLocCode + "' AND B.COMPANY_LIST LIKE '%'+ A.COMPANY_CODE + '%' ),";
            Sql += "DEFAULTYN=(SELECT CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END FROM WEBX_LOCATION_COMPANY_MAPPING C WHERE C.LOCCODE='" + EmpLocCode + "' AND C.DEFAULT_COMPANY LIKE '%'+ A.COMPANY_CODE +'%' )";
            Sql += "FROM WEBX_COMPANY_MASTER A WITH(NOLOCK) WHERE ACTIVEFLAG='Y' ORDER BY SRNO";
        }

        DataTable Dt = new DataTable();
        try
        {
            Dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString,CommandType.Text,Sql).Tables[0];
        }
        catch(Exception e)
        {
            throw e;
        }

        return Dt;
    }
    public string FindOutCompanyName_1(string COMPANY_CODE)
    {
        string Sql = "SELECT COMPANY_NAME FROM WEBX_COMPANY_MASTER WITH(NOLOCK) WHERE COMPANY_CODE='" + COMPANY_CODE + "'";

        string COMPANY_NAME = "";
        try
        {
            COMPANY_NAME = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql).ToString();
        }
        catch (Exception e)
        {
            throw e;
        }

        return COMPANY_NAME;
    }
    public string FindOutCompanyName(string COMPANY_CODE)
    {
        string Sql = "SELECT COMPANY_NAME FROM WEBX_COMPANY_MASTER WITH(NOLOCK) WHERE COMPANY_CODE='" + COMPANY_CODE + "'";

        string COMPANY_NAME = "";
        DataTable dt = new DataTable();

        if (COMPANY_CODE != "")
        {
            try
            {
                //COMPANY_NAME = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql).ToString();
                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                    COMPANY_NAME = dt.Rows[0]["COMPANY_NAME"].ToString();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        return COMPANY_NAME;
    }
    public DataTable EmpLocCheckExists(string Code,string Type)
    {
        string Sql = "";
        DataTable dt = new DataTable();

        if (Type == "Employee")
            Sql = "SELECT COUNT(EMP_CODE) COUNT,ACTIVEFLAG FROM WEBX_EMPLOYEE_COMPANY_MAPPING WHERE EMP_CODE='" + Code + "' GROUP BY EMP_CODE,ACTIVEFLAG";
        else
            Sql = "SELECT COUNT(LOCCODE) COUNT,ACTIVEFLAG FROM WEBX_LOCATION_COMPANY_MAPPING WHERE LOCCODE='" + Code + "' GROUP BY LOCCODE,ACTIVEFLAG";

        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];
        }
        catch (Exception e)
        {
            throw e;
        }

        return dt;
    }
    public DataTable CompanyListing()
    {
        string Sql = "SELECT COMPANY_CODE AS CODE,COMPANY_CODE + ' : ' + COMPANY_NAME AS COMPANY_NAME FROM WEBX_COMPANY_MASTER WITH(NOLOCK) WHERE ACTIVEFLAG='Y'";

        DataTable Dt = new DataTable();
        try
        {
            Dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];
        }
        catch (Exception e)
        {
            throw e;
        }

        return Dt;
    }
    public DataTable CompanyMasterLoadData(string Company_Code)
    {
        string Sql = "SELECT COMPANY_CODE,COMPANY_NAME,BRCD,ADDRESS,CONTACT_PERSON,CONTACTNO,ACTIVEFLAG FROM WEBX_COMPANY_MASTER WITH(NOLOCK) WHERE COMPANY_CODE='" + Company_Code + "'";
       
        DataTable Dt = new DataTable();
        try
        {
            Dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString,CommandType.Text,Sql).Tables[0];
        }
        catch(Exception e)
        {
            throw e;
        }

        return Dt;
    }
    public string InsertUpdateEmpMapping(string Xml_Emp_Details,SqlTransaction trans)
    {
        SqlParameter[] arParms = new SqlParameter[1];
        arParms[0] = ControllersHelper.GetSqlParameter("@Xml_Emp_Details", Xml_Emp_Details, SqlDbType.Text);

        string Emp_Code = "";
        string sql = "usp_Insert_Update_Emp_Company_Mapping";
        try
        {
            Emp_Code = SqlHelper.ExecuteScalar(trans,CommandType.StoredProcedure, sql, arParms).ToString();
        }
        catch(Exception e)
        {
            throw e;
        }

        return Emp_Code;
    }
    public string InsertUpdateLocMapping(string Xml_Location_Details,SqlTransaction trans)
    {
        SqlParameter[] arParms = new SqlParameter[1];
        arParms[0] = ControllersHelper.GetSqlParameter("@Xml_Location_Details", Xml_Location_Details, SqlDbType.Text);

        string LocCode = "";
        string sql = "usp_Insert_Update_Location_Company_Mapping";
        try
        {
            LocCode = SqlHelper.ExecuteScalar(trans, CommandType.StoredProcedure, sql, arParms).ToString();
        }
        catch(Exception e)
        {
            throw e;
        }

        return LocCode;
    }
    public DataTable CompanyListingMappedToEmployee(string Empcode)
    {
        SqlParameter[] arParms = new SqlParameter[1];
        arParms[0] = ControllersHelper.GetSqlParameter("@EmpCode", Empcode, SqlDbType.VarChar);

        string sql = "CompanyMappedToEmployee";
        
        DataTable dt = new DataTable();

        try
        {
            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sql, arParms);
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch (Exception e)
        {
            throw e;
        }

        return dt;
    }
    public string DefaultCompanyMappedToEmployee(string Empcode)
    {
        string sql = "SELECT DEFAULT_COMPANY FROM WEBX_EMPLOYEE_COMPANY_MAPPING WITH(NOLOCK) WHERE ACTIVEFLAG='Y' AND EMP_CODE='" + Empcode + "'";

        string DefaultCompany = "";

        try
        {
            object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sql);
            if (obj != null)
            {
                DefaultCompany = obj.ToString();
            }
        }
        catch (Exception e)
        {
            throw e;
        }

        return DefaultCompany;
    }
}

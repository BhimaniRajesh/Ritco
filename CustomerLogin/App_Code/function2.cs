using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


/// <summary>
/// Summary description for function2
/// </summary>
public class function2 : System.Web.UI.Page
{
   // SqlConnection conn = new SqlConnection("data source=192.168.0.3;UID=sa;PWD=!@ecfy#$;Database=TLL.Net;");
    //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    public static SqlConnection conn;
   
	public function2()
	{
        
		//
		// TODO: Add constructor logic here
		//
	}
    public string GetCompanyName(string ProspectCode)
    {
        string companyname = "";
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select companyname from webx_ProspectCustomer where ProspectCode='" + ProspectCode + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            companyname = Convert.ToString(dr["companyname"]);
        }
        dr.Close();
        conn.Close();
        if (companyname == null) companyname = "";
        return companyname;

    }

    public string GetEmployeeName(string entryby)
    {
        string EmployeeName = "";
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select Name from WebX_Master_Users where UserId='" + entryby + "'";
        SqlCommand cmd1 = new SqlCommand(sql, conn);


        SqlDataReader dr1 = null;
        dr1 = cmd1.ExecuteReader();

        while (dr1.Read())
        {
            EmployeeName = Convert.ToString(dr1["empnm"]);
        }
        dr1.Close();
        conn.Close();
        if (EmployeeName == null) EmployeeName = "";
        return EmployeeName;

    }
    public string GetIndustryName(string IndustryCode)
    {
        string IndustryName = "";
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select CodeDesc from Webx_Master_General where CodeType='IND' and CodeId='" + IndustryCode + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);


        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            IndustryName = Convert.ToString(dr["CodeDesc"]);
        }
        dr.Close();
        conn.Close();
        if (IndustryName == null) IndustryName = "";
        return IndustryName;

    }
}

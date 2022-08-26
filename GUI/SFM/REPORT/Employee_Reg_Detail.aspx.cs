using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class REPORT_Employee_Reg_Detail : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string entryby;

    protected void Page_Load(object sender, EventArgs e)
    {
        entryby = Request.QueryString["entryby"].ToString();

        //"Select RegisterDt, CompanyName, industryCode, CompAddr, CompCity, CompPin, CompPhone, CompEmail, ContPerson, ContDesign, ContPhone, ContEmail, LocCode From webx_prospectcustomer Where prospectcode='" & ProsCode & "'"
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select UserID,Name,RESI_ADDR,PhoneNo,EMAILID,MOBILENO,* from WebX_Master_Users Where UserID='" + entryby + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = sqlcmd.ExecuteReader();

        if (dr.Read())
        {

            string EmployeeCode, EmployeeName, Phone, Address, Mobile, Designation, Email;

            EmployeeCode = dr[0].ToString().Trim();
            EmployeeName = dr[1].ToString().Trim();
            Address = dr[2].ToString().Trim();
            Phone = dr[3].ToString().Trim();
            Email = dr[4].ToString().Trim();
            Mobile = dr[5].ToString().Trim();
            //Designation = dr[6].ToString().Trim();

            lblAddress.Text = Address;
            //lblDesignation.Text = Designation;
            lblEmail.Text = Email;
            lblEmployeeCode.Text = EmployeeCode;
            lblEmployeeName.Text = EmployeeName;
            lblMobileNo.Text = Mobile;
            lblPhoneNo.Text = Phone;
            

        }
        dr.Close();
        conn.Close();
    }
}

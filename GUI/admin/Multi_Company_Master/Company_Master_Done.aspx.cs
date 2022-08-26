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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_Multi_Company_Master_Company_Master_Done : System.Web.UI.Page
{
    public string Code = "", flag = "", CodeType = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CodeType = Request.QueryString["Type"].ToString();
        string sql = "";
        if (CodeType == "Company")
        {
            Code = Request.QueryString["Code"].ToString();
            flag = Request.QueryString["Flag"].ToString();
            if (flag == "1")
                Lblmsg.Text = "Following Company Code has been Successfully Added";
            else
                Lblmsg.Text = "Following Company Code has been Successfully Updated";

            sql = "SELECT COMPANY_CODE + ' : ' + COMPANY_NAME AS COMPANY FROM WEBX_COMPANY_MASTER WHERE COMPANY_CODE = '" + Code + "'";
        }
        else if (CodeType == "Employee")
        {
            Code = Request.QueryString["Code"].ToString();
            flag = Request.QueryString["Flag"].ToString();
            if (flag == "1")
                Lblmsg.Text = "Following Employee Code has been Successfully Added";
            else
                Lblmsg.Text = "Following Employee Code has been Successfully Updated";

            sql = "SELECT 'Employee Code : ' + EMP_CODE + ' Successfully Mapped To : ' + COMPANY_LIST + ' And Default Company Is : ' + DEFAULT_COMPANY FROM WEBX_EMPLOYEE_COMPANY_MAPPING WHERE EMP_CODE = '" + Code + "'";
        }
        else if (CodeType == "Location")
        {
            Code = Request.QueryString["Code"].ToString();
            flag = Request.QueryString["Flag"].ToString();
            if (flag == "1")
                Lblmsg.Text = "Following Location Code has been Successfully Added";
            else
                Lblmsg.Text = "Following Location Code has been Successfully Updated";

            sql = "SELECT 'Location Code : ' + LOCCODE + ' Successfully Mapped To : ' + COMPANY_LIST + ' And Default Company Is : ' + DEFAULT_COMPANY FROM WEBX_LOCATION_COMPANY_MAPPING WHERE LOCCODE = '" + Code + "'";
        }

        lblCompanyCode.Text = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sql).ToString();
    }
}

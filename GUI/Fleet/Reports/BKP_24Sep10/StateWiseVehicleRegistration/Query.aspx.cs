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
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_StateWiseVehicleRegistration_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        cls_Vehicle_Wise.strVehNo = txtVehicleNo.Text;
        cls_Vehicle_Wise.strCompany = company.SelectedValue.ToString().Trim();
        Response.Redirect("Result.aspx");
    }
}

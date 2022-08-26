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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TripsheetQueryNew : System.Web.UI.Page
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
   
        if (!IsPostBack)
        {
            txtKmplFrom.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            txtKmplTo.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            txtKmRunFrom.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            txtKmRunTo.Attributes.Add("OnBlur", "javascript:checkNumeric();");
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        TextBox txtDriver = (TextBox)this.popUpDriver.FindControl("tb_TextBox");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        Cls_Report_VehiclogRes.strTRIPSHEET_FROM_DT = txtDateFrom.Text.ToString().Trim();
        Cls_Report_VehiclogRes.strTRIPSHEET_TO_DT = txtDateTo.Text.ToString().Trim();
        Cls_Report_VehiclogRes.strVEH_NO = txtVehicle.Text;
        Cls_Report_VehiclogRes.strDRIVER_NAME = txtDriver.Text;
        Cls_Report_VehiclogRes.strKM_RUN_FROM = txtKmRunFrom.Text;
        Cls_Report_VehiclogRes.strKM_RUN_TO = txtKmRunTo.Text;
        Cls_Report_VehiclogRes.strKMPL_FROM = txtKmplFrom.Text;
        Cls_Report_VehiclogRes.strKMPL_TO = txtKmplTo.Text;
        Cls_Report_VehiclogRes.strCompany = company.SelectedValue.ToString().Trim();

        //Response.Redirect("VehicleLogRegisterReport.aspx");
     }
}

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

public partial class GUI_Fleet_Reports_VehicleWiseKMPL : System.Web.UI.Page
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
            
        }
    }
    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //     Cls_VehicleWiseKMPL.strVEHNO = txtVehicle.Text;
    //     Cls_VehicleWiseKMPL.strVSLIP_FROMDT = txtDateFrom.Text.ToString().Trim();
    //     Cls_VehicleWiseKMPL.strVSLIP_TODT = txtDateTo.Text.ToString().Trim();
    //     Cls_VehicleWiseKMPL.strCompany = company.SelectedValue.ToString().Trim();
    //    Response.Redirect("VehicleWiseKMPLReport.aspx");
    //}
}

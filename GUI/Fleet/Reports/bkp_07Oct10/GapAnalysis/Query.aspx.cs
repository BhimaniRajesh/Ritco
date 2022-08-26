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

            //VehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            //chkSelectAllVehicle.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelectAllVehicle.ClientID.ToString() + "," + chklstVehNo.ClientID.ToString() + ");");
        }
    }
   
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
         cls_Report_TripGapAnalysis.strFROM_DT = txtDateFrom.Text.ToString().Trim();
         cls_Report_TripGapAnalysis.strTO_DT = txtDateTo.Text.ToString().Trim();
         cls_Report_TripGapAnalysis.strVEH_NO = txtVehicle.Text.Trim();
        cls_Report_TripGapAnalysis.strCompany = company.SelectedValue.ToString().Trim();
             
        //Response.Redirect("Result.aspx");
    }
}

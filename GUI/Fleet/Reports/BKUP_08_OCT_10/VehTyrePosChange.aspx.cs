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

public partial class GUI_Fleet_Reports_DieselCardList : System.Web.UI.Page
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
            //SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
            
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            //txtCardList.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnCard.ClientID.ToString() + "').focus();");
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
        }
    }
    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //   // string strConnStr = Session["SqlProvider"].ToString();
    //    //string[] arrConnStr = strConnStr.Split(';');
    //   // string[] arrSrv = arrConnStr[0].Split('=');
    //   // string[] arrDb = arrConnStr[1].Split('=');
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //    Cls_Report_VehTyrePosChange.strDt_From = txtDateFrom.Text.ToString().Trim();
    //    Cls_Report_VehTyrePosChange.strDt_To = txtDateTo.Text.ToString().Trim();
    //    Cls_Report_VehTyrePosChange.strVehPosNotChangeDay = txtDays.Text.ToString().Trim();
    //    Cls_Report_VehTyrePosChange.strVehNo = txtVehicleNo.Text.ToString().Trim();
    //    Cls_Report_VehTyrePosChange.strCompany = company.SelectedValue.ToString().Trim();

    //    //Response.Redirect("VehTyrePosChangeReport.aspx");
    //}


}

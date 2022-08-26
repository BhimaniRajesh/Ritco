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
            //SqlDataSource2.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            //txtCardList.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnCard.ClientID.ToString() + "').focus();");
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        TextBox txtCardList = (TextBox)this.popUpCard.FindControl("tb_TextBox");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
            Cls_Diesel_Card_Trans.strVSlipDt_From = txtDateFrom.Text.ToString().Trim();
            Cls_Diesel_Card_Trans.strVSlipDt_To = txtDateTo.Text.ToString().Trim();
            Cls_Diesel_Card_Trans.strVehNo = txtVehicle.Text.ToString().Trim();
            Cls_Diesel_Card_Trans.strCardNo = txtCardList.Text.ToString().Trim();
            Cls_Diesel_Card_Trans.strCompany = company.SelectedValue.ToString().Trim();


        Response.Redirect("DieselCardTranReport.aspx");


    }


}

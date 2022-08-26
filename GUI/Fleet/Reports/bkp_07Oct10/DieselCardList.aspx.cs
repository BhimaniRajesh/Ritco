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
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            //txtKmplFrom.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            //txtKmplTo.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            //SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //SqlDataSource2.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //txtCardValueFrom.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            //txtCardValueTo.Attributes.Add("OnBlur", "javascript:checkNumeric();");
            //txtCardList.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnCard.ClientID.ToString() + "').focus();");
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        TextBox txtCardList = (TextBox)this.popUpCard.FindControl("tb_TextBox");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        Cls_Diesel_Card_List.strCOMPANY = company.SelectedValue.ToString();
        Cls_Diesel_Card_List.strVEHNO = txtVehicle.Text.Trim();
        Cls_Diesel_Card_List.strCARDNO =  txtCardList.Text.Trim();
        Cls_Diesel_Card_List.strCARDVAL_FROM = txtCardValueFrom.Text.ToString().Trim();
        Cls_Diesel_Card_List.strCARDVAL_TO = txtCardValueTo.Text.ToString().Trim();
       
        Response.Redirect("DieselCardListReport.aspx");
    }


}

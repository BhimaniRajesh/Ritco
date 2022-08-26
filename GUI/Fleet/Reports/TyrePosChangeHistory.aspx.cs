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


public partial class TyrePosChangeHistory : System.Web.UI.Page
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
            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 21/5/2014
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            btnPopupTyre.Attributes.Add("OnClick", "window.open('../../../GUI/popups/GetTyreDetRepoTyrePosChangeHistory.aspx?tyreno=" + txtTyreNo.ClientID + "&tyresize=" + txtTyreSize.ClientID + "&tyrepat=" + txtTyrePattern.ClientID + "&tyremfg=" + txtManufacturer.ClientID + "&model="+txtModel.ClientID +"&type="+txtType.ClientID +"&tyreid=" + hfTyreId.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            txtTyreNo.Attributes.Add("OnBlur", "javascript:GetTyreDetails(" + txtTyreNo.ClientID.ToString() + "," + txtManufacturer.ClientID.ToString() + "," + txtModel.ClientID.ToString() + "," + txtTyreSize.ClientID.ToString() + "," + txtTyrePattern.ClientID.ToString() + "," + txtType.ClientID.ToString() + "," + hfTyreId.ClientID.ToString() + ");");

            //txtManufacturer.Attributes.Add("OnFocus", "javascript:document.getElementById('" + btnShow.ClientID.ToString() + "').focus();");
            //txtModel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + btnShow.ClientID.ToString() + "').focus();");
            //txtTyreSize.Attributes.Add("OnFocus", "javascript:document.getElementById('" + btnShow.ClientID.ToString() + "').focus();");
            //txtTyrePattern.Attributes.Add("OnFocus", "javascript:document.getElementById('" + btnShow.ClientID.ToString() + "').focus();");
            //txtType.Attributes.Add("OnFocus", "javascript:document.getElementById('" + btnShow.ClientID.ToString() + "').focus();");
        }
    }
    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //    Cls_TyrePosChangHistory.strTyreNo = hfTyreId.Value;
    //        Cls_TyrePosChangHistory.strPosHisDateFrom = txtDateFrom.Text.ToString().Trim();
    //        Cls_TyrePosChangHistory.strPosHisDateTo = txtDateTo.Text.ToString().Trim();
    //        Cls_TyrePosChangHistory.strCompany = company.SelectedValue.ToString().Trim();
    //    //Response.Redirect("TyrePosChangeHistoryReport.aspx");
    //}


}

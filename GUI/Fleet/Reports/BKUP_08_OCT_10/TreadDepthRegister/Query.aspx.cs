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
            //SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //SqlDataSource2.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            //txtTyreNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnTyreNo.ClientID.ToString() + "').focus();");
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
           
            
        }
    }
  
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        TextBox txtTyreNo = (TextBox)this.popUpTyreNo.FindControl("tb_TextBox");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");

        cls_Report_TreadDepth_Register.strFROM_DT = txtDateFrom.Text;
        cls_Report_TreadDepth_Register.strTO_DT = txtDateTo.Text;
        cls_Report_TreadDepth_Register.strVEH_NO = txtVehicle.Text;
        cls_Report_TreadDepth_Register.strTYRE_NO = txtTyreNo.Text;
        cls_Report_TreadDepth_Register.strTWI_FROM = txtTWIfrom.Text;
        cls_Report_TreadDepth_Register.strTWI_TO = txtTWIto.Text;
        cls_Report_TreadDepth_Register.strCompany = company.SelectedValue.ToString().Trim();

        //Response.Redirect("Result.aspx");
    }
    //public void BindDropDown(string strProc, string text, string value, DropDownList d)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    string STR = strProc;
    //    conn.Open();
    //    SqlCommand cmd = new SqlCommand(STR, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;
        
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
    //        }
    //    }
    //    dr.Close();
    //    conn.Close();
    //}
}

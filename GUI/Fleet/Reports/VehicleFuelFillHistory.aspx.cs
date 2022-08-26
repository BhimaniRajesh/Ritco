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

public partial class GUI_Fleet_Reports_VehicleFuelFillHistory : System.Web.UI.Page
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
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            BindDropDown("USP_VEHTYPE_ALL", "TYPE_NAME", ddlVehType);
        }
    }
    //protected void ddlVehType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    BindCheckBoxList("usp_vehno_typewise", "VEHNO", "VEH_INTERNAL_NO", chklstVehNo);
    //    txtVehNo.Text = "";
    //}
    public void BindCheckBoxList(string strProc, string text, string value, CheckBoxList c)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@veh_type", SqlDbType.VarChar, 100).Value = ddlVehType.SelectedValue;  
        SqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                c.Items.Add(new ListItem(Convert.ToString(dr1[text]), Convert.ToString(dr1[value])));
            }
        }
        dr1.Close();
        conn.Close();
    }
    public void BindDropDown(string strProc, string text, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text])));
            }
        }
        dr.Close();
        conn.Close();
    }
    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //    Cls_Report_VehFuelFillHistory.strTYPE_NAME = ddlVehType.SelectedItem.Text.ToString().Trim();
    //    Cls_Report_VehFuelFillHistory.strVEHNO = txtVehicle.Text.ToString().Trim();
    //    Cls_Report_VehFuelFillHistory.strFROMDT = txtDateFrom.Text.ToString().Trim();
    //    Cls_Report_VehFuelFillHistory.strTODT = txtDateTo.Text.ToString().Trim();
    //    Cls_Report_VehFuelFillHistory.strCompany = company.SelectedValue.ToString().Trim();

    //    //Response.Redirect("VehicleFuelFillHistoryReport.aspx");
    //}
   
}

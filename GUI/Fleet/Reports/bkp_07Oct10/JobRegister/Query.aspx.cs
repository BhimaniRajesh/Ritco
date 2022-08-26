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
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            BindDropDown("usp_job_card_type_all", "CodeDesc", "CodeId", ddlJobCardType);
            BindDropDown("usp_locations_all", "LOCNAME", "LOCCODE", ddlLocation);
            BindDropDown("usp_vendor_all", "VENDORNAME", "VENDORCODE", ddlVendor);
            BindDropDown("USP_JOBORDER_STATUS", "ORDER_STATUS", "ORDER_STATUS", ddlStatus);
            
            FillServiceCenter();
        }
    }
    public void FillServiceCenter()
    {
        ddlSeviceCenterType.Items.Add(new ListItem("Select", "0"));
        ddlSeviceCenterType.Items.Add(new ListItem("Workshop", "1"));
        ddlSeviceCenterType.Items.Add(new ListItem("Vendor", "2")); 

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        cls_Report_JobsheeetRegister.strFROM_DT = txtDateFrom.Text;
        cls_Report_JobsheeetRegister.strTO_DT = txtDateTo.Text;
        cls_Report_JobsheeetRegister.strVEH_NO = txtVehicle.Text;
        cls_Report_JobsheeetRegister.strJOB_CARD_TYPE = ddlJobCardType.SelectedItem.Text.ToString();
        cls_Report_JobsheeetRegister.strSERV_CENTER_TYPE = ddlSeviceCenterType.SelectedItem.Text.ToString();
        cls_Report_JobsheeetRegister.strWorkshop_Loc = ddlLocation.SelectedItem.Text.ToString();
        cls_Report_JobsheeetRegister.strWorkshop_Vendor= ddlVendor.SelectedItem.Text.ToString();
        cls_Report_JobsheeetRegister.strJOB_STATUS = ddlStatus.SelectedItem.Text.ToString();
        cls_Report_JobsheeetRegister.strCompany = company.SelectedValue.ToString().Trim();
        Response.Redirect("Result.aspx");
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
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
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }


    protected void ddlSeviceCenterType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSeviceCenterType.SelectedValue == "1")
        {
            Label2.Text = "Select Location :";
            ddlLocation.Visible = true;
            ddlVendor.Visible = false;
        }
        else if (ddlSeviceCenterType.SelectedValue == "2")
        {
            Label2.Text = "Select Vendor :";
            ddlLocation.Visible = false;
            ddlVendor.Visible = true;
        }
        UpdatePanel2.Update();
        UpdatePanel3.Update();
    }
}

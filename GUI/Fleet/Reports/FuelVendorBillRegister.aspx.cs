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

public partial class GUI_Fleet_Reports_VehWiseKMPL : System.Web.UI.Page
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
            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 20/5/2014
            rbDate.Checked = true;
            BindDropDownDocument();
            txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            BindDropDown("USP_VENDORNAME", "VENDORNAME", "VENDORCODE", ddlVendorType);
        }
    }
    public void BindDropDownDocument()
    {
        ddlDocument.Items.Clear();
        ddlDocument.Items.Add(new ListItem("Select", "0"));
        ddlDocument.Items.Add(new ListItem("Bill Entry Number", "1"));
        ddlDocument.Items.Add(new ListItem("Manual Bill Number", "2"));
        ddlDocument.Items.Add(new ListItem("Vehicle Number", "3"));
    }
    protected void ddlVehType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //BindCheckBoxList("usp_vehno_typewise", "VEHNO", "VEH_INTERNAL_NO", chklstVehNo);
        //txtVehNo.Text = "";
    }
    public void BindCheckBoxList(string strProc, string text, string value, CheckBoxList c,string strParam)
    {
        c.Items.Clear(); 
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@doc_type", SqlDbType.VarChar, 100).Value = strParam;  
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
    


    protected void ddlDocument_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtVehNo.Text = "";
        if (ddlDocument.SelectedValue == "0")
        {
            lblDocument.Text = "";
            BindCheckBoxList("usp_docWise_fill", "", "", chklstVehNo, "");
        }
        if (ddlDocument.SelectedValue  == "1")
        {
            lblDocument.Text = "Bill Entry Number:";
            BindCheckBoxList("usp_docWise_fill", "BILLNO", "BILLNO", chklstVehNo,"Bill Entry Number"); 
        }
        else if (ddlDocument.SelectedValue == "2")
        {
            lblDocument.Text = "Manual Bill Number:";
            BindCheckBoxList("usp_docWise_fill", "VENDORBILLNO", "VENDORBILLNO", chklstVehNo, "Manual Bill Number"); 
        }
        else if (ddlDocument.SelectedValue == "3")
        {
            lblDocument.Text = "Vehicle Number:";
            BindCheckBoxList("usp_docWise_fill", "VEHNO", "VEH_INTERNAL_NO", chklstVehNo,"Vehicle Number"); 
        }
        UpdatePanel3.Update();
        UpdatePanel4.Update();
        UpdatePanel6.Update();
    }
    protected void btnShow_Click(object sender, EventArgs e)
     {
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        cls_FuelVendorBillRegister.strCompany = company.SelectedValue.ToString().Trim();
       // cls_FuelVendorBillRegister.strhdn  = hdnRptId.Value.ToString();
        if (ddlVendorType.Items.Count != 0)
        {
            cls_FuelVendorBillRegister.strVENDORNAME = Convert.ToString(ddlVendorType.SelectedItem.Text);
        }
        else
        {
            cls_FuelVendorBillRegister.strVENDORNAME = "All";
        }
        if (rbDate.Checked == true)
        {
            cls_FuelVendorBillRegister.strFROMDT = Convert.ToString(txtDateFrom.Text).Trim();
            cls_FuelVendorBillRegister.strTODT = Convert.ToString(txtDateTo.Text).Trim();
        }
        else if (rbLastWeek.Checked == true)
        {
            cls_FuelVendorBillRegister.strFROMDT = "DATEADD(day, DATEDIFF(day, 0, GETDATE()), - 7)";
            cls_FuelVendorBillRegister.strTODT = "GETDATE()";
            
        }
        else if (rbToday.Checked == true)
        {
            cls_FuelVendorBillRegister.strFROMDT = "GETDATE()";
            cls_FuelVendorBillRegister.strTODT = "GETDATE()";
        }
        if (ddlDocument.SelectedValue == "0")
        {
            cls_FuelVendorBillRegister.strDOCU_TYPE = "";
            cls_FuelVendorBillRegister.strTMP = "";
        }
        if (ddlDocument.SelectedValue == "1")
        {
            cls_FuelVendorBillRegister.strDOCU_TYPE = "BILLNO";
            cls_FuelVendorBillRegister.strTMP = txtVehNo.Text.ToString().Trim();
        }
        else if (ddlDocument.SelectedValue == "2")
        {
            cls_FuelVendorBillRegister.strDOCU_TYPE = "VENDORBILLNO";
            cls_FuelVendorBillRegister.strTMP = txtVehNo.Text.ToString().Trim();
        }
        else if (ddlDocument.SelectedValue == "3")
        {
            cls_FuelVendorBillRegister.strDOCU_TYPE = "VEHICLENO";
            cls_FuelVendorBillRegister.strTMP = txtVehNo.Text.ToString().Trim();
        }
       // Response.Redirect("FuelVendorBillRegisterResult.aspx");

       
    }
}

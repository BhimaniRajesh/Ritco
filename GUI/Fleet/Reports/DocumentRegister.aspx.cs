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

public partial class GUI_Fleet_Reports_TyreRegister : System.Web.UI.Page
{
    static string strjscript = "";
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

            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/Fleet/Document/Popup/VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&VehType=" + hfVehType.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + hfKm.ClientID.ToString() + "&vehcat=" + hfVehcate.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            //txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo(" + txtVehNo.ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + hfKm.ClientID.ToString() + "," + hfVehType.ClientID.ToString() + ");");
            BindDropDown("USP_DOCUTYPE_LIST_All", "DOCU_TYPE", "DOCU_TYPE_ID", ddlDocumentType);
            BindDropDown("USP_RENEWAUCODE_All", "CodeDesc", "CodeId", ddlRenewAutu);
            chkSelAllRepoColumn.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllRepoColumn.ClientID.ToString() + "," + chkRepoColumns.ClientID.ToString() + ");");
            
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (strProc == "USP_RENEWAUCODE_All")
        {
            cmd.Parameters.Add("@DOC_TYPE", SqlDbType.Int).Value = Convert.ToInt32(ddlDocumentType.SelectedValue);
        }
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
    protected void ddlDocumentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlRenewAutu.Items.Clear();
        BindDropDown("USP_RENEWAUCODE_All", "CodeDesc", "CodeId", ddlRenewAutu);
    }
    protected void rblExpiryDateRange_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblExpiryDateRange.SelectedValue == "1")
        {
            txtDateFrom.Visible = true;
        }
        else
        {
            txtDateFrom.Visible = false;
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {

        //for show/hide column
  
        if (chkRepoColumns.Items[0].Selected == true){ cls_DocumentRegisterVariable.strVehicleNumber = "VehicleNumber"; }
        if (chkRepoColumns.Items[1].Selected == true) { cls_DocumentRegisterVariable.strVehicleType = "VehicleType"; }
        if (chkRepoColumns.Items[2].Selected == true) { cls_DocumentRegisterVariable.strDocumentType = "DocumentType"; }
        if (chkRepoColumns.Items[3].Selected == true) { cls_DocumentRegisterVariable.strDocumentDescription = "DocumentDescription"; }
        if (chkRepoColumns.Items[4].Selected == true) { cls_DocumentRegisterVariable.strDocumentNumber = "DocumentNumber"; }
        if (chkRepoColumns.Items[5].Selected == true) { cls_DocumentRegisterVariable.strRenewalAuturity = "RenewalAuturity"; }
        if (chkRepoColumns.Items[6].Selected == true) { cls_DocumentRegisterVariable.strRenewalAuturityName = "RenewalAuturityName"; }
        if (chkRepoColumns.Items[7].Selected == true) { cls_DocumentRegisterVariable.strStartDate = "StartDate"; }
        if (chkRepoColumns.Items[8].Selected == true) { cls_DocumentRegisterVariable.strExpiryDate = "ExpiryDate"; }
        if (chkRepoColumns.Items[9].Selected == true) { cls_DocumentRegisterVariable.strCost = "Cost"; }
        if (chkRepoColumns.Items[10].Selected == true) { cls_DocumentRegisterVariable.strStates = "States"; }
        if (chkRepoColumns.Items[11].Selected == true) { cls_DocumentRegisterVariable.strScannedDocument = "ScannedDocument"; }
       
        //for search criteria

        cls_DocumentRegisterVariable.strVEHNO = txtVehNo.Text;

        cls_DocumentRegisterVariable.strDOC_TYPE = ddlDocumentType.SelectedItem.Text.ToString();
        cls_DocumentRegisterVariable.strRENEW_AUTH = ddlRenewAutu.SelectedItem.Text.ToString();
        if (ddlStatus.SelectedValue == "Already Expired")
        {
            cls_DocumentRegisterVariable.strEXP_STATUS = "ALREADY_EXPIRE";
        }
        else if (ddlStatus.SelectedValue == "Yet to Expire")
        {
            cls_DocumentRegisterVariable.strEXP_STATUS = "YET_TO_EXPIRE";
        }
        else
        {
            cls_DocumentRegisterVariable.strEXP_STATUS = "";
        }
        if (rblExpiryDateRange.SelectedValue == "0")
        {
            cls_DocumentRegisterVariable.strEXP_DT = "NEXT_7_DAYS";
        }
        else if (rblExpiryDateRange.SelectedValue == "1")
        {
            cls_DocumentRegisterVariable.strEXP_DT = "SPECIFY_T0_DT";
            //cls_DocumentRegisterVariable.strExDt = txtDateFrom.Text.ToString();  
        }
        else
        {
            cls_DocumentRegisterVariable.strEXP_DT = "";
        }
        cls_DocumentRegisterVariable.strOP_FORMAT = "0";

       // Response.Redirect("DocumentRegisterRes.aspx"); 
    }
   



    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlStatus.SelectedIndex == 1)
        {
            rowN.Visible = false;
        }
        else
        {
            rowN.Visible = true;
        }
    }
}

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


public partial class GUI_Fleet_Reports_TyreRegister : System.Web.UI.Page
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
            //sqldsMFG.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //sqldsSize.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //sqldsPattern.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //sqldsType.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //sqldsTyre.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //sqldsModel.ConnectionString = Session["SqlProvider"].ToString().Trim();

            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            BindDropDown("USP_TYRESTAUS", "TYRE_STATUS", "TYRE_STATUS", ddlTyreStatus);
            chkSelAllTyreSummary.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllTyreSummary.ClientID.ToString() + "," + chkTyreSummary.ClientID.ToString() + ");");
            chkSelAllTreadDepth.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllTreadDepth.ClientID.ToString() + "," + chkTreadDepthDet.ClientID.ToString() + ");");
            ckhSelAllVehDet.Attributes.Add("OnClick", "javascript:SelectAll(" + ckhSelAllVehDet.ClientID.ToString() + "," + chkVehDetails.ClientID.ToString() + ");");
            chkSelAllRemould.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllRemould.ClientID.ToString() + "," + chkRemouldDet.ClientID.ToString() + ");");
            chkSelAllCost.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllCost.ClientID.ToString() + "," + chkCostingDet.ClientID.ToString() + ");");

            //txtCateList.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnCate.ClientID.ToString() + "').focus();");
            //txtMFG.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnManufacturer.ClientID.ToString() + "').focus();");
            //txtModel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnModel.ClientID.ToString() + "').focus();");
            //txtSize.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSize.ClientID.ToString() + "').focus();");
            //txtPattern.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnPattern.ClientID.ToString() + "').focus();");
            //txtType.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnType.ClientID.ToString() + "').focus();");
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            //txtTyre.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnTyre.ClientID.ToString() + "').focus();");

            chkSelAllTreadDepth.Enabled = false;
            chkTreadDepthDet.Enabled = false;
            chkSelAllRemould.Enabled = false;
            chkRemouldDet.Enabled = false; 

        }
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
   
    protected void btnShow_Click(object sender, EventArgs e)
    {
        DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        TextBox txtTyreMfg = (TextBox)this.popUpTyreMfg.FindControl("tb_TextBox");
        TextBox txtTyreCat = (TextBox)this.popUpTyreCat.FindControl("tb_TextBox");
        TextBox txtTyreModelNo = (TextBox)this.popUpTyreModelNo.FindControl("tb_TextBox");
        TextBox txtTyreSize = (TextBox)this.popUpTyreSize.FindControl("tb_TextBox");
        TextBox txtTyrePattern = (TextBox)this.popUpTyrePattern.FindControl("tb_TextBox");
        TextBox txtTyreType = (TextBox)this.popUpTyreType.FindControl("tb_TextBox");
        TextBox txtTyreNo = (TextBox)this.popUpTyreNo.FindControl("tb_TextBox");
        Cls_Report_TyreRegister.strCompany = company.SelectedValue.ToString().Trim();
        //for show/hide column
        string strTyreNumber = "", strTyrecategory = "", strManufacturer = "", strModel = "", strSize = "", strPattern = "", strType = "", strPurchaseDate = "", strPurchasedAs = "", strPurchaseKm = "", strPurchaseCost = "", strStatus = "";
        string strVehicleNumber = "",strPositionCategory="",strPositionCode="",strPosition="";
        string strKmCount = "", strTOTALCOST = "", strCOSTKM="";
  
        if (chkTyreSummary.Items[0].Selected == true){ strTyreNumber = "TyreNumber"; }
        if (chkTyreSummary.Items[1].Selected == true) {strTyrecategory = "Tyrecategory";}
        if (chkTyreSummary.Items[2].Selected == true) { strManufacturer = "Manufacturer"; }
        if (chkTyreSummary.Items[3].Selected == true) { strModel = "Model"; }
        if (chkTyreSummary.Items[4].Selected == true) { strSize = "Size"; }
        if (chkTyreSummary.Items[5].Selected == true) { strPattern = "Pattern"; }
        if (chkTyreSummary.Items[6].Selected == true) { strType = "Type"; }
        if (chkTyreSummary.Items[7].Selected == true) { strPurchaseDate = "PurchaseDate"; }
        if (chkTyreSummary.Items[8].Selected == true) { strPurchasedAs = "PurchasedAs"; }
        if (chkTyreSummary.Items[9].Selected == true) { strPurchaseKm = "PurchaseKm"; }
        if (chkTyreSummary.Items[10].Selected == true) { strPurchaseCost = "PurchaseCost"; }
        if (chkTyreSummary.Items[11].Selected == true) { strStatus = "Status"; }

        if (chkVehDetails.Items[0].Selected == true) { strVehicleNumber = "VehicleNumber"; }
        if (chkVehDetails.Items[1].Selected == true) { strPositionCategory = "PositionCategory"; }
        if (chkVehDetails.Items[2].Selected == true) { strPositionCode = "PositionCode"; }
        if (chkVehDetails.Items[3].Selected == true) { strPosition = "Position"; }

        if (chkCostingDet.Items[0].Selected == true) { strKmCount = "KmCount"; }
        if (chkCostingDet.Items[1].Selected == true) { strTOTALCOST = "TOTALCOST"; }
        if (chkCostingDet.Items[2].Selected == true) { strCOSTKM = "COSTKM"; }
        //for search criteria

        Response.Redirect("TyreRegister_Report.aspx");
    }
}

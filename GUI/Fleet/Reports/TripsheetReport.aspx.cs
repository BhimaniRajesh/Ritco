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

public partial class GUI_Fleet_Reports_Tripsheet : System.Web.UI.Page
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
            //BindDropDown("USP_TYRESTAUS", "TYRE_STATUS", "TYRE_STATUS", ddlTyreStatus);
            //chkSelAllTyreSummary.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllTyreSummary.ClientID.ToString() + "," + chkTyreSummary.ClientID.ToString() + ");");
            //chkSelAllTreadDepth.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllTreadDepth.ClientID.ToString() + "," + chkTreadDepthDet.ClientID.ToString() + ");");
            //ckhSelAllVehDet.Attributes.Add("OnClick", "javascript:SelectAll(" + ckhSelAllVehDet.ClientID.ToString() + "," + chkVehDetails.ClientID.ToString() + ");");
            //chkSelAllRemould.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllRemould.ClientID.ToString() + "," + chkRemouldDet.ClientID.ToString() + ");");
            //chkSelAllCost.Attributes.Add("OnClick", "javascript:SelectAll(" + chkSelAllCost.ClientID.ToString() + "," + chkCostingDet.ClientID.ToString() + ");");

            //txtCateList.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnCate.ClientID.ToString() + "').focus();");
            //txtMFG.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnManufacturer.ClientID.ToString() + "').focus();");
            //txtModel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnModel.ClientID.ToString() + "').focus();");
            //txtSize.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSize.ClientID.ToString() + "').focus();");
            //txtPattern.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnPattern.ClientID.ToString() + "').focus();");
            //txtType.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnType.ClientID.ToString() + "').focus();");
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            //txtTyre.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnTyre.ClientID.ToString() + "').focus();");

            //chkSelAllTreadDepth.Enabled = false;
            //chkTreadDepthDet.Enabled = false;
            //chkSelAllRemould.Enabled = false;
            //chkRemouldDet.Enabled = false; 

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
   
    //protected override void CreateChildControls()
    //{
    //    base.CreateChildControls();
    //    DropDownList ddl = new DropDownList();
    //    ListItem li = new ListItem("");
    //    ddl.Items.Add(li);
    //    ddl.Width = new Unit(100);
    //    ddl.Attributes.Add("onmousedown", "showdiv()");
    //    ddl.Attributes.Add("onclick", "showdiv()");
    //    ddl.Attributes.Add("ondragover", "hidediv()");
    //    ddl.Attributes.Add("onmouseout", "hidediv()");

    //    cbl.Items.Add(li1);
    //    cbl.Items.Add(li2);
    //    cbl.Items.Add(li3);

    //    System.Web.UI.HtmlControls.HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
    //    div.ID = "serverdiv";
    //    div.Controls.Add(cbl);
    //    div.Style.Add("BORDER-RIGHT", "black 1px solid");
    //    div.Style.Add("BORDER-TOP", "black 1px solid");
    //    div.Style.Add("BORDER-LEFT", "black 1px solid");
    //    div.Style.Add("BORDER-BOTTOM", "black 1px solid");
    //    div.Style.Add("VISIBILITY", "hidden");

    //    //this.Controls.Add(ddl);
    //    //this.Controls.Add(div);
    //}

    protected void btnShow_Click(object sender, EventArgs e)
    {

        ////for show/hide column
        //string strTyreNumber = "", strTyrecategory = "", strManufacturer = "", strModel = "", strSize = "", strPattern = "", strType = "", strPurchaseDate = "", strPurchasedAs = "", strPurchaseKm = "", strPurchaseCost = "", strStatus = "";
        //string strVehicleNumber = "",strPositionCategory="",strPositionCode="",strPosition="";
        //string strKmCount = "", strTOTALCOST = "", strCOSTKM="";
  
        //if (chkTyreSummary.Items[0].Selected == true){ strTyreNumber = "TyreNumber"; }
        //if (chkTyreSummary.Items[1].Selected == true) {strTyrecategory = "Tyrecategory";}
        //if (chkTyreSummary.Items[2].Selected == true) { strManufacturer = "Manufacturer"; }
        //if (chkTyreSummary.Items[3].Selected == true) { strModel = "Model"; }
        //if (chkTyreSummary.Items[4].Selected == true) { strSize = "Size"; }
        //if (chkTyreSummary.Items[5].Selected == true) { strPattern = "Pattern"; }
        //if (chkTyreSummary.Items[6].Selected == true) { strType = "Type"; }
        //if (chkTyreSummary.Items[7].Selected == true) { strPurchaseDate = "PurchaseDate"; }
        //if (chkTyreSummary.Items[8].Selected == true) { strPurchasedAs = "PurchasedAs"; }
        //if (chkTyreSummary.Items[9].Selected == true) { strPurchaseKm = "PurchaseKm"; }
        //if (chkTyreSummary.Items[10].Selected == true) { strPurchaseCost = "PurchaseCost"; }
        //if (chkTyreSummary.Items[11].Selected == true) { strStatus = "Status"; }

        //if (chkVehDetails.Items[0].Selected == true) { strVehicleNumber = "VehicleNumber"; }
        //if (chkVehDetails.Items[1].Selected == true) { strPositionCategory = "PositionCategory"; }
        //if (chkVehDetails.Items[2].Selected == true) { strPositionCode = "PositionCode"; }
        //if (chkVehDetails.Items[3].Selected == true) { strPosition = "Position"; }

        //if (chkCostingDet.Items[0].Selected == true) { strKmCount = "KmCount"; }
        //if (chkCostingDet.Items[1].Selected == true) { strTOTALCOST = "TOTALCOST"; }
        //if (chkCostingDet.Items[2].Selected == true) { strCOSTKM = "COSTKM"; }
        ////for search criteria

             
        //ReportViewer1.Visible = true;


        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

        ////ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        //ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ////ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

        //ReportViewer1.ServerReport.ReportPath = "/Report Project1/TyreRegister";
        //ReportParameter[] parameters = new ReportParameter[34];
        ////for show/hide columns
        //parameters[0] = new ReportParameter("TyreNumber", strTyreNumber.ToString().Trim());
        //parameters[1] = new ReportParameter("Tyrecategory", strTyrecategory.ToString().Trim());
        //parameters[2] = new ReportParameter("Manufacturer", strManufacturer.ToString().Trim());
        //parameters[3] = new ReportParameter("Model", strModel.ToString().Trim());
        //parameters[4] = new ReportParameter("Size", strSize.ToString().Trim());
        //parameters[5] = new ReportParameter("Pattern", strPattern.ToString().Trim());
        //parameters[6] = new ReportParameter("Type", strType.ToString().Trim());
        //parameters[7] = new ReportParameter("PurchaseDate", strPurchaseDate.ToString().Trim());
        //parameters[8] = new ReportParameter("PurchasedAs", strPurchasedAs.ToString().Trim());
        //parameters[9] = new ReportParameter("PurchaseKm", strPurchaseKm.ToString().Trim());
        //parameters[10] = new ReportParameter("PurchaseCost", strPurchaseCost.ToString().Trim());
        //parameters[11] = new ReportParameter("Status", strStatus.ToString().Trim());
        //parameters[12] = new ReportParameter("VehicleNumber", strVehicleNumber.ToString().Trim());
        //parameters[13] = new ReportParameter("PositionCategory", strPositionCategory.ToString().Trim());
        //parameters[14] = new ReportParameter("PositionCode", strPositionCode.ToString().Trim());
        //parameters[15] = new ReportParameter("Position", strPosition.ToString().Trim());
        //parameters[16] = new ReportParameter("KmCount", strKmCount.ToString().Trim());
        //parameters[17] = new ReportParameter("TOTALCOST", strTOTALCOST.ToString().Trim());
        //parameters[18] = new ReportParameter("COSTKM", strCOSTKM.ToString().Trim());
        ////for search criteria
        //parameters[19] = new ReportParameter("PUR_DT_FROM", txtDateFrom.Text.ToString().Trim());
        //parameters[20] = new ReportParameter("PUR_DT_TO", txtDateTo.Text.ToString().Trim());
        //parameters[21] = new ReportParameter("TYRE_CATEGORY", txtCateList.Text.ToString().Trim());
        //parameters[22] = new ReportParameter("TYRE_MFG", txtMFG.Text.ToString().Trim());
        //parameters[23] = new ReportParameter("TYRE_MODEL", txtModel.Text.ToString().Trim());
        //parameters[24] = new ReportParameter("TYRE_SIZE", txtSize.Text.ToString().Trim());
        //parameters[25] = new ReportParameter("TYRE_PATTERN", txtPattern.Text.ToString().Trim());
        //parameters[26] = new ReportParameter("TYRE_TYPE", txtType.Text.ToString().Trim());
        //parameters[27] = new ReportParameter("NSD_FROM", txtNSDRangeF.Text.ToString().Trim());
        //parameters[28] = new ReportParameter("NSD_TO", txtNSDTo.Text.ToString().Trim());
        //parameters[29] = new ReportParameter("KMRUN_FROM", txtKMF.Text.ToString().Trim());
        //parameters[30] = new ReportParameter("KMRUN_TO", txtKMT.Text.ToString().Trim());
        //parameters[31] = new ReportParameter("TYRE_STATUS", ddlTyreStatus.SelectedValue.ToString().Trim());
        //parameters[32] = new ReportParameter("VEH_NO", txtVehNo.Text.ToString().Trim());
        //parameters[33] = new ReportParameter("TYRE_NO", txtTyre.Text.ToString().Trim());

        //ReportViewer1.ServerReport.SetParameters(parameters);
        //ReportViewer1.ServerReport.Refresh();
        //UpdatePanel1.Update();
    }




    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {

    }
    protected void RetrieveDriverDataInfo1(object sender, EventArgs e)
    {

    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Microsoft.ApplicationBlocks.Data;

public partial class MasterPage3 : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        lblEmployee.Text = Session["empcd"].ToString().Trim();
        lblEmpNameVal.Text = Session["empnm"].ToString().Trim();

        string str = "";

        //XmlTextWriter xmlw = new XmlTextWriter("XMLFile2.xml", System.Text.Encoding.UTF8);
        //xmlw.WriteString(str);

        //str = "<?xml version='1.0' encoding='utf-8' ?>";
        //str = str + "<Home>";
        //str = str + "<SubMenu text='Manage Menus' url='~/GUI/admin/ManageMenus.aspx'></SubMenu>";

        //str = str + "<SubMenu text='Manage Rules' url='~/GUI/Admin/ManageRules.aspx'>";
        //str = str + "<SubMenu text='Process Choice' url='~/GUI/admin/rules/WebXpressRules_Step3.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Document Nomenclature Settings' url='~/GUI/admin/rules/WebXpressRules_Step4.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Delivery Process Setting' url='~/GUI/admin/Rules/SetDelyProc.aspx'></SubMenu>";

        //str = str + "<SubMenu text='Billing Settings' url=''>";
        //str = str + "<SubMenu text='Accounting' url='~/GUI/admin/Accounting_RuleMst/Billing_Accounting.aspx'></SubMenu>";
        //str = str + "<SubMenu text='General' url='~/GUI/admin/Accounting_RuleMst/Billing_General_Rule.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Charges Master' url='~/GUI/admin/ChargeMAster/BillChargeMaster.aspx'></SubMenu>";
        //str = str + "</SubMenu>";

        //str = str + "<SubMenu text='"+ SessionUtilities.DocketCalledAs.ToString() +" Entry Accounting' url='~/GUI/admin/Accounting_RuleMst/Docket_Entry_Accounting.aspx'></SubMenu>";
        //str = str + "<SubMenu text='" + SessionUtilities.DocketCalledAs.ToString() + "/Contract Charge' url='~/GUI/admin/ChargeMaster/SuperSetCharge.aspx?chargetype=DKT'></SubMenu>";
        //str = str + "<SubMenu text='" + SessionUtilities.DocketCalledAs.ToString() + " Entry Settings' url='~/GUI/admin/DocketCustomization/DocketEntrySettingsList.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Set Balance Sheet Category' url='~/GUI/admin/BLanceSheet_Category.aspx'></SubMenu>";
        //str = str + "<SubMenu text='DFM Rules' url='~/GUI/admin/rules/Rules_DFM.aspx'></SubMenu>";
        //str = str + "<SubMenu text='General Master' url='~/GUI/admin/GeneralMaster/SA/MasterList.aspx?accesscode=S'></SubMenu>";
        //str = str + "<SubMenu text='Master Rules' url='~/GUI/admin/MasterRules/SetMasterRule.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Business Type Wise Mode of Service Master' url='~/GUI/admin/BusinessTypeWiseModeMaster/BusinessTypeWiseMode.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Manual Vouchers Rules' url='~/GUI/admin/ManualVoucherRules/ManualVouchersRules.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Account/Group Master Rules' url='~/GUI/admin/AccountMasterRules/AccountingRules.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Octroi Service Tax Rule Master' url='~/GUI/admin/Octroi Rule/STax Rule/STax_Rule.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Service Tax Rate And Rebate Settings' url='~/GUI/admin/TaxRebate/TaxRebate_Criteria.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Docket Notification Rule' url='~/GUI/admin/Rules/Dktnotification.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Back Date Control' url='~/GUI/admin/BackDateControl/Back_Date_Control.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Cost Center Master' url='~/GUI/admin/CostCenterMaster/CostIdMaster.aspx'></SubMenu>";
        //str = str + "<SubMenu text='LS/MF Rules' url='~/GUI/admin/LS_MF_RULE/Set_LS_MF_RULE.aspx'></SubMenu>";
        //str = str + "<SubMenu text='DCR Management' url='~/GUI/admin/DocumentsNameForDCR/DocumentNameForDCR_Entry.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Add General Master Member' url='~/GUI/admin/GeneralMaster/AddGeneralMasterMember.aspx'></SubMenu>";
        //str = str + "<SubMenu text='Add RDL for AutoEmail' url='~/GUI/admin/AutoEmail_Setting.aspx'></SubMenu>";
        //str = str + "</SubMenu>";
        //str = str + "</Home>";



        //str = "<?xml version='1.0' encoding='utf-8' ?>";
        str = str + "<Home>";

       // str = str + "<SubMenu text='Document Control' url=''>";

       // str = str + "<SubMenu text='Document Nomenclature' url=''></SubMenu>";
       // //str = str + "<SubMenu text='Length' url=''></SubMenu>";
       // str = str + "<SubMenu text='DCR rules' url='~/GUI/admin/rules/Rules_DFM.aspx'></SubMenu>";
       // str = str + "<SubMenu text='Business Type wise mode of service' url='~/GUI/admin/BusinessTypeWiseModeMaster/BusinessTypeWiseMode.aspx'></SubMenu>";

       // str = str + "</SubMenu>";


       // str = str + "<SubMenu text='Operations Rules' url=''>";

       //     str = str + "<SubMenu text='Process Choice' url=''></SubMenu>";
       //             str = str + "<SubMenu text='CN rules' url=''>";
       //             str = str + "<SubMenu text='CN Entry Settings' url='~/GUI/admin/Accounting_RuleMst/Docket_Entry_Accounting.aspx'></SubMenu>";
       //             str = str + "<SubMenu text='CN Contract/Charges' url='~/GUI/admin/ChargeMaster/SuperSetCharge.aspx?chargetype=DKT'></SubMenu>";
       //             str = str + "<SubMenu text='CN Entry accounting' url='~/GUI/admin/DocketCustomization/DocketEntrySettingsList.aspx'></SubMenu>";
       //             str = str + "<SubMenu text='CN Notification Rules' url=''></SubMenu>";
       //             str = str + "</SubMenu>";
       //             str = str + "<SubMenu text='LS/MF rules' url='~/GUI/admin/LS_MF_RULE/Set_LS_MF_RULE.aspx'></SubMenu>";
       //     str = str + "<SubMenu text='DRS Rules' url='~/GUI/admin/DRS_Rules/Set_DRS_RULE.aspx'></SubMenu>";
       //     str = str + "<SubMenu text='PRS Rules' url='~/GUI/admin/PRS_Rules/Set_PRS_RULE.aspx'></SubMenu>";
       //     str = str + "<SubMenu text='THC Rules' url='~/GUI/admin/THC_Rules/Set_THC_RULE.aspx'></SubMenu>";
       //     str = str + "<SubMenu text='Departure Rules' url='~/GUI/admin/Departure_Rules/Set_Departure_RULE.aspx'></SubMenu>";
       //     str = str + "<SubMenu text='Arrival and delivery rules' url=''></SubMenu>";
       //     str = str + "<SubMenu text='DFM rules' url='~/GUI/admin/rules/Rules_DFM.aspx'></SubMenu>";
       // str = str + "</SubMenu>";


       // str = str + "<SubMenu text='Finance Rules' url=''>";

       // str = str + "<SubMenu text='Billing Settings' url=''>";
       // str = str + "<SubMenu text='Accounting' url='~/GUI/admin/Accounting_RuleMst/Billing_Accounting.aspx'></SubMenu>";
       // str = str + "<SubMenu text='General' url='~/GUI/admin/Accounting_RuleMst/Billing_General_Rule.aspx'></SubMenu>";
       // str = str + "<SubMenu text='Bill Charges' url='/GUI/admin/ChargeMAster/BillChargeMaster.aspx'></SubMenu>";
       // str = str + "</SubMenu>";
       // str = str + "<SubMenu text='Octroi Service Tax Rule' url='~/GUI/admin/Octroi Rule/STax Rule/STax_Rule.aspx'></SubMenu>";
       // str = str + "</SubMenu>";


       // str = str + "<SubMenu text='Accounts rules' url=''>";

       // str = str + "<SubMenu text='Set Balance Sheet Category' url='~/GUI/admin/BLanceSheet_Category.aspx'></SubMenu>";
       // str = str + "<SubMenu text='Manual Voucher Rules' url=''></SubMenu>";
       // str = str + "<SubMenu text='Account/Group Master Rules' url='~/GUI/admin/AccountMasterRules/AccountingRules.aspx'></SubMenu>";
       //str = str + "<SubMenu text='Service Tax Rate and Rebate Settings' url=''></SubMenu>";
       // str = str + "<SubMenu text='Manual Voucher Back date control' url=''></SubMenu>";
       // str = str + "<SubMenu text='Cost Center Type Master' url=''></SubMenu>";
        
        
        
       // //str = str + "<SubMenu text='Service Tax Rate & Rebate Settings' url=''></SubMenu>";
       // //str = str + "<SubMenu text='Manual Voucher Back date control' url=''></SubMenu>";
       // //str = str + "<SubMenu text='Cost Center Type Master' url=''></SubMenu>";
       // str = str + "</SubMenu>";


       // str = str + "<SubMenu text='General' url=''>";

       // str = str + "<SubMenu text='General Masters' url=''></SubMenu>";
       // str = str + "<SubMenu text='Add General Master Members' url=''></SubMenu>";
       // str = str + "<SubMenu text='Application Settings' url=''></SubMenu>";
       // str = str + "<SubMenu text='Upload Logo' url=''></SubMenu>";
       // str = str + "<SubMenu text='Manage menus' url='~/GUI/admin/ManageMenus.aspx'></SubMenu>";
       // str = str + "<SubMenu text='Master Rules' url='~/GUI/admin/MasterRules/MasterRules.aspx'></SubMenu>";
       // str = str + "</SubMenu>";


       // str = str + "<SubMenu text='Auto E-Mail' url=''>";

       // str = str + "<SubMenu text='Add RDL for Auto e-mail' url=''></SubMenu>";
       // str = str + "</SubMenu>";


        str = str + "<SubMenu text='Fleet Rules' url='~/GUI/Fleet/TripRuleMaster/TripRuleMasterPage.aspx'>";
        str = str + "</SubMenu>";

     
        str = str + "</Home>";


        //xmlw.WriteString("ashish");

        //StringWriter S = new StringWriter();
        //XmlWriter xw = XmlWriter.Create(S);
        /* write away */

        XmlDataSource xds = new XmlDataSource();
        xds.XPath = "Home/SubMenu";
        xds.ID = "XmlSource1";

        xds.Data = str.ToString();
        Menu1.DataSource = xds;
        Menu1.DataBind();
    }
}

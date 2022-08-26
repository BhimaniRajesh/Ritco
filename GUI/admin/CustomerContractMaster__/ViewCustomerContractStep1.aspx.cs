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

public partial class ViewCustomerContractStep1 : System.Web.UI.Page
{
    //Mode of Transport variables
    public string strModeOfTransportAir;     //Code Id = 1
    public string strModeOfTransportRoad;    //Code Id = 2
    public string strModeOfTransportTrain;   //Code Id = 3
    public string strModeOfTransportExpress; //Code Id = 4

    //Type of Load variables
    public string strTypeOfLoadServiceNo1;   //Service_No = 1
    public string strTypeOfLoadServiceNo2;   //Service_No = 2

    //Contract Charges For Applicable_YN = Y
    public static string strContractCharges;

    //Contract Charges For Applicable_YN = N
    public static string strContractChargesHidden;

    //Applicable for COD-DOD charges
    public bool blnAppForCODDOD;

    //Applicable for DACC charges
    bool blnAppForDACC;

    //Applicable for Door-Pick Charges
    bool blnAppForDPCharges;

    //Applicable for Door-Delivery Charges
    bool blnAppForDDCharges;

    //Applicable for Demurrage Charges
    bool blnAppForDemCharges;

    //Applicable for FOV Charges
    bool blnAppForFOVCharges;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidCustCode.Value = Request.QueryString["CustomerCode"];
            HidCustCodeName.Value = Request.QueryString["CustomerCodeName"].Replace("^|^", "&");

            //Get Mode of Transport values
            getModeOfTransport();
            //Get Type of Load values
            getTypeOfLoad();
            //Get Applicable Docket Charges for 'Y'
            populateActiveCharges();
            //Get Applicable Docket Charges for 'N'
            //populateInActiveCharges();
            //Applicable for Type of Service values
            applicableForTypeOfService();

            trServiceTax.Visible = (lblSTApp.InnerHtml == "Yes" ? true : false);

            //Show/hide Door Pickup Charges row
            trDoorPickupCharge.Visible = blnAppForDPCharges;
            //Show/hide Door Delivery Charges row
            trDoorDeliveryCharge.Visible = blnAppForDDCharges;
            //Show/hide FOV Charges row
            trFOVCharge.Visible = blnAppForFOVCharges;
            //Show/hide Demurrage Charges row
            trDemurrageCharges.Visible = blnAppForDemCharges;

            displayData();
        }

        lblSelectedCustomer.InnerHtml = " " + HidCustCodeName.Value;
    }

    private void displayData()
    {
        string strPreviousFrom = "";
        string strPreviousTo = "";
        string strCurrentFrom = "";
        string strCurrentTo = "";

        int intColumnCounter = 0;
        int intRowCounter = 0;
        
        String strSQL = "select * from webx_ccm_step1 WHERE CustCode = '" + HidCustCode.Value + "'";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCM = new DataSet();

        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            HidRandomNo.Value = dsCCM.Tables[0].Rows[0]["Temp_Sr_No"].ToString();
            lblContractID.InnerHtml = dsCCM.Tables[0].Rows[0]["ContractID"].ToString();
            lblContractDate.InnerHtml = Convert.ToDateTime(dsCCM.Tables[0].Rows[0]["contdate"]).ToString("dd MMM yy");
            lblContractUntilDate.InnerHtml = Convert.ToDateTime(dsCCM.Tables[0].Rows[0]["contvaliduntil"]).ToString("dd MMM yy");
            lblContractEffFromDate.InnerHtml = Convert.ToDateTime(dsCCM.Tables[0].Rows[0]["contefffromdate"]).ToString("dd MMM yy");
            lblContSignLocation.InnerHtml = dsCCM.Tables[0].Rows[0]["contsignloc"].ToString();
            lblCustRep.InnerHtml = dsCCM.Tables[0].Rows[0]["custrep"].ToString();
            lblCoEmpName.InnerHtml = dsCCM.Tables[0].Rows[0]["coempname"].ToString();
            lblCustEmpDesi.InnerHtml = dsCCM.Tables[0].Rows[0]["custrepdesi"].ToString();
            lblCoEmpDesi.InnerHtml = dsCCM.Tables[0].Rows[0]["coempdesi"].ToString();
            lblCustWitness.InnerHtml = dsCCM.Tables[0].Rows[0]["custwitness"].ToString();
            lblCoWitness.InnerHtml = dsCCM.Tables[0].Rows[0]["cowitness"].ToString();
            lblBillingAddress.InnerHtml = dsCCM.Tables[0].Rows[0]["billadd"].ToString();
            lblCityPC.InnerHtml = dsCCM.Tables[0].Rows[0]["city"].ToString() + " - " + dsCCM.Tables[0].Rows[0]["pincode"].ToString();
            lblPartyCategory.InnerHtml = dsCCM.Tables[0].Rows[0]["partycat"].ToString();
            lblContractCategory.InnerHtml = dsCCM.Tables[0].Rows[0]["contcat"].ToString();
            lblSTApp.InnerHtml = (dsCCM.Tables[0].Rows[0]["stapp"].ToString().ToUpper() == "Y" ? "Yes" : "No");
            lblAcctRep.InnerHtml = dsCCM.Tables[0].Rows[0]["acctrep"].ToString();
        }
        
        strSQL = "select * from WebX_CustContract_Charge WHERE ContractId = '" + lblContractID.InnerHtml + "'";

        sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlDA = new SqlDataAdapter(sqlCommand);

        dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            //Mode of Transport
            lblMTAir.InnerHtml = strModeOfTransportAir + " (" + (dsCCM.Tables[0].Rows[0]["air_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblMTTrain.InnerHtml = strModeOfTransportTrain + " (" + (dsCCM.Tables[0].Rows[0]["rail_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblMTRoad.InnerHtml = strModeOfTransportRoad + " (" + (dsCCM.Tables[0].Rows[0]["road_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblMTExpress.InnerHtml = strModeOfTransportExpress + " (" + (dsCCM.Tables[0].Rows[0]["express_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";

            //Type of Load
            lblTLFTL.InnerHtml = strTypeOfLoadServiceNo2 + " (" + (dsCCM.Tables[0].Rows[0]["ftl_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblTLSundry.InnerHtml = strTypeOfLoadServiceNo1 + " (" + (dsCCM.Tables[0].Rows[0]["sundry_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";

            //Pickup-Delivery
            lblPDDD.InnerHtml = "Door-Door (" + (dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("DD") == true ? "Yes" : "No") + ")";
            lblPDDG.InnerHtml = "Door-Godown (" + (dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("DG") == true ? "Yes" : "No") + ")";
            lblPDGD.InnerHtml = "Godown-Door (" + (dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("GD") == true ? "Yes" : "No") + ")";
            lblPDGG.InnerHtml = "Godown-Godown (" + (dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("GG") == true ? "Yes" : "No") + ")";

            //Door Pickup Charges
            //lblDoorPickupCharge.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg"]).ToString("0.00") : "");
            //lblDoorPickupChargePerKg.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg_perkg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg_perkg"]).ToString("0.00") : "");

            lblDoorPickupCharge.InnerHtml = dsCCM.Tables[0].Rows[0]["dp_chrg"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblDoorPickupChargePerKg.InnerHtml = dsCCM.Tables[0].Rows[0]["dp_chrg_perkg"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Door Delivery Charges
            //lblDoorDeliveryCharge.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg"]).ToString("0.00") : "");
            //lblDoorDeliveryChargePerKg.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg_perkg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg_perkg"]).ToString("0.00") : "");

            lblDoorDeliveryCharge.InnerHtml = dsCCM.Tables[0].Rows[0]["dd_chrg"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblDoorDeliveryChargePerKg.InnerHtml = dsCCM.Tables[0].Rows[0]["dd_chrg_perkg"].ToString().ToUpper().Trim().Replace("NULL", "");

            //FOV Related
            lblFOVType.InnerHtml = (dsCCM.Tables[0].Rows[0]["fov_type"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["fov_type"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["fov_type"].ToString());
            //lblFOVCharge.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fov_chrg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fov_chrg"]).ToString("0.00") : "");
            //lblInsPer.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["insu_per"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["insu_per"]).ToString("0.00") : "");

            lblFOVCharge.InnerHtml = dsCCM.Tables[0].Rows[0]["fov_chrg"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblInsPer.InnerHtml = dsCCM.Tables[0].Rows[0]["insu_per"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Type of Service
            lblTSCODDOD.InnerHtml = "COD/DOD (" + (dsCCM.Tables[0].Rows[0]["cod_dod_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblTSODA.InnerHtml = "ODA (" + (dsCCM.Tables[0].Rows[0]["oda_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblTSVolumetric.InnerHtml = "Volumetric (" + (dsCCM.Tables[0].Rows[0]["vol_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";
            lblTSDACC.InnerHtml = "DACC (" + (dsCCM.Tables[0].Rows[0]["dacc_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No") + ")";

            //COD/DOD Charges
            if (dsCCM.Tables[0].Rows[0]["cod_dod_yn"].ToString().ToUpper().Trim() == "Y")
            {
                trTSCODChecked.Visible = true;
                //lblCODCharge.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_rs"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_rs"]).ToString("0.00") : "");
                //lblCODChargePer.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_per"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_per"]).ToString("0.00") : "");

                lblCODCharge.InnerHtml = dsCCM.Tables[0].Rows[0]["cod_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
                lblCODChargePer.InnerHtml = dsCCM.Tables[0].Rows[0]["cod_chrg_per"].ToString().ToUpper().Trim().Replace("NULL", "");
            }

            //Volumetric Charges
            if (dsCCM.Tables[0].Rows[0]["vol_yn"].ToString().ToUpper().Trim() == "Y")
            {
                trTSVolumetricChecked.Visible = true;
                //lblVolMeasure.InnerHtml = (dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["cft_measure"].ToString());
                //lblCFTToKg.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cft2kg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cft2kg"]).ToString("0.00") : "");

                lblVolMeasure.InnerHtml = dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim().Replace("NULL", "");
                lblCFTToKg.InnerHtml = dsCCM.Tables[0].Rows[0]["cft2kg"].ToString().ToUpper().Trim().Replace("NULL", "");
            }

            //DACC Charges
            if (dsCCM.Tables[0].Rows[0]["dacc_yn"].ToString().ToUpper().Trim() == "Y")
            {
                trTSDACCChecked.Visible = true;
                //lblDACCChargeRs.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_rs"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_rs"]).ToString("0.00") : "");
                //lblDACCChargePer.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_per"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_per"]).ToString("0.00") : "");

                lblDACCChargeRs.InnerHtml = dsCCM.Tables[0].Rows[0]["dacc_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
                lblDACCChargePer.InnerHtml = dsCCM.Tables[0].Rows[0]["dacc_chrg_per"].ToString().ToUpper().Trim().Replace("NULL", "");
            }

            //Demurrage Charges
            //lblDemAfterDays.InnerHtml = (dsCCM.Tables[0].Rows[0]["dem_day"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["dem_day"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToInt32(dsCCM.Tables[0].Rows[0]["dem_day"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_day"]).ToString() : "");
            //lblDemChargeRs.InnerHtml = (dsCCM.Tables[0].Rows[0]["dem_chrg_rs"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["dem_chrg_rs"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_rs"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_rs"]).ToString("0.00") : "");
            //lblDemChargePerKg.InnerHtml = (dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"]).ToString("0.00") : "");

            lblDemAfterDays.InnerHtml = dsCCM.Tables[0].Rows[0]["dem_day"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblDemChargeRs.InnerHtml = dsCCM.Tables[0].Rows[0]["dem_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblDemChargePerKg.InnerHtml = dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Bill Generation Location
            lblBillGen.InnerHtml = dsCCM.Tables[0].Rows[0]["billgen_loccode"].ToString().ToUpper().Trim();

            //Billimg Instance
            lblBillingInstance.InnerHtml = dsCCM.Tables[0].Rows[0]["bill_inst"].ToString();

            //Bill Submission Location
            lblBillSubLocation.InnerHtml = dsCCM.Tables[0].Rows[0]["billsub_loccode"].ToString().ToUpper().Trim();

            //Total Credit Limit in Rs.
            //lblCreditLimit.InnerHtml = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["credit_limit"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["credit_limit"]).ToString("0.00") : "");

            lblCreditLimit.InnerHtml = dsCCM.Tables[0].Rows[0]["credit_limit"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Bill Collection Location
            lblBillCollLocation.InnerHtml = dsCCM.Tables[0].Rows[0]["billcol_loccode"].ToString().ToUpper().Trim();

            //Total Credit Limit in Days
            //lblCreditDays.InnerHtml = (Convert.ToInt32(dsCCM.Tables[0].Rows[0]["credit_day"]) > 0 ? dsCCM.Tables[0].Rows[0]["credit_day"].ToString() : "");

            lblCreditDays.InnerHtml = dsCCM.Tables[0].Rows[0]["credit_day"].ToString().ToUpper().Trim().Replace("NULL", "");

            //SKU Wise Y/N
            lblSKU.InnerHtml = (dsCCM.Tables[0].Rows[0]["sku_yn"].ToString().ToUpper().Trim() == "Y" ? "Yes" : "No");

            //Service Tax Paid By
            lblSTPaidBy.InnerHtml = getSTPaidBy();

            //Charges
            //lblSCHG01Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dkt_chrg"]).ToString("0.0");
            //lblSCHG02Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["Hamali_chrg"]).ToString("0.0");
            //lblSCHG03Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["otchg"]).ToString("0.0");
            //lblSCHG04Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["nform_chrg"]).ToString("0.0");
            //lblSCHG05Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["hld_chrg"]).ToString("0.0");
            //lblSCHG06Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["oct_chrg"]).ToString("0.0");
            //lblSCHG09Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["state_chrg"]).ToString("0.0");
            //lblSCHG10Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["hld_dlychrg"]).ToString("0.0");
            //lblSCHG15Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["mathadi_chrg"]).ToString("0.0");
            //lblSCHG16Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["risk_chrg"]).ToString("0.0");
            //lblSCHG17Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["surcharge"]).ToString("0.0");
            //lblSCHG18Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["st_chrg"]).ToString("0.0");
            //lblSCHG19Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["oda_chrg"]).ToString("0.0");
            //lblSCHG20Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fuelchrg"]).ToString("0.0");
            //lblSCHG21Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fod_chrg"]).ToString("0.0");
            //lblSCHG22Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["DC_DD_chrg"]).ToString("0.0");
            //lblSCHG23Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["STSRE_chrg"]).ToString("0.0");

            lblSCHG01Value.InnerHtml = dsCCM.Tables[0].Rows[0]["dkt_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG02Value.InnerHtml = dsCCM.Tables[0].Rows[0]["Hamali_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG03Value.InnerHtml = dsCCM.Tables[0].Rows[0]["otchg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG04Value.InnerHtml = dsCCM.Tables[0].Rows[0]["nform_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG05Value.InnerHtml = dsCCM.Tables[0].Rows[0]["hld_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG06Value.InnerHtml = dsCCM.Tables[0].Rows[0]["oct_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG09Value.InnerHtml = dsCCM.Tables[0].Rows[0]["state_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG10Value.InnerHtml = dsCCM.Tables[0].Rows[0]["hld_dlychrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG15Value.InnerHtml = dsCCM.Tables[0].Rows[0]["mathadi_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG16Value.InnerHtml = dsCCM.Tables[0].Rows[0]["risk_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG17Value.InnerHtml = dsCCM.Tables[0].Rows[0]["surcharge"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG18Value.InnerHtml = dsCCM.Tables[0].Rows[0]["st_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG19Value.InnerHtml = dsCCM.Tables[0].Rows[0]["oda_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG20Value.InnerHtml = dsCCM.Tables[0].Rows[0]["fuelchrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG21Value.InnerHtml = dsCCM.Tables[0].Rows[0]["fod_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG22Value.InnerHtml = dsCCM.Tables[0].Rows[0]["DC_DD_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");
            lblSCHG23Value.InnerHtml = dsCCM.Tables[0].Rows[0]["STSRE_chrg"].ToString().ToUpper().Trim().Replace("NULL", "0.0");

            //lblUCHG01Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_1"]).ToString("0.0");
            //lblUCHG02Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_2"]).ToString("0.0");
            //lblUCHG03Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_3"]).ToString("0.0");
            //lblUCHG04Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_4"]).ToString("0.0");
            //lblUCHG05Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_5"]).ToString("0.0");
            //lblUCHG06Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_6"]).ToString("0.0");
            //lblUCHG07Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_7"]).ToString("0.0");
            //lblUCHG08Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_8"]).ToString("0.0");
            //lblUCHG09Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_9"]).ToString("0.0");
            //lblUCHG10Value.InnerHtml = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_10"]).ToString("0.0");

            //Minimum Freight
            lblAirForFreight.InnerHtml = strModeOfTransportAir;
            lblRoadForFreight.InnerHtml = strModeOfTransportRoad;
            lblTrainForFreight.InnerHtml = strModeOfTransportTrain;
            lblExpressForFreight.InnerHtml = strModeOfTransportExpress;

            //lblAirRateForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["air_rate"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["air_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["air_rate"]).ToString("0.00") : "");
            //lblRoadRateForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["road_rate"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["road_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["road_rate"]).ToString("0.00") : "");
            //lblTrainRateForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["rail_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["rail_rate"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["rail_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["rail_rate"]).ToString("0.00") : "");
            //lblExpressRateForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["exp_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["exp_rate"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["exp_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["exp_rate"]).ToString("0.00") : "");

            lblAirRateForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["air_rate"].ToString().ToUpper().Trim().Replace("NULL", "0.00");
            lblRoadRateForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["road_rate"].ToString().ToUpper().Trim().Replace("NULL", "0.00");
            lblTrainRateForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["rail_rate"].ToString().ToUpper().Trim().Replace("NULL", "0.00");
            lblExpressRateForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["exp_rate"].ToString().ToUpper().Trim().Replace("NULL", "0.00");

            //lblAirBasisForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["air_bas"].ToString());
            //lblRoadBasisForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["road_bas"].ToString());
            //lblTrainBasisForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["rail_bas"].ToString());
            //lblExpressBasisForFreight.InnerHtml = (dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["exp_bas"].ToString());

            lblAirBasisForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblRoadBasisForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblTrainBasisForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim().Replace("NULL", "");
            lblExpressBasisForFreight.InnerHtml = dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim().Replace("NULL", "");
        }

        tbl3ASSCForBranch.Visible = false;
        tbl3ASSCForZone.Visible = false;
        tbl3ASSCForCity.Visible = false;

        if (lblTLSundry.InnerHtml == strTypeOfLoadServiceNo1 + " (Yes)")
        {
            tblTypeOfContract.Visible = true;
            tblTypeOfContractHeader.Visible = true;

            tblFTLHeader.Visible = false;
            tblFTLRoadForBranch.Visible = false;
            tblFTLExpressForBranch.Visible = false;
            tblFTLRoadForZone.Visible = false;
            tblFTLExpressForZone.Visible = false;
            tblFTLRoadForCity.Visible = false;
            tblFTLExpressForCity.Visible = false;

            //Display CCMStep3FreightSundry Details
            strSQL = "select ISNULL(single_slab_yn, 'N') AS Single_Slab, ISNULL(multiple_slab_yn, 'N') AS Multi_Slab from webx_custcontract_hdr WHERE ContractId = '" + lblContractID.InnerHtml + "'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                lblTypeofContract.InnerHtml = (dsCCM.Tables[0].Rows[0]["Single_Slab"].ToString().ToUpper().Trim() == "Y" ? "Single Slab Contract (3A)" : "Multi Slab Detailed Contract (3B)");

                if (dsCCM.Tables[0].Rows[0]["Single_Slab"].ToString().ToUpper().Trim() == "Y")
                {
                    tbl3ASSC.Visible = true;
                    tbl3ASSCForRateType.Visible = true;
                    tbl3ASSCForBranch.Visible = true;
                    tbl3ASSCForZone.Visible = true;
                    tbl3ASSCForCity.Visible = true;

                        tdRoadHeaderForBranch.Visible = true;
                        tdAirHeaderForTrDaysForBranch.Visible = true;
                        tdRoadHeaderForZone.Visible = true;
                        tdAirHeaderForTrDaysForZone.Visible = true;
                        tdRoadHeaderForCity.Visible = true;
                        tdAirHeaderForTrDaysForCity.Visible = true;
                        tdRoadForRow1ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow2ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow3ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow4ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow5ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow6ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow7ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow8ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow9ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow10ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow1ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow2ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow3ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow4ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow5ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow6ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow7ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow8ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow9ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow10ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow1ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow2ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow3ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow4ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow5ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow6ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow7ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow8ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow9ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRow10ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        lblAirHeaderForBranch.InnerHtml = lblMTRoad.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblAirHeaderForZone.InnerHtml = lblMTRoad.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblAirHeaderForCity.InnerHtml = lblMTRoad.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");

                        tdRoadForRowTrDays1ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays2ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays3ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays4ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays5ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays6ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays7ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays8ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays9ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays10ForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays1ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays2ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays3ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays4ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays5ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays6ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays7ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays8ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays9ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays10ForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays1ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays2ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays3ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays4ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays5ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays6ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays7ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays8ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays9ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                        tdRoadForRowTrDays10ForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
                   
                        tdExpressHeaderForBranch.Visible = true;
                        tdExpressHeaderForTrDaysForBranch.Visible = true;
                        tdExpressHeaderForZone.Visible = true;
                        tdExpressHeaderForTrDaysForZone.Visible = true;
                        tdExpressHeaderForCity.Visible = true;
                        tdExpressHeaderForTrDaysForCity.Visible = true;
                        tdExpressForRow1ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow2ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow3ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow4ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow5ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow6ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow7ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow8ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow9ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow10ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow1ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow2ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow3ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow4ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow5ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow6ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow7ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow8ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow9ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow10ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow1ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow2ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow3ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow4ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow5ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow6ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow7ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow8ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow9ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRow10ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);

                        tdExpressForRowTrDays1ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays2ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays3ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays4ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays5ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays6ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays7ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays8ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays9ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays10ForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays1ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays2ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays3ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays4ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays5ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays6ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays7ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays8ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays9ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays10ForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays1ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays2ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays3ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays4ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays5ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays6ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays7ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays8ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays9ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        tdExpressForRowTrDays10ForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
                        lblExpressHeaderForBranch.InnerHtml = lblMTExpress.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblExpressHeaderForZone.InnerHtml = lblMTExpress.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblExpressHeaderForCity.InnerHtml = lblMTExpress.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");

                        tdTrainHeaderForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainHeaderForTrDaysForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdTrainHeaderForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdTrainHeaderForTrDaysForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdTrainHeaderForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdTrainHeaderForTrDaysForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdTrainForRow1ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow2ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow3ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow4ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow5ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow6ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow7ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow8ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow9ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow10ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow1ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow2ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow3ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow4ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow5ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow6ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow7ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow8ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow9ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow10ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow1ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow2ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow3ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow4ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow5ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow6ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow7ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow8ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow9ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRow10ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);

                        tdTrainForRowTrDays1ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays2ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays3ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays4ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays5ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays6ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays7ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays8ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays9ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays10ForBranch.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays1ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays2ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays3ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays4ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays5ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays6ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays7ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays8ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays9ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays10ForZone.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays1ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays2ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays3ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays4ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays5ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays6ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays7ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays8ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays9ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        tdTrainForRowTrDays10ForCity.Visible = (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)" ? true : false);
                        lblTrainHeaderForBranch.InnerHtml = lblMTTrain.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblTrainHeaderForZone.InnerHtml = lblMTTrain.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblTrainHeaderForCity.InnerHtml = lblMTTrain.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");

                        tdAirHeaderForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirHeaderForTrDaysForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirHeaderForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirHeaderForTrDaysForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirHeaderForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirHeaderForTrDaysForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow1ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow2ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow3ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow4ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow5ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow6ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow7ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow8ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow9ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow10ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow1ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow2ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow3ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow4ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow5ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow6ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow7ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow8ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow9ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow10ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow1ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow2ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow3ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow4ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow5ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow6ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow7ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow8ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow9ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRow10ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);

                        tdAirForRowTrDays1ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays2ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays3ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays4ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays5ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays6ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays7ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays8ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays9ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays10ForBranch.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays1ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays2ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays3ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays4ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays5ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays6ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays7ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays8ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays9ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays10ForZone.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays1ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays2ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays3ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays4ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays5ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays6ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays7ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays8ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays9ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        tdAirForRowTrDays10ForCity.Visible = (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)" ? true : false);
                        lblAirHeaderForBranch.InnerHtml = lblMTAir.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblAirHeaderForZone.InnerHtml = lblMTAir.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");
                        lblAirHeaderForCity.InnerHtml = lblMTAir.InnerHtml.Replace(" (Yes)", "").Replace(" (No)", "");

                    //Display for Branch Matrix for 3A Single Slab Details
                    strSQL = "select * from WEBX_CUSTCONTRACT_LOCDET WHERE ContractId = '" + lblContractID.InnerHtml + "'";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlDA = new SqlDataAdapter(sqlCommand);

                    dsCCM = new DataSet();
                    sqlDA.Fill(dsCCM);

                    if (dsCCM.Tables[0].Rows.Count > 0)
                    {
                        for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                        {
                            switch (intLoopCounter)
                            {
                                case 0:
                                    tr3ASSCRow1ForBranch.Visible = true;
                                    lblFreightMatrixRow1FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow1ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow1ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    lblRateType.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["rate_type"].ToString();
                                    break;

                                case 1:
                                    tr3ASSCRow2ForBranch.Visible = true;
                                    lblFreightMatrixRow2FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow2ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();
                                    
                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow2ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 2:
                                    tr3ASSCRow3ForBranch.Visible = true;
                                    lblFreightMatrixRow3FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow3ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblRoadTrDaysForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblTrainTrDaysForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblExpressTrDaysForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    break;

                                case 3:
                                    tr3ASSCRow4ForBranch.Visible = true;
                                    lblFreightMatrixRow4FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow4ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblRoadTrDaysForRow3ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow4ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblTrainTrDaysForRow4ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow4ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblExpressTrDaysForRow4ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    break;

                                case 4:
                                    tr3ASSCRow5ForBranch.Visible = true;
                                    lblFreightMatrixRow5FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow5ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblExpressTrDaysForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow5ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 5:
                                    tr3ASSCRow6ForBranch.Visible = true;
                                    lblFreightMatrixRow6FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow6ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow6ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 6:
                                    tr3ASSCRow7ForBranch.Visible = true;
                                    lblFreightMatrixRow7FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow7ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblAirTrDaysForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblRoadTrDaysForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow7ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 7:
                                    tr3ASSCRow8ForBranch.Visible = true;
                                    lblFreightMatrixRow8FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow8ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow8ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 8:
                                    tr3ASSCRow9ForBranch.Visible = true;
                                    lblFreightMatrixRow9FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow9ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow9ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 9:
                                    tr3ASSCRow10ForBranch.Visible = true;
                                    lblFreightMatrixRow10FromForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow10ToForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow10ForBranch.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;
                            }
                        }
                    }

                    //Zone Matrix
                    strSQL = "select * from WEBX_CUSTCONTRACT_REGDET WHERE ContractId = '" + lblContractID.InnerHtml + "'";

                    sqlCommand = null;
                    sqlDA = null;
                    dsCCM = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlDA = new SqlDataAdapter(sqlCommand);

                    dsCCM = new DataSet();

                    sqlDA.Fill(dsCCM);

                    if (dsCCM.Tables[0].Rows.Count > 0)
                    {
                        for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                        {
                            switch (intLoopCounter)
                            {
                                case 0:
                                    tr3ASSCRow1ForZone.Visible = true;
                                    lblFreightMatrixRow1FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow1ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow1ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    lblRateType.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["rate_type"].ToString();
                                    break;

                                case 1:
                                    tr3ASSCRow2ForZone.Visible = true;
                                    lblFreightMatrixRow2FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow2ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow2ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 2:
                                    tr3ASSCRow3ForZone.Visible = true;
                                    lblFreightMatrixRow3FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow3ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblRoadTrDaysForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblTrainTrDaysForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblExpressTrDaysForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    break;

                                case 3:
                                    tr3ASSCRow4ForZone.Visible = true;
                                    lblFreightMatrixRow4FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow4ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblRoadTrDaysForRow3ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow4ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblTrainTrDaysForRow4ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow4ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblExpressTrDaysForRow4ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    break;

                                case 4:
                                    tr3ASSCRow5ForZone.Visible = true;
                                    lblFreightMatrixRow5FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow5ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblExpressTrDaysForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow5ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 5:
                                    tr3ASSCRow6ForZone.Visible = true;
                                    lblFreightMatrixRow6FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow6ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow6ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 6:
                                    tr3ASSCRow7ForZone.Visible = true;
                                    lblFreightMatrixRow7FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow7ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblAirTrDaysForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblRoadTrDaysForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow7ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 7:
                                    tr3ASSCRow8ForZone.Visible = true;
                                    lblFreightMatrixRow8FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow8ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow8ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 8:
                                    tr3ASSCRow9ForZone.Visible = true;
                                    lblFreightMatrixRow9FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow9ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow9ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 9:
                                    tr3ASSCRow10ForZone.Visible = true;
                                    lblFreightMatrixRow10FromForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow10ToForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow10ForZone.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;
                            }
                        }
                    }

                    //City Matrix
                    strSQL = "select * from WEBX_CUSTCONTRACT_CITYDET WHERE ContractId = '" + lblContractID.InnerHtml + "'";

                    sqlCommand = null;
                    sqlDA = null;
                    dsCCM = null;

                    sqlCommand = new SqlCommand(strSQL, sqlConn);

                    sqlDA = new SqlDataAdapter(sqlCommand);

                    dsCCM = new DataSet();

                    sqlDA.Fill(dsCCM);

                    if (dsCCM.Tables[0].Rows.Count > 0)
                    {
                        for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                        {
                            switch (intLoopCounter)
                            {
                                case 0:
                                    tr3ASSCRow1ForCity.Visible = true;
                                    lblFreightMatrixRow1FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow1ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow1ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    lblRateType.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["rate_type"].ToString();
                                    break;

                                case 1:
                                    tr3ASSCRow2ForCity.Visible = true;
                                    lblFreightMatrixRow2FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow2ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow2ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 2:
                                    tr3ASSCRow3ForCity.Visible = true;
                                    lblFreightMatrixRow3FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow3ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblRoadTrDaysForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblTrainTrDaysForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblExpressTrDaysForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    break;

                                case 3:
                                    tr3ASSCRow4ForCity.Visible = true;
                                    lblFreightMatrixRow4FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow4ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblRoadTrDaysForRow3ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow4ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblTrainTrDaysForRow4ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow4ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblExpressTrDaysForRow4ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    break;

                                case 4:
                                    tr3ASSCRow5ForCity.Visible = true;
                                    lblFreightMatrixRow5FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow5ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblExpressTrDaysForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow5ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 5:
                                    tr3ASSCRow6ForCity.Visible = true;
                                    lblFreightMatrixRow6FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow6ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_rate"].ToString()));
                                        lblAirTrDaysForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Air_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_rate"].ToString()));
                                        lblRoadTrDaysForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Road_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow6ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 6:
                                    tr3ASSCRow7ForCity.Visible = true;
                                    lblFreightMatrixRow7FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow7ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblAirTrDaysForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblRoadTrDaysForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_rate"].ToString()));
                                        lblTrainTrDaysForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Train_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow7ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 7:
                                    tr3ASSCRow8ForCity.Visible = true;
                                    lblFreightMatrixRow8FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow8ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow8ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 8:
                                    tr3ASSCRow9ForCity.Visible = true;
                                    lblFreightMatrixRow9FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow9ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow9ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;

                                case 9:
                                    tr3ASSCRow10ForCity.Visible = true;
                                    lblFreightMatrixRow10FromForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FromLocode"].ToString().ToUpper().Trim();
                                    lblFreightMatrixRow10ToForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ToLocode"].ToString().ToUpper().Trim();

                                    if (lblMTAir.InnerHtml == strModeOfTransportAir + " (Yes)")
                                    {
                                        lblAirForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblAirTrDaysForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
                                    {
                                        lblRoadForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblRoadTrDaysForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTTrain.InnerHtml == strModeOfTransportTrain + " (Yes)")
                                    {
                                        lblTrainForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblTrainTrDaysForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
                                    {
                                        lblExpressForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString() == "0.00" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_rate"].ToString()));
                                        lblExpressTrDaysForRow10ForCity.InnerHtml = (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString().ToUpper().Trim() == "" ? "" : (dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString() == "0.0" ? "" : dsCCM.Tables[0].Rows[intLoopCounter]["Express_days"].ToString()));
                                    }

                                    break;
                            }
                        }
                    }
                }
                else
                {

                }
            }
        }
        else
        {
            tblTypeOfContract.Visible = false;
            tblTypeOfContractHeader.Visible = false;

            tblFTLHeader.Visible = true;

            tblFTLRoadForBranch.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
            tblFTLExpressForBranch.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
            tblFTLRoadForZone.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
            tblFTLExpressForZone.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);
            tblFTLRoadForCity.Visible = (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)" ? true : false);
            tblFTLExpressForCity.Visible = (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)" ? true : false);

            lblFTLHeader.InnerHtml = "<b>&nbsp;STEP 4: Freight Matrix - " + lblTLFTL.InnerHtml + "</b>";

            strPreviousFrom = "";
            strPreviousTo = "";
            strCurrentFrom = "";
            strCurrentTo = "";

            intColumnCounter = 0;
            intRowCounter = 0;

            trFrRoadForBranch1.Visible = false;
            trFrRoadForBranch2.Visible = false;
            trFrRoadForBranch3.Visible = false;
            trFrRoadForBranch4.Visible = false;
            trFrRoadForBranch5.Visible = false;
            trFrRoadForBranch6.Visible = false;
            trFrRoadForBranch7.Visible = false;
            trFrRoadForBranch8.Visible = false;
            trFrRoadForBranch9.Visible = false;
            trFrRoadForBranch10.Visible = false;

            if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
            {
                strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + lblContractID.InnerHtml + "' AND UPPER(Trans_Type) = '" + strModeOfTransportRoad.ToUpper() + "' AND LOC_REG = 'L'";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlDA = new SqlDataAdapter(sqlCommand);

                dsCCM = new DataSet();
                sqlDA.Fill(dsCCM);

                if (dsCCM.Tables[0].Rows.Count > 0)
                {
                    for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                    {
                        if (intColumnCounter == 0)
                        {
                            strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                            strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                            strCurrentFrom = strPreviousFrom;
                            strCurrentTo = strPreviousTo;

                            if (intRowCounter != 0)
                            {
                                intColumnCounter++;
                            }
                        }
                        else
                        {
                            strPreviousFrom = strCurrentFrom;
                            strPreviousTo = strCurrentTo;
                            strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                            strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                            if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                            {
                                intColumnCounter = 0;
                                intRowCounter++;
                            }
                        }

                        switch (intRowCounter)
                        {
                            case 0:
                                trFrRoadForBranch1.Visible = true;
                                lblFRFromRoadForBranch1.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch1.InnerHtml = strCurrentTo;

                                break;

                            case 1:
                                trFrRoadForBranch2.Visible = true;
                                lblFRFromRoadForBranch2.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch2.InnerHtml = strCurrentTo;

                                break;

                            case 2:
                                trFrRoadForBranch3.Visible = true;
                                lblFRFromRoadForBranch3.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch3.InnerHtml = strCurrentTo;

                                break;

                            case 3:
                                trFrRoadForBranch4.Visible = true;
                                lblFRFromRoadForBranch4.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch4.InnerHtml = strCurrentTo;

                                break;

                            case 4:
                                trFrRoadForBranch5.Visible = true;
                                lblFRFromRoadForBranch5.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch5.InnerHtml = strCurrentTo;

                                break;

                            case 5:
                                trFrRoadForBranch6.Visible = true;
                                lblFRFromRoadForBranch6.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch6.InnerHtml = strCurrentTo;

                                break;

                            case 6:
                                trFrRoadForBranch7.Visible = true;
                                lblFRFromRoadForBranch7.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch7.InnerHtml = strCurrentTo;

                                break;

                            case 7:
                                trFrRoadForBranch8.Visible = true;
                                lblFRFromRoadForBranch8.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch8.InnerHtml = strCurrentTo;

                                break;

                            case 8:
                                trFrRoadForBranch9.Visible = true;
                                lblFRFromRoadForBranch9.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch9.InnerHtml = strCurrentTo;

                                break;

                            case 9:
                                trFrRoadForBranch10.Visible = true;
                                lblFRFromRoadForBranch10.InnerHtml = strCurrentFrom;
                                lblFRToRoadForBranch10.InnerHtml = strCurrentTo;

                                break;
                        }

                        switch (intRowCounter)
                        {
                            case 0:
                                if (trFrRoadForBranch1.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFTLType1HeaderForRoadForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType1RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();
                                            break;

                                        case 1:

                                            lblFTLType2HeaderForRoadForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType2RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFTLType3HeaderForRoadForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType3RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFTLType4HeaderForRoadForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType4RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFTLType5HeaderForRoadForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType5RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 1:
                                if (trFrRoadForBranch2.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 2:
                                if (trFrRoadForBranch3.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }
                                break;

                            case 3:
                                if (trFrRoadForBranch4.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 4:
                                if (trFrRoadForBranch5.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 5:
                                if (trFrRoadForBranch6.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 6:
                                if (trFrRoadForBranch7.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 7:
                                if (trFrRoadForBranch8.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 8:
                                if (trFrRoadForBranch9.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 9:
                                if (trFrRoadForBranch10.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;
                        }

                        if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                        {
                            intColumnCounter++;
                        }
                    }
                }
            }
        }

        strPreviousFrom = "";
        strPreviousTo = "";
        strCurrentFrom = "";
        strCurrentTo = "";

        intColumnCounter = 0;
        intRowCounter = 0;

        trFrExpressForBranch1.Visible = false;
        trFrExpressForBranch2.Visible = false;
        trFrExpressForBranch3.Visible = false;
        trFrExpressForBranch4.Visible = false;
        trFrExpressForBranch5.Visible = false;
        trFrExpressForBranch6.Visible = false;
        trFrExpressForBranch7.Visible = false;
        trFrExpressForBranch8.Visible = false;
        trFrExpressForBranch9.Visible = false;
        trFrExpressForBranch10.Visible = false;
        
        if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + lblContractID.InnerHtml + "' AND UPPER(Trans_Type) = '" + strModeOfTransportExpress.ToUpper() + "' AND LOC_REG = 'L'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                trFrExpressForBranch1.Visible = true;
                                lblFRFromExpressForBranch1.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch1.InnerHtml = strCurrentTo;

                                break;

                            case 1:
                                trFrExpressForBranch2.Visible = true;
                                lblFRFromExpressForBranch2.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch2.InnerHtml = strCurrentTo;

                                break;

                            case 2:
                                trFrExpressForBranch3.Visible = true;
                                lblFRFromExpressForBranch3.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch3.InnerHtml = strCurrentTo;

                                break;

                            case 3:
                                trFrExpressForBranch4.Visible = true;
                                lblFRFromExpressForBranch4.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch4.InnerHtml = strCurrentTo;

                                break;

                            case 4:
                                trFrExpressForBranch5.Visible = true;
                                lblFRFromExpressForBranch5.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch5.InnerHtml = strCurrentTo;

                                break;

                            case 5:
                                trFrExpressForBranch6.Visible = true;
                                lblFRFromExpressForBranch6.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch6.InnerHtml = strCurrentTo;

                                break;

                            case 6:
                                trFrExpressForBranch7.Visible = true;
                                lblFRFromExpressForBranch7.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch7.InnerHtml = strCurrentTo;

                                break;

                            case 7:
                                trFrExpressForBranch8.Visible = true;
                                lblFRFromExpressForBranch8.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch8.InnerHtml = strCurrentTo;
                                
                                break;

                            case 8:
                                trFrExpressForBranch9.Visible = true;
                                lblFRFromExpressForBranch9.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch9.InnerHtml = strCurrentTo;

                                break;

                            case 9:
                                trFrExpressForBranch10.Visible = true;
                                lblFRFromExpressForBranch10.InnerHtml = strCurrentFrom;
                                lblFRToExpressForBranch10.InnerHtml = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            if (trFrExpressForBranch1.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFTLType1HeaderForExpressForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType1RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();
                                        break;

                                    case 1:

                                        lblFTLType2HeaderForExpressForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType2RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFTLType3HeaderForExpressForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType3RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFTLType4HeaderForExpressForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType4RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFTLType5HeaderForExpressForBranch.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType5RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 1:
                            if (trFrExpressForBranch2.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 2:
                            if (trFrExpressForBranch3.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }
                            break;

                        case 3:
                            if (trFrExpressForBranch4.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 4:
                            if (trFrExpressForBranch5.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 5:
                            if (trFrExpressForBranch6.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 6:
                            if (trFrExpressForBranch7.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 7:
                            if (trFrExpressForBranch8.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 8:
                            if (trFrExpressForBranch9.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 9:
                            if (trFrExpressForBranch10.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForBranch10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }

            strPreviousFrom = "";
            strPreviousTo = "";
            strCurrentFrom = "";
            strCurrentTo = "";

            intColumnCounter = 0;
            intRowCounter = 0;

            trFrRoadForZone1.Visible = false;
            trFrRoadForZone2.Visible = false;
            trFrRoadForZone3.Visible = false;
            trFrRoadForZone4.Visible = false;
            trFrRoadForZone5.Visible = false;
            trFrRoadForZone6.Visible = false;
            trFrRoadForZone7.Visible = false;
            trFrRoadForZone8.Visible = false;
            trFrRoadForZone9.Visible = false;
            trFrRoadForZone10.Visible = false;

            if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
            {
                strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + lblContractID.InnerHtml + "' AND UPPER(Trans_Type) = '" + strModeOfTransportRoad.ToUpper() + "' AND LOC_REG = 'R'";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlDA = new SqlDataAdapter(sqlCommand);

                dsCCM = new DataSet();
                sqlDA.Fill(dsCCM);

                if (dsCCM.Tables[0].Rows.Count > 0)
                {
                    for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                    {
                        if (intColumnCounter == 0)
                        {
                            strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                            strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                            strCurrentFrom = strPreviousFrom;
                            strCurrentTo = strPreviousTo;

                            switch (intRowCounter)
                            {
                                case 0:
                                    trFrRoadForZone1.Visible = true;
                                    lblFRFromRoadForZone1.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone1.InnerHtml = strCurrentTo;

                                    break;

                                case 1:
                                    trFrRoadForZone2.Visible = true;
                                    lblFRFromRoadForZone2.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone2.InnerHtml = strCurrentTo;

                                    break;

                                case 2:
                                    trFrRoadForZone3.Visible = true;
                                    lblFRFromRoadForZone3.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone3.InnerHtml = strCurrentTo;

                                    break;

                                case 3:
                                    trFrRoadForZone4.Visible = true;
                                    lblFRFromRoadForZone4.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone4.InnerHtml = strCurrentTo;

                                    break;

                                case 4:
                                    trFrRoadForZone5.Visible = true;
                                    lblFRFromRoadForZone5.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone5.InnerHtml = strCurrentTo;

                                    break;

                                case 5:
                                    trFrRoadForZone6.Visible = true;
                                    lblFRFromRoadForZone6.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone6.InnerHtml = strCurrentTo;

                                    break;

                                case 6:
                                    trFrRoadForZone7.Visible = true;
                                    lblFRFromRoadForZone7.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone7.InnerHtml = strCurrentTo;

                                    break;

                                case 7:
                                    trFrRoadForZone8.Visible = true;
                                    lblFRFromRoadForZone8.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone8.InnerHtml = strCurrentTo;

                                    break;

                                case 8:
                                    trFrRoadForZone9.Visible = true;
                                    lblFRFromRoadForZone9.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone9.InnerHtml = strCurrentTo;

                                    break;

                                case 9:
                                    trFrRoadForZone10.Visible = true;
                                    lblFRFromRoadForZone10.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForZone10.InnerHtml = strCurrentTo;

                                    break;
                            }

                            if (intRowCounter != 0)
                            {
                                intColumnCounter++;
                            }
                        }
                        else
                        {
                            strPreviousFrom = strCurrentFrom;
                            strPreviousTo = strCurrentTo;
                            strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                            strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                            if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                            {
                                intColumnCounter = 0;
                                intRowCounter++;
                            }
                        }

                        switch (intRowCounter)
                        {
                            case 0:
                                if (trFrRoadForZone1.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFTLType1HeaderForRoadForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType1RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();
                                            break;

                                        case 1:

                                            lblFTLType2HeaderForRoadForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType2RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFTLType3HeaderForRoadForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType3RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFTLType4HeaderForRoadForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType4RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFTLType5HeaderForRoadForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType5RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 1:
                                if (trFrRoadForZone2.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 2:
                                if (trFrRoadForZone3.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }
                                break;

                            case 3:
                                if (trFrRoadForZone4.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 4:
                                if (trFrRoadForZone5.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 5:
                                if (trFrRoadForZone6.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 6:
                                if (trFrRoadForZone7.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 7:
                                if (trFrRoadForZone8.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 8:
                                if (trFrRoadForZone9.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 9:
                                if (trFrRoadForZone10.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;
                        }

                        if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                        {
                            intColumnCounter++;
                        }
                    }
                }
            }
        }

        strPreviousFrom = "";
        strPreviousTo = "";
        strCurrentFrom = "";
        strCurrentTo = "";

        intColumnCounter = 0;
        intRowCounter = 0;

        trFrExpressForZone1.Visible = false;
        trFrExpressForZone2.Visible = false;
        trFrExpressForZone3.Visible = false;
        trFrExpressForZone4.Visible = false;
        trFrExpressForZone5.Visible = false;
        trFrExpressForZone6.Visible = false;
        trFrExpressForZone7.Visible = false;
        trFrExpressForZone8.Visible = false;
        trFrExpressForZone9.Visible = false;
        trFrExpressForZone10.Visible = false;

        if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + lblContractID.InnerHtml + "' AND UPPER(Trans_Type) = '" + strModeOfTransportExpress.ToUpper() + "' AND LOC_REG = 'R'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                trFrExpressForZone1.Visible = true;
                                lblFRFromExpressForZone1.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone1.InnerHtml = strCurrentTo;

                                break;

                            case 1:
                                trFrExpressForZone2.Visible = true;
                                lblFRFromExpressForZone2.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone2.InnerHtml = strCurrentTo;

                                break;

                            case 2:
                                trFrExpressForZone3.Visible = true;
                                lblFRFromExpressForZone3.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone3.InnerHtml = strCurrentTo;

                                break;

                            case 3:
                                trFrExpressForZone4.Visible = true;
                                lblFRFromExpressForZone4.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone4.InnerHtml = strCurrentTo;

                                break;

                            case 4:
                                trFrExpressForZone5.Visible = true;
                                lblFRFromExpressForZone5.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone5.InnerHtml = strCurrentTo;

                                break;

                            case 5:
                                trFrExpressForZone6.Visible = true;
                                lblFRFromExpressForZone6.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone6.InnerHtml = strCurrentTo;

                                break;

                            case 6:
                                trFrExpressForZone7.Visible = true;
                                lblFRFromExpressForZone7.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone7.InnerHtml = strCurrentTo;

                                break;

                            case 7:
                                trFrExpressForZone8.Visible = true;
                                lblFRFromExpressForZone8.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone8.InnerHtml = strCurrentTo;

                                break;

                            case 8:
                                trFrExpressForZone9.Visible = true;
                                lblFRFromExpressForZone9.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone9.InnerHtml = strCurrentTo;

                                break;

                            case 9:
                                trFrExpressForZone10.Visible = true;
                                lblFRFromExpressForZone10.InnerHtml = strCurrentFrom;
                                lblFRToExpressForZone10.InnerHtml = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            if (trFrExpressForZone1.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFTLType1HeaderForExpressForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType1RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();
                                        break;

                                    case 1:

                                        lblFTLType2HeaderForExpressForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType2RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFTLType3HeaderForExpressForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType3RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFTLType4HeaderForExpressForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType4RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFTLType5HeaderForExpressForZone.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType5RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 1:
                            if (trFrExpressForZone2.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 2:
                            if (trFrExpressForZone3.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }
                            break;

                        case 3:
                            if (trFrExpressForZone4.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 4:
                            if (trFrExpressForZone5.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 5:
                            if (trFrExpressForZone6.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 6:
                            if (trFrExpressForZone7.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 7:
                            if (trFrExpressForZone8.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 8:
                            if (trFrExpressForZone9.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 9:
                            if (trFrExpressForZone10.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForZone10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }

            strPreviousFrom = "";
            strPreviousTo = "";
            strCurrentFrom = "";
            strCurrentTo = "";

            intColumnCounter = 0;
            intRowCounter = 0;

            trFrRoadForCity1.Visible = false;
            trFrRoadForCity2.Visible = false;
            trFrRoadForCity3.Visible = false;
            trFrRoadForCity4.Visible = false;
            trFrRoadForCity5.Visible = false;
            trFrRoadForCity6.Visible = false;
            trFrRoadForCity7.Visible = false;
            trFrRoadForCity8.Visible = false;
            trFrRoadForCity9.Visible = false;
            trFrRoadForCity10.Visible = false;

            if (lblMTRoad.InnerHtml == strModeOfTransportRoad + " (Yes)")
            {
                strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + lblContractID.InnerHtml + "' AND UPPER(Trans_Type) = '" + strModeOfTransportRoad.ToUpper() + "' AND LOC_REG = 'C'";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlDA = new SqlDataAdapter(sqlCommand);

                dsCCM = new DataSet();
                sqlDA.Fill(dsCCM);

                if (dsCCM.Tables[0].Rows.Count > 0)
                {
                    for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                    {
                        if (intColumnCounter == 0)
                        {
                            strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                            strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                            strCurrentFrom = strPreviousFrom;
                            strCurrentTo = strPreviousTo;

                            switch (intRowCounter)
                            {
                                case 0:
                                    trFrRoadForCity1.Visible = true;
                                    lblFRFromRoadForCity1.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity1.InnerHtml = strCurrentTo;

                                    break;

                                case 1:
                                    trFrRoadForCity2.Visible = true;
                                    lblFRFromRoadForCity2.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity2.InnerHtml = strCurrentTo;

                                    break;

                                case 2:
                                    trFrRoadForCity3.Visible = true;
                                    lblFRFromRoadForCity3.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity3.InnerHtml = strCurrentTo;

                                    break;

                                case 3:
                                    trFrRoadForCity4.Visible = true;
                                    lblFRFromRoadForCity4.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity4.InnerHtml = strCurrentTo;

                                    break;

                                case 4:
                                    trFrRoadForCity5.Visible = true;
                                    lblFRFromRoadForCity5.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity5.InnerHtml = strCurrentTo;

                                    break;

                                case 5:
                                    trFrRoadForCity6.Visible = true;
                                    lblFRFromRoadForCity6.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity6.InnerHtml = strCurrentTo;

                                    break;

                                case 6:
                                    trFrRoadForCity7.Visible = true;
                                    lblFRFromRoadForCity7.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity7.InnerHtml = strCurrentTo;

                                    break;

                                case 7:
                                    trFrRoadForCity8.Visible = true;
                                    lblFRFromRoadForCity8.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity8.InnerHtml = strCurrentTo;

                                    break;

                                case 8:
                                    trFrRoadForCity9.Visible = true;
                                    lblFRFromRoadForCity9.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity9.InnerHtml = strCurrentTo;

                                    break;

                                case 9:
                                    trFrRoadForCity10.Visible = true;
                                    lblFRFromRoadForCity10.InnerHtml = strCurrentFrom;
                                    lblFRToRoadForCity10.InnerHtml = strCurrentTo;

                                    break;
                            }

                            if (intRowCounter != 0)
                            {
                                intColumnCounter++;
                            }
                        }
                        else
                        {
                            strPreviousFrom = strCurrentFrom;
                            strPreviousTo = strCurrentTo;
                            strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                            strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                            if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                            {
                                intColumnCounter = 0;
                                intRowCounter++;
                            }
                        }

                        switch (intRowCounter)
                        {
                            case 0:
                                if (trFrRoadForCity1.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFTLType1HeaderForRoadForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType1RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();
                                            break;

                                        case 1:

                                            lblFTLType2HeaderForRoadForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType2RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFTLType3HeaderForRoadForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType3RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFTLType4HeaderForRoadForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType4RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFTLType5HeaderForRoadForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                            lblFRRoadFTLType5RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 1:
                                if (trFrRoadForCity2.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 2:
                                if (trFrRoadForCity3.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }
                                break;

                            case 3:
                                if (trFrRoadForCity4.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 4:
                                if (trFrRoadForCity5.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 5:
                                if (trFrRoadForCity6.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 6:
                                if (trFrRoadForCity7.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 7:
                                if (trFrRoadForCity8.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 8:
                                if (trFrRoadForCity9.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;

                            case 9:
                                if (trFrRoadForCity10.Visible == true)
                                {
                                    switch (intColumnCounter)
                                    {
                                        case 0:
                                            lblFRRoadFTLType1RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType1RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 1:
                                            lblFRRoadFTLType2RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType2RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 2:
                                            lblFRRoadFTLType3RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType3RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 3:
                                            lblFRRoadFTLType4RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType4RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;

                                        case 4:
                                            lblFRRoadFTLType5RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                            lblTrDaysRoadFTLType5RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                            break;
                                    }
                                }

                                break;
                        }

                        if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                        {
                            intColumnCounter++;
                        }
                    }
                }
            }
        }

        strPreviousFrom = "";
        strPreviousTo = "";
        strCurrentFrom = "";
        strCurrentTo = "";

        intColumnCounter = 0;
        intRowCounter = 0;

        trFrExpressForCity1.Visible = false;
        trFrExpressForCity2.Visible = false;
        trFrExpressForCity3.Visible = false;
        trFrExpressForCity4.Visible = false;
        trFrExpressForCity5.Visible = false;
        trFrExpressForCity6.Visible = false;
        trFrExpressForCity7.Visible = false;
        trFrExpressForCity8.Visible = false;
        trFrExpressForCity9.Visible = false;
        trFrExpressForCity10.Visible = false;

        if (lblMTExpress.InnerHtml == strModeOfTransportExpress + " (Yes)")
        {
            strSQL = "select * from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR WHERE ContractId = '" + lblContractID.InnerHtml + "' AND UPPER(Trans_Type) = '" + strModeOfTransportExpress.ToUpper() + "' AND LOC_REG = 'C'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCM = new DataSet();
            sqlDA.Fill(dsCCM);

            if (dsCCM.Tables[0].Rows.Count > 0)
            {
                for (int intLoopCounter = 0; intLoopCounter < dsCCM.Tables[0].Rows.Count; intLoopCounter++)
                {
                    if (intColumnCounter == 0)
                    {
                        strPreviousFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strPreviousTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();
                        strCurrentFrom = strPreviousFrom;
                        strCurrentTo = strPreviousTo;

                        switch (intRowCounter)
                        {
                            case 0:
                                trFrExpressForCity1.Visible = true;
                                lblFRFromExpressForCity1.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity1.InnerHtml = strCurrentTo;

                                break;

                            case 1:
                                trFrExpressForCity2.Visible = true;
                                lblFRFromExpressForCity2.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity2.InnerHtml = strCurrentTo;

                                break;

                            case 2:
                                trFrExpressForCity3.Visible = true;
                                lblFRFromExpressForCity3.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity3.InnerHtml = strCurrentTo;

                                break;

                            case 3:
                                trFrExpressForCity4.Visible = true;
                                lblFRFromExpressForCity4.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity4.InnerHtml = strCurrentTo;

                                break;

                            case 4:
                                trFrExpressForCity5.Visible = true;
                                lblFRFromExpressForCity5.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity5.InnerHtml = strCurrentTo;

                                break;

                            case 5:
                                trFrExpressForCity6.Visible = true;
                                lblFRFromExpressForCity6.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity6.InnerHtml = strCurrentTo;

                                break;

                            case 6:
                                trFrExpressForCity7.Visible = true;
                                lblFRFromExpressForCity7.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity7.InnerHtml = strCurrentTo;

                                break;

                            case 7:
                                trFrExpressForCity8.Visible = true;
                                lblFRFromExpressForCity8.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity8.InnerHtml = strCurrentTo;

                                break;

                            case 8:
                                trFrExpressForCity9.Visible = true;
                                lblFRFromExpressForCity9.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity9.InnerHtml = strCurrentTo;

                                break;

                            case 9:
                                trFrExpressForCity10.Visible = true;
                                lblFRFromExpressForCity10.InnerHtml = strCurrentFrom;
                                lblFRToExpressForCity10.InnerHtml = strCurrentTo;

                                break;
                        }

                        if (intRowCounter != 0)
                        {
                            intColumnCounter++;
                        }
                    }
                    else
                    {
                        strPreviousFrom = strCurrentFrom;
                        strPreviousTo = strCurrentTo;
                        strCurrentFrom = dsCCM.Tables[0].Rows[intLoopCounter]["from_loccode"].ToString();
                        strCurrentTo = dsCCM.Tables[0].Rows[intLoopCounter]["to_loccode"].ToString();

                        if (strPreviousFrom != strCurrentFrom && strPreviousTo != strCurrentTo)
                        {
                            intColumnCounter = 0;
                            intRowCounter++;
                        }
                    }

                    switch (intRowCounter)
                    {
                        case 0:
                            if (trFrExpressForCity1.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFTLType1HeaderForExpressForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType1RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();
                                        break;

                                    case 1:

                                        lblFTLType2HeaderForExpressForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType2RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFTLType3HeaderForExpressForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType3RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFTLType4HeaderForExpressForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType4RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFTLType5HeaderForExpressForCity.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["ftltype"].ToString();
                                        lblFRExpressFTLType5RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity1.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 1:
                            if (trFrExpressForCity2.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity2.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 2:
                            if (trFrExpressForCity3.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity3.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }
                            break;

                        case 3:
                            if (trFrExpressForCity4.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity4.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 4:
                            if (trFrExpressForCity5.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity5.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 5:
                            if (trFrExpressForCity6.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity6.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 6:
                            if (trFrExpressForCity7.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity7.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 7:
                            if (trFrExpressForCity8.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity8.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 8:
                            if (trFrExpressForCity9.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity9.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;

                        case 9:
                            if (trFrExpressForCity10.Visible == true)
                            {
                                switch (intColumnCounter)
                                {
                                    case 0:
                                        lblFRExpressFTLType1RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType1RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 1:
                                        lblFRExpressFTLType2RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType2RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 2:
                                        lblFRExpressFTLType3RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType3RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 3:
                                        lblFRExpressFTLType4RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType4RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;

                                    case 4:
                                        lblFRExpressFTLType5RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRIP_RATE"].ToString();
                                        lblTrDaysExpressFTLType5RowForCity10.InnerHtml = dsCCM.Tables[0].Rows[intLoopCounter]["FTL1_TRDAYS"].ToString();

                                        break;
                                }
                            }

                            break;
                    }

                    if (strPreviousFrom == strCurrentFrom && strPreviousTo == strCurrentTo)
                    {
                        intColumnCounter++;
                    }
                }
            }

            



        }

        sqlConn.Close();
    }

    private void getModeOfTransport()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetModeOfTransport";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsMOT = new DataSet();

        sqlDA.Fill(dsMOT);

        if (dsMOT.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsMOT.Tables[0].Rows.Count; i++)
            {
                switch (i)
                {
                    case 0:
                        strModeOfTransportAir = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //HidMOTAir.InnerHtml = strModeOfTransportAir;
                        break;
                    case 1:
                        strModeOfTransportRoad = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //HidMOTRoad.InnerHtml = strModeOfTransportRoad;
                        break;
                    case 2:
                        strModeOfTransportTrain = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //HidMOTTrain.InnerHtml = strModeOfTransportTrain;
                        break;
                    case 3:
                        strModeOfTransportExpress = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //HidMOTExpress.Value = strModeOfTransportExpress;
                        break;
                }
            }
        }

        sqlConn.Close();
    }

    private void getTypeOfLoad()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetTypeOfLoad";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsTOL = new DataSet();

        sqlDA.Fill(dsTOL);

        if (dsTOL.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsTOL.Tables[0].Rows.Count; i++)
            {
                switch (i)
                {
                    case 0:
                        strTypeOfLoadServiceNo1 = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //HidSUNDRY.Value = strTypeOfLoadServiceNo1;
                        break;
                    case 1:
                        strTypeOfLoadServiceNo2 = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //HidFTL.Value = strTypeOfLoadServiceNo2;
                        break;
                }
            }
        }

        sqlConn.Close();
    }

    private void getApplicableDocketChargesForN()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetApplicableDocketCharges";

        sqlCommand.Parameters.AddWithValue("@ApplicableYN", "N");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsAppDocketCharges = new DataSet();

        sqlDA.Fill(dsAppDocketCharges);

        if (dsAppDocketCharges.Tables[0].Rows.Count > 0)
        {
            strContractChargesHidden = "";

            for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
            {
                strContractChargesHidden += "<input id='" + dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() + "' type='hidden' value='0' />";
            }
        }

        sqlConn.Close();
    }

    private void applicableForTypeOfService()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetTypeOfServiceAppForDocketCharges";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsTOSApplicable = new DataSet();

        sqlDA.Fill(dsTOSApplicable);

        blnAppForDACC = false;
        blnAppForCODDOD = false;
        blnAppForDPCharges = false;
        blnAppForDDCharges = false;
        blnAppForDemCharges = false;
        blnAppForFOVCharges = false;

        if (dsTOSApplicable.Tables[0].Rows.Count > 0)
        {
            blnAppForCODDOD = (dsTOSApplicable.Tables[0].Rows[0]["CODDODChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDACC = (dsTOSApplicable.Tables[0].Rows[0]["DACCAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDemCharges = (dsTOSApplicable.Tables[0].Rows[0]["DemChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDDCharges = (dsTOSApplicable.Tables[0].Rows[0]["DDChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDPCharges = (dsTOSApplicable.Tables[0].Rows[0]["DPChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForFOVCharges = (dsTOSApplicable.Tables[0].Rows[0]["FOVChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
        }

        sqlConn.Close();
    }

    private void populateActiveCharges()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetApplicableDocketCharges";

        sqlCommand.Parameters.AddWithValue("@ApplicableYN", "Y");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsAppDocketCharges = new DataSet();

        sqlDA.Fill(dsAppDocketCharges);

        if (dsAppDocketCharges.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
            {
                switch (dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString().ToUpper())
                {
                    case "SCHG01":
                        lblSCHG01.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG02":
                        lblSCHG02.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG03":
                        lblSCHG03.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG04":
                        lblSCHG04.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG05":
                        lblSCHG05.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG06":
                        lblSCHG06.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    //case "SCHG07":
                    //    lblSCHG07.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                    //    break;
                    //case "SCHG08":
                    //    lblSCHG08.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                    //    break;
                    case "SCHG09":
                        lblSCHG09.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG10":
                        lblSCHG10.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    //case "SCHG11":
                    //    lblSCHG11.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                    //    break;
                    //case "SCHG12":
                    //    lblSCHG12.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                    //    break;
                    //case "SCHG13":
                    //    lblSCHG13.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                    //    break;
                    //case "SCHG14":
                    //    lblSCHG14.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                    //    break;
                    case "SCHG15":
                        lblSCHG15.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG16":
                        lblSCHG16.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG17":
                        lblSCHG17.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG18":
                        lblSCHG18.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG19":
                        lblSCHG19.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG20":
                        lblSCHG20.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG21":
                        lblSCHG21.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG22":
                        lblSCHG22.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                    case "SCHG23":
                        lblSCHG23.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString() + ":";
                        break;
                }
            }
        }

        sqlConn.Close();
    }

    //private void populateInActiveCharges()
    //{
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    SqlCommand sqlCommand = new SqlCommand();
    //    sqlCommand.Connection = sqlConn;
    //    sqlCommand.CommandType = CommandType.StoredProcedure;
    //    sqlCommand.CommandText = "Webx_SP_GetApplicableDocketCharges";

    //    sqlCommand.Parameters.AddWithValue("@ApplicableYN", "N");

    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsAppDocketCharges = new DataSet();

    //    sqlDA.Fill(dsAppDocketCharges);

    //    if (dsAppDocketCharges.Tables[0].Rows.Count > 0)
    //    {
    //        for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
    //        {
    //            switch (dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString().ToUpper())
    //            {
    //                case "UCHG01":
    //                    lblUCHG01.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG02":
    //                    lblUCHG02.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG03":
    //                    lblUCHG03.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG04":
    //                    lblUCHG04.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG05":
    //                    lblUCHG05.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG06":
    //                    lblUCHG06.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG07":
    //                    lblUCHG07.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG08":
    //                    lblUCHG08.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG09":
    //                    lblUCHG09.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //                case "UCHG10":
    //                    lblUCHG10.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
    //                    break;
    //            }
    //        }
    //    }

    //    sqlConn.Close();
    //}

    private string getSTPaidBy()
    {
        string strSTPaidBy = "";

        string strSQL = "select stax_paidby from WEBX_CUSTCONTRACT_HDR where ContractId = '" + lblContractID.InnerHtml + "'";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            strSTPaidBy = (dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString().ToUpper().Trim() == "" ? "" : dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString());
        }

        return strSTPaidBy;
    }
}

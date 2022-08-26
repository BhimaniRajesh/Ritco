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

public partial class EditCustomerContractStep2 : System.Web.UI.Page
{
    //static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");
    
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

    //New (Next) Customer Contract ID
    string strCustContID;

    //XML String for Customer Contract Header
    string strXMLForCustContHeader;

    //XML String for Customer Contract Charges
    string strXMLForCustContCharges;

    string strMOT = "";
    string strMOTAbbr = "";
    string strTOL = "";
    string strTOLAbbr = "";
    string strPD = "";

    string strMTAir;
    string strMTRoad;
    string strMTTrain;
    string strMTExpress;

    string strTLFTL;
    string strTLSundry;

    string strDPCharge;
    string strDPChargePerKg;

    string strDDCharge;
    string strDDChargePerKg;

    string strFOVType;
    string strFOVRate;

    string strInsPer;

    string strTSCODDOD;
    string strTSODA;
    string strTSVolumetric;
    string strTSDACC;

    string strTOS;

    string strCODDODCharge;
    string strCODDODPerOfAmt;

    string strVolTypeOfMeasure;
    string strVolConversion;

    string strDACCCharges;
    string strDACCFreightPer;

    string strDemAfterDays;

    string strDemCharge;
    string strDemChargePerKg;

    string strBillGenCode;
    string strBillingInstance;

    string strBillSubCode;
    string strBillSubCreditLimit;

    string strBillCollCode;
    string strBillCollCreditDays;

    string strSKUWise;

    string strSTPaidBy;

    //System Charges
    string strSCHG01;
    string strSCHG02;
    string strSCHG03;
    string strSCHG04;
    string strSCHG05;
    string strSCHG06;
    //string strSCHG07;
    //string strSCHG08;
    string strSCHG09;
    string strSCHG10;
    //string strSCHG11;
    //string strSCHG12;
    //string strSCHG13;
    //string strSCHG14;
    string strSCHG15;
    string strSCHG16;
    string strSCHG17;
    string strSCHG18;
    string strSCHG19;
    string strSCHG20;
    string strSCHG21;
    string strSCHG22;
    string strSCHG23;

    //User Charges
    string strUCHG01;
    string strUCHG02;
    string strUCHG03;
    string strUCHG04;
    string strUCHG05;
    string strUCHG06;
    string strUCHG07;
    string strUCHG08;
    string strUCHG09;
    string strUCHG10;

    string strMinFreight_Air_Rate;
    string strMinFreight_Air_Basis;

    string strMinFreight_Road_Rate;
    string strMinFreight_Road_Basis;

    string strMinFreight_Train_Rate;
    string strMinFreight_Train_Basis;

    string strMinFreight_Express_Rate;
    string strMinFreight_Express_Basis;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidRandomNo.Value = Request.QueryString["RandomNo"];

            PopulateHiddenVars();

            //Get Mode of Transport values
            getModeOfTransport();
            //Get Type of Load values
            getTypeOfLoad();
            //Get Applicable Docket Charges for 'Y'
            //getApplicableDocketChargesForY();
            populateActiveCharges();
            //Get Applicable Docket Charges for 'N'
            //getApplicableDocketChargesForN();
            populateInActiveCharges();
            //Applicable for Type of Service values
            applicableForTypeOfService();

            trServiceTax.Visible = (HidSTApp.Value == "Y" ? true : false);

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
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Populate session variables with control values
        populateSession();
        //Get New (Next) Customer Contract ID
        //getNextCustomerContractID();
        //Prepare XML string for inserting Customer Contract Header table data
        prepareXMLStringForCustomerContractHeader();
        //Insert Customer Contract Header table entry
        //insertCustomerContractHeaderEntry();
        //Prepare XML string for inserting Customer Contract Header table data
        prepareXMLStringForCustomerContractCharges();
        //Insert Customer Contract Charges table entry in Temp Table
        //insertCustomerContractChargesEntry();

        //Update WebX_CCM_Step1 Table for Contract ID
        //updateCCMStep2();

        updateRecordInTempTable();
        
        //Insert in Actual Tables
        updateRecordInActualTable();
        
        if (chkTLSundry.Checked == true)
        {
            Response.Redirect("EditCCMStep3FreightSundry.aspx?TL=" + HidSUNDRY.Value + "&Random=" + HidRandomNo.Value + "&FTL=" + (chkTLFTL.Checked == true ? HidFTL.Value : "") + "&ODA=" + (chkTSODA.Checked == true ? "Y" : "N") + "&ContractID=" + HidContractID.Value);
        }
        else
        {
            Response.Redirect("EditCCMStep3FreightFTL.aspx?TL=" + HidFTL.Value + "&Random=" + HidRandomNo.Value + "&ODA=" + (chkTSODA.Checked == true ? "Y" : "N") + "&ContractID=" + HidContractID.Value);
        }
    }

    protected void txtBillCollLocation_TextChanged(object sender, EventArgs e)
    {
        lblErrorBillCollLocation.Visible = false;
        txtBillCollLocation.Text = txtBillCollLocation.Text.Trim().ToUpper();
        lblErrorBillCollLocation.Visible = (!(checkBillingLocation(txtBillCollLocation.Text)));
        if (lblErrorBillCollLocation.Visible == true)
        {
            txtBillCollLocation.Focus();
        }
    }

    protected void txtBillSubLocation_TextChanged(object sender, EventArgs e)
    {
        lblErrorBillSubLocation.Visible = false;
        txtBillSubLocation.Text = txtBillSubLocation.Text.Trim().ToUpper();
        lblErrorBillSubLocation.Visible = (!(checkBillingLocation(txtBillSubLocation.Text)));
        if (lblErrorBillSubLocation.Visible == true)
        {
            txtBillSubLocation.Focus();
        }
    }

    protected void txtBillGen_TextChanged(object sender, EventArgs e)
    {
        lblErrorBillGenLocation.Visible = false;
        txtBillGen.Text = txtBillGen.Text.Trim().ToUpper();
        lblErrorBillGenLocation.Visible = (!(checkBillingLocation(txtBillGen.Text)));
        if (lblErrorBillGenLocation.Visible == true)
        {
            txtBillGen.Focus();
        }
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
                        HidMOTAir.Value = strModeOfTransportAir;
                        //Session["Air"] = strModeOfTransportAir;
                        break;
                    case 1:
                        strModeOfTransportRoad = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        //Session["Road"] = strModeOfTransportRoad;
                        HidMOTRoad.Value = strModeOfTransportRoad;
                        break;
                    case 2:
                        strModeOfTransportTrain = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        HidMOTTrain.Value = strModeOfTransportTrain;
                        //Session["Train"] = strModeOfTransportTrain;
                        break;
                    case 3:
                        strModeOfTransportExpress = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        HidMOTExpress.Value = strModeOfTransportExpress;
                        //Session["Express"] = strModeOfTransportExpress;
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
                        HidSUNDRY.Value = strTypeOfLoadServiceNo1;
                        break;
                    case 1:
                        strTypeOfLoadServiceNo2 = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
                        HidFTL.Value = strTypeOfLoadServiceNo2;
                        break;
                }
            }
        }

        sqlConn.Close();
    }

    private void getApplicableDocketChargesForY()
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

        int intResult;
        string strContractChargesTemp="";

        if (dsAppDocketCharges.Tables[0].Rows.Count > 0)
        {
            strContractCharges = "";

            for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
            {
                strContractChargesTemp = "<td>";
                strContractChargesTemp += "<label class='blackfnt'>&nbsp;";
                strContractChargesTemp += dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                strContractChargesTemp += "</label>";
                strContractChargesTemp += "</td>";
                strContractChargesTemp += "<td>";
                strContractChargesTemp += "<input id='" + dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() + "' ";
                strContractChargesTemp += "type='text' size='10' class='input' value='0' maxlength='8' ";
                strContractChargesTemp += "onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />";
                strContractChargesTemp += "</td>";

                System.Math.DivRem(i, 2, out intResult);

                if (intResult == 1)
                {
                    strContractCharges += strContractChargesTemp + "</tr>";
                }
                else
                {
                    strContractCharges += "<tr style='background-color: White'>" + strContractChargesTemp;
                }
            }

            //Check for odd no. of rows in DataSet
            System.Math.DivRem(dsAppDocketCharges.Tables[0].Rows.Count, 2, out intResult);
            if (intResult == 1)
            {
                strContractCharges += "<td>&nbsp;</td><td>&nbsp;</td>" + "</tr>";
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

        HidCODDODApp.Value = "N";
        HidDACCApp.Value = "N";

        if (dsTOSApplicable.Tables[0].Rows.Count > 0)
        {
            blnAppForCODDOD = (dsTOSApplicable.Tables[0].Rows[0]["CODDODChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            HidCODDODApp.Value = (blnAppForCODDOD == true ? "Y" : "N");
            blnAppForDACC = (dsTOSApplicable.Tables[0].Rows[0]["DACCAppYN"].ToString().ToUpper() == "Y" ? true : false);
            HidDACCApp.Value = (blnAppForDACC == true ? "Y" : "N");
            blnAppForDemCharges = (dsTOSApplicable.Tables[0].Rows[0]["DemChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDDCharges = (dsTOSApplicable.Tables[0].Rows[0]["DDChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDPCharges = (dsTOSApplicable.Tables[0].Rows[0]["DPChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForFOVCharges = (dsTOSApplicable.Tables[0].Rows[0]["FOVChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
        }

        sqlConn.Close();
    }

    protected void chkTSCODDOD_CheckedChanged(object sender, EventArgs e)
    {
        if (HidCODDODApp.Value == "Y")
        {
            trTSCODChecked.Visible = chkTSCODDOD.Checked;
        }
    }

    protected void chkTSVolumetric_CheckedChanged(object sender, EventArgs e)
    {
        trTSVolumetricChecked.Visible = chkTSVolumetric.Checked;
    }

    protected void chkTSDACC_CheckedChanged(object sender, EventArgs e)
    {
        if (HidDACCApp.Value == "Y")
        {
            trTSDACCChecked.Visible = chkTSDACC.Checked;
        }
    }

    private void populateSession()
    {
        strMOT = "";
        strMOTAbbr = "";
        strTOL = "";
        strTOLAbbr = "";
        strPD = "";
        strTOS = "";

        //Check for Air, Mode of Transport
        if (chkMTAir.Checked == true)
        {
            strMOT = HidMOTAir.Value;
            strMOTAbbr = "A";
        }

        //Check for Road, Mode of Transport
        if (chkMTRoad.Checked == true)
        {
            strMOT = (strMOT == "" ? HidMOTRoad.Value : strMOT + "," + HidMOTRoad.Value);
            strMOTAbbr = (strMOTAbbr == "" ? "R" : strMOTAbbr + ",R");
        }

        //Check for Train, Mode of Transport
        if (chkMTTrain.Checked == true)
        {
            strMOT = (strMOT == "" ? HidMOTTrain.Value : strMOT + "," + HidMOTTrain.Value);
            strMOTAbbr = (strMOTAbbr == "" ? "T" : strMOTAbbr + ",T");
        }

        //Check for Express, Mode of Transport
        if (chkMTExpress.Checked == true)
        {
            strMOT = (strMOT == "" ? HidMOTExpress.Value : strMOT + "," + HidMOTExpress.Value);
            strMOTAbbr = (strMOTAbbr == "" ? "E" : strMOTAbbr + ",E");
        }
        
        strMTAir = (chkMTAir.Checked == true ? "Y" : "N");
        strMTRoad = (chkMTRoad.Checked == true ? "Y" : "N");
        strMTTrain = (chkMTTrain.Checked == true ? "Y" : "N");
        strMTExpress= (chkMTExpress.Checked == true ? "Y" : "N");

        //Check for FTL, Type of Load
        if (chkTLFTL.Checked == true)
        {
            strTOL = "FTL";
            strTOLAbbr = "F";
        }

        //Check for Sundry, Type of Load
        if (chkTLSundry.Checked == true)
        {
            strTOL = (strTOL == "" ? "SUNDRY" : strTOL + ",SUNDRY");
            strTOLAbbr = (strTOLAbbr == "" ? "S" : strTOLAbbr + ",S");
        }

        strTLFTL = (chkTLFTL.Checked == true ? "Y" : "N");
        strTLSundry = (chkTLSundry.Checked == true ? "Y" : "N");

        //Check for Godown-Godown, Pickup-Delivery
        if (chkGG.Checked == true)
        {
            strPD = (strPD == "" ? "GG" : strPD + ", GG");
        }

        //Check for Godown-Door, Pickup-Delivery
        if (chkGD.Checked == true)
        {
            strPD = (strPD == "" ? "GD" : strPD + ", GD");
        }

        //Check for Door-Door, Pickup-Delivery
        if (chkDD.Checked == true)
        {
            strPD = (strPD == "" ? "DD" : strPD + ", DD");
        }

        //Check for Door-Godown, Pickup-Delivery
        if (chkDG.Checked == true)
        {
            strPD = (strPD == "" ? "DG" : strPD + ", DG");
        }

        strDPCharge = "0.00";
        strDPChargePerKg = "0.00";
        
        if (trDoorPickupCharge.Visible == true)
        {
            strDPCharge = (txtDoorPickupCharge.Value == "" ? "0.00" : txtDoorPickupCharge.Value);
            strDPChargePerKg = (txtDoorPickupChargePerKg.Value == "" ? "0.00" : txtDoorPickupChargePerKg.Value);
        }
        
        strDDCharge = "0.00";
        strDDChargePerKg = "0.00";

        if (trDoorDeliveryCharge.Visible == true)
        {
            strDDCharge = (txtDoorDeliveryCharge.Value == "" ? "0.00" : txtDoorDeliveryCharge.Value);
            strDDChargePerKg = (txtDoorDeliveryChargePerKg.Value == "" ? "0.00" : txtDoorDeliveryChargePerKg.Value);
        }
        
        strFOVType = "";
        strFOVRate = "0.00";

        if (trFOVCharge.Visible == true)
        {
            strFOVType = (ddlFOVType.SelectedValue == "-1" ? "" : ddlFOVType.SelectedValue);
            strFOVRate = (txtFOVCharge.Value == "" ? "0.00" : txtFOVCharge.Value);
        }
        
        strInsPer = (txtInsPer.Value.Trim() == "" ? "0.00" : txtInsPer.Value.Trim());
        
        strTSCODDOD = (chkTSCODDOD.Checked == true ? "Y" : "N");
        strTSODA = (chkTSODA.Checked == true ? "Y" : "N");
        strTSVolumetric = (chkTSVolumetric.Checked == true ? "Y" : "N");
        strTSDACC = (chkTSDACC.Checked == true ? "Y" : "N");

        strCODDODCharge = "0.00";
        strCODDODPerOfAmt = "0.00";

        //COD-DOD values
        if (trTSCODChecked.Visible == true)
        {
            strCODDODCharge = (txtCODCharge.Value.Trim() == "" ? "0.00" : txtCODCharge.Value.Trim());
            strCODDODPerOfAmt = (txtCODChargePer.Value.Trim() == "" ? "0.00" : txtCODChargePer.Value.Trim());

            strTOS = (strTOS == "" ? "COD" : strTOS + "," + "COD");
        }
        
        strVolTypeOfMeasure = "";
        strVolConversion = "0.00";

        //Volumetric values
        if (trTSVolumetricChecked.Visible == true)
        {
            strVolTypeOfMeasure = ddlVolMeasure.SelectedValue;
            strVolConversion = txtCFTToKg.Value;

            strTOS = (strTOS == "" ? "VOL" : strTOS + "," + "VOL");
        }
        
        strDACCCharges = "0.00";
        strDACCFreightPer = "0.00";

        //DACC values
        if (trTSDACCChecked.Visible == true)
        {
            strDACCCharges = txtDACCChargeRs.Value;
            strDACCFreightPer = txtDACCChargePer.Value;

            strTOS = (strTOS == "" ? "DACC" : strTOS + "," + "DACC");
        }
        
        //ODA values
        if (chkTSODA.Checked == true)
        {
            strTOS = (strTOS == "" ? "ODA" : strTOS + "," + "ODA");
        }

        strDemAfterDays = (txtDemAfterDays.Value == "" ? "0" : txtDemAfterDays.Value);

        strDemCharge = "";
        strDemChargePerKg = "NULL";

        //Demurrage values
        if (trDemurrageCharges.Visible == true)
        {
            strDemCharge = txtDemChargeRs.Value;
            strDemChargePerKg = txtDemChargePerKg.Value;
        }
        
        //Bill generation details
        strBillGenCode = txtBillGen.Text;
        strBillingInstance = ddlBillingInstance.SelectedValue;

        //Bill submission details
        strBillSubCode = txtBillSubLocation.Text;
        strBillSubCreditLimit = (txtCreditLimit.Value == "" ? "0.00" : txtCreditLimit.Value);

        //Bill collection details
        strBillCollCode = txtBillCollLocation.Text;
        strBillCollCreditDays = (txtCreditDays.Value.Trim() == "" ? "0.00" : txtCreditDays.Value.Trim());

        //SKU-wise YN
        strSKUWise = (chkSKU.Checked == true ? "Y" : "N");

        strSTPaidBy = "";

        if (HidSTApp.Value == "Y")
        {
            strSTPaidBy = ddlSTPaidBy.SelectedValue;
        }
        
        //Docket Applicable Charges values

        //System Charges
        strSCHG01 = (txtSCHG01.Value != "" ? txtSCHG01.Value : "0.0"); //Docket Charges
        strSCHG02 = (txtSCHG02.Value != "" ? txtSCHG02.Value : "0.0"); //Hamali Chages
        strSCHG03 = (txtSCHG03.Value != "" ? txtSCHG03.Value : "0.0"); //Other Charges
        strSCHG04 = (txtSCHG04.Value != "" ? txtSCHG04.Value : "0.0"); //N-Form Charges
        strSCHG05 = (txtSCHG05.Value != "" ? txtSCHG05.Value : "0.0"); //Handling Charges
        strSCHG06 = (txtSCHG06.Value != "" ? txtSCHG06.Value : "0.0"); //Octroi Charges
        //strSCHG07 = (txtSCHG07.Value != "" ? txtSCHG07.Value : "0.0"); //Door Pickup Charges
        //strSCHG08 = (txtSCHG08.Value != "" ? txtSCHG08.Value : "0.0"); //Door Dely Charges
        strSCHG09 = (txtSCHG09.Value != "" ? txtSCHG09.Value : "0.0"); //State Charges
        strSCHG10 = (txtSCHG10.Value != "" ? txtSCHG10.Value : "0.0"); //Holiday Dely Charges
        //strSCHG11 = (txtSCHG11.Value != "" ? txtSCHG11.Value : "0.0"); //FOV Charges
        //strSCHG12 = (txtSCHG12.Value != "" ? txtSCHG12.Value : "0.0"); //COD/DOD Charges
        //strSCHG13 = (txtSCHG13.Value != "" ? txtSCHG13.Value : "0.0"); //DACC Charges
        //strSCHG14 = (txtSCHG14.Value != "" ? txtSCHG14.Value : "0.0"); //Dem Charges
        strSCHG15 = (txtSCHG15.Value != "" ? txtSCHG15.Value : "0.0"); //Mathadi Charges
        strSCHG16 = (txtSCHG16.Value != "" ? txtSCHG16.Value : "0.0"); //Risk Charges
        strSCHG17 = (txtSCHG17.Value != "" ? txtSCHG17.Value : "0.0"); //SurCharges
        strSCHG18 = (txtSCHG18.Value != "" ? txtSCHG18.Value : "0.0"); //Statistical Charges
        strSCHG19 = (txtSCHG19.Value != "" ? txtSCHG19.Value : "0.0"); //ODA Charges
        strSCHG20 = (txtSCHG20.Value != "" ? txtSCHG20.Value : "0.0"); //Fuel Charges
        strSCHG21 = (txtSCHG21.Value != "" ? txtSCHG21.Value : "0.0"); //FOD Charges
        strSCHG22 = (txtSCHG22.Value != "" ? txtSCHG22.Value : "0.0"); //DC DD Charges
        strSCHG23 = (txtSCHG23.Value != "" ? txtSCHG23.Value : "0.0"); //STSRE Charges

        //User Charges
        strUCHG01 = (txtUCHG01.Value != "" ? txtUCHG01.Value : "0.0");
        strUCHG02 = (txtUCHG02.Value != "" ? txtUCHG02.Value : "0.0");
        strUCHG03 = (txtUCHG03.Value != "" ? txtUCHG03.Value : "0.0");
        strUCHG04 = (txtUCHG04.Value != "" ? txtUCHG04.Value : "0.0");
        strUCHG05 = (txtUCHG05.Value != "" ? txtUCHG05.Value : "0.0");
        strUCHG06 = (txtUCHG06.Value != "" ? txtUCHG06.Value : "0.0");
        strUCHG07 = (txtUCHG07.Value != "" ? txtUCHG07.Value : "0.0");
        strUCHG08 = (txtUCHG08.Value != "" ? txtUCHG08.Value : "0.0");
        strUCHG09 = (txtUCHG09.Value != "" ? txtUCHG09.Value : "0.0");
        strUCHG10 = (txtUCHG10.Value != "" ? txtUCHG10.Value : "0.0");

        strMinFreight_Air_Rate = (txtAirRateForFreight.Value == "" ? "" : txtAirRateForFreight.Value);
        strMinFreight_Air_Basis = (ddlAirBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlAirBasisForFreight.SelectedValue + "'");

        strMinFreight_Road_Rate = (txtRoadRateForFreight.Value == "" ? "" : txtRoadRateForFreight.Value);
        strMinFreight_Road_Basis = (ddlRoadBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlRoadBasisForFreight.SelectedValue + "'");

        strMinFreight_Train_Rate = (txtTrainRateForFreight.Value == "" ? "" : txtTrainRateForFreight.Value);
        strMinFreight_Train_Basis = (ddlTrainBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlTrainBasisForFreight.SelectedValue + "'");

        strMinFreight_Express_Rate = (txtExpressRateForFreight.Value == "" ? "" : txtExpressRateForFreight.Value);
        strMinFreight_Express_Basis = (ddlExpressBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlExpressBasisForFreight.SelectedValue + "'");
    }

    private void getNextCustomerContractID()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetNextContractorID";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCustContID = new DataSet();

        sqlDA.Fill(dsCustContID);

        if (dsCustContID.Tables[0].Rows.Count > 0)
        {
            strCustContID = dsCustContID.Tables[0].Rows[0][0].ToString();
        }
        else
        {
            strCustContID = "CN00001";
        }

        sqlConn.Close();
    }
       
    private void prepareXMLStringForCustomerContractHeader()
    {
        strXMLForCustContHeader = "<root><customercontract>" + 
                                  "<contractid>" + strCustContID + "</contractid>" + 
                                  "<custcode>" + HidCustCode.Value + "</custcode>" + 
                                  "<contractcat>" + HidContCat.Value + "</contractcat>" + 
                                  "<custcat>" + HidPartyCat.Value + "</custcat>" + 
                                  "<contracttype>" + "NULL" + "</contracttype>" +
                                  "<contractstartdate>" + HidContDate.Value + "</contractstartdate>" + 
                                  "<contractenddate>" + HidContValidUntil.Value + "</contractenddate>" + 
                                  "<contracteffectivedate>" + HidContEffFromDate.Value + "</contracteffectivedate>" + 
                                  "<custrepresentative>" + HidCustRep.Value + "</custrepresentative>" + 
                                  "<compempname>" + HidCoEmpName.Value + "</compempname>" + 
                                  "<custdesig>" + HidCustRepDesi.Value + "</custdesig>" + 
                                  "<compdesig>" + HidCoEmpDesi.Value + "</compdesig>" + 
                                  "<custwitness>" + HidCustWitness.Value + "</custwitness>" + 
                                  "<compwitness>" + HidCoWitness.Value + "</compwitness>" + 
                                  "<billaddress>" + HidBillAdd.Value + "</billaddress>" + 
                                  "<billcity>" + HidCity.Value + "</billcity>" + 
                                  "<billpin>" + HidPinCode.Value + "</billpin>" + 
                                  "<contractsignloccode>" + HidContSignLoc.Value + "</contractsignloccode>" + 
                                  "<entryby>" + Session["empcd"].ToString() + "</entryby>" + 
                                  "<entrydate>" + System.DateTime.Today.ToString("dd-MMM-yyyy") + "</entrydate>" + 
                                  "<accrep>" + HidAcctRep.Value + "</accrep>" + 
                                  "<st>" + HidSTApp.Value + "</st>" + 
                                  "<paytype>" + "NULL" + "</paytype>" + 
                                  "<addcontractloccode>" + "NULL" + "</addcontractloccode>" + 
                                  "<stpaidby>" + strSTPaidBy + "</stpaidby>" + 
                                  "<sku>" + strSKUWise + "</sku>" + 
                                  "</customercontract></root>";
    }

    private void prepareXMLStringForCustomerContractCharges()
    {
        strXMLForCustContCharges = "<root><customercontract>" + 
                                   "<contractid>" + strCustContID + "</contractid>" + 
                                   "<custcode>" + HidCustCode.Value + "</custcode>" + 
                                   "<roadyn>" + strMTRoad + "</roadyn>" + 
                                   "<expressyn>" + strMTExpress + "</expressyn>" + 
                                   "<airyn>" + strMTAir + "</airyn>" + 
                                   "<railyn>" + strMTTrain + "</railyn>" + 
                                   "<ftlyn>" + strTLFTL + "</ftlyn>" + 
                                   "<sundryyn>" + strTLSundry + "</sundryyn>" + 
                                   "<pickupdelivery>" + strPD + "</pickupdelivery>" + 
                                   "<dpcharge>" + strDPCharge + "</dpcharge>" + 
                                   "<dpchargeperkg>" + strDPChargePerKg + "</dpchargeperkg>" + 
                                   "<ddcharge>" + strDDCharge + "</ddcharge>" + 
                                   "<ddchargeperkg>" + strDDChargePerKg + "</ddchargeperkg>" + 
                                   "<docketcharge>0</docketcharge>" + 
                                   "<hldcharge>" + strSCHG05 + "</hldcharge>" + 
                                   "<fovtype>" + strFOVType + "</fovtype>" + 
                                   "<fovcharge>" + strFOVRate + "</fovcharge>" + 
                                   "<coddodyn>" + strTSCODDOD + "</coddodyn>" + 
                                   "<odayn>" + strTSODA + "</odayn>" + 
                                   "<volyn>" + strTSVolumetric + "</volyn>" + 
                                   "<daccyn>" + strTSDACC + "</daccyn>" + 
                                   "<coddodcharges>" + strCODDODCharge + "</coddodcharges>" + 
                                   "<coddodchargeper>" + strCODDODPerOfAmt + "</coddodchargeper>" + 
                                   "<dacccharges>" + strDACCCharges + "</dacccharges>" + 
                                   "<daccchargeper>" + strDACCFreightPer + "</daccchargeper>" + 
                                   "<demday>" + strDemAfterDays + "</demday>" + 
                                   "<cft2kg>" + strVolConversion + "</cft2kg>" + 
                                   "<demcharges>" + strDemCharge + "</demcharges>" + 
                                   "<demchargeperkg>" + strDemChargePerKg + "</demchargeperkg>" + 
                                   "<octcharge>" + strSCHG06 + "</octcharge>" + 
                                   "<nformcharge>" + strSCHG04 + "</nformcharge>" + 
                                   "<statecharge>" + strSCHG09 + "</statecharge>" + 
                                   "<hlddlycharge>" + strSCHG10 + "</hlddlycharge>" + 
                                   "<billgencode>" + strBillGenCode + "</billgencode>" + 
                                   "<billinginstance>" + strBillingInstance + "</billinginstance>" + 
                                   "<billsubcode>" + strBillSubCode + "</billsubcode>" + 
                                   "<creditlimit>" + strBillSubCreditLimit + "</creditlimit>" + 
                                   "<billcollcode>" + strBillCollCode + "</billcollcode>" + 
                                   "<creditday>" + strBillCollCreditDays + "</creditday>" + 
                                   "<insurancepercentage>" + strInsPer + "</insurancepercentage>" + 
                                   "<voltypeofmeasure>" + strVolTypeOfMeasure + "</voltypeofmeasure>" + 
                                   "<demminfreight>0</demminfreight>" + 
                                   "<mathadicharge>" + strSCHG15 + "</mathadicharge>" + 
                                   "<fodcharge>" + strSCHG21 + "</fodcharge>" + 
                                   "<stcharge>" + strSCHG18 + "</stcharge>" + 
                                   "<airrate>" + strMinFreight_Air_Rate + "</airrate>" + 
                                   "<airbasis>" + strMinFreight_Air_Basis + "</airbasis>" + 
                                   "<roadrate>" + strMinFreight_Road_Rate + "</roadrate>" + 
                                   "<roadbasis>" + strMinFreight_Road_Basis + "</roadbasis>" + 
                                   "<exprate>" + strMinFreight_Express_Rate + "</exprate>" + 
                                   "<expbasis>" + strMinFreight_Express_Basis + "</expbasis>" + 
                                   "<railrate>" + strMinFreight_Train_Rate + "</railrate>" + 
                                   "<railbasis>" + strMinFreight_Train_Basis + "</railbasis>" + 
                                   "<hamalicharge>" + strSCHG02 + "</hamalicharge>" + 
                                   "<otcharge>" + strSCHG03 + "</otcharge>" + 
                                   "<riskcharge>" + strSCHG16 + "</riskcharge>" + 
                                   "<DCDDcharge>" + strSCHG22 + "</DCDDcharge>" + 
                                   "<surcharge>" + strSCHG17 + "</surcharge>" + 
                                   "<stsrecharge>" + strSCHG23 + "</stsrecharge>" + 
                                   "<odacharge>" + strSCHG19 + "</odacharge>" + 
                                   "<fuelcharge>" + strSCHG20 + "</fuelcharge>" + 
                                   "<User_charge_1>" + strUCHG01 + "</User_charge_1>" +
                                   "<User_charge_2>" + strUCHG02 + "</User_charge_2>" +
                                   "<User_charge_3>" + strUCHG03 + "</User_charge_3>" +
                                   "<User_charge_4>" + strUCHG04 + "</User_charge_4>" +
                                   "<User_charge_5>" + strUCHG05 + "</User_charge_5>" +
                                   "<User_charge_6>" + strUCHG06 + "</User_charge_6>" +
                                   "<User_charge_7>" + strUCHG07 + "</User_charge_7>" +
                                   "<User_charge_8>" + strUCHG08 + "</User_charge_8>" +
                                   "<User_charge_9>" + strUCHG09 + "</User_charge_9>" +
                                   "<User_charge_10>" + strUCHG10 + "</User_charge_10>" + 
                                   "</customercontract></root>";
    }

    private void insertCustomerContractHeaderEntry()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_InsertCustomerContractHeader";

        sqlCommand.Parameters.AddWithValue("@strXML", strXMLForCustContHeader);

        sqlCommand.ExecuteNonQuery();
        
        sqlConn.Close();
    }

    private void insertCustomerContractChargesEntry()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_InsertCustomerContractCharges";

        sqlCommand.Parameters.AddWithValue("@strXML", strXMLForCustContCharges);

        sqlCommand.ExecuteNonQuery();

        sqlConn.Close();
    }

    private bool checkBillingLocation(string strBillingLocationCode)
    {
        if (strBillingLocationCode == "")
        {
            return true;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT locname FROM webx_Location WHERE activeflag='Y' AND loccode = '" + strBillingLocationCode + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    private void PopulateHiddenVars()
    {
        string strSQL = "select * from Webx_CCM_Step1 where Temp_Sr_No = " + HidRandomNo.Value;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCMStep1Data = new DataSet();

        sqlDA.Fill(dsCCMStep1Data);

        if (dsCCMStep1Data.Tables[0].Rows.Count > 0)
        {
            HidCustCode.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustCode"].ToString();
            HidContractID.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContractID"].ToString();
            HidCustCodeName.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustCodeName"].ToString();
            HidContDate.Value = Convert.ToDateTime(dsCCMStep1Data.Tables[0].Rows[0]["ContDate"]).ToString("dd-MMM-yy");
            HidContValidUntil.Value = Convert.ToDateTime(dsCCMStep1Data.Tables[0].Rows[0]["ContValidUntil"]).ToString("dd-MMM-yy");
            HidContEffFromDate.Value = Convert.ToDateTime(dsCCMStep1Data.Tables[0].Rows[0]["ContEffFromDate"]).ToString("dd-MMM-yy");
            HidContSignLoc.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContSignLoc"].ToString();
            HidCustRep.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustRep"].ToString();
            HidCoEmpName.Value = dsCCMStep1Data.Tables[0].Rows[0]["CoEmpName"].ToString();
            HidCustRepDesi.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustRepDesi"].ToString();
            HidCoEmpDesi.Value = dsCCMStep1Data.Tables[0].Rows[0]["CoEmpDesi"].ToString();
            HidCustWitness.Value = dsCCMStep1Data.Tables[0].Rows[0]["CustWitness"].ToString();
            HidCoWitness.Value = dsCCMStep1Data.Tables[0].Rows[0]["CoWitness"].ToString();
            HidBillAdd.Value = dsCCMStep1Data.Tables[0].Rows[0]["BillAdd"].ToString();
            HidCity.Value = dsCCMStep1Data.Tables[0].Rows[0]["City"].ToString();
            HidPinCode.Value = dsCCMStep1Data.Tables[0].Rows[0]["PinCode"].ToString();
            HidPartyCat.Value = dsCCMStep1Data.Tables[0].Rows[0]["PartyCat"].ToString();
            HidContCat.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContCat"].ToString();
            HidSTApp.Value = dsCCMStep1Data.Tables[0].Rows[0]["STApp"].ToString();
            HidAcctRep.Value = dsCCMStep1Data.Tables[0].Rows[0]["AcctRep"].ToString();
        }
        else
        {
            
        }
    }

    private void updateRecordInTempTable()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_UpdateCustomerContractHeaderCharges";

        sqlCommand.Parameters.AddWithValue("@RandomNo", HidRandomNo.Value);
        sqlCommand.Parameters.AddWithValue("@strHeaderXML", strXMLForCustContHeader);
        sqlCommand.Parameters.AddWithValue("@strChargesXML", strXMLForCustContCharges);
        sqlCommand.Parameters.AddWithValue("@MOTAbbr", strMOTAbbr);
        sqlCommand.Parameters.AddWithValue("@MOT", strMOT);
        sqlCommand.Parameters.AddWithValue("@TOL", strTOLAbbr);
        sqlCommand.Parameters.AddWithValue("@PD", strPD);
        sqlCommand.Parameters.AddWithValue("@TOS", strTOS);
        sqlCommand.Parameters.AddWithValue("@BillGenLoc", txtBillGen.Text);
        sqlCommand.Parameters.AddWithValue("@BillSubLoc", txtBillSubLocation.Text);
        sqlCommand.Parameters.AddWithValue("@BillColLoc", txtBillCollLocation.Text);

        sqlCommand.ExecuteNonQuery();

        sqlConn.Close();
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private void updateRecordInActualTable()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "UPDATE WEBX_CUSTCONTRACT_CHARGE SET road_yn = '" + (chkMTRoad.Checked == true ? "Y" : "N") + "', " +
                 "express_yn = '" + (chkMTExpress.Checked == true ? "Y" : "N") + "', " +
                 "air_yn = '" + (chkMTAir.Checked == true ? "Y" : "N") + "', " +
                 "rail_yn = '" + (chkMTTrain.Checked == true ? "Y" : "N") + "', " +
                 "ftl_yn = '" + (chkTLFTL.Checked == true ? "Y" : "N") + "', " +
                 "sundry_yn = '" + (chkTLSundry.Checked == true ? "Y" : "N") + "', " +
                 "pkp_dly = '" + strPD + "', dp_chrg = " + strDPCharge + ", dp_chrg_perkg = " + strDPChargePerKg +
                 ", dd_chrg = " + strDDCharge + ", dd_chrg_perkg = " + strDDChargePerKg + ", " +
                 "dkt_chrg = " + strSCHG01 + ", hld_chrg = " + strSCHG05 + ", fov_type = '" + strFOVType + "', " +
                 "fov_chrg = " + strFOVRate + ", cod_dod_yn = '" + (strTOS.Contains("COD") == true ? "Y" : "N") + "', " +
                 "oda_yn = '" + (strTOS.Contains("ODA") == true ? "Y" : "N") + "', vol_yn = '" + (strTOS.Contains("VOL") == true ? "Y" : "N") + "', " +
                 "dacc_yn = '" + (strTOS.Contains("DACC") == true ? "Y" : "N") + "', cod_chrg_rs = '" + strCODDODCharge + "', " +
                 "cod_chrg_per = " + strCODDODPerOfAmt + ", dacc_chrg_rs = '" + strDACCCharges + "', " +
                 "dacc_chrg_per = " + strDACCFreightPer + ", dem_day = " + (txtDemAfterDays.Value == "" ? "NULL" : txtDemAfterDays.Value) + ", " +
                 "cft2kg = " + strVolConversion + ", dem_chrg_rs = '" + strDemCharge + "', dem_chrg_perkg = " + (strDemChargePerKg == "" ? "NULL" : strDemChargePerKg) + ", " +
                 "oct_chrg = " + strSCHG06 + ", nform_chrg = " + strSCHG04 + ", state_chrg = " + strSCHG09 + ", " +
                 "hld_dlychrg = " + strSCHG10 + ", billgen_loccode = '" + strBillGenCode + "', bill_inst = '" + strBillingInstance + "', " +
                 "billsub_loccode = '" + strBillSubCode + "', credit_limit = " + strBillSubCreditLimit + ", " +
                 "billcol_loccode = '" + strBillCollCode + "', credit_day = " + strBillCollCreditDays + ", tbb_yn = 'N', " +
                 "topay_yn = NULL, paid_yn = NULL, insu_per = " + strInsPer + ", cft_measure = '" + strVolTypeOfMeasure + "', " +
                 "dem_minfrt = 0.00, mathadi_chrg = " + strSCHG15 + ", fod_chrg = " + strSCHG21 + ", st_chrg = " + strSCHG18 + ", " +
                 "air_rate = " + (strMinFreight_Air_Rate == "" ? "NULL" : strMinFreight_Air_Rate) + ", air_bas = " +
                 (strMinFreight_Air_Basis == "" ? "NULL" : strMinFreight_Air_Basis) + ", road_rate = " +
                 (strMinFreight_Road_Rate == "" ? "NULL" : strMinFreight_Road_Rate) + ", road_bas = " + (strMinFreight_Road_Basis == "" ? "NULL" : strMinFreight_Road_Basis) +
                 ", exp_rate = " + (strMinFreight_Express_Rate == "" ? "NULL" : strMinFreight_Express_Rate) + ", " +
                 "exp_bas = " + (strMinFreight_Express_Basis == "" ? "NULL" : strMinFreight_Express_Basis) + ", " +
                 "rail_rate = " + (strMinFreight_Train_Rate == "" ? "NULL" : strMinFreight_Train_Rate) + ", " +
                 "rail_bas = " + (strMinFreight_Train_Basis == "" ? "NULL" : strMinFreight_Train_Basis) + ", " +
                 "Hamali_chrg = " + strSCHG02 + ", otchg = " + strSCHG03 + ", risk_chrg = " + strSCHG16 + ", " +
                 "DC_DD_chrg = " + strSCHG22 + ", surcharge = " + strSCHG17 + ", STSRE_chrg = " + strSCHG23 + ", " +
                 "oda_chrg = " + strSCHG19 + ", fuelchrg = " + strSCHG20 + ", User_chrg_1 = " + strUCHG01 + ", " +
                 "User_chrg_2 = " + strUCHG02 + ", User_chrg_3 = " + strUCHG03 + ", User_chrg_4 = " + strUCHG04 +
                 ", User_chrg_5 = " + strUCHG05 + ", User_chrg_6 = " + strUCHG06 + ", User_chrg_7 = " + strUCHG07 +
                 ", User_chrg_8 = " + strUCHG08 + ", User_chrg_9 = " + strUCHG09 + ", User_chrg_10 = " + strUCHG10 +
                 " WHERE ContractID = '" + HidContractID.Value + "'";        

        SqlCommand sqlCommand1 = new SqlCommand(strSQL, sqlConn);

        sqlCommand1.ExecuteNonQuery();

        strSQL = "UPDATE WEBX_CUSTCONTRACT_HDR SET stax_paidby = " + (ddlSTPaidBy.SelectedValue == "-1" ? "''" : "'" + ddlSTPaidBy.SelectedValue + "'") + " WHERE ContractID = '" + HidContractID.Value + "'";
        sqlCommand1 = null;

        sqlCommand1 = new SqlCommand(strSQL, sqlConn);

        sqlCommand1.ExecuteNonQuery();
    }

    //private void updateCCMStep1()
    //{
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    string strSQL = "UPDATE WebX_CCM_Step1 SET ContractID = '" + strCustContID + "' WHERE Temp_Sr_No = " + HidRandomNo.Value;
    //    SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

    //    sqlCommand.ExecuteNonQuery();
    //}

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

    private void populateInActiveCharges()
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
            for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
            {
                switch (dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString().ToUpper())
                {
                    case "UCHG01":
                        lblUCHG01.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG02":
                        lblUCHG02.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG03":
                        lblUCHG03.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG04":
                        lblUCHG04.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG05":
                        lblUCHG05.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG06":
                        lblUCHG06.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG07":
                        lblUCHG07.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG08":
                        lblUCHG08.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG09":
                        lblUCHG09.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case "UCHG10":
                        lblUCHG10.InnerHtml = dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                }
            }
        }

        sqlConn.Close();
    }

    private void displayData()
    {
        string strSQL = "select * from WebX_CustContract_Charge WHERE ContractId = '" + HidContractID.Value + "'";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            //Mode of Transport
            chkMTAir.Checked = (dsCCM.Tables[0].Rows[0]["air_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkMTTrain.Checked = (dsCCM.Tables[0].Rows[0]["rail_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkMTRoad.Checked = (dsCCM.Tables[0].Rows[0]["road_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkMTExpress.Checked = (dsCCM.Tables[0].Rows[0]["express_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);

            //Type of Load
            chkTLFTL.Checked = (dsCCM.Tables[0].Rows[0]["ftl_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTLSundry.Checked = (dsCCM.Tables[0].Rows[0]["sundry_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);

            //Pickup-Delivery
            chkDD.Checked = dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("DD");
            chkDG.Checked = dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("DG");
            chkGD.Checked = dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("GD");
            chkGG.Checked = dsCCM.Tables[0].Rows[0]["pkp_dly"].ToString().ToUpper().Trim().Contains("GG");

            //Door Pickup Charges
            txtDoorPickupCharge.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg"]).ToString("0.00") : "");
            txtDoorPickupChargePerKg.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg_perkg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dp_chrg_perkg"]).ToString("0.00") : "");

            //Door Delivery Charges
            txtDoorDeliveryCharge.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg"]).ToString("0.00") : "");
            txtDoorDeliveryChargePerKg.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg_perkg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dd_chrg_perkg"]).ToString("0.00") : "");

            //FOV Related
            ddlFOVType.SelectedValue = (dsCCM.Tables[0].Rows[0]["fov_type"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["fov_type"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["fov_type"].ToString());
            txtFOVCharge.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fov_chrg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fov_chrg"]).ToString("0.00") : "");
            txtInsPer.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["insu_per"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["insu_per"]).ToString("0.00") : "");

            //Type of Service
            chkTSCODDOD.Checked = (dsCCM.Tables[0].Rows[0]["cod_dod_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTSODA.Checked = (dsCCM.Tables[0].Rows[0]["oda_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTSVolumetric.Checked = (dsCCM.Tables[0].Rows[0]["vol_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTSDACC.Checked = (dsCCM.Tables[0].Rows[0]["dacc_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);

            //COD/DOD Charges
            if (chkTSCODDOD.Checked == true)
            {
                trTSCODChecked.Visible = true;
                txtCODCharge.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_rs"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_rs"]).ToString("0.00") : "");
                txtCODChargePer.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_per"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cod_chrg_per"]).ToString("0.00") : "");
            }

            //Volumetric Charges
            if (chkTSVolumetric.Checked == true)
            {
                trTSVolumetricChecked.Visible = true;
                ddlVolMeasure.SelectedValue = (dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["cft_measure"].ToString());
                txtCFTToKg.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cft2kg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["cft2kg"]).ToString("0.00") : "");
            }

            //DACC Charges
            if (chkTSDACC.Checked == true)
            {
                trTSDACCChecked.Visible = true;
                txtDACCChargeRs.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_rs"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_rs"]).ToString("0.00") : "");
                txtDACCChargePer.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_per"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dacc_chrg_per"]).ToString("0.00") : "");
            }

            //Demurrage Charges
            txtDemAfterDays.Value = (dsCCM.Tables[0].Rows[0]["dem_day"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["dem_day"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToInt32(dsCCM.Tables[0].Rows[0]["dem_day"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_day"]).ToString() : "");
            txtDemChargeRs.Value = (dsCCM.Tables[0].Rows[0]["dem_chrg_rs"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["dem_chrg_rs"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_rs"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_rs"]).ToString("0.00") : "");
            txtDemChargePerKg.Value = (dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"].ToString().ToUpper().Trim() == "" ? "" : Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"]).ToString("0.00") : "");

            //Bill Generation Location
            txtBillGen.Text = dsCCM.Tables[0].Rows[0]["billgen_loccode"].ToString().ToUpper().Trim();

            //Billimg Instance
            ddlBillingInstance.SelectedValue = dsCCM.Tables[0].Rows[0]["bill_inst"].ToString();

            //Bill Submission Location
            txtBillSubLocation.Text = dsCCM.Tables[0].Rows[0]["billsub_loccode"].ToString().ToUpper().Trim();

            //Total Credit Limit in Rs.
            txtCreditLimit.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["credit_limit"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["credit_limit"]).ToString("0.00") : "");

            //Bill Collection Location
            txtBillCollLocation.Text = dsCCM.Tables[0].Rows[0]["billcol_loccode"].ToString().ToUpper().Trim();

            //Total Credit Limit in Days
            txtCreditDays.Value = (Convert.ToInt32(dsCCM.Tables[0].Rows[0]["credit_day"]) > 0 ? dsCCM.Tables[0].Rows[0]["credit_day"].ToString() : "");

            //SKU Wise Y/N
            chkSKU.Checked = (dsCCM.Tables[0].Rows[0]["sku_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);

            //Service Tax Paid By
            ddlSTPaidBy.SelectedValue = getSTPaidBy();

            //Charges
            txtSCHG01.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["dkt_chrg"]).ToString("0.0");
            txtSCHG02.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["Hamali_chrg"]).ToString("0.0");
            txtSCHG03.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["otchg"]).ToString("0.0");
            txtSCHG04.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["nform_chrg"]).ToString("0.0");
            txtSCHG05.Value =Convert.ToDouble( dsCCM.Tables[0].Rows[0]["hld_chrg"]).ToString("0.0");
            txtSCHG06.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["oct_chrg"]).ToString("0.0");
            txtSCHG09.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["state_chrg"]).ToString("0.0");
            txtSCHG10.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["hld_dlychrg"]).ToString("0.0");
            txtSCHG15.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["mathadi_chrg"]).ToString("0.0");
            txtSCHG16.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["risk_chrg"]).ToString("0.0");
            txtSCHG17.Value =Convert.ToDouble( dsCCM.Tables[0].Rows[0]["surcharge"]).ToString("0.0");
            txtSCHG18.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["st_chrg"]).ToString("0.0");
            txtSCHG19.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["oda_chrg"]).ToString("0.0");
            txtSCHG20.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fuelchrg"]).ToString("0.0");
            txtSCHG21.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["fod_chrg"]).ToString("0.0");
            txtSCHG22.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["DC_DD_chrg"]).ToString("0.0");
            txtSCHG23.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["STSRE_chrg"]).ToString("0.0");

            txtUCHG01.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_1"]).ToString("0.0");
            txtUCHG02.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_2"]).ToString("0.0");
            txtUCHG03.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_3"]).ToString("0.0");
            txtUCHG04.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_4"]).ToString("0.0");
            txtUCHG05.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_5"]).ToString("0.0");
            txtUCHG06.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_6"]).ToString("0.0");
            txtUCHG07.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_7"]).ToString("0.0");
            txtUCHG08.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_8"]).ToString("0.0");
            txtUCHG09.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_9"]).ToString("0.0");
            txtUCHG10.Value = Convert.ToDouble(dsCCM.Tables[0].Rows[0]["User_chrg_10"]).ToString("0.0");

            //Minimum Freight
            txtAirRateForFreight.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["air_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["air_rate"]).ToString("0.00") : "");
            txtRoadRateForFreight.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["road_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["road_rate"]).ToString("0.00") : "");
            txtTrainRateForFreight.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["rail_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["rail_rate"]).ToString("0.00") : "");
            txtExpressRateForFreight.Value = (Convert.ToDouble(dsCCM.Tables[0].Rows[0]["exp_rate"]) > 0 ? Convert.ToDouble(dsCCM.Tables[0].Rows[0]["exp_rate"]).ToString("0.00") : "");

            ddlAirBasisForFreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["air_bas"].ToString());
            ddlRoadBasisForFreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["road_bas"].ToString());
            ddlTrainBasisForFreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["rail_bas"].ToString());
            ddlExpressBasisForFreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["exp_bas"].ToString());
        }
    }

    private string getSTPaidBy()
    {
        string strSTPaidBy = "";

        string strSQL = "select stax_paidby from WEBX_CUSTCONTRACT_HDR where ContractId = '" + HidContractID.Value + "'";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsCCM = new DataSet();
        sqlDA.Fill(dsCCM);

        if (dsCCM.Tables[0].Rows.Count > 0)
        {
            strSTPaidBy = (dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString().ToUpper().Trim() == "" ? "-1" : dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString());
        }

        return strSTPaidBy;
    }
}

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

public partial class AddCustomerContractStep2 : System.Web.UI.Page
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
    public static bool blnAppForCODDOD;

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
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Populate session variables with control values
        populateSession();
        //Get New (Next) Customer Contract ID
        getNextCustomerContractID();
        //Prepare XML string for inserting Customer Contract Header table data
        prepareXMLStringForCustomerContractHeader();
        //Insert Customer Contract Header table entry
        //insertCustomerContractHeaderEntry();
        //Prepare XML string for inserting Customer Contract Header table data
        prepareXMLStringForCustomerContractCharges();
        //Insert Customer Contract Charges table entry in Temp Table
        //insertCustomerContractChargesEntry();

        //Update WebX_CCM_Step1 Table for Contract ID
        updateCCMStep1();

        insertRecordInTempTable();
        
        //Insert in Actual Tables
        insertRecordInActualTable();
        
        if (chkTLSundry.Checked == true)
        {
            Response.Redirect("AddCCMStep3FreightSundry.aspx?TL=" + HidSUNDRY.Value + "&Random=" + HidRandomNo.Value + "&FTL=" + (chkTLFTL.Checked == true ? HidFTL.Value : "") + "&ODA=" + (chkTSODA.Checked == true ? "Y" : "N"));
        }
        else
        {
            Response.Redirect("AddCCMStep3FreightFTL.aspx?TL=" + HidFTL.Value + "&Random=" + HidRandomNo.Value + "&ODA=" + (chkTSODA.Checked == true ? "Y" : "N"));
        }
    }

    protected void txtBillCollLocation_TextChanged(object sender, EventArgs e)
    {
        txtBillCollLocation.Text = txtBillCollLocation.Text.Trim().ToUpper();
        lblErrorBillCollLocation.Visible = (!(checkBillingLocation(txtBillCollLocation.Text)));
        if (lblErrorBillCollLocation.Visible == true)
        {
            txtBillCollLocation.Focus();
        }
    }

    protected void txtBillSubLocation_TextChanged(object sender, EventArgs e)
    {
        txtBillSubLocation.Text = txtBillSubLocation.Text.Trim().ToUpper();
        lblErrorBillSubLocation.Visible = (!(checkBillingLocation(txtBillSubLocation.Text)));
        if (lblErrorBillSubLocation.Visible == true)
        {
            txtBillSubLocation.Focus();
        }
    }

    protected void txtBillGen_TextChanged(object sender, EventArgs e)
    {
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

    //protected void chkTSCODDOD_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (HidCODDODApp.Value == "Y")
    //    {
    //        trTSCODChecked.Visible = chkTSCODDOD.Checked;
    //    }
    //}

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
            strVolConversion = (txtCFTToKg.Value == "" ? "0.00" : txtCFTToKg.Value);

            strTOS = (strTOS == "" ? "VOL" : strTOS + "," + "VOL");
        }
        
        strDACCCharges = "0.00";
        strDACCFreightPer = "0.00";

        //DACC values
        if (trTSDACCChecked.Visible == true)
        {
            strDACCCharges = (txtDACCChargeRs.Value == "" ? "0.00" : txtDACCChargeRs.Value);
            strDACCFreightPer = (txtDACCChargePer.Value == "" ? "0.00" : txtDACCChargePer.Value);

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

    private void insertRecordInTempTable()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_InsertCustomerContractHeaderCharges";

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

    private void insertRecordInActualTable()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "Insert into WEBX_CUSTCONTRACT_HDR (ContractId,Custcode,contractcat,custcat,contract_type," +
                        "Contract_Stdate,Contract_Eddate,Contract_Effectdate,Cust_represent,Comp_Empname,CustDesig," +
                        "Comp_Desig,CustWitness,Comp_Witness,Bill_address,Bill_City,Bill_Pin,contract_sign_loccode," +
                        "Entryby,Entrydt,acc_rep,stax_yn,paytype,add_contract_loccode,stax_paidby,SKU_YN) VALUES (" +
                        "'" + strCustContID + "', '" + HidCustCode.Value + "', '" + HidContCat.Value + "', '" +
                        HidPartyCat.Value + "', '" + "" + "', '" + HidContDate.Value + "', '" + HidContValidUntil.Value + "', '" +
                        HidContEffFromDate.Value + "', " + (HidCustRep.Value == "" ? "NULL" : "'" + HidCustRep.Value + "'") +
                        "," + (HidCoEmpName.Value == "" ? "NULL" : "'" + HidCoEmpName.Value + "'") +
                        "," + (HidCustRepDesi.Value == "" ? "NULL" : "'" + HidCustRepDesi.Value + "'") +
                        "," + (HidCoEmpDesi.Value == "" ? "NULL" : "'" + HidCoEmpDesi.Value + "'") +
                        "," + (HidCustWitness.Value == "" ? "NULL" : "'" + HidCustWitness.Value + "'") +
                        "," + (HidCoWitness.Value == "" ? "NULL" : "'" + HidCoWitness.Value + "'") +
                        "," + (HidBillAdd.Value == "" ? "NULL" : "'" + HidBillAdd.Value + "'") +
                        "," + (HidCity.Value == "" ? "NULL" : "'" + HidCity.Value + "'") +
                        "," + (HidPinCode.Value == "" ? "NULL" : "'" + HidPinCode.Value + "'") +
                        "," + (HidContSignLoc.Value == "" ? "NULL" : "'" + HidContSignLoc.Value + "'") +
                        ",'" + Session["empcd"].ToString() + "', '" + System.DateTime.Today.ToString("dd MMM yy") + "'" +
                        "," + (HidAcctRep.Value == "" ? "NULL" : "'" + HidAcctRep.Value + "'") + ",'" + HidSTApp.Value + "', " +
                        "" + "NULL" + ", '" + "" + "', '" + ddlSTPaidBy.SelectedValue.Replace("-1", "") + "', '" + (chkSKU.Checked == true ? "Y" : "N") + "')";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();

        strSQL = "Insert into WEBX_CUSTCONTRACT_CHARGE (ContractId, Custcode, road_yn, express_yn, air_yn, " +
                 "rail_yn, ftl_yn, sundry_yn, pkp_dly, dp_chrg, dp_chrg_perkg, dd_chrg, dd_chrg_perkg, " +
                 "dkt_chrg, hld_chrg, fov_type, fov_chrg, cod_dod_yn, oda_yn, vol_yn, dacc_yn, cod_chrg_rs, " +
                 "cod_chrg_per, dacc_chrg_rs, dacc_chrg_per, dem_day, cft2kg, dem_chrg_rs, dem_chrg_perkg, " +
                 "oct_chrg, nform_chrg, state_chrg, hld_dlychrg, billgen_loccode, bill_inst, billsub_loccode, " +
                 "credit_limit, billcol_loccode, credit_day, tbb_yn, topay_yn, paid_yn, insu_per, cft_measure, " +
                 "dem_minfrt, mathadi_chrg, fod_chrg, st_chrg, air_rate, air_bas, road_rate, road_bas, exp_rate, " +
                 "exp_bas, rail_rate, rail_bas, Hamali_chrg, otchg, risk_chrg, DC_DD_chrg, surcharge, STSRE_chrg, " +
                 "oda_chrg, fuelchrg, User_chrg_1, User_chrg_2, User_chrg_3, User_chrg_4, User_chrg_5, User_chrg_6, " +
                 "User_chrg_7, User_chrg_8, User_chrg_9, User_chrg_10) values ('" +
                 strCustContID + "', '" + HidCustCode.Value + "', '" + (chkMTRoad.Checked == true ? "Y" : "N") + "', '" +
                 (chkMTExpress.Checked == true ? "Y" : "N") + "', '" + (chkMTAir.Checked == true ? "Y" : "N") + "', '" +
                 (chkMTTrain.Checked == true ? "Y" : "N") + "', '" + (chkTLFTL.Checked == true ? "Y" : "N") + "', '" +
                 (chkTLSundry.Checked == true ? "Y" : "N") + "', '" + strPD + "', " + strDPCharge + "," +
                 strDPChargePerKg + "," + strDDCharge + "," + strDDChargePerKg + "," + strSCHG01 + "," + strSCHG05 + ", '" +
                 strFOVType + "', " + strFOVRate + ", '" + (chkTSCODDOD.Checked == true ? "Y" : "N") + "', '" +
                 (chkTSODA.Checked == true ? "Y" : "N") + "', '" + (chkTSVolumetric.Checked == true ? "Y" : "N") + "', '" +
                 (chkTSDACC.Checked == true ? "Y" : "N") + "', '" + strCODDODCharge + "', " + strCODDODPerOfAmt + ", '" +
                 strDACCCharges + "', " + strDACCFreightPer + ", " + (txtDemAfterDays.Value == "" ? "NULL" : txtDemAfterDays.Value) +
                 ", " + strVolConversion + ", '" + strDemCharge + "', " + (strDemChargePerKg == "" ? "NULL" : strDemChargePerKg) + ", " + strSCHG06 + ", " +
                 strSCHG04 + ", " + strSCHG09 + ", " + strSCHG10 + ", '" + strBillGenCode + "', '" + strBillingInstance + "', '" +
                 strBillSubCode + "', " + strBillSubCreditLimit + ", '" + strBillCollCode + "', " + strBillCollCreditDays + ", " +
                 "'N', " + "NULL" + ", " + "NULL" + ", " + strInsPer + ", '" + strVolTypeOfMeasure + "', " +
                 "0.00, " + strSCHG15 + ", " + strSCHG21 + ", " + strSCHG18 + ", " + (strMinFreight_Air_Rate == "" ? "NULL" : strMinFreight_Air_Rate) + ", " +
                 (strMinFreight_Air_Basis == "" ? "NULL" : strMinFreight_Air_Basis) + ", " + (strMinFreight_Road_Rate == "" ? "NULL" : strMinFreight_Road_Rate) + ", " +
                 (strMinFreight_Road_Basis == "" ? "NULL" : strMinFreight_Road_Basis) + ", " + (strMinFreight_Express_Rate == "" ? "NULL" : strMinFreight_Express_Rate) + ", " +
                 (strMinFreight_Express_Basis == "" ? "NULL" : strMinFreight_Express_Basis) + ", " + (strMinFreight_Train_Rate == "" ? "NULL" : strMinFreight_Train_Rate) + ", " +
                 (strMinFreight_Train_Basis == "" ? "NULL" : strMinFreight_Train_Basis) + ", " + strSCHG02 + ", " + strSCHG03 + ", " +
                 strSCHG16 + ", " + strSCHG22 + ", " + strSCHG17 + ", " + strSCHG23 + ", " + strSCHG19 + ", " + strSCHG20 + ", " + strUCHG01 + ", " + strUCHG02 + ", " +
                 strUCHG03 + ", " + strUCHG04 + ", " + strUCHG05 + ", " + strUCHG06 + ", " + strUCHG07 + ", " + strUCHG08 + ", " + strUCHG09 + ", " + strUCHG10 + ")";                         

        SqlCommand sqlCommand1 = new SqlCommand(strSQL, sqlConn);

        sqlCommand1.ExecuteNonQuery();
    }

    private void updateCCMStep1()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "UPDATE WebX_CCM_Step1 SET ContractID = '" + strCustContID + "' WHERE Temp_Sr_No = " + HidRandomNo.Value;
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

        sqlCommand.ExecuteNonQuery();
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
}

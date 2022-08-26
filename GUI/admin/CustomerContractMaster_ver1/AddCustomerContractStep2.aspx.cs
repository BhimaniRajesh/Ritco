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
    static DataTable dt;
    string[] strSCHG = new string[35];


    //static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");
    string contractid = "", custcode = "";
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
   
   
    string strMinFreight_Air_Rate;
    string strMinFreight_Air_Basis;

    string strMinFreight_Road_Rate;
    string strMinFreight_Road_Basis;

    string strMinFreight_Train_Rate;
    string strMinFreight_Train_Basis;

    string strMinFreight_Express_Rate;
    string strMinFreight_Express_Basis;

    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {
        contractid = Request.QueryString["contractid"].ToString();
        custcode = Request.QueryString["custcode"].ToString();

        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }
       
        fn = new MyFunctions();
        lblcustcodename.Text = custcode + fn.Getcustomer(custcode);
       
        if (!IsPostBack)
        {
            //Get Mode of Transport values
            getModeOfTransport();
            //Get Type of Load values
            getTypeOfLoad();
            
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


        
            dt = new DataTable();

            dt.Columns.Add("codeid", typeof(string));
            dt.Columns.Add("codedesc", typeof(string));
            dt.Columns.Add("chargerate", typeof(string));
            dt.Columns.Add("statuscode", typeof(string));
            dt.Columns.Add("codefor", typeof(string));

            DataRow dtr;

            string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='CHG'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            int norows = Convert.ToInt16(cmd.ExecuteScalar());
            for (int i = 0; i < norows + 1; i++)
            {
                dt.Rows.Add();
            }

            int ii = 1;
            sqlstr = "SELECT codeid,codedesc,statuscode,codefor FROM webx_master_general WHERE codetype='CHG'";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                dt.Rows[ii]["codedesc"] = dr["codedesc"].ToString();
                dt.Rows[ii]["codeid"] = dr["codeid"].ToString();
                dt.Rows[ii]["chargerate"] = "0.00";
                dt.Rows[ii]["statuscode"] = dr["statuscode"].ToString();
                dt.Rows[ii]["codefor"] = dr["codefor"].ToString();
                ii++;
            }
            dr.Close();

            grvcharges.DataSource = dt;
            grvcharges.DataBind();
        }


        //ONLY FOR RCPL
        if (Session["client"].ToString().CompareTo("RCPL") == 0)
        {
            trcombus.Style["display"] = "block";
            hdnclient.Value = "RCPL";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Populate session variables with control values
        populateSession();
               
        //Insert in Actual Tables
        insertRecordInActualTable();
        
        if (chkTLSundry.Checked == true)
        {
            Response.Redirect("AddCCMStep3FreightSundry.aspx?TL=" + HidSUNDRY.Value +  "&FTL=" + (chkTLFTL.Checked == true ? HidFTL.Value : "") + "&ODA=" + (chkTSODA.Checked == true ? "Y" : "N") + "&ContractID=" + contractid + "&custcode=" + custcode);
               
        }
        else
        {
            Response.Redirect("AddCCMStep3FreightFTL.aspx?TL=" + HidFTL.Value + "&ODA=" + (chkTSODA.Checked == true ? "Y" : "N") + "&ContractID=" + contractid + "&custcode=" + custcode);
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
        
        
        strFOVRate = "0.00";

        if (trFOVCharge.Visible == true)
        {
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
            strCODDODCharge = (txtCODCharge.Value.Trim() == "" ? "0.00" : txtCODCharge.Value.Trim());
            strCODDODPerOfAmt = (txtCODChargePer.Value.Trim() == "" ? "0.00" : txtCODChargePer.Value.Trim());

            strTOS = (strTOS == "" ? "COD" : strTOS + "," + "COD");
        
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
        
        int i = 0;

        for (i = 0; i < 34; i++)
        {
            strSCHG[i] = "0.00";
        }

        i = 0;
        foreach (GridViewRow grv in grvcharges.Rows)
        {
            TextBox txt = (TextBox)(grv.FindControl("txtcharge"));
            strSCHG[i] = returnDouble(txt.Text).ToString("F2");
            i++;
        }

        strMinFreight_Air_Rate = (txtAirRateForFreight.Value == "" ? "" : txtAirRateForFreight.Value);
        strMinFreight_Air_Basis = (ddlAirBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlAirBasisForFreight.SelectedValue + "'");

        strMinFreight_Road_Rate = (txtRoadRateForFreight.Value == "" ? "" : txtRoadRateForFreight.Value);
        strMinFreight_Road_Basis = (ddlRoadBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlRoadBasisForFreight.SelectedValue + "'");

        strMinFreight_Train_Rate = (txtTrainRateForFreight.Value == "" ? "" : txtTrainRateForFreight.Value);
        strMinFreight_Train_Basis = (ddlTrainBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlTrainBasisForFreight.SelectedValue + "'");

        strMinFreight_Express_Rate = (txtExpressRateForFreight.Value == "" ? "" : txtExpressRateForFreight.Value);
        strMinFreight_Express_Basis = (ddlExpressBasisForFreight.SelectedValue == "-1" ? "" : "'" + ddlExpressBasisForFreight.SelectedValue + "'");
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

    private void insertRecordInActualTable()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();
         SqlTransaction trn = sqlConn.BeginTransaction();

        try
        {

        if (strPD.CompareTo("") == 0)
            strPD = "0.00";
        if (strDPCharge.CompareTo("") == 0)
            strDPCharge = "0.00";
        if (strDPChargePerKg.CompareTo("") == 0)
            strDPChargePerKg = "0.00";
        if (strDDCharge.CompareTo("") == 0)
            strDDCharge = "0.00";
        if (strDDChargePerKg.CompareTo("") == 0)
            strDDChargePerKg = "0.00";

        if (strFOVRate.CompareTo("") == 0)
            strFOVRate = "0.00";

        if (txtFOVCharge.Value.CompareTo("") == 0)
            txtFOVCharge.Value = "0.00";
        if (txtownerrisk.Value.CompareTo("") == 0)
            txtownerrisk.Value = "0.00";
        if (txtcarrierrisk.Value.CompareTo("") == 0)
            txtcarrierrisk.Value = "0.00";

        if (strCODDODCharge.CompareTo("") == 0)
            strCODDODCharge = "0.00";
        if (strCODDODPerOfAmt.CompareTo("") == 0)
            strCODDODPerOfAmt = "0.00";
        if (strDACCCharges.CompareTo("") == 0)
            strDACCCharges = "0.00";
        if (strDACCFreightPer.CompareTo("") == 0)
            strDACCFreightPer = "0.00";

        if (strVolConversion.CompareTo("") == 0)
            strVolConversion = "0.00";

        if (txtAirRateForFreight.Value.CompareTo("") == 0)
            txtAirRateForFreight.Value = "0.00";

        if (txtRoadRateForFreight.Value.CompareTo("") == 0)
            txtRoadRateForFreight.Value = "0.00";

        if (txtTrainRateForFreight.Value.CompareTo("") == 0)
            txtTrainRateForFreight.Value = "0.00";

        if (txtExpressRateForFreight.Value.CompareTo("") == 0)
            txtExpressRateForFreight.Value = "0.00";

        if (txtcommitedbusiness.Value.CompareTo("") == 0)
            txtcommitedbusiness.Value="0.00";

        string sku = "N";
        if (chkSKU.Checked == true)
        {
            sku = "Y";
        }


        // EMPTYING CONTRACT FROM TABLE
        string strSQL = "DELETE FROM webx_custcontract_charge WHERE custcode='" + custcode + "'";
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn, trn);
        sqlCommand.ExecuteNonQuery();

        strSQL = "INSERT INTO webx_custcontract_charge(contractid,custcode,road_yn, express_yn, air_yn,rail_yn,";
        strSQL = strSQL + "ftl_yn,sundry_yn, pkp_dly, dp_chrg, dp_chrg_perkg, dd_chrg, dd_chrg_perkg,";
        strSQL = strSQL + "fov_type, fov_chrg,fov_chrg_owner,fov_chrg_carrier, cod_dod_yn, oda_yn, vol_yn, dacc_yn, cod_chrg_rs, ";
        strSQL = strSQL + "cod_chrg_per, dacc_chrg_rs, dacc_chrg_per, dem_day, cft2kg, dem_chrg_rs, dem_chrg_perkg, "; 
        strSQL = strSQL + "billgen_loccode, bill_inst, billsub_loccode, ";
        //billing subcode
        strSQL = strSQL + "credit_limit, billcol_loccode, credit_day, tbb_yn, topay_yn, paid_yn, insu_per, cft_measure,";
        strSQL = strSQL + "dkt_chrg,Hamali_chrg,OTCHG,nform_chrg,hld_chrg,oct_chrg,state_chrg,hld_dlychrg,";
        // 10 charges
        strSQL = strSQL + "mathadi_chrg,risk_chrg,surcharge,st_chrg,oda_chrg,fuelchrg,";
        // 20 charges
        strSQL = strSQL + "FODCharge,DC_DD_chrg,STSRE_chrg,User_chrg_1,User_chrg_2,User_chrg_3,User_chrg_4,User_chrg_5,User_chrg_6,";
        strSQL = strSQL + "User_chrg_7,User_chrg_8,User_chrg_9,User_chrg_10,";
        strSQL = strSQL + "air_rate,road_rate,rail_rate,exp_rate,air_bas,road_bas,rail_bas,exp_bas,sku_yn";
        strSQL = strSQL + ") VALUES(";


        strSQL = strSQL + "'" + contractid + "','" + custcode + "','" + (chkMTRoad.Checked == true ? "Y" : "N") + "','" + (chkMTExpress.Checked == true ? "Y" : "N") + "','" + (chkMTAir.Checked == true ? "Y" : "N") + "','" + (chkMTTrain.Checked == true ? "Y" : "N") + "','";
        strSQL = strSQL + (chkTLFTL.Checked == true ? "Y" : "N") + "', '" + (chkTLSundry.Checked == true ? "Y" : "N") + "', '" + strPD + "', " + strDPCharge + "," + strDPChargePerKg + "," + strDDCharge + "," + strDDChargePerKg + ",'";
        strSQL = strSQL + ddlFOVType.SelectedValue + "', " + strFOVRate + "," + txtownerrisk.Value + "," + txtcarrierrisk.Value + ",'" + (chkTSCODDOD.Checked == true ? "Y" : "N") + "', '";  // 18
        strSQL = strSQL + (chkTSODA.Checked == true ? "Y" : "N") + "', '" + (chkTSVolumetric.Checked == true ? "Y" : "N") + "','";  //20
        strSQL = strSQL + (chkTSDACC.Checked == true ? "Y" : "N") + "', '" + strCODDODCharge + "', " + strCODDODPerOfAmt + ", '";  // 23
        strSQL = strSQL + strDACCCharges + "', " + strDACCFreightPer + ", " + (txtDemAfterDays.Value == "" ? "NULL" : txtDemAfterDays.Value);  //27
        strSQL = strSQL + ", " + strVolConversion + ", '" + strDemCharge + "', " + (strDemChargePerKg == "" ? "NULL" : strDemChargePerKg) + ", ";
        strSQL = strSQL + "'" + strBillGenCode + "', '" + strBillingInstance + "', '" + strBillSubCode + "', ";
        // billing subcode
        strSQL = strSQL + strBillSubCreditLimit + ", '" + strBillCollCode + "', " + strBillCollCreditDays + ", ";  //
        strSQL = strSQL + "'N', " + "NULL" + ", " + "NULL" + ", " + strInsPer + ", '" + strVolTypeOfMeasure + "', ";
        strSQL = strSQL + strSCHG[1].ToString() + "," + strSCHG[2].ToString() + "," + strSCHG[3].ToString() + ",";
        strSQL = strSQL + strSCHG[4].ToString() + "," + strSCHG[5].ToString() + "," + strSCHG[6].ToString() + ",";
        strSQL = strSQL + strSCHG[9].ToString() + "," + strSCHG[10].ToString() + ",";
        // 10 charges
        strSQL = strSQL + strSCHG[15].ToString() + ",";
        strSQL = strSQL + strSCHG[16].ToString() + "," + strSCHG[17].ToString() + "," + strSCHG[18].ToString() + ",";
        strSQL = strSQL + strSCHG[19].ToString() + "," + strSCHG[20].ToString() + ",";
        // 20 charges
        strSQL = strSQL + strSCHG[21].ToString() + ",";
        strSQL = strSQL + strSCHG[22].ToString() + "," + strSCHG[23].ToString() + ",";
        // 10 user charges
        strSQL = strSQL + strSCHG[24].ToString() + "," + strSCHG[25].ToString() + "," + strSCHG[26].ToString() + "," + strSCHG[27].ToString() + "," + strSCHG[28].ToString() + ",";
        strSQL = strSQL + strSCHG[29].ToString() + "," + strSCHG[30].ToString() + "," + strSCHG[31].ToString() + "," + strSCHG[32].ToString() + "," + strSCHG[33].ToString() + ",";
        strSQL = strSQL + txtAirRateForFreight.Value + "," + txtRoadRateForFreight.Value + "," + txtTrainRateForFreight.Value + "," + txtExpressRateForFreight.Value + ",";
        strSQL = strSQL + "'" + ddlAirBasisForFreight.SelectedValue + "','" + ddlRoadBasisForFreight.SelectedValue + "',";
        strSQL = strSQL + "'" + ddlTrainBasisForFreight.SelectedValue + "','" + ddlExpressBasisForFreight.SelectedValue + "',";
        strSQL = strSQL + "'" + sku + "')";

        SqlCommand sqlCommand1 = new SqlCommand(strSQL, sqlConn,trn);
        sqlCommand1.ExecuteNonQuery();


        strSQL = "UPDATE webx_custcontract_hdr SET stax_paidby='" + cmbstaxpaidby.SelectedValue + "',commitedbusiness=" + txtcommitedbusiness.Value + " WHERE custcode='" + custcode + "'";
        sqlCommand1 = new SqlCommand(strSQL, sqlConn, trn);
        sqlCommand1.ExecuteNonQuery();

    }
    catch (Exception ex)
    {
        trn.Rollback();
        Response.Write("This Contract ID already Exists. Please Refresh the Page and Re-Enter Data... " + ex.Message);
        return;
    }

    trn.Commit();
    }



    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdn = (HiddenField)e.Row.FindControl("hdnstatuscode");
            HiddenField hdncodeid = (HiddenField)e.Row.FindControl("hdncodeid");

            // AT THE TIME OF DEVELOPMENT THIS 6 CHARGES ARE FIXED NOT TO DISPLAY IN CHARGE TABLE SO THEY ARE KEPT UN DISPLAYED
            if (hdncodeid.Value.CompareTo("SCHG07") == 0 || hdncodeid.Value.CompareTo("SCHG08") == 0 || hdncodeid.Value.CompareTo("SCHG11") == 0 || hdncodeid.Value.CompareTo("SCHG12") == 0 || hdncodeid.Value.CompareTo("SCHG13") == 0 || hdncodeid.Value.CompareTo("SCHG14") == 0)
            {
                e.Row.Style["display"] = "none";
            }
            else
            {
                if (hdn.Value.CompareTo("Y") == 0)
                    e.Row.Style["display"] = "block";
                else
                    e.Row.Style["display"] = "none";
            }
        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    // Inner Function convert string to double,(incase string is NULL or blank it handles) and  keep Code clear
    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0";
        }

        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception e)
        {
            return 0.00;
        }
    }


}

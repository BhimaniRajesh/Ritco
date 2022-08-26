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

public partial class CompanyMaster : System.Web.UI.Page
{

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

    string strMOT = "";
    string strMOTAbbr = "";
    string strTOL = "";
    string strTOLAbbr = "";
    string strPD = "";

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

    SqlConnection con;
    MyFunctions fn;

    string custcode = "", contractid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }
        con.Open();

        custcode = Request.QueryString["custcode"];

        fn = new MyFunctions();


        if (!IsPostBack)
        {

            tblmain.Style["display"] = "none";

            trfuelsurcharge.Style["display"] = "none";
            troctroisurcharge.Style["display"] = "none";
            trloading.Style["display"] = "none";
            trunloading.Style["display"] = "none";





            getModeOfTransport();
            //Get Type of Load values
            getTypeOfLoad();

            //Applicable for Type of Service values
            applicableForTypeOfService();

            //Show/hide Door Pickup Charges row
            trDoorPickupCharge.Visible = blnAppForDPCharges;
            //Show/hide Door Delivery Charges row
            trDoorDeliveryCharge.Visible = blnAppForDDCharges;
            //Show/hide FOV Charges row
            trFOVCharge.Visible = blnAppForFOVCharges;
            //Show/hide Demurrage Charges row
            trDemurrageCharges.Visible = blnAppForDemCharges;


            string flag_multipickup = DocketRules.GetDefaultValue("FLAG_MULTI_PICKUPDEL");
            if (flag_multipickup.CompareTo("N") == 0)
            {
                trmultipointpickup.Style["display"] = "none";
                trmultipointdelivery.Style["display"] = "none";
                trloading.Style["display"] = "none";
                trunloading.Style["display"] = "none";
            }



            if (ddlFOVType.SelectedValue == "%")
            {
                tdfovcharge.Style["display"] = "none";
                tdfovpercentage.Style["display"] = "block";
            }
            else
            {
                tdfovcharge.Style["display"] = "block";
                tdfovpercentage.Style["display"] = "none";
            }

        } // ISPOSTBACK

    }


    protected void cmbpaybas_TextChanged(object sender, EventArgs e)
    {
        displayData();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Populate session variables with control values
        populateSession();


        //Insert in Actual Tables
        updateRecordInActualTable();

        string strsundry = "N", strftl = "N", strflatmultipoint = "N", stroda = "N", strflatloading = "N", strflatunloading = "N";
        string strlocloading = "N", strlocunloading = "N", strlocmultipoint = "N";
        if (chkTLSundry.Checked == true)
            strsundry = "Y";
        if (chkTLFTL.Checked == true)
            strftl = "Y";
        if (chkTSODA.Checked == true)
            stroda = "Y";
        if (chkflatmultipointpickup.Checked == true || chkflatmultipointdelivery.Checked == true)
            strflatmultipoint = "Y";
        if (chkflatloading.Checked == true)
            strflatloading = "Y";
        if (chkflatunloading.Checked == true)
            strflatunloading = "Y";
        if (chklocmultipointpickup.Checked == true || chklocmultipointdelivery.Checked == true)
            strlocmultipoint = "Y";
        if (chklocloading.Checked == true)
            strlocloading = "Y";
        if (chklocunloading.Checked == true)
            strlocunloading = "Y";
        if (chkTSODA.Checked == true)
            stroda = "Y";

        if (chkTSODA.Checked == true)
            Response.Redirect("CCMOtherCharges.aspx?custcode=" + cmbpaybas.SelectedValue + "8888&contractid=" + cmbpaybas.SelectedValue + "8888&oda_yn=Y");
        else
            Response.Redirect("CCMOtherCharges.aspx?custcode=" + cmbpaybas.SelectedValue + "8888&contractid=" + cmbpaybas.SelectedValue + "8888&oda_yn=N");
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
                        HidMOTAir.Value = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        chkMTAir.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        lblairname.Text = chkMTAir.Text;
                        lblmodenameair.Text = chkMTAir.Text;
                        break;
                    case 1:

                        HidMOTRoad.Value = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        chkMTRoad.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        lblroadname.Text = chkMTRoad.Text;
                        lblmodenameroad.Text = chkMTRoad.Text;
                        break;
                    case 2:

                        HidMOTTrain.Value = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        chkMTTrain.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        lbltrainname.Text = chkMTTrain.Text;
                        lblmodenametrain.Text = chkMTTrain.Text;
                        break;
                    case 3:
                        HidMOTExpress.Value = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        chkMTExpress.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        lblexpressname.Text = chkMTExpress.Text;
                        lblmodenameexpress.Text = chkMTExpress.Text;
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
                        HidSUNDRY.Value = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
                        chkTLSundry.Text = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case 1:
                        HidFTL.Value = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
                        chkTLFTL.Text = dsTOL.Tables[0].Rows[i]["CodeDesc"].ToString();
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

        HidDACCApp.Value = "N";
        if (dsTOSApplicable.Tables[0].Rows.Count > 0)
        {
            blnAppForCODDOD = (dsTOSApplicable.Tables[0].Rows[0]["CODDODChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDACC = (dsTOSApplicable.Tables[0].Rows[0]["DACCAppYN"].ToString().ToUpper() == "Y" ? true : false);
            HidDACCApp.Value = (blnAppForDACC == true ? "Y" : "N");
            blnAppForDemCharges = (dsTOSApplicable.Tables[0].Rows[0]["DemChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDDCharges = (dsTOSApplicable.Tables[0].Rows[0]["DDChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForDPCharges = (dsTOSApplicable.Tables[0].Rows[0]["DPChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
            blnAppForFOVCharges = (dsTOSApplicable.Tables[0].Rows[0]["FOVChargesAppYN"].ToString().ToUpper() == "Y" ? true : false);
        }

        sqlConn.Close();
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

    private void updateRecordInActualTable()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();

        SqlTransaction trn = sqlConn.BeginTransaction();

        //   string  strUCHG01 = "", strUCHG02 = "", strUCHG03 = "", strUCHG04 = "", strUCHG05 = "", strUCHG06 = "", strUCHG07 = "", strUCHG08 = "", strUCHG09 = "", strUCHG10 = "";

        double[,] arrcharges = new double[5, 100];
        int x = 0;
        foreach (GridViewRow grv in grvcharges.Rows)
        {
            if (x == 0)
            {
                x++; continue;
            }
            TextBox txtaircharge = (TextBox)grv.FindControl("txtaircharge");
            TextBox txtroadcharge = (TextBox)grv.FindControl("txtroadcharge");
            TextBox txttraincharge = (TextBox)grv.FindControl("txtraincharge");
            TextBox txtexpresscharge = (TextBox)grv.FindControl("txtexpresscharge");

            arrcharges[1, x] = returnDouble(txtaircharge.Text);
            arrcharges[2, x] = returnDouble(txtroadcharge.Text);
            arrcharges[3, x] = returnDouble(txttraincharge.Text);
            arrcharges[4, x] = returnDouble(txtexpresscharge.Text);
            x++;
        }


        try
        {


            // EMPTYING CONTRACT FROM TABLE
            string strSQL = "DELETE FROM webx_custcontract_charge";
            strSQL = strSQL + " WHERE custcode='" + cmbpaybas.SelectedValue + "8888'";
            strSQL = strSQL + " AND contractid='" + cmbpaybas.SelectedValue + "8888'";
            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn, trn);
            sqlCommand.ExecuteNonQuery();



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

            if (txtownerrisk.Value.CompareTo("") == 0)
                txtownerrisk.Value = "0.00";

            if (txtcarrierrisk.Value.CompareTo("") == 0)
                txtcarrierrisk.Value = "0.00";

            if (strFOVRate.CompareTo("") == 0)
                strFOVRate = "0.00";

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


            if (txtairrateforfreight.Text.CompareTo("") == 0)
                txtairrateforfreight.Text = "0.00";

            if (txtroadrateforfreight.Text.CompareTo("") == 0)
                txtroadrateforfreight.Text = "0.00";

            if (txttrainrateforfreight.Text.CompareTo("") == 0)
                txttrainrateforfreight.Text = "0.00";

            if (txttrainrateforfreight.Text.CompareTo("") == 0)
                txttrainrateforfreight.Text = "0.00";

            if (txtminfuelsurchargeair.Text.CompareTo("") == 0)
                txtminfuelsurchargeair.Text = "0.00";

            if (txtmaxfuelsurchargeair.Text.CompareTo("") == 0)
                txtmaxfuelsurchargeair.Text = "0.00";

            if (txtminfuelsurchargeroad.Text.CompareTo("") == 0)
                txtminfuelsurchargeroad.Text = "0.00";

            if (txtmaxfuelsurchargeroad.Text.CompareTo("") == 0)
                txtmaxfuelsurchargeroad.Text = "0.00";

            if (txtminfuelsurchargetrain.Text.CompareTo("") == 0)
                txtminfuelsurchargetrain.Text = "0.00";

            if (txtmaxfuelsurchargetrain.Text.CompareTo("") == 0)
                txtmaxfuelsurchargetrain.Text = "0.00";

            if (txtminfuelsurchargeexpress.Text.CompareTo("") == 0)
                txtminfuelsurchargeexpress.Text = "0.00";

            if (txtmaxfuelsurchargeexpress.Text.CompareTo("") == 0)
                txtmaxfuelsurchargeexpress.Text = "0.00";


            if (txtfuelsurchargeair.Text.CompareTo("") == 0)
                txtfuelsurchargeair.Text = "0.00";

            if (txtfuelsurchargeroad.Text.CompareTo("") == 0)
                txtfuelsurchargeroad.Text = "0.00";

            if (txtfuelsurchargetrain.Text.CompareTo("") == 0)
                txtfuelsurchargetrain.Text = "0.00";

            if (txtfuelsurchargeexpress.Text.CompareTo("") == 0)
                txtfuelsurchargeexpress.Text = "0.00";



            if (chkfuelsurcharge.Checked == false)
            {
                txtminfuelsurchargeair.Text = "0.00";
                txtmaxfuelsurchargeair.Text = "0.00";
                txtfuelsurchargeair.Text = "0.00";

                txtminfuelsurchargeroad.Text = "0.00";
                txtmaxfuelsurchargeroad.Text = "0.00";
                txtfuelsurchargeroad.Text = "0.00";

                txtminfuelsurchargetrain.Text = "0.00";
                txtmaxfuelsurchargetrain.Text = "0.00";
                txtfuelsurchargetrain.Text = "0.00";

                txtminfuelsurchargeexpress.Text = "0.00";
                txtmaxfuelsurchargeexpress.Text = "0.00";
                txtfuelsurchargeexpress.Text = "0.00";
            }

            if (chkoctroisurcharge.Checked == false)
            {
                txtminoctroisurcharge.Text = "0.00";
                txtmaxoctroisurcharge.Text = "0.00";
                txtoctroisurchargerate.Text = "0.00";
            }

            string sku = "N";
            if (chkSKU.Checked == true)
                sku = "Y";


            if (chkflatmultipointpickup.Checked == false && chklocmultipointpickup.Checked == false)
            {
                chkflatloading.Checked = false;
                chklocloading.Checked = false;
            }

            if (chkflatmultipointdelivery.Checked == false && chklocmultipointdelivery.Checked == false)
            {
                chkflatunloading.Checked = false;
                chklocunloading.Checked = false;
            }

            txtairrateforfreight.Text = txtairrateforfreight.Text.CompareTo("") == 0 ? "0.00" : txtairrateforfreight.Text;
            txtroadrateforfreight.Text = txtroadrateforfreight.Text.CompareTo("") == 0 ? "0.00" : txtroadrateforfreight.Text;
            txttrainrateforfreight.Text = txttrainrateforfreight.Text.CompareTo("") == 0 ? "0.00" : txttrainrateforfreight.Text;
            txtexpressrateforfreight.Text = txtexpressrateforfreight.Text.CompareTo("") == 0 ? "0.00" : txtexpressrateforfreight.Text;

            txtminsubtotalair.Text = txtminsubtotalair.Text.CompareTo("") == 0 ? "0.00" : txtminsubtotalair.Text;
            txtminsubtotalroad.Text = txtminsubtotalroad.Text.CompareTo("") == 0 ? "0.00" : txtminsubtotalroad.Text;
            txtminsubtotaltrain.Text = txtminsubtotaltrain.Text.CompareTo("") == 0 ? "0.00" : txtminsubtotaltrain.Text;
            txtminsubtotalexpress.Text = txtminsubtotalexpress.Text.CompareTo("") == 0 ? "0.00" : txtminsubtotalexpress.Text;

            txtsubtotallowerlimair.Text = txtsubtotallowerlimair.Text.CompareTo("") == 0 ? "0.00" : txtsubtotallowerlimair.Text;
            txtsubtotallowerlimroad.Text = txtsubtotallowerlimroad.Text.CompareTo("") == 0 ? "0.00" : txtsubtotallowerlimroad.Text;
            txtsubtotallowerlimtrain.Text = txtsubtotallowerlimtrain.Text.CompareTo("") == 0 ? "0.00" : txtsubtotallowerlimtrain.Text;
            txtsubtotallowerlimexpress.Text = txtsubtotallowerlimexpress.Text.CompareTo("") == 0 ? "0.00" : txtsubtotallowerlimexpress.Text;

            txtsubtotalupperlimair.Text = txtsubtotalupperlimair.Text.CompareTo("") == 0 ? "0.00" : txtsubtotalupperlimair.Text;
            txtsubtotalupperlimroad.Text = txtsubtotalupperlimroad.Text.CompareTo("") == 0 ? "0.00" : txtsubtotalupperlimroad.Text;
            txtsubtotalupperlimtrain.Text = txtsubtotalupperlimtrain.Text.CompareTo("") == 0 ? "0.00" : txtsubtotalupperlimtrain.Text;
            txtsubtotalupperlimexpress.Text = txtsubtotalupperlimexpress.Text.CompareTo("") == 0 ? "0.00" : txtsubtotalupperlimexpress.Text;


            txtminfreightrateair.Text = txtminfreightrateair.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateair.Text;
            txtminfreightrateroad.Text = txtminfreightrateroad.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateroad.Text;
            txtminfreightratetrain.Text = txtminfreightratetrain.Text.CompareTo("") == 0 ? "0.00" : txtminfreightratetrain.Text;
            txtminfreightrateexpress.Text = txtminfreightrateexpress.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateexpress.Text;

            txtminfreightratelowerlimair.Text = txtminfreightratelowerlimair.Text.CompareTo("") == 0 ? "0.00" : txtminfreightratelowerlimair.Text;
            txtminfreightratelowerlimroad.Text = txtminfreightratelowerlimroad.Text.CompareTo("") == 0 ? "0.00" : txtminfreightratelowerlimroad.Text;
            txtminfreightratelowerlimtrain.Text = txtminfreightratelowerlimtrain.Text.CompareTo("") == 0 ? "0.00" : txtminfreightratelowerlimtrain.Text;
            txtminfreightratelowerlimexpress.Text = txtminfreightratelowerlimexpress.Text.CompareTo("") == 0 ? "0.00" : txtminfreightratelowerlimexpress.Text;

            txtminfreightrateupperlimair.Text = txtminfreightrateupperlimair.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateupperlimair.Text;
            txtminfreightrateupperlimroad.Text = txtminfreightrateupperlimroad.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateupperlimroad.Text;
            txtminfreightrateupperlimtrain.Text = txtminfreightrateupperlimtrain.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateupperlimtrain.Text;
            txtminfreightrateupperlimexpress.Text = txtminfreightrateupperlimexpress.Text.CompareTo("") == 0 ? "0.00" : txtminfreightrateupperlimexpress.Text;


            strSQL = "INSERT INTO webx_custcontract_charge(custcode,contractid,road_yn, express_yn, air_yn,rail_yn,";
            strSQL = strSQL + "ftl_yn,sundry_yn, pkp_dly, dp_chrg, dp_chrg_perkg, dd_chrg, dd_chrg_perkg,";
            strSQL = strSQL + "risktype,fov_type, fov_chrg,fov_chrg_owner,fov_chrg_carrier, cod_dod_yn, oda_yn, vol_yn, dacc_yn, cod_chrg_rs, ";
            strSQL = strSQL + "cod_chrg_per, dacc_chrg_rs, dacc_chrg_per, dem_day, cft2kg, dem_chrg_rs, dem_chrg_perkg, ";
            strSQL = strSQL + "billgen_loccode, bill_inst, billsub_loccode,stax_paidby, ";
            //billing subcode
            strSQL = strSQL + "credit_limit, billcol_loccode, credit_day, tbb_yn, topay_yn, paid_yn, insu_per, cft_measure,";
            strSQL = strSQL + "air_rate,road_rate,rail_rate,exp_rate,air_bas,road_bas,rail_bas,exp_bas,sku_yn,";
            // min charges over
            strSQL = strSQL + "flatmultipickup_yn,locmultipickup_yn,";
            strSQL = strSQL + "flatmultidelivery_yn,locmultidelivery_yn,";
            strSQL = strSQL + "flatloading_yn,locloading_yn,flatunloading_yn,locunloading_yn,";
            strSQL = strSQL + "diesel_hike_yn,min_fuelsurchrgair,max_fuelsurchrgair,fuelsurchrgbasair,air_fuelsurchrg,";
            strSQL = strSQL + "min_fuelsurchrgroad,max_fuelsurchrgroad,fuelsurchrgbasroad,road_fuelsurchrg,";
            strSQL = strSQL + "min_fuelsurchrgtrain,max_fuelsurchrgtrain,fuelsurchrgbastrain,train_fuelsurchrg,";
            strSQL = strSQL + "min_fuelsurchrgexpress,max_fuelsurchrgexpress,fuelsurchrgbasexpress,express_fuelsurchrg,";
            // fuel surcharge over
            strSQL = strSQL + "oct_sur_yn,min_oct_sur,max_oct_sur,oct_sur_bas,rate_oct_sur,";
            // Tarrif Flag & Rates
            strSQL = strSQL + "min_freight_type,";
            strSQL = strSQL + "min_freight_percent_yn,min_subtotal_percent_yn,";
            strSQL = strSQL + "min_subtotal_air,min_subtotal_road,min_subtotal_train,min_subtotal_express,";
            strSQL = strSQL + "lowlim_subtotal_air,lowlim_subtotal_road,lowlim_subtotal_train,lowlim_subtotal_express,";
            strSQL = strSQL + "upplim_subtotal_air,upplim_subtotal_road,upplim_subtotal_train,upplim_subtotal_express,";
            strSQL = strSQL + "min_freightrate_air,min_freightrate_road,min_freightrate_train,min_freightrate_express,";
            strSQL = strSQL + "lowlim_freightrate_air,lowlim_freightrate_road,lowlim_freightrate_train,lowlim_freightrate_express,";
            strSQL = strSQL + "upplim_freightrate_air,upplim_freightrate_road,upplim_freightrate_train,upplim_freightrate_express";

            strSQL = strSQL + ") VALUES(";
            strSQL = strSQL + "'" + cmbpaybas.SelectedValue + "8888','" + cmbpaybas.SelectedValue + "8888',";
            strSQL = strSQL + "'" + (chkMTRoad.Checked == true ? "Y" : "N") + "','" + (chkMTExpress.Checked == true ? "Y" : "N") + "','" + (chkMTAir.Checked == true ? "Y" : "N") + "','" + (chkMTTrain.Checked == true ? "Y" : "N") + "','";
            strSQL = strSQL + (chkTLFTL.Checked == true ? "Y" : "N") + "', '" + (chkTLSundry.Checked == true ? "Y" : "N") + "', '" + strPD + "', " + strDPCharge + "," + strDPChargePerKg + "," + strDDCharge + "," + strDDChargePerKg + ",'";
            strSQL = strSQL + optrisktype.SelectedValue + "','";
            strSQL = strSQL + ddlFOVType.SelectedValue + "', " + strFOVRate + "," + txtownerrisk.Value + "," + txtcarrierrisk.Value + ",'" + (chkTSCODDOD.Checked == true ? "Y" : "N") + "', '";  // 18
            strSQL = strSQL + (chkTSODA.Checked == true ? "Y" : "N") + "', '" + (chkTSVolumetric.Checked == true ? "Y" : "N") + "','";  //20
            strSQL = strSQL + (chkTSDACC.Checked == true ? "Y" : "N") + "', '" + strCODDODCharge + "', " + strCODDODPerOfAmt + ", '";  // 23
            strSQL = strSQL + strDACCCharges + "', " + strDACCFreightPer + ", " + (txtDemAfterDays.Value == "" ? "NULL" : txtDemAfterDays.Value);  //27
            strSQL = strSQL + ", " + strVolConversion + ", '" + strDemCharge + "', " + (strDemChargePerKg == "" ? "NULL" : strDemChargePerKg) + ", ";
            strSQL = strSQL + "'" + strBillGenCode + "', '" + strBillingInstance + "', '" + strBillSubCode + "','" + cmbstaxpaidby.SelectedValue + "',";
            // billing subcode
            strSQL = strSQL + strBillSubCreditLimit + ", '" + strBillCollCode + "', " + strBillCollCreditDays + ", ";  //
            strSQL = strSQL + "'N', " + "NULL" + ", " + "NULL" + ", " + strInsPer + ", '" + strVolTypeOfMeasure + "', ";

            strSQL = strSQL + txtairrateforfreight.Text + "," + txtroadrateforfreight.Text + "," + txttrainrateforfreight.Text + "," + txtexpressrateforfreight.Text + ",";
            strSQL = strSQL + "'" + ddlairbasisforfreight.SelectedValue + "','" + ddlroadbasisforfreight.SelectedValue + "',";
            strSQL = strSQL + "'" + ddltrainbasisforfreight.SelectedValue + "','" + ddlexpressbasisforfreight.SelectedValue + "',";
            strSQL = strSQL + "'" + sku + "',";
            // mincharges over
            strSQL = strSQL + "'" + (chkflatmultipointpickup.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chklocmultipointpickup.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chkflatmultipointdelivery.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chklocmultipointdelivery.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chkflatloading.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chklocloading.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chkflatunloading.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chklocunloading.Checked == true ? "Y" : "N") + "',";
            // multipoint,loading,unloading over



            strSQL = strSQL + "'" + (chkfuelsurcharge.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + txtminfuelsurchargeair.Text.Trim() + ",";
            strSQL = strSQL + txtmaxfuelsurchargeair.Text.Trim() + ",";
            strSQL = strSQL + "'" + cmbfuelsurchargebasair.SelectedValue.Trim() + "',";
            strSQL = strSQL + txtfuelsurchargeair.Text.Trim() + ",";
            strSQL = strSQL + txtminfuelsurchargeroad.Text.Trim() + ",";
            strSQL = strSQL + txtmaxfuelsurchargeroad.Text.Trim() + ",";
            strSQL = strSQL + "'" + cmbfuelsurchargebasroad.SelectedValue.Trim() + "',";
            strSQL = strSQL + txtfuelsurchargeroad.Text.Trim() + ",";
            strSQL = strSQL + txtminfuelsurchargetrain.Text.Trim() + ",";
            strSQL = strSQL + txtmaxfuelsurchargetrain.Text.Trim() + ",";
            strSQL = strSQL + "'" + cmbfuelsurchargebastrain.SelectedValue.Trim() + "',";
            strSQL = strSQL + txtfuelsurchargetrain.Text.Trim() + ",";
            strSQL = strSQL + txtminfuelsurchargeexpress.Text.Trim() + ",";
            strSQL = strSQL + txtmaxfuelsurchargeexpress.Text.Trim() + ",";
            strSQL = strSQL + "'" + cmbfuelsurchargebasexpress.SelectedValue.Trim() + "',";
            strSQL = strSQL + txtfuelsurchargeexpress.Text.Trim() + ",";
            // fuel surchare over
            //oct_sur_yn,min_oct_sur,max_oct_sur,oct_sur_bas,rate_oct_sur
            strSQL = strSQL + "'" + (chkoctroisurcharge.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + txtminoctroisurcharge.Text.Trim() + ",";
            strSQL = strSQL + txtmaxoctroisurcharge.Text.Trim() + ",";
            strSQL = strSQL + "'" + cmboctroisurchargebas.SelectedValue + "',";
            strSQL = strSQL + txtoctroisurchargerate.Text.Trim() + ",";
            // Tarrif Rates
            strSQL = strSQL + "'" + optminfreighttype.SelectedValue + "',";
            strSQL = strSQL + "'" + (chkapplyfreight.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + "'" + (chkapplysubtotal.Checked == true ? "Y" : "N") + "',";
            strSQL = strSQL + txtminsubtotalair.Text.Trim() + "," + txtminsubtotalroad.Text.Trim() + ",";
            strSQL = strSQL + txtminsubtotaltrain.Text.Trim() + "," + txtminsubtotalexpress.Text.Trim() + ",";
            strSQL = strSQL + txtsubtotallowerlimair.Text.Trim() + "," + txtsubtotallowerlimroad.Text.Trim() + ",";
            strSQL = strSQL + txtsubtotallowerlimtrain.Text.Trim() + "," + txtsubtotallowerlimexpress.Text.Trim() + ",";
            strSQL = strSQL + txtsubtotalupperlimair.Text.Trim() + "," + txtsubtotalupperlimroad.Text.Trim() + ",";
            strSQL = strSQL + txtsubtotalupperlimtrain.Text.Trim() + "," + txtsubtotalupperlimexpress.Text.Trim() + ",";

            strSQL = strSQL + txtminfreightrateair.Text.Trim() + "," + txtminfreightrateroad.Text.Trim() + ",";
            strSQL = strSQL + txtminfreightratetrain.Text.Trim() + "," + txtminfreightrateexpress.Text.Trim() + ",";
            strSQL = strSQL + txtminfreightratelowerlimair.Text.Trim() + "," + txtminfreightratelowerlimroad.Text.Trim() + ",";
            strSQL = strSQL + txtminfreightratelowerlimtrain.Text.Trim() + "," + txtminfreightratelowerlimexpress.Text.Trim() + ",";
            strSQL = strSQL + txtminfreightrateupperlimair.Text.Trim() + "," + txtminfreightrateupperlimroad.Text.Trim() + ",";
            strSQL = strSQL + txtminfreightrateupperlimtrain.Text.Trim() + "," + txtminfreightrateupperlimexpress.Text.Trim() + ")";
            SqlCommand sqlCommand1 = new SqlCommand(strSQL, sqlConn, trn);

            sqlCommand1.ExecuteNonQuery();


        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Updation Error&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        trn.Commit();
    }

    private void displayData()
    {
        tblmain.Style["display"] = "block";

        if (cmbpaybas.SelectedValue.CompareTo("P02") != 0)
        {
            trbillgen.Style["display"] = "none";
            lblbillsubname.Style["display"] = "none";
            txtBillSubLocation.Style["display"] = "none";
            lblbillcolname.Style["display"] = "none";
            txtBillCollLocation.Style["display"] = "none";
        }
        else
        {
            trbillgen.Style["display"] = "block";
            lblbillsubname.Style["display"] = "block";
            txtBillSubLocation.Style["display"] = "block";
            lblbillcolname.Style["display"] = "block";
            txtBillCollLocation.Style["display"] = "block";
        }

        DataTable dt;
        string strSQL = "SELECT * FROM webx_custcontract_charge";
        strSQL = strSQL + " WHERE custcode= '" + cmbpaybas.SelectedValue + "8888'";
        strSQL = strSQL + " AND contractid= '" + cmbpaybas.SelectedValue + "8888'";
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
            txtDoorPickupCharge.Value = dsCCM.Tables[0].Rows[0]["dp_chrg"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtDoorPickupChargePerKg.Value = dsCCM.Tables[0].Rows[0]["dp_chrg_perkg"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Door Delivery Charges
            txtDoorDeliveryCharge.Value = dsCCM.Tables[0].Rows[0]["dd_chrg"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtDoorDeliveryChargePerKg.Value = dsCCM.Tables[0].Rows[0]["dd_chrg_perkg"].ToString().ToUpper().Trim().Replace("NULL", "");

            //FOV Related
            try
            {
                ddlFOVType.SelectedValue = dsCCM.Tables[0].Rows[0]["fov_type"].ToString().ToUpper().Trim();
            }
            catch (Exception ex) { }
            if (ddlFOVType.SelectedValue.CompareTo("RS") == 0)
            {
                tdfovpercentage.Style["display"] = "none";
                tdfovcharge.Style["display"] = "block";
            }
            else
            {
                tdfovpercentage.Style["display"] = "block";
                tdfovcharge.Style["display"] = "none";
            }

            txtFOVCharge.Value = dsCCM.Tables[0].Rows[0]["fov_chrg"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtownerrisk.Value = dsCCM.Tables[0].Rows[0]["fov_chrg_owner"].ToString().ToUpper().Trim().Replace("NULL", "0");
            txtcarrierrisk.Value = dsCCM.Tables[0].Rows[0]["fov_chrg_carrier"].ToString().ToUpper().Trim().Replace("NULL", "0");
            txtInsPer.Value = dsCCM.Tables[0].Rows[0]["insu_per"].ToString().ToUpper().Trim().Replace("NULL", "");

            // Risk type settings
            try
            {
                optrisktype.SelectedValue = dsCCM.Tables[0].Rows[0]["risktype"].ToString().ToUpper().Trim();
            }
            catch (Exception ex) { }

            //Type of Service
            chkTSCODDOD.Checked = (dsCCM.Tables[0].Rows[0]["cod_dod_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTSODA.Checked = (dsCCM.Tables[0].Rows[0]["oda_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTSVolumetric.Checked = (dsCCM.Tables[0].Rows[0]["vol_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);
            chkTSDACC.Checked = (dsCCM.Tables[0].Rows[0]["dacc_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);

            //COD/DOD Charges
            if (chkTSCODDOD.Checked == true)
            {
                trTSCODChecked.Style["display"] = "block";
                txtCODCharge.Value = dsCCM.Tables[0].Rows[0]["cod_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
                txtCODChargePer.Value = dsCCM.Tables[0].Rows[0]["cod_chrg_per"].ToString().ToUpper().Trim().Replace("NULL", "");
            }
            else
            {
                trTSCODChecked.Style["display"] = "none";
                txtCODCharge.Value = "0.00";
                txtCODChargePer.Value = "0.00";
            }

            //Volumetric Charges
            if (chkTSVolumetric.Checked == true)
            {
                trTSVolumetricChecked.Style["display"] = "block";
                try
                {
                    ddlVolMeasure.SelectedValue = (dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["cft_measure"].ToString().ToUpper().Trim() == "" ? "0" : dsCCM.Tables[0].Rows[0]["cft_measure"].ToString());
                }
                catch (Exception ex) { }
                txtCFTToKg.Value = dsCCM.Tables[0].Rows[0]["cft2kg"].ToString().ToUpper().Trim().Replace("NULL", "");
            }
            else
            {
                trTSVolumetricChecked.Style["display"] = "none";
                txtCFTToKg.Value = "0";
            }


            //DACC Charges
            if (chkTSDACC.Checked == true)
            {
                trTSDACCChecked.Style["display"] = "block";
                txtDACCChargeRs.Value = dsCCM.Tables[0].Rows[0]["dacc_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
                txtDACCChargePer.Value = dsCCM.Tables[0].Rows[0]["dacc_chrg_per"].ToString().ToUpper().Trim().Replace("NULL", "");
            }
            else
            {
                trTSDACCChecked.Style["display"] = "none";
                txtDACCChargeRs.Value = "0.00";
                txtDACCChargePer.Value = "0.00";
            }

            //Demurrage Charges
            txtDemAfterDays.Value = dsCCM.Tables[0].Rows[0]["dem_day"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtDemChargeRs.Value = dsCCM.Tables[0].Rows[0]["dem_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtDemChargePerKg.Value = dsCCM.Tables[0].Rows[0]["dem_chrg_perkg"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Bill Generation Location
            txtBillGen.Text = dsCCM.Tables[0].Rows[0]["billgen_loccode"].ToString().ToUpper().Trim();

            //Billimg Instance
            try
            {
                ddlBillingInstance.SelectedValue = dsCCM.Tables[0].Rows[0]["bill_inst"].ToString();
            }
            catch (Exception ex) { }
            //Bill Submission Location
            txtBillSubLocation.Text = dsCCM.Tables[0].Rows[0]["billsub_loccode"].ToString().ToUpper().Trim();

            //Total Credit Limit in Rs.
            txtCreditLimit.Value = dsCCM.Tables[0].Rows[0]["credit_limit"].ToString().ToUpper().Trim().Replace("NULL", "");

            //Bill Collection Location
            txtBillCollLocation.Text = dsCCM.Tables[0].Rows[0]["billcol_loccode"].ToString().ToUpper().Trim();

            //Total Credit Limit in Days
            txtCreditDays.Value = dsCCM.Tables[0].Rows[0]["credit_day"].ToString().ToUpper().Trim().Replace("NULL", "");

            //SKU Wise Y/N
            chkSKU.Checked = (dsCCM.Tables[0].Rows[0]["sku_yn"].ToString().ToUpper().Trim() == "Y" ? true : false);


            try
            {
                cmbstaxpaidby.SelectedValue = dsCCM.Tables[0].Rows[0]["stax_paidby"].ToString();
            }
            catch (Exception ex) { }

            //MULTIPOINT charges
            if (dsCCM.Tables[0].Rows[0]["flatmultipickup_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                chkflatmultipointpickup.Checked = true;
                chklocmultipointpickup.Checked = false;
                trloading.Style["display"] = "block";
                if (dsCCM.Tables[0].Rows[0]["flatloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chkflatloading.Checked = true;
                    chklocloading.Checked = false;
                }

                if (dsCCM.Tables[0].Rows[0]["locloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chklocloading.Checked = true;
                    chkflatloading.Checked = false;
                }
            }


            if (dsCCM.Tables[0].Rows[0]["locmultipickup_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                chklocmultipointpickup.Checked = true;
                chkflatmultipointpickup.Checked = false;
                trloading.Style["display"] = "block";
                if (dsCCM.Tables[0].Rows[0]["flatloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chkflatloading.Checked = true;
                    chklocloading.Checked = false;
                }

                if (dsCCM.Tables[0].Rows[0]["locloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chklocloading.Checked = true;
                    chkflatloading.Checked = false;
                }
            }

            if (dsCCM.Tables[0].Rows[0]["flatmultidelivery_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                chkflatmultipointdelivery.Checked = true;
                chklocmultipointdelivery.Checked = false;

                trunloading.Style["display"] = "block";
                if (dsCCM.Tables[0].Rows[0]["flatunloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chkflatunloading.Checked = true;
                    chklocunloading.Checked = false;
                }

                if (dsCCM.Tables[0].Rows[0]["locunloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chklocunloading.Checked = true;
                    chkflatunloading.Checked = false;
                }
            }


            if (dsCCM.Tables[0].Rows[0]["locmultidelivery_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                chklocmultipointdelivery.Checked = true;
                chkflatmultipointdelivery.Checked = false;

                trunloading.Style["display"] = "block";
                if (dsCCM.Tables[0].Rows[0]["flatunloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chkflatunloading.Checked = true;
                    chklocunloading.Checked = false;
                }

                if (dsCCM.Tables[0].Rows[0]["locunloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    chklocunloading.Checked = true;
                    chkflatunloading.Checked = false;
                }
            }

            //Charges

            if (dsCCM.Tables[0].Rows[0]["diesel_hike_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                chkfuelsurcharge.Checked = true;
                trfuelsurcharge.Style["display"] = "block";

                txtminfuelsurchargeair.Text = dsCCM.Tables[0].Rows[0]["min_fuelsurchrgair"].ToString();
                txtmaxfuelsurchargeair.Text = dsCCM.Tables[0].Rows[0]["max_fuelsurchrgair"].ToString();
                txtminfuelsurchargeroad.Text = dsCCM.Tables[0].Rows[0]["min_fuelsurchrgroad"].ToString();
                txtmaxfuelsurchargeroad.Text = dsCCM.Tables[0].Rows[0]["max_fuelsurchrgroad"].ToString();
                txtminfuelsurchargetrain.Text = dsCCM.Tables[0].Rows[0]["min_fuelsurchrgtrain"].ToString();
                txtmaxfuelsurchargetrain.Text = dsCCM.Tables[0].Rows[0]["max_fuelsurchrgtrain"].ToString();
                txtminfuelsurchargeexpress.Text = dsCCM.Tables[0].Rows[0]["min_fuelsurchrgexpress"].ToString();
                txtmaxfuelsurchargeexpress.Text = dsCCM.Tables[0].Rows[0]["max_fuelsurchrgexpress"].ToString();


                txtfuelsurchargeair.Text = dsCCM.Tables[0].Rows[0]["air_fuelsurchrg"].ToString();
                txtfuelsurchargeroad.Text = dsCCM.Tables[0].Rows[0]["road_fuelsurchrg"].ToString();
                txtfuelsurchargetrain.Text = dsCCM.Tables[0].Rows[0]["train_fuelsurchrg"].ToString();
                txtfuelsurchargeexpress.Text = dsCCM.Tables[0].Rows[0]["express_fuelsurchrg"].ToString();

                try
                {
                    cmbfuelsurchargebasair.SelectedValue = dsCCM.Tables[0].Rows[0]["fuelsurchrgbasair"].ToString();
                }
                catch (Exception ex) { }

                try
                {
                    cmbfuelsurchargebasroad.SelectedValue = dsCCM.Tables[0].Rows[0]["fuelsurchrgbasroad"].ToString();
                }
                catch (Exception ex) { }

                try
                {
                    cmbfuelsurchargebastrain.SelectedValue = dsCCM.Tables[0].Rows[0]["fuelsurchrgbastrain"].ToString();
                }
                catch (Exception ex) { }

                try
                {
                    cmbfuelsurchargebasexpress.SelectedValue = dsCCM.Tables[0].Rows[0]["fuelsurchrgbasexpress"].ToString();
                }

                catch (Exception ex) { }


            }

            try
            {
                optminfreighttype.SelectedValue = Convert.ToString(dsCCM.Tables[0].Rows[0]["min_freight_type"].ToString());
            }
            catch (Exception ex) { }


            if (dsCCM.Tables[0].Rows[0]["min_freight_type"].ToString().ToUpper().CompareTo("B") == 0)
            {
                tblbasewiseminfreight.Style["display"] = "block";
                tblpercentwiseminfreight.Style["display"] = "none";
            }
            else if (dsCCM.Tables[0].Rows[0]["min_freight_type"].ToString().ToUpper().CompareTo("%") == 0)
            {
                tblbasewiseminfreight.Style["display"] = "none";
                tblpercentwiseminfreight.Style["display"] = "block";

                txtminsubtotalair.Text = dsCCM.Tables[0].Rows[0]["min_subtotal_air"].ToString();
                txtminsubtotalroad.Text = dsCCM.Tables[0].Rows[0]["min_subtotal_road"].ToString();
                txtminsubtotaltrain.Text = dsCCM.Tables[0].Rows[0]["min_subtotal_train"].ToString();
                txtminsubtotalexpress.Text = dsCCM.Tables[0].Rows[0]["min_subtotal_express"].ToString();

                txtsubtotallowerlimair.Text = dsCCM.Tables[0].Rows[0]["lowlim_subtotal_air"].ToString();
                txtsubtotallowerlimroad.Text = dsCCM.Tables[0].Rows[0]["lowlim_subtotal_road"].ToString();
                txtsubtotallowerlimtrain.Text = dsCCM.Tables[0].Rows[0]["lowlim_subtotal_train"].ToString();
                txtsubtotallowerlimexpress.Text = dsCCM.Tables[0].Rows[0]["lowlim_subtotal_express"].ToString();

                txtsubtotalupperlimair.Text = dsCCM.Tables[0].Rows[0]["upplim_subtotal_air"].ToString();
                txtsubtotalupperlimroad.Text = dsCCM.Tables[0].Rows[0]["upplim_subtotal_road"].ToString();
                txtsubtotalupperlimtrain.Text = dsCCM.Tables[0].Rows[0]["upplim_subtotal_train"].ToString();
                txtsubtotalupperlimexpress.Text = dsCCM.Tables[0].Rows[0]["upplim_subtotal_express"].ToString();

                txtminfreightrateair.Text = dsCCM.Tables[0].Rows[0]["min_freightrate_air"].ToString();
                txtminfreightrateroad.Text = dsCCM.Tables[0].Rows[0]["min_freightrate_road"].ToString();
                txtminfreightratetrain.Text = dsCCM.Tables[0].Rows[0]["min_freightrate_train"].ToString();
                txtminfreightrateexpress.Text = dsCCM.Tables[0].Rows[0]["min_freightrate_express"].ToString();

                txtminfreightratelowerlimair.Text = dsCCM.Tables[0].Rows[0]["lowlim_freightrate_air"].ToString();
                txtminfreightratelowerlimroad.Text = dsCCM.Tables[0].Rows[0]["lowlim_freightrate_road"].ToString();
                txtminfreightratelowerlimtrain.Text = dsCCM.Tables[0].Rows[0]["lowlim_freightrate_train"].ToString();
                txtminfreightratelowerlimexpress.Text = dsCCM.Tables[0].Rows[0]["lowlim_freightrate_express"].ToString();

                txtminfreightrateupperlimair.Text = dsCCM.Tables[0].Rows[0]["upplim_freightrate_air"].ToString();
                txtminfreightrateupperlimroad.Text = dsCCM.Tables[0].Rows[0]["upplim_freightrate_road"].ToString();
                txtminfreightrateupperlimtrain.Text = dsCCM.Tables[0].Rows[0]["upplim_freightrate_train"].ToString();
                txtminfreightrateupperlimexpress.Text = dsCCM.Tables[0].Rows[0]["upplim_freightrate_express"].ToString();

            }


            // OCTROI PROCESSING
            if (dsCCM.Tables[0].Rows[0]["oct_sur_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                chkoctroisurcharge.Checked = true;
                troctroisurcharge.Style["display"] = "block";

                txtminoctroisurcharge.Text = dsCCM.Tables[0].Rows[0]["min_oct_sur"].ToString();
                txtmaxoctroisurcharge.Text = dsCCM.Tables[0].Rows[0]["max_oct_sur"].ToString();
                txtoctroisurchargerate.Text = dsCCM.Tables[0].Rows[0]["rate_oct_sur"].ToString();
                try
                {
                    cmboctroisurchargebas.SelectedValue = dsCCM.Tables[0].Rows[0]["oct_sur_bas"].ToString();
                }
                catch (Exception ex) { }
            }



            //Minimum Freight

            chkapplyfreight.Checked = dsCCM.Tables[0].Rows[0]["min_freight_percent_yn"].ToString().ToUpper().Trim().CompareTo("Y") == 0 ? true : false;
            chkapplysubtotal.Checked = dsCCM.Tables[0].Rows[0]["min_subtotal_percent_yn"].ToString().ToUpper().Trim().CompareTo("Y") == 0 ? true : false;

            txtairrateforfreight.Text = dsCCM.Tables[0].Rows[0]["air_rate"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtroadrateforfreight.Text = dsCCM.Tables[0].Rows[0]["road_rate"].ToString().ToUpper().Trim().Replace("NULL", "");
            txttrainrateforfreight.Text = dsCCM.Tables[0].Rows[0]["rail_rate"].ToString().ToUpper().Trim().Replace("NULL", "");
            txtexpressrateforfreight.Text = dsCCM.Tables[0].Rows[0]["exp_rate"].ToString().ToUpper().Trim().Replace("NULL", "");

            try
            {
                ddlairbasisforfreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["air_bas"].ToString().ToUpper().Trim() == "" ? "0" : dsCCM.Tables[0].Rows[0]["air_bas"].ToString());
            }
            catch (Exception ex) { }

            try
            {
                ddlexpressbasisforfreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["exp_bas"].ToString().ToUpper().Trim() == "" ? "0" : dsCCM.Tables[0].Rows[0]["exp_bas"].ToString());
            }
            catch (Exception ex) { }

            try
            {
                ddltrainbasisforfreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["rail_bas"].ToString().ToUpper().Trim() == "" ? "0" : dsCCM.Tables[0].Rows[0]["rail_bas"].ToString());
            }
            catch (Exception ex) { }

            try
            {
                ddlroadbasisforfreight.SelectedValue = (dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim() == "NULL" || dsCCM.Tables[0].Rows[0]["road_bas"].ToString().ToUpper().Trim() == "" ? "0" : dsCCM.Tables[0].Rows[0]["road_bas"].ToString());
            }
            catch (Exception ex) { }
        }  ///  dsCCM Loop



        dt = new DataTable();

        dt.Columns.Add("codeid", typeof(string));
        dt.Columns.Add("codedesc", typeof(string));
        dt.Columns.Add("airrate", typeof(string));
        dt.Columns.Add("roadrate", typeof(string));
        dt.Columns.Add("trainrate", typeof(string));
        dt.Columns.Add("expressrate", typeof(string));
        dt.Columns.Add("statuscode", typeof(string));


        DataRow dtr;

        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='CHG'";
        SqlCommand cmd = new SqlCommand(sqlstr, sqlConn);
        int norows = Convert.ToInt16(cmd.ExecuteScalar());
        for (int i = 0; i < norows + 1; i++)
        {
            dt.Rows.Add();
        }

        int ii = 1;
        sqlstr = "SELECT codeid,codedesc,statuscode FROM webx_master_general WHERE codetype='CHG'";
        cmd = new SqlCommand(sqlstr, sqlConn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            dt.Rows[ii]["codedesc"] = dr["codedesc"].ToString();
            dt.Rows[ii]["codeid"] = dr["codeid"].ToString();

            dt.Rows[ii]["airrate"] = "0.00";
            dt.Rows[ii]["roadrate"] = "0.00";
            dt.Rows[ii]["trainrate"] = "0.00";
            dt.Rows[ii]["expressrate"] = "0.00";
            dt.Rows[ii]["statuscode"] = dr["statuscode"].ToString();
            ii++;
        }
        dr.Close();


        //if (cmbpaybas.SelectedValue.CompareTo("P01") == 0)
        //    sqlstr = "SELECT * FROM vw_default_contract_charge WHERE contract_type='P01'";
        //else if (cmbpaybas.SelectedValue.CompareTo("P02") == 0)
        //    sqlstr = "SELECT * FROM vw_default_contract_charge WHERE contract_type='P02'";
        //else if (cmbpaybas.SelectedValue.CompareTo("P03") == 0)
        //    sqlstr = "SELECT * FROM vw_default_contract_charge WHERE contract_type='P03'";

        //cmd = new SqlCommand(sqlstr, sqlConn);
        //dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    for (int a = 1; a < 24; a++) // 23 BECAUSE NUMBER OF CHARGES IN WEBX_MASTERGENRAL ARE FIXED NO INCREMENT/DECREMENT
        //    {
        //        if (a < 10)
        //        {
        //            if (dr["trans_type"].ToString().CompareTo("1") == 0)
        //                dt.Rows[a]["airrate"] = returnDouble(dr["SCHG0" + a.ToString()].ToString()).ToString("F2");
        //            else if (dr["trans_type"].ToString().CompareTo("2") == 0)
        //                dt.Rows[a]["roadrate"] = returnDouble(dr["SCHG0" + a.ToString()].ToString()).ToString("F2");
        //            else if (dr["trans_type"].ToString().CompareTo("3") == 0)
        //                dt.Rows[a]["trainrate"] = returnDouble(dr["SCHG0" + a.ToString()].ToString()).ToString("F2");
        //            else if (dr["trans_type"].ToString().CompareTo("4") == 0)
        //                dt.Rows[a]["expressrate"] = returnDouble(dr["SCHG0" + a.ToString()].ToString()).ToString("F2");
        //        }
        //        else
        //        {
        //            if (dr["trans_type"].ToString().CompareTo("1") == 0)
        //                dt.Rows[a]["airrate"] = returnDouble(dr["SCHG" + a.ToString()].ToString()).ToString("F2");
        //            else if (dr["trans_type"].ToString().CompareTo("2") == 0)
        //                dt.Rows[a]["roadrate"] = returnDouble(dr["SCHG" + a.ToString()].ToString()).ToString("F2");
        //            else if (dr["trans_type"].ToString().CompareTo("3") == 0)
        //                dt.Rows[a]["trainrate"] = returnDouble(dr["SCHG" + a.ToString()].ToString()).ToString("F2");
        //            else if (dr["trans_type"].ToString().CompareTo("4") == 0)
        //                dt.Rows[a]["expressrate"] = returnDouble(dr["SCHG" + a.ToString()].ToString()).ToString("F2");
        //        }
        //    }

        //    for (int a = 1; a < 10; a++)
        //    {

        //        if (dr["trans_type"].ToString().CompareTo("1") == 0)
        //            dt.Rows[a + 23]["airrate"] = returnDouble(dr["UCHG0" + a.ToString()].ToString()).ToString("F2");
        //        else if (dr["trans_type"].ToString().CompareTo("2") == 0)
        //            dt.Rows[a + 23]["roadrate"] = returnDouble(dr["UCHG0" + a.ToString()].ToString()).ToString("F2");
        //        else if (dr["trans_type"].ToString().CompareTo("3") == 0)
        //            dt.Rows[a + 23]["trainrate"] = returnDouble(dr["UCHG0" + a.ToString()].ToString()).ToString("F2");
        //        else if (dr["trans_type"].ToString().CompareTo("4") == 0)
        //            dt.Rows[a + 23]["expressrate"] = returnDouble(dr["UCHG0" + a.ToString()].ToString()).ToString("F2");

        //    }

        //    if (dr["trans_type"].ToString().CompareTo("1") == 0)
        //        dt.Rows[33]["airrate"] = returnDouble(dr["UCHG10"].ToString()).ToString("F2");
        //    else if (dr["trans_type"].ToString().CompareTo("2") == 0)
        //        dt.Rows[33]["roadrate"] = returnDouble(dr["UCHG10"].ToString()).ToString("F2");
        //    else if (dr["trans_type"].ToString().CompareTo("3") == 0)
        //        dt.Rows[33]["trainrate"] = returnDouble(dr["UCHG10"].ToString()).ToString("F2");
        //    else if (dr["trans_type"].ToString().CompareTo("4") == 0)
        //        dt.Rows[33]["expressrate"] = returnDouble(dr["UCHG10"].ToString()).ToString("F2");

        //}
        //dr.Close();

        //grvcharges.DataSource = dt;
        //grvcharges.DataBind();




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
}

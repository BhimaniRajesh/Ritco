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
using System.IO;


public partial class Views_ViewCCServices : System.Web.UI.UserControl
{
    #region Variable[s]
    SqlConnection con;
    DataTable dtftlmatrix;
    MyFunctions fn;
    string sqlstr = "", custcode = "", contractid = "";    
    private bool flagODA = false, flagAir = false, flagStandard = false, flagTrain = false, flagExpress = false;
    private string m_CustomerContractID = string.Empty;
    #endregion

    #region Property
    public string CustomerContractID
    {
        get
        {
            return m_CustomerContractID;
        }
        set
        {
            m_CustomerContractID = value;
        }
    }
    #endregion

    #region  #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlCommand cmd;
        SqlDataReader dr;

        string single_slab_yn = "", multiple_slab_yn = "";
        string transport_mode = "", load_type = "", service_type = "";
        string pickup_delivery = string.Empty;
        fn = new MyFunctions();

        try
        {
            if (!IsPostBack)
            {
                hdncontractid.Value = CustomerContractID;
            }
            else
            {
                CustomerContractID = hdncontractid.Value; 
            }
        }
        catch (Exception ex) { }
        try
        {
            custcode = Request.QueryString["custcode"].ToString();
        }
        catch (Exception ex) { }
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        trCodDoc.Style["display"] = "none";
        trVolumetric.Style["display"] = "none";
        trDACC.Style["display"] = "none";
        trFuelSurchargeTitle.Style["display"] = "none";
        trFuelSurchargeApp.Style["display"] = "none";
        trOctroiSurcharge.Style["display"] = "none";
        trOctroiSurchargeEd.Style["display"] = "none";
        trFuelSurchargeBase.Style["display"] = "none";
        trFuelSurchargeRate.Style["display"] = "none";
        trFuelSurchargeMin.Style["display"] = "none";
        trFuelSurchargeMax.Style["display"] = "none";
        trOctroiSurChargeBase.Style["display"] = "none";
        trOctroiSurChargeMin.Style["display"] = "none";
        tblbasewiseminfreight.Style["display"] = "none";
        tblpercentwiseminfreight.Style["display"] = "none";
        trLoadingCharges.Style["display"] = "none";
        trUnLoadingCharges.Style["display"] = "none";

        #region STEP 1 Contract Information
        sqlstr = "SELECT convert(varchar,contract_stdate,106) as contract_stdate,";
        sqlstr = sqlstr + "convert(varchar,lasteditdate,106) AS lasteditdate,";
        sqlstr = sqlstr + "convert(varchar,contract_eddate,106) as contract_eddate,";
        sqlstr = sqlstr + "convert(varchar,contract_effectdate,106) as contract_effectdate,";
        sqlstr = sqlstr + "remarks,contractmode=(select codedesc from webx_master_general where codetype='CMOD' and codeid=contractmode),";
        sqlstr = sqlstr + " * FROM webx_custcontract_hdr With(NOLOCK) WHERE contractid='" + CustomerContractID.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            hdncustcode.Value = dr["custcode"].ToString();
            lblcustcodename.Text = dr["custcode"].ToString() + " : " + fn.Getcustomer(dr["custcode"].ToString());
            lblcontractid.Text = dr["contractid"].ToString();
            lblcontractdate.Text = dr["contract_stdate"].ToString();
            lblvaliduntil.Text = dr["contract_eddate"].ToString();
            lbleffectivedate.Text = dr["contract_effectdate"].ToString();
            lblcontractsignloc.Text = dr["contract_sign_loccode"].ToString();
            lblcustrepresent.Text = dr["cust_represent"].ToString();
            lblcompempname.Text = dr["comp_empname"].ToString();
            lblcustempdesig.Text = dr["custdesig"].ToString();
            lblcompempdesig.Text = dr["comp_desig"].ToString();
            lblcustwitness.Text = dr["custwitness"].ToString();
            lblcompwitness.Text = dr["comp_witness"].ToString();
            lblbilladdress.Text = dr["bill_address"].ToString();
            lblcitypincode.Text = dr["bill_city"].ToString() + " : " + dr["bill_pin"].ToString();
            lblpartycat.Text = dr["custcat"].ToString();
            lblcontractcat.Text = dr["contractcat"].ToString();
            lbllasteditdate.Text = dr["lasteditdate"].ToString();
            lbllasteditby.Text = dr["lasteditby"].ToString();

            if (dr["stax_yn"].ToString().ToUpper().ToString().CompareTo("Y") == 0)
                lblstaxapplicable.Text = "Yes";
            else
                lblstaxapplicable.Text = "No";
            lblaccrepresent.Text = dr["acc_rep"].ToString();

            single_slab_yn = dr["single_slab_yn"].ToString();
            multiple_slab_yn = dr["multiple_slab_yn"].ToString();         

            if (Session["client"].ToString().ToUpper().CompareTo("RCPL") == 0)
            {
                trcommitedbusiness.Style["display"] = "block";
            }
            lblcommitedbusiness.Text = dr["commitedbusiness"].ToString();

            if (dr["stax_paidby"].ToString().ToUpper().CompareTo("T") == 0)
            {
                lblstaxpaidby.Text = "Transporter";
            }
            else if (dr["stax_paidby"].ToString().ToUpper().CompareTo("P") == 0)
            {
                lblstaxpaidby.Text = "Party";
            }

            //CLIENT SPECIFIC SETTINGS
            lblrcplcontractid.Text = dr["contractid"].ToString();
            lblcustcode.Text = dr["custcode"].ToString();
            lblcustname.Text = fn.Getcustomer(dr["custcode"].ToString());

            if (Session["client"].ToString().ToUpper().CompareTo("RCPL") == 0)
            {
                trrcplcustname.Style["display"] = "compact";
                trrcplcontractid.Style["display"] = "compact";
                trcustcodename.Style["display"] = "none";
            }
            else
            {
                trrcplcustname.Style["display"] = "none";
                trrcplcontractid.Style["display"] = "none";
                trcustcodename.Style["display"] = "compact";
            }

            lblremarks.Text = dr["remarks"].ToString();
            lblcontractmode.Text = dr["contractmode"].ToString();

        }
        dr.Close();
        #endregion

        #region STEP 1 Service Information
        sqlstr = "SELECT * FROM webx_custcontract_charge WHERE contractid='" + CustomerContractID.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            #region Transport Mode
            if (Session["Client"].ToString().ToUpper().CompareTo("RLL") == 0)
            {
                flagStandard = true;
                if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                    transport_mode = "STANDARD";
            }
            else
            {
                if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                    transport_mode = "ROAD";
            }

            if (dr["air_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                flagAir = true;
                if (string.IsNullOrEmpty(transport_mode))
                    transport_mode = "AIR";
                else
                    transport_mode = transport_mode + ", AIR";
            }

            if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                flagExpress = true;
                if (string.IsNullOrEmpty(transport_mode))
                    transport_mode = "EXPRESS";
                else
                    transport_mode = transport_mode + ", EXPRESS";
            }

            if (dr["rail_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                flagTrain = true;
                if (string.IsNullOrEmpty(transport_mode))
                    transport_mode = "TRAIN";
                else
                    transport_mode = transport_mode + ", TRAIN";
            }
            lblTransportMode.Text = transport_mode;
            #endregion

            #region LOAD TYPES
            if (dr["sundry_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                if (string.IsNullOrEmpty(load_type))
                    load_type = "SUNDRY";
            }
            if (dr["FTL_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                if (string.IsNullOrEmpty(load_type))
                    load_type = "FTL";
                else
                    load_type = load_type + ", FTL";
            }
            lblLoadType.Text = load_type;
            #endregion

            #region PickUp - Delivery
            if ((dr["flatmultipickup_yn"].ToString().Trim().ToUpper().CompareTo("Y") == 0) || (dr["locmultipickup_yn"].ToString().Trim().ToUpper().CompareTo("Y") == 0))
            {
                trLoadingCharges.Style["display"] = "block";

                if (dr["flatmultipickup_yn"].ToString().Trim().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatMultiPointPU.Text = "Yes";
                    lblLocMultiPointPU.Text = "No";
                }
                else if (dr["locmultipickup_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatMultiPointPU.Text = "No";
                    lblLocMultiPointPU.Text = "Yes";
                }

                if (dr["flatloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatLoadingCharges.Text = "Yes";
                    lblLocLoadingCharges.Text = "No";
                }

                if (dr["locloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatLoadingCharges.Text = "No";
                    lblLocLoadingCharges.Text = "Yes";
                }

                if ((dr["flatloading_yn"].ToString().ToUpper().CompareTo("N") == 0) && (dr["locloading_yn"].ToString().ToUpper().CompareTo("N") == 0))
                {
                    lblFlatLoadingCharges.Text = "No";
                    lblLocLoadingCharges.Text = "No";
                }
            }
            else
            {
                lblFlatMultiPointPU.Text = "No";
                lblLocMultiPointPU.Text = "No";
            }

            if ((dr["flatmultidelivery_yn"].ToString().Trim().ToUpper().CompareTo("Y") == 0) || (dr["locmultidelivery_yn"].ToString().Trim().ToUpper().CompareTo("Y") == 0))
            {
                trUnLoadingCharges.Style["display"] = "block";

                if (dr["flatmultidelivery_yn"].ToString().Trim().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatMultiPointDL.Text = "Yes";
                    lblLocMultiPointDL.Text = "No";
                }

                if (dr["locmultipickup_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatMultiPointDL.Text = "No";
                    lblLocMultiPointDL.Text = "Yes";
                }

                if (dr["flatunloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatUnLoadingCharges.Text = "Yes";
                    lblLocUnLoadingCharges.Text = "No";
                }

                if (dr["locunloading_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    lblFlatUnLoadingCharges.Text = "No";
                    lblLocUnLoadingCharges.Text = "Yes";
                }

                if ((dr["flatunloading_yn"].ToString().ToUpper().CompareTo("N") == 0) && (dr["locunloading_yn"].ToString().ToUpper().CompareTo("N") == 0))
                {
                    lblFlatUnLoadingCharges.Text = "No";
                    lblLocUnLoadingCharges.Text = "No";
                }
            }
            else
            {
                lblFlatMultiPointDL.Text = "No";
                lblLocMultiPointDL.Text = "No";
            }
            #endregion

            #region  PICKUP DELEVERY
            string[] arrpickdel = dr["pkp_dly"].ToString().Trim().ToUpper().Split(',');
            for (int i = 0; i < arrpickdel.Length; i++)
            {
                if (arrpickdel[i].Trim().CompareTo("DD") == 0)
                {
                    if (string.IsNullOrEmpty(pickup_delivery))
                        pickup_delivery = "Door ~ Door";
                    else
                        pickup_delivery = pickup_delivery + ", Door ~ Door";
                }

                if (arrpickdel[i].Trim().CompareTo("GD") == 0)
                {
                    if (string.IsNullOrEmpty(pickup_delivery))
                        pickup_delivery = "GoDown ~ Door";
                    else
                        pickup_delivery = pickup_delivery + ", GoDown ~ Door";
                }

                if (arrpickdel[i].Trim().CompareTo("GG") == 0)
                {
                    if (string.IsNullOrEmpty(pickup_delivery))
                        pickup_delivery = "GoDown ~ GoDown";
                    else
                        pickup_delivery = pickup_delivery + ", GoDown ~ GoDown";
                }

                if (arrpickdel[i].Trim().CompareTo("DG") == 0)
                {
                    if (string.IsNullOrEmpty(pickup_delivery))
                        pickup_delivery = "Door ~ GoDown";
                    else
                        pickup_delivery = pickup_delivery + ", Door ~ GoDown";
                }
                lbldg.Text = pickup_delivery.Trim();
            }// PICKUP DELIVERY FOR LOOP
            #endregion

            #region FOV TYPES
            lblfovtype.Text = dr["fov_type"].ToString().ToUpper();
            if (dr["fov_type"].ToString().ToUpper().CompareTo("RS") == 0)
            {
                lblfovcarrierrate.Style["display"] = "none";
                lblfovownerrate.Style["display"] = "none";
                lblfovflatrate.Text = dr["fov_chrg"].ToString();
            }
            else if (dr["fov_type"].ToString().ToUpper().CompareTo("%") == 0)
            {
                lblfovcarrierrate.Text = "Carrier Risk - " + dr["fov_chrg_carrier"].ToString();
                lblfovownerrate.Text = "Owner Risk - " + dr["fov_chrg_owner"].ToString();
                lblfovflatrate.Style["display"] = "none";
            }
            #endregion

            #region RISK TYPE
            if (dr["risktype"].ToString().Trim().ToUpper().CompareTo("C") == 0)
            {
                lblRiskType.Text = "Carrier Risk";
            }
            else if (dr["risktype"].ToString().Trim().ToUpper().CompareTo("O") == 0)
            {
                lblRiskType.Text = "Owner Risk";
            }
            #endregion

            #region SERVICE TYPES
            if (dr["cod_dod_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                trCodDoc.Style["display"] = "block";
                lblCodMinRs.Text = dr["cod_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
                lblCodPerAmount.Text = dr["cod_chrg_per"].ToString().ToUpper().Trim().Replace("NULL", "");

                if (string.IsNullOrEmpty(service_type))
                    service_type = "COD/DOD";
                else
                    service_type = service_type + ", COD/DOD";
            }
            if (dr["oda_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                flagODA = true;
                if (string.IsNullOrEmpty(service_type))
                    service_type = "ODA";
                else
                    service_type = service_type + ", ODA";
            }
            if (dr["vol_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                trVolumetric.Style["display"] = "block";
                lblVolMeasureType.Text = dr["cft_measure"].ToString().ToUpper().Trim().Replace("NULL", "");
                lblCFTToKg.Text = dr["cft2kg"].ToString().ToUpper().Trim().Replace("NULL", "");

                if (string.IsNullOrEmpty(service_type))
                    service_type = "VOLUMETRIC";
                else
                    service_type = service_type + ", VOLUMETRIC";
            }
            if (dr["dacc_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                trDACC.Style["display"] = "block";
                lblDACCMinRs.Text = dr["dacc_chrg_rs"].ToString().ToUpper().Trim().Replace("NULL", "");
                lblDACCPerFreight.Text = dr["dacc_chrg_per"].ToString().ToUpper().Trim().Replace("NULL", "");

                if (string.IsNullOrEmpty(service_type))
                    service_type = "DACC";
                else
                    service_type = service_type + ", DACC";
            }
            lblTypeOfService.Text = service_type;
            #endregion

            #region FUEL SURCHARGE APPLICABLE
            if (dr["diesel_hike_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                lblFuelSurcharge.Text = "YES";
                trOctroiSurcharge.Style["display"] = "block";
                trFuelSurchargeTitle.Style["display"] = "block";
                trFuelSurchargeApp.Style["display"] = "block";
                trFuelSurchargeBase.Style["display"] = "block";
                trFuelSurchargeRate.Style["display"] = "block";
                trFuelSurchargeMin.Style["display"] = "block";
                trFuelSurchargeMax.Style["display"] = "block";

                if (dr["fuelsurchrgbasair"].ToString().Trim().ToUpper().CompareTo("%") == 0)
                {
                    lblFuelSurchargebasair.Text = "PerCent on Freight";
                }
                else if (dr["fuelsurchrgbasair"].ToString().Trim().ToUpper().CompareTo("W") == 0)
                {
                    lblFuelSurchargebasair.Text = "PerKG";
                }
                else if (dr["fuelsurchrgbasair"].ToString().Trim().ToUpper().CompareTo("F") == 0)
                {
                    lblFuelSurchargebasair.Text = "Flat RS";
                }

                if (dr["fuelsurchrgbasroad"].ToString().Trim().ToUpper().CompareTo("%") == 0)
                {
                    lblFuelSurchargebasroad.Text = "PerCent on Freight";
                }
                else if (dr["fuelsurchrgbasroad"].ToString().Trim().ToUpper().CompareTo("W") == 0)
                {
                    lblFuelSurchargebasroad.Text = "PerKG";
                }
                else if (dr["fuelsurchrgbasroad"].ToString().Trim().ToUpper().CompareTo("F") == 0)
                {
                    lblFuelSurchargebasroad.Text = "Flat RS";
                }

                if (dr["fuelsurchrgbastrain"].ToString().Trim().ToUpper().CompareTo("%") == 0)
                {
                    lblFuelSurchargebastrain.Text = "PerCent on Freight";
                }
                else if (dr["fuelsurchrgbastrain"].ToString().Trim().ToUpper().CompareTo("W") == 0)
                {
                    lblFuelSurchargebastrain.Text = "PerKG";
                }
                else if (dr["fuelsurchrgbastrain"].ToString().Trim().ToUpper().CompareTo("F") == 0)
                {
                    lblFuelSurchargebastrain.Text = "Flat RS";
                }

                if (dr["fuelsurchrgbasexpress"].ToString().Trim().ToUpper().CompareTo("%") == 0)
                {
                    lblFuelSurchargebasexpress.Text = "PerCent on Freight";
                }
                else if (dr["fuelsurchrgbasexpress"].ToString().Trim().ToUpper().CompareTo("W") == 0)
                {
                    lblFuelSurchargebasexpress.Text = "PerKG";
                }
                else if (dr["fuelsurchrgbasexpress"].ToString().Trim().ToUpper().CompareTo("F") == 0)
                {
                    lblFuelSurchargebasexpress.Text = "Flat RS";
                }

                lblFuelSurchargeRateAir.Text = Convert.ToString(dr["air_fuelsurchrg"]);
                lblFuelSurchargeRateRoad.Text = Convert.ToString(dr["road_fuelsurchrg"]);
                lblFuelSurchargeRateTrain.Text = Convert.ToString(dr["train_fuelsurchrg"]);
                lblFuelSurchargeRateExpress.Text = Convert.ToString(dr["express_fuelsurchrg"]);

                lblMinFuelSurchargeAir.Text = Convert.ToString(dr["min_fuelsurchrgair"]);
                lblMinFuelSurchargeRoad.Text = Convert.ToString(dr["min_fuelsurchrgroad"]);
                lblMinFuelSurchargeTrain.Text = Convert.ToString(dr["min_fuelsurchrgtrain"]);
                lblMinFuelSurchargeExpress.Text = Convert.ToString(dr["min_fuelsurchrgexpress"]);

                lblMaxFuelSurchargeAir.Text = Convert.ToString(dr["max_fuelsurchrgair"]);
                lblMaxFuelSurchargeRoad.Text = Convert.ToString(dr["max_fuelsurchrgroad"]);
                lblMaxFuelSurchargeTrain.Text = Convert.ToString(dr["max_fuelsurchrgtrain"]);
                lblMaxFuelSurchargeExpress.Text = Convert.ToString(dr["max_fuelsurchrgexpress"]);
            }
            else
            {
                lblFuelSurcharge.Text = "NO";
            }
            #endregion

            #region Octroi Surcharge Applicable
            if (dr["oct_sur_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                lblOctroiSurchargeApp.Text = "YES";
                trOctroiSurchargeEd.Style["display"] = "block";

                trOctroiSurChargeBase.Style["display"] = "block";
                trOctroiSurChargeMin.Style["display"] = "block";

                if (dr["oct_sur_bas"].ToString().Trim().ToUpper().CompareTo("O") == 0)
                {
                    lblOctroiBase.Text = "PerCent on Octroi Value";
                }
                else if (dr["oct_sur_bas"].ToString().Trim().ToUpper().CompareTo("I") == 0)
                {
                    lblOctroiBase.Text = "PerCent on Invoice Value";
                }
                else if (dr["oct_sur_bas"].ToString().Trim().ToUpper().CompareTo("F") == 0)
                {
                    lblOctroiBase.Text = "Flat in RS";
                }

                lblOctroiSurCharge.Text = Convert.ToString(dr["rate_oct_sur"]);
                lblMinOctroi.Text = Convert.ToString(dr["min_oct_sur"]);
                lblMaxOctroi.Text = Convert.ToString(dr["max_oct_sur"]);
            }
            else
            {
                lblOctroiSurchargeApp.Text = "NO";
            }
            #endregion

            #region DEMURRAGE AFTER DAYS
            if (dr["dem_day"].ToString().ToUpper().CompareTo("") == 0 || dr["dem_day"] == DBNull.Value)
                lbldemafterdays.Text = "0";
            else
                lbldemafterdays.Text = dr["dem_day"].ToString();

            if (dr["dem_chrg_rs"].ToString().ToUpper().CompareTo("") == 0 || dr["dem_day"] == DBNull.Value)
                lblmindemchrg.Text = "0.00";
            else
                lblmindemchrg.Text = dr["dem_chrg_rs"].ToString();

            if (dr["dem_chrg_perkg"].ToString().ToUpper().CompareTo("") == 0 || dr["dem_day"] == DBNull.Value)
                lbldemperkg.Text = "0.00";
            else
                lbldemperkg.Text = dr["dem_chrg_perkg"].ToString();
            #endregion

            lblbillgenloc.Text = dr["billgen_loccode"].ToString();
            lblbillsubloc.Text = dr["billsub_loccode"].ToString();
            lblbillcolloc.Text = dr["billcol_loccode"].ToString();

            if (dr["credit_day"].ToString().ToUpper().CompareTo("") == 0 || dr["credit_day"] == DBNull.Value)
                lblcreditdaysfromgen.Text = "Not Set";
            else
                lblcreditdaysfromgen.Text = dr["credit_day"].ToString();

            if (dr["bill_inst"].ToString().ToUpper().CompareTo("BKG") == 0)
            {
                lblbillinginstance.Text = "On Booking";
            }
            else if (dr["bill_inst"].ToString().ToUpper().CompareTo("POD") == 0)
            {
                lblbillinginstance.Text = "POD";
            }

            if (dr["credit_limit"].ToString().ToUpper().CompareTo("") == 0 || dr["credit_limit"] == DBNull.Value)
                lbltotlimitrs.Text = "Not Set";
            else
                lbltotlimitrs.Text = dr["credit_limit"].ToString();

            if (dr["sku_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lblsku.Text = "Yes";
            else
                lblsku.Text = "No";

            #region Type of Minimum Freight - Base Wise / Percent Wise
            #region TYPE OF MINIMUM FREIGHT
            if (dr["min_freight_type"].ToString().Trim().ToUpper().CompareTo("B") == 0)
            {
                lblTypeMinFreight.Text = "Base Wise";
                tblbasewiseminfreight.Style["display"] = "block";

                rate_air.Text = dr["air_rate"].ToString();
                basis_air.Text = getRateType(dr["air_bas"].ToString());
                rate_road.Text = dr["road_rate"].ToString();
                basis_road.Text = getRateType(dr["road_bas"].ToString());
                rate_express.Text = dr["exp_rate"].ToString();
                basis_express.Text = getRateType(dr["exp_bas"].ToString());
                rate_train.Text = dr["rail_rate"].ToString();
                basis_train.Text = getRateType(dr["rail_bas"].ToString());
            }
            else if (dr["min_freight_type"].ToString().Trim().ToUpper().CompareTo("%") == 0)
            {
                getModeOfTransport();
                tblpercentwiseminfreight.Style["display"] = "block";
                lblTypeMinFreight.Text = "Percent Wise";

                if (dr["min_freight_percent_yn"].ToString().ToUpper().Trim().CompareTo("Y") == 0)
                    lblApplyFreight.Text = "Freight Rate Limits Applicable - Yes";
                else
                    lblApplyFreight.Text = "Freight Rate Limits Applicable - No";

                if (dr["min_subtotal_percent_yn"].ToString().ToUpper().Trim().CompareTo("Y") == 0)
                    lblApplySubtotal.Text = "Sub Total Limits Applicable - Yes";
                else
                    lblApplySubtotal.Text = "Sub Total Limits Applicable - No";

                #region Freight Rate Limits
                lblMinFreightRateAir.Text = Convert.ToString(dr["min_freightrate_air"]);
                lblMinFreightRateRoad.Text = Convert.ToString(dr["min_freightrate_road"]);
                lblMinFreightRateTrain.Text = Convert.ToString(dr["min_freightrate_train"]);
                lblMinFreightRateExpress.Text = Convert.ToString(dr["min_freightrate_express"]);

                lblMinFreightRateLowerlimAir.Text = Convert.ToString(dr["lowlim_freightrate_air"]);
                lblMinFreightRateLowerlimRoad.Text = Convert.ToString(dr["lowlim_freightrate_road"]);
                lblMinFreightRateLowerlimTrain.Text = Convert.ToString(dr["lowlim_freightrate_train"]);
                lblMinFreightRateLowerlimExpress.Text = Convert.ToString(dr["lowlim_freightrate_express"]);

                lblMinFreightRateUpperlimAir.Text = Convert.ToString(dr["upplim_freightrate_air"]);
                lblMinFreightRateUpperlimRoad.Text = Convert.ToString(dr["upplim_freightrate_road"]);
                lblMinFreightRateUpperlimTrain.Text = Convert.ToString(dr["upplim_freightrate_train"]);
                lblMinFreightRateUpperlimExpree.Text = Convert.ToString(dr["upplim_freightrate_express"]);
                #endregion

                #region Sub Total Limits
                lblMinSubTotalAir.Text = Convert.ToString(dr["min_subtotal_air"]);
                lblMinSubTotalRoad.Text = Convert.ToString(dr["min_subtotal_road"]);
                lblMinSubTotalTrain.Text = Convert.ToString(dr["min_subtotal_train"]);
                lblMinSubTotalExpress.Text = Convert.ToString(dr["min_subtotal_express"]);

                lblSubTotalLowerlimAir.Text = Convert.ToString(dr["lowlim_subtotal_air"]);
                lblSubTotalLowerlimRoad.Text = Convert.ToString(dr["lowlim_subtotal_road"]);
                lblSubTotalLowerlimTrain.Text = Convert.ToString(dr["lowlim_subtotal_train"]);
                lblSubTotalLowerlimExpress.Text = Convert.ToString(dr["lowlim_subtotal_express"]);

                lblSubTotalUpperlimAir.Text = Convert.ToString(dr["upplim_subtotal_air"]);
                lblSubTotalUpperlimRoad.Text = Convert.ToString(dr["upplim_subtotal_road"]);
                lblSubTotalUpperlimTrain.Text = Convert.ToString(dr["upplim_subtotal_train"]);
                lblSubTotalUpperlimExpress.Text = Convert.ToString(dr["upplim_subtotal_express"]);
                #endregion
            }
            #endregion
            #endregion
        }
        dr.Close();
        #endregion       

        con.Close();
    }   
    #endregion

    #region Private Function[s]
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
                        lblmodenameair.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case 1:
                        lblmodenameroad.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case 2:
                        lblmodenametrain.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                    case 3:
                        lblmodenameexpress.Text = dsMOT.Tables[0].Rows[i]["CodeDesc"].ToString();
                        break;
                }
            }
        }

        sqlConn.Close();
    }  
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
    private string getRateType(string strRate)
    {
        if (strRate == "RS")
        {
            strRate = "RS";
        }
        else if (strRate == "KG")
        {
            strRate = "Rate Per KG.";
        }
        else if (strRate == "PKG")
        {
            strRate = "Rate Per Package.";
        }
        else
        {
            strRate = "";
        }
        return strRate;
    }
    #endregion
}

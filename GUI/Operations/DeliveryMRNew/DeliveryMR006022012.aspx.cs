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
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;


public partial class GUI_Operation_DeliveryMR_DeliveryMR : System.Web.UI.Page
{
    string dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dkt_call = SessionUtilities.DocketCalledAs;
            hdnemployee.Value = SessionUtilities.CurrentEmployeeID.ToUpper();
            txtcurrloc.Text = SessionUtilities.CurrentBranchCode.ToUpper();
            hdnclient.Value = SessionUtilities.Client.ToUpper();
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session Time Out&suggesion1=Log On again and ReTry.", false);
            return;
        }

        if (!IsPostBack)
        {
            trstep2.Style["display"] = "none";
            trcharges.Style["display"] = "none";
            trsumit.Style["display"] = "none";

            hdnserverdate.Value = DataProvider.GetServerDate();

            try
            {
                hdnfinstartyear.Value = Session["finyear"].ToString();
            }
            catch (Exception ex)
            {
                Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session Time Out&suggesion1=Log On again and ReTry.", false);
                return;
            }
        }
    }


    protected void btnstep1_Click(object sender, EventArgs e)
    {
        try
        {
            MRController.IsDocketEligibleForDelMR(txtdockno.Text.Trim(), ddlsuffix.SelectedValue, SessionUtilities.CurrentBranchCode, hdnfinstartyear.Value);
        }
        catch (Exception ex)
        {
            lblmessage.Text = ex.Message;
            return;
        }

        trstep1.Style["display"] = "none";
        trdockno.Style["display"] = "none";
        trstep2.Style["display"] = "block";

        string strsql = "";
        DataTable dt_docket = new DataTable();
        strsql = "SELECT CONVERT(VARCHAR,dockdt,103) AS dockdate,";
        strsql = strsql + "paymentbas,service_class,ftl_types,businesstype,orgncd,reassign_destcd as delloc,from_loc,to_loc,";
        strsql = strsql + " paybas,party_code,csgecd,csgenm,pkgsno,trn_mod,prodcd,diplomat,stax_exmpt_yn,stax_paidby,";
        strsql = strsql + " dacc_yn,cod_dod,insuyn,packtype,CONVERT(VARCHAR,cdeldt,106) AS edd,chrgwt,convert(varchar,arrived_dt,106) as ArrivedDate,";
        strsql = strsql + " prodcd,csgecd,csgenm,stax_exmpt_yn,CONVERT(INT,pkgsno) AS totpkgs,stax_paidby,curr_loc,invamt,product,";
        strsql = strsql + " godown=(SELECT godown_desc AS godownname FROM dbo.webx_godownmst WITH(NOLOCK) WHERE godown_srno=s.godown),isNULL(arrpkgqty,0) as arrpkgqty,isNULL(arrweightqty,0) as arrweightqty";
        strsql = strsql + " FROM dbo.webx_master_docket d WITH(NOLOCK) INNER JOIN dbo.webx_trans_docket_status s WITH(NOLOCK)";
        strsql = strsql + " ON d.dockno=s.dockno";
        strsql = strsql + " CROSS APPLY(SELECT codedesc AS packtype FROM dbo.webx_master_general WITH(NOLOCK) WHERE codetype='PKGS' AND codeid=pkgsty)pkty";
        strsql = strsql + " CROSS APPLY(SELECT codedesc AS paymentbas FROM dbo.webx_master_general WITH(NOLOCK) WHERE codetype='PAYTYP' AND codeid=paybas)pytp";
        strsql = strsql + " CROSS APPLY(SELECT codedesc AS product FROM dbo.webx_master_general WITH(NOLOCK) WHERE codetype='PROD' AND codeid=prodcd)prdcd";
        strsql = strsql + " WHERE d.dockno='" + txtdockno.Text + "' AND s.docksf='" + ddlsuffix.SelectedValue + "'";
        dt_docket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

        lbldockno.Text = txtdockno.Text + ddlsuffix.SelectedValue;
        hdndockdate.Value = dt_docket.Rows[0]["dockdate"].ToString();
        txtmrdate.Text = hdnserverdate.Value;
        lblpaybas.Text = dt_docket.Rows[0]["paymentbas"].ToString();
        hdnservicetype.Value = dt_docket.Rows[0]["service_class"].ToString();
        hdnftltype.Value = dt_docket.Rows[0]["ftl_types"].ToString();
        hdnbusinesstype.Value = dt_docket.Rows[0]["businesstype"].ToString();
        hdnorgnloc.Value = dt_docket.Rows[0]["orgncd"].ToString();
        hdndelloc.Value = dt_docket.Rows[0]["delloc"].ToString();
        hdnfrom.Value = dt_docket.Rows[0]["from_loc"].ToString();
        hdnto.Value = dt_docket.Rows[0]["to_loc"].ToString();
        hdnpaybas.Value = dt_docket.Rows[0]["paybas"].ToString();
        hdnpartycode.Value = dt_docket.Rows[0]["party_code"].ToString();
        hdnpartyname.Value = DataProvider.GetCustomerName(hdnpartycode.Value);
        hdncsgecd.Value = dt_docket.Rows[0]["csgecd"].ToString();
        hdncsgenm.Value = dt_docket.Rows[0]["csgenm"].ToString();

        hdnpkgsno.Value = dt_docket.Rows[0]["pkgsno"].ToString();
        hdnchargedweight.Value = Convert.ToDouble(dt_docket.Rows[0]["chrgwt"].ToString()).ToString("F0");
        hdntransmode.Value = dt_docket.Rows[0]["trn_mod"].ToString();
        hdnprodtype.Value = dt_docket.Rows[0]["prodcd"].ToString();
        hdnflagoda.Value = dt_docket.Rows[0]["diplomat"].ToString();
        hdnflagstaxempted.Value = dt_docket.Rows[0]["stax_exmpt_yn"].ToString().ToUpper();
        hdnstaxpayer.Value = dt_docket.Rows[0]["stax_paidby"].ToString();
        hdnflagdacc.Value = dt_docket.Rows[0]["dacc_yn"].ToString();
        hdnflagcoddod.Value = dt_docket.Rows[0]["cod_dod"].ToString();
        hdnrisktype.Value = dt_docket.Rows[0]["insuyn"].ToString();
        lblProductType.Text = dt_docket.Rows[0]["product"].ToString();
        lblnoOfPkgs.Text = dt_docket.Rows[0]["pkgsno"].ToString();
        lblUnLoadingDate.Text = dt_docket.Rows[0]["ArrivedDate"].ToString();

        if (hdnpaybas.Value.CompareTo("P02") == 0)
        {

            if (dt_docket.Rows[0]["csgecd"].ToString().CompareTo("8888") == 0)
            {
                txtpartyw.Text = dt_docket.Rows[0]["csgenm"].ToString();
            }
            else
            {
                txtpartycode.Text = dt_docket.Rows[0]["csgecd"].ToString();
                txtpartyname.Text = DataProvider.GetCustomerName(dt_docket.Rows[0]["csgecd"].ToString());
            }
            optpartytype.SelectedValue = "P";
            trpartyw.Style["display"] = "none";
            trpartyc.Style["display"] = "none";
            trcneewc.Style["display"] = "none";
        }
        else
        {
            optpartytype.SelectedValue = "CE";
            trpartytype.Style["display"] = "none";
        }

        if (dt_docket.Rows[0]["csgecd"].ToString().CompareTo("8888") != 0)
        {
            optpartyc.Checked = true;
            optpartyw.Checked = false;
            txtpartycode.Text = dt_docket.Rows[0]["csgecd"].ToString();
            txtpartyname.Text = DataProvider.GetCustomerName(dt_docket.Rows[0]["csgecd"].ToString());
            trpartyw.Style["display"] = "none";
            trpartyc.Style["display"] = "block";
        }
        else
        {
            optpartyc.Checked = false;
            optpartyw.Checked = true;
            txtpartyw.Text = dt_docket.Rows[0]["csgenm"].ToString();
            trpartyw.Style["display"] = "block";
            trpartyc.Style["display"] = "none";
        }


        if (hdncsgecd.Value.CompareTo("8888") == 0)
            hdncsgecd.Value = "";

        hdncurrloc.Value = dt_docket.Rows[0]["curr_loc"].ToString();
        hdndeclval.Value = dt_docket.Rows[0]["invamt"].ToString();
        lblgodownname.Text = dt_docket.Rows[0]["godown"].ToString();
        hdnarrpkgqty.Value = dt_docket.Rows[0]["arrpkgqty"].ToString();
        hdnarrweightqty.Value = dt_docket.Rows[0]["arrweightqty"].ToString();
        lblchrgpkg.Text = dt_docket.Rows[0]["arrweightqty"].ToString() + "/" + dt_docket.Rows[0]["arrpkgqty"].ToString();
    }

    protected void btnstep2_Click(object sender, EventArgs e)
    {
        DateTime dtdockdate, dtmrdate, dtserverdate;
        dtdockdate = WebXConvert.ToDateTime(hdndockdate.Value, "en-GB");
        dtserverdate = WebXConvert.ToDateTime(hdnserverdate.Value, "en-GB");
        dtmrdate = WebXConvert.ToDateTime(txtmrdate.Text, "en-GB");

        if (dtmrdate < dtdockdate)
        {
            Response.Redirect("ErrorPage.aspx?heading=Not allowed for Delivery MR&detail1=MR Date is less than " + hdndockname.Value + " Date&Suggestion1=Please Enter MR Date properly&detail2=.", false);
            return;
        }

        if (dtmrdate > dtserverdate)
        {
            Response.Redirect("ErrorPage.aspx?heading=Not allowed for Delivery MR&detail1=MR Date is more than Today's Date&Suggestion1=Please Enter MR Date Today's date or Back Date&detail2=.", false);
            return;
        }

        disableStep2();

        /*****************************************************************************************************
       *  RETRIEVING BASED ON CHARGE RULE
       ******************************************************************************************************/
        hdnchargerule.Value = DocketRules.GetDefaultValue("CHRG_RULE");

        if (hdnchargerule.Value.CompareTo("NONE") == 0)
            hdnbasecode1.Value = "NONE";
        else if (hdnchargerule.Value.CompareTo("SVCTYP") == 0)
            hdnbasecode1.Value = hdnservicetype.Value;
        else if (hdnchargerule.Value.CompareTo("BUT") == 0)
            hdnbasecode1.Value = hdnbusinesstype.Value;

        hdnchargesubrule.Value = ChargeMasterController.GetChargeSubRule("DKT", hdnchargerule.Value, hdnbasecode1.Value);
        if (hdnchargesubrule.Value.CompareTo("PROD") == 0)
            hdnbasecode2.Value = hdnprodtype.Value;
        else if (hdnchargesubrule.Value.CompareTo("NONE") == 0)
            hdnbasecode2.Value = "NONE";
        /******************************************************************************************************/

        hdnflagroundoff.Value = DocketRules.GetDefaultValue("FLAG_ROUND");
        hdncontractid.Value = DocketController.GetContractID(txtpartycode.Text, hdnpaybas.Value, WebXConvert.ToDateTime(txtmrdate.Text, "en-GB").ToString("dd MMM yyyy"));

        loadBookingCharges();

        if (("ABCDEFGHIMXYZ".Contains(ddlsuffix.SelectedValue) && (WebXConvert.ToInt16(hdnarrpkgqty.Value) == WebXConvert.ToInt16(hdnpkgsno.Value)) || (ddlsuffix.SelectedValue.CompareTo(".") == 0 && WebXConvert.ToInt16(hdnarrpkgqty.Value) > 0)))
        {
            if (GetContractInvokeFlag() && hdncontractid.Value.CompareTo("") != 0)
            {
                string depth = DocketRules.GetDefaultValue(hdnpaybas.Value + "DEPTH", hdnpaybas.Value);
                string flagproceed = DocketRules.GetDefaultValue(hdnpaybas.Value + "PROCEED", hdnpaybas.Value);

                ContractKeys ckeys = new ContractKeys();
                ckeys.BasedOn1 = hdnchargerule.Value;
                ckeys.BaseCode1 = hdnbasecode1.Value;
                ckeys.BasedOn2 = hdnchargesubrule.Value;
                ckeys.BaseCode2 = hdnbasecode2.Value;
                ckeys.ChargedWeight = WebXConvert.ToDouble(hdnchargedweight.Value);
                ckeys.ContractID = hdncontractid.Value;
                ckeys.DelLoc = hdndelloc.Value;
                ckeys.Depth = depth;
                ckeys.FlagProceed = flagproceed;
                ckeys.FromCity = hdnfrom.Value;
                ckeys.FTLType = hdnftltype.Value;
                ckeys.NoOfPkgs = WebXConvert.ToInt64(hdnpkgsno.Value);
                ckeys.OrgnLoc = hdnorgnloc.Value;
                ckeys.PayBase = hdnpaybas.Value;
                ckeys.ServiceType = hdnservicetype.Value;
                ckeys.ToCity = hdnto.Value;
                ckeys.TransMode = hdntransmode.Value;
                DocketController.ExecuteFreightContract(ckeys);

                TextBox txtfreightrate = (TextBox)grvcharges.Rows[1].FindControl("txtdelcharge");
                TextBox txtfreightcharge = (TextBox)grvcharges.Rows[2].FindControl("txtdelcharge");

                if (ckeys.FreightCharge != 0 && ckeys.FreightRate != 0)
                {
                    txtfreightrate.Text = ckeys.FreightRate.ToString("F2");
                    txtfreightcharge.Text = ckeys.FreightCharge.ToString("F2");
                }
                hdnratetype.Value = ckeys.RateType;
                if (hdnratetype.Value.CompareTo("") == 0)
                    hdnratetype.Value = "W";
                ContractServices cser = DocketController.GetContractServices(hdncontractid.Value);
                SetChargesGrid(ckeys, cser);
            }


        }

        calculateFreightDifference();

        loadDeliveryCharges();

        loadOctroiDetails();

        calculateSubTotal();

        BindBanks();
    }

    private void loadOctroiDetails()
    {
        string sqlstr = "SELECT UPPER(ISNULL(octroi_io,'N')) AS flagoctroi FROM dbo.webx_location WITH(NOLOCK) WHERE loccode='" + hdncurrloc.Value + "'";
        string flag = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).ToString();
        if (flag == "I" || flag == "O")
        {
            sqlstr = "SELECT TOP 1 ISNULL(octamt,0) AS octamt,ISNULL(processing_per,0) AS processing_per,ISNULL(process_chrg,0) AS process_chrg,";
            sqlstr = sqlstr + " ISNULL(process_chrg,0) AS process_chrg FROM dbo.webx_oct_det WITH(NOLOCK) WHERE dockno='" + txtdockno.Text + "'";
            sqlstr = sqlstr + " AND (voucherno IS NOT NULL OR ocbillno IS NOT NULL)";
            DataTable dt = new DataTable();

            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            if (dt.Rows.Count > 0)
            {

                txtoctcharge.Text = dt.Rows[0]["octamt"].ToString();
                txtoctprocrate.Text = dt.Rows[0]["processing_per"].ToString();
                txtoctproccharge.Text = dt.Rows[0]["process_chrg"].ToString();
            }
            else
            {
                txtoctcharge.Text = "0.00";
                txtoctprocrate.Text = "0.00";
                txtoctproccharge.Text = "0.00";
            }
        }
        else
        {
            txtoctcharge.Text = "0.00";
            txtoctprocrate.Text = "0.00";
            txtoctproccharge.Text = "0.00";
        }
    }

    protected void BindBanks()
    {
        string sqlstr = "";
        try
        {
            sqlstr = "SELECT acccode,accdesc FROM dbo.webx_acctinfo WITH(NOLOCK)" +
                            " WHERE (((bkloccode LIKE 'All' OR PATINDEX ('%" + hdncurrloc.Value + "%',bkloccode)>0)" +
                            " AND acccategory='BANK')) ORDER BY accdesc ";
            DataTable dtbanks = new DataTable();
            dtbanks = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            ddlbank.DataSource = dtbanks;
            ddlbank.DataBind();
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=" + ex.Message.Replace('\n', '_') + "&detail2=Delivery MR Entry Rejected", true);
            return;

        }
    }

    protected void SetChargesGrid(ContractKeys ckeys, ContractServices cser)
    {
        foreach (GridViewRow grvchrg in grvcharges.Rows)
        {
            HiddenField hdnchargecode = (HiddenField)grvchrg.FindControl("hdnchargecode");
            TextBox txtdelcharge = (TextBox)grvchrg.FindControl("txtdelcharge");

            //// FOV CHARGES
            if (hdnchargecode.Value.CompareTo("SCHG11") == 0)
            {
                double fovcharge;
                if (cser.FOVType.CompareTo("%") == 0)
                {
                    if (hdnrisktype.Value.CompareTo("C") == 0)
                        fovcharge = DocketController.ToDouble(hdndeclval.Value) * cser.FOVCarrierRate / 100;
                    else
                        fovcharge = DocketController.ToDouble(hdndeclval.Value) * cser.FOVOwnerRate / 100;
                }
                else
                {
                    fovcharge = cser.FOVCharge;
                }
                txtdelcharge.Text = fovcharge.ToString("F2");
            }

            if (hdnchargecode.Value.CompareTo("SCHG12") == 0)
            {
                if (hdnflagcoddod.Value.CompareTo("Y") == 0)
                    txtdelcharge.Text = cser.CODDODCharged.ToString("F2");
            }
            if (hdnchargecode.Value.CompareTo("SCHG13") == 0)
            {
                if (hdnflagdacc.Value.CompareTo("Y") == 0)
                    txtdelcharge.Text = cser.DACCCharged.ToString("F2");
            }


            if (hdnchargecode.Value.CompareTo("SCHG19") == 0 && hdnflagoda.Value.CompareTo("Y") == 0)
            {
                double[] oda = new double[2];
                oda = DocketController.BindODACharge(hdncontractid.Value, hdnto.Value, DocketController.ToDouble(hdnchargedweight.Value), DocketController.ToDouble(hdnpkgsno.Value), 0);
                txtdelcharge.Text = oda[0].ToString("F2");
            }
            //// FUEL SURCHARGE
            if (hdnchargecode.Value.CompareTo("SCHG20") == 0)
            {
                txtdelcharge.Text = applyFuelSurCharge(ckeys.FreightCharge, ckeys.FoundContract);
            }

        } // GRIDVIEW ROW ENDS HERE
        ////////////
    }

    protected void loadBookingCharges()
    {
        string strsql = "SELECT * FROM dbo.webx_master_docket_charges WITH(NOLOCK) WHERE dockno='" + txtdockno.Text + "'";
        DataTable dt_charges = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

        /************************************************************************************************
         *  SETTING DATA TABLE FOR CHARGES
         ***********************************************************************************************/
        if (hdnchargerule.Value.CompareTo("NONE") == 0)
            strsql = "SELECT contractcharge=0.00,docketcharge=0.00,defaultchargevalue=0.00,chargecode,chargename,operator,varybyloc,activeflag FROM dbo.webx_master_charge WITH(NOLOCK) WHERE basedon='" + hdnchargerule.Value + "' AND activeflag='Y' AND chargetype='DKT' AND booktimeflag='Y'";
        else if (hdnchargerule.Value.CompareTo("SVCTYP") == 0)
            strsql = "SELECT contractcharge=0.00,docketcharge=0.00,defaultchargevalue=0.00,chargecode,chargename,operator,varybyloc,activeflag FROM dbo.webx_master_charge WITH(NOLOCK) WHERE basedon='" + hdnchargerule.Value + "' AND basecode='" + hdnservicetype.Value + "' AND activeflag='Y' AND chargetype='DKT' AND booktimeflag='Y'";
        else if (hdnchargerule.Value.CompareTo("BUT") == 0)
            strsql = "SELECT contractcharge=0.00,docketcharge=0.00,defaultchargevalue=0.00,chargecode,chargename,operator,varybyloc,activeflag FROM dbo.webx_master_charge WITH(NOLOCK) WHERE basedon='" + hdnchargerule.Value + "' AND basecode='" + hdnbusinesstype.Value + "' AND activeflag='Y' AND chargetype='DKT' AND booktimeflag='Y'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

        DataRow dtr = dt.NewRow();
        dtr["chargecode"] = "weight";
        dtr["chargename"] = "Weight";
        dtr["docketcharge"] = hdnchargedweight.Value;
        dtr["contractcharge"] = hdnchargedweight.Value;
        dtr["activeflag"] = "Y";
        dtr["operator"] = "";
        dt.Rows.InsertAt(dtr, 0);

        dtr = dt.NewRow();
        dtr["chargecode"] = "frt_rate";
        dtr["chargename"] = "Freight Rate";
        dtr["docketcharge"] = dt_charges.Rows[0]["frt_rate"].ToString();
        hdnratetype.Value = dt_charges.Rows[0]["rate_type"].ToString();
        dtr["contractcharge"] = "0";
        dtr["activeflag"] = "Y";
        dtr["operator"] = "";
        dt.Rows.InsertAt(dtr, 1);

        dtr = dt.NewRow();
        dtr["chargecode"] = "freight";
        dtr["chargename"] = "Freight Charge";
        dtr["docketcharge"] = dt_charges.Rows[0]["freight"].ToString();
        dtr["contractcharge"] = "0";
        dtr["activeflag"] = "Y";
        dtr["operator"] = "+";
        dt.Rows.InsertAt(dtr, 2);

        for (int i = 3; i < dt.Rows.Count; i++)
        {
            dt.Rows[i]["docketcharge"] = Convert.ToString(dt_charges.Rows[0][Convert.ToString(dt.Rows[i]["chargecode"])]);
            dt.Rows[i]["contractcharge"] = Convert.ToString(dt_charges.Rows[0][Convert.ToString(dt.Rows[i]["chargecode"])]);
        }

        dt.Rows[1]["docketcharge"] = dt_charges.Rows[0]["frt_rate"].ToString();
        dt.Rows[2]["docketcharge"] = dt_charges.Rows[0]["freight"].ToString();
        dt.Rows[1]["contractcharge"] = dt_charges.Rows[0]["frt_rate"].ToString();
        dt.Rows[2]["contractcharge"] = dt_charges.Rows[0]["freight"].ToString();


        if ("ABCDEFGHIMXYZ".Contains(ddlsuffix.SelectedValue) && WebXConvert.ToInt16(hdnarrpkgqty.Value) < WebXConvert.ToInt16(hdnpkgsno.Value))
        {
            grvcharges.DataSource = dt;
            grvcharges.DataBind();
            Label lblbkgsubtotal1 = (Label)(grvcharges.FooterRow.FindControl("lblbkgsubtotal"));
            lblbkgsubtotal1.Text = dt_charges.Rows[0]["subtotal"].ToString();
            return;
        }

        if (GetContractInvokeFlag() && hdncontractid.Value.CompareTo("") != 0)
        {
            strsql = "SELECT * FROM dbo.webx_custcontract_charges WITH(NOLOCK)";
            strsql = strsql + " WHERE contractid='" + hdncontractid.Value + "'";
            strsql = strsql + " AND basedon1='" + hdnchargerule.Value + "' AND basecode1='" + hdnbasecode1.Value + "'";
            strsql = strsql + " AND basedon2='NONE' AND basecode2='NONE'";
            strsql = strsql + " AND chargetype='BKG'";

            DataTable dt_contract = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            if (dt_contract.Rows.Count > 0)
            {
                for (int i = 3; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["contractcharge"] = Convert.ToString(dt_contract.Rows[0][Convert.ToString(dt.Rows[i]["chargecode"])]);
                }
            }
        }

        grvcharges.DataSource = dt;
        grvcharges.DataBind();

        Label lblbkgsubtotal = (Label)(grvcharges.FooterRow.FindControl("lblbkgsubtotal"));
        lblbkgsubtotal.Text = dt_charges.Rows[0]["subtotal"].ToString();
    }

    protected void loadDeliveryCharges()
    {

        string strsql = "";

        /************************************************************************************************
        *  SETTING DATA TABLE FOR CHARGES
        ***********************************************************************************************/
        if (hdnchargerule.Value.CompareTo("NONE") == 0)
            strsql = "SELECT chargevalue=0.00,defaultchargevalue=0.00,chargecode,chargename,operator,varybyloc,activeflag FROM dbo.webx_master_charge WITH(NOLOCK) WHERE basedon='" + hdnchargerule.Value + "' AND activeflag='Y' AND chargetype='DKT' AND deltimeflag='Y'";
        else if (hdnchargerule.Value.CompareTo("SVCTYP") == 0)
            strsql = "SELECT chargevalue=0.00,defaultchargevalue=0.00,chargecode,chargename,operator,varybyloc,activeflag FROM dbo.webx_master_charge WITH(NOLOCK) WHERE basedon='" + hdnchargerule.Value + "' AND basecode='" + hdnservicetype.Value + "' AND activeflag='Y' AND chargetype='DKT' AND deltimeflag='Y'";
        else if (hdnchargerule.Value.CompareTo("BUT") == 0)
            strsql = "SELECT chargevalue=0.00,defaultchargevalue=0.00,chargecode,chargename,operator,varybyloc,activeflag FROM dbo.webx_master_charge WITH(NOLOCK) WHERE basedon='" + hdnchargerule.Value + "' AND basecode='" + hdnbusinesstype.Value + "' AND activeflag='Y' AND chargetype='DKT' AND deltimeflag='Y'";

        DataTable dtcharges = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

        grvdelcharges.DataSource = dtcharges;
        grvdelcharges.DataBind();

        if (("ABCDEFGHIMXYZ".Contains(ddlsuffix.SelectedValue) && (WebXConvert.ToInt16(hdnarrpkgqty.Value) == WebXConvert.ToInt16(hdnpkgsno.Value)) || (ddlsuffix.SelectedValue.CompareTo(".") == 0 && WebXConvert.ToInt16(hdnarrpkgqty.Value) > 0)))
        {
            strsql = "SELECT * FROM dbo.webx_custcontract_charges WITH(NOLOCK) WHERE ";
            strsql = strsql + " contractid='" + hdncontractid.Value + "' AND chargetype='DEL'";
            if (hdnchargerule.Value.CompareTo("NONE") == 0)
                strsql = strsql + " AND basedon1='" + hdnchargerule.Value + "' AND chargetype='DEL'";
            else if (hdnchargerule.Value.CompareTo("SVCTYP") == 0)
                strsql = strsql + " AND basedon1='" + hdnchargerule.Value + "' AND basecode1='" + hdnservicetype.Value + "' AND chargetype='DEL'";
            else if (hdnchargerule.Value.CompareTo("BUT") == 0)
                strsql = strsql + " AND basedon1='" + hdnchargerule.Value + "' AND basecode1='" + hdnbusinesstype.Value + "' AND chargetype='DEL'";

            strsql = strsql + " AND basedon2='NONE' AND basecode2='NONE'";
            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dtcharges.Rows.Count; i++)
                {
                    dtcharges.Rows[i]["chargevalue"] = Convert.ToString(dt.Rows[0][Convert.ToString(dtcharges.Rows[i]["chargecode"])]);
                }
            }

        }
        DataRow dtr = dtcharges.NewRow();
        dtr["chargecode"] = "frt_diff";
        dtr["chargename"] = "Freight Difference";
        TextBox txtdiffsubtotal = (TextBox)grvcharges.FooterRow.FindControl("txtdiffsubtotal");
        dtr["chargevalue"] = txtdiffsubtotal.Text.CompareTo("") == 0 ? "0" : txtdiffsubtotal.Text;
        dtr["activeflag"] = "Y";
        dtr["operator"] = "+";
        dtcharges.Rows.InsertAt(dtr, 0);

        grvdelcharges.DataSource = dtcharges;
        grvdelcharges.DataBind();
    }

    protected void calculateFreightDifference()
    {
        double subtotal = 0;

        foreach (GridViewRow grv in grvcharges.Rows)
        {
            TextBox txtcharge = (TextBox)grv.FindControl("txtdelcharge");
            if (grv.RowIndex != 0 && grv.RowIndex != 1)
                subtotal = subtotal + Convert.ToDouble(txtcharge.Text);
        }

        TextBox txtdelsubtotal = (TextBox)grvcharges.FooterRow.FindControl("txtdelsubtotal");
        subtotal = Math.Round(subtotal, MidpointRounding.AwayFromZero);
        txtdelsubtotal.Text = subtotal.ToString("F2");

        double freightdiff = 0;
        foreach (GridViewRow grv in grvcharges.Rows)
        {
            TextBox txtdelcharge = (TextBox)grv.FindControl("txtdelcharge");
            TextBox txtdiffcharge = (TextBox)grv.FindControl("txtdiffcharge");
            Label lblbkgcharge = (Label)grv.FindControl("lblbkgcharge");
            double diff = 0;
            if (grv.RowIndex != 0 && grv.RowIndex != 1)
            {
                diff = Convert.ToDouble(txtdelcharge.Text) - Convert.ToDouble(lblbkgcharge.Text);
                txtdiffcharge.Text = diff.ToString("F2");
                freightdiff = freightdiff + diff;
            }
        }

        TextBox txtdiffsubtotal = (TextBox)grvcharges.FooterRow.FindControl("txtdiffsubtotal");

        if (hdnflagroundoff.Value.CompareTo("Y") == 0)
            freightdiff = Math.Round(freightdiff, 0, MidpointRounding.AwayFromZero);

        txtdiffsubtotal.Text = freightdiff.ToString("F2");
    }

    protected void calculateSubTotal()
    {
        double subtotal = 0;
        foreach (GridViewRow grv in grvdelcharges.Rows)
        {
            TextBox txtdelcharge = (TextBox)grv.FindControl("txtdelcharge");
            subtotal = subtotal + DocketController.ToDouble(txtdelcharge.Text);
        }

        Label lblbkgsubtotal = (Label)grvcharges.FooterRow.FindControl("lblbkgsubtotal");

        subtotal = subtotal + DocketController.ToDouble(txtoctcharge.Text);
        subtotal = subtotal + DocketController.ToDouble(txtoctproccharge.Text);

        if (hdnpaybas.Value.CompareTo("P03") == 0)
        {
            if (ddlsuffix.SelectedValue == "." || (ddlsuffix.SelectedValue.CompareTo("M") == 0 && WebXConvert.ToInt16(hdnarrpkgqty.Value) == WebXConvert.ToInt16(hdnpkgsno.Value)))
            {
                subtotal = subtotal + DocketController.ToDouble(lblbkgsubtotal.Text);
            }
        }

        if ("ABCDEFGHIXYZ".Contains(ddlsuffix.SelectedValue))
        {
            subtotal = 0.00;
        }

        if (hdnflagroundoff.Value.CompareTo("Y") == 0)
            subtotal = Math.Round(subtotal, MidpointRounding.AwayFromZero);

        txtsubtotal.Text = subtotal.ToString("F2");

        calculateServiceTax();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            validateSubmit();
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + ex.Message.Replace('\n', '_') + "&detail1=Improper Details&detail2=Entry Rejected", true);
            return;
        }

        string strXMLMREntry, strXMLMRChargesEntry, strXMLMRDiffEntry, strXMLGatepassEntry, strXMLBillEntry;


        strXMLMREntry = GetMRObject();
        strXMLMRChargesEntry = GetMRChargesObject();
        strXMLMRDiffEntry = GetDifferenceObject();
        strXMLGatepassEntry = GetGatePassObject();
        strXMLBillEntry = GetBillObject();


        strXMLMREntry = strXMLMREntry.Replace("&", "&amp;");
        strXMLMRChargesEntry = strXMLMRChargesEntry.Replace("&", "&amp;");
        strXMLMRDiffEntry = strXMLMRDiffEntry.Replace("&", "&amp;");
        strXMLGatepassEntry = strXMLGatepassEntry.Replace("&", "&amp;");
        strXMLBillEntry = strXMLBillEntry.Replace("&", "&amp;");

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        SqlTransaction trn = con.BeginTransaction();

        try
        {
            MRController.IsDocketEligibleForDelMR(txtdockno.Text.Trim(), ddlsuffix.SelectedValue, SessionUtilities.CurrentBranchCode, hdnfinstartyear.Value, trn);
        }
        catch (Exception ex)
        {
            trn.Rollback();
            con.Close(); con.Dispose();
            Response.Redirect("ErrorPage.aspx?heading=Not allowed for Delivery MR&detail1=" + ex.Message.Replace('\n', '_') + "&detail2=OR Not proper Service Type.", false);
            return;
        }

        string billno = "NA";
        DataTable dtmr = new DataTable();
        try
        {
            string flagaccounting = "";
            if (("ABCDEFGHIMXYZ".Contains(ddlsuffix.SelectedValue) && (WebXConvert.ToInt16(hdnarrpkgqty.Value) == WebXConvert.ToInt16(hdnpkgsno.Value)) || (ddlsuffix.SelectedValue.CompareTo(".") == 0 && WebXConvert.ToInt16(hdnarrpkgqty.Value) > 0)))
            {
                flagaccounting = "Y";
            }

            dtmr = DeliveryMREntry(strXMLMREntry, strXMLMRChargesEntry, strXMLMRDiffEntry, strXMLGatepassEntry, strXMLBillEntry, flagaccounting, trn);
        }
        catch (Exception ex)
        {
            trn.Rollback();
            con.Close();
            Response.Redirect("../ErrorPage.aspx?heading=Delivery MR Entry Failed&detail1=" + ex.Message.Replace('\n', '_'), false);
            return;
        }
        trn.Commit();
        con.Close();

        Response.Redirect("DeliveryMR_Submit_Done.aspx?mrno=" + dtmr.Rows[0]["mrno"].ToString() + "&billno=" + (Convert.ToString(dtmr.Rows[0]["billno"]).CompareTo("") == 0 ? "NA" : Convert.ToString(dtmr.Rows[0]["billno"])), false);
    }

    protected void calculateServiceTax()
    {
        double bkgsubtotal = 0, subtotal = 0, mrtotal = 0;
        Label lblbkgsubtotal = (Label)(grvcharges.FooterRow.FindControl("lblbkgsubtotal"));
        bkgsubtotal = WebXConvert.ToDouble(lblbkgsubtotal.Text);
        subtotal = WebXConvert.ToDouble(txtsubtotal.Text);
        DocketServiceTax dst = new DocketServiceTax();
        dst.Date = WebXConvert.ToDateTime(hdnserverdate.Value, "en-GB");
        dst.SubTotal = subtotal - WebXConvert.ToDouble(txtoctcharge.Text) - WebXConvert.ToDouble(txtoctproccharge.Text);

        if (hdnflagstaxempted.Value.CompareTo("N") == 0)
        {
            if (hdnflagroundoff.Value.CompareTo("Y") == 0)
            {
                dst.SubTotal = Math.Round(dst.SubTotal, 0, MidpointRounding.AwayFromZero);
            }
        }
        else
        {
            dst.SubTotal = 0;
            lblexmpt.Style["display"] = "block";
        }

        dst.TransMode = hdntransmode.Value;
        dst.ServiceType = hdnservicetype.Value;
        dst.StaxPayer = hdnstaxpayer.Value;

        dst = DocketController.GetServiceTax(dst);
        lblservicetaxrate.Text = dst.STaxRate.ToString("F2");
        lbleducessrate.Text = dst.EduCessRate.ToString("F2");
        lblheducessrate.Text = dst.HEduCessRate.ToString("F2");


        if (hdnflagstaxempted.Value.CompareTo("Y") == 0)
        {
            lblservicetaxrate.Text = "0.00";
            lbleducessrate.Text = "0.00";
            lblheducessrate.Text = "0.00";
        }

        if (hdnflagroundoff.Value.CompareTo("Y") == 0)
        {
            dst.ServiceTax = Math.Round(dst.ServiceTax, 0, MidpointRounding.AwayFromZero);
            dst.EduCess = Math.Round(dst.EduCess, 0, MidpointRounding.AwayFromZero);
            dst.HEduCess = Math.Round(dst.HEduCess, 0, MidpointRounding.AwayFromZero);
        }

        txtservicetax.Text = dst.ServiceTax.ToString("F2");
        txteducess.Text = dst.EduCess.ToString("F2");
        txtheducess.Text = dst.HEduCess.ToString("F2");

        // Generating and Applying Docket Total
        mrtotal = subtotal + dst.ServiceTax + dst.EduCess + dst.HEduCess;

        if (hdnflagroundoff.Value.CompareTo("Y") == 0)
            mrtotal = Math.Round(mrtotal, 0, MidpointRounding.AwayFromZero);

        txtmramount.Text = mrtotal.ToString("F2");
        txtcollamt.Text = mrtotal.ToString("F2");
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnchargecode = (HiddenField)e.Row.FindControl("hdnchargecode");
            Label lbloperator = (Label)e.Row.FindControl("lbloperator");
            HiddenField hdnactiveflag = (HiddenField)e.Row.FindControl("hdnactiveflag");
            if (e.Row.RowIndex > 1)
                lbloperator.Text = "(" + DataBinder.Eval(e.Row.DataItem, "operator") + ")";

            TextBox txtdelcharge = (TextBox)e.Row.FindControl("txtdelcharge");
            if (hdnpaybas.Value.CompareTo("P01") == 0 || hdnpaybas.Value.CompareTo("P02") == 0)
                txtdelcharge.Enabled = false;

            if (e.Row.RowIndex > 2)
            {
                string[] _param_othercharge_req = new string[14];
                _param_othercharge_req[0] = hdnchargecode.Value;
                _param_othercharge_req[1] = "BKG";
                _param_othercharge_req[2] = hdnchargerule.Value;
                _param_othercharge_req[3] = hdnbasecode1.Value;
                _param_othercharge_req[4] = "NONE";
                _param_othercharge_req[5] = "NONE";
                _param_othercharge_req[6] = hdncontractid.Value;
                _param_othercharge_req[7] = hdnfrom.Value;
                _param_othercharge_req[8] = hdnto.Value;
                _param_othercharge_req[9] = hdnorgnloc.Value;
                _param_othercharge_req[10] = hdndelloc.Value;
                _param_othercharge_req[11] = hdntransmode.Value;
                _param_othercharge_req[12] = hdnchargedweight.Value;
                _param_othercharge_req[13] = hdnpkgsno.Value;

                if (GetContractInvokeFlag() && hdncontractid.Value.CompareTo("") != 0)
                {
                    string outcharges = "SCHG11,SCHG12,SCHG13,SCHG19,SCHG20,UCHG01,UCHG02,UCHG03,UCHG04";
                    if (outcharges.IndexOf(hdnchargecode.Value) < 0)
                    {
                        txtdelcharge.Text = DocketController.GetOtherCharge(_param_othercharge_req).ToString("F2");
                    }
                }
            }
            if (hdnchargecode.Value.CompareTo("frt_rate") == 0 || hdnchargecode.Value.CompareTo("weight") == 0)
            {
                txtdelcharge.Attributes.Add("onblur", "javascript:return freightRateBlur('" + txtdelcharge.ClientID.ToString() + "')");
            }

            if (hdnclient.Value.CompareTo("CHAWLA") == 0 || hdnclient.Value.CompareTo("CHC") == 0 || hdnclient.Value.CompareTo("RITCO") == 0)
            {
                e.Row.Style["display"] = "none";
            }
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txtdelsubtotal = (TextBox)(e.Row.FindControl("txtdelsubtotal"));
            if (hdnclient.Value.CompareTo("CHAWLA") == 0 || hdnclient.Value.CompareTo("CHC") == 0)
            {
                if (hdnpaybas.Value.CompareTo("P03") == 0)
                    txtdelsubtotal.Enabled = true;
            }
        }

    }

    protected void grvdelcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnchargecode = (HiddenField)e.Row.FindControl("hdnchargecode");
            HiddenField hdnvarybyloc = (HiddenField)e.Row.FindControl("hdnvarybyloc");
            HiddenField hdnactiveflag = (HiddenField)e.Row.FindControl("hdnactiveflag");

            Label lbloperator = (Label)e.Row.FindControl("lbloperator");

            TextBox txtdelcharge = (TextBox)e.Row.FindControl("txtdelcharge");

            if (e.Row.RowIndex > 0)
                lbloperator.Text = "(" + DataBinder.Eval(e.Row.DataItem, "operator") + ")";
            else
                txtdelcharge.Enabled = false;

            if (hdnvarybyloc.Value.CompareTo("Y") == 0)
            {
                string[] _param_othercharge_req = new string[14];
                _param_othercharge_req[0] = hdnchargecode.Value;
                _param_othercharge_req[1] = "DEL";
                _param_othercharge_req[2] = hdnchargerule.Value;
                _param_othercharge_req[3] = hdnbasecode1.Value;
                _param_othercharge_req[4] = "NONE";
                _param_othercharge_req[5] = "NONE";
                _param_othercharge_req[6] = (hdncontractid.Value.CompareTo("") == 0 ? hdnpaybas.Value + "8888" : hdncontractid.Value);
                _param_othercharge_req[7] = hdnfrom.Value;
                _param_othercharge_req[8] = hdnto.Value;
                _param_othercharge_req[9] = hdnorgnloc.Value;
                _param_othercharge_req[10] = hdndelloc.Value;
                _param_othercharge_req[11] = hdntransmode.Value;
                _param_othercharge_req[12] = hdnchargedweight.Value;
                _param_othercharge_req[13] = hdnpkgsno.Value;

                txtdelcharge.Text = DocketController.GetOtherCharge(_param_othercharge_req).ToString("F2");
            }
        }
    }

    private bool GetContractInvokeFlag()
    {
        //if (hdnpaybas.Value.CompareTo("P01") == 0 || hdnpaybas.Value.CompareTo("P03") == 0)
        //{
        //    if (hdncsgecd.Value.CompareTo(txtpartycode.Text) != 0)
        //    {
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}
        //else if (hdnpaybas.Value.CompareTo("P02") == 0)
        //{
        //    if (optpartytype.SelectedValue.CompareTo("CE") == 0)
        //    {
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}
        return false;
    }


    private string GetMRObject()
    {
        double freightcharge = 0;
        freightcharge = DocketController.ToDouble(((TextBox)grvdelcharges.Rows[0].FindControl("txtdelcharge")).Text);
        string strXMLMREntry = "<root><mr_entry>"
               + "<entryby>" + hdnemployee.Value + "</entryby>" + "<entrydt>GETDATE()</entrydt><mrssf>.</mrssf>"
               + "<mrsdt>" + WebXConvert.ToDateTime(txtmrdate.Text, "en-GB").ToString("dd MMM yyyy") + "</mrsdt>"
               + "<mrstype>12</mrstype>" + "<mrsbr>" + hdncurrloc.Value + "</mrsbr>" +
               "<dockno>" + txtdockno.Text.Trim() + "</dockno>" + "<docksf>" + ddlsuffix.SelectedValue + "</docksf>"
               + "<dockdt>" + WebXConvert.ToDateTime(hdndockdate.Value, "en-GB").ToString("dd MMM yyyy") + "</dockdt>";
        if (hdnpaybas.Value.CompareTo("P02") == 0)
        {
            if (optpartytype.SelectedValue.CompareTo("P") == 0)
            {
                if (hdnpartycode.Value.CompareTo("") == 0)
                {
                    Response.Redirect("ErrorPage.aspx?heading=Party Code Missing.&detail1=&suggesion1=", false);
                }
                strXMLMREntry = strXMLMREntry + "<ptcd>" + hdnpartycode.Value + "</ptcd>" + "<ptname>" + hdnpartyname.Value + "</ptname>";
            }
            else
            {
                if (optpartyc.Checked == true)
                {
                    strXMLMREntry = strXMLMREntry + "<ptcd>" + txtpartycode.Text + "</ptcd>" + "<ptname>" + txtpartyname.Text + "</ptname>";
                }
                else
                {
                    strXMLMREntry = strXMLMREntry + "<ptcd>8888</ptcd>" + "<ptname>" + txtpartyw.Text + "</ptname>";
                }
            }
        }
        else
        {
            if (optpartyc.Checked == true)
            {
                strXMLMREntry = strXMLMREntry + "<ptcd>" + txtpartycode.Text + "</ptcd>" + "<ptname>" + txtpartyname.Text + "</ptname>";
            }
            else
            {

                strXMLMREntry = strXMLMREntry + "<ptcd>8888</ptcd>" + "<ptname>" + txtpartyw.Text + "</ptname>";
            }
        }
        strXMLMREntry = strXMLMREntry + "<ptpin></ptpin><pttel></pttel>"
        + "<ptadd></ptadd><oldptcd>" + hdncsgecd.Value + "</oldptcd><oldptname>" + hdncsgenm.Value + "</oldptname>"
        + "<orgncd>" + hdnorgnloc.Value + "</orgncd><destcd>" + hdndelloc.Value + "</destcd>"
        + "<nopkgs>" + hdnarrpkgqty.Value + "</nopkgs>"
        + "<chrgwt>" + hdnarrweightqty.Value + "</chrgwt>"
        + "<paybas>" + hdnpaybas.Value + "</paybas>"
        + "<svctax_rate>" + lblservicetaxrate.Text.Trim() + "</svctax_rate><cess_rate>" + lbleducessrate.Text.Trim() + "</cess_rate>"
        + "<h_cess_rate>" + lblheducessrate.Text.Trim() + "</h_cess_rate><col_frt>" + freightcharge + "</col_frt>"
        + "<col_stax>" + txtservicetax.Text + "</col_stax><col_cess>" + txteducess.Text + "</col_cess>"
        + "<col_h_cess>" + txtheducess.Text + "</col_h_cess><mrsamt>" + txtmramount.Text.Trim() + "</mrsamt>"
        + "<mrs_closed>Y</mrs_closed>"
        + "<mr_cancel>N</mr_cancel><mrcollbrcd>" + hdncurrloc.Value + "</mrcollbrcd>"
        + "<col_oct>" + txtoctcharge.Text + "</col_oct><col_octprchrg>" + txtoctproccharge.Text + "</col_octprchrg>"
        + "<paymode>" + ddlpaymode.SelectedValue + "</paymode><finclosedt>" + WebXConvert.ToDateTime(txtmrdate.Text, "en-GB").ToString("dd MMM yyyy") + "</finclosedt>";
        if (ddlpaymode.SelectedValue.CompareTo("CASH") == 0)
        {
            strXMLMREntry = strXMLMREntry + "<mrscash>" + txtcollamt.Text + "</mrscash><mrschq>0</mrschq>"
            + "<mrschqdt>01 JAN 2000</mrschqdt>"
            + "<mrschqno></mrschqno>"
            + "<mrsbank></mrsbank><bankacccode></bankacccode>"
            + "<flagchqdepo>N</flagchqdepo>";
        }
        else if (ddlpaymode.SelectedValue.CompareTo("CHEQUE") == 0)
        {
            strXMLMREntry = strXMLMREntry + "<mrscash>0</mrscash><mrschq>" + txtcollamt.Text + "</mrschq>"
            + "<mrschqdt>" + WebXConvert.ToDateTime(txtchequedate.Text, "en-GB").ToString("dd MMM yyyy") + "</mrschqdt>"
            + "<mrschqno>" + txtchequeno.Text.Trim() + "</mrschqno>"
            + "<mrsbank>" + txtissuebank.Text + "</mrsbank>";

            if (optdeposit.SelectedValue.CompareTo("Y") == 0)
                strXMLMREntry = strXMLMREntry + "<bankacccode>" + ddlbank.SelectedValue + "</bankacccode>";
            else
                strXMLMREntry = strXMLMREntry + "<bankacccode>ACA0002</bankacccode>";
            strXMLMREntry = strXMLMREntry + "<flagchqdepo>" + optdeposit.SelectedValue + "</flagchqdepo>";

        }
        strXMLMREntry = strXMLMREntry + "</mr_entry></root>";
        return strXMLMREntry;
    }

    private string GetGatePassObject()
    {
        string strXMLGPEntry = "<root><gatepass_entry>"
        + "<gpbrcd>" + hdncurrloc.Value + "</gpbrcd>"
        + "<dockno>" + txtdockno.Text + "</dockno>"
        + "<gatepassdate>" + WebXConvert.ToDateTime(txtmrdate.Text, "en-GB").ToString("dd MMM yyyy") + "</gatepassdate>";
        if (hdnpaybas.Value.CompareTo("P02") == 0)
        {
            if (optpartytype.SelectedValue.CompareTo("P") == 0)
            {
                if (hdnpartycode.Value.CompareTo("") == 0)
                {
                    Response.Redirect("ErrorPage.aspx?heading=Party Code Missing.&detail1=&suggesion1=", false);
                }
                strXMLGPEntry = strXMLGPEntry + "<ptcd>" + hdnpartycode.Value + "</ptcd>" + "<ptname>" + hdnpartyname.Value + "</ptname>";
            }
            else
            {
                if (optpartyc.Checked == true)
                {
                    strXMLGPEntry = strXMLGPEntry + "<ptcd>" + txtpartycode.Text + "</ptcd>" + "<ptname>" + txtpartyname.Text + "</ptname>";
                }
                else
                {
                    strXMLGPEntry = strXMLGPEntry + "<ptcd>8888</ptcd>" + "<ptname>" + txtpartyw.Text + "</ptname>";
                }
            }
        }
        else
        {
            if (optpartyc.Checked == true)
            {
                strXMLGPEntry = strXMLGPEntry + "<ptcd>" + txtpartycode.Text + "</ptcd>" + "<ptname>" + txtpartyname.Text + "</ptname>";
            }
            else
            {

                strXMLGPEntry = strXMLGPEntry + "<ptcd>8888</ptcd>" + "<ptname>" + txtpartyw.Text + "</ptname>";
            }
        }
        if (optrecc.Checked == true)
        {
            strXMLGPEntry = strXMLGPEntry + "<receivercode>" + txtreceivercode.Text + "</receivercode>";
            strXMLGPEntry = strXMLGPEntry + "<receivername>" + txtreceivername.Text + "</receivername>";
        }
        else
        {
            strXMLGPEntry = strXMLGPEntry + "<receivercode>8888</receivercode>";
            strXMLGPEntry = strXMLGPEntry + "<receivername>" + txtreceiverw.Text + "</receivername>";
        }
        strXMLGPEntry = strXMLGPEntry + "<delvehicle>" + txtdelvehicle.Text + "</delvehicle>";
        strXMLGPEntry = strXMLGPEntry + "<remarks>" + txtremarks.Text + "</remarks>";
        strXMLGPEntry = strXMLGPEntry + "<activeflag>Y</activeflag>";
        strXMLGPEntry = strXMLGPEntry + "<entryby>" + hdnemployee.Value + "</entryby>";
        strXMLGPEntry = strXMLGPEntry + "<entrydate>GETDATE()</entrydate></gatepass_entry></root>";
        return strXMLGPEntry;
    }

    private string GetBillObject()
    {
        Bill bill = new Bill();
        double billamt = WebXConvert.ToDouble(txtmramount.Text) - WebXConvert.ToDouble(txtcollamt.Text);
        string strXMLBillEntry = "<root><bill_entry><billno></billno>"
        + "<bgndt>" + WebXConvert.ToDateTime(txtmrdate.Text, "en-GB").ToString("dd MMM yyyy") + "</bgndt>"
        + "<bbrcd>" + hdncurrloc.Value + "</bbrcd>"
        + "<paybas>11</paybas>"
        + "<ptmscd>" + txtpartycode.Text + "</ptmscd>"
        + "<ptmsnm>" + txtpartyname.Text + "</ptmsnm>"
        + "<ptmsaddr></ptmsaddr>"
        + "<ptmstel></ptmstel>"
        + "<ptmsemail></ptmsemail>"
        + "<remark >" + txtremarks.Text + "</remark >"
        + "<billamt>" + billamt.ToString("F2") + "</billamt>"
        + "<pendamt>" + billamt.ToString("F2") + "</pendamt>"
        + "<billstatus>BILL GENERATED</billstatus>"
        + "<closebill>N</closebill>"
        + "<bgenempcd>" + hdnemployee.Value + "</bgenempcd>"
        + "<bill_cancel>N</bill_cancel>"
        + "<billsubbrcd>" + hdncurrloc.Value + "</billsubbrcd>"
        + "<billcolbrcd>" + hdncurrloc.Value + "</billcolbrcd>"
        + "<svrcamt>" + txtservicetax.Text + "</svrcamt>"
        + "<cessamt>" + txteducess.Text + "</cessamt>"
        + "<hedu_cess>" + txtheducess.Text + "</hedu_cess>";
        if (WebXConvert.ToDouble(txtservicetax.Text) == 0)
        {
            strXMLBillEntry = strXMLBillEntry + "<svctax_rate>0</svctax_rate>"
                + "<cess_rate>0</cess_rate>"
                + "<h_cess_rate>0</h_cess_rate>";
        }
        else
        {
            strXMLBillEntry = strXMLBillEntry + "<svctax_rate>" + lblservicetaxrate.Text + "</svctax_rate>"
        + "<cess_rate>" + lbleducessrate.Text + "</cess_rate>"
        + "<h_cess_rate>" + lblheducessrate.Text + "</h_cess_rate>";
        }

        strXMLBillEntry = strXMLBillEntry + "<businesstype>" + hdnbusinesstype.Value + "</businesstype>"
        + "<dockno>" + txtdockno.Text + "</dockno>"
        + "<docksf>" + ddlbank.SelectedValue + "</docksf>"
        + "<orgncd>" + hdnorgnloc.Value + "</orgncd>"
        + "<reassign_destcd>" + hdndelloc.Value + "</reassign_destcd>"
        + "<dockdt>" + WebXConvert.ToDateTime(hdndockdate.Value, "en-GB").ToString("dd MMM yyyy") + "</dockdt>"
        + "<chrgwt>" + hdnchargedweight.Value + "</chrgwt></bill_entry></root>";
        return strXMLBillEntry;
    }

    private string GetMRChargesObject()
    {

        string[] arrchargenames = new string[34];
        double[] arrcharges = new double[34];

        for (int i = 1; i < 24; i++)
        {
            arrchargenames[i] = "SCHG" + i.ToString().PadLeft(2, '0');
        }
        for (int i = 1; i < 11; i++)
        {
            arrchargenames[i + 23] = "UCHG" + i.ToString().PadLeft(2, '0');
        }

        foreach (GridViewRow grv in grvdelcharges.Rows)
        {
            TextBox txtdelcharge = (TextBox)grv.FindControl("txtdelcharge");
            HiddenField hdnchargecode = (HiddenField)grv.FindControl("hdnchargecode");

            for (int i = 1; i < 34; i++)
            {
                if (arrchargenames[i].CompareTo(hdnchargecode.Value) == 0)
                {
                    arrcharges[i] = DocketController.ToDouble(txtdelcharge.Text.Trim());
                }
            }
        }

        string strXMLMrChargesEntry = "<root><mr_charges_entry>"
        + "<MRNO></MRNO>"
        + "<MRSF>.</MRSF>"
        + "<DOCKNO>" + txtdockno.Text.Trim() + "</DOCKNO>"
        + "<FREIGHT_DIFF>" + ((TextBox)grvdelcharges.Rows[0].FindControl("txtdelcharge")).Text + "</FREIGHT_DIFF>";

        if (hdnpaybas.Value.CompareTo("P03") == 0)
            strXMLMrChargesEntry = strXMLMrChargesEntry + "<FREIGHT>" + ((TextBox)grvcharges.Rows[2].FindControl("txtdelcharge")).Text + "</FREIGHT>";
        else
            strXMLMrChargesEntry = strXMLMrChargesEntry + "<FREIGHT>0</FREIGHT>";
        for (int i = 1; i < 34; i++)
        {
            strXMLMrChargesEntry = strXMLMrChargesEntry + "<" + arrchargenames[i] + ">" + arrcharges[i] + "</" + arrchargenames[i] + ">";
        }
        strXMLMrChargesEntry = strXMLMrChargesEntry + "<SUBTOTAL>" + txtsubtotal.Text + "</SUBTOTAL>"
        + "<SVCTAX>" + txtservicetax.Text + "</SVCTAX>"
        + "<CESS>" + txteducess.Text + "</CESS>"
        + "<HEDU_CESS>" + txtheducess.Text + "</HEDU_CESS>"
        + "<MRSAMT>" + txtmramount.Text + "</MRSAMT>"
        + "</mr_charges_entry></root>";

        return strXMLMrChargesEntry;
    }

    private string GetDifferenceObject()
    {
        string[] arrchargenames = new string[34];
        double[] arrcharges = new double[34];

        for (int i = 1; i < 24; i++)
        {
            arrchargenames[i] = "SCHG" + i.ToString().PadLeft(2, '0');
        }
        for (int i = 1; i < 11; i++)
        {
            arrchargenames[i + 23] = "UCHG" + i.ToString().PadLeft(2, '0');
        }

        foreach (GridViewRow grv in grvcharges.Rows)
        {
            TextBox txtdiffcharge = (TextBox)grv.FindControl("txtdiffcharge");
            HiddenField hdnchargecode = (HiddenField)grv.FindControl("hdnchargecode");

            for (int i = 1; i < 34; i++)
            {
                if (arrchargenames[i].CompareTo(hdnchargecode.Value) == 0)
                {
                    arrcharges[i] = DocketController.ToDouble(txtdiffcharge.Text.Trim());
                }
            }
        }
        string strXMLMrDiffEntry = "<root><mr_diff_entry>"
            + "<MRNO></MRNO><MRSF>.</MRSF><DOCKNO>" + txtdockno.Text.Trim() + "</DOCKNO>";
        if (hdnpaybas.Value.CompareTo("P03") == 0)
            strXMLMrDiffEntry = strXMLMrDiffEntry + "<FREIGHT>" + DocketController.ToDouble(((TextBox)grvcharges.Rows[2].FindControl("txtdelcharge")).Text).ToString("F2") + "</FREIGHT>";
        else
            strXMLMrDiffEntry = strXMLMrDiffEntry + "<FREIGHT>0</FREIGHT>";

        for (int i = 1; i < 34; i++)
        {
            strXMLMrDiffEntry = strXMLMrDiffEntry + "<" + arrchargenames[i] + ">" + arrcharges[i] + "</" + arrchargenames[i] + ">";
        }
        strXMLMrDiffEntry = strXMLMrDiffEntry + "</mr_diff_entry></root>";
        return strXMLMrDiffEntry;
    }
    /***********************************************************************************************/



    protected bool validateSubmit()
    {

        Exception ex;
        double subtotal = 0;
        foreach (GridViewRow grv in grvdelcharges.Rows)
        {
            TextBox txtdelcharge = (TextBox)grv.FindControl("txtdelcharge");
            subtotal = subtotal + DocketController.ToDouble(txtdelcharge.Text);
        }

        Label lblbkgsubtotal = (Label)grvcharges.FooterRow.FindControl("lblbkgsubtotal");

        subtotal = subtotal + DocketController.ToDouble(txtoctcharge.Text);
        subtotal = subtotal + DocketController.ToDouble(txtoctproccharge.Text);

        if (hdnpaybas.Value.CompareTo("P03") == 0)
        {
            if (ddlsuffix.SelectedValue == "." || (ddlsuffix.SelectedValue.CompareTo("M") == 0 && WebXConvert.ToInt16(hdnarrpkgqty.Value) == WebXConvert.ToInt16(hdnpkgsno.Value)))
            {
                subtotal = subtotal + DocketController.ToDouble(lblbkgsubtotal.Text);
            }
        }
        if (hdnflagroundoff.Value.CompareTo("Y") == 0)
            subtotal = Math.Round(subtotal, MidpointRounding.AwayFromZero);

        if (WebXConvert.ToDouble(txtsubtotal.Text) != subtotal)
        {
            ex = new Exception("Mismatch in charge calculation");
            throw ex;
        }


        if (DocketController.ToDouble(txtsubtotal.Text) < 0)
        {
            ex = new Exception("SubTotal Can't be less than Zero");
            throw ex;
        }

        if (DocketController.ToDouble(txtmramount.Text) < 0)
        {
            ex = new Exception("MR Amount Can't be less than Zero.");
            throw ex;
        }


        if (!"ABCDEFGHIMXYZ".Contains(ddlsuffix.SelectedValue) && ddlsuffix.SelectedValue.CompareTo(".") != 0)
        {
            ex = new Exception("Invalid Suffix for " + hdndockname.Value + " " + txtdockno.Text);
            throw ex;
        }

        if ("ABCDEFGHIXYZ".Contains(ddlsuffix.SelectedValue))
        {
            if (DocketController.ToDouble(txtsubtotal.Text) > 0)
            {
                ex = new Exception("Suffix " + hdndockname.Value + " Can't have Sub Total more than Zero.");
                throw ex;
            }

            if (DocketController.ToDouble(txtmramount.Text) > 0)
            {
                ex = new Exception("Suffix " + hdndockname.Value + " Can't have MR Amount more than Zero.");
                throw ex;
            }
        }


        if ("M".Contains(ddlsuffix.SelectedValue) && WebXConvert.ToInt64(hdnarrpkgqty.Value) == WebXConvert.ToInt64(hdnpkgsno.Value))
        {
            if (DocketController.ToDouble(txtsubtotal.Text) <= 0)
            {
                ex = new Exception("Full Misrouted " + hdndockname.Value + " Can't have Sub Total Zero.");
                throw ex;
            }

            if (DocketController.ToDouble(txtmramount.Text) <= 0)
            {
                ex = new Exception("Full Misrouted " + hdndockname.Value + " Can't have MR Amount Zero.");
                throw ex;
            }
        }

        if (hdnpaybas.Value.CompareTo("P03") == 0 && (("M".Contains(ddlsuffix.SelectedValue) && WebXConvert.ToInt64(hdnarrpkgqty.Value) == WebXConvert.ToInt64(hdnpkgsno.Value)) || ddlsuffix.SelectedValue.CompareTo(".") == 0))
        {
            if (DocketController.ToDouble(txtsubtotal.Text) == 0)
            {
                ex = new Exception("SubTotal Can't be less than Zero.");
                throw ex;
            }

            if (DocketController.ToDouble(txtmramount.Text) == 0)
            {
                ex = new Exception("MR Amount Can't be less than Zero.");
                throw ex;
            }
        }

        if (("M".Contains(ddlsuffix.SelectedValue) && WebXConvert.ToInt64(hdnarrpkgqty.Value) == WebXConvert.ToInt64(hdnpkgsno.Value)) || ddlsuffix.SelectedValue.CompareTo(".") == 0)
        {
            if (ddlpaymode.SelectedValue.CompareTo("") == 0)
            {
                ex = new Exception("Payment Mode is not Proper.");
                throw ex;
            }

            if (ddlpaymode.SelectedValue.CompareTo("CHEQUE") == 0)
            {
                if (ddlbank.SelectedValue.CompareTo("") == 0 || ddlbank.SelectedValue.CompareTo("0") == 0)
                {
                    ex = new Exception("Bank Name is not Selected.");
                    throw ex;
                }

                if (txtchequeno.Text.CompareTo("") == 0)
                {
                    ex = new Exception("Cheque Number not found.");
                    throw ex;
                }

                if (txtchequedate.Text.CompareTo("") == 0)
                {
                    ex = new Exception("Cheque Date not found.");
                    throw ex;
                }

                DateTime dt = WebXConvert.ToDateTime(txtchequedate.Text, "en-GB");
                string sql = "SELECT COUNT(chqno) FROM dbo.webx_chq_det WITH(NOLOCK) WHERE chqno='" + txtchequeno.Text.Trim() + "'";
                sql = sql + " AND chqdt='" + dt.ToString("dd MMM yyyy") + "'";
                int cnt = 0;
                try
                {
                    cnt = Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sql));
                }
                catch (Exception exe)
                {
                    throw exe;
                }

                if (cnt != 0)
                {
                    ex = new Exception("Entered Cheque Already Exists.");
                    throw ex;
                }

            }
        }
        return true;
    }

    protected void disableStep2()
    {
        trbtnstep2.Style["display"] = "none";
        trcharges.Style["display"] = "block";
        trsumit.Style["display"] = "block";
        trpaymode.Style["display"] = "block";
        txtmrdate.Enabled = false;
        txtdelvehicle.Enabled = false;
        txtremarks.Enabled = false;

        txtpartycode.Enabled = false;
        txtpartyname.Enabled = false;
        txtpartyw.Enabled = false;
        btnpartypopup.Disabled = true;
        optpartyw.Enabled = false;
        optpartyc.Enabled = false;
        optpartytype.Enabled = false;
        if (optpartytype.SelectedValue.CompareTo("P") == 0)
        {
            trcneewc.Style["display"] = "none";
            trpartyc.Style["display"] = "none";
            trpartyw.Style["display"] = "none";
        }
        else
        {
            trcneewc.Style["display"] = "block";
            if (optpartyc.Checked == true)
            {
                trpartyc.Style["display"] = "block";
                trpartyw.Style["display"] = "none";
            }
            else
            {
                trpartyc.Style["display"] = "none";
                trpartyw.Style["display"] = "block";
            }

        }


        chkpartpayment.Enabled = false;
        btnpartypopup.Disabled = true;
        optrecc.Enabled = false;
        optrecw.Enabled = false;
        txtreceivercode.Enabled = false;
        txtreceivername.Enabled = false;
        txtreceiverw.Enabled = false;


        if (optrecc.Checked == true)
        {
            trrecc.Style["display"] = "block";
            trrecw.Style["display"] = "none";
        }
        else
        {
            trrecc.Style["display"] = "none";
            trrecw.Style["display"] = "block";
        }

        txtcollamt.Enabled = chkpartpayment.Checked;
    }

    protected string applyFuelSurCharge(double freightchrg, string foundcontract)
    {
        string fuelsurchargeflag = "", fuelsurchargebasair = "", fuelsurchargebasroad = "", fuelsurchargebastrain = "", fuelsurchargebasexpress = "";
        double fuelsurchargeair = 0, fuelminchargeair = 0, fuelmaxchargeair = 0;
        double fuelsurchargeroad = 0, fuelminchargeroad = 0, fuelmaxchargeroad = 0;
        double fuelsurchargetrain = 0, fuelminchargetrain = 0, fuelmaxchargetrain = 0;
        double fuelsurchargeexpress = 0, fuelminchargeexpress = 0, fuelmaxchargeexpress = 0;

        double totalsurcharge = 0.00;

        string sqlstr = "SELECT diesel_hike_yn,min_fuelsurchrgair,max_fuelsurchrgair,";
        sqlstr = sqlstr + " min_fuelsurchrgroad,max_fuelsurchrgroad,min_fuelsurchrgtrain,max_fuelsurchrgtrain,";
        sqlstr = sqlstr + " min_fuelsurchrgexpress,max_fuelsurchrgexpress,fuelsurchrgbasair,fuelsurchrgbasroad,";
        sqlstr = sqlstr + " fuelsurchrgbastrain,fuelsurchrgbasexpress,air_fuelsurchrg,road_fuelsurchrg,";
        sqlstr = sqlstr + " train_fuelsurchrg,express_fuelsurchrg ";
        sqlstr = sqlstr + " FROM dbo.webx_custcontract_charge WITH(NOLOCK) WHERE contractid='" + hdncontractid.Value + "'";
        SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
        while (dr.Read())
        {
            fuelsurchargeflag = Convert.ToString(dr["diesel_hike_yn"]);
            fuelminchargeair = WebXConvert.ToDouble(Convert.ToString(dr["min_fuelsurchrgair"]));
            fuelmaxchargeair = WebXConvert.ToDouble(Convert.ToString(dr["max_fuelsurchrgair"]));
            fuelminchargeroad = WebXConvert.ToDouble(Convert.ToString(dr["min_fuelsurchrgroad"]));
            fuelmaxchargeroad = WebXConvert.ToDouble(Convert.ToString(dr["max_fuelsurchrgroad"]));
            fuelminchargetrain = WebXConvert.ToDouble(Convert.ToString(dr["min_fuelsurchrgtrain"]));
            fuelmaxchargetrain = WebXConvert.ToDouble(Convert.ToString(dr["max_fuelsurchrgtrain"]));
            fuelminchargeexpress = WebXConvert.ToDouble(Convert.ToString(dr["min_fuelsurchrgexpress"]));
            fuelmaxchargeexpress = WebXConvert.ToDouble(Convert.ToString(dr["max_fuelsurchrgexpress"]));

            fuelsurchargebasair = Convert.ToString(dr["fuelsurchrgbasair"]);
            fuelsurchargebasroad = Convert.ToString(dr["fuelsurchrgbasroad"]);
            fuelsurchargebastrain = Convert.ToString(dr["fuelsurchrgbastrain"]);
            fuelsurchargebasexpress = Convert.ToString(dr["fuelsurchrgbasexpress"]);

            fuelsurchargeair = WebXConvert.ToDouble(Convert.ToString(dr["air_fuelsurchrg"]));
            fuelsurchargeroad = WebXConvert.ToDouble(Convert.ToString(dr["road_fuelsurchrg"]));
            fuelsurchargetrain = WebXConvert.ToDouble(Convert.ToString(dr["train_fuelsurchrg"]));
            fuelsurchargeexpress = WebXConvert.ToDouble(Convert.ToString(dr["express_fuelsurchrg"]));
        }
        dr.Close();

        if (fuelsurchargeflag.ToUpper().CompareTo("Y") == 0)
        {
            switch (hdntransmode.Value)
            {
                case "1":
                    switch (fuelsurchargebasair)
                    {
                        case "F":
                            totalsurcharge = fuelsurchargeair;
                            break;
                        case "%":
                            totalsurcharge = (freightchrg * fuelsurchargeair) / 100;
                            break;
                        case "W":
                            totalsurcharge = (WebXConvert.ToDouble(hdnchargedweight.Value) * fuelsurchargeair);
                            break;
                    }
                    break;
                case "2":
                    switch (fuelsurchargebasroad)
                    {
                        case "F":
                            totalsurcharge = fuelsurchargeroad;
                            break;
                        case "%":
                            totalsurcharge = (freightchrg * fuelsurchargeroad) / 100;
                            break;
                        case "W":
                            totalsurcharge = (WebXConvert.ToDouble(hdnchargedweight.Value) * fuelsurchargeroad);
                            break;
                    }

                    break;
                case "3":
                    switch (fuelsurchargebastrain)
                    {
                        case "F":
                            totalsurcharge = fuelsurchargetrain;
                            break;
                        case "%":
                            totalsurcharge = (freightchrg * fuelsurchargetrain) / 100;
                            break;
                        case "W":
                            totalsurcharge = (WebXConvert.ToDouble(hdnchargedweight.Value) * fuelsurchargetrain);
                            break;
                    }

                    break;
                case "4":
                    switch (fuelsurchargebasexpress)
                    {
                        case "F":
                            totalsurcharge = fuelsurchargeexpress;
                            break;
                        case "%":
                            totalsurcharge = (freightchrg * fuelsurchargeexpress) / 100;
                            break;
                        case "W":
                            totalsurcharge = (WebXConvert.ToDouble(hdnchargedweight.Value) * fuelsurchargeexpress);
                            break;
                    }

                    break;
            } // TRANS MODE SWITCH
        }

        // APPLYING MIN-MAX
        switch (hdntransmode.Value)
        {
            case "1":
                if (totalsurcharge < fuelminchargeair)
                    totalsurcharge = fuelminchargeair;
                if (totalsurcharge > fuelmaxchargeair)
                    totalsurcharge = fuelmaxchargeair;

                break;
            case "2":
                if (totalsurcharge < fuelminchargeroad)
                    totalsurcharge = fuelminchargeroad;
                if (totalsurcharge > fuelmaxchargeroad)
                    totalsurcharge = fuelmaxchargeroad;

                break;
            case "3":
                if (totalsurcharge < fuelminchargetrain)
                    totalsurcharge = fuelminchargetrain;
                if (totalsurcharge > fuelmaxchargetrain)
                    totalsurcharge = fuelmaxchargetrain;
                break;
            case "4":
                if (totalsurcharge < fuelminchargeexpress)
                    totalsurcharge = fuelminchargeexpress;
                if (totalsurcharge > fuelmaxchargeexpress)
                    totalsurcharge = fuelmaxchargeexpress;
                break;

        }

        return totalsurcharge.ToString("F2");
    }

    public DocketServiceTax GetServiceTax(DocketServiceTax dst)
    {
        TaxRate trate = new TaxRate();
        trate.Date = dst.Date;
        trate = TaxRateController.GetTaxObject(trate);

        dst.StdSTaxRate = trate.ServiceTaxRate;
        dst.StdEduCessRate = trate.EduCessRate;
        dst.StdHEduCessRate = trate.HEduCessRate;

        dst.STaxRate = trate.ServiceTaxRate;
        dst.EduCessRate = trate.EduCessRate;
        dst.HEduCessRate = trate.HEduCessRate;
        double comp_subtotal = dst.SubTotal;


        // FOR ROAD MODE TRANSPORTER GETS 75% REBET
        if (dst.TransMode.CompareTo("2") == 0 || dst.TransMode.CompareTo("4") == 0)
        {
            if (dst.ServiceType.CompareTo("1") == 0 && dst.SubTotal > 750)
                dst.STaxRate = trate.ServiceTaxRate * 0.25;
            else if (dst.ServiceType.CompareTo("2") == 0 && dst.SubTotal > 1500)
                dst.STaxRate = trate.ServiceTaxRate * 0.25;
            else
                dst.STaxRate = 0.00;
        }

        if (dst.StaxPayer.CompareTo("T") == 0)
        {
            dst.ServiceTax = dst.SubTotal * dst.STaxRate / 100;
            dst.EduCess = dst.ServiceTax * dst.EduCessRate / 100;
            dst.HEduCess = dst.ServiceTax * dst.HEduCessRate / 100;
        }
        else
        {
            dst.ServiceTax = 0;
            dst.EduCess = 0;
            dst.HEduCess = 0;
        }
        return dst;
    }

    public DataTable DeliveryMREntry(string strXMLMREntry, string strXMLMRChargesEntry, string strXMLMRDiffEntry, string strXMLGatepassEntry, string strXMLBillEntry, string flagacc, SqlTransaction trn)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[7];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLMREntry", strXMLMREntry, SqlDbType.NVarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@strXMLMRChargesEntry", strXMLMRChargesEntry, SqlDbType.NVarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@strXMLMRDiffEntry", strXMLMRDiffEntry, SqlDbType.NVarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@strXMLGatepassEntry", strXMLGatepassEntry, SqlDbType.NVarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@strXMLBillEntry", strXMLBillEntry, SqlDbType.NVarChar);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@flagacc", flagacc, SqlDbType.VarChar);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@finyear4d", hdnfinstartyear.Value, SqlDbType.VarChar);

            dt = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, "USP_DELMR_ENTRY", paramsToStore).Tables[0];

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return dt;
    }

}


//strXMLMREntry = strXMLMREntry.Replace("<mrno></mrno>", "<mrno>" + hdnmrno.Value + "</mrno>");

//strXMLGatepassEntry = strXMLGatepassEntry.Replace("<mrno></mrno>", "<mrno>" + hdnmrno.Value + "</mrno>");
//strXMLGatepassEntry = strXMLGatepassEntry.Replace("<gatepassno></gatepassno>", "<gatepassno>" + hdnmrno.Value + "</gatepassno>");


//strXMLMRChargesEntry = strXMLMRChargesEntry.Replace("<mrno></mrno>", "<mrno>" + hdnmrno.Value + "</mrno>");
//strXMLMRDiffEntry = strXMLMRDiffEntry.Replace("<mrno></mrno>", "<mrno>" + hdnmrno.Value + "</mrno>");


//string voucherno = MRController.DelMRAccountTransaction(txtdockno.Text, ddlsuffix.SelectedValue, hdnemployee.Value, hdnfinstartyear.Value, trn);

//if (ddlpaymode.SelectedValue.CompareTo("CHEQUE") == 0)
//{
//    // ChequeEntry(mr, voucherno, trn);
//}

//if (DocketController.ToDouble(txtcollamt.Text) < DocketController.ToDouble(txtmramount.Text))
//{
//    strXMLBillEntry = GetBillObject();
//    strXMLBillEntry = strXMLBillEntry.Replace("<billno></billno>", "<billno>" + DataProvider.GetNewBillCode("DBL", hdncurrloc.Value, "N", "", hdnfinstartyear.Value, trn) + "</billno>");
//}

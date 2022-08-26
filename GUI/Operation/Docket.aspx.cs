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
using System.IO;

public partial class GUI_Operation_DocketEntry_Docket : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;
    public string dkt_call = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        // GETTING OBJECT OF LIABRARY
        fn = new MyFunctions();

        // GETTING SQL CONNECTION AND OPENING IT
        try
        {
            con = new SqlConnection(Convert.ToString(Session["SqlProvider"]).Trim());
            con.Open();

            // STORES NAME OF CLIENT, FOR CLIENT SPECIFIC SETTINGS
            hdnclient.Value = Session["client"].ToString().ToUpper();

            // NOMACLEDGER, NAME OF DOCKET IS DIFFERENT FOR EACH CLIENT, SO GETTING FROM SESSION
            dkt_call = Convert.ToString(Session["DocketCalledAs"]);
        }
        catch (Exception ex)
        {
            string exmess = ex.Message.ToString().Replace('\n', '_');
            Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session TimeOut Occured&detail2=" + exmess + "&suggestion2=Docket Entry");
        }


        // SOME OBJECT DECLARATION
        string sqlstr = "";
        SqlCommand cmd;
        SqlDataReader dr;

        if (!IsPostBack)
        {

            // FINANCIAL YEAR TO BE PASSED AT ACCOUNTING METHODS
            hdnfinstartyear.Value = Session["finyear"].ToString();


            /*****************************************************************************************************
             *      DOCKET ENTRY HAS CONTRACT SPECIFIC BEHAVIOR
             *      GETTING RULES FROM DATABASE
             *****************************************************************************************************/
            sqlstr = "SELECT * FROM webx_rules_docket WHERE code IN ('P01CONTRACT','P02CONTRACT','P03CONTRACT') ORDER BY  code";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dtrules = new DataTable();
            da.Fill(dtrules);


            for (int i = 0; i < dtrules.Rows.Count; i++)
            {
                hdncontractsets.Value = hdncontractsets.Value + dtrules.Rows[i]["defaultvalue"].ToString() + ",";

            }


            // PAGE LOAD VISIBILITY SETTINGS
            txtpartycode.BackColor = System.Drawing.Color.FromName("#e6e6e6");
            divpartycsgne.Style["display"] = "none";
            btnpartypopup.Style["display"] = "none";

            hdnfoundcontract.Value = "W";
            hdnrecordfind.Value = "N";

            trtransmode.Style["display"] = "none";
            trpickupdel.Style["display"] = "none";
            trpacktype.Style["display"] = "none";
            trvolumetric.Style["display"] = "none";
            trlocal.Style["display"] = "none";
            trdacc.Style["display"] = "none";
            trbtnstep2.Style["display"] = "none";
            lblsourcedockname.Style["display"] = "none";
            txtsourcedockno.Style["display"] = "none";
            imgsourcedock.Style["display"] = "none";
            trmultipoint.Style["display"] = "none";

            divmpsources.Style["display"] = "none";
            lblsourcedockname.Text = "Source" + hdndockname.Value;




            try
            {
                // STORING NAME OF EMPLOYEE THAT ENTERES DOCKET
                hdnemployee.Value = Convert.ToString(Session["empcd"]);

                // NAME OF CURRENT LOCATION SELECTED BY USER,i.e. ORIGIN OF DOCKET
                lblorgnloc.Text = Convert.ToString(Session["brcd"]);
            }
            catch (Exception ex)
            {
                string exmess = ex.Message.ToString().Replace('\n', '_');
                Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session TimeOut Occured&detail2=" + exmess + "&suggestion2=Docket Entry");
            }

            // ALSO JAVASCRIPT USES DOCKET NAME,EASY TO RETRIEVE IN JAVASCRIPT VIA HIDDENFIELD
            hdndockname.Value = dkt_call;


            // GETTING DATEBASE SERVER'S TODAYS'S DATE IN dd/MM/yyyy FORMAT
            sqlstr = "SELECT TOP 1 date=CONVERT(VARCHAR,GETDATE(),103) FROM webx_location";
            cmd = new SqlCommand(sqlstr, con);
            hdnserverdate.Value = Convert.ToString(cmd.ExecuteScalar()).Trim();
            txtdockdate.Text = hdnserverdate.Value;


            // GETTING DATEBASE SERVER'S TODAYS'S DATE IN dd/MM/yyyy FORMAT
            sqlstr = "SELECT CONVERT(VARCHAR(2), GETDATE(), 108)";
            cmd = new SqlCommand(sqlstr, con);
            hdnserverhour.Value = Convert.ToString(cmd.ExecuteScalar()).Trim();


            // FILLING PAYMENT TYPES FROM DATABASE
            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='PAYTYP' AND statuscode='Y' AND codeid IN ('P01','P02','P03','P04')";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            cmbpaybas.Items.Clear(); // Must Clear Combo
            cmbpaybas.Items.Add(new ListItem("Select", "0")); // A UnSelection Item
            while (dr.Read())
            {
                cmbpaybas.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"]).ToUpper()));
            }
            dr.Close();


            // DISABLING PARTYCODE FOR THE FIRST TIME
            txtpartycode.Enabled = false;



            /*******************************************************************************************
             *      CLIENT SPECIFIC AREA THAT MAKES DIFFERENT SETTINGS CLIENTS
             ******************************************************************************************/
            if (hdnclient.Value.CompareTo("RCPL") != 0)
            {
                txtfrom.Attributes.Add("onblur", "javascript:return cityTest('from',this.getAttribute('id'))");
                txtto.Attributes.Add("onblur", "javascript:return cityTest('to',this.getAttribute('id'))");
            }
            else
            {
                txtfrom.Attributes.Add("onblur", "this.value=this.value.toUpperCase()");
                txtto.Attributes.Add("onblur", "this.value=this.value.toUpperCase()");
            }

            if (hdnclient.Value.CompareTo("RLL") == 0)
            {
                cmbratetype.Items.Add(new ListItem("Rate/KG", "W"));
                cmbratetype.Items.Add(new ListItem("Rate/Pkg", "P"));
            }
            else
            {
                cmbratetype.Items.Add(new ListItem("Rate/KG", "W"));
                cmbratetype.Items.Add(new ListItem("Rate/Pkg", "P"));
                cmbratetype.Items.Add(new ListItem("Rate/Ton", "T"));
                cmbratetype.Items.Add(new ListItem("Flat", "F"));
            }


            if (hdnclient.Value.CompareTo("RLL") == 0)
            {
                lblfromcityname.Text = "BKG Remote";
                lbltocityname.Text = "DLY Remote";
            }

            if (hdnclient.Value.CompareTo("RITCO") == 0)
                lblstaxexmpname.Style["display"] = "block";
            else
                lblstaxexmpname.Style["display"] = "none";

            txtdockno.Focus();
        } // IsPostBack ENDS HERE ------------------------------------------------------------------------>



    } // Page_Load ENDS HERE ------------------------------------------------------------------------>


    protected void btnstep1_Click(object sender, EventArgs e)
    {
        // STEP 1 VISIBILIY, DISABLING ALL CONTRACTS AT STEP1
        disableStep1();

        SqlCommand cmd;
        SqlDataReader dr;
        string sqlstr = "";


        // VALIDATION OF VALUES THAT ARE ENERED AT STEP1
        step1Validation();

        // RETRIEVING CONTRACT ID FOR ACTIVE CONTRACT
        sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE contract_type='" + cmbpaybas.SelectedValue + "'";
        sqlstr = sqlstr + " AND custcode='" + txtpartycode.Text + "'";
        sqlstr = sqlstr + " AND activeflag='Y' AND '" + fn.Mydate1(txtdockdate.Text) + "' BETWEEN contract_effectdate AND contract_eddate";
        cmd = new SqlCommand(sqlstr, con);
        hdncontractid.Value = Convert.ToString(cmd.ExecuteScalar());
        /////////////

        // GETTING RULES FROM DATABASE
        sqlstr = "SELECT * FROM webx_rules_docket WHERE paybas='" + cmbpaybas.SelectedValue + "'";
        cmd = new SqlCommand(sqlstr, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dtrules = new DataTable();
        da.Fill(dtrules);
        ////////////



        // STORING TYPE OF CONTRACT PROGRAM RETRIEVED,i.e. DEFAULT, CUSTOMER WISE
        for (int i = 0; i < dtrules.Rows.Count; i++)
        {
            if (dtrules.Rows[i]["code"].ToString().CompareTo(cmbpaybas.SelectedValue + "CONTRACT") == 0)
            {
                hdncontracttype.Value = dtrules.Rows[i]["defaultvalue"].ToString();
            }
        }


        /*************************************************************************************************
         * LOADING DATA AS PER CONTRACT(DEFAUL OR CUSTOMER WISE)
         **************************************************************************************************/
        bool road_yn = false, express_yn = false, air_yn = false, rail_yn = false, ftl_yn = false, sundry_yn = false;
        bool coddod_enable_yn = false, dacc_enable_yn = false, volumetric_yn = false;
        string pickupdel = "";

        sqlstr = "USP_GET_CONTRACT_FLAGS";
        cmd = new SqlCommand(sqlstr, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@paybas", cmbpaybas.SelectedValue);
        cmd.Parameters.Add("@contractid", hdncontractid.Value);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (Convert.ToString(dr["FLAG_REC"]).CompareTo("Y") == 0)
            {
                air_yn = Convert.ToString(dr["FLAG_AIR"]).CompareTo("Y") == 0 ? true : false;
                road_yn = Convert.ToString(dr["FLAG_ROAD"]).CompareTo("Y") == 0 ? true : false;
                rail_yn = Convert.ToString(dr["FLAG_TRAIN"]).CompareTo("Y") == 0 ? true : false;
                express_yn = Convert.ToString(dr["FLAG_EXPRESS"]).CompareTo("Y") == 0 ? true : false;

                sundry_yn = Convert.ToString(dr["FLAG_SUNDRY"]).CompareTo("Y") == 0 ? true : false;
                ftl_yn = Convert.ToString(dr["FLAG_FTL"]).CompareTo("Y") == 0 ? true : false;

                volumetric_yn = Convert.ToString(dr["FLAG_VOLUMETRIC"]).CompareTo("Y") == 0 ? true : false;
                coddod_enable_yn = Convert.ToString(dr["FLAG_CODDOD"]).CompareTo("Y") == 0 ? true : false;
                dacc_enable_yn = Convert.ToString(dr["FLAG_DACC"]).CompareTo("Y") == 0 ? true : false;

                pickupdel = Convert.ToString(dr["PICKUP_DEL"]);
            }
        }
        dr.Close();


        // SETTING FLAGS GOT FROM CONTRACT
        setTransMode(air_yn, road_yn, rail_yn, express_yn);
        setServiceType(sundry_yn, ftl_yn);
        setFTLType();
        setPickDel(pickupdel);

        chkcoddod.Enabled = coddod_enable_yn;
        chkdacc.Enabled = dacc_enable_yn;
        chkvolumetric.Enabled = volumetric_yn;
        // END OF FILLING CONTROAL AS PER CONTRACT



        /***********************************************************************************************
         *  FILLING OF GENERAL CONTROLS
         **********************************************************************************************/

        // Filling Packaging Type
        sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='PKGS' AND statuscode='Y'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        cmbpacktype.Items.Clear();
        cmbpacktype.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cmbpacktype.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"])));
        }
        dr.Close();

        //Filling Product types (Say to Contain)
        sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='PROD' AND statuscode='Y'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        cmbprodtype.Items.Clear();
        cmbprodtype.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cmbprodtype.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"])));
        }
        dr.Close();


        //Filling Business type
        sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='BUT' AND statuscode='Y'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        cmbbusinesstype.Items.Clear();
        cmbbusinesstype.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cmbbusinesstype.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"])));
        }
        dr.Close();


        //Filling Load type
        sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='LOT' AND statuscode='Y'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        cmbloadtype.Items.Clear();
        cmbloadtype.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cmbloadtype.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"])));
        }
        dr.Close();
        // END OF FILLING GENERAL CONTROLS



        // GETTING BUSINESS TYPE & TRANSMODE RULES ACCORDING TO DCR FROM DATABASE
        sqlstr = "SELECT * FROM webx_rules_docket WHERE code IN ('DCR_BUSINESS','DCR_TRANSMODE')";
        cmd = new SqlCommand(sqlstr, con);
        da = new SqlDataAdapter(cmd);
        dtrules = new DataTable();
        da.Fill(dtrules);


        // STORING TYPE OF CONTRACT PROGRAM RETRIEVED,i.e. DEFAULT, CUSTOMER WISE
        string dcr_business = "N", dcr_transmode = "N";
        for (int i = 0; i < dtrules.Rows.Count; i++)
        {
            if (dtrules.Rows[i]["code"].ToString().CompareTo("DCR_BUSINESS") == 0)
            {
                dcr_business = dtrules.Rows[i]["defaultvalue"].ToString();
            }

            if (dtrules.Rows[i]["code"].ToString().CompareTo("DCR_TRANSMODE") == 0)
            {
                dcr_transmode = dtrules.Rows[i]["defaultvalue"].ToString();
            }
        }


        if (dcr_business.CompareTo("Y") == 0)
        {
            setDCRBusinessType();
        }

        if (dcr_business.CompareTo("Y") == 0 && dcr_transmode.CompareTo("Y") == 0)
        {
            setDCRBusinessTransMode();
        }





        /*******************************************************************************************************
         *  CLIENT SPECIFIC SETTINGS
         *******************************************************************************************************/

        // AGILITY SPECIAL MULTI-POINT SETTINGS
        if (hdnclient.Value.ToUpper().CompareTo("AGILITY") == 0)
        {
            cmbloadtype.Style["display"] = "marker";
            lblloadtypename.Style["display"] = "marker";

            loadMPSources();
        }
        else
        {
            trmultipoint.Style["display"] = "none";
        }

        if (hdnclient.Value.CompareTo("RITCO") == 0)
        {
            lbldopinoname.Style["display"] = "marker";
            txtdopino.Style["display"] = "marker";
        }


        if (hdnclient.Value.CompareTo("RITCO") == 0)
        {
            if (chkservicetaxexemp.Checked == true)
            {
                try
                {
                    cmbtransmode.SelectedValue = "3";
                }
                catch (Exception ex) { }
            }
        }

        if (hdnclient.Value.CompareTo("ASL") == 0)
        {
            chkpermit.Checked = true;
        }


        if (hdnclient.Value.ToUpper().CompareTo("RLL") == 0)
        {
            try
            {
                cmbbusinesstype.SelectedValue = "3";
            }
            catch (Exception ex) { }
        }


        if (hdnclient.Value.CompareTo("RLL") == 0)
        {
            try
            {
                cmbpickupdel.SelectedValue = "4";
            }
            catch (Exception ex) { }

            try
            {
                cmbservicetype.SelectedValue = "1";
            }
            catch (Exception ex) { }
            try
            {
                cmbtransmode.SelectedValue = "4";
            }
            catch (Exception ex) { }
        }

        // SETTING FOCUS FOR, HELPS TO USER WHOSE USE ONLY KEY BOARD
        cmbtransmode.Focus();

    } // btnstep1_Click ENDS HERE



    protected void btnstep2_Click(object sender, EventArgs e)
    {

        // VISIBILITY AT STEP 2
        disableStep2();

        // VALIDATION OF VALUES WHICH WERE ENTERED IN STEP 2
        step2Validation();

        // CLIENT SPECIFIC SETTINGS
        if (hdnclient.Value.ToUpper().CompareTo("VARUNA") == 0)
        {
            trentrysheetno.Style["display"] = "marker";
        }

        // Load type field is demanded by agility only
        if (hdnclient.Value.ToUpper().CompareTo("AGILITY") == 0)
        {
            lblloadtypename.Style["display"] = "marker";
            cmbloadtype.Style["display"] = "marker";
        }

        if (hdnclient.Value.ToUpper().CompareTo("PTN") == 0 || hdnclient.Value.ToUpper().CompareTo("RLL") == 0 || hdnclient.Value.ToUpper().CompareTo("UFL") == 0 || hdnclient.Value.ToUpper().CompareTo("RCPL") == 0)
        {
            optownerrisk.Checked = true;
            optcarrierrisk.Checked = false;
        }
        else
        {
            optownerrisk.Checked = false;
            optcarrierrisk.Checked = true;
        }


        if (hdnclient.Value.CompareTo("AGILITY") == 0)
        {
            if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
            {
                trmultipoint.Style["display"] = "block";
            }

            if (chkmultidelivery.Checked == true || chkmultidelivery.Checked == true)
            {
                lblsourcedockname.Style["display"] = "block";
                txtsourcedockno.Style["display"] = "block";
                imgsourcedock.Style["display"] = "block";
            }
        }

        // STATE WISE DOCUMENT DETAILS
        applyDocumentDetails();

        // BY DEFAULT CUSTOMER REFERENCE NO IS DOCKET NUMBER
        txtcustrefno.Text = txtdockno.Text;

        // THIS FUNCTION CHECKS WHERE THE TOCITY IS ODA OR NOT
        checkODA();

        SqlCommand cmd;
        string sqlstr = "";

        if (hdncontractid.Value.CompareTo("") != 0)
        {
            sqlstr = "USP_GET_STEP2_RATES";
            cmd = new SqlCommand(sqlstr, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@contractid", hdncontractid.Value);
        }
        else
        {
            sqlstr = "USP_GET_DEFAULT_STEP2_RATES";
            cmd = new SqlCommand(sqlstr, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@paybas", cmbpaybas.SelectedValue);
            cmd.Parameters.Add("@transmode", cmbtransmode.SelectedValue);
        }
        SqlDataReader dr = cmd.ExecuteReader();
        string risktype = "";
        if (dr.Read())
        {
            risktype = dr["risktype"].ToString();
            hdncft2kg.Value = returnDouble(Convert.ToString(dr["cft2kg"])).ToString("F2");
            txtcubicrate.Text = hdncft2kg.Value;
            hdnvolmeasuretype.Value = dr["cftmeasure"].ToString().Trim();
            txtbilledat.Text = Convert.ToString(dr["billingloc"]);

            hdnfovtype.Value = Convert.ToString(dr["fovtype"]);
            hdnfovcharge.Value = Convert.ToString(dr["fovcharge"]);
            hdnfovownerrate.Value = Convert.ToString(dr["ownerrisk_rate"]);
            hdnfovcarrierrate.Value = Convert.ToString(dr["carrierrisk_rate"]);

            txtcoddodcharged.Text = returnDouble(Convert.ToString(dr["coddodcharge"])).ToString("F2");
            txtdacccharged.Text = returnDouble(Convert.ToString(dr["dacccharge"])).ToString("F2");

        }
        else
        {
            Response.Redirect("ErrorPage.aspx?heading=Contract At Step 2 Not Found." + dkt_call + " &detail1=&detail2=&suggestion2=Enter Valid Contract");
            return;
        }
        dr.Close();


        if (risktype.CompareTo("C") == 0)
        {
            optcarrierrisk.Checked = true;
            optownerrisk.Checked = false;
        }
        else if (risktype.CompareTo("O") == 0)
        {
            optownerrisk.Checked = true;
            optcarrierrisk.Checked = false;
        }


        if (hdnvolmeasuretype.Value.CompareTo("") == 0 || hdnvolmeasuretype.Value.CompareTo("-1") == 0)
        {
            hdnvolmeasuretype.Value = "INCHES";
            txtcubicrate.Text = "0";
        }

        // EXCEPTION FOR BILLED AT Billed At Location is not available then Enable text box
        if (txtbilledat.Text.CompareTo("") == 0)
        {
            txtbilledat.Text = lblorgnloc.Text.Trim();
            txtbilledat.Enabled = true;
        }

        //EXCEPTION FOR MINIMUM FREIGHT, SETTING MINIMUM FREIGHT IN HIDDEN 
        if (hdnminfreightbas.Value.CompareTo("") == 0)
        {
            hdnminfreightbas.Value = "RS";
            hdnminfreightrate.Value = "0.00";
        }

        // FILLING SERVICE TAX PAID BY DROPDOWN MENU BASED UPON TRANSMODE
        cmbstaxpaidby.Items.Clear();
        if (cmbtransmode.SelectedValue.CompareTo("2") == 0)
        {
            cmbstaxpaidby.Items.Add(new ListItem("Select", "0"));
            if (cmbpaybas.SelectedValue.CompareTo("P02") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Billing Party", "P"));
            }
            else if (cmbpaybas.SelectedValue.CompareTo("P01") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Consignor", "CO"));
            }
            else if (cmbpaybas.SelectedValue.CompareTo("P03") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Consignee", "CE"));
            }
            else if (cmbpaybas.SelectedValue.CompareTo("P04") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Billing Party", "P"));
            }
        }

        if (hdnclient.Value.CompareTo("RCPL") == 0)
        {
            cmbstaxpaidby.Items.Add(new ListItem("Select", "0"));
            if (cmbpaybas.SelectedValue.CompareTo("P02") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Billing Party", "P"));
            }
            else if (cmbpaybas.SelectedValue.CompareTo("P01") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Consignor", "CO"));
            }
            else if (cmbpaybas.SelectedValue.CompareTo("P03") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Consignee", "CE"));
            }
            else if (cmbpaybas.SelectedValue.CompareTo("P04") == 0)
            {
                cmbstaxpaidby.Items.Add(new ListItem("Billing Party", "P"));
            }
        }
        cmbstaxpaidby.Items.Add(new ListItem("Transporter", "T"));



        // SETTING FOCUS, HELPS USER WHO USE ONLY KEY BOARD
        txtcsgncd.Focus();

    } // btnstep2_Click ENDS HERE



    // ON pgChange EVENT OF DOCUMENT GRID THIS FUNCTION IS CALLED TO SET NEW RECORDS
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }




    // INVOICE FUNCTIONS STARTS HERE
    protected void grvinvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (chkvolumetric.Checked == false)
            {
                e.Row.Cells[3].Style["display"] = "none"; // Length
                e.Row.Cells[4].Style["display"] = "none"; // Breadth
                e.Row.Cells[5].Style["display"] = "none"; // Height
                e.Row.Cells[8].Style["display"] = "none"; // Total
            }
            else
            {
                Label lbllength = (Label)e.Row.FindControl("lbllength");
                Label lblbreadth = (Label)e.Row.FindControl("lblbreadth");
                Label lblheight = (Label)e.Row.FindControl("lblheight");

                if (hdnvolmeasuretype.Value.CompareTo("CM") == 0)
                {
                    lbllength.Text = "Length(in CMs)";
                    lblbreadth.Text = "Breadth(in CMs)";
                    lblheight.Text = "Height(in CMs)";
                }
                else
                {
                    lbllength.Text = "Length(in Inches)";
                    lblbreadth.Text = "Breadth(in Inches)";
                    lblheight.Text = "Height(in Inches)";
                }
            }
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {

            string s = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("txtinvoicedate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkinvoicedate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkinvoicedate")).Attributes.Add("onclick", s);


            if (chkvolumetric.Checked == false)
            {
                e.Row.Cells[3].Style["display"] = "none"; // Length
                e.Row.Cells[4].Style["display"] = "none"; // Breadth
                e.Row.Cells[5].Style["display"] = "none"; // Height
                e.Row.Cells[8].Style["display"] = "none"; // Total
            }
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            if (chkvolumetric.Checked == false)
            {
                e.Row.Cells[3].Style["display"] = "none"; // Length
                e.Row.Cells[4].Style["display"] = "none"; // Breadth
                e.Row.Cells[5].Style["display"] = "none"; // Height
                e.Row.Cells[8].Style["display"] = "none"; // Total
            }
        }

    }

    protected void btnaddrows_click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("SRNO", typeof(string));
        int rows = Convert.ToInt16(txtinvoicerows.Text);
        if (chkvolumetric.Checked == true)
            trcubicfeet.Style["display"] = "marker";
        else
            trcubicfeet.Style["display"] = "none";
        dt.Rows.Clear();
        for (int i = 0; i < rows; i++)
        {
            dt.Rows.Add();
        }

        int j = 0;
        foreach (DataRow dtr in dt.Rows)
        {
            dtr["srno"] = ++j;
        }
        grvinvoice.DataSource = dt;
        grvinvoice.DataBind();
    }




    // STEP 4 FUNCIONS
    protected void btnpayment_Click(object sender, EventArgs e)
    {
        disableStep3();
        disableStep4();

        divpayment.Style["display"] = "none";
        divcharges.Style["display"] = "marker";

        // VALIDATION OF CONSIGNOR CONSIGNEE DEATILS AND INVOICE DEATAILS
        step3Validation();

        string sqlstr = "";
        SqlCommand cmd;
        SqlDataReader dr;


        // FOV/CODDOD/DACC DISPLAY SETTINGS
        // FOV SETTINGS 
        sqlstr = "SELECT UPPER(statuscode) FROM webx_master_general WHERE codeid='SCHG11' AND codetype='CHG'";
        cmd = new SqlCommand(sqlstr, con);
        string flag_fov = Convert.ToString(cmd.ExecuteScalar());

        if (flag_fov.Trim().CompareTo("Y") == 0)
            trfov.Style["display"] = "marker";
        else
        {
            txtfovcharged.Text = "0.00";
            txtfovrate.Text = "0.00";
            txtfovcalculated.Text = "0.00";
            trfov.Style["display"] = "none";
        }

        // CODDOD SETTINGS
        if (chkcoddod.Checked == true)
            trcoddod.Style["display"] = "marker";
        else
        {
            txtcoddodcharged.Text = "0.00";
            txtcoddodcollected.Text = "0.00";
            trcoddod.Style["display"] = "none";
        }

        // DACC SETTING
        if (chkdacc.Checked == true)
            trdacccharge.Style["display"] = "marker";
        else
        {
            txtdacccharged.Text = "0.00";
            txtdacccollected.Text = "0.00";
            trdacccharge.Style["display"] = "none";
        }



        sqlstr = "SELECT * FROM webx_rules_docket WHERE paybas='" + cmbpaybas.SelectedValue + "'";
        cmd = new SqlCommand(sqlstr, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dtrules = new DataTable();
        da.Fill(dtrules);

        // string contract_type = "C";
        for (int i = 0; i < dtrules.Rows.Count; i++)
        {
            if (dtrules.Rows[i]["code"].ToString().CompareTo(cmbpaybas.SelectedValue + "DEPTH") == 0)
            {
                hdncontractdepth.Value = dtrules.Rows[i]["defaultvalue"].ToString();
            }
        }


        if (hdncontracttype.Value.CompareTo("C") == 0)
        {
            applyContractFreight(hdncontractdepth.Value);
            hdnfoundcontract.Value = "C";
        }
        else if (hdncontracttype.Value.CompareTo("CD") == 0)
        {
            applyContractFreight(hdncontractdepth.Value);
            hdnfoundcontract.Value = "C";
            if (returnDouble(txtfreightcharge.Text) == 0 || returnDouble(txtfreightrate.Text) == 0)
            {
                applyDefaultFreight(hdncontractdepth.Value);
                hdnfoundcontract.Value = "D";
            }
        }
        else if (hdncontracttype.Value.CompareTo("D") == 0)
        {
            applyDefaultFreight(hdncontractdepth.Value);
            hdnfoundcontract.Value = "D";
        }
        else if (hdncontracttype.Value.CompareTo("W") == 0)
        {
            hdnfoundcontract.Value = "W";
            //hdnminfreightbas.Value = "RS";
            //hdnminfreighttype.Value = "B";
            hdnminfreightrate.Value = "0.00";
            txtfreightrate.Text = "0.00";
            txtfreightcharge.Text = "0.00";
        }
        /************************************************************************************************
        *APPLYING YIELD RATE i.e. MOST IMPORTANT FOR MINIMUM FREIGHT RATE FROM CONTRACT
        ************************************************************************************************/
        hdnyieldsubtotalrate.Value = txtfreightrate.Text;
        /***********************************************************************************************/


        if (hdncontractdepth.Value.CompareTo("M") == 0)
        {
            checkFreightLimits();
        }


        string strproceed = "";
        for (int i = 0; i < dtrules.Rows.Count; i++)
        {
            if (dtrules.Rows[i]["code"].ToString().CompareTo(cmbpaybas.SelectedValue + "PROCEED") == 0)
            {
                strproceed = dtrules.Rows[i]["defaultvalue"].ToString();
            }
        }

        if (strproceed.CompareTo("N") == 0)
        {
            if (returnDouble(txtfreightcharge.Text) == 0 || returnDouble(txtfreightcharge.Text) == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Contract Freight Charge is not Found. Can't Enter " + dkt_call + " &detail1=Strict Contract Validation&detail2=&suggestion2=Enter Valid Contract");
                return;
            }
        }


        // CALCULATE FOV FROM DELCARED VALUE AND CONTRACT
        applyFOV();


        // ADDING PRORATA IN FREIGHT
        if (hdnclient.Value.CompareTo("AGILITY") == 0)
        {
            if (cmbpaybas.SelectedValue.CompareTo("P02") == 0 && cmbservicetype.SelectedValue.CompareTo("2") == 0)
            {
                txtfreightcharge.Text = returnDouble(Convert.ToString(returnDouble(txtfreightcharge.Text) + returnDouble(applyProRataCharges()))).ToString("F2");
            }
        }


        // CHAREGS FIDDING

        // Prepare a datatable with needed column to assign Grid
        DataTable dt = new DataTable();
        dt.Columns.Add("chargecode", typeof(string));
        dt.Columns.Add("chargename", typeof(string));
        dt.Columns.Add("chargevalue", typeof(string));
        dt.Columns.Add("statuscode", typeof(string));

        // Filling charges in datatable from charge master regardless applicable or not later on display property will be none
        sqlstr = "SELECT codeid,chargename=codedesc,statuscode,chargevalue='0.00',codeid as chargecode FROM webx_master_general WHERE codetype='CHG' AND statuscode='Y' AND codeid not in ('SCHG11','SCHG12','SCHG13') ORDER BY statuscode desc";
        cmd = new SqlCommand(sqlstr, con);
        da = new SqlDataAdapter(cmd);
        da.Fill(dt);

        DataTable dtcharges = new DataTable();
        dtcharges.Columns.Add("chargecode1", typeof(string));
        dtcharges.Columns.Add("chargename1", typeof(string));
        dtcharges.Columns.Add("chargevalue1", typeof(string));
        dtcharges.Columns.Add("statuscode1", typeof(string));
        dtcharges.Columns.Add("chargecode2", typeof(string));
        dtcharges.Columns.Add("chargename2", typeof(string));
        dtcharges.Columns.Add("chargevalue2", typeof(string));
        dtcharges.Columns.Add("statuscode2", typeof(string));

        if (dt.Rows.Count % 2 != 0)
            dt.Rows.Add();

        int rwscnt = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dtcharges.Rows.Add();
            dtcharges.Rows[rwscnt]["chargecode1"] = dt.Rows[i]["chargecode"].ToString();
            dtcharges.Rows[rwscnt]["chargename1"] = dt.Rows[i]["chargename"].ToString();
            dtcharges.Rows[rwscnt]["chargevalue1"] = dt.Rows[i]["chargevalue"].ToString();
            dtcharges.Rows[rwscnt]["statuscode1"] = dt.Rows[i]["statuscode"].ToString();
            i++;
            dtcharges.Rows[rwscnt]["chargecode2"] = dt.Rows[i]["chargecode"].ToString();
            dtcharges.Rows[rwscnt]["chargename2"] = dt.Rows[i]["chargename"].ToString();
            dtcharges.Rows[rwscnt]["chargevalue2"] = dt.Rows[i]["chargevalue"].ToString();
            dtcharges.Rows[rwscnt]["statuscode2"] = dt.Rows[i]["statuscode"].ToString();
            rwscnt++;
        }


        if (hdnfoundcontract.Value.CompareTo("C") == 0)
            sqlstr = "SELECT * FROM vw_custcontract_charge WHERE contractid='" + hdncontractid.Value + "'";
        else if (hdnfoundcontract.Value.CompareTo("D") == 0)
            sqlstr = "SELECT * FROM vw_default_contract_charge WHERE ltrim(rtrim(contract_type))='" + cmbpaybas.SelectedValue.Trim() + "' AND trans_type='" + cmbtransmode.SelectedValue.Trim() + "'";
        else
        {   // FOC HAS NO CONTRACT NO VALUE SO THEY ARE ZERO
            sqlstr = "SELECT SCHG01=0,SCHG02=0,SCHG03=0,SCHG04=0,SCHG05=0,SCHG06=0,SCHG07=0,SCHG08=0,SCHG09=0,SCHG10=0,";
            sqlstr = sqlstr + "SCHG11=0,SCHG12=0,SCHG13=0,SCHG14=0,SCHG15=0,SCHG16=0,SCHG17=0,SCHG18=0,SCHG19=0,SCHG20=0,";
            sqlstr = sqlstr + "SCHG21=0,SCHG22=0,SCHG23=0,UCHG01=0,UCHG02=0,UCHG03=0,UCHG04=0,UCHG05=0,UCHG06=0,UCHG07=0,";
            sqlstr = sqlstr + "UCHG08=0,UCHG09=0,UCHG10=0";
        }

        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        string code = "";
        if (dr.Read())
        {
            // NUMBER OF SIMPLE CHARGES 24
            for (int i = 0; i < dtcharges.Rows.Count; i++)
            {
                dtcharges.Rows[i]["chargevalue1"] = returnDouble(Convert.ToString(dr[Convert.ToString(dtcharges.Rows[i]["chargecode1"])])).ToString("F2");
                try
                {
                    dtcharges.Rows[i]["chargevalue2"] = returnDouble(Convert.ToString(dr[Convert.ToString(dtcharges.Rows[i]["chargecode2"])])).ToString("F2");
                }
                catch (Exception ex)
                {
                    if (i != dtcharges.Rows.Count - 1)
                    {
                        string exmess = ex.Message.ToString().Replace('\n', '_');
                        Response.Redirect("ErrorPage.aspx?heading=Critical Error. Charge Filling from DataBase Problem Zero&detail1=Programming Error&detail2=" + exmess + "&suggestion2=Docket Entry");
                    }
                    else
                    {
                        dtcharges.Rows[i]["chargevalue2"] = "0.00";
                    }
                }
            }
        } // charges dr
        dr.Close();

        grvcharges.DataSource = dtcharges;
        grvcharges.DataBind();



        // ASL DOESN'T WANT N-FORM CHARGES i.e. SCHG04 FOR ROAD & EXPRESS
        if (hdnclient.Value.CompareTo("ASL") == 0)
        {
            foreach (GridViewRow grvchrg in grvcharges.Rows)
            {
                HiddenField hdnchargecode1 = (HiddenField)grvchrg.FindControl("hdnchargecode1");
                HiddenField hdnchargecode2 = (HiddenField)grvchrg.FindControl("hdnchargecode2");

                if (cmbtransmode.SelectedValue.CompareTo("2") == 0 || cmbtransmode.SelectedValue.CompareTo("4") == 0)
                {
                    if (hdnchargecode1.Value.CompareTo("SCHG04") == 0)
                    {
                        TextBox txt1 = (TextBox)grvchrg.FindControl("txtcharge1");
                        txt1.Text = "0.00";
                    }

                    if (hdnchargecode2.Value.CompareTo("SCHG04") == 0)
                    {
                        TextBox txt2 = (TextBox)grvchrg.FindControl("txtcharge2");
                        txt2.Text = "0.00";
                    }
                }
            }
        }


        // APPLYING SEPARATE CHARGES BECAUSE CALCULATED EXTERNALLY
        foreach (GridViewRow grvchrg in grvcharges.Rows)
        {
            HiddenField hdnchargecode1 = (HiddenField)grvchrg.FindControl("hdnchargecode1");
            HiddenField hdnchargecode2 = (HiddenField)grvchrg.FindControl("hdnchargecode2");
            TextBox txt1 = (TextBox)grvchrg.FindControl("txtcharge1");
            TextBox txt2 = (TextBox)grvchrg.FindControl("txtcharge2");

            if (hdnchargecode1.Value.CompareTo("SCHG19") == 0)
            {
                txt1.Text = applyODACharge().ToString("F2");
            }

            if (hdnchargecode2.Value.CompareTo("SCHG19") == 0)
            {
                txt2.Text = applyODACharge().ToString("F2");
            }

            // FUEL SURCHARGE
            if (hdnchargecode1.Value.CompareTo("SCHG20") == 0)
            {
                txt1.Text = applyFuelSurCharge();
                HiddenField hdnchargevalue1 = (HiddenField)grvchrg.FindControl("hdnchargevalue1");
                hdnchargevalue1.Value = txt1.Text;
            }

            if (hdnchargecode2.Value.CompareTo("SCHG20") == 0)
            {
                txt2.Text = applyFuelSurCharge();
                HiddenField hdnchargevalue2 = (HiddenField)grvchrg.FindControl("hdnchargevalue2");
                hdnchargevalue2.Value = txt2.Text;
            }


            // AGILITY HAS NEW CONTRACT CHANGES
            if (hdnclient.Value.CompareTo("AGILITY") == 0)
            {
                if (cmbpaybas.SelectedValue.CompareTo("P02") == 0)
                {
                    // MULTIPOINT PICKUP CHARGES
                    if (hdnchargecode1.Value.CompareTo("UCHG01") == 0)
                    {
                        txt1.Text = applyMultiPointPickUp();
                    }
                    if (hdnchargecode2.Value.CompareTo("UCHG01") == 0)
                    {
                        txt2.Text = applyMultiPointPickUp();
                    }
                    // MULTIPOINT DELIVERY CHARGES
                    if (hdnchargecode1.Value.CompareTo("UCHG03") == 0)
                    {
                        txt1.Text = applyMultiPointDelivery();
                    }
                    if (hdnchargecode2.Value.CompareTo("UCHG03") == 0)
                    {
                        txt2.Text = applyMultiPointDelivery();
                    }
                    // LOADING CHARGES
                    if (hdnchargecode1.Value.CompareTo("UCHG04") == 0)
                    {
                        txt1.Text = applyLoadingCharge();
                    }
                    if (hdnchargecode2.Value.CompareTo("UCHG04") == 0)
                    {
                        txt2.Text = applyLoadingCharge();
                    }
                    // UNLOADING CHARGES
                    if (hdnchargecode1.Value.CompareTo("UCHG02") == 0)
                    {
                        txt1.Text = applyUnLoadingCharge();
                    }
                    if (hdnchargecode2.Value.CompareTo("UCHG02") == 0)
                    {
                        txt2.Text = applyUnLoadingCharge();
                    }

                    // IF MULTI POINT PICKUP DOCKET THEN
                    if (chkmultipickup.Checked == true || chkmultidelivery.Checked == true)
                    {
                        txtfreightcharge.Text = "0.00";
                        txtfreightrate.Text = "0.00";
                        lblminfreightalert.Style["display"] = "none";

                        if (hdnchargecode1.Value.CompareTo("UCHG02") == 0)
                            txt1.Text = "0.00";

                        if (hdnchargecode2.Value.CompareTo("UCHG02") == 0)
                            txt2.Text = "0.00";

                        if (hdnchargecode1.Value.CompareTo("UCHG04") == 0)
                            txt1.Text = "0.00";

                        if (hdnchargecode2.Value.CompareTo("UCHG04") == 0)
                            txt2.Text = "0.00";
                    }
                } // if PAYBASE ENDS HERE
            } // if CLIENT==AGILITY ENDS HERE
        } // GRIDVIEW ROW ENDS HERE



        // SETTING EDD
        txtedd.Text = returnEDD(hdntrdays.Value);
        if (hdnclient.Value.CompareTo("RLL") == 0)
        {
            if (hdnrecordfind.Value.CompareTo("R") == 0 || hdnrecordfind.Value.CompareTo("N") == 0)
            {
                txtedd.Text = eddFromTransitMaster();
            }
        }



        string flag_freight, flag_rate, flag_ratetype;

        sqlstr = "SELECT enabled FROM webx_rules_docket WHERE paybas='" + cmbpaybas.SelectedValue + "' AND code='F_CHRG'";
        cmd = new SqlCommand(sqlstr, con);
        flag_freight = Convert.ToString(cmd.ExecuteScalar());

        sqlstr = "SELECT enabled FROM webx_rules_docket WHERE paybas='" + cmbpaybas.SelectedValue + "' AND code='F_RATE'";
        cmd = new SqlCommand(sqlstr, con);
        flag_rate = Convert.ToString(cmd.ExecuteScalar());

        sqlstr = "SELECT enabled FROM webx_rules_docket WHERE paybas='" + cmbpaybas.SelectedValue + "' AND code='RATETYPE'";
        cmd = new SqlCommand(sqlstr, con);
        flag_ratetype = Convert.ToString(cmd.ExecuteScalar());


        if (flag_freight.CompareTo("N") == 0)
            txtfreightcharge.Enabled = false;

        if (flag_rate.CompareTo("N") == 0)
            txtfreightrate.Enabled = false;

        if (flag_ratetype.CompareTo("N") == 0)
            cmbratetype.Enabled = false;




        if (cmbpaybas.SelectedValue.CompareTo("P01") == 0 || cmbpaybas.SelectedValue.CompareTo("P03") == 0 || cmbpaybas.SelectedValue.CompareTo("P04") == 0)
        {
            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtcharge1 = (TextBox)(grv.FindControl("txtcharge1"));
                TextBox txtcharge2 = (TextBox)(grv.FindControl("txtcharge2"));
                HiddenField hdnchargecode1 = (HiddenField)(grv.FindControl("hdnchargecode1"));
                HiddenField hdnchargecode2 = (HiddenField)(grv.FindControl("hdnchargecode2"));

                if (hdnclient.Value.CompareTo("RCPL") == 0)
                {
                    if (hdnchargecode1.Value.CompareTo("SCHG20") == 0)
                        txtcharge1.Enabled = false;

                    if (hdnchargecode2.Value.CompareTo("SCHG20") == 0)
                        txtcharge2.Enabled = false;
                }
            }
        }
        else
        {
            if (hdnclient.Value.CompareTo("RLL") == 0)
            {
                txtfreightcharge.Enabled = false;
                txtfreightrate.Enabled = false;
                foreach (GridViewRow grv in grvcharges.Rows)
                {
                    TextBox txtcharge1 = (TextBox)(grv.FindControl("txtcharge1"));
                    TextBox txtcharge2 = (TextBox)(grv.FindControl("txtcharge2"));

                    HiddenField hdnchargecode1 = (HiddenField)(grv.FindControl("hdnchargecode1"));
                    HiddenField hdnchargecode2 = (HiddenField)(grv.FindControl("hdnchargecode2"));
                    if (hdnchargecode1.Value.CompareTo("SCHG03") != 0)
                        txtcharge1.Enabled = false;
                    if (hdnchargecode2.Value.CompareTo("SCHG03") != 0)
                        txtcharge2.Enabled = false;
                }
            }
        }


        if (hdnclient.Value.CompareTo("TLL") == 0)
        {
            txtfovcharged.Enabled = true;
        }


        // SETTING SERVICE TAX PAID BY
        if (hdnfoundcontract.Value.CompareTo("C") == 0)
            sqlstr = "SELECT stax_paidby FROM webx_custcontract_hdr WHERE custcode='" + txtpartycode.Text + "'";
        else if (hdnfoundcontract.Value.CompareTo("D") == 0)
            sqlstr = "SELECT stax_paidby FROM webx_default_contract_charge WHERE contract_type='" + cmbpaybas.SelectedValue.ToUpper().Trim() + "' AND trans_type='" + cmbtransmode.SelectedValue.ToUpper().Trim() + "'";

        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            try
            {
                cmbstaxpaidby.SelectedValue = Convert.ToString(dr["stax_paidby"]);
            }
            catch (Exception ex) { }
        }
        dr.Close();



        /////////////////////////////////// MAKING DOCKET TOTAL /////////////////////////////////
        double subtotal = 0.00, dockettotal = 0.00;
        // ADDING FREIGHT, FOV, COD/DOD, DACC INTO SUBTOTAL
        subtotal = subtotal + returnDouble(txtfreightcharge.Text);

        // FOV charged
        subtotal = subtotal + returnDouble(txtfovcharged.Text);

        if (chkcoddod.Checked == true)
            subtotal = subtotal + returnDouble(txtcoddodcharged.Text);

        if (chkdacc.Checked == true)
            subtotal = subtotal + returnDouble(txtdacccharged.Text);


        // NOW ADDING STRAIGHT CHARGES TO SUBTOTAL

        foreach (GridViewRow grv in grvcharges.Rows)
        {
            TextBox txtcharge1 = (TextBox)grv.FindControl("txtcharge1");
            TextBox txtcharge2 = (TextBox)grv.FindControl("txtcharge2");
            HiddenField hdnchargecode1 = (HiddenField)grv.FindControl("hdnchargecode1");
            HiddenField hdnchargecode2 = (HiddenField)grv.FindControl("hdnchargecode2");

            if (hdnchargecode1.Value.ToUpper().CompareTo("UCHG06") != 0 && hdnchargecode1.Value.ToUpper().CompareTo("UCHG07") != 0 && hdnchargecode1.Value.ToUpper().CompareTo("UCHG08") != 0 && hdnchargecode1.Value.ToUpper().CompareTo("UCHG09") != 0 && hdnchargecode1.Value.ToUpper().CompareTo("UCHG10") != 0)
                subtotal = subtotal + returnDouble(txtcharge1.Text);
            else
                subtotal = subtotal - returnDouble(txtcharge1.Text);

            if (hdnchargecode2.Value.ToUpper().CompareTo("UCHG06") != 0 && hdnchargecode2.Value.ToUpper().CompareTo("UCHG07") != 0 && hdnchargecode2.Value.ToUpper().CompareTo("UCHG08") != 0 && hdnchargecode2.Value.ToUpper().CompareTo("UCHG09") != 0 && hdnchargecode2.Value.ToUpper().CompareTo("UCHG10") != 0)
                subtotal = subtotal + returnDouble(txtcharge2.Text);
            else
                subtotal = subtotal - returnDouble(txtcharge2.Text);
        }



        //Subtotal applited to textbox////////////////////////////////////////////////////////////////////
        if (hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("TLL") == 0 || hdnclient.Value.CompareTo("ASL") == 0)
            txtsubtotal.Text = returnDouble(Convert.ToString(subtotal)).ToString("F0");
        else
            txtsubtotal.Text = returnDouble(Convert.ToString(subtotal)).ToString("F2");


        //Getting Service Tax
        sqlstr = "SELECT TOP 1 servicetax,edu_cess_rate,hedu_cess_rate FROM webx_chargemst";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblservicetaxrate.Text = Convert.ToString(dr["servicetax"]);
            lbleducessrate.Text = Convert.ToString(dr["edu_cess_rate"]);
            lblheducessrate.Text = Convert.ToString(dr["hedu_cess_rate"]);
        }
        dr.Close();



        double servicetax = 0, educess = 0, heducess = 0;
        if (cmbtransmode.SelectedValue.CompareTo("2") == 0)
        {
            if (cmbservicetype.SelectedValue.CompareTo("1") == 0 && subtotal > 750)
            {
                servicetax = subtotal * 3 / 100;
                educess = servicetax * returnDouble(lbleducessrate.Text) / 100;
                heducess = servicetax * returnDouble(lblheducessrate.Text) / 100;
            }
            else if (cmbservicetype.SelectedValue.CompareTo("2") == 0 && subtotal > 1500)
            {
                servicetax = subtotal * 3 / 100;
                educess = servicetax * returnDouble(lbleducessrate.Text) / 100;
                heducess = servicetax * returnDouble(lblheducessrate.Text) / 100;
            }
            else
            {
                servicetax = 0.00;
                educess = 0.00;
                heducess = 0.00;
            }

        } // road trans mode for service tax ENDS HERE
        else
        {
            servicetax = subtotal * returnDouble(lblservicetaxrate.Text) / 100;
            educess = servicetax * returnDouble(lbleducessrate.Text) / 100;
            heducess = servicetax * returnDouble(lblheducessrate.Text) / 100;
        } // transmode for sevice tax ENDS HERE


        if (cmbstaxpaidby.SelectedValue.ToUpper().CompareTo("T") == 0 || cmbstaxpaidby.SelectedValue.ToUpper().CompareTo("TRANSPORTER") == 0)
        {
            if (hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("TLL") == 0 || hdnclient.Value.CompareTo("ASL") == 0)
            {
                txtservicetax.Text = returnDouble(Convert.ToString(servicetax)).ToString("F0");
                txteducess.Text = returnDouble(Convert.ToString(educess)).ToString("F0");
                txtheducess.Text = returnDouble(Convert.ToString(heducess)).ToString("F0");
            }
            else
            {
                txtservicetax.Text = returnDouble(Convert.ToString(servicetax)).ToString("F2");
                txteducess.Text = returnDouble(Convert.ToString(educess)).ToString("F2");
                txtheducess.Text = returnDouble(Convert.ToString(heducess)).ToString("F2");
            }
        }
        else
        {
            if (hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("TLL") == 0 || hdnclient.Value.CompareTo("ASL") == 0)
            {
                txtservicetax.Text = "0";
                txteducess.Text = "0";
                txtheducess.Text = "0";
            }
            else
            {
                txtservicetax.Text = "0.00";
                txteducess.Text = "0.00";
                txtheducess.Text = "0.00";
            }
        }


        if (hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("TLL") == 0 || hdnclient.Value.CompareTo("ASL") == 0)
        {
            txtservicetaxsub.Text = returnDouble(Convert.ToString(servicetax)).ToString("F0");
            txteducesssub.Text = returnDouble(Convert.ToString(educess)).ToString("F0");
            txtheducesssub.Text = returnDouble(Convert.ToString(heducess)).ToString("F0");
        }
        else
        {
            txtservicetaxsub.Text = returnDouble(Convert.ToString(servicetax)).ToString("F2");
            txteducesssub.Text = returnDouble(Convert.ToString(educess)).ToString("F2");
            txtheducesssub.Text = returnDouble(Convert.ToString(heducess)).ToString("F2");
        }



        // Generating and Applying Docket Total
        dockettotal = subtotal + returnDouble(txtservicetax.Text) + returnDouble(txteducess.Text) + returnDouble(txtheducess.Text);


        if (hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("TLL") == 0 || hdnclient.Value.CompareTo("ASL") == 0)
            txtdockettotal.Text = returnDouble(Convert.ToString(dockettotal)).ToString("F0");
        else
            txtdockettotal.Text = returnDouble(Convert.ToString(dockettotal)).ToString("F2");


        if (hdntotnopkgs.Value.CompareTo("") == 0 || returnDouble(hdntotnopkgs.Value) == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Critical Error. No of Packages are Zero&detail1=Programming Error&detail2=" + "&suggestion2=Docket Entry");
        }

        if (hdntotdeclval.Value.CompareTo("") == 0 || returnDouble(hdntotdeclval.Value) == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Critical Error. Total Declared value is Zero&detail1=Programming Error&detail2=" + "&suggestion2=Docket Entry");
        }

        if (txttotchargedweight.Text.CompareTo("") == 0 || returnDouble(txttotchargedweight.Text) == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Critical Error. Total Charged Weight is Zero&detail1=Programming Error&detail2=" + "&suggestion2=Docket Entry");
        }


        // FOR PAID DOCKET PAYMENT IS ALREADY DONE SO BILLED AT NOT MANDATORY
        if (cmbpaybas.SelectedValue.CompareTo("P01") == 0 || cmbpaybas.SelectedValue.CompareTo("P03") == 0 || cmbpaybas.SelectedValue.CompareTo("P04") == 0)
        {
            lblbilledat.Style["display"] = "none";
            txtbilledat.Style["display"] = "none";
        }







        cmbstaxpaidby.SelectedValue = "T";

        if (chkservicetaxexemp.Checked == true)
        {
            txtfovrate.Enabled = true;
            txtservicetax.Enabled = true;
            txteducess.Enabled = true;
            txtheducess.Enabled = true;
        }
        else
        {
            txtservicetax.Enabled = false;
            txteducess.Enabled = false;
            txtheducess.Enabled = false;
        }


        if (hdnclient.Value.CompareTo("RLL") == 0)
        {
            if (optpartycsgn.Checked == true)
                txtbilledat.Text = lblorgnloc.Text.Trim();
            else if (optpartycsge.Checked == true)
                txtbilledat.Text = txtdelloc.Text.Trim();

            if (cmbpaybas.SelectedValue.CompareTo("P01") == 0 || cmbpaybas.SelectedValue.CompareTo("P03") == 0)
                cmbratetype.Enabled = false;
            if (cmbpaybas.SelectedValue.CompareTo("P02") == 0)
            {
                txtbilledat.Enabled = false;
                txtfovrate.Enabled = false;
                txtfovcharged.Enabled = false;
                cmbstaxpaidby.Enabled = false;
            }
        }


        /// Focusing to Control
        if (cmbratetype.Enabled == true)
            cmbratetype.Focus();
        else if (cmbstaxpaidby.Enabled == true)
            cmbstaxpaidby.Focus();

    }

    // CHARGES GRID IS FILLED HERE
    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnchargecode1 = (HiddenField)e.Row.FindControl("hdnchargecode1");
            HiddenField hdnchargecode2 = (HiddenField)e.Row.FindControl("hdnchargecode2");
            Label lbloperand1 = (Label)e.Row.FindControl("lbloperand1");
            Label lbloperand2 = (Label)e.Row.FindControl("lbloperand2");
            if (hdnchargecode1.Value.CompareTo("UCHG06") == 0 || hdnchargecode1.Value.CompareTo("UCHG07") == 0 || hdnchargecode1.Value.CompareTo("UCHG08") == 0 || hdnchargecode1.Value.CompareTo("UCHG09") == 0 || hdnchargecode1.Value.CompareTo("UCHG10") == 0)
                lbloperand1.Text = "( - )";
            else
                lbloperand1.Text = "( + )";

            if (hdnchargecode2.Value.CompareTo("UCHG06") == 0 || hdnchargecode2.Value.CompareTo("UCHG07") == 0 || hdnchargecode2.Value.CompareTo("UCHG08") == 0 || hdnchargecode2.Value.CompareTo("UCHG09") == 0 || hdnchargecode2.Value.CompareTo("UCHG10") == 0)
                lbloperand2.Text = "( - )";
            else
                lbloperand2.Text = "( + )";

            if (hdnchargecode2.Value.CompareTo("") == 0)
            {
                TextBox txtcharge2 = (TextBox)e.Row.FindControl("txtcharge2");
                lbloperand2.Style["display"] = "none";
                txtcharge2.Style["display"] = "none";
            }
        }
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
        catch (Exception ex)
        {
            return 0.00;
        }
    }


    // CHECK FOR ODA
    protected void checkODA()
    {
        string sqlstr = "SELECT oda_yn FROM webx_citymaster WHERE location='" + txtto.Text.ToUpper() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (Convert.ToString(dr["oda_yn"]).ToUpper().CompareTo("Y") == 0)
                chkoda.Checked = true;
            else
                chkoda.Checked = false;
        }
        dr.Close();
    }





    protected double applyODACharge()
    {
        double odacharge = 0.00;

        if (chkoda.Checked == false)
            return 0.00;


        double odakm = 0.00, minodacharge = 0.00;
        int odadays = 0;

        string sqlstr = "", slabcode = "", esscode = "";
        SqlCommand cmd;
        SqlDataReader dr;

        sqlstr = "SELECT location,odakm FROM webx_citymaster WHERE location='" + txtto.Text.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            odakm = returnDouble(Convert.ToString(dr["odakm"]));
        }
        dr.Close();


        // THIS WILL FIND APPROPRIATE SLAB CODE FROM CONTRACT
        if (hdnfoundcontract.Value.CompareTo("C") == 0)
        {
            sqlstr = "SELECT slab_code,matrix_type FROM webx_custcontract_odamatrix_slabhdr WHERE contractid='" + hdncontractid.Value + "' AND CONVERT(NUMERIC,(CASE WHEN matrix_type='W' THEN '" + txttotchargedweight.Text.Trim() + "' ELSE '" + hdntotnopkgs.Value.Trim() + "' END),106) BETWEEN slab_from AND slab_to";
        }
        else if (hdnfoundcontract.Value.CompareTo("D") == 0)
        {
            sqlstr = sqlstr = "SELECT slab_code,matrix_type FROM webx_default_contract_odamatrix_slabhdr WHERE contract_type='" + cmbpaybas.SelectedValue.Trim() + "' AND CONVERT(NUMERIC,(CASE WHEN matrix_type='W' THEN '" + txttotchargedweight.Text.Trim() + "' ELSE '" + hdntotnopkgs.Value.Trim() + "' END),106) BETWEEN slab_from AND slab_to";
        }
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            slabcode = Convert.ToString(dr["slab_code"]);
        }
        dr.Close();


        // UPON SLABCODE FINDING ESSCODE
        if (slabcode.CompareTo("") != 0)
        {
            if (hdnfoundcontract.Value.CompareTo("C") == 0)
            {
                sqlstr = "SELECT ess_code,min_odachrg FROM webx_custcontract_odamatrix_disthdr WHERE contractid='" + hdncontractid.Value + "' AND " + odakm.ToString() + " BETWEEN ess_from AND ess_to";
            }
            else if (hdnfoundcontract.Value.CompareTo("D") == 0)
            {
                sqlstr = sqlstr = "SELECT ess_code,min_odachrg FROM webx_default_contract_odamatrix_disthdr WHERE contract_type='" + cmbpaybas.SelectedValue.Trim() + "' AND " + odakm.ToString() + " BETWEEN ess_from AND ess_to";
            }
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                esscode = Convert.ToString(dr["ess_code"]);
                minodacharge = returnDouble(Convert.ToString(dr["min_odachrg"]));
            }
            dr.Close();



            // Actual Finding of ODA charge
            if (hdnfoundcontract.Value.CompareTo("C") == 0)
            {
                sqlstr = "SELECT " + slabcode + " as odacharge,trdays FROM webx_custcontract_odamatrix_charge WHERE  contractid='" + hdncontractid.Value + "' AND  ess_code='" + esscode + "'";
            }
            else if (hdnfoundcontract.Value.CompareTo("D") == 0)
            {
                sqlstr = "SELECT " + slabcode + " as odacharge,trdays FROM webx_default_contract_odamatrix_charge WHERE contract_type='" + cmbpaybas.SelectedValue.Trim() + "' and ess_code='" + esscode + "'";
            }
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                odacharge = returnDouble(Convert.ToString(dr["odacharge"]));
                odadays = Convert.ToInt16(returnDouble(Convert.ToString(dr["trdays"])));
            }
            dr.Close();



            // Adding ODA days into Total trdays
            if (odadays > 0)
            {
                hdntrdays.Value = Convert.ToString(returnDouble(hdntrdays.Value) + odadays);
            }


            // Checking for Minimum ODA Charge
            if (minodacharge > odacharge)
                return minodacharge;
            else
                return odacharge;

        }
        else
        {
            odacharge = 0.00;
            return odacharge;
        }

    }



    protected string returnEDD(string trdays)
    {

        string[] arrdate = new string[3];
        arrdate = txtdockdate.Text.Split('/');

        DateTime dt = Convert.ToDateTime(arrdate[1] + "/" + arrdate[0] + "/" + arrdate[2]);
        for (int i = 0; i < returnDouble(trdays); i++)
        {
            if (dt.DayOfWeek.ToString().ToUpper().CompareTo("SUNDAY") == 0)
                dt = dt + TimeSpan.FromDays(1);
            dt = dt + TimeSpan.FromDays(1);
        }

        if (dt.DayOfWeek.ToString().ToUpper().CompareTo("SUNDAY") == 0)
            dt = dt + TimeSpan.FromDays(1);

        DateTime edd = dt;



        return edd.ToString("dd/MM/yyyy");
    }


    protected void disableStep1()
    {
        txtdockno.Enabled = false;
        txtdockdate.Enabled = false;
        cmbpaybas.Enabled = false;
        txtpartycode.Enabled = false;
        txtdelloc.Enabled = false;

        btndelpopup.Disabled = true;
        btnpartypopup.Disabled = true;

        trtransmode.Style["display"] = "marker";
        trpickupdel.Style["display"] = "marker";
        trpacktype.Style["display"] = "marker";
        trvolumetric.Style["display"] = "marker";
        trlocal.Style["display"] = "marker";
        trdacc.Style["display"] = "marker";
        trbtnstep2.Style["display"] = "marker";
        trbtnstep1.Style["display"] = "none";

        // SETTING CONSIGNOR/CONSIGNEE
        divpartycsgne.Style["display"] = "none";
        if (optpartycsgn.Checked == true)
        {
            txtcsgncd.Text = txtpartycode.Text;
            txtcsgnnm.Text = txtpartyname.Text;
        }
        else
        {
            txtcsgecd.Text = txtpartycode.Text;
            txtcsgenm.Text = txtpartyname.Text;
        }


        // LOCAL DOCKET SETTINGS 
        if (lblorgnloc.Text.ToUpper().CompareTo(txtdelloc.Text.ToUpper()) != 0)
        {
            chklocal.Enabled = false;
            chklocal.Checked = false;
        }
    }

    protected void disableStep2()
    {
        cmbtransmode.Enabled = false;
        cmbservicetype.Enabled = false;
        cmbftltype.Enabled = false;
        cmbpickupdel.Enabled = false;
        txtfrom.Enabled = false;
        txtto.Enabled = false;
        cmbpacktype.Enabled = false;
        cmbprodtype.Enabled = false;
        txtsplinstruct.Enabled = false;
        chkvolumetric.Enabled = false;
        chkcoddod.Enabled = false;
        chkdacc.Enabled = false;
        chklocal.Enabled = false;
        chkpermit.Enabled = false;
        cmbloadtype.Enabled = false;
        txtdopino.Enabled = false;
        cmbbusinesstype.Enabled = false;
        chkdacc.Enabled = false;
        chkmultipickup.Enabled = false;
        chkmultidelivery.Enabled = false;
        txtsourcedockno.Enabled = false;

        btnfrompopup.Disabled = true;
        btntopopup.Disabled = true;

        trbtnstep2.Style["display"] = "none";
        imgsourcedock.Style["display"] = "none";
        divstep4.Style["display"] = "marker";
        divpayment.Style["display"] = "marker";
        trbtnstep3.Style["display"] = "none";

        if (chkpermit.Checked == true)
            tblpermit.Style["display"] = "marker";
        else
            tblpermit.Style["display"] = "none";

        if (chkmultipickup.Checked == true)
        {
            txtsourcedockno.Style["display"] = "block";
            trmultipoint.Style["display"] = "block";
            lblsourcedockname.Style["display"] = "block";
        }

        divstep3.Style["display"] = "marker";
    }

    protected void disableStep3()
    {
        txtcsgncd.Enabled = false;
        txtcsgnaddress.Enabled = false;
        txtcsgncity.Enabled = false;
        txtcsgnemail.Enabled = false;
        txtcsgnname.Enabled = false;
        txtcsgnnm.Enabled = false;
        txtcsgnphone.Enabled = false;
        txtcsgnpin.Enabled = false;

        txtcsgecd.Enabled = false;
        txtcsgeaddress.Enabled = false;
        txtcsgecity.Enabled = false;
        txtcsgeemail.Enabled = false;
        txtcsgename.Enabled = false;
        txtcsgenm.Enabled = false;
        txtcsgephone.Enabled = false;
        txtcsgepin.Enabled = false;

        optcarrierrisk.Enabled = false;
        optownerrisk.Enabled = false;
        txtpolicydate.Enabled = false;
        txtpolicyno.Enabled = false;
        txtprivatemark.Enabled = false;
        txtinternalcovers.Enabled = false;
        txtmodvatcovers.Enabled = false;
        txtcustrefno.Enabled = false;
        txttpnumber.Enabled = false;

        btncsgnpopup.Disabled = true;
        btncsgepopup.Disabled = true;


        foreach (GridViewRow grv in grvdoc.Rows)
        {
            TextBox txt = (TextBox)grv.FindControl("txtdocumentno");
            txt.Enabled = false;
        }

        lblpermitdate.Enabled = false;
        lblpermitvaliditydate.Enabled = false;
        lblpermitrecieveddate.Enabled = false;

        txtpermitdate.Enabled = false;
        txtpermitrecvddate.Enabled = false;
        txtpermitvaldate.Enabled = false;
    }

    protected void disableStep4()
    {

        //Blocking Invoice Details
        txtcubicrate.Enabled = false;
        txtinvoicerows.Enabled = false;
        btnaddrows.Enabled = false;


        foreach (GridViewRow grv in grvinvoice.Rows)
        {
            TextBox txtinvoiceno = (TextBox)grv.FindControl("txtinvoiceno");
            TextBox txtinvoicedate = (TextBox)grv.FindControl("txtinvoicedate");
            LinkButton lnkinvoicedate = (LinkButton)grv.FindControl("lnkinvoicedate");
            TextBox txtlength = (TextBox)grv.FindControl("txtlength");
            TextBox txtbreadth = (TextBox)grv.FindControl("txtbreadth");
            TextBox txtheight = (TextBox)grv.FindControl("txtheight");
            TextBox txtdeclval = (TextBox)grv.FindControl("txtdeclval");
            TextBox txtnopkgs = (TextBox)grv.FindControl("txtnopkgs");
            TextBox txtactualweight = (TextBox)grv.FindControl("txtactualweight");

            txtinvoiceno.Enabled = false;
            txtinvoicedate.Enabled = false;
            lnkinvoicedate.Enabled = false;
            txtlength.Enabled = false;
            txtbreadth.Enabled = false;
            txtheight.Enabled = false;
            txtdeclval.Enabled = false;
            txtnopkgs.Enabled = false;
            txtactualweight.Enabled = false;

        }

        txttotchargedweight.Enabled = false;

    }

    // EDD CALCULATION FUNCTION RETURN TYPE : string (EXPECTED DATE OF DELIVERY)
    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        btnsubmit.Style["display"] = "none";
        if (cmbpaybas.SelectedValue.ToUpper().CompareTo("P04") != 0)
        {
            if (chkmultipickup.Checked == false && chkmultidelivery.Checked == false)
            {
                if (txtfreightcharge.Text.CompareTo("") == 0 || returnDouble(txtfreightcharge.Text) < 1)
                {
                    Response.Redirect("ErrorPage.aspx?heading=Critical Error. Freight Charge is Zero&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                }

                if (txtfreightcharge.Text.CompareTo("") == 0 || returnDouble(txtfreightcharge.Text) < 1)
                {
                    Response.Redirect("ErrorPage.aspx?heading=Critical Error. Freight Charge is Zero&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                }
            }

            if (txtsubtotal.Text.CompareTo("") == 0 || returnDouble(txtsubtotal.Text) < 1)
            {
                Response.Redirect("ErrorPage.aspx?heading=Critical Error. " + dkt_call + " Subtotal is Zero&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
            }

            if (txtdockettotal.Text.CompareTo("") == 0 || returnDouble(txtdockettotal.Text) < 1)
            {
                Response.Redirect("ErrorPage.aspx?heading=Critical Error. " + dkt_call + " Total is Zero&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
            }
        }





        if (hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("TLL") == 0 || hdnclient.Value.CompareTo("ASL") == 0)
        {
            if (Math.Round(returnDouble(txtsubtotal.Text)) > returnDouble(txtdockettotal.Text))
            {
                Response.Redirect("ErrorPage.aspx?heading=InValid User Entry. Subtoal is Detacted Greater than Docket Total.&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                return;
            }


            if (Math.Round(returnDouble(txtfreightcharge.Text)) > returnDouble(txtsubtotal.Text))
            {
                Response.Redirect("ErrorPage.aspx?heading=InValid User Entry. Freight is Detacted Greater than SubTotal.&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                return;
            }

            if (Math.Round(returnDouble(txtfreightcharge.Text)) > returnDouble(txtdockettotal.Text))
            {
                Response.Redirect("ErrorPage.aspx?heading=InValid User Entry. Freight is Detacted Greater than Docket Total.&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                return;
            }
        }
        else
        {

            if (returnDouble(txtsubtotal.Text) > returnDouble(txtdockettotal.Text))
            {
                Response.Redirect("ErrorPage.aspx?heading=InValid User Entry. Subtoal is Detacted Greater than Docket Total.&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                return;
            }


            if (returnDouble(txtfreightcharge.Text) > returnDouble(txtsubtotal.Text))
            {
                Response.Redirect("ErrorPage.aspx?heading=InValid User Entry. Freight is Detacted Greater than SubTotal.&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                return;
            }

            if (returnDouble(txtfreightcharge.Text) > returnDouble(txtdockettotal.Text))
            {
                Response.Redirect("ErrorPage.aspx?heading=InValid User Entry. Freight is Detacted Greater than Docket Total.&detail1=Internal Error&detail2=" + "&suggestion2=Docket Entry");
                return;
            }
        }








        /// BA ENTRY FOR RCPL
        string bacode = "", strmrno = "", sqlstr = "";
        SqlCommand cmd;
        int cnt = 0;
        sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + txtbilledat.Text + "' AND activeflag='Y'";
        cmd = new SqlCommand(sqlstr, con);
        cnt = Convert.ToInt16(cmd.ExecuteScalar());
        if (cnt == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Billing Location Not From Location Master &detail1=Wrong  Billing Location. Kindly select other Billing Location" + "&suggestion2=Docket Entry");
            return;
        }
        SqlTransaction trn = con.BeginTransaction();






        ///// STARTING INSERT INTO DATABASE
        // MAIN SP IS TO STORE

        try
        {
            sqlstr = "usp_docket_entry";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@dockno", txtdockno.Text.Trim());
            cmd.Parameters.AddWithValue("@dockdate", fn.Mydate1(txtdockdate.Text.Trim()));
            cmd.Parameters.AddWithValue("@paybas", cmbpaybas.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@partycode", txtpartycode.Text.Trim());
            cmd.Parameters.AddWithValue("@orgnloc", lblorgnloc.Text.Trim());
            cmd.Parameters.AddWithValue("@delloc", txtdelloc.Text.Trim());
            cmd.Parameters.AddWithValue("@transmode", cmbtransmode.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@servicetype", cmbservicetype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@ftltype", cmbftltype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@pickupdelivery", cmbpickupdel.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@fromcity", txtfrom.Text.Trim());
            cmd.Parameters.AddWithValue("@tocity", txtto.Text.Trim());
            cmd.Parameters.AddWithValue("@packagingtype", cmbpacktype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@producttype", cmbprodtype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@specialinstruct", txtsplinstruct.Text.Trim());  // 15 

            if (chkvolumetric.Checked == true)
                cmd.Parameters.AddWithValue("@flag_volumetric", "Y");
            else
                cmd.Parameters.AddWithValue("@flag_volumetric", "N");

            if (chkcoddod.Checked == true)
                cmd.Parameters.AddWithValue("@flag_coddod", "Y");
            else
                cmd.Parameters.AddWithValue("@flag_coddod", "N");

            if (chkoda.Checked == true)
                cmd.Parameters.AddWithValue("@flag_oda", "Y");
            else
                cmd.Parameters.AddWithValue("@flag_oda", "N");

            if (chklocal.Checked == true)
                cmd.Parameters.AddWithValue("@flag_local", "Y");
            else
                cmd.Parameters.AddWithValue("@flag_local", "N");

            if (chkdacc.Checked == true)
                cmd.Parameters.AddWithValue("@flag_dacc", 'Y');
            else
                cmd.Parameters.AddWithValue("@flag_dacc", 'N');

            if (chkpermit.Checked == true)
                cmd.Parameters.AddWithValue("@flag_permit", "Y");
            else
                cmd.Parameters.AddWithValue("@flag_permit", "N");

            cmd.Parameters.AddWithValue("@loadtype", cmbloadtype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@dopino", txtdopino.Text.Trim());
            cmd.Parameters.AddWithValue("@businesstype", cmbbusinesstype.SelectedValue.Trim());

            if (txtcsgncd.Text.CompareTo("") == 0)
                cmd.Parameters.AddWithValue("@csgncd", "8888");
            else
                cmd.Parameters.AddWithValue("@csgncd", txtcsgncd.Text.Trim());

            cmd.Parameters.AddWithValue("@csgnname", txtcsgnname.Text.Trim()); // 25
            cmd.Parameters.AddWithValue("@csgnaddr", txtcsgnaddress.Text.Trim());
            cmd.Parameters.AddWithValue("@csgncity", txtcsgncity.Text.Trim());
            cmd.Parameters.AddWithValue("@csgnpincode", txtcsgnpin.Text.Trim());
            cmd.Parameters.AddWithValue("@csgntelephone", txtcsgnphone.Text.Trim());
            cmd.Parameters.AddWithValue("@csgnemail", txtcsgnemail.Text.Trim());

            if (txtcsgecd.Text.CompareTo("") == 0)
                cmd.Parameters.AddWithValue("@csgecd", "8888");
            else
                cmd.Parameters.AddWithValue("@csgecd", txtcsgecd.Text.Trim());

            cmd.Parameters.AddWithValue("@csgename", txtcsgename.Text.Trim());
            cmd.Parameters.AddWithValue("@csgeaddr", txtcsgeaddress.Text.Trim());
            cmd.Parameters.AddWithValue("@csgecity", txtcsgecity.Text.Trim());
            cmd.Parameters.AddWithValue("@csgepincode", txtcsgepin.Text.Trim());
            cmd.Parameters.AddWithValue("@csgetelephone", txtcsgephone.Text.Trim());
            cmd.Parameters.AddWithValue("@csgeemail", txtcsgeemail.Text.Trim()); //37
            cmd.Parameters.AddWithValue("@entrysheetno", txtentrysheetno.Text.Trim());
            cmd.Parameters.AddWithValue("@obdno", txtobdno.Text.Trim());
            cmd.Parameters.AddWithValue("@permitno", txtpermitno.Text.Trim());
            cmd.Parameters.AddWithValue("@permitdate", fn.Mydate1(txtpermitdate.Text.Trim()));
            cmd.Parameters.AddWithValue("@permitvaliditydate", fn.Mydate1(txtpermitdate.Text.Trim()));
            cmd.Parameters.AddWithValue("@permitrecvddate", fn.Mydate1(txtpermitdate.Text.Trim()));
            cmd.Parameters.AddWithValue("@permitrecvdat", cmbpermitrecvdat.SelectedValue.Trim());


            /// IT IS TO LIMIT THE SCOPE OF INVOICE VARIABLES
            {
                TextBox txtinvoiceno = (TextBox)(grvinvoice.Rows[0].FindControl("txtinvoiceno"));
                TextBox txtinvoicedate = (TextBox)(grvinvoice.Rows[0].FindControl("txtinvoicedate"));

                cmd.Parameters.AddWithValue("@invno", txtinvoiceno.Text.Trim());
                cmd.Parameters.AddWithValue("@invdt", fn.Mydate1(txtinvoicedate.Text.Trim()));
                try
                {
                    cmd.Parameters.AddWithValue("@invamt", Convert.ToDecimal(hdntotdeclval.Value.Trim()));
                }
                catch (Exception ex)
                {
                    cmd.Parameters.AddWithValue("@invamt", "0");
                    trn.Rollback();
                    string exmess = ex.Message.ToString().Replace('\n', '_');
                    Response.Redirect("ErrorPage.aspx?heading=DataBase Entry Failed.&detail1=InValid Declared Value Entered by User&detail2=" + exmess + "&suggestion2=Docket Entry");
                    return;
                }
            }

            cmd.Parameters.AddWithValue("@bacode", bacode);

            if (optcarrierrisk.Checked == true)
                cmd.Parameters.AddWithValue("@risktype", "O");
            else if (optownerrisk.Checked == true)
                cmd.Parameters.AddWithValue("@risktype", "C");

            cmd.Parameters.AddWithValue("@policyno", txtpolicyno.Text.Trim());
            cmd.Parameters.AddWithValue("@policydate", fn.Mydate1(txtpolicydate.Text.Trim()));
            cmd.Parameters.AddWithValue("@internalcovers", returnDouble(txtinternalcovers.Text.Trim()));
            cmd.Parameters.AddWithValue("@modvatcovers", returnDouble(txtmodvatcovers.Text.Trim()));
            cmd.Parameters.AddWithValue("@custrefno", txtcustrefno.Text.Trim()); //50
            cmd.Parameters.AddWithValue("@privatemark", txtprivatemark.Text.Trim());
            cmd.Parameters.AddWithValue("@tpnumber", txttpnumber.Text.Trim());
            cmd.Parameters.AddWithValue("@noofpkgs", returnDouble(hdntotnopkgs.Value.Trim()));
            cmd.Parameters.AddWithValue("@actualweight", returnDouble(hdntotactualweight.Value.Trim()));
            cmd.Parameters.AddWithValue("@chargedweight", returnDouble(txttotchargedweight.Text.Trim()));

            if (chkcoddod.Checked == true)
            {
                cmd.Parameters.AddWithValue("@coddodcharged", returnDouble(txtcoddodcharged.Text.Trim()));
                cmd.Parameters.AddWithValue("@coddodamt", returnDouble(txtcoddodcollected.Text.Trim()));
            }
            else
            {
                cmd.Parameters.AddWithValue("@coddodcharged", 0);
                cmd.Parameters.AddWithValue("@coddodamt", 0);
            }

            cmd.Parameters.AddWithValue("@edd", fn.Mydate1(txtedd.Text.Trim()));
            cmd.Parameters.AddWithValue("@staxpaidby", cmbstaxpaidby.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@staxregno", txtstaxregno.Text.Trim());
            cmd.Parameters.AddWithValue("@billedat", txtbilledat.Text.Trim());
            try
            {
                cmd.Parameters.AddWithValue("@entryby", hdnemployee.Value);
            }
            catch (Exception ex)
            {
                string exmess = ex.Message.ToString().Replace('\n', '_');
                Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session TimeOut Occured&detail2=" + exmess + "&suggestion2=Docket Entry");
            }
            cmd.Parameters.AddWithValue("@entrydate", fn.Mydate1(hdnserverdate.Value.Trim()));
            cmd.ExecuteNonQuery();

            sqlstr = "SELECT TOP 1 assignto AS bacode FROM vw_dcr_series_new WHERE assignto NOT IN (SELECT loccode FROM webx_location) AND ( assignto IN (SELECT userid FROM webx_master_users ) OR assignto IN (SELECT vendorcode FROM webx_vendor_hdr WHERE vendor_type='08' )) AND '" + txtdockno.Text + "' BETWEEN series_from AND series_to AND LEN(RTRIM(LTRIM('" + txtdockno.Text + "'))) = LEN(series_from)";
            cmd = new SqlCommand(sqlstr, con, trn);
            bacode = Convert.ToString(cmd.ExecuteScalar());


            sqlstr = "UPDATE webx_master_docket SET bacode='" + bacode + "' WHERE dockno='" + txtdockno.Text + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            cmd = new SqlCommand("usp_ba_calculation_entry", con, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@dockno", txtdockno.Text.Trim());
            cmd.Parameters.AddWithValue("@dockdate", fn.Mydate1(txtdockdate.Text));
            cmd.Parameters.AddWithValue("@paybas", cmbpaybas.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@orgnloc", lblorgnloc.Text.Trim());
            cmd.Parameters.AddWithValue("@delloc", txtdelloc.Text.Trim());

            cmd.Parameters.AddWithValue("@transmode", cmbtransmode.SelectedValue.Trim());
            if (txtcsgncd.Text.CompareTo("") == 0)
            {
                cmd.Parameters.AddWithValue("@csgncd", "8888");
                cmd.Parameters.AddWithValue("@csgnname", txtcsgnname.Text.Trim());
            }
            else
            {
                cmd.Parameters.AddWithValue("@csgncd", txtcsgncd.Text.Trim());
                cmd.Parameters.AddWithValue("@csgnname", txtcsgnnm.Text.Trim());
            }

            if (txtcsgecd.Text.CompareTo("") == 0)
            {
                cmd.Parameters.AddWithValue("@csgecd", "8888");
                cmd.Parameters.AddWithValue("@csgename", txtcsgename.Text.Trim());
            }
            else
            {
                cmd.Parameters.AddWithValue("@csgecd", txtcsgecd.Text.Trim());
                cmd.Parameters.AddWithValue("@csgename", txtcsgenm.Text.Trim());
            }

            cmd.Parameters.AddWithValue("@bacode", bacode.Trim());
            cmd.Parameters.AddWithValue("@noofpkgs", hdntotnopkgs.Value.Trim());
            cmd.Parameters.AddWithValue("@actualweight", hdntotactualweight.Value.Trim());
            cmd.Parameters.AddWithValue("@chargedweight", txttotchargedweight.Text.Trim());
            cmd.Parameters.AddWithValue("@servicetype", cmbservicetype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@freight", txtfreightcharge.Text.Trim());
            cmd.Parameters.AddWithValue("@subtotal", txtsubtotal.Text.Trim());
            cmd.Parameters.AddWithValue("@svctax", txtservicetax.Text.Trim());
            cmd.Parameters.AddWithValue("@educess", txteducess.Text.Trim());
            cmd.Parameters.AddWithValue("@heducess", txtheducess.Text.Trim());
            cmd.Parameters.AddWithValue("@dockettotal", txtdockettotal.Text.Trim());
            cmd.Parameters.AddWithValue("@mrno", strmrno.Trim());
            cmd.Parameters.AddWithValue("@entryby", Session["empcd"].ToString());
            cmd.Parameters.AddWithValue("@entrydate", fn.Mydate1(DateTime.Now.ToString("dd/MM/yyyy")));
            cmd.ExecuteNonQuery();

            if (hdnclient.Value.CompareTo("AGILITY") == 0)
            {
                sqlstr = "UPDATE  webx_master_docket SET sourcedockno='" + txtsourcedockno.Text.Trim() + "',";
                sqlstr = sqlstr + "multipickup_yn='" + (chkmultipickup.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "multidelivery_yn='" + (chkmultidelivery.Checked == true ? "Y" : "N") + "'";
                sqlstr = sqlstr + " WHERE dockno='" + txtdockno.Text.Trim() + "'";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }




            // INSERTING DOCUMENT DETAILS
            foreach (GridViewRow grv in grvdoc.Rows)
            {
                HiddenField doc_srno = (HiddenField)grv.FindControl("Doc_srno");
                TextBox txtdocumentno = (TextBox)grv.FindControl("txtdocumentno");

                cmd = new SqlCommand("usp_docket_state_document_entry", con, trn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@dockno", txtdockno.Text.Trim());
                cmd.Parameters.AddWithValue("@docksf", ".");

                cmd.Parameters.AddWithValue("@srno", Convert.ToInt16(doc_srno.Value));
                cmd.Parameters.AddWithValue("@documentno", txtdocumentno.Text.Trim());

                cmd.ExecuteNonQuery();
            }



            // INSERTING INVOICE DETAILS
            foreach (GridViewRow grv in grvinvoice.Rows)
            {

                TextBox txtinvoiceno = (TextBox)grv.FindControl("txtinvoiceno");
                TextBox txtinvoicedate = (TextBox)grv.FindControl("txtinvoicedate");
                TextBox txtdeclval = (TextBox)grv.FindControl("txtdeclval");
                TextBox txtnopkgs = (TextBox)grv.FindControl("txtnopkgs");
                TextBox txtactualweight = (TextBox)grv.FindControl("txtactualweight");
                TextBox txtlength = (TextBox)grv.FindControl("txtlength");
                TextBox txtbreadth = (TextBox)grv.FindControl("txtbreadth");
                TextBox txtheight = (TextBox)grv.FindControl("txtheight");
                TextBox txtcftval = (TextBox)grv.FindControl("txtcft");
                if (txtinvoiceno.Text.ToString() != "")
                {
                    cmd = new SqlCommand("usp_docket_Invoie_entry", con, trn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@dockno", txtdockno.Text.Trim());
                    cmd.Parameters.AddWithValue("@invno", txtinvoiceno.Text.ToString());
                    cmd.Parameters.AddWithValue("@invdt", fn.Mydate1(txtinvoicedate.Text.ToString()));
                    try
                    {
                        cmd.Parameters.AddWithValue("@declval", Convert.ToDecimal(hdntotdeclval.Value.Trim()));
                    }
                    catch (Exception ex)
                    {
                        cmd.Parameters.AddWithValue("@declval", "0");
                        trn.Rollback();
                        string exmess = ex.Message.ToString().Replace('\n', '_');
                        Response.Redirect("ErrorPage.aspx?heading=DataBase Entry Failed.&detail1=InValid Declared Value Entered by User&detail2=" + exmess + "&suggestion2=Docket Entry");
                        return;
                    }
                    cmd.Parameters.AddWithValue("@pkgsno", returnDouble(txtnopkgs.Text));
                    cmd.Parameters.AddWithValue("@actuwt", txtactualweight.Text.ToString());
                    cmd.Parameters.AddWithValue("@vol_l", txtlength.Text.ToString());
                    cmd.Parameters.AddWithValue("@vol_b", txtbreadth.Text.ToString());
                    cmd.Parameters.AddWithValue("@vol_h", txtheight.Text.ToString());
                    cmd.Parameters.AddWithValue("@tot_cft", txtcftval.Text.ToString());
                    cmd.ExecuteNonQuery();
                }

            }



            // INSERTING CHARGES

            if (txtcoddodcharged.Text.CompareTo("") == 0)
                txtcoddodcharged.Text = "0.00";
            if (txtdacccharged.Text.CompareTo("") == 0)
                txtdacccharged.Text = "0.00";
            if (txtfovcharged.Text.CompareTo("") == 0)
                txtfovcharged.Text = "0.00";

            cmd = new SqlCommand("usp_docket_charges_entry", con, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@dockno", txtdockno.Text.Trim());
            cmd.Parameters.AddWithValue("@rate_type", cmbratetype.SelectedValue.Trim());
            cmd.Parameters.AddWithValue("@frt_rate", returnDouble(txtfreightrate.Text.Trim()));
            cmd.Parameters.AddWithValue("@freight_calc", returnDouble(txtfreightcharge.Text.Trim()));
            cmd.Parameters.AddWithValue("@freight", returnDouble(txtfreightcharge.Text.Trim()));
            cmd.Parameters.AddWithValue("@fov", returnDouble(txtfovcharged.Text.Trim()));

            string[,] arrcharges = new string[33, 2];
            // Filling Simple Charges
            int chargesuffix = 0;
            for (int i = 0; i < 33; i++)
            {
                chargesuffix = i + 1;
                if (chargesuffix < 10)
                    arrcharges[i, 0] = "SCHG0" + chargesuffix;
                else
                    arrcharges[i, 0] = "SCHG" + chargesuffix;

                arrcharges[i, 1] = "0.00";
            }
            // Filling User Charges
            for (int i = 0; i < 10; i++)
            {
                chargesuffix = i + 1;
                arrcharges[i + 23, 0] = "UCHG0" + chargesuffix;
                arrcharges[i + 23, 1] = "0.00";
            }
            //10th User charge
            arrcharges[32, 0] = "UCHG10";
            arrcharges[32, 1] = "0.00";




            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtcharge1 = (TextBox)grv.FindControl("txtcharge1");
                TextBox txtcharge2 = (TextBox)grv.FindControl("txtcharge2");
                HiddenField hdnchargecode1 = (HiddenField)grv.FindControl("hdnchargecode1");
                HiddenField hdnchargecode2 = (HiddenField)grv.FindControl("hdnchargecode2");

                for (int i = 0; i < 33; i++)
                {
                    if (arrcharges[i, 0].CompareTo(hdnchargecode1.Value) == 0)
                    {
                        arrcharges[i, 1] = txtcharge1.Text.Trim();
                    }
                    if (arrcharges[i, 0].CompareTo(hdnchargecode2.Value) == 0)
                    {
                        arrcharges[i, 1] = txtcharge2.Text.Trim();
                    }
                }
            }
            string strchargeparam = "";
            for (int i = 0; i < 33; i++)
            {
                strchargeparam = "@" + arrcharges[i, 0];

                if (strchargeparam.CompareTo("@SCHG11") == 0)
                {
                    cmd.Parameters.AddWithValue(strchargeparam, returnDouble(txtfovcharged.Text));
                }
                else if (strchargeparam.CompareTo("@SCHG12") == 0)
                {
                    if (chkcoddod.Checked == true)
                        cmd.Parameters.AddWithValue(strchargeparam, returnDouble(txtcoddodcharged.Text));
                    else
                        cmd.Parameters.AddWithValue(strchargeparam, returnDouble(arrcharges[i, 1]));
                }
                else if (strchargeparam.CompareTo("@SCHG13") == 0)
                {
                    if (chkdacc.Checked == true)
                        cmd.Parameters.AddWithValue(strchargeparam, returnDouble(txtdacccharged.Text));
                    else
                        cmd.Parameters.AddWithValue(strchargeparam, returnDouble(arrcharges[i, 1]));
                }
                else
                {
                    cmd.Parameters.AddWithValue(strchargeparam, returnDouble(arrcharges[i, 1]));
                }
            }

            cmd.Parameters.AddWithValue("@subtotal", returnDouble(txtsubtotal.Text.ToString()));
            cmd.Parameters.AddWithValue("@svctax", returnDouble(txtservicetax.Text.Trim()));
            cmd.Parameters.AddWithValue("@cess", returnDouble(txteducess.Text.Trim()));
            cmd.Parameters.AddWithValue("@h_cess", returnDouble(txtheducess.Text.Trim()));
            cmd.Parameters.AddWithValue("@dkttot", returnDouble(txtdockettotal.Text.ToString()));
            cmd.ExecuteNonQuery();




            //ACCOUNTING OF PAID DOCKET CREATING MONEY RECIEPT
            if (cmbpaybas.SelectedValue.CompareTo("P01") == 0)
            {
                strmrno = fn.MRNogen(lblorgnloc.Text.Trim());

                // THESE VARIABLE ARE BULK MAY BE USED IF DOCKET FINANCE ENTRY CHANGE
                double deductionamt = 0, othercharge = 0, diplomatcharge = 0; //diplomatcharge=odacharge
                double deliverycharge = 0, tdscharge = 0, deducationonaccount = 0, otherdeduction = 0;
                string sqlmr = "INSERT INTO webx_mr_hdr ";
                sqlmr = sqlmr + "(entryby,entrydt,mrsno,mrssf, mrsdt, mrstype, mrsbr, mrbrnnm, dockno, docksf,";
                sqlmr = sqlmr + " dockdt, dockdlydt, ptcd, ptname, ptpin, pttel, ptadd, orgncd, docbknm, destcd,";
                sqlmr = sqlmr + " docdlnm, nopkgs, chrgwt, paybas, delbasd, mrsamt, netamt, deduction,mrs_closed,";
                sqlmr = sqlmr + "ba_emp_cd,ba_emp_nm,rebook_flag,mrcollbrcd)"; ;
                sqlmr = sqlmr + " VALUES ('" + hdnemployee.Value.Trim() + "','" + fn.Mydate1(txtdockdate.Text.Trim()) + "', '" + strmrno + "','.','" + fn.Mydate1(txtdockdate.Text.Trim()) + "', '1' ,";
                sqlmr = sqlmr + "'" + lblorgnloc.Text.Trim() + "', '" + fn.GetLocation(lblorgnloc.Text.Trim()) + "',";
                sqlmr = sqlmr + "'" + txtdockno.Text.Trim() + "','.','" + fn.Mydate1(txtdockdate.Text.Trim()) + "',";
                sqlmr = sqlmr + "'" + fn.Mydate1(txtedd.Text.Trim()) + "',";
                if (txtcsgncd.Text.Trim().CompareTo("") == 0)
                {
                    sqlmr = sqlmr + "'8888','" + txtcsgnname.Text.ToString() + "',";
                }
                else
                {
                    sqlmr = sqlmr + "'" + txtcsgncd.Text.ToString() + "','" + txtcsgnnm.Text.ToString() + "',";
                }

                sqlmr = sqlmr + "'" + txtcsgnpin.Text.ToString() + "',";
                sqlmr = sqlmr + "'" + txtcsgnphone.Text.ToString() + "','" + txtcsgnaddress.Text.ToString() + "',";
                sqlmr = sqlmr + "'" + lblorgnloc.Text.Trim() + "','" + fn.GetLocation(lblorgnloc.Text.Trim()) + "',";
                sqlmr = sqlmr + "'" + txtdelloc.Text.ToString() + "','" + fn.GetLocation(txtdelloc.Text.ToString()) + "',";
                sqlmr = sqlmr + "'" + hdntotnopkgs.Value.Trim() + "','" + txttotchargedweight.Text.Trim() + "',";
                sqlmr = sqlmr + "'" + cmbpaybas.SelectedValue.Trim() + "',";
                sqlmr = sqlmr + "'" + fn.Getpaybas(cmbpaybas.SelectedValue.Trim()) + "', '" + txtdockettotal.Text.Trim() + "',";
                sqlmr = sqlmr + "'" + txtdockettotal.Text.Trim() + "','" + deductionamt + "','N','0','" + fn.GetEmpName(hdnemployee.Value.Trim()) + "',";
                sqlmr = sqlmr + "'N', '" + lblorgnloc.Text.Trim() + "')";
                cmd = new SqlCommand(sqlmr, con, trn);
                cmd.ExecuteNonQuery();

                //
                sqlmr = "UPDATE webx_mr_hdr SET col_frt=" + txtsubtotal.Text.Trim() + ",col_oth=" + othercharge + ",";
                sqlmr = sqlmr + "col_stax=" + txtservicetax.Text.Trim() + ",col_dlychg=" + deliverycharge + ",ded_tds=" + tdscharge + ",";
                sqlmr = sqlmr + "ded_onac=" + deducationonaccount + ",ded_oth=" + otherdeduction + ",diplomatchg=" + diplomatcharge + ",delserchrg_ded=0,";
                sqlmr = sqlmr + "diplomatchg_ded=0,col_cess=" + txteducess.Text.Trim() + ",col_h_cess=" + txtheducess.Text.Trim() + ",";
                sqlmr = sqlmr + "svctax_rate=" + lblservicetaxrate.Text.Trim() + ",cess_rate=" + lbleducessrate.Text.Trim() + ",";
                sqlmr = sqlmr + "h_cess_rate=" + lblheducessrate.Text.Trim() + "";
                sqlmr = sqlmr + " WHERE mrsno='" + strmrno + "'";
                cmd = new SqlCommand(sqlmr, con, trn);
                cmd.ExecuteNonQuery();

                sqlmr = "UPDATE webx_trans_docket_status SET MR='Y' WHERE dockno='" + txtdockno.Text.Trim() + "'";
                cmd = new SqlCommand(sqlmr, con, trn);
                cmd.ExecuteNonQuery();

                sqlmr = "EXEC usp_paidmrtransaction 1,'" + txtdockno.Text.Trim() + "','" + hdnfinstartyear.Value.Substring(2, 2) + "','" + hdnemployee.Value.Trim() + "',''";
                cmd = new SqlCommand(sqlmr, con, trn);
                cmd.ExecuteNonQuery();
            } // MR ENTRY ENDS HERE


            //UPDATE COUNT IN DCR MASTER
            sqlstr = "UPDATE webx_dcr_header SET used=ISNULL(used,0)+1 WHERE '" + txtdockno.Text.Trim() + "' BETWEEN doc_sr_from AND doc_sr_to AND LEN('" + txtdockno.Text.Trim() + "')=LEN(doc_sr_from)";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            ///////////// TBB ACCOUNTING //////////////////////////
            if (cmbpaybas.SelectedValue.Trim().CompareTo("P02") == 0)
            {
                if (hdnclient.Value.Trim().CompareTo("AGILITY") == 0 || hdnclient.Value.Trim().CompareTo("ASL") == 0 || hdnclient.Value.Trim().CompareTo("RLL") == 0 || hdnclient.Value.Trim().CompareTo("RITCO") == 0 || hdnclient.Value.Trim().CompareTo("VARUNA") == 0 || hdnclient.Value.Trim().CompareTo("UFL") == 0)
                {
                    string sqltbbacct = "EXEC usp_tbb_transaction 1,'" + txtdockno.Text.Trim() + "','" + hdnfinstartyear.Value.Substring(2, 2) + "','" + hdnemployee.Value.Trim() + "',''";
                    cmd = new SqlCommand(sqltbbacct, con, trn);
                    cmd.ExecuteNonQuery();
                }
            }


            ////////////////// TOPAY ACCOUNTING  //////////////////////////////
            if (cmbpaybas.SelectedValue.Trim().CompareTo("P03") == 0)
            {
                if (hdnclient.Value.CompareTo("AGILITY") == 0 || hdnclient.Value.Trim().CompareTo("ASL") == 0 || hdnclient.Value.CompareTo("RITCO") == 0 || hdnclient.Value.CompareTo("VARUNA") == 0 || hdnclient.Value.Trim().CompareTo("UFL") == 0)
                {
                    // GENERATING PAID MR TRANSACTION - START
                    sqlstr = "usp_topaymrtransaction";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@transNo", "1");
                    cmd.Parameters.AddWithValue("@docNo", txtdockno.Text.Trim());
                    cmd.Parameters.AddWithValue("@docsf", ".");
                    cmd.Parameters.AddWithValue("@finYear", hdnfinstartyear.Value.Substring(2, 2).Trim());
                    cmd.Parameters.AddWithValue("@entryBy1", hdnemployee.Value.Trim());
                    cmd.Parameters.AddWithValue("@NextVoucherno", "");
                    cmd.ExecuteNonQuery();
                    // GENERATING PAID MR TRANSACTION - END
                }
            }

            string flag_stax = "N", party_as = "CSGN";
            if (chkservicetaxexemp.Checked == true)
                flag_stax = "Y";
            else
                flag_stax = "N";

            if (optpartycsge.Checked == true)
                party_as = "CSGE";
            else
                party_as = "CSGN";

            sqlstr = "UPDATE webx_master_docket SET stax_exmpt_yn='" + flag_stax + "',party_as='" + party_as + "' WHERE dockno='" + txtdockno.Text + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            trn.Rollback();
            string exmess = ex.Message.ToString().Replace('\n', '_');
            Response.Redirect("ErrorPage.aspx?heading=DataBase Entry Failed.&detail1=May Be or Out of Range Wrong Data  Occured&detail2=" + exmess + "&suggestion2=Docket Entry");
            return;
        }

        trn.Commit();

        // REDIRECTION TO SUBMIT PAGE
        if (cmbpaybas.SelectedValue.CompareTo("P01") == 0)
        {
            Response.Redirect("docket_submit_done.aspx?dockno=" + txtdockno.Text.Trim() + "&Mrsno=" + strmrno.Trim());
        }
        else
        {
            Response.Redirect("docket_submit_done.aspx?dockno=" + txtdockno.Text.Trim() + "&Mrsno=NA");
        }
    }



    protected void applyContractFreight(string depth)
    {
        SqlCommand cmd;
        string sqlstr = "";
        if (depth.ToUpper().CompareTo("C") == 0)
            sqlstr = "USP_GET_CITY_FREIGHT";
        else if (depth.ToUpper().CompareTo("L") == 0)
            sqlstr = "USP_GET_LOCATION_FREIGHT";
        else if (depth.ToUpper().CompareTo("R") == 0 || depth.ToUpper().CompareTo("M") == 0)
            sqlstr = "USP_GET_REGIONAL_FREIGHT";

        cmd = new SqlCommand(sqlstr, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@contractid", hdncontractid.Value);
        cmd.Parameters.Add("@dockdate", fn.Mydate1(txtdockdate.Text));
        cmd.Parameters.Add("@fromcity", txtfrom.Text);
        cmd.Parameters.Add("@tocity", txtto.Text);
        cmd.Parameters.Add("@orgnloc", lblorgnloc.Text);
        cmd.Parameters.Add("@delloc", txtdelloc.Text);
        cmd.Parameters.Add("@servicetype", cmbservicetype.SelectedValue);
        cmd.Parameters.Add("@ftltype", cmbftltype.SelectedValue);
        cmd.Parameters.Add("@transmode", cmbtransmode.SelectedValue);
        cmd.Parameters.Add("@chargedweight", txttotchargedweight.Text.Trim());
        cmd.Parameters.Add("@noofpkgs", hdntotnopkgs.Value.Trim());
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            txtfreightcharge.Text = Convert.ToString(dr["freightcharge"]);
            txtfreightrate.Text = Convert.ToString(dr["freightrate"]);
            try
            {
                cmbratetype.SelectedValue = Convert.ToString(dr["ratetype"]);
            }
            catch (Exception ex) { cmbratetype.SelectedValue = "W"; }
            hdntrdays.Value = Convert.ToString(dr["trdays"]);


        }
        else
        {
            txtfreightcharge.Text = "0.00";
            txtfreightrate.Text = "0.00";
            cmbratetype.SelectedValue = "W";
            hdntrdays.Value = "0";
        }
        dr.Close();


        if (depth.CompareTo("M") == 0)
        {
            applyContractMinimumFreight();
        }

        if (txtfreightcharge.Text.CompareTo("") == 0)
            txtfreightcharge.Text = "0.00";

        if (txtfreightrate.Text.CompareTo("") == 0)
            txtfreightrate.Text = "0.00";

        if (hdntrdays.Value.CompareTo("") == 0)
            hdntrdays.Value = "0";

        // SETTING HIDDEN RATE FOR MINIMUM CALCULATION
        hdndbfreightrate.Value = txtfreightrate.Text;

    }


    protected void applyDefaultFreight(string depth)
    {
        SqlCommand cmd;
        string sqlstr = "";
        double rate_perkg = 0, rate_perpkg = 0;

        if (depth.ToUpper().CompareTo("L") == 0)
            sqlstr = "USP_GET_DEFAULT_LOCATION_FREIGHT";
        else if (depth.ToUpper().CompareTo("R") == 0 || depth.ToUpper().CompareTo("M") == 0)
            sqlstr = "USP_GET_DEFAULT_REGIONAL_FREIGHT";

        cmd = new SqlCommand(sqlstr, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@paybas", cmbpaybas.SelectedValue);
        cmd.Parameters.Add("@orgnloc", lblorgnloc.Text);
        cmd.Parameters.Add("@delloc", txtdelloc.Text);
        cmd.Parameters.Add("@transmode", cmbtransmode.SelectedValue);
        cmd.Parameters.Add("@chargedweight", txttotchargedweight.Text.Trim());
        cmd.Parameters.Add("@noofpkgs", hdntotnopkgs.Value.Trim());
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            rate_perkg = returnDouble(Convert.ToString(dr["RATE_PER_KG"]));
            rate_perpkg = returnDouble(Convert.ToString(dr["RATE_PER_PKG"]));
            hdntrdays.Value = Convert.ToString(dr["TRDAYS"]);
        }
        else
        {
            txtfreightcharge.Text = "0.00";
            txtfreightrate.Text = "0.00";
            cmbratetype.SelectedValue = "W";
            hdntrdays.Value = "0";
        }
        dr.Close();


        if (rate_perkg != 0)
        {
            txtfreightrate.Text = rate_perkg.ToString("F2");
            txtfreightcharge.Text = returnDouble(Convert.ToString(rate_perkg * returnDouble(txttotchargedweight.Text))).ToString("F2");
            cmbratetype.SelectedValue = "W";
        }
        else
        {
            txtfreightcharge.Text = "0.00";
            txtfreightrate.Text = "0.00";
            cmbratetype.SelectedValue = "W";
        }


        if (depth.ToUpper().CompareTo("M") == 0)
        {
            applyDefaultMinimumFreight();
        }


        if (txtfreightcharge.Text.CompareTo("") == 0)
            txtfreightcharge.Text = "0.00";

        if (txtfreightrate.Text.CompareTo("") == 0)
            txtfreightrate.Text = "0.00";

        if (hdntrdays.Value.CompareTo("") == 0)
            hdntrdays.Value = "0";

        // SETTING HIDDEN RATE FOR MINIMUM CALCULATION
        hdndbfreightrate.Value = txtfreightrate.Text;
    }


    protected void applyFOV()
    {
        //SETTING FOV RATE AND CHARGE
        if (hdnfovtype.Value.CompareTo("RS") == 0)
        {
            txtfovcalculated.Text = hdnfovcharge.Value.Trim();
            txtfovcharged.Text = hdnfovcharge.Value.Trim();
            txtfovrate.Text = "0.00";
            txtfovrate.Enabled = false;
        }
        else if (hdnfovtype.Value.CompareTo("%") == 0 || hdnfovtype.Value.Trim().ToUpper().CompareTo("% OF INVOICE") == 0)
        {
            if (optcarrierrisk.Checked == true)
            {
                txtfovrate.Text = hdnfovcarrierrate.Value;
                txtfovcalculated.Text = Convert.ToString(returnDouble(hdntotdeclval.Value) * returnDouble(hdnfovcarrierrate.Value) / 100);
                txtfovcharged.Text = Convert.ToString(returnDouble(hdntotdeclval.Value) * returnDouble(hdnfovcarrierrate.Value) / 100);
            }
            else if (optownerrisk.Checked == true)
            {
                txtfovrate.Text = hdnfovownerrate.Value;
                txtfovcalculated.Text = Convert.ToString(returnDouble(hdntotdeclval.Value) * returnDouble(hdnfovcarrierrate.Value) / 100);
                txtfovcharged.Text = Convert.ToString(returnDouble(hdntotdeclval.Value) * returnDouble(hdnfovcarrierrate.Value) / 100);
            }
        }

        // ROUNDING FOVs
        txtfovrate.Text = returnDouble(txtfovrate.Text).ToString("F2");
        txtfovcalculated.Text = returnDouble(txtfovcharged.Text).ToString("F2");
        txtfovcharged.Text = returnDouble(txtfovcharged.Text).ToString("F2");

        hdndefaultfov.Value = txtfovcharged.Text;
    }

    protected string applyMultiPointPickUp()
    {
        string flat = "", loc = "", sqlstr = "", rateype = "", multipickupcharge = "0.00";
        double pickuprate = 0.00, deliveryrate = 0.00;

        sqlstr = "SELECT flatmultipickup_yn,locmultipickup_yn FROM webx_custcontract_charge WHERE contractid='" + hdncontractid.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            flat = Convert.ToString(dr["flatmultipickup_yn"]);
            loc = Convert.ToString(dr["locmultipickup_yn"]);
        }
        dr.Close();


        if (loc.CompareTo("Y") == 0)
        {
            sqlstr = "SELECT pickup_chrg,delivery_chrg FROM webx_custcontract_multipointcharges ";
            sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "' AND ftltype='" + cmbftltype.SelectedValue.Trim() + "'";
            sqlstr = sqlstr + " AND from_loc='" + lblorgnloc.Text.Trim() + "' AND to_loc='" + txtdelloc.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                pickuprate = returnDouble(Convert.ToString(dr["pickup_chrg"]));
                rateype = Convert.ToString(dr["ratetype"]);
            }
            dr.Close();

        }
        else if (flat.CompareTo("Y") == 0)
        {
            sqlstr = "SELECT pickup,ratetype,delivery FROM webx_custcontract_flatmultipoint ";
            sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "' AND ftltype='" + cmbftltype.SelectedValue.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                pickuprate = returnDouble(Convert.ToString(dr["pickup"]));
                rateype = Convert.ToString(dr["ratetype"]);

            }
            dr.Close();
        }

        if (rateype.ToUpper().CompareTo("W") == 0)
        {
            multipickupcharge = returnDouble(Convert.ToString(pickuprate * returnDouble(txttotchargedweight.Text))).ToString("F2");
        }
        else if (rateype.ToUpper().CompareTo("P") == 0)
        {
            multipickupcharge = returnDouble(Convert.ToString(pickuprate * returnDouble(hdntotnopkgs.Value))).ToString("F2");
        }
        else if (rateype.ToUpper().CompareTo("T") == 0)
        {
            multipickupcharge = returnDouble(Convert.ToString(pickuprate * returnDouble(txttotchargedweight.Text) / 1000)).ToString("F2");
        }
        else if (rateype.ToUpper().CompareTo("F") == 0)
        {
            multipickupcharge = pickuprate.ToString("F2");
        }

        if (chkmultipickup.Checked == false)
        {
            multipickupcharge = "0.00";
        }

        if (multipickupcharge.CompareTo("") == 0)
            multipickupcharge = "0.00";

        return multipickupcharge;
    }

    protected string applyMultiPointDelivery()
    {

        string flat = "", loc = "", sqlstr = "", rateype = "", multideliverycharge = "0.00";
        double deliveryrate = 0.00;

        sqlstr = "SELECT flatmultidelivery_yn,locmultidelivery_yn FROM webx_custcontract_charge WHERE contractid='" + hdncontractid.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            flat = Convert.ToString(dr["flatmultidelivery_yn"]);
            loc = Convert.ToString(dr["locmultidelivery_yn"]);
        }
        dr.Close();

        if (loc.CompareTo("") == 0 && flat.CompareTo("") == 0)
        {
            multideliverycharge = "0.00";
        }

        if (loc.CompareTo("Y") == 0)
        {
            sqlstr = "SELECT pickup_chrg,delivery_chrg FROM webx_custcontract_multipointcharges ";
            sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "' AND ftltype='" + cmbftltype.SelectedValue.Trim() + "'";
            sqlstr = sqlstr + " AND from_loc='" + lblorgnloc.Text.Trim() + "' AND to_loc='" + txtdelloc.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {

                deliveryrate = returnDouble(Convert.ToString(dr["delivery_chrg"]));
                rateype = Convert.ToString(dr["ratetype"]);
            }
            dr.Close();

        }
        else if (flat.CompareTo("Y") == 0)
        {
            sqlstr = "SELECT pickup,ratetype,delivery FROM webx_custcontract_flatmultipoint ";
            sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "' AND ftltype='" + cmbftltype.SelectedValue.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {

                deliveryrate = returnDouble(Convert.ToString(dr["delivery"]));
                rateype = Convert.ToString(dr["ratetype"]);

            }
            dr.Close();
        }

        if (rateype.ToUpper().CompareTo("W") == 0)
        {
            multideliverycharge = returnDouble(Convert.ToString(deliveryrate * returnDouble(txttotchargedweight.Text))).ToString("F2");
        }
        else if (rateype.ToUpper().CompareTo("P") == 0)
        {
            multideliverycharge = returnDouble(Convert.ToString(deliveryrate * returnDouble(hdntotnopkgs.Value))).ToString("F2");
        }
        else if (rateype.ToUpper().CompareTo("T") == 0)
        {
            multideliverycharge = returnDouble(Convert.ToString(deliveryrate * returnDouble(txttotchargedweight.Text) / 1000)).ToString("F2");
        }
        else if (rateype.ToUpper().CompareTo("F") == 0)
        {
            multideliverycharge = deliveryrate.ToString("F2");
        }

        if (chkmultidelivery.Checked == false)
        {
            multideliverycharge = "0.00";
        }


        if (multideliverycharge.CompareTo("") == 0)
            multideliverycharge = "0.00";

        return multideliverycharge;

    }

    protected string applyProRataCharges()
    {
        string sqlstr = "", proratacharge = "0.00";
        sqlstr = "SELECT maxcapacity FROM webx_master_ftlcapacity WHERE ftltype='" + cmbftltype.SelectedValue + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        double maxcapacity = 0.00, diff = 0.00, ovcharges = 0.00;
        maxcapacity = returnDouble(Convert.ToString(cmd.ExecuteScalar()));
        diff = returnDouble(txttotchargedweight.Text) - maxcapacity;
        if (diff > 0)
        {
            ovcharges = diff * returnDouble(txtfreightcharge.Text) / maxcapacity;
        }


        proratacharge = ovcharges.ToString("F2");
        if (proratacharge.ToUpper().CompareTo("NAN") == 0)
        {
            proratacharge = "0.00";
        }
        hdnftlmaxcapacity.Value = maxcapacity.ToString();
        return proratacharge;
    }

    protected string applyLoadingCharge()
    {
        string flatloading = "", locloading = "", sqlstr = "", loadingcharge = "0.00";
        string loadingratetype = "";
        double loadingrate = 0.00;
        sqlstr = "SELECT flatloading_yn,flatunloading_yn,locloading_yn,locunloading_yn FROM webx_custcontract_charge WHERE contractid='" + hdncontractid.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            flatloading = Convert.ToString(dr["flatloading_yn"]);
            locloading = Convert.ToString(dr["locloading_yn"]);
        }
        dr.Close();



        int reccnt = 0;
        // RETRIEVING LOCATION WISE LOADING CHARGES
        if (locloading.CompareTo("Y") == 0)
        {
            if (cmbservicetype.SelectedValue.CompareTo("1") == 0)
                sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_loadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='C' AND location='" + txtfrom.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "'";
            else if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
                sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_loadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='C' AND location='" + txtfrom.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "' AND ftltype='" + cmbftltype.SelectedValue + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                loadingrate = returnDouble(Convert.ToString(dr["rate"]));
                loadingratetype = Convert.ToString(dr["ratetype"]).ToUpper();
                reccnt++;
            }
            dr.Close();

            if (reccnt == 0)
            {
                if (cmbservicetype.SelectedValue.CompareTo("1") == 0)
                    sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_loadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='L' AND location='" + lblorgnloc.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "'";
                else if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
                    sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_loadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='L' AND location='" + lblorgnloc.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "' AND ftltype='" + cmbftltype.SelectedValue + "'";
                cmd = new SqlCommand(sqlstr, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    loadingrate = returnDouble(Convert.ToString(dr["rate"]));
                    loadingratetype = Convert.ToString(dr["ratetype"]).ToUpper();
                    reccnt++;
                }
                dr.Close();
            } // END OF CITY NOT FOUND IF

        } // END OF LOADING IF

        if (flatloading.ToUpper().CompareTo("Y") == 0)
        {
            if (cmbservicetype.SelectedValue.CompareTo("1") == 0)
            {
                sqlstr = "SELECT rate,ratetype FROM webx_custcontract_flatloading WHERE contractid='" + hdncontractid.Value + "' AND service_class='" + cmbservicetype.SelectedValue + "'";
            }
            else if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
            {
                sqlstr = "SELECT rate,ratetype FROM webx_custcontract_flatloading WHERE contractid='" + hdncontractid.Value + "' AND service_class='" + cmbservicetype.SelectedValue + "' AND ftltype='" + cmbftltype.SelectedValue + "'";
            }
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                loadingrate = returnDouble(Convert.ToString(dr["rate"]));
                loadingratetype = Convert.ToString(dr["ratetype"]);
            }
            dr.Close();

        }


        if (loadingratetype.CompareTo("P") == 0)
        {
            loadingcharge = returnDouble(Convert.ToString(loadingrate * returnDouble(hdntotnopkgs.Value))).ToString("F2");
        }
        else if (loadingratetype.CompareTo("W") == 0)
        {
            loadingcharge = returnDouble(Convert.ToString(loadingrate * returnDouble(txttotchargedweight.Text))).ToString("F2");
        }
        else if (loadingratetype.CompareTo("T") == 0)
        {
            loadingcharge = returnDouble(Convert.ToString(loadingrate * returnDouble(txttotchargedweight.Text) / 1000)).ToString("F2");
        }
        else if (loadingratetype.CompareTo("F") == 0)
        {
            loadingcharge = loadingrate.ToString("F2");
        }


        if (returnDouble(loadingcharge) == 0)
            loadingcharge = "0.00";

        return loadingcharge;

    }

    protected string applyUnLoadingCharge()
    {
        string flatunloading = "", locunloading = "", sqlstr = "", unloadingcharge = "0.00";
        string unloadingratetype = "";
        double loadingrate = 0.00, unloadingrate = 0.00;
        sqlstr = "SELECT flatloading_yn,flatunloading_yn,locloading_yn,locunloading_yn FROM webx_custcontract_charge WHERE contractid='" + hdncontractid.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            flatunloading = Convert.ToString(dr["flatunloading_yn"]);
            locunloading = Convert.ToString(dr["locunloading_yn"]);
        }
        dr.Close();

        int reccnt = 0;



        // RETRIEVING LOCATION WISE UNLOADING CHARGES
        if (locunloading.CompareTo("Y") == 0)
        {
            reccnt = 0;
            if (cmbservicetype.SelectedValue.CompareTo("1") == 0)
                sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_unloadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='C' AND location='" + txtto.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "'";
            else if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
                sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_unloadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='C' AND location='" + txtto.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "' AND ftltype='" + cmbftltype.SelectedValue + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                unloadingrate = returnDouble(Convert.ToString(dr["rate"]));
                unloadingratetype = Convert.ToString(dr["ratetype"]).ToUpper();
                reccnt++;
            }
            dr.Close();


            if (reccnt == 0)
            {
                if (cmbservicetype.SelectedValue.CompareTo("1") == 0)
                    sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_unloadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='L' AND location='" + txtdelloc.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "'";
                else if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
                    sqlstr = "SELECT airrate AS rate,ratetype FROM webx_custcontract_unloadingcharges WHERE contractid='" + hdncontractid.Value + "' AND loctype='L' AND location='" + txtdelloc.Text + "' AND service_class='" + cmbservicetype.SelectedValue + "' AND ftltype='" + cmbftltype.SelectedValue + "'";
                cmd = new SqlCommand(sqlstr, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    unloadingrate = returnDouble(Convert.ToString(dr["rate"]));
                    unloadingratetype = Convert.ToString(dr["ratetype"]).ToUpper();
                    reccnt++;
                }
                dr.Close();
            }

        } // END OF LOCATION UNLOADING



        if (flatunloading.ToUpper().CompareTo("Y") == 0)
        {
            if (cmbservicetype.SelectedValue.CompareTo("1") == 0)
            {
                sqlstr = "SELECT rate,ratetype FROM webx_custcontract_flatunloading WHERE contractid='" + hdncontractid.Value + "' AND service_class='" + cmbservicetype.SelectedValue + "'";
            }
            else if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
            {
                sqlstr = "SELECT rate,ratetype FROM webx_custcontract_flatunloading WHERE contractid='" + hdncontractid.Value + "' AND service_class='" + cmbservicetype.SelectedValue + "' AND ftltype='" + cmbftltype.SelectedValue + "'";
            }
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                unloadingrate = returnDouble(Convert.ToString(dr["rate"]));
                unloadingratetype = Convert.ToString(dr["ratetype"]);
            }
            dr.Close();

        }


        if (unloadingratetype.CompareTo("P") == 0)
        {
            unloadingcharge = returnDouble(Convert.ToString(unloadingrate * returnDouble(hdntotnopkgs.Value))).ToString("F2");
        }
        else if (unloadingratetype.CompareTo("W") == 0)
        {
            unloadingcharge = returnDouble(Convert.ToString(unloadingrate * returnDouble(txttotchargedweight.Text))).ToString("F2");
        }
        else if (unloadingratetype.CompareTo("T") == 0)
        {
            unloadingcharge = returnDouble(Convert.ToString(unloadingrate * returnDouble(txttotchargedweight.Text) / 1000)).ToString("F2");
        }
        else if (unloadingratetype.CompareTo("F") == 0)
        {
            unloadingcharge = unloadingrate.ToString("F2");
        }


        if (returnDouble(unloadingcharge) == 0)
            unloadingcharge = "0.00";

        return unloadingcharge;
    }

    protected string applyFuelSurCharge()
    {
        string fuelsurchargeflag = "", fuelsurchargebasair = "", fuelsurchargebasroad = "", fuelsurchargebastrain = "", fuelsurchargebasexpress = "";
        double fuelsurchargeair = 0, fuelminchargeair = 0, fuelmaxchargeair = 0;
        double fuelsurchargeroad = 0, fuelminchargeroad = 0, fuelmaxchargeroad = 0;
        double fuelsurchargetrain = 0, fuelminchargetrain = 0, fuelmaxchargetrain = 0;
        double fuelsurchargeexpress = 0, fuelminchargeexpress = 0, fuelmaxchargeexpress = 0;

        double totalsurcharge = 0.00, freightchrg = 0.00;
        freightchrg = returnDouble(txtfreightcharge.Text.Trim());
        if (hdnfoundcontract.Value.CompareTo("C") == 0)
        {
            string sqlstr = "SELECT * FROM webx_custcontract_charge WHERE contractid='" + hdncontractid.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                fuelsurchargeflag = Convert.ToString(dr["diesel_hike_yn"]);
                fuelminchargeair = returnDouble(Convert.ToString(dr["min_fuelsurchrgair"]));
                fuelmaxchargeair = returnDouble(Convert.ToString(dr["max_fuelsurchrgair"]));
                fuelminchargeroad = returnDouble(Convert.ToString(dr["min_fuelsurchrgroad"]));
                fuelmaxchargeroad = returnDouble(Convert.ToString(dr["max_fuelsurchrgroad"]));
                fuelminchargetrain = returnDouble(Convert.ToString(dr["min_fuelsurchrgtrain"]));
                fuelmaxchargetrain = returnDouble(Convert.ToString(dr["max_fuelsurchrgtrain"]));
                fuelminchargeexpress = returnDouble(Convert.ToString(dr["min_fuelsurchrgexpress"]));
                fuelmaxchargeexpress = returnDouble(Convert.ToString(dr["max_fuelsurchrgexpress"]));

                fuelsurchargebasair = Convert.ToString(dr["fuelsurchrgbasair"]);
                fuelsurchargebasroad = Convert.ToString(dr["fuelsurchrgbasroad"]);
                fuelsurchargebastrain = Convert.ToString(dr["fuelsurchrgbastrain"]);
                fuelsurchargebasexpress = Convert.ToString(dr["fuelsurchrgbasexpress"]);

                fuelsurchargeair = returnDouble(Convert.ToString(dr["air_fuelsurchrg"]));
                fuelsurchargeroad = returnDouble(Convert.ToString(dr["road_fuelsurchrg"]));
                fuelsurchargetrain = returnDouble(Convert.ToString(dr["train_fuelsurchrg"]));
                fuelsurchargeexpress = returnDouble(Convert.ToString(dr["express_fuelsurchrg"]));
            }
            dr.Close();
        }
        else if (hdnfoundcontract.Value.CompareTo("D") == 0)
        {
            string sqlstr = "SELECT * FROM webx_default_contract_charge WHERE contract_type='" + cmbpaybas.SelectedValue.Trim() + "' AND trans_type='" + cmbtransmode.Text + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                fuelsurchargeflag = Convert.ToString(dr["diesel_hike_yn"]);
                fuelminchargeair = returnDouble(Convert.ToString(dr["min_fuelsurchrgair"]));
                fuelmaxchargeair = returnDouble(Convert.ToString(dr["max_fuelsurchrgair"]));
                fuelminchargeroad = returnDouble(Convert.ToString(dr["min_fuelsurchrgroad"]));
                fuelmaxchargeroad = returnDouble(Convert.ToString(dr["max_fuelsurchrgroad"]));
                fuelminchargetrain = returnDouble(Convert.ToString(dr["min_fuelsurchrgtrain"]));
                fuelmaxchargetrain = returnDouble(Convert.ToString(dr["max_fuelsurchrgtrain"]));
                fuelminchargeexpress = returnDouble(Convert.ToString(dr["min_fuelsurchrgexpress"]));
                fuelmaxchargeexpress = returnDouble(Convert.ToString(dr["max_fuelsurchrgexpress"]));

                fuelsurchargebasair = Convert.ToString(dr["fuelsurchrgbasair"]);
                fuelsurchargebasroad = Convert.ToString(dr["fuelsurchrgbasroad"]);
                fuelsurchargebastrain = Convert.ToString(dr["fuelsurchrgbastrain"]);
                fuelsurchargebasexpress = Convert.ToString(dr["fuelsurchrgbasexpress"]);

                fuelsurchargeair = returnDouble(Convert.ToString(dr["air_fuelsurchrg"]));
                fuelsurchargeroad = returnDouble(Convert.ToString(dr["road_fuelsurchrg"]));
                fuelsurchargetrain = returnDouble(Convert.ToString(dr["train_fuelsurchrg"]));
                fuelsurchargeexpress = returnDouble(Convert.ToString(dr["express_fuelsurchrg"]));
            }
            dr.Close();
        }



        if (fuelsurchargeflag.ToUpper().CompareTo("Y") == 0)
        {
            switch (cmbtransmode.SelectedValue)
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
                            totalsurcharge = (returnDouble(txttotchargedweight.Text) * fuelsurchargeair);
                            break;
                    }
                    hdnfuelsurchargebas.Value = fuelsurchargebasair;
                    hdnfuelsurchargerate.Value = fuelsurchargeair.ToString("F2");
                    hdnfuelsurmincharge.Value = fuelminchargeair.ToString("F2");
                    hdnfuelsurmaxcharge.Value = fuelmaxchargeair.ToString("F2");
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
                            totalsurcharge = (returnDouble(txttotchargedweight.Text) * fuelsurchargeroad);
                            break;
                    } break;
                    hdnfuelsurchargebas.Value = fuelsurchargebasroad;
                    hdnfuelsurchargerate.Value = fuelsurchargeroad.ToString("F2");
                    hdnfuelsurmincharge.Value = fuelminchargeroad.ToString("F2");
                    hdnfuelsurmaxcharge.Value = fuelmaxchargeroad.ToString("F2");
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
                            totalsurcharge = (returnDouble(txttotchargedweight.Text) * fuelsurchargetrain);
                            break;
                    } break;
                    hdnfuelsurchargebas.Value = fuelsurchargebastrain;
                    hdnfuelsurchargerate.Value = fuelsurchargetrain.ToString("F2");
                    hdnfuelsurmincharge.Value = fuelminchargetrain.ToString("F2");
                    hdnfuelsurmaxcharge.Value = fuelmaxchargetrain.ToString("F2");
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
                            totalsurcharge = (returnDouble(txttotchargedweight.Text) * fuelsurchargeexpress);
                            break;
                    }
                    hdnfuelsurchargebas.Value = fuelsurchargebasexpress;
                    hdnfuelsurchargerate.Value = fuelsurchargeexpress.ToString("F2");
                    hdnfuelsurmincharge.Value = fuelminchargeexpress.ToString("F2");
                    hdnfuelsurmaxcharge.Value = fuelmaxchargeexpress.ToString("F2");
                    break;
            } // TRANS MODE SWITCH
        }






        // APPLYING MIN-MAX
        switch (cmbtransmode.SelectedValue)
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

    protected void loadMPSources()
    {
        string sqlstr = "SELECT dockno,dockdt FROM webx_master_docket WHERE convert(varchar,dockdt,106)='" + fn.Mydate1(txtdockdate.Text.Trim()) + "' AND service_class='2' ORDER BY dockno";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        int cnt = 0;
        TableRow tr = new TableRow();
        tr.BackColor = System.Drawing.Color.White;
        while (dr.Read())
        {
            if (cnt == 0)
            {
                tr = new TableRow();
                tr.BackColor = System.Drawing.Color.White;
            }

            TableCell tc = new TableCell();
            tc.HorizontalAlign = HorizontalAlign.Center;
            tc.VerticalAlign = VerticalAlign.Middle;
            tc.BackColor = System.Drawing.Color.White;
            LinkButton lnk = new LinkButton();
            lnk.CssClass = "blackfnt";
            lnk.Text = dr["dockno"].ToString();
            lnk.Attributes.Add("onclick", "javascript:return selectMPSource('" + dr["dockno"].ToString() + "')");
            lnk.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
            lnk.ToolTip = "Click to Select Source " + hdndockname.Value;
            tc.Controls.Add(lnk);
            tr.Cells.Add(tc);

            cnt++;
            if (cnt == 5)
            {
                tblsources.Rows.Add(tr);
                cnt = 0;
            }
        }
        dr.Close();

        if (cnt > 0)
        {
            for (int i = 0; i < 5 - cnt; i++)
            {
                TableCell tc = new TableCell();
                tc.HorizontalAlign = HorizontalAlign.Center;
                tr.Cells.Add(tc);
            }
            tblsources.Rows.Add(tr);
        }
    }
    protected string eddFromTransitMaster()
    {
        string sqlstr = "";
        SqlCommand cmd;
        SqlDataReader dr;
        // FREIGHT CALCULATION STARTS HERE
        sqlstr = "SELECT TOP 1 * FROM webx_trms WHERE trorgn='" + lblorgnloc.Text.Trim() + "' AND trdest='" + txtdelloc.Text.Trim() + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        int rec = 0;
        if (dr.Read())
        {
            rec++;
            if (cmbtransmode.SelectedValue.CompareTo("1") == 0)
            {
                hdntrdays.Value = Convert.ToString(dr["trdays_air"]);
            }
            else if (cmbtransmode.SelectedValue.CompareTo("2") == 0)
            {
                hdntrdays.Value = Convert.ToString(dr["trdays"]);
            }
            else if (cmbtransmode.SelectedValue.CompareTo("3") == 0)
            {
                hdntrdays.Value = Convert.ToString(dr["trdays_rail"]);
            }
            else if (cmbtransmode.SelectedValue.CompareTo("4") == 0)
            {
                hdntrdays.Value = Convert.ToString(dr["trdays_exp"]);
            }
        }
        dr.Close();

        if (rec == 0)
        {
            if (hdnclient.Value.CompareTo("RLL") == 0)
            {
                string strfromzone = "", strtozone = "";
                sqlstr = "SELECT locregion FROM webx_location WHERE loccode='" + lblorgnloc.Text.Trim() + "'";
                cmd = new SqlCommand(sqlstr, con);
                strfromzone = Convert.ToString(cmd.ExecuteScalar());

                sqlstr = "SELECT locregion FROM webx_location WHERE loccode='" + txtdelloc.Text.Trim() + "'";
                cmd = new SqlCommand(sqlstr, con);
                strtozone = Convert.ToString(cmd.ExecuteScalar());

                // FREIGHT CALCULATION STARTS HERE
                sqlstr = "SELECT TOP 1 * FROM webx_trms_zone WHERE trorgn_zone='" + strfromzone + "' AND trdest_zone='" + strtozone + "'";
                cmd = new SqlCommand(sqlstr, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (cmbtransmode.SelectedValue.CompareTo("1") == 0)
                    {
                        hdntrdays.Value = Convert.ToString(dr["trdays_air"]);
                    }
                    else if (cmbtransmode.SelectedValue.CompareTo("2") == 0)
                    {
                        hdntrdays.Value = Convert.ToString(dr["trdays"]);
                    }
                    else if (cmbtransmode.SelectedValue.CompareTo("3") == 0)
                    {
                        hdntrdays.Value = Convert.ToString(dr["trdays_rail"]);
                    }
                    else if (cmbtransmode.SelectedValue.CompareTo("4") == 0)
                    {
                        hdntrdays.Value = Convert.ToString(dr["trdays_exp"]);
                    }
                }
                dr.Close();
            }
        } // IF RECORD NOT FOUND THEN FROM ZONE MASTER

        return returnEDD(hdntrdays.Value);
    }

    protected bool setPickDel(string pickupdel)
    {
        // PickUp/Delivery Types
        string[] arrdly = new string[4];
        arrdly = pickupdel.Split(',');
        cmbpickupdel.Items.Clear();
        cmbpickupdel.Items.Add(new ListItem("Select", "0"));
        for (int i = 0; i < arrdly.Length; i++)
        {
            if (arrdly[i].Trim().ToUpper().CompareTo("GG") == 0)
                cmbpickupdel.Items.Add(new ListItem("Godown Pickup - Godown Delivery", "1"));
            else if (arrdly[i].Trim().ToUpper().CompareTo("GD") == 0)
                cmbpickupdel.Items.Add(new ListItem("Godown Pickup - Door Delivery", "2"));
            else if (arrdly[i].Trim().ToUpper().CompareTo("DG") == 0)
                cmbpickupdel.Items.Add(new ListItem("Door Pickup - Godown Delivery", "3"));
            else if (arrdly[i].Trim().ToUpper().CompareTo("DD") == 0)
                cmbpickupdel.Items.Add(new ListItem("Door Pickup - Door Delivery", "4"));
        }
        return true;
    }
    protected bool setTransMode(bool air_yn, bool road_yn, bool rail_yn, bool express_yn)
    {
        cmbtransmode.Items.Clear();
        cmbtransmode.Items.Add(new ListItem("Select", "0"));
        string sqlstr = "SELECT * FROM webx_master_general WHERE codetype='TRN' AND statuscode='Y' ORDER BY codeid";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (Convert.ToString(dr["codeid"]).CompareTo("1") == 0)
            {
                if (air_yn)
                    cmbtransmode.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
            }
            if (Convert.ToString(dr["codeid"]).CompareTo("2") == 0)
            {
                if (road_yn)
                    cmbtransmode.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
            }
            if (Convert.ToString(dr["codeid"]).CompareTo("3") == 0)
            {
                if (rail_yn)
                    cmbtransmode.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
            }
            if (Convert.ToString(dr["codeid"]).CompareTo("4") == 0)
            {
                if (express_yn)
                    cmbtransmode.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
            }
        }
        dr.Close();
        return true;
    }
    protected bool setServiceType(bool sundry_yn, bool ftl_yn)
    {
        cmbservicetype.Items.Clear();
        cmbservicetype.Items.Add(new ListItem("Select", "0"));
        string sqlstr = "SELECT * FROM webx_master_general WHERE codetype='SVCTYP' AND statuscode='Y' ORDER BY codeid";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (Convert.ToString(dr["codeid"]).CompareTo("1") == 0)
            {
                if (sundry_yn)
                    cmbservicetype.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
            }
            if (Convert.ToString(dr["codeid"]).CompareTo("2") == 0)
            {
                if (ftl_yn)
                    cmbservicetype.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
            }
        }
        dr.Close();
        return true;
    }

    protected bool setFTLType()
    {
        //Filling FTL Types

        string sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y'";
        if (hdncontractid.Value.CompareTo("") != 0)
        {
            sqlstr = sqlstr + " AND codeid IN (SELECT ftltype FROM webx_custcontract_frtmatrix_ftlslabhdr ";
            sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "')";
        }
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        cmbftltype.Items.Clear();
        cmbftltype.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            cmbftltype.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"])));
        }
        dr.Close();

        return true;
    }

    protected void setDCRBusinessType()
    {
        string sqlstr = "";
        SqlCommand cmd;
        sqlstr = "SELECT business_type_id FROM webx_dcr_header WHERE '" + txtdockno.Text.Trim() + "' BETWEEN doc_sr_from AND doc_sr_to";
        cmd = new SqlCommand(sqlstr, con);
        string businesstype = Convert.ToString(cmd.ExecuteScalar());
        try
        {
            cmbbusinesstype.SelectedValue = businesstype;
            if (cmbbusinesstype.SelectedValue.CompareTo("") == 0 || cmbbusinesstype.SelectedValue.CompareTo("0") == 0)
                cmbbusinesstype.Enabled = true;
            else
                cmbbusinesstype.Enabled = false;
        }
        catch (Exception ex)
        {
            cmbbusinesstype.Enabled = true;
        }
    }


    protected void setDCRBusinessTransMode()
    {
        string sqlstr = "";
        SqlCommand cmd;
        sqlstr = "SELECT * FROM webx_dcr_business_transmode WHERE businesstype='" + cmbbusinesstype.SelectedValue + "'";
        cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        cmbtransmode.Items.Clear();
        cmbtransmode.Items.Add(new ListItem("Select", "0"));
        string defaultval = "";
        bool road_yn = false, air_yn = false, train_yn = false, express_yn = false, enabled = false;
        while (dr.Read())
        {
            if (dr["air_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                air_yn = true;
            }
            if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                road_yn = true;
            }
            if (dr["train_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                train_yn = true;
            }

            if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                express_yn = true;
            }

            if (dr["enabled"].ToString().ToUpper().CompareTo("Y") == 0)
            {
                enabled = true;
            }
            defaultval = dr["defaultvalue"].ToString();

        }
        dr.Close();

        setTransMode(air_yn, road_yn, train_yn, express_yn);
        cmbtransmode.SelectedValue = defaultval;
        cmbtransmode.Enabled = enabled;
    }

    protected bool finYearTestDockDate()
    {
        // DATE FINYEAR CHECKING
        System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
        DateTime dtnewdockdt = Convert.ToDateTime(txtdockdate.Text, enGB);

        string finyear = "";
        try
        {
            finyear = Session["finyear"].ToString();
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired &detail1=Please Further Enter " + dkt_call + "&suggestion2=Docket Entry");
            return false;
        }

        if (dtnewdockdt.Year == Convert.ToInt16(finyear))
        {
            if (dtnewdockdt.Month < 4)
            {
                Response.Redirect("ErrorPage.aspx?heading=Finacial Year of " + dkt_call + " date differs &detail1=Please Further Enter " + dkt_call + "&suggestion2=Docket Entry");
                return false;
            }
        }
        else if (dtnewdockdt.Year > Convert.ToInt16(finyear))
        {
            if (dtnewdockdt.Month > 3)
            {
                Response.Redirect("ErrorPage.aspx?heading=Finacial Year of " + dkt_call + " date differs &detail1=Please Further Enter " + dkt_call + "&suggestion2=Docket Entry");
                return false;
            }
        }
        else
        {
            Response.Redirect("ErrorPage.aspx?heading=Finacial Year of " + dkt_call + " date differs &detail1=Please Further Enter " + dkt_call + "&suggestion2=Docket Entry");
            return false;
        }
        return true;
    }

    protected string getContractID(string custcode)
    {
        string sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE custcode='" + custcode + "' AND contract_type='" + cmbpaybas.SelectedValue + "' AND CONVERT(datetime,'" + fn.Mydate1(txtdockdate.Text.Trim()) + "',106) BETWEEN contract_effectdate AND contract_eddate";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        return Convert.ToString(cmd.ExecuteScalar());
    }


    protected void step1Validation()
    {

        SqlCommand cmd;
        string sqlstr = "";

        if (cmbpaybas.SelectedValue.CompareTo("") == 0 || cmbpaybas.SelectedValue.CompareTo("0") == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Payment Basis Type Not Entered Properly.&detail1=Please enter Payment Basis properly.");
            return;
        }

        int cnt = 0;
        sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + lblorgnloc.Text + "' AND activeflag='Y'";
        cmd = new SqlCommand(sqlstr, con);
        cnt = Convert.ToInt16(cmd.ExecuteScalar());
        if (cnt == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Origin Location Not From Location Master &detail1=Wrong Origin Entered. Kindly select other Origin" + "&suggestion2=Docket Entry");
            return;
        }

        cnt = 0;
        sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + txtdelloc.Text + "' AND activeflag='Y'";
        cmd = new SqlCommand(sqlstr, con);
        cnt = Convert.ToInt16(cmd.ExecuteScalar());
        if (cnt == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Destination Location Not From Location Master &detail1=Wrong Destination Entered. Kindly select other Destination" + "&suggestion2=Docket Entry Failed");
            return;
        }

        // CHECKING FOR DOCKET DATE LIES IN CURRENT FIN YEAR
        if (!finYearTestDockDate())
        {
            Response.Redirect("ErrorPage.aspx?heading=Docket Date has not Proper Financial Year&detail1=" + "&suggestion2=Docket Entry Failed");
            return;
        }

    }


    protected void step2Validation()
    {

        string sqlstr = "";
        SqlCommand cmd;
        SqlDataReader dr;

        if (hdnclient.Value.CompareTo("UFL") != 0 && hdnclient.Value.CompareTo("RCPL") != 0)
        {
            int cnt = 0;
            if (txtfrom.Text.CompareTo("") != 0)
            {
                sqlstr = "SELECT COUNT(location) FROM webx_citymaster WHERE location='" + txtfrom.Text + "'";
                cmd = new SqlCommand(sqlstr, con);
                cnt = Convert.ToInt16(cmd.ExecuteScalar());
                if (cnt == 0)
                {
                    Response.Redirect("ErrorPage.aspx?heading=From City Not From Master &detail1=Wrong With FromCity. Kindly select other From City" + "&suggestion2=Docket Entry");
                    return;
                }
            }

            cnt = 0;
            if (txtto.Text.CompareTo("") != 0)
            {
                sqlstr = "SELECT COUNT(location) FROM webx_citymaster WHERE location='" + txtto.Text + "'";
                cmd = new SqlCommand(sqlstr, con);
                cnt = Convert.ToInt16(cmd.ExecuteScalar());
                if (cnt == 0)
                {
                    Response.Redirect("ErrorPage.aspx?heading=To City Not From Master &detail1=Wrong With To City. Kindly select To City" + "&suggestion2=Docket Entry");
                    return;
                }
            }
        } // Not UFL if


        if (cmbservicetype.SelectedValue.CompareTo("") == 0 || cmbservicetype.SelectedValue.CompareTo("0") == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Service Type Not Entered Properly.&detail1=Please enter service type properly.");
            return;
        }


        if (cmbservicetype.SelectedValue.CompareTo("2") == 0)
        {
            if (cmbftltype.SelectedValue.CompareTo("") == 0 || cmbftltype.SelectedValue.CompareTo("0") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=FTL Type Type Not Entered Properly.&detail1=Please enter FTL Type type properly.");
                return;
            }
        }


        // To Show and Hide Cubic Feet Panel
        if (chkvolumetric.Checked == true)
            trcubicfeet.Style["display"] = "marker";
        else
            trcubicfeet.Style["display"] = "none";



        // LOADING INVOICE GRID
        DataTable dt = new DataTable();
        dt.Columns.Add("srno", typeof(string));
        dt.Rows.Add();
        foreach (DataRow dtr in dt.Rows)
        {
            dtr["srno"] = "1";
        }


        grvinvoice.DataSource = dt;
        grvinvoice.DataBind();

        if (chkvolumetric.Checked == true)
            txtcubicrate.Focus();
        else
            txtinvoicerows.Focus();

    }

    protected bool step3Validation()
    {

        if (txtcsgncd.Text.CompareTo("") == 0 && txtcsgnname.Text.CompareTo("") == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Consignor Code and Name Not found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return false;
        }
        if (txtcsgecd.Text.CompareTo("") == 0 && txtcsgename.Text.CompareTo("") == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Consignee Code and Name Not found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return false;
        }
        if (txtcsgncd.Text.CompareTo("") == 0)
        {
            if (txtcsgnaddress.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignor Address Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtcsgncity.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignor City Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtcsgnpin.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignor PinCode Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtcsgnphone.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignor Phone Number Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }
        }

        if (txtcsgecd.Text.CompareTo("") == 0)
        {
            if (txtcsgeaddress.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignee Address Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtcsgecity.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignee City Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtcsgepin.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignee PinCode Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtcsgephone.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Consignee Phone Number Not Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }
        }

        if (hdntotnopkgs.Value.CompareTo("") == 0 || returnDouble(hdntotnopkgs.Value) < 1)
        {
            Response.Redirect("ErrorPage.aspx?heading=Critical Error. Total No of Packages is is Zero&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return false;
        }

        if (hdntotdeclval.Value.CompareTo("") == 0 || returnDouble(hdntotdeclval.Value) < 1)
        {
            Response.Redirect("ErrorPage.aspx?heading=Critical Error. Total Declared Value is Zero&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return false;
        }

        if (returnDouble(txttotchargedweight.Text) == 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=Total Charged Weight is zero.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return false;
        }


        if (grvinvoice.Rows.Count <= 0)
        {
            Response.Redirect("ErrorPage.aspx?heading=No Invoice Entry Found.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return false;
        }


        foreach (GridViewRow grv in grvinvoice.Rows)
        {
            TextBox txtinvoiceno = (TextBox)grv.FindControl("txtinvoiceno");
            TextBox txtinvoicedate = (TextBox)grv.FindControl("txtinvoicedate");
            TextBox txtdeclval = (TextBox)grv.FindControl("txtdeclval");
            TextBox txtnopkgs = (TextBox)grv.FindControl("txtnopkgs");
            TextBox txtactualweight = (TextBox)grv.FindControl("txtactualweight");

            if (txtinvoiceno.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Invoice Number is Blank at time of submit.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (txtinvoicedate.Text.CompareTo("") == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Invoice Date is Blank at time of submit.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (returnDouble(txtdeclval.Text) == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Invoice Declared Value is zero at time of submit.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (returnDouble(txtnopkgs.Text) == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Invoice No of Packages is zero at time of submit.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }

            if (returnDouble(txtactualweight.Text) == 0)
            {
                Response.Redirect("ErrorPage.aspx?heading=Invoice Actual Weight is Packages is zero at time of submit.&detail1=&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
                return false;
            }
        }

        return true;
    }


    protected void applyContractMinimumFreight()
    {
        string sqlstr = "USP_GET_MINIMUM_FREIGHT";
        SqlCommand cmd;

        cmd = new SqlCommand(sqlstr, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@contractid", hdncontractid.Value);
        cmd.Parameters.Add("@paybas", cmbpaybas.SelectedValue);
        cmd.Parameters.Add("@transmode", cmbtransmode.SelectedValue);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            hdnminfreighttype.Value = Convert.ToString(dr["minfreighttype"]);
            hdnminfreightbas.Value = Convert.ToString(dr["minfreightbas"]);
            hdnminfreightbasrate.Value = Convert.ToString(dr["minfreightbasrate"]);

            hdnminfreightrate.Value = Convert.ToString(dr["minfreightrate"]);
            hdnlowlimfreightrate.Value = Convert.ToString(dr["freightratelowerlimit"]);
            hdnupplimfreightrate.Value = Convert.ToString(dr["freightrateupperlimit"]);

            hdnminsubtotal.Value = Convert.ToString(dr["minsubtotal"]);
            hdnlowlimsubtotal.Value = Convert.ToString(dr["subtotallowerlimit"]);
            hdnupplimsubtotal.Value = Convert.ToString(dr["subtotalupperlimit"]);

            hdnflagminfreightper.Value = Convert.ToString(dr["flag_freight"]);
            hdnflagminsubtotalper.Value = Convert.ToString(dr["flag_subtotal"]);
        }
        dr.Close();

    }

    protected void applyDefaultMinimumFreight()
    {
        string sqlstr = "USP_GET_DEFAULT_MINIMUM_FREIGHT";
        SqlCommand cmd;

        cmd = new SqlCommand(sqlstr, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@paybas", cmbpaybas.SelectedValue);
        cmd.Parameters.Add("@transmode", cmbtransmode.SelectedValue);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            hdnminfreighttype.Value = Convert.ToString(dr["minfreighttype"]);
            hdnminfreightbas.Value = Convert.ToString(dr["minfreightbas"]);
            hdnminfreightbasrate.Value = Convert.ToString(dr["minfreightbasrate"]);

            hdnminfreightrate.Value = Convert.ToString(dr["minfreightrate"]);
            hdnlowlimfreightrate.Value = Convert.ToString(dr["freightratelowerlimit"]);
            hdnupplimfreightrate.Value = Convert.ToString(dr["freightrateupperlimit"]);

            hdnminsubtotal.Value = Convert.ToString(dr["minsubtotal"]);
            hdnlowlimsubtotal.Value = Convert.ToString(dr["subtotallowerlimit"]);
            hdnupplimsubtotal.Value = Convert.ToString(dr["subtotalupperlimit"]);

            hdnflagminfreightper.Value = Convert.ToString(dr["flag_freight"]);
            hdnflagminsubtotalper.Value = Convert.ToString(dr["flag_subtotal"]);
        }
        dr.Close();

    }

    protected void checkFreightLimits()
    {
        double minfreight = 0.00, lowlim = 0.00, upplim = 0.00;
        if (hdnminfreighttype.Value.CompareTo("B") == 0)
        {
            if (hdnminfreightbas.Value.CompareTo("RS") == 0)
                minfreight = returnDouble(hdnminfreightbasrate.Value);
            else if (hdnminfreightbas.Value.CompareTo("KG") == 0)
                minfreight = returnDouble(hdnminfreightbasrate.Value) * returnDouble(txttotchargedweight.Text);
            else if (hdnminfreightbas.Value.CompareTo("PKG") == 0)
                minfreight = returnDouble(hdnminfreightbasrate.Value) * returnDouble(hdntotnopkgs.Value);
            else if (hdnminfreightbas.Value.CompareTo("T") == 0)
                minfreight = returnDouble(hdnminfreightbasrate.Value) * returnDouble(txttotchargedweight.Text) / 1000;

            if (returnDouble(txtfreightcharge.Text) < minfreight)
            {
                lblminfreightalert.Text = "Minimm Freight Base Wise Applied.";
                lblminfreightalert.Style["display"] = "block";
                txtfreightcharge.Text = minfreight.ToString("F2");
                if (cmbratetype.SelectedValue.CompareTo("W") == 0)
                    txtfreightrate.Text = returnDouble(Convert.ToString(minfreight / returnDouble(txttotchargedweight.Text))).ToString("F2");
                else if (cmbratetype.SelectedValue.CompareTo("P") == 0)
                    txtfreightrate.Text = returnDouble(Convert.ToString(minfreight / returnDouble(hdntotnopkgs.Value))).ToString("F2");
                else if (cmbratetype.SelectedValue.CompareTo("T") == 0)
                    txtfreightrate.Text = returnDouble(Convert.ToString(minfreight / (returnDouble(txttotchargedweight.Text) * 1000))).ToString("F2");
            }
        }
        else if (hdnminfreighttype.Value.CompareTo("%") == 0)
        {

            minfreight = returnDouble(hdnminfreightrate.Value);
            //lowlim = returnDouble(txtfreightrate.Text) * returnDouble(hdnlowlimfreightrate.Value) / 100;
            //upplim = returnDouble(txtfreightrate.Text) * returnDouble(hdnupplimfreightrate.Value) / 100;

            //if (returnDouble(txtfreightrate.Text) < lowlim)
            //{
            //    txtfreightrate.Text = lowlim.ToString("F2");

            //    lblminfreightalert.Text = "Minimm Freight Percent Wise Lower Limit " + hdnlowlimfreightrate.Value + " % Applied.";
            //    lblminfreightalert.Style["display"] = "block";
            //}

            //if (returnDouble(txtfreightrate.Text) > upplim)
            //{
            //    txtfreightrate.Text = upplim.ToString("F2");

            //    lblminfreightalert.Text = "Minimm Freight Percent Wise Upper Limit " + hdnupplimfreightrate.Value + " % Applied.";
            //    lblminfreightalert.Style["display"] = "block";
            //}

            //if (cmbratetype.SelectedValue.CompareTo("W") == 0)
            //    txtfreightcharge.Text = returnDouble(Convert.ToString(returnDouble(txtfreightrate.Text) * returnDouble(txttotchargedweight.Text))).ToString("F2");
            //else if (cmbratetype.SelectedValue.CompareTo("W") == 0)
            //    txtfreightcharge.Text = returnDouble(Convert.ToString(returnDouble(txtfreightrate.Text) * returnDouble(hdntotnopkgs.Value))).ToString("F2");
            //else if (cmbratetype.SelectedValue.CompareTo("T") == 0)
            //    txtfreightcharge.Text = returnDouble(Convert.ToString(returnDouble(txtfreightrate.Text) * (returnDouble(txttotchargedweight.Text) / 1000))).ToString("F2");

            if (returnDouble(txtfreightcharge.Text) < minfreight)
            {
                txtfreightcharge.Text = minfreight.ToString("F2");
                if (cmbratetype.SelectedValue.CompareTo("W") == 0)
                    txtfreightrate.Text = returnDouble(Convert.ToString(returnDouble(txtfreightcharge.Text) / returnDouble(txttotchargedweight.Text))).ToString("F2");
                else if (cmbratetype.SelectedValue.CompareTo("W") == 0)
                    txtfreightrate.Text = returnDouble(Convert.ToString(returnDouble(txtfreightcharge.Text) * returnDouble(hdntotnopkgs.Value))).ToString("F2");
                else if (cmbratetype.SelectedValue.CompareTo("T") == 0)
                    txtfreightrate.Text = returnDouble(Convert.ToString(returnDouble(txtfreightcharge.Text) / ((returnDouble(txttotchargedweight.Text) * 1000)))).ToString("F2");

                lblminfreightalert.Text = "Minimm Freight Percent Wise applied. Minimum Amount " + minfreight.ToString("F2") + " RS Applied.";
                lblminfreightalert.Style["display"] = "block";
            }
        }
        else
        {
            Response.Redirect("ErrorPage.aspx?heading=Minimum Freight Not Set Please complete Contract &detail1=Error Occured on Payment Click Button&detail2=" + "&suggestion2=" + dkt_call + " Entry Failed");
            return;
        }
    }


    protected void applyDocumentDetails()
    {
        // Filling Document Grid
        string sql_doc = "WEBX_Check_Location";

        // Getting State Code for Document Details
        SqlCommand cmd = new SqlCommand(sql_doc, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = txtdelloc.Text;
        SqlDataReader dr = cmd.ExecuteReader();

        string locstate = "";
        while (dr.Read())
        {

            locstate = Convert.ToString(dr["LocState"]);
        }
        dr.Close();

        sql_doc = "SELECT stform,stcstreq,stnm,srno AS doc_srno FROM webx_state WHERE stcd='" + locstate + "' AND activeflag='Y'";

        cmd = new SqlCommand(sql_doc, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("STFORM", typeof(string));
        dt.Columns.Add("STCSTREQ", typeof(string));
        dt.Columns.Add("STNM", typeof(string));
        dt.Columns.Add("Doc_srno", typeof(string));

        DataRow dtr;
        da.Fill(ds, "tbldocument");

        if (ds.Tables["tbldocument"].Rows.Count > 0)
        {
            grvdoc.DataSource = ds;
            grvdoc.DataBind();
        }
    }


    protected void btndockcri_Click(object sender, EventArgs e)
    {

    }

}


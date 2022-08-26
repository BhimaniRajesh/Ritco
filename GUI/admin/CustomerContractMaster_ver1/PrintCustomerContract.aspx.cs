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

public partial class PrintCustomerContract : System.Web.UI.Page
{
    SqlConnection con;
    string sqlstr = "", custcode = "",contractid="", slabtype = "";
    public static string single_slab_yn = "", multiple_slab_yn = "", slab_code = "", slab_from = "", slab_to = "";
    public static string ratetype = "", trans_type = "", from_loccode = "", to_loccode = "", trdays = "", slab1 = "", slab2 = "", slab3 = "", slab4 = "", slab5 = "", slab6 = "";
    public static string air_rate = "", air_days = "", road_rate = "", road_days = "", train_rate = "", train_days = "", express_rate = "", express_days = "";
    public static string air_bas = "", road_bas = "", exp_bas = "", rail_bas = "", ftl1_trip_Rate = "", ftl1_trdays = "";

    MyFunctions fn;
    //  protected static string boxbg = "boxbg", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlCommand cmd;
        SqlDataReader dr;

        fn = new MyFunctions();

        try
        {
            custcode = Request.QueryString["customercode"].ToString();
        }
        catch (Exception ex)
        { 
            
        }

        try
        {
            contractid = Request.QueryString["contractid"].ToString();
        }
        catch (Exception ex)
        {

        }

        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();
        sqlstr = "SELECT convert(varchar,contract_stdate,106) as contract_stdate,convert(varchar,contract_eddate,106) as contract_eddate,convert(varchar,contract_effectdate,106) as contract_effectdate,* FROM webx_custcontract_hdr With(NOLOCK) WHERE contractid='" + contractid + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
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
            if (dr["stax_yn"].ToString().ToUpper().ToString().CompareTo("Y") == 0)
                lblstaxapplicable.Text = "Yes";
            else
                lblstaxapplicable.Text = "No";
            lblaccrepresent.Text = dr["acc_rep"].ToString();

            if (dr["single_slab_yn"].ToString().CompareTo("Y") == 0)
                slabtype = "S";
            else
                slabtype = "M";

            single_slab_yn = dr["single_slab_yn"].ToString();
            multiple_slab_yn = dr["multiple_slab_yn"].ToString();
            if (single_slab_yn == "Y")
            {
                typeofContrct.Text = "Single Slab Contract";
            }
            else if (multiple_slab_yn == "Y")
            {
                typeofContrct.Text = "Multi Slab Contract";
            }
            typeofContrct.CssClass = "blackfnt";
            if (Session["client"].ToString().ToUpper().CompareTo("RCPL") == 0)
            {
                trcommitedbusiness.Style["display"] = "block";
            }
            lblcommitedbusiness.Text = dr["commitedbusiness"].ToString();
            lblstaxpaidby.Text = dr["stax_paidby"].ToString();

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


        }
        dr.Close();




        sqlstr = "SELECT * FROM webx_custcontract_charge WHERE  contractid='" + contractid + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (Session["Client"].ToString().ToUpper().CompareTo("RLL") == 0)
            {
                if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                    lbltransroad.Text = "STANDARD - Yes";
                else
                    lbltransroad.Text = "STANDARD - No";
            }
            else
            {
                if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                    lbltransroad.Text = "ROAD - Yes";
                else
                    lbltransroad.Text = "ROAD - No";
            }

            if (dr["air_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lbltransair.Text = "AIR - Yes";
            else
                lbltransair.Text = "AIR - No";

            if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lbltransexpress.Text = "EXPRESS - Yes";
            else
                lbltransexpress.Text = "EXPRESS - No";

            if (dr["rail_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lbltranstrain.Text = "TRAIN - Yes";
            else
                lbltranstrain.Text = "TRAIN - No";

            //LOAD TYPES
            if (dr["sundry_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lblloadsundry.Text = "SUNDRY - Yes";
            else
                lblloadsundry.Text = "SUNDRY - No";

            if (dr["FTL_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lblloadftl.Text = "FTL - Yes";
            else
                lblloadftl.Text = "FTL - No";

            //PICKUP DELEVERY

            string[] arrpickdel = dr["pkp_dly"].ToString().Trim().ToUpper().Split(',');

            for (int i = 0; i < arrpickdel.Length; i++)
            {
                if (arrpickdel[i].CompareTo("DD") == 0)
                    lbldd.Text = "Door ~ Door - Yes";
                else
                    lbldd.Text = "Door ~ Door - No";

                if (arrpickdel[i].CompareTo("GD") == 0)
                    lblgd.Text = "GoDown ~ Door - Yes";
                else
                    lblgd.Text = "GoDown ~ Door - No";

                if (arrpickdel[i].CompareTo("GG") == 0)
                    lblgg.Text = "GoDown ~ GoDown - Yes";
                else
                    lblgg.Text = "GoDown ~ GoDown - No";

                if (arrpickdel[i].CompareTo("DG") == 0)
                    lbldg.Text = "Door ~ GoDown - Yes";
                else
                    lbldg.Text = "Door ~ GoDown - No";
            }// PICKUP DELIVERY FOR LOOP


            // FOV TYPES
            lblfovtype.Text = dr["fov_type"].ToString().ToUpper();
            if (dr["fov_type"].ToString().ToUpper().CompareTo("RS") == 0)
            {
                lblfovcarrierrate.Style["display"] = "none";
                lblfovownerrate.Style["display"] = "none";
                lblfovflatrate.Text = dr["fov_chrg"].ToString();
            }
            else if (dr["fov_type"].ToString().ToUpper().CompareTo("%") == 0)
            {
                lblfovownerrate.Text = "Owner Risk " + dr["fov_chrg_owner"].ToString();
                lblfovcarrierrate.Text = "Carrier Risk " + dr["fov_chrg_carrier"].ToString();
                lblfovflatrate.Style["display"] = "none";
            }

            //INSURANCE PERCENTAGE
            lblinsuranceper.Text = dr["insu_per"].ToString();

            // SERVICE TYPES
            if (dr["cod_dod_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lblcoddod.Text = "COD/DOD  Yes";
            else
                lblcoddod.Text = "COD/DOD  No";

            if (dr["oda_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lbloda.Text = "ODA  Yes";
            else
                lbloda.Text = "ODA  No";

            if (dr["vol_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lblvolumetric.Text = "VOLUMETRIC  Yes";
            else
                lblvolumetric.Text = "VOLUMETRIC  No";

            if (dr["dacc_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lbldacc.Text = "DACC  Yes";
            else
                lbldacc.Text = "DACC  No";


            //DEMURRAGE AFTER DAYS
            if (dr["dem_day"].ToString().ToUpper().CompareTo("") == 0 || dr["dem_day"] == DBNull.Value)
                lbldemafterdays.Text = "0";
            else
                lbldemafterdays.Text = dr["dem_day"].ToString();

            if (dr["dem_chrg_rs"].ToString().ToUpper().CompareTo("") == 0 || dr["dem_day"] == DBNull.Value)
                lblmindemchrg.Text = "0.00";
            else
                lbldemperkg.Text = dr["dem_chrg_rs"].ToString();

            if (dr["dem_chrg_perkg"].ToString().ToUpper().CompareTo("") == 0 || dr["dem_day"] == DBNull.Value)
                lbldemperkg.Text = "0.00";
            else
                lbldemperkg.Text = dr["dem_chrg_perkg"].ToString();


            // LOCATIONS
            lblbillgenloc.Text = dr["billgen_loccode"].ToString();
            lblbillsubloc.Text = dr["billsub_loccode"].ToString();
            lblbillcolloc.Text = dr["billcol_loccode"].ToString();

            if (dr["credit_day"].ToString().ToUpper().CompareTo("") == 0 || dr["credit_day"] == DBNull.Value)
                lblcreditdaysfromgen.Text = "Not Set";
            else
                lblcreditdaysfromgen.Text = dr["credit_day"].ToString();

            lblbillinginstance.Text = dr["bill_inst"].ToString();

            if (dr["credit_limit"].ToString().ToUpper().CompareTo("") == 0 || dr["credit_limit"] == DBNull.Value)
                lbltotlimitrs.Text = "Not Set";
            else
                lbltotlimitrs.Text = dr["credit_limit"].ToString();


            if (dr["sku_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                lblsku.Text = "Yes";
            else
                lblsku.Text = "No";

            rate_air.Text = dr["air_rate"].ToString();
            air_bas = dr["air_bas"].ToString();
            if (air_bas == "RS")
            {
                air_bas = "RS";
            }
            else if (air_bas == "KG")
            {
                air_bas = "Rate Per KG.";
            }
            else if (air_bas == "PKG")
            {
                air_bas = "Rate Per Package.";
            }
            else
            {
                air_bas = "";
            }
            basis_air.Text = air_bas;
            rate_road.Text = dr["road_rate"].ToString();
            road_bas = dr["road_bas"].ToString();
            if (road_bas == "RS")
            {
                road_bas = "RS";
            }
            else if (road_bas == "KG")
            {
                road_bas = "Rate Per KG.";
            }
            else if (road_bas == "PKG")
            {
                road_bas = "Rate Per Package.";
            }
            else
            {
                road_bas = "";
            }
            basis_road.Text = road_bas;
            rate_express.Text = dr["exp_rate"].ToString();
            exp_bas = dr["exp_bas"].ToString();
            if (exp_bas == "RS")
            {
                exp_bas = "RS";
            }
            else if (exp_bas == "KG")
            {
                exp_bas = "Rate Per KG.";
            }
            else if (exp_bas == "PKG")
            {
                exp_bas = "Rate Per Package.";
            }
            else
            {
                exp_bas = "";
            }
            basis_express.Text = exp_bas;
            rate_train.Text = dr["rail_rate"].ToString();
            rail_bas = dr["rail_bas"].ToString();
            if (rail_bas == "RS")
            {
                rail_bas = "RS";
            }
            else if (rail_bas == "KG")
            {
                rail_bas = "Rate Per KG.";
            }
            else if (rail_bas == "PKG")
            {
                rail_bas = "Rate Per Package.";
            }
            else
            {
                rail_bas = "";
            }
            basis_train.Text = rail_bas;

        }
        dr.Close();

        //*******************chagre Mst***********************************

        string SCHG01 = "", SCHG02 = "", SCHG03 = "", SCHG04 = "", SCHG05 = "", SCHG06 = "", SCHG07 = "", SCHG08 = "", SCHG09 = "", SCHG10 = "", SCHG11 = "", SCHG12 = "", SCHG13 = "", SCHG14 = "", SCHG15 = "", SCHG16 = "", SCHG17 = "", SCHG18 = "", SCHG19 = "", SCHG20 = "", SCHG21 = "", SCHG22 = "", SCHG23 = "";
        string UCHG01 = "", UCHG02 = "", UCHG03 = "", UCHG04 = "", UCHG05 = "", UCHG06 = "", UCHG07 = "", UCHG08 = "", UCHG09 = "", UCHG10 = "";
        sqlstr = " SELECT * FROM VW_custCONTRACT_CHARGE WHERE  contractid='" + contractid + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            SCHG01 = dr["SCHG01"].ToString();
            SCHG02 = dr["SCHG02"].ToString();
            SCHG03 = dr["SCHG03"].ToString();
            SCHG04 = dr["SCHG04"].ToString();
            SCHG05 = dr["SCHG05"].ToString();
            SCHG06 = dr["SCHG06"].ToString();
            SCHG07 = dr["SCHG07"].ToString();
            SCHG08 = dr["SCHG08"].ToString();
            SCHG09 = dr["SCHG09"].ToString();
            SCHG10 = dr["SCHG10"].ToString();
            SCHG11 = dr["SCHG11"].ToString();
            SCHG12 = dr["SCHG12"].ToString();
            SCHG13 = dr["SCHG13"].ToString();
            SCHG14 = dr["SCHG14"].ToString();
            SCHG15 = dr["SCHG15"].ToString();
            SCHG16 = dr["SCHG16"].ToString();
            SCHG17 = dr["SCHG17"].ToString();
            SCHG18 = dr["SCHG18"].ToString();

            SCHG19 = dr["SCHG19"].ToString();
            SCHG20 = dr["SCHG20"].ToString();
            SCHG21 = dr["SCHG21"].ToString();
            SCHG22 = dr["SCHG22"].ToString();
            SCHG23 = dr["SCHG23"].ToString();

            UCHG01 = dr["UCHG01"].ToString();
            UCHG02 = dr["UCHG02"].ToString();
            UCHG03 = dr["UCHG03"].ToString();
            UCHG04 = dr["UCHG04"].ToString();
            UCHG05 = dr["UCHG05"].ToString();
            UCHG06 = dr["UCHG06"].ToString();
            UCHG07 = dr["UCHG07"].ToString();
            UCHG08 = dr["UCHG08"].ToString();
            UCHG09 = dr["UCHG09"].ToString();
            UCHG10 = dr["UCHG10"].ToString();

        }

        dr.Close();
        sqlstr = " SELECT codeid,codedesc,statuscode FROM webx_master_general WHERE codetype='CHG' and statuscode='Y' and codeid not in ('SCHG07','SCHG08','SCHG11','SCHG12','SCHG13','SCHG14')";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        int chg_cnt = 0;
        TableRow Chgmast_row_title = new TableRow();
        Chgmast_row_title.BorderWidth = 1;
        TableCell Chgmast_cell_title11 = new TableCell();
        TableCell Chgmast_cell_title12 = new TableCell();

        TableRow Chgmast_row_header = new TableRow();
        Chgmast_row_header.BorderWidth = 1;
        TableCell Chgmast_cell_title = new TableCell();
        TableCell Chgmast_cell_title1 = new TableCell();

        string chargeName = "", codeid = "", chargevalue = "";
        while (dr.Read())
        {
            chg_cnt = chg_cnt + 1;
            if (chg_cnt == 1)
            {

                Chgmast_cell_title11.Text = "Charges Details";
                Chgmast_cell_title11.Font.Bold = true;

                Chgmast_cell_title11.CssClass = "blackboldfnt";
                Chgmast_cell_title11.Wrap = false;
                Chgmast_cell_title11.ColumnSpan = 2;
                Chgmast_row_title.Cells.Add(Chgmast_cell_title11);

                Chgmast_row_title.BackColor = System.Drawing.Color.White;


                //Chgmast_row_header.BackColor = System.Drawing.Color.White;
                ChargesMst.Rows.Add(Chgmast_row_title);




                Chgmast_cell_title.Text = "Charge Name";
                Chgmast_cell_title.CssClass = "blackboldfnt";
                Chgmast_cell_title.Wrap = false;
                Chgmast_row_header.Cells.Add(Chgmast_cell_title);
                Chgmast_cell_title1.Text = "Charge Value";
                Chgmast_cell_title1.CssClass = "blackboldfnt";
                Chgmast_cell_title1.Wrap = false;
                Chgmast_row_header.Cells.Add(Chgmast_cell_title1);
                Chgmast_row_header.BackColor = System.Drawing.Color.White;
                ChargesMst.Rows.Add(Chgmast_row_header);

            }
            TableRow Chgmast_row_Value = new TableRow();
            Chgmast_row_Value.BorderWidth = 1;
            TableCell Chgmast_cell_Name = new TableCell();
            TableCell Chgmast_cell_Value = new TableCell();

            chargeName = dr["codedesc"].ToString();
            codeid = dr["codeid"].ToString();
            if (codeid == "SCHG01")
            {
                chargevalue = SCHG01;
            }
            else if (codeid == "SCHG02")
            {
                chargevalue = SCHG02;
            }
            else if (codeid == "SCHG03")
            {
                chargevalue = SCHG03;
            }
            else if (codeid == "SCHG04")
            {
                chargevalue = SCHG04;
            }
            else if (codeid == "SCHG05")
            {
                chargevalue = SCHG05;
            }
            else if (codeid == "SCHG06")
            {
                chargevalue = SCHG06;
            }
            else if (codeid == "SCHG07")
            {
                chargevalue = SCHG07;
            }
            else if (codeid == "SCHG08")
            {
                chargevalue = SCHG08;
            }
            else if (codeid == "SCHG09")
            {
                chargevalue = SCHG09;
            }
            else if (codeid == "SCHG10")
            {
                chargevalue = SCHG10;
            }
            else if (codeid == "SCHG11")
            {
                chargevalue = SCHG11;
            }
            else if (codeid == "SCHG12")
            {
                chargevalue = SCHG12;
            }
            else if (codeid == "SCHG13")
            {
                chargevalue = SCHG13;
            }
            else if (codeid == "SCHG14")
            {
                chargevalue = SCHG14;
            }
            else if (codeid == "SCHG15")
            {
                chargevalue = SCHG15;
            }
            else if (codeid == "SCHG16")
            {
                chargevalue = SCHG16;
            }
            else if (codeid == "SCHG17")
            {
                chargevalue = SCHG17;
            }
            else if (codeid == "SCHG18")
            {
                chargevalue = SCHG18;
            }
            else if (codeid == "SCHG19")
            {
                chargevalue = SCHG19;
            }
            else if (codeid == "SCHG20")
            {
                chargevalue = SCHG20;
            }
            else if (codeid == "SCHG21")
            {
                chargevalue = SCHG21;
            }
            else if (codeid == "SCHG22")
            {
                chargevalue = SCHG22;
            }
            else if (codeid == "SCHG23")
            {
                chargevalue = SCHG23;
            }
            else if (codeid == "UCHG01")
            {
                chargevalue = UCHG01;
            }
            else if (codeid == "UCHG02")
            {
                chargevalue = UCHG02;
            }
            else if (codeid == "UCHG03")
            {
                chargevalue = UCHG03;
            }
            else if (codeid == "UCHG04")
            {
                chargevalue = UCHG04;
            }
            else if (codeid == "UCHG05")
            {
                chargevalue = UCHG05;
            }
            else if (codeid == "UCHG06")
            {
                chargevalue = UCHG06;
            }
            else if (codeid == "UCHG07")
            {
                chargevalue = UCHG07;
            }
            else if (codeid == "UCHG08")
            {
                chargevalue = UCHG08;
            }
            else if (codeid == "UCHG09")
            {
                chargevalue = UCHG09;
            }
            else if (codeid == "UCHG10")
            {
                chargevalue = UCHG10;
            }
            Chgmast_cell_Name.Text = chargeName;
            Chgmast_cell_Name.CssClass = "blackfnt";
            Chgmast_cell_Name.Wrap = false;
            Chgmast_row_Value.Cells.Add(Chgmast_cell_Name);
            Chgmast_cell_Value.Text = chargevalue;
            Chgmast_cell_Value.CssClass = "blackfnt";
            Chgmast_cell_Value.Wrap = false;
            Chgmast_row_Value.Cells.Add(Chgmast_cell_Value);
            Chgmast_row_Value.BackColor = System.Drawing.Color.White;
            ChargesMst.Rows.Add(Chgmast_row_Value);
        }
        dr.Close();
        //ChargesMst
        //***************************************


        if (multiple_slab_yn == "Y")
        {

            int multitotalslab = 0;
            Slabhdr.Visible = true;
            sqlstr = " select slab_code,slab_from,slab_to from webx_custcontract_frtmatrix_slabhdr  WHERE contractid='" + contractid + "' order by slab_code";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();

            TableRow Slab1 = new TableRow();
            Slab1.BorderWidth = 1;
            int cnt_slab = 0;
            while (dr.Read())
            {
                cnt_slab = cnt_slab + 1;
                slab_code = dr["slab_code"].ToString();
                slab_from = dr["slab_from"].ToString();
                slab_to = dr["slab_to"].ToString();
                // if (slab_code == "SLAB" + Convert.ToString(cnt_slab))
                //{
                //lblslab1from.Text = slab_from.ToString();
                //lblslab1to.Text = slab_to.ToString();
                TableCell Slabfrom = new TableCell();
                TableCell Slabto = new TableCell();
                Slabfrom.Text = slab_from.ToString();
                Slabfrom.CssClass = "blackfnt";
                Slabfrom.Wrap = false;
                Slab1.Cells.Add(Slabfrom);
                Slabto.Text = slab_to.ToString();
                Slabto.CssClass = "blackfnt";
                Slabto.Wrap = false;
                Slab1.Cells.Add(Slabto);
                Slab1.BackColor = System.Drawing.Color.White;
                Slabhdr.Rows.Add(Slab1);
                // }

            }
            dr.Close();
            string TransMode = "", matrixtype = "", matrixtype_desc = "";
            for (int j = 1; j < 4; j++)
            {
                if (j == 1)
                {
                    matrixtype = "L";
                    matrixtype_desc = "Branch";
                }
                else if (j == 2)
                {
                    matrixtype = "R";
                    matrixtype_desc = "Zone";
                }
                else if (j == 3)
                {
                    matrixtype = "C";
                    matrixtype_desc = "City";
                }
                for (int i = 1; i < 5; i++)
                {
                    if (i == 1)
                    {
                        TransMode = "Air";
                    }
                    else if (i == 2)
                    {
                        TransMode = "Road";
                    }
                    else if (i == 3)
                    {
                        TransMode = "Train";
                    }
                    else if (i == 4)
                    {
                        TransMode = "Express";
                    }

                    //**************************************************Start branch Road*************************************************
                    sqlstr = "SELECT ratetype=(case when rtrim(ltrim(ratetype))='W' then 'Per Kg' when rtrim(ltrim(ratetype))='P' then 'Per Package' else 'unknown' end),* FROM webx_custcontract_frtmatrix_slabdet With(NOlock) WHERE  contractid='" + contractid + "' AND UPPER(trans_type)='" + TransMode + "' AND loc_reg='" + matrixtype + "'";
                    cmd = new SqlCommand(sqlstr, con);
                    dr = cmd.ExecuteReader();

                    TableRow BR_loc1 = new TableRow();
                    BR_loc1.BorderWidth = 1;
                    TableCell BR_loc_title = new TableCell();
                    //int cnt_slab = 0;
                    multitotalslab = 0;
                    TableRow BR_loc2 = new TableRow();
                    BR_loc2.BorderWidth = 1;
                    TableCell BR_loc_from2 = new TableCell();
                    TableCell BR_loc_to2 = new TableCell();
                    TableCell BR_loc_ratetype2 = new TableCell();
                    TableCell BR_loc_trdays2 = new TableCell();
                    TableCell BR_loc_slab12 = new TableCell();
                    TableCell BR_loc_slab22 = new TableCell();
                    TableCell BR_loc_slab32 = new TableCell();
                    TableCell BR_loc_slab42 = new TableCell();
                    TableCell BR_loc_slab52 = new TableCell();
                    TableCell BR_loc_slab62 = new TableCell();


                    BR_loc_from2.Text = "From";
                    BR_loc_from2.CssClass = "blackboldfnt";
                    BR_loc_from2.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_from2);

                    BR_loc_to2.Text = "To";
                    BR_loc_to2.CssClass = "blackboldfnt";
                    BR_loc_to2.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_to2);

                    BR_loc_trdays2.Text = "Tr days";
                    BR_loc_trdays2.CssClass = "blackboldfnt";
                    BR_loc_trdays2.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_trdays2);

                    BR_loc_ratetype2.Text = "Rate Type";
                    BR_loc_ratetype2.CssClass = "blackboldfnt";
                    BR_loc_ratetype2.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_ratetype2);

                    BR_loc_slab12.Text = "Slab 1";
                    BR_loc_slab12.CssClass = "blackboldfnt";
                    BR_loc_slab12.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_slab12);

                    BR_loc_slab22.Text = "Slab 2";
                    BR_loc_slab22.CssClass = "blackboldfnt";
                    BR_loc_slab22.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_slab22);

                    BR_loc_slab32.Text = "Slab 32";
                    BR_loc_slab32.CssClass = "blackboldfnt";
                    BR_loc_slab32.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_slab32);

                    BR_loc_slab42.Text = "Slab 4";
                    BR_loc_slab42.CssClass = "blackboldfnt";
                    BR_loc_slab42.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_slab42);

                    BR_loc_slab52.Text = "Slab 5";
                    BR_loc_slab52.CssClass = "blackboldfnt";
                    BR_loc_slab52.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_slab52);

                    BR_loc_slab62.Text = "Slab 6";
                    BR_loc_slab62.CssClass = "blackboldfnt";
                    BR_loc_slab62.Wrap = false;
                    BR_loc2.Cells.Add(BR_loc_slab62);



                    while (dr.Read())
                    {
                        multitotalslab = multitotalslab + 1;
                        // Branc_road.BackColor = System.Drawing.Color.White;
                        if (multitotalslab == 1)
                        {
                            BR_loc_title.Text = "Matrices for " + TransMode + "- Freight Rate " + matrixtype_desc + " Matrix";
                            BR_loc_title.CssClass = "blackboldfnt";
                            BR_loc_title.Wrap = false;
                            BR_loc_title.ColumnSpan = 10;
                            BR_loc1.BackColor = System.Drawing.Color.White;
                            BR_loc1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
                            BR_loc1.Cells.Add(BR_loc_title);
                            Branc_road.Rows.Add(BR_loc1);

                            BR_loc2.BackColor = System.Drawing.Color.White;
                            Branc_road.Rows.Add(BR_loc2);
                        }
                        TableRow BR_loc = new TableRow();
                        BR_loc.BorderWidth = 1;
                        ratetype = dr["ratetype"].ToString();
                        trans_type = dr["trans_type"].ToString();
                        from_loccode = dr["from_loccode"].ToString();
                        to_loccode = dr["to_loccode"].ToString();


                        if (matrixtype == "R")
                        {
                            from_loccode = fn.GetRegion_name(from_loccode);
                            to_loccode = fn.GetRegion_name(to_loccode);
                        }
                        trdays = dr["trdays"].ToString();
                        slab1 = dr["slab1"].ToString();
                        slab2 = dr["slab2"].ToString();
                        slab3 = dr["slab3"].ToString();
                        slab4 = dr["slab4"].ToString();
                        slab5 = dr["slab5"].ToString();
                        slab6 = dr["slab6"].ToString();

                        TableCell BR_loc_from = new TableCell();
                        TableCell BR_loc_to = new TableCell();
                        TableCell BR_loc_ratetype = new TableCell();
                        TableCell BR_loc_trdays = new TableCell();
                        TableCell BR_loc_slab1 = new TableCell();
                        TableCell BR_loc_slab2 = new TableCell();
                        TableCell BR_loc_slab3 = new TableCell();
                        TableCell BR_loc_slab4 = new TableCell();
                        TableCell BR_loc_slab5 = new TableCell();
                        TableCell BR_loc_slab6 = new TableCell();


                        BR_loc_from.Text = from_loccode.ToString();
                        BR_loc_from.CssClass = "blackfnt";
                        BR_loc_from.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_from);

                        BR_loc_to.Text = to_loccode.ToString();
                        BR_loc_to.CssClass = "blackfnt";
                        BR_loc_to.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_to);

                        BR_loc_trdays.Text = trdays.ToString();
                        BR_loc_trdays.CssClass = "blackfnt";
                        BR_loc_trdays.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_trdays);

                        BR_loc_ratetype.Text = ratetype.ToString();
                        BR_loc_ratetype.CssClass = "blackfnt";
                        BR_loc_ratetype.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_ratetype);

                        BR_loc_slab1.Text = slab1.ToString();
                        BR_loc_slab1.CssClass = "blackfnt";
                        BR_loc_slab1.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_slab1);

                        BR_loc_slab2.Text = slab2.ToString();
                        BR_loc_slab2.CssClass = "blackfnt";
                        BR_loc_slab2.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_slab2);

                        BR_loc_slab3.Text = slab3.ToString();
                        BR_loc_slab3.CssClass = "blackfnt";
                        BR_loc_slab3.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_slab3);

                        BR_loc_slab4.Text = slab4.ToString();
                        BR_loc_slab4.CssClass = "blackfnt";
                        BR_loc_slab4.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_slab4);

                        BR_loc_slab5.Text = slab5.ToString();
                        BR_loc_slab5.CssClass = "blackfnt";
                        BR_loc_slab5.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_slab5);

                        BR_loc_slab6.Text = slab6.ToString();
                        BR_loc_slab6.CssClass = "blackfnt";
                        BR_loc_slab6.Wrap = false;
                        BR_loc.Cells.Add(BR_loc_slab6);
                        BR_loc.BackColor = System.Drawing.Color.White;
                        Branc_road.Rows.Add(BR_loc);

                    }
                    dr.Close();
                }
            }
        }
        else if (single_slab_yn == "Y")
        {
            Single_slab.Visible = true;
            int total_cnt = 0;
            TableRow Single_Row2 = new TableRow();
            Single_Row2.BorderWidth = 1;
            TableCell Single_ratetype2 = new TableCell();
            string TransMode = "", Tablename = "", matrixtype_desc = "", fromloc = "", toloc = "";
            for (int j = 1; j < 4; j++)
            {
                total_cnt = 0;
                if (j == 1)
                {
                    Tablename = "webx_custcontract_locdet";
                    matrixtype_desc = "Branch";
                    fromloc = "fromlocode";
                    toloc = "tolocode";
                }
                else if (j == 2)
                {
                    Tablename = "webx_custcontract_regdet";
                    matrixtype_desc = "Zone";
                    fromloc = "FromRegion";
                    toloc = "ToRegion";
                }
                else if (j == 3)
                {
                    Tablename = "webx_custcontract_citydet";
                    matrixtype_desc = "City";
                    fromloc = "Fromcity";
                    toloc = "Tocity";
                }

                sqlstr = "SELECT rate_type=(case when rtrim(ltrim(rate_type))='W' then 'Per Kg' when rtrim(ltrim(rate_type))='P' then 'Per Package' else 'unknown' end)," + fromloc + " as fromlocode," + toloc + " as tolocode,air_rate,air_days,road_rate,road_days,train_rate,train_days,express_rate,express_days FROM " + Tablename + " WHERE  contractid='" + contractid + "'";
                cmd = new SqlCommand(sqlstr, con);
                dr = cmd.ExecuteReader();

                TableRow Single_Row1 = new TableRow();
                Single_Row1.BorderWidth = 1;
                TableCell Single_title = new TableCell();

                //if (dr.Read())
                //{
                //    ratetype = dr["rate_type"].ToString();
                //    Single_ratetype2.Text = ratetype.ToString();
                //    Single_ratetype2.CssClass = "blackboldfnt";
                //    Single_ratetype2.Wrap = false;
                //    Single_ratetype2.ColumnSpan = 10;
                //    Single_Row2.BackColor = System.Drawing.Color.White;
                //    Single_ratetype2.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
                //    Single_Row2.Cells.Add(Single_ratetype2);
                //    Single_slab.Rows.Add(Single_Row2);
                //}
                //int cnt_slab = 0;

                TableRow Single_Row_caption = new TableRow();
                Single_Row_caption.BorderWidth = 1;
                //TableCell Single_title = new TableCell();

                TableCell Single_from1 = new TableCell();
                TableCell Single_to1 = new TableCell();

                TableCell Single_air_rate1 = new TableCell();
                TableCell Single_air_days1 = new TableCell();

                TableCell Single_road_rate1 = new TableCell();
                TableCell Single_road_days1 = new TableCell();

                TableCell Single_train_rate1 = new TableCell();
                TableCell Single_train_days1 = new TableCell();

                TableCell Single_express_rate1 = new TableCell();
                TableCell Single_express_days1 = new TableCell();

                Single_from1.Text = "From";
                Single_from1.CssClass = "blackboldfnt";
                Single_from1.Wrap = false;
                Single_Row_caption.Cells.Add(Single_from1);

                Single_to1.Text = "To";
                Single_to1.CssClass = "blackboldfnt";
                Single_to1.Wrap = false;
                Single_Row_caption.Cells.Add(Single_to1);

                int cospn = 4;
                if (lbltransair.Text == "AIR - Yes")
                {
                    Single_air_rate1.Text = "Air Rate";
                    Single_air_rate1.CssClass = "blackboldfnt";
                    Single_air_rate1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_air_rate1);

                    Single_air_days1.Text = "Air Days";
                    Single_air_days1.CssClass = "blackboldfnt";
                    Single_air_days1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_air_days1);
                    cospn = cospn + 2;
                }

                if (lbltransroad.Text == "STANDARD - Yes" || lbltransroad.Text == "ROAD - Yes")
                {
                    Single_road_rate1.Text = "Raod Rate";
                    Single_road_rate1.CssClass = "blackboldfnt";
                    Single_road_rate1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_road_rate1);

                    Single_road_days1.Text = "Road Days";
                    Single_road_days1.CssClass = "blackboldfnt";
                    Single_road_days1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_road_days1);
                    cospn = cospn + 2;
                }
                if (lbltranstrain.Text == "TRAIN - Yes")
                {
                    Single_train_rate1.Text = "Train Rate";
                    Single_train_rate1.CssClass = "blackboldfnt";
                    Single_train_rate1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_train_rate1);

                    Single_train_days1.Text = "Train Days";
                    Single_train_days1.CssClass = "blackboldfnt";
                    Single_train_days1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_train_days1);
                    cospn = cospn + 2;
                }
                if (lbltransexpress.Text == "EXPRESS - Yes")
                {
                    Single_express_rate1.Text = "Express Rate";
                    Single_express_rate1.CssClass = "blackboldfnt";
                    Single_express_rate1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_express_rate1);

                    Single_express_days1.Text = "Express Days";
                    Single_express_days1.CssClass = "blackboldfnt";
                    Single_express_days1.Wrap = false;
                    Single_Row_caption.Cells.Add(Single_express_days1);
                    cospn = cospn + 2;
                }


                //   int ftl_rowadd_cnt=0;
                while (dr.Read())
                {
                    // ftl_rowadd_cnt = ftl_rowadd_cnt + 1;
                    total_cnt = total_cnt + 1;
                    ratetype_id.Visible = true;
                    ratetyp.Text = dr["rate_type"].ToString();
                    ratetyp.CssClass = "blackfnt";
                    // *******************for title ******************";
                    if (total_cnt == 1)
                    {
                        Single_title.Text = matrixtype_desc + " Matrix";
                        Single_title.CssClass = "blackboldfnt";
                        Single_title.Wrap = false;
                        Single_title.ColumnSpan = cospn;
                        Single_Row1.BackColor = System.Drawing.Color.White;
                        Single_Row1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
                        Single_Row1.Cells.Add(Single_title);
                        Single_slab.Rows.Add(Single_Row1);

                        Single_Row_caption.BackColor = System.Drawing.Color.White;
                        Single_slab.Rows.Add(Single_Row_caption);
                    }

                    from_loccode = dr["fromlocode"].ToString();
                    to_loccode = dr["tolocode"].ToString();


                    if (matrixtype_desc == "Zone")
                    {
                        from_loccode = fn.GetRegion_name(from_loccode);
                        to_loccode = fn.GetRegion_name(to_loccode);
                    }


                    air_rate = dr["air_rate"].ToString();
                    air_days = dr["air_days"].ToString();
                    road_rate = dr["road_rate"].ToString();
                    road_days = dr["road_days"].ToString();
                    train_rate = dr["train_rate"].ToString();
                    train_days = dr["train_days"].ToString();
                    express_rate = dr["express_rate"].ToString();
                    express_days = dr["express_days"].ToString();
                    TableRow Single_Row3 = new TableRow();
                    Single_Row3.BorderWidth = 1;
                    TableCell Single_from = new TableCell();
                    TableCell Single_to = new TableCell();

                    TableCell Single_air_rate = new TableCell();
                    TableCell Single_air_days = new TableCell();

                    TableCell Single_road_rate = new TableCell();
                    TableCell Single_road_days = new TableCell();

                    TableCell Single_train_rate = new TableCell();
                    TableCell Single_train_days = new TableCell();

                    TableCell Single_express_rate = new TableCell();
                    TableCell Single_express_days = new TableCell();

                    Single_from.Text = from_loccode.ToString();
                    Single_from.CssClass = "blackfnt";
                    Single_from.Wrap = false;
                    Single_Row3.Cells.Add(Single_from);

                    Single_to.Text = to_loccode.ToString();
                    Single_to.CssClass = "blackfnt";
                    Single_to.Wrap = false;
                    Single_Row3.Cells.Add(Single_to);

                    if (lbltransair.Text == "AIR - Yes")
                    {
                        Single_air_rate.Text = air_rate.ToString();
                        Single_air_rate.CssClass = "blackfnt";
                        Single_air_rate.Wrap = false;
                        Single_Row3.Cells.Add(Single_air_rate);

                        Single_air_days.Text = air_days.ToString();
                        Single_air_days.CssClass = "blackfnt";
                        Single_air_days.Wrap = false;
                        Single_Row3.Cells.Add(Single_air_days);
                    }
                    if (lbltransroad.Text == "STANDARD - Yes" || lbltransroad.Text == "ROAD - Yes")
                    {
                        Single_road_rate.Text = road_rate.ToString();
                        Single_road_rate.CssClass = "blackfnt";
                        Single_road_rate.Wrap = false;
                        Single_Row3.Cells.Add(Single_road_rate);

                        Single_road_days.Text = road_days.ToString();
                        Single_road_days.CssClass = "blackfnt";
                        Single_road_days.Wrap = false;
                        Single_Row3.Cells.Add(Single_road_days);
                    }
                    if (lbltranstrain.Text == "TRAIN - Yes")
                    {
                        Single_train_rate.Text = train_rate.ToString();
                        Single_train_rate.CssClass = "blackfnt";
                        Single_train_rate.Wrap = false;
                        Single_Row3.Cells.Add(Single_train_rate);

                        Single_train_days.Text = train_days.ToString();
                        Single_train_days.CssClass = "blackfnt";
                        Single_train_days.Wrap = false;
                        Single_Row3.Cells.Add(Single_train_days);
                    }
                    if (lbltransexpress.Text == "EXPRESS - Yes")
                    {
                        Single_express_rate.Text = express_rate.ToString();
                        Single_express_rate.CssClass = "blackfnt";
                        Single_express_rate.Wrap = false;
                        Single_Row3.Cells.Add(Single_express_rate);

                        Single_express_days.Text = express_days.ToString();
                        Single_express_days.CssClass = "blackfnt";
                        Single_express_days.Wrap = false;
                        Single_Row3.Cells.Add(Single_express_days);
                    }

                    Single_Row3.BackColor = System.Drawing.Color.White;
                    Single_slab.Rows.Add(Single_Row3);

                }
                dr.Close();
            }
        }

        if (lblloadftl.Text == "FTL - Yes")
        {

            FTL_Hdr.Visible = true;
            Int64 multitotalslab = 0, ftlcount = 0, intResult = 0;
            string ftladdrow = "";
            string TransMode = "", matrixtype = "", matrixtype_desc = "";
            for (int j = 1; j < 4; j++)
            {

                if (j == 1)
                {
                    matrixtype = "L";
                    matrixtype_desc = "Branch";
                }
                else if (j == 2)
                {
                    matrixtype = "R";
                    matrixtype_desc = "Zone";
                }
                else if (j == 3)
                {
                    matrixtype = "C";
                    matrixtype_desc = "City";
                }
                for (int i = 1; i < 5; i++)
                {
                    if (i == 1)
                    {
                        TransMode = "Air";
                    }
                    else if (i == 2)
                    {
                        TransMode = "Road";
                    }
                    else if (i == 3)
                    {
                        TransMode = "Train";
                    }
                    else if (i == 4)
                    {
                        TransMode = "Express";
                    }

                    //**************************************************Start branch Road*************************************************
                    sqlstr = "select ftl_type=(select codedesc from webx_master_general where codetype='FTLTYP' and codeid=a.ftltype),* from webx_custcontract_frtmatrix_ftlslabhdr a where contractid='" + contractid + "'  AND UPPER(trans_type)='" + TransMode + "' AND loc_reg='" + matrixtype + "' order by srno";
                    cmd = new SqlCommand(sqlstr, con);
                    dr = cmd.ExecuteReader();

                    TableRow Ftl_loc1 = new TableRow();
                    Ftl_loc1.BorderWidth = 1;
                    TableCell Ftl_loc_title = new TableCell();
                    TableRow Ftl_loc11 = new TableRow();
                    Ftl_loc11.BorderWidth = 1;
                    TableCell Ftl_loc_title1 = new TableCell();
                    //int cnt_slab = 0;
                    multitotalslab = 0;
                    TableRow Ftl_loc2 = new TableRow();
                    Ftl_loc2.BorderWidth = 1;
                    TableCell Ftl_loc_from2 = new TableCell();
                    TableCell Ftl_loc_to2 = new TableCell();
                    TableCell Ftl_loc_ratetype2 = new TableCell();
                    TableCell Ftl_loc_trdays2 = new TableCell();
                    TableCell Ftl_loc_slab12 = new TableCell();
                    TableCell Ftl_loc_slab22 = new TableCell();
                    TableCell Ftl_loc_slab32 = new TableCell();
                    TableCell Ftl_loc_slab42 = new TableCell();
                    TableCell Ftl_loc_slab52 = new TableCell();
                    TableCell Ftl_loc_slab62 = new TableCell();
                    TableCell Ftl_loc_slab72 = new TableCell();
                    TableCell Ftl_loc_slab82 = new TableCell();

                    Ftl_loc_from2.Text = "From";
                    Ftl_loc_from2.CssClass = "blackboldfnt";
                    Ftl_loc_from2.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_from2);

                    Ftl_loc_to2.Text = "To";
                    Ftl_loc_to2.CssClass = "blackboldfnt";
                    Ftl_loc_to2.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_to2);

                    Ftl_loc_trdays2.Text = "FTL Rate";
                    Ftl_loc_trdays2.CssClass = "blackboldfnt";
                    Ftl_loc_trdays2.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_trdays2);

                    Ftl_loc_ratetype2.Text = "Transit Days";
                    Ftl_loc_ratetype2.CssClass = "blackboldfnt";
                    Ftl_loc_ratetype2.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_ratetype2);

                    Ftl_loc_slab12.Text = "FTL Rate";
                    Ftl_loc_slab12.CssClass = "blackboldfnt";
                    Ftl_loc_slab12.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab12);

                    Ftl_loc_slab22.Text = "Transit Days";
                    Ftl_loc_slab22.CssClass = "blackboldfnt";
                    Ftl_loc_slab22.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab22);

                    Ftl_loc_slab32.Text = "FTL Rate";
                    Ftl_loc_slab32.CssClass = "blackboldfnt";
                    Ftl_loc_slab32.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab32);

                    Ftl_loc_slab42.Text = "Transit Days";
                    Ftl_loc_slab42.CssClass = "blackboldfnt";
                    Ftl_loc_slab42.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab42);

                    Ftl_loc_slab52.Text = "FTL Rate";
                    Ftl_loc_slab52.CssClass = "blackboldfnt";
                    Ftl_loc_slab52.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab52);

                    Ftl_loc_slab62.Text = "Transit Days";
                    Ftl_loc_slab62.CssClass = "blackboldfnt";
                    Ftl_loc_slab62.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab62);

                    Ftl_loc_slab72.Text = "FTL Rate";
                    Ftl_loc_slab72.CssClass = "blackboldfnt";
                    Ftl_loc_slab72.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab72);

                    Ftl_loc_slab82.Text = "Transit Days";
                    Ftl_loc_slab82.CssClass = "blackboldfnt";
                    Ftl_loc_slab82.Wrap = false;
                    Ftl_loc2.Cells.Add(Ftl_loc_slab82);


                    TableRow Ftl_loc3 = null;

                    int ftl_rowadd_cnt = 0;

                    TableRow Ftl_loc = null;
                    while (dr.Read())
                    {
                        ftl_rowadd_cnt = ftl_rowadd_cnt + 1;
                        multitotalslab = multitotalslab + 1;
                        ftlcount = ftlcount + 1;
                        // Branc_road.BackColor = System.Drawing.Color.White;
                        if (ftlcount == 1)
                        {
                            Ftl_loc_title1.Text = "Step 4 :FTL Matrix Detail";
                            Ftl_loc_title1.CssClass = "blackboldfnt";
                            Ftl_loc_title1.Wrap = false;
                            Ftl_loc_title1.ColumnSpan = 12;
                            Ftl_loc11.BackColor = System.Drawing.Color.White;
                            Ftl_loc11.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
                            Ftl_loc11.Cells.Add(Ftl_loc_title1);
                            FTL_Hdr.Rows.Add(Ftl_loc11);
                        }


                        if (multitotalslab == 1)
                        {


                            Ftl_loc_title.Text = "Matrices for " + TransMode + "- Freight Rate " + matrixtype_desc + " Matrix";
                            Ftl_loc_title.CssClass = "blackboldfnt";
                            Ftl_loc_title.Wrap = false;
                            Ftl_loc_title.ColumnSpan = 12;
                            Ftl_loc1.BackColor = System.Drawing.Color.White;
                            Ftl_loc1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
                            Ftl_loc1.Cells.Add(Ftl_loc_title);
                            FTL_Hdr.Rows.Add(Ftl_loc1);

                            Ftl_loc2.BackColor = System.Drawing.Color.White;
                            FTL_Hdr.Rows.Add(Ftl_loc2);
                        }

                        ratetype = dr["ftl_type"].ToString();
                        TableCell Ftl_type = new TableCell();
                        TableCell Ftl_type1 = new TableCell();

                        TableCell Ftl_type2 = new TableCell();

                        if (ftl_rowadd_cnt == 1)
                        {
                            Ftl_loc3 = new TableRow();
                            Ftl_loc3.BorderWidth = 1;
                            Ftl_type1.Text = "";
                            Ftl_type1.CssClass = "blackfnt";
                            Ftl_type1.Wrap = false;
                            Ftl_loc3.Cells.Add(Ftl_type1);

                            Ftl_type2.Text = "";
                            Ftl_type2.CssClass = "blackfnt";
                            Ftl_type2.Wrap = false;
                            Ftl_loc3.Cells.Add(Ftl_type2);
                        }
                        if (ftl_rowadd_cnt < 6)
                        {
                            Ftl_type.Text = ratetype.ToString();
                            Ftl_type.CssClass = "blackfnt";
                            Ftl_type.Wrap = false;
                            Ftl_type.ColumnSpan = 2;
                            Ftl_loc3.Cells.Add(Ftl_type);
                        }
                        if (ftl_rowadd_cnt == 1)
                        {
                            Ftl_loc3.BackColor = System.Drawing.Color.White;
                            FTL_Hdr.Rows.Add(Ftl_loc3);
                        }

                        trans_type = dr["trans_type"].ToString();
                        from_loccode = dr["from_loccode"].ToString();
                        to_loccode = dr["to_loccode"].ToString();


                        if (matrixtype == "R")
                        {
                            from_loccode = fn.GetRegion_name(from_loccode);
                            to_loccode = fn.GetRegion_name(to_loccode);
                        }

                        ftl1_trip_Rate = dr["ftl1_trip_Rate"].ToString();
                        ftl1_trdays = dr["ftl1_trdays"].ToString();




                        TableCell Ftl_loc_from = new TableCell();
                        TableCell Ftl_loc_to = new TableCell();
                        TableCell Ftl_loc_ratetype = new TableCell();
                        TableCell Ftl_loc_trdays = new TableCell();
                        //TableCell Ftl_loc_slab1 = new TableCell();
                        //TableCell Ftl_loc_slab2 = new TableCell();
                        //TableCell Ftl_loc_slab3 = new TableCell();
                        //TableCell Ftl_loc_slab4 = new TableCell();
                        //TableCell Ftl_loc_slab5 = new TableCell();
                        //TableCell Ftl_loc_slab6 = new TableCell();
                        if (multitotalslab < 6)
                        {
                            if (multitotalslab == 1)
                            {
                                intResult = 1;
                            }
                            else
                            {
                                intResult = 0;
                            }
                        }
                        else
                        {
                            System.Math.DivRem(multitotalslab, 5, out intResult);

                        }


                        if (intResult == 1)
                        {
                            Ftl_loc = new TableRow();
                            Ftl_loc.BorderWidth = 1;
                            Ftl_loc_from.Text = from_loccode.ToString();
                            Ftl_loc_from.CssClass = "blackfnt";
                            Ftl_loc_from.Wrap = false;
                            Ftl_loc.Cells.Add(Ftl_loc_from);

                            Ftl_loc_to.Text = to_loccode.ToString();
                            Ftl_loc_to.CssClass = "blackfnt";
                            Ftl_loc_to.Wrap = false;
                            Ftl_loc.Cells.Add(Ftl_loc_to);
                        }
                        Ftl_loc_trdays.Text = ftl1_trip_Rate.ToString();
                        Ftl_loc_trdays.CssClass = "blackfnt";
                        Ftl_loc_trdays.Wrap = false;
                        Ftl_loc.Cells.Add(Ftl_loc_trdays);

                        Ftl_loc_ratetype.Text = ftl1_trdays.ToString();
                        Ftl_loc_ratetype.CssClass = "blackfnt";
                        Ftl_loc_ratetype.Wrap = false;
                        Ftl_loc.Cells.Add(Ftl_loc_ratetype);

                        if (multitotalslab < 5)
                        {
                            intResult = 1;

                        }
                        else
                        {
                            System.Math.DivRem(multitotalslab, 5, out intResult);
                        }
                        if (intResult == 0)
                        {
                            Ftl_loc.BackColor = System.Drawing.Color.White;
                            FTL_Hdr.Rows.Add(Ftl_loc);
                        }

                    }

                    dr.Close();
                }
            }

        }

        if (lbloda.Text == "ODA  Yes")
        {

            OdaHDr.Visible = true;
            ODA_Km.Visible = true;
            Oda_charges.Visible = true;
            sqlstr = " select * from webx_custcontract_odamatrix_slabhdr  WHERE contractid='" + contractid + "' order by slab_code";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();

            TableRow Oda_Slab1 = new TableRow();
            Oda_Slab1.BorderWidth = 1;
            TableRow Oda_Slab_header = new TableRow();
            Oda_Slab_header.BorderWidth = 1;
            TableCell Oda_header1 = new TableCell();
            TableCell Oda_header2 = new TableCell();
            TableCell Oda_header3 = new TableCell();
            TableCell Oda_header4 = new TableCell();
            TableCell Oda_header5 = new TableCell();
            TableCell Oda_header6 = new TableCell();

            Oda_header1.Text = "Slab1";
            Oda_header1.CssClass = "blackboldfnt";
            Oda_header1.Wrap = false;
            Oda_header1.ColumnSpan = 2;
            Oda_header1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            Oda_Slab_header.Cells.Add(Oda_header1);

            Oda_header2.Text = "Slab2";
            Oda_header2.CssClass = "blackboldfnt";
            Oda_header2.Wrap = false;
            Oda_header2.ColumnSpan = 2;
            Oda_header2.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            Oda_Slab_header.Cells.Add(Oda_header2);


            Oda_header3.Text = "Slab3";
            Oda_header3.CssClass = "blackboldfnt";
            Oda_header3.Wrap = false;
            Oda_header3.ColumnSpan = 2;
            Oda_header3.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            Oda_Slab_header.Cells.Add(Oda_header3);

            Oda_header4.Text = "Slab4";
            Oda_header4.CssClass = "blackboldfnt";
            Oda_header4.Wrap = false;
            Oda_header4.ColumnSpan = 2;
            Oda_header4.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            Oda_Slab_header.Cells.Add(Oda_header4);

            Oda_header5.Text = "Slab5";
            Oda_header5.CssClass = "blackboldfnt";
            Oda_header5.Wrap = false;
            Oda_header5.ColumnSpan = 2;
            Oda_header5.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            Oda_Slab_header.Cells.Add(Oda_header5);

            Oda_header6.Text = "Slab6";
            Oda_header6.CssClass = "blackboldfnt";
            Oda_header6.Wrap = false;
            Oda_header6.ColumnSpan = 2;
            Oda_header6.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            Oda_Slab_header.Cells.Add(Oda_header6);
            TableRow Oda_loc11 = new TableRow();
            Oda_loc11.BorderWidth = 1;
            TableCell Oda_loc_title1 = new TableCell();

            TableRow Oda_loc12 = new TableRow();
            Oda_loc12.BorderWidth = 1;
            TableCell Oda_loc_title12 = new TableCell();

            int cnt_slab = 0;
            while (dr.Read())
            {


                cnt_slab = cnt_slab + 1;
                if (cnt_slab == 1)
                {

                    Oda_loc_title1.Text = "Step 5 :ODA Matrix Detail";
                    Oda_loc_title1.CssClass = "blackboldfnt";
                    Oda_loc_title1.Wrap = false;
                    Oda_loc_title1.Style["font-weight"] = "bold";
                    Oda_loc_title1.ColumnSpan = 12;
                    Oda_loc11.BackColor = System.Drawing.Color.White;
                    Oda_loc11.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
                    Oda_loc11.Cells.Add(Oda_loc_title1);

                    OdaHDr.Rows.Add(Oda_loc11);

                    Oda_loc_title12.Text = "Weight / Pckages Slab";
                    Oda_loc_title12.CssClass = "blackboldfnt";
                    Oda_loc_title12.Wrap = false;
                    Oda_loc_title12.Style["font-weight"] = "bold";
                    Oda_loc_title12.ColumnSpan = 12;
                    Oda_loc12.BackColor = System.Drawing.Color.White;
                    Oda_loc12.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
                    Oda_loc12.Cells.Add(Oda_loc_title12);

                    OdaHDr.Rows.Add(Oda_loc12);

                    Oda_Slab_header.BackColor = System.Drawing.Color.White;
                    OdaHDr.Rows.Add(Oda_Slab_header);
                }
                slab_code = dr["slab_code"].ToString();
                slab_from = dr["slab_from"].ToString();
                slab_to = dr["slab_to"].ToString();
                // if (slab_code == "SLAB" + Convert.ToString(cnt_slab))
                //{
                //lblslab1from.Text = slab_from.ToString();
                //lblslab1to.Text = slab_to.ToString();


                TableCell Oda_Slabfrom = new TableCell();
                TableCell Oda_Slabto = new TableCell();
                Oda_Slabfrom.Text = slab_from.ToString();
                Oda_Slabfrom.CssClass = "blackfnt";
                Oda_Slabfrom.Wrap = false;
                Oda_Slab1.Cells.Add(Oda_Slabfrom);
                Oda_Slabto.Text = slab_to.ToString();
                Oda_Slabto.CssClass = "blackfnt";
                Oda_Slabto.Wrap = false;
                Oda_Slab1.Cells.Add(Oda_Slabto);
                Oda_Slab1.BackColor = System.Drawing.Color.White;
                OdaHDr.Rows.Add(Oda_Slab1);
                // }

            }
            dr.Close();

            //************* Oda Km **************************
            sqlstr = " select  * from webx_custcontract_odamatrix_disthdr  WHERE contractid='" + contractid + "' order by ess_code";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();

            TableRow ODA_Km_Slab1 = new TableRow();
            ODA_Km_Slab1.BorderWidth = 1;

            // int cnt_slab = 0;

            TableRow ODA_Km_Slab_header = new TableRow();
            ODA_Km_Slab_header.BorderWidth = 1;
            TableCell ODA_Km_header1 = new TableCell();
            TableCell ODA_Km_header2 = new TableCell();
            TableCell ODA_Km_header3 = new TableCell();
            TableCell ODA_Km_header4 = new TableCell();
            TableCell ODA_Km_header5 = new TableCell();
            TableCell ODA_Km_header6 = new TableCell();

            ODA_Km_header1.Text = "ODA1";
            ODA_Km_header1.CssClass = "blackboldfnt";
            ODA_Km_header1.Wrap = false;
            ODA_Km_header1.ColumnSpan = 2;
            ODA_Km_header1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Km_Slab_header.Cells.Add(ODA_Km_header1);

            ODA_Km_header2.Text = "ODA2";
            ODA_Km_header2.CssClass = "blackboldfnt";
            ODA_Km_header2.Wrap = false;
            ODA_Km_header2.ColumnSpan = 2;
            ODA_Km_header2.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Km_Slab_header.Cells.Add(ODA_Km_header2);


            ODA_Km_header3.Text = "ODA3";
            ODA_Km_header3.CssClass = "blackboldfnt";
            ODA_Km_header3.Wrap = false;
            ODA_Km_header3.ColumnSpan = 2;
            ODA_Km_header3.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Km_Slab_header.Cells.Add(ODA_Km_header3);

            ODA_Km_header4.Text = "ODA4";
            ODA_Km_header4.CssClass = "blackboldfnt";
            ODA_Km_header4.Wrap = false;
            ODA_Km_header4.ColumnSpan = 2;
            ODA_Km_header4.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Km_Slab_header.Cells.Add(ODA_Km_header4);

            ODA_Km_header5.Text = "ODA5";
            ODA_Km_header5.CssClass = "blackboldfnt";
            ODA_Km_header5.Wrap = false;
            ODA_Km_header5.ColumnSpan = 2;
            ODA_Km_header5.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Km_Slab_header.Cells.Add(ODA_Km_header5);

            ODA_Km_header6.Text = "ODA6";
            ODA_Km_header6.CssClass = "blackboldfnt";
            ODA_Km_header6.Wrap = false;
            ODA_Km_header6.ColumnSpan = 2;
            ODA_Km_header6.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Km_Slab_header.Cells.Add(ODA_Km_header6);
            cnt_slab = 0;

            TableRow ODA_Km_title = new TableRow();
            ODA_Km_title.BorderWidth = 1;
            TableCell ODA_Km_tile2 = new TableCell();
            while (dr.Read())
            {

                cnt_slab = cnt_slab + 1;
                if (cnt_slab == 1)
                {

                    ODA_Km_tile2.Text = "ODA DIstance In ODA Km.";
                    ODA_Km_tile2.CssClass = "blackboldfnt";
                    ODA_Km_tile2.Wrap = false;
                    ODA_Km_tile2.Style["font-weight"] = "bold";
                    ODA_Km_tile2.ColumnSpan = 12;
                    ODA_Km_title.BackColor = System.Drawing.Color.White;
                    ODA_Km_title.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
                    ODA_Km_title.Cells.Add(ODA_Km_tile2);

                    ODA_Km.Rows.Add(ODA_Km_title);

                    ODA_Km_Slab_header.BackColor = System.Drawing.Color.White;
                    ODA_Km.Rows.Add(ODA_Km_Slab_header);
                }
                slab_code = dr["ess_code"].ToString();
                slab_from = dr["ESS_from"].ToString();
                slab_to = dr["ESS_to"].ToString();
                // if (slab_code == "SLAB" + Convert.ToString(cnt_slab))
                //{
                //lblslab1from.Text = slab_from.ToString();
                //lblslab1to.Text = slab_to.ToString();
                TableCell ODA_Km_Slabfrom = new TableCell();
                TableCell ODA_Km_Slabto = new TableCell();
                ODA_Km_Slabfrom.Text = slab_from.ToString();
                ODA_Km_Slabfrom.CssClass = "blackfnt";
                ODA_Km_Slabfrom.Wrap = false;
                ODA_Km_Slab1.Cells.Add(ODA_Km_Slabfrom);
                ODA_Km_Slabto.Text = slab_to.ToString();
                ODA_Km_Slabto.CssClass = "blackfnt";
                ODA_Km_Slabto.Wrap = false;
                ODA_Km_Slab1.Cells.Add(ODA_Km_Slabto);
                ODA_Km_Slab1.BackColor = System.Drawing.Color.White;
                ODA_Km.Rows.Add(ODA_Km_Slab1);
                // }

            }
            dr.Close();
            //*******************************************************
            //************* Oda Mtrix **************************
            sqlstr = " select  * from webx_custcontract_odamatrix_charge  WHERE  contractid='" + contractid + "' order by ess_code";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();



            // int cnt_slab = 0;

            TableRow ODA_Chg_Slab_header = new TableRow();
            ODA_Chg_Slab_header.BorderWidth = 1;
            TableCell ODA_Chg_header1 = new TableCell();
            TableCell ODA_Chg_header2 = new TableCell();
            TableCell ODA_Chg_header3 = new TableCell();
            TableCell ODA_Chg_header4 = new TableCell();
            TableCell ODA_Chg_header5 = new TableCell();
            TableCell ODA_Chg_header6 = new TableCell();
            TableCell ODA_Chg_header7 = new TableCell();
            TableCell ODA_Chg_header8 = new TableCell();

            ODA_Chg_header1.Text = "Dist From Del. Location";
            ODA_Chg_header1.CssClass = "blackboldfnt";
            //ODA_Chg_header1.BorderWidth = 1;
            ODA_Chg_header1.Wrap = false;
            // ODA_Chg_header1.ColumnSpan = 2;
            ODA_Chg_header1.Wrap = true;
            ODA_Chg_header1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header1);

            ODA_Chg_header2.Text = "Extra Transit Days";
            ODA_Chg_header2.CssClass = "blackboldfnt";
            //ODA_Chg_header2.BorderWidth = 1;
            ODA_Chg_header2.Wrap = false;
            //ODA_Chg_header2.ColumnSpan = 2;
            ODA_Chg_header2.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header2);


            ODA_Chg_header3.Text = "SLAB1";
            ODA_Chg_header3.CssClass = "blackboldfnt";
            // ODA_Chg_header3.BorderWidth = 1;
            ODA_Chg_header3.Wrap = false;
            // ODA_Chg_header3.ColumnSpan = 2;
            ODA_Chg_header3.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header3);

            ODA_Chg_header4.Text = "SLAB2";
            ODA_Chg_header4.CssClass = "blackboldfnt";
            //ODA_Chg_header4.BorderWidth = 1;
            ODA_Chg_header4.Wrap = false;
            // ODA_Chg_header4.ColumnSpan = 2;
            ODA_Chg_header4.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header4);

            ODA_Chg_header5.Text = "SLAB3";
            ODA_Chg_header5.CssClass = "blackboldfnt";
            //ODA_Chg_header5.BorderWidth = 1;
            ODA_Chg_header5.Wrap = false;
            //ODA_Chg_header5.ColumnSpan = 2;
            ODA_Chg_header5.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header5);

            ODA_Chg_header6.Text = "SLAB4";
            ODA_Chg_header6.CssClass = "blackboldfnt";
            //ODA_Chg_header6.BorderWidth = 1;
            ODA_Chg_header6.Wrap = false;
            // ODA_Chg_header6.ColumnSpan = 2;
            ODA_Chg_header6.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header6);

            ODA_Chg_header7.Text = "SLAB5";
            ODA_Chg_header7.CssClass = "blackboldfnt";
            //ODA_Chg_header7.BorderWidth = 1;
            ODA_Chg_header7.Wrap = false;
            //ODA_Chg_header7.ColumnSpan = 2;
            ODA_Chg_header7.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header7);

            ODA_Chg_header8.Text = "SLAB6";
            ODA_Chg_header8.CssClass = "blackboldfnt";
            //ODA_Chg_header8.BorderWidth = 1;
            ODA_Chg_header8.Wrap = false;
            //ODA_Chg_header8.ColumnSpan = 2;
            ODA_Chg_header8.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            ODA_Chg_Slab_header.Cells.Add(ODA_Chg_header8);
            cnt_slab = 0;
            TableRow ODA_Chg_title = new TableRow();
            ODA_Chg_title.BorderWidth = 1;
            TableCell ODA_Chg_title1 = new TableCell();
            while (dr.Read())
            {
                TableRow ODA_Chg_Slab1 = new TableRow();
                ODA_Chg_Slab1.BorderWidth = 1;
                cnt_slab = cnt_slab + 1;
                if (cnt_slab == 1)
                {
                    ODA_Chg_title1.Text = "ODA Charges Matrix";
                    ODA_Chg_title1.CssClass = "blackboldfnt";
                    ODA_Chg_title1.Wrap = false;
                    ODA_Chg_title1.Style["font-weight"] = "bold";
                    ODA_Chg_title1.ColumnSpan = 12;
                    ODA_Chg_title.BackColor = System.Drawing.Color.White;
                    ODA_Chg_title.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
                    ODA_Chg_title.Cells.Add(ODA_Chg_title1);

                    Oda_charges.Rows.Add(ODA_Chg_title);

                    ODA_Chg_Slab_header.BackColor = System.Drawing.Color.White;
                    Oda_charges.Rows.Add(ODA_Chg_Slab_header);
                }
                slab_code = dr["ess_code"].ToString();
                trdays = dr["trdays"].ToString();
                slab1 = dr["slab1"].ToString();
                slab2 = dr["slab2"].ToString();
                slab3 = dr["slab3"].ToString();
                slab4 = dr["slab4"].ToString();
                slab5 = dr["slab5"].ToString();
                slab6 = dr["slab6"].ToString();

                TableCell ODA_Chg_ESS = new TableCell();
                TableCell ODA_Chg_Trdays = new TableCell();
                TableCell ODA_Chg_Oda1 = new TableCell();
                TableCell ODA_Chg_Oda2 = new TableCell();
                TableCell ODA_Chg_Oda3 = new TableCell();
                TableCell ODA_Chg_Oda4 = new TableCell();
                TableCell ODA_Chg_Oda5 = new TableCell();
                TableCell ODA_Chg_Oda6 = new TableCell();

                ODA_Chg_ESS.Text = slab_code.ToString();
                //ODA_Chg_ESS.BorderWidth = 1;
                ODA_Chg_ESS.CssClass = "blackfnt";
                ODA_Chg_ESS.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_ESS);

                ODA_Chg_Trdays.Text = trdays.ToString();
                //ODA_Chg_Trdays.BorderWidth = 1;
                ODA_Chg_Trdays.CssClass = "blackfnt";
                ODA_Chg_Trdays.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Trdays);

                ODA_Chg_Oda1.Text = slab1.ToString();
                //ODA_Chg_Oda1.BorderWidth = 1;
                ODA_Chg_Oda1.CssClass = "blackfnt";
                ODA_Chg_Oda1.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Oda1);

                ODA_Chg_Oda2.Text = slab2.ToString();
                //ODA_Chg_Oda2.BorderWidth = 1;
                ODA_Chg_Oda2.CssClass = "blackfnt";
                ODA_Chg_Oda2.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Oda2);

                ODA_Chg_Oda3.Text = slab3.ToString();
                //ODA_Chg_Oda3.BorderWidth = 1;
                ODA_Chg_Oda3.CssClass = "blackfnt";
                ODA_Chg_Oda3.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Oda3);

                ODA_Chg_Oda4.Text = slab4.ToString();
                //ODA_Chg_Oda4.BorderWidth = 1;
                ODA_Chg_Oda4.CssClass = "blackfnt";
                ODA_Chg_Oda4.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Oda4);

                ODA_Chg_Oda5.Text = slab5.ToString();
                //ODA_Chg_Oda5.BorderWidth = 1;
                ODA_Chg_Oda5.CssClass = "blackfnt";
                ODA_Chg_Oda5.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Oda5);

                ODA_Chg_Oda6.Text = slab6.ToString();
                // ODA_Chg_Oda6.BorderWidth = 1;
                ODA_Chg_Oda6.CssClass = "blackfnt";
                ODA_Chg_Oda6.Wrap = false;
                ODA_Chg_Slab1.Cells.Add(ODA_Chg_Oda6);

                ODA_Chg_Slab1.BackColor = System.Drawing.Color.White;
                Oda_charges.Rows.Add(ODA_Chg_Slab1);
            }
            dr.Close();
            //*******************************************************
        }
    }


    protected void lnkBtnXLS_Click(object sender, EventArgs e)
    {
        DownloadXLS();
    }
    protected void btnXLS_Click(object sender, EventArgs e)
    {
        DownloadXLS();
    }
    public void DownloadXLS()
    {
        //tblHeadXLS.Visible = false;
        //tblBtnXls.Visible = false;
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Customer_Contract_" + contractid + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(pnlMain);
        //frm.Controls.Add(tblheader);

        //frm.Controls.Add(tbldetail);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

}

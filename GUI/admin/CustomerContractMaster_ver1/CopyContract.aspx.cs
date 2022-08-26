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

public partial class GUI_admin_CustomerContractMaster_CopyContract : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString());
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired. LogOn Again&reason1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        con.Open();

        if (!IsPostBack)
        {
            imgtick.Style["display"] = "none";
            hdnpaybas.Value = Request.QueryString["paybas"].ToString().ToUpper();

            hdnstartdate.Value = Request.QueryString["startdate"].ToString();
            hdnenddate.Value = Request.QueryString["enddate"].ToString();

            string strpaybasname = "";
            switch (hdnpaybas.Value)
            {
                case "P01":
                    strpaybasname = "PAID";
                    break;
                case "P02":
                    strpaybasname = "TBB";
                    break;
                case "P03":
                    strpaybasname = "TOPAY";
                    break;
            }

            lblcontractid.Text = getContractID();
            lblcustname.Text = Request.QueryString["custcode"].ToString() + "  :  " + fn.Getcustomer(Request.QueryString["custcode"].ToString());
            lblcustname.Text = lblcustname.Text + "  :  " + strpaybasname;
        }

    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        btnsubmit.Style["display"] = "none";


        if (txtcontractid.Text.CompareTo("") == 0)
        {
            if (addContract())
            {
                Response.Redirect("CCM_DisplayResult.aspx?contractid=" + lblcontractid.Text.Trim() + "&custcode=" + Request.QueryString["custcode"].ToString() + "&CCMMode=E");
                return;
            }
        }
        else
        {
            if (copyContract())
            {
                Response.Redirect("CCM_DisplayResult.aspx?contractid=" + lblcontractid.Text.Trim() + "&custcode=" + Request.QueryString["custcode"].ToString() + "&CCMMode=E");
                return;
            }
            else
            {
              //  Response.Redirect("ErrorPage.aspx?heading=Updation Error in Copy Contract.");
                return;
            }
        }


        txtcontractid.Enabled = false;
        imgpopup.Style["display"] = "none";
        lblmessage.Style["display"] = "block";
    }



    private string getContractID()
    {
        string sql = "SELECT contractid FROM webx_custcontract_hdr";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        string oldcnid = "";
        int ab = 0;
        int greatno = 0;
        while (dr.Read())
        {
            oldcnid = dr["contractid"].ToString();
            if (oldcnid.Length <= 3)
                continue;
            oldcnid = oldcnid.Substring(2, oldcnid.Length - 2);

            ab = Convert.ToInt16(oldcnid);
            if (greatno < ab)
            {
                greatno = ab;
            }

        }
        dr.Close();

        greatno = greatno + 1;
        string newcnid = "CN" + greatno.ToString().PadLeft(10, '0');

        return newcnid;
    }


    protected bool addContract()
    {
        SqlTransaction trn = con.BeginTransaction();
        string sqlstr = "";
        try
        {
            SqlCommand cmd;
            sqlstr = "INSERT INTO webx_custcontract_hdr";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "Contract_Stdate,Contract_Effectdate,Contract_Eddate,activeflag)";
            sqlstr = sqlstr + " VALUES('" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "','" + fn.Mydate1(hdnstartdate.Value) + "',";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnstartdate.Value) + "',";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnenddate.Value) + "','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            trn.Rollback();
            lblmessage.Text = ex.Message + "\n-->" + sqlstr;
            return false;
        }

        trn.Commit();
        return true;

    }


    protected bool copyContract()
    {
        string sqlstr = "";
        sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE contractid='" + txtcontractid.Text + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        string contractid = Convert.ToString(cmd.ExecuteScalar());
        if (contractid.CompareTo("") == 0)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=Contract Doesn't Exist.Improper Contract Selection.");
            return false;
        }


        SqlTransaction trn = con.BeginTransaction();

        try
        {
            sqlstr = "INSERT INTO webx_custcontract_hdr";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "custcat,contractcat,Contract_Stdate,Contract_Effectdate,Contract_Eddate,Cust_represent,";
            sqlstr = sqlstr + "Comp_Empname,CustDesig,Comp_Desig,CustWitness,Comp_Witness,Bill_address,Bill_city,Bill_pin,";
            sqlstr = sqlstr + "Entryby,Entrydt,single_slab_yn,multiple_slab_yn,contract_sign_loccode,dktchg,fovchg,";
            sqlstr = sqlstr + "stax_yn,acc_rep,add_contract_loccode,paytype,stax_paidby,SKU_YN,commitedbusiness,";
            sqlstr = sqlstr + "remarks,contractmode,lasteditby,lasteditdate,accperemail,accperphone,custaccperson,custemail,";
            sqlstr = sqlstr + "custphone,compphone,compemail,csename,csephone,cseemail,activeflag)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "custcat,contractcat,";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnstartdate.Value) + "',";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnstartdate.Value) + "',";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnenddate.Value) + "',";
            sqlstr = sqlstr + "Cust_represent,Comp_Empname,CustDesig,Comp_Desig,CustWitness,Comp_Witness,Bill_address,Bill_city,Bill_pin,";
            sqlstr = sqlstr + "Entryby,Entrydt,single_slab_yn,multiple_slab_yn,contract_sign_loccode,dktchg,fovchg,";
            sqlstr = sqlstr + "stax_yn,acc_rep,add_contract_loccode,paytype,stax_paidby,SKU_YN,commitedbusiness,";
            sqlstr = sqlstr + "remarks,contractmode,lasteditby,lasteditdate,accperemail,accperphone,custaccperson,custemail,";
            sqlstr = sqlstr + "custphone,compphone,compemail,csename,csephone,cseemail,activeflag";
            sqlstr = sqlstr + " FROM webx_custcontract_hdr WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "INSERT INTO webx_custcontract_charge";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "road_yn,express_yn,air_yn,rail_yn,ftl_yn,sundry_yn,pkp_dly,";
            sqlstr = sqlstr + "dp_chrg,dd_chrg,dkt_chrg,hld_chrg,fov_type,fov_chrg,cod_dod_yn,oda_yn,vol_yn,";
            sqlstr = sqlstr + "dacc_yn,cod_chrg_rs,cod_chrg_per,dacc_chrg_rs,dacc_chrg_per,dem_day,cft2kg,dem_chrg_rs,";
            sqlstr = sqlstr + "dem_chrg_perkg,oct_chrg,nform_chrg,state_chrg,hld_dlychrg,billgen_loccode,bill_inst,";
            sqlstr = sqlstr + "billsub_loccode,credit_limit,billcol_loccode,credit_day,bill_freq,diesel_hike_yn,";
            sqlstr = sqlstr + "max_invval,max_invval_kg,warehoue_yn,air_rate,air_bas,road_rate,road_bas,exp_rate,";
            sqlstr = sqlstr + "exp_bas,rail_rate,rail_bas,spl_inst,inst_show_yn,tbb_yn,topay_yn,paid_yn,insu_per,";
            sqlstr = sqlstr + "cft_measure,dem_minfrt,mathadi_chrg,fod_chrg,st_chrg,risk_chrg,dp_chrg_perkg,";
            sqlstr = sqlstr + "dd_chrg_perkg,Hamali_chrg,OTCHG,surcharge,DC_DD_chrg,STSRE_chrg,oda_chrg,fuelchrg,";
            sqlstr = sqlstr + "User_chrg_1,User_chrg_2,User_chrg_3,User_chrg_4,User_chrg_5,sku_yn,User_chrg_6,";
            sqlstr = sqlstr + "User_chrg_7,User_chrg_8,User_chrg_9,User_chrg_10,FODCharge,fov_chrg_owner,";
            sqlstr = sqlstr + "fov_chrg_carrier,lasteditby,lasteditdate,flatmultipickup_yn,flatmultidelivery_yn,flatloading_yn,";
            sqlstr = sqlstr + "flatunloading_yn,locloading_yn,locunloading_yn,";
            sqlstr = sqlstr + "air_fuelsurchrg,road_fuelsurchrg,";
            sqlstr = sqlstr + "train_fuelsurchrg,express_fuelsurchrg,min_fuelsurchrgair,max_fuelsurchrgair,";
            sqlstr = sqlstr + "fuelsurchrgbasair,min_fuelsurchrgroad,max_fuelsurchrgroad,fuelsurchrgbasroad,";
            sqlstr = sqlstr + "min_fuelsurchrgtrain,max_fuelsurchrgtrain,fuelsurchrgbastrain,min_fuelsurchrgexpress,";
            sqlstr = sqlstr + "max_fuelsurchrgexpress,fuelsurchrgbasexpress,oct_sur_yn,min_oct_sur,max_oct_sur,";
            sqlstr = sqlstr + "rate_oct_sur,oct_sur_bas,locmultipickup_yn,locmultidelivery_yn,";
            sqlstr = sqlstr + "min_air_subtotal,min_road_subtotal,min_train_subtotal,";
            sqlstr = sqlstr + "min_express_subtotal)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "road_yn,express_yn,air_yn,rail_yn,ftl_yn,sundry_yn,pkp_dly,dp_chrg,";
            sqlstr = sqlstr + "dd_chrg,dkt_chrg,hld_chrg,fov_type,fov_chrg,cod_dod_yn,oda_yn,vol_yn,dacc_yn,cod_chrg_rs,cod_chrg_per,";
            sqlstr = sqlstr + "dacc_chrg_rs,dacc_chrg_per,dem_day,cft2kg,dem_chrg_rs,dem_chrg_perkg,oct_chrg,nform_chrg,state_chrg,";
            sqlstr = sqlstr + "hld_dlychrg,billgen_loccode,bill_inst,billsub_loccode,credit_limit,billcol_loccode,credit_day,bill_freq,";
            sqlstr = sqlstr + "diesel_hike_yn,max_invval,max_invval_kg,warehoue_yn,air_rate,air_bas,road_rate,road_bas,exp_rate,exp_bas,";
            sqlstr = sqlstr + "rail_rate,rail_bas,spl_inst,inst_show_yn,tbb_yn,topay_yn,paid_yn,insu_per,cft_measure,dem_minfrt,mathadi_chrg,";
            sqlstr = sqlstr + "fod_chrg,st_chrg,risk_chrg,dp_chrg_perkg,dd_chrg_perkg,Hamali_chrg,OTCHG,surcharge,DC_DD_chrg,STSRE_chrg,oda_chrg,";
            sqlstr = sqlstr + "fuelchrg,User_chrg_1,User_chrg_2,User_chrg_3,User_chrg_4,User_chrg_5,sku_yn,User_chrg_6,User_chrg_7,User_chrg_8,";
            sqlstr = sqlstr + "User_chrg_9,User_chrg_10,FODCharge,fov_chrg_owner,fov_chrg_carrier,lasteditby,lasteditdate,flatmultipickup_yn,flatmultidelivery_yn,";
            sqlstr = sqlstr + "flatloading_yn,flatunloading_yn,locloading_yn,locunloading_yn,";
            sqlstr = sqlstr + "air_fuelsurchrg,road_fuelsurchrg,train_fuelsurchrg,express_fuelsurchrg,min_fuelsurchrgair,";
            sqlstr = sqlstr + "max_fuelsurchrgair,fuelsurchrgbasair,min_fuelsurchrgroad,max_fuelsurchrgroad,fuelsurchrgbasroad,";
            sqlstr = sqlstr + "min_fuelsurchrgtrain,max_fuelsurchrgtrain,fuelsurchrgbastrain,min_fuelsurchrgexpress,max_fuelsurchrgexpress,";
            sqlstr = sqlstr + "fuelsurchrgbasexpress,oct_sur_yn,min_oct_sur,max_oct_sur,rate_oct_sur,oct_sur_bas,locmultipickup_yn,";
            sqlstr = sqlstr + "locmultidelivery_yn,min_air_subtotal,min_road_subtotal,min_train_subtotal,";
            sqlstr = sqlstr + "min_express_subtotal";
            sqlstr = sqlstr + " FROM webx_custcontract_charge WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            // SINGLE SLAB SUNDRY COPYING STARTS HERE
            sqlstr = "INSERT INTO webx_custcontract_citydet";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "Fromcity,Tocity,Air_rate,Train_rate,Express_rate,Road_rate,rate_type,";
            sqlstr = sqlstr + " reverse_rate,Air_days,Train_days,Express_days,Road_days)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "Fromcity,Tocity,Air_rate,Train_rate,Express_rate,Road_rate,rate_type,";
            sqlstr = sqlstr + " reverse_rate,Air_days,Train_days,Express_days,Road_days";
            sqlstr = sqlstr + " FROM webx_custcontract_citydet WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_locdet ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "FromLocode,ToLocode,Air_rate,Train_rate,Express_rate,Road_rate,rate_type,";
            sqlstr = sqlstr + " reverse_rate,Air_days,Train_days,Express_days,Road_days)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "FromLocode,ToLocode,Air_rate,Train_rate,Express_rate,Road_rate,rate_type,";
            sqlstr = sqlstr + " reverse_rate,Air_days,Train_days,Express_days,Road_days";
            sqlstr = sqlstr + " FROM webx_custcontract_locdet WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_regdet ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "FromRegion,ToRegion,Air_rate,Train_rate,Express_rate,Road_rate,rate_type,";
            sqlstr = sqlstr + " reverse_rate,Air_days,Train_days,Express_days,Road_days)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "FromRegion,ToRegion,Air_rate,Train_rate,Express_rate,Road_rate,rate_type,";
            sqlstr = sqlstr + " reverse_rate,Air_days,Train_days,Express_days,Road_days";
            sqlstr = sqlstr + " FROM webx_custcontract_regdet WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            // SINGLE SLAB SUNDRY COPYING ENDS HERE


            // MULTI SLAB SUNDRY COPYING STARTS HERE
            sqlstr = "INSERT INTO webx_custcontract_frtmatrix_slabhdr ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "trans_type,matrix_type,slab_code,slab_from,slab_to)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "trans_type,matrix_type,slab_code,slab_from,slab_to";
            sqlstr = sqlstr + " FROM webx_custcontract_frtmatrix_slabhdr WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_frtmatrix_slabdet ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "RateType,trans_type,from_loccode,to_loccode,destcode,trdays,slab1,";
            sqlstr = sqlstr + "slab2,slab3,slab4,slab5,slab6,LOC_REG,reverse_rate)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "RateType,trans_type,from_loccode,to_loccode,destcode,trdays,slab1,";
            sqlstr = sqlstr + "slab2,slab3,slab4,slab5,slab6,LOC_REG,reverse_rate";
            sqlstr = sqlstr + " FROM webx_custcontract_frtmatrix_slabdet WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            // MULTI SLAB SUNDRY COPYING ENDS HERE


            // FTL COPYING STARTS HERE
            sqlstr = "INSERT INTO webx_custcontract_frtmatrix_ftlslabhdr ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "Pickup_loc,ServiceType,PayType,comp_loc,bkg_type,from_loccode,to_loccode,destcode,";
            sqlstr = sqlstr + "FTL1_TRIP_RATE,FTL1_TRDAYS,FTL2_TRIP_RATE,FTL2_TRDAYS,FTL3_TRIP_RATE,FTL3_TRDAYS,";
            sqlstr = sqlstr + "FTL4_TRIP_RATE,FTL4_TRDAYS,FTL5_TRIP_RATE,FTL5_TRDAYS,FTL6_TRIP_RATE,FTL6_TRDAYS,";
            sqlstr = sqlstr + "FTL7_TRIP_RATE,FTL7_TRDAYS,FTL8_TRIP_RATE,FTL8_TRDAYS,FTL9_TRIP_RATE,FTL9_TRDAYS,";
            sqlstr = sqlstr + "FTL10_TRIP_RATE,FTL10_TRDAYS,trans_type,LOC_REG,ftltype)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "Pickup_loc,ServiceType,PayType,comp_loc,bkg_type,from_loccode,to_loccode,destcode,";
            sqlstr = sqlstr + "FTL1_TRIP_RATE,FTL1_TRDAYS,FTL2_TRIP_RATE,FTL2_TRDAYS,FTL3_TRIP_RATE,FTL3_TRDAYS,";
            sqlstr = sqlstr + "FTL4_TRIP_RATE,FTL4_TRDAYS,FTL5_TRIP_RATE,FTL5_TRDAYS,FTL6_TRIP_RATE,FTL6_TRDAYS,";
            sqlstr = sqlstr + "FTL7_TRIP_RATE,FTL7_TRDAYS,FTL8_TRIP_RATE,FTL8_TRDAYS,FTL9_TRIP_RATE,FTL9_TRDAYS,";
            sqlstr = sqlstr + "FTL10_TRIP_RATE,FTL10_TRDAYS,trans_type,LOC_REG,ftltype";
            sqlstr = sqlstr + " FROM webx_custcontract_frtmatrix_ftlslabhdr WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            // FTL COPYING ENDS HERE


            //ODA MATRICES COPYING STARTS HERE
            sqlstr = "INSERT INTO webx_custcontract_odamatrix_charge ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "ESS_code,trdays,slab1,slab2,slab3,slab4,slab5,slab6)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "ESS_code,trdays,slab1,slab2,slab3,slab4,slab5,slab6";
            sqlstr = sqlstr + " FROM webx_custcontract_odamatrix_charge WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "INSERT INTO webx_custcontract_odamatrix_disthdr ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "matrix_type,MIN_ODACHRG,ESS_code,ESS_from,ESS_to)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "matrix_type,MIN_ODACHRG,ESS_code,ESS_from,ESS_to";
            sqlstr = sqlstr + " FROM webx_custcontract_odamatrix_disthdr WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "INSERT INTO webx_custcontract_odamatrix_slabhdr ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "matrix_type,slab_code,slab_from,slab_to)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "matrix_type,slab_code,slab_from,slab_to";
            sqlstr = sqlstr + " FROM webx_custcontract_odamatrix_slabhdr WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            //ODA MATRICES COPYING ENDS HERE


            // AGILITY CHANGES
            sqlstr = "INSERT INTO webx_custcontract_loadingcharges ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "loctype,location,service_class,ftltype,ratetype,airrate,roadrate,trainrate,expressrate)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "loctype,location,service_class,ftltype,ratetype,airrate,roadrate,trainrate,expressrate";
            sqlstr = sqlstr + " FROM webx_custcontract_loadingcharges WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_unloadingcharges ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "loctype,location,service_class,ftltype,ratetype,airrate,roadrate,trainrate,expressrate)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "loctype,location,service_class,ftltype,ratetype,airrate,roadrate,trainrate,expressrate";
            sqlstr = sqlstr + " FROM webx_custcontract_unloadingcharges WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_multipointcharges ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "from_loc,to_loc,ftltype,pickup_chrg,delivery_chrg)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "from_loc,to_loc,ftltype,pickup_chrg,delivery_chrg";
            sqlstr = sqlstr + " FROM webx_custcontract_multipointcharges WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_flatloading ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "service_class,ftltype,ratetype,rate)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "service_class,ftltype,ratetype,rate";
            sqlstr = sqlstr + " FROM webx_custcontract_flatloading WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_flatunloading ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "service_class,ftltype,ratetype,rate)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "service_class,ftltype,ratetype,rate";
            sqlstr = sqlstr + " FROM webx_custcontract_flatunloading WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "INSERT INTO webx_custcontract_flatmultipoint ";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "service_class,ftltype,ratetype,pickup,delivery)";
            sqlstr = sqlstr + " SELECT '" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "',";
            sqlstr = sqlstr + "service_class,ftltype,ratetype,pickup,delivery";
            sqlstr = sqlstr + " FROM webx_custcontract_flatmultipoint WHERE contractid='" + txtcontractid.Text.Trim() + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            // AGILITY CHANGES

        }
        catch (Exception ex)
        {
            trn.Rollback();
            lblmessage.Text = ex.Message + "\n-->" + sqlstr;
            lblmessage.Style["display"] = "block";
            return false;
        }

        trn.Commit();
        return true;
    }



}

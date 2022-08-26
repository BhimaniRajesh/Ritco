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
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operation_Singlescreen_DocketPrint_DocketView_xls : System.Web.UI.Page
{
    protected string sdkt_call = "";

    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string remark = "", dockno = "", printyn = "", dest = "", docksf = "";
        string boxbg = "boxbg", bgbluegrey = "bgbluegrey", blackfnt = "bluefnt";
        string csgncd = "", csgecd = "";
        string service_class = "", businesstype = "";


        dockno = Request.QueryString["dockno"].ToString();
        docksf = Request.QueryString["docksf"].ToString();
        sdkt_call = "Docket";

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
        con.Open();
        DocketServiceTax dst = new DocketServiceTax();
       string sqlstr = "SELECT convert(varchar,dockdt,106) AS docketdate,convert(varchar,dockdt,103) AS dockddateddmmyyyy,orgncd AS orgnloc,destcd AS delloc,party_code AS partycode,";
        sqlstr = sqlstr + "paymentbasis=(SELECT codedesc FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=paybas),paybas,";
        sqlstr = sqlstr + "service_class,businesstype,servicetype=(SELECT codedesc FROM webx_master_general WHERE codetype='SVCTYP' AND codeid=service_class),";
        sqlstr = sqlstr + "ftltype=(SELECT codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND codeid=ftl_types),";
        sqlstr = sqlstr + "transmode=(SELECT codedesc FROM webx_master_general WHERE codetype='TRN' AND codeid=trn_mod),trn_mod,";
        
        sqlstr = sqlstr + "cft_yn AS flag_volumetric,localcn_yn AS flag_local,dacc_yn AS flag_dacc,cod_dod as flag_coddod,";
        sqlstr = sqlstr + "pickup_dely AS pickupdel,convert(varchar,dockdt_entry,106) AS entrydate,from_loc as fromcity,to_loc as tocity,";
        sqlstr = sqlstr + "convert(varchar,cdeldt,106) AS edd,";
        sqlstr = sqlstr + "csgncd,csgnnm,csgnaddr,csgncity,csgnpincode,csgnteleno,csgnemail,";
        sqlstr = sqlstr + "csgecd,csgenm,csgeaddr,csgecity,csgepincode,csgeteleno,csgeemail,";
        sqlstr = sqlstr + "permit_yn AS flag_permit,permit_recvd_at,permit_no AS permitno,permitdt AS permitdate,";
        sqlstr = sqlstr + "permit_validity_dt,permit_recvd_dt,fincmplbr AS billedat,pkgsno AS noofpkgs,actuwt AS actualweight,";
        sqlstr = sqlstr + "producttype=(CASE WHEN PROD_CNT=0 THEN 'OTHERS'+'-'+prodcd ELSE (SELECT codedesc FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd) END),";
        sqlstr = sqlstr + "chrgwt AS chargedweight,spl_svc_req AS remarks,";
        sqlstr = sqlstr + "stax_paidby AS staxpaidby,stax_regno AS staxregno,";
        sqlstr = sqlstr + "risktype=(CASE ltrim(rtrim(insuyn)) WHEN 'O' THEN 'Owner Risk' WHEN 'C' THEN 'Carrier Risk' END) ,";
        sqlstr = sqlstr + "insuyn AS flag_policy,convert(varchar,insupldt,106) AS policydate,insupl as policyno,";
        sqlstr = sqlstr + "tot_covers,tot_modvat,tot_covers,ctr_no AS custrefno,";
        sqlstr = sqlstr + "packtype=(SELECT codedesc FROM webx_master_general WHERE codetype='PKGS' AND codeid=pkgsty),";
        sqlstr = sqlstr + "privatemark,tpnumber,entryby,reassign_destcd AS reassigndelloc,convert(varchar,lasteditDate,106) AS lasteditDate,LastEditBy,";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + "codamt";
        sqlstr = sqlstr + " FROM webx_master_docket"; 
        sqlstr = sqlstr + " CROSS APPLY ( SELECT Count(codeid) PROD_CNT FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd )prodname_Cnt";
        sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND docksf='" + docksf + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        string consignee = "", consignor = "", cft_yn = "";
        while (dr.Read())
        {
            dest = dr["delloc"].ToString();
            lbldockno.Text = dockno;
            lblpaybas.Text = dr["paymentbasis"].ToString();
            lblorgnloc.Text = dr["orgnloc"].ToString();
            lbldocketdate.Text = dr["docketdate"].ToString();
          
            service_class = dr["service_class"].ToString();
            businesstype = dr["businesstype"].ToString();

            lbldelloc.Text = dr["delloc"].ToString();
            lblreassigndelloc.Text = dr["reassigndelloc"].ToString();
            cft_yn = dr["flag_volumetric"].ToString();
            lblvolumetric.Text = dr["flag_volumetric"].ToString();
            lblservicetype.Text = dr["servicetype"].ToString();
            lblftltype.Text = dr["ftltype"].ToString();

            if (dr["pickupdel"].ToString().Trim().CompareTo("1") == 0)
            {
                lblpickupdel.Text = "Godown Pickup - Godown Delivery";
            }
            else if (dr["pickupdel"].ToString().Trim().CompareTo("2") == 0)
            {
                lblpickupdel.Text = "Godown Pickup - Door Delivery";
            }
            else if (dr["pickupdel"].ToString().Trim().CompareTo("3") == 0)
            {
                lblpickupdel.Text = "Door Pickup - GoDown Delivery";
            }
            else if (dr["pickupdel"].ToString().Trim().CompareTo("4") == 0)
            {
                lblpickupdel.Text = "Door Pickup - Door Delivery";
            }


            lbldocketentrydate.Text = dr["entrydate"].ToString();
            lblfromcity.Text = dr["fromcity"].ToString();
            lbllocaldocket.Text = dr["flag_local"].ToString();
            lbledd.Text = dr["edd"].ToString();
            lbltocity.Text = dr["tocity"].ToString();


            if (Convert.ToString(dr["csgecd"]).CompareTo("8888") == 0)
            {
                lblneename.Text = "8888 :" + dr["csgenm"].ToString();
            }
            else
            {
                lblneename.Text = Convert.ToString(dr["csgecd"]) + " : " + fn.Getcustomer(Convert.ToString(dr["csgecd"]));
                csgecd = Convert.ToString(dr["csgecd"]);
            }
            lblneeadd.Text = dr["csgeaddr"].ToString();
            lblneepincode.Text = dr["csgecity"].ToString() + " : " + dr["csgepincode"].ToString();
            lblneetel.Text = dr["csgeteleno"].ToString();
            lblneeemail.Text = dr["csgeemail"].ToString();

            if (Convert.ToString(dr["csgncd"]).CompareTo("8888") == 0)
            {
                lblnorname.Text = "8888 :" + dr["csgnnm"].ToString();
            }
            else
            {
                lblnorname.Text = Convert.ToString(dr["csgncd"]) + " : " + fn.Getcustomer(Convert.ToString(dr["csgncd"]));
                csgncd = Convert.ToString(dr["csgncd"]);
            }

            lblnoradd.Text = dr["csgnaddr"].ToString();
            lblnorpincode.Text = dr["csgncity"].ToString() + " : " + dr["csgnpincode"].ToString();
            lblnortel.Text = dr["csgnteleno"].ToString();
            lblnoremail.Text = dr["csgnemail"].ToString();

            lblbillingparty.Text = dr["partycode"].ToString() + " : " + fn.Getcustomer(Convert.ToString(dr["partycode"]));

            lbltransmode.Text = dr["transmode"].ToString();
            hdnTransMode.Value = dr["trn_mod"].ToString();
            lblrisktype.Text = Convert.ToString(dr["risktype"]);

            lblpolicyno.Text = dr["policyno"].ToString();
            lblpolicydate.Text = dr["policydate"].ToString();
            if (dr["tot_covers"].ToString().CompareTo("Y") == 0)
                lblmodvatenclosed.Text = "Yes";
            else
                lblmodvatenclosed.Text = "No";
            lblpackagingtype.Text = dr["packtype"].ToString();
            lblinternalcovers.Text = dr["tot_modvat"].ToString();
            lblmodvatcovers.Text = dr["tot_covers"].ToString();
            lblcustomerreferenceno.Text = dr["custrefno"].ToString();
            lblprivatemark.Text = dr["privatemark"].ToString();
            lbltpno.Text = dr["tpnumber"].ToString();

            /***************************************************************************************************************
                                            PERMIT TRACKER
            ***************************************************************************************************************/

            lblpermitapplicable.Text = dr["flag_permit"].ToString();
            lblpermitrecievedat.Text = dr["permit_recvd_at"].ToString();
            lblpermitno.Text = dr["permitno"].ToString();
            lblpermitdate.Text = dr["permitdate"].ToString();
            lblpermitvaliditydate.Text = dr["permit_validity_dt"].ToString();
            lblpermitrecieveddate.Text = dr["permit_recvd_dt"].ToString();
            lblbilledat.Text = dr["billedat"].ToString();

            /***************************************************************************************************************
                                                CONSIGNMENT DETAILS
            ***************************************************************************************************************/

            lbltotalnoofpack.Text = Convert.ToString(Math.Round(returnDouble(dr["noofpkgs"].ToString())));
            lbltotalactualweight.Text = returnDouble(Convert.ToString(dr["actualweight"])).ToString("F2");
            lblsaytocontain.Text = dr["producttype"].ToString();
            lblchargedweight.Text = returnDouble(Convert.ToString(dr["chargedweight"])).ToString("F2");
            lblspecialinstruactions.Text = dr["remarks"].ToString();

            /***************************************************************************************************************
                                                PAYMENT DETAILS
            ***************************************************************************************************************/
            if (dr["staxpaidby"].ToString().ToUpper().CompareTo("T") == 0)
                lblservicetaxpaidby.Text = "Transporter";
            else if (dr["staxpaidby"].ToString().ToUpper().CompareTo("P") == 0)
                lblservicetaxpaidby.Text = "Billing Party";
            else
                lblservicetaxpaidby.Text = dr["staxpaidby"].ToString().ToUpper();
            lblservicetaxregby.Text = dr["staxregno"].ToString();


            lblentryby.Text = Convert.ToString(dr["entryby"]) + " : " + fn.GetEmpName(Convert.ToString(dr["entryby"]));
            lblentrydate.Text = Convert.ToString(dr["entrydate"]);

		lblEditedby.Text = Convert.ToString(dr["LastEditBy"]) + " : " + fn.GetEmpName(Convert.ToString(dr["LastEditBy"]));
            lblEditeddate.Text = Convert.ToString(dr["lasteditDate"]);

            // CHARGED COD IS SET HERE
            lblcoddodamt.Text = returnDouble(Convert.ToString(dr["codamt"])).ToString("F2");
            if (Convert.ToString(dr["flag_dacc"]).CompareTo("Y") != 0)
            {
                trdacc.Style["display"] = "none";
            }
            if (Convert.ToString(dr["flag_coddod"]).CompareTo("Y") != 0)
            {
                trcoddod.Style["display"] = "none";
            }

            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            dst.Date = Convert.ToDateTime(dr["dockddateddmmyyyy"], enGB);
            dst.SubTotal = DocketController.ToDouble(lblsubtoal.Text);
            dst.TransMode = dr["trn_mod"].ToString();
            dst.ServiceType = dr["service_class"].ToString();
            dst.StaxPayer = dr["staxpaidby"].ToString();

        }

        dr.Close();


        if (csgncd.CompareTo("8888") != 0)
        {
            sqlstr = "SELECT custaddress,city,telno,pincode,emailids,mobileno FROM webx_custhdr WHERE custcd='" + csgncd + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblnoradd.Text = dr["custaddress"].ToString();
                lblnorpincode.Text = dr["city"].ToString() + " : " + dr["pincode"].ToString();
                lblnortel.Text = dr["telno"].ToString();
                lblnoremail.Text = dr["emailids"].ToString();
                lblnormob.Text = dr["mobileno"].ToString();
            }
            dr.Close();
        }

        if (csgecd.CompareTo("8888") != 0)
        {
            sqlstr = "SELECT custaddress,city,telno,pincode,emailids,mobileno FROM webx_custhdr WHERE custcd='" + csgecd + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblneeadd.Text = dr["custaddress"].ToString();
                lblneepincode.Text = dr["city"].ToString() + " : " + dr["pincode"].ToString();
                lblneetel.Text = dr["telno"].ToString();
                lblneeemail.Text = dr["emailids"].ToString();
                lblneemob.Text = dr["mobileno"].ToString();
            }
            dr.Close();
        }



        sqlstr = "SELECT statuscode FROM webx_master_general WHERE codeid='SCHG11' AND codetype='CHG'";
        cmd = new SqlCommand(sqlstr, con);
        string flag_fov = Convert.ToString(cmd.ExecuteScalar());
        if (flag_fov.CompareTo("Y") != 0)
            trfov.Style["display"] = "none";




        // CHAREGS FIDDING

        /*****************************************************************************************************
      *  RETRIEVING BASED ON CHARGE RULE
      ******************************************************************************************************/
        sqlstr = "SELECT defaultvalue FROM webx_rules_docket WHERE code='CHRG_RULE'";
        cmd = new SqlCommand(sqlstr, con);
        string chargerule = Convert.ToString(cmd.ExecuteScalar());
        /******************************************************************************************************/

        /************************************************************************************************
         *  SETTING DATA TABLE FOR CHARGES
         ***********************************************************************************************/
        if (chargerule.CompareTo("NONE") == 0)
            sqlstr = "SELECT chargevalue=0.00,defaultchargevalue=0.00,activeflag,* FROM webx_master_charge WHERE basedon='" + chargerule + "' AND activeflag='Y'";
        else if (chargerule.CompareTo("SVCTYP") == 0)
            sqlstr = "SELECT chargevalue=0.00,defaultchargevalue=0.00,activeflag,* FROM webx_master_charge WHERE basedon='" + chargerule + "' AND basecode='" + service_class + "' AND activeflag='Y'";
        else if (chargerule.CompareTo("BUT") == 0)
            sqlstr = "SELECT chargevalue=0.00,defaultchargevalue=0.00,activeflag,* FROM webx_master_charge WHERE basedon='" + chargerule + "' AND basecode='" + businesstype + "' AND activeflag='Y'";

        cmd = new SqlCommand(sqlstr, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        DataTable dtcharges = new DataTable();
        dtcharges.Columns.Add("chargecode1", typeof(string));
        dtcharges.Columns.Add("chargename1", typeof(string));
        dtcharges.Columns.Add("chargevalue1", typeof(string));
        dtcharges.Columns.Add("activeflag1", typeof(string));
        dtcharges.Columns.Add("defaultchargevalue1", typeof(string));
        dtcharges.Columns.Add("operator1", typeof(string));
        dtcharges.Columns.Add("chargecode2", typeof(string));
        dtcharges.Columns.Add("chargename2", typeof(string));
        dtcharges.Columns.Add("chargevalue2", typeof(string));
        dtcharges.Columns.Add("activeflag2", typeof(string));
        dtcharges.Columns.Add("defaultchargevalue2", typeof(string));
        dtcharges.Columns.Add("operator2", typeof(string));
        if (dt.Rows.Count % 2 != 0)
            dt.Rows.Add();

        int rwscnt = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dtcharges.Rows.Add();
            dtcharges.Rows[rwscnt]["chargecode1"] = dt.Rows[i]["chargecode"].ToString();
            dtcharges.Rows[rwscnt]["chargename1"] = dt.Rows[i]["chargename"].ToString();
            dtcharges.Rows[rwscnt]["chargevalue1"] = dt.Rows[i]["chargevalue"].ToString();
            dtcharges.Rows[rwscnt]["activeflag1"] = dt.Rows[i]["activeflag"].ToString();
            dtcharges.Rows[rwscnt]["operator1"] = dt.Rows[i]["operator"].ToString();
            i++;
            dtcharges.Rows[rwscnt]["chargecode2"] = dt.Rows[i]["chargecode"].ToString();
            dtcharges.Rows[rwscnt]["chargename2"] = dt.Rows[i]["chargename"].ToString();
            dtcharges.Rows[rwscnt]["chargevalue2"] = dt.Rows[i]["chargevalue"].ToString();
            dtcharges.Rows[rwscnt]["operator2"] = dt.Rows[i]["operator"].ToString();
            dtcharges.Rows[rwscnt]["activeflag2"] = dt.Rows[i]["activeflag"].ToString();
            rwscnt++;
        }
        /***********************************************************************************************/

        sqlstr = "SELECT * FROM webx_master_docket_charges WHERE dockno='" + dockno + "'";
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
                        Response.Redirect("ErrorPage.aspx?heading=Critical Error. Charge Filling from DataBase Problem Zero&detail1=Programming Error&detail2=" + exmess);
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





        //dst = DocketController.GetServiceTax(dst);

        //lblservicetaxrate.Text = dst.StdSTaxRate.ToString("F2");
        //lblservicetaxrate.Text = dst.STaxRate.ToString("F2");
        //lbleducessrate.Text = dst.StdEduCessRate.ToString("F2");
        //lblheducessrate.Text = dst.StdHEduCessRate.ToString("F2");
        //lblSbcRate.Text = dst.StdSbCessRate.ToString("F2");
        //lblKKRate.Text = dst.StdKKCessRate.ToString("F2");


        //if ((hdnTransMode.Value == "2" || hdnTransMode.Value == "4") && lblservicetype.Text.ToUpper().CompareTo("SUNDRY") == 0 && returnDouble(lblsubtoal.Text) > 750)
        //{
        //    lblservicetaxrate.Text = "2.50";
        //}
        //else if ((hdnTransMode.Value == "2" || hdnTransMode.Value == "4") && lblservicetype.Text.ToUpper().CompareTo("FTL") == 0 && returnDouble(lblsubtoal.Text) > 1500)
        //{
        //    lblservicetaxrate.Text = "2.50";
        //}
        //else if (hdnTransMode.Value == "2" || hdnTransMode.Value == "4")
        //{
        //    lblservicetaxrate.Text = "0.00";
        //}
		//GET GST Charges
        DataTable DGSTCharge = null;
        using (var dbObject = new WebX.Common.WebXHelper())
        {
            DGSTCharge = dbObject.ExecuteDataTable(System.Data.CommandType.StoredProcedure, "Usp_ViewPrint_GSTRate_Docket",
               new[] {
                        new System.Data.SqlClient.SqlParameter("@Dockno",dockno),

               });
            
        }
       // var DGSTCharge = DocketController.GSTDOCKETRATE(dockno);
        
        if (DGSTCharge != null && DGSTCharge.Rows.Count > 0)
        {
            gstpayment.Visible = true;
            gstcategory.Visible = true;
            gstcharges.Visible = true;
            gstservicetype.Visible = true;
            servicetax.Visible = false;
            educationtax.Visible = false;
            highereducationtax.Visible = false;
            cesstax.Visible = false;
            kkcesstax.Visible = false;

            gststate.Text = (DGSTCharge.Rows[0]["STATENAME"]).ToString();
            gstin.Text = (DGSTCharge.Rows[0]["GSTIN"]).ToString();
            gstproduct.Text = (DGSTCharge.Rows[0]["PRODUCT"]).ToString();
            saccategory.Text = (DGSTCharge.Rows[0]["SACCATEGORY"]).ToString();
            servicetype.Text = (DGSTCharge.Rows[0]["SERVICETYPENAME"]).ToString();
            gstrate.Text = (DGSTCharge.Rows[0]["GSTRATE"]).ToString();
            gstamount.Text = (DGSTCharge.Rows[0]["GSTAmount"]).ToString();
            gstcharge.Text = (DGSTCharge.Rows[0]["GSTCharged"]).ToString();
            lblsubtoal.Text = (DGSTCharge.Rows[0]["Subtotal"]).ToString();
            lbldockettotal.Text = (DGSTCharge.Rows[0]["DKTTOT"]).ToString();

        }

        else
        {
            gstpayment.Visible = false;
            gstcategory.Visible = false;
            gstcharges.Visible = false;
            gstservicetype.Visible = false;
            servicetax.Visible = true;
            educationtax.Visible = true;
            highereducationtax.Visible = true;
            cesstax.Visible = true;
            kkcesstax.Visible = true;
        }
        sqlstr = "SELECT ratetype=(CASE rate_type WHEN 'W' THEN 'Per KG' WHEN 'P' THEN 'Per Package' WHEN 'T' THEN 'Per TON' ELSE rate_type END),* FROM webx_master_docket_charges WHERE dockno='" + dockno + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblfreightratetype.Text = Convert.ToString(dr["ratetype"]);
            lblfreightcharge.Text = returnDouble(Convert.ToString(dr["freight"])).ToString("F2");
            lblfreightrate.Text = returnDouble(Convert.ToString(dr["frt_rate"])).ToString("F2");

            lblsubtoal.Text = returnDouble(Convert.ToString(dr["subtotal"])).ToString("F2");

            /* KK Cess */
            lblservicetaxrate.Text = returnDouble(Convert.ToString(dr["ServiceTaxRate"])).ToString("F2");
            lbleducessrate.Text = returnDouble(Convert.ToString(dr["cess"])) > 0 ? "2.00" : "0.00";
            lblheducessrate.Text = returnDouble(Convert.ToString(dr["hedu_cess"])) > 0 ? "1.00" : "0.00";
            lblSbcRate.Text = returnDouble(Convert.ToString(dr["SbcRate"])).ToString("F2");
            lblKKRate.Text = returnDouble(Convert.ToString(dr["KKCessRate"])).ToString("F2");
            /* KK Cess */

            lblservicetax.Text = returnDouble(Convert.ToString(dr["svctax"])).ToString("F2");
            lbleducess.Text = returnDouble(Convert.ToString(dr["cess"])).ToString("F2");
            lblheducess.Text = returnDouble(Convert.ToString(dr["hedu_cess"])).ToString("F2");
            lblSBCess.Text = returnDouble(Convert.ToString(dr["SBCess"])).ToString("F2");
            lblKKCess.Text = returnDouble(Convert.ToString(dr["KKCess"])).ToString("F2");

            lblservicetaxonsubtotal.Text = returnDouble(Convert.ToString(dr["svctax"])).ToString("F2");
            lbleducessonsubtotal.Text = returnDouble(Convert.ToString(dr["cess"])).ToString("F2");
            lblheducessonsubtotal.Text = returnDouble(Convert.ToString(dr["hedu_cess"])).ToString("F2");
            lblsbcessonsubtotal.Text = returnDouble(Convert.ToString(dr["SBCess"])).ToString("F2");
            lblkkcessonsubtotal.Text = returnDouble(Convert.ToString(dr["KKCess"])).ToString("F2");

            lbldockettotal.Text = returnDouble(Convert.ToString(dr["dkttot"])).ToString("F2");


            lblfovcharged.Text = returnDouble(Convert.ToString(dr["SCHG11"])).ToString("F2");
            lblcoddodcharged.Text = returnDouble(Convert.ToString(dr["SCHG12"])).ToString("F2");
            lbldacccharged.Text = returnDouble(Convert.ToString(dr["SCHG13"])).ToString("F2");

        }
        dr.Close();







        /***************************************************************************************************************
                                                  INVOICE DETAILS
        ***************************************************************************************************************/

        string sqlqry = "SELECT * FROM webx_master_docket_invoice WHERE dockno='" + dockno + "'";
        cmd = new SqlCommand(sqlqry, con);

        da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        da.Fill(ds, "tbl1");
        if (cft_yn.CompareTo("Y") == 0)
        {
            if (ds.Tables["tbl1"].Rows.Count <= 0)
            {
                DataRow dd;
                dd = ds.Tables["tbl1"].NewRow();
                ds.Tables["tbl1"].Rows.Add(dd);
                gvdocketdrill.Style["display"] = "none";
                tblinvoice.Style["display"] = "block";
            }
            gvdocketdrill_cft.DataSource = ds;
            gvdocketdrill_cft.DataBind();
        }
        else
        {
            if (ds.Tables["tbl1"].Rows.Count <= 0)
            {
                DataRow dd;
                dd = ds.Tables["tbl1"].NewRow();
                ds.Tables["tbl1"].Rows.Add(dd);
                gvdocketdrill.Style["display"] = "none";
                tblinvoice.Style["display"] = "block";
            }
            gvdocketdrill.DataSource = ds;
            gvdocketdrill.DataBind();
        }




        da.Dispose();


        /***************************************************************************************************************
                                                    DOCUMENT DETAILS GRID
        ***************************************************************************************************************/
        string loc_state = ""; // each location have state and we are printing state wise detail here
        sqlstr = "exec webx_check_location '" + dest + "'";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            loc_state = dr["locstate"].ToString();
        }
        dr.Close();


        // document grid
        sqlstr = "SELECT stform,stcstreq,stnm,documentno=(SELECT top 1 documentno FROM webx_master_docket_document WITH(NOLOCK) WHERE dockno='" + dockno + "') FROM webx_State a WITH(NOLOCK) WHERE STCD='" + loc_state + "' AND activeflag='Y'";
        cmd = new SqlCommand(sqlstr, con);

        da = new SqlDataAdapter(cmd);
        ds = new DataSet();

        da.Fill(ds, "tbl2");

        if (ds.Tables["tbl2"].Rows.Count <= 0)
        {
            DataRow dd;
            dd = ds.Tables["tbl2"].NewRow();
            ds.Tables["tbl2"].Rows.Add(dd);
            grvdoc.Style["display"] = "none";
            tbldocgrid.Style["display"] = "block";
        }

        grvdoc.DataSource = ds;
        grvdoc.DataBind();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvdocketdrill_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    // CHARGES GRID IS FILLED HERE
    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnchargecode1 = (HiddenField)e.Row.FindControl("hdnchargecode1");
            HiddenField hdnchargecode2 = (HiddenField)e.Row.FindControl("hdnchargecode2");

            Label lbloperator1 = (Label)e.Row.FindControl("lbloperator1");
            Label lbloperator2 = (Label)e.Row.FindControl("lbloperator2");

            HiddenField hdnactiveflag1 = (HiddenField)e.Row.FindControl("hdnactiveflag1");
            HiddenField hdnactiveflag2 = (HiddenField)e.Row.FindControl("hdnactiveflag2");

            lbloperator1.Text = "(" + DataBinder.Eval(e.Row.DataItem, "operator1") + ")";
            lbloperator2.Text = "(" + DataBinder.Eval(e.Row.DataItem, "operator2") + ")";

            if (hdnchargecode2.Value.CompareTo("") == 0)
            {
                Label lblcharge2 = (Label)e.Row.FindControl("lblcharge2");
                lbloperator2.Style["display"] = "none";
                lblcharge2.Style["display"] = "none";
            }
        }
    }

    protected void grvdoc_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    // Inner Function convert string to double,(incase string is NULL or blank it handles) and  keep Code clear
    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0.00";
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

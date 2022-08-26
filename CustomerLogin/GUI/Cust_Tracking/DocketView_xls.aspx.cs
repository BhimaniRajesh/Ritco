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

public partial class GUI_Operation_Singlescreen_DocketPrint_DocketView_xls : System.Web.UI.Page
{
    protected string sdkt_call = "";

    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string remark = "", dockno = "", printyn = "", dest = "", docksf = "";
        string boxbg = "boxbg", bgbluegrey = "bgbluegrey", blackfnt = "bluefnt";
        string csgncd = "", csgecd = "";

        dockno = Request.QueryString["dockno"].ToString();
        docksf = Request.QueryString["docksf"].ToString();
        sdkt_call = Session["DocketCalledAs"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sqlstr = "SELECT convert(varchar,dockdt,106) AS docketdate,orgncd AS orgnloc,destcd AS delloc,party_code AS partycode,";
        sqlstr = sqlstr + "paymentbasis=(SELECT codedesc FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=paybas),paybas,";
        sqlstr = sqlstr + "servicetype=(SELECT codedesc FROM webx_master_general WHERE codetype='SVCTYP' AND codeid=service_class),";
        sqlstr = sqlstr + "ftltype=(SELECT codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND codeid=ftl_types),";
        sqlstr = sqlstr + "transmode=(SELECT codedesc FROM webx_master_general WHERE codetype='TRN' AND codeid=trn_mod),";
        sqlstr = sqlstr + "producttype=(SELECT codedesc FROM webx_master_general WHERE codetype='PROD' AND codeid=PRODCD),";
        sqlstr = sqlstr + "cft_yn AS flag_volumetric,localcn_yn AS flag_local,dacc_yn AS flag_dacc,cod_dod as flag_coddod,";
        sqlstr = sqlstr + "pickup_dely AS pickupdel,convert(varchar,dockdt_entry,106) AS entrydate,from_loc as fromcity,to_loc as tocity,";
        sqlstr = sqlstr + "convert(varchar,cdeldt,106) AS edd,";
        sqlstr = sqlstr + "csgncd,csgnnm,csgnaddr,csgncity,csgnpincode,csgnteleno,csgnemail,";
        sqlstr = sqlstr + "csgecd,csgenm,csgeaddr,csgecity,csgepincode,csgeteleno,csgeemail,";
        sqlstr = sqlstr + "permit_yn AS flag_permit,permit_recvd_at,permit_no AS permitno,permitdt AS permitdate,";
        sqlstr = sqlstr + "permit_validity_dt,permit_recvd_dt,fincmplbr AS billedat,pkgsno AS noofpkgs,actuwt AS actualweight,";
        sqlstr = sqlstr + "producttype=(SELECT codedesc FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd),";
        sqlstr = sqlstr + "chrgwt AS chargedweight,spl_svc_req AS remarks,";
        sqlstr = sqlstr + "stax_paidby AS staxpaidby,stax_regno AS staxregno,";
        sqlstr = sqlstr + "risktype=(CASE ltrim(rtrim(insuyn)) WHEN 'O' THEN 'Owner Risk' WHEN 'C' THEN 'Carrier Risk' END) ,";
        sqlstr = sqlstr + "insuyn AS flag_policy,convert(varchar,insupldt,106) AS policydate,insupl as policyno,";
        sqlstr = sqlstr + "tot_covers,tot_modvat,tot_covers,ctr_no AS custrefno,";
        sqlstr = sqlstr + "packtype=(SELECT codedesc FROM webx_master_general WHERE codetype='PKGS' AND codeid=pkgsty),";
        sqlstr = sqlstr + "privatemark,tpnumber,entryby,reassign_destcd AS reassigndelloc,";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + " ";
        sqlstr = sqlstr + "codamt";
        sqlstr = sqlstr + " FROM webx_master_docket WHERE dockno='" + dockno + "' AND docksf='" + docksf + "'";
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

            if (lblpaybas.Text.ToUpper().CompareTo("TBB") == 0 || lblpaybas.Text.ToUpper().CompareTo("BOD") == 0 || lblpaybas.Text.ToUpper().CompareTo("NATIONAL") == 0)
            {
                lblbillingparty.Text = dr["partycode"].ToString() + " : " + fn.Getcustomer(Convert.ToString(dr["partycode"]));
            }


            lbltransmode.Text = dr["transmode"].ToString();
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
        }

        dr.Close();


        if (csgncd.CompareTo("8888") != 0)
        {
            sqlstr = "SELECT custaddress,city,telno,pincode,emailids FROM webx_custhdr WHERE custcd='" + csgncd + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblnoradd.Text = dr["custaddress"].ToString();
                lblnorpincode.Text = dr["city"].ToString() + " : " + dr["pincode"].ToString();
                lblnortel.Text = dr["telno"].ToString();
                lblnoremail.Text = dr["emailids"].ToString();
            }
            dr.Close();
        }

        if (csgecd.CompareTo("8888") != 0)
        {
            sqlstr = "SELECT custaddress,city,telno,pincode,emailids FROM webx_custhdr WHERE custcd='" + csgecd + "'";
            cmd = new SqlCommand(sqlstr, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblneeadd.Text = dr["custaddress"].ToString();
                lblneepincode.Text = dr["city"].ToString() + " : " + dr["pincode"].ToString();
                lblneetel.Text = dr["telno"].ToString();
                lblneeemail.Text = dr["emailids"].ToString();
            }
            dr.Close();
        }



        sqlstr = "SELECT statuscode FROM webx_master_general WHERE codeid='SCHG11' AND codetype='CHG'";
        cmd = new SqlCommand(sqlstr, con);
        string flag_fov = Convert.ToString(cmd.ExecuteScalar());
        if(flag_fov.CompareTo("Y")!=0)
            trfov.Style["display"] = "none";




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
        SqlDataAdapter da = new SqlDataAdapter(cmd);
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

     
        sqlstr = "SELECT * FROM webx_chargemst";
        cmd = new SqlCommand(sqlstr, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblservicetaxrate.Text = returnDouble(dr["svctax_rate"].ToString()).ToString("F2");
            lbleducessrate.Text = returnDouble(dr["edu_cess_rate"].ToString()).ToString("F2");
            lblheducessrate.Text = returnDouble(dr["hedu_cess_rate"].ToString()).ToString("F2");
        }
        dr.Close();


        if (lbltransmode.Text.ToUpper().CompareTo("ROAD") == 0 && lblservicetype.Text.ToUpper().CompareTo("SUNDRY") == 0 && returnDouble(lblsubtoal.Text) > 750)
        {
            lblservicetaxrate.Text = "3.00";
        }
        else if (lbltransmode.Text.ToUpper().CompareTo("ROAD") == 0 && lblservicetype.Text.ToUpper().CompareTo("FTL") == 0 && returnDouble(lblsubtoal.Text) > 1500)
        {
            lblservicetaxrate.Text = "3.00";
        }
        else if(lbltransmode.Text.ToUpper().CompareTo("ROAD")==0)
        {
            lblservicetaxrate.Text = "0.00";
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
            
            lblservicetax.Text = returnDouble(Convert.ToString(dr["svctax"])).ToString("F2");
            lbleducess.Text = returnDouble(Convert.ToString(dr["cess"])).ToString("F2");
            lblheducess.Text = returnDouble(Convert.ToString(dr["hedu_cess"])).ToString("F2");


            lblservicetaxonsubtotal.Text = returnDouble(Convert.ToString(dr["svctax"])).ToString("F2");
            lbleducessonsubtotal.Text = returnDouble(Convert.ToString(dr["cess"])).ToString("F2");
            lblheducessonsubtotal.Text = returnDouble(Convert.ToString(dr["hedu_cess"])).ToString("F2");

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
                Label lblcharge2 = (Label)e.Row.FindControl("lblcharge2");
                lbloperand2.Style["display"] = "none";
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

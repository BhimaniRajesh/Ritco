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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Data.SqlClient;

//if cod/dod =Y, then show cod/dod charges (already in place), cod/dod amount, cod/dod number
//Apurva Mankad: total 3
public partial class GUI_Operation_Singlescreen_docketentry_docket : System.Web.UI.Page
{

    public static string SQLstr, mode = "Y", System_Manual = "", wstr = "", COD_DOD_YN = "N";
    public static int intTotalRecords, totdoc;
    protected string fin2dig_year = "";

    //Docket Name is dynamic and depends on DB to use in aspx we store it in string
    protected string sdkt_call = "abc";

    MyFunctions fn = new MyFunctions();
    PaidMR paidmr = new PaidMR();

    SqlConnection sqlConn;

    //Contract Charges For Applicable_YN = Y
    public static string strContractCharges;
    public static string blnAppForFOVCharges;
    public static int tabcsr = 0;
    //Contract Charges For Applicable_YN = N
    public static string strContractChargesHidden, dktlenght, branchname="", Locationstr = "", Custcdstr = "", CityStr = "", ODACityStr = "", Validate_YN = "N", oda_yn = "", Contrct_YN = "N";
    public static double ServiceTax = 12, OtherTax = 2, H_OtherTax = 1, CFT_Ratio = 0;
    public static string SCHG01 = "0", SCHG02 = "0", SCHG03 = "0", SCHG04 = "0", SCHG05 = "0", SCHG06 = "0", SCHG07 = "0", SCHG08 = "0", SCHG09 = "0", SCHG10 = "0", SCHG11 = "0", SCHG12 = "0", SCHG13 = "0", SCHG14 = "0", SCHG15 = "0", SCHG16 = "0", SCHG17 = "0", SCHG18 = "0", SCHG19 = "0", SCHG20 = "0", SCHG21 = "0", SCHG22 = "0", SCHG23 = "0", UCHG01 = "0", UCHG02 = "0", UCHG03 = "0", UCHG04 = "0", UCHG05 = "0", UCHG06 = "0", UCHG07 = "0", UCHG08 = "0", UCHG09 = "0", UCHG10 = "0";

    public string strloccodes = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlCommand cmd;
        try
        {
            sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
            return;
        }


        /*****************************************************************************************************************
                                            SETING Page_Load DEFAULTS
         ****************************************************************************************************************/
        sqlConn.Open();

        hdnmode.Value = "ADD";
        hdnclient.Value = Session["Client"].ToString().ToUpper();
        if (hdnclient.Value.ToUpper().CompareTo("AGILITY") != 0)
        {
            lblloadcaption.Style["display"] = "none";
            cmbloadtype.Style["display"] = "none";
        }

        if (hdnclient.Value.ToUpper().CompareTo("VARUNA") != 0)
        {
            trodbno.Style["display"] = "none";
        }

        cmd = new SqlCommand("SELECT loccode FROM webx_location",sqlConn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (strloccodes.CompareTo("") == 0)
                strloccodes =  "," + dr["loccode"].ToString() + ",";
            else
                strloccodes = strloccodes + dr["loccode"].ToString() + ",";
        }
        dr.Close();

        hdnloccodes.Value = strloccodes;


        dktlenght  = Session["Dktlength"].ToString().Trim();
        lbldocklabel.Text = Session["DocketCalledAs"].ToString() + " Number";
        sdkt_call = Session["DocketCalledAs"].ToString();




        fin2dig_year = Session["finyear"].ToString().Substring(2, 2);
        hdnfinstartyear.Value = Session["finyear"].ToString();



        if (!IsPostBack)
        {

            string scr = @"<script>
                    function update1(elemValue1,elemValue2)
                  {
                      document.getElementById('ctl00_MyCPH1_consignor_Bill').value=elemValue1.toUpperCase();
                      document.getElementById('ctl00_MyCPH1_consignor_Bill_name').value=elemValue2;
                      document.getElementById('ctl00_MyCPH1_consignor_Bill').focus();  
                      document.getElementById('ctl00_MyCPH1_lblcontract_check').innerText='';
                  }
                  </script>";
           // scr = scr + onBlur_party_Detail();
            Page.RegisterClientScriptBlock("update1", scr);
            btnPopUp.Attributes.Add("onclick", "window.open('popup_cust.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");

            string scr1 = @"<script>
                    function update11(elemValue1,elemValue2)
                  {
                     document.getElementById('ctl00_MyCPH1_consignor_name_B').value=elemValue1.toUpperCase();
                     document.getElementById('ctl00_MyCPH1_consignor_name_B_nm').value=elemValue2;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update11", scr1);
            btn1.Attributes.Add("onclick", "window.open('popup_cust_csgn.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");


            string scr2 = @"<script>
                    function update111(elemValue1,elemValue2)
                  {
                     document.getElementById('ctl00_MyCPH1_consignee_name_B').value=elemValue1.toUpperCase();
                     document.getElementById('ctl00_MyCPH1_consignee_name_B_nm').value=elemValue2;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update111", scr2);
            Btn2.Attributes.Add("onclick", "window.open('popup_cust_csge.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");

            string scr3 = @"<script>
                    function update1111(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_destn').value=elemValue;
                     document.getElementById('ctl00_MyCPH1_destn').focus()
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1111", scr3);
            btnPopupLoc.Attributes.Add("onclick", "window.open('popup-branch_level4.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");


            string scr4 = @"<script>
                    function update_city(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_destfrom').value=elemValue;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city", scr4);
            btnFrom.Attributes.Add("onclick", "window.open('popup-city.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");

            string scr5 = @"<script>
                    function update_city1(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_destto').value=elemValue;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city1", scr5);
            btnTo.Attributes.Add("onclick", "window.open('popup-city1.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");


            branchname = fn.GetLocation(Session["Brcd"].ToString());
            Orgn.Value = Session["Brcd"].ToString();
            SqlDataReader drpaybas;
            //******************Starts Pay Bases*************************************

            string sql = "Select CodeId,CodeDesc From Webx_Master_General Where CodeType='PAYTYP' and  StatusCode='Y'";
            //string sql = "select codetype_new,abbr_type from webx_typemst where   activeflag='Y'";
            cmd = new SqlCommand(sql, sqlConn);
            drpaybas = cmd.ExecuteReader();

            paybas.Items.Clear();
            //paybas.Items.Add("Select");
            paybas.Items.Add(new ListItem("Select",""));
            paybas.SelectedIndex = 0;
            while (drpaybas.Read())
            {
                paybas.Items.Add(new ListItem(drpaybas.GetValue(1).ToString(), drpaybas.GetValue(0).ToString()));

            }
            drpaybas.Close();

            //******************end  Pay Bases*************************************


            //******************Starts Packging type*************************************
            SqlDataReader drpkgtyp;
            sql = "Select CodeId,CodeDesc From webx_master_general where CodeType='PKGS' and StatusCode='Y'";
            //sql = "select uty_id,uty_name from webx_UTYMAST where catid='2'";
            cmd = new SqlCommand(sql, sqlConn);
            drpkgtyp = cmd.ExecuteReader();

            pkgtyp.Items.Clear();
            pkgtyp.Items.Add(new ListItem("Select", ""));
            while (drpkgtyp.Read())
            {
                pkgtyp.Items.Add(new ListItem(drpkgtyp.GetValue(1).ToString(), drpkgtyp.GetValue(0).ToString()));
            }
            drpkgtyp.Close();

            //******************end  Packging type*************************************


            //******************Starts mode*************************************
            SqlDataReader drtrnmod;
            string sql1 = "select codeID,codedesc from Webx_Master_General where codetype='trn'";
            SqlCommand cmd1 = new SqlCommand(sql1, sqlConn);
            drtrnmod = cmd1.ExecuteReader();

            trans.Items.Clear();
            while (drtrnmod.Read())
            {
                trans.Items.Add(new ListItem(drtrnmod.GetValue(1).ToString(), drtrnmod.GetValue(0).ToString()));
            }
            drtrnmod.Close();

            //**************************end mode***********************************


            //*****************************starts Product**************************
            SqlDataReader drprod;
            sql1 = "Select CodeId,CodeDesc From webx_master_general where CodeType='PROD' and StatusCode='Y'";
            //sql1 = "select uty_id,uty_name from webx_UTYMAST where catid='1'";
            cmd1 = new SqlCommand(sql1, sqlConn);
            drprod = cmd1.ExecuteReader();

            prod.Items.Clear();
            prod.Items.Add(new ListItem("Select", ""));
            while (drprod.Read())
            {
                prod.Items.Add(new ListItem(drprod.GetValue(1).ToString(), drprod.GetValue(0).ToString()));

            }

            drprod.Close();

            //*****************************end products*********************************




            
            
            sql = "SELECT * FROM webx_master_general WHERE codetype='LOT' AND statuscode='Y'";
            cmbloadtype.Items.Clear();
            cmbloadtype.Items.Add(new ListItem("Select", "0"));
            cmd = new SqlCommand(sql, sqlConn);
            drprod=cmd.ExecuteReader();
            while (drprod.Read())
            {
                cmbloadtype.Items.Add(new ListItem(drprod["codedesc"].ToString(),drprod["codeid"].ToString()));
            }
            drprod.Close();


            sql = "SELECT * FROM webx_master_general WHERE codetype='BUT' AND statuscode='Y'";
            cmbbustype.Items.Clear();
            cmbbustype.Items.Add(new ListItem("Select", "0"));
            cmd = new SqlCommand(sql, sqlConn);
            drprod = cmd.ExecuteReader();
            while (drprod.Read())
            {
                cmbbustype.Items.Add(new ListItem(drprod["codedesc"].ToString(), drprod["codeid"].ToString()));
            }
            drprod.Close();


            //*****************************starts service**************************
            SqlDataReader drservice;
            sql = "Select codeid,codedesc From WebX_Master_General where CodeType='SVCTYP'";
            cmd = new SqlCommand(sql, sqlConn);
            drservice = cmd.ExecuteReader();
            service.Items.Clear();
            service.Items.Add("Select");
            while (drservice.Read())
            {

                service.Items.Add(new ListItem(drservice.GetValue(1).ToString(), drservice.GetValue(0).ToString()));
                //if (drpkgtyp.GetValue(0).ToString() == "1")
                //{

                //}
            }
            drservice.Close();

            //*****************************end service*******************************************************

            //*****************************starts FTL type**************************
            SqlDataReader drftltype;
            sql = "Select CodeId,CodeDesc From webx_master_general where CodeType='FTLTYP' and StatusCode='Y'";
            //sql = "Select distinct ftltype from webx_ftlmaster  order by FTLtype";
            cmd = new SqlCommand(sql, sqlConn);
            drftltype = cmd.ExecuteReader();

            service_ftl.Items.Clear();
            service_ftl.Items.Add(new ListItem("Select", ""));
            while (drftltype.Read())
            {
                service_ftl.Items.Add(new ListItem(drftltype.GetValue(1).ToString(), drftltype.GetValue(0).ToString()));

            }
            drftltype.Close();

            //************for contrct Master *************************************
            Payment_detaile_show_YN();
            //*****************************end FTL Type*****************************
            dockdt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");

            noofrows1.Text = "1";

            int onofrows1 = Convert.ToInt16(noofrows1.Text.ToString());
            addrowfn(onofrows1);//for page load



            //************************************for javascript******************************
            javascript_fn();
            //********************************************************************************

            //  //Generate SQL statement for Docket Listing
            generateSQL();

            //  //Paint Docket Listing based on criteria supplied by the user
            State_document_detail();

           
           
           
            GetChargemst();
            paymentdetail_flaggupdate(false);
            All_Main_Details_flaggupdate(false);


            consignor_name_B.Attributes.Add("onblur", "javascript:return partyCodeTest(this.getAttribute('id'),'" + consignor_name_B_nm.ClientID + "')");
            consignor_name_B.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
            consignee_name_B.Attributes.Add("onblur", "javascript:return partyCodeTest(this.getAttribute('id'),'" + consignee_name_B_nm.ClientID + "')");
            consignee_name_B.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");


            destfrom.Attributes.Add("onblur", "javascript:return originTest('" + destfrom.ClientID.ToString() + "','" + Orgn.ClientID.ToString() + "')");
            destto.Attributes.Add("onblur", "javascript:return destTest('" + destto.ClientID.ToString() + "','" + destn.ClientID.ToString() + "')");
 

            // CLIENT SPECIFIC SETTINGS

            if (Session["client"].ToString().ToUpper().CompareTo("AGILITY") == 0)
            {
                ins.SelectedValue = "O";
            }


         

        } // ISPOSTBACK


        if (paybas.SelectedValue.CompareTo("P02") == 0 || paybas.SelectedValue.CompareTo("P08") == 0 || paybas.SelectedValue.CompareTo("P09") == 0)
        {
            consignor_Bill.Enabled = true;
            consignor_Bill_name.Enabled = true;
            consignor_Bill.BackColor = System.Drawing.Color.FromArgb(0, 255, 255, 255);
            consignor_Bill_name.BackColor = System.Drawing.Color.FromArgb(0, 255, 255, 255);
            btnPopUp.Style["display"] = "block";

        }
        else
        {
            consignor_Bill.Enabled = false;
            consignor_Bill_name.Enabled = false;
            consignor_Bill.BackColor = System.Drawing.Color.FromArgb(0, 230, 230, 230);
            consignor_Bill_name.BackColor = System.Drawing.Color.FromArgb(0, 230, 230, 230);
            btnPopUp.Style["display"] = "none";
        }

        if (service.SelectedValue == "2")
        {
            service_ftl.Enabled = true;
        }
        else
        {
            service_ftl.Enabled = false;
        }


       
        cmd = new SqlCommand("SELECT GETDATE() AS servdt", sqlConn);
        DateTime d = (DateTime)cmd.ExecuteScalar();
        hdnserverdate.Value = d.ToString("dd/MM/yyyy");


    }
    protected void CODDOD_Click(object sender, EventArgs e)
    {

        Cod_Dod_display();
    }
    private void Cod_Dod_display()
    {
        if (chkCoddoc.Checked == true)
        {

            txtcodchrg.Enabled = true;
            txtcodchrg.Text = SCHG12;
            txtcodamt.Enabled = true;
           // txtcodamt.Text = "0.00";
        }
        //    divcod.Style["display"] = "block";
        //Payment_detal_table_cod.Visible=true;
        else
        {
            txtcodchrg.Enabled = false;
            txtcodamt.Enabled = false;
            txtcodchrg.Text = "0.00";
            //txtcodamt.Text = "0.00";
        }
            //    divcod.Style["display"] = "none";
        //    Payment_detal_table_cod.Visible = false;

    }
  
    protected void state_documentdetail_chk(object sender, EventArgs e)
    {
        
    }

    
    private void generateSQL()
    {
        string destcd = destn.Text.ToString();
        String sql_doc = "WEBX_Check_Location";


        SqlCommand sqlCommand = new SqlCommand(sql_doc, sqlConn);

        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = destcd.ToString();
        SqlDataReader DR_statecode;
        DR_statecode = sqlCommand.ExecuteReader();

        string LocState = "";
        while (DR_statecode.Read())
        {

            LocState = Convert.ToString(DR_statecode["LocState"]);
        }
        DR_statecode.Close();

        SQLstr = "Select STFORM,STCSTREQ,STNM,SRNO as Doc_srno from webx_State where STCD='" + LocState + "' and ACTIVEFLAG='Y'";



    }

    private void State_document_detail()
    {
        string destcd = destn.Text.ToString();
        Session["destination"] = destn.Text.ToString();
        state_doc_table.Visible = false;

        //Generate SQL statement for Docket Listing
        generateSQL();

        Payment_detaile_show_YN();
        Submitbtn.Attributes.Add("onclick", "javascript:return SubmitData()");
       
        SqlCommand sqlCommand = new SqlCommand(SQLstr, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocketList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("STFORM", typeof(string));
        dt.Columns.Add("STCSTREQ", typeof(string));
        dt.Columns.Add("STNM", typeof(string));
        dt.Columns.Add("Doc_srno", typeof(string));

        DataRow dr;
        sqlDA.Fill(dsDocketList);
        int i = 1;
        intTotalRecords = dsDocketList.Tables[0].Rows.Count;
        totdoc = intTotalRecords;
        

        if (intTotalRecords > 0)
        {
            rptDocketList.Visible = true;
            state_doc_table.Visible = true;
            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                dr = dt.NewRow();
                if (drRows["STCSTREQ"].ToString() == "Y")
                {
                    dr["STFORM"] = drRows["STFORM"].ToString();
                    dr["STCSTREQ"] = drRows["STCSTREQ"].ToString();
                    dr["STNM"] = drRows["STNM"].ToString(); //(drRows["STNM"] == System.DBNull.Value ? "" : Convert.ToDateTime(drRows["DocketDate"].ToString()).ToString("dd/MM/yyyy"));
                    dr["Doc_srno"] = drRows["Doc_srno"].ToString();
                    dt.Rows.Add(dr);
                }
            }
            rptDocketList.DataSource = dt;
            rptDocketList.DataBind();
            if (dsDocketList.Tables[0].Rows.Count <= 0)
                rptDocketList.Visible = false;
        }
        else
        {
            rptDocketList.Visible = false;
        }

       
        cltotdoc.Value = Convert.ToString(intTotalRecords);
    }


    protected void onBlur_party_Detail()
    {
      if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03" || paybas.SelectedValue == "P04" || paybas.SelectedValue == "P05" || paybas.SelectedValue == "P06")
            {
                consignor_Bill.Text = "";
                consignor_Bill_name.Text = "";
                consignor_Bill.Enabled = false;
                consignor_Bill_name.Enabled = false;

            }
            else
            {
                consignor_Bill.Enabled = true;
                consignor_Bill_name.Enabled = true;



                string Party_code = consignor_Bill.Text.ToString();
                string sql_party_check = "SELECT isnull((sum(case when custcd is not null  then 1 else 0 end )),0) as Party_yn from webx_custhdr  where  custcd='" + Party_code + "' ";
                SqlCommand cmd = new SqlCommand(sql_party_check, sqlConn);
                SqlDataReader Party_check;
                int Party_yn = 0;
                Party_check = cmd.ExecuteReader();

                if (Party_check.Read())
                {
                    Party_yn = Convert.ToInt16(Party_check.GetValue(0).ToString());
                }
                Party_check.Close();

                if (Party_yn > 0)
                {
                    string sql_contract_check = "SELECT   isnull((sum(case when a.custcd=b.custcode   then 1 else 0 end )),0)  as contrct_yn  FROM webx_CUSTHDR a WITH(NOLOCK) inner join WEBX_CUSTCONTRACT_HDR b  WITH(NOLOCK) on a.CUSTCD=b.custcode  where CUSTCD is not null and  PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0 and custcd='" + Party_code + "' ";
                    cmd = new SqlCommand(sql_contract_check, sqlConn);
                    SqlDataReader contrct_check;
                    contrct_check = cmd.ExecuteReader();
                    int contrct_yn = 0;
                    while (contrct_check.Read())
                    {
                        contrct_yn = Convert.ToInt16(contrct_check.GetValue(0).ToString());

                    }
                    contrct_check.Close();

                    if (contrct_yn > 0)
                    {

                        string sql_pick_del = "SELECT pkp_dly FROM webx_custcontract_charge WITH(NOLOCK) WHERE custcode='" + Party_code + "'";
                        cmd = new SqlCommand(sql_pick_del, sqlConn);
                        SqlDataReader dr_pick_del=cmd.ExecuteReader();
                        string tmpdly = "";
                        while (dr_pick_del.Read())
                        {
                            tmpdly = dr_pick_del["pkp_dly"].ToString().Trim();
                        }
                        dr_pick_del.Close();

                        string[] arrdly = new string[4];
                        arrdly = tmpdly.Split(',');
                        cboPickupDely.Items.Clear();
                        for (int i = 0; i < arrdly.Length; i++)
                        {
                            if (arrdly[i].Trim().ToUpper().CompareTo("GG") == 0)
                                 cboPickupDely.Items.Add(new ListItem("Godown Pickup - Godown Delivery","1"));
                            else if (arrdly[i].Trim().ToUpper().CompareTo("GD") == 0)
                                 cboPickupDely.Items.Add(new ListItem("Godown Pickup - Door Delivery", "2"));
                            else if (arrdly[i].Trim().ToUpper().CompareTo("DG") == 0)
                                 cboPickupDely.Items.Add(new ListItem("Door Pickup - Godown Delivery", "3"));
                            else if (arrdly[i].Trim().ToUpper().CompareTo("DD") == 0)
                                 cboPickupDely.Items.Add(new ListItem("Door Pickup - Door Delivery", "4"));
                        }

                       
                        
                        //*******************foe Service TYpe *****************************

                        //**************************************************************
                        //**************for COD DOC * Volumetric & ODA*****************************
                        Contract_for_Others();
                        //**********for trn mod*********************************************
                        string sql_trn_mod = "select road_yn,Express_yn,air_yn,rail_yn from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";

                        SqlDataReader dr_trn;

                        cmd = new SqlCommand(sql_trn_mod, sqlConn);
                       
                        dr_trn = cmd.ExecuteReader();
                        string trnmod = "", trnmodval = "";
                        string road_yn = "", Express_yn = "", air_yn = "", rail_yn = "";
                        trans.Items.Clear();
                        while (dr_trn.Read())
                        {

                            road_yn = dr_trn.GetValue(0).ToString();
                            Express_yn = dr_trn.GetValue(1).ToString();
                            air_yn = dr_trn.GetValue(2).ToString();
                            rail_yn = dr_trn.GetValue(3).ToString();
                            if (air_yn == "Y")
                            {
                                trnmod = fn.Gettrnmod("1");//"Air";
                                trnmodval = "1";
                                trans.Items.Add(new ListItem(trnmod, trnmodval));
                            }
                            if (road_yn == "Y")
                            {
                                trnmod = fn.Gettrnmod("2");//"Road";
                                trnmodval = "2";
                                trans.Items.Add(new ListItem(trnmod, trnmodval));
                            }
                            if (rail_yn == "Y")
                            {
                                trnmod = fn.Gettrnmod("3");//"Train";
                                trnmodval = "3";
                                trans.Items.Add(new ListItem(trnmod, trnmodval));
                            }
                            if (Express_yn == "Y")
                            {
                                trnmod = fn.Gettrnmod("4");//"Express";
                                trnmodval = "4";
                                trans.Items.Add(new ListItem(trnmod, trnmodval));
                            }

                        }

                        dr_trn.Close();

                        //**********************************************************************
                        //**********for Service type*********************************************
                        string sql_service = "select ftl_yn,sundry_yn from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";

                        SqlDataReader dr_service;

                        cmd = new SqlCommand(sql_service, sqlConn);
                   
                        dr_service = cmd.ExecuteReader();
                        string servicecode = "", servicedesc = "";
                        string ftl_yn = "", sundry_yn = "";
                        service.Items.Clear();
                        service.Items.Add("Select");
                        while (dr_service.Read())
                        {

                            ftl_yn = dr_service.GetValue(0).ToString();
                            sundry_yn = dr_service.GetValue(1).ToString();

                            if (sundry_yn == "Y")
                            {
                                servicedesc = "Sundry";
                                servicecode = "1";
                                service.Items.Add(new ListItem(servicedesc, servicecode));
                            }
                            if (ftl_yn == "Y")
                            {
                                servicedesc = "FTL";
                                servicecode = "2";
                                service.Items.Add(new ListItem(servicedesc, servicecode));
                            }
                        }
                        dr_service.Close();

                        lblcontract_check.Text = "";
                        lblcontract_check.Visible = false;
                        validation_chk.Value = "";
                    }
                    else
                    {
                        lblcontract_check.Text = "This Billing Party  has no contract For this Location !!!";
                        validation_chk.Value = "";
                    }
                }
                else
                {
                    lblcontract_check.Text = "Invalid Party Code!!!";
                    if (validation_chk.Value == "")
                    {
                        validation_chk.Value = "Invalid Party Code!!!";
                    }

                }
                //**********************************************************************
             
                Payment_detaile_show_YN();
                consignor_Bill_name.Text = fn.Getcustomer(Party_code);
                if (paybas.SelectedValue == "P02")
                {
                    consignor_name_B.Text = Party_code.ToString();
                    consignor_name_B_nm.Text = fn.Getcustomer(Party_code);
                }
                else if (paybas.SelectedValue == "P08")
                {
                    consignee_name_B.Text = Party_code.ToString();
                    consignee_name_B_nm.Text = fn.Getcustomer(Party_code);
                }
            }
    }
    protected void for_paid_topay()
    {
        string Paybas = paybas.SelectedValue.ToString();
        string Transtype = trans.SelectedValue.ToString();
        if (Transtype == "Standard")
        {
            Transtype = "Road";
        }
        string sql_contract_check = "SELECT   count(*)  as contrct_yn  FROM WEBX_Default_CONTRACT_CHARGE  WITH(NOLOCK)  where contract_type='" + Paybas + "'";
        SqlCommand cmd = new SqlCommand(sql_contract_check, sqlConn);
                SqlDataReader contrct_check;
                contrct_check = cmd.ExecuteReader();
                int contrct_yn = 0;
                while (contrct_check.Read())
                {
                    contrct_yn = Convert.ToInt16(contrct_check.GetValue(0).ToString());

                }
                contrct_check.Close();

                if (contrct_yn > 0)
                {
                    //************************************FILLING PICKUPDELIVERY****************************


                    string sql_pick_del = "SELECT top 1 pkp_dly FROM WEBX_Default_CONTRACT_CHARGE WITH(NOLOCK) WHERE  contract_type='" + Paybas + "'";
                    cmd = new SqlCommand(sql_pick_del, sqlConn);
                    SqlDataReader dr_pick_del = cmd.ExecuteReader();
                    string tmpdly = "";
                    while (dr_pick_del.Read())
                    {
                        tmpdly = dr_pick_del["pkp_dly"].ToString().Trim();
                    }
                    dr_pick_del.Close();

                    string[] arrdly = new string[4];
                    arrdly = tmpdly.Split(',');
                    cboPickupDely.Items.Clear();
                    for (int i = 0; i < arrdly.Length; i++)
                    {
                        if (arrdly[i].Trim().ToUpper().CompareTo("GG") == 0)
                            cboPickupDely.Items.Add(new ListItem("Godown Pickup - Godown Delivery", "1"));
                        else if (arrdly[i].Trim().ToUpper().CompareTo("GD") == 0)
                            cboPickupDely.Items.Add(new ListItem("Godown Pickup - Door Delivery", "2"));
                        else if (arrdly[i].Trim().ToUpper().CompareTo("DG") == 0)
                            cboPickupDely.Items.Add(new ListItem("Door Pickup - Godown Delivery", "3"));
                        else if (arrdly[i].Trim().ToUpper().CompareTo("DD") == 0)
                            cboPickupDely.Items.Add(new ListItem("Door Pickup - Door Delivery", "4"));
                    }

                    //**************************************************************
                    //**************for COD DOC * Volumetric & ODA*****************************
                    Contract_for_Others_paid_topay();
                    //**********for trn mod*********************************************
                    string sql_trn_mod = "select top 1 road_yn,Express_yn,air_yn,rail_yn from   WEBX_Default_CONTRACT_CHARGE  WITH(NOLOCK) where  contract_type='" + Paybas + "'";

                    SqlDataReader dr_trn;

                    cmd = new SqlCommand(sql_trn_mod, sqlConn);

                    dr_trn = cmd.ExecuteReader();
                    string trnmod = "", trnmodval = "";
                    string road_yn = "", Express_yn = "", air_yn = "", rail_yn = "";
                    trans.Items.Clear();
                    while (dr_trn.Read())
                    {

                        road_yn = dr_trn.GetValue(0).ToString();
                        Express_yn = dr_trn.GetValue(1).ToString();
                        air_yn = dr_trn.GetValue(2).ToString();
                        rail_yn = dr_trn.GetValue(3).ToString();
                        if (air_yn == "Y")
                        {
                            trnmod = fn.Gettrnmod("1");//"Air";
                            trnmodval = "1";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }
                        if (road_yn == "Y")
                        {
                            trnmod = fn.Gettrnmod("2");//"Road";
                            trnmodval = "2";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }
                        if (rail_yn == "Y")
                        {
                            trnmod = fn.Gettrnmod("3");//"Train";
                            trnmodval = "3";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }
                        if (Express_yn == "Y")
                        {
                            trnmod = fn.Gettrnmod("4");//"Express";
                            trnmodval = "4";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }

                    }

                    dr_trn.Close();

                    //**********************************************************************
                    //**********for Service type*********************************************
                    string sql_service = "select top 1  ftl_yn,sundry_yn from   WEBX_Default_CONTRACT_CHARGE  WITH(NOLOCK) where  contract_type='" + Paybas + "'";

                    SqlDataReader dr_service;

                    cmd = new SqlCommand(sql_service, sqlConn);

                    dr_service = cmd.ExecuteReader();
                    string servicecode = "", servicedesc = "";
                    string ftl_yn = "", sundry_yn = "";
                    service.Items.Clear();
                    service.Items.Add("Select");
                    while (dr_service.Read())
                    {

                        ftl_yn = dr_service.GetValue(0).ToString();
                        sundry_yn = dr_service.GetValue(1).ToString();

                        if (sundry_yn == "Y")
                        {
                            servicedesc = "Sundry";
                            servicecode = "1";
                            service.Items.Add(new ListItem(servicedesc, servicecode));
                        }
                        if (ftl_yn == "Y")
                        {
                            servicedesc = "FTL";
                            servicecode = "2";
                            service.Items.Add(new ListItem(servicedesc, servicecode));
                        }
                    }
                    dr_service.Close();

                    lblcontract_check.Text = "";
                    lblcontract_check.Visible = false;
                    validation_chk.Value = "";
                }
         
         
    }

    protected void onBlur_party(object sender, EventArgs e)
    {
        onBlur_party_Detail();
        if (Session["Client"].ToString() == "RLL")
        {
            if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03" || paybas.SelectedValue == "P04" || paybas.SelectedValue == "P05" || paybas.SelectedValue == "P06")
            {
                for_paid_topay();

            }
        }

    }
    protected void btnstep1_Click(object sender, EventArgs e)
    {

        dockno.Enabled = false;
        All_Main_Details_flaggupdate(true);
        onBlur_party_Detail();
        State_document_detail();
        if (Session["Client"].ToString() == "RLL")
        {
            if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03" || paybas.SelectedValue == "P04" || paybas.SelectedValue == "P05" || paybas.SelectedValue == "P06")
            {
                for_paid_topay();

            }
        }
        ctrno.Text = dockno.Text;
        btnPopUp.Style["display"] = "none";
        btnPopupLoc.Visible = false;

    }
    protected void EnableParty_Dest(object sender, EventArgs e)
    {
        btnPopUp.Style["display"] = "block";
        btnPopupLoc.Visible = true;
        DOCKET_DETAIL_ROW3.Visible = false;
        DOCKET_DETAIL_ROW4.Visible = false;
        DOCKET_DETAIL_ROW5.Visible = false;
        Cnor_Cnee_detail.Visible = true;
        Permit_tracker_detail.Visible = true;
        Invoice_detail.Visible = true;
        Consignment_detail.Visible = false;
        Documents_detail.Visible = false;
        paymentdetail.Visible = false;
        Btn_enable.Visible = false;
        paymentdetail_flaggupdate(false);
    }
    
    protected void Row_Invisible(object sender, EventArgs e)
    {
         All_Main_Details_flaggupdate(true);
    }
    
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
 *                  NO OF ROWS OF INVOICE GRID VALIDATION NOT LESS THAN 1
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
    protected void NOOFROWS(object sender, EventArgs e)
    {
        int onofrows1 = Convert.ToInt16(noofrows1.Text.ToString());
        addrowfn(onofrows1);


        if (chkcft.Checked)
        {
            javascript_invdetal_cft_fn();
        }
        else
        {
            javascript_invdetal_fn();
        }
    }


   

    public void addrowfn(int onofrows1)
    {


        string SQLstr1 = "select top " + onofrows1 + "  " + onofrows1 + " as SRNO from Addrow";


        SqlCommand sqlCommand = new SqlCommand(SQLstr1, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocketList = new DataSet();

        DataTable dt1 = new DataTable();
        dt1.Columns.Add("SRNO", typeof(string));
        DataRow dr;

        sqlDA.Fill(dsDocketList);

        int i = 1;

        intTotalRecords = dsDocketList.Tables[0].Rows.Count;
        if (intTotalRecords > 0)
        {
            if (chkcft.Checked)
            {

                invdata_cft.Visible = true;
                cft_detal_row.Visible = true;
                invdata.Visible = false;
            }
            else
            {
                invdata.Visible = true;
                invdata_cft.Visible = false;
                cft_detal_row.Visible = false;
            }
            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                dr = dt1.NewRow();
                dr["SRNO"] = i;
                dt1.Rows.Add(dr);

                i++;

            }
            if (chkcft.Checked)
            {


                invdata_cft.DataSource = dt1;
                invdata_cft.DataBind();
            }
            else
            {
                invdata.DataSource = dt1;
                invdata.DataBind();
            }

        }
        else
        {
            invdata.Visible = false;
            invdata_cft.Visible = false;
        }

        string vol = "Y";


        decl.Text = "0";
        pkg.Text = "0";
        awt.Text = "0";
        cwt.Text = "0";

    }


    

   public void javascript_fn()
    {
        consignor_name.Attributes.Add("onblur", "javascript:return Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_add.Attributes.Add("onblur", "javascript:return Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_pin.Attributes.Add("onblur", "javascript:return Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_telno.Attributes.Add("onblur", "javascript:return Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_email.Attributes.Add("onblur", "javascript:return Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_email.Attributes.Add("onblur", "javascript:return num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ",'1')");
        consignee_email.Attributes.Add("onblur", "javascript:return num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ",'2')");
        consignor_pin.Attributes.Add("onblur", "javascript:return num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ")");
        consignee_pin.Attributes.Add("onblur", "javascript:return num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ")");

        modvat.Attributes.Add("onclick", "javascript:return modvatblur(" + modvat.ClientID + "," + totmodvat.ClientID + ")");
        permit_recvd_at.Attributes.Add("onblur", "javascript:return disable_enable(" + permit_yn.ClientID + "," + permitno.ClientID + ")");
        staxpaidby.Attributes.Add("onblur", "javascript:return FreightCalc()");
        frieght.Attributes.Add("onblur", "javascript:return FreightCalc()");
        rate.Attributes.Add("onblur", "javascript:return FreightCalc()");

        ratetype.Attributes.Add("onblur", "javascript:return FreightCalc()");
       
       Submitbtn.Attributes.Add("onclick", "javascript:return SubmitData()");
       dockdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + dockdt.ClientID + ")");
       txtDelyDt.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDelyDt.ClientID + ")");
        
       local_yn.Attributes.Add("onclick", "javascript:return LocalCN_validation_checkbox()");
       chkoda.Attributes.Add("onclick", "javascript:return ODA_validation_checkbox()");
       covers.Attributes.Add("onchange", "javascript:return Nagative_Chk_woDecimal(" + covers.ClientID + ")");
        totmodvat.Attributes.Add("onchange", "javascript:return Nagative_Chk_woDecimal(" + totmodvat.ClientID + ")");
        permitdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + permitdt.ClientID + ")");
        permit_val_dt.Attributes.Add("onblur", "javascript:return ValidateForm(" + permit_val_dt.ClientID + ")");
        permit_recvd_dt.Attributes.Add("onblur", "javascript:return ValidateForm(" + permit_recvd_dt.ClientID + ")");
        txtinsdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtinsdt.ClientID + ")");

        consignor_name.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
        consignee_name.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
        consignor_add.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
        consignee_add.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");


        fincmplbr.Attributes.Add("onblur", "javascript:return destCodeTest(this.getAttribute('id'))");

        if (chkcft.Checked)
        {
            javascript_invdetal_cft_fn();
        }
        else
        {
            javascript_invdetal_fn();
        }

    }


    protected void partynamedisplay(object sender, EventArgs e)
    {
        consignor_name_B.Text = consignor_name_B.Text.ToUpper();
        consignor_name_B_nm.Text = fn.Getcustomer(consignor_name_B.Text.ToString());
    }

    protected void cagenamedisplay(object sender, EventArgs e)
    {
        consignee_name_B.Text = consignee_name_B.Text.ToUpper();
        consignee_name_B_nm.Text = fn.Getcustomer(consignee_name_B.Text.ToString());
    }

    public void javascript_invdetal_fn()
    {

        foreach (GridViewRow gridrow in invdata.Rows)
        {
            TextBox invno = (TextBox)gridrow.FindControl("invno");
            TextBox invdt = (TextBox)gridrow.FindControl("invdt");
            TextBox declvalue = (TextBox)gridrow.FindControl("declvalue");
            TextBox pkgno = (TextBox)gridrow.FindControl("pkgno");
            TextBox actwt = (TextBox)gridrow.FindControl("actwt");

            invno.Attributes.Add("onblur", "javascript:return fSpecialChar(" + invno.ClientID + ")");
            invno.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
            declvalue.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + actwt.ClientID + ")");
            invdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + invdt.ClientID + ")");
            declvalue.Attributes.Add("onblur", "javascript:return TotalCalc(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onblur", "javascript:return TotalCalc(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onblur", "javascript:return TotalCalc(" + actwt.ClientID + ")");


        }
    }
    public void javascript_invdetal_cft_fn()
    {

        foreach (GridViewRow gridrow in invdata_cft.Rows)
        {
            TextBox invno = (TextBox)gridrow.FindControl("invno");
            TextBox declvalue = (TextBox)gridrow.FindControl("declvalue");
            TextBox pkgno = (TextBox)gridrow.FindControl("pkgno");
            TextBox actwt = (TextBox)gridrow.FindControl("actwt");
            TextBox length = (TextBox)gridrow.FindControl("length");
            TextBox breadth = (TextBox)gridrow.FindControl("breadth");
            TextBox height = (TextBox)gridrow.FindControl("height");
            TextBox invdt = (TextBox)gridrow.FindControl("invdt");

            invdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + invdt.ClientID + ")");
            invno.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
            invno.Attributes.Add("onblur", "javascript:return fSpecialChar(" + invno.ClientID + ")");
            declvalue.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + actwt.ClientID + ")");

            declvalue.Attributes.Add("onblur", "javascript:return TotalCalc(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onblur", "javascript:return TotalCalc(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onblur", "javascript:return TotalCalc(" + actwt.ClientID + ")");

            length.Attributes.Add("onblur", "javascript:return InvoiceDet(" + actwt.ClientID + ")");
            breadth.Attributes.Add("onblur", "javascript:return InvoiceDet(" + actwt.ClientID + ")");
            height.Attributes.Add("onblur", "javascript:return InvoiceDet(" + actwt.ClientID + ")");


        }
    }

    protected void fOnChangepaybas(object sender, EventArgs e)
    {
       
        Payment_detail_show.Value = "Y";
        Customer_contract();
        if (Session["client"].ToString() == "RCPL")
        {
            if (paybas.SelectedValue.CompareTo("P02") == 0 || paybas.SelectedValue.CompareTo("P08") == 0 || paybas.SelectedValue.CompareTo("P09") == 0)
            {
                frieght.Enabled = false;
                rate.Enabled = false;
            }
            else
            {
                frieght.Enabled = true;
                rate.Enabled = true;
            }
        }

        fincmplbr.Attributes.Add("onblur", "javascript:return destCodeTest(this.getAttribute('id'))");
        

        // CLIENT SPECIFIC SETTINGS
        if (Session["client"].ToString().ToUpper().CompareTo("RLL") == 0)
        {
            fincmplbr.Text = Session["brcd"].ToString();
        }
    }

    protected void fOnChangepaybas_for_otherControl(object sender, EventArgs e)
    {
        Payment_detaile_show_YN();
    }


    public void Payment_detaile_show_YN()
    {
        if (Payment_detail_show.Value == "Y")
        {
            Customer_contract();
        }
        COD_DOC_CHGDisplay();
        Contract_for_Others();
        ODA_CHGDisplay();
    }


    public void Customer_contract()
    {

        Contract_validation();

        /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
         *                              VALIDATAION FOR INVOICE GRID DATA
         *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/

        if (chkcft.Checked == false)
        {
            foreach (GridViewRow rptrow in invdata.Rows)
            {
                TextBox txtinvoiceno = (TextBox)rptrow.FindControl("invno");
                TextBox txtinvdate = (TextBox)rptrow.FindControl("invdt");
                TextBox txtdeclval = (TextBox)rptrow.FindControl("declvalue");
                TextBox txtpkgsno = (TextBox)rptrow.FindControl("pkgno");
                TextBox txtactwt = (TextBox)rptrow.FindControl("actwt");

                if (txtinvoiceno.Text.CompareTo("") == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Invoice Number..";
                    Payment_detal_errmsg1.Text = "Please Enter Invoice Number..";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtinvoiceno.Focus();
                }

                if (txtinvdate.Text.CompareTo("") == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Invoice Date...";
                    Payment_detal_errmsg1.Text = "Please Enter Invoice Date..";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtinvdate.Focus();
                }

                if (Convert.ToDouble(txtdeclval.Text) == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Declared Value Greater than Zero.";
                    Payment_detal_errmsg1.Text = "Please Enter Declared Value Greater than Zero.";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtdeclval.Focus();
                }

                if (Convert.ToDouble(txtpkgsno.Text) == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter No of Packages Greater than Zero.";
                    Payment_detal_errmsg1.Text = "Please Enter No of Packages Greater than Zero.";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtpkgsno.Focus();
                }

                if (Convert.ToDouble(txtactwt.Text) == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Actual Weight Greater than Zero.";
                    Payment_detal_errmsg1.Text = "Please Enter Actual Weight Greater than Zero.";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtactwt.Focus();
                }

            }
        } // CTF CHECKING 
        else
        {
            foreach (GridViewRow rptrow in invdata_cft.Rows)
            {
                TextBox txtinvoiceno = (TextBox)rptrow.FindControl("invno");
                TextBox txtinvdate = (TextBox)rptrow.FindControl("invdt");

                TextBox txtdeclval = (TextBox)rptrow.FindControl("declvalue");
                TextBox txtpkgsno = (TextBox)rptrow.FindControl("pkgno");

                TextBox txtlength = (TextBox)rptrow.FindControl("length");
                TextBox txtbreath = (TextBox)rptrow.FindControl("breath");
                TextBox txtheight = (TextBox)rptrow.FindControl("height");
                TextBox txtcftval = (TextBox)rptrow.FindControl("cftval");
                TextBox txtactwt = (TextBox)rptrow.FindControl("actwt");

                if (txtinvoiceno.Text.CompareTo("") == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Invoice Number..";
                    Payment_detal_errmsg1.Text = "Please Enter Invoice Number..";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtinvoiceno.Focus();
                }

                if (txtinvdate.Text.CompareTo("") == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Invoice Date...";
                    Payment_detal_errmsg1.Text = "Please Enter Invoice Date..";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtinvdate.Focus();
                }

                if (Convert.ToDouble(txtdeclval.Text) == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Declared Value Greater than Zero.";
                    Payment_detal_errmsg1.Text = "Please Enter Declared Value Greater than Zero.";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtdeclval.Focus();
                }

                if (Convert.ToDouble(txtpkgsno.Text) == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter No of Packages Greater than Zero.";
                    Payment_detal_errmsg1.Text = "Please Enter No of Packages Greater than Zero.";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtpkgsno.Focus();
                }

                if (Convert.ToDouble(txtactwt.Text) == 0)
                {
                    Payment_detal_errmsg.Text = "Please Enter Actual Weight Greater than Zero.";
                    Payment_detal_errmsg1.Text = "Please Enter Actual Weight Greater than Zero.";
                    paymentdetail_flaggupdate(false);
                    Validate_YN = "N";
                    txtactwt.Focus();
                }
            }

        }

        //FOr EDD 
        string EDDfrom = "NonODA";
        EDD_calc(EDDfrom, 0);
        if (dockno.Text != "" && paybas.Text != "" && trans.Text != "" && service.Text != "" && cwt.Text != "")
        {
            //contrct details

            DisplayCOntractPaymentdetail();
            if (Session["Client"].ToString() == "RLL")
            {
                if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
                {
                    DisplayCOntractPaymentdetail_FOR_Other();
                }
            }
            //Conctract_charges_value();
            //svc tax apid by stting 
            SetServicetaxPaidby();
           
            //Get Applicable Docket Charges for 'Y'
            if (Validate_YN == "Y")
            {
                getApplicableDocketChargesForY();
            }
            
            //Get Applicable Docket Charges for 'N'
            getApplicableDocketChargesForN();
            // state_doc_table2.Visible = true;
            if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
            {
                fincmplbr.Enabled = false;
              //  applicableForTypeOfService_for_paid_topay();

            }
            //FOr FOV charges
            applicableForTypeOfService();
            //for cod dod 
            Cod_Dod_display();
            ODA_CHGDisplay();
        }
       
    }

    public void Contract_validation()
    {
        string service_ftl_type;
        Validate_YN = "N";
        if (dockno.Text == "")
        {
            Payment_detal_errmsg.Text = "Plz Enter Docket NO";
            Payment_detal_errmsg1.Text = "Plz Enter Docket NO";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            dockno.Focus();
            //Response.End();
        }

        else if (paybas.Text == "" || paybas.Text.CompareTo("Select") == 0)
        {
            Payment_detal_errmsg.Text = "Plz Select Paybas";
            Payment_detal_errmsg1.Text = "Plz Select Paybas";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            paybas.Focus();
            // Response.End();
        }
        else if ((paybas.Text == "P02" || paybas.Text == "P09" || paybas.Text == "P08") && consignor_Bill.Text == "")
        {

            Payment_detal_errmsg.Text = "Plz Enter Party Code";
            Payment_detal_errmsg1.Text = "Plz Enter Party Code";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            consignor_Bill.Focus();
            // Response.End();

        }
        else if (destn.Text == "")
        {
            Payment_detal_errmsg.Text = "Plz Enter Destination Code";
            Payment_detal_errmsg1.Text = "Plz Enter Destination Code";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            destn.Focus();
        }
        else if (trans.Text == "Select" || trans.Text == "")
        {
            Payment_detal_errmsg.Text = "Plz Select Mode Of Transport";
            Payment_detal_errmsg1.Text = "Plz Select Mode Of Transport";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            trans.Focus();
        }
        else if (service.Text == "" || service.Text.CompareTo("Select") == 0)
        {
            Payment_detal_errmsg.Text = "Plz Select Service Type";
            Payment_detal_errmsg1.Text = "Plz Select Service Type";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            service.Focus();
        }
        else if (service.Text == "2" && service_ftl.Text == "")
        {
            Payment_detal_errmsg.Text = "Plz Select FTL Type";
            Payment_detal_errmsg1.Text = "Plz Select FTL Type";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            service_ftl.Focus();
        }
        else
        {
            service_ftl_type = service_ftl.Text;
            Payment_detal_errmsg.Text = "";
            Payment_detal_errmsg1.Text = "";
            Validate_YN = "Y";
        }


    }


    public void SetServicetaxPaidby()
    {
        string Trans = trans.SelectedValue.ToString();
        string Paybas = paybas.SelectedValue.ToString();
        staxpaidby.Items.Clear();
        if (Trans != "1" && Trans != "3" && Trans != "4")
        {
            if (Paybas == "P03")
            {
                staxpaidby.Items.Add(new ListItem("Consignee", "Consignee"));
            }
            else if (Paybas == "P01")
            {
                staxpaidby.Items.Add(new ListItem("Consignor", "Consignor"));
            }
            else
            {
                staxpaidby.Items.Add(new ListItem("Billing party", "Billing party"));
            }
        }
        staxpaidby.Items.Add(new ListItem("Transporter", "Transporter"));

    }
    private void getApplicableDocketChargesForY()
    {

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetApplicableDocketCharges_new";

        sqlCommand.Parameters.AddWithValue("@ApplicableYN", "Y");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsAppDocketCharges = new DataSet();

        sqlDA.Fill(dsAppDocketCharges);

        int intResult;
        string strContractChargesTemp = "";
        if (dsAppDocketCharges.Tables[0].Rows.Count > 0)
        {
            strContractCharges = "";

            for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
            {
                string readonlystr = "";

                if (COD_DOD_YN == "N" && dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() == "SCHG12")
                {
                    readonlystr = "readonly";
                }

                string Chargesvalue = "";

                string ChargesName = dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString();
                if (ChargesName == "SCHG01")
                {
                    Chargesvalue = SCHG01;
                }
                else if (ChargesName == "SCHG02")
                {
                    Chargesvalue = SCHG02;
                }
                else if (ChargesName == "SCHG03")
                {
                    Chargesvalue = SCHG03;
                }
                else if (ChargesName == "SCHG04")
                {
                    Chargesvalue = SCHG04;
                }
                else if (ChargesName == "SCHG05")
                {
                    Chargesvalue = SCHG05;
                }
                else if (ChargesName == "SCHG06")
                {
                    Chargesvalue = SCHG06;
                }
                else if (ChargesName == "SCHG07")
                {
                    Chargesvalue = SCHG07;
                }
                else if (ChargesName == "SCHG08")
                {
                    Chargesvalue = SCHG08;
                }
                else if (ChargesName == "SCHG09")
                {
                    Chargesvalue = SCHG09;
                }

                else if (ChargesName == "SCHG10")
                {
                    Chargesvalue = SCHG10;
                }
                else if (ChargesName == "SCHG11")
                {
                    Chargesvalue = SCHG11;
                }
                else if (ChargesName == "SCHG12")
                {
                    Chargesvalue = SCHG12;
                }
                else if (ChargesName == "SCHG13")
                {
                    if (chkdacc.Checked == true)
                    {
                        Chargesvalue = SCHG13;
                    }
                    else
                    {
                        Chargesvalue = "0.00";
                    }
                }
                else if (ChargesName == "SCHG14")
                {
                    Chargesvalue = SCHG14;
                }
                else if (ChargesName == "SCHG15")
                {
                    Chargesvalue = SCHG15;
                }
                else if (ChargesName == "SCHG16")
                {
                    Chargesvalue = SCHG16;
                }
                else if (ChargesName == "SCHG17")
                {
                    Chargesvalue = SCHG17;
                }
                else if (ChargesName == "SCHG18")
                {
                    Chargesvalue = SCHG18;
                }
                else if (ChargesName == "SCHG19")
                {
                    Chargesvalue = SCHG19;
                }
                else if (ChargesName == "SCHG20")
                {
                    Chargesvalue = SCHG20;
                }
                else if (ChargesName == "SCHG21")
                {
                    Chargesvalue = SCHG21;
                }
                else if (ChargesName == "SCHG22")
                {
                    Chargesvalue = SCHG22;
                }
                else if (ChargesName == "SCHG23")
                {
                    Chargesvalue = SCHG23;
                }
                else if (ChargesName == "UCHG01")
                {
                    Chargesvalue = UCHG01;
                }
                else if (ChargesName == "UCHG02")
                {
                    Chargesvalue = UCHG02;
                }
                else if (ChargesName == "UCHG03")
                {
                    Chargesvalue = UCHG03;
                }
                else if (ChargesName == "UCHG04")
                {
                    Chargesvalue = UCHG04;
                }
                else if (ChargesName == "UCHG05")
                {
                    Chargesvalue = UCHG05;
                }
                else if (ChargesName == "UCHG06")
                {
                    Chargesvalue = SCHG06;
                }
                else if (ChargesName == "UCHG07")
                {
                    Chargesvalue = UCHG07;
                }
                else if (ChargesName == "UCHG08")
                {
                    Chargesvalue = UCHG08;
                }
                else if (ChargesName == "UCHG09")
                {
                    Chargesvalue = UCHG09;
                }
                else if (ChargesName == "UCHG10")
                {
                    Chargesvalue = UCHG10;
                }
                

                if (paybas.SelectedValue.ToString() == "P02" || paybas.SelectedValue.ToString() == "P08" || paybas.SelectedValue.ToString() == "P09")
                {
                    // Chargesvalue = "0.0";
                    readonlystr = "ReadOnly";
                }
                else
                {
                    readonlystr = "";
                }
                if (Session["Client"].ToString() != "RCPL")
                {
                    if (Contrct_YN == "Y")
                    {
                        readonlystr = "ReadOnly";
                    }
                    else
                    {
                        readonlystr = "";
                    }
                    if (ChargesName == "SCHG13")
                    {
                        if (chkdacc.Checked == false)
                        {
                                                       readonlystr = "ReadOnly";
                        }
                    }

                }

                strContractChargesTemp = "<td  colspan='2'>";
                strContractChargesTemp += "<label class='blackfnt'>&nbsp;";
                strContractChargesTemp += dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();//+ "(" + dsAppDocketCharges.Tables[0].Rows[i]["operand"].ToString() + ")"
                strContractChargesTemp += "</label>";
                strContractChargesTemp += "</td>";
                strContractChargesTemp += "<td>";
                strContractChargesTemp += "<input id='" + dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() + "' ";
                strContractChargesTemp += "type='text' size='10' class='input' value='" + Chargesvalue + "' maxlength='8' ";
                strContractChargesTemp += "onblur='javascript: if(Nagative_Chk_wDecimal(this)){ return FreightCalc()};' " + readonlystr + " style='margin-left: 5px;text-align:right;' runat='server' />";
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
                strContractCharges += "<td  colspan='2'>&nbsp;</td><td>&nbsp;</td>" + "</tr>";
            }
        }

        paymentdetail_flaggupdate(true);


    }
    private void getApplicableDocketChargesForN()
    {


        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetApplicableDocketCharges_New";

        sqlCommand.Parameters.AddWithValue("@ApplicableYN", "N");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsAppDocketCharges = new DataSet();

        sqlDA.Fill(dsAppDocketCharges);

        if (dsAppDocketCharges.Tables[0].Rows.Count > 0)
        {
            strContractChargesHidden = "";

            for (int i = 0; i < dsAppDocketCharges.Tables[0].Rows.Count; i++)
            {
                strContractChargesHidden += "<input id='" + dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() + "' style='text-align:right;' type='hidden' value='0' runat='server'  />";
            }
        }


    }
    private void applicableForTypeOfService()
    {


        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetTypeOfServiceAppForDocketCharges_new";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsTOSApplicable = new DataSet();

        sqlDA.Fill(dsTOSApplicable);


        blnAppForFOVCharges = "";
        double fov_chrg = 0, fov_chrg_owner = 0, fov_chrg_carrier = 0, fov_rate = 0;
        string fov_type = "";
        double fov_calc = 0;
        if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
        { 

            string Sql_fov = "SELECT ISNULL(fov_chrg,0) AS fov_chrg,ISNULL(fov_chrg_owner,0) AS fov_chrg_owner ,fov_type,isnull(fov_chrg_carrier,0)  AS fov_chrg_carrier FROM webx_default_contract_CHARGE WHERE contract_type='" + paybas.SelectedValue + "'";
            sqlCommand = new SqlCommand(Sql_fov, sqlConn);

            SqlDataReader dr_Fov = null;
            dr_Fov = sqlCommand.ExecuteReader();

            if (dr_Fov.Read())
            {
                fov_chrg = Convert.ToDouble(dr_Fov["fov_chrg"]);
                fov_chrg_owner = Convert.ToDouble(dr_Fov["fov_chrg_owner"]);
                fov_chrg_carrier = Convert.ToDouble(dr_Fov["fov_chrg_carrier"]);
                fov_type = dr_Fov["fov_type"].ToString();
            }
            dr_Fov.Close();
        }
        else if (paybas.SelectedValue.CompareTo("P02") == 0 || paybas.SelectedValue.CompareTo("P08") == 0 || paybas.SelectedValue.CompareTo("P09") == 0)
        {
            string Sql_fov = "SELECT ISNULL(fov_chrg,0) AS fov_chrg,ISNULL(fov_chrg_owner,0) AS fov_chrg_owner ,fov_type,isnull(fov_chrg_carrier,0)  AS fov_chrg_carrier FROM webx_custcontract_CHARGE WHERE custcode='" + consignor_Bill.Text + "'";
            sqlCommand = new SqlCommand(Sql_fov, sqlConn);

            SqlDataReader dr_Fov = null;
            dr_Fov = sqlCommand.ExecuteReader();

            if (dr_Fov.Read())
            {
                fov_chrg = Convert.ToDouble(dr_Fov["fov_chrg"]);
                fov_chrg_owner = Convert.ToDouble(dr_Fov["fov_chrg_owner"]);
                fov_chrg_carrier = Convert.ToDouble(dr_Fov["fov_chrg_carrier"]);
                fov_type = dr_Fov["fov_type"].ToString();
            }
            dr_Fov.Close();
        }


        if (fov_type.ToUpper().CompareTo("%") == 0)
        {
            if (ins.SelectedValue.CompareTo("C") == 0)
            {
                fov_calc = (Convert.ToDouble(decl.Text) * fov_chrg_carrier) / 100;
                fov_rate = fov_chrg_carrier;
            }
            else if (ins.SelectedValue.CompareTo("O") == 0)
            {
                fov_calc = (Convert.ToDouble(decl.Text) * fov_chrg_owner) / 100;
                fov_rate = fov_chrg_owner;
            }
        }
        else
        {
            fov_calc = fov_chrg;
            fov_rate = 0;
        }



            if (dsTOSApplicable.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsTOSApplicable.Tables[0].Rows.Count; i++)
                {
                    string codeid = dsTOSApplicable.Tables[0].Rows[i]["CodeId"].ToString().ToUpper();

                    if (codeid == "SCHG11".ToUpper())
                    {
                        //blnAppForFOVCharges = (dsTOSApplicable.Tables[0].Rows[i]["Applicabl_yn"].ToString().ToUpper() == "Y" ? true : false);
                        if (dsTOSApplicable.Tables[0].Rows[i]["StatusCode"].ToString().ToUpper() == "Y")
                        {
                            blnAppForFOVCharges = "<TR bgcolor='#FFFFFF'><td  colspan='2' ><font class='blackfnt'>FOV(%)</font></td>";
                            blnAppForFOVCharges += "<td><font class='blackfnt'><input id='FOV_RATE' name='FOV_RATE' style='text-align:right;' type='text' size='10' value='" + fov_rate + "'  maxlength=8 onchange='javascript:return fovRate()' onblur='javascript:return fovRate();' ></font></td>";
                            blnAppForFOVCharges += "<td   colspan='2'></td><td></td></TR>	";
                            blnAppForFOVCharges += "<TR bgcolor='#FFFFFF'><td   colspan='2'><font class='blackfnt'>FOV On Declared Value</font></td>";
                            blnAppForFOVCharges += "<td><font class='blackfnt'><input id='FOV_delc' name='FOV_delc' type='text' size='10' style='text-align:right;' value='" + fov_calc + "' maxlength=8 onchange='javascript:return Nagative_Chk_wDecimal(this)' readonly></font></td>";
                            blnAppForFOVCharges += "<td   colspan='2'><font class='blackfnt'>FOV Charged(+)</font></td>";
                            blnAppForFOVCharges += "<td><font class='blackfnt'><input id='SCHG11' name='SCHG11' type='text' size='10' style='text-align:right;' value='" + fov_calc + "' onchange='javascript:return Nagative_Chk_wDecimal(this)'  onblur='javascript:return FreightCalc();' maxlength=8 ></font></td>";
                            blnAppForFOVCharges += "</TR>";
                        }
                        else
                        {
                            blnAppForFOVCharges = "<input id='FOV_RATE' name='FOV_RATE' type=hidden size=10  onchange='javascript:return fovRate()'>";
                            blnAppForFOVCharges += "<input id='FOV_delc' name='FOV_delc' type=hidden size=10  onchange='javascript:return Nagative_Chk_wDecimal(this)'>";
                            blnAppForFOVCharges += "<input id='SCHG11' name='SCHG11' type=hidden size=10  onchange='javascript:return Nagative_Chk_wDecimal(this)'>";


                        }
                    }
                }
            }

        
    }

   
    
    public void EDD_calc(string EDDfrom, int Trdays1)
    {

        string orgncd = Session["brcd"].ToString();
        string descd = destn.Text.ToString();
        string trnmod = trans.SelectedValue.ToString();
        string colnamecls = "",rateperkg="", ratepetpkg="";
        int Trdays = 0;
        if (trnmod == "1")
        {
            colnamecls = "trdays_air";
            rateperkg = "STD_RATE_PER_KG_Air";
            ratepetpkg = "STD_RATE_PER_PKG_Air";
        }
        else if (trnmod == "2")
        {
            colnamecls = "TRDAYS";
            rateperkg = "STD_RATE_PER_KG";
            ratepetpkg = "STD_RATE_PER_PKG";
        }
        else if (trnmod == "3")
        {
            colnamecls = "trdays_rail";
            rateperkg = "STD_RATE_PER_KG_Rail";
            ratepetpkg = "STD_RATE_PER_PKG_Rail";
        }
        else if (trnmod == "4")
        {
            colnamecls = "trdays_exp";
            rateperkg = "STD_RATE_PER_KG_Exp";
            ratepetpkg = "STD_RATE_PER_PKG_Exp";
        }



        string sql = "select isnull(" + colnamecls + ",0) as TRDAYS,  isnull(" + rateperkg + ",0) as rateperkg, isnull(" + ratepetpkg + ",0) as ratepetpkg  from webx_TRMS Where TRORGN ='" + orgncd + "' and TRDEST ='" + descd + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_edd = null;
        dr_edd = sqlCommand.ExecuteReader();



        if (dr_edd.Read())
        {

            Trdays = Convert.ToInt16(dr_edd.GetValue(0).ToString());
            if (Trdays is DBNull)
            {
                Trdays = 0;
            }

            trms_Rate_Kg.Value = dr_edd.GetValue(1).ToString();
            trms_Rate_Pkg.Value = dr_edd.GetValue(2).ToString();

            if (ratetype.SelectedValue.CompareTo("P")==0)
            {
                frieght.Text = Convert.ToString(Convert.ToDouble(cwt.Text) * Convert.ToDouble(trms_Rate_Pkg.Value));
                rate.Text = Convert.ToString(Convert.ToDouble(cwt.Text) * Convert.ToDouble(trms_Rate_Kg.Value));

                //hdnfreight.Value = frieght.Text;
                //hdnfreightrate.Value = rate.Text;
            }
            else if (ratetype.SelectedValue.CompareTo("W") == 0)
            {
                frieght.Text = Convert.ToString(Convert.ToDouble(decl.Text) * Convert.ToDouble(trms_Rate_Kg.Value));
                rate.Text = Convert.ToString(Convert.ToDouble(trms_Rate_Kg.Value));

                //hdnfreight.Value = frieght.Text;
                //hdnfreightrate.Value = rate.Text;
            }



        }
        dr_edd.Close();


        if (EDDfrom == "ODA" || EDDfrom == "FromContract")
        {
            Trdays = Trdays1;
        }
        string dktdate = dockdt.Text.ToString();
        string[] dktdate_arr;
        dktdate_arr = dktdate.Split('/');
        string dktdate_dt = dktdate_arr[0].ToString();
        string dktdate_mm = dktdate_arr[1].ToString();
        string dktdate_yy = dktdate_arr[2].ToString();
        dktdate = dktdate_mm + "/" + dktdate_dt + "/" + dktdate_yy;
        DateTime Docketdate = Convert.ToDateTime(dktdate.ToString());
        Trdays = Trdays + 1;
        DateTime Edd = Docketdate + TimeSpan.FromDays(Trdays);
        if (Edd.ToString("ddd").ToUpper() == "SUN")
        {
            Trdays = Trdays + 1;
            Edd = Docketdate + TimeSpan.FromDays(Trdays);
            
         }
         txtDelyDt.Text = Edd.ToString("dd/MM/yyyy");
    }

   
    
   
    public void Contract_PaymentDetailDisplay()
    {
    }
    protected void Contract_validate(object sender, EventArgs e)
    {
        Contract_chk_validate();

    }
    public void Contract_chk_validate()
    {
        if (chkCoddoc.Checked == true)
        {
            COD_DOD_YN = "Y";
        }
        else
        {
            COD_DOD_YN = "N";
        }

        if (local_yn.Checked == true)
        {
            if (Orgn.Value == destn.Text.ToString())
            {
                pkgtyp.Items.Clear();
                pkgtyp.Items.Add(new ListItem("Door Pickup - Door Delivery", "3"));
            }
        }
    }

    public void GetChargemst()
    {
        string moddesc = "";
        string sql = "Select * from WEBX_CHARGEMST";
        SqlCommand cmd = new SqlCommand(sql, sqlConn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            ServiceTax = Convert.ToDouble(dr["ServiceTax"].ToString());
            OtherTax = Convert.ToDouble(dr["EDU_CESS_RATE"].ToString());
            CFT_Ratio = Convert.ToDouble(dr["CFT_Ratio"].ToString());
            H_OtherTax = Convert.ToDouble(dr["HEDU_CESS_RATE"].ToString());

            hdnstaxrate.Value = dr["ServiceTax"].ToString();
            hdnedurate.Value = dr["EDU_CESS_RATE"].ToString();
            hdnhedurate.Value = dr["HEDU_CESS_RATE"].ToString();
            hdncftratio.Value = dr["CFT_RATIO"].ToString();
        }
        dr.Close();
    }

    public void DisplayCOntractPaymentdetail()
    {


        string Paybas = paybas.SelectedValue.ToString();
        string PartyCode = consignor_Bill.Text.ToString();
        string Destcd = destn.Text.ToString();
        string Orgncd = Session["brcd"].ToString();
        string Destfrom = destfrom.Text.ToString();
        string Destto = destto.Text.ToString();
        string Service = service.SelectedValue.ToString();
        string Service_ftl = service_ftl.SelectedValue.ToString();
        string Pkgsno = pkg.Text.ToString();
        string Transtype = trans.SelectedItem.ToString();
        if (Transtype == "Standard")
        {
            Transtype = "Road";
        }
        string Transtype_code = trans.SelectedValue.ToString();
        string charge_wt = cwt.Text.ToString();
        string Fromregion = fn.GetLocregion(Orgncd);
        string Toregion = fn.GetLocregion(Destcd);
        Contrct_YN = "N";
        string FTL_flag = "N", minfrt_flag = "N";
        string stax_paidby_new = "", sundry_yn = "", BilledAt = "", ftl_yn = "", cft2kg = "", stax_yn = "";
        double FreightStd = 0, RateDisp = 0;

        string dbService_No = Service;
        string single_slab_yn = "", multiple_slab_yn = "";
        string LOC_FLAG = "N", vol_yn = "", cod_dod_yn = "", REG_FLAG = "N", city_FLAG = "N", bkg_ratecol = "",trdays_col="";
        string slab_codeval = "", matrix_type = "", slab_code = "", trdays = "", MultiContract_yn = "N", RateDispVal = "";
        double RatePerKg = 0, RatePerPkg = 0;
        BilledAt = Session["brcd"].ToString();
        if (Paybas == "P02" || Paybas == "P08" || Paybas == "P09")
        {
            string sql = "Select h.stax_yn,h.stax_paidby as stax_paidby_new, c.* from  webx_custcontract_hdr h,webx_custcontract_CHARGE c where h.custcode=c.custcode and c.custcode='" + PartyCode + "'";
            SqlCommand cmd = new SqlCommand(sql, sqlConn);
            SqlDataReader Myrd = null;
            Myrd = cmd.ExecuteReader();
            int chargesvalue = 0;
            if (Myrd.Read())
            {
                Contrct_YN = "Y";
                stax_paidby_new = Convert.ToString(Myrd["stax_paidby_new"]);
                BilledAt = Convert.ToString(Myrd["billgen_loccode"]);
                if (BilledAt == "" || BilledAt is DBNull)
                {
                    BilledAt = Session["brcd"].ToString();
                }
                fincmplbr.Text = BilledAt;
                sundry_yn = Convert.ToString(Myrd["sundry_yn"]);

                ftl_yn = Convert.ToString(Myrd["ftl_yn"]);

                cft2kg = Convert.ToString(Myrd["cft2kg"]);
                cft2kg = fn.GetZeroval(cft2kg);
                cftratio.Text = cft2kg;
                stax_yn = Convert.ToString(Myrd["stax_yn"]);
                stax_yn = fn.GetZeroval(stax_yn);

                SCHG01 = Convert.ToString(Myrd["Dkt_chrg"]);

                SCHG02 = Convert.ToString(Myrd["Hamali_chrg"]);
                SCHG03 = Convert.ToString(Myrd["Otchg"]);
                SCHG04 = Convert.ToString(Myrd["nform_chrg"]);
                SCHG05 = Convert.ToString(Myrd["hld_chrg"]);
                SCHG06 = Convert.ToString(Myrd["oct_chrg"]);
                SCHG07 = Convert.ToString(Myrd["dp_chrg"]);
                SCHG08 = Convert.ToString(Myrd["dd_chrg"]);
                SCHG09 = Convert.ToString(Myrd["state_chrg"]);
                SCHG10 = Convert.ToString(Myrd["hld_dlychrg"]);
                SCHG11 = Convert.ToString(Myrd["fov_chrg"]);
                SCHG12 = Convert.ToString(Myrd["cod_chrg_rs"]);
                COD_DOC_CHGDisplay();
                SCHG13 = Convert.ToString(Myrd["dacc_chrg_rs"]);
                SCHG14 = Convert.ToString(Myrd["dem_chrg_rs"]);
                SCHG15 = Convert.ToString(Myrd["mathadi_chrg"]);
                SCHG16 = Convert.ToString(Myrd["risk_chrg"]);
                SCHG17 = Convert.ToString(Myrd["surcharge"]);
                SCHG18 = Convert.ToString(Myrd["st_chrg"]);
                SCHG19 = Convert.ToString(Myrd["oda_chrg"]);

                SCHG20 = Convert.ToString(Myrd["fuelchrg"]);
                SCHG21 = Convert.ToString(Myrd["FOD_chrg"]);
                SCHG22 = Convert.ToString(Myrd["DC_DD_chrg"]);
                SCHG23 = Convert.ToString(Myrd["STSRE_chrg"]);

                UCHG01 = Convert.ToString(Myrd["User_chrg_1"]);
                UCHG02 = Convert.ToString(Myrd["User_chrg_2"]);
                UCHG03 = Convert.ToString(Myrd["User_chrg_3"]);
                UCHG04 = Convert.ToString(Myrd["User_chrg_4"]);
                UCHG05 = Convert.ToString(Myrd["User_chrg_5"]);
                UCHG06 = Convert.ToString(Myrd["User_chrg_6"]);
                UCHG07 = Convert.ToString(Myrd["User_chrg_7"]);
                UCHG08 = Convert.ToString(Myrd["User_chrg_8"]);
                UCHG09 = Convert.ToString(Myrd["User_chrg_9"]);
                UCHG10 = Convert.ToString(Myrd["User_chrg_10"]);

                SCHG01 = fn.GetZeroval(SCHG01);
                SCHG02 = fn.GetZeroval(SCHG02);
                SCHG03 = fn.GetZeroval(SCHG03);
                SCHG04 = fn.GetZeroval(SCHG04);
                SCHG05 = fn.GetZeroval(SCHG05);
                SCHG06 = fn.GetZeroval(SCHG06);
                SCHG07 = fn.GetZeroval(SCHG07);
                SCHG08 = fn.GetZeroval(SCHG08);
                SCHG09 = fn.GetZeroval(SCHG09);
                SCHG10 = fn.GetZeroval(SCHG10);
                SCHG11 = fn.GetZeroval(SCHG11);
                SCHG12 = fn.GetZeroval(SCHG12);
                SCHG13 = fn.GetZeroval(SCHG13);
                SCHG14 = fn.GetZeroval(SCHG14);
                SCHG15 = fn.GetZeroval(SCHG15);
                SCHG16 = fn.GetZeroval(SCHG16);
                SCHG17 = fn.GetZeroval(SCHG17);
                SCHG18 = fn.GetZeroval(SCHG18);
                SCHG19 = fn.GetZeroval(SCHG19);
                SCHG20 = fn.GetZeroval(SCHG20);
                SCHG21 = fn.GetZeroval(SCHG21);
                SCHG22 = fn.GetZeroval(SCHG22);
                SCHG23 = fn.GetZeroval(SCHG23);
                UCHG01 = fn.GetZeroval(UCHG01);
                UCHG02 = fn.GetZeroval(UCHG02);
                UCHG03 = fn.GetZeroval(UCHG03);
                UCHG04 = fn.GetZeroval(UCHG04);
                UCHG05 = fn.GetZeroval(UCHG05);
                UCHG06 = fn.GetZeroval(UCHG06);
                UCHG07 = fn.GetZeroval(UCHG07);
                UCHG08 = fn.GetZeroval(UCHG08);
                UCHG09 = fn.GetZeroval(UCHG09);
                UCHG10 = fn.GetZeroval(UCHG10);
            }
            Myrd.Close();

            //******************for Sundry********************************
            if (dbService_No == "1")
            {
                sql = "Select single_slab_yn,multiple_slab_yn from webx_custcontract_hdr where custcode='" + PartyCode + "'";
                cmd = new SqlCommand(sql, sqlConn);
                SqlDataReader Myrd1 = null;
                Myrd1 = cmd.ExecuteReader();
                if (Myrd1.Read())
                {
                    single_slab_yn = Convert.ToString(Myrd1["single_slab_yn"]);
                    multiple_slab_yn = Convert.ToString(Myrd1["multiple_slab_yn"]);
                }
                Myrd1.Close();

                //*************For Single Slab -**********************************************
                if (single_slab_yn == "Y")
                {
                    if (Transtype_code == "1")
                    {
                        bkg_ratecol = "Air_rate";
                        trdays_col = "Air_days";
                    }
                    else if (Transtype_code == "2")
                    {
                        bkg_ratecol = "Road_rate";
                        trdays_col = "Road_days";
                    }
                    else if (Transtype_code == "3")
                    {
                        bkg_ratecol = "Train_rate";
                        trdays_col = "Express_days";
                    }
                    else if (Transtype_code == "4")
                    {
                        bkg_ratecol = "Express_rate";
                        trdays_col = "Train_days";
                    }
                    sql = "SELECT " + bkg_ratecol + " AS slab_codeval ,rate_type AS matrix_type,isnull(" + trdays_col + " ,0) as trdays FROM webx_custcontract_citydet WHERE custcode='" + PartyCode + "' AND ((fromcity='" + Destfrom + "' AND tocity='" + Destto + "')) ";
                    cmd = new SqlCommand(sql, sqlConn);
                    SqlDataReader Myrd_single = null;
                    Myrd_single = cmd.ExecuteReader();
                    if (Myrd_single.Read())
                    {
                        city_FLAG = "Y";
                        slab_codeval = Convert.ToString(Myrd_single["slab_codeval"]);
                        matrix_type = Convert.ToString(Myrd_single["matrix_type"]);
                        trdays = Convert.ToString(Myrd_single["trdays"]);
                    }
                    Myrd_single.Close();

                    if (city_FLAG == "N")
                    {
                        sql = "SELECT " + bkg_ratecol + " AS slab_codeval ,rate_type AS matrix_type,isnull(" + trdays_col + " ,0)  as trdays  FROM webx_custcontract_locdet  WHERE custcode='" + PartyCode + "' AND ((fromlocode='" + Orgncd + "' AND tolocode='" + Destcd + "')) ";
                        cmd = new SqlCommand(sql, sqlConn);
                        Myrd_single = null;
                        Myrd_single = cmd.ExecuteReader();
                        if (Myrd_single.Read())
                        {
                            LOC_FLAG = "Y";
                            slab_codeval = Convert.ToString(Myrd_single["slab_codeval"]);
                            matrix_type = Convert.ToString(Myrd_single["matrix_type"]);
                            trdays = Convert.ToString(Myrd_single["trdays"]);
                        }
                        Myrd_single.Close();

                    }
                    if (LOC_FLAG == "N")
                    {
                        sql = "SELECT " + bkg_ratecol + " AS slab_codeval ,rate_type AS matrix_type,isnull(" + trdays_col + " ,0)  as trdays  FROM webx_custcontract_regdet  WHERE custcode='" + PartyCode + "' AND ((fromregion='" + Fromregion + "' and toregion='" + Toregion + "')) ";
                        cmd = new SqlCommand(sql, sqlConn);
                        Myrd_single = null;
                        Myrd_single = cmd.ExecuteReader();
                        if (Myrd_single.Read())
                        {
                            REG_FLAG = "Y";
                            slab_codeval = Convert.ToString(Myrd_single["slab_codeval"]);
                            matrix_type = Convert.ToString(Myrd_single["matrix_type"]);
                            trdays = Convert.ToString(Myrd_single["trdays"]);
                        }
                        Myrd_single.Close();

                    }
                }
                //******************************Single Slab End ********************************
                //******************************Multi Slab start********************************
                else
                {
                    sql = "SELECT slab_code,matrix_type FROM webx_custcontract_frtmatrix_slabhdr WHERE custcode='" + PartyCode + "'  AND (CASE WHEN matrix_type='W' THEN " + charge_wt + " ELSE " + Pkgsno + " END) BETWEEN slab_from AND slab_to";
                    cmd = new SqlCommand(sql, sqlConn);
                    SqlDataReader Myrd_Multiple = null;
                    Myrd_Multiple = cmd.ExecuteReader();
                    if (Myrd_Multiple.Read())
                    {
                        MultiContract_yn = "Y";
                        slab_code = Convert.ToString(Myrd_Multiple["slab_code"]);
                        matrix_type = Convert.ToString(Myrd_Multiple["matrix_type"]);
                    }
                    Myrd_Multiple.Close();

                    if (MultiContract_yn == "Y")
                    {


                        sql = "SELECT  " + slab_code + " AS slab_codeval,trdays,isnull(ratetype,'W') as matrix_type FROM webx_custcontract_frtmatrix_slabdet  WHERE custcode='" + PartyCode + "'  AND ((from_loccode='" + Destfrom + "' AND to_loccode='" + Destto + "')) AND trans_type='" + Transtype + "'";
                        cmd = new SqlCommand(sql, sqlConn);
                        Myrd_Multiple = null;
                        Myrd_Multiple = cmd.ExecuteReader();
                        if (Myrd_Multiple.Read())
                        {
                            city_FLAG = "Y";
                            if (Myrd_Multiple["slab_codeval"] is DBNull)
                            {
                                slab_codeval = "";
                            }
                            else
                            {
                                slab_codeval = Myrd_Multiple["slab_codeval"].ToString();
                            }
                            trdays = Convert.ToString(Myrd_Multiple["trdays"]);
                            matrix_type = Convert.ToString(Myrd_Multiple["matrix_type"]);
                            trdays = fn.GetZeroval(trdays);
                        }
                        Myrd_Multiple.Close();

                        if (city_FLAG == "N")
                        {
                            sql = "select  " + slab_code + " as slab_codeval,trdays,isnull(ratetype,'W') as matrix_type   from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET  where custcode='" + PartyCode + "'  and ((from_loccode='" + Orgncd + "' and to_loccode='" + Destcd + "')) and trans_type='" + Transtype + "'";
                            Myrd_Multiple = null;
                            cmd = new SqlCommand(sql, sqlConn);
                            Myrd_Multiple = cmd.ExecuteReader();
                            if (Myrd_Multiple.Read())
                            {
                                LOC_FLAG = "Y";
                                if (Myrd_Multiple["slab_codeval"] is DBNull)
                                {
                                    slab_codeval = "";
                                }
                                else
                                {
                                    slab_codeval = Myrd_Multiple["slab_codeval"].ToString();
                                }
                                trdays = Convert.ToString(Myrd_Multiple["trdays"]);
                                matrix_type = Convert.ToString(Myrd_Multiple["matrix_type"]);
                                trdays = fn.GetZeroval(trdays);
                            }
                            Myrd_Multiple.Close();
                        }
                        if (LOC_FLAG == "N")
                        {
                            sql = "select  " + slab_code + " as slab_codeval,trdays,isnull(ratetype,'W') as matrix_type   from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET  where custcode='" + PartyCode + "'  and ((from_loccode='" + Fromregion + "' and to_loccode='" + Toregion + "')) and trans_type='" + Transtype + "'";
                            Myrd_Multiple = null;
                            cmd = new SqlCommand(sql, sqlConn);
                            Myrd_Multiple = cmd.ExecuteReader();
                            if (Myrd_Multiple.Read())
                            {
                                REG_FLAG = "Y";
                                if (Myrd_Multiple["slab_codeval"] is DBNull)
                                {
                                    slab_codeval = "";
                                }
                                else
                                {
                                    slab_codeval = Myrd_Multiple["slab_codeval"].ToString();
                                }
                                trdays = Convert.ToString(Myrd_Multiple["trdays"]);
                                matrix_type = Convert.ToString(Myrd_Multiple["matrix_type"]);
                                trdays = fn.GetZeroval(trdays);
                            }
                            Myrd_Multiple.Close();
                        }

                    }
                }

                if (LOC_FLAG == "N" && REG_FLAG == "N" && city_FLAG == "N")
                {
                    slab_codeval = "0";
                    Contrct_YN = "N";
                }
                //**********************Multi Slab End *****************
            }
            //*************Sundry COntrct End ******************************
            // **************** FTL Contrct Start***************************
            else
            {

                Fromregion = fn.GetLocregion(Fromregion);
                Toregion = fn.GetLocregion(Toregion);
                sql = "select City_matrix=isnull(sum(case when LOC_reg='C'and  from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "'  and ftltype='" + Service_ftl + "'  then 1 else 0 end),0), ";
                sql = sql + "Branch_matrix=isnull(sum(case when LOC_reg='L'and  from_loccode='" + Orgncd + "' and to_loccode='" + Destcd + "' and ftltype='" + Service_ftl + "' then 1 else 0 end),0),";
                sql = sql + "Region_matrix=isnull(sum(case when LOC_reg='R' and  from_loccode='" + Fromregion + "' and to_loccode='" + Toregion + "'  and ftltype='" + Service_ftl + "'then 1 else 0 end),0) from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where    custcode='" + PartyCode + "' ";
                //sql = "select count(*) as City_matrix from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "' and ftltype='" & Service_ftl & "' and LOC_reg='C'";
                cmd = new SqlCommand(sql, sqlConn);
                SqlDataReader Myrd_Ftl = null;
                int City_matrix = 0, Branch_matrix = 0, Region_matrix = 0;
                cmd = new SqlCommand(sql, sqlConn);
                Myrd_Ftl = cmd.ExecuteReader();
                if (Myrd_Ftl.Read())
                {

                    City_matrix = Convert.ToInt16(Myrd_Ftl["City_matrix"]);
                    Branch_matrix = Convert.ToInt16(Myrd_Ftl["Branch_matrix"]);
                    Region_matrix = Convert.ToInt16(Myrd_Ftl["Region_matrix"]);

                }
                Myrd_Ftl.Close();

                string Sql_ftl = "";
                if (City_matrix > 0)
                {
                    FTL_flag = "Y";
                    Sql_ftl = "select *  from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "' and ftltype='" + Service_ftl + "' and LOC_reg='C' and trans_type='" + Transtype + "'";
                }
                else if (Branch_matrix > 0)
                {
                    FTL_flag = "Y";
                    Sql_ftl = "select *  from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Orgncd + "' and to_loccode='" + Destcd + "' and ftltype='" + Service_ftl + "' and LOC_reg='L' and trans_type='" + Transtype + "'";
                }
                else if (Region_matrix > 0)
                {
                    FTL_flag = "Y";
                    Sql_ftl = "select *  from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Fromregion + "' and to_loccode='" + Toregion + "' and ftltype='" + Service_ftl + "' and LOC_reg='R' and trans_type='" + Transtype + "'";
                }
                if (Sql_ftl != "")
                {
                    Myrd_Ftl = null;
                    cmd = new SqlCommand(Sql_ftl, sqlConn);
                    Myrd_Ftl = cmd.ExecuteReader();
                    if (Myrd_Ftl.Read())
                    {
                        if (Myrd_Ftl["ftl1_trip_rate"] is DBNull)
                        {
                            FreightStd = 0;
                        }
                        else
                        {
                            FreightStd = Convert.ToDouble(Myrd_Ftl["ftl1_trip_rate"]);
                        }
                        if (Myrd_Ftl["ftl1_trdays"] is DBNull)
                        {
                            trdays = "0";
                        }
                        else
                        {
                            trdays = Myrd_Ftl["ftl1_trdays"].ToString();
                        }

                        RateDisp = FreightStd / Convert.ToDouble(charge_wt);
                    }
                    Myrd_Ftl.Close();
                }
            }
            frieght.Text = Convert.ToString(FreightStd);
            //hdnfreight.Value = frieght.Text;

            string EDDfrom = "FromContract";
            if (trdays == "" || trdays == "NULL")
            {
                trdays = "0";
            }
            EDD_calc(EDDfrom, Convert.ToInt16(trdays));
            // **************** FTL Contrct end ***************************
            if (Contrct_YN == "Y")
            {

                if (matrix_type == "W")
                {
                    RatePerKg = Convert.ToDouble(fn.GetZeroval(slab_codeval));
                    RatePerPkg = 0;
                    FreightStd = FreightStd / Convert.ToDouble(charge_wt);
                    if (Contrct_YN == "Y")
                    {
                        RateDisp = RatePerKg;
                        RateDispVal = "W";
                    }
                    ratetype.SelectedValue = RateDispVal.ToString();
                }
                else if (matrix_type == "P")
                {
                    RatePerKg = 0;
                    RatePerPkg = Convert.ToDouble(fn.GetZeroval(slab_codeval));
                    FreightStd = FreightStd / Convert.ToDouble(Pkgsno);
                    if (Contrct_YN == "Y")
                    {
                        RateDisp = RatePerPkg;
                        RateDispVal = "P";
                    }
                    ratetype.SelectedValue = RateDispVal.ToString();
                }
                if (dbService_No == "1")
                {
                    rate.Text = Convert.ToString(RateDisp);
                    
                }
            }
            else
            {
                rate.Text = "0.0";
                ratetype.SelectedValue = "W";
            }
            // ****************for Minmum rate /chgwt/pk****************
            string min_frtcol = "", type_bas = "", typebas = "";
            double minfrt = 0;
            if (Transtype_code == "1")
            {
                min_frtcol = "Air_rate";
                type_bas = "air_bas";
            }
            else if (Transtype_code == "2")
            {
                min_frtcol = "Road_rate";
                type_bas = "Road_bas";
            }
            else if (Transtype_code == "3")
            {
                min_frtcol = "rail_rate";
                type_bas = "rail_bas";
            }
            else if (Transtype_code == "4")
            {
                min_frtcol = "Exp_rate";
                type_bas = "Exp_bas";
            }
            sql = "Select " + min_frtcol + " as minfrt," + type_bas + " AS typebas  from webx_CUSTCONTRACT_CHARGE with (NOLOCK) where Custcode='" + PartyCode + "'";
            cmd = new SqlCommand(sql, sqlConn);
            SqlDataReader Myrd_Min_rate = null;

            cmd = new SqlCommand(sql, sqlConn);
            Myrd_Min_rate = cmd.ExecuteReader();
            if (Myrd_Min_rate.Read())
            {
                minfrt = Convert.ToDouble(Myrd_Min_rate["minfrt"]);
                typebas = Convert.ToString(Myrd_Min_rate["typebas"]);
            }
            Myrd_Min_rate.Close();

            if (typebas == "KG")//&& minfrt > Convert.ToDouble(charge_wt)
            {

                Payment_detal_errmsg.Text = "Minimum Charge wt. should be " + minfrt + " for this party ";
                Payment_detal_errmsg1.Text = "Minimum Charge wt. should be " + minfrt + " for this party";
                minfrt_flag = "Y";
                min_chrgwt.Value = Convert.ToString(minfrt);

                min_frt.Value = minfrt.ToString("F2");

                //frieght.Text = minfrt.ToString("F2");
                //try
                //{
                //    rate.Text = Convert.ToString(minfrt / returnDouble(cwt.Text));
                //}
                //catch (Exception ex)
                //{
                //    rate.Text = "0.00";
                //    frieght.Text = "0.00";
                //}

                if (Convert.ToDouble(cwt.Text) <= Convert.ToDouble(minfrt))
                {
                    Payment_detal_errmsg.Visible = true;
                    Payment_detal_errmsg1.Visible = true;
                }
                else
                {
                    Payment_detal_errmsg.Visible = false;
                    Payment_detal_errmsg1.Visible = false;
                }
            }
            else if (typebas == "PKG")//&& minfrt > Convert.ToDouble(Pkgsno)
            {
                Payment_detal_errmsg.Text = "Minimum Packages  should be " + minfrt + " for this party";
                Payment_detal_errmsg1.Text = "Minimum Packages  should be " + minfrt + " for this party";
                min_pkgsno.Value = Convert.ToString(minfrt);
                minfrt_flag = "Y";

                min_frt.Value = minfrt.ToString("F2");
                //frieght.Text = minfrt.ToString("F2");
                //try
                //{
                //    rate.Text = Convert.ToString(minfrt / returnDouble(pkg.Text));
                //}
                //catch (Exception ex)
                //{
                //    rate.Text = "0.00";
                //    frieght.Text = "0.00";
                //}
                if (Convert.ToDouble(pkg.Text) <= Convert.ToDouble(minfrt))
                {
                    Payment_detal_errmsg.Visible = true;
                    Payment_detal_errmsg1.Visible = true;
                }
                else
                {
                    Payment_detal_errmsg.Visible = false;
                    Payment_detal_errmsg1.Visible = false;
                }
            }
            else if (typebas == "RS")//&& minfrt > FreightStd
            {
                Payment_detal_errmsg.Text = "Minimum Freight should be " + minfrt + " for this party";
                Payment_detal_errmsg1.Text = "Minimum Freight should be " + minfrt + " for this party";
                minfrt_flag = "Y";
              
                min_frt.Value = minfrt.ToString("F2");
                //frieght.Text = minfrt.ToString("F2");
                //try
                //{
                //    rate.Text = Convert.ToString(minfrt / returnDouble(pkg.Text));
                //}
                //catch (Exception ex)
                //{
                //    rate.Text = "0.00";
                //    frieght.Text = "0.00";
                //}
                if (Convert.ToDouble(frieght.Text) <= Convert.ToDouble(minfrt))
                {
                    Payment_detal_errmsg.Visible = true;
                    Payment_detal_errmsg1.Visible = true;
                }
                else
                {
                    Payment_detal_errmsg.Visible = false;
                    Payment_detal_errmsg1.Visible = false;
                }
            }
            Myrd_Min_rate.Close();
        }
        else
        {
            string sql = "SELECT * FROM  webx_default_contract_CHARGE WHERE contract_type='" + paybas.SelectedValue + "'";

            SqlCommand cmd = new SqlCommand(sql, sqlConn);

            SqlDataReader Myrd = null;
            Myrd = cmd.ExecuteReader();
            int chargesvalue = 0;
            if (Myrd.Read())
            {
                stax_paidby_new = Convert.ToString(Myrd["stax_paidby"]);
                BilledAt = Convert.ToString(Myrd["billgen_loccode"]);
                if (BilledAt == "" || BilledAt is DBNull)
                {
                    BilledAt = Session["brcd"].ToString();
                }
                fincmplbr.Text = BilledAt;
                sundry_yn = Convert.ToString(Myrd["sundry_yn"]);

                ftl_yn = Convert.ToString(Myrd["ftl_yn"]);

                cft2kg = Convert.ToString(Myrd["cft2kg"]);
                cft2kg = fn.GetZeroval(cft2kg);
                cftratio.Text = cft2kg;
                //stax_yn = Convert.ToString(Myrd["stax_yn"]);
                stax_yn = fn.GetZeroval(stax_yn);

                SCHG01 = Convert.ToString(Myrd["Dkt_chrg"]);

                SCHG02 = Convert.ToString(Myrd["Hamali_chrg"]);
                SCHG03 = Convert.ToString(Myrd["Otchg"]);
                SCHG04 = Convert.ToString(Myrd["nform_chrg"]);
                SCHG05 = Convert.ToString(Myrd["hld_chrg"]);
                SCHG06 = Convert.ToString(Myrd["oct_chrg"]);
                SCHG07 = Convert.ToString(Myrd["dp_chrg"]);
                SCHG08 = Convert.ToString(Myrd["dd_chrg"]);
                SCHG09 = Convert.ToString(Myrd["state_chrg"]);
                SCHG10 = Convert.ToString(Myrd["hld_dlychrg"]);
                SCHG11 = Convert.ToString(Myrd["fov_chrg"]);
                SCHG12 = Convert.ToString(Myrd["cod_chrg_rs"]);



                COD_DOC_CHGDisplay();



                SCHG13 = Convert.ToString(Myrd["dacc_chrg_rs"]);
                SCHG14 = Convert.ToString(Myrd["dem_chrg_rs"]);
                SCHG15 = Convert.ToString(Myrd["mathadi_chrg"]);
                SCHG16 = Convert.ToString(Myrd["risk_chrg"]);
                SCHG17 = Convert.ToString(Myrd["surcharge"]);
                SCHG18 = Convert.ToString(Myrd["st_chrg"]);
                SCHG19 = Convert.ToString(Myrd["oda_chrg"]);

                SCHG20 = Convert.ToString(Myrd["fuelchrg"]);
                SCHG21 = Convert.ToString(Myrd["FOD_chrg"]);
                SCHG22 = Convert.ToString(Myrd["DC_DD_chrg"]);
                SCHG23 = Convert.ToString(Myrd["STSRE_chrg"]);

                UCHG01 = Convert.ToString(Myrd["User_chrg_1"]);
                UCHG02 = Convert.ToString(Myrd["User_chrg_2"]);
                UCHG03 = Convert.ToString(Myrd["User_chrg_3"]);
                UCHG04 = Convert.ToString(Myrd["User_chrg_4"]);
                UCHG05 = Convert.ToString(Myrd["User_chrg_5"]);
                UCHG06 = Convert.ToString(Myrd["User_chrg_6"]);
                UCHG07 = Convert.ToString(Myrd["User_chrg_7"]);
                UCHG08 = Convert.ToString(Myrd["User_chrg_8"]);
                UCHG09 = Convert.ToString(Myrd["User_chrg_9"]);
                UCHG10 = Convert.ToString(Myrd["User_chrg_10"]);

                SCHG01 = fn.GetZeroval(SCHG01);
                SCHG02 = fn.GetZeroval(SCHG02);
                SCHG03 = fn.GetZeroval(SCHG03);
                SCHG04 = fn.GetZeroval(SCHG04);
                SCHG05 = fn.GetZeroval(SCHG05);
                SCHG06 = fn.GetZeroval(SCHG06);
                SCHG07 = fn.GetZeroval(SCHG07);
                SCHG08 = fn.GetZeroval(SCHG08);
                SCHG09 = fn.GetZeroval(SCHG09);
                SCHG10 = fn.GetZeroval(SCHG10);
                SCHG11 = fn.GetZeroval(SCHG11);
                SCHG12 = fn.GetZeroval(SCHG12);
                SCHG13 = fn.GetZeroval(SCHG13);
                SCHG14 = fn.GetZeroval(SCHG14);
                SCHG15 = fn.GetZeroval(SCHG15);
                SCHG16 = fn.GetZeroval(SCHG16);
                SCHG17 = fn.GetZeroval(SCHG17);
                SCHG18 = fn.GetZeroval(SCHG18);
                SCHG19 = fn.GetZeroval(SCHG19);
                SCHG20 = fn.GetZeroval(SCHG20);
                SCHG21 = fn.GetZeroval(SCHG21);
                SCHG22 = fn.GetZeroval(SCHG22);
                SCHG23 = fn.GetZeroval(SCHG23);
                UCHG01 = fn.GetZeroval(UCHG01);
                UCHG02 = fn.GetZeroval(UCHG02);
                UCHG03 = fn.GetZeroval(UCHG03);
                UCHG04 = fn.GetZeroval(UCHG04);
                UCHG05 = fn.GetZeroval(UCHG05);
                UCHG06 = fn.GetZeroval(UCHG06);
                UCHG07 = fn.GetZeroval(UCHG07);
                UCHG08 = fn.GetZeroval(UCHG08);
                UCHG09 = fn.GetZeroval(UCHG09);
                UCHG10 = fn.GetZeroval(UCHG10);
            }
            Myrd.Close();
        } // PAID ENDS HERE

        ratetype.Focus();
        Contract_for_Others();
        ODA_CHGDisplay();


    }


    public void DisplayCOntractPaymentdetail_FOR_Other()
    {


        string Paybas = paybas.SelectedValue.ToString();
        string Transtype = trans.SelectedValue.ToString();
        if (Transtype == "Standard")
        {
            Transtype = "Road";
        }
        if (Paybas == "P01" || Paybas == "P03")
        {

            string sql = "select * from WEBX_Default_CONTRACT_CHARGE with(NOLOCK)where contract_type='" + Paybas + "' and trans_type='" + Transtype + "'";

            SqlCommand cmd = new SqlCommand(sql, sqlConn);

            SqlDataReader Myrd = null;
            Myrd = cmd.ExecuteReader();
            int chargesvalue = 0;
            if (Myrd.Read())
            {
                Contrct_YN = "Y";
                

                SCHG01 = Convert.ToString(Myrd["Dkt_chrg"]);

                SCHG02 = Convert.ToString(Myrd["Hamali_chrg"]);
                SCHG03 = Convert.ToString(Myrd["Otchg"]);
                SCHG04 = Convert.ToString(Myrd["nform_chrg"]);
                SCHG05 = Convert.ToString(Myrd["hld_chrg"]);
                SCHG06 = Convert.ToString(Myrd["oct_chrg"]);
                SCHG07 = Convert.ToString(Myrd["dp_chrg"]);
                SCHG08 = Convert.ToString(Myrd["dd_chrg"]);
                SCHG09 = Convert.ToString(Myrd["state_chrg"]);
                SCHG10 = Convert.ToString(Myrd["hld_dlychrg"]);
                SCHG11 = Convert.ToString(Myrd["fov_chrg"]);
                SCHG12 = Convert.ToString(Myrd["cod_chrg_rs"]);
                COD_DOC_CHGDisplay();
                SCHG13 = Convert.ToString(Myrd["dacc_chrg_rs"]);
                SCHG14 = Convert.ToString(Myrd["dem_chrg_rs"]);
                SCHG15 = Convert.ToString(Myrd["mathadi_chrg"]);
                SCHG16 = Convert.ToString(Myrd["risk_chrg"]);
                SCHG17 = Convert.ToString(Myrd["surcharge"]);
                SCHG18 = Convert.ToString(Myrd["st_chrg"]);
                SCHG19 = Convert.ToString(Myrd["oda_chrg"]);

                SCHG20 = Convert.ToString(Myrd["fuelchrg"]);
                SCHG21 = Convert.ToString(Myrd["FOD_chrg"]);
                SCHG22 = Convert.ToString(Myrd["DC_DD_chrg"]);
                SCHG23 = Convert.ToString(Myrd["STSRE_chrg"]);

                UCHG01 = Convert.ToString(Myrd["User_chrg_1"]);
                UCHG02 = Convert.ToString(Myrd["User_chrg_2"]);
                UCHG03 = Convert.ToString(Myrd["User_chrg_3"]);
                UCHG04 = Convert.ToString(Myrd["User_chrg_4"]);
                UCHG05 = Convert.ToString(Myrd["User_chrg_5"]);
                UCHG06 = Convert.ToString(Myrd["User_chrg_6"]);
                UCHG07 = Convert.ToString(Myrd["User_chrg_7"]);
                UCHG08 = Convert.ToString(Myrd["User_chrg_8"]);
                UCHG09 = Convert.ToString(Myrd["User_chrg_9"]);
                UCHG10 = Convert.ToString(Myrd["User_chrg_10"]);

                SCHG01 = fn.GetZeroval(SCHG01);
                SCHG02 = fn.GetZeroval(SCHG02);
                SCHG03 = fn.GetZeroval(SCHG03);
                SCHG04 = fn.GetZeroval(SCHG04);
                SCHG05 = fn.GetZeroval(SCHG05);
                SCHG06 = fn.GetZeroval(SCHG06);
                SCHG07 = fn.GetZeroval(SCHG07);
                SCHG08 = fn.GetZeroval(SCHG08);
                SCHG09 = fn.GetZeroval(SCHG09);
                SCHG10 = fn.GetZeroval(SCHG10);
                SCHG11 = fn.GetZeroval(SCHG11);
                SCHG12 = fn.GetZeroval(SCHG12);
                SCHG13 = fn.GetZeroval(SCHG13);
                SCHG14 = fn.GetZeroval(SCHG14);
                SCHG15 = fn.GetZeroval(SCHG15);
                SCHG16 = fn.GetZeroval(SCHG16);
                SCHG17 = fn.GetZeroval(SCHG17);
                SCHG18 = fn.GetZeroval(SCHG18);
                SCHG19 = fn.GetZeroval(SCHG19);
                SCHG20 = fn.GetZeroval(SCHG20);
                SCHG21 = fn.GetZeroval(SCHG21);
                SCHG22 = fn.GetZeroval(SCHG22);
                SCHG23 = fn.GetZeroval(SCHG23);
                UCHG01 = fn.GetZeroval(UCHG01);
                UCHG02 = fn.GetZeroval(UCHG02);
                UCHG03 = fn.GetZeroval(UCHG03);
                UCHG04 = fn.GetZeroval(UCHG04);
                UCHG05 = fn.GetZeroval(UCHG05);
                UCHG06 = fn.GetZeroval(UCHG06);
                UCHG07 = fn.GetZeroval(UCHG07);
                UCHG08 = fn.GetZeroval(UCHG08);
                UCHG09 = fn.GetZeroval(UCHG09);
                UCHG10 = fn.GetZeroval(UCHG10);
            }
            Myrd.Close();
            ODA_CHGDisplay();
        }
        
    }
    public void paymentdetail_flaggupdate(bool flag)
    {
        Payment_detal_table1.Visible = flag;
        Payment_detal_table2.Visible = flag;
        Payment_detal_table3.Visible = flag;
        Payment_detal_table4.Visible = flag;
        Payment_detal_table5.Visible = flag;
        Payment_detal_table6.Visible = flag;
        Payment_detal_table7.Visible = flag;
        Payment_detal_table8.Visible = flag;
        Payment_detal_table9.Visible = flag;
        Payment_detal_table110.Visible = flag;
       
    }
    
    public void All_Main_Details_flaggupdate(bool flag)
    {
        DOCKET_DETAIL_ROW3.Visible = flag;
        DOCKET_DETAIL_ROW4.Visible = flag;
        DOCKET_DETAIL_ROW5.Visible = flag;
        Cnor_Cnee_detail.Visible = flag;
        Permit_tracker_detail.Visible = flag;
        Invoice_detail.Visible = flag;
        Consignment_detail.Visible = flag;
        Documents_detail.Visible = flag;
        paymentdetail.Visible = flag;
        Btn_enable.Visible = flag;
     }
  
    public void COD_DOC_CHGDisplay()
    {
        if (chkCoddoc.Checked == false)
        {
            SCHG12 = "0";
        }

    }
    public void ODA_CHGDisplay()
    {
        string oda_yn = "";
        string dest_to = destto.Text.ToString(), Pkgsno = pkg.Text.ToString(), CHgwt = cwt.Text.ToString(), party_code = consignor_Bill.Text.ToString();
        double odakm = 0;
        string Oda_charge = "0.00", trdays = "0";
        string sql = "select Location,oda_yn from webx_citymaster where location='" + dest_to + "'  ";
        SqlCommand cmd = new SqlCommand(sql, sqlConn);
        SqlDataReader Dr_Oda1;

        Dr_Oda1 = cmd.ExecuteReader();
        if (Dr_Oda1.Read())
        {
            oda_yn = Convert.ToString(Dr_Oda1["oda_yn"]);
        }
        Dr_Oda1.Close();
        if (oda_yn == "Y")
        {
            chkoda.Checked = true;
        }
        
       
       

        if (oda_yn == "Y")
        {
            if (chkoda.Checked == true)
            {
                
                sql = "select Location,odakm from webx_citymaster where location='" + dest_to + "'  ";
                 cmd = new SqlCommand(sql, sqlConn);
                SqlDataReader Dr_Oda;

                Dr_Oda = cmd.ExecuteReader();
                if (Dr_Oda.Read())
                {
                    odakm = Convert.ToDouble(Dr_Oda["odakm"]);
                }
                Dr_Oda.Close();

                string slab_code = "", matrix_type;
                if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
                {

                    sql = "Select slab_code,matrix_type from WEBX_Default_CONTRACT_ODAMATRIX_SLABHDR where contract_type='" + paybas.Text + "' and convert(numeric,(case when matrix_type='W' then '" + CHgwt + "' else '" + Pkgsno + "' end),106) between slab_from and slab_to";
                }
                else
                {
                    sql = "Select slab_code,matrix_type from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR where custcode='" + party_code + "' and convert(numeric,(case when matrix_type='W' then '" + CHgwt + "' else '" + Pkgsno + "' end),106) between slab_from and slab_to";
                }
                cmd = new SqlCommand(sql, sqlConn);
                Dr_Oda = cmd.ExecuteReader();
                if (Dr_Oda.Read())
                {
                    slab_code = Convert.ToString(Dr_Oda["slab_code"]);
                    matrix_type = Convert.ToString(Dr_Oda["matrix_type"]);
                }
                else
                {
                    slab_code = "";
                }
                Dr_Oda.Close();

                if (slab_code != "")
                {
                    string ESS_code = "", Min_ODAChrg;
                    if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
                    {

                        sql = "Select ESS_code,Min_ODAChrg from WEBX_Default_CONTRACT_ODAMATRIX_DISTHDR where contract_type='" + paybas.Text + "' and " + odakm + " between ESS_from and Ess_to";
                    }
                    else
                    {
                        sql = "Select ESS_code,Min_ODAChrg from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR where custcode='" + party_code + "' and " + odakm + " between ESS_from and Ess_to";
                    }
                    
                    cmd = new SqlCommand(sql, sqlConn);
                    Dr_Oda = cmd.ExecuteReader();
                    if (Dr_Oda.Read())
                    {
                        ESS_code = Convert.ToString(Dr_Oda["ESS_code"]);
                        Min_ODAChrg = Convert.ToString(Dr_Oda["Min_ODAChrg"]);
                        if (Min_ODAChrg is DBNull)
                        {
                            Min_ODAChrg = "0";
                        }
                    }
                    Dr_Oda.Close();
                    if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
                    {

                        sql = "select " + slab_code + " as Oda_charge,trdays from WEBX_Default_CONTRACT_ODAMATRIX_CHARGE where contract_type='"+paybas.Text+"' and ESS_code='" + ESS_code + "'";
                    }
                    else
                    {
                        sql = "select " + slab_code + " as Oda_charge,trdays from WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE where  custcode='" + party_code + "' and  ESS_code='" + ESS_code + "'";
                    }
                   
                    cmd = new SqlCommand(sql, sqlConn);
                    Dr_Oda = cmd.ExecuteReader();
                    if (Dr_Oda.Read())
                    {
                        Oda_charge = Convert.ToString(Dr_Oda["Oda_charge"]);

                        if (Oda_charge is DBNull)
                        {
                            Oda_charge = "0.00";
                        }
                        trdays = Convert.ToString(Dr_Oda["trdays"]);
                        if (trdays is DBNull || trdays=="")
                        {
                            trdays = "0";
                        }
                    }
                    Dr_Oda.Close();
                    string EDDFrom = "ODA";
                    EDD_calc(EDDFrom, Convert.ToInt16(trdays));
                }

            }

        }
        SCHG19 = Oda_charge;

    }

    public void Contract_for_Others()
    {
        //**********************for volumetric & cod dod*************************************************
        string Party_code = consignor_Bill.Text.ToString();
        if (paybas.SelectedValue == "P02" || paybas.SelectedValue == "P08" || paybas.SelectedValue == "P09")
        {
            string sql_checkbox = "select cod_dod_yn,vol_yn,oda_yn  from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";

            SqlDataReader dr_chk;

            SqlCommand cmd = new SqlCommand(sql_checkbox, sqlConn);
            dr_chk = cmd.ExecuteReader();
            string vol_yn = "", cod_dod_yn = "";


            if (dr_chk.Read())
            {
                vol_yn = Convert.ToString(dr_chk["vol_yn"]);
                if (vol_yn == "" || vol_yn is DBNull)
                {
                    vol_yn = "N";
                }
                if (vol_yn == "Y")
                {
                    chkcft.Enabled = true;
                }
                else
                {
                    chkcft.Enabled = false;
                }
                oda_yn = Convert.ToString(dr_chk["oda_yn"]);
                if (oda_yn == "" || oda_yn is DBNull)
                {
                    oda_yn = "N";
                }
                if (oda_yn == "Y")
                {
                    chkoda.Enabled = true;
                }
                else
                {
                    chkoda.Enabled = false;
                }

                cod_dod_yn = Convert.ToString(dr_chk["cod_dod_yn"]);
                if (cod_dod_yn == "" || cod_dod_yn is DBNull)
                {
                    cod_dod_yn = "N";
                }
                if (cod_dod_yn == "Y")
                {
                    chkCoddoc.Enabled = true;
                }
                else
                {
                    chkCoddoc.Enabled = false;
                }
            }
            dr_chk.Close();
        }
    }


    public void Contract_for_Others_paid_topay()
    {
        //**********************for volumetric & cod dod*************************************************
        string Party_code = consignor_Bill.Text.ToString();

        if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P02" )
        {
            string sql_checkbox = "select cod_dod_yn,vol_yn,oda_yn  from   WEBX_Default_CONTRACT_CHARGE  WITH(NOLOCK) where   contract_type='" + paybas.SelectedValue + "'";

            SqlDataReader dr_chk;

            SqlCommand cmd = new SqlCommand(sql_checkbox, sqlConn);
            dr_chk = cmd.ExecuteReader();
            string vol_yn = "", cod_dod_yn = "";


            if (dr_chk.Read())
            {
                vol_yn = Convert.ToString(dr_chk["vol_yn"]);
                if (vol_yn == "" || vol_yn is DBNull)
                {
                    vol_yn = "N";
                }
                if (vol_yn == "Y")
                {
                    chkcft.Enabled = true;
                }
                else
                {
                    chkcft.Enabled = false;
                }
                oda_yn = Convert.ToString(dr_chk["oda_yn"]);
                if (oda_yn == "" || oda_yn is DBNull)
                {
                    oda_yn = "N";
                }
                if (oda_yn == "Y")
                {
                    chkoda.Enabled = true;
                }
                else
                {
                    chkoda.Enabled = false;
                }

                cod_dod_yn = Convert.ToString(dr_chk["cod_dod_yn"]);
                if (cod_dod_yn == "" || cod_dod_yn is DBNull)
                {
                    cod_dod_yn = "N";
                }
                if (cod_dod_yn == "Y")
                {
                    chkCoddoc.Enabled = true;
                }
                else
                {
                    chkCoddoc.Enabled = false;
                }
            }
            dr_chk.Close();
        }
    }
    protected void invdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string s = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("invdt")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkdate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkdate")).Attributes.Add("onclick", s);
        }
    }

    protected void invdata_cft_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string s = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("invdt")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkdate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkdate")).Attributes.Add("onclick", s);
        }
    }


    protected void Submitbtn_Click(object sender, EventArgs e)
    {

        string Mrsno="";
        SqlCommand cmd = new SqlCommand();

        service.SelectedValue = Convert.ToString(hdnservice.Value).Trim();

        string Dockno = dockno.Text.ToString();
        string Dockdt = dockdt.Text.ToString();
        string Paybas = paybas.SelectedValue.ToString();
        string Party_code = consignor_Bill.Text.ToString();
        string Destcd = destn.Text.ToString();
        string PickupDely = cboPickupDely.SelectedValue.ToString();
        string Destfrom = destfrom.Text.ToString();
        string Destto = destto.Text.ToString();
        bool Chkcft = chkcft.Checked;
        
        string Csgncd = consignor_name_B.Text.ToString();
        string Csgnnm = "", CsgnPin = "", Csgnphone = "", Csgncity = "", Csgnadd = "", Csgnemail = "";

        
        if (Csgncd != "")
        {
            string sql = "WEBX_Customer_Other";
            cmd = new SqlCommand(sql, sqlConn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Brcd", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = Csgncd.Trim();

            SqlDataReader dr = null;
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                Csgnnm = dr.GetValue(1).ToString();
                CsgnPin = dr.GetValue(7).ToString();
                Csgnadd = dr.GetValue(2).ToString();
                Csgncity = dr.GetValue(6).ToString();
                Csgnphone = dr.GetValue(8).ToString();
                Csgnemail = dr.GetValue(9).ToString();

            }
            dr.Close();
        }
        else
        {
            Csgncd = "8888";
            Csgnnm = consignor_name.Text.ToString();
            Csgnadd = consignor_add.Text.ToString();
            CsgnPin = consignor_pin.Text.ToString();
            Csgncity = consignor_city.Text.ToString();
            Csgnphone = consignor_telno.Text.ToString();
            Csgnemail = consignor_email.Text.ToString();
        }

        string Csgecd = consignee_name_B.Text.ToString();
        string Csgenm = "", CsgePin = "", Csgephone = "", Csgecity = "", Csgeadd = "", Csgeemail = "";
        if (Csgecd != "")
        {
            string sql = "WEBX_Customer_Other";
            cmd = new SqlCommand(sql, sqlConn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Brcd", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = Csgncd.Trim();

            SqlDataReader dr_csge = null;
            dr_csge = cmd.ExecuteReader();

            if (dr_csge.Read())
            {
                Csgenm = dr_csge.GetValue(1).ToString();
                CsgePin = dr_csge.GetValue(7).ToString();
                Csgeadd = dr_csge.GetValue(2).ToString();
                Csgecity = dr_csge.GetValue(6).ToString();
                Csgephone = dr_csge.GetValue(8).ToString();
                Csgeemail = dr_csge.GetValue(9).ToString();
            }
            dr_csge.Close();
        }
        else
        {
            Csgecd = "8888";
            Csgenm = consignee_name.Text.ToString();
            Csgeadd = consignee_add.Text.ToString();
            CsgePin = consignee_pin.Text.ToString();
            Csgecity = consignee_city.Text.ToString();
            Csgephone = consignee_telno.Text.ToString();
            Csgeemail = consignee_email.Text.ToString();
        }

        string Ins = ins.Text.ToString();
        string Policyno = policyno.Text.ToString();
        string Insdt = txtinsdt.Text.ToString();
        if (Insdt == "")
        {
            Insdt = "Null";
        }
        else
        {
            Insdt = "'" + Insdt + "'";
        }
        string Totmodvat = totmodvat.Text.ToString();
        if (Totmodvat == "")
        {
            Totmodvat = "Null";
        }
        string Covers = covers.Text.ToString();
        if (Covers == "")
        {
            Covers = "Null";
        }
        string Ctrno = ctrno.Text.ToString();
        string Tpnumber = txttpno.Text.ToString();

        string Privatemark = txtprivatemark.Text.ToString();
        string cft = "";
        int total_cft = 0;
        if (chkcft.Checked)
        {
            cft = "Y";
        }
        else
        {
            cft = "N";
            total_cft = 0;
        }
        //*************permit tracker Detail ********
        string Permit_yn = "";
        if (permit_yn.Checked)
        {
            Permit_yn = "Y";
        }
        else
        {
            Permit_yn = "N";
        }
        string Permitno = permitno.Text.ToString();
        string Permitdt = "";
        string Permit_recvd_dt = "";
        string Permit_validity_at = "";
        // string Permit_yn = "N";
        string Permit_recvd_at = "";
        if (Permit_yn == "Y")
        {
            Permit_recvd_at = permit_recvd_at.SelectedValue.ToString();
            if (Permit_recvd_at == "B")
            {
                Permit_recvd_dt = permit_recvd_dt.Text.ToString();
                if (Permit_recvd_dt == "")
                {
                    Permit_recvd_dt = "";
                }
                else
                {
                    Permit_recvd_dt = fn.Mydate1(Permit_recvd_dt);//"'" + permit_recvd_at + "'";
                }
                Permit_validity_at = permit_val_dt.Text.ToString();
                if (Permit_validity_at == "")
                {
                    Permit_validity_at = "";
                }
                else
                {
                    Permit_validity_at = fn.Mydate1(Permit_validity_at);// "'" + Permit_validity_at + "'";
                }
            }
            Permitdt = permitdt.Text.ToString();
            if (Permitdt == "")
            {
                Permitdt = "";
            }
            else
            {
                Permitdt = fn.Mydate1(Permitdt);//"'" + Permitdt + "'";
            }
        }
      
        string Trn_mod = trans.SelectedValue.ToString();
        string Service_class = service.SelectedValue.ToString();
        string Ftl_type = service_ftl.SelectedValue.ToString();
        if (Service_class == "1")
        {
            Ftl_type = "";
        }
        string Pkg = pkg.Text.ToString();
        string Pkgtyp = pkgtyp.SelectedValue.ToString();
        string Awt = awt.Text.ToString();
        string Prod = prod.SelectedValue.ToString();
        string Cwt = cwt.Text.ToString();
        string Spl_inst = spl_inst.Text.ToString();
        string Staxpaidby = staxpaidby.SelectedValue.ToString();
        string Stax_regno = staxregno.Text.ToString();
        fincmplbr.Enabled = true;
        string Fincmplbr = fincmplbr.Text.ToString();
        if (Fincmplbr == "" || Fincmplbr is DBNull)
        {
            Fincmplbr = "";
        }
        
        string Frieght = frieght.Text.ToString();
        string Ratetype = ratetype.SelectedValue.ToString();

        Frieght = hdnfreight.Value;

        string Rate = hdnfreightrate.Value.ToString();
        string Stax_s = stax_s.Text.ToString();
        if (Stax_s == "")
        {
            string Stax = stax.Text.ToString();
            Stax_s = Stax;
        }
        if (Stax_s == "") { Stax_s = "0"; }
        string Otax_s = otax_s.Text.ToString();
        if (Otax_s == "")
        {
            string Otax = otax.Text.ToString();
            Otax_s = Otax;
        }
        if (Otax_s == "") { Otax_s = "0"; }
        string Hotax_s = hotax_s.Text.ToString();
        if (Hotax_s == "")
        {
            string Hotax = hotax.Text.ToString();
            Hotax_s = Hotax_s;
        }
        if (Hotax_s == "") { Hotax_s = "0"; }

        string Chg_SCHG01 = CHG_SCHG01.Value == "" ? "0.00" : CHG_SCHG01.Value;
        string Chg_SCHG02 = CHG_SCHG02.Value == "" ? "0.00" : CHG_SCHG02.Value;
        string Chg_SCHG03 = CHG_SCHG03.Value== "" ? "0.00" : CHG_SCHG03.Value;
        string Chg_SCHG04 = CHG_SCHG04.Value== "" ? "0.00" : CHG_SCHG04.Value;
        string Chg_SCHG05 = CHG_SCHG05.Value== "" ? "0.00" : CHG_SCHG05.Value;
        string Chg_SCHG06 = CHG_SCHG06.Value== "" ? "0.00" : CHG_SCHG06.Value;
        string Chg_SCHG07 = CHG_SCHG07.Value== "" ? "0.00" : CHG_SCHG07.Value;
        string Chg_SCHG08 = CHG_SCHG08.Value== "" ? "0.00" : CHG_SCHG08.Value;
        string Chg_SCHG09 = CHG_SCHG09.Value== "" ? "0.00" : CHG_SCHG09.Value;
        string Chg_SCHG10 = CHG_SCHG10.Value== "" ? "0.00" : CHG_SCHG10.Value;
        string Chg_SCHG11 = CHG_SCHG11.Value== "" ? "0.00" : CHG_SCHG11.Value;
        string Chg_SCHG12 = txtcodchrg.Text== "" ? "0.00" : txtcodchrg.Text;
        string Chg_SCHG13 = CHG_SCHG13.Value== "" ? "0.00" : CHG_SCHG13.Value;
        string Chg_SCHG14 = CHG_SCHG14.Value== "" ? "0.00" : CHG_SCHG14.Value;
        string Chg_SCHG15 = CHG_SCHG15.Value== "" ? "0.00" : CHG_SCHG15.Value;
        string Chg_SCHG16 = CHG_SCHG16.Value== "" ? "0.00" : CHG_SCHG16.Value;
        string Chg_SCHG17 = CHG_SCHG17.Value== "" ? "0.00" : CHG_SCHG17.Value;
        string Chg_SCHG18 = CHG_SCHG18.Value== "" ? "0.00" : CHG_SCHG18.Value;
        string Chg_SCHG19 = CHG_SCHG19.Value== "" ? "0.00" : CHG_SCHG19.Value;
        string Chg_SCHG20 = CHG_SCHG20.Value== "" ? "0.00" : CHG_SCHG20.Value;
        string Chg_SCHG21 = CHG_SCHG21.Value== "" ? "0.00" : CHG_SCHG21.Value;
        string Chg_SCHG22 = CHG_SCHG22.Value== "" ? "0.00" : CHG_SCHG22.Value;
        string Chg_SCHG23 = CHG_SCHG23.Value== "" ? "0.00" : CHG_SCHG23.Value;

        string Chg_UCHG01 = CHG_UCHG01.Value== "" ? "0.00" : CHG_UCHG01.Value;
        string Chg_UCHG02 = CHG_UCHG02.Value== "" ? "0.00" : CHG_UCHG02.Value;
        string Chg_UCHG03 = CHG_UCHG03.Value== "" ? "0.00" : CHG_UCHG03.Value;
        string Chg_UCHG04 = CHG_UCHG04.Value== "" ? "0.00" : CHG_UCHG04.Value;
        string Chg_UCHG05 = CHG_UCHG05.Value== "" ? "0.00" : CHG_UCHG05.Value;
        string Chg_UCHG06 = CHG_UCHG06.Value== "" ? "0.00" : CHG_UCHG06.Value;
        string Chg_UCHG07 = CHG_UCHG07.Value== "" ? "0.00" : CHG_UCHG07.Value;
        string Chg_UCHG08 = CHG_UCHG08.Value== "" ? "0.00" : CHG_UCHG08.Value;
        string Chg_UCHG09 = CHG_UCHG09.Value== "" ? "0.00" : CHG_UCHG09.Value;
        string Chg_UCHG10 = CHG_UCHG10.Value== "" ? "0.00" : CHG_UCHG10.Value;

        string sql_chg_stax = "Select * from WEBX_CHARGEMST";
        cmd = new SqlCommand(sql_chg_stax, sqlConn);
        SqlDataReader dr_oth_charges = null;
        dr_oth_charges = cmd.ExecuteReader();
        string ServiceTax = "", OtherTax = "", H_OtherTax = "";
        while (dr_oth_charges.Read())
        {
            ServiceTax = Convert.ToString(dr_oth_charges["ServiceTax"].ToString());
            OtherTax = Convert.ToString(dr_oth_charges["EDU_CESS_RATE"].ToString());

            H_OtherTax = Convert.ToString(dr_oth_charges["HEDU_CESS_RATE"].ToString());
        }
        dr_oth_charges.Close();
        if (Trn_mod.ToString() == "2")
        {
            ServiceTax = "3";
        }
        string svctax_str = ",svctax_rate=" + ServiceTax + ",cess_rate  =" + OtherTax + ",H_cess_rate=" + H_OtherTax + "";


        SqlTransaction trn;
        trn = sqlConn.BeginTransaction();


        try  //  try FOR ALL
        {

            cmd = new SqlCommand("usp_docket_Single_entry", sqlConn, trn);
            cmd.CommandType = CommandType.StoredProcedure;


            cmd.Parameters.AddWithValue("@DOCKNO", Dockno.ToString());
            cmd.Parameters.AddWithValue("@DOCKSF", ".");
            cmd.Parameters.AddWithValue("@DOCKDT", fn.Mydate1(Dockdt.ToString()));
            cmd.Parameters.AddWithValue("@ORGNCD", Session["brcd"].ToString());
            cmd.Parameters.AddWithValue("@DESTCD", Destcd.ToString());
            cmd.Parameters.AddWithValue("@REASSIGN_DESTCD", Destcd.ToString());
            cmd.Parameters.AddWithValue("@from_loc", Destfrom.ToString());
            cmd.Parameters.AddWithValue("@to_loc", Destto.ToString());
            cmd.Parameters.AddWithValue("@dly_loc", Destto.ToString());
            cmd.Parameters.AddWithValue("@CDELDT", fn.Mydate1(txtDelyDt.Text.ToString()));
            cmd.Parameters.AddWithValue("@PAYBAS", Paybas.ToString());

            cmd.Parameters.AddWithValue("@PKGSNO", Pkg.ToString());
            cmd.Parameters.AddWithValue("@ACTUWT", Awt.ToString());
            cmd.Parameters.AddWithValue("@CHRGWT", Cwt.ToString());


            cmd.Parameters.AddWithValue("@PRODCD", Prod.ToString());
            cmd.Parameters.AddWithValue("@PKGSTYP", Pkgtyp.ToString());
            cmd.Parameters.AddWithValue("@spl_svc_req", Spl_inst.ToString());
            cmd.Parameters.AddWithValue("@stax_paidby", Staxpaidby.ToString());
            cmd.Parameters.AddWithValue("@stax_regno", Stax_regno.ToString());
            // cmd.Parameters.AddWithValue("@BILLSTATUS", "Uncleared");
            cmd.Parameters.AddWithValue("@Service_Class", Service_class.ToString());
            cmd.Parameters.AddWithValue("@ftl_types", Ftl_type.ToString());
            cmd.Parameters.AddWithValue("@fincmplbr", Fincmplbr.ToString());
            cmd.Parameters.AddWithValue("@CSGNCD", Csgncd.ToString());
            cmd.Parameters.AddWithValue("@CSGNNM", Csgnnm.ToString());
            cmd.Parameters.AddWithValue("@CSGNADDR", Csgnadd.ToString());
            cmd.Parameters.AddWithValue("@CSGNCity", Csgncity.ToString());
            cmd.Parameters.AddWithValue("@CSGNPinCode", CsgnPin.ToString());
            cmd.Parameters.AddWithValue("@CSGNTeleNo", Csgnphone.ToString());
            cmd.Parameters.AddWithValue("@CSGNEmail", Csgnemail.ToString());
            cmd.Parameters.AddWithValue("@CSGECD", Csgecd.ToString());
            cmd.Parameters.AddWithValue("@CSGENM", Csgenm.ToString());
            cmd.Parameters.AddWithValue("@CSGEADDR", Csgeadd.ToString());
            cmd.Parameters.AddWithValue("@CSGECity", Csgecity.ToString());
            cmd.Parameters.AddWithValue("@CSGEPinCode", CsgePin.ToString());
            cmd.Parameters.AddWithValue("@CSGETeleNo", Csgephone.ToString());
            cmd.Parameters.AddWithValue("@CSGEEmail", Csgeemail.ToString());
            cmd.Parameters.AddWithValue("@PARTY_CODE", Party_code.ToString());
            cmd.Parameters.AddWithValue("@privatemark", Privatemark.ToString());
            cmd.Parameters.AddWithValue("@tpnumber", Tpnumber.ToString());
            cmd.Parameters.AddWithValue("@TRN_MOD", Trn_mod.ToString());
            if(chkCoddoc.Checked==true)
                cmd.Parameters.AddWithValue("@COD_DOD", "Y");
            else
                cmd.Parameters.AddWithValue("@COD_DOD", "N");
            if (chkcft.Checked)
            {
                cmd.Parameters.AddWithValue("@CFT_YN", "Y");
            }
            else
            {
                cmd.Parameters.AddWithValue("@CFT_YN", "N");
            }
            cmd.Parameters.AddWithValue("@DIPLOMAT", "N");
            cmd.Parameters.AddWithValue("@DACC_YN", "N");
            cmd.Parameters.AddWithValue("@LocalCN_YN", "N");
            cmd.Parameters.AddWithValue("@Part", "N");
            cmd.Parameters.AddWithValue("@Pickup_Dely", PickupDely.ToString());
            cmd.Parameters.AddWithValue("@UGC", "N");
            cmd.Parameters.AddWithValue("@permit_yn", Permit_yn.ToString());
            cmd.Parameters.AddWithValue("@permit_recvd_at", Permit_recvd_at.ToString());
            if (Permitdt == "")
            {
                cmd.Parameters.AddWithValue("@permitdt", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@permitdt", Permitdt.ToString());
            }
            if (Permit_recvd_dt == "")
            {
                cmd.Parameters.AddWithValue("@permit_recvd_dt", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@permit_recvd_dt", Permit_recvd_dt.ToString());
            }
            cmd.Parameters.AddWithValue("@Permit_No", Permitno.ToString());
            if (Permit_validity_at == "")
            {
                cmd.Parameters.AddWithValue("@permit_validity_dt", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@permit_validity_dt", Permit_validity_at.ToString());
            }

            cmd.Parameters.AddWithValue("@ENTRYBY", Session["empcd"].ToString());
            cmd.Parameters.AddWithValue("@Docket_Mode", "F");

            cmd.ExecuteNonQuery();


            if (rptDocketList.Visible != false)
            {
                foreach (GridViewRow rptrow in rptDocketList.Rows)
                {
                    HiddenField Doc_srno = (HiddenField)rptrow.FindControl("Doc_srno");
                    TextBox docu = (TextBox)rptrow.FindControl("docu");

                    cmd = new SqlCommand("usp_docket_State_document_entry", sqlConn, trn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@DOCKNO", Dockno.ToString());
                    cmd.Parameters.AddWithValue("@DOCKSF", ".");

                    cmd.Parameters.AddWithValue("@SRNO", Convert.ToInt16(Doc_srno.Value));
                    cmd.Parameters.AddWithValue("@DOCUMENTNO", docu.Text.ToString());

                    cmd.ExecuteNonQuery();
                }
            }

            if (chkcft.Checked)
            {
                foreach (GridViewRow gridrow in invdata_cft.Rows)
                {

                    TextBox invno = (TextBox)gridrow.FindControl("invno");
                    TextBox invdt = (TextBox)gridrow.FindControl("invdt");
                    TextBox declvalue = (TextBox)gridrow.FindControl("declvalue");
                    TextBox pkgno = (TextBox)gridrow.FindControl("pkgno");
                    TextBox actwt = (TextBox)gridrow.FindControl("actwt");
                    TextBox length = (TextBox)gridrow.FindControl("length");
                    TextBox breadth = (TextBox)gridrow.FindControl("breadth");
                    TextBox height = (TextBox)gridrow.FindControl("height");
                    TextBox cftval = (TextBox)gridrow.FindControl("height");
                    if (invno.Text.ToString() != "")
                    {
                        cmd = new SqlCommand("usp_docket_Invoie_entry", sqlConn, trn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@DOCKNO", Dockno.ToString());
                        cmd.Parameters.AddWithValue("@INVNO", invno.Text.ToString());
                        cmd.Parameters.AddWithValue("@INVDT", fn.Mydate1(invdt.Text.ToString()));
                        cmd.Parameters.AddWithValue("@DECLVAL", declvalue.Text.ToString());
                        cmd.Parameters.AddWithValue("@PKGSNO", pkgno.Text.ToString());
                        cmd.Parameters.AddWithValue("@ACTUWT", actwt.Text.ToString());
                        cmd.Parameters.AddWithValue("@VOL_L", length.Text.ToString());
                        cmd.Parameters.AddWithValue("@VOL_B", breadth.Text.ToString());
                        cmd.Parameters.AddWithValue("@VOL_H", height.Text.ToString());
                        cmd.Parameters.AddWithValue("@TOT_CFT", cftval.Text.ToString());

                        cmd.ExecuteNonQuery();
                    }
                }

            }
            else
            {
                foreach (GridViewRow gridrow in invdata.Rows)
                {

                    TextBox invno = (TextBox)gridrow.FindControl("invno");
                    TextBox invdt = (TextBox)gridrow.FindControl("invdt");
                    TextBox declvalue = (TextBox)gridrow.FindControl("declvalue");
                    TextBox pkgno = (TextBox)gridrow.FindControl("pkgno");
                    TextBox actwt = (TextBox)gridrow.FindControl("actwt");

                    if (invno.Text.ToString() != "")
                    {
                        cmd = new SqlCommand("usp_docket_Invoie_entry", sqlConn, trn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@DOCKNO", Dockno.ToString());
                        cmd.Parameters.AddWithValue("@INVNO", invno.Text.ToString());
                        cmd.Parameters.AddWithValue("@INVDT", fn.Mydate1(invdt.Text.ToString()));
                        cmd.Parameters.AddWithValue("@DECLVAL", declvalue.Text.ToString());
                        cmd.Parameters.AddWithValue("@PKGSNO", pkgno.Text.ToString());
                        cmd.Parameters.AddWithValue("@ACTUWT", actwt.Text.ToString());
                        cmd.Parameters.AddWithValue("@VOL_L", DBNull.Value);
                        cmd.Parameters.AddWithValue("@VOL_B", DBNull.Value);
                        cmd.Parameters.AddWithValue("@VOL_H", DBNull.Value);
                        cmd.Parameters.AddWithValue("@TOT_CFT", DBNull.Value);

                        cmd.ExecuteNonQuery();
                    }

                }
            }


            cmd = new SqlCommand("usp_docket_Charges_entry", sqlConn, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DOCKNO", Dockno.ToString());
            cmd.Parameters.AddWithValue("@RATE_TYPE", Ratetype);
            cmd.Parameters.AddWithValue("@FRT_RATE", Convert.ToDouble(Rate));

            // cmd.Parameters.AddWithValue("@DECLVAL", Frieght);

            cmd.Parameters.AddWithValue("@FREIGHT_CALC", Convert.ToDouble(Frieght.ToString()));
            cmd.Parameters.AddWithValue("@FREIGHT", Convert.ToDouble(Frieght.ToString()));
            cmd.Parameters.AddWithValue("@FOV", Convert.ToDouble(Chg_SCHG11.ToString()));
            cmd.Parameters.AddWithValue("@SCHG01", Convert.ToDouble(Chg_SCHG01.ToString()));
            cmd.Parameters.AddWithValue("@SCHG02", Convert.ToDouble(Chg_SCHG02.ToString()));
            cmd.Parameters.AddWithValue("@SCHG03", Convert.ToDouble(Chg_SCHG03.ToString()));
            cmd.Parameters.AddWithValue("@SCHG04", Convert.ToDouble(Chg_SCHG04.ToString()));
            cmd.Parameters.AddWithValue("@SCHG05", Convert.ToDouble(Chg_SCHG05.ToString()));
            cmd.Parameters.AddWithValue("@SCHG06", Convert.ToDouble(Chg_SCHG06.ToString()));
            cmd.Parameters.AddWithValue("@SCHG07", Convert.ToDouble(Chg_SCHG07.ToString()));
            cmd.Parameters.AddWithValue("@SCHG08", Convert.ToDouble(Chg_SCHG08.ToString()));
            cmd.Parameters.AddWithValue("@SCHG09", Convert.ToDouble(Chg_SCHG09.ToString()));
            cmd.Parameters.AddWithValue("@SCHG10", Convert.ToDouble(Chg_SCHG10.ToString()));
            cmd.Parameters.AddWithValue("@SCHG11", Convert.ToDouble(Chg_SCHG11.ToString()));
            cmd.Parameters.AddWithValue("@SCHG12", Convert.ToDouble(Chg_SCHG12.ToString()));
            cmd.Parameters.AddWithValue("@SCHG13", Convert.ToDouble(Chg_SCHG13.ToString()));
            cmd.Parameters.AddWithValue("@SCHG14", Convert.ToDouble(Chg_SCHG14.ToString()));
            cmd.Parameters.AddWithValue("@SCHG15", Convert.ToDouble(Chg_SCHG15.ToString()));
            cmd.Parameters.AddWithValue("@SCHG16", Convert.ToDouble(Chg_SCHG16.ToString()));
            cmd.Parameters.AddWithValue("@SCHG17", Convert.ToDouble(Chg_SCHG17.ToString()));
            cmd.Parameters.AddWithValue("@SCHG18", Convert.ToDouble(Chg_SCHG18.ToString()));
            cmd.Parameters.AddWithValue("@SCHG19", Convert.ToDouble(Chg_SCHG19.ToString()));
            cmd.Parameters.AddWithValue("@SCHG20", Convert.ToDouble(Chg_SCHG20.ToString()));
            cmd.Parameters.AddWithValue("@SCHG21", Convert.ToDouble(Chg_SCHG21.ToString()));
            cmd.Parameters.AddWithValue("@SCHG22", Convert.ToDouble(Chg_SCHG22.ToString()));
            cmd.Parameters.AddWithValue("@SCHG23", Convert.ToDouble(Chg_SCHG23.ToString()));
            cmd.Parameters.AddWithValue("@UCHG01", Convert.ToDouble(Chg_UCHG01.ToString()));
            cmd.Parameters.AddWithValue("@UCHG02", Convert.ToDouble(Chg_UCHG02.ToString()));
            cmd.Parameters.AddWithValue("@UCHG03", Convert.ToDouble(Chg_UCHG03.ToString()));
            cmd.Parameters.AddWithValue("@UCHG04", Convert.ToDouble(Chg_UCHG04.ToString()));
            cmd.Parameters.AddWithValue("@UCHG05", Convert.ToDouble(Chg_UCHG05.ToString()));
            cmd.Parameters.AddWithValue("@UCHG06", Convert.ToDouble(Chg_UCHG06.ToString()));
            cmd.Parameters.AddWithValue("@UCHG07", Convert.ToDouble(Chg_UCHG07.ToString()));
            cmd.Parameters.AddWithValue("@UCHG08", Convert.ToDouble(Chg_UCHG08.ToString()));
            cmd.Parameters.AddWithValue("@UCHG09", Convert.ToDouble(Chg_UCHG09.ToString()));
            cmd.Parameters.AddWithValue("@UCHG10", Convert.ToDouble(Chg_UCHG10.ToString()));

            cmd.Parameters.AddWithValue("@SubTotal", Convert.ToDouble(subtotal.Text.ToString()));
            cmd.Parameters.AddWithValue("@SVCTAX", Convert.ToDouble(Stax_s));
            cmd.Parameters.AddWithValue("@CESS", Convert.ToDouble(Otax_s));
            cmd.Parameters.AddWithValue("@H_CESS", Convert.ToDouble(Hotax_s));
            cmd.Parameters.AddWithValue("@DKTTOT", Convert.ToDouble(total.Text.ToString()));

            cmd.ExecuteNonQuery();


            string strins = "UPDATE webx_master_docket SET insuyn='" + ins.SelectedValue + "',insupl='" + policyno.Text + "',";
            strins += "insupldt='" + fn.Mydate1(txtinsdt.Text) + "',ctr_no='" + ctrno.Text + "',";
            strins += "tpnumber='" + txttpno.Text + "',privatemark='" + txtprivatemark.Text + "',";
            if (modvat.Checked == true)
                strins += "modvat_encl='Y',";
            else
                strins += "modvat_encl='N',";
            if (covers.Text.CompareTo("") == 0)
                covers.Text = "0.00";
            strins += "tot_modvat=" + covers.Text + ",";

            if (totmodvat.Text.CompareTo("") == 0)
                totmodvat.Text = "0.00";
            strins += "tot_covers=" + totmodvat.Text + ",";
            strins += "loadtype='" + cmbloadtype.SelectedValue + "',";
            strins += "businesstype='" + cmbbustype.Text + "',";
            strins += "obdno='" + txtobdno.Text + "',";
            strins += "entrysheetno='" + txtentrysheetno.Text + "' ";

            strins += " WHERE dockno='" + dockno.Text + "'";

            cmd = new SqlCommand(strins, sqlConn, trn);
            cmd.ExecuteNonQuery();
            //Update count in Dcr master
            strins = "update webx_dcr_header set used=isnull(used,0)+1 where '" + dockno.Text + "' between doc_sr_from and doc_sr_to and len('" + dockno.Text + "')=len(doc_sr_from)";
            cmd = new SqlCommand(strins, sqlConn, trn);
            cmd.ExecuteNonQuery();

            // COD/DOD CHRGES
            if (chkCoddoc.Checked == true)
            {
                strins = "UPDATE webx_master_docket SET cod_dod='Y',";
                if (txtcodamt.Text.CompareTo("") == 0)
                    txtcodamt.Text = "0.00";
                strins += "codamt=" + txtcodamt.Text + ",";

                if (txtcodchrg.Text.CompareTo("") == 0)
                    txtcodchrg.Text = "0.00";
                strins += "codchrg=" + txtcodchrg.Text;
                strins += " WHERE dockno='" + dockno.Text + "'";

                cmd = new SqlCommand(strins, sqlConn, trn);
                cmd.ExecuteNonQuery();
            }
            else
            {
                strins = "UPDATE webx_master_docket SET cod_dod='N',";
                strins += "codno='',codamt=0.00,codchrg=0.00";
                strins += " WHERE dockno='" + dockno.Text + "'";

                cmd = new SqlCommand(strins, sqlConn, trn);
                cmd.ExecuteNonQuery();
            }

            if (Session["Client"].ToString() == "RLL")
            {
                if (paybas.SelectedValue == "P02")
                {
                    string sql_TBB_acct = "exec usp_TBB_Transaction 1,'" + Dockno.ToString() + "','" + fin2dig_year + "','" + Session["empcd"].ToString() + "',''";
                    cmd = new SqlCommand(sql_TBB_acct, sqlConn, trn);
                    cmd.ExecuteNonQuery();
                }
            }





            if (paybas.SelectedValue == "P01")
            {
                string UCGmrsno = "", empcd = Session["empcd"].ToString(), empnm = fn.GetEmpName(empcd);
                string dbcode = Session["brcd"].ToString(), dbname = fn.GetLocation(dbcode);
                Mrsno = fn.MRNogen(Session["brcd"].ToString());
                string mrbrncd = "'" + Session["brcd"].ToString().Trim() + "'";
                string mrbrnnm = "'" + fn.GetLocation(Session["brcd"].ToString()) + "'";
                double tot = Convert.ToDouble(subtotal.Text.ToString()) + Convert.ToDouble(Stax_s) + Convert.ToDouble(Otax_s) + Convert.ToDouble(Hotax_s);
                double deductamt = 0, ot = 0, dc = 0, tds = 0, acd = 0, otded = 0, DIPLOMATCHG = 0;

                string sql = "Insert into webx_MR_HDR (ENTRYBY,ENTRYDT,MRSNO,MRSSF, MRSDT, MRSTYPE, MRSBR, MRBRNNM, DOCKNO, DOCKSF, DOCKDT, DOCKDLYDT, PTCD, PTNAME, PTPIN, PTTEL, PTADD, ORGNCD, DOCBKNM, DESTCD, DOCDLNM, NOPKGS, CHRGWT, PAYBAS, DELBASD, MRSAMT, NETAMT, DEDUCTION,MRS_CLOSED,ba_emp_cd,ba_emp_nm,REBOOK_FLAG,mrcollbrcd) values ('" + empcd + "',getdate(), '" + Mrsno + "','.',getdate(), '1' , " + mrbrncd + ", " + mrbrnnm + ", '" + Dockno + "', '.', '" + fn.Mydate1(Dockdt.ToString()) + "', '" + fn.Mydate1(txtDelyDt.Text.ToString()) + "', '" + Csgncd.ToString() + "',' " + Csgnnm.ToString() + "', '" + CsgnPin.ToString() + "', '" + Csgnphone.ToString() + "', '" + Csgnadd.ToString() + "', '" + Session["brcd"].ToString() + "', '" + fn.GetLocation(Session["brcd"].ToString()) + "', '" + Destcd.ToString() + "', '" + fn.GetLocation(Destcd.ToString()) + "', '" + Pkg.ToString() + "', '" + Cwt.ToString() + "', '" + Paybas.ToString() + "', '" + fn.Getpaybas(Paybas.ToString()) + "', '" + tot + "','" + tot + "', '" + deductamt + "','N','0','" + empnm + "','N', " + mrbrncd + ")";
                cmd = new SqlCommand(sql, sqlConn, trn);
                cmd.ExecuteNonQuery();
                sql = "update webx_MR_HDR set Col_frt=" + subtotal.Text.ToString() + ",Col_oth=" + ot + ",col_stax=" + Stax_s + ",COL_DLYCHG=" + dc + ",DED_TDS=" + tds + ",DED_ONAC=" + acd + ",DED_OTH=" + otded + ",DIPLOMATCHG=" + DIPLOMATCHG + ",DELSERCHRG_DED=0,DIPLOMATCHG_DED=0,col_cess=" + Otax_s + ",col_H_Cess=" + Hotax_s + "  " + svctax_str + " where mrsno='" + Mrsno + "'";
                cmd = new SqlCommand(sql, sqlConn, trn);
                cmd.ExecuteNonQuery();

                string sql_MR_update = "update webx_trans_docket_status set MR='Y' where dockno='" + Dockno.ToString() + "'";
                cmd = new SqlCommand(sql_MR_update, sqlConn, trn);
                cmd.ExecuteNonQuery();
                string sql_Paid_acct = "exec usp_paidmrtransaction 1,'" + Dockno.ToString() + "','" + fin2dig_year + "','" + Session["empcd"].ToString() + "',''";
                cmd = new SqlCommand(sql_Paid_acct, sqlConn, trn);
                cmd.ExecuteNonQuery();
            }


                /// NEW CHANGE IN STATUS TABLE FOR INVOICE DETAILS
                
                //  RETRIVEING INVOICE DEATAILS
            string strinvno = "",strinvdt="";
            double totinvamt = 0.00;
            if (chkcft.Checked == true)
            {
                foreach (GridViewRow gridrow in invdata_cft.Rows)
                {
                    TextBox txtinvno = (TextBox)gridrow.FindControl("invno");
                    TextBox txtinvdt = (TextBox)gridrow.FindControl("invdt");
                    TextBox txtdeclvalue = (TextBox)gridrow.FindControl("declvalue");

                    if (strinvno.CompareTo("") == 0)
                        strinvno = txtinvno.Text;
                    else
                        strinvno = strinvno + "," + txtinvno.Text;

                    if (strinvdt.CompareTo("") == 0)
                        strinvdt = fn.Mydate(txtinvdt.Text);

                    totinvamt = totinvamt + returnDouble(txtdeclvalue.Text);
                }

            }
            else
            {
                foreach (GridViewRow gridrow in invdata.Rows)
                {
                    TextBox txtinvno = (TextBox)gridrow.FindControl("invno");
                    TextBox txtinvdt = (TextBox)gridrow.FindControl("invdt");
                    TextBox txtdeclvalue = (TextBox)gridrow.FindControl("declvalue");

                    if (strinvno.CompareTo("") == 0)
                        strinvno = txtinvno.Text;
                    else
                        strinvno = strinvno + "," + txtinvno.Text;

                    if (strinvdt.CompareTo("") == 0)
                        strinvdt = fn.Mydate(txtinvdt.Text);

                    totinvamt = totinvamt + returnDouble(txtdeclvalue.Text);
                }
            }
                string strupdate = "UPDATE webx_trans_docket_status SET invno='" + strinvno + "',invdt='" + strinvdt + "',invamt=" + totinvamt.ToString("F2") + " WHERE dockno='" + Dockno.ToString() + "'";
                cmd = new SqlCommand(strupdate, sqlConn, trn);
                cmd.ExecuteNonQuery();

                
                



        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n',' ');
            trn.Rollback();
            return;
        }

        trn.Commit();

        if (paybas.SelectedValue == "P01")
            {
                Response.Redirect("Docket_submit_done.aspx?Dockno=" + Dockno.ToString() + "&Mrsno=" + Mrsno.ToString());
            }
            else
            {
                Response.Redirect("Docket_submit_done.aspx?Dockno=" + Dockno.ToString() + "&Mrsno=NA");
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
        catch (Exception e)
        {
            return 0.00;
        }
    }

}

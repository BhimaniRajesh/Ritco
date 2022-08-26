/****************************************************************************************************************
* 
*                                   MODULE NAME : UNICODE DOCKET EDITION
*                                       VERSION : 2.0(Refined)
**      
***************************************************************************************************************/
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


public partial class GUI_Operation_Singlescreen_docketentry_docketoperationedit : System.Web.UI.Page
{

    public static string SQLstr, mode = "Y",  System_Manual = "", wstr="",COD_DOD_YN="N";
    public static int intTotalRecords, totdoc;

    //Docket Name is dynamic and depends on DB to use in aspx we store it in string
    protected string sdkt_call="abc";
    
    MyFunctions fn = new MyFunctions();
    PaidMR paidmr = new PaidMR();
    
    //Contract Charges For Applicable_YN = Y
    public static string strContractCharges;
    public static string blnAppForFOVCharges;
    public static int tabcsr = 0;
    //Contract Charges For Applicable_YN = N
    public static string strContractChargesHidden,dktlenght, branchname, Locationstr = "", Custcdstr = "", CityStr = "", ODACityStr="", Validate_YN = "N", oda_yn = "",Contrct_YN = "N";
    public static double ServiceTax = 0, OtherTax = 0,H_OtherTax=0, CFT_Ratio=0;
    public static string SCHG01, SCHG02, SCHG03, SCHG04, SCHG05, SCHG06, SCHG07, SCHG08, SCHG09, SCHG10, SCHG11, SCHG12, SCHG13, SCHG14, SCHG15, SCHG16, SCHG17, SCHG18, SCHG19, SCHG20, SCHG21,SCHG22, SCHG23, UCHG01, UCHG02, UCHG03, UCHG04, UCHG05, UCHG06, UCHG07, UCHG08, UCHG09, UCHG10;
    SqlConnection conn;

    string docno = "";
    protected static DataTable dtinvoice;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        docno = Request.QueryString["dockno"].ToString();
        hdnmode.Value = "EDIT";
        
/*****************************************************************************************************************
                                    SETING Page_Load DEFAULTS
 ****************************************************************************************************************/
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
    	dktlenght= Session["Dktlength"].ToString().Trim();
        lbldocklabel.Text = Session["DocketCalledAs"].ToString() + " Number";
        sdkt_call = Session["DocketCalledAs"].ToString();
        //lbldockno.Text = docno;
        if (!IsPostBack)
        {

            string scr = @"<script>
                    function update1(elemValue1,elemValue2)
                  {
                     document.getElementById('ctl00_MyCPH1_consignor_Bill').value=elemValue1;
                     document.getElementById('ctl00_MyCPH1_consignor_Bill_name').value=elemValue2;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1", scr);
            btnPopUp.Attributes.Add("onclick", "window.open('popup_cust.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");


            string scr1 = @"<script>
                    function update11(elemValue1,elemValue2)
                  {
                     document.getElementById('ctl00_MyCPH1_consignor_name_B').value=elemValue1;
                     document.getElementById('ctl00_MyCPH1_consignor_name_B_nm').value=elemValue2;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update11", scr1);
            btn1.Attributes.Add("onclick", "window.open('popup_cust_csgn.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");


            string scr2 = @"<script>
                    function update111(elemValue1,elemValue2)
                  {
                     document.getElementById('ctl00_MyCPH1_consignee_name_B').value=elemValue1;
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
            SqlCommand cmd = new SqlCommand(sql, conn);
            drpaybas = cmd.ExecuteReader();

            paybas.Items.Clear();
            paybas.Items.Add("Select");
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
             cmd = new SqlCommand(sql, conn);
            drpkgtyp = cmd.ExecuteReader();

            pkgtyp.Items.Clear();
            pkgtyp.Items.Add(new ListItem("Select",""));
            while (drpkgtyp.Read())
            {

                pkgtyp.Items.Add(new ListItem(drpkgtyp.GetValue(1).ToString(), drpkgtyp.GetValue(0).ToString()));

            }
           
            drpkgtyp.Close();
            //******************end  Packging type*************************************


            //******************Starts mode*************************************
            SqlDataReader drtrnmod;
            string sql1 = "select codeID,codedesc from Webx_Master_General where codetype='trn'";
            SqlCommand cmd1 = new SqlCommand(sql1, conn);
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
             cmd1 = new SqlCommand(sql1, conn);
             drprod = cmd1.ExecuteReader();

             prod.Items.Clear();
             prod.Items.Add(new ListItem("Select", ""));
            while (drprod.Read())
            {
                prod.Items.Add(new ListItem(drprod.GetValue(1).ToString(), drprod.GetValue(0).ToString()));

            }

            drprod.Close();
            //*****************************end products*********************************


             //*****************************starts service**************************
            SqlDataReader drservice;
            sql = "select codeid,codedesc from webx_master_general where codetype='SVRTYPE'";
             cmd = new SqlCommand(sql, conn);
             drservice = cmd.ExecuteReader();
             service.Items.Clear();
             //service.Items.Add(new ListItem("Select","0"));
            while (drservice.Read())
            {
                service.Items.Add(new ListItem(drservice.GetValue(1).ToString(), drservice.GetValue(0).ToString()));
            }
            drservice.Close();
            //*****************************end service*******************************************************

            //*****************************starts FTL type**************************
            SqlDataReader drftltype;
            sql = "Select CodeId,CodeDesc From webx_master_general where CodeType='FTLTYP' and StatusCode='Y'";
            //sql = "Select distinct ftltype from webx_ftlmaster  order by FTLtype";
            cmd = new SqlCommand(sql, conn);
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
            
           
            noofrows1.Text = "1";
            
            int onofrows1 = Convert.ToInt16(noofrows1.Text.ToString());
            addrowfn(onofrows1);//for page load


           //************************************for javascript******************************
            javascript_fn();
            //********************************************************************************
         
           //Generate SQL statement for Docket Listing
            generateSQL();

            //Paint Docket Listing based on criteria supplied by the user
            State_document_detail();
            checkloccode();
            checkcustomer();
            CheckCity();
            GetChargemst();
            paymentdetail_flaggupdate(false);
            
       

        getApplicableDocketChargesForY();
        getApplicableDocketChargesForN();
        applicableForTypeOfService();


        string sqll = "SELECT convert(varchar,dockdt,103) as dockdt,convert(varchar,insupldt,103) as insupldt,convert(varchar,cdeldt,103) as cdeldt,convert(varchar,permitdt,103) as permitdt,convert(varchar,permit_recvd_dt,103) as permit_recvd_dt,convert(varchar,permit_validity_dt,103) as permit_validity_dt,* FROM webx_master_docket WHERE dockno='" + docno + "'";
        SqlCommand cmdd = new SqlCommand(sqll, conn);
        SqlDataReader dr = cmdd.ExecuteReader();
        string consignorcode = "", consigneecode = "";
        int crec=0;
        while (dr.Read())
        {
            lbldockno.Text = dr["dockno"].ToString();
            dockno.Text = dr["dockno"].ToString();
            
            paybas.SelectedValue = dr["paybas"].ToString();
            if (dr["paybas"].ToString().CompareTo("P02") == 0 || dr["paybas"].ToString().CompareTo("P08") == 0 || dr["paybas"].ToString().CompareTo("P09") == 0)
            {
                consignor_Bill.Enabled = true;
                consignor_Bill_name.Enabled = true;
                fincmplbr.Enabled = true;
                consignor_Bill.BackColor = System.Drawing.Color.White;
                consignor_Bill_name.BackColor = System.Drawing.Color.White;
                btnPopUp.Style["display"] = "block";
            }
            else
            {
                consignor_Bill.Enabled = false;
                consignor_Bill_name.Enabled = false;
                fincmplbr.Enabled = false;
                consignor_Bill.BackColor = System.Drawing.Color.FromArgb(0, 230, 230, 230);
                consignor_Bill_name.BackColor = System.Drawing.Color.FromArgb(0, 230, 230, 230);
                btnPopUp.Style["display"] = "none";
            }



            dockdt.Text = dr["dockdt"].ToString();
            destn.Text = dr["destcd"].ToString();
            destfrom.Text = dr["from_loc"].ToString();
            destto.Text = dr["to_loc"].ToString();
            txtDelyDt.Text = dr["cdeldt"].ToString();

            // IF CUSTOMER EXISTS IN NOT THE LIST THEN csgncd IS 8888
            consignorcode = dr["csgncd"].ToString();
            if (consignorcode.CompareTo("8888") == 0)
            {
                consignor_name.Text = dr["csgnnm"].ToString();
                consignor_add.Text = dr["csgnaddr"].ToString();
                consignor_city.Text = dr["csgncity"].ToString();
                consignor_pin.Text = dr["csgnpincode"].ToString();
                consignor_telno.Text = dr["csgnteleno"].ToString();
                consignor_email.Text = dr["csgnemail"].ToString();
            }
            else
            {
                consignor_name_B.Text = dr["csgncd"].ToString();
                consignor_name_B_nm.Text = fn.Getcustomer(dr["csgncd"].ToString());
            }

            // IF CUSTOMER EXISTS IN NOT THE LIST THEN csgecd IS 8888
            consigneecode = dr["csgecd"].ToString();
            if (consigneecode.CompareTo("8888") == 0)
            {
                consignee_name.Text = dr["csgenm"].ToString();
                consignee_add.Text = dr["csgeaddr"].ToString();
                consignee_city.Text = dr["csgecity"].ToString();
                consignee_pin.Text = dr["csgepincode"].ToString();
                consignee_telno.Text = dr["csgeteleno"].ToString();
                consignee_email.Text = dr["csgeemail"].ToString();
            }
            else
            {
                consignee_name_B.Text = dr["csgecd"].ToString();
                consignee_name_B_nm.Text = fn.Getcustomer(dr["csgecd"].ToString());
            }


            policyno.Text = dr["insupl"].ToString();
            txtinsdt.Text = dr["insupldt"].ToString();
            covers.Text = dr["tot_covers"].ToString();
            totmodvat.Text = dr["tot_modvat"].ToString();
            if (dr["modvat_encl"].ToString().CompareTo("Y") == 0)
                modvat.Checked = true;
            if (dr["insuyn"].ToString().ToUpper().CompareTo("C") == 0)
                ins.SelectedIndex = 0;
            else
                ins.SelectedIndex = 1;
            ctrno.Text = dr["ctr_no"].ToString();
            txttpno.Text = dr["tpnumber"].ToString();
            txtprivatemark.Text = dr["privatemark"].ToString();


            if (dr["permit_yn"].ToString().ToUpper().CompareTo("Y") == 0)
                permit_yn.Checked = true;
            else
                permit_yn.Checked = false;

            permitno.Text=dr["permit_no"].ToString(); //=dr[""].ToString();
            permitdt.Text = dr["permitdt"].ToString();

            ///// IF RECVD IS NULL THEN MUST PUT CHECK UP
            if (dr["permit_recvd_at"].ToString().Trim().CompareTo("")!=0)
                permit_recvd_at.Text = dr["permit_recvd_at"].ToString();
    
            permit_recvd_dt.Text = dr["permit_recvd_dt"].ToString();
            permit_val_dt.Text = dr["permit_validity_dt"].ToString();


            pkgtyp.SelectedValue = dr["pkgsty"].ToString();
            spl_inst.Text = dr["spl_svc_req"].ToString();
            prod.Text = dr["prodcd"].ToString();
            
            staxpaidby.Text = dr["stax_paidby"].ToString();
            staxregno.Text = dr["stax_regno"].ToString();

            if (dr["service_class"].ToString().CompareTo("1") == 0)
            {
                service_ftl.Enabled = false;
                service.SelectedIndex = 1;
                //service.Text = "Sundry";
            }
            else if (dr["service_class"].ToString().CompareTo("2") == 0)
            {
                service_ftl.Enabled = true;

                //service.Text = "FTL";
                service.SelectedIndex = 1;
                service_ftl.Text = dr["ftl_types"].ToString();
            }
            fincmplbr.Text=dr["fincmplbr"].ToString();
            crec++;
        }
        dr.Close();


        if (crec == 0)
        {
            lblErrordockno.Text = "Docket Not Found....";
            lblErrordockno.Visible = true;
            return;
        }


        sqll = "SELECT COUNT(dockno) FROM webx_master_docket_invoice WHERE dockno='" + docno + "'";
        cmdd = new SqlCommand(sqll, conn);
        double norows=Convert.ToDouble(cmdd.ExecuteScalar());
        DataTable dt = new DataTable();
        for(int i=0;i<norows;i++)
        {
            
            dt.Rows.Add();
        }
        invdata.DataSource = dt;
        invdata.DataBind();

 
        sqll = "SELECT srno,invno,convert(varchar,invdt,103) as invdt,declval,pkgsno,actuwt FROM WebX_Master_Docket_Invoice WHERE dockno='" + docno + "'";
        cmdd = new SqlCommand(sqll, conn);
        dr=cmdd.ExecuteReader();
        int ii=0;
        while(dr.Read())
        {
            foreach (GridViewRow drRows in invdata.Rows)
            {
                if(drRows.RowIndex==ii)
                {
                    ((Label)drRows.FindControl("srno")).Text = dr["srno"].ToString();
                    ((TextBox)drRows.FindControl("invno")).Text = dr["invno"].ToString();
                    ((TextBox)drRows.FindControl("invdt")).Text = dr["invdt"].ToString();
                    ((TextBox)drRows.FindControl("declvalue")).Text = Convert.ToDouble(dr["declval"].ToString()).ToString("F2");
                    ((TextBox)drRows.FindControl("pkgno")).Text = Convert.ToDouble(dr["pkgsno"].ToString()).ToString("F2");
                    ((TextBox)drRows.FindControl("actwt")).Text = Convert.ToDouble(dr["actuwt"].ToString()).ToString("F2");
                }
            }
            ii++;
        }

        dr.Close();


        sqll = "SELECT * FROM WebX_Master_Docket_charges WHERE dockno='" + docno + "'";
        cmdd = new SqlCommand(sqll, conn);
        dr = cmdd.ExecuteReader();
        while (dr.Read())
        {
            frieght.Text = dr["freight"].ToString();
            subtotal.Text = dr["subtotal"].ToString();
            stax_s.Text = dr["svctax"].ToString();
            otax_s.Text = dr["cess"].ToString();
            total.Text = dr["dkttot"].ToString();
        }
        dr.Close();


        sqll = "SELECT SUM(declval) AS declval,SUM(pkgsno) AS pkgsno,SUM(actuwt) AS actuwt FROM WebX_Master_Docket_Invoice WHERE dockno='" + docno + "'";
        cmdd = new SqlCommand(sqll, conn);
        dr = cmdd.ExecuteReader();
        while (dr.Read())
        {
            decl.Text = dr["declval"].ToString();
            pkg.Text = dr["pkgsno"].ToString();
            awt.Text = dr["actuwt"].ToString();
        }
        dr.Close();

    } // IsPostBack

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


 }

    protected void txtdocknocheck_TextChanged(object sender, EventArgs e)
    {
        
        //Check for Next Location
        dockno.Text = dockno.Text.ToUpper();

        if (dockno.Text == "")
        {
            lblErrordockno.Visible = false;
            return;
        }


        String strSQLNextStop = "usp_validate_docket_entry";

       
        SqlCommand sqlCommand = new SqlCommand(strSQLNextStop, conn);
               sqlCommand.CommandType = CommandType.StoredProcedure; 
        DataSet dsdockno = new DataSet();

        sqlCommand.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = dockno.Text.ToString();
        sqlCommand.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();

        //  sqlDA.Fill(dsdockno);
        SqlDataReader dr_dockno;
        dr_dockno = sqlCommand.ExecuteReader();

        int count=0 ;
        if(dr_dockno.Read())
        {
               
            count = Convert.ToInt16(dr_dockno[0].ToString());
        }
        dr_dockno.Close();

        lblErrordockno.Text = Session["DocketCalledAs"].ToString() + " is in Use or Not in Series or Invalid " + Session["DocketCalledAs"].ToString();
        lblErrordockno.Visible = (count > 0 ? false : true);
        if (lblErrordockno.Visible)
        {
            validation_chk.Value = Session["DocketCalledAs"].ToString() +  " is in Use or Not in Series or Invalid " + Session["DocketCalledAs"].ToString();
        }
        else
        {
            validation_chk.Value = "";
            if (lblcontract_check.Text == "Invalid Party Code!!!")
            {
                validation_chk.Value = "Invalid Party Code!!!";
            }
        }
        if (count == 0)
        {
           // dockno.Text = "";
            dockno.Focus();
        }
   
    }

    protected void state_documentdetail_chk(object sender, EventArgs e)
    {
        string destcd = destn.Text.ToString();
        Session["destination"] = destn.Text.ToString();
        state_doc_table.Visible = false;

        //Generate SQL statement for Docket Listing
        generateSQL();

        //Paint Docket Listing based on criteria supplied by the user
        
        Payment_detaile_show_YN();
        Submitbtn.Attributes.Add("onclick", "javascript:return SubmitData(" + totdoc.ToString() + ")");
        State_document_detail();
    }

    private void generateSQL()
    {
        string destcd = destn.Text.ToString();
        String sql_doc = "WEBX_Check_Location";

       
        SqlCommand sqlCommand = new SqlCommand(sql_doc, conn);
       
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = destcd.ToString();
        SqlDataReader DR_statecode;
        DR_statecode = sqlCommand.ExecuteReader();

        string LocState="";
        while (DR_statecode.Read())
        {

            LocState = Convert.ToString(DR_statecode["LocState"]);
        }
        DR_statecode.Close();
       
        SQLstr = "Select STFORM,STCSTREQ,STNM,SRNO as Doc_srno from webx_State where STCD='" + LocState + "' and ACTIVEFLAG='Y'";
    }

    private void State_document_detail()
    {

        SqlCommand sqlCommand = new SqlCommand(SQLstr, conn);
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

    protected void onBlur_party(object sender, EventArgs e)
    {
        if (paybas.SelectedValue == "P01" || paybas.SelectedValue == "P03")
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
                SqlCommand cmd = new SqlCommand(sql_party_check, conn);
                SqlDataReader Party_check;
                int Party_yn = 0;
                Party_check = cmd.ExecuteReader();

                if (Party_check.Read())
                {
                    Party_yn = Convert.ToInt16(Party_check.GetValue(0).ToString());  
                }
                Party_check.Close();
               if (Party_yn>0)
               {
                string sql_contract_check = "SELECT   isnull((sum(case when a.custcd=b.custcode   then 1 else 0 end )),0)  as contrct_yn  FROM webx_CUSTHDR a WITH(NOLOCK) inner join WEBX_CUSTCONTRACT_HDR b  WITH(NOLOCK) on a.CUSTCD=b.custcode  where CUSTCD is not null and  PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0 and custcd='" + Party_code + "' ";
                 cmd = new SqlCommand(sql_contract_check, conn);
                SqlDataReader contrct_check;
                contrct_check = cmd.ExecuteReader();
                int contrct_yn=0;
                while (contrct_check.Read())
                {
                     contrct_yn = Convert.ToInt16(contrct_check.GetValue(0).ToString());
                         
                }
                contrct_check.Close();
                if (contrct_yn > 0)
                {
                    //************************************for service type****************************

                    string sql_pick_del = "select pkp_dly=(case when pkp_dly='GG' then 'Godown Pickup - Godown  Delivery' when pkp_dly='DD' then 'Door Pickup - Door  Delivery'when pkp_dly='GD' then 'Godown Pickup - Door  Delivery'when pkp_dly='DG' then 'Door Pickup - Godown  Delivery' end )  " +
                    ",pkp_dly_val=(case when pkp_dly='GG' then '1'  " +
                    "when pkp_dly='DD' then '3' " +
                    "when pkp_dly='GD' then '2' " +
                    "when pkp_dly='DG' then '4' end ) " +
                    "from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";

                    SqlDataReader dr_pick_del;

                    cmd = new SqlCommand(sql_pick_del, conn);
                    dr_pick_del = cmd.ExecuteReader();
                    string pkp_dly = "";
                    cboPickupDely.Items.Clear();
                    while (dr_pick_del.Read())
                    {

                        pkp_dly = dr_pick_del.GetValue(0).ToString();

                        cboPickupDely.Items.Add(new ListItem(dr_pick_del.GetValue(0).ToString(), dr_pick_del.GetValue(1).ToString()));
                    }


                    dr_pick_del.Close();
                    //*******************foe Service TYpe *****************************
                   
                    //**************************************************************
                    //**************for COD DOC * Volumetric & ODA*****************************
                    Contract_for_Others();
                    //**********for trn mod*********************************************
                    string sql_trn_mod = "select road_yn,Express_yn,air_yn,rail_yn from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";

                    SqlDataReader dr_trn;

                    cmd = new SqlCommand(sql_trn_mod, conn);
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
                            trnmod = "Air";
                            trnmodval = "1";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }
                        if (road_yn == "Y")
                        {
                            trnmod = "Road";
                            trnmodval = "2";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }
                        if (rail_yn == "Y")
                        {
                            trnmod = "Train";
                            trnmodval = "3";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }
                        if (Express_yn == "Y")
                        {
                            trnmod = "Express";
                            trnmodval = "4";
                            trans.Items.Add(new ListItem(trnmod, trnmodval));
                        }

                    }

                    dr_trn.Close();
                    //**********************************************************************
                    //**********for Service type*********************************************
                    string sql_service = "select ftl_yn,sundry_yn from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";

                    SqlDataReader dr_service;

                    cmd = new SqlCommand(sql_service, conn);
                    
                    dr_service = cmd.ExecuteReader();
                    string servicecode = "", servicedesc = "";
                    string ftl_yn = "", sundry_yn = "";
                    service.Items.Clear();
                    service.Items.Add(new ListItem("Select", "0"));
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
                //Party_check.Close();
             
                Payment_detaile_show_YN();
                consignor_Bill_name.Text = fn.Getcustomer(Party_code);
                if (paybas.SelectedValue == "P02")
                {
                    consignor_name_B.Text = Party_code.ToString();
                    consignor_name_B_nm.Text = fn.Getcustomer(Party_code);
                }
                else if (paybas.SelectedValue =="P08")
                {
                    consignee_name_B.Text = Party_code.ToString();
                    consignee_name_B_nm.Text = fn.Getcustomer(Party_code);
                }
    }
        
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
      
        SqlCommand sqlCommand = new SqlCommand(SQLstr1, conn);
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

        string vol="Y";


        decl.Text = "0";
        pkg.Text = "0";
        awt.Text = "0";
        cwt.Text = "0";

    }



    public void javascript_fn()
    {
       // paybas.Attributes.Add("onblur", "javascript:fOnChangepaybas_redonly_party(" + paybas.ClientID + "," + consignor_Bill.ClientID + "," + consignor_Bill_name.ClientID + "," + btnPopUp.ClientID + ")");
        consignor_name.Attributes.Add("onblur", "javascript:Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + ","+consignor_name_B.ClientID+")");
        consignor_add.Attributes.Add("onblur", "javascript:Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_pin.Attributes.Add("onblur", "javascript:Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_telno.Attributes.Add("onblur", "javascript:Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_city.Attributes.Add("onblur", "javascript:Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_email.Attributes.Add("onblur", "javascript:Clear_Csgn(" + paybas.ClientID + "," + consignor_name.ClientID + "," + consignor_add.ClientID + "," + consignor_pin.ClientID + "," + consignor_telno.ClientID + "," + consignor_city.ClientID + "," + consignor_email.ClientID + "," + consignor_name_B.ClientID + ")");
        consignor_email.Attributes.Add("onblur", "javascript:num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ",'1')");
        consignee_email.Attributes.Add("onblur", "javascript:num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ",'2')");
        consignor_pin.Attributes.Add("onblur", "javascript:num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ")");
        consignee_pin.Attributes.Add("onblur", "javascript:num_email_chk(" + consignor_email.ClientID + "," + consignee_email.ClientID + "," + consignor_pin.ClientID + "," + consignee_pin.ClientID + ")");
        modvat.Attributes.Add("onclick", "javascript:modvatblur(" + modvat.ClientID + "," + totmodvat.ClientID + ")");
        permit_recvd_at.Attributes.Add("onblur", "javascript:return disable_enable(" + permit_yn.ClientID + "," + permitno.ClientID + ")");
        staxpaidby.Attributes.Add("onblur", "javascript:return calc()");
        frieght.Attributes.Add("onblur", "javascript:FreightCalc();calc()");
        rate.Attributes.Add("onblur", "javascript:FreightCalc();calc()");
        ratetype.Attributes.Add("onblur", "javascript:FreightCalc();calc()");
        Submitbtn.Attributes.Add("onclick", "javascript:return SubmitData()");
        dockdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + dockdt.ClientID + ")");
        txtDelyDt.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtDelyDt.ClientID + ")");
        chkCoddoc.Attributes.Add("onclick", "javascript:return CODDOD_validation_checkbox()");
        local_yn.Attributes.Add("onclick", "javascript:return LocalCN_validation_checkbox()");
        chkoda.Attributes.Add("onclick", "javascript:return ODA_validation_checkbox()");
        covers.Attributes.Add("onchange", "javascript:Nagative_Chk_woDecimal(" + covers.ClientID + ")");
        totmodvat.Attributes.Add("onchange", "javascript:Nagative_Chk_woDecimal(" + totmodvat.ClientID + ")");
        permitdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + permitdt.ClientID + ")");
        permit_val_dt.Attributes.Add("onblur", "javascript:return ValidateForm(" + permit_val_dt.ClientID + ")");
        permit_recvd_dt.Attributes.Add("onblur", "javascript:return ValidateForm(" + permit_recvd_dt.ClientID + ")");
        txtinsdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtinsdt.ClientID + ")");
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
        consignor_name_B_nm.Text = fn.Getcustomer(consignor_name_B.Text.ToString());
    }

    protected void cagenamedisplay(object sender, EventArgs e)
    {
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

            invno.Attributes.Add("onblur", "javascript:fSpecialChar(" + invno.ClientID + ")");
            declvalue.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(" + actwt.ClientID + ")");
            invdt.Attributes.Add("onblur", "javascript:return ValidateForm(" + invdt.ClientID + ")");
            declvalue.Attributes.Add("onblur", "javascript:TotalCalc(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onblur", "javascript:TotalCalc(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onblur", "javascript:TotalCalc(" + actwt.ClientID + ")");
           

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
            invno.Attributes.Add("onblur", "javascript:fSpecialChar(" + invno.ClientID + ")");
            declvalue.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onchange", "javascript:Nagative_Chk_wDecimal(" + actwt.ClientID + ")");

            declvalue.Attributes.Add("onblur", "javascript:TotalCalc(" + declvalue.ClientID + ")");
            pkgno.Attributes.Add("onblur", "javascript:TotalCalc(" + pkgno.ClientID + ")");
            actwt.Attributes.Add("onblur", "javascript:TotalCalc(" + actwt.ClientID + ")");

            length.Attributes.Add("onblur", "javascript:InvoiceDet(" + actwt.ClientID + ")");
            breadth.Attributes.Add("onblur", "javascript:InvoiceDet(" + actwt.ClientID + ")");
            height.Attributes.Add("onblur", "javascript:InvoiceDet(" + actwt.ClientID + ")");

            
        }
    }

    protected void fOnChangepaybas(object sender, EventArgs e)
    {

        Payment_detail_show.Value = "Y";
        Customer_contract();
        fincmplbr.Attributes.Add("onblur", "javascript:return Locationcheck(" + fincmplbr.ClientID + ")");
        fincmplbr.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
       

    }

    protected void fOnChangepaybas_for_otherControl(object sender, EventArgs e)
    {
        if (service.SelectedValue.ToUpper().CompareTo("1") == 0)
        {
            service_ftl.Enabled = false;
        
        }
        else if (service.SelectedValue.ToUpper().CompareTo("2") == 0)
        {
            service_ftl.Enabled = true;
        }
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
    }


    public void Customer_contract()
    {

        Contract_validation();




/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
 *                              VALIDATAION FOR INVOICE GRID DATA
 *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/

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


     

            //FOr EDD 
            string EDDfrom="NonODA";
            EDD_calc(EDDfrom, 0);
            if (dockno.Text != "" && paybas.Text != "" && trans.Text != "" && service.Text != "" && cwt.Text != "")
            {
                //contrct details

                DisplayCOntractPaymentdetail();

                //svc tax apid by stting 
                SetServicetaxPaidby();
                //FOr FOV charges
                applicableForTypeOfService();
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
                }
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
        }
        else if (paybas.Text == "" || paybas.Text.CompareTo("Select")==0)
        {
            Payment_detal_errmsg.Text = "Plz Select Paybas";
            Payment_detal_errmsg1.Text = "Plz Select Paybas";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            paybas.Focus();
        }
        else if ((paybas.Text == "P02" || paybas.Text == "P09" || paybas.Text == "P08") && consignor_Bill.Text == "")
        {

            Payment_detal_errmsg.Text = "Plz Enter Party Code";
            Payment_detal_errmsg1.Text = "Plz Enter Party Code";
            paymentdetail_flaggupdate(false);
            Validate_YN = "N";
            consignor_Bill.Focus();
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
        else if (service.Text == "" || service.Text.CompareTo("Select")==0)
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
            if (Paybas == "P01")
            {
                staxpaidby.Items.Add(new ListItem("Consignee", "Consignee"));
            }
            else if (Paybas == "P03")
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
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetApplicableDocketCharges_new";

        sqlCommand.Parameters.AddWithValue("@ApplicableYN", "Y");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsAppDocketCharges = new DataSet();

        sqlDA.Fill(dsAppDocketCharges);

        int intResult;
        string strContractChargesTemp = "";
        string readonlystrs="";
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
              
                if (Contrct_YN == "Y")
                {
                    readonlystrs = "ReadOnly";
                }


                string strsql = "SELECT " + ChargesName + " FROM webx_master_docket_charges where dockno='" + docno + "'";
                SqlCommand cmdchrg = new SqlCommand(strsql, conn);
                SqlDataReader dr = cmdchrg.ExecuteReader();
                string sss = "";
                while (dr.Read())
                {
                    sss = dr[0].ToString();
                }
                dr.Close();

                strContractChargesTemp = "<td  colspan='2'>";
                strContractChargesTemp += "<label class='blackfnt'>&nbsp;";
                strContractChargesTemp += dsAppDocketCharges.Tables[0].Rows[i]["CodeDesc"].ToString();//+ "(" + dsAppDocketCharges.Tables[0].Rows[i]["operand"].ToString() + ")"
                strContractChargesTemp += "</label>";
                strContractChargesTemp += "</td>";
                strContractChargesTemp += "<td>";
                strContractChargesTemp += "<input id='" + dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() + "' ";
                strContractChargesTemp += "type='text' size='10' align='right' class='inputnum' value='"+ Convert.ToDouble(sss).ToString("F2")+"' maxlength='8' ";
                strContractChargesTemp += "onblur='javascript: if(Nagative_Chk_wDecimal(this)){ return calc()};' style='margin-left: 5px;'  " + readonlystrs + " runat='server' />";
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
        sqlCommand.Connection = conn;
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
                strContractChargesHidden += "<input id='" + dsAppDocketCharges.Tables[0].Rows[i]["CodeId"].ToString() + "' type='hidden' value='0.00' runat='server'  />";
            }
        }

    }
    private void applicableForTypeOfService()
    {
        
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetTypeOfServiceAppForDocketCharges_new";

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsTOSApplicable = new DataSet();

        sqlDA.Fill(dsTOSApplicable);

        
        blnAppForFOVCharges = "";

        if (dsTOSApplicable.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsTOSApplicable.Tables[0].Rows.Count; i++)
            {
                
                if (dsTOSApplicable.Tables[0].Rows[i]["CodeId"].ToString().ToUpper() == "SCHG011".ToUpper())
                {
                    if (dsTOSApplicable.Tables[0].Rows[i]["StatusCode"].ToString().ToUpper() == "Y")
                    {

                        blnAppForFOVCharges = "<TR bgcolor='#FFFFFF'><td  colspan='2' ><font class='blackfnt'>FOV(%)</font></td>";
                        blnAppForFOVCharges += "<td><font class='blackfnt'><input name=FOV type=text size=10  class='inputnum'  value='0.00'  maxlength=8 onchange='javascript:fov_calc()'     onblur='javascript: if(Nagative_Chk_wDecimal(this)){ return calc();};' ></font></td>";
                        blnAppForFOVCharges += "<td   colspan='2'></td><td></td></TR>	";
                        blnAppForFOVCharges += "<TR bgcolor='#FFFFFF'><td   colspan='2'><font class='blackfnt'>FOV On Declared Value</font></td>";
                        blnAppForFOVCharges += "<td><font class='blackfnt'><input name=FOV_delc type=text size=10  value='0.00'   maxlength=8 onchange='return Nagative_Chk_wDecimal(this)' class='inputnum'  onblur='javascript: if(Nagative_Chk_wDecimal(this)){ return calc()};' readonly></font></td>";
                        blnAppForFOVCharges += "<td   colspan='2'><font class='blackfnt'>FOV Charged(+)</font></td>";
                        blnAppForFOVCharges += "<td><font class='blackfnt'><input name=FOV_charged type=text size=10   value='0.00'   maxlength=8  onchange='return Nagative_Chk_wDecimal(this)' class='inputnum' onblur='javascript: if(Nagative_Chk_wDecimal(this)){ return calc()};'></font></td>";
                        blnAppForFOVCharges += "</TR>";
                    }
                    else
                    {
                        blnAppForFOVCharges = "<input name=FOV type=hidden size=10  onchange='return Nagative_Chk_wDecimal(this)'>";
                        blnAppForFOVCharges += "<input name=FOV_delc type=hidden size=10  onchange='return Nagative_Chk_wDecimal(this)'>";
                        blnAppForFOVCharges += "<input name=FOV_charged type=hidden size=10  onchange='return Nagative_Chk_wDecimal(this)'>";
                    }
                }
            }
        }

    }

    protected void Submitbtn_Click(object sender, EventArgs e)
    {
        updateDocket();
    }
    public void EDD_calc(string EDDfrom,int Trdays1)
    {

        string orgncd = Session["brcd"].ToString();
        string descd = destn.Text.ToString();
        string trnmod = trans.SelectedValue.ToString();
        string colnamecls = "";
        int Trdays = 0;
        if (trnmod == "1")
        {
            colnamecls = "trdays_air";
        }
        else if (trnmod == "2")
        {
        colnamecls = "TRDAYS";
        }
        else if (trnmod == "3")
        {
            colnamecls="trdays_rail";
        }
        else if (trnmod == "4")
        {
            colnamecls="trdays_exp";
        }
        
        string sql = "select " + colnamecls + " as TRDAYS   from webx_TRMS Where TRORGN ='" + orgncd + "' and TRDEST ='" + descd + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, conn);
       
        SqlDataReader dr_edd = null;
        dr_edd = sqlCommand.ExecuteReader();

        if (dr_edd.Read())
        {

            Trdays = Convert.ToInt16(dr_edd.GetValue(0).ToString());
            if (Trdays is DBNull  )
            { 
                Trdays=0;
            }
        }
        dr_edd.Close();
     

        if (EDDfrom == "ODA")
        {
            Trdays = Trdays1;
        }
        string  dktdate = dockdt.Text.ToString();
        string[] dktdate_arr;
        dktdate_arr = dktdate.Split('/');
        string dktdate_dt = dktdate_arr[0].ToString();
        string dktdate_mm = dktdate_arr[1].ToString();
        string dktdate_yy = dktdate_arr[2].ToString();
        dktdate = dktdate_mm + "/" + dktdate_dt + "/" + dktdate_yy;

        DateTime Docketdate = Convert.ToDateTime(dktdate.ToString());
        DateTime Edd = Docketdate + TimeSpan.FromDays(Trdays);
        txtDelyDt.Text = Edd.ToString("dd/MM/yyyy");
    }

    public void checkloccode()
    {
        Locationstr=fn.getLocationStr();
        destn.Attributes.Add("onblur", "javascript:return Locationcheck(" + destn.ClientID + ")");
        destn.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
    }
    
    public void checkcustomer()
    {
        Custcdstr = fn.getCustomerStr();
        consignor_name_B.Attributes.Add("onblur", "javascript:return Customercheck(" + consignor_name_B.ClientID + ")");
        consignor_name_B.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
        consignee_name_B.Attributes.Add("onblur", "javascript:return Customercheck(" + consignee_name_B.ClientID + ")");
        consignee_name_B.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");
    }

    public void CheckCity()
    {
        string[] CityStr_arr = fn.getCityStr().Split('/');
        CityStr = CityStr_arr[0].ToString();
        ODACityStr = CityStr_arr[1].ToString();

        destfrom.Attributes.Add("onblur", "javascript:return originTest('" + destfrom.ClientID.ToString() + "','" + Orgn.ClientID.ToString() + "')");
        destto.Attributes.Add("onblur", "javascript:return destTest('" + destto.ClientID.ToString() + "','" + destn.ClientID.ToString() + "')");
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
             if (chkCoddoc.Checked==true)
            {
                COD_DOD_YN = "Y";
            }
            else
            {
                COD_DOD_YN = "N";
            }

            if (local_yn.Checked==true)
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
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();
       
        while (dr.Read())
        {
            ServiceTax = Convert.ToDouble(dr["ServiceTax"].ToString());
            OtherTax = Convert.ToDouble(dr["EDU_CESS_RATE"].ToString());
            CFT_Ratio = Convert.ToDouble(dr["CFT_Ratio"].ToString());
            H_OtherTax = Convert.ToDouble(dr["HEDU_CESS_RATE"].ToString());
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
        string Transtype= trans.SelectedItem.ToString();
        string Transtype_code = trans.SelectedValue.ToString();
        string charge_wt = cwt.Text.ToString();
        string Fromregion = fn.GetLocregion(Orgncd);
        string Toregion = fn.GetLocregion(Destcd);
        Contrct_YN = "N";
        string FTL_flag = "N", minfrt_flag = "N";
        string stax_paidby_new = "", sundry_yn = "", BilledAt = "", ftl_yn = "", cft2kg = "", stax_yn="";
        double FreightStd = 0, RateDisp = 0;

        string dbService_No = Service;
        string single_slab_yn = "", multiple_slab_yn = "";
        string LOC_FLAG = "N", vol_yn="",cod_dod_yn="", REG_FLAG = "N", city_FLAG = "N", bkg_ratecol = "";
        string slab_codeval = "", matrix_type = "", slab_code = "", trdays = "", MultiContract_yn = "N", RateDispVal="";
        double RatePerKg = 0, RatePerPkg = 0;
        if (Paybas == "P02" || Paybas == "P08" || Paybas == "P09")
        {

            string sql = "Select h.stax_yn,h.stax_paidby as stax_paidby_new, c.* from  webx_custcontract_hdr h,webx_custcontract_CHARGE c where h.custcode=c.custcode and c.custcode='" + PartyCode + "'";
          
            SqlCommand cmd = new SqlCommand(sql, conn);

            SqlDataReader Myrd = null;
            Myrd = cmd.ExecuteReader();
            int chargesvalue = 0;
            if(Myrd.Read())
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
                SCHG21 = Convert.ToString(Myrd["Dkt_chrg"]);
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
                cmd = new SqlCommand(sql, conn);
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
                    }
                    else if (Transtype_code == "2")
                    {
                        bkg_ratecol = "Road_rate";
                    }
                    else if (Transtype_code == "3")
                    {
                        bkg_ratecol = "Train_rate";
                    }
                    else if (Transtype_code == "4")
                    {
                        bkg_ratecol = "Express_rate";
                    }
                    sql = "select " + bkg_ratecol + " as slab_codeval ,rate_type as matrix_type from WEBX_CUSTCONTRACT_cityDET  where custcode='" + PartyCode + "' and ((fromcity='" + Destfrom + "' and tocity='" + Destto + "')) ";
                    cmd = new SqlCommand(sql, conn);
                    SqlDataReader Myrd_single = null;
                    Myrd_single = cmd.ExecuteReader();
                    if (Myrd_single.Read())
                    {
                        city_FLAG = "Y";
                        slab_codeval = Convert.ToString(Myrd_single["slab_codeval"]);
                        matrix_type = Convert.ToString(Myrd_single["matrix_type"]);
                    }
                    Myrd_single.Close();
                    if (city_FLAG == "N")
                    {
                        sql = "select " + bkg_ratecol + " as slab_codeval ,rate_type as matrix_type from WEBX_CUSTCONTRACT_locDET  where custcode='" + PartyCode + "' and ((FromLocode='" + Orgncd + "' and ToLocode='" + Destcd + "')) ";
                        cmd = new SqlCommand(sql, conn);
                        Myrd_single = null;
                        Myrd_single = cmd.ExecuteReader();
                        if (Myrd_single.Read())
                        {
                            LOC_FLAG = "Y";
                            slab_codeval = Convert.ToString(Myrd_single["slab_codeval"]);
                            matrix_type = Convert.ToString(Myrd_single["matrix_type"]);
                        }
                        Myrd_single.Close();

                    }
                    if (LOC_FLAG == "N")
                    {
                        sql = "select " + bkg_ratecol + " as slab_codeval ,rate_type as matrix_type from WEBX_CUSTCONTRACT_REGDET  where custcode='" + PartyCode + "' and ((FromRegion='" + Fromregion + "' and ToRegion='" + Toregion + "')) ";
                        cmd = new SqlCommand(sql, conn);
                        Myrd_single = null;
                        Myrd_single = cmd.ExecuteReader();
                        if (Myrd_single.Read())
                        {
                            REG_FLAG = "Y";
                            slab_codeval = Convert.ToString(Myrd_single["slab_codeval"]);
                            matrix_type = Convert.ToString(Myrd_single["matrix_type"]);
                        }
                        Myrd_single.Close();

                    }
                }
                //******************************Single Slab End ********************************
                //******************************Multi Slab start********************************
                else
                {
                    sql = "Select slab_code,matrix_type from WEBX_CUSTCONTRACT_FRTMATRIX_SLABHDR where custcode='" + PartyCode + "'  and (case when matrix_type='W' then " + charge_wt + " else " + Pkgsno + " end) between slab_from and slab_to";
                    cmd = new SqlCommand(sql, conn);
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
                        sql = "select  " + slab_code + " as slab_codeval,trdays  from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET  where custcode='" + PartyCode + "'  and ((from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "')) and trans_type='" + Transtype + "'";
                        cmd = new SqlCommand(sql, conn);
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
                            trdays = fn.GetZeroval(trdays);
                        }
                        Myrd_Multiple.Close();
                        if (city_FLAG == "N")
                        {
                            sql = "select  " + slab_code + " as slab_codeval,trdays  from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET  where custcode='" + PartyCode + "'  and ((from_loccode='" + Orgncd + "' and to_loccode='" + Destcd + "')) and trans_type='" + Transtype + "'";
                            Myrd_Multiple = null;
                            cmd = new SqlCommand(sql, conn);
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
                                trdays = fn.GetZeroval(trdays);
                            }
                            Myrd_Multiple.Close();
                        }
                        if (LOC_FLAG == "N")
                        {
                            sql = "select  " + slab_code + " as slab_codeval,trdays  from WEBX_CUSTCONTRACT_FRTMATRIX_SLABDET  where custcode='" + PartyCode + "'  and ((from_loccode='" + Fromregion + "' and to_loccode='" + Toregion + "')) and trans_type='" + Transtype + "'";
                            Myrd_Multiple = null;
                            cmd = new SqlCommand(sql, conn);
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
                sql = "select City_matrix=isnull(sum(case when LOC_reg='C'and  from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "'  and ftltype='" + Service_ftl + "'  then 1 else 0 end),0), ";
                sql = sql + "Branch_matrix=isnull(sum(case when LOC_reg='L'and  from_loccode='" + Orgncd + "' and to_loccode='" + Destcd + "' and ftltype='" + Service_ftl + "' then 1 else 0 end),0),";
                sql = sql + "Region_matrix=isnull(sum(case when LOC_reg='R' and  from_loccode='" + Fromregion + "' and to_loccode='" + Toregion + "'  and ftltype='" + Service_ftl + "'then 1 else 0 end),0) from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where    custcode='" + PartyCode + "' ";
                //sql = "select count(*) as City_matrix from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "' and ftltype='" & Service_ftl & "' and LOC_reg='C'";
                cmd = new SqlCommand(sql, conn);
                SqlDataReader Myrd_Ftl = null;
                int City_matrix = 0, Branch_matrix = 0, Region_matrix=0;
                cmd = new SqlCommand(sql, conn);
                Myrd_Ftl = cmd.ExecuteReader();
                if (Myrd_Ftl.Read())
                {
                    
                    City_matrix = Convert.ToInt16(Myrd_Ftl["City_matrix"]);
                    Branch_matrix = Convert.ToInt16(Myrd_Ftl["Branch_matrix"]);
                    Region_matrix = Convert.ToInt16(Myrd_Ftl["Region_matrix"]);
                    
                }
                Myrd_Ftl.Close();
                string Sql_ftl="";
                if (City_matrix > 0)
                {
                    FTL_flag = "Y";
                    Sql_ftl = "select *  from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Destfrom + "' and to_loccode='" + Destto + "' and ftltype='" + Service_ftl + "' and LOC_reg='C'";
                }
                else if (Branch_matrix > 0)
                {
                    FTL_flag = "Y";
                    Sql_ftl = "select *  from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Orgncd + "' and to_loccode='" + Destcd + "' and ftltype='" + Service_ftl + "' and LOC_reg='L'";
                }
                else if (Region_matrix > 0)
                {
                    FTL_flag = "Y";
                    Sql_ftl = "select *  from WEBX_CUSTCONTRACT_FRTMATRIX_FTLSLABHDR where custcode='" + PartyCode + "' and  from_loccode='" + Fromregion + "' and to_loccode='" + Toregion + "' and ftltype='" + Service_ftl + "' and LOC_reg='R'";
                }
                if (Sql_ftl != "")
                { 
                    Myrd_Ftl = null;
                    cmd = new SqlCommand(Sql_ftl, conn);
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
                }
            }
            frieght.Text = Convert.ToString(FreightStd);
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
                }
                if (dbService_No == "1")
                {
                    rate.Text = Convert.ToString(RateDisp);
                    ratetype.SelectedValue = RateDispVal.ToString();
                }
            }
            else
            {
                rate.Text = "0.0";
                ratetype.SelectedValue = "W";
            }
            // ****************for Minmum rate /chgwt/pk****************
            string min_frtcol = "", type_bas = "", typebas="";
            double minfrt=0;
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
            sql = "Select "+ min_frtcol +" as minfrt,"+ type_bas +" AS typebas  from webx_CUSTCONTRACT_CHARGE with (NOLOCK) where Custcode='" + PartyCode + "'";
            cmd = new SqlCommand(sql, conn);
            SqlDataReader Myrd_Min_rate = null;

            cmd = new SqlCommand(sql, conn);
            Myrd_Min_rate = cmd.ExecuteReader();
            if (Myrd_Min_rate.Read())
            {
                minfrt = Convert.ToDouble(Myrd_Min_rate["minfrt"]);
                typebas = Convert.ToString(Myrd_Min_rate["typebas"]);
             }
             if (typebas == "KG")//&& minfrt > Convert.ToDouble(charge_wt)
             {
                 Payment_detal_errmsg.Text = "Minimum Charge wt. should be " + minfrt + " for this party ";
                 Payment_detal_errmsg1.Text = "Minimum Charge wt. should be " + minfrt + " for this party";
                 minfrt_flag = "Y";
                 min_chrgwt.Value = Convert.ToString(minfrt);

             }
             else if (typebas == "PKG")//&& minfrt > Convert.ToDouble(Pkgsno)
             {
                 Payment_detal_errmsg.Text = "Minimum Packages  should be " + minfrt + " for this party";
                 Payment_detal_errmsg1.Text = "Minimum Packages  should be " + minfrt + " for this party";
                 min_pkgsno.Value = Convert.ToString(minfrt);
                 minfrt_flag = "Y";
                 //paymentdetail_flaggupdate(false);
                 //Response.End();
             }
             else if (typebas == "RS")//&& minfrt > FreightStd
             {
                 Payment_detal_errmsg.Text = "Minimum Freight should be " + minfrt + " for this party";
                 Payment_detal_errmsg1.Text = "Minimum Freight should be " + minfrt + " for this party";
                 minfrt_flag = "Y";
                 min_frt.Value = Convert.ToString(minfrt);
                // paymentdetail_flaggupdate(false);
                 //Response.End();
             }
            Myrd_Min_rate.Close();
            //*********************************************************
        }
      
            ratetype.Focus();
            Contract_for_Others();
            ODA_CHGDisplay();
        
    }
    public void paymentdetail_flaggupdate(bool flag)
    {
        if (flag == false)
        {
            flag = false;
        }
        else
        {
            flag = true;
        }
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
        string dest_to = destto.Text.ToString(),Pkgsno=pkg.Text.ToString(),CHgwt=cwt.Text.ToString(),party_code=consignor_Bill.Text.ToString();
        double odakm = 0;
        string Oda_charge="0",trdays="0";
        if (oda_yn == "Y")
        {
            if (chkoda.Checked == true)
            {
                string sql = "select Location,odakm from webx_citymaster where location='" + dest_to + "'  ";
               
                SqlCommand cmd = new SqlCommand(sql, conn);
                SqlDataReader Dr_Oda;
               
                Dr_Oda = cmd.ExecuteReader();
                if (Dr_Oda.Read())
                {
                    odakm = Convert.ToDouble(Dr_Oda["odakm"]);
                }
                Dr_Oda.Close();
                string slab_code="", matrix_type;
                sql ="Select slab_code,matrix_type from WEBX_CUSTCONTRACT_ODAMATRIX_SLABHDR where custcode='"+party_code+"' and convert(numeric,(case when matrix_type='W' then '"+CHgwt+"' else '"+Pkgsno+"' end),106) between slab_from and slab_to";
                 cmd = new SqlCommand(sql, conn);
                 Dr_Oda = cmd.ExecuteReader();
                 if (Dr_Oda.Read())
                 {
                     slab_code = Convert.ToString(Dr_Oda["slab_code"]);
                     matrix_type = Convert.ToString(Dr_Oda["matrix_type"]);
                 }
                 else
                 {
                     slab_code="";
                 }
                 Dr_Oda.Close();
                 if (slab_code != "")
                 {
                     string ESS_code="", Min_ODAChrg;
                     sql = "Select ESS_code,Min_ODAChrg from WEBX_CUSTCONTRACT_ODAMATRIX_DISTHDR where custcode='" + party_code + "' and " + odakm + " between ESS_from and Ess_to";
                     cmd = new SqlCommand(sql, conn);
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
                     sql = "select " + slab_code + " as Oda_charge,trdays from WEBX_CUSTCONTRACT_ODAMATRIX_CHARGE where ESS_code='" + ESS_code + "'";
                     cmd = new SqlCommand(sql, conn);
                     Dr_Oda = cmd.ExecuteReader();
                     if (Dr_Oda.Read())
                     {
                         Oda_charge = Convert.ToString(Dr_Oda["Oda_charge"]);

                         if (Oda_charge is DBNull)
                         {
                             Oda_charge = "0";
                         }
                         trdays= Convert.ToString(Dr_Oda["trdays"]);
                          if (trdays is DBNull)
                         {
                             trdays = "0";
                         }
                     }
                     Dr_Oda.Close();
                     string EDDFrom="ODA";
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
        
        string sql_checkbox = "select cod_dod_yn,vol_yn,oda_yn  from   WEBX_CUSTCONTRACT_CHARGE  WITH(NOLOCK) where  custcode='" + Party_code + "'";
       
        SqlDataReader dr_chk;

        SqlCommand cmd = new SqlCommand(sql_checkbox, conn);
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
                // int onofrows1 = Convert.ToInt16(noofrows1.Text.ToString());
                //addrowfn(onofrows1);
                // javascript_fn();
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
            CheckCity();

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
   
        //********************************
    }

    protected void invdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string s = "cal.select(" + ((TextBox)e.Row.FindControl("invdt")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkdate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkdate")).Attributes.Add("onclick", s);

            TextBox txtinvno = ((TextBox)e.Row.FindControl("invno"));
            TextBox txtinvdt = ((TextBox)e.Row.FindControl("invdt"));
            TextBox txtdeclval = ((TextBox)e.Row.FindControl("declval"));
            TextBox txtpkgsno = ((TextBox)e.Row.FindControl("pkgno"));
            TextBox txtactuwt = ((TextBox)e.Row.FindControl("actwt"));
        }
    }


    protected void invdata_cft_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string s = "cal.select(" + ((TextBox)e.Row.FindControl("invdt")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkdate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkdate")).Attributes.Add("onclick", s);

            TextBox txtinvno = ((TextBox)e.Row.FindControl("invno"));
            TextBox txtinvdt = ((TextBox)e.Row.FindControl("invdt"));
            TextBox txtdeclval = ((TextBox)e.Row.FindControl("declval"));
            TextBox txtpkgsno = ((TextBox)e.Row.FindControl("pkgno"));
            TextBox txtactuwt = ((TextBox)e.Row.FindControl("actwt"));
        }
    }

    protected void paybas_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (paybas.SelectedIndex == 6 || paybas.SelectedIndex == 2 || paybas.SelectedIndex == 5)
        {
            consignor_Bill.Enabled = true;
            btnPopUp.Style["display"] = "block";
            consignor_Bill_name.Enabled = true;
            consignor_Bill.BackColor = System.Drawing.Color.White;
            consignor_Bill_name.BackColor = System.Drawing.Color.White;
            fincmplbr.Enabled = true;
        }
        else
        {
            consignor_Bill.Enabled = false;
            btnPopUp.Style["display"] = "none";
            consignor_Bill_name.Enabled = false;
            consignor_Bill.BackColor = System.Drawing.Color.FromArgb(0, 230, 230, 230);
            consignor_Bill_name.BackColor = System.Drawing.Color.FromArgb(0,230,230,230) ;
            fincmplbr.Enabled = false;
        }
    }


    // THIS FUNCTION UPDATES ALL FIELDS OF DOCKET WITHOUT USING ANY StoredProcedure
    protected void updateDocket()
    {
        string sqldockdet = "UPDATE webx_master_docket SET ";
        sqldockdet = sqldockdet + "dockdt='" + fn.Mydate(dockdt.Text) + "',";
        sqldockdet = sqldockdet + "paybas='" + paybas.SelectedValue + "',";
        sqldockdet = sqldockdet + "party_code='" + consignor_name.Text + "',";
        sqldockdet = sqldockdet + "orgncd='" + Orgn.Value + "',";
        sqldockdet = sqldockdet + "reassign_destcd='" + destn.Text + "',";
        sqldockdet = sqldockdet + "pickup_dely='" + cboPickupDely.SelectedValue + "',";
        sqldockdet = sqldockdet + "from_loc='" + destfrom.Text + "',";
        sqldockdet = sqldockdet + "to_loc='" + destto.Text + "',";
        
        if(local_yn.Checked==true)
            sqldockdet = sqldockdet + "localcn_yn='Y',";
        else
            sqldockdet = sqldockdet + "localcn_yn='N',";

        // COD/DOD INFORMATION
        if(chkCoddoc.Checked==true)
            sqldockdet = sqldockdet + "cod_dod='Y',";
        else
            sqldockdet = sqldockdet + "cod_dod='N',";

        if (chkcft.Checked == true)
            sqldockdet = sqldockdet + "cft_yn='Y',";
        else
            sqldockdet = sqldockdet + "cft_yn='N',";

        sqldockdet = sqldockdet + "csgncd='" + consignor_name_B.Text + "',";
        sqldockdet = sqldockdet + "csgnnm='" + consignor_name_B_nm.Text + "',";
        sqldockdet = sqldockdet + "csgnaddr='" + consignor_add.Text + "',";
        sqldockdet = sqldockdet + "csgncity='" +  consignor_city.Text +"',";
        sqldockdet = sqldockdet + "csgnpincode='" + consignor_pin.Text + "',";
        sqldockdet = sqldockdet + "csgnteleno='" + consignor_telno.Text + "',";
        sqldockdet = sqldockdet + "csgnemail='" + consignor_email.Text + "',";
        sqldockdet = sqldockdet + "csgecd='" + consignee_name_B.Text + "',";
        sqldockdet = sqldockdet + "csgenm='" + consignee_name_B_nm.Text + "',";
        sqldockdet = sqldockdet + "csgeaddr='" + consignee_add.Text + "',";
        sqldockdet = sqldockdet + "csgecity='" + consignee_city.Text + "',";
        sqldockdet = sqldockdet + "csgepincode='" + consignee_pin.Text + "',";
        sqldockdet = sqldockdet + "csgeteleno='" + consignee_telno.Text + "',";
        sqldockdet = sqldockdet + "csgeemail='" + consignee_email.Text + "',";


        // RISK TYPE AND POLICY INFORMATION
        sqldockdet = sqldockdet + "insuyn='" + ins.SelectedValue + "',";

        sqldockdet = sqldockdet + "insupl='" + policyno.Text + "',";
        sqldockdet = sqldockdet + "insupldt='" + fn.Mydate(txtinsdt.Text) + "',";
        
        if(covers.Text.Trim().CompareTo("")!=0)
            sqldockdet = sqldockdet + "tot_modvat=" + Convert.ToDouble(covers.Text).ToString("F2") + ",";
        if (totmodvat.Text.Trim().CompareTo("") != 0)
        sqldockdet = sqldockdet + "tot_covers=" + Convert.ToDouble(totmodvat.Text).ToString("F2") + ",";
        sqldockdet = sqldockdet + "ctr_no='" + ctrno.Text + "',";
        
        if(modvat.Checked==true)
            sqldockdet = sqldockdet + "modvat_encl='Y',";
        else
            sqldockdet = sqldockdet + "modvat_encl='N',";

        sqldockdet = sqldockdet + "privatemark='" + txtprivatemark.Text + "',";
        sqldockdet = sqldockdet + "tpnumber='" + txttpno.Text + "',";
       
        if(permit_yn.Checked==true)
            sqldockdet = sqldockdet + "permit_yn='Y',";
        else
            sqldockdet = sqldockdet + "permit_yn='N',";

        sqldockdet = sqldockdet + "permit_recvd_at='" + permit_recvd_at.SelectedValue + "',";
        sqldockdet = sqldockdet + "permit_no='" + permitno.Text + "',";

        if (permitdt.Text.CompareTo("") != 0)
            sqldockdet = sqldockdet + "permitdt='" + fn.Mydate(permitdt.Text) + "',";

        if (permit_recvd_dt.Text.CompareTo("") != 0)
            sqldockdet = sqldockdet + "permit_recvd_dt='" + fn.Mydate(permit_recvd_dt.Text) + "',";

        if (permit_val_dt.Text.CompareTo("") != 0)
            sqldockdet = sqldockdet + "permit_validity_dt='" + fn.Mydate(permit_val_dt.Text) + "',";
        sqldockdet = sqldockdet + "cdeldt='" + fn.Mydate(txtDelyDt.Text) + "',"; ///EDD

        if (pkg.Text != "")
            sqldockdet = sqldockdet + "pkgsno=" + Convert.ToDouble(pkg.Text).ToString("F2") + ",";
        else
            sqldockdet = sqldockdet + "pkgsno=0,";
        if(awt.Text!="")
            sqldockdet = sqldockdet + "actuwt=" + Convert.ToDouble(awt.Text).ToString("F2") + ",";
        else
            sqldockdet = sqldockdet + "actuwt=0,";

        sqldockdet = sqldockdet + "chrgwt=" + Convert.ToDouble(cwt.Text).ToString("F2") + ",";
        sqldockdet = sqldockdet + "pkgsty='" + pkgtyp.SelectedValue + "',";
        sqldockdet = sqldockdet + "prodcd='" + prod.SelectedValue + "',";
        sqldockdet = sqldockdet + "service_class='" + service.SelectedValue + "',";
        sqldockdet = sqldockdet + "ftl_types='" + service_ftl.SelectedValue + "',";
        sqldockdet = sqldockdet + "trn_mod='" + trans.SelectedValue + "',";
        sqldockdet = sqldockdet + "stax_paidby='" + staxpaidby.Text +  "',";
        sqldockdet = sqldockdet + "stax_regno='" + staxregno.Text + "',";
        sqldockdet = sqldockdet + "fincmplbr='" + fincmplbr.Text + "',";
        sqldockdet = sqldockdet + "spl_svc_req='" + spl_inst.Text + "',";
        sqldockdet = sqldockdet + "lasteditdate='" + DateTime.Now.ToString() + "',";
        sqldockdet = sqldockdet + "lasteditby='" + Session["Empcd"].ToString() +"'";
        sqldockdet = sqldockdet + " WHERE dockno='" + docno + "'";

        SqlCommand cmd = new SqlCommand(sqldockdet,conn);
        cmd.ExecuteNonQuery();


        // UPDATES IN WEBX_MASTER_DOCKET_CHARGES
        string sqlcharges = "UPDATE webx_master_docket_charges SET freight=" + Convert.ToDouble(frieght.Text) + ",";
        sqlcharges = sqlcharges + "rate_type='" + ratetype.SelectedValue + "',";
        if (rate.Text.CompareTo("") == 0)
            rate.Text = "0.00";
        sqlcharges = sqlcharges + "frt_rate=" + Convert.ToDouble(rate.Text.ToString()).ToString() +",";
        sqlcharges = sqlcharges + "SCHG01=" + Convert.ToDouble(CHG_SCHG01.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG02=" + Convert.ToDouble(CHG_SCHG02.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG03=" + Convert.ToDouble(CHG_SCHG03.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG04=" + Convert.ToDouble(CHG_SCHG04.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG05=" + Convert.ToDouble(CHG_SCHG05.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG06=" + Convert.ToDouble(CHG_SCHG06.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG07=" + Convert.ToDouble(CHG_SCHG07.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG08=" + Convert.ToDouble(CHG_SCHG08.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG09=" + Convert.ToDouble(CHG_SCHG09.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG10=" + Convert.ToDouble(CHG_SCHG10.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG11=" + Convert.ToDouble(CHG_SCHG11.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG12=" + Convert.ToDouble(CHG_SCHG12.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG13=" + Convert.ToDouble(CHG_SCHG13.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG14=" + Convert.ToDouble(CHG_SCHG14.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG15=" + Convert.ToDouble(CHG_SCHG15.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG16=" + Convert.ToDouble(CHG_SCHG16.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG17=" + Convert.ToDouble(CHG_SCHG17.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG18=" + Convert.ToDouble(CHG_SCHG18.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG19=" + Convert.ToDouble(CHG_SCHG19.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG20=" + Convert.ToDouble(CHG_SCHG20.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG21=" + Convert.ToDouble(CHG_SCHG21.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG22=" + Convert.ToDouble(CHG_SCHG22.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "SCHG23=" + Convert.ToDouble(CHG_SCHG23.Value.ToString()) + ",";

        sqlcharges = sqlcharges + "UCHG01=" + Convert.ToDouble(CHG_UCHG01.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG02=" + Convert.ToDouble(CHG_UCHG02.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG03=" + Convert.ToDouble(CHG_UCHG03.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG04=" + Convert.ToDouble(CHG_UCHG04.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG05=" + Convert.ToDouble(CHG_UCHG05.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG06=" + Convert.ToDouble(CHG_UCHG06.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG07=" + Convert.ToDouble(CHG_UCHG07.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG08=" + Convert.ToDouble(CHG_UCHG08.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG09=" + Convert.ToDouble(CHG_UCHG09.Value.ToString()) + ",";
        sqlcharges = sqlcharges + "UCHG10=" + Convert.ToDouble(CHG_UCHG10.Value.ToString()) + ",";


        sqlcharges = sqlcharges + "subtotal=" + Convert.ToDouble(subtotal.Text) + ",";
        sqlcharges = sqlcharges + "svctax=" + Convert.ToDouble(stax_s.Text) + ",";
        sqlcharges = sqlcharges + "cess=" + Convert.ToDouble(otax_s.Text) + ",";
        sqlcharges = sqlcharges + "dkttot=" + Convert.ToDouble(total.Text) + ",";
        sqlcharges = sqlcharges + "hedu_cess=" + Convert.ToDouble(H_OtherTax) + "";
        sqlcharges = sqlcharges + " WHERE dockno='" + docno + "'";

        //////////INVOICE UPDATION
        string sqlinvoice = "DELETE FROM webx_master_docket_invoice WHERE dockno='" + docno + "'";
        cmd = new SqlCommand(sqlinvoice, conn);
        cmd.ExecuteNonQuery();
        if (chkcft.Checked = true)
        {
            foreach (GridViewRow drRows in invdata_cft.Rows)
            {

                Label lblsrno = ((Label)drRows.FindControl("srno"));
                TextBox txtinvno = ((TextBox)drRows.FindControl("invno"));
                TextBox txtinvdt = ((TextBox)drRows.FindControl("invdt"));
                TextBox txtdeclval = ((TextBox)drRows.FindControl("declvalue"));
                TextBox txtpkgsno = ((TextBox)drRows.FindControl("pkgno"));
                TextBox txtactwt = ((TextBox)drRows.FindControl("actwt"));
                TextBox txtlength = ((TextBox)drRows.FindControl("length"));
                TextBox txtbreadth = ((TextBox)drRows.FindControl("breadth"));
                TextBox txtheight = ((TextBox)drRows.FindControl("height"));
                TextBox txttotal = ((TextBox)drRows.FindControl("cftval"));


                sqlinvoice = "INSERT INTO webx_master_docket_invoice(DOCKNO,INVNO,INVDT,DECLVAL,PKGSNO,ACTUWT,VOL_L,VOL_B,VOL_H,TOT_CFT) VALUES(";
                sqlinvoice = sqlinvoice + "'" + docno + "',";
                sqlinvoice = sqlinvoice + "'" + txtinvno.Text + "',";
                sqlinvoice = sqlinvoice + "'" + txtinvdt.Text + "',";
                sqlinvoice = sqlinvoice + "" + txtdeclval.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtpkgsno.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtactwt.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtlength.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtbreadth.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtheight.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtheight.Text + ",";
                sqlinvoice = sqlinvoice + "" + txttotal.Text + ")";
            }

        }
        else
        {
            foreach (GridViewRow drRows in invdata.Rows)
            {
                TextBox txtinvno = ((TextBox)drRows.FindControl("invno"));
                TextBox txtinvdt = ((TextBox)drRows.FindControl("invdt"));
                TextBox txtdeclval = ((TextBox)drRows.FindControl("declvalue"));
                TextBox txtpkgsno = ((TextBox)drRows.FindControl("pkgno"));
                TextBox txtactwt = ((TextBox)drRows.FindControl("actwt"));
                TextBox txtlength = ((TextBox)drRows.FindControl("length"));

                sqlinvoice = "INSERT INTO webx_master_docket_invoice(DOCKNO,INVNO,INVDT,DECLVAL,PKGSNO,ACTUWT) VALUES(";
                sqlinvoice = sqlinvoice + "'" + docno + "',";
                sqlinvoice = sqlinvoice + "'" + txtinvno.Text + "',";
                sqlinvoice = sqlinvoice + "'" + txtinvdt.Text + "',";
                sqlinvoice = sqlinvoice + "" + txtdeclval.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtpkgsno.Text + ",";
                sqlinvoice = sqlinvoice + "" + txtactwt.Text + ")";
            }
        }

        cmd = new SqlCommand(sqlinvoice, conn);
        cmd.ExecuteNonQuery();

            ///////// ENTERY FOR PAID DOCKET
        if (paybas.Text.ToUpper().CompareTo("PAID") == 0)
        {
            string sssss = "UPDATE webx_trans_docket_status SET mr='Y' WHERE dockno='" + dockno.Text + "'";
            cmd = new SqlCommand(sssss, conn);
            cmd.ExecuteNonQuery();
        }
        else
        {
            string sssss = "UPDATE webx_trans_docket_status SET mr='N' WHERE dockno='" + dockno.Text + "'";
            cmd = new SqlCommand(sssss, conn);
            cmd.ExecuteNonQuery();
        }

        //////////DOCUMENT UPDATION
        string sqldocument = "DELETE FROM webx_master_docket_document WHERE dockno='" + docno + "'";
        cmd = new SqlCommand(sqldocument, conn);
        cmd.ExecuteNonQuery();

        foreach (GridViewRow drRows in rptDocketList.Rows)
        {

            TextBox txtdocu = ((TextBox)drRows.FindControl("docu"));
            sqldocument = "INSERT INTO webx_master_docket_document(dockno,docksf,documentno) VALUES('" + docno + "','.','" + txtdocu.Text + "')";
            cmd = new SqlCommand(sqldocument, conn);
            cmd.ExecuteNonQuery();
        }

    } // UPDATE ENDED



}

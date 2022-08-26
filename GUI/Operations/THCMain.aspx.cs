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
using System.Data.SqlClient;

public partial class GUI_Operations_THC_THCMain : System.Web.UI.Page
{
    public static string strLSCaption;
    public static string strSQL;
    public static string strNewTHCNo;
    public static string strNewVehcileTrackNo;
    static string strRouteModeForViewName;
    public static int intTotalRecords;
    public static bool blnPostSQL;
    string strMFNoList;
    public static double mf_dblWtTotal = 0;

    protected string ServiceTaxRate="", OtherTaxRate="",routecd="";

    protected string acccode = "", accdesc = "";
    SqlConnection con;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        MySQLDataSource_RouteNames.ConnectionString = Session["SqlProvider"].ToString().Trim();

        string sql = "SELECT accdesc+':'+Company_acccode as dispval,accdesc,acccode FROM webx_acctinfo WHERE acccode='CLA0015'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        tdsacccode.Items.Clear();
        while (dr.Read())
        {
            tdsacccode.Items.Add(new ListItem(dr["dispval"].ToString(), dr["acccode"].ToString()));
            acccode = dr["acccode"].ToString();
            accdesc = dr["accdesc"].ToString();
        }
         
        dr.Close();
        

        if (!IsPostBack)
        {
            balamtbr.Text = Session["brcd"].ToString().Trim();
            txtTHCDate.Value = System.DateTime.Today.ToString("dd/MM/yyyy");
            HidSystemDate.Value = txtTHCDate.Value;

            txtActualDepDate.Value = txtTHCDate.Value;
            txtActualDepTimeHH.Value = System.DateTime.Now.Hour.ToString("00");
            txtActualDepTimeMM.Value = System.DateTime.Now.Minute.ToString("00");

            txtEmpCode.Text = Session["empcd"].ToString();
            //txtFinCompAt.Text = Session["brcd"].ToString();

            populateLateDepartureReason();

            getDocumentDetails();

          
        }

        lblHeader.InnerHtml = "<b>Prepare New " + Session["THCCalledAs"] + "</b>";
        lblSelCriteria.InnerHtml = "<b>Select criteria for preparing New " + Session["THCCalledAs"] + "</b>";
        lblTHCNoCaption.InnerHtml = Session["THCCalledAs"] + " No.:";
        lblTHCDateCaption.InnerHtml = Session["THCCalledAs"] + " Date:";
        lblManTHCNo.InnerHtml = "Manual " + Session["THCCalledAs"] + " No.:";
        lblManualTHCNo.InnerHtml = "&nbsp;Invalid Manual " + Session["THCCalledAs"] + " No.!!!";
        lblManTHCNoHint.InnerHtml = "&nbsp;Hint: Enter NA if Manual " + Session["THCCalledAs"] + " No. is not available.";
        //lblTHCFF.InnerHtml = Session["THCCalledAs"];
        //lblMoreTHC.InnerHtml = "<a href=\"THCMain.aspx\"><u>Click here to prepare more " + Session["THCCalledAs"] + "s</u></a>";
        //lblVPTHC.InnerHtml = "<a href=\"Javascript:OpenInWindow('thcprintview_new.aspx?tcno=<%=strNewTHCNo%>',null,'left=700, top=700, height=500, width=600, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar= no')\"><u>View & Print " + Session["THCCalledAs"] + "</u></a>";
        lblMFNoCaption.InnerHtml = HidMF.Value + " No.";
        lblManMFNoCaption.InnerHtml = "Manual " + HidMF.Value + " No.";
        lblNoRecsForMF.InnerHtml = HidMF.Value + "s not found for the given Route";
        lblTotDockets.InnerHtml = "Total " + HidDocket.Value + "s&nbsp;";
        //lblLSMFOptions.InnerHtml = "<a href=\"./../LSMFOptions.aspx\"><u>" + HidLS.Value + " &amp; " + HidMF.Value + " Options</u></a>";

        //lblTHCVP.InnerHtml = "<a href=\"Javascript:OpenInWindow('thcprintview_new.aspx?tcno=\"" + strNewTHCNo + ",null,'left=700, top=700, height=500, width=600, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar= no')\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('thcprintview_new.aspx?tcno=\"" + strNewTHCNo + ",null,'left=700, top=700, height=500, width=600, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar= no')\"><u>Print</u></a>";
        
        btnPrepareTHC.Text = "Prepare New " + Session["THCCalledAs"];
        btnPrepareTHC.ToolTip = "Click here to prepare new " + Session["THCCalledAs"];

        Page.Title = "Prepare New " + Session["THCCalledAs"];

        if (!IsPostBack)
        {
            txtTHCDate.Focus();
        }
    }

    public void getstdpcamt()
    {
        string vendcd = ddlVendor.SelectedValue.ToString();
        string vehnocd = ddlVehicleNo.SelectedValue.ToString();
        string st_rutcd = ddlRouteCode.SelectedValue.ToString();
        stdpcamt.Text = mf_dblWtTotal.ToString();
        double db_stdpcamt = 0;
        //Response.Write("<br> vendcd : " + vendcd);
        string sql_stcontamt = "";
         con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        sql_stcontamt = "SELECT top 1 matrixcode,isnull(otherChrg,0) as otherChrg,usedCapacity=isnull((select (select usedCapacity from webx_vehicle_type where type_code=v.vehicle_type) from webx_vehicle_hdr v where vehno='" + vehnocd + "'),0),st_vehtpe=(select vehicle_type from webx_vehicle_hdr v where vehno='" + vehnocd + "') FROM webx_vendor_contract_MATRIX WHERE VENDORCODE='" + vendcd + "'";
        SqlCommand concmd = new SqlCommand(sql_stcontamt, con);
        SqlDataReader contdr = concmd.ExecuteReader();
        string st_matcode = "",st_vehtyp="";
        double amt_otcdg = 0, amt_capacity = 0, extraChrg = 0;
        while (contdr.Read())
        {
            st_matcode = contdr["matrixcode"].ToString();
            amt_otcdg = Convert.ToDouble(contdr["otherChrg"]);
            amt_capacity = Convert.ToDouble(contdr["usedCapacity"]);
            st_vehtyp = contdr["st_vehtpe"].ToString();
        }

        contdr.Close();
        


        string[] strArrMFDetails1 = HidFinalMFDetails.Value.Split('~');
        double dblWt1 = 0, totdblWt1 = 0;
        string wt = "";
        for (int ip = 0; ip < strArrMFDetails1.Length; ip++)
        {
            //dblWt1 = Convert.ToDouble(strArrMFDetails1[4].Substring(0, strArrMFDetails1[4].LastIndexOf('/')));

           // totdblWt1 += dblWt1;

            string[] strArrInnerMFDetails1 = strArrMFDetails1[ip].Split(',');

            dblWt1 = Convert.ToDouble(strArrInnerMFDetails1[4].Substring(0, strArrInnerMFDetails1[4].LastIndexOf('/')));

            totdblWt1 += dblWt1;

            //wt = strArrMFDetails1[4].ToString();
        }


        if (st_matcode == "1")
        {

            if (amt_otcdg > 0)
            {
                if (totdblWt1 > 1000 * amt_capacity)
                {
                    extraChrg = amt_otcdg * totdblWt1 - (1000 * amt_capacity);
                }
            }


            string st_sqlmat1 = "SELECT slabvalue FROM webx_vendor_contract_charges WHERE VENDORCODE='" +vendcd+ "' and matrixcode='"+st_matcode+ "' and routecd='" + st_rutcd + "' and convert(varchar,vehtype)='" +st_vehtyp+ "'";
            SqlCommand concmd1 = new SqlCommand(st_sqlmat1, con);
            SqlDataReader contdr1 = concmd1.ExecuteReader();
            double amt_m1slab = 0;
            while (contdr1.Read())
            {
                amt_m1slab = Convert.ToDouble(contdr1["slabvalue"]);
            }

            db_stdpcamt = extraChrg + amt_m1slab;

            contdr1.Close();

        }
        else if (st_matcode == "9")
        {
            string st_sqlmat3 = "SELECT slabrate,slabfrom as minval,slabto as maxval  FROM webx_vendor_contract_charges WHERE VENDORCODE='" + vendcd + "' and matrixcode='" + st_matcode + "' and " + totdblWt1 + " between slabfrom and slabto ";
            SqlCommand concmd3 = new SqlCommand(st_sqlmat3, con);
            SqlDataReader contdr3 = concmd3.ExecuteReader();
            double amt_m1slabrate = 0, minval = 0, maxval = 0;
            while (contdr3.Read())
            {
                amt_m1slabrate = Convert.ToDouble(contdr3["slabrate"]);
                minval = Convert.ToDouble(contdr3["minval"]);
                maxval = Convert.ToDouble(contdr3["maxval"]);
            }

            db_stdpcamt = extraChrg + amt_m1slabrate;

            if (db_stdpcamt < minval)
            {
                db_stdpcamt = minval;
            }
            if (db_stdpcamt < maxval)
            {
                db_stdpcamt = maxval;
            }

            contdr3.Close();
        }

        stdpcamt.Text = db_stdpcamt.ToString();
       
        con.Close();

        //foreach (TableRow tr in tblmflist)
        //{
        //    CheckBox chk = (CheckBox)tr.FindControl("chkSelectMF");
        //    Label LBLmf = (Label)tr.FindControl("lblmf");
        //    if(chk.Checked==true)
        //    {

        //        if (ST_MF = "")
        //        {
        //            ST_MF = "'"+LBLmf+"'";
        //        }
        //        else
        //        {
        //            ST_MF = "'" + ST_MF + "','" + LBLmf + "'";
        //        }
                        
        //    }
        //}



    }

    protected void btnPrepareTHC_Click(object sender, EventArgs e)
    {
        //Generate New THC No.
        string strNewTHCNo=generateNewTHCNo();

        if (strNewTHCNo != "")
        {
            //Generate New Vehicle Track No.
            //generateNewVehicleTrackNo();

            prepareTHC();

         

            string sql = "UPDATE webx_thc_summary SET loadOperType='" + loadOpertype.Text + "',advamt=" + advanceamt.Text + ",advpaidby='" + advpaidby.Text + "',advpaiddt=GETDATE(),pcamt=";
            sql = sql + contractamt.Text + ",tel_chrg=" + tel_chrg.Text + ",mamul_chrg=" + mamul_chrg.Text + ",load_chrg=" + load_chrg.Text;
            sql = sql + ",balamtbrcd='" + balamtbr.Text + "',tds_rate=" + tds_rate.Text + ",tds_chrg=" + tds_chrg.Text + ",pan_no='" + pan_no.Text;
            sql = sql + "',tds_acccode='" + acccode + "',tds_accdesc='" + accdesc + "',tdsgrpcode='" + acccode + "',tdsgrpdesc='" + accdesc;
            //sql = sql + "',tdsfor='" + tdsfor.SelectedValue + "',svrcamt=" + svrcamt.Text + ",cessamt=" + cessamt.Text + ",netbalamt=" + balamt.Text + ",advance_paid='O',";
            sql = sql + "',tdsfor='-',svrcamt=" + svrcamt.Text + ",cessamt=" + cessamt.Text + ",netbalamt=" + balamt.Text + ",advance_paid='O',";
            sql = sql + "advamt_lastpaid=" + advanceamt.Text + ",svrc_rate='" + svtax_rate.Text + "',thcnew_mode='F',";

            //sql = sql + "cwt=" + txtcwt.Text + ",height=" + txtheight.Text + ",detention=" + txtdetentionchg.Text + ",";
            //sql=sql + "multi_point=" + txtmultipt.Text + ",";

            sql = sql + "hedu_cess=" + hcessamt.Text + ",rut_cat='" + ddlRouteMode.SelectedValue.ToString() + "'  WHERE thcno='" + strNewTHCNo + "'";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.ExecuteNonQuery();
            string Vno = "";
            if (Convert.ToInt16(advanceamt.Text) <= 0)
            {

                sql = "update webx_thc_summary SET advance_paid='Y' WHERE thcno='" + strNewTHCNo + "'";
                cmd = new SqlCommand(sql, con);
                cmd.ExecuteNonQuery();
            }

            if (Session["Client"].ToString() == "RLL")
            {
                //********************Advance transaction Entries************************************
                string Vbrcd = Session["brcd"].ToString(), Voucherno = fn.NextVoucherno(Vbrcd, "07");
                Vno = fn.NextVoucherno(Vbrcd, "07");

                //string sql_Adv_acct = "exec usp_THCTransaction 1,'" + strNewTHCNo.ToString() + "','.','07','" + Session["empcd"].ToString() + "','" + Vno + "'";
                //cmd = new SqlCommand(sql_Adv_acct, con);
                //// Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
                //cmd.ExecuteNonQuery();

                string sql_bal_acct = "exec usp_THCTransaction 2,'" + strNewTHCNo.ToString() + "','.','07','" + Session["empcd"].ToString() + "','" + Vno + "'";
                cmd = new SqlCommand(sql_bal_acct, con);
                // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
                cmd.ExecuteNonQuery();

                sql_bal_acct = "exec usp_THCTransaction 3,'" + strNewTHCNo.ToString() + "','.','07','" + Session["empcd"].ToString() + "','" + Vno + "'";
                cmd = new SqlCommand(sql_bal_acct, con);
                // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
                cmd.ExecuteNonQuery();

                //************************************************************************************
                Response.Redirect("DisplayTHCResult.aspx?THCNo=" + strNewTHCNo + "&ManTHCNo=" + txtManualTHCNo.Text.Trim() + "&voucherNo=" + Vno);
            }
            else
            {
                Vno = "NA";
                Response.Redirect("DisplayTHCResult.aspx?THCNo=" + strNewTHCNo + "&ManTHCNo=" + txtManualTHCNo.Text.Trim() + "&voucherNo=" + Vno);
            }
        }
    }

    protected void txtEmpCode_TextChanged(object sender, EventArgs e)
    {
        checkSupervisorCode();        
    }

    protected void txtManualTHCNo_TextChanged(object sender, EventArgs e)
    {
        checkManualTHCNo();
    }

    //protected void txtFinCompAt_TextChanged(object sender, EventArgs e)
    //{
    //    checkFinancialCompletionAt();
    //}

    protected void ddlRouteMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        additionalRowsVisibleFalse();

        ddlVehicleNo.Visible = true;
        lblVehicleNoOR.Visible = true;

        if (ddlRouteMode.SelectedValue == "-1")
        {
            //ddlRouteCode.Items.Clear();
            //ddlRouteCode.Items.Insert(0, new ListItem("Select", "-1"));
            ddlVendorType.Items.Clear();
            ddlVendorType.Items.Insert(0, new ListItem("Select", "-1"));
            ddlVendor.Items.Clear();
            ddlVendor.Items.Insert(0, new ListItem("Select", "-1"));
        }
        else
        {
            //Populate Route Code drop down list
            //populateRouteCode();
            //Populate Vendor Type drop down list
            populateVendorType();
            //Manage Vendor Type change
            vendorTypeChanged();
            //Manage Vehicle Info ROWS
            manageVehicleInfo("xxx");
            //Populate Vendor drop down list
            populateVendor();
        }

        //manageRouteCodeChanges();
    }

    protected void ddlRouteCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        manageRouteCodeChanges();
    }

    protected void ddlVehicleNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        VehicleNoChanged();
        //Fleet Code
        populateTripSheetNo();
    }

    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetPANNumber();
        populateVehicleType();
        populateVehicleNo();
    }

    protected void GetPANNumber()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        strSQL = "Select PAN_NO From WebX_Vendor_Hdr Where VendorCode='" + ddlVendor.Items[ddlVendor.SelectedIndex].Value.ToString().Trim() + "'";
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlCommand.CommandType = CommandType.Text;
        SqlDataReader dr = sqlCommand.ExecuteReader();
        while (dr.Read())
        {
            pan_no.Text = dr["pan_no"].ToString();
        }
        dr.Close();
    }


    protected void ddlVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        vendorTypeChanged();
    }

    private void populateRouteCode()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "usp_RouteNames_For_New_THC";
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        sqlCommand.Parameters.Add("@routemode", SqlDbType.VarChar).Value = ddlRouteMode.SelectedValue.Trim();
        /*    
        string strSQLIn = "(Select tobh_code From vw_Next_Locations_For_New_THC where tcbr='" + Session["brcd"].ToString() + "')";
        strSQL = "Select Distinct MyRouteCode, MyRouteName From vw_NewTHC_Routes_3 where tcbr='" + Session["brcd"].ToString() + "' and tobh_code in " + strSQLIn + " and MyRouteMode='" + ddlRouteMode.SelectedValue + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        */
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsRouteCode = new DataSet();

        sqlDA.Fill(dsRouteCode);

        ddlRouteCode.Items.Clear();

        ddlRouteCode.DataSource = dsRouteCode;
        ddlRouteCode.DataTextField = "MyRouteName";
        ddlRouteCode.DataValueField = "MyRouteCode";
        ddlRouteCode.DataBind();

        //ddlRouteCode.Items.Insert(0, new ListItem("Select", "-1"));

        sqlConn.Close();        
        /*
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQLIn = "(Select tobh_code From vw_Next_Locations_For_New_THC where tcbr='" + Session["brcd"].ToString() + "')";
        strSQL = "Select Distinct MyRouteCode, MyRouteName From vw_RouteCode_For_New_THC3 where tcbr='" + Session["brcd"].ToString() + "' and tobh_code in " + strSQLIn + " and MyRouteMode='" + ddlRouteMode.SelectedValue + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsRouteCode = new DataSet();

        sqlDA.Fill(dsRouteCode);

        ddlRouteCode.Items.Clear();

        ddlRouteCode.DataSource = dsRouteCode;
        ddlRouteCode.DataTextField = "MyRouteName";
        ddlRouteCode.DataValueField = "MyRouteCode";
        ddlRouteCode.DataBind();

        ddlRouteCode.Items.Insert(0, new ListItem("Select", "-1"));

        sqlConn.Close();*/        
    }

    private void populateVendor()
    {
        //--Fleet Code
        trTS.Visible = false;
        //--
        tdVendorDDL.Visible = true;
        tdVendor.Visible = false;

        ddlVendor.Items.Clear();

        if (ddlVendorType.SelectedValue == "-1")
        {
            ddlVendor.Items.Insert(0, new ListItem("Select", "-1"));
        }
        else
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            strRouteModeForViewName = "Road";
            DataSet dsVendor;
            SqlCommand sqlCommand;
            SqlDataAdapter sqlDA;

            //---Start Change on 10 Dec 2007
            strSQL = "usp_Vendors";
            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            switch (ddlRouteMode.SelectedValue)
            {
                case "R":
                    switch (ddlVendorType.SelectedValue)
                    {
                        case "A":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "10";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "O":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "YY";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "M":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "XX";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);

                            tdVendorDDL.Visible = false;
                            tdVendor.Visible = true;

                            break;
                    }
                    break;
                case "A":
                    switch (ddlVendorType.SelectedValue)
                    {
                        case "A":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "09";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "O":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "ZZ";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "M":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "XX";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);

                            tdVendorDDL.Visible = false;
                            tdVendor.Visible = true;

                            break;
                    }
                    break;
                case "S":
                    switch (ddlVendorType.SelectedValue)
                    {
                        case "A":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "03";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "O":
                            //Fleet Code
                            trTS.Visible = true;    
                            //--
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "05";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "C":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "04";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);
                            break;
                        case "M":
                            sqlCommand.Parameters.Add("@vendor_type", SqlDbType.VarChar).Value = "XX";
							sqlCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
							sqlDA = new SqlDataAdapter(sqlCommand);

                            tdVendorDDL.Visible = false;
                            tdVendor.Visible = true;

                            break;
                    }
                    break;
            }
            sqlDA = new SqlDataAdapter(sqlCommand);
            dsVendor = new DataSet();
            sqlDA.Fill(dsVendor);
            if (dsVendor.Tables[0].Rows.Count > 0)
            {
                ddlVendor.DataSource = dsVendor;
                ddlVendor.DataTextField = dsVendor.Tables[0].Columns[1].ColumnName;
                ddlVendor.DataValueField = dsVendor.Tables[0].Columns[0].ColumnName;
                ddlVendor.DataBind();
            }
            else
            {
                ddlVendor.Items.Insert(0, new ListItem("No Vendors Available", "-1"));
            }
            //---End Change on 10 Dec 2007

            /*
            switch (ddlVendorType.SelectedValue)
            {
                case "A":
                    //strSQL = "Select * From vw_" + strRouteModeForViewName + "_vendors_attached Where Vendor_Code in (Select vendorcode from webx_vendor_det where rtrim(ltrim(vendorbrcd))= '" + Session["brcd"].ToString() + "')";
                    strSQL = "Select * From vw_" + strRouteModeForViewName + "_vendors_attached Where Vendor_Code in (Select vendorcode from webx_vendor_det where (select [dbo].SplitWithSearch(vendorbrcd, ',', '" + Session["brcd"].ToString() + "')) = 1)";
                    sqlCommand = new SqlCommand(strSQL, sqlConn);
                    sqlDA = new SqlDataAdapter(sqlCommand);

                    dsVendor = new DataSet();

                    sqlDA.Fill(dsVendor);

                    if (dsVendor.Tables[0].Rows.Count > 0)
                    {
                        ddlVendor.DataSource = dsVendor;
                        ddlVendor.DataTextField = dsVendor.Tables[0].Columns[1].ColumnName;
                        ddlVendor.DataValueField = dsVendor.Tables[0].Columns[0].ColumnName;
                        ddlVendor.DataBind();
                    }
                    else
                    {
                        ddlVendor.Items.Insert(0, new ListItem("No Vendors Available", "-1"));
                    }

                    break;

                case "O":
                    strSQL = "Select * From vw_Road_Vendors_Own";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);
                    sqlDA = new SqlDataAdapter(sqlCommand);

                    dsVendor = new DataSet();

                    sqlDA.Fill(dsVendor);

                    if (dsVendor.Tables[0].Rows.Count > 0)
                    {
                        ddlVendor.DataSource = dsVendor;
                        ddlVendor.DataTextField = dsVendor.Tables[0].Columns[1].ColumnName;
                        ddlVendor.DataValueField = dsVendor.Tables[0].Columns[0].ColumnName;
                        ddlVendor.DataBind();
                    }
                    else
                    {
                        ddlVendor.Items.Insert(0, new ListItem("No Vendors Available", "-1"));                       
                    }

                    break;

                case "C":
                    strSQL = "Select * From vw_Road_Vendors_Co_Loader Where Vendor_Code in (Select vendorcode from webx_vendor_det where rtrim(ltrim(vendorbrcd))='" + Session["brcd"].ToString() + "')";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);
                    sqlDA = new SqlDataAdapter(sqlCommand);

                    dsVendor = new DataSet();

                    sqlDA.Fill(dsVendor);

                    if (dsVendor.Tables[0].Rows.Count > 0)
                    {
                        ddlVendor.DataSource = dsVendor;
                        ddlVendor.DataTextField = dsVendor.Tables[0].Columns[1].ColumnName;
                        ddlVendor.DataValueField = dsVendor.Tables[0].Columns[0].ColumnName;
                        ddlVendor.DataBind();
                    }
                    else
                    {
                        ddlVendor.Items.Insert(0, new ListItem("No Vendors Available", "-1"));
                    }

                    break;

                case "M":
                    tdVendorDDL.Visible = false;
                    tdVendor.Visible = true;

                    break;
            }
*/
            sqlConn.Close();
        }
    }

    //=============Fleet Code===================
    private void populateTripSheetNo()
    {

        DataSet dsTripSheetNo;
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDA;

        ddlTripSheetNo.Items.Clear();

        if (ddlVehicleNo.SelectedValue == "")
        {
            ddlTripSheetNo.Items.Insert(0, new ListItem("Select", ""));

        }
        else
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            strSQL = "usp_TripSheetListForTHC";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = ddlVehicleNo.SelectedValue;

            //sqlCommand.Parameters.AddWithValue("@VehicleNo", ddlVehicleNo.SelectedValue);

            sqlDA = new SqlDataAdapter(sqlCommand);

            dsTripSheetNo = new DataSet();

            sqlDA.Fill(dsTripSheetNo);

            if (dsTripSheetNo.Tables[0].Rows.Count > 0)
            {
                ddlTripSheetNo.DataSource = dsTripSheetNo;
                ddlTripSheetNo.DataTextField = dsTripSheetNo.Tables[0].Columns[0].ColumnName;
                ddlTripSheetNo.DataValueField = dsTripSheetNo.Tables[0].Columns[0].ColumnName;
                ddlTripSheetNo.DataBind();
                ddlTripSheetNo.Items.Insert(0, new ListItem("Select", ""));
            }
            else
            {
                ddlTripSheetNo.Items.Insert(0, new ListItem("No Trip Sheet Available", ""));
            }
            sqlConn.Close();

        }
    }
    //=============Fleet Code===================


    private void populateVendorType()
    {
        ddlVendorType.Items.Clear();

        switch (ddlRouteMode.SelectedValue)
        {
            case "-1":
                ddlVendorType.Items.Insert(0, new ListItem("Select", "-1"));
                break;
            case "R":
            case "A":
                ddlVendorType.Items.Insert(0, new ListItem("Select", "-1"));
                ddlVendorType.Items.Insert(1, new ListItem("Attached", "A"));
                ddlVendorType.Items.Insert(2, new ListItem("Market", "M"));
                ddlVendorType.Items.Insert(3, new ListItem("Own", "O"));
                break;
            case "S":
                ddlVendorType.Items.Insert(0, new ListItem("Select", "-1"));
                ddlVendorType.Items.Insert(1, new ListItem("Attached", "A"));
                ddlVendorType.Items.Insert(2, new ListItem("Market", "M"));
                ddlVendorType.Items.Insert(3, new ListItem("Own", "O"));
                ddlVendorType.Items.Insert(4, new ListItem("Co-Loader", "C"));
                break;
            default:
                ddlVendorType.Items.Insert(0, new ListItem("Select", "-1"));
                break;
        }
    }

    private void manageVehicleInfo(string VehicleNo)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        if (ddlRouteMode.SelectedValue == "S")
        {
            strSQL = "Select * From vw_vehicles where vehno='" + VehicleNo + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsVehicleInfo = new DataSet();

            sqlDA.Fill(dsVehicleInfo);

            trVehicleInfoForRouteModeS.Visible = true;

            if (dsVehicleInfo.Tables[0].Rows.Count > 0)
            {
                //For Vehicle Type
                tdVehicleNotFoundForVehType.Visible = false;
                tdVehicleFoundForVehType.Visible = true;
                lblVehicleType.InnerHtml = dsVehicleInfo.Tables[0].Rows[0]["Type_Name"].ToString();
                HidVehicleType.Value = (dsVehicleInfo.Tables[0].Rows[0]["Vehicle_Type"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["Vehicle_Type"].ToString().Trim() == "" ? "-" : dsVehicleInfo.Tables[0].Rows[0]["Vehicle_Type"].ToString());
                //For Engine No.
                tdVehicleNotFoundForEngine.Visible = false;
                tdVehicleFoundForEngine.Visible = true;
                lblEngineNo.InnerHtml = (dsVehicleInfo.Tables[0].Rows[0]["EngineNo"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["EngineNo"].ToString().Trim() == "" ? "-" : dsVehicleInfo.Tables[0].Rows[0]["EngineNo"].ToString());
                //For Chasis No.
                tdVehicleNotFoundForChasis.Visible = false;
                tdVehicleFoundForChasis.Visible = true;
                lblChasisNo.InnerHtml = (dsVehicleInfo.Tables[0].Rows[0]["ChasisNo"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["ChasisNo"].ToString().Trim() == "" ? "-" : dsVehicleInfo.Tables[0].Rows[0]["ChasisNo"].ToString());
                //For RC Book No.
                tdVehicleNotFoundForRCBook.Visible = false;
                tdVehicleFoundForRCBook.Visible = true;
                lblRCBook.InnerHtml = (dsVehicleInfo.Tables[0].Rows[0]["RCBookNo"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["RCBookNo"].ToString().Trim() == "" ? "-" : dsVehicleInfo.Tables[0].Rows[0]["RCBookNo"].ToString());
                //For Vehicle Registration Date
                tdVehicleNotFoundRegDate.Visible = false;
                tdVehicleFoundRegDate.Visible = true;
                lblRegDate.InnerHtml = (dsVehicleInfo.Tables[0].Rows[0]["RegistrationDt"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["RegistrationDt"].ToString().Trim() == "" ? "-" : (dsVehicleInfo.Tables[0].Rows[0]["RegistrationDt"].ToString().IndexOf('/') == 0 ? getDateInddMMMyyFormat(Convert.ToDateTime(dsVehicleInfo.Tables[0].Rows[0]["RegistrationDt"].ToString()).ToString("dd/MM/yyyy")) : getDateInddMMMyyFormat(dsVehicleInfo.Tables[0].Rows[0]["RegistrationDt"].ToString())));
                //For Insurance Policy Date
                tdVehicleNotFoundInsPolicyDate.Visible = false;
                tdVehicleFoundInsPolicyDate.Visible = true;
                lblInsPolicyDate.InnerHtml = (dsVehicleInfo.Tables[0].Rows[0]["InsuranceValDt"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["InsuranceValDt"].ToString().Trim() == "" ? "-" : (dsVehicleInfo.Tables[0].Rows[0]["InsuranceValDt"].ToString().IndexOf('/') == 0 ? getDateInddMMMyyFormat(Convert.ToDateTime(dsVehicleInfo.Tables[0].Rows[0]["InsuranceValDt"].ToString()).ToString("dd/MM/yyyy")) : getDateInddMMMyyFormat(dsVehicleInfo.Tables[0].Rows[0]["InsuranceValDt"].ToString())));
                //For Fitness Certificate/Validity Date
                tdVehicleNotFoundFitnessCertValidDate.Visible = false;
                tdVehicleFoundFitnessCertValidDate.Visible = true;
                lblFitnessCertValidDate.InnerHtml = (dsVehicleInfo.Tables[0].Rows[0]["FitnessValDt"].ToString().ToUpper() == "NULL" || dsVehicleInfo.Tables[0].Rows[0]["FitnessValDt"].ToString().Trim() == "" ? "-" : (dsVehicleInfo.Tables[0].Rows[0]["FitnessValDt"].ToString().IndexOf('/') == 0 ? getDateInddMMMyyFormat(Convert.ToDateTime(dsVehicleInfo.Tables[0].Rows[0]["FitnessValDt"].ToString()).ToString("dd/MM/yyyy")) : getDateInddMMMyyFormat(dsVehicleInfo.Tables[0].Rows[0]["FitnessValDt"].ToString())));
            }
            else
            {
                //For Vehicle Type
                tdVehicleNotFoundForVehType.Visible = true;
                //Populate Vehicle Type
                populateVehicleType();
                //For Engine No.
                tdVehicleNotFoundForEngine.Visible = true;
                //For Chasis No.
                tdVehicleNotFoundForChasis.Visible = true;
                //For RC Book No.
                tdVehicleNotFoundForRCBook.Visible = true;
                //For Vehicle Registration Date
                tdVehicleNotFoundRegDate.Visible = true;
                //For Insurance Policy Date
                tdVehicleNotFoundInsPolicyDate.Visible = true;
                //For Fitness Certificate/Validity Date
                tdVehicleNotFoundFitnessCertValidDate.Visible = true;
            }
        }
        else if (ddlRouteMode.SelectedValue == "R")
        {
            trVehicleInfoForRouteModeR.Visible = true;
        }
        else if (ddlRouteMode.SelectedValue == "A")
        {
            trVehicleInfoForRouteModeA.Visible = true;
        }
    }

    private void populateVehicleType()
    {
        ddlVehicleType.Items.Clear();

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "Select Type_Code, [Type_Name] AS VehicleType From webx_vehicle_type WHERE activeflag = 'Y' order by [Type_Name]";
        //strSQL = "select CodeId AS Type_Code, CodeDesc AS VehicleType from webx_master_general where codetype = 'VEHTYP' and StatusCode = 'Y'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsVehicleType = new DataSet();

        sqlDA.Fill(dsVehicleType);

        if (dsVehicleType.Tables[0].Rows.Count > 0)
        {
            ddlVehicleType.DataSource = dsVehicleType;
            ddlVehicleType.DataTextField = "VehicleType";
            ddlVehicleType.DataValueField = "Type_Code";
            ddlVehicleType.DataBind();
        }

        ddlVehicleType.Items.Insert(0, new ListItem("Select", "-1"));
    }

    private void populateVehicleNo()
    {
        ddlVehicleNo.Items.Clear();

        if (ddlVendorType.SelectedValue == "-1")
        {
            ddlVehicleNo.Items.Insert(0, new ListItem("Select", "-1"));
            ddlVehicleNo.Visible = true;
            lblVehicleNoOR.Visible = true;
        }
        else
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            DataSet dsVehicleNo;
            SqlCommand sqlCommand;
            SqlDataAdapter sqlDA;

            switch (ddlVendorType.SelectedValue)
            {
                case "A":
                    if (ddlRouteMode.SelectedValue == "S")
                    {
                        strSQL = "Select distinct vehno From vw_vehicle_on_road where vendorcode in ('" + ddlVendor.SelectedValue + "')";
                        
                        sqlCommand = new SqlCommand(strSQL, sqlConn);
                        sqlDA = new SqlDataAdapter(sqlCommand);

                        dsVehicleNo = new DataSet();

                        sqlDA.Fill(dsVehicleNo);

                        if (dsVehicleNo.Tables[0].Rows.Count > 0)
                        {
                            ddlVehicleNo.DataSource = dsVehicleNo;
                            ddlVehicleNo.DataTextField = dsVehicleNo.Tables[0].Columns[0].ColumnName;
                            ddlVehicleNo.DataValueField = dsVehicleNo.Tables[0].Columns[0].ColumnName;
                            ddlVehicleNo.DataBind();
                            ddlVehicleNo.Items.Insert(0, new ListItem("Select", "-1"));
                        }
                        else
                        {
                            ddlVehicleNo.Items.Insert(0, new ListItem("No Vehicles Available", "-1"));
                        }
    
                        ddlVehicleNo.Visible = true;
                        lblVehicleNoOR.Visible = true;
                    }
                    else
                    {
                        ddlVehicleNo.Visible = false;
                        lblVehicleNoOR.Visible = false;
                    }

                    break;

                case "O":
                    if (ddlRouteMode.SelectedValue == "S")
                    {
                        strSQL = "Select distinct vehno From vw_vehicle_on_road_company_own where vendorcode in ('" + ddlVendor.SelectedValue + "')";

                        sqlCommand = new SqlCommand(strSQL, sqlConn);
                        sqlDA = new SqlDataAdapter(sqlCommand);

                        dsVehicleNo = new DataSet();

                        sqlDA.Fill(dsVehicleNo);

                        if (dsVehicleNo.Tables[0].Rows.Count > 0)
                        {
                            ddlVehicleNo.DataSource = dsVehicleNo;
                            ddlVehicleNo.DataTextField = dsVehicleNo.Tables[0].Columns[0].ColumnName;
                            ddlVehicleNo.DataValueField = dsVehicleNo.Tables[0].Columns[0].ColumnName;
                            ddlVehicleNo.DataBind();
                            ddlVehicleNo.Items.Insert(0, new ListItem("Select", "-1"));
                        }
                        else
                        {
                            ddlVehicleNo.Items.Insert(0, new ListItem("No Vehicles Available", "-1"));
                        }

                        ddlVehicleNo.Visible = true;
                        lblVehicleNoOR.Visible = true;
                    }
                    else
                    {
                        ddlVehicleNo.Visible = false;
                        lblVehicleNoOR.Visible = false;
                    }

                    break;

                case "C":
                    if (ddlRouteMode.SelectedValue == "S")
                    {
                        strSQL = "Select * From vw_vehicle_on_road_co_loader where vendorcode in ('" + ddlVendor.SelectedValue + "')";

                        sqlCommand = new SqlCommand(strSQL, sqlConn);
                        sqlDA = new SqlDataAdapter(sqlCommand);

                        dsVehicleNo = new DataSet();

                        sqlDA.Fill(dsVehicleNo);

                        if (dsVehicleNo.Tables[0].Rows.Count > 0)
                        {
                            ddlVehicleNo.DataSource = dsVehicleNo;
                            ddlVehicleNo.DataTextField = dsVehicleNo.Tables[0].Columns[0].ColumnName;
                            ddlVehicleNo.DataValueField = dsVehicleNo.Tables[0].Columns[0].ColumnName;
                            ddlVehicleNo.DataBind();
                            ddlVehicleNo.Items.Insert(0, new ListItem("Select", "-1"));
                        }
                        else
                        {
                            ddlVehicleNo.Items.Insert(0, new ListItem("No Vehicles Available", "-1"));
                        }

                        ddlVehicleNo.Visible = true;
                        lblVehicleNoOR.Visible = true;
                    }
                    else
                    {
                        ddlVehicleNo.Visible = false;
                        lblVehicleNoOR.Visible = false;
                    }

                    break;

                case "M":
                    ddlVehicleNo.Visible = false;
                    lblVehicleNoOR.Visible = false;
                    
                    break;

                default:
                    ddlVehicleNo.Visible = false;
                    lblVehicleNoOR.Visible = false;

                    break;
            }

            sqlConn.Close();
        }

        //Manage Vehicle Info
        VehicleNoChanged();
    }

    private void checkSupervisorCode()
    {
        //Check for Supervisor
        txtEmpCode.Text = txtEmpCode.Text.Trim().ToUpper();

        if (txtEmpCode.Text == "")
        {
            txtEmpCode.Text = Session["empcd"].ToString().ToUpper();
            lblErrorEmpCode.Visible = false;
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLSupervisor = "select UserID From webx_master_users where rtrim(ltrim(UserID))='" + txtEmpCode.Text + "' and (rtrim(ltrim(branchcode))='" + Session["brcd"].ToString() + "' Or rtrim(ltrim(branchcode))='" + Session["mainbrcd"].ToString() + "') and Status='100'";

        SqlCommand sqlCommand = new SqlCommand(strSQLSupervisor, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsSupervisor = new DataSet();

        sqlDA.Fill(dsSupervisor);

        //Remove this code
        if (txtEmpCode.Text == Session["empcd"].ToString().ToUpper())
        {
            lblErrorEmpCode.Visible = false;
        }
        else
        {
            lblErrorEmpCode.Visible = (dsSupervisor.Tables[0].Rows.Count > 0 ? false : true);
        }

        sqlConn.Close();
    }

    //private void checkFinancialCompletionAt()
    //{
    //    //Check for Finacial Completion At Branch
    //    txtFinCompAt.Text = txtFinCompAt.Text.Trim().ToUpper();

    //    if (txtFinCompAt.Text == "")
    //    {
    //        txtFinCompAt.Text = Session["brcd"].ToString().ToUpper();
    //        lblErrorFinCompAt.Visible = false;
    //        return;
    //    }

    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    String strSQLFinCompAt = "select LocCode From webx_location where rtrim(ltrim(LocCode))='" + txtFinCompAt.Text + "'";

    //    SqlCommand sqlCommand = new SqlCommand(strSQLFinCompAt, sqlConn);
    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsFinCompAt = new DataSet();

    //    sqlDA.Fill(dsFinCompAt);

    //    lblErrorFinCompAt.Visible = (dsFinCompAt.Tables[0].Rows.Count > 0 ? false : true);

    //    sqlConn.Close();
    //}

    private void additionalRowsVisibleFalse()
    {
        trVehicleInfoForRouteModeA.Visible = false;
        trVehicleInfoForRouteModeS.Visible = false;
        trVehicleInfoForRouteModeR.Visible = false;
    }

    private void vendorTypeChanged()
    {
        //Populate Vendor
        populateVendor();
        //Populate Vehicle No.
        populateVehicleNo();
    }

    private void manageRouteCodeChanges()
    {
        txtSchedDepDate.Value = "";
        txtSchedDepTimeHH.Value = "";
        txtSchedDepTimeMM.Value = "";
        //txtFinCompAt.Text = "";

        if (ddlRouteCode.SelectedValue == "-1")
        {
            trDocketList.Visible = false;
            trTableHeadersForMF.Visible = false;
            trPrepareTHCErrorMsg.Visible = false;
            trNoRecsForDocketList.Visible = false;
        }
        else
        {
            string strNextLocation = ddlRouteCode.SelectedItem.Text.Replace("'","").Replace(",", "','").Replace("-", "','").Replace(":", "','").Trim();
            string strRouteCode = ddlRouteCode.SelectedValue;

            blnPostSQL = true;

            if (strRouteCode == "-1")
            {
                strNextLocation = "xxxxxxxx";
            }

            strSQL = "Select * From vw_manifest_for_new_thc Where tcbr='" + Session["brcd"].ToString() + "' and upper(tobh_code) in ('" + strNextLocation + "')";
            //Paint Manifest Listing
            paintManifestListing();

            //Show Scheduled Date & Time for the selected Route Code
            showScheduledDateTimeForRouteCode(strRouteCode);

            //Financial Completion At
            //showControllingLocationForRouteCode(strRouteCode);
        }
    }

    private void paintManifestListing()
    {
        try
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsManifestList = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("ChkVisible", typeof(bool));
            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("MFNo", typeof(string));
            dt.Columns.Add("ManualMFNo", typeof(string));
            dt.Columns.Add("BookingLocation", typeof(string));
            dt.Columns.Add("BookingDate", typeof(string));
            dt.Columns.Add("NextStop", typeof(string));
            dt.Columns.Add("Dockets_in_MF", typeof(string));
            dt.Columns.Add("PackagesLB", typeof(string));
            dt.Columns.Add("WeightLB", typeof(string));
            dt.Columns.Add("CFT", typeof(string));
            dt.Columns.Add("MF_Date", typeof(string));

            DataRow dr;

            sqlDA.Fill(dsManifestList);

            int i = 1;

            string strMFDate = "";

            trDocketList.Visible = true;
            trTableHeadersForMF.Visible = true;
            trPrepareTHCErrorMsg.Visible = false;

            if (dsManifestList.Tables[0].Rows.Count > 0)
            {
                trNoRecsForDocketList.Visible = false;
                rptDocketList.Visible = true;

                foreach (DataRow drRows in dsManifestList.Tables[0].Rows)
                {
                    dr = dt.NewRow();
                    
                    dr["SrNo"] = i.ToString();
                    i++;
                    
                    dr["ChkVisible"] = blnPostSQL;
                    dr["MFNo"] = drRows["TCNo"].ToString();
                    dr["ManualMFNo"] = (drRows["Manual_TCNo"].ToString().ToUpper() == "NULL" || drRows["Manual_TCNo"].ToString().Trim() == "" ? "-" : drRows["Manual_TCNo"].ToString());
                    dr["BookingLocation"] = drRows["tcbr"].ToString();
                    dr["BookingDate"] =  Convert.ToDateTime(drRows["tcdt"].ToString()).ToString("dd MMM yy");
                    dr["NextStop"] = drRows["tobh_code"].ToString().ToUpper();
                    dr["Dockets_in_MF"] = drRows["tot_dkt"].ToString();
                    dr["PackagesLB"] = drRows["Pkgs"].ToString();
                    dr["WeightLB"] = drRows["Wts"].ToString();
                    dr["CFT"] = drRows["CFT_Wt"].ToString();
                    dr["MF_Date"] = drRows["MF_Date"].ToString();
                    
                    dt.Rows.Add(dr);
                }

                rptDocketList.DataSource = dt;
                rptDocketList.DataBind();

                //trPrepareTHC.Visible = true;
               
                trpaydetail.Visible = true;
                HidFinalMFDetails.Value = "";
            }
            else
            {
                trNoRecsForDocketList.Visible = true;
                rptDocketList.Visible = false;
                //trPrepareTHC.Visible = false;
                trpaydetail.Visible = false;
            }

            sqlConn.Close();
        }
        catch (Exception Ex)
        {
            trPrepareTHCErrorMsg.Visible = true;
            lblPrepareTHCErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
    }

    private string generateNewTHCNo()
    {
        strNewTHCNo = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlCommand;

        sqlConn.Open();

        try
        {
            sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            //sqlCommand.CommandText = "usp_get_next_THC_code";

            //sqlCommand.Parameters.AddWithValue("@loccode", Session["brcd"].ToString());

            //AS PER NEW DB OBJECTS WITH IMPLEMENTATION OF NOMENCLATURE RULES
            sqlCommand.CommandText = "WebX_SP_GetNextDocumentCode";

        

            sqlCommand.Parameters.AddWithValue("@LocCode", Session["brcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@FinYear", Session["FinYear"].ToString());
            sqlCommand.Parameters.AddWithValue("@Document", "THC");
            
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsNewTHCNo = new DataSet();

            sqlDA.Fill(dsNewTHCNo);

            if (dsNewTHCNo.Tables[0].Rows.Count > 0)
            {
                strNewTHCNo = dsNewTHCNo.Tables[0].Rows[0][0].ToString();
            }
            else
            {
                strNewTHCNo = "";
            }
        }
        catch (Exception Ex)
        {
            strNewTHCNo = "";
        }
        finally
        {
            sqlCommand = null;
            sqlConn.Close();
            sqlConn = null;
        }
        return strNewTHCNo;
    }

    private void generateNewVehicleTrackNo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlCommand;

        sqlConn.Open();

        try
        {
            sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_get_next_vehicle_track_code";

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsNewVehcileTrackNo = new DataSet();

            sqlDA.Fill(dsNewVehcileTrackNo);

            if (dsNewVehcileTrackNo.Tables[0].Rows.Count > 0)
            {
                strNewVehcileTrackNo = dsNewVehcileTrackNo.Tables[0].Rows[0]["NewCode"].ToString();
            }
            else
            {
                strNewVehcileTrackNo = "";
            }
        }
        catch (Exception Ex)
        {
            strNewVehcileTrackNo = "";
        }
        finally
        {
            sqlCommand = null;
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void insertVehicleTrackNo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlCommand;

        sqlConn.Open();

        try
        {
            strSQL = "Insert into webx_VEHICLE_TRACKNO values('" + strNewVehcileTrackNo + "',getdate())";
            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlCommand.ExecuteNonQuery();
        }
        catch (Exception Ex)
        {
            
        }
        finally
        {
            sqlCommand = null;
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void prepareTHC()
    {
        //Fleet Code
        string mTripSheetNo = "null";
        if (ddlRouteMode.SelectedValue == "S" && ddlVendorType.SelectedValue == "O")
        {
            mTripSheetNo = "'" + ddlTripSheetNo.SelectedValue + "'";
        }
        //Fleet Code

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();

        SqlCommand sqlCommand;

        try
        {
            double dblPkgTotal = 0;
            double dblWtTotal = 0;
            double dblCFTTotal = 0;

            double dblPkg = 0;
            double dblWt = 0;
            double dblCFT = 0;
            
            string[] strArrMFDetails = HidFinalMFDetails.Value.Split('~');

            string strRouteCode = "";
            string strRouteName = "";

            if (ddlRouteCode.SelectedItem.Text.Contains(":"))
            {
                string[] strArrRoute = ddlRouteCode.SelectedItem.Text.Split(':');
                strRouteCode = strArrRoute[0].Trim();
                strRouteName = strArrRoute[1].Trim();
            }

            string strSourceHub = "";
            string strToHub = "";

            string strSummaryListField;
            string strSummaryListField2;
            string strSQLFinal;

            if (strRouteName.Contains("-"))
            {
                string[] strArrRouteName = strRouteName.Split('-');
                strSourceHub = strArrRouteName[0];
                strToHub = strArrRouteName[1];
            }

            string strVendorCode = "";
            string strVendorName = "";
            string strVendorAddress = "";

            if (HidMarketVeh.Value == "Y")
            {
                strVendorCode = ddlVendor.SelectedValue;
                strVendorName = txtVendorName.Value.Replace(" ", "_").Replace("'", "");
                strVendorAddress = txtVendorAddress.Value.Replace(" ", "_").Replace("'", "");
            }
            else
            {
                string[] strArrVendor = ddlVendor.SelectedItem.Text.Split(':');
                strVendorCode = strArrVendor[0].Trim();
                strVendorName = strArrVendor[1].Trim().Replace("'", "");
            }

            string strVehicleNo = (ddlVehicleNo.Visible == true ? (ddlVehicleNo.SelectedValue == "-1" ? txtVehicle.Value : ddlVehicleNo.SelectedValue) : txtVehicle.Value);

            strMFNoList = "";

            for (int intLoopCounter = 0; intLoopCounter < strArrMFDetails.Length; intLoopCounter++)
            {
                string[] strArrInnerMFDetails = strArrMFDetails[intLoopCounter].Split(',');

                strMFNoList = (strMFNoList == "" ? strArrInnerMFDetails[0] : strMFNoList + "~" + strArrInnerMFDetails[0]);

                dblPkg = Convert.ToDouble(strArrInnerMFDetails[3].Substring(0, strArrInnerMFDetails[3].LastIndexOf('/')));
                dblWt = Convert.ToDouble(strArrInnerMFDetails[4].Substring(0, strArrInnerMFDetails[4].LastIndexOf('/')));
                dblCFT = Convert.ToDouble(strArrInnerMFDetails[5]);

                dblPkgTotal += dblPkg;
                dblWtTotal += dblWt;
                dblCFTTotal += dblCFT;

                strSQL = "Update webx_TCHDR set ROUTE_CODE='" + strRouteCode + "', TFlag_YN = 'Y',THCBR = '" + Session["brcd"].ToString() + "', THCNO = '" + strNewTHCNo + "', THCsf = '.', THCDT='" + getDateInddMMMyyyFormat(txtTHCDate.Value) + "' ,VEHNO='" + strVehicleNo + "' where TCNO ='" + strArrInnerMFDetails[0] + "'";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlCommand.ExecuteNonQuery();

                //strSQL = "Insert into webx_thctc_pntr (THCNO,THCSF,TCNO,TCSF,TCBR,TCDATE,TC_CHWT,airbilltotamt,TOBH_Code,TOTDKT) " +
                //         "Select '" + strNewTHCNo + "' As THCNO, '.' As THCSF, TCNO, TCSF, TCBR, TCDT, TOT_CFTWT, 0 As airbilltotamt, ToBH_CODE, TOT_DKT From webx_tchdr Where tcno='" + strArrInnerMFDetails[0] + "'";

                //sqlCommand = new SqlCommand(strSQL, sqlConn);

                //sqlCommand.ExecuteNonQuery();

                //Update Record in WebX_Trans_Docket_Status table for THC No.
                strSQL = "UPDATE WebX_Trans_Docket_Status SET THC = '" + strNewTHCNo + "', Op_Status = 'IN TRANSIT BETWEEN " + strSourceHub + " & " + strToHub + "' where MF ='" + strArrInnerMFDetails[0] + "'";

                sqlCommand = new SqlCommand(strSQL, sqlConn);

                sqlCommand.ExecuteNonQuery();
            }

           

            strSQL = "Insert into webx_thchdr (thcno,thcsf,thcbr,thcdt,sourcehb,tobh_code,actdept_dt,actdept_tm,sealno_out,thc_outrem,rvn_last,rvn_self,upthc_flag,thchdrflag,loader) " +
                     "values (" +
                     "'" + strNewTHCNo + "', '.', '" + Session["brcd"].ToString() + "', '" + getDateInddMMMyyyFormat(txtTHCDate.Value) + "', '" + strSourceHub + "', '" + strToHub + "', '" +
                     getDateInddMMMyyyFormat(txtActualDepDate.Value) + "', '" + txtActualDepTimeHH.Value + ":" + txtActualDepTimeMM.Value + "', '" + txtSealNo.Value + "', '" + txaOutgoingRemarks.Value.Replace(" ", "_").Replace("'", "") + "' " +
                     ", 'N', 'N', 'N', 'N', '" + txtEmpCode.Text + "')";

            sqlCommand = new SqlCommand(strSQL, sqlConn);

            sqlCommand.ExecuteNonQuery();

            strSummaryListField = "thcno,thcsf,VTRACK_NO,thcdt,thcbr,sourcehb,tobh_code,routecd,routename,type_of_vehicle,vehno,mkt_veh,vehtype,sealno_out,rvn_last,rvn_self,thc_outrem,upthc_flag," + 
                                  "thchdrflag,VENDOR_CODE,VENDOR_NAME,OWN_ADDRESS,RCBOOKNO,CHASISNO,ENGINENO,vehregdt,fitness_certdt,OPENKM,CLOSEKM,thc_close,THC_OPERATION,THC_FINANCE,THCNEW_ENTRYBY," + 
                                  "THCNEW_ENTRYDT,actdept_dt,actdept_tm,driver1,DRIVER1LICNO,DRIVER1LICVALDT,DRIVERRTO1,driver2,DRIVER2LICNO,DRIVER2LICVALDT,DRIVERRTO2,airline_name,flightno,airbillno,ManualTHCNo";
            strSummaryListField2 = "thcno,thcsf,'" + strNewVehcileTrackNo + "' As VTRACK_NO,thcdt,thcbr,sourcehb,tobh_code,'" + strRouteCode + "' As routecd,'" + strRouteName + "' As routename,'" + 
                                   HidMarketVeh.Value + "' As type_of_vehicle,'" + 
                                   (ddlVehicleNo.Visible == true ? (ddlVehicleNo.SelectedValue == "-1" ? txtVehicle.Value : ddlVehicleNo.SelectedValue) : txtVehicle.Value) + "' As vehno,'" + HidMarketVeh.Value + 
                                   "' As mkt_veh,'" + (ddlVehicleType.Visible == true ? ddlVehicleType.SelectedValue : HidVehicleType.Value) + "' As vehtype,sealno_out,rvn_last,rvn_self,thc_outrem,upthc_flag,thchdrflag,'" + strVendorCode + "' As VENDOR_CODE,'" + 
                                   strVendorName + "' As VENDOR_NAME,'" + strVendorAddress + "' As OWN_ADDRESS,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtRCBook.Value.Replace(" ", "_").Replace("'", "") : "") + 
                                   "' As RCBOOKNO,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtChasisNo.Value.Replace(" ", "_").Replace("'", "") : "") + "' As CHASISNO,'" + 
                                   (trVehicleInfoForRouteModeS.Visible == true ? txtEngineNo.Value.Replace(" ", "_").Replace("'", "") : "") + "' As ENGINENO,'" + 
                                   (trVehicleInfoForRouteModeS.Visible == true ? getDateInddMMMyyyFormat(txtRegDate.Value) : "") + "' As vehregdt,'" + 
                                   (trVehicleInfoForRouteModeS.Visible == true ? getDateInddMMMyyyFormat(txtFitnessCertValidDate.Value) : "") + "' As fitness_certdt," + txtStartKM.Value + 
                                   " As OPENKM,0 As CLOSEKM,'N' As thc_close,'N' As THC_OPERATION,'N' As THC_FINANCE,'" + Session["empcd"].ToString() + "' As THCNEW_ENTRYBY,getdate() As THCNEW_ENTRYDT,actdept_dt,actdept_tm,'" +
                                   (trVehicleInfoForRouteModeS.Visible == true ? txtDriver1Name.Value : "") + "' As driver1,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtDriver1LicenseNo.Value : "") +
                                   "' As DRIVER1LICNO,'" + (trVehicleInfoForRouteModeS.Visible == true ? getDateInddMMMyyyFormat(txtDriver1LicenseValDate.Value) : "") + "' As DRIVER1LICVALDT,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtDriver1IssuedByRTO.Value : "") + 
                                   "' As DRIVERRTO1,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtDriver2Name.Value : "") + "' As driver2,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtDriver2LicenseNo.Value : "") + 
                                   "' As DRIVER2LICNO,'" + (trVehicleInfoForRouteModeS.Visible == true ? getDateInddMMMyyyFormat(txtDriver2LicenseValDate.Value) : "") + "' As DRIVER2LICVALDT,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtDriver2IssuedByRTO.Value : "") + 
                                   "' As DRIVERRTO2,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtAirLineName.Value : "") + "' As airline_name,'" + (trVehicleInfoForRouteModeS.Visible == true ? txtFlightNo.Value : "") + "' As flightno,'" + 
                                   (trVehicleInfoForRouteModeS.Visible == true ? txtAirwayBillNo.Value : "") + "' As airbillno,'" + (txtManualTHCNo.Text == "" ? "NULL" : txtManualTHCNo.Text) + "' As ManualTHCNo";

            //strSQLFinal = "Insert into webx_thc_summary (" + strSummaryListField + ",ld_tc,ld_actuwt,ld_cftwt,ld_pkgs,fincmplbr,THCNEW_MODE,ul_pkgs,ul_actuwt, ul_tc, dtds, dstat, dclaim, dshort, doth, dtotadv, pcmisc, pcoth, pcamt, inacm, outacm, ext_veh, sehedept_dt, schedept_tm, LateDeptReason) SELECT " +
            //              strSummaryListField2 + "," + strArrMFDetails.Length.ToString() + " As ld_tc," + dblWtTotal.ToString() + " As ld_actuwt," + dblCFTTotal.ToString() + " As ld_cftwt," +
            //              dblPkgTotal.ToString() + " As ld_pkgs,'" + txtFinCompAt.Text + "' As fincmplbr, 'O' as THCNEW_MODE, 0 as ul_pkgs, 0 as ul_actuwt, 0 as ul_tc, 0 as dtds, 0 as dstat, 0 as dclaim, 0 as dshort, 0 as doth, 0 as dtotadv, 0 as pcmisc, 0 as pcoth, 0 as pcamt, 0 as inacm, 0 as outacm, " + (HidMarketVeh.Value.ToUpper() == "Y" ? "'N'" : "'Y'") + " as ext_veh, '" + getDateInddMMMyyyFormat(txtSchedDepDate.Value) + "' AS sehedept_dt, '" + txtSchedDepTimeHH.Value + ":" + txtSchedDepTimeMM.Value + "' AS schedept_tm, '" + ddlLateDepartureReason.SelectedValue + "' AS LateDeptReason From webx_thchdr Where thcno+thcsf='" + strNewTHCNo + ".'";

            //==Fleet Code
            //strSQLFinal = "Insert into webx_thc_summary (" + strSummaryListField + ",ld_tc,ld_actuwt,ld_cftwt,ld_pkgs,fincmplbr,THCNEW_MODE,ul_pkgs,ul_actuwt, ul_tc, dtds, dstat, dclaim, dshort, doth, dtotadv, pcmisc, pcoth, pcamt, inacm, outacm, ext_veh, sehedept_dt, schedept_tm, LateDeptReason,TripSheetNo) SELECT " +
            //              strSummaryListField2 + "," + strArrMFDetails.Length.ToString() + " As ld_tc," + dblWtTotal.ToString() + " As ld_actuwt," + dblCFTTotal.ToString() + " As ld_cftwt," +
            //              dblPkgTotal.ToString() + " As ld_pkgs,'" + txtFinCompAt.Text + "' As fincmplbr, 'O' as THCNEW_MODE, 0 as ul_pkgs, 0 as ul_actuwt, 0 as ul_tc, 0 as dtds, 0 as dstat, 0 as dclaim, 0 as dshort, 0 as doth, 0 as dtotadv, 0 as pcmisc, 0 as pcoth, 0 as pcamt, 0 as inacm, 0 as outacm, " + (HidMarketVeh.Value.ToUpper() == "Y" ? "'N'" : "'Y'") + " as ext_veh, '" + getDateInddMMMyyyFormat(txtSchedDepDate.Value) + "' AS sehedept_dt, '" + txtSchedDepTimeHH.Value + ":" + txtSchedDepTimeMM.Value + "' AS schedept_tm, '" + ddlLateDepartureReason.SelectedValue + "' AS LateDeptReason," + mTripSheetNo + " As TripSheetNo From webx_thchdr Where thcno+thcsf='" + strNewTHCNo + ".'";
            strSQLFinal = "Insert into webx_thc_summary (" + strSummaryListField + ",ld_tc,ld_actuwt,ld_cftwt,ld_pkgs,fincmplbr,THCNEW_MODE,ul_pkgs,ul_actuwt, ul_tc, dtds, dstat, dclaim, dshort, doth, dtotadv, pcmisc, pcoth, pcamt, inacm, outacm, ext_veh, sehedept_dt, schedept_tm, LateDeptReason,TripSheetNo) SELECT " +
                          strSummaryListField2 + "," + strArrMFDetails.Length.ToString() + " As ld_tc," + dblWtTotal.ToString() + " As ld_actuwt," + dblCFTTotal.ToString() + " As ld_cftwt," +
                          dblPkgTotal.ToString() + " As ld_pkgs,'" + Session["brcd"].ToString().Trim() + "' As fincmplbr, 'O' as THCNEW_MODE, 0 as ul_pkgs, 0 as ul_actuwt, 0 as ul_tc, 0 as dtds, 0 as dstat, 0 as dclaim, 0 as dshort, 0 as doth, 0 as dtotadv, 0 as pcmisc, 0 as pcoth, 0 as pcamt, 0 as inacm, 0 as outacm, " + (HidMarketVeh.Value.ToUpper() == "Y" ? "'N'" : "'Y'") + " as ext_veh, '" + getDateInddMMMyyyFormat(txtSchedDepDate.Value) + "' AS sehedept_dt, '" + txtSchedDepTimeHH.Value + ":" + txtSchedDepTimeMM.Value + "' AS schedept_tm, '" + ddlLateDepartureReason.SelectedValue + "' AS LateDeptReason," + mTripSheetNo + " As TripSheetNo From webx_thchdr Where thcno+thcsf='" + strNewTHCNo + ".'";
            //==Fleet Code

            sqlCommand = null;
            sqlCommand = new SqlCommand(strSQLFinal, sqlConn);

            sqlCommand.ExecuteNonQuery();

            //====Fleet Code
            if (mTripSheetNo != "null")
            {
                SqlCommand cmd = new SqlCommand("usp_UpdateForTHCInVehicle_TS", sqlConn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = ddlVehicleNo.SelectedValue.ToString().Trim();
                cmd.Parameters.Add("@THC_MODE", SqlDbType.VarChar).Value = "START";
                cmd.ExecuteNonQuery();
            }
            //====Fleet Code


            //managePostSQL();
        }
        catch (Exception Ex)
        {
            trPrepareTHCErrorMsg.Visible = true;
            lblPrepareTHCErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }

    private void checkManualTHCNo()
    {
        //Check for Manual THC No.
        txtManualTHCNo.Text = txtManualTHCNo.Text.Trim().ToUpper();

        if (txtManualTHCNo.Text == "" || txtManualTHCNo.Text == "NA")
        {
            lblManualTHCNo.Visible = false;
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLManualTHCNo = "select thcno from webx_Thc_Summary where ManualTHCNo='" + txtManualTHCNo.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQLManualTHCNo, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsManualTHCNo = new DataSet();

        sqlDA.Fill(dsManualTHCNo);

        lblManualTHCNo.Visible = (dsManualTHCNo.Tables[0].Rows.Count > 0 ? true : false);

        if (lblManualTHCNo.Visible == true)
        {
            txtManualTHCNo.Focus();
        }
        
        sqlConn.Close();
    }

    //private void managePostSQL()
    //{
    //    tblMain.Visible = false;
    //    trDocketList.Visible = false;
    //    trPrepareTHC.Visible = false;
    //    trViewTHC.Visible = true;

    //    lblTHCNo.InnerHtml = strNewTHCNo;

    //    paintManifestListingForTHC();
    //}

    //private void paintManifestListingForTHC()
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();

    //        dt.Columns.Add("MF", typeof(string));
    //        dt.Columns.Add("MFNo", typeof(string));
    //        dt.Columns.Add("MFNoViewPrint", typeof(string));
            
    //        DataRow dr;

    //        trDocketList.Visible = false;
    //        trTableHeadersForMF.Visible = false;
    //        trPrepareTHCErrorMsg.Visible = false;

    //        string[] strArrMFNo = strMFNoList.Split('~');
    //        for(int intLoopCounter = 0; intLoopCounter < strArrMFNo.Length; intLoopCounter++)
    //        {
    //            dr = dt.NewRow();

    //            dr["MF"] = (intLoopCounter == 0 ? "Maniest No." : "");
    //            dr["MFNo"] = strArrMFNo[intLoopCounter];
    //            dr["MFNoViewPrint"] = "<a href=\"Javascript:OpenInWindow('~/GUI/Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=\"" + strArrMFNo[intLoopCounter] + ",null,'left=700, top=700, height=500, width=600, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar= no')\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('~/GUI/Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=\"" + strArrMFNo[intLoopCounter] + ",null,'left=700, top=700, height=500, width=600, status=no, resizable= yes, scrollbars= yes, toolbar= no,location= no, menubar= no')\"><u>Print</u></a>";
                
    //            dt.Rows.Add(dr);
    //        }

    //        rptViewTHC.DataSource = dt;
    //        rptViewTHC.DataBind();
    //    }
    //    catch (Exception Ex)
    //    {

    //    }
    //}

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private void VehicleNoChanged()
    {
        if (ddlVehicleNo.SelectedValue != "-1")
        {
            manageVehicleInfo(ddlVehicleNo.SelectedValue);
        }
        else
        {
            tdVehicleNotFoundForVehType.Visible = true;
            tdVehicleFoundForVehType.Visible = false;

            tdVehicleNotFoundForEngine.Visible = true;
            tdVehicleFoundForEngine.Visible = false;

            tdVehicleNotFoundForChasis.Visible = true;
            tdVehicleFoundForChasis.Visible = false;

            tdVehicleNotFoundForRCBook.Visible = true;
            tdVehicleFoundForRCBook.Visible = false;

            tdVehicleNotFoundRegDate.Visible = true;
            tdVehicleFoundRegDate.Visible = false;

            tdVehicleNotFoundInsPolicyDate.Visible = true;
            tdVehicleFoundInsPolicyDate.Visible = false;

            tdVehicleNotFoundFitnessCertValidDate.Visible = true;
            tdVehicleFoundFitnessCertValidDate.Visible = false;
        }
    }

    private void getDocumentDetails()
    {
        HidDocket.Value = "";
        HidLS.Value = "";
        HidMF.Value = "";
        HidTHC.Value = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQLForDocument = "select CodeID, CodeDesc from webx_master_general where codetype = 'DOCS'";

        SqlCommand sqlCommand = new SqlCommand(strSQLForDocument, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocument = new DataSet();

        sqlDA.Fill(dsDocument);

        if (dsDocument.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsDocument.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (dsDocument.Tables[0].Rows[intLoopCounter]["CodeID"].ToString())
                {
                    case "DKT":
                        HidDocket.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "LS":
                        HidLS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "MF":
                        HidMF.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "THC":
                        HidTHC.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }

    private void populateLateDepartureReason()
    {
        ddlLateDepartureReason.Items.Clear();

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        //string strSQLForLateDepartureReason = "select CodeID, CodeDesc from webx_master_general where codetype = 'LATE_D'";
        string strSQLForLateDepartureReason = "select CodeID, CodeDesc from webx_master_general where codetype = 'LTDEP' and StatusCode = 'Y'";

        SqlCommand sqlCommand = new SqlCommand(strSQLForLateDepartureReason, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsForLateDepartureReason = new DataSet();

        sqlDA.Fill(dsForLateDepartureReason);

        if (dsForLateDepartureReason.Tables[0].Rows.Count > 0)
        {
            ddlLateDepartureReason.DataTextField = "CodeDesc";
            ddlLateDepartureReason.DataValueField = "CodeID";

            ddlLateDepartureReason.DataSource = dsForLateDepartureReason;
            ddlLateDepartureReason.DataBind();
        }
        
        ddlLateDepartureReason.Items.Insert(0, new ListItem("Select", "-1"));
    }

    private void showScheduledDateTimeForRouteCode(string RouteCode)
    {
        //Fetch Scheduled Departure Date & Time
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.CommandText = "WebX_SP_GetScheduledDateTimeForRouteCode";
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.Parameters.AddWithValue("@RouteCode", RouteCode);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsForLateDepartureReason = new DataSet();

        sqlDA.Fill(dsForLateDepartureReason);

        if (dsForLateDepartureReason.Tables.Count == 1)
        {
            if (dsForLateDepartureReason.Tables[0].Rows.Count > 0)
            {
                txtSchedDepDate.Value = dsForLateDepartureReason.Tables[0].Rows[0][0].ToString();
                string[] strArrTime = dsForLateDepartureReason.Tables[0].Rows[0][1].ToString().Split(':');
                txtSchedDepTimeHH.Value = strArrTime[0];
                txtSchedDepTimeMM.Value = strArrTime[1];
            }
        }
        else
        {
            if (dsForLateDepartureReason.Tables[1].Rows.Count > 0)
            {
                txtSchedDepDate.Value = dsForLateDepartureReason.Tables[1].Rows[0][0].ToString();
                string[] strArrTime = dsForLateDepartureReason.Tables[1].Rows[0][1].ToString().Split(':');
                txtSchedDepTimeHH.Value = strArrTime[0];
                txtSchedDepTimeMM.Value = strArrTime[1];
            }
        }
    }

    //private void showControllingLocationForRouteCode(string RouteCode)
    //{
    //    //Fetch Controlling Location
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    SqlCommand sqlCommand = new SqlCommand();
    //    sqlCommand.CommandText = "WebX_SP_GetControllingLocationForRouteCode";
    //    sqlCommand.Connection = sqlConn;
    //    sqlCommand.CommandType = CommandType.StoredProcedure;

    //    sqlCommand.Parameters.AddWithValue("@RouteCode", RouteCode);

    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsForLateDepartureReason = new DataSet();

    //    sqlDA.Fill(dsForLateDepartureReason);

    //    if (dsForLateDepartureReason.Tables[0].Rows.Count > 0)
    //    {
    //        txtFinCompAt.Text = dsForLateDepartureReason.Tables[0].Rows[0][0].ToString();
    //    }
    //}


    protected void btnpaymentdetail_Click(object sender, EventArgs e)
    {
        //for (int i = 0; i < rptDocketList.Items.Count; i++)
        //{
        //    CheckBox chk = (CheckBox)rptDocketList.Items[i].FindControl("chkSelectMF");
        //    chk.Enabled = false;
        //}
        trpaydetail.Visible = false;
        trPrepareTHC.Visible = true;
        trcharges.Visible = true;

        getstdpcamt();

        tds_chrg.Enabled = false;
        cessamt.Enabled = false;
        hcessamt.Enabled = false;
        svrcamt.Enabled = false;
        if (Session["Client"].ToString() == "RLL")
        {
            tel_chrg.Enabled = false;
            load_chrg.Enabled = false;
            mamul_chrg.Enabled = false;
            svtax_rate.Enabled = false;
        }
    }
}


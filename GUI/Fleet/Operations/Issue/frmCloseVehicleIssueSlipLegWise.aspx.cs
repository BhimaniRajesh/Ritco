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
using ApplicationManager;
public partial class GUI_Fleet_Operations_Issue_frmCloseVehicleIssueSlipLegWise : System.Web.UI.Page
{
    //prasad
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    MyFleetDataSet.HSD_OIL_EXPRow datarow_HSDOIL;
    MyFleetDataSet.SparePartRow datarow_Spare;
    MyFleetDataSet.EnExpenseRow datarow_EnExp;
    MyFleetDataSet.EnExpenseRouteDataTable dtEnExpense = new MyFleetDataSet.EnExpenseRouteDataTable();
     
    MyFleetDataSet.EnExpenseRouteRow datarow_Enroute;

    MyFleetDataSet.EnrouteExpenseLegWiseDataTable dtEnrouteExpense = new MyFleetDataSet.EnrouteExpenseLegWiseDataTable();
    MyFleetDataSet.ExternalCustDetailsRow datarow_ExternalCustDetails;
    MyFleetDataSet.EnrouteExpenseLegWise123Row datarow_EnrouteExpenseLegWise;
    MyFleetDataSet.TripsheetCnoteLegWiseRow datarow_TripsheetCnoteLegWise;

    public string strPolarity = "";

    public double totExAmt = 0, totStandardAmt = 0;
    public double totExAmt2 = 0, totStandardAmt2 = 0;
    public double totExAmt3 = 0, totStandardAmt3 = 0;
    public double totExAmt4 = 0, totStandardAmt4 = 0;
    public double totExAmt5 = 0, totStandardAmt5 = 0;
    public double totExAmt6 = 0, totStandardAmt6 = 0;

    string stVSlipId = "", strVEHNO = "", strStartKM = "";
    SqlConnection conn;
    //prasad
    static string str_Connection_String = "";
    public string modeval = "";
     
    //string stVSlipId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        modeval = Request.QueryString["mode"];
        if (!IsPostBack)
        {
            try
            {
               
               

                if (Session["SqlProvider"] != null)
                {
                    str_Connection_String = Session["SqlProvider"].ToString();
                    conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    conn.Open();
                }
                else
                {
                    Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
                }
            }
            catch (Exception Ex)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
            }


            //TextBox txt_Date = (TextBox)txtDateFrom.FindControl("txt_Date");
            txtDateFrom.Attributes.Add("OnBlur", "javascript:ValidCloseDateFinance(" + lblIssueNo.ClientID.Trim() + "," + txtDateFrom.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");
            txtDateOpClose.Attributes.Add("OnBlur", "javascript:ValidCloseDateOperational(" + txtDateOpClose.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");


            txtCloseKM.Attributes.Add("OnBlur", "javascript:CheckClosingKMLegWise();");
            stVSlipId = Request.QueryString["id"];
            //modeval = Request.QueryString["mode"];
            if (modeval == "FE")
            {
                lblPageHead.Text = "Vehicle Issue Slip - Financial Edit";
                lblHeader.Text = "Financial Edit - Vehicle Issue Slip";

            }
            Session["Tripsheet"] = null;
            Session["Tripsheet"] = stVSlipId;
            System.DateTime righnow = System.DateTime.Today;



            //DateTime StartDate = DateTime.ParseExact(txtStartDate.Text + " " + ddlFromHours.SelectedValue + ":" + ddlFromMinutes.SelectedValue, "MM/dd/yyyy HH:mm",
            //System.Globalization.CultureInfo.InvariantCulture);

            //DateTime EndDate = DateTime.ParseExact(txtStartDate.Text + " " + ddlToHours.SelectedValue + ":" + ddlToMinutes.SelectedValue, "MM/dd/yyyy HH:mm",
            //System.Globalization.CultureInfo.InvariantCulture);
            try
            {
                TripSheet objTripSheet = new TripSheet(str_Connection_String);

                DataTable dtKM = new DataTable();
                dtKM = objTripSheet.ExecuteSql("  select top 1 End_KM_Read from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where Tripsheetno='" + Request.QueryString["ID"] + "' order by End_KM_Read desc ");

                if (dtKM.Rows.Count > 0)
                {
                    hdnLastKM.Value = dtKM.Rows[0]["End_KM_Read"].ToString();
                }


                objTripSheet.CheckTripRule();
                if (objTripSheet.Diff_Bet_CloseKM_StartKM == "Y")
                {
                    hf_CloseKMGreater10K.Value = "Y";
                }
                else
                {
                    hf_CloseKMGreater10K.Value = "";
                }
                if (objTripSheet.CloseKM_Greater_Than_StartKM == "Y")
                {
                    hf_CloseKMGreater10K.Value = "N";
                }
                else
                {
                    hf_CloseKMGreater10K.Value = "";
                }
                if (objTripSheet.Diesel_CF == "Y")
                {
                    hdnDiesel_CF.Value = "Y";
                }
                else
                {
                    hdnDiesel_CF.Value = "N";
                }

                ////Trip closure should not be submitted if total expense (en-route + diesel) should (I) equal to zero or (II) not equal to zero
                hf_Check_Amt_Rule.Value = "";
                if (objTripSheet.Trip_Closure_Not_Zero == "Y")
                {
                    hf_Check_Amt_Rule.Value = "N";
                }
                else if (objTripSheet.Trip_Closure_Zero == "Y")
                {
                    hf_Check_Amt_Rule.Value = "Y";
                }



                //lblDocketsLable.Text = objTripSheet.DOCKET_NO_LABEL + " Numbers ";

                DataTable dtVI = new DataTable();
                dtVI = objTripSheet.ExecuteSql("SELECT *from vw_TripSheetClose where VSlipNo= '" + stVSlipId + "'");

                //string strrightnow = righnow.ToString("dd/MM/yyyy");
                //txtDateFrom.Text = strrightnow;

                if (dtVI.Rows.Count > 0)
                {
                    lblIssueNo.Text = dtVI.Rows[0]["VSlipNo"].ToString();
                    lblIssueDt.Text = dtVI.Rows[0]["VSlipDt"].ToString();
                    lblVehno.Text = dtVI.Rows[0]["Vehno"].ToString();
                    hdnVehno.Value = dtVI.Rows[0]["Vehno"].ToString();
                    lblDriverName.Text = dtVI.Rows[0]["driver_name"].ToString();
                    Session["strDriverCode"] = dtVI.Rows[0]["driver1"].ToString();
                    //prasad
                    hfRouteCode.Value = dtVI.Rows[0]["rut_code"].ToString();
                    hfRouteDesc.Value = dtVI.Rows[0]["rutdesc"].ToString();
                    lblLicno.Text = dtVI.Rows[0]["License_no"].ToString();
                    lblValidDt.Text = dtVI.Rows[0]["valdity_dt"].ToString();
                    lblStartKm.Text = dtVI.Rows[0]["Start_km"].ToString();
                    //txtFuelFilled.Text = dtVI.Rows[0]["f_issue_fill"].ToString();
                    lblManualNo.Text = dtVI.Rows[0]["Manual_Tripsheetno"].ToString();
                    lblStartLoc.Text = dtVI.Rows[0]["Tripsheet_StartLoc"].ToString();
                    lblEndLoc.Text = dtVI.Rows[0]["Tripsheet_EndLoc"].ToString();
                    //lblCategory.Text = dtVI.Rows[0]["Category"].ToString();
                    txtApprovedBy.Text = dtVI.Rows[0]["ApprovedBy"].ToString();
                    txtPreparedBy.Text = dtVI.Rows[0]["PreparedBy"].ToString();
                    txtCheckedBy.Text = dtVI.Rows[0]["CheckedBy"].ToString();
                    txtAuditedBy.Text = dtVI.Rows[0]["AuditedBy"].ToString();
                    txtCloseKM.Text = dtVI.Rows[0]["f_closure_closekm"].ToString();

                    txtDateOpClose.Text = dtVI.Rows[0]["Oper_Close_Dt"].ToString();
                    txtDateFrom.Text = dtVI.Rows[0]["TS_Close_Dt"].ToString();

                    hfFinancialCloseDate.Value = dtVI.Rows[0]["TS_Close_Dt"].ToString();
                    hfOperationalyCloseDate.Value = dtVI.Rows[0]["Oper_Close_Dt"].ToString();

                    if (dtVI.Rows[0]["Oper_Close_Dt"].ToString() != "")
                    {
                        txtDateOpClose.Enabled = false;
                        txtCloseKM.Enabled = false;
                    }
                    else
                    {
                        txtDateOpClose.Enabled = true;
                        txtCloseKM.Enabled = true;
                    }

                    lblFTLType.Text = dtVI.Rows[0]["VehicleType"].ToString();
                    hfKMPL.Value = dtVI.Rows[0]["KMPL"].ToString();
                    lblAverageDieselRate.Text = dtVI.Rows[0]["AvgDieselRate"].ToString();
                    if (dtVI.Rows[0]["rut_code"].ToString() != "0")
                    {
                        //row_Route.Visible = true;
                        //row_FTCity.Visible = false;
                        lblRoute.Text = dtVI.Rows[0]["rut_code"].ToString() + " : " + dtVI.Rows[0]["rutdesc"].ToString();
                    }
                    else
                    {
                        //row_Route.Visible = false;
                        //row_FTCity.Visible = true;
                        lblRoute.Text = dtVI.Rows[0]["From_City"].ToString() + "~" + dtVI.Rows[0]["To_City"].ToString() + "~" + dtVI.Rows[0]["From_City"].ToString();
                    }
                    if (txtCloseKM.Text != "")
                    {
                        string StartKm = lblStartKm.Text.ToString();
                        string CloseKM = txtCloseKM.Text.ToString();
                        double TotalKms = 0;
                        TotalKms = Convert.ToDouble(CloseKM) - Convert.ToDouble(StartKm);
                        txtTotalKms.Text = TotalKms.ToString();
                    }

                    //txtFuelFilledEnroute.Text = dtVI.Rows[0]["f_closure_fill"].ToString();
                    //lblKMPL.Text = dataReadVI["Actual_KMPL"].ToString();
                    txtKMPL.Text = dtVI.Rows[0]["Actual_KMPL"].ToString();
                    txtApprKMPL.Text = dtVI.Rows[0]["KMPL"].ToString();

                    //prasadcomment5
                    //InetializEnrouteExpense();
                    //BindGridEnExpense();
                    //Fuel
                    TripSheet objTs = new TripSheet(str_Connection_String);

                    DataTable dtKMF = new DataTable();
                    dtKMF = objTs.ExecuteSql("  select top 1 End_KM_Read from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where Tripsheetno='" + Request.QueryString["ID"] + "' order by End_KM_Read desc ");

                    if (dtKMF.Rows.Count > 0)
                    {
                        hdnLastKM.Value = dtKMF.Rows[0]["End_KM_Read"].ToString();
                    }


                    //BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor1);
                    //BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor2);
                    //BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor3);
                    //BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor4);

                    //objTs.BindDropDown(ddlVendor1, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");
                    //objTs.BindDropDown(ddlVendor2, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");
                    //objTs.BindDropDown(ddlVendor3, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");
                    //objTs.BindDropDown(ddlVendor4, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");

                    //txtLastKM1.Text = stStartKM;
                    //txtLastKM1.Text = lblStartKm.Text;

                    //txtCurrentKM1.Attributes.Add("OnBlur", "return CheckCurrentKM1(" + txtCurrentKM1.ClientID.ToString().Trim() + "," + txtLastKM1.ClientID.ToString().Trim() + ")");
                    //txtCurrentKM2.Attributes.Add("OnBlur", "return CheckCurrentKM2(" + txtCurrentKM2.ClientID.ToString().Trim() + "," + txtLastKM2.ClientID.ToString().Trim() + ")");
                    //txtCurrentKM3.Attributes.Add("OnBlur", "return CheckCurrentKM3(" + txtCurrentKM3.ClientID.ToString().Trim() + "," + txtLastKM3.ClientID.ToString().Trim() + ")");
                    //txtCurrentKM4.Attributes.Add("OnBlur", "return CheckCurrentKM4(" + txtCurrentKM4.ClientID.ToString().Trim() + "," + txtLastKM4.ClientID.ToString().Trim() + ")");

                    //txtDieselQty1.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
                    //txtDieselQty2.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
                    //txtDieselQty3.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
                    //txtDieselQty4.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");

                    //txtDieselRate1.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
                    //txtDieselRate2.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
                    //txtDieselRate3.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
                    //txtDieselRate4.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");

                    //txtDate1.Attributes.Add("OnBlur", "javascript:CheckDate()");
                    //txtDate2.Attributes.Add("OnBlur", "javascript:CheckDate()");
                    //txtDate3.Attributes.Add("OnBlur", "javascript:CheckDate()");
                    //txtDate4.Attributes.Add("OnBlur", "javascript:CheckDate()");

                    //  Previous_FuelExpense();
                    InetializEnrouteExpense();
                    Previous_HSD_OIL_EXP();

                }

                conn.Close();
            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }
        }
        else 
        {
             
            ReverseBind();
        }

    }


    


     

    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

     

 


    public void BindDropDownF(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    //end
    protected void cmdOpClose_Click(object sender, EventArgs e)
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
             double mTotAdvExp = 0, mTotOilExp = 0, mTotRepairExp = 0, mTotIncDedExp = 0, mTotEnrouteExp = 0, mTotClaimsExp = 0, mTotSpareExp = 0;
        string mTripSheetNo = "";
        string sql = "";
        string sqlDEL = "";
        SqlCommand cmdDEL = new SqlCommand();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime mServerDt = DateTime.Now;
        //sResponse.Write("###mServerDt : " + mServerDt);
        DateTime mIssueDt = new DateTime();
        mIssueDt = Convert.ToDateTime(lblIssueDt.Text.ToString(), dtfi);
        DateTime mCloseDt = new DateTime();
        //mCloseDt = Convert.ToDateTime(txtDateFrom.CalendarDate.ToString(), dtf

         mTripSheetNo = lblIssueNo.Text.ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        bool success = false;
        SqlTransaction trans;
        conn.Open();
        trans = conn.BeginTransaction();
        try
        {

            //string strCloseDateTime = txtDateFrom.Text + " " + tsFinancialCloseDate.Hour + ":" + tsFinancialCloseDate.Minute + " " + tsFinancialCloseDate.AmPm;
            string strOpCloseDateTime = txtDateOpClose.Text + " " + tsDateOpClose.Hour + ":" + tsDateOpClose.Minute + " " + tsDateOpClose.AmPm;
            if (txtApprKMPL.Text == "") { txtApprKMPL.Text = "0.00"; }

            SqlCommand cmd = new SqlCommand("USP_NEW_CloseVehicleIssue_Operationally", conn, trans);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
            cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = Session["strDriverCode"].ToString();
            cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.Text.ToString();
            cmd.Parameters.Add("@APPKMPL", SqlDbType.VarChar).Value = txtApprKMPL.Text.ToString();
            if (txtCloseKM.Text.ToString() != "")
            {
                cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = txtCloseKM.Text.ToString();
            }
            else
            {
                cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = "0";
            }
            //cmd.Parameters.Add("@Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(strCloseDateTime.Trim(), dtfi);// lblExpTot.Text.ToString();
            cmd.Parameters.Add("@Oper_Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(strOpCloseDateTime.Trim(), dtfi);// lblExpTot.Text.ToString();
            cmd.Parameters.Add("@Diesel_CF", SqlDbType.VarChar).Value = hdnDiesel_CF.Value;
            cmd.ExecuteNonQuery();

            cmd.ExecuteNonQuery();


            if (hdnDiesel_CF.Value != "Y")
			{
				if (txtCloseKM.Text == "")
					txtCloseKM.Text="0.00";
				
                sql = " Update webx_vehicle_hdr set Vehicle_Status='Available',current_KM_Read='" + txtCloseKM.Text.ToString().Trim() + "'   where vehno='" + lblVehno.Text + "'";
                SqlCommand VH = new SqlCommand(sql, conn, trans);
                VH.CommandType = CommandType.Text;
                VH.ExecuteNonQuery();

                SqlCommand cdCurLoc = new SqlCommand(" Update WEBX_VEHICLE_HDR set CURLOC='" + lblEndLoc.Text.ToString().Trim() + "' where VEHNO='" + lblVehno.Text.ToString().Trim() + "'", conn, trans);
                cdCurLoc.CommandType = CommandType.Text;
                cdCurLoc.ExecuteNonQuery();

                sql = " Update WEBX_FLEET_DRIVERMST set Driver_Status='Available' where Driver_id in (select driver1  from WEBX_FLEET_VEHICLE_ISSUE  where VSlipNo='" + mTripSheetNo + "')";
                SqlCommand VD = new SqlCommand(sql, conn, trans);
                VD.CommandType = CommandType.Text;
                VD.ExecuteNonQuery();

                sql = " Update WEBX_FLEET_DRIVERMST set Driver_Status='Available' where Driver_id in (select  (CASE  WHEN ISNUMERIC(driver2)=0  THEN 0  ELSE  DRIVER2 END)  from WEBX_FLEET_VEHICLE_ISSUE  where VSlipNo='" + mTripSheetNo + "')";
                SqlCommand VD1 = new SqlCommand(sql, conn, trans);
                VD1.CommandType = CommandType.Text;
                VD1.ExecuteNonQuery();

                sql = "USP_Tyre_KM_Run_Update";
                SqlCommand cmdTyreUpdate = new SqlCommand(sql, conn, trans);
                cmdTyreUpdate.CommandType = CommandType.StoredProcedure;
                cmdTyreUpdate.Parameters.Add("@VSlipNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                cmdTyreUpdate.Parameters.Add("@f_closure_closekm", SqlDbType.Decimal).Value = Convert.ToDecimal(txtCloseKM.Text);
                cmdTyreUpdate.Parameters.Add("@VehicleNo", SqlDbType.VarChar, 50).Value = lblVehno.Text;
                cmdTyreUpdate.ExecuteNonQuery();
            }
            #region gvEnroute
           
            #region newly added
            #region gvEnroute
            sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();
            foreach (GridViewRow gridrow in gvEnroute.Rows)
                    {
                        DropDownList ddlNExpense = (DropDownList)gvEnroute.Rows[gridrow.RowIndex].Cells[1].FindControl("ddlNExpense");
                        TextBox txtAmount = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[2].FindControl("txtAmount");
                        TextBox txtBillNo = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[3].FindControl("txtBillNo");
                        TextBox txtDate = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[4].FindControl("txtDate");
                        TextBox txtEAmt = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("txtEAmt");
                        TextBox txtRemark = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[6].FindControl("txtRemark");
                        HiddenField hfEAmt = (HiddenField)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("hfEAmt");
                        HiddenField hfPolarity = (HiddenField)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("hfPolarity");
                        TextBox txtEnAmtTotal = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtEnAmtTotal");
                
                        if (ddlNExpense.SelectedValue != "0")
                        {
                            string sqlEnroute = "USP_INSERT_ENROUTE_EXP";

                            SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                            sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                            sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
                            sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = ddlNExpense.SelectedValue;
                            if (txtAmount.Text.ToString() != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                            }
                            else
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                            }
                            sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                            if (hfEAmt.Value != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt.Value.ToString());
                            }
                            else
                            {
                                if (txtEAmt.Text != "")
                                {
                                    sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt.Text.ToString());
                                }
                                else
                                {
                                    sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble("0");
                                }
                            }

                            sqlcmdEnRoute.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemark.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@Polarity", SqlDbType.VarChar).Value = hfPolarity.Value.ToString();
                            //datarow_EnExp = _dataSet.EnExpense[gridrow.RowIndex];
                            //_dataSet.EnExpense[gridrow.RowIndex].ItemArray = datarow_EnExp.ItemArray;
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }


                    mTotEnrouteExp = hfETotalAmt.Value != "" ? Convert.ToDouble(hfETotalAmt.Value) : 0;

                    #endregion
                    #region dgHSD_OIL_EXP

                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        Double LKmRead = 0, currKm = 0;
                        if (((TextBox)gridrow.FindControl("txtLKmRead")).Text != "")
                        {
                            LKmRead = Convert.ToDouble(((TextBox)gridrow.FindControl("txtLKmRead")).Text);
                        }
                        if (((TextBox)gridrow.FindControl("txtKM_Reading")).Text != "")
                        {
                            currKm = Convert.ToDouble(((TextBox)gridrow.FindControl("txtKM_Reading")).Text);
                        }
                        if (lblError.Text.Trim() == "")
                        {
                            if (LKmRead > currKm)
                            {
                                lblError.Visible = true;
                                lblError.Text = "Current Km Reading should always be greater than last Km Reading";
                            }
                        }
                    }
                    #endregion
                    #region dgHSD_OIL_EXP
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        DateTime mBilldt = new DateTime();
                        mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);
                        if (lblError.Text.Trim() == "")
                        {
                            if (mBilldt > mServerDt)
                            {
                                lblError.Visible = true;
                                lblError.Text = "Bill Date should not be greater than today's date for HSD/OIL Expenses!";
                            }
                            if (mBilldt < mIssueDt)
                            {
                                lblError.Visible = true;
                                lblError.Text = "Bill Date should not be less than Issue Slip Date for HSD/OIL Expenses!";
                            }
                        }
                    }
                    #endregion

                    #region dgHSD_OIL_EXP
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        if (gridrow.ItemIndex != -1)
                        {
                            Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                            DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                            string FCCardNo = "";
                            //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                            //conn.Open();
                            DataTable dtFuelCard = new DataTable();
                            string msql = "select Manual_Fuel_Card_No from WEBX_FLEET_FUELCARD where Vehicle_No='" + lblVehno.Text + "'";
                            //SqlCommand cdR = new SqlCommand(msql, conn);
                            //SqlDataReader cdDR = cdR.ExecuteReader();
                            dtFuelCard = objTripSheet.ExecuteSql(msql);
                            if (dtFuelCard.Rows.Count > 0)
                            {
                                //while (cdDR.Read())
                                {
                                    FCCardNo = Convert.ToString(dtFuelCard.Rows[0]["Manual_Fuel_Card_No"]);
                                }
                            }
                            //cdDR.Close();
                            //conn.Close();
                            if (tbddlPayment.SelectedValue == "Diesel Card")
                            {
                                tbFCCard.Text = FCCardNo.ToString();
                                if (lblError.Text == "")
                                {
                                    if (tbFCCard.Text == "")
                                    {
                                        lblError.Visible = true;
                                        lblError.Text = "*FO ledger is not activated for this vehicle FC card !!! Please check";
                                    }
                                }
                            }
                            else
                            {
                                tbFCCard.Text = "";
                            }
                        }
                    }
                    #endregion

                    #region dgHSD_OIL_EXP
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;

                        ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                        ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                        ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                        //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

                        ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                        //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;

                        ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                        ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;

                        ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                        //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = true;
                    }
                    #endregion

                    #region dgHSD_OIL_EXP

                    string strFuelPayType = " and Card_Cash not in ('Credit Card','Credit')";
                    sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'" + strFuelPayType;
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                        string mPPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Text;
                        string mBrand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Text;
                        string mFuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Text;
                        string mLastKm = ((TextBox)gridrow.FindControl("txtLKmRead")).Text;
                        string mCard_Cash = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedValue.Trim();
                        string mRemark = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
                        string mKM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
                        string mBillno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
                        DateTime mBilldt = new DateTime();
                        mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);
                        string mDiesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
                        //string mOil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
                        string mOil_Ltr = "0.0";
                        string mDiesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
                        //string mOil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
                        string mOil_Rate = "0.0";
                        string mAmt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                        string mExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                        mTotOilExp = mTotOilExp + Convert.ToDouble(mExeAmt);
                        if (mCard_Cash != "Credit" && mCard_Cash != "Credit Card")
                        {
                            sql = " Insert into WEBX_TRIPSHEET_OILEXPDET (TripSheetNo,Place,KM_Reading,BillNo,BillDt,Diesel_Ltr,Oil_Ltr,Amount,Diesel_Rate,Oil_Rate,PetrolPName,Brand,FuelType,Last_Km_Read,Card_Cash,Remark,Exe_Amt) values ( "
                                 + "'" + mTripSheetNo + "', '" + mOilPlace + "','" + mKM_Reading + "','" + mBillno + "','" + mBilldt + "','" + mDiesel_Ltr + "','" + mOil_Ltr + "','" + mAmt + "'," + mDiesel_Rate + "," + mOil_Rate + ",'" + mPPName + "','" + mBrand + "','" + mFuelType + "','" + mLastKm + "','" + mCard_Cash + "','" + mRemark + "','" + mExeAmt + "') ";
                            SqlCommand HSDOilDetail = new SqlCommand(sql, conn, trans);
                            HSDOilDetail.CommandType = CommandType.Text;

                            //datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
                            //_dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;
                            HSDOilDetail.ExecuteNonQuery();
                        }
                        //datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
                        //_dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;
                    }
                    #endregion
            #endregion
            #endregion
             

            trans.Commit();
            //trans.Rollback();
            success = true;
            Session["strDriverCode"] = null;

        }
        catch (Exception e1)
        {
            trans.Rollback();
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
          
            Response.End();
        }
        if (success)
        {
            Response.Redirect("frmVehicleIssueSlipCloseLegWise_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
            //Server.Transfer("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
        }
    }

    protected void SubmitData(object sender, EventArgs e)
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        double mTotAdvExp = 0, mTotOilExp = 0, mTotRepairExp = 0, mTotIncDedExp = 0, mTotEnrouteExp = 0, mTotClaimsExp = 0, mTotSpareExp = 0;
        string mTripSheetNo = "";
        string sql = "";
        string sqlDEL = "";
        SqlCommand cmdDEL = new SqlCommand();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime mServerDt = DateTime.Now;
        //sResponse.Write("###mServerDt : " + mServerDt);
        DateTime mIssueDt = new DateTime();
        mIssueDt = Convert.ToDateTime(lblIssueDt.Text.ToString(), dtfi);
        DateTime mCloseDt = new DateTime();
        //mCloseDt = Convert.ToDateTime(txtDateFrom.CalendarDate.ToString(), dtf

        mTripSheetNo = lblIssueNo.Text.ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        bool success = false;
        SqlTransaction trans;
        conn.Open();
        trans = conn.BeginTransaction();
        try
        {

            string strCloseDateTime = txtDateFrom.Text + " " + tsFinancialCloseDate.Hour + ":" + tsFinancialCloseDate.Minute + " " + tsFinancialCloseDate.AmPm;
            string strOpCloseDateTime = txtDateOpClose.Text + " " + tsDateOpClose.Hour + ":" + tsDateOpClose.Minute + " " + tsDateOpClose.AmPm;
            if (txtApprKMPL.Text == "") { txtApprKMPL.Text = "0.00"; }

            string mFinYear = "";
            string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
            SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, conn, trans);
            sqlcmdFinYear.CommandType = CommandType.Text;
            SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
            if (drFinYear.Read())
            {
                mFinYear = drFinYear["YearVal"].ToString().Trim();
            }
            drFinYear.Close();

            string mYearVal = "";

            GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
            mYearVal = objFinYear.FinancialYear();


            SqlCommand cmd = new SqlCommand("USP_NEW_CloseVehicleIssue", conn, trans);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
            cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = Session["strDriverCode"].ToString();
            cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.Text.ToString();
            cmd.Parameters.Add("@APPKMPL", SqlDbType.VarChar).Value = txtApprKMPL.Text.ToString();
            if (txtCloseKM.Text.ToString() != "")
            {
                cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = txtCloseKM.Text.ToString();
            }
            else
            {
                cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = "0";
            }
            cmd.Parameters.Add("@Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(strCloseDateTime.Trim(), dtfi);// lblExpTot.Text.ToString();
            cmd.Parameters.Add("@Oper_Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(strOpCloseDateTime.Trim(), dtfi);// lblExpTot.Text.ToString();
            cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString();
            cmd.Parameters.Add("@Company_Code", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString();
            cmd.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
            cmd.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
            cmd.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString();
           
            cmd.ExecuteNonQuery();

            if (txtDateOpClose.Enabled != false && txtCloseKM.Enabled != false)
            {
                sql = " Update webx_vehicle_hdr set Vehicle_Status='Available',current_KM_Read='" + txtCloseKM.Text.ToString().Trim() + "'   where vehno='" + lblVehno.Text + "'";
                SqlCommand VH = new SqlCommand(sql, conn, trans);
                VH.CommandType = CommandType.Text;
                VH.ExecuteNonQuery();

                SqlCommand cdCurLoc = new SqlCommand(" Update WEBX_VEHICLE_HDR set CURLOC='" + lblEndLoc.Text.ToString().Trim() + "' where VEHNO='" + lblVehno.Text.ToString().Trim() + "'", conn, trans);
                cdCurLoc.CommandType = CommandType.Text;
                cdCurLoc.ExecuteNonQuery();

                sql = " Update WEBX_FLEET_DRIVERMST set Driver_Status='Available' where Driver_id in (select driver1  from WEBX_FLEET_VEHICLE_ISSUE  where VSlipNo='" + mTripSheetNo + "')";
                SqlCommand VD = new SqlCommand(sql, conn, trans);
                VD.CommandType = CommandType.Text;
                VD.ExecuteNonQuery();

                sql = " Update WEBX_FLEET_DRIVERMST set Driver_Status='Available' where Driver_id in (select  (CASE  WHEN ISNUMERIC(driver2)=0  THEN 0  ELSE  DRIVER2 END)  from WEBX_FLEET_VEHICLE_ISSUE  where VSlipNo='" + mTripSheetNo + "')";
                SqlCommand VD1 = new SqlCommand(sql, conn, trans);
                VD1.CommandType = CommandType.Text;
                VD1.ExecuteNonQuery();

                sql = "USP_Tyre_KM_Run_Update";
                SqlCommand cmdTyreUpdate = new SqlCommand(sql, conn, trans);
                cmdTyreUpdate.CommandType = CommandType.StoredProcedure;
                cmdTyreUpdate.Parameters.Add("@VSlipNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                cmdTyreUpdate.Parameters.Add("@f_closure_closekm", SqlDbType.Decimal).Value = Convert.ToDecimal(txtCloseKM.Text);
                cmdTyreUpdate.Parameters.Add("@VehicleNo", SqlDbType.VarChar, 50).Value = lblVehno.Text;
                cmdTyreUpdate.ExecuteNonQuery();
            }


            



            #region newly added

                    #region gvEnroute
            sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();
                    foreach (GridViewRow gridrow in gvEnroute.Rows)
                    {
                        DropDownList ddlNExpense = (DropDownList)gvEnroute.Rows[gridrow.RowIndex].Cells[1].FindControl("ddlNExpense");
                        TextBox txtAmount = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[2].FindControl("txtAmount");
                        TextBox txtBillNo = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[3].FindControl("txtBillNo");
                        TextBox txtDate = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[4].FindControl("txtDate");
                        TextBox txtEAmt = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("txtEAmt");
                        TextBox txtRemark = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[6].FindControl("txtRemark");
                        HiddenField hfEAmt = (HiddenField)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("hfEAmt");
                        HiddenField hfPolarity = (HiddenField)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("hfPolarity");
                        TextBox txtEnAmtTotal = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtEnAmtTotal");

                        if (ddlNExpense.SelectedValue != "0")
                        {
                            string sqlEnroute = "USP_INSERT_ENROUTE_EXP";

                            SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                            sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                            sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
                            sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = ddlNExpense.SelectedValue;
                            if (txtAmount.Text.ToString() != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                            }
                            else
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                            }
                            sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                            if (hfEAmt.Value != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt.Value.ToString());
                            }
                            else
                            {
                                if (txtEAmt.Text != "")
                                {
                                    sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt.Text.ToString());
                                }
                                else
                                {
                                    sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble("0");
                                }
                            }

                            sqlcmdEnRoute.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemark.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@Polarity", SqlDbType.VarChar).Value = hfPolarity.Value.ToString();
                            //datarow_EnExp = _dataSet.EnExpense[gridrow.RowIndex];
                            //_dataSet.EnExpense[gridrow.RowIndex].ItemArray = datarow_EnExp.ItemArray;
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }


                    mTotEnrouteExp = hfETotalAmt.Value != "" ? Convert.ToDouble(hfETotalAmt.Value) : 0;

                    #endregion

            #region dgHSD_OIL_EXP

            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                Double LKmRead = 0, currKm = 0;
                if (((TextBox)gridrow.FindControl("txtLKmRead")).Text != "")
                {
                    LKmRead = Convert.ToDouble(((TextBox)gridrow.FindControl("txtLKmRead")).Text);
                }
                if (((TextBox)gridrow.FindControl("txtKM_Reading")).Text != "")
                {
                    currKm = Convert.ToDouble(((TextBox)gridrow.FindControl("txtKM_Reading")).Text);
                }
                if (lblError.Text.Trim() == "")
                {
                    if (LKmRead > currKm)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Current Km Reading should always be greater than last Km Reading";
                    }
                }
            }
            #endregion
            #region dgHSD_OIL_EXP
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                DateTime mBilldt = new DateTime();
                mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);
                if (lblError.Text.Trim() == "")
                {
                    if (mBilldt > mServerDt)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Bill Date should not be greater than today's date for HSD/OIL Expenses!";
                    }
                    if (mBilldt < mIssueDt)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Bill Date should not be less than Issue Slip Date for HSD/OIL Expenses!";
                    }
                }
            }
            #endregion

            #region dgHSD_OIL_EXP
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                if (gridrow.ItemIndex != -1)
                {
                    Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                    DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                    string FCCardNo = "";
                    //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    //conn.Open();
                    DataTable dtFuelCard = new DataTable();
                    string msql = "select Manual_Fuel_Card_No from WEBX_FLEET_FUELCARD where Vehicle_No='" + lblVehno.Text + "'";
                    //SqlCommand cdR = new SqlCommand(msql, conn);
                    //SqlDataReader cdDR = cdR.ExecuteReader();
                    dtFuelCard = objTripSheet.ExecuteSql(msql);
                    if (dtFuelCard.Rows.Count > 0)
                    {
                        //while (cdDR.Read())
                        {
                            FCCardNo = Convert.ToString(dtFuelCard.Rows[0]["Manual_Fuel_Card_No"]);
                        }
                    }
                    //cdDR.Close();
                    //conn.Close();
                    if (tbddlPayment.SelectedValue == "Diesel Card")
                    {
                        tbFCCard.Text = FCCardNo.ToString();
                        if (lblError.Text == "")
                        {
                            if (tbFCCard.Text == "")
                            {
                                lblError.Visible = true;
                                lblError.Text = "*FO ledger is not activated for this vehicle FC card !!! Please check";
                            }
                        }
                    }
                    else
                    {
                        tbFCCard.Text = "";
                    }
                }
            }
            #endregion

            #region dgHSD_OIL_EXP
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;

                ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

                ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;

                ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;

                ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = true;
            }
            #endregion
             
            #region dgHSD_OIL_EXP

            string strFuelPayType = " and Card_Cash not in ('Credit Card','Credit')";
            sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'" + strFuelPayType;
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();

            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                string mPPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Text;
                string mBrand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Text;
                string mFuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Text;
                string mLastKm = ((TextBox)gridrow.FindControl("txtLKmRead")).Text;
                string mCard_Cash = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedValue.Trim();
                string mRemark = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
                string mKM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
                string mBillno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
                DateTime mBilldt = new DateTime();
                mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);
                string mDiesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
                //string mOil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
                string mOil_Ltr = "0.0";
                string mDiesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
                //string mOil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
                string mOil_Rate = "0.0";
                string mAmt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                string mExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                mTotOilExp = mTotOilExp + Convert.ToDouble(mExeAmt);
                if (mCard_Cash != "Credit" && mCard_Cash != "Credit Card")
                {
                    sql = " Insert into WEBX_TRIPSHEET_OILEXPDET (TripSheetNo,Place,KM_Reading,BillNo,BillDt,Diesel_Ltr,Oil_Ltr,Amount,Diesel_Rate,Oil_Rate,PetrolPName,Brand,FuelType,Last_Km_Read,Card_Cash,Remark,Exe_Amt) values ( "
                         + "'" + mTripSheetNo + "', '" + mOilPlace + "','" + mKM_Reading + "','" + mBillno + "','" + mBilldt + "','" + mDiesel_Ltr + "','" + mOil_Ltr + "','" + mAmt + "'," + mDiesel_Rate + "," + mOil_Rate + ",'" + mPPName + "','" + mBrand + "','" + mFuelType + "','" + mLastKm + "','" + mCard_Cash + "','" + mRemark + "','" + mExeAmt + "') ";
                    SqlCommand HSDOilDetail = new SqlCommand(sql, conn, trans);
                    HSDOilDetail.CommandType = CommandType.Text;

                    //datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
                    //_dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;
                    HSDOilDetail.ExecuteNonQuery();
                }
                //datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
                //_dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;
            }
            #endregion

            string mActual_KMPL = "0";
            string mActual_Approved = "0";
            string mApproved_Ltr = "0";
            string mApproved_Rate = "0";
            string mApproved_Amt = "0";
            string mAmount = mTotOilExp.ToString();

            sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPHDR where TripSheetNo='" + mTripSheetNo + "'";
            cmdDEL = new SqlCommand(sqlDEL, conn, trans);
            cmdDEL.ExecuteNonQuery();
            cmdDEL.Dispose();


            sql = " Insert into WEBX_TRIPSHEET_OILEXPHDR (TripSheetNo,Actual_KMPL,Actual_Approved,Approved_Ltr,Approved_Rate,Approved_Amt,Amount) values ( "
                    + "'" + mTripSheetNo + "','" + mActual_KMPL + "','" + mActual_Approved + "','" + mApproved_Ltr + "','" + mApproved_Rate + "','" + mApproved_Amt + "','" + mAmount + "') ";
            SqlCommand HSDOilHeader = new SqlCommand(sql, conn, trans);
            HSDOilHeader.CommandType = CommandType.Text;
            HSDOilHeader.ExecuteNonQuery();
            #endregion



            trans.Commit();
            //trans.Rollback();
            success = true;
            Session["strDriverCode"] = null;

        }
        catch (Exception e1)
        {
            trans.Rollback();
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
            Response.End();
        }
        if (success)
        {
            Response.Redirect("frmVehicleIssueSlipCloseLegWise_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
            //Server.Transfer("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
        }
    }




    #region newly added 3 jan 2015

    protected void add_rowOil(object sender, EventArgs e)
    {

        lblError.Text = "";
        int count = Convert.ToInt32(Session["dbOilRow"].ToString());
        string rowno;
        rowno = txtAddRowOilExp.Text;
        int mroww = 0;

        mroww = Convert.ToInt16(rowno);

        if (mroww >= count)
        {
            int miroww = 0;
            int i;
            int iroww = 0;
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                iroww = iroww + 1;
            }
            miroww = iroww;
            if (mroww < miroww)
            {
                miroww = mroww;
            }
            if (iroww >= 0)
            {
                for (i = iroww - 1; i > -1 + miroww; i--)
                {
                    _dataSet.HSD_OIL_EXP.RemoveHSD_OIL_EXPRow(_dataSet.HSD_OIL_EXP[i]);
                }
            }
            for (i = 0 + miroww; i < Int16.Parse(txtAddRowOilExp.Text); i++)
            {
                Double LastKm1 = 0;
                string LastKm2 = lblStartKm.Text;
                LastKm1 = Convert.ToDouble(lblStartKm.Text);
                int LastKm = Convert.ToInt32(LastKm1);
                // LastKm=LastKm+
                if (i == 0)
                {
                    _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", LastKm2, "", "", "", "0", "0", "", "", "", "", "0", "0");
                }
                else
                {
                    _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "", "", "", "0", "0");
                }
            }
            BindGrid();
            int k = 0;
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                string cash_card = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Value;
                if (k < count) // && cash_card=="Credit"
                {
                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = false;

                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = false;
                    //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = false;
                    //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = false;
                    //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = false;

                    k = k + 1;
                }
                else
                {

                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;

                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                    //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                    //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;

                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                    //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = true;
                }
            }
        }
        else
        {
            lblError.Text = "Sorry, HSD/OIL Expenses row can not be less than " + Session["dbOilRow"].ToString() + " !!!";
        }
    }



    public void BindGrid()
    {
        //gvTHC.DataSource = _dataSet.THCContract;
        //gvTHC.DataBind();
        //_lastEditedPage = gvTHC.CurrentPageIndex;

        //gvTHC.DataSource = _dataSet.THCContract;
        //gvTHC.DataBind();

        // dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        //dgAdvanceDet.DataBind();
        // _lastEditedPage = dgAdvanceDet.CurrentPageIndex;

        dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
        dgHSD_OIL_EXP.DataBind();
        _lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;

        //dgEnroute.DataSource = _dataSet.EnExpense;
        //dgEnroute.DataBind();
        //_lastEditedPage = dgEnroute.CurrentPageIndex;

        gvEnroute.DataSource = _dataSet.EnExpense;
        gvEnroute.DataBind();

         
    }


    protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct VENDORNAME,VENDORCODE from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME", conn);
        conn.Close();
        da1.Fill(ds1, "webx_VENDOR_HDR");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlPPName = ((DropDownList)e.Item.FindControl("ddlPPName"));
            ddlPPName.DataTextField = "VENDORNAME";
            ddlPPName.DataValueField = "VENDORCODE";
            ddlPPName.DataSource = ds1.Tables["webx_VENDOR_HDR"];
            ddlPPName.DataBind();
            ddlPPName.Items.Insert(0, "");
            TextBox txtKM_Reading = (TextBox)e.Item.FindControl("txtKM_Reading");
            TextBox txtLKmRead = (TextBox)e.Item.FindControl("txtLKmRead");

            TextBox txtExeAmt = (TextBox)e.Item.FindControl("txtExeAmt");
            //txtLKmRead.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtKM_Reading.ClientID.ToString() + "').focus();");
            txtExeAmt.Attributes.Add("OnBlur", "return CheckApprovedAmt(" + e.Item.ItemIndex + ",this)");
            txtKM_Reading.Attributes.Add("OnBlur", "return CheckKM(" + e.Item.ItemIndex + ",this," + txtLKmRead.ClientID.ToString().Trim() + ")");

            DropDownList ddlFuelType = (DropDownList)e.Item.FindControl("ddlFuelType");
            ddlFuelType.Attributes.Add("OnChange", "javascript:FillLastKmRead(" + e.Item.ItemIndex + ",this);");



        }


        DataSet ds2 = new DataSet();
        SqlDataAdapter da2 = new SqlDataAdapter("select distinct Fuel_Brand_ID,Fuel_Brand_Name from WEBX_FLEET_FUELBRAND where Active_Flag='Y' order By Fuel_Brand_Name", conn);
        conn.Close();
        da2.Fill(ds2, "WEBX_FLEET_FUELBRAND");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlBrand = ((DropDownList)e.Item.FindControl("ddlBrand"));
            ddlBrand.DataTextField = "Fuel_Brand_Name";
            ddlBrand.DataValueField = "Fuel_Brand_ID";
            ddlBrand.DataSource = ds2.Tables["WEBX_FLEET_FUELBRAND"];
            ddlBrand.DataBind();
            ddlBrand.Items.Insert(0, "");
        }
        DataSet ds3 = new DataSet();
        SqlDataAdapter da3 = new SqlDataAdapter("select distinct CodeId,CodeDesc from Webx_Master_General where CodeType='FUELTY' Order By CodeDesc", conn);
        conn.Close();
        da3.Fill(ds3, "Webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlFuelType = ((DropDownList)e.Item.FindControl("ddlFuelType"));
            ddlFuelType.DataTextField = "CodeDesc";
            ddlFuelType.DataValueField = "CodeId";
            ddlFuelType.DataSource = ds3.Tables["Webx_Master_General"];
            ddlFuelType.DataBind();
            ddlFuelType.Items.Insert(0, "");
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_HSDOIL = ((MyFleetDataSet.HSD_OIL_EXPRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtOilPlace")).Text = datarow_HSDOIL.OilPlace;

            ((DropDownList)e.Item.FindControl("ddlPPName")).SelectedItem.Text = datarow_HSDOIL.PPName;
            ((DropDownList)e.Item.FindControl("ddlBrand")).SelectedItem.Text = datarow_HSDOIL.Brand;
            ((DropDownList)e.Item.FindControl("ddlFuelType")).SelectedItem.Text = datarow_HSDOIL.FuelType;
            ((TextBox)e.Item.FindControl("txtLKMRead")).Text = datarow_HSDOIL.Last_Km_Read;

            ((TextBox)e.Item.FindControl("txtKM_Reading")).Text = datarow_HSDOIL.KM_Reading;
            ((TextBox)e.Item.FindControl("txtBillno")).Text = datarow_HSDOIL.Billno;
            ((TextBox)e.Item.FindControl("txtBilldt")).Text = datarow_HSDOIL.Billdt;
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Text = datarow_HSDOIL.Diesel_Ltr;
            //((TextBox)e.Item.FindControl("txtOil_Ltr")).Text = datarow_HSDOIL.Oil_Ltr;
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_HSDOIL.Amt;

            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_HSDOIL.Exe_Amt;
            ((DropDownList)e.Item.FindControl("ddlPayment")).SelectedValue = datarow_HSDOIL.Payment;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_HSDOIL.Remarks;

            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Text = datarow_HSDOIL.Diesel_Rate;
            //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Text = datarow_HSDOIL.Oil_Rate;

            ((TextBox)e.Item.FindControl("txtBilldt")).Attributes.Add("OnBlur", "javascript:ValidDateHSD(" + ((TextBox)e.Item.FindControl("txtBilldt")).ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Attributes.Add("OnBlur", "javascript:CalculateDiesel()");

            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Attributes.Add("OnBlur", "javascript:CalculateDieselLiters(" + ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).ClientID.ToString() + "," + ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).ClientID.ToString() + "," + ((TextBox)e.Item.FindControl("txtAmt")).ClientID.ToString() + ")");

            ((TextBox)e.Item.FindControl("txtAmt")).Attributes.Add("OnFocus", "javascript:document.getElementById('" + ((TextBox)e.Item.FindControl("txtExeAmt")).ClientID.ToString() + "').focus();");

            DropDownList ddlPayment = (DropDownList)e.Item.FindControl("ddlPayment");
            if (datarow_HSDOIL.Payment == "Credit")
            {
                ddlPayment.Items.Add(new ListItem("Credit", "Credit"));

                ddlPayment.SelectedValue = "Credit";
            }
            if (datarow_HSDOIL.Payment == "Credit")
            {
                ((TextBox)e.Item.FindControl("txtOilPlace")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlPPName")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlBrand")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlFuelType")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtKM_Reading")).Enabled = false;

                ((TextBox)e.Item.FindControl("txtBillno")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtBilldt")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Enabled = false;
                //((TextBox)e.Item.FindControl("txtOil_Ltr")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = false;

                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = false;
                //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Enabled = false;
            }
            else
            {
                ((TextBox)e.Item.FindControl("txtOilPlace")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlPPName")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlBrand")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlFuelType")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtKM_Reading")).Enabled = true;

                ((TextBox)e.Item.FindControl("txtBillno")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtBilldt")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Enabled = true;
                //((TextBox)e.Item.FindControl("txtOil_Ltr")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = true;

                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = true;
                //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Enabled = true;
            }
        }
    }


    private void ReverseBind()
    {
        MyFleetDataSet.SparePartRow datarow_Spare;

        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
             
            datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
            datarow_HSDOIL.OilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
            datarow_HSDOIL.PPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Value;
            datarow_HSDOIL.Brand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Value;
            datarow_HSDOIL.FuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Value;
            datarow_HSDOIL.Last_Km_Read = ((TextBox)gridrow.FindControl("txtLKMRead")).Text;
            datarow_HSDOIL.KM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
            datarow_HSDOIL.Billno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
            datarow_HSDOIL.Billdt = ((TextBox)gridrow.FindControl("txtBilldt")).Text;
            datarow_HSDOIL.Diesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
            datarow_HSDOIL.Oil_Ltr = "";
            //datarow_HSDOIL.Oil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
            datarow_HSDOIL.Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
            datarow_HSDOIL.Exe_Amt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
            datarow_HSDOIL.Payment = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Text;
            datarow_HSDOIL.Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
            datarow_HSDOIL.Diesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
            //datarow_HSDOIL.Oil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
            datarow_HSDOIL.Oil_Rate = "";
        }
    }

    public void Inetialized_HSD_OIL_EXP()
    {
        _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "", "", "", "0", "0");
    }
    protected void CardNo_Dispaly(object sender, EventArgs e)
    {
        lblError.Text = "";
        MyFleetDataSet.HSD_OIL_EXPRow datarow_OilExp;
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                string FCCardNo = "";
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                string msql = "select Manual_Fuel_Card_No  from WEBX_FLEET_FUELCARD where Vehicle_No='" + lblVehno.Text + "'";
                SqlCommand cdR = new SqlCommand(msql, conn);
                SqlDataReader cdDR = cdR.ExecuteReader();
                if (cdDR.HasRows)
                {
                    while (cdDR.Read())
                    {
                        FCCardNo = Convert.ToString(cdDR["Manual_Fuel_Card_No"]);
                    }
                }
                cdDR.Close();
                conn.Close();
                if (tbddlPayment.SelectedValue == "Diesel Card")
                {
                    tbFCCard.Text = FCCardNo.ToString();
                    if (lblError.Text == "")
                    {
                        if (tbFCCard.Text == "")
                        {
                            lblError.Visible = true;
                            lblError.Text = "FO ledger is not activated for this vehicle FC card !!! Please check";
                        }
                    }
                }
                else
                {
                    tbFCCard.Text = "";
                }
            }
        }
    }

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "0";
        _dataSet.EnExpense.Clear();
        string strPolarity = "";
        foreach (GridViewRow row in gvEnroute.Rows)
        {
            DropDownList ddlNExpense = (DropDownList)row.FindControl("ddlNExpense");
            TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
            TextBox txtBillNo = (TextBox)row.FindControl("txtBillNo");
            TextBox txtDate = (TextBox)row.FindControl("txtDate");
            TextBox txtEAmt = (TextBox)row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)row.FindControl("hfPolarity");
            TextBox txtRemark = (TextBox)row.FindControl("txtRemark");
            if (strPolarity == "")
            {
                strPolarity = hfPolarity.Value + "~";
            }
            else
            {
                strPolarity = strPolarity + hfPolarity.Value + "~";
            }
            _dataSet.EnExpense.AddEnExpenseRow(ddlNExpense.SelectedValue, txtAmount.Text, txtBillNo.Text, txtDate.Text, txtEAmt.Text, txtRemark.Text);
        }
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            _dataSet.EnExpense.AddEnExpenseRow("", "", "", "", "", "");
        }
        tb_Row_No.Text = "0";
        gvEnroute.DataSource = _dataSet.EnExpense;
        gvEnroute.DataBind();

        if (strPolarity != "")
        {
            strPolarity = strPolarity.Substring(0, strPolarity.Length - 1);
        }

        string[] strPol = strPolarity.Split('~');
        int len = strPol.Length;
        foreach (GridViewRow row in gvEnroute.Rows)
        {
            TextBox txtEAmt = (TextBox)row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)row.FindControl("hfEAmt");
            txtEAmt.Text = hfEAmt.Value;
            if (len > 0)
            {
                HiddenField hfPolarity = (HiddenField)row.FindControl("hfPolarity");
                hfPolarity.Value = strPol[row.RowIndex].ToString();
            }
            len = len - 1;
        }
    }

    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddlNExpense = (DropDownList)e.Row.FindControl("ddlNExpense");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            TextBox txtEAmt = (TextBox)e.Row.FindControl("txtEAmt");
            TextBox txtDate = (TextBox)e.Row.FindControl("txtDate");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
            TextBox txtBillNo = (TextBox)e.Row.FindControl("txtBillNo");
            TextBox txtRemark = (TextBox)e.Row.FindControl("txtRemark");

            txtEAmt.Enabled = false;
            BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);
            txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtDate.Attributes.Add("OnBlur", "javascript:ValidDate(" + txtDate.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");

            ddlNExpense.Attributes.Add("onChange", "return CheckValidExp(" + e.Row.RowIndex + "," + ddlNExpense.ClientID.ToString() + "," + txtEAmt.ClientID.ToString() + "," + hfEAmt.ClientID.ToString() + "," + hfPolarity.ClientID.ToString() + ");");

            if (_dataSet.EnExpense.Count > 0)
            {
                //ddlNExpense.SelectedItem.Text = _dataSet.EnExpense[e.Row.RowIndex]["NExpense"].ToString();
                ddlNExpense.SelectedValue = _dataSet.EnExpense[e.Row.RowIndex]["NExpense"].ToString();
            }

            if (strPolarity != "")
            {
                string[] strArr = strPolarity.ToString().Split(',');
                for (int i = 0; i < strArr.Length; i++)
                {
                    if (e.Row.RowIndex == i)
                    {
                        hfPolarity.Value = strArr[i].ToString();
                    }
                }
            }
            //datarow_EnExp.NExpense
            //ddlNExpense.SelectedItem.Text = _dataSet.EnExpense.d
            //txtEAmt.Text = datarow_EnExp.Amount;

            //txtBillNo.Text = datarow_EnExp.BillNo;
            //txtDate.Text = datarow_EnExp.Date;
            //txtEAmt.Text = datarow_EnExp.EAmt;
            //txtRemark.Text = datarow_EnExp.Remarks;

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txtETotalAmt = (TextBox)e.Row.FindControl("txtETotalAmt");
            TextBox txtEnAmtTotal = (TextBox)e.Row.FindControl("txtEnAmtTotal");
            txtETotalAmt.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal.ClientID.ToString() + "').disabled='true';");

            txtEnAmtTotal.Text = Convert.ToString(totExAmt);
            txtETotalAmt.Text = Convert.ToString(totStandardAmt);
        }
    }


    private void BindGridEnExpense()
    {
        gvEnroute.DataSource = dtEnExpense;
        gvEnroute.DataBind();
    }

    public void Previous_HSD_OIL_EXP()
    {
        string mSTR = "  select convert(varchar,BillDt,103) as BillDt1,(select top 1 vendorname from webx_vendor_hdr where vendorcode=PetrolPName or VendorName=PetrolPName) as PPName,(select  top 1 Fuel_Brand_Name from WEBX_FLEET_FUELBRAND where convert(varchar(3),Fuel_Brand_ID)=Brand or Fuel_Brand_Name=Brand) BrandName,(select CodeDesc from Webx_Master_General where CodeType='FUELTY' and (CodeId=FuelType or CodeDesc=FuelType)) FuelTypeName, * from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo ='" + Request.QueryString["ID"] + "'  ";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());
        DataTable dt = new DataTable();

        dt = objTripSheet.ExecuteSql(mSTR);
        double TotDisesel_Ltr = 0;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;

                string place = Convert.ToString(dr["place"]);
                string ppname = Convert.ToString(dr["PPName"]);//PetrolPNAme
                string FuelType = Convert.ToString(dr["FuelTypeName"]);//FuelType

                string Remark = Convert.ToString(dr["Remark"]);
                string Exe_amt = Convert.ToString(dr["Exe_amt"]);

                string Last_Km_read = Convert.ToString(dr["Last_Km_read"]);
                string KMRead = Convert.ToString(dr["KM_Reading"]);
                string BillNo = Convert.ToString(dr["BillNo"]);
                string BillDt = Convert.ToString(dr["BillDt1"]);
                string Disesel_Ltr = Convert.ToString(dr["Diesel_Ltr"]);

                TotDisesel_Ltr = TotDisesel_Ltr + Convert.ToDouble(Disesel_Ltr.ToString());
                string Oil_Ltr = Convert.ToString(dr["Oil_Ltr"]);
                string Dsl_rate = Convert.ToString(dr["Diesel_rate"]);
                string Oil_Rate = Convert.ToString(dr["Oil_Rate"]);

                string Amount = Convert.ToString(dr["Amount"]);
                string Brand = Convert.ToString(dr["BrandName"]);//Brand

                string Category = Convert.ToString(dr["Category"]);

                string Card_Cash = Convert.ToString(dr["Card_Cash"]);
                if (Card_Cash == "Credit")
                {
                    mcount = mcount + 1;
                }

                //DropDownList ddlPayment = (DropDownList)e.Item.FindControl("ddlPayment");
                //if (datarow_HSDOIL.Payment == "Credit")
                //{
                //    ddlPayment.Items.Add(new ListItem("Credit", "Credit"));

                //    ddlPayment.SelectedValue = "Credit";
                //}

                _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow(place, ppname, Brand, FuelType, Last_Km_read, KMRead, BillNo, BillDt, Disesel_Ltr, Oil_Ltr, Amount, Exe_amt, Card_Cash, Remark, Dsl_rate, Oil_Rate);
            }
        }
        BindGrid();

        Session["dbOilRow"] = mcount;
        Session["dbOilRow1"] = count;
      //  txtFuelFilledEnroute.Text = TotDisesel_Ltr.ToString();

        txtAddRowOilExp.Text = count.ToString();
    }


    public void InetializEnrouteExpense()
    {
        TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());

        //string str = "SELECT G.CodeDesc, E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt, E.Remarks"
        //+ " FROM Webx_Master_General AS G LEFT OUTER JOIN"
        //+ " WEBX_FLEET_ENROUTE_EXP AS E ON G.CodeId = E.id AND (E.TripsheetNo = '" + Session["Tripsheet"].ToString().Trim() + "')"
        //+ " WHERE (G.CodeType = 'FULEXP') "
        //+ " ORDER BY G.CodeId";

        string str = "SELECT G.Trip_Exp_Header + ' (' +G.Polarity + ')' as CodeDesc,G.Polarity , E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt"
              + ", E.Remarks FROM Webx_Trip_Expense_Master AS G INNER JOIN WEBX_FLEET_ENROUTE_EXP AS E "
              + "ON G.ID = E.id AND (E.TripsheetNo = '" + Request.QueryString["ID"] + "') ORDER BY G.ID ";


        DataTable dtDR = new DataTable();
        dtDR = objTripSheet.ExecuteSql(str);
        Double mAmt = 0, mEAmt = 0;
        if (dtDR.Rows.Count > 0)
        {
            foreach (DataRow dr in dtDR.Rows)
            {
                string mCodeDesc = Convert.ToString(dr["codedesc"]);
                string id = Convert.ToString(dr["id"]);
                string Amount = Convert.ToString(dr["Amount_spent"]);
                string BillNo = Convert.ToString(dr["BillNo"]);
                string BillDt = Convert.ToString(dr["dt"]);
                string Exe_amt = Convert.ToString(dr["exe_appr_amt"]);
                if (Amount == "")
                {
                    Amount = "0";
                }
                if (Exe_amt == "")
                {
                    Exe_amt = "0";
                }
                mAmt = mAmt + Convert.ToDouble(Amount);
                mEAmt = mEAmt + Convert.ToDouble(Exe_amt);
                if (Amount == "0")
                {
                    Amount = "";
                }
                if (Exe_amt == "0")
                {
                    Exe_amt = "0";
                }
                string Remarks = Convert.ToString(dr["Remarks"]);
                //dtEnExpense.AddEnExpenseRouteRow(mCodeDesc,"" , Amount, BillNo, BillDt, Exe_amt, Remarks);
                if (strPolarity == "")
                {
                    strPolarity = Convert.ToString(dr["Polarity"]);
                }
                else
                {
                    strPolarity = strPolarity + "," + Convert.ToString(dr["Polarity"]);
                }


                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt = totExAmt + Convert.ToDouble(Convert.ToString(dr["Amount_spent"]) == "" ? "0" : Convert.ToString(dr["Amount_spent"]));
                    totStandardAmt = totStandardAmt + Convert.ToDouble(Convert.ToString(dr["exe_appr_amt"]) == "" ? "0" : Convert.ToString(dr["exe_appr_amt"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt = totExAmt - Convert.ToDouble(Convert.ToString(dr["Amount_spent"]) == "" ? "0" : Convert.ToString(dr["Amount_spent"]));
                    totStandardAmt = totStandardAmt - Convert.ToDouble(Convert.ToString(dr["exe_appr_amt"]) == "" ? "0" : Convert.ToString(dr["exe_appr_amt"]));
                }
                hfETotalAmt.Value = Convert.ToString(totExAmt);

                //_dataSet.EnExpense.AddEnExpenseRow(mCodeDesc, Amount, BillNo, BillDt, Exe_amt, Remarks);
                _dataSet.EnExpense.AddEnExpenseRow(id, Amount, BillNo, BillDt, Exe_amt, Remarks);

                //dtEnExpense.AddEnExpenseRouteRow(mCodeDesc, "", Amount, BillNo, BillDt, Exe_amt, Remarks);
            }
        }
        BindGrid();
        //foreach (GridViewRow r in gvEnroute.Rows)
        //{
        //    DropDownList ddlNExpense = (DropDownList)r.FindControl("ddlNExpense");
        //    //BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);
        //    ddlNExpense.SelectedItem.Text = _dataSet.EnExpense[r.RowIndex]["NExpense"].ToString().Trim();
        //}


    }

    #endregion 

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }
}

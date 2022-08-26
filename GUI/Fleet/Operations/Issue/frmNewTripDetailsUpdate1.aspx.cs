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
using System.Web.Resources;

public partial class GUI_Fleet_Operations_Issue_frmNewTripDetailsUpdate : System.Web.UI.Page
{
    static string str_Connection_String = "";

    public string modeval = "";

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    MyFleetDataSet.ETMRRow datarow_ETMR;



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
        SqlConnection conn;

        string stVSlipId = "";
        str_Connection_String = Session["SqlProvider"].ToString();
        // Button1.Attributes.Add("onClick", "javascript:return validtripbilling(this);");

       // txtFromCity.Attributes.Add("OnBlur", "javascript:return CheckValidCity(this," + lbl_FromCity_Err.ClientID.ToString() + ")");
        // txtToCity.Attributes.Add("OnBlur", "javascript:return CheckValidCity(this," + lbl_ToCity_Err.ClientID.ToString() + ")");


        txtFromCity.Attributes.Add("OnBlur", "javascript:return CheckFromValidCityN( " + txtFromCity.ClientID.ToString().Trim() + ", " + hdnFromCity.ClientID.ToString().Trim() + ")");
        txtToCity.Attributes.Add("OnBlur", "javascript:return CheckToValidCityN(" + txtToCity.ClientID.ToString().Trim() + ", " + hdnToCity.ClientID.ToString().Trim() + ")");

        TextBoxFromCity.Attributes.Add("OnBlur", "javascript:return CheckFromValidCityNE( " + TextBoxFromCity.ClientID.ToString().Trim() + ", " + hdnFromCityNE.ClientID.ToString().Trim() + ")");
        TextBoxToCity.Attributes.Add("OnBlur", "javascript:return CheckToValidCityNE(" + TextBoxToCity.ClientID.ToString().Trim() + ", " + hdntoCityNE.ClientID.ToString().Trim() + ")");
        TextBoxVehicleNo.Attributes.Add("Onblur", "javascript:GetVehicleDetails(this);");

        TextBoxBalanceAmount.Attributes.Add("Onblur", "javascript:GetBalanceAmountDetails(this);");
        TextBoxAdvanceAmount.Attributes.Add("Onblur", "javascript:GetBalanceAmountDetails(this);");
        TextBoxContractAmount.Attributes.Add("Onblur", "javascript:GetBalanceAmountDetails(this);");
        txtChallanDate.Attributes.Add("OnBlur", "javascript:CheckLogEntrytxtChallanDate(" + txtChallanDate.ClientID.ToString() + ");");
        TexLoadingDate.Attributes.Add("OnBlur", "javascript:CheckLogEntryTexLoadingDate(" + TexLoadingDate.ClientID.ToString() + ");");


        txtCustomer.Attributes.Add("onBlur", "javascript:GettxtCustomerwalkin(this);");



        if (!IsPostBack)
        {
            InitializeDataTripBilling();

            TableRowWalkincust.Style["display"] = "none"; 

            

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

            stVSlipId = Request.QueryString["id"];

            if (modeval == "TripDetails")
            {
                lblPageHead.Text = "Vehicle Issue Slip - Financial Edit";
            }
            Session["Tripsheet"] = null;
            Session["Tripsheet"] = stVSlipId;
            System.DateTime righnow = System.DateTime.Today;

            try
            {
                TripSheet objTripSheet = new TripSheet(str_Connection_String);

                DataTable dtVI = new DataTable();
                dtVI = objTripSheet.ExecuteSql("SELECT * from VW_Webx_Fleet_TripDetails where VSlipNo= '" + stVSlipId + "'");

                if (dtVI.Rows.Count > 0)
                {
                    lblTripsheetno.Text = dtVI.Rows[0]["VSlipNo"].ToString();
                    lblTripDateTime.Text = dtVI.Rows[0]["VSlipDt"].ToString();
                    hdnTripSheetDate.Value = dtVI.Rows[0]["TripDate"].ToString();
                    txtManualTripSheetNo.Text = dtVI.Rows[0]["Manual_TripSheetNo"].ToString();
                    lblStartLoc.Text = dtVI.Rows[0]["TripSheet_StartLoc"].ToString();
                    lblEndLoc.Text = dtVI.Rows[0]["TripSheet_EndLoc"].ToString();
                    lblStartKm.Text = dtVI.Rows[0]["Start_km"].ToString();

                    txtVehno.Text = dtVI.Rows[0]["vehno"].ToString();
                    txtVehModel.Text = dtVI.Rows[0]["Model_No"].ToString();
                    txtVehCategory.Text = dtVI.Rows[0]["Category"].ToString();
                    txtVehCapacity.Text = dtVI.Rows[0]["Capacity"].ToString();
                    txtVehOpnKM.Text = dtVI.Rows[0]["Start_km"].ToString();
                    txtDieselCarryForward.Text = dtVI.Rows[0]["DIESEL_QTY_CF"].ToString();
                    txtDieselCarryForwardAmt.Text = dtVI.Rows[0]["DIESEL_AMT_CF"].ToString();

                    txtDriver1Name.Text = dtVI.Rows[0]["Driver1_Name"].ToString();
                    txtDriver2Name.Text = dtVI.Rows[0]["Driver2_Name"].ToString();
                    txtCleanerName.Text = dtVI.Rows[0]["Cleaner_Name"].ToString();
                    lblDriver1Licno.Text = dtVI.Rows[0]["Licno1"].ToString();
                    lblDriver2Licno.Text = dtVI.Rows[0]["Licno2"].ToString();
                    //lblCleanerLicno.Text = dtVI.Rows[0]["driver_name"].ToString();
                    lblDriver1ValidDt.Text = dtVI.Rows[0]["Validdt1"].ToString();
                    lblDriver2ValidDt.Text = dtVI.Rows[0]["Validdt2"].ToString();
                    //lblCleanerValidDt.Text = dtVI.Rows[0]["driver_name"].ToString();

                    txtRouteType.Text = dtVI.Rows[0]["Trip_route_type"].ToString();
                    txtRouteName.Text = dtVI.Rows[0]["rut_code"].ToString();

                    //txtAdvancegiven.Text = dtVI.Rows[0]["driver_name"].ToString();

                    TextBoxUserId.Text = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    TextBoxVehicleNo.Text = dtVI.Rows[0]["vehno"].ToString();
                    TextBoxTripsheetNo.Text = dtVI.Rows[0]["VSlipNo"].ToString();
                    TextBoxBalancePayment.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();





                    hdnTextBoxUserIdM.Value= SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    hdnTextBoxVehicleNoM.Value= dtVI.Rows[0]["vehno"].ToString();
                    hdnTextBoxTripsheetNoM.Value = dtVI.Rows[0]["VSlipNo"].ToString();
                    hdnTextBoxBalancePaymentM.Value = SessionUtilities.CurrentBranchCode.ToString().Trim();




                    





                    TextBoxUserId.Attributes.Add("OnFocus", "javascript:this.blur()");
                    TextBoxVehicleNo.Attributes.Add("OnFocus", "javascript:this.blur()");
                    TextBoxTripsheetNo.Attributes.Add("OnFocus", "javascript:this.blur()");
                    TextBoxBalancePayment.Attributes.Add("OnFocus", "javascript:this.blur()");

                    


                }

            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }

            //Previous_VehicleLogEntry();
            Previous_ETHCEntry();
            Previous_VehicleLogEntry();
           // table1646.Visible = false;
        }
    }

    protected void SubmitData(object sender, EventArgs e)
    {

        var Tripsheetno = Request.QueryString["id"];
        //changed by anupam new
        rowVehicleLogHdr.Visible = true;
        RowVehicleLogRow.Visible = true;
        rowVehicleLogDet.Visible = true;
        table1646.Visible = true;
        //cmdSubmit.Visible = false;
        btnNext.Visible = true;
        //changed by anupam new

       // TableEXTERNALTHCDetails.Visible = true;
        Previous_ETHCEntry();
        Previous_VehicleLogEntry();

        //Response.Redirect("~/GUI/Fleet/Operations/Issue/frmNewVehicleIssueLegWise.aspx?VSLIPNO=" + Tripsheetno + "");
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
    public void BindDropDownLegType(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.Parameters.Add("@VEHNO", SqlDbType.VarChar).Value = txtVehno.Text.ToString().Trim();
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



    protected void btnNext_SubmitData(object sender, EventArgs e)
    {
        //try
        {
            TripSheet objTripSheet = new TripSheet(str_Connection_String);

            string mTripSheetNo = "";
            string sqlDEL = "";
            SqlCommand cmdDEL = new SqlCommand();

            


            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            //DateTime mServerDt = new DateTime;

            mTripSheetNo = lblTripsheetno.Text.ToString();
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();


            try
            {

                sqlDEL = "Delete from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                sqlDEL = "Delete from Webx_Fleet_Trip_Dockets where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                sqlDEL = "UPDATE WEBX_FLEET_NEW_TRIP_LEGNAME SET LEGNAME1='',LEGNAME2='',LEGNAME3='',LEGNAME4='',LEGNAME5='',LEGNAME6='',LEGNAME1_From_Code='',LEGNAME1_To_Code='',LEGNAME2_From_Code='',LEGNAME2_To_Code='',LEGNAME3_From_Code='',LEGNAME3_To_Code='',LEGNAME4_From_Code='',LEGNAME4_To_Code='',LEGNAME5_From_Code='',LEGNAME5_To_Code='',LEGNAME6_From_Code='',LEGNAME6_To_Code='' where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                foreach (GridViewRow gridrow in gvVehicleLogEntry.Rows)
                {
                    SqlCommand sql_insert_veh = new SqlCommand("USP_FLEET_INSERT_VEHICLE_LOGENTRY", conn, trans);
                    sql_insert_veh.CommandType = CommandType.StoredProcedure;

                    if (((TextBox)gridrow.FindControl("txtFrom")).Text.ToString() != "" && ((TextBox)gridrow.FindControl("txtTo")).Text.ToString() != "")
                    {
                        sql_insert_veh.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                        sql_insert_veh.Parameters.Add("@From_Point", SqlDbType.VarChar, 100).Value = ((HiddenField)gridrow.FindControl("hdnFromCity")).Value.ToString();
                        sql_insert_veh.Parameters.Add("@To_Point", SqlDbType.VarChar, 100).Value = ((HiddenField)gridrow.FindControl("hdnToCity")).Value.ToString();
                        
                        sql_insert_veh.Parameters.Add("@Category_Type", SqlDbType.VarChar, 50).Value = ((DropDownList)gridrow.FindControl("ddlCategory")).SelectedValue.ToString().Trim();
                        sql_insert_veh.Parameters.Add("@ContainerNo", SqlDbType.VarChar, 30).Value = ((TextBox)gridrow.FindControl("txtContainerNo")).Text.ToString();
                        sql_insert_veh.Parameters.Add("@Document_Name", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtInvoiceNo")).Text.ToString();

                        if (((TextBox)gridrow.FindControl("txtStartDate")).Text.ToString() != "" && ((TextBox)gridrow.FindControl("txtEndDate")).Text.ToString() != "")
                        {
                            string mStartDateTm = ((TextBox)gridrow.FindControl("txtStartDate")).Text.ToString() + " " + ((TextBox)gridrow.FindControl("tb_StartTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_StartTime_MM")).Text.ToString();
                            string mEndDateTm = ((TextBox)gridrow.FindControl("txtEndDate")).Text.ToString() + " " + ((TextBox)gridrow.FindControl("tb_EndTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_EndTime_MM")).Text.ToString();

                            sql_insert_veh.Parameters.Add("@Start_Date_Tm", SqlDbType.DateTime).Value = Convert.ToDateTime(mStartDateTm, dtfi);
                            sql_insert_veh.Parameters.Add("@End_Date_Tm", SqlDbType.DateTime).Value = Convert.ToDateTime(mEndDateTm, dtfi);

                        }
                        else
                        {
                            string mStartDateTm = "" + "" + "";
                            string mEndDateTm = "" + "" + "";

                            sql_insert_veh.Parameters.Add("@Start_Date_Tm", SqlDbType.DateTime).Value = "";
                            sql_insert_veh.Parameters.Add("@End_Date_Tm", SqlDbType.DateTime).Value = "";

                        }
                        sql_insert_veh.Parameters.Add("@Start_Km_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtStartKm")).Text.ToString());
                        sql_insert_veh.Parameters.Add("@End_KM_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtEndKm")).Text.ToString());
                        sql_insert_veh.Parameters.Add("@KM_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtKMRun")).Text.ToString());
                        sql_insert_veh.Parameters.Add("@Transit_Time", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("tb_Transit_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_Transit_MM")).Text.ToString();
                        sql_insert_veh.Parameters.Add("@Idle_Time", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("tb_IdleTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_IdleTime_MM")).Text.ToString();

                        sql_insert_veh.ExecuteNonQuery();
                    }

                }


                trans.Commit();
                //trans.Rollback();
                success = true;


            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                //Response.Redirect("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblTripsheetno.Text.ToString() + "&mode=" + modeval, true);
                Response.Redirect("frmNewTripDetailsUpdateNext.aspx?id=" + lblTripsheetno.Text.ToString() + "&VEHNO=" + txtVehno.Text + "&StartKM=" + lblStartKm.Text, true);
                //Server.Transfer("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
            }
        }
    }



    protected void SubmitDataTripBilling(object sender, EventArgs e)
    {
        //try
        {
            cmdSubmit.Visible = true;
            rowVehicleLogDet.Visible = true;
            TripSheet objTripSheet = new TripSheet(str_Connection_String);

            string mTripSheetNo = "";
            string sqlDEL = "";
            SqlCommand cmdDEL = new SqlCommand();
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            mTripSheetNo = lblTripsheetno.Text.ToString();
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {
                sqlDEL = "UPDATE WEBX_FLEET_VEHICLE_ISSUE SET TripBillingWise='" + txtCustomer.Text.ToString() + "',TripBillingType='" + ddlTripBIllingSelection.SelectedValue.ToString() + "',from_city='" + txtFromCity.Text.ToString() + "',to_city='" + txtToCity.Text.ToString() + "',BillingCustname='" + txtWalkinCustomerName.Text.ToString() + "' where VSlipNo='" + mTripSheetNo + "'";

                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();
                trans.Commit();
                //trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("frmNewTripDetailsUpdate.aspx?id=" + mTripSheetNo + "&mode=TD", true);
            }
        }
    }

    protected void ddlTripBIllingSelection_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlTripBIllingSelection.SelectedValue.ToString() == "01")
        {
            TableRowfrom_city.Visible = true;

        }
        else
        {
            TableRowfrom_city.Visible = false;
        }
    }
    public void InitializeDataTripBilling()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.CheckTripRule();
        if (objTs.Trip_Billing == "Y")
        {
            if (objTs.Trip_Billing_wise == "THC")
            {
                BindDropDown("USP_FLEET_TRIP_NEW_TRIPBILL_THC", "CodeDesc", "CodeId", ddlTripBIllingSelection);
            }
            if (objTs.Trip_Billing_wise == "LOG")
            {
                BindDropDown("USP_FLEET_TRIP_NEW_TRIPBILL_LOG", "CodeDesc", "CodeId", ddlTripBIllingSelection);
            }
            if (objTs.Trip_Billing_wise == "BOTH")
            {
                BindDropDown("USP_FLEET_TRIP_NEW_TRIPBILL_BOTH", "CodeDesc", "CodeId", ddlTripBIllingSelection);
            }
            try
            {
                TripSheet objTripSheet = new TripSheet(str_Connection_String);

                DataTable dtVI = new DataTable();
                dtVI = objTripSheet.ExecuteSql("SELECT * from VW_Webx_Fleet_TripBillDetails where VSlipNo= '" + Request.QueryString["id"] + "'");

                if (dtVI.Rows.Count > 0)
                {
                    lblTripBillingWise.Text = dtVI.Rows[0]["TripBillingWise"].ToString();
                    lblTripBillingType.Text = dtVI.Rows[0]["TripBillingType"].ToString();
                }

            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }

            if (lblTripBillingWise.Text.ToString() == "" && lblTripBillingType.Text.ToString() == "")
            {
                Div1.Visible = false;
                Tripbilling.Visible = true;
                cmdSubmit.Visible = false;
                rowVehicleLogDet.Visible = false;
            }
            else
            {
                Div1.Visible = true;
                Tripbilling.Visible = false;
                cmdSubmit.Visible = true;
            }
        }
        else
        {
            tblTripBilling.Visible = false;
            Div1.Visible = false;
            Tripbilling.Visible = false;
            cmdSubmit.Visible = true;
        }
    }


    protected void SubmitExternalTHCNoMulti(object sender, EventArgs e)
    {
        {
            TripSheet objTripSheet = new TripSheet(str_Connection_String);
            string mTripSheetNo = "";
            string sqlDEL = "";
            SqlCommand cmdDEL = new SqlCommand();
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            mTripSheetNo = lblTripsheetno.Text.ToString();
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {

                sqlDEL = "Delete from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                sqlDEL = "UPDATE WEBX_FLEET_NEW_TRIP_LEGNAME SET LEGNAME1='',LEGNAME2='',LEGNAME3='',LEGNAME4='',LEGNAME5='',LEGNAME6='',LEGNAME1_From_Code='',LEGNAME1_To_Code='',LEGNAME2_From_Code='',LEGNAME2_To_Code='',LEGNAME3_From_Code='',LEGNAME3_To_Code='',LEGNAME4_From_Code='',LEGNAME4_To_Code='',LEGNAME5_From_Code='',LEGNAME5_To_Code='',LEGNAME6_From_Code='',LEGNAME6_To_Code='' where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                string mDocuementNo = "";
                foreach (GridViewRow gridrow in gvVehicleLogEntry.Rows)
                {
                    if (((Label)gridrow.FindControl("LabelExternalTHCNoM")).Text.ToString().Trim()=="")
                    {
                        string YearVal = "";
                        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                        YearVal = objFinYear.FinancialYear();
                        string mSTRGND = "WebX_SP_GetNextDocumentCode_ETHC";
                        SqlCommand mcmd1 = new SqlCommand(mSTRGND, conn, trans);
                        mcmd1.CommandType = CommandType.StoredProcedure;
                        mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                        mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();
                        mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = "ETHC";
                        SqlDataReader rTS = mcmd1.ExecuteReader();
                        if (rTS.Read())
                        {
                            mDocuementNo = rTS[0].ToString().Trim();
                        }
                        rTS.Close();


                        string mCityC = "WebX_SP_GetCitytCode_ETHC";
                        SqlCommand mCityC1 = new SqlCommand(mCityC, conn, trans);
                        mCityC1.CommandType = CommandType.StoredProcedure;
                        mCityC1.Parameters.Add("@FrmCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("TextBoxFromCityM")).Text.ToString().Trim();
                        mCityC1.Parameters.Add("@ToCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("TextBoxToCityM")).Text.ToString().Trim();
                        SqlDataReader rTSmCityC = mCityC1.ExecuteReader();
                        if (rTSmCityC.Read())
                        {
                            if (((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim() == "")
                            {
                                ((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value = rTSmCityC[0].ToString().Trim();
                            }

                            if (((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value.ToString().Trim() == "")
                            {
                                ((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value = rTSmCityC[1].ToString().Trim();
                            }
                        }
                        rTSmCityC.Close();




                        SqlCommand sql_insert_ExternalTHC = new SqlCommand("USP_WEBX_FLEET_ExternalTHC_ExternalTHC", conn, trans);
                        sql_insert_ExternalTHC.CommandType = CommandType.StoredProcedure;
                        sql_insert_ExternalTHC.Parameters.Add("@ExternalTHCNo", SqlDbType.VarChar, 50).Value = mDocuementNo.ToString().Trim();
                       // sql_insert_ExternalTHC.Parameters.Add("@TextBoxUserId", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxUserIdM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxUserId", SqlDbType.VarChar, 50).Value = hdnTextBoxUserIdM.Value.ToString().Trim();
                        
                        //sql_insert_ExternalTHC.Parameters.Add("@TextBoxVehicleNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxVehicleNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxVehicleNo", SqlDbType.VarChar, 50).Value = hdnTextBoxVehicleNoM.Value.Trim();
                        //sql_insert_ExternalTHC.Parameters.Add("@TextBoxTripsheetNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxTripsheetNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxTripsheetNo", SqlDbType.VarChar, 50).Value = hdnTextBoxTripsheetNoM.Value.Trim();
                        
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxCustomerType", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxCustomerTypeM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxTransporterName", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxTransporterNameM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxFromCity", SqlDbType.VarChar, 50).Value = ((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxToCity", SqlDbType.VarChar, 50).Value = ((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxTransporterChallanNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxTransporterChallanNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@txtChallanDate", SqlDbType.DateTime).Value = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtChallanDateM")).Text.ToString().Trim(), dtfi);
                        sql_insert_ExternalTHC.Parameters.Add("@TexLoadingDate", SqlDbType.DateTime).Value = Convert.ToDateTime(((TextBox)gridrow.FindControl("TexLoadingDateM")).Text.ToString().Trim(), dtfi);
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxContactNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxContactNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxBrokerName", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxBrokerNameM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxMobileNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxMobileNoM")).Text.ToString().Trim();

                        if (((TextBox)gridrow.FindControl("TextBoxWeightM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxWeightM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxWeight", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxWeightM")).Text.ToString().Trim());
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxNug", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxNugM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxCommodity", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxCommodityM")).Text.ToString().Trim();

                        if (((TextBox)gridrow.FindControl("TextBoxContractAmountM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxContractAmountM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxContractAmount", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxContractAmountM")).Text.ToString().Trim());

                        if (((TextBox)gridrow.FindControl("TextBoxAdvanceAmountM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxAdvanceAmountM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxAdvanceAmount", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxAdvanceAmountM")).Text.ToString().Trim());
                        ((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text.ToString().Trim();
                        if (((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxBalanceAmount", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text.ToString().Trim());
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxRemarks", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxRemarksM")).Text.ToString().Trim();
                        //sql_insert_ExternalTHC.Parameters.Add("@TextBoxBalancePayment", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxBalancePaymentM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxBalancePayment", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                        
                        sql_insert_ExternalTHC.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@OTripsheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@Company_Code", SqlDbType.VarChar, 20).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@finYear", SqlDbType.VarChar, 4).Value = SessionUtilities.FinYear.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@yearSuffix", SqlDbType.VarChar, 5).Value = YearVal.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@BRCD", SqlDbType.VarChar, 10).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                        sql_insert_ExternalTHC.ExecuteNonQuery();
                    }
                    else
                    {
                        string mCityC = "WebX_SP_GetCitytCode_ETHC";
                        SqlCommand mCityC1 = new SqlCommand(mCityC, conn, trans);
                        mCityC1.CommandType = CommandType.StoredProcedure;
                        mCityC1.Parameters.Add("@FrmCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("TextBoxFromCityM")).Text.ToString().Trim();
                        mCityC1.Parameters.Add("@ToCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("TextBoxToCityM")).Text.ToString().Trim();
                        SqlDataReader rTSmCityC = mCityC1.ExecuteReader(); 
                        if (rTSmCityC.Read())
                        {
                            if (((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim() == "")
                            {
                                ((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value = rTSmCityC[0].ToString().Trim();
                            }

                            if (((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value.ToString().Trim() == "")
                            {
                                ((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value = rTSmCityC[1].ToString().Trim();
                            }
                        }
                        rTSmCityC.Close();

                        SqlCommand sql_insert_ExternalTHC = new SqlCommand("USP_WEBX_FLEET_ExternalTHC_ExternalTHC_Update", conn, trans);
                        sql_insert_ExternalTHC.CommandType = CommandType.StoredProcedure;
                        sql_insert_ExternalTHC.Parameters.Add("@ExternalTHCNo", SqlDbType.VarChar, 50).Value = ((Label)gridrow.FindControl("LabelExternalTHCNoM")).Text.ToString().Trim();
                        //sql_insert_ExternalTHC.Parameters.Add("@TextBoxUserId", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxUserIdM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxUserId", SqlDbType.VarChar, 50).Value = hdnTextBoxUserIdM.Value.ToString().Trim();
                        
                       // sql_insert_ExternalTHC.Parameters.Add("@TextBoxVehicleNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxVehicleNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxVehicleNo", SqlDbType.VarChar, 50).Value = hdnTextBoxVehicleNoM.Value.Trim();
                        //sql_insert_ExternalTHC.Parameters.Add("@TextBoxTripsheetNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxTripsheetNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxTripsheetNo", SqlDbType.VarChar, 50).Value  = hdnTextBoxTripsheetNoM.Value.Trim().Trim();
                        
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxCustomerType", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxCustomerTypeM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxTransporterName", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxTransporterNameM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxFromCity", SqlDbType.VarChar, 50).Value = ((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxToCity", SqlDbType.VarChar, 50).Value = ((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxTransporterChallanNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxTransporterChallanNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@txtChallanDate", SqlDbType.DateTime).Value = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtChallanDateM")).Text.ToString().Trim(), dtfi);
                        sql_insert_ExternalTHC.Parameters.Add("@TexLoadingDate", SqlDbType.DateTime).Value = Convert.ToDateTime(((TextBox)gridrow.FindControl("TexLoadingDateM")).Text.ToString().Trim(), dtfi);
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxContactNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxContactNoM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxBrokerName", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxBrokerNameM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxMobileNo", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxMobileNoM")).Text.ToString().Trim();

                        if (((TextBox)gridrow.FindControl("TextBoxWeightM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxWeightM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxWeight", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxWeightM")).Text.ToString().Trim());
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxNug", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxNugM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxCommodity", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxCommodityM")).Text.ToString().Trim();

                        if (((TextBox)gridrow.FindControl("TextBoxContractAmountM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxContractAmountM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxContractAmount", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxContractAmountM")).Text.ToString().Trim());

                        if (((TextBox)gridrow.FindControl("TextBoxAdvanceAmountM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxAdvanceAmountM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxAdvanceAmount", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxAdvanceAmountM")).Text.ToString().Trim());
                        ((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text.ToString().Trim();
                        if (((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text == "")
                        {
                            ((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text = "0";
                        }
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxBalanceAmount", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("TextBoxBalanceAmountM")).Text.ToString().Trim());
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxRemarks", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxRemarksM")).Text.ToString().Trim();
                        //sql_insert_ExternalTHC.Parameters.Add("@TextBoxBalancePayment", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("TextBoxBalancePaymentM")).Text.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@TextBoxBalancePayment", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                        sql_insert_ExternalTHC.Parameters.Add("@OTripsheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo.ToString().Trim();
                        sql_insert_ExternalTHC.ExecuteNonQuery();
                    }
                }


                foreach (GridViewRow gridrow in gvVehicleLogEntry.Rows)
                {
                    SqlCommand sql_insert_veh = new SqlCommand("USP_FLEET_INSERT_VEHICLE_LOGENTRY_ExternalTHC", conn, trans);
                    sql_insert_veh.CommandType = CommandType.StoredProcedure;
                    sql_insert_veh.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_veh.Parameters.Add("@From_Point", SqlDbType.VarChar, 100).Value = ((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim();
                    sql_insert_veh.Parameters.Add("@To_Point", SqlDbType.VarChar, 100).Value = ((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value.ToString().Trim();
                    //((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim();
                    sql_insert_veh.ExecuteNonQuery();
                }
                    sqlDEL = "Delete from WEBX_FLEET_TRIPTHCDET where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                    foreach (GridViewRow gridrow in gvVehicleLogEntry.Rows)
                    {
                        string sqlContract = "usp_TripTHCDetailInsert_ExternalTHC";
                        SqlCommand sqlcmdContract = new SqlCommand(sqlContract, conn, trans);
                        sqlcmdContract.CommandType = CommandType.StoredProcedure;
                        sqlcmdContract.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
                        if (txtCustomer.Text == "")
                        {
                            txtCustomer.Text = lblTripBillingWise.Text.ToString().Trim();
                        }
                        sqlcmdContract.Parameters.Add("@Custcode", SqlDbType.VarChar).Value = txtCustomer.Text.ToString().Trim();
                        sqlcmdContract.Parameters.Add("@FromCity", SqlDbType.VarChar).Value = ((HiddenField)gridrow.FindControl("hdnFromCityNEM")).Value.ToString().Trim();
                        sqlcmdContract.Parameters.Add("@ToCity", SqlDbType.VarChar).Value = ((HiddenField)gridrow.FindControl("hdntoCityNEM")).Value.ToString().Trim();
                        

                        if (LabelExternalTHCNo.Text == "")
                        {
                            LabelExternalTHCNo.Text = mDocuementNo.ToString().Trim();
                        }
                        sqlcmdContract.Parameters.Add("@THCNo", SqlDbType.VarChar).Value = LabelExternalTHCNo.Text.ToString().Trim();
                        sqlcmdContract.ExecuteNonQuery();
                    }
               trans.Commit();
               //trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("frmNewTripDetailsUpdateNext.aspx?id=" + lblTripsheetno.Text.ToString() + "&VEHNO=" + txtVehno.Text + "&StartKM=" + lblStartKm.Text, true); 
            }
        }
    }


    protected void SubmitExternalTHCNo(object sender, EventArgs e)
    {  
    }


    public void Previous_ETHCEntry()
    { 
    }
    protected void Add_RowVehicleLog(object sender, EventArgs e)
    {
        if ((txtAddVehicleLogRow.Text == "") || (txtAddVehicleLogRow.Text == "0")) txtAddVehicleLogRow.Text = "0";
        _dataSet.ETMR.Rows.Clear();
        foreach (GridViewRow row in gvVehicleLogEntry.Rows)
        {
            Label LabelSystemGeneratedM = (Label)row.FindControl("LabelSystemGeneratedM");
            Label LabelExternalTHCNoM = (Label)row.FindControl("LabelExternalTHCNoM");
            TextBox TextBoxUserIdM = (TextBox)row.FindControl("TextBoxUserIdM");
            TextBox TextBoxVehicleNoM = (TextBox)row.FindControl("TextBoxVehicleNoM");
            TextBox TextBoxTripsheetNoM = (TextBox)row.FindControl("TextBoxTripsheetNoM");
            TextBox TextBoxCustomerTypeM = (TextBox)row.FindControl("TextBoxCustomerTypeM");
            TextBox TextBoxTransporterNameM = (TextBox)row.FindControl("TextBoxTransporterNameM");
            TextBox TextBoxFromCityM = (TextBox)row.FindControl("TextBoxFromCityM");
            TextBox TextBoxToCityM = (TextBox)row.FindControl("TextBoxToCityM");
            TextBox TextBoxTransporterChallanNoM = (TextBox)row.FindControl("TextBoxTransporterChallanNoM");
            TextBox txtChallanDateM = (TextBox)row.FindControl("txtChallanDateM");
            TextBox TexLoadingDateM = (TextBox)row.FindControl("TexLoadingDateM");
            TextBox TextBoxContactNoM = (TextBox)row.FindControl("TextBoxContactNoM");
            TextBox TextBoxBrokerNameM = (TextBox)row.FindControl("TextBoxBrokerNameM");
            TextBox TextBoxMobileNoM = (TextBox)row.FindControl("TextBoxMobileNoM");
            TextBox TextBoxWeightM = (TextBox)row.FindControl("TextBoxWeightM");
            TextBox TextBoxNugM = (TextBox)row.FindControl("TextBoxNugM");
            TextBox TextBoxCommodityM = (TextBox)row.FindControl("TextBoxCommodityM");
            TextBox TextBoxContractAmountM = (TextBox)row.FindControl("TextBoxContractAmountM");
            TextBox TextBoxAdvanceAmountM = (TextBox)row.FindControl("TextBoxAdvanceAmountM");
            TextBox TextBoxBalanceAmountM = (TextBox)row.FindControl("TextBoxBalanceAmountM");
            TextBox TextBoxRemarksM = (TextBox)row.FindControl("TextBoxRemarksM");
            TextBox TextBoxBalancePaymentM = (TextBox)row.FindControl("TextBoxBalancePaymentM");
            _dataSet.ETMR.AddETMRRow(LabelSystemGeneratedM.Text, LabelExternalTHCNoM.Text, TextBoxUserIdM.Text, TextBoxVehicleNoM.Text, TextBoxTripsheetNoM.Text, TextBoxCustomerTypeM.Text, TextBoxTransporterNameM.Text, TextBoxFromCityM.Text, TextBoxToCityM.Text, TextBoxTransporterChallanNoM.Text, txtChallanDateM.Text, TexLoadingDateM.Text, TextBoxContactNoM.Text, TextBoxBrokerNameM.Text, TextBoxMobileNoM.Text, TextBoxWeightM.Text, TextBoxNugM.Text, TextBoxCommodityM.Text, TextBoxContractAmountM.Text, TextBoxAdvanceAmountM.Text, TextBoxBalanceAmountM.Text, TextBoxRemarksM.Text, TextBoxBalancePaymentM.Text);
        }
        lbl_VehicleLog_Err.Text = "";
        int count = 0;
        string rowno;
        rowno = txtAddVehicleLogRow.Text;
        int mroww = 0;
        mroww = Convert.ToInt16(rowno);
        if (mroww >= count)
        {
            int miroww = 0;
            int i;
            int iroww = 0;
            foreach (GridViewRow row in gvVehicleLogEntry.Rows)
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
                    _dataSet.ETMR.RemoveETMRRow(_dataSet.ETMR[i]);

                }
            }
            for (i = 0 + miroww; i < Int16.Parse(txtAddVehicleLogRow.Text); i++)
            {
                Double LastKm1 = 0;
                string LastKm2 = txtVehOpnKM.Text;
                LastKm1 = Convert.ToDouble(txtVehOpnKM.Text);
                int LastKm = Convert.ToInt32(LastKm1);
                //LastKm=LastKm+
                if (i == 0)
                {
                    _dataSet.ETMR.AddETMRRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                }
                else
                {
                    _dataSet.ETMR.AddETMRRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                }
            }
        }

        gvVehicleLogEntry.DataSource = _dataSet.ETMR;
        gvVehicleLogEntry.DataBind();
    }

    protected void gvVehicleLogEntry1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label LabelSystemGeneratedM = (Label)e.Row.FindControl("LabelSystemGeneratedM");
            Label LabelExternalTHCNoM = (Label)e.Row.FindControl("LabelExternalTHCNoM");
            TextBox TextBoxUserIdM = (TextBox)e.Row.FindControl("TextBoxUserIdM");
            TextBox TextBoxVehicleNoM = (TextBox)e.Row.FindControl("TextBoxVehicleNoM");
            TextBox TextBoxTripsheetNoM = (TextBox)e.Row.FindControl("TextBoxTripsheetNoM");
            TextBox TextBoxCustomerTypeM = (TextBox)e.Row.FindControl("TextBoxCustomerTypeM");
            TextBox TextBoxTransporterNameM = (TextBox)e.Row.FindControl("TextBoxTransporterNameM");
            TextBox TextBoxFromCityM = (TextBox)e.Row.FindControl("TextBoxFromCityM");
            TextBox TextBoxToCityM = (TextBox)e.Row.FindControl("TextBoxToCityM");
            TextBox TextBoxTransporterChallanNoM = (TextBox)e.Row.FindControl("TextBoxTransporterChallanNoM");
            TextBox txtChallanDateM = (TextBox)e.Row.FindControl("txtChallanDateM");
            TextBox TexLoadingDateM = (TextBox)e.Row.FindControl("TexLoadingDateM");
            TextBox TextBoxContactNoM = (TextBox)e.Row.FindControl("TextBoxContactNoM");
            TextBox TextBoxBrokerNameM = (TextBox)e.Row.FindControl("TextBoxBrokerNameM");
            TextBox TextBoxMobileNoM = (TextBox)e.Row.FindControl("TextBoxMobileNoM");
            TextBox TextBoxWeightM = (TextBox)e.Row.FindControl("TextBoxWeightM");
            TextBox TextBoxNugM = (TextBox)e.Row.FindControl("TextBoxNugM");
            TextBox TextBoxCommodityM = (TextBox)e.Row.FindControl("TextBoxCommodityM");
            TextBox TextBoxContractAmountM = (TextBox)e.Row.FindControl("TextBoxContractAmountM");
            TextBox TextBoxAdvanceAmountM = (TextBox)e.Row.FindControl("TextBoxAdvanceAmountM");
            TextBox TextBoxBalanceAmountM = (TextBox)e.Row.FindControl("TextBoxBalanceAmountM");
            TextBox TextBoxRemarksM = (TextBox)e.Row.FindControl("TextBoxRemarksM");
            TextBox TextBoxBalancePaymentM = (TextBox)e.Row.FindControl("TextBoxBalancePaymentM");

            HiddenField hdnFromCityNEM = (HiddenField)e.Row.FindControl("hdnFromCityNEM");
            HiddenField hdntoCityNEM = (HiddenField)e.Row.FindControl("hdntoCityNEM");

            TextBoxFromCityM.Attributes.Add("OnBlur", "javascript:return CheckFromValidCityNEM( " + TextBoxFromCityM.ClientID.ToString().Trim() + ", " + hdnFromCityNEM.ClientID.ToString().Trim() + ")");
            TextBoxToCityM.Attributes.Add("OnBlur", "javascript:return CheckToValidCityNEM(" + TextBoxToCityM.ClientID.ToString().Trim() + ", " + hdntoCityNEM.ClientID.ToString().Trim() + ")");


            TextBoxBalanceAmountM.Attributes.Add("Onblur", "javascript:GetBalanceAmountDetailsM(this);");
            TextBoxAdvanceAmountM.Attributes.Add("Onblur", "javascript:GetBalanceAmountDetailsM(this);");
            TextBoxContractAmountM.Attributes.Add("Onblur", "javascript:GetBalanceAmountDetailsM(this);");
            txtChallanDateM.Attributes.Add("OnBlur", "javascript:CheckLogEntrytxtChallanDateM(" + txtChallanDateM.ClientID.ToString() + ");");
            TexLoadingDateM.Attributes.Add("OnBlur", "javascript:CheckLogEntryTexLoadingDateM(" + TexLoadingDateM.ClientID.ToString() + ");");

            TextBoxUserIdM.Text = hdnTextBoxUserIdM.Value.ToString().Trim();
            TextBoxVehicleNoM.Text = hdnTextBoxVehicleNoM.Value;
            TextBoxTripsheetNoM.Text = hdnTextBoxTripsheetNoM.Value;
            TextBoxBalancePaymentM.Text = hdnTextBoxBalancePaymentM.Value.ToString().Trim();
            TextBoxUserIdM.Attributes.Add("OnFocus", "javascript:this.blur()");
            TextBoxVehicleNoM.Attributes.Add("OnFocus", "javascript:this.blur()");
            TextBoxTripsheetNoM.Attributes.Add("OnFocus", "javascript:this.blur()");
            TextBoxBalancePaymentM.Attributes.Add("OnFocus", "javascript:this.blur()");

            
        }
    }

    public void Previous_VehicleLogEntry()
    {
        string mSTR = "select ExternalTHCNo,UserId,VehicleNo,TripsheetNo,CustomerType,TransporterName,(select Location from webx_citymaster where convert(varchar,city_code)=convert(varchar,FromCity)) as FromCity,FromCity as FromCityc,ToCity as ToCityc,(select Location from webx_citymaster where convert(varchar,city_code)=convert(varchar,ToCity)) as ToCity,TransporterChallanNo,CONVERT(varchar,ChallanDate,103)as ChallanDate,CONVERT(varchar,LoadingDate,103)as LoadingDate,ContactNo,BrokerName, MobileNo,Weight,Nug,Commodity,ContractAmount,AdvanceAmount,BalanceAmount,Remarks,BalancePayment,OTripsheetNo  from WEBX_FLEET_ExternalTHC where OTripsheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow gv in dt.Rows)
            {
                count = count + 1;
                string LabelExternalTHCNoM = Convert.ToString(gv["ExternalTHCNo"]);
                string TextBoxUserIdM = Convert.ToString(gv["UserId"]);
                string TextBoxVehicleNoM = Convert.ToString(gv["VehicleNo"]);
                string TextBoxTripsheetNoM = Convert.ToString(gv["TripsheetNo"]);
                string TextBoxCustomerTypeM = Convert.ToString(gv["CustomerType"]);
                string TextBoxTransporterNameM = Convert.ToString(gv["TransporterName"]);
                string TextBoxFromCityM = Convert.ToString(gv["FromCity"]);
                string TextBoxToCityM = Convert.ToString(gv["ToCity"]);
                string TextBoxTransporterChallanNoM = Convert.ToString(gv["TransporterChallanNo"]);
                string txtChallanDateM = Convert.ToString(gv["ChallanDate"]);
                string TexLoadingDateM = Convert.ToString(gv["LoadingDate"]);
                string TextBoxContactNoM = Convert.ToString(gv["ContactNo"]);
                string TextBoxBrokerNameM = Convert.ToString(gv["BrokerName"]);
                string TextBoxMobileNoM = Convert.ToString(gv["MobileNo"]);
                string TextBoxWeightM = Convert.ToString(gv["Weight"]);
                string TextBoxNugM = Convert.ToString(gv["Nug"]);
                string TextBoxCommodityM = Convert.ToString(gv["Commodity"]);
                string TextBoxContractAmountM = Convert.ToString(gv["ContractAmount"]);
                string TextBoxAdvanceAmountM = Convert.ToString(gv["AdvanceAmount"]);
                string TextBoxBalanceAmountM = Convert.ToString(gv["BalanceAmount"]);
                string TextBoxRemarksM = Convert.ToString(gv["Remarks"]);
                string TextBoxBalancePaymentM = Convert.ToString(gv["BalancePayment"]);
                _dataSet.ETMR.AddETMRRow(LabelExternalTHCNoM, LabelExternalTHCNoM, TextBoxUserIdM, TextBoxVehicleNoM, TextBoxTripsheetNoM, TextBoxCustomerTypeM, TextBoxTransporterNameM, TextBoxFromCityM, TextBoxToCityM, TextBoxTransporterChallanNoM, txtChallanDateM, TexLoadingDateM, TextBoxContactNoM, TextBoxBrokerNameM, TextBoxMobileNoM, TextBoxWeightM, TextBoxNugM, TextBoxCommodityM, TextBoxContractAmountM, TextBoxAdvanceAmountM, TextBoxBalanceAmountM, TextBoxRemarksM, TextBoxBalancePaymentM);
                rowVehicleLogHdr.Visible = true;
                RowVehicleLogRow.Visible = true;
                rowVehicleLogDet.Visible = true;
                table1646.Visible = true;
                cmdSubmit.Visible = false;
                btnNext.Visible = true;
            }
        }
        BindGrid();
        Session["dbVEHLogRow"] = mcount;
        txtAddVehicleLogRow.Text = count.ToString();
    }
    public void BindGrid()
    {
        gvVehicleLogEntry.DataSource = _dataSet.ETMR;
        gvVehicleLogEntry.DataBind();
    }

}

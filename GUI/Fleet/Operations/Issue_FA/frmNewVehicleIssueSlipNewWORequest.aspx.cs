using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ApplicationManager;
using System.Web.Services;
using System.Collections.Generic;
using System.Configuration;


public partial class GUI_Fleet_Operations_Issue_frmNewVehicleIssueSlipNewWORequest : System.Web.UI.Page
{
    static string str_Connection_String = "";
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    MyFleetDataSet.AdvanceTakenFARow datarow_Adv;
    int _lastEditedPage;
    public string mRouteStr = "";
    DateFunction DtFun = new DateFunction();
    MyFunctions fn = new MyFunctions();
    MyFunctions fn1 = new MyFunctions();
    DriverBalance DBalance = new DriverBalance();

    string[] nameParts;
    string SplitVendorName;
    string SplitBankName;
    string SplitVendorCity;

    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString();
        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(str_Connection_String));
        string strfinyear = SessionUtilities.FinYear.ToString().Trim();
        hfFinancialYr.Value = SessionUtilities.FinYear.ToString().Trim();
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        //UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        //DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        //TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        //TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        //TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        //txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this);"); 
        //cmdSubmit.Attributes.Add("onClick", "javascript:return valid(this," + dlsttranstype.ClientID + ");");

        cmdSubmit.Attributes.Add("onClick", "javascript:return valid(this);");
        //cmdSubmit.Attributes.Add("onClick", "javascript:return Validate();");
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (txtVehno.Text.ToString().Trim() != "")
        {
            lblRouteError.Text = "";
        }

        //tblAdvanceEntry.Style["display"] = "none"; 
        //if (chkAdvanceFlag.Checked == true)
        //{
        //    tblAdvanceEntry.Style["display"] = "block";
        //    //tblAdvanceEntry.Visible = true;
        //}
        //else
        //{
        //    tblAdvanceEntry.Style["display"] = "none";
        //    //tblAdvanceEntry.Visible = false;
        //} 
        //txtVehno.Attributes.Add("OnChange", "javascript:CallA();");

        if (!IsPostBack)
        {

            txtStartLoc.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();
            txtEndLoc.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();

            //InitializeData();

            //txtDriver1.Attributes.Add("OnKeyUp", "javascript:foo=false; alert(foo);");

            txtDate.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../../images/Fleet_Date_Control_Rule_Check.aspx');ChekcFinancialYear();");

            txtVehno.Attributes.Add("Onblur", "javascript:GetVehicleDetailsMaster(this);");

            txtDriver1.Attributes.Add("Onblur", "javascript:GetDriver1DetailsMaster(this); GetDriver1DetailsVehicleWiseMaster(this);");
            txtDriver2.Attributes.Add("Onblur", "javascript:GetDriver2DetailsMaster(this); GetDriver2DetailsVehicleWiseMaster(this);");
            txtCleaner.Attributes.Add("Onblur", "javascript:GetCleanerDetails(this); GetCleanerDetailsVehicleWise(this);");



            fn.Fill_Location_Dataset();
            fn1.Fill_City_Dataset();


            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            //DtCal.SetCalenderText(strrightnow);
            txtDate.Text = strrightnow;
            hfTodayDate.Value = righnow.ToString("dd/MM/yyyy");

            string script;
            script = @"<SCRIPT language='javascript'> CheckTripRule();" + "</SCRIPT>";
            this.RegisterStartupScript("MyAlert", script);

            string scr3 = @"<script>
                function update1111(elemValue)
              {
                 document.getElementById('ctl00_MyCPH1_txtEndLoc').value=elemValue;
                 document.getElementById('ctl00_MyCPH1_txtEndLoc').focus()
              }
              </script>";
            Page.RegisterClientScriptBlock("update1111", scr3);
            btnPopupLoc.Attributes.Add("onclick", "window.open('../../../Popups/popup-branch_level4.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");

            string scr4 = @"<script>
                function update_city1(elemValue)
              {
                 document.getElementById('ctl00_MyCPH1_txtFromCity').value=elemValue;
                 //document.getElementById('ctl00_MyCPH1_txtFromCity').focus();

              }
              </script>";
            Page.RegisterClientScriptBlock("update_city1", scr4);

            string scr5 = @"<script>
              function update_city2(elemValue)
              {
                 document.getElementById('ctl00_MyCPH1_txtToCity').value=elemValue;
                 //document.getElementById('ctl00_MyCPH1_txtToCity').focus();
              }
              </script>";

            txtManualTripSheetNo.Attributes.Add("OnBlur", "javascript:CheckValidManualTS(this," + lbl_Manual_TS_Err.ClientID.ToString() + ");");

            //Mayank 
            //foreach (GridViewRow gridrow in gvFuelSlip.Rows)
            //{
            //    TextBox txtFuelSlipNo = (TextBox)gridrow.FindControl("txtFuelSlipNo");
            //    Label lbl_FuelSlipNo_Err = (Label)gridrow.FindControl("lbl_FuelSlipNo_Err");
            //    txtFuelSlipNo.Attributes.Add("OnBlur", "javascript:CheckValidFuelSlipNo(this," + lbl_FuelSlipNo_Err.ClientID.ToString() + ");");
            //}

            Inetialized_AdvanceTaken();
            BindGrid();
            InitializeData();

            // BindDropDown("USP_FLEET_TRIP_NEW_ROUTETYPE", "CodeDesc", "CodeId", ddlRouteType);
            //ddlRoute.Attributes.Add("OnChange", "javascript:OnChangeRoute(this);");

            SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
            conn.Open();
            string brcd = Session["brcd"].ToString();
            string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
            SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            SqlDataReader drBr;
            drBr = sqlcmd1.ExecuteReader();
            drBr.Read();
            string loccd = drBr["loccode"].ToString();
            drBr.Close();
            String SQL_LOC;

            if (brcd == loccd)
            {
                SQL_LOC = "Select '--Select--' AS RouteName UNION select RouteName from StandardExpense_FixedRoute_HDR";
                //sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            }
            else
            {
                SQL_LOC = "Select '-Select-' AS RouteNo UNION select RouteName from StandardExpense_FixedRoute_HDR";
                //sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {

                ddlRouteName.Items.Add(new ListItem(dr1.GetValue(0).ToString()));
            }
            dr1.Close();
            ddlRouteName.SelectedItem.Text = "-Select-";
            conn.Close();
            Add_RowAdvance(sender, e);
            Add_RowFuelSlip(sender, e);

        }
        else
        {
            if (txtDieselCarryForward.Text.ToString() != "")
            {
                txtDieselCarryForward.Enabled = false;
                txtDieselCarryForward.BorderStyle = BorderStyle.None;
                txtDieselCarryForward.CssClass = "";

            }
            else
            {
                txtDieselCarryForward.Enabled = true;
                txtDieselCarryForward.BorderStyle = BorderStyle.Groove;
                txtDieselCarryForward.CssClass = "input";
            }
            if (txtDieselCarryForwardAmt.Text.ToString() != "")
            {
                txtDieselCarryForwardAmt.Enabled = false;
                txtDieselCarryForwardAmt.BorderStyle = BorderStyle.None;
                txtDieselCarryForwardAmt.CssClass = "";
            }
            else
            {
                txtDieselCarryForwardAmt.Enabled = true;
                txtDieselCarryForwardAmt.BorderStyle = BorderStyle.Groove;
                txtDieselCarryForwardAmt.CssClass = "input";
            }
        }

    }


    protected void ddlTripBIllingSelection_SelectedIndexChanged(object sender, EventArgs e)
    {


    }


    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
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

    public void BindDropDownWithPerameter(string strProc, string text, string value, string parameter, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Mode", SqlDbType.VarChar).Value = parameter;
        SqlDataReader dr = cmd.ExecuteReader();
        d.Items.Clear();
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
    //protected void PopulateAdvamt(object sender, EventArgs e)
    //{
    //    UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
    //    TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
    //    foreach (DataGridItem gridrow in dgAdvanceDet.Items)
    //    {
    //        if (((TextBox)gridrow.FindControl("txtAdvDt")).Text != "")
    //        {
    //            txtAmount.Text = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;
    //        }
    //    }
    //}

    public void InitializeData()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.BindCheckList(gvChecklist);

        objTs.CheckTripRule();

        if (objTs.Vehicle_Filter == "CONT_LOC")
        {
            hfVehicleLocation.Value = "CONT_LOC";
        }
        if (objTs.Vehicle_Filter == "CUR_LOC")
        {
            hfVehicleLocation.Value = "CUR_LOC";
        }
        if (objTs.Vehicle_Filter == "NONE")
        {
            hfVehicleLocation.Value = "NONE";
        }

        if (objTs.THC_Attached == "Y")
        {
            hfAttached.Value = "Y";
        }
        else
        {
            hfAttached.Value = "N";
        }

        if (objTs.End_Location == "Y")
        {
            hdnEndLocEnable.Value = "Y";
            dvEndLoc.Visible = true;
        }
        else
        {
            hdnEndLocEnable.Value = "N";
            dvEndLoc.Visible = false;
        }

        if (objTs.SecondTrip_Approved == "Y")
        {
            hdnSecondTripApproved.Value = "Y";
        }
        else
        {
            hdnSecondTripApproved.Value = "N";

        }




        ddlDriver1.SelectedValue = "Y";
        //ddlDriver1.Enabled = false;

        objTs.Vehicle_No = txtVehno.Text.ToString().Trim();

        txtDriver1.Text = "";
        txtDriver1Name.Text = "";
        lblDriver1Licno.Text = "";
        lblDriver1ValidDt.Text = "";
        hf_Manual_Driver1_Code.Value = "";
        LblDriverBalance.Text = "";
        txtDriver1NotFromRoster.Text = "";

        lblDriver1Licno.Enabled = false;
        lblDriver1Licno.BorderStyle = BorderStyle.None;
        lblDriver1Licno.CssClass = "";

        lblDriver1ValidDt.Enabled = false;
        lblDriver1ValidDt.BorderStyle = BorderStyle.None;
        lblDriver1ValidDt.CssClass = "";

        txtDriver1.Visible = true;
        txtDriver1.Enabled = true;
        txtDriver1.BorderStyle = BorderStyle.Groove;

        txtDriver1Name.Visible = true;
        txtDriver1Name.Enabled = true;
        txtDriver1Name.BorderStyle = BorderStyle.Groove;

        txtDriver1NotFromRoster.Visible = false;
        txtDriver1NotFromRoster.Enabled = false;
        txtDriver1NotFromRoster.BorderStyle = BorderStyle.None;


        objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
        ddlDriver2.SelectedValue = "Y";
        //ddlDriver2.Enabled = false;
        txtDriver2.Text = "";
        txtDriver2Name.Text = "";
        lblDriver2Licno.Text = "";
        lblDriver2ValidDt.Text = "";
        txtDriver2NotFromRoster.Text = "";

        lblDriver2Licno.Enabled = false;
        lblDriver2Licno.BorderStyle = BorderStyle.None;
        lblDriver2Licno.CssClass = "";

        lblDriver2ValidDt.Enabled = false;
        lblDriver2ValidDt.BorderStyle = BorderStyle.None;
        lblDriver2ValidDt.CssClass = "";

        txtDriver2.Visible = true;
        txtDriver2.Enabled = true;
        txtDriver2.BorderStyle = BorderStyle.Groove;

        txtDriver2Name.Visible = true;
        txtDriver2Name.Enabled = true;
        txtDriver2Name.BorderStyle = BorderStyle.Groove;

        txtDriver2NotFromRoster.Visible = false;
        txtDriver2NotFromRoster.Enabled = false;
        txtDriver2NotFromRoster.BorderStyle = BorderStyle.None;


        //added by anupam
        /*
         //Commented to make By defult 'Y' --P006320
         
           if (objTs.Driver1NTFM == "Y")
          {
              ddlDriver1.SelectedValue = "Y";
              ddlDriver1.Enabled = false;

              objTs.Vehicle_No = txtVehno.Text.ToString().Trim();

              txtDriver1.Text = "";
              txtDriver1Name.Text = "";
              lblDriver1Licno.Text = "";
              lblDriver1ValidDt.Text = "";
              hf_Manual_Driver1_Code.Value = "";
              LblDriverBalance.Text = "";
              txtDriver1NotFromRoster.Text = "";

              lblDriver1Licno.Enabled = false;
              lblDriver1Licno.BorderStyle = BorderStyle.None;
              lblDriver1Licno.CssClass = "";

              lblDriver1ValidDt.Enabled = false;
              lblDriver1ValidDt.BorderStyle = BorderStyle.None;
              lblDriver1ValidDt.CssClass = "";

              txtDriver1.Visible = true;
              txtDriver1.Enabled = true;
              txtDriver1.BorderStyle = BorderStyle.Groove;

              txtDriver1Name.Visible = true;
              txtDriver1Name.Enabled = true;
              txtDriver1Name.BorderStyle = BorderStyle.Groove;

              txtDriver1NotFromRoster.Visible = false;
              txtDriver1NotFromRoster.Enabled = false;
              txtDriver1NotFromRoster.BorderStyle = BorderStyle.None;







          }
          else if (objTs.Driver1NTFM == "N")
          {
              objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
              ddlDriver1.SelectedValue = "N";
              ddlDriver1.Enabled = false;
              txtDriver1.Text = "";
              txtDriver1Name.Text = "";
              lblDriver1Licno.Text = "";
              lblDriver1ValidDt.Text = "";
              hf_Manual_Driver1_Code.Value = "";
              LblDriverBalance.Text = "";
              txtDriver1NotFromRoster.Text = "";

              lblDriver1Licno.Enabled = true;
              lblDriver1Licno.BorderStyle = BorderStyle.Groove;
              lblDriver1Licno.CssClass = "input";

              lblDriver1ValidDt.Enabled = true;
              lblDriver1ValidDt.BorderStyle = BorderStyle.Groove;
              lblDriver1ValidDt.CssClass = "input";

              txtDriver1.Visible = false;
              txtDriver1.Enabled = false;
              txtDriver1.BorderStyle = BorderStyle.None;

              txtDriver1Name.Visible = false;
              txtDriver1Name.Enabled = false;
              txtDriver1Name.BorderStyle = BorderStyle.None;

              txtDriver1NotFromRoster.Visible = true;
              txtDriver1NotFromRoster.Enabled = true;
              txtDriver1NotFromRoster.BorderStyle = BorderStyle.Groove;
          }
          else
          {
              objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
              ddlDriver1.SelectedValue = "Y";
              ddlDriver1_SelectedIndexChanged(null, null);
              //ddlDriver1.Enabled=false;
              txtDriver1.Text = "";
              txtDriver1Name.Text = "";
              lblDriver1Licno.Text = "";
              lblDriver1ValidDt.Text = "";
              hf_Manual_Driver1_Code.Value = "";
              LblDriverBalance.Text = "";
              txtDriver1NotFromRoster.Text = "";

              lblDriver1Licno.Enabled = false;
              lblDriver1Licno.BorderStyle = BorderStyle.None;
              lblDriver1Licno.CssClass = "";

              lblDriver1ValidDt.Enabled = false;
              lblDriver1ValidDt.BorderStyle = BorderStyle.None;
              lblDriver1ValidDt.CssClass = "";

              txtDriver1.Visible = false;
              txtDriver1.Enabled = false;
              txtDriver1.BorderStyle = BorderStyle.None;

              txtDriver1Name.Visible = false;
              txtDriver1Name.Enabled = false;
              txtDriver1Name.BorderStyle = BorderStyle.None;

              txtDriver1NotFromRoster.Visible = false;
              txtDriver1NotFromRoster.Enabled = false;
              txtDriver1NotFromRoster.BorderStyle = BorderStyle.None;
          }

          if (objTs.Driver2NTFM == "Y")
          {
              objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
              ddlDriver2.SelectedValue = "Y";
              ddlDriver2.Enabled = false;
              txtDriver2.Text = "";
              txtDriver2Name.Text = "";
              lblDriver2Licno.Text = "";
              lblDriver2ValidDt.Text = "";
              txtDriver2NotFromRoster.Text = "";

              lblDriver2Licno.Enabled = false;
              lblDriver2Licno.BorderStyle = BorderStyle.None;
              lblDriver2Licno.CssClass = "";

              lblDriver2ValidDt.Enabled = false;
              lblDriver2ValidDt.BorderStyle = BorderStyle.None;
              lblDriver2ValidDt.CssClass = "";

              txtDriver2.Visible = true;
              txtDriver2.Enabled = true;
              txtDriver2.BorderStyle = BorderStyle.Groove;

              txtDriver2Name.Visible = true;
              txtDriver2Name.Enabled = true;
              txtDriver2Name.BorderStyle = BorderStyle.Groove;

              txtDriver2NotFromRoster.Visible = false;
              txtDriver2NotFromRoster.Enabled = false;
              txtDriver2NotFromRoster.BorderStyle = BorderStyle.None;
          }
          else if (objTs.Driver2NTFM == "N")
          {
              objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
              ddlDriver2.SelectedValue = "N";
              ddlDriver2.Enabled = false;

              txtDriver2.Text = "";
              txtDriver2Name.Text = "";
              lblDriver2Licno.Text = "";
              lblDriver2ValidDt.Text = "";
              txtDriver2NotFromRoster.Text = "";

              lblDriver2Licno.Enabled = true;
              lblDriver2Licno.BorderStyle = BorderStyle.Groove;
              lblDriver2Licno.CssClass = "input";

              lblDriver2ValidDt.Enabled = true;
              lblDriver2ValidDt.BorderStyle = BorderStyle.Groove;
              lblDriver2ValidDt.CssClass = "input";

              txtDriver2.Visible = false;
              txtDriver2.Enabled = false;
              txtDriver2.BorderStyle = BorderStyle.None;

              txtDriver2Name.Visible = false;
              txtDriver2Name.Enabled = false;
              txtDriver2Name.BorderStyle = BorderStyle.None;

              txtDriver2NotFromRoster.Visible = true;
              txtDriver2NotFromRoster.Enabled = true;
              txtDriver2NotFromRoster.BorderStyle = BorderStyle.Groove;
          }
          else
          {
              objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
              ddlDriver2.SelectedValue = "0";
              //ddlDriver2.Enabled=false;
              txtDriver2.Text = "";
              txtDriver2Name.Text = "";
              lblDriver2Licno.Text = "";
              lblDriver2ValidDt.Text = "";
              txtDriver2NotFromRoster.Text = "";

              lblDriver2Licno.Enabled = false;
              lblDriver2Licno.BorderStyle = BorderStyle.None;
              lblDriver2Licno.CssClass = "";

              lblDriver2ValidDt.Enabled = false;
              lblDriver2ValidDt.BorderStyle = BorderStyle.None;
              lblDriver2ValidDt.CssClass = "";

              txtDriver2.Visible = false;
              txtDriver2.Enabled = false;
              txtDriver2.BorderStyle = BorderStyle.None;

              txtDriver2Name.Visible = false;
              txtDriver2Name.Enabled = false;
              txtDriver2Name.BorderStyle = BorderStyle.None;

              txtDriver2NotFromRoster.Visible = false;
              txtDriver2NotFromRoster.Enabled = false;
              txtDriver2NotFromRoster.BorderStyle = BorderStyle.None;
          }*/

        if (objTs.CleanerNTFM == "Y")
        {
            objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
            ddlCleaner.SelectedValue = "Y";
            ddlCleaner.Enabled = false;
            txtCleaner.Text = "";
            txtCleanerName.Text = "";
            lblCleanerLicno.Text = "";
            lblCleanerValidDt.Text = "";
            txtCleanerNotFromRoster.Text = "";

            lblCleanerLicno.Enabled = false;
            lblCleanerLicno.BorderStyle = BorderStyle.None;
            lblCleanerLicno.CssClass = "";

            lblCleanerValidDt.Enabled = false;
            lblCleanerValidDt.BorderStyle = BorderStyle.None;
            lblCleanerValidDt.CssClass = "";

            txtCleaner.Visible = true;
            txtCleaner.Enabled = true;
            txtCleaner.BorderStyle = BorderStyle.Groove;

            txtCleanerName.Visible = true;
            txtCleanerName.Enabled = true;
            txtCleanerName.BorderStyle = BorderStyle.Groove;

            txtCleanerNotFromRoster.Visible = false;
            txtCleanerNotFromRoster.Enabled = false;
            txtCleanerNotFromRoster.BorderStyle = BorderStyle.None;
        }
        else if (objTs.CleanerNTFM == "N")
        {
            objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
            ddlCleaner.SelectedValue = "N";
            ddlCleaner.Enabled = false;

            txtCleaner.Text = "";
            txtCleanerName.Text = "";
            lblCleanerLicno.Text = "";
            lblCleanerValidDt.Text = "";
            txtCleanerNotFromRoster.Text = "";



            txtCleaner.Visible = false;
            txtCleaner.Enabled = false;
            txtCleaner.BorderStyle = BorderStyle.None;

            txtCleanerName.Visible = false;
            txtCleanerName.Enabled = false;
            txtCleanerName.BorderStyle = BorderStyle.None;

            txtCleanerNotFromRoster.Visible = true;
            txtCleanerNotFromRoster.Enabled = true;
            txtCleanerNotFromRoster.BorderStyle = BorderStyle.Groove;
        }
        else
        {
            objTs.Vehicle_No = txtVehno.Text.ToString().Trim();
            ddlCleaner.SelectedValue = "0";
            // ddlDriver2.Enabled = false;
            txtCleaner.Text = "";
            txtCleanerName.Text = "";
            lblCleanerLicno.Text = "";
            lblCleanerValidDt.Text = "";
            txtCleanerNotFromRoster.Text = "";

            lblCleanerLicno.Enabled = false;
            lblCleanerLicno.BorderStyle = BorderStyle.None;
            lblCleanerLicno.CssClass = "";

            lblCleanerValidDt.Enabled = false;
            lblCleanerValidDt.BorderStyle = BorderStyle.None;
            lblCleanerValidDt.CssClass = "";

            txtCleaner.Visible = false;
            txtCleaner.Enabled = false;
            txtCleaner.BorderStyle = BorderStyle.None;

            txtCleanerName.Visible = false;
            txtCleanerName.Enabled = false;
            txtCleanerName.BorderStyle = BorderStyle.None;

            txtCleanerNotFromRoster.Visible = false;
            txtCleanerNotFromRoster.Enabled = false;
            txtCleanerNotFromRoster.BorderStyle = BorderStyle.None;
        }
        //added by anupam



        objTs.BRCD = SessionUtilities.CurrentBranchCode.ToString().Trim();
        objTs.VENDORTYPE = "";
        objTs.Driver_Name = "";
        objTs.Vehicle_No = "";

        if (objTs.Driver_WO_Vehicle == "Y")
        {
            //objTs.BindDriverDropdown(ddl_Driver1, "");
        }
        if (objTs.Checklist == "Y" || objTs.Checklist_Mandatory == "Y")
        {
            hfChecklist_Mandatory.Value = objTs.Checklist_Mandatory;
            //Row_Checklist.Style["display"] = "block";
            gvChecklist.Visible = true;
            Table6.Visible = true;
        }
        else
        {
            //Row_Checklist.Style["display"] = "none";
            gvChecklist.Visible = false;
            Table6.Visible = false;
        }

        if (objTs.Driver_Photo_Rule == "Y" || objTs.Valdity_dt == "Y" || objTs.Settlement_Pending == "Y")
        {
            hfDriver_photo_Rule.Value = objTs.Driver_Photo_Rule;
            hfDriverLic_Validity_Rule.Value = objTs.Driver_License;
            hfDriver_TripCount_Rule.Value = objTs.Settlement_Pending;
            hfTot_No_Trip.Value = objTs.Tot_Tripsheet;
            hfDriver_Photo.Value = objTs.Driver_Photo;
            hfDriver_TripCount.Value = objTs.Trip_Count;
        }
        else
        {
            hfDriver_photo_Rule.Value = objTs.Driver_Photo_Rule;
            hfDriverLic_Validity_Rule.Value = objTs.Driver_License;
            hfDriver_TripCount_Rule.Value = objTs.Settlement_Pending;
            hfTot_No_Trip.Value = objTs.Tot_Tripsheet;
            hfDriver_Photo.Value = objTs.Driver_Photo;
            hfDriver_TripCount.Value = objTs.Trip_Count;
        }

        if (objTs.Driver2_Photo_Rule == "Y" || objTs.Driver2_License == "Y")
        {
            hfDriver2_photo_Rule.Value = objTs.Driver2_Photo_Rule;
            hfDriver2Lic_Validity_Rule.Value = objTs.Driver2_License;
            hfDriver2_Mandetory_Rule.Value = objTs.Driver2_Mandetory;
            hfDriver2_With_LocationFilter_Rule.Value = objTs.Driver2_With_LocationFilter;
            hfCleaner_Mandetory_Rule.Value = objTs.Cleaner_Mandetory;
        }
        else
        {
            hfDriver2_photo_Rule.Value = objTs.Driver2_Photo_Rule;
            hfDriver2Lic_Validity_Rule.Value = objTs.Driver2_License;
            hfDriver2_Mandetory_Rule.Value = objTs.Driver2_Mandetory;
            hfDriver2_With_LocationFilter_Rule.Value = objTs.Driver2_With_LocationFilter;
            hfCleaner_Mandetory_Rule.Value = objTs.Cleaner_Mandetory;
        }

        if (objTs.FUEL_SLIP_PROVIDED == "Y")
        {
            TableRowFuelSlip.Visible = true;
        }
        else
        {
            TableRowFuelSlip.Visible = false;
        }

        if (objTs.Trip_Billing == "Y")
        {
            //if (objTs.Trip_Billing_wise == "THC")
            //{
            //    BindDropDown("USP_FLEET_TRIP_NEW_TRIPBILL_THC", "CodeDesc", "CodeId", ddlTripBIllingSelection);
            //}
            //if (objTs.Trip_Billing_wise == "LOG")
            //{
            //    BindDropDown("USP_FLEET_TRIP_NEW_TRIPBILL_LOG", "CodeDesc", "CodeId", ddlTripBIllingSelection);
            //}
            //if (objTs.Trip_Billing_wise == "BOTH")
            //{
            //    BindDropDown("USP_FLEET_TRIP_NEW_TRIPBILL_BOTH", "CodeDesc", "CodeId", ddlTripBIllingSelection);
            //}
            tblTripBilling.Visible = false;
        }
        else
        {
            tblTripBilling.Visible = false;
        }
        if (objTs.Diesel_CF == "Y")
        {
            ROW_DIESEL_BALANCE.Visible = true;
            hdndieselCF.Value = "Y";
        }
        else
        {
            ROW_DIESEL_BALANCE.Visible = false;
            hdndieselCF.Value = "N";
        }

    }

    protected void chkFuelSlipFlag_CheckedChanged(object sender, EventArgs e)
    {
        if (chkFuelSlipFlag.Checked == true)
        {
            TableFuelSlip.Visible = true;
        }
        else
        {
            TableFuelSlip.Visible = false;
        }
    }

    public void CheckLocation(object sender, EventArgs e)
    {
        LblLocError.Text = "";
        string DataFoundFlag = "N";

        string strEndLoc = txtEndLoc.Text;
        if (strEndLoc != "")
        {
            SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
            string sql = "webx_Check_Location";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = strEndLoc;
            conn.Open();
            SqlDataReader dataRead = cmd.ExecuteReader();
            while (dataRead.Read())
            {
                DataFoundFlag = "Y";
            }
            dataRead.Close();
            conn.Close();

            if (DataFoundFlag == "N")
            {
                LblLocError.Text = "Invalid Location. !!!Please check.";
            }
        }
    }

    protected void ddlDriver1_SelectedIndexChanged(object sender, EventArgs e)
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.Vehicle_No = txtVehno.Text.ToString().Trim();


        if (ddlDriver1.SelectedValue == "0")
        {
            txtDriver1.Text = "";
            txtDriver1Name.Text = "";
            lblDriver1Licno.Text = "";
            lblDriver1ValidDt.Text = "";
            hf_Manual_Driver1_Code.Value = "";
            LblDriverBalance.Text = "";
            txtDriver1NotFromRoster.Text = "";

            lblDriver1Licno.Enabled = false;
            lblDriver1Licno.BorderStyle = BorderStyle.None;
            lblDriver1Licno.CssClass = "";

            lblDriver1ValidDt.Enabled = false;
            lblDriver1ValidDt.BorderStyle = BorderStyle.None;
            lblDriver1ValidDt.CssClass = "";

            txtDriver1.Visible = false;
            txtDriver1.Enabled = false;
            txtDriver1.BorderStyle = BorderStyle.None;

            txtDriver1Name.Visible = false;
            txtDriver1Name.Enabled = false;
            txtDriver1Name.BorderStyle = BorderStyle.None;

            txtDriver1NotFromRoster.Visible = false;
            txtDriver1NotFromRoster.Enabled = false;
            txtDriver1NotFromRoster.BorderStyle = BorderStyle.None;
        }

        else if (ddlDriver1.SelectedValue == "Y")
        {
            txtDriver1.Text = "";
            txtDriver1Name.Text = "";
            lblDriver1Licno.Text = "";
            lblDriver1ValidDt.Text = "";
            hf_Manual_Driver1_Code.Value = "";
            LblDriverBalance.Text = "";
            txtDriver1NotFromRoster.Text = "";

            //lblDriver1Licno.Enabled = false;
            //lblDriver1Licno.BorderStyle = BorderStyle.None;
            //lblDriver1Licno.CssClass = "";

            //lblDriver1ValidDt.Enabled = false;
            //lblDriver1ValidDt.BorderStyle = BorderStyle.None;
            //lblDriver1ValidDt.CssClass = "";

            txtDriver1.Visible = true;
            txtDriver1.Enabled = true;
            txtDriver1.BorderStyle = BorderStyle.Groove;

            txtDriver1Name.Visible = true;
            txtDriver1Name.Enabled = true;
            txtDriver1Name.BorderStyle = BorderStyle.Groove;

            txtDriver1NotFromRoster.Visible = false;
            txtDriver1NotFromRoster.Enabled = false;
            txtDriver1NotFromRoster.BorderStyle = BorderStyle.None;
        }
        else if (ddlDriver1.SelectedValue == "N")
        {
            txtDriver1.Text = "";
            txtDriver1Name.Text = "";
            lblDriver1Licno.Text = "";
            lblDriver1ValidDt.Text = "";
            hf_Manual_Driver1_Code.Value = "";
            LblDriverBalance.Text = "";
            txtDriver1NotFromRoster.Text = "";

            //lblDriver1Licno.Enabled = true;
            //lblDriver1Licno.BorderStyle = BorderStyle.Groove;
            //lblDriver1Licno.CssClass = "input";

            //lblDriver1ValidDt.Enabled = true;
            //lblDriver1ValidDt.BorderStyle = BorderStyle.Groove;
            //lblDriver1ValidDt.CssClass = "input";

            txtDriver1.Visible = false;
            txtDriver1.Enabled = false;
            txtDriver1.BorderStyle = BorderStyle.None;

            txtDriver1Name.Visible = false;
            txtDriver1Name.Enabled = false;
            txtDriver1Name.BorderStyle = BorderStyle.None;

            txtDriver1NotFromRoster.Visible = true;
            txtDriver1NotFromRoster.Enabled = true;
            txtDriver1NotFromRoster.BorderStyle = BorderStyle.Groove;

        }

    }

    protected void ddlDriver2_SelectedIndexChanged(object sender, EventArgs e)
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.Vehicle_No = txtVehno.Text.ToString().Trim();

        if (ddlDriver2.SelectedValue == "0")
        {
            txtDriver2.Text = "";
            txtDriver2Name.Text = "";
            lblDriver2Licno.Text = "";
            lblDriver2ValidDt.Text = "";
            txtDriver2NotFromRoster.Text = "";

            //lblDriver2Licno.Enabled = false;
            //lblDriver2Licno.BorderStyle = BorderStyle.None;
            //lblDriver2Licno.CssClass = "";

            //lblDriver2ValidDt.Enabled = false;
            //lblDriver2ValidDt.BorderStyle = BorderStyle.None;
            //lblDriver2ValidDt.CssClass = "";

            txtDriver2.Visible = false;
            txtDriver2.Enabled = false;
            txtDriver2.BorderStyle = BorderStyle.None;

            txtDriver2Name.Visible = false;
            txtDriver2Name.Enabled = false;
            txtDriver2Name.BorderStyle = BorderStyle.None;

            txtDriver2NotFromRoster.Visible = false;
            txtDriver2NotFromRoster.Enabled = false;
            txtDriver2NotFromRoster.BorderStyle = BorderStyle.None;
        }
        else if (ddlDriver2.SelectedValue == "Y")
        {
            txtDriver2.Text = "";
            txtDriver2Name.Text = "";
            lblDriver2Licno.Text = "";
            lblDriver2ValidDt.Text = "";
            txtDriver2NotFromRoster.Text = "";

            //lblDriver2Licno.Enabled = false;
            //lblDriver2Licno.BorderStyle = BorderStyle.None;
            //lblDriver2Licno.CssClass = "";

            //lblDriver2ValidDt.Enabled = false;
            //lblDriver2ValidDt.BorderStyle = BorderStyle.None;
            //lblDriver2ValidDt.CssClass = "";

            txtDriver2.Visible = true;
            txtDriver2.Enabled = true;
            txtDriver2.BorderStyle = BorderStyle.Groove;

            txtDriver2Name.Visible = true;
            txtDriver2Name.Enabled = true;
            txtDriver2Name.BorderStyle = BorderStyle.Groove;

            txtDriver2NotFromRoster.Visible = false;
            txtDriver2NotFromRoster.Enabled = false;
            txtDriver2NotFromRoster.BorderStyle = BorderStyle.None;
        }
        else if (ddlDriver2.SelectedValue == "N")
        {
            txtDriver2.Text = "";
            txtDriver2Name.Text = "";
            lblDriver2Licno.Text = "";
            lblDriver2ValidDt.Text = "";
            txtDriver2NotFromRoster.Text = "";

            //lblDriver2Licno.Enabled = true;
            //lblDriver2Licno.BorderStyle = BorderStyle.Groove;
            //lblDriver2Licno.CssClass = "input";

            //lblDriver2ValidDt.Enabled = true;
            //lblDriver2ValidDt.BorderStyle = BorderStyle.Groove;
            //lblDriver2ValidDt.CssClass = "input";

            txtDriver2.Visible = false;
            txtDriver2.Enabled = false;
            txtDriver2.BorderStyle = BorderStyle.None;

            txtDriver2Name.Visible = false;
            txtDriver2Name.Enabled = false;
            txtDriver2Name.BorderStyle = BorderStyle.None;

            txtDriver2NotFromRoster.Visible = true;
            txtDriver2NotFromRoster.Enabled = true;
            txtDriver2NotFromRoster.BorderStyle = BorderStyle.Groove;

        }
    }

    protected void ddlDriver3_SelectedIndexChanged(object sender, EventArgs e)
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.Vehicle_No = txtVehno.Text.ToString().Trim();

        if (ddlCleaner.SelectedValue == "0")
        {
            txtCleaner.Text = "";
            txtCleanerName.Text = "";
            lblCleanerLicno.Text = "";
            lblCleanerValidDt.Text = "";
            txtCleanerNotFromRoster.Text = "";

            lblCleanerLicno.Enabled = false;
            lblCleanerLicno.BorderStyle = BorderStyle.None;
            lblCleanerLicno.CssClass = "";

            lblCleanerValidDt.Enabled = false;
            lblCleanerValidDt.BorderStyle = BorderStyle.None;
            lblCleanerValidDt.CssClass = "";

            txtCleaner.Visible = false;
            txtCleaner.Enabled = false;
            txtCleaner.BorderStyle = BorderStyle.None;

            txtCleanerName.Visible = false;
            txtCleanerName.Enabled = false;
            txtCleanerName.BorderStyle = BorderStyle.None;

            txtCleanerNotFromRoster.Visible = false;
            txtCleanerNotFromRoster.Enabled = false;
            txtCleanerNotFromRoster.BorderStyle = BorderStyle.None;
        }
        if (ddlCleaner.SelectedValue == "Y")
        {
            txtCleaner.Text = "";
            txtCleanerName.Text = "";
            lblCleanerLicno.Text = "";
            lblCleanerValidDt.Text = "";
            txtCleanerNotFromRoster.Text = "";

            lblCleanerLicno.Enabled = false;
            lblCleanerLicno.BorderStyle = BorderStyle.None;
            lblCleanerLicno.CssClass = "";

            lblCleanerValidDt.Enabled = false;
            lblCleanerValidDt.BorderStyle = BorderStyle.None;
            lblCleanerValidDt.CssClass = "";

            txtCleaner.Visible = true;
            txtCleaner.Enabled = true;
            txtCleaner.BorderStyle = BorderStyle.Groove;

            txtCleanerName.Visible = true;
            txtCleanerName.Enabled = true;
            txtCleanerName.BorderStyle = BorderStyle.Groove;

            txtCleanerNotFromRoster.Visible = false;
            txtCleanerNotFromRoster.Enabled = false;
            txtCleanerNotFromRoster.BorderStyle = BorderStyle.None;
        }
        else if (ddlCleaner.SelectedValue == "N")
        {
            txtCleaner.Text = "";
            txtCleanerName.Text = "";
            lblCleanerLicno.Text = "";
            lblCleanerValidDt.Text = "";
            txtCleanerNotFromRoster.Text = "";

            ////lblCleanerLicno.Enabled = true;
            ////lblCleanerLicno.BorderStyle = BorderStyle.Groove;
            ////lblCleanerLicno.CssClass = "input";

            ////lblCleanerValidDt.Enabled = true;
            ////lblCleanerValidDt.BorderStyle = BorderStyle.Groove;
            ////lblCleanerValidDt.CssClass = "input";

            txtCleaner.Visible = false;
            txtCleaner.Enabled = false;
            txtCleaner.BorderStyle = BorderStyle.None;

            txtCleanerName.Visible = false;
            txtCleanerName.Enabled = false;
            txtCleanerName.BorderStyle = BorderStyle.None;

            txtCleanerNotFromRoster.Visible = true;
            txtCleanerNotFromRoster.Enabled = true;
            txtCleanerNotFromRoster.BorderStyle = BorderStyle.Groove;

        }
    }

    //protected void txtVehno_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    TripSheet objTs = new TripSheet(str_Connection_String);
    //    objTs.Vehicle_No = txtVehno.Text.ToString();
    //    if (txtVehno.Text.ToString() != "")
    //    {
    //        objTs.BindRouteDropdown(ddlRoute);
    //    }
    //    else
    //    {
    //        ddlRoute.Items.Clear();
    //        ddlRouteType.SelectedIndex = 0;
    //    }
    //    objTs.CheckTripRule();

    //    objTs.BRCD = SessionUtilities.CurrentBranchCode.ToString().Trim();
    //    objTs.Driver_Name = "";

    //    if (objTs.Driver_WO_Vehicle == "N")
    //    {
    //        //objTs.BindDriverDropdown(txtDriver1.Text, "");
    //    }
    //    //txtDriver1.Attributes.Add("OnBlur", "javascript:GetDriver1Details(this);");

    //}

    //protected void ddlRouteType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //TripSheet objTs = new TripSheet(str_Connection_String);
    //objTs.Vehicle_No = txtVehno.Text.ToString().Trim();

    //if (ddlRouteType.SelectedValue == "01" && txtVehno.Text.ToString() == "")
    //{
    //    tblTripRouteHdr.Visible = false;
    //    tblTripRouteDet.Visible = false;

    //    if (txtVehno.Text.ToString() == "")
    //    {
    //        lblRouteError.Text = "Kindly Select Vehicle";
    //        ddlRouteType.SelectedIndex = 0;
    //    }
    //}
    //if (ddlRouteType.SelectedValue == "01" && txtVehno.Text.ToString().Trim() != "")
    //{
    //    tblTripRouteHdr.Visible = true;
    //    tblTripRouteDet.Visible = true;

    //    lblRouteError.Text = "";

    //    if (txtVehno.Text.ToString() != "")
    //    {
    //        objTs.BindRouteDropdown(ddlRoute);
    //    }
    //}
    //if (ddlRouteType.SelectedValue == "02")
    //{
    //    lblRouteError.Text = "";
    //    ddlRoute.Items.Clear();
    //    tblTripRouteHdr.Visible = false;
    //    tblTripRouteDet.Visible = false;
    //}


    //    if(ddlRouteType.SelectedValue == "Open")
    //    {
    //        txtRouteType1.Visible = true;
    //        txtRouteType2.Visible = true;
    //        txtRouteType3.Visible = true;
    //        txtRouteType4.Visible = true;
    //    }
    //    else
    //    {
    //        txtRouteType1.Visible = false;
    //        txtRouteType2.Visible = false;
    //        txtRouteType3.Visible = false;
    //        txtRouteType4.Visible = false;
    //    }
    //}

    protected void chkAdvanceFlag_CheckedChanged(object sender, EventArgs e)
    {
        //if (chkAdvanceFlag.Checked == true)
        //{
        //    tblAdvanceEntry.Visible = true;
        //}
        //else
        //{
        //    tblAdvanceEntry.Visible = false;
        //}
    }

    protected void ddlFuelType_SelectedIndexChanged(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in gvFuelSlip.Rows)
        {

            DropDownList ddlFuelType = (DropDownList)gridrow.FindControl("ddlFuelType");
            DropDownList ddlFuelVendor = (DropDownList)gridrow.FindControl("ddlFuelVendor");
            TextBox txtQtyLiter = (TextBox)gridrow.FindControl("txtQtyLiter");
            TextBox txtRate = (TextBox)gridrow.FindControl("txtRate");
            TextBox txtAmount = (TextBox)gridrow.FindControl("txtAmount");
            TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");
            TextBox txtamounttotal = (TextBox)gridrow.FindControl("txtamounttotal");
            
            txtamounttotal.Enabled = false;
            if (ddlFuelType.SelectedValue == "" && ddlFuelVendor.Enabled == true)
            {
                txtQtyLiter.ReadOnly = false;
                txtRate.ReadOnly = false;
                //txtAmount.ReadOnly = true;
                //txtAmount.Enabled = false;

                txtQtyLiter.Text = "";
                txtRate.Text = "";
                txtAmount.Text = "";
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;
              
                txtIGST.Text = "";
                txtSGST.Text = "";
                txtCGST.Text = "";             

                txtQtyLiter.BorderStyle = BorderStyle.Groove;
                txtQtyLiter.CssClass = "input";
                txtRate.BorderStyle = BorderStyle.Groove;
                txtRate.CssClass = "input";
                txtAmount.BorderStyle = BorderStyle.None;
                txtAmount.CssClass = "";
                txtIGST.BorderStyle = BorderStyle.None;
                txtIGST.CssClass = "";
                txtSGST.BorderStyle = BorderStyle.None;
                txtSGST.CssClass = "";
                txtCGST.BorderStyle = BorderStyle.None;
                txtCGST.CssClass = "";
                
            }
            else if (ddlFuelType.SelectedValue == "1" && ddlFuelVendor.Enabled == true)
            {
                txtQtyLiter.ReadOnly = false;
                txtRate.ReadOnly = false;
                //txtAmount.ReadOnly = true;
                txtAmount.Enabled = false;
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;
             
                txtIGST.Text = "";
                txtSGST.Text = "";
                txtCGST.Text = "";
                //txtQtyLiter.Text = "";
                //txtRate.Text = "";
                //txtAmount.Text = "";

                txtQtyLiter.BorderStyle = BorderStyle.Groove;
                txtQtyLiter.CssClass = "input";
                txtRate.BorderStyle = BorderStyle.Groove;
                txtRate.CssClass = "input";
                txtAmount.BorderStyle = BorderStyle.None;
                txtAmount.CssClass = "";
                txtIGST.BorderStyle = BorderStyle.None;
                txtIGST.CssClass = "";
                txtSGST.BorderStyle = BorderStyle.None;
                txtSGST.CssClass = "";
                txtCGST.BorderStyle = BorderStyle.None;
                txtCGST.CssClass = "";               
            }
            else if (ddlFuelType.SelectedValue == "2" && ddlFuelVendor.Enabled == true)
            {
                txtQtyLiter.Text = "0.00";
                txtRate.Text = "0.00";
                //txtAmount.Text = "";

                txtQtyLiter.ReadOnly = true;
                txtRate.ReadOnly = true;
                //txtAmount.ReadOnly = false;
                txtAmount.Enabled = true;
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;
                
                txtIGST.Text = "";
                txtSGST.Text = "";
                txtCGST.Text = "";                

                txtQtyLiter.BorderStyle = BorderStyle.None;
                txtQtyLiter.CssClass = "";
                txtRate.BorderStyle = BorderStyle.None;
                txtRate.CssClass = "";
                txtAmount.BorderStyle = BorderStyle.Groove;
                txtAmount.CssClass = "input";
                txtIGST.BorderStyle = BorderStyle.None;
                txtIGST.CssClass = "";
                txtSGST.BorderStyle = BorderStyle.None;
                txtSGST.CssClass = "";
                txtCGST.BorderStyle = BorderStyle.None;
                txtCGST.CssClass = "";                
            }

        }

    }

    protected void Add_RowFuelSlip(object sender, EventArgs e)
    {

        if ((txtAddFuelSlipRow.Text == "") || (txtAddFuelSlipRow.Text == "0")) txtAddFuelSlipRow.Text = "0";



        _dataSet.FuelSlipEntry.Rows.Clear();

        foreach (GridViewRow row in gvFuelSlip.Rows)
        {
            DropDownList ddlFuelType = (DropDownList)row.FindControl("ddlFuelType");
            TextBox txtFuelSlipNo = (TextBox)row.FindControl("txtFuelSlipNo");
            DropDownList ddlFuelVendor = (DropDownList)row.FindControl("ddlFuelVendor");
            TextBox txtQtyLiter = (TextBox)row.FindControl("txtQtyLiter");
            TextBox txtRate = (TextBox)row.FindControl("txtRate");
            TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
            HiddenField hdSrNo = (HiddenField)row.FindControl("hdSrNo");

            DropDownList FuelTYPE = (DropDownList)row.FindControl("ddlFuelTypePD");
            TextBox FromCity = (TextBox)row.FindControl("txtFromCity");
            HiddenField FromCityCode = (HiddenField)row.FindControl("hdFromCityCode");
            TextBox txtIGST = (TextBox)row.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)row.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)row.FindControl("txtCGST");
            TextBox txtamounttotal = (TextBox)row.FindControl("txtamounttotal");

            _dataSet.FuelSlipEntry.AddFuelSlipEntryRow(ddlFuelType.Text, txtFuelSlipNo.Text, ddlFuelVendor.Text, txtQtyLiter.Text, txtRate.Text, txtAmount.Text, hdSrNo.Value, FromCity.Text, FromCityCode.Value, FuelTYPE.Text, txtIGST.Text, txtSGST.Text, txtCGST.Text, txtamounttotal.Text);

            txtIGST.Enabled = false;
            txtSGST.Enabled = false;
            txtCGST.Enabled = false;                
        }

        int count = 0;
        string rowno;
        rowno = txtAddFuelSlipRow.Text;
        int mroww = 0;

        mroww = Convert.ToInt16(rowno);

        if (mroww >= count)
        {
            int miroww = 0;
            int i;
            int iroww = 0;
            foreach (GridViewRow row in gvFuelSlip.Rows)
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
                    _dataSet.FuelSlipEntry.RemoveFuelSlipEntryRow(_dataSet.FuelSlipEntry[i]);

                }
            }
            for (i = 0 + miroww; i < Int16.Parse(txtAddFuelSlipRow.Text); i++)
            {

                _dataSet.FuelSlipEntry.AddFuelSlipEntryRow("", "", "", "", "", "", "", "", "", "","","","","");
            }
        }

        gvFuelSlip.DataSource = _dataSet.FuelSlipEntry;
        gvFuelSlip.DataBind();
    }

    protected void Add_RowAdvance(object sender, EventArgs e)
    {
        try
        {


            if ((txtAddAdvanceRow.Text == "") || (txtAddAdvanceRow.Text == "0")) txtAddAdvanceRow.Text = "0";


            _dataSet.AdvanceTakenFA.Rows.Clear();

            foreach (GridViewRow row in dgAdvanceDet.Rows)
            {
                //DropDownList ddlFuelType = (DropDownList)row.FindControl("ddlFuelType");
                TextBox txtAdvPlace = (TextBox)row.FindControl("txtAdvPlace");
                //DropDownList ddlFuelVendor = (DropDownList)row.FindControl("ddlFuelVendor");
                TextBox txtAdvDt = (TextBox)row.FindControl("txtAdvDt");
                TextBox txtAdvAmt = (TextBox)row.FindControl("txtAdvAmt");
                DropDownList ddlMode = (DropDownList)row.FindControl("ddlMode");
                DropDownList ddlAcount = (DropDownList)row.FindControl("ddlAcount");

                TextBox txtBranchCode = (TextBox)row.FindControl("txtBranchCode");
                TextBox txtSignature = (TextBox)row.FindControl("txtSignature");
                TextBox txtRefNo = (TextBox)row.FindControl("txtRefNo");


                HiddenField hdnBankAccount = (HiddenField)row.FindControl("hdnBankAccount");
                HiddenField hdnMode = (HiddenField)row.FindControl("hdnMode");

                //BindDropDownWithPerameter("Usp_TripsheetGene_Happay_List", "CodeName", "CodeID", ddlMode.SelectedItem.Value, ddlAcount);

                if (hdnBankAccount.Value == "")
                {
                    hdnBankAccount.Value = ddlAcount.SelectedValue;
                }
                if (hdnMode.Value == "")
                {
                    hdnMode.Value = ddlMode.SelectedValue;
                }


                //DropDownList FuelTYPE = (DropDownList)row.FindControl("ddlFuelTypePD");
                //TextBox FromCity = (TextBox)row.FindControl("txtFromCity");
                //HiddenField FromCityCode = (HiddenField)row.FindControl("hdFromCityCode");

                _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow(txtAdvPlace.Text, txtAdvDt.Text, txtAdvAmt.Text, "", txtBranchCode.Text, txtSignature.Text, txtRefNo.Text, ddlMode.SelectedItem.Value, hdnBankAccount.Value);

                //_dataSet.FuelSlipEntry.AddFuelSlipEntryRow(ddlFuelType.Text, txtFuelSlipNo.Text, ddlFuelVendor.Text, txtQtyLiter.Text, txtRate.Text, txtAmount.Text, hdSrNo.Value, FromCity.Text, FromCityCode.Value, FuelTYPE.Text);
            }

            int count = 0;
            string rowno;
            rowno = txtAddAdvanceRow.Text;
            int mroww = 0;

            mroww = Convert.ToInt16(rowno);

            if (mroww >= count)
            {
                int miroww = 0;
                int i;
                int iroww = 0;
                foreach (GridViewRow row in dgAdvanceDet.Rows)
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
                        //_dataSet.FuelSlipEntry.RemoveFuelSlipEntryRow(_dataSet.FuelSlipEntry[i]);
                        _dataSet.AdvanceTakenFA.RemoveAdvanceTakenFARow(_dataSet.AdvanceTakenFA[i]);

                    }
                }
                for (i = 0 + miroww; i < Int16.Parse(txtAddAdvanceRow.Text); i++)
                {
                    _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow("", "", "", "", SessionUtilities.CurrentBranchCode.ToString().Trim(), "", "", "", "");


                }
            }

            dgAdvanceDet.DataSource = _dataSet.AdvanceTakenFA;
            dgAdvanceDet.DataBind();
        }
        catch (Exception ex)
        {


        }
    }

    protected void dgAdvanceDet_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {


            DropDownList ddlAcount = (DropDownList)e.Row.FindControl("ddlAcount");
            DropDownList ddlMode = (DropDownList)e.Row.FindControl("ddlMode");
            HiddenField hdnBankAccount = (HiddenField)e.Row.FindControl("hdnBankAccount");
            HiddenField hdnMode = (HiddenField)e.Row.FindControl("hdnMode");
            TextBox txtRefNo = (TextBox)e.Row.FindControl("txtRefNo");

            if (hdnMode.Value != "")
            {
                ddlMode.SelectedValue = hdnMode.Value;

            }
            else
            {
                ddlMode.SelectedValue = "0";
            }

            BindDropDownWithPerameter("Usp_TripsheetGene_Happay_List", "CodeName", "CodeID", ddlMode.SelectedItem.Value, ddlAcount);

            if (hdnBankAccount.Value != "")
            {
                ddlAcount.SelectedValue = hdnBankAccount.Value;
            }

            if (ddlMode.SelectedValue == "1")
            {
                txtRefNo.Enabled = false;
            }

            //TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            //DropDownList ddlFuelType = (DropDownList)e.Row.FindControl("ddlFuelType");
            //if (ddlFuelType.SelectedValue != "")
            //{
            //    txtAmount.Enabled = false;
            //}
            //TextBox txtFuelSlipNo = (TextBox)e.Row.FindControl("txtFuelSlipNo");
            //DropDownList ddlFuelVendor = (DropDownList)e.Row.FindControl("ddlFuelVendor");
            //TextBox txtQtyLiter = (TextBox)e.Row.FindControl("txtQtyLiter");
            //TextBox txtRate = (TextBox)e.Row.FindControl("txtRate");

            //HiddenField hdSrNo = (HiddenField)e.Row.FindControl("hdSrNo");

            //TextBox txtFromCity = (TextBox)e.Row.FindControl("txtFromCity");
            //HiddenField hdFromCityCode = (HiddenField)e.Row.FindControl("hdFromCityCode");
            //DropDownList ddlFuelTypePD = (DropDownList)e.Row.FindControl("ddlFuelTypePD");




        }
    }
    protected void gvFuelSlip_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            DropDownList ddlFuelType = (DropDownList)e.Row.FindControl("ddlFuelType");
            if (ddlFuelType.SelectedValue != "")
            {
                txtAmount.Enabled = false;
            }
            TextBox txtFuelSlipNo = (TextBox)e.Row.FindControl("txtFuelSlipNo");
            DropDownList ddlFuelVendor = (DropDownList)e.Row.FindControl("ddlFuelVendor");
            TextBox txtQtyLiter = (TextBox)e.Row.FindControl("txtQtyLiter");
            TextBox txtRate = (TextBox)e.Row.FindControl("txtRate");
            Label lblSystemDate = (Label)e.Row.FindControl("lblSystemDate");
            HiddenField hdSrNo = (HiddenField)e.Row.FindControl("hdSrNo");

            TextBox txtFromCity = (TextBox)e.Row.FindControl("txtFromCity");
            HiddenField hdFromCityCode = (HiddenField)e.Row.FindControl("hdFromCityCode");
            DropDownList ddlFuelTypePD = (DropDownList)e.Row.FindControl("ddlFuelTypePD");
            lblSystemDate.Text = System.DateTime.Now.ToString("dd MMM yyyy");
            //BindDropDown("USP_FLEET_TRIP_FUEL_SLIP", "CodeDesc", "CodeId", ddlFuelVendor);

            TextBox txtIGST = (TextBox)e.Row.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)e.Row.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)e.Row.FindControl("txtCGST");
            TextBox txtamounttotal = (TextBox)e.Row.FindControl("txtamounttotal");
            txtamounttotal.Enabled = false;
            if (ddlFuelTypePD.SelectedValue == "4")
            {
                txtIGST.Enabled = true;
                txtSGST.Enabled = true;
                txtCGST.Enabled = true;              
            }
            else
            {
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;               
                txtIGST.Text = "";
                txtSGST.Text = "";
                txtCGST.Text = "";
                txtamounttotal.Text = "";               
            }

            TripSheet objTs = new TripSheet(str_Connection_String);
            //objTs.BindDropDown(ddlFuelType, "SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CodeType='FSM'");
            //objTs.BindDropDown(ddlFuelVendor, "SELECT HDR.VENDORCODE as CodeId,( HDR.VENDORNAME +' + '+ HDR.VENDORCODE) AS CodeDesc FROM webx_VENDOR_HDR HDR Inner JOIN webx_VENDOR_Det Det On HDR.VENDORCODE=Det.VENDORCODE AND HDR.Vendor_Type='12' AND DET.VENDORBRCD LIKE '%" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "%'");


            objTs.BindDropDown(ddlFuelVendor, "SELECT HDR.VENDORCODE as CodeId,( HDR.VENDORNAME+' : '+ DET.VendorCity +' : '+ HDR.VENDORCODE ) AS CodeDesc FROM webx_VENDOR_HDR HDR Inner JOIN webx_VENDOR_Det Det On HDR.VENDORCODE=Det.VENDORCODE AND HDR.Vendor_Type='12' AND DET.VENDORBRCD LIKE '%" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "%'");

            //objTs.BindDropDown(ddlFuelTypePD, "SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CodeType='FUELTY'"); 
            txtQtyLiter.Attributes.Add("OnBlur", "javascript:CalculateBalance_FuelSlip(" + e.Row.RowIndex + ");");
            txtAmount.Attributes.Add("OnBlur", "javascript:CalculateBalance_FuelSlip(" + e.Row.RowIndex + ");");
            txtRate.Attributes.Add("OnBlur", "javascript:CalculateBalance_FuelSlip(" + e.Row.RowIndex + ");");
            txtFuelSlipNo.Attributes.Add("OnBlur", "javascript:CheckFuelSlipNo(" + e.Row.RowIndex + "," + txtFuelSlipNo.ClientID.ToString() + "," + hdSrNo.ClientID.ToString() + ")");
            txtIGST.Attributes.Add("OnBlur", "javascript:CalculateTotalAmount(" + e.Row.RowIndex + ");");
            txtSGST.Attributes.Add("OnBlur", "javascript:CalculateTotalAmount(" + e.Row.RowIndex + ");");
            txtCGST.Attributes.Add("OnBlur", "javascript:CalculateTotalAmount(" + e.Row.RowIndex + ");");


            //txtFromCity.Attributes.Add("OnBlur", "javascript:return CheckFromValidCityNEM( " + txtFromCity.ClientID.ToString().Trim() + ", " + hdFromCityCode.ClientID.ToString().Trim() + ", " + ddlFuelTypePD.ClientID.ToString().Trim() + ", " + txtRate.ClientID.ToString().Trim() + ", " + ddlFuelVendor.ClientID.ToString().Trim() + ")");
            //ddlFuelTypePD.Attributes.Add("onchange", "javascript:return CheckFromValidCityNEM( " + txtFromCity.ClientID.ToString().Trim() + ", " + hdFromCityCode.ClientID.ToString().Trim() + ", " + ddlFuelTypePD.ClientID.ToString().Trim() + ", " + txtRate.ClientID.ToString().Trim() + ", " + ddlFuelVendor.ClientID.ToString().Trim() + ");javascript:CalculateBalance_FuelSlip(" + e.Row.RowIndex + ");");
            //ddlFuelVendor.Attributes.Add("onchange", "javascript:return CheckFromValidCityNEM( " + txtFromCity.ClientID.ToString().Trim() + ", " + hdFromCityCode.ClientID.ToString().Trim() + ", " + ddlFuelTypePD.ClientID.ToString().Trim() + ", " + txtRate.ClientID.ToString().Trim() + ", " + ddlFuelVendor.ClientID.ToString().Trim() + ");javascript:CalculateBalance_FuelSlip(" + e.Row.RowIndex + ");");


            if (_dataSet.FuelSlipEntry.Count > 0)
            {
                ddlFuelVendor.SelectedValue = _dataSet.FuelSlipEntry[e.Row.RowIndex]["FuelVendor"].ToString().Trim();
            }
            if (_dataSet.FuelSlipEntry.Count > 0)
            {
                ddlFuelType.SelectedValue = _dataSet.FuelSlipEntry[e.Row.RowIndex]["SLIPTYPE"].ToString().Trim();
            }
            if (_dataSet.FuelSlipEntry.Count > 0)
            {
                ddlFuelTypePD.SelectedValue = _dataSet.FuelSlipEntry[e.Row.RowIndex]["FuelTypePD"].ToString().Trim();
            }
        }
    }


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
    public void BindGrid()
    {
        dgAdvanceDet.DataSource = _dataSet.AdvanceTakenFA;
        dgAdvanceDet.DataBind();
        //_lastEditedPage = dgAdvanceDet.CurrentPageIndex;
    }
    public void Inetialized_AdvanceTaken()
    {
        //string mBranchCode = SessionUtilities.CurrentBranchCode.ToString().Trijava();
        _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow("", "", "", "", SessionUtilities.CurrentBranchCode.ToString().Trim(), "", "", "", "");
    }


    public void CheckTripsheetDate(DateTime TripsheetDate, string VehicleNo)
    {

        SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
        string sql = "USP_TripsheetGeneration_DateValidation";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehicleNo;
        cmd.Parameters.Add("@NewTripsheetDate", SqlDbType.DateTime).Value = TripsheetDate;
        conn.Open();
        SqlDataReader dataRead = cmd.ExecuteReader();
        while (dataRead.Read())
        {
            lbl_Manual_TS_Err.Text = dataRead[0].ToString();
        }
        dataRead.Close();
        conn.Close();

    }
    protected void SubmitData(object sender, EventArgs e)
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        System.Globalization.DateTimeFormatInfo year = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        //year.ShortDatePattern = "dd/MM/yy";

        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(str_Connection_String));
        DateTime mServerDt = DateTime.Now;
        DateTime mIssueDt = new DateTime();
        txtDate.Enabled = true;
        //mIssueDt = Convert.ToDateTime(txtDate.Text.ToString(), dtfi);
		
		
		string TripDateTimestr = txtDate.Text + " " + TimeSelector1.Hour + ":" + TimeSelector1.Minute + " " + TimeSelector1.AmPm;
		mIssueDt = Convert.ToDateTime(TripDateTimestr, dtfi);
		
        SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());

        CheckTripsheetDate(mIssueDt, txtVehno.Text);
        if (txtVehOpnKM.Text.Trim() == "")
        {
            lbl_Manual_TS_Err.Text = "Invalid TripStart KM !!";
        }
        if (txtVehOpnKM.Text.Trim() != "" && lbl_Manual_TS_Err.Text == "")
        {
            if (Convert.ToDecimal(txtVehOpnKM.Text.Trim()) == 0) {
                lbl_Manual_TS_Err.Text = "TripStart KM Can Not be Zero !!";
            }
        }

        if (lbl_Manual_TS_Err.Text == "")
        {
            string mDocuementNo = "", mCheck = "";
            string sql = "";
            string strDocketNos = "";
            //for (int i = 0; i < chklstDockets.Items.Count; i++)
            //{
            //    if (chklstDockets.Items[i].Selected == true)
            //    {
            //        strDocketNos = strDocketNos + chklstDockets.Items[i].Value.Trim() + ",";
            //    }
            //}

            bool success = false;
            bool incomplete = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {
                string msql = "usp_CheckTS";
                SqlCommand msqlcmd1 = new SqlCommand(msql, conn, trans);
                msqlcmd1.CommandType = CommandType.StoredProcedure;
                // sqlcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "ISSUE";
                //  msqlcmd1.Parameters.Add("@Vehicle_Valid", SqlDbType.VarChar).Value ="";
                msqlcmd1.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "TS";
                SqlDataReader mr1 = msqlcmd1.ExecuteReader();
                if (mr1.Read())
                {
                    mCheck = mr1[0].ToString().Trim();
                }
                mr1.Close();

                if (mCheck == "TS")
                {
                    string YearVal = "";

                    YearVal = objFinYear.FinancialYear();


                    string mSTR = "WebX_SP_GetNextDocumentCode";
                    SqlCommand mcmd1 = new SqlCommand(mSTR, conn, trans);
                    mcmd1.CommandType = CommandType.StoredProcedure;
                    //   mcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "TS";
                    //  mcmd1.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();

                    //mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
		    mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = txtStartLoc.Text.ToString().Trim();
                    //mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = "AAAA";
                    mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();

                    mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = "TS";

                    SqlDataReader rTS = mcmd1.ExecuteReader();
                    if (rTS.Read())
                    {
                        mDocuementNo = rTS[0].ToString().Trim();
                    }
                    rTS.Close();
                }
                else
                {
                    sql = "usp_GetDocumentNo";
                    SqlCommand sqlcmd1 = new SqlCommand(sql, conn, trans);
                    sqlcmd1.CommandType = CommandType.StoredProcedure;
                    sqlcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "ISSUE";
                    //sqlcmd1.Parameters.Add("@BRCD", SqlDbType.VarChar).Value =SessionUtilities.CurrentBranchCode.ToString().Trim();

                    SqlDataReader r1 = sqlcmd1.ExecuteReader();
                    if (r1.Read())
                    {
                        mDocuementNo = r1[0].ToString();
                    }
                    r1.Close();

                }

                string strAttachedDriverID1 = "";
                string strAttachedDriverID2 = "";
                string strAttachedCleaner = "";

                if (txtDriver1NotFromRoster.Text != "" && txtDriver1.Text.ToString().Trim() == "")
                {
                    SqlCommand cmdInsDriver = new SqlCommand("Usp_Insert_New_Webx_Fleet_Drivermst_Attached", conn, trans);
                    cmdInsDriver.CommandType = CommandType.StoredProcedure;

                    cmdInsDriver.Parameters.Add("@Driver_Id", SqlDbType.Int).Value = 0;
                    cmdInsDriver.Parameters.Add("@Driver_Name", SqlDbType.VarChar).Value = txtDriver1NotFromRoster.Text.Trim();
                    cmdInsDriver.Parameters.Add("@License_No", SqlDbType.VarChar).Value = lblDriver1Licno.Text.Trim();
                    //cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(lblDriver1ValidDt.Text);
                    cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(System.DateTime.Now.ToString("dd/MM/yyyy"));
                    cmdInsDriver.Parameters.Add("@Manual_Driver_Code", SqlDbType.VarChar).Value = "";
                    cmdInsDriver.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    cmdInsDriver.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                    cmdInsDriver.Parameters.Add("@Driver_Type_Id", SqlDbType.VarChar).Value = "01";
                    cmdInsDriver.Parameters[0].Direction = System.Data.ParameterDirection.Output;
                    cmdInsDriver.ExecuteNonQuery();
                    strAttachedDriverID1 = cmdInsDriver.Parameters["@Driver_Id"].Value.ToString();
                }
                if (txtDriver2NotFromRoster.Text != "" && txtDriver2.Text.ToString().Trim() == "")
                {
                    SqlCommand cmdInsDriver = new SqlCommand("Usp_Insert_New_Webx_Fleet_Drivermst_Attached", conn, trans);
                    cmdInsDriver.CommandType = CommandType.StoredProcedure;
                    cmdInsDriver.Parameters.Add("@Driver_Id", SqlDbType.Int).Value = 0;
                    cmdInsDriver.Parameters.Add("@Driver_Name", SqlDbType.VarChar).Value = txtDriver2NotFromRoster.Text.Trim();
                    cmdInsDriver.Parameters.Add("@License_No", SqlDbType.VarChar).Value = lblDriver2Licno.Text.Trim();
                    //cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(lblDriver2ValidDt.Text);
                    cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(System.DateTime.Now.ToString("dd/MM/yyyy"));

                    cmdInsDriver.Parameters.Add("@Manual_Driver_Code", SqlDbType.VarChar).Value = "";
                    cmdInsDriver.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    cmdInsDriver.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                    cmdInsDriver.Parameters.Add("@Driver_Type_Id", SqlDbType.VarChar).Value = "01";
                    cmdInsDriver.Parameters[0].Direction = System.Data.ParameterDirection.Output;
                    cmdInsDriver.ExecuteNonQuery();
                    strAttachedDriverID2 = cmdInsDriver.Parameters["@Driver_Id"].Value.ToString();
                }
                if (txtCleanerNotFromRoster.Text != "" && txtCleaner.Text.ToString().Trim() == "")
                {
                    SqlCommand cmdInsDriver = new SqlCommand("Usp_Insert_New_Webx_Fleet_Drivermst_Attached_Cleaner", conn, trans);
                    cmdInsDriver.CommandType = CommandType.StoredProcedure;
                    cmdInsDriver.Parameters.Add("@Driver_Id", SqlDbType.Int).Value = 0;
                    cmdInsDriver.Parameters.Add("@Driver_Name", SqlDbType.VarChar).Value = txtCleanerNotFromRoster.Text.Trim();
                    //cmdInsDriver.Parameters.Add("@License_No", SqlDbType.VarChar).Value = lblCleanerLicno.Text.Trim();
                    //cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(lblCleanerValidDt.Text);
                    cmdInsDriver.Parameters.Add("@Manual_Driver_Code", SqlDbType.VarChar).Value = "";
                    cmdInsDriver.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    cmdInsDriver.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                    cmdInsDriver.Parameters.Add("@Driver_Type_Id", SqlDbType.VarChar).Value = "02";
                    cmdInsDriver.Parameters[0].Direction = System.Data.ParameterDirection.Output;
                    cmdInsDriver.ExecuteNonQuery();
                    strAttachedCleaner = cmdInsDriver.Parameters["@Driver_Id"].Value.ToString();
                }

                string strTripDateTime = txtDate.Text + " " + TimeSelector1.Hour + ":" + TimeSelector1.Minute + " " + TimeSelector1.AmPm;

                SqlCommand cmd = new SqlCommand("Usp_Insert_Webx_Fleet_AddVehicleIssue_FA", conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = mDocuementNo;
                cmd.Parameters.Add("@VSlipDt", SqlDbType.DateTime).Value = Convert.ToDateTime(strTripDateTime.ToString().Trim(), dtfi);
                if (txtVehno.Text != "")
                {
                    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehno.Text.ToString();
                }
                //else if (cboVehno.SelectedIndex != 0)
                //{
                //    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = cboVehno.SelectedItem.Value;
                //}
                //else
                //{
                //    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = tb_Vehicle_Name.Text;
                //}
                if (ddlDriver1.SelectedValue == "Y")
                {
                    cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = txtDriver1.Text.ToString().Trim();
                }
                else
                {
                    cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = "0";
                }
                if (ddlDriver2.SelectedValue == "Y")
                {
                    cmd.Parameters.Add("@Driver2", SqlDbType.VarChar).Value = txtDriver2.Text.ToString().Trim();
                }
                else
                {
                    cmd.Parameters.Add("@Driver2", SqlDbType.VarChar).Value = "0";
                }

                cmd.Parameters.Add("@VehiclePath", SqlDbType.VarChar).Value = "-";

                if (txtVehOpnKM.Text == "")
                {
                    txtVehOpnKM.Text = "0.00";
                }

                cmd.Parameters.Add("@f_issue_startkm", SqlDbType.VarChar).Value = txtVehOpnKM.Text.ToString().Trim();
                cmd.Parameters.Add("@f_issue_fill", SqlDbType.VarChar).Value = "0.0";
                if (hfAutoManualTsStatus.Value == "Yes")
                {
                    cmd.Parameters.Add("@Manual_TripSheetNo", SqlDbType.VarChar).Value = mDocuementNo;
                }
                else if (hfAutoManualTsStatus.Value == "No")
                {
                    cmd.Parameters.Add("@Manual_TripSheetNo", SqlDbType.VarChar).Value = txtManualTripSheetNo.Text.ToString().Trim();
                }
                cmd.Parameters.Add("@StartLoc", SqlDbType.VarChar).Value = txtStartLoc.Text.ToString().Trim();
                cmd.Parameters.Add("@EndLoc", SqlDbType.VarChar).Value = txtEndLoc.Text.ToString().Trim();

                // New  change

                cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@CustCode", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@M_Own", SqlDbType.VarChar).Value = "";


                cmd.Parameters.Add("@From_City", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@To_City", SqlDbType.VarChar).Value = "";
                //string mRouteStr = txtFromCity.Text.ToString() + " - " + txtToCity.Text.ToString() + " - " + txtFromCity.Text.ToString();
                cmd.Parameters.Add("@Route", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@rut_code", SqlDbType.VarChar).Value = ddlRoute.SelectedValue;

                if (hfAttached.Value == "Y")
                {
                    cmd.Parameters.Add("@THC_Attached_YN", SqlDbType.VarChar).Value = "Y";
                }
                else
                {
                    cmd.Parameters.Add("@THC_Attached_YN", SqlDbType.VarChar).Value = "N";
                }

                cmd.Parameters.Add("@Revenue_Capture", SqlDbType.Float).Value = Convert.ToDouble("0".ToString());

                cmd.Parameters.Add("@Transit_Time", SqlDbType.VarChar, 10).Value = "";
                cmd.Parameters.Add("@UFL_Weight", SqlDbType.Float).Value = Convert.ToDouble("0".ToString());
                cmd.Parameters.Add("@AFL_Weight", SqlDbType.Float).Value = Convert.ToDouble("0".ToString());
                cmd.Parameters.Add("@Total_Weight", SqlDbType.Float).Value = Convert.ToDouble("0".ToString());
                cmd.Parameters.Add("@Driver1OpBal", SqlDbType.VarChar).Value = LblDriverBalance.Text.ToString();
                cmd.Parameters.Add("@Entryby", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                cmd.Parameters.Add("@ExternalUsage_Category", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10

                cmd.Parameters.Add("@Vehicle_Mode", SqlDbType.VarChar).Value = "";//Vendor Type  

                cmd.Parameters.Add("@Driver1_Name", SqlDbType.VarChar).Value = strAttachedDriverID1.Trim();
                cmd.Parameters.Add("@Driver2_Name", SqlDbType.VarChar).Value = strAttachedDriverID2.Trim();

                cmd.Parameters.Add("@DOCKNO", SqlDbType.VarChar).Value = (strDocketNos != "") ? strDocketNos.Trim().Substring(0, strDocketNos.Length - 1) : strDocketNos;
                //cmd.Parameters.Add("@Vehicle_Name", SqlDbType.VarChar).Value = tb_Vehicle_Name.Text.ToUpper(); 

                if (ddlCleaner.SelectedValue == "Y")
                {
                    cmd.Parameters.Add("@Driver_Assistant_Id", SqlDbType.VarChar).Value = txtCleaner.Text.ToString().Trim();
                }
                else
                {
                    cmd.Parameters.Add("@Driver_Assistant_Id", SqlDbType.VarChar).Value = "0";
                }

                cmd.Parameters.Add("@Driver_Assistant_Name", SqlDbType.VarChar).Value = strAttachedCleaner.Trim();

                cmd.Parameters.Add("@Trip_Route_Type", SqlDbType.VarChar).Value = ddlRouteType.SelectedValue.ToString();

                string strRouteName;
                strRouteName = ddlRouteName.SelectedValue.ToString();
                if (strRouteName == "--Select--")
                {
                    strRouteName = "";
                }

                cmd.Parameters.Add("@Fixed_RouteName", SqlDbType.VarChar).Value = strRouteName;
                cmd.Parameters.Add("@Opn_Route1", SqlDbType.VarChar).Value = txtRouteType1.Text;
                cmd.Parameters.Add("@Opn_Route2", SqlDbType.VarChar).Value = txtRouteType2.Text;
                cmd.Parameters.Add("@Opn_Route3", SqlDbType.VarChar).Value = txtRouteType3.Text;
                cmd.Parameters.Add("@Opn_Route4", SqlDbType.VarChar).Value = txtRouteType4.Text;



                if (chkbxAdvacneDetails.Checked == true)
                {
                    cmd.Parameters.Add("@Trip_Adv_Det_Flag", SqlDbType.VarChar).Value = "Y";
                }
                else
                {
                    cmd.Parameters.Add("@Trip_Adv_Det_Flag", SqlDbType.VarChar).Value = "N";
                }

                if (ddlDriver1.SelectedValue != "0")
                {
                    cmd.Parameters.Add("@Driver1_Roster_YN", SqlDbType.VarChar).Value = ddlDriver1.SelectedValue.ToString();
                }
                if (ddlDriver2.SelectedValue != "0")
                {
                    cmd.Parameters.Add("@Driver2_Roster_YN", SqlDbType.VarChar).Value = ddlDriver2.SelectedValue.ToString();
                }
                if (ddlCleaner.SelectedValue != "0")
                {
                    cmd.Parameters.Add("@Cleaner_Roster_YN", SqlDbType.VarChar).Value = ddlCleaner.SelectedValue.ToString();
                }

                if (hdndieselCF.Value == "Y")
                {
                    cmd.Parameters.Add("@DIESEL_QTY_CF", SqlDbType.Float).Value = Convert.ToDouble(txtDieselCarryForward.Text.ToString());
                    cmd.Parameters.Add("@DIESEL_AMT_CF", SqlDbType.Float).Value = Convert.ToDouble(txtDieselCarryForwardAmt.Text.ToString());
                }
                else
                {
                    cmd.Parameters.Add("@DIESEL_QTY_CF", SqlDbType.Float).Value = "0";
                    cmd.Parameters.Add("@DIESEL_AMT_CF", SqlDbType.Float).Value = "0";
                }

                cmd.Parameters.Add("@Licno1", SqlDbType.VarChar).Value = lblDriver1Licno.Text.ToString().Trim();

                //cmd.Parameters.Add("@Validdt1", SqlDbType.VarChar).Value = lblDriver1ValidDt.Text.ToString().Trim();
                if (lblDriver1ValidDt.Text.ToString().Trim() != "")
                    cmd.Parameters.Add("@Validdt1", SqlDbType.DateTime).Value = Convert.ToDateTime(lblDriver1ValidDt.Text.ToString().Trim(), dtfi);
                else
                    cmd.Parameters.Add("@Validdt1", SqlDbType.DateTime).Value = "01 Jan 1990";
                cmd.Parameters.Add("@Licno2", SqlDbType.VarChar).Value = lblDriver2Licno.Text.ToString().Trim();
                //cmd.Parameters.Add("@Validdt2", SqlDbType.VarChar).Value = lblDriver2ValidDt.Text.ToString().Trim();
                if (lblDriver2ValidDt.Text.ToString().Trim() != "")
                    cmd.Parameters.Add("@Validdt2", SqlDbType.DateTime).Value = Convert.ToDateTime(lblDriver2ValidDt.Text.ToString().Trim(), dtfi);
                else
                    cmd.Parameters.Add("@Validdt2", SqlDbType.DateTime).Value = "01 Jan 1990";

                if (chkbxFuelSlipEntry.Checked == true)
                {
                    cmd.Parameters.Add("@FUEL_SLIP_FLAG", SqlDbType.VarChar).Value = "Y";
                }
                else
                {
                    cmd.Parameters.Add("@FUEL_SLIP_FLAG", SqlDbType.VarChar).Value = "N";
                }

                cmd.Parameters.Add("@TripBillingType", SqlDbType.VarChar).Value = ddlTripBIllingSelection.SelectedValue.ToString();
                cmd.Parameters.Add("@TripBillingWise", SqlDbType.VarChar).Value = txtCustomer.Text.ToString();
                //Added by ritesh singh on 07 feb 2017 for tripsheet hold::@HoldFlag
                //if (txtHoldFlag.Text=="Y")
                //{
                cmd.Parameters.Add("@HoldFlag", SqlDbType.VarChar).Value = txtHoldFlag.Text.ToString();
                //}

                cmd.ExecuteNonQuery();


                #region CHECKLIST

                SqlCommand cmdCheckList = new SqlCommand("USP_FLEET_INSERT_CHECKLIST_HDR", conn, trans);
                cmdCheckList.CommandType = CommandType.StoredProcedure;
                cmdCheckList.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = mDocuementNo;
                cmdCheckList.Parameters.Add("@Checked_By", SqlDbType.VarChar).Value = txtCheckedBy.Text.ToString();
                cmdCheckList.Parameters.Add("@Checked_Dt", SqlDbType.VarChar).Value = txtCheckedDate.Text.ToString();
                cmdCheckList.Parameters.Add("@Approved_By", SqlDbType.VarChar).Value = txtApprovedBy.Text.ToString();
                cmdCheckList.Parameters.Add("@Approved_Dt", SqlDbType.VarChar).Value = txtApprovedDate.Text.ToString();
                cmdCheckList.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                cmdCheckList.Parameters.Add("@Company_Code", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim();
                cmdCheckList.ExecuteNonQuery();

                foreach (GridViewRow gridrow in gvChecklist.Rows)
                {
                    CheckBox chkBx = (CheckBox)gridrow.FindControl("chkSelect");
                    HiddenField Category_ID = (HiddenField)gridrow.FindControl("Category_ID");
                    HiddenField CheckList_ID = (HiddenField)gridrow.FindControl("CheckList_ID");

                    if (chkBx != null && chkBx.Checked)
                    {
                        SqlCommand sql_insert = new SqlCommand("USP_FLEET_INSERT_CHECKLIST_DETAIL", conn, trans);
                        sql_insert.CommandType = CommandType.StoredProcedure;

                        sql_insert.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = mDocuementNo;
                        sql_insert.Parameters.Add("@Chk_Cat", SqlDbType.VarChar).Value = Category_ID.Value.ToString();
                        sql_insert.Parameters.Add("@Chk_ID", SqlDbType.VarChar).Value = CheckList_ID.Value.ToString();
                        sql_insert.Parameters.Add("@Chk_Comments", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtComments")).Text.ToString();
                        sql_insert.ExecuteNonQuery();
                    }

                }

                #endregion

                string mAdvAmt = "";
                SqlCommand cmdDEL = new SqlCommand();
                string sqlDEL = "";
                sqlDEL = "Delete from WEBX_TRIPSHEET_ADVEXP where TripSheetNo='" + mDocuementNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();
                string mBranchCode = "";

                //AP
                if (chkbxAdvacneDetails.Checked == true)
                {
                    foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
                    {
                        //string mAdvPlace = ((DropDownList)gridrow.FindControl("cboAdvPlace")).SelectedItem.Value;
                        string mAdvPlace = ((TextBox)gridrow.FindControl("txtAdvPlace")).Text;

                        DateTime mAdvDt = new DateTime();
                        string Advance_Date = "";

                        if (((TextBox)gridrow.FindControl("txtAdvDt")).Text != "")
                        {
                            mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);

                            Advance_Date = ((TextBox)gridrow.FindControl("txtAdvDt")).Text.ToString();
                        }
                        mAdvAmt = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;

                        //mTotAdvExp = mTotAdvExp + Convert.ToDouble(mAdvAmt);

                        // string mTHCno = ((TextBox)gridrow.FindControl("txtTHCno")).Text;
                        mBranchCode = ((TextBox)gridrow.FindControl("txtBranchCode")).Text;
                        string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;

                        DropDownList ddlAcount = (DropDownList)gridrow.FindControl("ddlAcount");
                        DropDownList ddlMode = (DropDownList)gridrow.FindControl("ddlMode");
                        HiddenField hdnBankAccount = (HiddenField)gridrow.FindControl("hdnBankAccount");
                        HiddenField hdnMode = (HiddenField)gridrow.FindControl("hdnMode");
                        TextBox txtRefNo = (TextBox)gridrow.FindControl("txtRefNo");


                        //UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
                        //DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
                        //DropDownList dlstAcccode = (DropDownList)paymen.FindControl("dlstAcccode");

                        //TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                        //TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
                        //TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");

                        //string madv_Transtype = dlsttranstype.SelectedItem.Value;
                        //if (madv_Transtype == "" || madv_Transtype == null)
                        //{
                        //    madv_Transtype = "NULL";
                        //}
                        //else
                        //{
                        //    madv_Transtype = "'" + madv_Transtype + "'";
                        //}


                        //string madv_Chqno = txtChqNo.Text;
                        //if (madv_Chqno == "" || madv_Chqno == null)
                        //{
                        //    madv_Chqno = "NULL";
                        //}
                        //else
                        //{
                        //    madv_Chqno = "'" + madv_Chqno + "'";
                        //}

                        //string madv_Chqdate = txtChqDate.Text;
                        //if (madv_Chqdate == "" || madv_Chqdate == null)
                        //{
                        //    madv_Chqdate = "NULL";
                        //}
                        //else
                        //{
                        //    madv_Chqdate = "'" + madv_Chqdate + "'";
                        //}

                        //string madv_acccode = dlstAcccode.SelectedItem.Value;
                        //if (madv_acccode == "" || madv_acccode == null)
                        //{
                        //    madv_acccode = "NULL";
                        //}
                        //else
                        //{
                        //    madv_acccode = "'" + madv_acccode + "'";
                        //}


                        string mEntryby = "'" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "'";

                        if (mAdvAmt != "" && mAdvAmt != null)
                        {

                            //sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature,adv_Transtype,adv_Chqno,adv_Chqdate,adv_acccode,Entryby,COMPANY_CODE) values ("
                            //     + "'" + mDocuementNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "'," + madv_Transtype + "," + madv_Chqno + "," + madv_Chqdate + "," + madv_acccode + "," + mEntryby + ",'" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "') ";

                            //mBranchCode.Split('~')[1]mAdvPlace.Split(':')[0] 
                            //sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature,adv_Transtype,adv_Chqno,adv_Chqdate,adv_acccode,Entryby,COMPANY_CODE) values ("
                            //     + "'" + mDocuementNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "','" + ddlMode.SelectedItem.Text + "','" + txtRefNo.Text.Trim() + "',CAST('" + mAdvDt + "' AS DATE),'" + ddlAcount.Text + "'," + mEntryby + ",'" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "') ";
                            sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature,adv_Transtype,adv_Chqno,adv_Chqdate,adv_acccode,Entryby,COMPANY_CODE) values ("
                                 + "'" + mDocuementNo + "','" + mAdvPlace + "',CAST( '" + mAdvDt + "' AS DATE),'" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "','" + ddlMode.SelectedItem.Text + "','" + txtRefNo.Text.Trim() + "', CONVERT(VARCHAR(20),CAST('" + mAdvDt + "' AS DATE) ,103),'" + ddlAcount.Text + "'," + mEntryby + ",'" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "') ";



                            SqlCommand AdvDetail = new SqlCommand(sql, conn, trans);
                            AdvDetail.CommandType = CommandType.Text;

                            //datarow_Adv = _dataSet.AdvanceTaken[gridrow.DataSetIndex];

                            //_dataSet.AdvanceTaken[gridrow.DataSetIndex].ItemArray = datarow_Adv.ItemArray;

                            AdvDetail.ExecuteNonQuery();
                        }



                        string Cnt = "";

                        //if (dlsttranstype.SelectedValue == "CASH" || dlsttranstype.SelectedValue == "Both")
                        //{
                        //    Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(mAdvAmt.ToString()), fn.Mydate1(Advance_Date.ToString()));
                        //    if (Cnt == "F")
                        //    {
                        //        incomplete = true;
                        //        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                        //        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Advance Payment" + "&ErrorMsg=" + ErrorMsg);
                        //        trans.Rollback();
                        //        Response.End();
                        //    }
                        //}

                    }

                    double advamt = 0;
                    foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
                    {
                        //string mAdvPlace = ((DropDownList)gridrow.FindControl("cboAdvPlace")).SelectedItem.Value;

                        advamt += Convert.ToDouble(((TextBox)gridrow.FindControl("txtAdvAmt")).Text);
                    }


                    if (advamt != 0)
                    {
                        sql = " Update WEBX_FLEET_VEHICLE_ISSUE set TotAdvExp='" + Convert.ToString(advamt) + "' Where VSlipNo ='" + mDocuementNo + "' ";
                        SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
                        TripHeader.CommandType = CommandType.Text;
                        TripHeader.ExecuteNonQuery();
                    }
                }



                //////////////////////////////

                if (chkbxFuelSlipEntry.Checked == true)
                {
                    foreach (GridViewRow gridrow in gvFuelSlip.Rows)
                    {
                        TextBox txtFuelSlipNo = (TextBox)gridrow.FindControl("txtFuelSlipNo");
                        DropDownList ddlFuelVendor = (DropDownList)gridrow.FindControl("ddlFuelVendor");
                        TextBox txtQtyLiter = (TextBox)gridrow.FindControl("txtQtyLiter");
                        TextBox txtRate = (TextBox)gridrow.FindControl("txtRate");
                        TextBox txtAmount = (TextBox)gridrow.FindControl("txtAmount");

                        TextBox txtFromCity = (TextBox)gridrow.FindControl("txtFromCity");
                        HiddenField hdFromCityCode = (HiddenField)gridrow.FindControl("hdFromCityCode");
                        DropDownList ddlFuelTypePD = (DropDownList)gridrow.FindControl("ddlFuelTypePD");
                        DropDownList ddlFuelType = (DropDownList)gridrow.FindControl("ddlFuelType");

                        TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
                        TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
                        TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");
                        TextBox txtamounttotal = (TextBox)gridrow.FindControl("txtamounttotal");

                        if (txtQtyLiter.Text == "") { txtQtyLiter.Text = "0.00"; }
                        if (txtRate.Text == "") { txtRate.Text = "0.00"; }
                        if (txtAmount.Text == "") { txtAmount.Text = "0.00"; }
                        if (txtIGST.Text == "") { txtIGST.Text = "0.00"; }
                        if (txtSGST.Text == "") { txtSGST.Text = "0.00"; }
                        if (txtCGST.Text == "") { txtCGST.Text = "0.00"; }
                        if (txtamounttotal.Text == "") { txtamounttotal.Text = "0.00"; }

                        string mFinYearfuel = "";
                        mFinYearfuel = SessionUtilities.FinYear.ToString().Trim();
                        string mYearValfuel = "";
                        GetFinancialYear objFinYear123 = new GetFinancialYear(Convert.ToString(str_Connection_String));
                        mYearValfuel = objFinYear123.FinancialYear();

                        SqlCommand cmdFuelSlip = new SqlCommand("USP_FLEET_INSERT_FUELSLIP_DETAILS_NEW", conn, trans);
                        cmdFuelSlip.CommandType = CommandType.StoredProcedure;
                        cmdFuelSlip.Parameters.Add("@Tripsheetno", SqlDbType.VarChar).Value = mDocuementNo;
                        cmdFuelSlip.Parameters.Add("@FuelSlipNo", SqlDbType.VarChar).Value = txtFuelSlipNo.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@FuelVendor", SqlDbType.VarChar).Value = ddlFuelVendor.SelectedValue.ToString();
                        cmdFuelSlip.Parameters.Add("@QuantityLiter", SqlDbType.Float).Value = txtQtyLiter.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@Rate", SqlDbType.Float).Value = txtRate.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@Amount", SqlDbType.Float).Value = txtAmount.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                        cmdFuelSlip.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.Trim();
                        //cmdFuelSlip.Parameters.Add("@VehNo", SqlDbType.VarChar).Value = lblVehno.Text.ToString();

                        if (txtVehno.Text != "")
                        {
                            cmdFuelSlip.Parameters.Add("@VehNo", SqlDbType.VarChar).Value = txtVehno.Text.ToString();
                        }
                        else
                        {
                            cmdFuelSlip.Parameters.Add("@VehNo", SqlDbType.VarChar).Value = txtVehno.Text.ToString();
                        }

                        cmdFuelSlip.Parameters.Add("@FuelType", SqlDbType.VarChar).Value = ddlFuelType.SelectedValue.ToString();
                        cmdFuelSlip.Parameters.Add("@CompanyCode", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString();
                        cmdFuelSlip.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYearfuel;
                        cmdFuelSlip.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearValfuel;
                        cmdFuelSlip.Parameters.Add("@FromCity", SqlDbType.VarChar).Value = hdFromCityCode.Value.ToString();
                        cmdFuelSlip.Parameters.Add("@FuelTypePD", SqlDbType.VarChar).Value = ddlFuelTypePD.SelectedValue.ToString();
                        cmdFuelSlip.Parameters.Add("@IGST", SqlDbType.Float).Value = txtIGST.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@SGST", SqlDbType.Float).Value = txtSGST.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@CGST", SqlDbType.Float).Value = txtCGST.Text.ToString();
                        cmdFuelSlip.Parameters.Add("@TotalAmount", SqlDbType.Float).Value = txtamounttotal.Text.ToString();
                        cmdFuelSlip.ExecuteNonQuery();
                    }
                }

                //////////////////////////////

                #region ATTCHAED_CNOTE_WITH_TRIPSHEET

                //TripSheet objTs = new TripSheet(str_Connection_String);

                //objTs.CheckTripRule();

                //if (objTs.DOCKET_WITH_TRIPSHEET == "Y")
                //{

                //    foreach (GridViewRow gridrow in gvCnote.Rows)
                //    {
                //        TextBox txtCnoteNo = (TextBox)gridrow.FindControl("txtCnoteNo");
                //        TextBox txtBkgDate = (TextBox)gridrow.FindControl("txtBkgDate");
                //        TextBox txtOriginDestination = (TextBox)gridrow.FindControl("txtOriginDestination");
                //        TextBox txtPackage = (TextBox)gridrow.FindControl("txtPackage");
                //        TextBox txtActualWeight = (TextBox)gridrow.FindControl("txtActualWeight");
                //        TextBox txtChargedWeight = (TextBox)gridrow.FindControl("txtChargedWeight");
                //        TextBox txtSubTotal = (TextBox)gridrow.FindControl("txtSubTotal");
                //        TextBox txtCnoteTotal = (TextBox)gridrow.FindControl("txtCnoteTotal");

                //        string Origin = "";
                //        string Destination = "";

                //        string[] strArray;
                //        strArray = txtOriginDestination.Text.Split(new char[] { '-' });

                //        Origin = strArray[0].Trim();
                //        Destination = strArray[1].Trim();

                //        SqlCommand cmdCnote = new SqlCommand("USP_FLEET_INSERT_CNOTE_HDR", conn, trans);
                //        cmdCnote.CommandType = CommandType.StoredProcedure;
                //        cmdCnote.Parameters.Add("@Tripsheetno", SqlDbType.VarChar).Value = mDocuementNo;
                //        cmdCnote.Parameters.Add("@DockNo", SqlDbType.VarChar).Value = txtCnoteNo.Text.ToString();
                //        cmdCnote.Parameters.Add("@DOCKDT", SqlDbType.VarChar).Value = txtBkgDate.Text.ToString();
                //        cmdCnote.Parameters.Add("@ORGNCD", SqlDbType.VarChar).Value = Origin;
                //        cmdCnote.Parameters.Add("@DESTCD", SqlDbType.VarChar).Value = Destination;
                //        cmdCnote.Parameters.Add("@PKGSNO", SqlDbType.VarChar).Value = txtPackage.Text.ToString();
                //        cmdCnote.Parameters.Add("@ACTUWT", SqlDbType.VarChar).Value = txtActualWeight.Text.ToString();
                //        cmdCnote.Parameters.Add("@CHRGWT", SqlDbType.VarChar).Value = txtChargedWeight.Text.ToString();
                //        cmdCnote.Parameters.Add("@SubTotal", SqlDbType.VarChar).Value = txtSubTotal.Text.ToString();
                //        cmdCnote.Parameters.Add("@DKTTOT", SqlDbType.VarChar).Value = txtCnoteTotal.Text.ToString();
                //        cmdCnote.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                //        cmdCnote.ExecuteNonQuery();
                //    }
                //}

                #endregion

                //----------------- FLEET TRANSACTION -----------------------------------
                string mFinYear = "";
                mFinYear = SessionUtilities.FinYear.ToString();
                string mYearVal = "";
                mYearVal = objFinYear.FinancialYear();

                string sqlAcc = "Usp_FleetTransaction";
                SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = mBranchCode;// SessionUtilities.CurrentBranchCode.ToString().Trim();
                sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "8";
                sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mDocuementNo;
                sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear; //2001
                sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal; // 09_10
                sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10

                sqlcmdAcc.ExecuteNonQuery();


                //upload check list file
                string newFName = "";
                if (fileUploadCheckList.HasFile)
                {
                    //newFName = GetFileName(fUThcDoc.PostedFile.FileName, mDocuementNo.ToString().Trim());
                    string ImgName = fileUploadCheckList.PostedFile.FileName;
                    int lastIndex = ImgName.LastIndexOf('.');
                    var name = ImgName.Substring(0, lastIndex);
                    var ext = ImgName.Substring(lastIndex + 1);
                    string docno = mDocuementNo.Trim().Replace("/", "$");
                    newFName = "CheckList_" + docno + "." + ext;

                    double dblFileSize = Math.Ceiling(Convert.ToDouble(fileUploadCheckList.PostedFile.ContentLength) / 1000);
                    double MaxSize = 1024; //1MB

                    // if (dblFileSize > MaxSize)
                    // {
                    // throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                    // }
                    //fUThcDoc.SaveAs(Server.MapPath(".") + @"\" + path + @"\" + clintName + @"\" + newFName);
                    fileUploadCheckList.SaveAs(Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages") + @"\" + newFName);

                }
                if (newFName != "")
                {
                    string sqlchecklist = " Update WEBX_FLEET_VEHICLE_ISSUE set CheckListFile='" + newFName + "' Where VSlipNo ='" + mDocuementNo + "' ";
                    SqlCommand TripCheckList = new SqlCommand(sqlchecklist, conn, trans);
                    TripCheckList.CommandType = CommandType.Text;
                    TripCheckList.ExecuteNonQuery();
                }


                //------------------------------------------------------------------------
                //trans.Rollback();
                trans.Commit();
                success = true;
            }
            catch (Exception e1)
            {
                if (incomplete)
                {
                    string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Advance Payment" + "&ErrorMsg=" + ErrorMsg);
                    trans.Rollback();
                    Response.End();
                }
                else
                {
                    Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                    //Response.Write("Error" + e1.Message);
                    trans.Rollback();
                    Response.End();
                }
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                //Response.Redirect("frmVehicleIssueSlipNew_result.aspx?VSlipId=" + mDocuementNo.Trim(), true);
                Response.Redirect("frmVehicleIssueSlipNew_result.aspx?VSlipId=" + mDocuementNo.Trim() + "&TripSheetType=D", true);
            }
        }

    }
    protected void ddlFuelVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in gvFuelSlip.Rows)
        {
            DropDownList ddlFuelVendor = (DropDownList)gridrow.FindControl("ddlFuelVendor");
            TextBox txtFromCity = (TextBox)gridrow.FindControl("txtFromCity");
            TextBox txtRate = (TextBox)gridrow.FindControl("txtRate");
            DropDownList ddlFuelTypePD = (DropDownList)gridrow.FindControl("ddlFuelTypePD");


            SplitVendorName = ddlFuelVendor.SelectedItem.Text;
            string[] stringSeparators = new string[] { ":" };
            string[] result;
            result = SplitVendorName.Split(stringSeparators, StringSplitOptions.None);

            //foreach (string s in result)
            //{

            txtFromCity.Text = result[1];
            //}


            string GetVendorCode = ddlFuelVendor.SelectedValue;
            string GetProduct = ddlFuelTypePD.SelectedValue;
            SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());

            conn.Open();
            SqlCommand cmd = new SqlCommand("usp_GetVendorRate", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = GetVendorCode.Trim();
            cmd.Parameters.Add("@Product", SqlDbType.VarChar).Value = GetProduct.Trim();
            cmd.Parameters.Add("@Rate", SqlDbType.VarChar, 30);

            cmd.Parameters["@Rate"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            conn.Close();


            string VendorRate = cmd.Parameters["@Rate"].Value.ToString();

            if (VendorRate != "")
            {
                txtRate.Text = VendorRate;
            }

            else
            {
                txtRate.Text = "NA";
            }

        }
    }
    protected void ddlFuelTypePD_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in gvFuelSlip.Rows)
        {
            DropDownList ddlFuelVendor = (DropDownList)gridrow.FindControl("ddlFuelVendor");
            TextBox txtFromCity = (TextBox)gridrow.FindControl("txtFromCity");
            TextBox txtRate = (TextBox)gridrow.FindControl("txtRate");
            DropDownList ddlFuelTypePD = (DropDownList)gridrow.FindControl("ddlFuelTypePD");
            TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");
            TextBox txtamounttotal = (TextBox)gridrow.FindControl("txtamounttotal");

            SplitVendorName = ddlFuelVendor.SelectedItem.Text;
            string[] stringSeparators = new string[] { ":" };
            string[] result;
            result = SplitVendorName.Split(stringSeparators, StringSplitOptions.None);

            //foreach (string s in result)
            //{

            txtFromCity.Text = result[1];
            //}


            string GetVendorCode = ddlFuelVendor.SelectedValue;
            string GetProduct = ddlFuelTypePD.SelectedValue;
            SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());

            conn.Open();
            SqlCommand cmd = new SqlCommand("usp_GetVendorRate", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = GetVendorCode.Trim();
            cmd.Parameters.Add("@Product", SqlDbType.VarChar).Value = GetProduct.Trim();
            cmd.Parameters.Add("@Rate", SqlDbType.VarChar, 30);

            cmd.Parameters["@Rate"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            conn.Close();


            string VendorRate = cmd.Parameters["@Rate"].Value.ToString();

            if (VendorRate != "")
            {
                txtRate.Text = VendorRate;
            }

            else
            {
                txtRate.Text = "NA";
            }
            if (ddlFuelTypePD.SelectedValue != "AddBlue")
            {
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;
                               
            }
            else
            {
                txtIGST.Enabled = true;
                txtSGST.Enabled = true;
                txtCGST.Enabled = true;                
            }
        }
    }
    protected void ddlMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
        {
            DropDownList ddlAcount = (DropDownList)gridrow.FindControl("ddlAcount");
            DropDownList ddlMode = (DropDownList)gridrow.FindControl("ddlMode");
            HiddenField hdnBankAccount = (HiddenField)gridrow.FindControl("hdnBankAccount");
            HiddenField hdnMode = (HiddenField)gridrow.FindControl("hdnMode");
            TextBox txtRefNo = (TextBox)gridrow.FindControl("txtRefNo");
            BindDropDownWithPerameter("Usp_TripsheetGene_Happay_List", "CodeName", "CodeID", ddlMode.SelectedItem.Value, ddlAcount);

            if (hdnBankAccount.Value != "")
            {
                ddlAcount.SelectedValue = hdnBankAccount.Value;
            }
            if (ddlMode.SelectedValue == "1")
            {
                txtRefNo.Text = "";
                txtRefNo.Enabled = false;
            }

        }
    }
    protected void ddlAcount_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

}
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

//----------LIVE CODE
public partial class frmVehicleIssueSlipNewWORequest : System.Web.UI.Page
{
    static string str_Connection_String = "";

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;
    int _lastEditedPage;
    public string mRouteStr = "";

    DateFunction DtFun = new DateFunction();

    DriverBalance DBalance = new DriverBalance();
    protected void Page_Load(object sender, EventArgs e)
    {
        //AjaxPro.Utility.RegisterTypeForAjax(typeof(frmVehicleIssueSlipNewWORequest));

        str_Connection_String = Session["SqlProvider"].ToString();

        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
        string strfinyear = SessionUtilities.FinYear.ToString().Trim();

        hfFinancialYr.Value = SessionUtilities.FinYear.ToString().Trim();
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        //btnBack.Attributes.Add("onclick", "return confirm('Are you sure you want to clear Data?')");
        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        txtFromCity.Attributes.Add("OnBlur", "javascript:return CheckValidCity(this," + lbl_FromCity_Err.ClientID.ToString() + ")");
        txtToCity.Attributes.Add("OnBlur", "javascript:return CheckValidCity(this," + lbl_ToCity_Err.ClientID.ToString() + ")");

        txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this);");
        cmdSubmit.Attributes.Add("onClick", "javascript:return valid(this," + dlsttranstype.ClientID + ");");
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;


        if (!IsPostBack)
        {
            txtStartLoc.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();
            txtEndLoc.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();
            //InitializeData();

            //txtDate.Attributes.Add("onBlur", "javascript:ValidateDate(this);ChekcFinancialYear();MIn_Max_Date_Validation(this,'01','../../images/Date_Control_Rule_Check.aspx')");
            txtDate.Attributes.Add("onBlur", "javascript:MIn_Max_Date_Validation(this,'01','../../../images/Fleet_Date_Control_Rule_Check.aspx');ChekcFinancialYear();");
               
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

            Page.RegisterClientScriptBlock("update_city2", scr5);

            txtManualTripSheetNo.Attributes.Add("OnBlur", "javascript:CheckValidManualTS(this," + lbl_Manual_TS_Err.ClientID.ToString() + ");");

            Inetialized_AdvanceTaken();

            BindGrid();

            InitializeData();
            //ddl_Driver1.Attributes.Add("OnChange", "javascript:GetDriver1Details(this);");
            //ddl_Driver1.Attributes.Add("OnChange", "javascript:GetDriver2Details(this," + LblDriver2Name.ClientID.ToString() + "," + lblLicno.ClientID.ToString() + "," + lblValidDt.ClientID.ToString() + ");");

            ddl_Driver2.Attributes.Add("OnChange", "javascript:GetDriver2Details(this," + LblDriver2Name.ClientID.ToString() + "," + lblLicnoD2.ClientID.ToString() + "," + lblValidDtD2.ClientID.ToString() + ");");
            ddlRouteDetails.Attributes.Add("OnChange", "javascript:ChangeRouteDetails(this)");

            if (ddlRouteDetails.SelectedValue == "1")
            {
                row_Trip_Route_C.Style["display"] = "block";
                row_Trip_Route_B.Style["display"] = "block";
                row_Trip_Route_R.Style["display"] = "none";
            }

            

            //txtVehNo.Attributes.Add("OnChange", "javascript:GetTabSet();");
            txtVehNo.Attributes.Add("OnBlur", "javascript:CheckVehicleNumber(this," + lblVehCheck.ClientID.ToString().Trim() + "," + txtStartKM.ClientID.ToString() + ");");
            txtCustCode.Attributes.Add("OnBlur", "javascript:CheckCustomerCode(this," + lblErrorLocation1.ClientID.ToString() + ");");

            
            ddlRoute.Attributes.Add("OnChange", "javascript:OnChangeRoute(this);");
        }
    }


    ////For Bind Dropdown using javascript

    // [AjaxPro.AjaxMethod]
    // public DataSet GetDataSet()
    // {
    //     DataSet ds = new DataSet();
    //     TripSheet objTs = new TripSheet(str_Connection_String);
    //     objTs.Vehicle_No = str;//"HR55G5158";
    //     ds = objTs.GetDsRoute();
    //     return ds;
    // }

    //////////////////////////////////////////////////////////////////

    protected void ddl_Vehicle_Mode_SelectedIndexChanged(object sender, EventArgs e)
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.CheckTripRule();

        if (ddl_Vehicle_Mode.SelectedValue == "01")
        {
            row_Vehicle_Name.Style["display"] = "none";
            if (objTs.Vehicle_Selection == "Y")
            {
                row_Vehicle_Manual.Style["display"] = "none";
                row_Vehicle_Select.Style["display"] = "block";
            }
            else
            {
                row_Vehicle_Manual.Style["display"] = "block";
                row_Vehicle_Select.Style["display"] = "none";
            }
            //row_Vehicle_Manual.Style["display"] = "block";
            //row_Vehicle_Select.Style["display"] = "block";

            row_Driver_Name.Style["display"] = "block";
            row_Driver_Manual.Style["display"] = "none";
            row_Driver_Select.Style["display"] = "none";

            tbl_Driver_Adv.Style["display"] = "none";

            row_Driver_Name_Dis.Style["display"] = "none";
            //row_Driver_License_Dis.Style["display"] = "none";
            //row_Driver_LicenseValid_Dis.Style["display"] = "none";
            lblLicno.BorderStyle = BorderStyle.Groove;
            lblLicno.CssClass = "input";
            lblLicnoD2.BorderStyle = BorderStyle.Groove;
            lblLicnoD2.CssClass = "input";

            lblValidDt.BorderStyle = BorderStyle.Groove;
            lblValidDt.CssClass = "input";
            lblValidDtD2.BorderStyle = BorderStyle.Groove;
            lblValidDtD2.CssClass = "input";
        }
        else if (ddl_Vehicle_Mode.SelectedValue == "05")
        {
            row_Vehicle_Name.Style["display"] = "none";
            if (objTs.Vehicle_Selection == "Y")
            {
                row_Vehicle_Manual.Style["display"] = "none";
                row_Vehicle_Select.Style["display"] = "block";
            }
            else
            {
                row_Vehicle_Manual.Style["display"] = "block";
                row_Vehicle_Select.Style["display"] = "none";
            }
            //row_Vehicle_Manual.Style["display"] = "block";
            //row_Vehicle_Select.Style["display"] = "block";

            if (objTs.Manual_Driver_Code == "Y")
            {
                row_Driver_Manual.Style["display"] = "block";
                row_Driver_Select.Style["display"] = "none";
            }
            else
            {
                row_Driver_Manual.Style["display"] = "none";
                row_Driver_Select.Style["display"] = "block";
            }

            row_Driver_Name.Style["display"] = "none";
            tbl_Driver_Adv.Style["display"] = "block";

            row_Driver_Name_Dis.Style["display"] = "block";
            //row_Driver_License_Dis.Style["display"] = "block";
            //row_Driver_LicenseValid_Dis.Style["display"] = "block";

            lblLicno.BorderStyle = BorderStyle.None;
            lblLicno.CssClass = "";
            lblLicno.Attributes.Add("onblur", "this.focus()");
            lblLicnoD2.BorderStyle = BorderStyle.None;
            lblLicnoD2.CssClass = "";
            lblLicnoD2.Attributes.Add("onblur", "this.focus()");

            lblValidDt.BorderStyle = BorderStyle.None;
            lblValidDt.CssClass = "";
            lblValidDt.Attributes.Add("onblur", "this.focus()");
            lblValidDtD2.BorderStyle = BorderStyle.None;
            lblValidDtD2.CssClass = "";
            lblValidDtD2.Attributes.Add("onblur", "this.focus()");

        }
        else if (ddl_Vehicle_Mode.SelectedValue == "07")
        {
            row_Vehicle_Name.Style["display"] = "block";
            row_Vehicle_Manual.Style["display"] = "none";
            row_Vehicle_Select.Style["display"] = "none";

            row_Driver_Name.Style["display"] = "block";
            row_Driver_Manual.Style["display"] = "none";
            row_Driver_Select.Style["display"] = "none";

            tbl_Driver_Adv.Style["display"] = "none";

            row_Driver_Name_Dis.Style["display"] = "none";
            //row_Driver_License_Dis.Style["display"] = "none";
            //row_Driver_LicenseValid_Dis.Style["display"] = "none";
            lblLicno.BorderStyle = BorderStyle.Groove;
            lblLicno.CssClass = "input";
            lblLicnoD2.BorderStyle = BorderStyle.Groove;
            lblLicnoD2.CssClass = "input";

            lblValidDt.BorderStyle = BorderStyle.Groove;
            lblValidDt.CssClass = "input";
            lblValidDtD2.BorderStyle = BorderStyle.Groove;
            lblValidDtD2.CssClass = "input";
        }
        objTs.Vehicle_No = "";
        objTs.BRCD = SessionUtilities.CurrentBranchCode.ToString().Trim();
        objTs.VENDORTYPE = ddl_Vehicle_Mode.SelectedValue.ToString().Trim();
        objTs.BindVehicleDropdown(cboVehno);

        row_Docket_btn.Style["display"] = "none";
        row_Docket_hdr.Style["display"] = "none";
        row_Dockets.Style["display"] = "none";

        cboVehno.SelectedIndex = 0;
        //ddlCategory.SelectedIndex = 0;
        //ddl_ExternalUsages_Category.SelectedIndex = 0; 
        cboVehno_SelectedIndexChanged(sender, e);
        //ddlCategory_SelectedIndexChanged(sender, e);
    }

    protected void cboVehno_SelectedIndexChanged(object sender, EventArgs e)
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.Vehicle_No = cboVehno.SelectedValue;
        if (cboVehno.SelectedIndex != 0)
        {
			ddlRoute.Items.Clear();
            objTs.BindRouteDropdown(ddlRoute);
        }
        objTs.CheckTripRule();

        objTs.BRCD = SessionUtilities.CurrentBranchCode.ToString().Trim();
        objTs.Driver_Name = "";
        objTs.Vehicle_No = cboVehno.SelectedValue;

        if (objTs.Driver_WO_Vehicle == "N")
        {
            objTs.BindDriverDropdown(ddl_Driver1, "");
        }

        DataTable dtKMRead = new DataTable();
        dtKMRead = objTs.ExecuteSql("Select current_KM_Read  from webx_vehicle_hdr  where vehno='" + cboVehno.SelectedItem.Text.Trim() + "'");
        if (dtKMRead.Rows.Count > 0)
        {
            if (objTs.Retrieved_from_last_Trip == "Y")
            {
                txtStartKM.Text = Convert.ToString(dtKMRead.Rows[0]["current_KM_Read"]);
                hdStatKm.Value = Convert.ToString(dtKMRead.Rows[0]["current_KM_Read"]);
                txtStartKM.ReadOnly = false;
                txtStartKM.BorderStyle = BorderStyle.Groove;
                txtStartKM.CssClass = "input";
                txtStartKM.Attributes.Add("OnBlur", "javascript:CheckStartKM(" + txtStartKM.ClientID + "," + hdStatKm.ClientID + ",'N');");
            }
            else if (objTs.Not_To_Be_Changed == "Y")
            {
                if (dtKMRead.Rows[0]["current_KM_Read"].ToString().Trim() == "")
                {
                    txtStartKM.Text = "0";
                }
                else
                {
                    txtStartKM.Text = Convert.ToString(dtKMRead.Rows[0]["current_KM_Read"]);
                    hdStatKm.Value = Convert.ToString(dtKMRead.Rows[0]["current_KM_Read"]);

                }
                txtStartKM.BorderStyle = BorderStyle.None;
                txtStartKM.CssClass = "";
                txtStartKM.ReadOnly = true;
                txtStartKM.Attributes.Add("OnBlur", "javascript:CheckStartKM(" + txtStartKM.ClientID + "," + hdStatKm.ClientID + ",'N');");
            }
            else if (objTs.Editable_Can_Be_Change == "Y")
            {
                txtStartKM.Text = Convert.ToString(dtKMRead.Rows[0]["current_KM_Read"]);
                hdStatKm.Value = Convert.ToString(dtKMRead.Rows[0]["current_KM_Read"]);
                txtStartKM.ReadOnly = false;
                txtStartKM.BorderStyle = BorderStyle.Groove;
                txtStartKM.CssClass = "input";
                txtStartKM.Attributes.Add("OnBlur", "javascript:CheckStartKM(" + txtStartKM.ClientID + "," + hdStatKm.ClientID + ",'Y');");
            }
        }

        LblDriver1Name.Text = "";
        lblLicno.Text = "";
        lblValidDt.Text = "";
        ddl_Driver1.Attributes.Add("OnChange", "javascript:GetDriver1Details(this);");

        row_Docket_btn.Style["display"] = "none";
        row_Docket_hdr.Style["display"] = "none";
        row_Dockets.Style["display"] = "none";
		ddlRouteDetails.SelectedValue = "2";
    }
    public void InitializeData()
    {
        row_Driver_Name.Style["display"] = "none";

        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.BindCheckList(gvChecklist);
        //objTs.BindDropDown(ddl_Vehicle_Mode, "select  CodeId,CodeDesc from webx_master_General where codetype = 'VENDTY' AND CODEID IN ('05','07')");
        objTs.BindDropDown(ddl_Vehicle_Mode, "select VendorTypeCode,VendorTypename from Webx_Main_Vendor_Type where VendorTypeCode IN ('01','05')");
		objTs.BindDropDown(ddl_ExternalUsages_Category, "select CodeId,CodeDesc from webx_master_General where codetype = 'EXCAT' And StatusCode='Y'");

        objTs.CheckTripRule();



        if (objTs.Vehicle_Selection == "Y")
        {
            row_Vehicle_Manual.Style["display"] = "none";
            row_Vehicle_Select.Style["display"] = "block";
        }
        else
        {
            row_Vehicle_Manual.Style["display"] = "block";
            row_Vehicle_Select.Style["display"] = "none";
        }
        if (objTs.Driver1_Manual == "Y" && objTs.Driver2_Manual == "Y")
        {
            row_Driver_Manual.Style["display"] = "block";
            row_Driver_Select.Style["display"] = "none";
        }
        else
        {
            row_Driver_Manual.Style["display"] = "none";
            row_Driver_Select.Style["display"] = "block";
        }
        if (objTs.Trip_Route_Selection == "C")
        {
            row_Trip_Route_C.Style["display"] = "block";
            row_Trip_Route_B.Style["display"] = "none";
            row_Trip_Route_R.Style["display"] = "none";
        }
        else if (objTs.Trip_Route_Selection == "R")
        {
            row_Trip_Route_C.Style["display"] = "none";
            row_Trip_Route_B.Style["display"] = "none";
            row_Trip_Route_R.Style["display"] = "block";
        }
        else if (objTs.Trip_Route_Selection == "B")
        {
            row_Trip_Route_C.Style["display"] = "block";
            row_Trip_Route_B.Style["display"] = "block";
            row_Trip_Route_R.Style["display"] = "none";
        }
        else if (objTs.Trip_Route_Selection == "N")
        {
            row_Trip_Route_C.Style["display"] = "none";
            row_Trip_Route_B.Style["display"] = "none";
            row_Trip_Route_R.Style["display"] = "none";
        }

        if (objTs.THC_Attached == "Y")
        {
            row_THC_Attached.Style["display"] = "none";
            hfAttached.Value = "Y";
        }
        else
        {
            row_THC_Attached.Style["display"] = "none";
            hfAttached.Value = "N";
        }
        if (objTs.Vehicle_Filter == "CUR_LOC")
        {
            hf_Vehicle_Filter.Value = "CUR_LOC";
        }
        else if (objTs.Vehicle_Filter == "CONT_LOC")
        {
            hf_Vehicle_Filter.Value = "CONT_LOC";
        }

        if (objTs.UFL_Filter == "Y")
        {
            row_UFL1.Style["display"] = "block";
            row_UFL2.Style["display"] = "block";
        }
        else
        {
            row_UFL1.Style["display"] = "none";
            row_UFL2.Style["display"] = "none";
        }

        if (objTs.Auto_Vslip_Filter == "Y")
        {
            row_Auto_Manual_TSNo.Style["display"] = "block";
            row_Manual_TSNo.Style["display"] = "none";
            hfAutoManualTsStatus.Value = "Yes";
        }
        else
        {
            row_Auto_Manual_TSNo.Style["display"] = "none";
            row_Manual_TSNo.Style["display"] = "block";
            hfAutoManualTsStatus.Value = "No";
        }
        if (objTs.VEHICLE_MODE == "Y")
        {
            row_Vehicle_Mode.Style["display"] = "block";
            row_Vehicle_Mode.Style["display"] = "block";
        }
        else
        {
            row_Vehicle_Mode.Style["display"] = "none";
            row_Vehicle_Mode.Style["display"] = "none";
        }

        btnAttachDocket.Text = "Attached " + objTs.DOCKET_NO_LABEL + " Details";
        lblDocketLable.Text = "Select " + objTs.DOCKET_NO_LABEL + " Number";
        hfLOCAL_CITY.Value = objTs.LOCAL_CITY;
        hfDocketLabel.Value = objTs.DOCKET_NO_LABEL;

        row_Docket_btn.Style["display"] = "none";
        row_Docket_hdr.Style["display"] = "none";
        row_Dockets.Style["display"] = "none";
        row_Vehicle_Name.Style["display"] = "none";

        if (objTs.DOCKET_WITH_TRIPSHEET == "Y")
        {
            //row_Docket_btn.Visible = true;
            ddl_ExternalUsages_Category.Attributes.Add("OnChange", "javascript:ChangeExternalUsages()");
            chkSelAllDocket.Attributes.Add("OnClick", "javascript:SelectAllDocket(" + chkSelAllDocket.ClientID.ToString() + "," + chklstDockets.ClientID.ToString() + ");");
        }

        objTs.BRCD = SessionUtilities.CurrentBranchCode.ToString().Trim();
        objTs.VENDORTYPE = "";
        objTs.Driver_Name = "";
        objTs.Vehicle_No = "";

        if (objTs.VEHICLE_MODE == "Y")
        {

        }
        else
        {
            objTs.BindVehicleDropdown(cboVehno);
        }
        if (objTs.Driver_WO_Vehicle == "Y")
        {
            objTs.BindDriverDropdown(ddl_Driver1, "");
        }
        if (objTs.Checklist == "Y" || objTs.Checklist_Mandatory == "Y")
        {
            hfChecklist_Mandatory.Value = objTs.Checklist_Mandatory;
            Row_Checklist.Style["display"] = "block";
            gvChecklist.Visible = true;
            Table2.Visible = true;
        }
        else
        {
            Row_Checklist.Style["display"] = "none";
            gvChecklist.Visible = false;
            Table2.Visible = false;
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


        objTs.BindDriverDropdown(ddl_Driver2, "driver2");
    }

    protected void btnAttachDocket_Click(object sender, EventArgs e)
    {
        row_Docket_btn.Style["display"] = "none";
        row_Docket_hdr.Style["display"] = "block";
        row_Dockets.Style["display"] = "block";

        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.GetDockets(chklstDockets);
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblCutcode.Visible = false;
        lblPopup.Visible = false;
        txtCustCode.Visible = false;
        //Table1.Visible = false;

        lblMarket_own.Visible = false;
        ddlMarket.Visible = false;
        //tblContract.Visible = true;
        lblExternalUsages.Visible = false;
        ddl_ExternalUsages_Category.Visible = false;
        hr1.Visible = false;
        hr2.Visible = false;

        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "External Usage")
        {

            lblCutcode.Visible = true;
            lblPopup.Visible = true;
            txtCustCode.Visible = true;
            //Table1.Visible = true;
            lblMarket_own.Visible = false;
            ddlMarket.Visible = false;
            //  tblContract.Visible = true;

            TripSheet objTs = new TripSheet(str_Connection_String);
            objTs.CheckTripRule();

            if (objTs.ExternalUsage_Category == "Y")
            {
                lblExternalUsages.Visible = true;
                ddl_ExternalUsages_Category.Visible = true;
                hr1.Visible = true;
                hr2.Visible = true;
            }
            else
            {
                lblExternalUsages.Visible = false;
                ddl_ExternalUsages_Category.Visible = false;
                hr1.Visible = false;
                hr2.Visible = false;
            }
        }
        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "Internal Usage")
        {
            txtFromCity.Text = "";
            txtToCity.Text = "";
            //txtRoute.Text = "";
            lblCutcode.Visible = false;
            txtCustCode.Visible = false;
            //Table1.Visible = true;
            lblMarket_own.Visible = true;
            ddlMarket.Visible = true;

            lblPopup.Visible = false;
            lblExternalUsages.Visible = false;
            ddl_ExternalUsages_Category.Visible = false;
            hr1.Visible = false;
            hr2.Visible = false;
        }
        //txtVehNo_TextChanged(sender, e);
        //string mToDt = DtFun.return_date(txtDate.Text);
        //string mDBVal = "";
        //mDBVal = DBalance.GetDriverBalanceAmt(txtDriver1.Text.Trim(), mToDt);
        //LblDriverBalance.Text = mDBVal;
        row_Docket_btn.Style["display"] = "none";
        row_Docket_hdr.Style["display"] = "none";
        row_Dockets.Style["display"] = "none";
    }
    protected void PopulateAdvamt(object sender, EventArgs e)
    {
        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {
            if (((TextBox)gridrow.FindControl("txtAdvDt")).Text != "")
            {
                txtAmount.Text = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;
            }
        }
    }

    public void Inetialized_AdvanceTaken()
    {
        //string mBranchCode = SessionUtilities.CurrentBranchCode.ToString().Trim();
        _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", SessionUtilities.CurrentBranchCode.ToString().Trim(), "");
    }


    public void BindGrid()
    {
        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;
    }

    public void CheckLocation(object sender, EventArgs e)
    {
        LblLocError.Text = "";
        string DataFoundFlag = "N";

        string strEndLoc = txtEndLoc.Text;
        if (strEndLoc != "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
    protected void SubmitData(object sender, EventArgs e)
    {
        cmdSubmit.Enabled = false;

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        System.Globalization.DateTimeFormatInfo year = new System.Globalization.DateTimeFormatInfo();

        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        //    year.ShortDatePattern = "dd/MM/yy";

        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));

        DateTime mServerDt = DateTime.Now;
        DateTime mIssueDt = new DateTime();
        mIssueDt = Convert.ToDateTime(txtDate.Text.ToString(), dtfi);
        // lblError.Text = "";

        if (ddlCategory.SelectedItem.Value == "External Usage")
        {
            if (txtCustCode.Text.ToString().Trim() == "")
            {
                lblError.Text = "Please enter Customer code  !";
            }
        }


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        if (lbl_Manual_TS_Err.Text == "" && lblError.Text == "")
        {
            string mDocuementNo = "", mCheck = "";
            string sql = "";
            string strDocketNos = "";
            for (int i = 0; i < chklstDockets.Items.Count; i++)
            {
                if (chklstDockets.Items[i].Selected == true)
                {
                    strDocketNos = strDocketNos + chklstDockets.Items[i].Value.Trim() + ",";
                }
            }


            bool success = false;
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

                    mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
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

                if (tb_Driver_Name1.Text != "")
                {
                    SqlCommand cmdInsDriver = new SqlCommand("Usp_Insert_Webx_Fleet_Drivermst_Attached", conn, trans);
                    cmdInsDriver.CommandType = CommandType.StoredProcedure;

                    cmdInsDriver.Parameters.Add("@Driver_Id", SqlDbType.Int).Value = 0;
                    cmdInsDriver.Parameters.Add("@Driver_Name", SqlDbType.VarChar).Value = tb_Driver_Name1.Text.Trim();
                    cmdInsDriver.Parameters.Add("@License_No", SqlDbType.VarChar).Value = lblLicno.Text.Trim();
                    cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(lblValidDt.Text);
                    cmdInsDriver.Parameters.Add("@Manual_Driver_Code", SqlDbType.VarChar).Value = "";
                    cmdInsDriver.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    cmdInsDriver.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                    cmdInsDriver.Parameters[0].Direction = System.Data.ParameterDirection.Output;
                    cmdInsDriver.ExecuteNonQuery();
                    strAttachedDriverID1 = cmdInsDriver.Parameters["@Driver_Id"].Value.ToString();
                }
                if (tb_Driver_Name2.Text != "")
                {
                    SqlCommand cmdInsDriver = new SqlCommand("Usp_Insert_Webx_Fleet_Drivermst_Attached", conn, trans);
                    cmdInsDriver.CommandType = CommandType.StoredProcedure;

                    cmdInsDriver.Parameters.Add("@Driver_Id", SqlDbType.Int).Value = 0;
                    cmdInsDriver.Parameters.Add("@Driver_Name", SqlDbType.VarChar).Value = tb_Driver_Name2.Text.Trim();
                    cmdInsDriver.Parameters.Add("@License_No", SqlDbType.VarChar).Value = lblLicnoD2.Text.Trim();
                    cmdInsDriver.Parameters.Add("@Valdity_dt", SqlDbType.VarChar).Value = DTM.ConvertToDate(lblValidDtD2.Text);
                    cmdInsDriver.Parameters.Add("@Manual_Driver_Code", SqlDbType.VarChar).Value = "";
                    cmdInsDriver.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = "Y";
                    cmdInsDriver.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();
                    cmdInsDriver.Parameters[0].Direction = System.Data.ParameterDirection.Output;
                    cmdInsDriver.ExecuteNonQuery();
                    strAttachedDriverID2 = cmdInsDriver.Parameters["@Driver_Id"].Value.ToString();
                }

                string strTripDateTime = txtDate.Text + " " + TimeSelector1.Hour + ":" + TimeSelector1.Minute + " " + TimeSelector1.AmPm;

                SqlCommand cmd = new SqlCommand("usp_AddVehicleIssue", conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = mDocuementNo;
                cmd.Parameters.Add("@VSlipDt", SqlDbType.DateTime).Value = Convert.ToDateTime(strTripDateTime.ToString().Trim(), dtfi);
                if (txtVehNo.Text != "")
                {
                    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehNo.Text.ToString();
                }
                else if (cboVehno.SelectedIndex != 0)
                {
                    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = cboVehno.SelectedItem.Value;
                }
                else
                {
                    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = tb_Vehicle_Name.Text;
                }
                if (ddl_Driver1.SelectedIndex != 0)
                {
                    cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = ddl_Driver1.SelectedValue;
                }
                else if (hfDriver1ID.Value != "")
                {
                    cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = hfDriver1ID.Value;
                }
                else
                {
                    cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = "0";
                }

                if (ddl_Driver2.SelectedIndex != 0)
                {
                    cmd.Parameters.Add("@Driver2", SqlDbType.VarChar).Value = ddl_Driver2.SelectedValue;
                }
                else if (hfDriver2ID.Value != "")
                {
                    cmd.Parameters.Add("@Driver2", SqlDbType.VarChar).Value = hfDriver2ID.Value;
                }
                else
                {
                    cmd.Parameters.Add("@Driver2", SqlDbType.VarChar).Value = "0";
                }

                cmd.Parameters.Add("@VehiclePath", SqlDbType.VarChar).Value = "-";
                cmd.Parameters.Add("@f_issue_startkm", SqlDbType.VarChar).Value = txtStartKM.Text.ToString().Trim();
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

                cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = ddlCategory.SelectedItem.Value.ToString().Trim();
                cmd.Parameters.Add("@CustCode", SqlDbType.VarChar).Value = txtCustCode.Text.ToString().Trim();
                cmd.Parameters.Add("@M_Own", SqlDbType.VarChar).Value = ddlMarket.SelectedItem.Value.ToString().Trim();


                cmd.Parameters.Add("@From_City", SqlDbType.VarChar).Value = txtFromCity.Text.ToString();
                cmd.Parameters.Add("@To_City", SqlDbType.VarChar).Value = txtToCity.Text.ToString();
                string mRouteStr = txtFromCity.Text.ToString() + " - " + txtToCity.Text.ToString() + " - " + txtFromCity.Text.ToString();
                cmd.Parameters.Add("@Route", SqlDbType.VarChar).Value = mRouteStr;
                cmd.Parameters.Add("@rut_code", SqlDbType.VarChar).Value = ddlRoute.SelectedValue;
                if (hfAttached.Value == "Y")
                {
                    cmd.Parameters.Add("@THC_Attached_YN", SqlDbType.VarChar).Value = "Y";
                }
                else
                {
                    cmd.Parameters.Add("@THC_Attached_YN", SqlDbType.VarChar).Value = "N";
                }

                if (tb_Trip_Revenue.Text == "")
                {
                    cmd.Parameters.Add("@Revenue_Capture", SqlDbType.Float).Value = Convert.ToDouble("0".ToString());
                }
                else
                {
                    cmd.Parameters.Add("@Revenue_Capture", SqlDbType.Float).Value = Convert.ToDouble(tb_Trip_Revenue.Text.ToString());
                }
                cmd.Parameters.Add("@Transit_Time", SqlDbType.VarChar, 10).Value = tb_Trasit_HH.Text + ":" + tb_Trasit_MM.Text;
                cmd.Parameters.Add("@UFL_Weight", SqlDbType.Float).Value = Convert.ToDouble(tb_UFL_Weight.Text.ToString());
                cmd.Parameters.Add("@AFL_Weight", SqlDbType.Float).Value = Convert.ToDouble(tb_AFL_Weight.Text.ToString());
                cmd.Parameters.Add("@Total_Weight", SqlDbType.Float).Value = Convert.ToDouble(tb_Total_Weight.Text.ToString());
                cmd.Parameters.Add("@Driver1OpBal", SqlDbType.VarChar).Value = LblDriverBalance.Text.ToString();
                cmd.Parameters.Add("@Entryby", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                cmd.Parameters.Add("@ExternalUsage_Category", SqlDbType.VarChar).Value = ddl_ExternalUsages_Category.SelectedValue.Trim();
                cmd.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10

                cmd.Parameters.Add("@Vehicle_Mode", SqlDbType.VarChar).Value = ddl_Vehicle_Mode.SelectedValue;//Vendor Type  

                cmd.Parameters.Add("@Driver1_Name", SqlDbType.VarChar).Value = strAttachedDriverID1.Trim();
                cmd.Parameters.Add("@Driver2_Name", SqlDbType.VarChar).Value = strAttachedDriverID2.Trim();

                cmd.Parameters.Add("@DOCKNO", SqlDbType.VarChar).Value = (strDocketNos != "") ? strDocketNos.Trim().Substring(0, strDocketNos.Length - 1) : strDocketNos;
                //cmd.Parameters.Add("@Vehicle_Name", SqlDbType.VarChar).Value = tb_Vehicle_Name.Text.ToUpper(); 

                cmd.ExecuteNonQuery();

                string mAdvAmt = "";
                SqlCommand cmdDEL = new SqlCommand();
                string sqlDEL = "";
                sqlDEL = "Delete from WEBX_TRIPSHEET_ADVEXP where TripSheetNo='" + mDocuementNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();
                string mBranchCode = "";
                foreach (DataGridItem gridrow in dgAdvanceDet.Items)
                {
                    //string mAdvPlace = ((DropDownList)gridrow.FindControl("cboAdvPlace")).SelectedItem.Value;
                    string mAdvPlace = ((TextBox)gridrow.FindControl("txtAdvPlace")).Text;

                    DateTime mAdvDt = new DateTime();
                    if (((TextBox)gridrow.FindControl("txtAdvDt")).Text != "")
                    {
                        mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);
                    }
                    mAdvAmt = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;

                    //mTotAdvExp = mTotAdvExp + Convert.ToDouble(mAdvAmt);

                    // string mTHCno = ((TextBox)gridrow.FindControl("txtTHCno")).Text;
                    mBranchCode = ((TextBox)gridrow.FindControl("txtBranchCode")).Text;
                    string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;




                    UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
                    DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
                    DropDownList dlstAcccode = (DropDownList)paymen.FindControl("dlstAcccode");

                    TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                    TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
                    TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");

                    string madv_Transtype = dlsttranstype.SelectedItem.Value;
                    if (madv_Transtype == "" || madv_Transtype == null)
                    {
                        madv_Transtype = "NULL";
                    }
                    else
                    {
                        madv_Transtype = "'" + madv_Transtype + "'";
                    }


                    string madv_Chqno = txtChqNo.Text;
                    if (madv_Chqno == "" || madv_Chqno == null)
                    {
                        madv_Chqno = "NULL";
                    }
                    else
                    {
                        madv_Chqno = "'" + madv_Chqno + "'";
                    }

                    string madv_Chqdate = txtChqDate.Text;
                    if (madv_Chqdate == "" || madv_Chqdate == null)
                    {
                        madv_Chqdate = "NULL";
                    }
                    else
                    {
                        madv_Chqdate = "'" + madv_Chqdate + "'";
                    }

                    string madv_acccode = dlstAcccode.SelectedItem.Value;
                    if (madv_acccode == "" || madv_acccode == null)
                    {
                        madv_acccode = "NULL";
                    }
                    else
                    {
                        madv_acccode = "'" + madv_acccode + "'";
                    }


                    string mEntryby = "'" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "'";

                    if (mAdvAmt != "" && mAdvAmt != null)
                    {
                        sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature,adv_Transtype,adv_Chqno,adv_Chqdate,adv_acccode,Entryby,COMPANY_CODE) values ("
                             + "'" + mDocuementNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "'," + madv_Transtype + "," + madv_Chqno + "," + madv_Chqdate + "," + madv_acccode + "," + mEntryby + ",'" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "') ";
                        SqlCommand AdvDetail = new SqlCommand(sql, conn, trans);
                        AdvDetail.CommandType = CommandType.Text;

                        //datarow_Adv = _dataSet.AdvanceTaken[gridrow.DataSetIndex];

                        //_dataSet.AdvanceTaken[gridrow.DataSetIndex].ItemArray = datarow_Adv.ItemArray;

                        AdvDetail.ExecuteNonQuery();
                    }
                }
                if (mAdvAmt != "")
                {
                    sql = " Update WEBX_FLEET_VEHICLE_ISSUE set TotAdvExp='" + mAdvAmt + "' Where VSlipNo ='" + mDocuementNo + "' ";
                    SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
                    TripHeader.CommandType = CommandType.Text;
                    TripHeader.ExecuteNonQuery();
                }

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


                //sql = " Update webx_vehicle_hdr set Vehicle_Status='Available' where vehno='" + lblVehno.Text + "'";
                //SqlCommand VH = new SqlCommand(sql, conn, trans);
                //VH.CommandType = CommandType.Text;
                //VH.ExecuteNonQuery();


                //----------------- FLEET TRANSACTION -----------------------------------
                string mFinYear = "";
                mFinYear = SessionUtilities.FinYear.ToString();
                string mYearVal = "";
                mYearVal = objFinYear.FinancialYear();

                string sqlAcc = "Usp_FleetTransaction";
                SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = mBranchCode;// SessionUtilities.CurrentBranchCode.ToString().Trim();
                sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "3";
                sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mDocuementNo;
                sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear; //2001
                sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal; // 09_10
                sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10


                sqlcmdAcc.ExecuteNonQuery();
                //------------------------------------------------------------------------
                //trans.Rollback();
                trans.Commit();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                //Response.Write("Error" + e1.Message);
                //trans.Rollback();
                Response.End();
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


    //protected void txtVehNo_TextChanged(object sender, EventArgs e)
    //{
    //    if (txtVehNo.Text != "" && lblVehCheck.Text == "")
    //    {
    //        Session["VEHNO"] = txtVehNo.Text.Trim();
    //        BindDropDown("USP_TRIPROUTE_Tripsheet", "RUTDESC", "RUTCD", ddlRoute);
    //    }
    //    else
    //    {
    //        Session["VEHNO"] = null;
    //    }
    //    if (cboVehno.SelectedIndex != 0)
    //    {
    //        Session["VEHNO"] = cboVehno.SelectedValue.Trim();
    //        BindDropDown("USP_TRIPROUTE_Tripsheet", "RUTDESC", "RUTCD", ddlRoute);
    //    }
    //    else
    //    {
    //        Session["VEHNO"] = null;
    //    }
    //}



}

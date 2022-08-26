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

public partial class Issue_frmVehicleIssueSlipNewNext : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.RequestDetRow datarow;
  //  public MyFleetDataSet _dataSet = new MyFleetDataSet();
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;

    string strOrgnCity, strOrgnLoc, strStartDt, strVehType;
    string strPassNo;
    string strReqDt, strDestnCity, strEndDt;
    string strReqId, strReqBy,strIssueDt;
    string mManualTripSheetNo = "";


    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);


        //btnBack.Attributes.Add("onclick", "return confirm('Are you sure you want to clear Data?')");
        


        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            btnBack.Attributes.Add("onclick", "window.history.go(-1);");
            strReqId = Request.QueryString["ReqId"];
            strIssueDt = Request.QueryString["IssueDt"];
            mManualTripSheetNo = Request.QueryString["ManualTripSheetNo"];
            lblIssueDt.Text = strIssueDt;
            lblManualTripSheetNo.Text = mManualTripSheetNo;
            txtStartLoc.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();
            txtEndLoc.Text = SessionUtilities.CurrentBranchCode.ToString().Trim();
            string scr3 = @"<script>
                    function update1111(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtEndLoc').value=elemValue;
                     document.getElementById('ctl00_MyCPH1_txtEndLoc').focus()
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1111", scr3);
            btnPopupLoc.Attributes.Add("onclick", "window.open('../../../operation/Singlescreen_docketentry/popup-branch_level4.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');return false;");


            InitializeData();

            Inetialized_AdvanceTaken();
            BindGrid();

            //LoadDriverData();

        }
    }


    public void Inetialized_AdvanceTaken()
    {
        _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
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





    private void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.RequestDet;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;


        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;


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

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);
            DataSet ds = new DataSet();


            
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);

            if (e.Item.ItemIndex >= -1)
            {
                //string strSelRadio = ((RadioButton)e.Item.FindControl("chksel")).ClientID;
                //((RadioButton)e.Item.FindControl("chksel")).Attributes.Add("onClick", "fnCheckSel('" + strSelRadio + "')");

            }
            
            ((RadioButton)e.Item.FindControl("chksel")).Checked = true;// datarow.Chksel;
            ((TextBox)e.Item.FindControl("txtReqId")).Text = datarow.RequestId;
            ((TextBox)e.Item.FindControl("txtReqBy")).Text = datarow.Request_By;
            ((TextBox)e.Item.FindControl("txtReqDt")).Text = datarow.Request_Dt;
            ((TextBox)e.Item.FindControl("txtOrgnCity")).Text = datarow.Orgn_City;
            ((TextBox)e.Item.FindControl("txtDestnCity")).Text = datarow.Destn_City;

            ((TextBox)e.Item.FindControl("txtStDt")).Text = datarow.Start_Dt;
            ((TextBox)e.Item.FindControl("txtEdDt")).Text = datarow.End_Dt;
            //((TextBox)e.Item.FindControl("txtPassNo")).Text = datarow.Pass_No;
            ((TextBox)e.Item.FindControl("txtVehType")).Text = datarow.Vehtype;
            //((DropDownList)e.Item.FindControl("cboVehno")).SelectedItem.Value = datarow.Vehno;





        }
    }

    public void InitializeData()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        lblDataError.Text = "";
        string DataFound = "N";
        strOrgnCity = ""; strOrgnLoc = ""; strStartDt = ""; strEndDt = ""; strVehType = "";
        strReqDt = "";
        strDestnCity = ""; strPassNo = "";
        strReqBy = ""; //strReqId = "";
        string  CustCode = "", Category = "", Market_Own = "";

        SqlCommand cmdREQ = new SqlCommand("usp_RequestListForIssue", conn);
        cmdREQ.CommandType = CommandType.StoredProcedure;
        //strReqId

        //strStartDt = Request.QueryString["StartDt"].ToString().Trim();
        //strOrgnCity = Request.QueryString["OrgnCity"].ToString().Trim();
        //strOrgnLoc = Request.QueryString["OrgnLoc"].ToString().Trim();
        //if (strOrgnLoc == "" || strOrgnLoc == null)
        //{
        //    strOrgnLoc = "";
        //}
        //strVehType = Request.QueryString["VehType"].ToString().Trim();
        //strPassNo = Request.QueryString["Pass_no"].ToString().Trim();

        cmdREQ.Parameters.AddWithValue("@StartDt", strStartDt);
        cmdREQ.Parameters.AddWithValue("@EndDt", strEndDt);
        
        cmdREQ.Parameters.AddWithValue("@OrgnCity", strOrgnCity);
        //cmdREQ.Parameters.AddWithValue("@OrgnLoc", strOrgnLoc);
        cmdREQ.Parameters.AddWithValue("@VehType", strVehType);
        //cmdREQ.Parameters.AddWithValue("@Pass_No", strPassNo);
        cmdREQ.Parameters.AddWithValue("@ReqId", strReqId);

        conn.Open();
        SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();


        while (dataReadREQ.Read())
        {
            DataFound = "Y";
            strReqId = dataReadREQ["Request_Id"].ToString();
            strReqBy = dataReadREQ["Request_By"].ToString();
            strReqDt = dataReadREQ["Request_dt"].ToString();
            strOrgnCity = dataReadREQ["Orgn_city"].ToString();
            strDestnCity = dataReadREQ["Destn_city"].ToString();
            strStartDt = dataReadREQ["Start_date_time"].ToString();
            strEndDt = dataReadREQ["End_dt_tm"].ToString();
            strPassNo = dataReadREQ["No_Passenger"].ToString();
            strVehType = dataReadREQ["Vehtype"].ToString();

            CustCode = dataReadREQ["CustCode"].ToString();
            Category = dataReadREQ["Category"].ToString();
            Market_Own = dataReadREQ["Market_Own"].ToString();





            _dataSet.RequestDet.AddRequestDetRow(false, strReqId, strReqBy, strReqDt, strOrgnCity, strDestnCity, strStartDt, strEndDt, strPassNo, strVehType, "", "");


        }

        dataReadREQ.Close();


        // New Change

        if (Category.ToString().Trim() != "" && Category.ToString().Trim() != null)
        {





            for (int i = 0; i < ddlCategory.Items.Count; i++)
            {
                if (Category.ToString().Trim() == ddlCategory.Items[i].Text.Trim())
                {
                    ddlCategory.SelectedIndex = i;
                }
            }



        lblCutcode.Visible = false;
        lblPopup.Visible = false;
        txtCustCode.Visible = false;
        Table1.Visible = false;
        lblMarket_own.Visible = false;
        ddlMarket.Visible = false;


        ReqMarket.Visible = false;



        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "External Usage")
        {

            lblCutcode.Visible = true;
            lblPopup.Visible = true;
            txtCustCode.Visible = true;
            Table1.Visible = true;
            lblMarket_own.Visible = false;
            ddlMarket.Visible = false;
            ReqMarket.Visible = false;

            txtCustCode.Text = CustCode.ToString().Trim();




        }
        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "Internal Usage")
        {

            lblCutcode.Visible = false;
            txtCustCode.Visible = false;
            Table1.Visible = true;
            lblMarket_own.Visible = true;
            ddlMarket.Visible = true;
            ReqMarket.Visible = true;
            lblPopup.Visible = false;



                for (int i = 0; i < ddlMarket.Items.Count; i++)
                {

                    if (Market_Own.ToString().Trim() == ddlMarket.Items[i].Text.Trim())
                    {

                        ddlMarket.SelectedIndex = i;

                    }
               }

            
           

        }









        }
        












        // New Change

        string msql = "select  TSWithVehicle_Valid ,TS_VehicleFilter_Loc from   WebX_Setup_Process";
        string TSWithVehicle_Valid = "", TS_VehicleFilter_Loc = "";

        string strValid = "", strLocFilter = "";
        SqlCommand sql1 = new SqlCommand(msql, conn);
        sql1.CommandType = CommandType.Text;

      //  sql1.Parameters.Add("@Vehicle_Valid", SqlDbType.VarChar).Value = "AAA";

        SqlDataReader mr1 = sql1.ExecuteReader();


        if (mr1.HasRows)
        {
            while (mr1.Read())
            {


                TSWithVehicle_Valid = mr1["TSWithVehicle_Valid"].ToString().Trim();

                TS_VehicleFilter_Loc = mr1["TS_VehicleFilter_Loc"].ToString().Trim();

            }

            
        }
        mr1.Close();



        string STR1 = "select V.vehno from webx_vehicle_hdr V where 1=1  and  vendortype='05'";

        if (TSWithVehicle_Valid == "Y")
        {
            //  if (SessionUtilities.CurrentBranchCode.ToString().Trim() != "BWD")
           // {

                strValid = "   and   (V.Vehicle_Status='Available' or V.Vehicle_Status is null)";
        //    }
        }
        if (TS_VehicleFilter_Loc == "Y")
        {

            strLocFilter = "   and conrtl_branch='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";

        }


        STR1 = STR1 + strValid + strLocFilter + "  order by VEHNO";
        DataSet ds = new DataSet();


        SqlDataAdapter da = new SqlDataAdapter(STR1, conn);
        da.Fill(ds);
        cboVehno.DataSource = ds;
        cboVehno.DataTextField = "vehno";
        cboVehno.DataValueField = "vehno";
        cboVehno.DataBind();
        cboVehno.Items.Insert(0, "");
        cboVehno.Items[0].Selected = true;


        string Driver_WO_Vehicle = "N";
        string sql = "Select * from WebX_Setup_Process";
        SqlCommand sqlcmd1 = new SqlCommand(sql, conn);
        sqlcmd1.CommandType = CommandType.Text;
        SqlDataReader r1 = sqlcmd1.ExecuteReader();
        if (r1.Read())
        {
            if (r1["Driver_WO_Vehicle"] != null)
            {
                Driver_WO_Vehicle = r1["Driver_WO_Vehicle"].ToString().Trim();
            }
        }
        r1.Close();


        if (Driver_WO_Vehicle == "Y")
        {



       string        str = "select * from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  and (Driver_Status='Available' OR Driver_Status is null) Order by Driver_Name";
     

            SqlCommand cmd = new SqlCommand(str, conn);
            cboDriver1.Items.Clear();
            cboDriver2.Items.Clear();
     
            cboDriver1.Items.Insert(0, "");
            cboDriver2.Items.Insert(0, "");

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string MDCode = "";

                    MDCode = dr["Manual_Driver_Code"].ToString();

                    if (MDCode != "")
                    {
                        MDCode = ":" + MDCode;

                    }
                    else
                    {
                        MDCode = "";

                    }


                    cboDriver1.Items.Add(new ListItem(dr["Driver_Name"].ToString()+ MDCode, dr["Driver_Id"].ToString()));
                    cboDriver2.Items.Add(new ListItem(dr["Driver_Name"].ToString() + MDCode, dr["Driver_Id"].ToString()));
                }

            }

            dr.Close();

        }


        else
        {

            // string str1 = "select * from WEBX_FLEET_DRIVERMST where ActiveFlag='Y' and  Driver_Location='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'      and (Driver_Status='Available' OR Driver_Status is null) Order by Driver_Name";


            string str1 = "select * from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'    and    Driver_Location='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "' ";   
            string mBwdDriver = "";

            //if (SessionUtilities.CurrentBranchCode.ToString().Trim() == "BWD")
            //{

            //    mBwdDriver="";

            //}
            //else
            //{
                mBwdDriver=" and (Driver_Status='Available' OR Driver_Status is null)";

      //      }

   


             str1=str1 + mBwdDriver+"  Order by Driver_Name";
            
            
            
            
            
            
            
            
            
            SqlCommand cmd2 = new SqlCommand(str1, conn);

            cboDriver2.Items.Clear();

            cboDriver2.Items.Insert(0, "");

            SqlDataReader dr2 = cmd2.ExecuteReader();
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {
                    string MDCode = "";
                    MDCode = dr2["Manual_Driver_Code"].ToString();
                    if (MDCode != "")
                    {
                        MDCode = ":" + MDCode;

                    }
                    else
                    {
                        MDCode = "";

                    }

                    
                    cboDriver2.Items.Add(new ListItem(dr2["Driver_Name"].ToString() + MDCode, dr2["Driver_Id"].ToString()));
                }

            }

            dr2.Close();


        }



        
        conn.Close();

        if (DataFound == "N")
        {
            lblDataError.Text = "No Request Found !!!";
        }

    }


    public void RetrieveDriverDataInfo1(object sender, EventArgs e)
    {
       //  lblLicno.Text="";
        // lblValidDt.Text = "";

         if (cboDriver1.SelectedItem.Value != "" && cboDriver1.SelectedItem.Value != null)
         {

             SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

             string sql = "Select License_No,convert(varchar,Valdity_dt,103) Valdity_dt from WEBX_FLEET_DRIVERMST where Driver_Id=" + cboDriver1.SelectedItem.Value + "";
             SqlCommand cmdREQ = new SqlCommand(sql, conn);
             cmdREQ.CommandType = CommandType.Text;
             conn.Open();
             SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();
             while (dataReadREQ.Read())
             {
                 lblLicno.Text = dataReadREQ["License_No"].ToString();
                 lblValidDt.Text = dataReadREQ["Valdity_dt"].ToString();
             }
             dataReadREQ.Close();
             conn.Close();

         }

         else
         {
             lblLicno.Text = "";
             lblValidDt.Text = "";

         }
    }




    public void RetrieveDriverDataInfo2(object sender, EventArgs e)
    {
        //  lblLicno.Text="";
        // lblValidDt.Text = "";

        if (cboDriver2.SelectedItem.Value != "" && cboDriver2.SelectedItem.Value != null)
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            string sql = "Select License_No,convert(varchar,Valdity_dt,103) Valdity_dt from WEBX_FLEET_DRIVERMST where Driver_Id=" + cboDriver2.SelectedItem.Value + "";
            SqlCommand cmdREQ = new SqlCommand(sql, conn);
            cmdREQ.CommandType = CommandType.Text;
            conn.Open();
            SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();
            while (dataReadREQ.Read())
            {
                lblLicnoD2.Text = dataReadREQ["License_No"].ToString();
                lblValidDtD2.Text = dataReadREQ["Valdity_dt"].ToString();
            }
            dataReadREQ.Close();
            conn.Close();

        }

        else
        {
            lblLicnoD2.Text = "";
            lblValidDtD2.Text = "";

        }
    }






    protected void SubmitData(object sender, EventArgs e)
    {
        string mDocuementNo = "", mCheck = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        string sql = "";




        DateTime mServerDt = DateTime.Now;
        DateTime mIssueDt = new DateTime();
        mIssueDt = Convert.ToDateTime(lblIssueDt.Text.ToString().Trim(), dtfi);

        lblError.Text = "";




        if (cboDriver1.SelectedItem.Value == cboDriver2.SelectedItem.Value)
        {
            lblError.Text = "Second Driver should  not  be same as  Driver1 !";

        }






        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {
            DateTime mAdvDt = new DateTime();
            if (((TextBox)gridrow.FindControl("txtAdvDt")).Text != "")
            {
                mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);
                if (mAdvDt > mServerDt)
                {
                    lblError.Text = "Advance Date should not be greater than Issue Slip date!";
                }

                if (mAdvDt < mIssueDt)
                {
                    lblError.Text = "Advance Date should not be less than Issue Slip Date!";
                }
            }
        }



        


        if (lblError.Text == "")
        {





            bool success = false;
            SqlTransaction trans;

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            conn.Open();
            trans = conn.BeginTransaction();
            try
            {




                string msql = "usp_CheckTS";
                SqlCommand msqlcmd1 = new SqlCommand(msql, conn, trans);
                msqlcmd1.CommandType = CommandType.StoredProcedure;
                // sqlcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "ISSUE";
               msqlcmd1.Parameters.Add("@Flag", SqlDbType.VarChar).Value ="TS";

                SqlDataReader mr1 = msqlcmd1.ExecuteReader();
                if (mr1.Read())
                {
                    mCheck = mr1[0].ToString().Trim();
                }
                mr1.Close();



                if (mCheck == "TS")
                {
                     string YearVal = "";


                      GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                      YearVal = objFinYear.FinancialYear();

 
                    string mSTR = "WebX_SP_GetNextDocumentCode";
                    SqlCommand mcmd1 = new SqlCommand(mSTR, conn, trans);
                    mcmd1.CommandType = CommandType.StoredProcedure;

                    mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                 //   mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = "AAAA";

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

                    //string thisYear = Convert.ToString(lblIssueDt.Text.Trim());

     

                    //string[] selvaluesArr2;

                    //selvaluesArr2 = thisYear.Split(new char[] { '/' });

                    //int maxarr2 = selvaluesArr2.GetUpperBound(0);

                    //for (int i = 0; i <= maxarr2; i++)
                    //{

                    //    mYear = selvaluesArr2[2].ToString().Trim();
                    //}

                     

                      sql = "usp_GetDocumentNo";
                    SqlCommand sqlcmd1 = new SqlCommand(sql, conn, trans);
                    sqlcmd1.CommandType = CommandType.StoredProcedure;
                    sqlcmd1.Parameters.Add("@DTYPE", SqlDbType.VarChar).Value = "ISSUE";

                //    sqlcmd1.Parameters.Add("@YEAR", SqlDbType.VarChar).Value = mYear.Substring(0, 4).Trim();
                    
                    
                    SqlDataReader r1 = sqlcmd1.ExecuteReader();
                    if (r1.Read())
                    {
                        mDocuementNo = r1[0].ToString();
                    }
                    r1.Close();


                }





                SqlCommand cmd = new SqlCommand("usp_AddVehicleIssue", conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = mDocuementNo;
                cmd.Parameters.Add("@VSlipDt", SqlDbType.DateTime).Value = Convert.ToDateTime(lblIssueDt.Text.ToString().Trim(), dtfi);
                cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = cboVehno.SelectedItem.Value;
                cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = cboDriver1.SelectedValue;
                cmd.Parameters.Add("@Driver2", SqlDbType.VarChar).Value = cboDriver2.SelectedValue;
                cmd.Parameters.Add("@VehiclePath", SqlDbType.VarChar).Value = "-";
                cmd.Parameters.Add("@f_issue_startkm", SqlDbType.VarChar).Value = txtStartKM.Text.ToString().Trim();
                cmd.Parameters.Add("@f_issue_fill", SqlDbType.VarChar).Value = txtFuel.Text.ToString().Trim();
                cmd.Parameters.Add("@Manual_TripSheetNo", SqlDbType.VarChar).Value = lblManualTripSheetNo.Text.ToString().Trim();


                 // New Change

                cmd.Parameters.Add("@StartLoc", SqlDbType.VarChar).Value = txtStartLoc.Text.ToString().Trim();
                cmd.Parameters.Add("@EndLoc", SqlDbType.VarChar).Value = txtEndLoc.Text.ToString().Trim();





                // New  change

                cmd.Parameters.Add("@Category", SqlDbType.VarChar).Value = ddlCategory.SelectedItem.Value.ToString().Trim();
                cmd.Parameters.Add("@CustCode", SqlDbType.VarChar).Value = txtCustCode.Text.ToString().Trim();
                cmd.Parameters.Add("@M_Own", SqlDbType.VarChar).Value = ddlMarket.SelectedItem.Value.ToString().Trim();
              








                cmd.ExecuteNonQuery();


                foreach (DataGridItem gridrow in DataGrid1.Items)
                {
                    SqlCommand Detail = new SqlCommand("usp_UpdateRequestVehicleIssue", conn, trans);
                    Detail.CommandType = CommandType.StoredProcedure;

                    string mReqId = ((TextBox)gridrow.FindControl("txtReqId")).Text;

                    datarow = _dataSet.RequestDet[gridrow.DataSetIndex];


                    Detail.Parameters.Add("@ReqId", SqlDbType.VarChar).Value = mReqId.Trim();
                    Detail.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = mDocuementNo.Trim();
                    Detail.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = cboVehno.SelectedItem.Value;
                    Detail.Parameters.Add("@Start_km", SqlDbType.VarChar).Value = txtStartKM.Text.ToString().Trim();
                    Detail.Parameters.Add("@End_km", SqlDbType.VarChar).Value = "";
                    Detail.Parameters.Add("@End_dt", SqlDbType.DateTime).Value = Convert.ToDateTime("01/01/1900", dtfi);
                    Detail.Parameters.Add("@End_tm", SqlDbType.VarChar).Value = "";
                    Detail.Parameters.Add("@IssueMode", SqlDbType.VarChar).Value = "START";

                    _dataSet.RequestDet[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;

                    Detail.ExecuteNonQuery();



                    string mAdvAmt = "";
                    SqlCommand cmdDEL = new SqlCommand();
                    string sqlDEL = "";
                    sqlDEL = "Delete from WEBX_TRIPSHEET_ADVEXP where TripSheetNo='" + mDocuementNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                    foreach (DataGridItem gridrow1 in dgAdvanceDet.Items)
                    {
                        //string mAdvPlace = ((DropDownList)gridrow.FindControl("cboAdvPlace")).SelectedItem.Value;
                        string mAdvPlace = ((TextBox)gridrow1.FindControl("txtAdvPlace")).Text;

                        DateTime mAdvDt = new DateTime();
                        if (((TextBox)gridrow1.FindControl("txtAdvDt")).Text != "")
                        {
                            mAdvDt = Convert.ToDateTime(((TextBox)gridrow1.FindControl("txtAdvDt")).Text, dtfi);
                        }
                        mAdvAmt = ((TextBox)gridrow1.FindControl("txtAdvAmt")).Text;

                        //mTotAdvExp = mTotAdvExp + Convert.ToDouble(mAdvAmt);

                        // string mTHCno = ((TextBox)gridrow.FindControl("txtTHCno")).Text;
                        string mBranchCode = ((TextBox)gridrow1.FindControl("txtBranchCode")).Text;
                        string mSignature = ((TextBox)gridrow1.FindControl("txtSignature")).Text;

                        if (mAdvAmt != "" && mAdvAmt != null)
                        {
                            sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature) values ("
                                 + "'" + mDocuementNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "') ";
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















                }
       trans.Commit();



          //    trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
                //Response.Redirect("frmVehicleIssueSlipNew_result.aspx?VSlipId=" + mDocuementNo.Trim(), true);
                Response.Redirect("frmVehicleIssueSlipNew_result.aspx?VSlipId=" + mDocuementNo.Trim() + "&TripSheetType=D", true);
        }













}


    protected void BackData(object sender, EventArgs e)
    {

    }


    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblCutcode.Visible = false;
        lblPopup.Visible = false;
        txtCustCode.Visible = false;
        Table1.Visible = false;
        lblMarket_own.Visible = false;
        ddlMarket.Visible = false;


        ReqMarket.Visible = false;



        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "External Usage")
        {

            lblCutcode.Visible = true;
            lblPopup.Visible = true;
            txtCustCode.Visible = true;
            Table1.Visible = true;
            lblMarket_own.Visible = false;
            ddlMarket.Visible = false;
            ReqMarket.Visible = false;
        }
        if (ddlCategory.SelectedItem.Text.ToString().Trim() == "Internal Usage")
        {

            lblCutcode.Visible = false;
            txtCustCode.Visible = false;
            Table1.Visible = true;
            lblMarket_own.Visible = true;
            ddlMarket.Visible = true;
            ReqMarket.Visible = true;
            lblPopup.Visible = false;



        }
    }




    protected void txtCustCode_TextChanged1(object sender, EventArgs e)
    {
        if (txtCustCode.Text.ToString().Trim() != "")
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string DataFound = "N";
            string str = "Select * from webx_CUSTHDR where CUST_ACTIVE='Y' and custcd='" + txtCustCode.Text.ToString().Trim() + "'";
            SqlCommand cmd = new SqlCommand(str, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    DataFound = "Y";

                }
            }
            dr.Close();
            conn.Close();
            if (DataFound == "N")
            {


                lblErrorLocation1.Visible = true;

                lblErrorLocation1.Text = "Invalid Customer Code";
            }
            else
            {
                lblErrorLocation1.Text = "";

                lblErrorLocation1.Visible = false;

            }

        }
    }



    protected void cboVehno_SelectedIndexChanged(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        //DataSet dds = new DataSet();
        //string str = "select * from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'    and    VEHNO='" + cboVehno.SelectedItem.Text + "'         and (Driver_Status='Available' OR Driver_Status is null) Order by Driver_Name";
        //SqlDataAdapter dda = new SqlDataAdapter(str, conn);
        //dda.Fill(dds);
        //cboDriver.DataSource = dds;
        //cboDriver.DataTextField = "Driver_Name";
        //cboDriver.DataValueField = "Driver_Id";
        //cboDriver.DataBind();
        //cboDriver.Items.Insert(0, "");
        //cboDriver.Items[0].Selected = true;


        string Driver_WO_Vehicle = "N";
        string sql = "Select * from WebX_Setup_Process";
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlcmd1 = new SqlCommand(sql, conn);
        SqlDataReader r1 = sqlcmd1.ExecuteReader();
        if (r1.Read())
        {
            if (r1["Driver_WO_Vehicle"] != null)
            {
                Driver_WO_Vehicle = r1["Driver_WO_Vehicle"].ToString().Trim();
            }
        }
        r1.Close();


        if (Driver_WO_Vehicle == "N")
        {

                string str = "select * from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'    and    VEHNO='" + cboVehno.SelectedItem.Text + "'"  ;  
            string mBwdDriver = "";

            //if (SessionUtilities.CurrentBranchCode.ToString().Trim() == "BWD")
            //{

            //    mBwdDriver="";

            //}
            //else
            //{
                mBwdDriver="and (Driver_Status='Available' OR Driver_Status is null)";

          //  }

   


             str=str + mBwdDriver + "  Order by Driver_Name";
                       
                      
            
            SqlCommand cmd = new SqlCommand(str, conn);
            cboDriver1.Items.Clear();
         
     
            cboDriver1.Items.Insert(0, "");
        
            
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string MDCode = "";
                    MDCode = dr["Manual_Driver_Code"].ToString();
                     if (MDCode != "")
                    {
                        MDCode = ":" + MDCode;

                    }
                    else
                    {
                        MDCode = "";

                    }

                    cboDriver1.Items.Add(new ListItem(dr["Driver_Name"].ToString()+MDCode, dr["Driver_Id"].ToString()));
                
                }

            }

            dr.Close();
 
        }

 
        conn.Close();

    }
}

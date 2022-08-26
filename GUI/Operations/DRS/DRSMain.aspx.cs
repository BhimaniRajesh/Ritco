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

public partial class GUI_Operations_DRS_DRSCreateMain : System.Web.UI.Page
{
    //private GridViewHelper helper;

    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static string mBrCd = "";
    public static string DocDateRange = "";

    public static int dktCount = 0;
    public string YearVal = "";
    
    public static DateTime dt1, dt2;

    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();

    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        dtToday = DateTime.Now.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        mBrCd = Session["brcd"].ToString().Trim();

        MySQLDataSource_VendorTypes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vendors.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicles.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicle_Types.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_TranMode.ConnectionString = Session["SqlProvider"].ToString().Trim();

        DocDateRangeProc();
        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";


        //dtFrom = Convert.ToDateTime("01/04/2007", dtfi);
        //dtTo = Convert.ToDateTime("31/03/2008", dtfi);

        //RVDate.MinimumValue = dtFrom.ToShortDateString().ToString();
        //RVDate.MaximumValue = dtTo.ToShortDateString().ToString();
    }

    protected void DocDateRangeProc()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        
        //DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
        if (Session["FinYear_Change"] != null)
        {
            YearVal = Session["FinYear_Change"].ToString().Trim();
        }

        string sql = "usp_DateRange";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@finval", SqlDbType.VarChar).Value = YearVal;


        SqlDataReader dr = sqlCmd.ExecuteReader();

        while (dr.Read())
        {
            DocDateRange= dr[0].ToString().Trim();
        }

        sqlCon.Close();    
    }

    protected void OnVendorTypeChange(object sender, EventArgs e)
    {
        tblDocketList.Visible = false;

        DropDownList dl = (DropDownList)sender;
        txtMarketVendor.Text = dl.Items[dl.SelectedIndex].Text;
        txtMarketVendor.Visible = false;
        txtVehicle.Visible = false;
        if (dl.Items[dl.SelectedIndex].Value == "XX")
        {
            txtMarketVendor.Text = "";
            txtMarketVendor.Visible = true;
        }
    }

//DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
//if (mpLabel != null)
//{
//YearVal = mpLabel.SelectedItem.Value;
//}

    protected void OnVendorChange(object sender, EventArgs e)
    {
        txtVehicle.Visible = false;
    }

    protected void OnVehicleChange(object sender, EventArgs e)
    {
        DropDownList dl = (DropDownList)sender;
        txtVehicle.Text = dl.Items[dl.SelectedIndex].Value;
        txtVehicle.Visible = false;
        if (dl.Items[dl.SelectedIndex].Value == "O")
        {
            txtVehicle.Text = "";
            txtVehicle.Visible = true;
        }
    }

    protected void ListDocketsForDRSGeneration(object sender, EventArgs e)
    {
        tblResult.Visible = false;
        tblNoDocketsSelected.Visible = false;
        tblDocketList.Visible = true;

        BindGrid();
    }

    protected void BindGrid()
    {
        SetDataSet();
        dgDockets.DataSource = ds;
        dgDockets.DataBind();
    }

    protected void SetDataSet()
    {
        int RecFound = 0;

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        FromToDateProc();


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        string sql = "usp_DocketList_For_DRS_Generation";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@docklist", SqlDbType.VarChar).Value = txtDocketList.Text;
        sqlCmd.Parameters.Add("@from_bkg_arrv_date", SqlDbType.DateTime).Value = dtFrom;
        sqlCmd.Parameters.Add("@to_bkg_arrv_date", SqlDbType.DateTime).Value = dtTo;
        sqlCmd.Parameters.Add("@dt_flag", SqlDbType.Char).Value = cboDocketDate.Items[cboDocketDate.SelectedIndex].Value;
        sqlCmd.Parameters.Add("@drs_date", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate.Text, dtfi);
        sqlCmd.Parameters.Add("@trn_mode ", SqlDbType.VarChar).Value = cboTranMode.Items[cboTranMode.SelectedIndex].Value; 
        
        
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;

        tblSubmitBtn.Visible = true;
        if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
        {
            tblSubmitBtn.Visible = false;
        }

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------
    }

    protected void ResetDocketList(object sender, EventArgs e)
    {
        tblDocketList.Visible = false;
        tblSubmitBtn.Visible = false;
        tblResult.Visible = false;
        tblNoDocketsSelected.Visible = false;
    }

    protected void FromToDateProc()
    {
        //int RecFound = 0;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        //From - To Date Range
        if (radFromToDate.Checked)
        {
            try
            {
                dtFrom = Convert.ToDateTime(txtFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtTo.Text, dtfi);
            }
            catch (Exception ex)
            {
                radToday.Checked = true;
            }
        }
        //--------------------------------

        //Today Date
        if (radToday.Checked)
        {
            dtFrom = Convert.ToDateTime(dtToday, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Last Week Date
        if (radLastWeek.Checked)
        {
            string dt2Str;

            dt2 = DateTime.Now.AddDays(-6);
            dt2Str = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();

            dtFrom = Convert.ToDateTime(dt2Str, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Till Date
        if (radTillDate.Checked)
        {
            dtFrom = Convert.ToDateTime("01/01/1900");
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------
    }

    protected string GenerateArgument()
    {
        //dgGeneral.DataKeys[index].Values[1].ToString().Trim();
        string arg = "";
        dktCount = 0;
        for (int index = 0; index < dgDockets.Rows.Count; index++)
        {
            //DOCKETS CSV
            CheckBox chkDocket = (CheckBox)dgDockets.Rows[index].FindControl("chkDocket");

            if (chkDocket.Checked == true)
            {
                dktCount += 1;
                if (arg == "")
                {
                    arg = dgDockets.DataKeys[index].Values[0].ToString().Trim() + dgDockets.DataKeys[index].Values[1].ToString().Trim();
                }
                else
                {
                    arg = arg + "," + dgDockets.DataKeys[index].Values[0].ToString().Trim() + dgDockets.DataKeys[index].Values[1].ToString().Trim();
                }
            }
        }
        return arg;
    }

    //protected void MyCal1(object sender, EventArgs e)
    //{
    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //    dtfi.DateSeparator = "/";

    //    mycal1.Visible = false;
        
    //    //txtFrom.Text = Convert.ToDateTime(mycal1.SelectedDate(), dtfi); 
    //}

    //protected void ShowCal1(object sender, EventArgs e)
    //{
    //    mycal1.Visible = true;
    //}

    protected void GenerateDRS(object sender, EventArgs e)
    {
        tblNoDocketsSelected.Visible = false;
        string DocketList = GenerateArgument();
        if (DocketList != "")
        {
            btnCreateDRS.Enabled = false;
            //Make & Open Connection
            SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            sqlCon.Open();
            //--------------------------------

            FromToDateProc();


            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            string sql = "usp_drs_generate";
            SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
            sqlCmd.Parameters.Add("@manpdcno", SqlDbType.VarChar).Value = txtManCode.Text.Trim();
            sqlCmd.Parameters.Add("@pdcdt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate.Text, dtfi);
            sqlCmd.Parameters.Add("@pdctype", SqlDbType.VarChar).Value = "D";

            if (cboVendorType.Items[cboVendorType.SelectedIndex].Value == "08")//If BA
            {
                sqlCmd.Parameters.Add("@bacode", SqlDbType.VarChar).Value = cboVendors.Items[cboVendors.SelectedIndex].Value;
            }

            if (cboVendorType.Items[cboVendorType.SelectedIndex].Value != "08")//If Not BA
            {
                sqlCmd.Parameters.Add("@bacode", SqlDbType.VarChar).Value = "";
            }

            if (cboVendorType.Items[cboVendorType.SelectedIndex].Value != "XX")//If Not Market
            {
                sqlCmd.Parameters.Add("@vendorcode", SqlDbType.VarChar).Value = cboVendors.Items[cboVendors.SelectedIndex].Value;
                sqlCmd.Parameters.Add("@marketveh", SqlDbType.VarChar).Value = "N";
            }
            else
            {
                sqlCmd.Parameters.Add("@vendorcode", SqlDbType.VarChar).Value = "8888";
                sqlCmd.Parameters.Add("@marketveh", SqlDbType.VarChar).Value = "Y";
            }
            sqlCmd.Parameters.Add("@vendorname", SqlDbType.Char).Value = txtMarketVendor.Text.Trim();
            sqlCmd.Parameters.Add("@vehicleno", SqlDbType.VarChar).Value = txtVehicle.Text.Trim();
            sqlCmd.Parameters.Add("@vehicletype", SqlDbType.VarChar).Value = cboVehicleTypes.Items[cboVehicleTypes.SelectedIndex].Value;

            sqlCmd.Parameters.Add("@drivername", SqlDbType.VarChar).Value = txtDriver.Text.Trim();

            sqlCmd.Parameters.Add("@startkm", SqlDbType.Int).Value = Convert.ToInt32(txtStartKM.Text);
            sqlCmd.Parameters.Add("@endkm", SqlDbType.Int).Value = 0;

            sqlCmd.Parameters.Add("@staff", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
            sqlCmd.Parameters.Add("@empcd", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();

            sqlCmd.Parameters.Add("@docketlist", SqlDbType.VarChar).Value = DocketList.Trim();
            sqlCmd.Parameters.Add("@TotalDockets", SqlDbType.Int).Value = dktCount;

            sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();
            sqlCmd.Parameters.Add("@dept_time", SqlDbType.VarChar).Value = txtHHMM.Text.Trim();
            sqlCmd.Parameters.Add("@trn_mod", SqlDbType.VarChar).Value = cboTranMode.Items[cboTranMode.SelectedIndex].Value; 
            
            
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

            //DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();

            dgResult.DataSource = ds;
            dgResult.DataBind();

            string strNextDRSCode = "";
            strNextDRSCode = ds.Tables[0].Rows[0]["PDCNo"].ToString();
            //----------------------------------------
            /*helper = new GridViewHelper(this.dgResult, false);
            helper.RegisterGroup("DRS #",true,true);
            helper.ApplyGroupSort();*/
            //----------------------------------------

            tblDocketCreteria.Visible = false;
            tblNote.Visible = false;
            tblDRSHeader.Visible = false;
            tblDocketList.Visible = false;
            tblSubmitBtn.Visible = false;
            tblResult.Visible = true;

            if (strNextDRSCode != "DRS Generation Failed")
            {
                Response.Redirect("~/GUI/Operations/DRS/GenerateDRSResult.aspx?DRSCode=" + strNextDRSCode + "&DocketList=" + DocketList.Trim());
            }

        }
        else
        {
            tblNoDocketsSelected.Visible = true;
        }
    }

    //protected void PrevDRSScreen(Object sender, CommandEventArgs e)
    //{
    //    tblDocketCreteria.Visible = true;
    //    tblNote.Visible = true;
    //    tblDRSHeader.Visible = true;
    //    tblDocketList.Visible = false;
    //    tblSubmitBtn.Visible = false;
    //    tblResult.Visible = false;
    //}
}

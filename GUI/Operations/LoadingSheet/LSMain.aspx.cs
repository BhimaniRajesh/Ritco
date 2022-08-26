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

public partial class GUI_Operations_LoadingSheet_LSMain : System.Web.UI.Page
{
    public static string strLSCaption;
    public static string strSQL;

    //For Docket Listing
    static string strFromDate;
    static string strToDate;
    static string strManualLSNo;
    static string strDocketList;
    static string strDocketNoList;
    static string strDocketIDList;
    static string strNextLocation;
    public static string strNextLoadingSheetNo;
    static string strDestination;
    static string strFromCity;
    static string strToCity;
    static string strRegion;
    static bool blnPostSQL;
    public static string strSystemDate;
    public static string strLastWeekFromDate;
    public static string strLastWeekToDate;

    public static int intTotalRecords;
    static bool blnCheckAllClicked = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strSystemDate = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtLSDate.Value = strSystemDate;
            HidSystemDate.Value = strSystemDate;
            lblToday.InnerHtml = "Today: " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
            radLastWeek.Checked = true;

            DateTime dtLastWeek = System.DateTime.Today.AddDays(-6);

            strLastWeekFromDate = dtLastWeek.ToString("dd/MM/yyyy");
            strLastWeekToDate = System.DateTime.Today.ToString("dd/MM/yyyy");

            chkAll.Attributes.Add("title", "Click this box for selection of all " + HidDocket.Value + "s");
            btnSubmit.Attributes.Add("ToolTip", "Click here to search " + HidDocket.Value + "(s) based on given criteria");

            getLSManualNoMandatoryYN();

            //populateZoneDetails();

            populateMOT();

            populateRegionLocations();

            getDocumentDetails();

            txtPrepBy.Text = Session["empcd"].ToString();
            lblPrepByName.InnerHtml = Session["empnm"].ToString();
            
            txtLSDate.Focus();
        }

        lblSelDcoketCriteria.InnerHtml = "<b>Select " + HidDocket.Value + " Criteria</b>";
        lblSelDcoketDate.InnerHtml = "Select " + HidDocket.Value + " Date:";
        lblDcoketNo1.InnerHtml = HidDocket.Value + " No.";
        lblDcoketNo.InnerHtml = HidDocket.Value + " No.";
        lblNoDocketsForRoute.InnerHtml = "No " + HidDocket.Value + "s Found for the given Route";
        lblDockets.InnerHtml = HidDocket.Value + "(s):";
        lblHintForLSDate.InnerHtml = "&nbsp;Hint: Only " + HidDocket.Value + "s booked upto this date can be selected";

        lblHeader.InnerHtml = "<b>Prepare New " + HidLS.Value + "</b>";
        lblSelCrtForLS.InnerHtml = "<b>Select Criteria For Preparing " + HidLS.Value + "</b>";
        lblLSNo1.InnerHtml = HidLS.Value + " No.:";
        lblLSNo.InnerHtml = "<b>" + HidLS.Value + " No.&nbsp;</b>";
        lblLSDate.InnerHtml = HidLS.Value + " Date:";
        lblManLSNo.InnerHtml = "Manual " + HidLS.Value + " No.:";
        lblManualLSNo.InnerHtml = "&nbsp;Duplicate Manual " + HidLS.Value + " No.!!!";
        lblHelpForManLSNo.InnerHtml = "&nbsp;Hint: Enter NA if Manual " + HidLS.Value + " No. is not available.";
        lblHintForNextStop.InnerHtml = "(<i>" + HidLS.Value + " will be prepared for this Next Location</i>)";

        btnPrepareLS.Text = "Prepare " + HidLS.Value;
    }

    protected void txtNextStop_TextChanged(object sender, EventArgs e)
    {
        trDocketList.Visible = false;
        Session["destination"] = "";

        //Check for Next Location
        txtNextStop.Text = txtNextStop.Text.Trim().ToUpper();

        if (txtNextStop.Text == "")
        {
            lblErrorNextStop.Visible = false;
            return;
        }
        /*else if(txtNextStop.Text == Session["brcd"].ToString().Trim().ToUpper())
        {
            lblErrorNextStop.Visible = true;
            return;
        }*/

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLNextStop = "SELECT LocCode FROM webx_location WHERE LocCode = '" + txtNextStop.Text + "' and (op_dly='Y'  or op_tranship='Y')";

        SqlCommand sqlCommand = new SqlCommand(strSQLNextStop, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorNextStop.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? false : true);

        if (lblErrorNextStop.Visible == true)
        {
            txtNextStop.Focus();
        }
        else
        {
            Session["destination"] = txtNextStop.Text;
        }

        sqlConn.Close();
    }

    protected void txtDestCd_TextChanged(object sender, EventArgs e)
    {
        trDocketList.Visible = false;

        //Check for Destination Location(s)
        txtDestCd.Text = txtDestCd.Text.Trim().ToUpper();

        if (txtDestCd.Text == "")
        {
            lblErrorDestCd.Visible = false;
            return;
        }
        /*else if (txtDestCd.Text == Session["brcd"].ToString().Trim().ToUpper())
        {
            lblErrorDestCd.Visible = true;
            return;
        }
        else if (checkLoginCdInDestCd() == true)
        {
            lblErrorDestCd.Visible = true;
            return;
        }*/

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        txtDestCd.Text = txtDestCd.Text.Replace("'", "").Replace(" ", "").Trim();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "WebX_SP_ValidateDestinationLocations";

        sqlCommand.Parameters.AddWithValue("@DestLoc", txtDestCd.Text);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
        DataSet dsDestLoc = new DataSet();

        sqlDA.Fill(dsDestLoc);
       
        lblErrorDestCd.Visible = (dsDestLoc.Tables[dsDestLoc.Tables.Count-1].Rows[0]["Return_Value"].ToString() == "True" ? true : false);
        
        if (lblErrorDestCd.Visible == true)
        {
            txtDestCd.Focus();
        }
        
        sqlConn.Close();
    }

    protected void txtManualLSNo_TextChanged(object sender, EventArgs e)
    {
        txtManualLSNo.Text = txtManualLSNo.Text.ToUpper().Trim();

        if (txtManualLSNo.Text == "" || txtManualLSNo.Text == "NA")
        {
            lblManualLSNo.Visible = false;
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLManualLSNo = "SELECT ManualLSNo FROM webx_tchdr_tmp WHERE ManualLSNo = '" + txtManualLSNo.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQLManualLSNo, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblManualLSNo.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? true : false);

        sqlConn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        strLSCaption = HidLS.Value + " For: " + txtNextStop.Text;
        tdColSpanForLSCaption.ColSpan = 8;
        
        //Generate SQL statement for Docket Listing
        generateSQL();
        
        //Pre SQL
        blnPostSQL = false;

        //Paint Docket Listing based on criteria supplied by the user
        paintDocketListing();
        trLSCaption.Visible = true;
        //lblTemp.Text=strSQL;
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

    private string getDateInddMMMyyFormatWithHyphen(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private void generateSQL()
    {
        createValuesFromUserSelection();

        //This SQL Statement is based on Revised Docket Structure (Impl. started on 16-Aug-07)

        strSQL = "SELECT (CASE WMD.TRN_Mod WHEN 1 THEN 'Air' WHEN 2 THEN 'Road' WHEN 3 THEN 'Train'  " +
                 "WHEN 4 THEN 'Express' ELSE '-' END ) AS TrnMode, WTDS.DOCKNO+WTDS.DOCKSF As DocketNo, WMD.DOCKDT AS DocketDate, " +
                 "WMD.ORGNCD AS OrgCode, WMD.CSGNCD AS ConsCD, WMD.CSGNNM AS ConsName, " +
                 "WTDS.NextLoc AS DelyLoc, WMD.DESTCD AS DestCode, '' AS ArrivalDate, " +
                 "WMD.CDELDT AS DelyDate, WMD.PKGSNO AS PackagesLB, WMD.ACTUWT AS WeightLB, " +
                 "WTDS.DOCKET_MODE AS DocketMode, WMD.Reassign_destcd, " +
                 "ISNULL(WMD.from_loc, '') + ' - ' + ISNULL(WMD.to_loc, '') AS FromTo From WebX_Master_Docket WMD " +
                 "INNER JOIN WebX_Trans_Docket_Status WTDS ON WMD.DOCKNO = WTDS.DOCKNO and (Case When Reassign_DestCD is NULL Then DestCd When Ltrim(Rtrim(Reassign_destcd))='' Then  DestCd Else Reassign_DestCD End)<>WTDS.Curr_LOC " +
                 "WHERE (IsNULL(LocalCN_YN,'N')='N' OR Rtrim(Ltrim(LocalCN_YN))='-') and WTDS.Dely_Date is NULL and WTDS.LS is NULL AND WTDS.MF IS NULL AND (WTDS.Cancelled = 'N' or " +
                 "WTDS.Cancelled is NULL) AND (WTDS.detained = 'N' or WTDS.detained is NULL) AND UPPER(ISNULL(WTDS.Op_Status,'-'))<>'DELIVERED' AND WTDS.LS is NULL AND WTDS.MF is NULL AND ";

        //"WHERE WTDS.LS IS NULL AND WTDS.MF IS NULL  AND (WTDS.Cancelled = 'N' or " +

        if (ddlRouteMode.Value != "-1")
        {
            strSQL += " WMD.TRN_MOD = '" + ddlRouteMode.Value + "' AND ";
        }

        if (strDocketList != "")
        {
        //    strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' AND WMD.REASSIGN_DESTCD <>'" + Session["brcd"].ToString().Trim() + "' AND WTDS.DOCKNO in ('" + strDocketList + "')" +
        //              " ORDER BY WMD.REASSIGN_DESTCD, WMD.ORGNCD, WTDS.DOCKNO + WTDS.DOCKSF, WMD.DOCKDT";
            strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' AND IsNULL(WMD.REASSIGN_DESTCD,WMD.DestCD) <>'" + Session["brcd"].ToString().Trim() + "' AND WTDS.DOCKNO in ('" + strDocketList + "')" +
              " ORDER BY WMD.REASSIGN_DESTCD, WMD.ORGNCD, WTDS.DOCKNO + WTDS.DOCKSF, WMD.DOCKDT";

            if (strNextLocation == Session["brcd"].ToString().Trim())
            {
                strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "'AND WTDS.DOCKNO in ('" + strDocketList + "')" +
                  "  AND ORGNCD=IsNULL(Reassign_Destcd,DESTCD) ORDER BY WMD.REASSIGN_DESTCD, WMD.ORGNCD, WTDS.DOCKNO + WTDS.DOCKSF, WMD.DOCKDT";
            }
        }
        else
        {
            if (strDestination != "")
            {
                //strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD in ('" + strDestination + "')";
                strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and IsNull(WMD.REASSIGN_DESTCD,WMD.DESTCD) in ('" + strDestination + "')";
            }
            else if (strRegion != "")
            {
                //strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD in (Select LocCode From WebX_Location Where Report_Loc in ('" + strRegion + "'))";
                strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and IsNull(WMD.REASSIGN_DESTCD,WMD.DESTCD) in (Select LocCode From WebX_Location Where Report_Loc in ('" + strRegion + "'))";
            }
            else if (strFromCity != "" && strToCity != "")
            {
                strSQL += " WMD.from_loc ='" + strFromCity + "' AND WMD.to_loc ='" + strToCity + "' AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' ";
            }
            else if (strFromCity != "")
            {
                strSQL += " WMD.from_loc ='" + strFromCity + "' AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' ";
            }
            else if (strToCity != "")
            {
                strSQL += " WMD.to_loc ='" + strToCity + "' AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "'";
            }
            else
            {
                //strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "'";
                strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "'";
            }

            if (strNextLocation != Session["brcd"].ToString().Trim())
            {
                strSQL += " AND IsNULL(WMD.REASSIGN_DESTCD,WMD.DestCD) <>'" + Session["brcd"].ToString().Trim() + "' ";
            }
            else
            {
                strSQL += " AND ORGNCD=IsNULL(Reassign_Destcd,DESTCD) ";
            }

            strSQL += " AND WMD.DOCKDT between '" + strFromDate + "' and '" + strToDate + "' ORDER BY WMD.REASSIGN_DESTCD, WMD.ORGNCD, WTDS.DOCKNO + WTDS.DOCKSF, WMD.DOCKDT";
        }
        //Response.Write(strSQL);
    }

    private void paintDocketListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocketList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("RowColor", typeof(string));
        dt.Columns.Add("SrNo", typeof(string));
        dt.Columns.Add("DocketID", typeof(string));
        dt.Columns.Add("DocketNo", typeof(string));
        dt.Columns.Add("DocketMode", typeof(string));
        dt.Columns.Add("DocketDate", typeof(string));
        dt.Columns.Add("OrgCode", typeof(string));
        dt.Columns.Add("ConsName", typeof(string));
        dt.Columns.Add("DelyLoc", typeof(string));
        dt.Columns.Add("DestCode", typeof(string));
        dt.Columns.Add("ArrivalDate", typeof(string));
        dt.Columns.Add("DelyDate", typeof(string));
        dt.Columns.Add("PackagesLB", typeof(string));
        dt.Columns.Add("WeightLB", typeof(string));
        dt.Columns.Add("FromTo", typeof(string));
        dt.Columns.Add("TrnMode", typeof(string));

        DataRow dr;

        sqlDA.Fill(dsDocketList);
        
        int i = 1;
        
        intTotalRecords = dsDocketList.Tables[0].Rows.Count;
        HidTotalRecords.Value = intTotalRecords.ToString();

        //trPrepBy.Visible = false;
        
        string strFromDateToDisplay = strFromDate.Substring(0, strFromDate.IndexOf(' ')).Trim();
        string[] strArrDateFrom = strFromDateToDisplay.Split('-');
        strFromDateToDisplay = strArrDateFrom[0] + " " + strArrDateFrom[1] + " " + strArrDateFrom[2].Substring(2);
        string strToDateToDisplay = strToDate.Substring(0, strToDate.IndexOf(' ')).Trim();
        string[] strArrDateTo = strToDateToDisplay.Split('-');
        strToDateToDisplay = strArrDateTo[0] + " " + strArrDateTo[1] + " " + strArrDateTo[2].Substring(2);
        lblInstrunction.InnerHtml = "<b>" + HidDocket.Value + "(s) Date: " + strFromDateToDisplay + " - " + strToDateToDisplay + "</b>";

        trDocketList.Visible = true;
        trTableHeadersForLS.Visible = true;
        trTableHeadersForLSView.Visible = false;

        strDocketNoList = "";
        strDocketIDList = "";

        rptDocketList.Visible = false;
        rptDocketListForView.Visible = false;

        if (intTotalRecords > 0)
        {
            trNoRecsForDocketList.Visible = false;
            trPrepareLoadingSheet.Visible = true;
            //trPrepBy.Visible = true;
            //txtPrepBy.Text = Session["empcd"].ToString();

            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowColor"] = (drRows["DocketMode"].ToString() == "Q" ? "#FF0000" : "#000000");
                dr["SrNo"] = i.ToString();
                i++;
                dr["DocketNo"] = drRows["DocketNo"].ToString();
                strDocketNoList = (strDocketNoList == "" ? drRows["DocketNo"].ToString() : strDocketNoList + "," + drRows["DocketNo"].ToString());
                dr["DocketMode"] = drRows["DocketMode"].ToString();
                dr["DocketDate"] = (drRows["DocketDate"] == System.DBNull.Value ? "-" : Convert.ToDateTime(drRows["DocketDate"].ToString()).ToString("dd MMM yy"));
                dr["OrgCode"] = drRows["OrgCode"].ToString();
                dr["ConsName"] = (drRows["ConsName"].ToString() == "" ? "-" : drRows["ConsName"].ToString()); //GenerateProperCase(drRows["ConsName"].ToString()));
                dr["DelyLoc"] = (drRows["Reassign_destcd"].ToString().Trim() == "" || drRows["Reassign_destcd"].ToString().ToUpper() == "NULL" ? drRows["DestCode"].ToString() : drRows["Reassign_destcd"].ToString());
                dr["DestCode"] = drRows["DestCode"].ToString();
                dr["ArrivalDate"] = (drRows["ArrivalDate"].ToString().ToUpper() == "NULL" || drRows["ArrivalDate"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["ArrivalDate"].ToString()).ToString("dd MMM yy"));
                dr["DelyDate"] = (drRows["DelyDate"] == System.DBNull.Value ? "-" : Convert.ToDateTime(drRows["DelyDate"].ToString()).ToString("dd MMM yy"));
                dr["PackagesLB"] = drRows["PackagesLB"].ToString();
                dr["WeightLB"] = drRows["WeightLB"].ToString();
                dr["FromTo"] = drRows["FromTo"].ToString();
                dr["TrnMode"] = drRows["TrnMode"].ToString();

                dt.Rows.Add(dr);
            }

            if (blnPostSQL == false)
            {
                trTableHeadersForLS.Visible = true;
                rptDocketList.Visible = true;
                rptDocketList.DataSource = dt;
                rptDocketList.DataBind();
            }
            else
            {
                trTableHeadersForLS.Visible = false;
                trTableHeadersForLSView.Visible = true;
                rptDocketListForView.Visible = true;
                rptDocketListForView.DataSource = dt;
                rptDocketListForView.DataBind();
            }
        }
        else
        {
            trNoRecsForDocketList.Visible = true;
            trPrepareLoadingSheet.Visible = false;
            rptDocketList.Visible = false;
        }

        HidSelectedDocketNos.Value = strDocketNoList;
        HidSelectedDocketIDs.Value = strDocketIDList;

        sqlConn.Close();
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
    
    protected void btnPrepareLS_Click(object sender, EventArgs e)
    {
        //Preparing Loading Sheet starts.....
        
        //Get Next LS No.
        getNextLSNo();
        //Prepare Loading Sheet
        prepareLoadingSheet();

        //Preparing Loading Sheet ends.....

        Response.Redirect("DisplayLSResult.aspx?LSNo=" + strNextLoadingSheetNo + "&ManLSNo=" + txtManualLSNo.Text.Trim());
    }

    private void getNextLSNo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        
        //AS PER PREVIOUS DB OBJECTS
        //sqlCommand.CommandText = "usp_get_next_ls_code";
        //sqlCommand.Parameters.AddWithValue("@loccode", Session["brcd"].ToString());

        //AS PER NEW DB OBJECTS WITH IMPLEMENTATION OF NOMENCLATURE RULES
        sqlCommand.CommandText = "WebX_SP_GetNextDocumentCode";

        sqlCommand.Parameters.AddWithValue("@LocCode", Session["brcd"].ToString());
        sqlCommand.Parameters.AddWithValue("@FinYear", Session["FinYear"].ToString());
        sqlCommand.Parameters.AddWithValue("@Document", "LS");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
        DataSet dsNextLSCode = new DataSet();

        sqlDA.Fill(dsNextLSCode);

        strNextLoadingSheetNo = dsNextLSCode.Tables[0].Rows[0][0].ToString().Replace(" ", "");
    }

    private void prepareLoadingSheet()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();
        
        //SqlTransaction sqlTrans = sqlConn.BeginTransaction();
        SqlCommand sqlCommand;
        SqlCommand sqlCommandForHeader;
        SqlCommand sqlCommandForDocketTrack;
        SqlCommand sqlCommandForDocketStatus;

        string strSelectedDockets = HidSelectedDockets.Value.Replace("'", "").Replace(" ", "").Replace(",", "','");
        
        try
        {
            //This SQL Statement is based on Revised Docket Structure (Impl. started on 16-Aug-07)

            string strTCTempSQL = "Insert into webx_tctrn_tmp (TCNO, TCSF, ORGNCD, DESTCD, REASSIGN_DESTCD, DOCKNO, DOCKSF, DOCKCLS, " + 
                                  "DOCKDT, CDELDT, PAYBAS, NOPKGS, CFTWT, ACTUWT, DKTAMT, Modvat_Ctr, Internal_Ctr, CFT_YN, " +
                                  "PartCsgn_YN, ToBH_CODE, CSGNNM, RemainingWt, LOADACTUWT, RemainingQty, LOADPKGSNO) select '" + strNextLoadingSheetNo + "' AS TCNO, '.' As TCSF, " + 
                                  "WMD.ORGNCD, WMD.DESTCD, WMD.REASSIGN_DESTCD, WTDS.DOCKNO, WTDS.DOCKSF, 'X' As DOCKCLS, " + 
                                  "WMD.DOCKDT, WMD.CDELDT, WMD.PAYBAS, WMD.PKGSNO, WMD.CHRGWT, WMD.ACTUWT, isNull(WDC.DKTTOT,0), " +
                                  "0 As Modvat_Ctr, 0 As Internal_Ctr, CFT_YN, 'N' As PartCsgn_YN, WTDS.NextLoc, WMD.CSGNNM, 0, 0, 0, 0 " + 
                                  "From WebX_Master_Docket WMD INNER JOIN WebX_Trans_Docket_Status WTDS ON WMD.DOCKNO = " + 
                                  "WTDS.DOCKNO Inner Join WebX_Master_Docket_Charges WDC on WMD.dockno = WDC.dockno " + 
                                  "where WMD.dockno + WMD.docksf in ('" + strSelectedDockets + "')";

            sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandText = strTCTempSQL;
            //sqlCommand.Transaction = sqlTrans;

            sqlCommand.ExecuteNonQuery();

            //Successful record entry in webx_tctrn_tmp table

            //This SQL Statement is based on Revised Docket Structure (Impl. started on 16-Aug-07)

            string strTCHeaderTempSQL = "Insert into webx_TCHDR_tmp (Entryby, TCNO, TCSF, TCDT, TCBR, ROUTE_CODE, LOADING_STATUS, " + 
                                        "TOT_DKT, TOT_PKGS, TOT_ACTUWT, TOT_CFTWT, TOT_FRTAMT, ModvatCover, IntCover, CFT_Ctr, " +
                                        "PartCsgn_Ctr, TOT_ACLSDOCK, vehno, ToBH_CODE, ManualLSNo, Final_TC, TFlag_YN, PreparedBy) select '" + Session["empcd"].ToString() + "'" +
                                        " AS Entryby, '" + strNextLoadingSheetNo + "' AS TCNO, '.' As TCSF, GetDate() AS TCDT, '" + Session["brcd"].ToString() + "' AS TCBR, " + 
                                        "'' AS ROUTE_CODE, '' As LOADING_STATUS, ISNULL(count(*), 0) As TOT_DKT, ISNULL(SUM(WMD.PKGSNO), 0) As TOT_PKGS, " + 
                                        "ISNULL(SUM(WMD.ACTUWT), 0) As TOT_ACTUWT, ISNULL(SUM(WMD.CHRGWT), 0) As TOT_CFTWT, " +  
                                        "ISNULL(SUM(WMDC.DKTTOT),0) As TOT_FRTAMT, 0 As ModvatCover, 0 As IntCover, 0 As CFT_Ctr, " + 
                                        "0 As PartCsgn_Ctr, 0 As TOT_ACLSDOCK, '' As vehno, '" + strNextLocation + "' As ToBH_CODE, " + 
                                        "'" + strManualLSNo + "' as ManualLSno, 'N', 'N', '" + txtPrepBy.Text + "' " + 
                                        "FROM webx_master_docket WMD INNER JOIN WebX_Master_Docket_Charges WMDC ON " + 
                                        "WMD.DOCKNO = WMDC.DOCKNO where WMD.DOCKNO + WMD.DOCKSF in ('" + strSelectedDockets + "')";

            sqlCommandForHeader = new SqlCommand();
            sqlCommandForHeader.Connection = sqlConn;
            sqlCommandForHeader.CommandText = strTCHeaderTempSQL;
            //sqlCommandForHeader.Transaction = sqlTrans;

            sqlCommandForHeader.ExecuteNonQuery();


            if (strFromCity != "" && strToCity != "")
            {
                string strTCHeaderUpdate = "Update WebX_TCHDR_Tmp Set FromCity='" + strFromCity + "',ToCity='" + strToCity + "' Where TCNO='" + strNextLoadingSheetNo + "'";
                sqlCommandForHeader = null;
                sqlCommandForHeader = new SqlCommand();
                sqlCommandForHeader.Connection = sqlConn;
                sqlCommandForHeader.CommandText = strTCHeaderUpdate;
                //--
                sqlCommandForHeader.ExecuteNonQuery();
            }
            //Successful record entry in webx_TCHDR_tmp table

            //Update webx_Trans_Docket_Status table
            string strTCDocketStatusSQL = "Update WebX_Trans_Docket_Status SET NextLoc = '" + txtNextStop.Text + "', LS='" + strNextLoadingSheetNo + "' Where DockNo + DockSF IN ('" + strSelectedDockets + "')";

            sqlCommandForDocketStatus = new SqlCommand();
            sqlCommandForDocketStatus.Connection = sqlConn;
            sqlCommandForDocketStatus.CommandText = strTCDocketStatusSQL;
            //sqlCommandForDocketTrack.Transaction = sqlTrans;

            sqlCommandForDocketStatus.ExecuteNonQuery();

            //Successful record entry in webx_Trans_Docket_Status table

            //sqlTrans.Commit();

            ////Post display logic
            //trLSCaption.Visible = false;
            //lnkbtnDocketsinLSForMF.Text = strNextLoadingSheetNo;
            //trLSCaptionWithLink.Visible = true;
            
            ////Generate Post SQL script
            //strSQL = "select WMD.DOCKNO + WMD.DOCKSF As DocketNo, WMD.DOCKDT AS DocketDate, " +
            //         "WMD.ORGNCD AS OrgCode, WMD.CSGNCD AS ConsCD, WMD.CSGNNM AS ConsName, WTDS.NextLoc AS DelyLoc, " + 
            //         "WMD.DESTCD AS DestCode, '' AS ArrivalDate, WMD.CDELDT AS DelyDate, " + 
            //         "WMD.PKGSNO AS PackagesLB, WMD.ACTUWT AS WeightLB, WTDS.Docket_Mode AS DocketMode, " + 
            //         "WMD.REASSIGN_DESTCD FROM webx_master_docket WMD INNER JOIN  WebX_Trans_Docket_Status WTDS " + 
            //         "ON WMD.DOCKNO = WTDS.DOCKNO where WMD.DOCKNO + WMD.DOCKSF IN ('" + strSelectedDockets + "')";
            
            ////Post SQL
            //blnPostSQL = true;

            //if (chkAll.Checked == true)
            //{
            //    chkAll.Checked = false;
            //}

            //paintDocketListing();

            //managePostSQL();
            //blnPostSQL = false;
        }
        catch (Exception Ex)
        {
            //sqlTrans.Rollback();
            trPrepareLSErrorMsg.Visible = true;
            lblPrepareLSErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message + Ex.Source;
        }
        finally
        {
            sqlCommand = null;
            sqlCommandForHeader = null;
            sqlCommandForDocketTrack = null;

            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void createValuesFromUserSelection()
    {
        //Collect user supplied values
        if (radRange.Checked == true)
        {
            strFromDate = getDateInddMMMyyyFormat(txtFromDate.Value);

            if (txtLSDate.Value != txtToDate.Value && Convert.ToDateTime(getDateInddMMMyyFormat(txtToDate.Value)) > Convert.ToDateTime(getDateInddMMMyyFormat( txtLSDate.Value)))
            {
                strToDate = getDateInddMMMyyyFormat(txtLSDate.Value);
            }
            else
            {
                strToDate = getDateInddMMMyyyFormat(txtToDate.Value);
            }
        }
        else if (radToday.Checked == true)
        {
            strFromDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
            strToDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
        }
        else if (radLastWeek.Checked == true)
        {
            DateTime dtLastWeek = System.DateTime.Today.AddDays(-6);
            if (txtLSDate.Value != strSystemDate)
            {
                strFromDate = dtLastWeek.ToString("dd-MMM-yyyy");
                strToDate = getDateInddMMMyyyFormat(txtLSDate.Value);
            }
            else
            {
                strFromDate = dtLastWeek.ToString("dd-MMM-yyyy");
                strToDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
            }
        }

        strFromDate += " 00:00:00";
        strToDate += " 23:59:59";

        strManualLSNo = txtManualLSNo.Text.Trim();
        strDocketList = txtDockets.Value.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        strNextLocation = txtNextStop.Text.Replace("'", "").Replace(" ", "").Trim();
        strDestination = txtDestCd.Text.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        strFromCity = txtCityFrom.Text.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        strToCity = txtCityTo.Text.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        
        getSelectedRegionLocations();

        strRegion = strRegion.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
    }

    private string getConsName(string strConsCode, string strConsName)
    {
        if (strConsCode == "8888")
        {
            return strConsName;
        }
        else if (strConsCode.Trim() == "")
        {
            return "-";
        }
        else
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            try
            {
                sqlConn.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConn;
                sqlCommand.CommandText = "select CustNm from webx_Custhdr where Custcd='" + strConsCode + "'";

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
                DataSet dsConsName = new DataSet();

                sqlDA.Fill(dsConsName);

                return (dsConsName.Tables[0].Rows.Count > 0 ? dsConsName.Tables[0].Rows[0][0].ToString() : "-");//GenerateProperCase(dsConsName.Tables[0].Rows[0][0].ToString()) : "-");
            }
            catch (Exception Ex)
            {
                return "-";
                sqlConn.Close();
            }
        }
    }

    //private void managePostSQL()
    //{
    //    trPrepareLoadingSheet.Visible = false;
        
    //    trNextStep.Visible = true;
    //    trPrepareMoreLS.Visible = true;
    //    trViewPrintLS.Visible = true;

    //    chkAll.Visible = false;
    //}

    protected void lnkbtnDocketsinLSForMF_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/GUI/Operations/LoadingSheet/PrepareMFFromLS.aspx?LSNo=" + strNextLoadingSheetNo);
    }

    private string checkCheckboxSelected()
    {
        return (blnCheckAllClicked == true && chkAll.Checked == true ? "checked=\"checked\"" : "");
    }

    private string GenerateProperCase(string Name)
    {
        string strProperCase = "";

        string[] strArrName = Name.Split(' ');

        for (int intLoopCounter = 0; intLoopCounter < strArrName.Length; intLoopCounter++)
        {
            strProperCase = (strProperCase == "" ? strArrName[intLoopCounter].Trim().Substring(0, 1).ToUpper() + strArrName[intLoopCounter].Trim().Substring(1).ToLower() : strProperCase + " " + strArrName[intLoopCounter].Trim().Substring(0, 1).ToUpper() + strArrName[intLoopCounter].Trim().Substring(1).ToLower());
        }

        return strProperCase;
    }

    private void getLSManualNoMandatoryYN()
    {
        HidManNoManYN.Value = "N";
    
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        try
        {
            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandText = "Webx_SP_GetManualNoMandatoryYNForDocument";
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@DocumentName", "LS");

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
            DataSet dsManLSNo = new DataSet();

            sqlDA.Fill(dsManLSNo);

            HidManNoManYN.Value = (dsManLSNo.Tables[0].Rows.Count > 0 ? dsManLSNo.Tables[0].Rows[0][0].ToString() : "N");
        }
        catch (Exception Ex)
        {
            sqlConn.Close();
        }
    }

    //private void populateZoneDetails()
    //{
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    SqlCommand sqlCommand = new SqlCommand();
    //    sqlCommand.Connection = sqlConn;
    //    sqlCommand.CommandType = CommandType.StoredProcedure;
    //    sqlCommand.CommandText = "Webx_SP_GetZone";

    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsZone = new DataSet();

    //    sqlDA.Fill(dsZone);

    //    if (dsZone.Tables[0].Rows.Count > 0)
    //    {
    //        ddlRegion.DataTextField = "CodeDesc";
    //        ddlRegion.DataValueField = "CodeId";

    //        ddlRegion.DataSource = dsZone;
    //        ddlRegion.DataBind();
    //    }

    //    ddlRegion.Items.Insert(0, new ListItem("Select", "-1"));
    //}

    private void populateRegionLocations()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQLForRegion = "select distinct LocCode + ' : ' + LocName AS LocCodeName, Loccode from webx_location where Loc_Level = (SELECT top 1 Loc_Level - 1 FROM webx_location WHERE LocCode = '" + Session["brcd"].ToString() + "') ORDER BY LocCode";

        SqlCommand sqlCommand = new SqlCommand(strSQLForRegion, sqlConn);
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsRegion = new DataSet();

        sqlDA.Fill(dsRegion);

        if (dsRegion.Tables[0].Rows.Count > 0)
        {
            lstRegion.DataTextField = "LocCodeName";
            lstRegion.DataValueField = "Loccode";

            lstRegion.DataSource = dsRegion;
            lstRegion.DataBind();
        }

        lstRegion.Items.Insert(0, new ListItem("Select", "-1"));
    }

    private void getSelectedRegionLocations()
    {
        strRegion = "";

        for (int intLoopCounter = 0; intLoopCounter < lstRegion.Items.Count; intLoopCounter++)
        {
            if (lstRegion.Items[intLoopCounter].Selected == true && lstRegion.Items[intLoopCounter].Value != "-1")
            {
                strRegion = (strRegion == "" ? lstRegion.Items[intLoopCounter].Value : strRegion + "," + lstRegion.Items[intLoopCounter].Value);
            }
        }
    }

    private bool checkLoginCdInDestCd()
    {
        string[] strArrLoginCdInDestCd = txtDestCd.Text.Split(',');

        for (int intLoopCounter = 0; intLoopCounter < strArrLoginCdInDestCd.Length; intLoopCounter++)
        {
            if (strArrLoginCdInDestCd[intLoopCounter].Trim().ToUpper() == Session["brcd"].ToString().ToUpper())
            {
                return true;
            }
        }

        return false;
    }

    protected void txtPrepBy_TextChanged(object sender, EventArgs e)
    {
        //Check for Next Location
        txtPrepBy.Text = txtPrepBy.Text.Trim().ToUpper();
        lblErrorPrepBy.Visible = false;

        if (txtPrepBy.Text == "")
        {
            lblErrorPrepBy.Visible = false;
            return;
        }
        else if (txtPrepBy.Text == Session["empcd"].ToString())
        {
            lblPrepByName.InnerHtml = Session["empnm"].ToString();
            return;
        }
        
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLPrepBy = "select UserId, [Name] AS UserName from webx_master_users WHERE UserId = '" + txtPrepBy.Text + "' AND BranchCode = '" + Session["brcd"].ToString() + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQLPrepBy, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsPrepBy = new DataSet();

        sqlDA.Fill(dsPrepBy);

        lblErrorPrepBy.Visible = (dsPrepBy.Tables[0].Rows.Count > 0 ? false : true);

        if (lblErrorPrepBy.Visible == true)
        {
            lblPrepByName.InnerHtml = "";
            txtPrepBy.Focus();
        }
        else
        {
            lblPrepByName.InnerHtml = dsPrepBy.Tables[0].Rows[0]["UserName"].ToString();
        }

        sqlConn.Close();
    }

    private void getDocumentDetails()
    {
        HidDocket.Value = "";
        HidLS.Value = "";

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
                }
            }
        }
    }

    private void populateMOT()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand("select CodeId, CodeDesc from webx_master_general where codetype = 'TRN' ORDER BY CodeID", sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsMOT = new DataSet();

        sqlDA.Fill(dsMOT);

        if (dsMOT.Tables[0].Rows.Count > 0)
        {
            ddlRouteMode.DataTextField = "CodeDesc";
            ddlRouteMode.DataValueField = "CodeId";

            ddlRouteMode.DataSource = dsMOT;
            ddlRouteMode.DataBind();
        }

        ddlRouteMode.Items.Insert(0, new ListItem("Select", "-1"));
    }
    protected void txtCityFrom_TextChanged(object sender, EventArgs e)
    {
        trDocketList.Visible = false;
        
        //Check for Next Location
        txtCityFrom.Text = txtCityFrom.Text.Trim().ToUpper();

        if (txtCityFrom.Text == "")
        {
            lblErrorCityFrom.Visible = false;
            return;
        }
        
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        //String strSQLFromCity = "select * from webx_citymaster where book_loc = '" + Session["brcd"].ToString() + "' AND location = '" + txtCityFrom.Text + "'";
        String strSQLFromCity = "select * from webx_citymaster where location = '" + txtCityFrom.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQLFromCity, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsFromCity = new DataSet();

        sqlDA.Fill(dsFromCity);

        lblErrorCityFrom.Visible = (dsFromCity.Tables[0].Rows.Count > 0 ? false : true);

        if (lblErrorCityFrom.Visible == true)
        {
            txtCityFrom.Focus();
        }

        sqlConn.Close();
    }
    protected void txtCityTo_TextChanged(object sender, EventArgs e)
    {
        trDocketList.Visible = false;

        //Check for Next Location
        txtCityTo.Text = txtCityTo.Text.Trim().ToUpper();

        if (txtCityTo.Text == "")
        {
            lblErrorCityTo.Visible = false;
            return;
        }
        
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLToCity = "select * from webx_citymaster where location = '" + txtCityTo.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQLToCity, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsToCity = new DataSet();

        sqlDA.Fill(dsToCity);

        lblErrorCityTo.Visible = (dsToCity.Tables[0].Rows.Count > 0 ? false : true);

        if (lblErrorCityTo.Visible == true)
        {
            txtCityTo.Focus();
        }

        sqlConn.Close();
    }
}

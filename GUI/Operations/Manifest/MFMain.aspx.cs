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

public partial class GUI_Operations_LoadingSheet_MFMain : System.Web.UI.Page
{
    public static string strLSCaption;
    public static string strSQL;

    public static bool ErrorRaise = false;

    //For Docket Listing
    static string strFromDate;
    static string strToDate;
    static string strManualLSNo;
    static string strDocketList;
    static string strDocketNoList;
    static string strPackageNoList;
    static string strWeightNoList;
    static string strChargeWeightNoList;
    static string strNextLocation;
    public static string strNextManifestNo;
    static string strDestination;
    static string strRegion;
    static string strFromCity;
    static string strToCity;
    static bool blnPostSQL;
    public static string strSystemDate;

    public static int intTotalRecords;
    static bool blnCheckAllClicked = false;
    static bool blnMFCreated;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strSystemDate = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtMFDate.Value = strSystemDate;
            HidSystemDate.Value = txtMFDate.Value;
            lblToday.InnerHtml = "Today: " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
            radLastWeek.Checked = true;

            chkAll.Attributes.Add("title", "Click this box for selection of all " + HidDocket.Value + "s");

            getMFManualNoMandatoryYN();

            getLSRequiredForMFYN();

            populateZoneDetails();

            populateMOT();

            getDocumentDetails();

            txtPrepBy.Text = Session["empcd"].ToString();
            lblPrepByName.InnerHtml = Session["empnm"].ToString();

            txtMFDate.Focus();
        }

        lblHeader.InnerHtml = "<b>Prepare New " + HidMF.Value + "</b>";
        lblCriteria.InnerHtml = "<b>Select criteria for preparing " + HidMF.Value + "</b>";
        lblMFNo.InnerHtml = HidMF.Value + " No.:";
        lblMFDate.InnerHtml = HidMF.Value + " Date:";
        lblMFDateHint.InnerHtml = "&nbsp;Hint: Only " + HidDocket.Value + "s booked upto this date can be selected";
        lblManMFNo.InnerHtml = "Manual " + HidMF.Value + " No.:";
        lblManualMFNo.InnerHtml = "&nbsp;Duplicate Manual " + HidMF.Value + " No.!!!";
        lblManualMFNoHint.InnerHtml = "&nbsp;Hint: Enter NA if Manual " + HidMF.Value + " No. is not available.";
        lblMFNoCaption.InnerHtml = "<b>" + HidMF.Value + " No.&nbsp;</b>";
        lblDocketCaption.InnerHtml = "<b>&nbsp;prepared for following " + HidDocket.Value + "s.</b>";
        lblDockets.InnerHtml = HidDocket.Value + "s:";
        lblDocketCaption1.InnerHtml = HidDocket.Value + " No.";
        lblNoRecsMessage.InnerHtml = "No " + HidDocket.Value + "s Found for the given Route";
        lblDocketSelCriteria.InnerHtml = "<b>Select " + HidDocket.Value + " Criteria</b>";
        lblDocketDate.InnerHtml = "Select " + HidDocket.Value + " Date:";
        lblMFNextStopHint.InnerHtml = "(" + HidMF.Value + " <i>will be prepared for this Next Location</i>)";

        btnSubmit.ToolTip = "Click here to search " + HidMF.Value + " based on given criteria";
        btnPrepareMF.Text = "Prepare " + HidMF.Value;

        Page.Title = "Generate " + HidMF.Value + " Without Creating " + HidLS.Value;
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
        //else if (txtNextStop.Text == Session["brcd"].ToString().Trim().ToUpper())
        //{
        //    lblErrorNextStop.Visible = true;
        //    return;
        //}

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLNextStop = "SELECT LocCode FROM webx_location WHERE LocCode = '" + txtNextStop.Text + "' and (op_dly='Y'  or op_tranship='Y')";

        SqlCommand sqlCommand = new SqlCommand(strSQLNextStop, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorNextStop.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? false : true);
        //ErrorRaise = (ErrorRaise == true ? true : lblErrorNextStop.Visible);
        ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;
        sqlConn.Close();

        if (lblErrorNextStop.Visible == true)
        {
            txtNextStop.Focus();
        }
        else
        {
            Session["destination"] = txtNextStop.Text;
        }
    }

    protected void txtManualMFNo_TextChanged(object sender, EventArgs e)
    {
        trDocketList.Visible = false;

        txtManualMFNo.Text = txtManualMFNo.Text.ToUpper();

        if (txtManualMFNo.Text == "" || txtManualMFNo.Text == "NA")
        {
            lblManualMFNo.Visible = false;
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLManualMFNo = "SELECT Manual_tcno FROM webx_TChdr WHERE Manual_tcno = '" + txtManualMFNo.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQLManualMFNo, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsManualMF = new DataSet();

        sqlDA.Fill(dsManualMF);

        lblManualMFNo.Visible = (dsManualMF.Tables[0].Rows.Count > 0 ? true : false);

        if (lblManualMFNo.Visible == true)
        {
            txtManualMFNo.Focus();
        }

        sqlConn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ErrorRaise == false)
        {
            strLSCaption = HidMF.Value + " For: " + txtNextStop.Text;
            tdColSpanForLSCaption.ColSpan = 11;

            //Generate SQL statement for Docket Listing
            generateSQL();

            //Pre SQL
            blnPostSQL = false;

            //Paint Docket Listing based on criteria supplied by the user
            paintDocketListing();
            trLSCaption.Visible = true;
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

    private void generateSQL()
    {
        createValuesFromUserSelection();

        //This SQL Statement is based on Revised Docket Structure (Impl. started on 16-Aug-07)

        strSQL = "SELECT (CASE WMD.TRN_Mod WHEN 1 THEN 'Air' WHEN 2 THEN 'Road' WHEN 3 THEN 'Train'  " +
                 "WHEN 4 THEN 'Express' ELSE '-' END ) AS TrnMode, WMD.DOCKNO+WMD.DOCKSF As DocketNo, " + 
                 "WMD.DOCKDT AS DocketDate, WMD.ORGNCD AS OrgCode, WMD.CSGNCD AS ConsCD, WMD.CSGNNM " + 
                 "AS ConsName, WTDS.NextLoc AS DelyLoc, WMD.DESTCD AS DestCode, '' AS ArrivalDate, " + 
                 "WMD.CDELDT AS DelyDate, WMD.PKGSNO AS PackagesLB, WMD.ACTUWT AS WeightLB, WMD.CHRGWT " + 
                 "AS ChargeWeight, WTDS.DOCKET_MODE AS DocketMode, WMD.paybas AS PayBase, WMD.Reassign_destcd, " + 
                 "ISNULL(WMD.from_loc, '') + ' - ' + ISNULL(WMD.to_loc, '') AS FromTo From WebX_Master_Docket " + 
                 "WMD INNER JOIN WebX_Trans_Docket_Status WTDS ON WMD.DOCKNO = WTDS.DOCKNO " +
                 "WHERE WTDS.Dely_Date is NULL and WTDS.MF IS NULL AND (WTDS.Cancelled = 'N' or WTDS.Cancelled is NULL) AND (WTDS.detained = 'N' or WTDS.detained is NULL) AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' AND ";
                 //"WHERE WTDS.LS IS NULL AND WTDS.MF IS NULL AND (WTDS.Cancelled = 'N' or WTDS.Cancelled is NULL) AND ";

        /*if (HidLSReqForMF.Value == "Y")
        {
            strSQL += " WTDS.LS IS NOT NULL AND ";
        }
        else
        {*/
            strSQL += " WTDS.LS IS NULL AND ";
        //}

        if (ddlRouteMode.Value != "-1")
        {
            strSQL += " WMD.TRN_MOD = '" + ddlRouteMode.Value + "' AND ";
        }

        if (strDocketList != "")
        {
            strSQL += " WTDS.CURR_LOC='" + Session["brcd"].ToString().Trim() + "' and WMD.Reassign_destcd<>'" + Session["brcd"].ToString().Trim() + "' and WMD.DOCKNO in ('" + strDocketList + "') " + 
                      " Order By WMD.Reassign_DestCd, WMD.ORGNCD, WMD.DOCKNO+WMD.DOCKSF, WMD.DOCKDT";

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
                /*if (Session["brcd"].ToString().ToUpper() == strNextLocation.ToUpper())
                {
                    strSQL += " WTDS.CURR_LOC='" + Session["brcd"].ToString().Trim() + "' and WMD.Reassign_destcd ='" + strNextLocation.Trim() + "'";
                }
                else
                {
                    strSQL += " WTDS.CURR_LOC='" + Session["brcd"].ToString().Trim() + "' and WMD.Reassign_destcd<>'" + Session["brcd"].ToString().Trim() + "' and WMD.Reassign_destcd in ('" + strDestination + "')";
                }*/
                strSQL += " IsNULL(WMD.Reassign_destcd,DESTCD) in ('" + strDestination + "') AND ";
            }
            else if (strRegion != "-1" && strRegion != "")
            {
                //strSQL += " WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD in (select LocCode from webx_location where locstate = '" + strRegion + "')";
                //strSQL += " IsNULL(WMD.REASSIGN_DESTCD,DESTCD) in (select LocCode from webx_location where locstate = '" + strRegion + "') AND ";
                strSQL += " IsNull(WMD.REASSIGN_DESTCD,WMD.DESTCD) in (Select LocCode From WebX_Location Where Report_Loc in ('" + strRegion + "')) AND";

            }
            else if (strFromCity != "" && strToCity != "")
            {
                //strSQL += " WMD.from_loc ='" + strFromCity + "' AND WMD.to_loc ='" + strToCity + "' AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "' ";
                strSQL += " WMD.from_loc ='" + strFromCity + "' AND WMD.to_loc ='" + strToCity + "' AND  ";
            }
            else if (strFromCity != "")
            {
                //strSQL += " WMD.from_loc ='" + strFromCity + "' AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "' ";
                strSQL += " WMD.from_loc ='" + strFromCity + "' AND ";
            }
            else if (strToCity != "")
            {
                //strSQL += " WMD.to_loc ='" + strToCity + "' AND WTDS.Curr_Loc ='" + Session["brcd"].ToString().Trim() + "' and WMD.REASSIGN_DESTCD <> '" + Session["brcd"].ToString().Trim() + "' ";
                strSQL += " WMD.to_loc ='" + strToCity + "' AND ";
            }
            /*else
            {
                if (Session["brcd"].ToString().ToUpper() == strNextLocation.ToUpper())
                {
                    strSQL += " WTDS.CURR_LOC='" + Session["brcd"].ToString().Trim() + "' and WMD.Reassign_destcd ='" + strNextLocation.Trim() + "'";
                }
                else
                {
                    strSQL += " WTDS.CURR_LOC='" + Session["brcd"].ToString().Trim() + "' and WMD.Reassign_destcd <>'" + Session["brcd"].ToString().Trim().ToUpper() + "'";
                }
            }*/

            if (strNextLocation != Session["brcd"].ToString().Trim())
            {
                strSQL += " IsNULL(WMD.REASSIGN_DESTCD,WMD.DestCD) <>'" + Session["brcd"].ToString().Trim() + "' ";
            }
            else
            {
                strSQL += " ORGNCD=IsNULL(Reassign_Destcd,DESTCD) ";
            }

            strSQL += " AND WMD.DockDt between '" + strFromDate + "' and '" + strToDate + "' ORDER BY WMD.Reassign_DestCd, WMD.ORGNCD, WMD.DOCKNO+WMD.DOCKSF, WMD.DOCKDT";
        }
    }

    private void paintDocketListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocketList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("CheckBoxOrSpace", typeof(string));
        dt.Columns.Add("RowColor", typeof(string));
        dt.Columns.Add("SrNo", typeof(string));
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
        dt.Columns.Add("ChargeWeight", typeof(string));
        dt.Columns.Add("FromTo", typeof(string));
        dt.Columns.Add("TrnMode", typeof(string));

        DataRow dr;

        sqlDA.Fill(dsDocketList);

        int i = 1;

        intTotalRecords = dsDocketList.Tables[0].Rows.Count;
        HidTotalRecords.Value = intTotalRecords.ToString();

        trDocketList.Visible = true;
        trTableHeadersForMF.Visible = true;
        //trPrepBy.Visible = false;

        string strGiveAlert = "";
        string strStdPayBase = "P02,P08,P09";

        strDocketNoList = "";
        strPackageNoList = "";
        strWeightNoList = "";
        strChargeWeightNoList = "";

        string strFromDateToDisplay = strFromDate.Substring(0, strFromDate.IndexOf(' ')).Trim();
        string[] strArrDateFrom = strFromDateToDisplay.Split('-');
        strFromDateToDisplay = strArrDateFrom[0] + " " + strArrDateFrom[1] + " " + strArrDateFrom[2].Substring(2);
        string strToDateToDisplay = strToDate.Substring(0, strToDate.IndexOf(' ')).Trim();
        string[] strArrDateTo = strToDateToDisplay.Split('-');
        strToDateToDisplay = strArrDateTo[0] + " " + strArrDateTo[1] + " " + strArrDateTo[2].Substring(2);
        lblInstrunction.InnerHtml = "<b>" + HidDocket.Value + "(s) Date: " + strFromDateToDisplay + " - " + strToDateToDisplay + "</b>";

        if (intTotalRecords > 0)
        {
            trNoRecsForDocketList.Visible = false;
            trPrepareManifest.Visible = true;
            rptDocketList.Visible = true;
            //trPrepBy.Visible = true;

            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                dr = dt.NewRow();

                strGiveAlert = (drRows["DocketMode"].ToString() == "Q" ? (strStdPayBase.Contains(drRows["PayBase"].ToString()) ? "N" : "Y") : "");

                dr["CheckBoxOrSpace"] = (blnPostSQL == true ? "" : "<input id=\"chkSelDocket\" type=\"checkbox\" runat=\"server\" value=\"" + drRows["DocketNo"].ToString() + "\" onclick=\"SelectDocket('" + drRows["DocketMode"].ToString() + "','" + drRows["DocketNo"].ToString() + "', this)\" />");
                dr["RowColor"] = (drRows["DocketMode"].ToString() == "Q" ? "#FF0000" : "#000000");
                dr["SrNo"] = i.ToString();
                i++;
                dr["DocketNo"] = drRows["DocketNo"].ToString();
                if (strGiveAlert == "N" || strGiveAlert == "")
                {
                    strDocketNoList = (strDocketNoList == "" ? drRows["DocketNo"].ToString() : strDocketNoList + "," + drRows["DocketNo"].ToString());
                    strPackageNoList = (strPackageNoList == "" ? drRows["PackagesLB"].ToString() : strPackageNoList + "," + drRows["PackagesLB"].ToString());
                    strWeightNoList = (strWeightNoList == "" ? drRows["WeightLB"].ToString() : strWeightNoList + "," + drRows["WeightLB"].ToString());
                    strChargeWeightNoList = (strChargeWeightNoList == "" ? drRows["ChargeWeight"].ToString() : strChargeWeightNoList + "," + drRows["ChargeWeight"].ToString());
                }
                dr["DocketMode"] = drRows["DocketMode"].ToString();
                dr["DocketDate"] = (drRows["DocketDate"].ToString().Trim() == "" || drRows["DocketDate"].ToString().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["DocketDate"].ToString()).ToString("dd MMM yy"));
                dr["OrgCode"] = drRows["OrgCode"].ToString();
                dr["ConsName"] = (drRows["ConsName"].ToString() == "" ? "-" : drRows["ConsName"].ToString()); //GenerateProperCase(drRows["ConsName"].ToString()));
                dr["DelyLoc"] = (drRows["Reassign_destcd"].ToString().Trim() == "" || drRows["Reassign_destcd"].ToString().ToUpper() == "NULL" ? drRows["DestCode"].ToString() : drRows["Reassign_destcd"].ToString());
                dr["DestCode"] = drRows["DestCode"].ToString();
                dr["ArrivalDate"] = (drRows["ArrivalDate"].ToString().Trim() == "" || drRows["ArrivalDate"].ToString().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["ArrivalDate"].ToString()).ToString("dd MMM yy"));
                dr["DelyDate"] = (drRows["DelyDate"].ToString().Trim() == "" || drRows["DelyDate"].ToString().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["DelyDate"].ToString()).ToString("dd MMM yy"));
                dr["PackagesLB"] = drRows["PackagesLB"].ToString();
                dr["WeightLB"] = drRows["WeightLB"].ToString();
                dr["ChargeWeight"] = drRows["ChargeWeight"].ToString();
                dr["FromTo"] = drRows["FromTo"].ToString();
                dr["TrnMode"] = drRows["TrnMode"].ToString();

                dt.Rows.Add(dr);
            }

            rptDocketList.DataSource = dt;
            rptDocketList.DataBind();
        }
        else
        {
            trNoRecsForDocketList.Visible = true;
            trPrepareManifest.Visible = false;
            rptDocketList.Visible = false;
        }

        HidSelectedDocketNos.Value = strDocketNoList;
        HidSelectedPackageNos.Value = strPackageNoList;
        HidSelectedWeightNos.Value = strWeightNoList;
        HidSelectedChargeWeightNos.Value = strChargeWeightNoList;
        HidSelectedDockets.Value = "";
        HidSelectedPackages.Value = "";
        HidSelectedWeights.Value = "";
        HidSelectedChargeWeights.Value = "";

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

    protected void btnPrepareMF_Click(object sender, EventArgs e)
    {
        //Prepare Manifest
        prepareManifest();
    }

    private void prepareManifest()
    {
        string strRemainingDataList = PrepareRemainingPackagesAndWeight();

        string[] strArrRemDataList = strRemainingDataList.Split('~');

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_Create_LS_MF";

            sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());

            sqlCommand.Parameters.AddWithValue("@docklist", "'" + HidSelectedDockets.Value.Replace(",", "','") + "'");

            sqlCommand.Parameters.AddWithValue("@RemainingDocketList", strArrRemDataList[0]);
            sqlCommand.Parameters.AddWithValue("@RemainingPackagesList", strArrRemDataList[1]);
            sqlCommand.Parameters.AddWithValue("@RemainingWeightList", strArrRemDataList[2]);
            sqlCommand.Parameters.AddWithValue("@RemainingChargeWeightList", strArrRemDataList[11]);

            sqlCommand.Parameters.AddWithValue("@TotalDockets", strArrRemDataList[3]);
            sqlCommand.Parameters.AddWithValue("@TotalPackages", strArrRemDataList[4]);
            sqlCommand.Parameters.AddWithValue("@TotalWeight", strArrRemDataList[5]);
            sqlCommand.Parameters.AddWithValue("@TotalChargeWeight", strArrRemDataList[12]);

            sqlCommand.Parameters.AddWithValue("@strXMLForTCTRN", strArrRemDataList[6]);
            sqlCommand.Parameters.AddWithValue("@strXMLForRemPackagesWeightForStatus", strArrRemDataList[7]);

            sqlCommand.Parameters.AddWithValue("@TotalOriginalPackages", strArrRemDataList[8]);
            sqlCommand.Parameters.AddWithValue("@TotalOriginalWeight", strArrRemDataList[9]);
            sqlCommand.Parameters.AddWithValue("@TotalOriginalChargeWeight", strArrRemDataList[10]);

            sqlCommand.Parameters.AddWithValue("@tohub", txtNextStop.Text);
            sqlCommand.Parameters.AddWithValue("@empcd", Session["empcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@Manual_tcno", txtManualMFNo.Text);
            sqlCommand.Parameters.Add("@Manual_tcdt", SqlDbType.DateTime).Value = Convert.ToDateTime(getDateInddMMMyyyFormat(txtMFDate.Value));

            sqlCommand.Parameters.AddWithValue("@PrepBy", txtPrepBy.Text);
            sqlCommand.Parameters.AddWithValue("@FinYear", Session["FinYear"].ToString());

            sqlCommand.Parameters.AddWithValue("@from_city", strFromCity.Trim());
            sqlCommand.Parameters.AddWithValue("@to_city", strToCity.Trim());

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsPrepareMF = new DataSet();

            sqlDA.Fill(dsPrepareMF);

            if (dsPrepareMF.Tables[0].Rows.Count > 0)
            {
                strNextManifestNo = dsPrepareMF.Tables[0].Rows[0]["MF"].ToString();
                blnMFCreated = (dsPrepareMF.Tables[0].Rows[0]["Created"].ToString() == "T" ? true : false);

                if (blnMFCreated == true)
                {
                    //managePostSQL();
                    Response.Redirect("DisplayMFResult.aspx?MFNo=" + strNextManifestNo + "&ManMFNo=" + txtManualMFNo.Text.Trim());
                }
                else
                {
                    trPrepareMFErrorMsg.Visible = true;
                    lblPrepareMFErrorMsg.InnerHtml = "An unknown error has occurred while preparing " + HidMF.Value + ".";
                }
            }
        }
        catch (Exception Ex)
        {
            trPrepareMFErrorMsg.Visible = true;
            lblPrepareMFErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message + Ex.Source;
        }
        finally
        {
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
            strToDate = getDateInddMMMyyyFormat(txtToDate.Value);
        }
        else if (radToday.Checked == true)
        {
            strFromDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
            strToDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
        }
        else if (radLastWeek.Checked == true)
        {
            DateTime dtLastWeek = System.DateTime.Today.AddDays(-6);

            strFromDate = dtLastWeek.ToString("dd-MMM-yyyy");
            strToDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
        }

        strFromDate += " 00:00:00";
        strToDate += " 23:59:59";

        strManualLSNo = txtManualMFNo.Text.Trim();
        strDocketList = txtDockets.Value.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        strNextLocation = txtNextStop.Text.Replace("'", "").Replace(" ", "").Trim();
        strDestination = txtDestCd.Value.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        strRegion = (ddlRegion.SelectedValue == "-1" ? "" : ddlRegion.SelectedValue);
        strFromCity = txtCityFrom.Text.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
        strToCity = txtCityTo.Text.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim();
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

                return (dsConsName.Tables[0].Rows.Count > 0 ? dsConsName.Tables[0].Rows[0][0].ToString() : "-"); //GenerateProperCase(dsConsName.Tables[0].Rows[0][0].ToString()) : "-");
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
    //    trLSCaption.Visible = false;
    //    trLSCaptionWithLink.Visible = true;
    //    lnkbtnDocketsinMFForTH.Text = strNextManifestNo;

    //    trPrepareManifest.Visible = false;

    //    trNextStep.Visible = true;
    //    trPrepareMoreMF.Visible = true;
    //    trPrepareMoreTHC.Visible = true;

    //    paintDocketsInMF();
    //}

    protected void lnkbtnDocketsinMFForTH_Click(object sender, EventArgs e)
    {
        //This is pending
        //Response.Redirect("~/GUI/Operations/LoadingSheet/PrepareMFFromLS.aspx?LSNo=" + strNextManifestNo);
    }

    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        
    }

    private string checkCheckboxSelected()
    {
        return (blnCheckAllClicked == true && chkAll.Checked == true ? "checked=\"checked\"" : "");
    }

    private void paintDocketsInMF()
    {
        try
        {
            tdForMF.Visible = false;
            blnPostSQL = true;
            //Generate SQL

            string strSQL = "SELECT (CASE D.TRN_Mod WHEN 1 THEN 'Air' WHEN 2 THEN 'Road' WHEN 3 THEN 'Train'  " +
                            "WHEN 4 THEN 'Express' ELSE '-' END ) AS TrnMode, D.DOCKNO+D.DOCKSF As DocketNo, " + 
                            "Convert(varchar, D.DOCKDT, 103) AS DocketDate, D.ORGNCD AS OrgCode, " +
                            "D.CSGNCD AS ConsCD, D.CSGNNM AS ConsName, WTDS.NextLoc AS DelyLoc, D.DESTCD AS DestCode, " +
                            "'' AS ArrivalDate, Convert(varchar, D.CDELDT, 103) AS DelyDate, D.PKGSNO  AS PackagesLBOld, D.ACTUWT AS WeightLBOld, " +
                            "tc.LOADPKGSNO  AS PackagesLB, tc.LOADACTUWT AS WeightLB, WTDS.Docket_Mode AS DocketMode, " +
                            "D.Reassign_destcd, ISNULL(D.from_loc, '') + ' - ' + ISNULL(D.to_loc, '') AS FromTo From Webx_Master_Docket D Inner Join WebX_TCTRN tc on D.dockno=tc.dockno " +
                            "Inner Join WebX_Trans_Docket_Status WTDS on D.dockno + D.docksf = WTDS.dockno + WTDS.dockSF " +
                            "where tc.tcno = '" + strNextManifestNo + "'";

            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDocketListForMF = new DataSet();
            sqlDA.Fill(dsDocketListForMF);

            DataTable dt = new DataTable();

            dt.Columns.Add("RowColor", typeof(string));
            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("DocketNo", typeof(string));
            dt.Columns.Add("DocketMode", typeof(string));
            dt.Columns.Add("DocketDate", typeof(string));
            dt.Columns.Add("OrgCode", typeof(string));
            dt.Columns.Add("ConsName", typeof(string));
            dt.Columns.Add("NextStop", typeof(string));
            dt.Columns.Add("DelyLoc", typeof(string));
            dt.Columns.Add("ArrivalDate", typeof(string));
            dt.Columns.Add("DelyDate", typeof(string));
            dt.Columns.Add("PackagesLB", typeof(string));
            dt.Columns.Add("WeightLB", typeof(string));

            DataRow dr;

            int i = 1;

            intTotalRecords = dsDocketListForMF.Tables[0].Rows.Count;
            HidTotalRecords.Value = intTotalRecords.ToString();
            trTableHeadersForMF.Visible = true;
            rptDocketList.Visible = false;

            if (intTotalRecords > 0)
            {
                rptViewDocketsInMF.Visible = true;

                foreach (DataRow drRows in dsDocketListForMF.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["RowColor"] = (drRows["DocketMode"].ToString() == "Q" ? "#FF0000" : "#000000");
                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["DocketNo"] = drRows["DocketNo"].ToString();
                    dr["DocketMode"] = drRows["DocketMode"].ToString();
                    dr["DocketDate"] = (drRows["DocketDate"].ToString().Trim() == "" || drRows["DocketDate"].ToString().Trim().ToUpper() == "NULL" ? "-" : getDateInddMMMyyFormat(drRows["DocketDate"].ToString()));
                    dr["OrgCode"] = drRows["OrgCode"].ToString();
                    dr["ConsName"] = (drRows["ConsName"].ToString() == "" ? "-" : drRows["ConsName"].ToString()); //GenerateProperCase(drRows["ConsName"].ToString()));
                    dr["NextStop"] = drRows["DelyLoc"].ToString();
                    dr["DelyLoc"] = (drRows["Reassign_destcd"].ToString().Trim() == "" || drRows["Reassign_destcd"].ToString().ToUpper() == "NULL" ? drRows["DestCode"].ToString() : drRows["Reassign_destcd"].ToString());
                    dr["ArrivalDate"] = (drRows["ArrivalDate"].ToString().Trim() == "" || drRows["ArrivalDate"].ToString().Trim().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["ArrivalDate"].ToString()).ToString("dd MMM yy"));
                    dr["DelyDate"] = (drRows["DelyDate"].ToString().Trim() == "" || drRows["DelyDate"].ToString().Trim().ToUpper() == "NULL" ? "-" : getDateInddMMMyyFormat(drRows["DelyDate"].ToString()));
                    dr["PackagesLB"] = drRows["PackagesLB"].ToString();
                    dr["WeightLB"] = drRows["WeightLB"].ToString();

                    dt.Rows.Add(dr);
                }

                rptViewDocketsInMF.DataSource = dt;
                rptViewDocketsInMF.DataBind();
            }
        }
        catch (Exception Ex)
        {

        }
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

    private string PrepareRemainingPackagesAndWeight()
    {
        string[] strArrDocketNos = HidSelectedDocketNos.Value.Split(',');
        string[] strArrPackagesNos = HidSelectedPackageNos.Value.Split(',');
        string[] strArrWeightsNos = HidSelectedWeightNos.Value.Split(',');
        string[] strArrChargeWeightsNos = HidSelectedChargeWeightNos.Value.Split(',');

        string[] strArrDockets = HidSelectedDockets.Value.Split(',');
        string[] strArrPackages = HidSelectedPackages.Value.Split(',');
        string[] strArrWeights = HidSelectedWeights.Value.Split(',');
        string[] strArrChargeWeights = HidSelectedChargeWeights.Value.Split(',');

        string strRemainingDocketList = "";
        string strRemainingPackagesList = "";
        string strRemainingWeightList = "";
        string strRemainingChargeWeightList = "";

        int intPackages = 0;
        double dblWeight = 0;
        double dblChargeWeight = 0;

        int intTotalPackages = 0;
        double dblTotalWeight = 0;
        double dblTotalChargeWeight = 0;

        int intTotalOriginalPackages = 0;
        double dblTotalOriginalWeight = 0;
        double dblTotalOriginalChargeWeight = 0;

        string strSQLForTCTRN = "<root>";
        string strSQLForStatus = "<root>";

        for (int intLoopCounter = 0; intLoopCounter < strArrDockets.Length; intLoopCounter++)
        {
            intTotalPackages += Convert.ToInt32(strArrPackages[intLoopCounter]);
            dblTotalWeight += Convert.ToDouble(strArrWeights[intLoopCounter]);
            dblTotalChargeWeight += Convert.ToDouble(strArrChargeWeights[intLoopCounter]);

            strSQLForTCTRN += "<tctrn>" +
                              "<tcno></tcno>" +
                              "<tcsf>" + "." + "</tcsf>" +
                              "<dockno>" + strArrDockets[intLoopCounter].Substring(0, strArrDockets[intLoopCounter].Length - 1) + "</dockno>" +
                              "<docsf>" + strArrDockets[intLoopCounter].Substring(strArrDockets[intLoopCounter].Length - 1) + "</docsf>" +
                              "<packages>" + strArrPackages[intLoopCounter] + "</packages>" +
                              "<weight>" + strArrWeights[intLoopCounter] + "</weight>" +
                              "<chargeweight>" + strArrChargeWeights[intLoopCounter] + "</chargeweight>" +
                              "</tctrn>";

            for (int intInnerLoopCounter = 0; intInnerLoopCounter < strArrDocketNos.Length; intInnerLoopCounter++)
            {
                if (strArrDocketNos[intInnerLoopCounter] == strArrDockets[intLoopCounter])
                {
                    intPackages = Convert.ToInt32(strArrPackagesNos[intInnerLoopCounter]) - Convert.ToInt32(strArrPackages[intLoopCounter]);
                    dblWeight = Convert.ToDouble(strArrWeightsNos[intInnerLoopCounter]) - Convert.ToDouble(strArrWeights[intLoopCounter]);
                    dblChargeWeight = Convert.ToDouble(strArrChargeWeightsNos[intInnerLoopCounter]) - Convert.ToDouble(strArrChargeWeights[intLoopCounter]);

                    intTotalOriginalPackages += Convert.ToInt32(strArrPackagesNos[intInnerLoopCounter]);
                    dblTotalOriginalWeight += Convert.ToDouble(strArrWeightsNos[intInnerLoopCounter]);
                    dblTotalOriginalChargeWeight += Convert.ToDouble(strArrChargeWeightsNos[intInnerLoopCounter].Trim() == "" ? "0" : strArrChargeWeightsNos[intInnerLoopCounter]);

                    if (intPackages > 0)
                    {
                        strRemainingPackagesList = (strRemainingPackagesList == "" ? intPackages.ToString() : strRemainingPackagesList + "," + intPackages.ToString());
                        strRemainingWeightList = (strRemainingWeightList == "" ? dblWeight.ToString() : strRemainingWeightList + "," + dblWeight.ToString());
                        strRemainingChargeWeightList = (strRemainingChargeWeightList == "" ? dblChargeWeight.ToString() : strRemainingChargeWeightList + "," + dblChargeWeight.ToString());
                        strRemainingDocketList = (strRemainingDocketList== "" ? strArrDockets[intLoopCounter] : strRemainingDocketList+ "," + strArrDockets[intLoopCounter]);

                        strSQLForStatus += "<wtds>" +
                                           "<docketno>" + strArrDockets[intLoopCounter].Substring(0, strArrDockets[intLoopCounter].Length - 1) + "</docketno>" +
                                           "<docketsf>X</docketsf>" +
                                           "<currloc>" + Session["brcd"].ToString() + "</currloc>" +
                                           "<billed>" + "N" + "</billed>" +
                                           "<mr>" + "N" + "</mr>" +
                                           "<octroimr>" + "N" + "</octroimr>" +
                                           "<ls></ls>" +
                                           "<mf></mf>" +
                                           "<delivered>" + "N" + "</delivered>" +
                                           "<cancelled>" + "N" + "</cancelled>" +
                                           "<op_status>" + "B" + "</op_status>" +
                                           "<docketmode>" + "F" + "</docketmode>" + 
                                           "</wtds>";
                    }

                    break;
                }
            }
        }

        strSQLForTCTRN += "</root>";

        strSQLForStatus = (strSQLForStatus == "<root>" ? "" : strSQLForStatus + "</root>");

        return strRemainingDocketList + "~" + strRemainingPackagesList + "~" + strRemainingWeightList + "~" + strArrDockets.Length.ToString() + "~" + intTotalPackages.ToString() + "~" + dblTotalWeight.ToString() + "~" + strSQLForTCTRN + "~" + strSQLForStatus + "~" + intTotalOriginalPackages.ToString() + "~" + dblTotalOriginalWeight.ToString() + "~" + dblTotalOriginalChargeWeight.ToString() + "~" + strRemainingChargeWeightList + "~" + dblTotalChargeWeight.ToString();
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

    private void getMFManualNoMandatoryYN()
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

            sqlCommand.Parameters.AddWithValue("@DocumentName", "MF");

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

    private void populateZoneDetails()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();


        string strSQLForRegion = "select distinct LocCode + ' : ' + LocName AS LocCodeName, Loccode from webx_location where Loc_Level = (SELECT top 1 Loc_Level - 1 FROM webx_location WHERE LocCode = '" + Session["brcd"].ToString() + "') ORDER BY LocCode";
        SqlCommand sqlCommand = new SqlCommand(strSQLForRegion, sqlConn);

        /*SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "Webx_SP_GetZone";
        */
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsZone = new DataSet();

        sqlDA.Fill(dsZone);

        if (dsZone.Tables[0].Rows.Count > 0)
        {
            ddlRegion.DataTextField = "LocCodeName"; // CodeDesc
            ddlRegion.DataValueField = "Loccode"; // CodeId

            ddlRegion.DataSource = dsZone;
            ddlRegion.DataBind();
        }

        ddlRegion.Items.Insert(0, new ListItem("Select", "-1"));
    }

    private void getLSRequiredForMFYN()
    {
        HidLSReqForMF.Value = "N";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        try
        {
            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandText = "Webx_SP_GetLSReqForMF";
            sqlCommand.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
            DataSet dsLSReqForMF = new DataSet();

            sqlDA.Fill(dsLSReqForMF);

            HidLSReqForMF.Value = (dsLSReqForMF.Tables[0].Rows.Count > 0 ? dsLSReqForMF.Tables[0].Rows[0][0].ToString() : "N");
        }
        catch (Exception Ex)
        {
            sqlConn.Close();
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

    protected void txtPrepBy_TextChanged(object sender, EventArgs e)
    {
        //ErrorRaise
        //Check for Next Location
        txtPrepBy.Text = txtPrepBy.Text.Trim().ToUpper();
        lblErrorPrepBy.Visible = false;

        if (txtPrepBy.Text == "")
        {
            lblErrorPrepBy.Visible = false;
            ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;

            return;
        }
        else if (txtPrepBy.Text == Session["empcd"].ToString())
        {
            lblPrepByName.InnerHtml = Session["empnm"].ToString();
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLPrepBy = "select UserId, [Name] AS UserName from webx_master_users WHERE UserId = '" + txtPrepBy.Text + "' AND BranchCode = '" + Session["brcd"].ToString() + "' and Status='100'";

        SqlCommand sqlCommand = new SqlCommand(strSQLPrepBy, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsPrepBy = new DataSet();

        sqlDA.Fill(dsPrepBy);

        lblErrorPrepBy.Visible = (dsPrepBy.Tables[0].Rows.Count > 0 ? false : true);
        //ErrorRaise = (ErrorRaise == true ? true : lblErrorPrepBy.Visible);
        ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;

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
            ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLFromCity = "select * from webx_citymaster where location = '" + txtCityFrom.Text + "'"; //book_loc = '" + Session["brcd"].ToString() + "'

        SqlCommand sqlCommand = new SqlCommand(strSQLFromCity, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsFromCity = new DataSet();

        sqlDA.Fill(dsFromCity);

        lblErrorCityFrom.Visible = (dsFromCity.Tables[0].Rows.Count > 0 ? false : true);
        //ErrorRaise = (ErrorRaise == true ? true : lblErrorCityFrom.Visible);
        ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;

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
            ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;

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
        //ErrorRaise = (ErrorRaise == true ? true : lblErrorCityTo.Visible);
        ErrorRaise = lblErrorNextStop.Visible || lblErrorCityFrom.Visible || lblErrorCityTo.Visible || lblErrorPrepBy.Visible;

        if (lblErrorCityTo.Visible == true)
        {
            txtCityTo.Focus();
        }

        sqlConn.Close();
    }
}

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

public partial class GUI_Operations_DRS_UpdateDRSDetailsStep1 : System.Web.UI.Page
{
    public static string strDRSNo;
    public static string strDocketNoList;
    public static string strCODDODAmountList;
    public static string strDocketDateList;
    public static string strCDelDateList;
    public static string strPendingPackagesForDeliveryList;
    public static string strDocketList;
    public static string strFromDate;
    public static string strToDate;
    public static string strManualDRSCode;
    public static string strDRSDate;
    public static string strDelyBy;
    public static string strBAVendorCode;
    public static string strVendorName;
    public static string strStaff;
    public static string strStaffCode;
    public static string strVehType;
    public static string strVehTypeCode;
    public static string strVehNo;
    public static string strManualVehNo;
    public static string strDriver;
    public static string strStartKM;
    public static string strDelyAt;
    public static string strBACode;
    public static string strVendorCode;
    public static string strNextDRSCode;
    public static string strTotalDocketsInDRS;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strDRSNo = HttpUtility.UrlDecode(Request.QueryString["DRSCode"].ToString());

            getDocumentDetails();

            //strDRSNo = Session["DRSCode"].ToString();
            //Display Selected DRS Details
            displayDRSDetails();
            //Paint Docket Listing
            paintDocketListing();
            //Populate Reasons for No Delivery of Packages
            //populateReasonUFdelivered();
            populateDeliveryReason("UNDELY", 2);
            //Populate Reasons for Fully Delivered Packages
            populateDeliveryReason("LATE_D", 3);
            //Populate Reasons for Partly Delivered Packages
            //populateReasonPartlyDelivered();
            populateDeliveryReason("PART_D", 1);
        }

        lblTotalDockets.InnerHtml = "<b>Total " + HidDocket.Value + "(s) In " + HidDRS.Value + ":</b>";
        lblDocketBkgDate.InnerHtml = "<b>" + HidDocket.Value + "<br />Booking Date</b>";
        lblNoRecsForDocket.InnerHtml = "No " + HidDocket.Value + "(s) found for the Selected " + HidDRS.Value + " " + strDRSNo + ".";
        lblHeader.InnerHtml = "<b>Update " + HidDRS.Value + ": " + strDRSNo + "</b>";
        lblDRSHeaderInfo.InnerHtml = "<b>" + HidDRS.Value + " Header Information</b>";
        lblDRSCode.InnerHtml = "<b>" + HidDRS.Value + " Code:</b>";
        lblDRSNo.InnerHtml = strDRSNo;
        lblDRSLocationCaption.InnerHtml = "<b>" + HidDRS.Value + " Location:</b>";
        lblDRSDateCaption.InnerHtml = "<b>" + HidDRS.Value + " Date:</b>";

        btnUpdateDRS.Value = "Update " + HidDRS.Value;
        btnUpdateDRS.Attributes.Add("title", "Click here to Update " + HidDRS.Value);

        Page.Title = "Update Selected " + HidDRS.Value + " Details";
    }

    private void displayDRSDetails()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        try
        {
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_DRS_Summary";

            sqlCommand.Parameters.AddWithValue("@pdcno", strDRSNo);
            
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDRSDetails = new DataSet();

            sqlDA.Fill(dsDRSDetails);

            if (dsDRSDetails.Tables[0].Rows.Count > 0)
            {
                //Populate Local Variables
                strDRSDate = getDateInddMMMyyFormat(dsDRSDetails.Tables[0].Rows[0]["PDC_Dt"].ToString());
                strDelyBy = dsDRSDetails.Tables[0].Rows[0]["deliveryBy"].ToString();
                strBAVendorCode = (dsDRSDetails.Tables[0].Rows[0]["BA_Vendor_Code"] == System.DBNull.Value ? "-" : dsDRSDetails.Tables[0].Rows[0]["BA_Vendor_Code"].ToString());
                strStaff = dsDRSDetails.Tables[0].Rows[0]["Staff"].ToString();
                strDriver = dsDRSDetails.Tables[0].Rows[0]["DriverName"].ToString();
                strVehNo = dsDRSDetails.Tables[0].Rows[0]["VEHNO"].ToString();
                strStartKM = dsDRSDetails.Tables[0].Rows[0]["Start_KM"].ToString();
                strTotalDocketsInDRS = dsDRSDetails.Tables[0].Rows[0]["Total_Dockets_In_DRS"].ToString();

                lblDRSLocation.InnerHtml = Session["brcd"].ToString().ToUpper();

                lblDRSDate.InnerHtml = strDRSDate;

                lblDeliveryBy.InnerHtml = strDelyBy;

                if (strDelyBy == "BA")
                {
                    trDeliveryByBA.Visible = true;
                    lblBACode.InnerHtml = strBAVendorCode;
                    strBACode = strBAVendorCode;
                    strVendorCode = "";
                }
                else
                {
                    trDeliveryByStaff.Visible = true;
                    trStaff.Visible = true;
                    lblVendorCode.InnerHtml = strBAVendorCode;
                    lblStaff.InnerHtml = strStaff;
                    strBACode = "";
                    strVendorCode = strBAVendorCode;
                }

                lblVehicleNo.InnerHtml = strVehNo;

                lblDriver.InnerHtml = strDriver;

                lblStartKM.InnerHtml = strStartKM;

                lblTotalDocketsInDRS.InnerHtml = strTotalDocketsInDRS;
            }
            else
            {
                return;
            }
        }
        catch (Exception Ex)
        {

        }
    }

    private void paintDocketListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        try
        {
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_dockets_for_drs_updation";

            sqlCommand.Parameters.AddWithValue("@pdcno", strDRSNo);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDRSDetails = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("CheckBoxOrSpace", typeof(string));
            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("DocketNo", typeof(string));
            dt.Columns.Add("DocketSuffix", typeof(string));
            dt.Columns.Add("DocketDate", typeof(string));
            dt.Columns.Add("OrgCode", typeof(string));
            dt.Columns.Add("DestCode", typeof(string));
            dt.Columns.Add("PayBasis", typeof(string));
            dt.Columns.Add("CsgnCode", typeof(string));
            dt.Columns.Add("CsgnName", typeof(string));
            dt.Columns.Add("CsgeCode", typeof(string));
            dt.Columns.Add("CsgeName", typeof(string));
            dt.Columns.Add("PackagesArrived", typeof(string));
            dt.Columns.Add("PackagesBooked", typeof(string));
            dt.Columns.Add("PackagesPending", typeof(string));
            dt.Columns.Add("CommDelyDate", typeof(string));
            dt.Columns.Add("Freight", typeof(string));
            dt.Columns.Add("DocketTotal", typeof(string));
            dt.Columns.Add("ServiceTax", typeof(string));
            dt.Columns.Add("DelyLoc", typeof(string));
            dt.Columns.Add("PayBasCode", typeof(string));
            dt.Columns.Add("DeliveryDate", typeof(string));
            dt.Columns.Add("DeliveryTimeHH", typeof(string));
            dt.Columns.Add("DeliveryTimeMM", typeof(string));
            dt.Columns.Add("CODDOD", typeof(bool));
            dt.Columns.Add("CODDODAmountVisible", typeof(bool));
            dt.Columns.Add("CODDODAmountHidden", typeof(bool));
            dt.Columns.Add("CODDODAmount", typeof(string));
            dt.Columns.Add("DelyDateTextBoxID", typeof(string));
            dt.Columns.Add("DelyDateLinkID", typeof(string));
            dt.Columns.Add("PackagesDeliveredID", typeof(string));

            DataRow dr;

            sqlDA.Fill(dsDRSDetails);

            int i = 1;

            HidTotalRecords.Value = dsDRSDetails.Tables[0].Rows.Count.ToString();

            trDocketList.Visible = true;
            trUpdateDRSErrorMsg.Visible = false;

            strDocketNoList = "";      
            strCODDODAmountList = "";
            strDocketDateList = "";
            strCDelDateList = "";
            strPendingPackagesForDeliveryList = "";

            if (dsDRSDetails.Tables[0].Rows.Count > 0)
            {
                trNoRecsForDocketList.Visible = false;
                trUpdateDRS.Visible = true;
                rptDocketList.Visible = true;
                int j;

                foreach (DataRow drRows in dsDRSDetails.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    j = i - 1;

                    dr["SrNo"] = i.ToString();
                    dr["DelyDateTextBoxID"] = "ctl00_MyCPH1_rptDocketList_ctl" + (j > 9 ? "" : "0") + j.ToString() + "_txtDeliveryDate";
                    dr["DelyDateLinkID"] = "ctl00_MyCPH1_rptDocketList_ctl" + (j > 9 ? "" : "0") + j.ToString() + "_aLnkDeliveryDate";
                    dr["PackagesDeliveredID"] = "ctl00_MyCPH1_rptDocketList_ctl" + (j > 9 ? "" : "0") + j.ToString() + "_txtPackagesDelivered";
                    
                    i++;
                    dr["DocketNo"] = drRows["dockno"].ToString();
                    dr["DocketSuffix"] = drRows["docksf"].ToString();
                    
                    strDocketNoList = (strDocketNoList == "" ? drRows["dockno"].ToString() + drRows["docksf"].ToString() : strDocketNoList + "," + drRows["dockno"].ToString() + drRows["docksf"].ToString());
                    strCODDODAmountList = (strCODDODAmountList == "" ? drRows["CODDODAmount"].ToString() : strCODDODAmountList + "," + drRows["CODDODAmount"].ToString());
                    strDocketDateList = (strDocketDateList == "" ? drRows["DockDt_ddmmyyyy"].ToString() : strDocketDateList + "," + drRows["DockDt_ddmmyyyy"].ToString());
                    strCDelDateList = (strCDelDateList == "" ? drRows["CDELDT_ddmmyyyy"].ToString() : strCDelDateList + "," + drRows["CDELDT_ddmmyyyy"].ToString());
                    strPendingPackagesForDeliveryList = (strPendingPackagesForDeliveryList == "" ? drRows["pkgs_pending"].ToString() : strPendingPackagesForDeliveryList + "," + drRows["pkgs_pending"].ToString());

                    dr["DocketDate"] = (drRows["Booking_Date"].ToString().Trim() == "" || drRows["Booking_Date"].ToString().Trim().ToUpper() == "NULL" ? "-" : getDateInddMMMyyFormat(drRows["Booking_Date"].ToString()));
                    dr["OrgCode"] = drRows["orgncd"].ToString();
                    dr["DestCode"] = drRows["destcd"].ToString();
                    dr["PayBasis"] = drRows["PayBasis"].ToString();
                    dr["CsgnCode"] = (drRows["csgncd"].ToString() == "" || drRows["csgncd"].ToString().ToUpper() == "NULL" ? "-" : drRows["csgncd"].ToString());
                    dr["CsgnName"] = (drRows["csgnnm"].ToString() == "" || drRows["csgnnm"].ToString().ToUpper() == "NULL" ? "-" : drRows["csgnnm"].ToString()); //GenerateProperCase(drRows["csgnnm"].ToString()));
                    dr["CsgeCode"] = (drRows["csgecd"].ToString() == "" || drRows["csgecd"].ToString().ToUpper() == "NULL" ? "-" : drRows["csgecd"].ToString());
                    dr["CsgeName"] = (drRows["csgenm"].ToString() == "" || drRows["csgenm"].ToString().ToUpper() == "NULL" ? "-" : drRows["csgenm"].ToString()); //GenerateProperCase(drRows["csgenm"].ToString()));
                    dr["PackagesArrived"] = drRows["pkgs_arrived"].ToString();
                    dr["PackagesBooked"] = drRows["pkgs_booked"].ToString();
                    dr["PackagesPending"] = drRows["pkgs_pending"].ToString();
                    dr["CommDelyDate"] = (drRows["comm_dely_dt"].ToString().Trim() == "" || drRows["comm_dely_dt"].ToString().Trim().ToUpper() == "NULL" ? "-" : getDateInddMMMyyFormat(drRows["comm_dely_dt"].ToString()));
                    dr["Freight"] = (drRows["Freight"].ToString() == "" || drRows["Freight"].ToString().ToUpper() == "NULL" ? "-" : drRows["Freight"].ToString());
                    dr["DocketTotal"] = drRows["Docket_Total"].ToString();
                    dr["ServiceTax"] = (drRows["Service_Tax"].ToString() == "" || drRows["Service_Tax"].ToString().ToUpper() == "NULL" ? "-" : drRows["Service_Tax"].ToString());
                    dr["DelyLoc"] = (drRows["DelyLocation"].ToString().Trim() == "" || drRows["DelyLocation"].ToString().Trim().ToUpper() == "NULL" ? "-" : drRows["DelyLocation"].ToString());
                    dr["PayBasCode"] = drRows["PayBasCode"].ToString();
                    dr["DeliveryDate"] = System.DateTime.Today.ToString("dd/MM/yyyy");
                    dr["DeliveryTimeHH"] = System.DateTime.Now.Hour.ToString("00");
                    dr["DeliveryTimeMM"] = System.DateTime.Now.Minute.ToString("00");
                    dr["CODDOD"] = (drRows["COD_DOD"].ToString().ToUpper() == "Y" ? true: false);
                    dr["CODDODAmountVisible"] = (Convert.ToDouble(drRows["CODDODAmount"].ToString()) > 0 ? false : true);
                    dr["CODDODAmountHidden"] = (Convert.ToDouble(drRows["CODDODAmount"].ToString()) > 0 ? true : false);
                    dr["CODDODAmount"] = Convert.ToDouble(drRows["CODDODAmount"].ToString()).ToString("0.00");
                    
                    dt.Rows.Add(dr);
                }

                rptDocketList.DataSource = dt;
                rptDocketList.DataBind();

                HidDocketNoList.Value = strDocketNoList;
                HidCODDODAmountList.Value = strCODDODAmountList;
                HidDocketDateList.Value = strDocketDateList;
                HidCDelDateList.Value = strCDelDateList;
                HidPendingPackagesForDeliveryList.Value = strPendingPackagesForDeliveryList;
                HidSystemDate.Value = System.DateTime.Today.ToString("dd/MM/yyyy");
                HidSystemTimeInHH.Value = System.DateTime.Now.Hour.ToString("00");
                HidSystemTimeInMM.Value = System.DateTime.Now.Minute.ToString("00");
            }
            else
            {
                trNoRecsForDocketList.Visible = true;
                trUpdateDRS.Visible = false;
                rptDocketList.Visible = false;
            }
        }
        catch (Exception Ex)
        {
            trUpdateDRSErrorMsg.Visible = true;
            lblUpdateDRSErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
        finally
        {
            sqlConn.Close();
            sqlCommand = null;
            sqlConn = null;
        }
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            if (strDateParts.Length > 0)
            {
                return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
            }
            else
            {
                return strDate;
            }
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

    protected void btnUpdateDRS_Click(object sender, EventArgs e)
    {
        updateDRS();
    }

    private void updateDRS()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand;

        int intLoopCounter;

        string[] strArrDRSDetails = HidFinalDRSDetails.Value.Split(',');

        for (intLoopCounter = 0; intLoopCounter < strArrDRSDetails.Length; intLoopCounter++)
        {
            string[] strArrInnerDRSDetails = strArrDRSDetails[intLoopCounter].Split('~');

            try
            {
                sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConn;
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandText = "usp_drs_update";

                sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
                sqlCommand.Parameters.AddWithValue("@pdcno", strDRSNo);
                sqlCommand.Parameters.AddWithValue("@dockno", strArrInnerDRSDetails[0]);
                sqlCommand.Parameters.AddWithValue("@pkgswaspending", strArrInnerDRSDetails[1]);
                sqlCommand.Parameters.AddWithValue("@pkgsdelivered", strArrInnerDRSDetails[2]);
                sqlCommand.Parameters.AddWithValue("@delydt", getDateInddMMMyyyFormat(strArrInnerDRSDetails[3]) + " " + strArrInnerDRSDetails[4]);
                sqlCommand.Parameters.AddWithValue("@reason", strArrInnerDRSDetails[5]);
                sqlCommand.Parameters.AddWithValue("@recd_person", strArrInnerDRSDetails[6]);
                sqlCommand.Parameters.AddWithValue("@MarketVeh", "");
                sqlCommand.Parameters.AddWithValue("@CODAmount", (strArrInnerDRSDetails[7].Trim() == "" ? "0" : strArrInnerDRSDetails[7].Trim()));
                sqlCommand.Parameters.AddWithValue("@CODCollected", (strArrInnerDRSDetails[8].Trim() == "" ? "0" : strArrInnerDRSDetails[8].Trim()));
                sqlCommand.Parameters.AddWithValue("@CODNo", strArrInnerDRSDetails[9].Trim());
                sqlCommand.Parameters.AddWithValue("@closekm", txtCloseKM.Value);
                sqlCommand.Parameters.AddWithValue("@empcd", Session["empcd"].ToString());

                //sqlCommand.ExecuteNonQuery();

                sqlCommand = null;
            }
            catch (Exception Ex)
            {
                trUpdateDRSErrorMsg.Visible = true;
                lblUpdateDRSErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
                break;
            }
            finally
            {
                sqlConn.Close();
                sqlConn = null;
            }
        }

        if (intLoopCounter == strArrDRSDetails.Length)
        {
            Response.Redirect("DisplayUpdatedDRSDetails.aspx");
        }
    }

    //private void populateReasonUFdelivered()
    //{
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    SqlCommand sqlCommand;

    //    try
    //    {
    //        sqlCommand = new SqlCommand("Select UTY_ID,UTY_ID + ' : ' + UTY_Name AS UTYIDName From webx_utymast where catid = '5'", sqlConn);
    //        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //        DataSet dsReason = new DataSet();

    //        sqlDA.Fill(dsReason);

    //        if (dsReason.Tables[0].Rows.Count > 0)
    //        {
    //            ddlReasonU.DataSource = dsReason;
    //            ddlReasonU.DataTextField = "UTYIDName";
    //            ddlReasonU.DataValueField = "UTY_ID";
    //            ddlReasonU.DataBind();
    //        }

    //        ddlReasonU.Items.Insert(0, new ListItem("No Delivery Reason", "-1"));

    //        DataView dvReason;

    //        dvReason = dsReason.Tables[0].DefaultView;

    //        if (dsReason.Tables[0].Rows.Count > 0)
    //        {
    //            ddlReasonF.DataSource = dvReason;
    //            ddlReasonF.DataTextField = "UTYIDName";
    //            ddlReasonF.DataValueField = "UTY_ID";
    //            ddlReasonF.DataBind();
    //        }

    //        ddlReasonF.Items.Insert(0, new ListItem("Late Delivery Reason", "-1"));
    //    }
    //    catch (Exception Ex)
    //    {

    //    }
    //    finally
    //    {
    //        sqlCommand = null;
    //        sqlConn.Close();
    //        sqlConn = null;
    //    }
    //}

    private void populateDeliveryReason(string CodeType, byte bytIndex)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand;

        try
        {
            //sqlCommand = new SqlCommand("Select UTY_ID,UTY_ID + ' : ' + UTY_Name AS UTYIDName From webx_utymast where catid = '6'", sqlConn);
            sqlCommand = new SqlCommand("select CodeId, CodeId + ' : ' + CodeDesc AS Code from webx_master_general where codetype = '" + CodeType + "' and StatusCode = 'Y'", sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsReason = new DataSet();

            sqlDA.Fill(dsReason);

            if (dsReason.Tables[0].Rows.Count > 0)
            {
                if (bytIndex == 1)
                {
                    ddlReasonP.DataSource = dsReason;
                    ddlReasonP.DataTextField = "Code";
                    ddlReasonP.DataValueField = "CodeId";
                    ddlReasonP.DataBind();
                }
                else if (bytIndex == 2)
                {
                    ddlReasonU.DataSource = dsReason;
                    ddlReasonU.DataTextField = "Code";
                    ddlReasonU.DataValueField = "CodeId";
                    ddlReasonU.DataBind();
                }
                else if (bytIndex == 3)
                {
                    ddlReasonF.DataSource = dsReason;
                    ddlReasonF.DataTextField = "Code";
                    ddlReasonF.DataValueField = "CodeId";
                    ddlReasonF.DataBind();
                }
            }

            if (bytIndex == 1)
            {
                ddlReasonP.Items.Insert(0, new ListItem("Part Delivery Reason", "-1"));
            }
            else if (bytIndex == 2)
            {
                ddlReasonU.Items.Insert(0, new ListItem("No Delivery Reason", "-1"));
            }
            else if (bytIndex == 3)
            {
                ddlReasonF.Items.Insert(0, new ListItem("Full Delivery Reason", "-1"));
            }
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

    //private void populateReasonPartlyDelivered()
    //{
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    SqlCommand sqlCommand;

    //    try
    //    {
    //        //sqlCommand = new SqlCommand("Select UTY_ID,UTY_ID + ' : ' + UTY_Name AS UTYIDName From webx_utymast where catid = '6'", sqlConn);
    //        sqlCommand = new SqlCommand("select CodeId, CodeId + ' : ' + CodeDesc AS Code from webx_master_general where codetype = 'UNDELY' and StatusCode = 'Y'", sqlConn);
    //        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //        DataSet dsReason = new DataSet();

    //        sqlDA.Fill(dsReason);

    //        if (dsReason.Tables[0].Rows.Count > 0)
    //        {
    //            ddlReasonP.DataSource = dsReason;
    //            ddlReasonP.DataTextField = "Code";
    //            ddlReasonP.DataValueField = "CodeId";
    //            ddlReasonP.DataBind();
    //        }

    //        ddlReasonP.Items.Insert(0, new ListItem("Part Delivery Reason", "-1"));
    //    }
    //    catch (Exception Ex)
    //    {

    //    }
    //    finally
    //    {
    //        sqlCommand = null;
    //        sqlConn.Close();
    //        sqlConn = null;
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

    //private string GenerateProperCase(string Name)
    //{
    //    string strProperCase = "";

    //    string[] strArrName = Name.Split(' ');

    //    for (int intLoopCounter = 0; intLoopCounter < strArrName.Length; intLoopCounter++)
    //    {
    //        strProperCase = (strProperCase == "" ? strArrName[intLoopCounter].Trim().Substring(0, 1).ToUpper() + strArrName[intLoopCounter].Trim().Substring(1).ToLower() : strProperCase + " " + strArrName[intLoopCounter].Trim().Substring(0, 1).ToUpper() + strArrName[intLoopCounter].Trim().Substring(1).ToLower());
    //    }

    //    return strProperCase;
    //}

    private void getDocumentDetails()
    {
        HidLS.Value = "";
        HidMF.Value = "";
        HidTHC.Value = "";
        HidDRS.Value = "";
        HidDocket.Value = "";

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
                    case "LS":
                        HidLS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "MF":
                        HidMF.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "THC":
                        HidTHC.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "DRS":
                        HidDRS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "DKT":
                        HidDocket.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }
}

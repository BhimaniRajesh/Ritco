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

public partial class GUI_Operations_DRS_DisplayDocketListForDRS : System.Web.UI.Page
{
    static string strDocketNoList;
    static string strDocketPayBaseList;
    static string strDocketList;
    static string strFromDate;
    static string strToDate;
    static string strManualDRSCode;
    static string strDRSDate;
    static string strDelyBy;
    static string strBAVendorCode;
    static string strVendorName;
    static string strStaff;
    static string strStaffCode;
    static string strVehType;
    static string strVehTypeCode;
    static string strVehNo;
    static string strManualVehNo;
    static string strDriver;
    static string strStartKM;
    static string strDelyAt;
    static string strBACode;
    static string strVendorCode;
    static string strNextDRSCode;
    static string strDateType;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strDocketList = HttpUtility.UrlDecode(Request.QueryString["DocketList"].ToString());
            strFromDate = HttpUtility.UrlDecode(Request.QueryString["FromDate"].ToString());
            strToDate = HttpUtility.UrlDecode(Request.QueryString["ToDate"].ToString());
            strManualDRSCode = HttpUtility.UrlDecode(Request.QueryString["ManualDRSCode"].ToString());
            strDRSDate = HttpUtility.UrlDecode(Convert.ToDateTime(Request.QueryString["DRSDate"].ToString()).ToString("dd MMM yy"));
            strDelyBy = HttpUtility.UrlDecode(Request.QueryString["DelyBy"].ToString());
            strBAVendorCode = HttpUtility.UrlDecode(Request.QueryString["BAVendorCode"].ToString());
            strVendorName = HttpUtility.UrlDecode(Request.QueryString["VendorName"].ToString());
            strStaff = HttpUtility.UrlDecode(Request.QueryString["Staff"].ToString());
            strStaffCode = HttpUtility.UrlDecode(Request.QueryString["StaffCode"].ToString());
            strVehType = HttpUtility.UrlDecode(Request.QueryString["VehType"].ToString());
            strVehTypeCode = HttpUtility.UrlDecode(Request.QueryString["VehTypeCode"].ToString());
            strVehNo = HttpUtility.UrlDecode(Request.QueryString["VehNo"].ToString());
            strManualVehNo = HttpUtility.UrlDecode(Request.QueryString["ManualVehNo"].ToString());
            strDriver = HttpUtility.UrlDecode(Request.QueryString["Driver"].ToString());
            strStartKM = HttpUtility.UrlDecode(Request.QueryString["StartKM"].ToString());
            strDelyAt = HttpUtility.UrlDecode(Request.QueryString["DelyAt"].ToString());
            strDateType = HttpUtility.UrlDecode(Request.QueryString["DateType"].ToString());

            getDocumentDetails();

            //Display user selected values
            displayValues();
            //Paint Docket Listing
            paintDocketListing();
        }

        lblHeader.InnerHtml = "<b>Generate " + HidDRS.Value + "</b>";
        lblDocketCriteria.InnerHtml = "<b>" + HidDocket.Value + " Criteria &amp; " + HidDRS.Value + " Header Information</b>";
        lblDocketList.InnerHtml = "<b>" + HidDocket.Value + " List:</b>";
        lblDocketDateRange.InnerHtml = "<b>" + HidDocket.Value + "(s) booked between:</b>";
        lblDelyAt.InnerHtml = "<b>" + HidDocket.Value + " Delivery At:</b>";
        lblDRSCode.InnerHtml = "<b>" + HidDRS.Value + " Code:</b>";
        lblManDRSCode.InnerHtml = "<b>Manual " + HidDRS.Value + " Code:</b>";
        lblDRSLocationCaption.InnerHtml = "<b>" + HidDRS.Value + " Location:</b>";
        lblDRSDateCaption.InnerHtml = "<b>" + HidDRS.Value + " Date:</b>";
        lblInst.InnerHtml = "<b>N.B.:</b>" + HidDocket.Value + "(s) having Booking Date &lt;= " + HidDRS.Value + " Date will be available for generating " + HidDRS.Value + ".";
        lblDocketBkDate.InnerHtml = "<b>" + HidDocket.Value + "<br />Booking Date</b>";
        lblDktTotal.InnerHtml = "<b>" + HidDocket.Value + " Total&nbsp;</b>";
        lblNoRecsForDocket.InnerHtml = "No " + HidDocket.Value + "s found for " + HidDRS.Value + " Generation for the given criteria.";

        btnGenerateDRS.Text = "Generate " + HidDRS.Value;
        btnGenerateDRS.ToolTip = "Click here to Generate " + HidDRS.Value;

        Page.Title = "List of " + HidDocket.Value + " to Generate " + HidDRS.Value;
    }

    private void displayValues()
    {
        if (strFromDate == "")
        {
            trDocketNos.Visible = true;
            lblDocketNos.InnerHtml = strDocketList;
        }
        else
        {
            trDocketDate.Visible = true;
            trDocketDateType.Visible = true;

            lblDocketDateType.InnerHtml = (strDateType == "1" ? HidDocket.Value + " Booking Date" : HidDocket.Value + " Arrival Date");

            string[] strArrFromDateTime = strFromDate.Split(' ');
            string[] strArrFromDate = strArrFromDateTime[0].Split('-');
            string strFromDateForDisplay = strArrFromDate[0] + " " + strArrFromDate[1] + " " + strArrFromDate[2].Substring(2);
            
            string[] strArrToDateTime = strToDate.Split(' ');
            string[] strArrToDate = strArrToDateTime[0].Split('-');
            string strToDateForDisplay = strArrToDate[0] + " " + strArrToDate[1] + " " + strArrToDate[2].Substring(2);

            lblDocketDate.InnerHtml = strFromDateForDisplay + " And " + strToDateForDisplay;
        }

        if(strDelyAt == "-1")
        {
            lblDocketDelyAt.InnerHtml = "Door Or Godown";
        }
        else if(strDelyAt == "2,3")
        {
            lblDocketDelyAt.InnerHtml = "Door";
        }
        else if(strDelyAt == "1,4")
        {
            lblDocketDelyAt.InnerHtml = "Godown";
        }

        lblManualDRSCode.InnerHtml = strManualDRSCode;

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

        lblVehicleType.InnerHtml = strVehType;

        lblVehicleNo.InnerHtml = strVehNo;

        lblDriver.InnerHtml = strDriver;

        lblStartKM.InnerHtml = strStartKM;
    }
    
    protected void btnGenerateDRS_Click(object sender, EventArgs e)
    {
        generateDRS();
    }

    private void paintDocketListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "usp_dockets_for_drs_generation";

        sqlCommand.Parameters.AddWithValue("@dockno", strDocketList);
        sqlCommand.Parameters.AddWithValue("@dockdtfrom", strFromDate);
        sqlCommand.Parameters.AddWithValue("@dockdtto", strToDate);
        sqlCommand.Parameters.AddWithValue("@paybas", "");
        sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
        sqlCommand.Parameters.AddWithValue("@pdcdt", strDRSDate);
        sqlCommand.Parameters.AddWithValue("@DateType", strDateType);
        
        if (strDelyAt != "D,G")
        {
            sqlCommand.Parameters.AddWithValue("@delyat", strDelyAt);
        }

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocketList = new DataSet();

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
        
        DataRow dr;

        sqlDA.Fill(dsDocketList);

        int i = 1;

        HidTotalRecords.Value = dsDocketList.Tables[0].Rows.Count.ToString();

        trDocketList.Visible = true;
        
        strDocketNoList = "";
        strDocketPayBaseList = "";

        if (dsDocketList.Tables[0].Rows.Count > 0)
        {
            trNoRecsForDocketList.Visible = false;
            trPrepareDRS.Visible = true;
            rptDocketList.Visible = true;

            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["SrNo"] = i.ToString();
                i++;
                dr["DocketNo"] = drRows["dockno"].ToString();
                dr["DocketSuffix"] = drRows["docksf"].ToString();
                strDocketNoList = (strDocketNoList == "" ? drRows["dockno"].ToString() + drRows["docksf"].ToString() : strDocketNoList + "," + drRows["dockno"].ToString() + drRows["docksf"].ToString());
                strDocketPayBaseList = (strDocketPayBaseList == "" ? drRows["dockno"].ToString() + drRows["docksf"].ToString() + "~" + drRows["PayBasCode"].ToString() : strDocketPayBaseList + "," + drRows["dockno"].ToString() + drRows["docksf"].ToString() + "~" + drRows["PayBasCode"].ToString());
                dr["DocketDate"] = (drRows["Booking_Date"].ToString().Trim() == "" || drRows["Booking_Date"].ToString().Trim().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["Booking_Date"].ToString()).ToString("dd MMM yy"));
                dr["OrgCode"] = drRows["orgncd"].ToString();
                dr["DestCode"] = drRows["destcd"].ToString();
                dr["PayBasis"] = drRows["PayBasis"].ToString();
                dr["CsgnCode"] = (drRows["csgncd"].ToString().ToUpper() == "NULL" || drRows["csgncd"].ToString().Trim() == "" ? "-" : drRows["csgncd"].ToString());
                dr["CsgnName"] = (drRows["csgnnm"].ToString().ToUpper() == "NULL" || drRows["csgnnm"].ToString().Trim() == "" ? "-" : GenerateProperCase(drRows["csgnnm"].ToString()));
                dr["CsgeCode"] = (drRows["csgecd"].ToString().ToUpper() == "NULL" || drRows["csgecd"].ToString().Trim() == "" ? "-" : drRows["csgecd"].ToString());
                dr["CsgeName"] = (drRows["csgenm"].ToString().ToUpper() == "NULL" || drRows["csgenm"].ToString().Trim() == "" ? "-" : GenerateProperCase(drRows["csgenm"].ToString()));
                dr["PackagesArrived"] = drRows["pkgs_arrived"].ToString();
                dr["PackagesBooked"] = drRows["pkgs_booked"].ToString();
                dr["PackagesPending"] = drRows["pkgs_pending"].ToString();
                dr["CommDelyDate"] = (drRows["comm_dely_dt"].ToString().Trim() == "" || drRows["comm_dely_dt"].ToString().Trim().ToUpper() == "NULL" ?  "-" : Convert.ToDateTime(drRows["comm_dely_dt"].ToString()).ToString("dd MMM yy"));
                dr["Freight"] = (drRows["Freight"].ToString().ToUpper() == "NULL" || drRows["Freight"].ToString().Trim() == "" ? "-" : drRows["Freight"].ToString());
                dr["DocketTotal"] = (drRows["Docket_Total"].ToString().Trim() == "" || drRows["Docket_Total"].ToString().Trim().ToUpper() == "NULL" ? "-" : drRows["Docket_Total"].ToString());
                dr["ServiceTax"] = (drRows["Service_Tax"].ToString().Trim() == "" || drRows["Service_Tax"].ToString().Trim().ToUpper() == "NULL" ? "-" : drRows["Service_Tax"].ToString());
                dr["DelyLoc"] = (drRows["DelyLocation"].ToString().Trim() == "" ? "-" : drRows["DelyLocation"].ToString());
                dr["PayBasCode"] = drRows["PayBasCode"].ToString();
                
                dt.Rows.Add(dr);
            }

            rptDocketList.DataSource = dt;
            rptDocketList.DataBind();
        }
        else
        {
            trNoRecsForDocketList.Visible = true;
            trPrepareDRS.Visible = false;
            rptDocketList.Visible = false;
        }

        HidSelectedDocketNos.Value = strDocketNoList;
        HidDocketPayBaseList.Value = strDocketPayBaseList;

        sqlConn.Close();
    }

    private void generateDRS()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;

        string[] strArrSelectedDockets = HidFinalDocketDetails.Value.Split(',');

        int intTotalDockets = strArrSelectedDockets.Length;

        try
        {
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_drs_generate";

            sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@manpdcno", strManualDRSCode);
            sqlCommand.Parameters.AddWithValue("@pdcdt", strDRSDate);
            sqlCommand.Parameters.AddWithValue("@pdctype", "D");
            sqlCommand.Parameters.AddWithValue("@bacode", strBACode);
            sqlCommand.Parameters.AddWithValue("@vendorcode", strVendorCode);
            sqlCommand.Parameters.AddWithValue("@vendorname", strVendorName);
            sqlCommand.Parameters.AddWithValue("@marketveh", (strBAVendorCode == "8888" ? "Y" : "N"));
            sqlCommand.Parameters.AddWithValue("@vehicleno", strVehNo);
            sqlCommand.Parameters.AddWithValue("@vehicletype", strVehTypeCode);
            sqlCommand.Parameters.AddWithValue("@drivername", strDriver);
            sqlCommand.Parameters.AddWithValue("@startkm", strStartKM);
            sqlCommand.Parameters.AddWithValue("@endkm", "0");
            sqlCommand.Parameters.AddWithValue("@staff", strStaffCode);
            sqlCommand.Parameters.AddWithValue("@empcd", Session["empcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@docketlist", HidFinalDocketDetails.Value);
            sqlCommand.Parameters.AddWithValue("@TotalDockets", intTotalDockets);
            sqlCommand.Parameters.AddWithValue("@FinYear", Session["FinYear"].ToString());
            
            //sqlCommand.ExecuteNonQuery();

            string[] strArrDockets = HidFinalDocketDetails.Value.Split(',');

            for (int intLoopCounter = 0; intLoopCounter < strArrDockets.Length; intLoopCounter++)
            {
                if (IsDocketPayBaseToPay(strArrDockets[intLoopCounter]))
                {
                    //Call finance function
                    //ToPayTransaction(1, Session["brcd"].ToString(), strDRSDate, strArrDockets[intLoopCounter].Replace("'", ""), ".");
                }
            }

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsGenerateDRS = new DataSet();

            sqlDA.Fill(dsGenerateDRS);

            if (dsGenerateDRS.Tables[0].Rows.Count > 0)
            {
                strNextDRSCode = dsGenerateDRS.Tables[0].Rows[0]["PDCNo"].ToString();
            }

            //getDRSCode();

            Response.Redirect("GenerateDRSResult.aspx?DRSCode=" + strNextDRSCode + "&DocketList=" + HidFinalDocketDetails.Value);
        }
        catch (Exception Ex)
        {
            trPrepareDRSErrorMsg.Visible = true;
            lblPrepareDRSErrorMsg.InnerHtml = "An unknown error has ocurred: " + Ex.Message;
        }
        finally
        {
            sqlCommand = null;
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void getDRSCode()
    {
        strNextDRSCode = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        try
        {
            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            //sqlCommand.CommandText = "Select PDCNO,TOT_DKT From webx_pdchdr where PDCBR='" + Session["brcd"].ToString() + "' and CERTIFY_BY='" + Session["empcd"].ToString() + "' order by PDCDT_Sys Desc";

            //sqlCommand.CommandText = "select max(convert(numeric(18, 0) , right(pdcno, 7))) AS PDCNO from webx_pdchdr where pdcbr = '" + Session["brcd"].ToString() + "' and CERTIFY_BY='" + Session["empcd"].ToString() + "'";
            sqlCommand.CommandText = "SELECT Top 1 pdcno FROM webx_pdchdr Where PDCTY='D' and PDCBR='" + Session["brcd"].ToString() + "' Order By  PDCNO Desc, PDCDt_Sys Desc, PDCDT Desc";
            
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
            DataSet dsDRS = new DataSet();

            sqlDA.Fill(dsDRS);

            if (dsDRS.Tables[0].Rows.Count > 0)
            {
                strNextDRSCode = dsDRS.Tables[0].Rows[0]["PDCNO"].ToString();
                //strNextDRSCode = (Session["brcd"].ToString().Length == 3 ? Session["brcd"].ToString() + "_" : Session["brcd"].ToString()) + "/DS/" + strNextDRSCode.PadLeft(7, '0');
            }
            else
            {
                strNextDRSCode = (Session["brcd"].ToString().Length == 3 ? Session["brcd"].ToString() + "_" : Session["brcd"].ToString()) + "/DS/0000001";
            }
        }
        catch (Exception Ex)
        {
            sqlConn.Close();
        }
    }

    private bool IsDocketPayBaseToPay(string DocketNo)
    {
        string[] strArrDocketPayBasis = HidDocketPayBaseList.Value.Split(',');

        for (int intLoopCounter = 0; intLoopCounter < strArrDocketPayBasis.Length; intLoopCounter++)
        {
            string[] strArrInnerDocketPayBases = strArrDocketPayBasis[intLoopCounter].Split('~');
            if (strArrInnerDocketPayBases[0] == DocketNo)
            {
                if (strArrInnerDocketPayBases[1].Trim().ToUpper() == "P03")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        return false;
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

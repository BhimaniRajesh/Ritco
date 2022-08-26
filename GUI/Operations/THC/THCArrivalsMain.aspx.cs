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

public partial class GUI_Operations_THC_THCArrivalsMain : System.Web.UI.Page
{
    public static string strFromDate;
    public static string strToDate;
    string strFromDateOnly;
    string strToDateOnly;
    public static string strTHCs;
    public static string strTHCDepLoc;
    public static string strTHCVehicleNo, strTHCDOCKETNo;
    public static string strcust, dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {dkt_call = Session["DocketCalledAs"].ToString();

            getDocumentDetails();

            lblToday.InnerHtml = "Today's " + HidTHC.Value + "(s): " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
            radLastWeek.Checked = true;
        }

        lblHeader.InnerHtml = "<b>Update Incoming " + HidTHC.Value + "</b>";
        lblSelCriteria.InnerHtml = "<b>Select Criteria To Update Incoming " + HidTHC.Value + "</b>";
        lblDateFrom.InnerHtml = HidTHC.Value + " Date From:";
        lblDateTo.InnerHtml = HidTHC.Value + " Date To:";
        lblLWTHCs.InnerHtml = "Last Week " + HidTHC.Value + "s (Including Today)";
        lblTHCDate.InnerHtml = HidTHC.Value + "(s) Till Date";
        lblTHCNo.InnerHtml = HidTHC.Value + " No.";
        lblTHCDepFromLocs.InnerHtml = HidTHC.Value + "(s) Departed From Locations(s):";
        lblTHCVehNo.InnerHtml = HidTHC.Value + "(s) having Vehicle No(s).:";
        lblTHCDOCkNO.InnerHtml = HidTHC.Value + "(s) having " + dkt_call.ToString() + " No(s).:";
        lblNote.InnerHtml = "<b>N.B.:</b>&nbsp;Click on the " + HidTHC.Value + " No. to update it for Incoming/Arrival";
        lblTHCNoCaption.InnerHtml = "<b>" + HidTHC.Value + " No.</b>";
        lblTHCDateCaption.InnerHtml = "<b>" + HidTHC.Value + " Date</b>";
        lblNoRecsForTHC.InnerHtml = "No " + HidTHC.Value + "(s) found for Incoming/Arrival for the given criteria";

        btnShowList.ToolTip = "Click here to Show List of " + HidTHC.Value + "(s)";

        Page.Title = "Update Incoming " + HidTHC.Value;
    }
    
    protected void radTHCs_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCs.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCDepLoc.Checked = false;
            radTHCVehicle.Checked = false;

            txtTHCs.Value = txtTHCs.Value.Trim();

            if (txtTHCs.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCs = txtTHCs.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }
        }
    }

    protected void radTHCDepLoc_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCDepLoc.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCs.Checked = false;
            radTHCVehicle.Checked = false;

            txtTHCDepLoc.Value = txtTHCDepLoc.Value.Trim();

            if (txtTHCDepLoc.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCDepLoc = txtTHCDepLoc.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }
        }
    }
    
    protected void radTHCVehicle_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCVehicle.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCs.Checked = false;
            radTHCDepLoc.Checked = false;

            txtTHCVehicle.Value = txtTHCVehicle.Value.Trim();

            if (txtTHCVehicle.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCVehicleNo = txtTHCVehicle.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }
        }
    }

    protected void radTHCDKT_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCDockets.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCs.Checked = false;
            radTHCDepLoc.Checked = false;
            radTHCVehicle.Checked = false;
            txtTHCDockets.Value = txtTHCDockets.Value.Trim();

            if (txtTHCDockets.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCDOCKETNo = txtTHCDockets.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }
        }
    }
    
    protected void btnShowList_Click(object sender, EventArgs e)
    {

        //Prepare Query String variable values
        strFromDate = "";
        strToDate = "";

        if (radRange.Checked == true)
        {
            strFromDate = getDateInddMMMyyyFormat(txtFromDate.Value);
            strToDate = getDateInddMMMyyyFormat(txtToDate.Value);
        }
        else if (radToday.Checked == true)
        {
            strFromDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
            strToDate = strFromDate;
        }
        else if (radLastWeek.Checked == true)
        {
            DateTime dtLastWeek = System.DateTime.Today.AddDays(-6);

            strFromDate = dtLastWeek.ToString("dd-MMM-yyyy");
            strToDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
        }
        else if (radTillDate.Checked == true)
        {
            strFromDate = "01-Jan-1990";
            strToDate = System.DateTime.Today.ToString("dd-MMM-yyyy");
        }

        strFromDateOnly = strFromDate;
        strToDateOnly = strToDate;

        strFromDate += " 00:00:00";
        strToDate += " 23:59:59";

        //Display List of THC(s)
        DisplayTHCListing();
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

    private void DisplayTHCListing()
    {
        //string strSQL = "select distinct a.thcno as THC_Number, convert(char(10),a.thcdt,103) as THC_Date, " +
        //                "a.sourcehb as Previous_Location, " +
        //                " (case when a.routecd is null then 'Non-Standard' else a.routecd+' : '+a.routename End) as route, " +
        //                " a.vehno as VehicleNo, convert(char(10),b.actdept_dt,103)+' '+b.actdept_tm as ATD, " +
        //                " '00:00' as ETA, ISNULL(a.OPENKM , 0) as OPENKM, " +
        //                " (case when b.actdept_dt is null then 'Not Departed' else 'Departed' End) as Status, " +
        //                " convert(char(10),b.thcdt,103) as thcdt,b.tobh_code,a.manualthcno as manualthcno " +
        //                " from webx_thc_summary as a,webx_thchdr as b " +
        //                " where a.thcno = b.thcno and a.thcsf=b.thcsf " +
        //                " and a.thcdt >= '20070401 00:00:00' " +
        //                " and a.thcno not in (Select THCNO From webx_thchdr where sourcehb=b.tobh_code " +
        //                " and UPPER(IsNull(a.tobh_code,'NULL')) <> 'NULL' AND a.sourcehb='" + Session["brcd"].ToString() + "') ";

        ////" and a.thcno not in (select thcno from webx_thchdr where sourcehb = '" + Session["brcd"].ToString() + "') " +
        
        //if (radRange.Checked == true || radLastWeek.Checked == true || radToday.Checked == true || radTillDate.Checked == true)
        //{
        //    strSQL += " and b.thcdt between '" + strFromDate + "' and '" + strToDate + "' order by thcdt Desc";
        //}
        //else if (radTHCs.Checked == true)
        //{
        //    strSQL += " and a.thcno in ('" + txtTHCs.Value.Replace("'", "").Replace(" ", "").Replace(",", "','") + "') order by THC_Number";
        //}
        //else if (radTHCDepLoc.Checked == true)
        //{
        //    strSQL += " and a.sourcehb in ('" + txtTHCDepLoc.Value.Replace("'", "").Replace(" ", "").Replace(",", "','") + "') order by Previous_Location";
        //}
        //else if (radTHCVehicle.Checked == true)
        //{
        //    strSQL += " and a.vehno in ('" + txtTHCVehicle.Value.Replace("'", "").Replace(" ", "").Replace(",", "','") + "') order by VehicleNo";
        //}

        //ListTHCs(strSQL);
        ListTHCs();
    }

    private void HideResultTable()
    {
        trNote.Visible = false;
        trTHCList.Visible = false;
        trNoRecsForTHCList.Visible = false;
        rptTHCList.Visible = false;
        trUpdateIncomingTHCErrorMsg.Visible = false;
    }

    private void ListTHCs()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand();

            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_Incoming_THC_Ver1";

            if (radRange.Checked == true || radLastWeek.Checked == true || radToday.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@incomingat", Session["brcd"].ToString());
                sqlCommand.Parameters.AddWithValue("@fromdt", strFromDateOnly);
                sqlCommand.Parameters.AddWithValue("@todt", strToDateOnly);
            }
            else if (radTHCs.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@incomingat", Session["brcd"].ToString());
                sqlCommand.Parameters.AddWithValue("@thcno", txtTHCs.Value.Replace("'", "").Replace(" ", "").Replace(",", "','"));
            }
            else if (radTHCDepLoc.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@incomingat", Session["brcd"].ToString());
                sqlCommand.Parameters.AddWithValue("@departedfrom", txtTHCDepLoc.Value.Replace("'", "").Replace(" ", "").Replace(",", "','"));
            }
            else if (radTHCVehicle.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@incomingat", Session["brcd"].ToString());
                sqlCommand.Parameters.AddWithValue("@vehno", txtTHCVehicle.Value.Replace("'", "").Replace(" ", "").Replace(",", "','"));
            }
            else if (radTHCDockets.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@incomingat", Session["brcd"].ToString());
                sqlCommand.Parameters.AddWithValue("@Dockno", txtTHCDockets.Value.ToString());
            }
            
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsTHCList = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("THCNo", typeof(string));
            dt.Columns.Add("THCDate", typeof(string));
            dt.Columns.Add("PreviousLocation", typeof(string));
            dt.Columns.Add("Route", typeof(string));
            dt.Columns.Add("Vehicle", typeof(string));
            dt.Columns.Add("ATD", typeof(string));
            dt.Columns.Add("ETA", typeof(string));
            dt.Columns.Add("UnloadingSheet", typeof(string));

            DataRow dr;

            sqlDA.Fill(dsTHCList);

            HideResultTable();

            int i = 1;
            string strUpdateTHC;

            if (dsTHCList.Tables[0].Rows.Count > 0)
            {
                trTHCList.Visible = true;
                trNote.Visible = true;
                rptTHCList.Visible = true;

                foreach (DataRow drRows in dsTHCList.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["SrNo"] = i.ToString();
                    i++;
                    strUpdateTHC = "<a href=\"JavaScript:UpdateTHC('" + drRows["Vehicle"].ToString() + "', '" + drRows["THCNO"].ToString() + "', '.', '" + (drRows["ATD"].ToString().ToUpper() == "NULL" || drRows["ATD"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["ATD"]).ToString("dd/MM/yyyy HH:mm")) + "', '" + drRows["PreviousBranch"].ToString().Trim() + "', '" + drRows["OPENKM"].ToString().Trim() + "', 'T', '" + (drRows["ETA"].ToString().ToUpper() == "NULL" || drRows["ETA"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["ETA"]).ToString("dd/MM/yyyy HH:mm")) + "')\"><u>" + drRows["THCNO"].ToString() + "</u></a>";
                    dr["THCNo"] = (drRows["Status"].ToString().ToLower() == "not departed" ? drRows["THCNO"].ToString() : strUpdateTHC);
                    dr["THCDate"] = (drRows["THCDate"].ToString().ToUpper() == "NULL" || drRows["THCDate"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["THCDate"]).ToString("dd MMM yy"));
                    dr["PreviousLocation"] = drRows["PreviousBranch"].ToString();
                    dr["Route"] = (drRows["Route"].ToString().Trim() == "" || drRows["Route"].ToString().ToUpper() == "NULL" ? "-" : drRows["Route"].ToString());
                    dr["Vehicle"] = drRows["Vehicle"].ToString();
                    dr["ATD"] = (drRows["ATD"].ToString().ToUpper() == "NULL" || drRows["ATD"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["ATD"]).ToString("dd MMM yy HH:mm"));
                    dr["ETA"] = (drRows["ETA_"].ToString().Trim() == "" || drRows["ETA_"].ToString().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["ETA_"]).ToString("dd MMM yy HH:mm"));
                    dr["UnloadingSheet"] = (drRows["Status"].ToString().ToLower() == "not departed" ? "<label class='blackfnt' style='color: red;'>Not Departed<br />From Previous<br />Location</label>" : "<a href=\"Javascript:OpenInWindow('../TCS/PrintTCS/View_Print_UnloadingSheet.aspx?THC_No=" + drRows["THCNO"].ToString() + "', 400,600,10,10)\"><u>Unloading Sheet</u></a>");
                    
                    dt.Rows.Add(dr);
                }

                rptTHCList.DataSource = dt;
                rptTHCList.DataBind();
            }
            else
            {
                trTHCList.Visible = true;
                trNoRecsForTHCList.Visible = true;
            }

            sqlConn.Close();
        }
        catch (Exception Ex)
        {
            trUpdateIncomingTHCErrorMsg.Visible = true;
            lblPrepareDRSErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
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
}

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

public partial class GUI_Operations_UpdateDocketArrivalStatus_UpdateDocketArrivalStatusMain : System.Web.UI.Page
{
    public static string strFromDate;
    public static string strToDate;
    public static string strTHCs;
    public static string strTHCMFNo;
    public static string strTHCDestination;
    public static string strDocket;

    protected void Page_Load(object sender, EventArgs e)
    {
        HidTHC.Value = Session["THCCalledAs"].ToString();
        if (!IsPostBack)
        {
            getDocumentDetails();

            lblToday.InnerHtml = "Today's " + HidTHC.Value + " Arrival: " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
            radLastWeek.Checked = true;
        }

        lblHeader.InnerHtml = "<b>Update " + HidDocket.Value + " Arrival Status</b>";
        lblSelCriteria.InnerHtml = "<b>Select Criteria To Update " + HidDocket.Value + " Arrival Status</b>";
        lblTHCForDestinations.InnerHtml = HidTHC.Value + "(s) Containing " + HidDocket.Value + "(s) for Destination(s):";
        lblDocketNos.InnerHtml = HidTHC.Value + "(s) Containing " + HidDocket.Value + " No.(s):";
        lblListDocketsForArrivalStatusUpdate.InnerHtml = "<b>" + HidTHC.Value + " List for " + HidDocket.Value + " Arrival Status Update</b>";
        lblTotMFs.InnerHtml = "<b>Total " + HidMF.Value + "(s)</b>";
        lblTotDockets.InnerHtml = "<b>Total " + HidDocket.Value + "(s)&nbsp;</b>";
        lblNoRecsForTHC.InnerHtml = "No " + HidTHC.Value + " found for the given criteria";
        lblMFInTHC.InnerHtml = HidTHC.Value + "(s) Containing " + HidMF.Value + " No(s):";
        lblTHCArrivalDateFrom.InnerHtml = HidTHC.Value + " Arrival Date From:";
        lblTHCArrivalDateTo.InnerHtml = HidTHC.Value + " Arrival Date To:";
        lblLWTHC.InnerHtml = "Last Week " + HidTHC.Value + " Arrivals (Including Today)";
        lblTHCTillDate.InnerHtml = HidTHC.Value + " Arrivals Till Date";
        lblTHCNo.InnerHtml = HidTHC.Value + " No(s).:";
        lblTHCNoCaption.InnerHtml = "<b>" + HidTHC.Value + " No.</b>";
        lblTHCBranch.InnerHtml = "<b>" + HidTHC.Value + " Branch</b>";


        btnShowList.ToolTip = "Click here to Show List of " + HidTHC.Value + "(s)";

        Page.Title = "Update " + HidDocket.Value + " Arrival Status";
    }

    protected void radTHCs_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCs.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCMFNo.Checked = false;
            radTHCDestination.Checked = false;
            radDockets.Checked = false;

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

            txtTHCs.Focus();
        }
    }

    protected void radTHCMFNo_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCMFNo.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCs.Checked = false;
            radTHCDestination.Checked = false;
            radDockets.Checked = false;

            txtTHCMFNo.Value = txtTHCMFNo.Value.Trim();

            if (txtTHCMFNo.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCMFNo = txtTHCMFNo.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }

            txtTHCMFNo.Focus();
        }
    }

    protected void radTHCDestination_CheckedChanged(object sender, EventArgs e)
    {
        if (radTHCDestination.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCs.Checked = false;
            radTHCMFNo.Checked = false;
            radDockets.Checked = false;

            txtTHCDestination.Value = txtTHCDestination.Value.Trim();

            if (txtTHCDestination.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCDestination = txtTHCDestination.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }

            txtTHCDestination.Focus();
        }
    }

    protected void radDockets_CheckedChanged(object sender, EventArgs e)
    {
        if (radDockets.Checked == true)
        {
            radRange.Checked = false;
            radToday.Checked = false;
            radLastWeek.Checked = false;
            radTillDate.Checked = false;
            radTHCs.Checked = false;
            radTHCMFNo.Checked = false;
            radTHCDestination.Checked = false;

            txtDocketNo.Value = txtDocketNo.Value.Trim();

            if (txtTHCDestination.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strDocket = txtDocketNo.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }

            txtDocketNo.Focus();
        }
    }

    private void HideResultTable()
    {
        trTHCList.Visible = false;
        trNoRecsForTHCList.Visible = false;
        rptTHCList.Visible = false;
        trTHCErrorMsg.Visible = false;
    }

    private void DisplayTHCListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_THCs_Arrived_For_Docket_Arrival_Update";

            sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());

            if (radTHCs.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@thcnoCSV", txtTHCs.Value.Replace(" ", "").Replace("'", ""));
            }
            else if (radTHCMFNo.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@mfnoCSV", txtTHCMFNo.Value.Replace(" ", "").Replace("'", ""));
            }
            else if (radDockets.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@docknoCSV", txtDocketNo.Value.Replace(" ", "").Replace("'", ""));
            }
            else if (radTHCDestination.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@dockDestCSV", txtTHCDestination.Value.Replace(" ", "").Replace("'", ""));
            }
            else if (radRange.Checked == true || radToday.Checked == true || radLastWeek.Checked == true || radTillDate.Checked == true)
            {
                sqlCommand.Parameters.AddWithValue("@fromDate", strFromDate);
                sqlCommand.Parameters.AddWithValue("@toDate", strToDate);
            }

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsTHCList = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("THCNo", typeof(string));
            dt.Columns.Add("NavURL", typeof(string));
            dt.Columns.Add("VehicleNo", typeof(string));
            dt.Columns.Add("THCBranch", typeof(string));
            dt.Columns.Add("ArrivalDate", typeof(string));
            dt.Columns.Add("TotalMF", typeof(string));
            dt.Columns.Add("TotalDockets", typeof(string));
            
            DataRow dr;

            sqlDA.Fill(dsTHCList);

            HideResultTable();

            int i = 1;

            if (dsTHCList.Tables[0].Rows.Count > 0)
            {
                trTHCList.Visible = true;
                rptTHCList.Visible = true;

                foreach (DataRow drRows in dsTHCList.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["THCNo"] = drRows["THC_No"].ToString();
                    dr["VehicleNo"] = (drRows["Vehicle_No"].ToString().ToUpper() == "NULL" || drRows["Vehicle_No"].ToString().Trim() == "" ? "-" : drRows["Vehicle_No"].ToString());
                    dr["NavURL"] = "DisplayDocketsInTHC.aspx?THCNo=" + drRows["THC_No"].ToString() + "&VehicleNo=" + dr["VehicleNo"].ToString();
                    dr["THCBranch"] = (drRows["THC_Location"].ToString().ToUpper() == "NULL" || drRows["THC_Location"].ToString().Trim() == "" ? "-" : drRows["THC_Location"].ToString());
                    dr["ArrivalDate"] = (drRows["Arrival_Date"].ToString().ToUpper() == "NULL" || drRows["Arrival_Date"].ToString().Trim() == "" ? "-" : getDateInddMMMyyFormat(Convert.ToDateTime(drRows["Arrival_Date"].ToString()).ToString("dd/MM/yyyy")));
                    dr["TotalMF"] = (drRows["Total_MFs"].ToString().ToUpper() == "NULL" || drRows["Total_MFs"].ToString().Trim() == "" ? "-" : drRows["Total_MFs"].ToString());
                    dr["TotalDockets"] = (drRows["Total_Dockets"].ToString().ToUpper() == "NULL" || drRows["Total_Dockets"].ToString().Trim() == "" ? "-" : drRows["Total_Dockets"].ToString());

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
            trTHCErrorMsg.Visible = true;
            lblPrepareDRSErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
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

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
    public static string strTHCs;
    public static string strTHCDepLoc;
    public static string strTHCVehicleNo;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDocumentDetails();

            lblToday.InnerHtml = "Today's " + HidTHC.Value + "(s): " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
            radLastWeek.Checked = true;
        }

        lblHeader.InnerHtml = "<b>Update Outgoing " + HidTHC.Value + "</b>";
        lblHeader.InnerHtml = "<b>Update Outgoing " + HidTHC.Value + "</b>";
        lblSelCriteria.InnerHtml = "<b>Select Criteria To Update Outgoing " + HidTHC.Value + "</b>";
        lblDateFrom.InnerHtml = HidTHC.Value + " Date From:";
        lblDateTo.InnerHtml = HidTHC.Value + " Date To:";
        lblLWTHC.InnerHtml = "Last Week " + HidTHC.Value + "(s) (Including Today)";
        lblTillDate.InnerHtml = HidTHC.Value + "(s) Till Date";
        lblTHCNoCaption.InnerHtml = HidTHC.Value + " No(s).:";
        lblTHCForLocs.InnerHtml = HidTHC.Value + "(s) Going for Locations(s):";
        lblTHCVehicle.InnerHtml = HidTHC.Value + "(s) Having Vehicle No(s).:";
        lblNote.InnerHtml = "<b>N.B.:</b>&nbsp;Click on the " + HidTHC.Value + " No. to update it for Outgoing/Departure";
        lblTHCNoCaption1.InnerHtml = "<b>" + HidTHC.Value + " No.</b>";
        lblTHCDateCaption1.InnerHtml = "<b>" + HidTHC.Value + " Date</b>";
        lblNoRecsForTHC.InnerHtml = "No " + HidTHC.Value + "(s) found for Outgoing/Departure for the given criteria";

        btnShowList.ToolTip = "Click here to Show List of " + HidTHC.Value + "(s)";
        btnShowList.Text = "Show " + HidTHC.Value + "(s)";

        Page.Title = "Update Outgoing " + HidTHC.Value;
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

            txtTHCGoingForLoc.Value = txtTHCGoingForLoc.Value.Trim();

            if (txtTHCGoingForLoc.Value == "")
            {
                //Code for Hiding Result Table
                HideResultTable();
                return;
            }
            else
            {
                strTHCDepLoc = txtTHCGoingForLoc.Value;
                //Display List of THC(s)
                DisplayTHCListing();
            }

            txtTHCGoingForLoc.Focus();
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

            txtTHCVehicle.Focus();
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

    private void DisplayTHCListing()
    {
        string strSQL = "Select Distinct THC_Number, THC_Date, THC_For As Next_Location, (Case When RouteName is NULL Then 'Non-Standard' Else RouteCode + ' : '+ RouteName End) As Route, VehicleNo, ATA, ETD, thcdt, (Select sourcehb From webx_thchdr where thcno=V.THC_Number and tobh_code='" + Session["brcd"].ToString() + "') As ArrivedFrom " +
                        " From vw_THC_Arrivals V WHERE ATD is NULL and THC_SourceHub = '" + Session["brcd"].ToString() + "' ";
                        
        if (radRange.Checked == true || radLastWeek.Checked == true || radToday.Checked == true || radTillDate.Checked == true)
        {
            strSQL += " and thcdt between '" + strFromDate + "' and '" + strToDate + "' order by thcdt Desc";
        }
        else if (radTHCs.Checked == true)
        {
            strSQL += " and THC_Number in ('" + strTHCs.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim() + "') order by THC_Number";
        }
        else if (radTHCDepLoc.Checked == true)
        {
            strSQL += "  and THC_For in ('" + strTHCDepLoc.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim() + "') order by THC_SourceHub";
        }
        else if (radTHCVehicle.Checked == true)
        {
            strSQL += " and VehicleNo in ('" + strTHCVehicleNo.Replace("'", "").Replace(" ", "").Replace(",", "','").Trim() + "') order by VehicleNo";
        }

        ListTHCs(strSQL);
    }

    private void HideResultTable()
    {
        trNote.Visible = false;
        trTHCList.Visible = false;
        trNoRecsForTHCList.Visible = false;
        rptTHCList.Visible = false;
        trUpdateIncomingTHCErrorMsg.Visible = false;
    }

    private void ListTHCs(string strSQLToListTHC)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand(strSQLToListTHC, sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsTHCList = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("THCNo", typeof(string));
            dt.Columns.Add("NextLocation", typeof(string));
            dt.Columns.Add("THCDate", typeof(string));
            dt.Columns.Add("ArrivedFromLocation", typeof(string));
            dt.Columns.Add("Route", typeof(string));
            dt.Columns.Add("Vehicle", typeof(string));
            dt.Columns.Add("ATA", typeof(string));
            dt.Columns.Add("ETD", typeof(string));

            DataRow dr;

            sqlDA.Fill(dsTHCList);

            HideResultTable();

            int i = 1;
            
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
                    dr["THCNo"] = "<a href=\"JavaScript:UpdateOutgoingTHC('" + drRows["THC_Number"].ToString() + "')\"><u>" + drRows["THC_Number"].ToString() + "</u></a>";
                    dr["THCDate"] = (drRows["THC_Date"].ToString().ToUpper() == "NULL" || drRows["THC_Date"].ToString().Trim() == "" ? "-" : getDateInddMMMyyFormat(Convert.ToDateTime(drRows["THC_Date"]).ToString("dd/MM/yyyy")));
                    dr["NextLocation"] = (drRows["Next_Location"].ToString().ToUpper() == "NULL" || drRows["Next_Location"].ToString().Trim() == "" ? "-" : drRows["Next_Location"].ToString());
                    dr["ArrivedFromLocation"] = (drRows["ArrivedFrom"].ToString().ToUpper() == "NULL" || drRows["ArrivedFrom"].ToString().Trim() == "" ? "-" : drRows["ArrivedFrom"].ToString());
                    dr["Route"] = (drRows["Route"].ToString().ToUpper() == "NULL" || drRows["Route"].ToString().Trim() == "" ? "-" : drRows["Route"].ToString());
                    dr["Vehicle"] = (drRows["VehicleNo"].ToString().ToUpper() == "NULL" || drRows["VehicleNo"].ToString().Trim() == "" ? "-" : drRows["VehicleNo"].ToString());
                    dr["ATA"] = (drRows["ATA"].ToString().ToUpper() == "NULL" || drRows["ATA"].ToString().Trim() == "" ? "-" : getDateInddMMMyyFormat(Convert.ToDateTime(drRows["ATA"]).ToString("dd/MM/yyyy")) + " " + Convert.ToDateTime(drRows["ATA"]).ToString("HH:mm"));
                    dr["ETD"] = (drRows["ETD"].ToString().ToUpper() == "NULL" || drRows["ETD"].ToString().Trim() == "" ? "-" : drRows["ETD"].ToString());
                    
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

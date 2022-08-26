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

public partial class GUI_Operations_PRS_PRSMain : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/GUI/Operations/PRS/PRSCreateMain.aspx");

        if (!IsPostBack)
        {
            getDocumentDetails();

            lblToday.InnerHtml = "Today's " + HidDocket.Value + "(s): " + System.DateTime.Today.ToString("dddd, MMMM dd, yyyy");
            radLastWeek.Checked = true;
        }

        lblHeader.InnerHtml = "<b>Booking " + HidPRS.Value + " Generation</b>";
        lblSelCriteria.InnerHtml = "<b>Select " + HidDocket.Value + " Criteria By Arrival Date</b>";
        lblLWDockets.InnerHtml = "Last Week " + HidDocket.Value + "s (Including Today)";
        lblDockets.InnerHtml = HidDocket.Value + " No.(s):";

        Page.Title = HidPRS.Value + " Generation Module";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strFromDate = "";
        string strToDate = "";
        string strDocketList = "";

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
        else if (radDocket.Checked == true)
        {
            strDocketList = txtDocket.Value.Trim();
        }

        Response.Redirect("PRSGenerateStep1.aspx?FromDate=" + strFromDate + "&ToDate=" + strToDate + "&DocketList=" + strDocketList);
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
        HidPRS.Value = "";

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
                    case "PRS":
                        HidPRS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }
}

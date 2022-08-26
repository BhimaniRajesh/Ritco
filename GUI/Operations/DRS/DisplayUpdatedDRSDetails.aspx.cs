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

public partial class GUI_Operations_DRS_DisplayUpdatedDRSDetails : System.Web.UI.Page
{
    public static string strDRSCode;
    static string strUpdatedDRSDetails;
    static string strCloseKM;
    static string strDRSDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strDRSCode = HttpUtility.UrlDecode(Request.QueryString["DRSCode"].ToString());
            strUpdatedDRSDetails = HttpUtility.UrlDecode(Request.QueryString["DRSDetails"].ToString());
            strCloseKM = HttpUtility.UrlDecode(Request.QueryString["CloseKM"].ToString());
            strDRSDate = HttpUtility.UrlDecode(Request.QueryString["DRSDate"].ToString());

            updateDRS();

            getDocumentDetails();
        }

        //lblHeader.InnerHtml = "<b>" + HidDRS.Value + "  Updation Result</b>";
        lblHeader.InnerHtml = "<b>Transaction Completed</b>";
        lblMoreDRS.InnerHtml = "<a href=\"../../../GUI/Operations/DRS/DRSMain.aspx\"><u>Click here to Generate More " + HidDRS.Value + "</u></a>";
        lblUpdateDRS.InnerHtml = "<a href=\"../../../GUI/Operations/DRS/UpdateDRSMain.aspx\"><u>Update " + HidDRS.Value + "</u></a>";
        //lblVP.InnerHtml = "<a href=\"Javascript:OpenInWindow('DRS_View_Print.aspx?DRSNo=" + strDRSCode + "',400,600,10,10)\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('DRS_View_Print.aspx?DRSNo=" + strDRSCode + "',400,600,10,10)\"><u>Print</u></a>";
        //Update on 08 Jan 07
        lblVP.InnerHtml = "<a href=\"Javascript:OpenInWindow('DRS_View_Print.aspx?DRSNo=" + strDRSCode + ",0',400,600,10,10)\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('DRS_View_Print.aspx?DRSNo=" + strDRSCode + ",1',400,600,10,10)\"><u>Print</u></a>|&nbsp;<a href=\"Javascript:OpenInWindow('../../Print/PDCPrint.aspx?DRSNo=" + strDRSCode + "',400,600,10,10)\"><u>Dos Print</u></a>";
        lblDRSCaption.InnerHtml = HidDRS.Value;

        Page.Title = "Display Updated " + HidDRS.Value + " Details";
    }

    private void updateDRS()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand;

        int intLoopCounter;

        string[] strArrDRSDetails = strUpdatedDRSDetails.Split(',');

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
                sqlCommand.Parameters.AddWithValue("@pdcno", strDRSCode);
                sqlCommand.Parameters.AddWithValue("@pdcdt", strDRSDate);
                sqlCommand.Parameters.AddWithValue("@dockno", strArrInnerDRSDetails[0]);
                sqlCommand.Parameters.AddWithValue("@pkgswaspending", strArrInnerDRSDetails[1]);
                sqlCommand.Parameters.AddWithValue("@pkgsdelivered", strArrInnerDRSDetails[2]);
                sqlCommand.Parameters.AddWithValue("@delydt", getDateInddMMMyyyFormat(strArrInnerDRSDetails[3]) + " " + strArrInnerDRSDetails[4]);
                sqlCommand.Parameters.AddWithValue("@reason", strArrInnerDRSDetails[5]);
                sqlCommand.Parameters.AddWithValue("@recd_person", strArrInnerDRSDetails[6]);
                sqlCommand.Parameters.AddWithValue("@MarketVeh", "");
                sqlCommand.Parameters.AddWithValue("@CODAmount", 0);
                sqlCommand.Parameters.AddWithValue("@CODCollected", (strArrInnerDRSDetails[7].Trim() == "" ? "0" : strArrInnerDRSDetails[7].Trim()));
                sqlCommand.Parameters.AddWithValue("@CODNo", strArrInnerDRSDetails[8].Trim());
                sqlCommand.Parameters.AddWithValue("@closekm", strCloseKM);
                sqlCommand.Parameters.AddWithValue("@empcd", Session["empcd"].ToString());

                sqlCommand.ExecuteNonQuery();

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
                
            }
        }

        sqlConn.Close();
        sqlConn = null;
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

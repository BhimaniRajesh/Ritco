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

public partial class GUI_Operations_THC_UpdateIncomingTHC : System.Web.UI.Page
{
    static string strVehicleNo;
    static string strTHCNo;
    static string strTHCSF;
    static string strPrevLoc;
    static string strOpenKM;
    static string strOperation;
    static string strDepDate;
    static string strDepDateTime;
    public static string strActualDeptDate;
    public static string strActualDeptTime;
    public static string strDepTimeHH;
    public static string strDepTimeMM;
    public static string strSystemTimeHH;
    public static string strSystemTimeMM;
    public static string strSystemDate;

    static string strETADate;
    static string strETADateTime;
    public static string strETAActualDate;
    public static string strETAActualTime;
    public static string strETATimeHH;
    public static string strETATimeMM;
    
    bool blnTHCUpdated = false;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strSystemDate = System.DateTime.Today.ToString("dd/MM/yyyy");
            strSystemTimeHH = System.DateTime.Now.ToString("HH");
            strSystemTimeMM = System.DateTime.Now.ToString("mm");
            strVehicleNo = HttpUtility.UrlDecode(Request.QueryString["VehicleNo"].ToString());
            strTHCNo = HttpUtility.UrlDecode(Request.QueryString["THCNo"].ToString());
            HIDTHCNo.Value = strTHCNo;
            strTHCSF = HttpUtility.UrlDecode(Request.QueryString["DocketSF"].ToString());
            strPrevLoc = HttpUtility.UrlDecode(Request.QueryString["PrevLoc"].ToString());
            strOpenKM = HttpUtility.UrlDecode(Request.QueryString["OpenKM"].ToString());
            strDepDateTime = HttpUtility.UrlDecode(Request.QueryString["ATD"].ToString());
            strDepDate = strDepDateTime;
            strActualDeptDate = "";
            strActualDeptTime = "";
            strDepTimeHH = "";
            strDepTimeMM = "";

            strETADateTime = HttpUtility.UrlDecode(Request.QueryString["ETA"].ToString());
            strETADate = strETADateTime;
            strETAActualDate = "";
            strETAActualTime = "";
            strETATimeHH = "";
            strETATimeMM = "";

            getDocumentDetails();

            if (strDepDate != "-")
            {
                string[] strArrArrivalDateTime = strDepDate.Split(' ');
                strActualDeptDate = strArrArrivalDateTime[0];
                strActualDeptTime = strArrArrivalDateTime[1];
                string[] strArrArrivalTime = strArrArrivalDateTime[1].Split(':');
                strDepTimeHH = strArrArrivalTime[0].Trim();
                strDepTimeMM = strArrArrivalTime[1].Trim();
            }

            if (strETADate != "-")
            {
                string[] strArrETADateTime = strETADate.Split(' ');
                strETAActualDate = strArrETADateTime[0];
                strETAActualTime = strArrETADateTime[1];
                string[] strArrArrivalTime = strArrETADateTime[1].Split(':');
                strETATimeHH = strArrArrivalTime[0].Trim();
                strETATimeMM = strArrArrivalTime[1].Trim();
            }
            strOperation = HttpUtility.UrlDecode(Request.QueryString["Operation"].ToString());

            populateLateArrivalReason();

            DisplayData();
        }

        lblHeader.InnerHtml = "<b>Update Incoming " + HidTHC.Value + "</b>";
        lblTHCData.InnerHtml = "<b>Incoming " + HidTHC.Value + " Data</b>";
        lblTHCNoCaption.InnerHtml = "<b>" + HidTHC.Value + "#:</b>";

        btnSubmit.Text = "Update Incoming " + HidTHC.Value + " Data";
        btnSubmit.ToolTip = "Click here to update incoming " + HidTHC.Value + " data";

        Page.Title = "Update Incoming " + HidTHC.Value;

        if (!IsPostBack)
        {
            txtIncomingSealNo.Focus();
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        UpdateIncomingTHC();

        if (blnTHCUpdated == true)
        {
            //Response.Redirect("THCArrivalsMain.aspx");
            Response.Redirect("DisplayIncomingTHCResult.aspx");
        }
    }

    private void UpdateIncomingTHC()
    {
        blnTHCUpdated = false;

        lblErrorMessage.Visible = false;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_Update_Incoming_THC";

            sqlCommand.Parameters.AddWithValue("@thcno", HIDTHCNo.Value);
            sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@arrvdt", getDateInddMMMyyFormat(txtArrivalDate.Value));
            sqlCommand.Parameters.AddWithValue("@arrvtm", txtArrivalTimeHH.Value + ":" + txtArrivalTimeMM.Value);
            sqlCommand.Parameters.AddWithValue("@seal", txtIncomingSealNo.Value);
            sqlCommand.Parameters.AddWithValue("@sealstatus", ddlSealStatus.Value);
            sqlCommand.Parameters.AddWithValue("@inremark", txaIncomingRemarks.Value);
            sqlCommand.Parameters.AddWithValue("@empcd", txtUnloader.Value);
            sqlCommand.Parameters.AddWithValue("@latearrival", ddlLateArrivalReason.SelectedValue.Replace("-1", ""));
            sqlCommand.Parameters.AddWithValue("@closekm",txtCloseKM.Value.ToString());
            sqlCommand.ExecuteNonQuery();

            sqlConn.Close();
            sqlConn = null;

            blnTHCUpdated = true;
        }
        catch (Exception Ex)
        {
            lblErrorMessage.Visible = true;
            lblErrorMessage.InnerHtml = "<br />An unknown error has occurred: " + Ex.Message;

            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void DisplayData()
    {
        lblTHCNo.InnerHtml = HIDTHCNo.Value;
        lblVehNo.InnerHtml = strVehicleNo;
        lblVehDepFrom.InnerHtml = strPrevLoc + " @ " + strDepDateTime;
        lblExpArrivalDateTime.InnerHtml = (strETADate == "-" ? "" : strETAActualDate + " " + strETAActualTime);

        txtArrivalDate.Value = System.DateTime.Today.ToString("dd/MM/yyyy");
        txtArrivalTimeHH.Value = System.DateTime.Now.Hour.ToString("00");
        txtArrivalTimeMM.Value = System.DateTime.Now.Minute.ToString("00");

        txtUnloader.Value = Session["empcd"].ToString().ToUpper();

        lblOpenKM.InnerHtml = (strOpenKM.Trim() == "" ? "0" : strOpenKM);
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

    private void populateLateArrivalReason()
    {
        ddlLateArrivalReason.Items.Clear();
        
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQLForLateDeltReason = "select CodeID, CodeDesc from webx_master_general where codetype = 'LATE_A'";

        SqlCommand sqlCommand = new SqlCommand(strSQLForLateDeltReason, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsForLateArrivalReason = new DataSet();

        sqlDA.Fill(dsForLateArrivalReason);

        if (dsForLateArrivalReason.Tables[0].Rows.Count > 0)
        {
            ddlLateArrivalReason.DataTextField = "CodeDesc";
            ddlLateArrivalReason.DataValueField = "CodeID";

            ddlLateArrivalReason.DataSource = dsForLateArrivalReason;
            ddlLateArrivalReason.DataBind();
        }

        ddlLateArrivalReason.Items.Insert(0, new ListItem("Select", "-1"));
    }
    protected void txtCloseKM_ServerChange(object sender, EventArgs e)
    {

    }
}

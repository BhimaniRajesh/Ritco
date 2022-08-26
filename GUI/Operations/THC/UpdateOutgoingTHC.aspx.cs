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

public partial class GUI_Operations_THC_UpdateOutgoingTHC : System.Web.UI.Page
{
    static string strVehicleNo;
    static string strTHCNo;
    static string strTHCSF = ".";
    static string strTHCDate;
    static string strVendor;
    static string strRoute;
    static string strRouteCode;
    static string strArrivedAt;
    static string strATA;
    static string strDepartureFor;
    public static string strDepTimeHH;
    public static string strDepTimeMM;
    public static string strSystemDate;
    public static string strSystemTimeHH;
    public static string strSystemTimeMM;
    public static int intTotalRecords;

    string strFinalMFDetails;

    bool blnTHCUpdated = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strSystemDate = System.DateTime.Today.ToString("dd/MM/yyyy");
            strSystemTimeHH = System.DateTime.Now.ToString("HH");
            strSystemTimeMM = System.DateTime.Now.ToString("mm");

            strTHCNo = HttpUtility.UrlDecode(Request.QueryString["THCNo"].ToString());

            getDocumentDetails();

            DisplayData();

            ListManifestDetails();
        }

        lblHeader.InnerHtml = "<b>Update Outgoing " + HidTHC.Value + "</b>";
        lblSelCriteria.InnerHtml = "<b>Selected " + HidTHC.Value + " Details</b>";
        lblTHCNoCaption.InnerHtml = "<b>" + HidTHC.Value + " #:</b>";
        lblTHCDateCaption.InnerHtml = "<b>" + HidTHC.Value + " Date:</b>";
        lblAttachMF.InnerHtml = "<b>Select " + HidMF.Value + " to Attach</b>";
        lblMFNoCaption.InnerHtml = HidMF.Value + " No.";
        lblManMFNoCaption.InnerHtml = "Manual " + HidMF.Value + " No.";
        lblTotDockets.InnerHtml = "Total " + HidDocket.Value + "(s)&nbsp;";

        btnSubmit.Text = "Update Outgoing " + HidTHC.Value;
        btnSubmit.ToolTip = "Click here to Update Outgoing " + HidTHC.Value;

        Page.Title = "Update Outgoing " + HidTHC.Value;

        if (!IsPostBack)
        {
            txtVFS.Focus();
        }
    }

    protected void txtEmpCode_TextChanged(object sender, EventArgs e)
    {
        checkSupervisorCode();
    }

    private void checkSupervisorCode()
    {
        //Check for Supervisor
        txtEmpCode.Text = txtEmpCode.Text.Trim().ToUpper();

        if (txtEmpCode.Text == "")
        {
            txtEmpCode.Text = Session["empcd"].ToString().ToUpper();
            lblErrorEmpCode.Visible = false;
            return;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        String strSQLSupervisor = "select UserID From webx_master_users where rtrim(ltrim(UserID))='" + txtEmpCode.Text + "' and (rtrim(ltrim(branchcode))='" + Session["brcd"].ToString() + "' Or rtrim(ltrim(branchcode))='" + Session["mainbrcd"].ToString() + "') and Status='100'";

        SqlCommand sqlCommand = new SqlCommand(strSQLSupervisor, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsSupervisor = new DataSet();

        sqlDA.Fill(dsSupervisor);

        //Remove this code
        if (txtEmpCode.Text == Session["empcd"].ToString().ToUpper())
        {
            lblErrorEmpCode.Visible = false;
        }
        else
        {
            lblErrorEmpCode.Visible = (dsSupervisor.Tables[0].Rows.Count > 0 ? false : true);
        }

        if (lblErrorEmpCode.Visible == true)
        {
            txtEmpCode.Focus();
        }

        sqlConn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        UpdateOutgoingTHC();

        if (blnTHCUpdated == true)
        {
            Response.Redirect("THCArrivalsMainForOutgoing.aspx");
        }
    }

    private void DisplayData()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            string strSQL = "Select * From vw_THC_Departure Where THC_Number='" + strTHCNo + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsTHCDetails = new DataSet();

            sqlDA.Fill(dsTHCDetails);

            if (dsTHCDetails.Tables[0].Rows.Count > 0)
            {
                lblTHCNo.InnerHtml = strTHCNo;

                strTHCDate = Convert.ToDateTime(dsTHCDetails.Tables[0].Rows[0]["THC_Date"]).ToString("dd/MM/yyyy");
                lblTHCDate.InnerHtml = strTHCDate;

                strVendor = dsTHCDetails.Tables[0].Rows[0]["THC_Vendor"].ToString();
                lblVendor.InnerHtml = strVendor;

                strRoute = dsTHCDetails.Tables[0].Rows[0]["Route"].ToString();
                lblRoute.InnerHtml = strRoute;

                strVehicleNo = dsTHCDetails.Tables[0].Rows[0]["VehicleNo"].ToString();
                lblVehicle.InnerHtml = strVehicleNo;

                strArrivedAt = dsTHCDetails.Tables[0].Rows[0]["ArrivedFrom"].ToString();
                strATA = (dsTHCDetails.Tables[0].Rows[0]["ATA"].ToString().ToUpper() == "NULL" || dsTHCDetails.Tables[0].Rows[0]["ATA"].ToString().Trim() == "" ? "-" : getDateInddMMMyyFormat(Convert.ToDateTime(dsTHCDetails.Tables[0].Rows[0]["ATA"]).ToString("dd/MM/yyyy")) + " " + Convert.ToDateTime(dsTHCDetails.Tables[0].Rows[0]["ATA"]).ToString("HH:mm"));
                lblArrivedFrom.InnerHtml = strArrivedAt + " @ " + strATA;

                strDepartureFor = dsTHCDetails.Tables[0].Rows[0]["THC_For"].ToString();
                lblDepartingTo.InnerHtml = strDepartureFor;

                strRouteCode = dsTHCDetails.Tables[0].Rows[0]["RouteCode"].ToString();

                txtEmpCode.Text = Session["empcd"].ToString();

                txtDepartureDate.Value = strSystemDate;
                txtDepartureTimeHH.Value = strSystemTimeHH;
                txtDepartureTimeMM.Value = strSystemTimeMM;
            }
            else
            {

            }
        }
        catch (Exception Ex)
        {

        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
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

    private void ListManifestDetails()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "sp_manifest_for_attachments";

            sqlCommand.Parameters.AddWithValue("@MF_Branch", Session["brcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@RouteCode", strRouteCode);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDocketListForMF = new DataSet();
            sqlDA.Fill(dsDocketListForMF);

            DataTable dt = new DataTable();

            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("MFNo", typeof(string));
            dt.Columns.Add("ManualMFNo", typeof(string));
            dt.Columns.Add("BookingLocation", typeof(string));
            dt.Columns.Add("BookingDate", typeof(string));
            dt.Columns.Add("NextLocation", typeof(string));
            dt.Columns.Add("TotalDockets", typeof(string));
            dt.Columns.Add("PackagesLB", typeof(string));
            dt.Columns.Add("WeightLB", typeof(string));
            dt.Columns.Add("CFT", typeof(string));
            
            DataRow dr;

            int i = 1;

            HidTotalRecords.Value = dsDocketListForMF.Tables[0].Rows.Count.ToString();
            
            HidSelectedMFDetails.Value = "";
            strFinalMFDetails = "";
            
            if (dsDocketListForMF.Tables[0].Rows.Count > 0)
            {
                rptDocketListForMF.Visible = true;
                
                foreach (DataRow drRows in dsDocketListForMF.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["MFNo"] = (drRows["tcno"].ToString().ToUpper() == "NULL" || drRows["tcno"].ToString().Trim() == "" ? "-" : drRows["tcno"].ToString());
                    dr["ManualMFNo"] = (drRows["manual_tcno"].ToString().ToUpper() == "NULL" || drRows["manual_tcno"].ToString().Trim() == "" ? "-" : drRows["manual_tcno"].ToString());
                    dr["BookingLocation"] = (drRows["tcbr"].ToString().ToUpper() == "NULL" || drRows["tcbr"].ToString().Trim() == "" ? "-" : drRows["tcbr"].ToString());
                    dr["BookingDate"] = (drRows["MF_Date"].ToString().ToUpper() == "NULL" || drRows["MF_Date"].ToString().Trim() == "" ? "-" : (drRows["MF_Date"].ToString().IndexOf('/') > 0 ? getDateInddMMMyyFormat(drRows["MF_Date"].ToString()) : getDateInddMMMyyFormat(Convert.ToDateTime(drRows["MF_Date"]).ToString("dd/MM/yyyy"))));
                    dr["NextLocation"] = (drRows["tobh_code"].ToString().ToUpper() == "NULL" || drRows["tobh_code"].ToString().Trim() == "" ? "-" : drRows["tobh_code"].ToString());
                    dr["TotalDockets"] = (drRows["tot_dkt"].ToString().ToUpper() == "NULL" || drRows["tot_dkt"].ToString().Trim() == "" ? "-" : drRows["tot_dkt"].ToString());
                    dr["PackagesLB"] = (drRows["pkgs"].ToString().ToUpper() == "NULL" || drRows["pkgs"].ToString().Trim() == "" ? "-" : drRows["pkgs"].ToString());
                    dr["WeightLB"] = (drRows["wts"].ToString().ToUpper() == "NULL" || drRows["wts"].ToString().Trim() == "" ? "-" : drRows["wts"].ToString());
                    dr["CFT"] = (drRows["CFT_wt"].ToString().ToUpper() == "NULL" || drRows["CFT_wt"].ToString().Trim() == "" ? "-" : drRows["CFT_wt"].ToString());                   

                    strFinalMFDetails = (strFinalMFDetails == "" ? dr["MFNo"].ToString() + "," + dr["BookingLocation"].ToString() + "," + dr["NextLocation"].ToString() + "," + dr["PackagesLB"].ToString() + "," + dr["WeightLB"].ToString() + "," + dr["CFT"].ToString() : strFinalMFDetails + "~" + dr["MFNo"].ToString() + "," + dr["BookingLocation"].ToString() + "," + dr["NextLocation"].ToString() + "," + dr["PackagesLB"].ToString() + "," + dr["WeightLB"].ToString() + "," + dr["CFT"].ToString());

                    dt.Rows.Add(dr);
                }

                rptDocketListForMF.DataSource = dt;
                rptDocketListForMF.DataBind();

                HidFinalMFDetails.Value = strFinalMFDetails;
            }
            else
            {
                trErrorMsgForMF.Visible = true;
                lblErrorMsgForMF.InnerHtml = HidMF.Value + " details not found!";
            }
        }
        catch (Exception Ex)
        {
            trErrorMsgForMF.Visible = true;
            lblErrorMsgForMF.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void UpdateOutgoingTHC()
    {
        blnTHCUpdated = false;

        lblErrorUpdateOutgoingTHC.Visible = false;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "";

        try
        {
            SqlCommand sqlCommand;

            if (HidSelectedMFDetails.Value != "")
            {
                string[] strArrMFDetails = HidSelectedMFDetails.Value.Split('~');

                for (int intLoopCuonter = 0; intLoopCuonter < strArrMFDetails.Length; intLoopCuonter++)
                {
                    string[] strArrInnerMFDetails = strArrMFDetails[intLoopCuonter].Split(',');

                    strSQL = "Update webx_TCHDR set ROUTE_CODE='" + strRouteCode + "', TFlag_YN = 'Y',THCBR = '" + Session["brcd"].ToString() + "', THCNO = '" + strTHCNo + "',THCsf = '" + strTHCSF + "', THCDT=getdate(),VEHNO='" + strVehicleNo + "' where TCNO ='" + strArrInnerMFDetails[0] + "'";

                    sqlCommand = new SqlCommand(strSQL, sqlConn);
                    sqlCommand.ExecuteNonQuery();
                    sqlCommand = null;

                    //strSQL = "Insert into webx_thctc_pntr (THCNO,THCSF,TCNO,TCSF,TCBR,TCDATE,TC_CHWT,airbilltotamt,TOBH_Code,TOTDKT)";
                    //strSQL += " Select '" + strTHCNo + "' As THCNO, '.' As THCSF, TCNO, TCSF, TCBR, TCDT, TOT_CFTWT, 0 As airbilltotamt, ToBH_CODE, TOT_DKT From webx_tchdr Where tcno='" + strArrInnerMFDetails[0] + "'";

                    //sqlCommand = new SqlCommand(strSQL, sqlConn);
                    //sqlCommand.ExecuteNonQuery();
                }
            }

            strSQL = "update webx_thchdr set outacm='" + txtVFS.Value + "', sealno_out='" + txtSealNo.Value + "',sealstat_out='Ok',actdept_dt='" + getDateInddMMMyyFormat(txtDepartureDate.Value) + "',actdept_tm='" + txtDepartureTimeHH.Value + ":" + txtDepartureTimeMM.Value + "',thc_outrem='" + txaOutgoingRemarks.Value.Replace("'", "").Replace(" ", "_") + "',loader='" + txtEmpCode.Text + "' Where thcno='" + strTHCNo + "' and sourcehb='" + Session["brcd"].ToString() + "'";

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlCommand.ExecuteNonQuery();
            sqlCommand = null;

            blnTHCUpdated = true;
        }
        catch (Exception Ex)
        {
            lblErrorUpdateOutgoingTHC.Visible = true;
            lblErrorUpdateOutgoingTHC.InnerHtml = "<br />An unknown error has occurred: " + Ex.Message;

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

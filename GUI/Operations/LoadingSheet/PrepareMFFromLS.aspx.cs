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

public partial class GUI_Operations_LoadingSheet_PrepareMFFromLS : System.Web.UI.Page
{   
    public static string strLSCaption;
    public static int intTotalRecords;
    static string strSelectedDocketList;
    static string strDocketNoList;
    static string strToHubList;
    static string strSelectedToHubList;
    static string strPackagesList;
    static string strSelectedPackagesList;
    static string strWeightList;
    static string strSelectedWeightList;
    static bool blnPostSQL;

    string strSelectedDocketsForMF;
    string strNotSelectedDocketsForMF;
    string strSelectedToHubsForMF;
    string strSelectedPackagesForMF;
    string strSelectedWeightsForMF;   
    string strRouteCode;
    string strNextMFCode;
    int intTotalPackages;
    double dblTotalWeights;
    int intRemainingPackages;
    double dblRemainingWeights;
    string strDocketsForInnerLoop;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidLSNo.Value = HttpUtility.UrlDecode(Request.QueryString["LSNo"].ToString());
            blnPostSQL = false;

            getDocumentDetails();

            paintDocketListingForMF();
        }

        lblHeader.InnerHtml = "<b>Update " + HidLS.Value + " & Prepare " + HidMF.Value + "</b>";
        lblMF.InnerHtml = "<b>" + HidMF.Value + " No.&nbsp;</b>";
        lblDocketPrep.InnerHtml = "<b>&nbsp;prepared for following " + HidDocket.Value + "s</b>";
        lblMF.InnerHtml = "<b>" + HidMF.Value + " No.&nbsp;</b>";
        lblDocketCaption.InnerHtml = HidDocket.Value + " No.";
        lblDocketCaption1.InnerHtml = HidDocket.Value + " No.";


        Page.Title = "Prepare " + HidMF.Value + " From " + HidLS.Value;
        btnPrepareMF.Text = "Prepare " + HidMF.Value;
    }

    private void paintDocketListingForMF()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        try
        {
            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "usp_webx_dockets_in_LS";

            sqlCommand.Parameters.AddWithValue("@LSCode", HidLSNo.Value);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDocketListForMF = new DataSet();
            sqlDA.Fill(dsDocketListForMF);

            DataTable dt = new DataTable();

            //dt.Columns.Add("CheckBoxOrSpace", typeof(string));
            dt.Columns.Add("RowColor", typeof(string));
            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("DocketID", typeof(string));
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
            dt.Columns.Add("GiveAlert", typeof(string));
            
            DataRow dr;

            int i = 1;

            intTotalRecords = dsDocketListForMF.Tables[0].Rows.Count;
            HidTotalRecords.Value = intTotalRecords.ToString();
            trTableHeaderForMF.Visible = true;
            trTableHeaderForMFForView.Visible = false;
            rptViewDocketsInMF.Visible = false;
            rptDocketListForMF.Visible = false;

            strDocketNoList = "";
            strSelectedDocketList = "";
            strToHubList = "";
            strSelectedToHubList = "";
            strPackagesList = "";
            strSelectedPackagesList = "";
            strWeightList = "";
            strSelectedWeightList = "";

            string strGiveAlert = "";
            string strStdPayBase = "P02,P08,P09";

            trLSCaption.Visible = true;
            strLSCaption = HidDocket.Value + "s from " + HidLS.Value + " " + HidLSNo.Value + " for preparing " + HidMF.Value;

            if (intTotalRecords > 0)
            {
                rptDocketListForMF.Visible = true;

                trPrepareMFButton.Visible = true;

                foreach (DataRow drRows in dsDocketListForMF.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    strGiveAlert = (drRows["DOCKET_MODE"].ToString() == "Q" ? (strStdPayBase.Contains(drRows["PayBase"].ToString()) ? "N" : "Y") : "");

                    //dr["CheckBoxOrSpace"] = (blnPostSQL == true ? "" : "<input id=\"chkSelDocket\" type=\"checkbox\" runat=\"server\" value=\"" + drRows["DocketNo"].ToString() + "\" onclick=\"SelectDocket('" + drRows["DOCKET_MODE"].ToString() + "','" + drRows["DocketNo"].ToString() + "','" + strGiveAlert + "','" + drRows["DelyLoc"].ToString() + "', this)\"" + (strGiveAlert == "Y" ? "" : " checked ") + " />");
                    dr["GiveAlert"] = strGiveAlert;
                    dr["RowColor"] = (drRows["DOCKET_MODE"].ToString() == "Q" ? "#FF0000" : "#000000");
                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["DocketNo"] = drRows["DocketNo"].ToString();

                    strDocketNoList = (strDocketNoList == "" ? drRows["DocketNo"].ToString() : strDocketNoList + "," + drRows["DocketNo"].ToString());
                    strToHubList = (strToHubList == "" ? drRows["DelyLoc"].ToString() : strToHubList + "," + drRows["DelyLoc"].ToString());
                    strPackagesList = (strPackagesList == "" ? drRows["PackagesLB"].ToString() : strPackagesList + "," + drRows["PackagesLB"].ToString());
                    strWeightList = (strWeightList == "" ? drRows["WeightLB"].ToString() : strWeightList + "," + drRows["WeightLB"].ToString());

                    if (strGiveAlert == "N" || strGiveAlert == "")
                    {
                        strSelectedDocketList = (strSelectedDocketList == "" ? drRows["DocketNo"].ToString() : strSelectedDocketList + "," + drRows["DocketNo"].ToString());
                        strSelectedToHubList = (strSelectedToHubList == "" ? drRows["DelyLoc"].ToString() : strSelectedToHubList + "," + drRows["DelyLoc"].ToString());
                        strSelectedPackagesList = (strSelectedPackagesList == "" ? drRows["PackagesLB"].ToString() : strSelectedPackagesList + "," + drRows["PackagesLB"].ToString());
                        strSelectedWeightList = (strSelectedWeightList == "" ? drRows["WeightLB"].ToString() : strSelectedWeightList + "," + drRows["WeightLB"].ToString());
                    }

                    dr["DocketMode"] = drRows["DOCKET_MODE"].ToString();
                    dr["DocketDate"] = (drRows["DocketDate"].ToString().ToUpper() == "NULL" || drRows["DocketDate"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["DocketDate"].ToString()).ToString("dd MMM yy"));
                    dr["OrgCode"] = drRows["OrgCode"].ToString();
                    dr["ConsName"] = getConsName(drRows["ConsCD"].ToString(), drRows["ConsName"].ToString());
                    dr["NextStop"] = drRows["DelyLoc"].ToString();
                    dr["DelyLoc"] = drRows["DestCode"].ToString();
                    dr["ArrivalDate"] = (drRows["ArrivalDate"].ToString().ToUpper() == "NULL" || drRows["ArrivalDate"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["ArrivalDate"].ToString()).ToString("dd MMM yy"));
                    dr["DelyDate"] = (drRows["DelyDate"].ToString().ToUpper() == "NULL" || drRows["DelyDate"].ToString().Trim() == "" ? "-" : Convert.ToDateTime(drRows["DelyDate"].ToString()).ToString("dd MMM yy"));
                    dr["PackagesLB"] = drRows["PackagesLB"].ToString();
                    dr["WeightLB"] = drRows["WeightLB"].ToString();

                    dt.Rows.Add(dr);
                }

                rptDocketListForMF.DataSource = dt;
                rptDocketListForMF.DataBind();

                HidSelectedDocketNos.Value = strDocketNoList;
                //HidSelectedDockets.Value = strSelectedDocketList;
                HidSelectedToHubNos.Value = strToHubList;
                //HidSelectedToHub.Value = strSelectedToHubList;
                HidSelectedPackageNos.Value = strPackagesList;
                //HidSelectedPackages.Value = strSelectedPackagesList;
                HidSelectedWeightNos.Value = strWeightList;
                //HidSelectedWeights.Value = strSelectedWeightList;
            }
            else
            {
                trErrorMsgForMF.Visible = true;
                lblErrorMsgForMF.InnerHtml = "No " + HidDocket.Value + "s Found for the given " + HidLS.Value;
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
        }
    }

    private string getConsName(string strConsCode, string strConsName)
    {
        if (strConsCode == "8888")
        {
            return strConsName;
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

                sqlConn.Close();

                return (dsConsName.Tables[0].Rows.Count > 0 ? GenerateProperCase(dsConsName.Tables[0].Rows[0][0].ToString()) : "-");
            }
            catch (Exception Ex)
            {
                sqlConn.Close();

                return "-";
            }
        }
    }

    protected void btnPrepareMF_Click(object sender, EventArgs e)
    {
        //Segregate Selected and Not Selected Dockets
        segregateDocektSelection();
        //Get Route Code based on LS No.
        getRouteCode();
        //Get Next MF Code
        getNextMFCode();
        //Insert MF entry for selected Dockets
        insertMFEntryForSelectedDockets();
        //Hide LS Caption
        //trLSCaption.Visible = false;
        //Paint Dockets in MF
        //paintDocketsInMF();
        //Display next step rows
        //trNextStep.Visible = true;
        //trPrepareMF.Visible = true;
        //trPrepareTHC.Visible = true;

        Response.Redirect("DisplayMFResult.aspx?MFNo=" + strNextMFCode + "&ManMFNo=");
    }

    private void getRouteCode()
    {
        try
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            string strSQL = "Select ROUTE_CODE from webx_tchdr_tmp where TCNO='" + HidLSNo.Value + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsRouteCode = new DataSet();

            sqlDA.Fill(dsRouteCode);

            strRouteCode = (dsRouteCode.Tables[0].Rows.Count > 0 ? dsRouteCode.Tables[0].Rows[0]["ROUTE_CODE"].ToString() : "");

            sqlConn.Close();
        }
        catch (Exception Ex)
        {
            strRouteCode = "";
        }
    }

    private void getNextMFCode()
    {
        try
        {
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            sqlConn.Open();

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            
            //sqlCommand.CommandText = "usp_get_next_mf_code";
            //sqlCommand.Parameters.AddWithValue("@loccode", Session["brcd"].ToString());

            //AS PER NEW DB OBJECTS WITH IMPLEMENTATION OF NOMENCLATURE RULES
            sqlCommand.CommandText = "WebX_SP_GetNextDocumentCode";

            sqlCommand.Parameters.AddWithValue("@LocCode", Session["brcd"].ToString());
            sqlCommand.Parameters.AddWithValue("@FinYear", Session["FinYear"].ToString());
            sqlCommand.Parameters.AddWithValue("@Document", "MF");

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
            DataSet dsNextMFCode = new DataSet();

            sqlDA.Fill(dsNextMFCode);

            strNextMFCode = dsNextMFCode.Tables[0].Rows[0][0].ToString().Replace(" ", "");
        }
        catch (Exception Ex)
        {
            strNextMFCode = "";
        }
    }

    private void segregateDocektSelection()
    {
        strSelectedDocketsForMF = "";
        strNotSelectedDocketsForMF = "";
        strSelectedToHubsForMF = "";
        strSelectedPackagesForMF = "";
        strSelectedWeightsForMF = "";
        strDocketsForInnerLoop = "";

        string[] strArrDockets = HidSelectedDocketNos.Value.Split(',');
        string[] strArrToHubs = HidSelectedToHubNos.Value.Split(',');
        string[] strArrPackages = HidSelectedPackageNos.Value.Split(',');
        string[] strArrWeights = HidSelectedWeightNos.Value.Split(',');
        string[] strArrSelectedWeights = HidSelectedWeights.Value.Split(',');
        string[] strArrSelectedPackages = HidSelectedPackages.Value.Split(',');
        
        //Segragate not selected dockets, To Hubs, Packages and Weights
        for (int intLoopCounter = 0; intLoopCounter < strArrDockets.Length; intLoopCounter++)
        {
            if (HidSelectedDockets.Value.Contains(strArrDockets[intLoopCounter]))
            {
                strSelectedDocketsForMF = (strSelectedDocketsForMF == "" ? strArrDockets[intLoopCounter] : strSelectedDocketsForMF + "," + strArrDockets[intLoopCounter]);
                strSelectedToHubsForMF = (strSelectedToHubsForMF == "" ? strArrToHubs[intLoopCounter] : strSelectedToHubsForMF + "," + strArrToHubs[intLoopCounter]);

                strSelectedPackagesForMF = (strSelectedPackagesForMF == "" ? getSelectedPackage(strArrDockets[intLoopCounter]) : strSelectedPackagesForMF + "," + getSelectedPackage(strArrDockets[intLoopCounter]));
                strSelectedWeightsForMF = (strSelectedWeightsForMF == "" ? getSelectedWeight(strArrDockets[intLoopCounter]) : strSelectedWeightsForMF + "," + getSelectedWeight(strArrDockets[intLoopCounter]));

                intTotalPackages += Convert.ToInt32(getSelectedPackage(strArrDockets[intLoopCounter]));
                intRemainingPackages += Convert.ToInt32(strArrPackages[intLoopCounter]) - Convert.ToInt32(getSelectedPackage(strArrDockets[intLoopCounter]));

                dblTotalWeights += Convert.ToDouble(getSelectedWeight(strArrDockets[intLoopCounter]));
                dblRemainingWeights += Convert.ToDouble(strArrWeights[intLoopCounter]) - Convert.ToDouble(getSelectedWeight(strArrDockets[intLoopCounter]));

                strDocketsForInnerLoop = (strDocketsForInnerLoop == "" ? strArrDockets[intLoopCounter] + "~" + getSelectedPackage(strArrDockets[intLoopCounter]) + "~" + getSelectedWeight(strArrDockets[intLoopCounter]) + "~" + strArrPackages[intLoopCounter] + "~" + strArrWeights[intLoopCounter] + "~" + Convert.ToString(Convert.ToDouble(strArrPackages[intLoopCounter]) - Convert.ToDouble(getSelectedPackage(strArrDockets[intLoopCounter]))) + "~" + Convert.ToString(Convert.ToDouble(strArrWeights[intLoopCounter]) - Convert.ToDouble(getSelectedWeight(strArrDockets[intLoopCounter]))) : strDocketsForInnerLoop + "," + strArrDockets[intLoopCounter] + "~" + getSelectedPackage(strArrDockets[intLoopCounter]) + "~" + getSelectedWeight(strArrDockets[intLoopCounter]) + "~" + strArrPackages[intLoopCounter] + "~" + strArrWeights[intLoopCounter] + "~" + Convert.ToString(Convert.ToDouble(strArrPackages[intLoopCounter]) - Convert.ToDouble(getSelectedPackage(strArrDockets[intLoopCounter]))) + "~" + Convert.ToString(Convert.ToDouble(strArrWeights[intLoopCounter]) - Convert.ToDouble(getSelectedWeight(strArrDockets[intLoopCounter]))));
            }
            else
            {
                strNotSelectedDocketsForMF = (strNotSelectedDocketsForMF == "" ? strArrDockets[intLoopCounter] : strNotSelectedDocketsForMF + "," + strArrDockets[intLoopCounter]);
            }
        }
    }

    protected void insertMFEntryForSelectedDockets()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();

        try
        {
            string[] strArrDockets = strSelectedDocketsForMF.Split(',');
            string[] strArrNotSelectedDockets = strNotSelectedDocketsForMF.Split(',');
            string[] strArrToHubs = strSelectedToHubsForMF.Split(',');
            string[] strArrPackages = strSelectedPackagesForMF.Split(',');
            string[] strArrWeights = strSelectedWeightsForMF.Split(',');

            string strSQLForTCTRN;
            string strSQLForTCHDR;
            string strUpdateForTCHDR;
            string strSQLForDocketTrackUpdate;
            string strSQLForRemainingDocketTrackInsert;
            string strSQLForRemainingDocketStatusInsert;
            string strSQLForDocketUpdate;

            SqlCommand sqlCommandForTCTRN;
            SqlCommand sqlCommandForTCHeader;
            SqlCommand sqlCommandForDocket;
            SqlCommand sqlCommandForDocketTrack;

            string strMFNo = strNextMFCode;

            //Insert record in webx_TCHDR table

            strSQLForTCHDR = "Insert into webx_TCHDR (Entryby,TCNO,TCSF,TCBR,ROUTE_CODE,TOT_DKT,tot_load_pkgs,TOT_PKGS,tot_load_actwt,TOT_ACTUWT,TOT_CFTWT, " +
                                         "VEHNO,ToBH_CODE,TCHDRFLAG,TFLAG_YN,TCDT) VALUES ('" + Session["empcd"].ToString() + "', '" +
                                         strMFNo + "', '.', '" + Session["brcd"].ToString() + "', '" + strRouteCode +
                                         "', " + strArrDockets.Length.ToString() + ", " + intTotalPackages.ToString() + ", " + intTotalPackages.ToString() + ", " +
                                         dblTotalWeights.ToString() + ", " + dblTotalWeights.ToString() + ", " + dblTotalWeights.ToString() + ", '', '" +
                                         strArrToHubs[0] + "', 'Y', 'N', GetDate())";


            //,(select FromCity From WebX_TCHDR_Tmp Where TCNo='" + HidLSNo.Value + "'),(select ToCity From WebX_TCHDR_Tmp Where TCNo='" + HidLSNo.Value + "')

            sqlCommandForTCHeader = new SqlCommand();
            sqlCommandForTCHeader.Connection = sqlConn;
            sqlCommandForTCHeader.CommandText = strSQLForTCHDR;
            //sqlCommand.Transaction = sqlTrans;

            sqlCommandForTCHeader.ExecuteNonQuery();
            //Successful record entry in webx_TCHDR table

            sqlCommandForTCHeader = null;

            strUpdateForTCHDR = "Update WebX_TCHDR Set FromCity=(Select FromCity From Webx_TCHDR_Tmp Where TCNO='" + HidLSNo.Value + "'),ToCity=(Select ToCity From Webx_TCHDR_Tmp Where TCNO='" + HidLSNo.Value + "')Where TCNO='" + strMFNo + "'";
            sqlCommandForTCHeader = new SqlCommand();
            sqlCommandForTCHeader.Connection = sqlConn;
            sqlCommandForTCHeader.CommandText = strUpdateForTCHDR;
            sqlCommandForTCHeader.ExecuteNonQuery();
            
            //Insert record in webx_TCTRN table

            strSQLForTCTRN = "<root>";

            string[] strArrTemp = strDocketsForInnerLoop.Split(',');

            for (int intInnerLoopCounter = 0; intInnerLoopCounter < strArrTemp.Length; intInnerLoopCounter++)
            {
                string[] strArrDocketsInnerLoop = strArrTemp[intInnerLoopCounter].Split('~');

                strSQLForTCTRN += "<tctrn>" +
                                  "<tcno>" + strMFNo + "</tcno>" +
                                  "<tcsf>" + "." + "</tcsf>" +
                                  "<dockno>" + strArrDocketsInnerLoop[0].Substring(0, strArrDocketsInnerLoop[0].Length - 1) + "</dockno>" +
                                  "<docsf>" + strArrDocketsInnerLoop[0].Substring(strArrDocketsInnerLoop[0].Length - 1) + "</docsf>" +
                                  "<packages>" + strArrDocketsInnerLoop[1] + "</packages>" +
                                  "<weight>" + strArrDocketsInnerLoop[2] + "</weight>" +
                                  "<chargeweight>" + strArrDocketsInnerLoop[2] + "</chargeweight>" +
                                  "</tctrn>";
            }

            strSQLForTCTRN += "</root>";

            sqlCommandForTCTRN = new SqlCommand();
            sqlCommandForTCTRN.Connection = sqlConn;
            sqlCommandForTCTRN.CommandType = CommandType.StoredProcedure;
            sqlCommandForTCTRN.CommandText = "WebX_SP_Insert_Dockets_TCTRN_For_MF";

            sqlCommandForTCTRN.Parameters.AddWithValue("@strXML", strSQLForTCTRN);

            sqlCommandForTCTRN.ExecuteNonQuery();

            //Successful Update record in webx_TCTRN table

            //Update record in webx_Trans_Docket_Track table

            //This SQL Statement is based on Revised Docket Structure (Impl. started on 16-Aug-07)

            strSQLForDocketTrackUpdate = "Update webx_Trans_Docket_Track SET NextLoc='" + strArrToHubs[0] + "', UpdtBy = '" + Session["empcd"].ToString() + "', UpdtOn = '" + System.DateTime.Today.ToString("dd-MMM-yyyy") + " " + System.DateTime.Now.Hour.ToString("00") + ":" + System.DateTime.Now.Minute.ToString("00") + ":" + System.DateTime.Now.Second.ToString("00") + "' Where Dockno + DockSF IN ('" + strSelectedDocketsForMF.Replace("'", "").Replace(" ", "").Replace(",", "','") + "')";
            sqlCommandForDocketTrack = new SqlCommand();
            sqlCommandForDocketTrack.Connection = sqlConn;
            sqlCommandForDocketTrack.CommandText = strSQLForDocketTrackUpdate;
            //sqlCommand.Transaction = sqlTrans;

            sqlCommandForDocketTrack.ExecuteNonQuery();
            //Successful Update record in webx_Trans_Docket_Track table

            strSQLForDocketUpdate = "Update webx_Trans_Docket_Status Set NextLoc='" + strArrToHubs[0] + "', MF ='" + strMFNo + "' Where DockNo+DockSF IN ('" + strSelectedDocketsForMF.Replace("'", "").Replace(" ", "").Replace(",", "','") + "')";

            sqlCommandForDocket = new SqlCommand();
            sqlCommandForDocket.Connection = sqlConn;
            sqlCommandForDocket.CommandText = strSQLForDocketUpdate;
            //sqlCommand.Transaction = sqlTrans;

            sqlCommandForDocket.ExecuteNonQuery();
            //Successful Update record in webx_Trans_Docket_Status table

            strSQLForRemainingDocketTrackInsert = "<root>";

            for (int intInnerLoopCounter = 0; intInnerLoopCounter < strArrTemp.Length; intInnerLoopCounter++)
            {
                string[] strArrDocketsInnerLoop = strArrTemp[intInnerLoopCounter].Split('~');

                if (strArrDocketsInnerLoop[5].Trim() != "")
                {
                    if (Convert.ToDouble(strArrDocketsInnerLoop[5]) > 0)
                    {
                        //============================================================================
                        //===========Start Commented on 18 Dec 2007=========================================
                        //============================================================================
                        ////Insert record in WebX_trans_Docket_Status table
                        //strSQLForDocketTrackUpdate = "INSERT INTO WebX_Trans_Docket_Status (DOCKNO, DOCKSF, Docket_Mode, Curr_Loc, Billed, MR, OctroiMR, LS, MF, Delivered, Cancelled, Op_Status) SELECT '" +
                        //                             strArrDocketsInnerLoop[0].Substring(0, strArrDocketsInnerLoop[0].Length - 1) + "', 'X', (SELECT TOP 1 Docket_Mode FROM WebX_Trans_Docket_Status WHERE DOCKNO = '" +
                        //                             strArrDocketsInnerLoop[0].Substring(0, strArrDocketsInnerLoop[0].Length - 1) + "' AND DOCKSF = '" + strArrDocketsInnerLoop[0].Substring(strArrDocketsInnerLoop[0].Length - 1) +
                        //                             "') AS Docket_Mode, '" + Session["brcd"].ToString() + "', 'N', 'N', 'N', '" +
                        //                             HidLSNo.Value + "', '" + strNextMFCode + "', 'N', 'N', 'B'";

                        //sqlCommandForDocketTrack = new SqlCommand();
                        //sqlCommandForDocketTrack.Connection = sqlConn;
                        //sqlCommandForDocketTrack.CommandText = strSQLForDocketTrackUpdate;
                        ////sqlCommand.Transaction = sqlTrans;

                        //sqlCommandForDocketTrack.ExecuteNonQuery();
                        ////Successful Update record in WebX_trans_Docket_Status table

                        ////Insert record in WebX_trans_Docket_Track table
                        //strSQLForDocketTrackUpdate = "INSERT INTO WebX_Trans_Docket_Track (SrNo, Dockno, DockSF, CurLoc, In_Out, Packages, Weight, UpdtBy, UpdtOn) " +
                        //                             "SELECT (SELECT [dbo].[GetNextSrNo] ('" + strArrDocketsInnerLoop[0].Substring(0, strArrDocketsInnerLoop[0].Length - 1) +
                        //                             "')) AS SrNo, '" +
                        //                             strArrDocketsInnerLoop[0].Substring(0, strArrDocketsInnerLoop[0].Length - 1) + "', 'X','" +
                        //                             Session["brcd"].ToString() + "', 'B', " + strArrDocketsInnerLoop[5] + "," + strArrDocketsInnerLoop[6] + ",'" +
                        //                             Session["empcd"].ToString() + "', '" + System.DateTime.Today.ToString("dd-MMM-yyyy") + " " + System.DateTime.Now.Hour.ToString("00") + ":" + System.DateTime.Now.Minute.ToString("00") + ":" + System.DateTime.Now.Second.ToString("00") + "'";

                        //sqlCommandForDocketTrack = new SqlCommand();
                        //sqlCommandForDocketTrack.Connection = sqlConn;
                        //sqlCommandForDocketTrack.CommandText = strSQLForDocketTrackUpdate;
                        ////sqlCommand.Transaction = sqlTrans;

                        //sqlCommandForDocketTrack.ExecuteNonQuery();
                        ////Successful Update record in WebX_trans_Docket_Track table
                        //============================================================================
                        //===========End Commented on 18 Dec 2007=========================================
                        //============================================================================
                    }
                }
            }

            //Update record in webx_tchdr_tmp table
            strSQLForTCHDR = "Update webx_tchdr_tmp Set Final_TC='Y' Where tcno='" + HidLSNo.Value + "'";

            sqlCommandForTCHeader = new SqlCommand();
            sqlCommandForTCHeader.Connection = sqlConn;
            sqlCommandForTCHeader.CommandText = strSQLForTCHDR;
            //sqlCommand.Transaction = sqlTrans;

            sqlCommandForTCHeader.ExecuteNonQuery();
            //Successful Update record in webx_tchdr_tmp table
        }
        catch (Exception Ex)
        {
            trErrorMsgForMF.Visible = true;
            lblErrorMsgForMF.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
    }

    private void paintDocketsInMF()
    {
        try
        {
            //tdForMF.Visible = false;
            blnPostSQL = true;
            //Display link for MF No.
            trLSCaptionWithLink.Visible = true;
            lnkbtnDocketsInMF.Text = strNextMFCode;
            //Hide Prepare MF Button row
            trPrepareMFButton.Visible = false;
            //Generate SQL
            
            string strSQL = "SELECT WMD.DOCKNO+WMD.DOCKSF As DocketNo, WMD.DOCKDT AS DocketDate, WMD.ORGNCD AS OrgCode,  " + 
                            "WMD.CSGNCD AS ConsCD, WMD.CSGNNM AS ConsName, WTDS.NextLoc AS DelyLoc, WMD.DESTCD AS DestCode, " + 
                            "'' AS ArrivalDate, WMD.CDELDT AS DelyDate, WMD.PKGSNO  AS PackagesLBOld, WMD.ACTUWT AS WeightLBOld, " + 
                            "tc.LOADPKGSNO  AS PackagesLB, tc.LOADACTUWT AS WeightLB, WTDS.DOCKET_MODE AS DocketMode " + 
                            "From WebX_Master_Docket WMD Inner Join WebX_Trans_Docket_Status WTDS On " +
                            "WMD.dockno = WTDS.dockno inner join webx_tctrn tc on WMD.dockno=tc.dockno " +
                            "where tc.tcno = '" + strNextMFCode + "' AND WTDS.docksf = '.'";

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
            trTableHeaderForMF.Visible = true;
            rptDocketListForMF.Visible = false;

            if (intTotalRecords > 0)
            {
                rptViewDocketsInMF.Visible = true;
                trPrepareMFButton.Visible = false;

                foreach (DataRow drRows in dsDocketListForMF.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    dr["RowColor"] = (drRows["DocketMode"].ToString() == "Q" ? "#FF0000" : "#000000");
                    dr["SrNo"] = i.ToString();
                    i++;
                    dr["DocketNo"] = drRows["DocketNo"].ToString();
                    dr["DocketMode"] = drRows["DocketMode"].ToString();
                    dr["DocketDate"] = (drRows["DocketDate"] == System.DBNull.Value ? "-" : Convert.ToDateTime(drRows["DocketDate"].ToString()).ToString("dd MMM yy"));
                    dr["OrgCode"] = drRows["OrgCode"].ToString();
                    dr["ConsName"] = getConsName(drRows["ConsCD"].ToString(), drRows["ConsName"].ToString());
                    dr["NextStop"] = drRows["DelyLoc"].ToString();
                    dr["DelyLoc"] = drRows["DestCode"].ToString();
                    dr["ArrivalDate"] = (drRows["ArrivalDate"].ToString().Trim() == "" || drRows["ArrivalDate"].ToString().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["ArrivalDate"].ToString()).ToString("dd MMM yy"));
                    dr["DelyDate"] = (drRows["DelyDate"].ToString().Trim() == "" || drRows["DelyDate"].ToString().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(drRows["DelyDate"].ToString()).ToString("dd MMM yy"));
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

    protected void lnkbtnDocketsInMF_Click(object sender, EventArgs e)
    {
                                           
    }

    private string getSelectedPackage(string strDocketNo)
    {
        string[] strArrDockets = HidSelectedDockets.Value.Split(',');
        string[] strArrPackages = HidSelectedPackages.Value.Split(',');
        
        for (int intLoopCounter = 0; intLoopCounter < strArrPackages.Length; intLoopCounter++)
        {
            if (strArrDockets[intLoopCounter] == strDocketNo)
            {
                return strArrPackages[intLoopCounter];
            }
        }

        return "0";
    }

    private string getSelectedWeight(string strDocketNo)
    {
        string[] strArrDockets = HidSelectedDockets.Value.Split(',');
        string[] strArrWeights = HidSelectedWeights.Value.Split(',');

        for (int intLoopCounter = 0; intLoopCounter < strArrWeights.Length; intLoopCounter++)
        {
            if (strArrDockets[intLoopCounter] == strDocketNo)
            {
                return strArrWeights[intLoopCounter];
            }
        }

        return "0";
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

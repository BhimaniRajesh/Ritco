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

public partial class GUI_Operations_UpdateDocketArrivalStatus_DisplayDocketsInTHC : System.Web.UI.Page
{
    public static string strTHCNo;
    public static string strVehicleNo;
    public int intTotalRecords;
    //string strMessage;
    public static string strDefArrivalCondition;
    public static string strDefGodown;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strTHCNo = HttpUtility.UrlDecode(Request.QueryString["THCNo"].ToString());
            HidTHCNo.Value = strTHCNo;
            strVehicleNo = HttpUtility.UrlDecode(Request.QueryString["VehicleNo"].ToString());

            getDocumentDetails();

            GetDefaultArrivalCondition();
            GetDefaultGodown();

            populateDeliveryReason("UNDELY", 2);
            //Populate Reasons for Fully Delivered Packages
            populateDeliveryReason("LATE_D", 3);
            //Populate Reasons for Partly Delivered Packages
            //populateReasonPartlyDelivered();
            populateDeliveryReason("PART_D", 1);

            DisplayTHCDetails();

            DisplayDocketsInTHC();
        }

        lblTHCNoCaption.InnerHtml = "<b>" + HidTHC.Value + " No.:</b>";
        lblHeader.InnerHtml = "<b>Update " + HidDocket.Value + " Arrival Status</b>";
        //lblMFNoCaption.InnerHtml = "<b>" + HidMF.Value + " No.:&nbsp;</b>";
        lblListDocketsForArrivalUpdate.InnerHtml = "<b>List of " + HidDocket.Value + "(s) Arrival Update</b>";
        lblDocketCaptionBkgDel.InnerHtml = "<b>" + HidDocket.Value + "<br />Bkg.-Dest.</b>";
        lblNoRecsForDocketList.InnerHtml = "No " + HidDocket.Value + "(s) found for the given criteria";
        lblUpdateStatus.InnerHtml = HidDocket.Value + "(s) Arrival Status Updated";
        lblMoreUpdates.InnerHtml = "<a href=\"UpdateDocketArrivalStatusMain.aspx\"><u>Click Here For Arrival & Update of More " + HidDocket.Value + "(s)</u></a>";

        btnUpdateDocketStatus.ToolTip = "Click here to Update " + HidDocket.Value + " Arrival Status";

        Page.Title = "Display " + HidDocket.Value + "s in " + HidTHC.Value;
    }

    private void GetDefaultArrivalCondition()
    {
        strDefArrivalCondition = "";
        
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            //String strSQL = "Select Top 1 UTY_ID + ':' + UTY_NAME As UTILITY From webx_UTYMAST where left(UTY_ID,1)='C' order by UTY_ID";
            String strSQL = "select CodeId + ' : ' + CodeDesc AS Code from webx_master_general where codetype = 'RECV' and StatusCode = 'Y' ORDER BY CodeId";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsArrivalCondition = new DataSet();

            sqlDA.Fill(dsArrivalCondition);

            if (dsArrivalCondition.Tables[0].Rows.Count > 0)
            {
                strDefArrivalCondition = (dsArrivalCondition.Tables[0].Rows[0]["Code"].ToString().Trim() == "" || dsArrivalCondition.Tables[0].Rows[0]["Code"].ToString().ToUpper() == "NULL" ? "" : dsArrivalCondition.Tables[0].Rows[0]["Code"].ToString());
            }

            sqlConn.Close();
            sqlConn = null;
        }
        catch (Exception Ex)
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void GetDefaultGodown()
    {
        strDefGodown = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            String strSQL = "Select Top 1 cast(godown_srno as varchar) + ':' + godown_name As GODOWN From webx_GODOWNMST Where spdbrcd='" + Session["brcd"].ToString() + "' order by godown_srno";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsGodown = new DataSet();

            sqlDA.Fill(dsGodown);

            if (dsGodown.Tables[0].Rows.Count > 0)
            {
                strDefGodown = (dsGodown.Tables[0].Rows[0]["GODOWN"].ToString().Trim() == "" || dsGodown.Tables[0].Rows[0]["GODOWN"].ToString().ToUpper() == "NULL" ? "" : dsGodown.Tables[0].Rows[0]["GODOWN"].ToString());
            }

            sqlConn.Close();
            sqlConn = null;
        }
        catch (Exception Ex)
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private void DisplayTHCDetails()
    {
        lnlTHCNo.InnerHtml = HidTHCNo.Value;
        lblVehicleNo.InnerHtml = strVehicleNo;
    }

    private void DisplayDocketsInTHC()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            //String strSQL = "Select distinct TCNO, DOCKNO, ORGNCD, DESTCD, LOADPKGSNO, LOADACTUWT, docksf, TOL_FTL, ActArrivalDate, ActArrivalTime, tobh_code, PayBase  From vw_Dockets_For_Arrival WITH(NOLOCK) Where tobh_code='" + Session["brcd"].ToString() + "' and THC_NO in ('" + HidTHCNo.Value.Replace(" ", "").Replace(",", "','") + "') order by TCNO,DockNo";
            String strSQL = "Select distinct TCNO, DOCKNO, ORGNCD, DESTCD, LOADPKGSNO, LOADACTUWT, docksf, TOL_FTL, ActArrivalDate=IsNULL(ActArrivalDate,getdate()), ActArrivalTime=IsNULL(ActArrivalTime,Left(Convert(varchar,getdate(),108),5)), tobh_code, PayBase  From vw_Dockets_For_Arrival WITH(NOLOCK) Where tobh_code='" + Session["brcd"].ToString() + "' and THC_NO in ('" + HidTHCNo.Value.Replace(" ", "").Replace(",", "','") + "') order by TCNO,DockNo";

            

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsDockets = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("MFNoRowVisible", typeof(bool));
            dt.Columns.Add("SrNo", typeof(string));
            dt.Columns.Add("MFNo", typeof(string));
            dt.Columns.Add("DocketNo", typeof(string));
            dt.Columns.Add("DocketSF", typeof(string));
            dt.Columns.Add("OrgnCD", typeof(string));
            dt.Columns.Add("DestinationCD", typeof(string));
            dt.Columns.Add("PackagesLB", typeof(string));
            dt.Columns.Add("WeightLB", typeof(string));
            dt.Columns.Add("DefArrivalCondition", typeof(string));
            dt.Columns.Add("DefGodown", typeof(string));
            dt.Columns.Add("ArrivalGodownJSFunctionCall0", typeof(string));
            dt.Columns.Add("ArrivalGodownJSFunctionCall1", typeof(string));
            dt.Columns.Add("ArrivalGodownJSFunctionCall2", typeof(string));
            dt.Columns.Add("ArrivalGodownJSFunctionCall3", typeof(string));
            dt.Columns.Add("ArrivalGodownJSFunctionCall4", typeof(string));
            dt.Columns.Add("ArrivalGodownJSFunctionCall5", typeof(string));
            dt.Columns.Add("OctroiVisible", typeof(bool));
            dt.Columns.Add("PCVisible", typeof(bool));
            dt.Columns.Add("LoadTypeVisible", typeof(bool));
            dt.Columns.Add("TOL_FTL", typeof(string));
            dt.Columns.Add("ActArrivalDate", typeof(string));
            dt.Columns.Add("ActArrivalTimeHH", typeof(string));
            dt.Columns.Add("ActArrivalTimeMM", typeof(string));
            dt.Columns.Add("PayBase", typeof(string));
            dt.Columns.Add("tdColSpan", typeof(int));
            dt.Columns.Add("DelyDateToday", typeof(string));
            dt.Columns.Add("DelyTimeHHToday", typeof(string));
            dt.Columns.Add("DelyTimeMMToday", typeof(string));
            
            DataRow dr;

            sqlDA.Fill(dsDockets);

            int i = 1;
            string strMFNo = "";

            //trDocketList.Visible = true;
            //trTableHeadersForMF.Visible = true;
            trDocketErrorMsg.Visible = false;

            intTotalRecords = dsDockets.Tables[0].Rows.Count;

            if (dsDockets.Tables[0].Rows.Count > 0)
            {
                trNoRecsForDocketList.Visible = false;
                rptTHCList.Visible = true;
                int j;
                string strPackages = "";
                string strOctroi = "";

                foreach (DataRow drRows in dsDockets.Tables[0].Rows)
                {
                    dr = dt.NewRow();

                    j = i - 1;

                    dr["SrNo"] = i.ToString();
                    i++;

                    dr["MFNoRowVisible"] = (strMFNo != drRows["TCNo"].ToString() ? true : false);
                    dr["MFNo"] = drRows["TCNo"].ToString();
                    dr["DocketNo"] = (drRows["DOCKNO"].ToString().ToUpper() == "NULL" || drRows["DOCKNO"].ToString().Trim() == "" ? "-" : drRows["DOCKNO"].ToString());
                    dr["DocketSF"] = (drRows["docksf"].ToString().ToUpper() == "NULL" || drRows["docksf"].ToString().Trim() == "" ? "-" : drRows["docksf"].ToString());
                    dr["OrgnCD"] = (drRows["ORGNCD"].ToString().ToUpper() == "NULL" || drRows["ORGNCD"].ToString().Trim() == "" ? "-" : drRows["ORGNCD"].ToString());
                    dr["DestinationCD"] = (drRows["DESTCD"].ToString().ToUpper() == "NULL" || drRows["DESTCD"].ToString().Trim() == "" ? "-" : drRows["DESTCD"].ToString());
                    dr["PackagesLB"] = (drRows["LOADPKGSNO"].ToString().ToUpper() == "NULL" || drRows["LOADPKGSNO"].ToString().Trim() == "" ? "0" : drRows["LOADPKGSNO"].ToString());
                    dr["WeightLB"] = (drRows["LOADACTUWT"].ToString().ToUpper() == "NULL" || drRows["LOADACTUWT"].ToString().Trim() == "" ? "0" : drRows["LOADACTUWT"].ToString());
                    dr["DefArrivalCondition"] = strDefArrivalCondition;
                    dr["DefGodown"] = strDefGodown;
                    dr["ArrivalGodownJSFunctionCall0"] = "JavaScript:OpenInNewWindowForArrivalCondition('" + "ctl00_MyCPH1_rptTHCList_ctl" + (j > 9 ? "" : "0") + j.ToString() + "_txtArrivalCondition')";
                    strPackages = "JavaScript:OpenInNewWindowForGodown('" + "ctl00_MyCPH1_rptTHCList_ctl" + (j > 9 ? "" : "0") + j.ToString() + "_txtGodown";
                    dr["ArrivalGodownJSFunctionCall1"] = strPackages + "1')";
                    dr["ArrivalGodownJSFunctionCall2"] = strPackages + "2')";
                    dr["ArrivalGodownJSFunctionCall3"] = strPackages + "3')";
                    dr["ArrivalGodownJSFunctionCall4"] = strPackages + "4')";
                    dr["ArrivalGodownJSFunctionCall5"] = strPackages + "5')";
                    strOctroi = CheckOctroi(drRows["TCNo"].ToString()).ToUpper();
                    dr["OctroiVisible"] = (strOctroi.ToUpper() == "I" ? true : false);
                    dr["PCVisible"] = (strOctroi.ToUpper() == "I" ? true : false);
                    dr["tdColSpan"] = (strOctroi.ToUpper() == "I" && strOctroi.ToUpper() == "I" ? 6 : (strOctroi.ToUpper() != "I" && strOctroi.ToUpper() != "I" ? 4 : 5));
                    dr["LoadTypeVisible"] = (Convert.ToInt32(drRows["TOL_FTL"].ToString()) > 0 && Session["brcd"].ToString() == drRows["DESTCD"].ToString() ? true : false);
                    dr["TOL_FTL"] = drRows["TOL_FTL"].ToString();
                    dr["ActArrivalDate"] =Convert.ToDateTime(drRows["ActArrivalDate"]).ToString("dd/MM/yyyy");
                    string[] strArrTime = drRows["ActArrivalTime"].ToString().Split(':');
                    dr["ActArrivalTimeHH"] = strArrTime[0];
                    dr["ActArrivalTimeMM"] = strArrTime[1];
                    dr["PayBase"] = drRows["PayBase"].ToString();
                    dr["DelyDateToday"] = System.DateTime.Today.ToString("dd/MM/yyyy");
                    dr["DelyTimeHHToday"] = System.DateTime.Now.ToString("HH");
                    dr["DelyTimeMMToday"] = System.DateTime.Now.ToString("mm");

                    strMFNo = drRows["TCNo"].ToString();

                    dt.Rows.Add(dr);
                }

                rptTHCList.DataSource = dt;
                rptTHCList.DataBind();

                trUpdateDocketStatus.Visible = true;
                //HidFinalMFDetails.Value = "";
            }
            else
            {
                trNoRecsForDocketList.Visible = true;
                rptTHCList.Visible = false;
                trUpdateDocketStatus.Visible = false;
            }
        }
        catch (Exception Ex)
        {
            trDocketErrorMsg.Visible = true;
            lblDocketErrorMsg.InnerHtml = "An unknown error has ocurred: " + Ex.Message;
        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }

    private string CheckOctroi(string DestinationCode)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            String strSQL = "Select octroi_io from webx_location WITH(NOLOCK) where loccode='" + DestinationCode + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsOctroi = new DataSet();

            sqlDA.Fill(dsOctroi);

            return (dsOctroi.Tables[0].Rows[0][0].ToString().ToUpper() == "NULL" || dsOctroi.Tables[0].Rows[0][0].ToString().Trim() == "" ? "N" : dsOctroi.Tables[0].Rows[0][0].ToString().ToUpper());
        }
        catch (Exception Ex)
        {
            sqlConn.Close();
            sqlConn = null;

            return "N";
        }
    }

    protected void btnUpdateDocketStatus_Click(object sender, EventArgs e)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand;

        trUpdateDocketStatusErrorMsg.Visible = false;
        trResult.Visible = false;

        try
        {
            //string strUpdate = "Update WEBX_TCHDR WITH (PAGLOCK)  set TCHDRFlag='N' where TCNO in (Select tcno From webx_thctc_pntr  WITH(NOLOCK) where thcno='" + HidTHCNo.Value + "')";
            string strUpdate = "Update WEBX_TCHDR WITH (PAGLOCK) set TCHDRFlag='N' where TCNO in (Select MF From Webx_Trans_Docket_Status WITH(NOLOCK) where THC = '" + HidTHCNo.Value + "')";

            sqlCommand = new SqlCommand(strUpdate, sqlConn);
            
            sqlCommand.ExecuteNonQuery();

            string strArrivedDockets = HidSelectedDockets.Value;
            string[] strArrArrivedDockets = strArrivedDockets.Split('|');

            string strDOCKSF;
            string strORGNCD;
            string strDESTCD;
            string strREASSDESTCD;

            string strDocketNo;
            string strMFNo;
            string strPackages;
            string strWeight;
            string strPackagesDiff;
            string strPCAmt;
            string strDocketSF;
            string strOCAmt;
            string strArrivalCondition;
            int intFTL = 0;
            string strPayBasis = "";
            string strDelyDate = "";
            string strDelyTime = "";
            string strDelyTo = "";
            string strDelyPackages = "";
            string strDelyReason = "";
            
            string strPackages1 = "0";
            string strGodown1 = "";
            string strPackages2 = "0";
            string strGodown2 = "";
            string strPackages3 = "0";
            string strGodown3 = "";
            string strPackages4 = "0";
            string strGodown4= "";
            string strPackages5 = "0";
            string strGodown5 = "";

            int intPackagesIn = 0;
            double dblActualWeightIn = 0;

            string strInsUpdate1;
            string strInsUpdate2;
            string strInsUpdate3;
            string strInsUpdate4;
            
            string strInsPackage1;
            string strInsPackage2;
            string strInsPackage3;
            string strInsPackage4;
            string strInsPackage5;
            string strNotArrivedDockets;

            string strUpdateDocketStatus;
            string strDocketList = "";

            //strMessage = "";
            
            for (int intLoopCounter = 0; intLoopCounter < strArrArrivedDockets.Length; intLoopCounter++)
            {
                string [] strArrDocket = strArrArrivedDockets[intLoopCounter].Split(',');
                strDocketNo = strArrDocket[0].Trim();
                
                strMFNo = strArrDocket[1].Trim();
                strPackages = strArrDocket[2].Trim();
                strWeight = strArrDocket[3].Trim();
                strPackagesDiff = strArrDocket[4].Trim();
                strOCAmt = strArrDocket[7].Trim();
                strPCAmt = strArrDocket[8].Trim();
                strDocketSF = strArrDocket[9].Trim();
                strDelyDate = strArrDocket[10].Trim();
                strDelyTime = strArrDocket[11].Trim() + ":" + strArrDocket[12].Trim();
                strDelyTo = strArrDocket[13].Trim();
                strDelyPackages = strArrDocket[14].Trim();
                strDelyReason = strArrDocket[15].Trim();
                strPayBasis = strArrDocket[16].Trim();

                if (strDelyDate != "")
                {
                    strDocketList = (strDocketList == "" ? strDocketNo + strDocketSF : strDocketList + "," + strDocketNo + strDocketSF);
                }

                string [] strArrArrivalCondition = strArrDocket[5].Trim().Split(':');
                strArrivalCondition = strArrArrivalCondition[0].Trim();

                strPackages1 = "0";
                strGodown1 = "";
                strPackages2 = "0";
                strGodown2 = "";
                strPackages3 = "0";
                strGodown3 = "";
                strPackages4 = "0";
                strGodown4 = "";
                strPackages5 = "0";
                strGodown5 = "";

                string[] strArrPackagesGodownRecordArray = strArrDocket[6].Split('$');

                for (int intLoopCounter1 = 0; intLoopCounter1 < strArrPackagesGodownRecordArray.Length; intLoopCounter1++)
                {
                    string[] strArrPackGodwnRecords = strArrPackagesGodownRecordArray[intLoopCounter1].Trim().Split('~');

                    switch (intLoopCounter1)
                    {
                        case 0:
                            strPackages1 = strArrPackGodwnRecords[0];
                            string [] strArrGodownRecord1 = strArrPackGodwnRecords[1].Trim().Split(':');
                            strGodown1 = strArrGodownRecord1[0].Trim();
                            break;
                        case 1:
                            strPackages2 = strArrPackGodwnRecords[0].Trim();
                            string[] strArrGodownRecord2 = strArrPackGodwnRecords[1].Trim().Split(':');
                            strGodown2 = strArrGodownRecord2[0].Trim();
                            break;
                        case 2:
                            strPackages3 = strArrPackGodwnRecords[0].Trim();
                            string[] strArrGodownRecord3 = strArrPackGodwnRecords[1].Trim().Split(':');
                            strGodown3 = strArrGodownRecord3[0].Trim();
                            break;
                        case 3:
                            strPackages4 = strArrPackGodwnRecords[0].Trim();
                            string[] strArrGodownRecord4 = strArrPackGodwnRecords[1].Trim().Split(':');
                            strGodown4 = strArrGodownRecord4[0].Trim();
                            break;
                        case 4:
                            strPackages5 = strArrPackGodwnRecords[0].Trim();
                            string[] strArrGodownRecord5 = strArrPackGodwnRecords[1].Trim().Split(':');
                            strGodown5 = strArrGodownRecord5[0].Trim();
                            break;
                    }
                }

                string strSQL_SF = "select DOCKSF,orgncd,destcd,REASSIGN_DESTCD from WebX_Master_Docket WITH(NOLOCK) where DOCKNO = '" + strDocketNo + "'";

                sqlCommand = null;

                sqlCommand = new SqlCommand(strSQL_SF, sqlConn);
                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

                DataSet dsDocket = new DataSet();

                sqlDA.Fill(dsDocket);

                strDOCKSF = "";
                strORGNCD = "";
                strREASSDESTCD = "";
                strDESTCD = "";

                if (dsDocket.Tables[0].Rows.Count > 0)
                {
                    strDOCKSF = dsDocket.Tables[0].Rows[0]["DOCKSF"].ToString().Trim();
                    strORGNCD = dsDocket.Tables[0].Rows[0]["orgncd"].ToString().Trim();
                    strDESTCD = dsDocket.Tables[0].Rows[0]["destcd"].ToString().Trim();
                    strREASSDESTCD = dsDocket.Tables[0].Rows[0]["REASSIGN_DESTCD"].ToString().Trim();
                }

                intPackagesIn = Convert.ToInt32(strPackages1) + Convert.ToInt32(strPackages2) + Convert.ToInt32(strPackages3) + Convert.ToInt32(strPackages4) + Convert.ToInt32(strPackages5);
                dblActualWeightIn = Convert.ToDouble(strWeight);

                //Update Record for Docket No. in WebX_Trans_Docket_Status Table

                strUpdateDocketStatus = "UPDATE Webx_Trans_Docket_Status SET Op_Status = '" + (strDelyDate == "" ? "AT " + Session["brcd"].ToString() : "DELIVERED") + "', " + 
                                        "ArrPkgQty = " + intPackagesIn.ToString() + ", ArrWeightQty= " + dblActualWeightIn.ToString() + 
                                        ", DelPkgQty = 0, DelWeightQty = 0, PendPkgQty = " + intPackagesIn.ToString() +
                                        ", PendWeightQty = " + dblActualWeightIn.ToString() + ", LS = NULL, MF = NULL, THC = NULL, Curr_Loc = '" + 
                                        Session["brcd"].ToString() + "', NextLoc = (select top 1 DESTCD from webx_master_docket " + 
                                        "WHERE DockNo + DockSF = '" + strDocketNo + strDocketSF + "') WHERE DockNo + DockSF = '" + strDocketNo + strDocketSF + "'";

                sqlCommand = null;

                sqlCommand = new SqlCommand(strUpdateDocketStatus, sqlConn);

                sqlCommand.ExecuteNonQuery();

                //Insert Record for Docket No. in WebX_Trans_Docket_Track Table

                strInsUpdate1 = "INSERT INTO WebX_Trans_Docket_Track(SrNo, Dockno, DockSF, CurLoc, In_Out, Packages, Weight, ATAD, NextLoc, UpdtBy, UpdtOn, " +
                                "Pkgs1, Godown1, Pkgs2, Godown2, Pkgs3, Godown3, Pkgs4, Godown4, Pkgs5, Godown5) " +
                                " SELECT TOP 1 (SELECT [dbo].[GetNextSrNo] (WTDT.DockNo)) AS SrNo, WTDT.DockNo, WTDT.DockSF, '" + Session["brcd"].ToString() + "', " +
                                "'I', WTDT.Packages, WTDT.Weight, GetDate(), WTDS.NextLoc, '" + Session["empcd"].ToString() + "', GetDate(), " +  
                                strPackages1 + ", '" + strGodown1 + "', " + strPackages2 + ", '" + strGodown2 + "', " + strPackages3 + ", '" + 
                                strGodown3 + "', " + strPackages4 + ", '" + strGodown4 + "', " + strPackages5 + ", '" + strGodown5 + "' " + 
                                "FROM " + 
                                "WebX_Trans_Docket_Track WTDT INNER JOIN WebX_Trans_Docket_Status WTDS ON WTDS.DockNo + WTDS.DockSF = " +
                                "WTDT.DockNo + WTDT.DockSF WHERE WTDS.DOCKNO + WTDS.DOCKSF = '" + strDocketNo + ".'";

                sqlCommand = null;

                sqlCommand = new SqlCommand(strInsUpdate1, sqlConn);

                sqlCommand.ExecuteNonQuery();

                strInsUpdate3 = "Update webx_tctrn  WITH (PAGLOCK) set RECVDPKGSNO=" + intPackagesIn.ToString() + ",arrived_yn='Y' where TCNO='" + strMFNo + "' and DOCKNO='" + strDocketNo + "' AND DOCKSF='" + strDocketSF + "'";
                sqlCommand = null;

                sqlCommand = new SqlCommand(strInsUpdate3, sqlConn);

                sqlCommand.ExecuteNonQuery();
            }

            ////Generate DRS
            //sqlCommand = null;
            
            //sqlCommand = new SqlCommand();
            //sqlCommand.Connection = sqlConn;
            //sqlCommand.CommandType = CommandType.StoredProcedure;
            //sqlCommand.CommandText = "usp_drs_generate";

            //sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
            //sqlCommand.Parameters.AddWithValue("@manpdcno", "");
            //sqlCommand.Parameters.AddWithValue("@pdcdt", System.DateTime.Today.ToString("dd MMM yy"));
            //sqlCommand.Parameters.AddWithValue("@pdctype", "D");
            //sqlCommand.Parameters.AddWithValue("@bacode", "");
            //sqlCommand.Parameters.AddWithValue("@vendorcode", "");
            //sqlCommand.Parameters.AddWithValue("@vendorname", "");
            //sqlCommand.Parameters.AddWithValue("@marketveh", "N");
            //sqlCommand.Parameters.AddWithValue("@vehicleno", "");
            //sqlCommand.Parameters.AddWithValue("@vehicletype", "");
            //sqlCommand.Parameters.AddWithValue("@drivername", "");
            //sqlCommand.Parameters.AddWithValue("@startkm", "0");
            //sqlCommand.Parameters.AddWithValue("@endkm", "0");
            //sqlCommand.Parameters.AddWithValue("@staff", "");
            //sqlCommand.Parameters.AddWithValue("@empcd", Session["empcd"].ToString());
            //sqlCommand.Parameters.AddWithValue("@docketlist", strDocketList);
            //sqlCommand.Parameters.AddWithValue("@TotalDockets", strDocketList.Length);
            //sqlCommand.Parameters.AddWithValue("@FinYear", Session["FinYear"].ToString());

            ////sqlCommand.ExecuteNonQuery();

            //SqlDataAdapter sqlDADRS = new SqlDataAdapter(sqlCommand);

            //DataSet dsGenerateDRS = new DataSet();

            //sqlDADRS.Fill(dsGenerateDRS);

            //string strNextDRSCode = "";

            //if (dsGenerateDRS.Tables[0].Rows.Count > 0)
            //{
            //    strNextDRSCode = dsGenerateDRS.Tables[0].Rows[0]["PDCNo"].ToString();
            //}

            ////Update DRS for FTL Type of Load related dockets

            //for (int intLoopCounter = 0; intLoopCounter < strArrArrivedDockets.Length; intLoopCounter++)
            //{
            //    string[] strArrDocket = strArrArrivedDockets[intLoopCounter].Split(',');
            //    strDocketNo = strArrDocket[0].Trim();
            //    strMFNo = strArrDocket[1].Trim();
            //    strPackages = strArrDocket[2].Trim();
            //    strWeight = strArrDocket[3].Trim();
            //    strPackagesDiff = strArrDocket[4].Trim();
            //    strOCAmt = strArrDocket[7].Trim();
            //    strPCAmt = strArrDocket[8].Trim();
            //    strDocketSF = strArrDocket[9].Trim();
            //    strDelyDate = strArrDocket[10].Trim();
            //    strDelyTime = strArrDocket[11].Trim() + ":" + strArrDocket[12].Trim();
            //    strDelyTo = strArrDocket[13].Trim();
            //    strDelyPackages = strArrDocket[14].Trim();
            //    strDelyReason = strArrDocket[15].Trim();
            //    strPayBasis = strArrDocket[16].Trim();

            //    if (strDelyDate != "")
            //    {
            //        sqlCommand = null;
                    
            //        sqlCommand = new SqlCommand();
            //        sqlCommand.Connection = sqlConn;
            //        sqlCommand.CommandType = CommandType.StoredProcedure;
            //        sqlCommand.CommandText = "usp_drs_update";

            //        sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
            //        sqlCommand.Parameters.AddWithValue("@pdcno", strNextDRSCode);
            //        sqlCommand.Parameters.AddWithValue("@dockno", strDocketNo + strDocketSF);
            //        sqlCommand.Parameters.AddWithValue("@pkgswaspending", "0");
            //        sqlCommand.Parameters.AddWithValue("@pkgsdelivered", strDelyPackages);
            //        sqlCommand.Parameters.AddWithValue("@delydt", getDateInddMMMyyyFormat(strDelyDate) + " " + strDelyTime);
            //        sqlCommand.Parameters.AddWithValue("@reason", strDelyReason);
            //        sqlCommand.Parameters.AddWithValue("@recd_person", strDelyTo);
            //        sqlCommand.Parameters.AddWithValue("@MarketVeh", "");
            //        sqlCommand.Parameters.AddWithValue("@CODAmount", "0");
            //        sqlCommand.Parameters.AddWithValue("@CODCollected", "0");
            //        sqlCommand.Parameters.AddWithValue("@CODNo", "");
            //        sqlCommand.Parameters.AddWithValue("@closekm", "0");
            //        sqlCommand.Parameters.AddWithValue("@empcd", Session["empcd"].ToString());

            //        sqlCommand.ExecuteNonQuery();
            //    }
            //}

            //Manage Not Arrived Dockets
            if (HidNotSelectedDockets.Value != "")
            {
                string [] strArrNotArrivedDockets = HidNotSelectedDockets.Value.Split('|');

                for (int intLoopCounter = 0; intLoopCounter < strArrNotArrivedDockets.Length; intLoopCounter++)
                {
                    string[] strArrDockets = strArrNotArrivedDockets[intLoopCounter].Split(',');

                    strNotArrivedDockets = "Update webx_tctrn  WITH(ROWLOCK) set arrived_yn='N' where TCNO='" + strArrDockets[1] + "' and DOCKNO='" + strArrDockets[0] + "' and docksf='" + strArrDockets[2] + "'";
                    sqlCommand = null;

                    sqlCommand = new SqlCommand(strNotArrivedDockets, sqlConn);

                    sqlCommand.ExecuteNonQuery();
                }
            }

            trDocketList.Visible = false;

            trResult.Visible = true;
        }
        catch (Exception Ex)
        {
            trUpdateDocketStatusErrorMsg.Visible = true;
            lblUpdateDocketStatusErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;

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

    //protected void txtDelyTo_TextChanged(object sender, EventArgs e)
    //{
    //    //Check for Next Location
    //    txtDelyTo.Text = txtDelyTo.Text.Trim().ToUpper();

    //    if (txtDelyTo.Text == "")
    //    {
    //        lblErrorDelyTo.Visible = false;
    //        return;
    //    }

    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    String strSQLPrepBy = "select UserId from webx_master_users WHERE UserId = '" + txtDelyTo.Text + "' AND BranchCode = '" + Session["brcd"].ToString() + "'";

    //    SqlCommand sqlCommand = new SqlCommand(strSQLPrepBy, sqlConn);
    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsPrepBy = new DataSet();

    //    sqlDA.Fill(dsPrepBy);

    //    lblErrorPrepBy.Visible = (dsPrepBy.Tables[0].Rows.Count > 0 ? false : true);

    //    if (lblErrorPrepBy.Visible == true)
    //    {
    //        txtPrepBy.Focus();
    //    }

    //    sqlConn.Close();
    //}

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
}

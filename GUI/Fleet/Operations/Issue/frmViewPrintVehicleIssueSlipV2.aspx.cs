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

public partial class Issue_frmViewPrintVehicleIssueSlipV2 : System.Web.UI.Page
{
    static string str_Connection_String = "";
    Double AmtSpent = 0, AmtApproved = 0;
    Double TotAmtSpent = 0, TotAmtApproved = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            str_Connection_String = Session["SqlProvider"].ToString().Trim();

            if (Request.QueryString["PrintMode"] != null)
            {
                if (Request.QueryString["PrintMode"].ToString() == "0")
                {
                    rEntryBy.Visible = true;
                }
                else if (Request.QueryString["PrintMode"].ToString() == "1")
                {
                    rEntryBy.Visible = false;
                }
            }
            string logo = Session["logofile"].ToString();
            imgLogo.ImageUrl = "~/GUI/images/" + logo;
            imgLogo1.ImageUrl = "~/GUI/images/" + logo;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string strTripSheetNo = "";
            string strExternalUsage_Category = "";
            if (Request.QueryString["VSlipNo"] != null)
            {
                strTripSheetNo = Request.QueryString["VSlipNo"].ToString();
                conn.Open();
                string sql = "usp_TripSheetView";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TRIPSHEET_NO", strTripSheetNo);
                cmd.Parameters.AddWithValue("@EXPTYPE", "TRIPSHEET");
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    lblControllingBranch.Text = dr["Branch"].ToString();
                    lblManualTripsheet.Text = dr["Manual_TripSheetNo"].ToString();
                    lblTripsheetNo.Text = dr["VSlipNo"].ToString();
                    lblTripSheetStatus.Text = dr["Cancel_Status"].ToString();
                    if (lblTripSheetStatus.Text == "Y")
                    {
                        lblTripSheetStatus.Text = "[Cancelled]";
                        lblTripSheetStatus.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        lblTripSheetStatus.Text = "";
                    }
                    lblStartDate.Text = dr["sDT"].ToString();
                    lblEndDate.Text = dr["eDT"].ToString();
                    lblTripStartKM.Text = dr["Start_km"].ToString();
                    lblTripEndKM.Text = dr["f_closure_closekm"].ToString();
                    if (lblTripEndKM.Text != "" && lblTripStartKM.Text != "")
                    {
                        lblTotTripKM.Text = Convert.ToString(System.Math.Round(Convert.ToDecimal(Convert.ToDouble(lblTripEndKM.Text) - Convert.ToDouble(lblTripStartKM.Text)),2));
                    }
                    lblVehno.Text = dr["VehicleNo"].ToString();
                    lblDriverNm.Text = dr["driver_name"].ToString();
                    lblDriverLicValidity.Text = dr["valdity_dt"].ToString();
                    lblDriverLicNo.Text = dr["License_no"].ToString();
                    lblVehType.Text = dr["VEH_TYPE"].ToString();
                    lblVehCapacity.Text = dr["Capacity"].ToString();
                    lblRouteKM.Text = dr["f_closure_fill"].ToString();
                    lblRouteKM.Text = "";

                    lblControllingBranch1.Text = dr["Branch"].ToString();
                    lblManualTripsheet1.Text = dr["Manual_TripSheetNo"].ToString();
                    lblTripsheetNo1.Text = dr["VSlipNo"].ToString();
                    lblStartDate1.Text = dr["sDT"].ToString();
                    lblEndDate1.Text = dr["eDT"].ToString();
                    lblTripStartKM1.Text = dr["Start_km"].ToString();
                    lblTripEndKM1.Text = dr["f_closure_closekm"].ToString();
                    if (lblTripEndKM1.Text != "" && lblTripStartKM.Text != "")
                    {
                        lblTotTripKM1.Text = Convert.ToString(System.Math.Round(Convert.ToDecimal(Convert.ToDouble(lblTripEndKM.Text) - Convert.ToDouble(lblTripStartKM.Text)), 2));
                    }
                    lblVehno1.Text = dr["VehicleNo"].ToString();


                    lblCategory.Text = dr["Category"].ToString();
                    lblExternalUsageCategory.Text = dr["ExternalUsage_Category"].ToString();
                    lblcustname.Text = dr["CustName1"].ToString();

                    //lblDriverNm1.Text = dr["driver_name"].ToString();
                    //lblDriverLicValidity1.Text = dr["valdity_dt"].ToString();
                    //lblDriverLicNo1.Text = dr["License_no"].ToString();

                    lblDriverNm1.Text = dr["driver_name"].ToString();
                    lblDriverLicValidity1.Text = dr["valdity_dt"].ToString();
                    lblDriverLicNo1.Text = dr["License_no"].ToString();

                    lblDriverNm2.Text = dr["driver_name2"].ToString();
                    lblDriverLicValidity2.Text = dr["valdity_dt2"].ToString();
                    lblDriverLicNo2.Text = dr["License_no2"].ToString();

                    lblTripStartLoc.Text = dr["tripsheet_startloc"].ToString();
                    lblTripEndLoc.Text = dr["TripSheet_EndLoc"].ToString();
                    lblTripFromCity.Text = dr["From_City"].ToString();
                    lblTripToCity.Text = dr["To_City"].ToString();

                    lblVehType1.Text = dr["VEH_TYPE"].ToString();
                    lblVehCapacity1.Text = dr["Capacity"].ToString();
                    if (dr["RUTDESC"].ToString() != "")
                    {
                        lblRoute.Text = dr["RUTDESC"].ToString() ;
                        lblRoute1.Text = dr["RUTDESC"].ToString();
                    }
                    else
                    {
                        lblRoute.Text = dr["Route"].ToString();
                        lblRoute1.Text = dr["Route"].ToString();
                    }
                    lblRouteKM1.Text = "";
                    strExternalUsage_Category = dr["ExternalUsage_Category"].ToString();
                    lblVehicleMode.Text = dr["Vehicle_Mode"].ToString();
                    lblDocketLab.Text = dr["Docket_no_Label"].ToString();
                    lblDockets.Text = dr["Dockno"].ToString();
                }

                
                conn.Close();

                if (strExternalUsage_Category == "Milk Run")
                {
                    gvVehicleLogEntry.Visible = true;
                    VehicleLogEntryDetails(strTripSheetNo);
                }

                TripSheet objTripSheet = new TripSheet(str_Connection_String);
                objTripSheet.CheckTripRule();
                if (objTripSheet.Checklist == "Y")
                {
                    //DataTable dt = new DataTable();
                    //dt = objTripSheet.GetChecklist_TripDetail(strTripSheetNo);
                    //if (dt.Rows.Count > 0)
                    //{
                        gvChecklist.Visible = true;
                        table111.Visible = true;
                        ChecklistDetails(strTripSheetNo);
                        ChecklistHDR(strTripSheetNo);
                    //}
                    //else
                    //{
                    //    gvChecklist.Visible = false;
                    //    table111.Visible = false;
                    //}
                }

                CnoteDetails(strTripSheetNo);
                
                //FUEL EXPENSE
                BindGrid("FUELEXP", strTripSheetNo,gvFuelExp);
                //ADVANCE PAID TO DRIVER
                BindGrid("ADVPAID", strTripSheetNo,gvAdvPaid);
                //JOURNET DETAILS
                BindGrid("JOURNEYDET", strTripSheetNo, gvJourneyDet);
                //EXPENSE DETAILS
                BindGrid("EXPDETAILS", strTripSheetNo, gvExpDetails);   
                //DRIVER SETTLEMENT
                //BindGrid("VehicleLogEntry_Summary", strTripSheetNo, gvVehLogEntryDet);
                //External THC Details
                BindGrid("ETD", strTripSheetNo, gvETD);   
                conn.Open();
                SqlCommand cmdDR = new SqlCommand(sql, conn);
                cmdDR.CommandType = CommandType.StoredProcedure;
                cmdDR.Parameters.AddWithValue("@TRIPSHEET_NO", strTripSheetNo);
                cmdDR.Parameters.AddWithValue("@EXPTYPE", "DRIVERSETTLEMENT");
                SqlDataReader drDR = cmdDR.ExecuteReader();

                while (drDR.Read())
                {
                    lblAdvPaid.Text = drDR["TOTADVPAID"].ToString();
                    //commented by anupam
                    //txtTotExp.Text = drDR["TOTEXPENSE"].ToString();
                    //commented by anupam End
                    //lblEnrouteExp.Text = drDR["TOTEXPENSE"].ToString();
                    //lblEnrouteExp.Text = TotAmtApproved.ToString();
                    lblEnrouteExp.Text = TotAmtSpent.ToString();
                    //commented by anupam
                    //if (drDR["Card_Cash"].ToString() != "Diesel Card")
                    //{
                    //    lblFuelExp.Text = drDR["EXE_AMT"].ToString();
                    //}
                    //else
                    //{
                    //    lblFuelExp.Text = "0";
                    //}
                    //commented by anupam End
                    //added by anupam 
                    if (drDR["Card_Cash"].ToString() != "Diesel Card" && drDR["Card_Cash"].ToString() != "Credit")
                    {
                        decimal asd, asd1;
                        if (drDR["EXE_AMT"].ToString() == "")
                        {
                            asd = 0;
                        }
                        else
                        {
                            asd = Convert.ToDecimal(drDR["EXE_AMT"].ToString());
                        }
                        if (lblFuelExp.Text == "")
                        {
                            lblFuelExp.Text = "0";
                        }
                        asd1 = (Convert.ToDecimal(lblFuelExp.Text) + asd);
                        lblFuelExp.Text = Convert.ToString(asd1);

                    }
                    else
                    {
                        if (lblFuelExp.Text != "0")
                        {

                        }
                        else
                        {
                            lblFuelExp.Text = "0";
                        }
                    }
                    //added by anupam end
                    //if (drDR["AmtPaidToDriver"].ToString() == "0")
                    //{
                    //    Label1.Font.Bold = true;
                    //    lblNetPayRec.Text = drDR["AmtRecvdFromDriver"].ToString();
                    //}
                    //if (drDR["AmtRecvdFromDriver"].ToString() == "0")
                    //{
                    //    Label2.Font.Bold = true;
                    //    lblNetPayRec.Text = drDR["AmtPaidToDriver"].ToString();
                    //}
                    if (drDR["AmtPaidToDriver"].ToString() != "0")
                    {
                        Label1.Font.Bold = true;
                        lblNetPayRec.Text = drDR["AmtPaidToDriver"].ToString();
                    }
                    if (drDR["AmtRecvdFromDriver"].ToString() != "0")
                    {
                        Label2.Font.Bold = true;
                        lblNetPayRec.Text = drDR["AmtRecvdFromDriver"].ToString();
                    }
                    //added by anupam 
                    decimal TotExp;
                    if (lblFuelExp.Text == "")
                    {
                        lblFuelExp.Text = "0";
                    }
                    TotExp = (Convert.ToDecimal(lblFuelExp.Text) + Convert.ToDecimal(TotAmtSpent.ToString()));
                    txtTotExp.Text = Convert.ToString(TotExp);
                    //added by anupam end

                }
                conn.Close();
                //KMPL DETAILS
                conn.Open();
                SqlCommand cmdkmpl = new SqlCommand(sql, conn);
                cmdkmpl.CommandType = CommandType.StoredProcedure;
                cmdkmpl.Parameters.AddWithValue("@TRIPSHEET_NO", strTripSheetNo);
                cmdkmpl.Parameters.AddWithValue("@EXPTYPE", "KMPLDET");
                SqlDataReader drkmpl = cmdkmpl.ExecuteReader();
                while (drkmpl.Read())
                {
                    lblKMPLActual.Text =  drkmpl["Actual_KMPL"].ToString();
                    lblActualKMPL.Text = drkmpl["Actual_KMPL"].ToString();

                    lblApprovedKMPL.Text = drkmpl["Approved_KMPL"].ToString();
                    lblKMPLApproved.Text = drkmpl["Approved_KMPL"].ToString();

                    if (lblKMPLActual.Text != "" && lblKMPLApproved.Text != "")
                    {
                        lblKMPLVariance.Text = Convert.ToString(System.Math.Round(Convert.ToDecimal(Convert.ToDouble(lblKMPLActual.Text) - Convert.ToDouble(lblKMPLApproved.Text)),2));
                        lblVarianceKMPL.Text = Convert.ToString(Convert.ToDouble(lblKMPLActual.Text) - Convert.ToDouble(lblKMPLApproved.Text));
                    }
                    lblEntryby.Text = drkmpl["entryby"].ToString();
                    lblEntryDt.Text = drkmpl["Entrydt"].ToString();
                }
                conn.Close();

                //DIESEL EXPENSE DETAILS
                conn.Open();
                SqlCommand cmdDies = new SqlCommand(sql, conn);
                cmdDies.CommandType = CommandType.StoredProcedure;
                cmdDies.Parameters.AddWithValue("@TRIPSHEET_NO", strTripSheetNo);
                cmdDies.Parameters.AddWithValue("@EXPTYPE", "DIESELEXPDET");
                SqlDataReader drDise = cmdDies.ExecuteReader();
                while (drDise.Read())
                {
                    lblDleselQty.Text = drDise["Diesel_Ltr"].ToString();
                    lblDieselExp.Text = drDise["Exe_Amt"].ToString();
                    //lblDleselQty.Text = "";
                    //lblDieselExp.Text = "";
                }
                conn.Close();

                //RouteKMRun
                conn.Open();
                SqlCommand cmdRouteKMRun = new SqlCommand(sql, conn);
                cmdRouteKMRun.CommandType = CommandType.StoredProcedure;
                cmdRouteKMRun.Parameters.AddWithValue("@TRIPSHEET_NO", strTripSheetNo);
                cmdRouteKMRun.Parameters.AddWithValue("@EXPTYPE", "RouteKMRun");
                SqlDataReader drRouteKMRun = cmdRouteKMRun.ExecuteReader();
                while (drRouteKMRun.Read())
                {
                    lblRouteApprovedKM.Text = drRouteKMRun["RUTKM"].ToString();
                    lblActualKM.Text = drRouteKMRun["ACTUALKM"].ToString();
                    lblVarianceKM.Text = drRouteKMRun["VARIANCEKM"].ToString();
                }
                conn.Close();
            }
            
        }
    }
    public void BindGrid(string strExpType,string strTripsheetNo,GridView gv)
    {
        string sql = "usp_TripSheetView";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@TRIPSHEET_NO", strTripsheetNo);
        cmd.Parameters.AddWithValue("@EXPTYPE", strExpType);

        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables.Count > 0 )
        {
            gv.DataSource = ds;
            gv.DataBind();
        }
        conn.Close();
        
    }
    protected void gvExpDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl_Polarity = (Label)e.Row.FindControl("lbl_Polarity"); 
            if (e.Row.Cells[4].Text.Trim() != "")
            {
                AmtSpent = Convert.ToDouble(e.Row.Cells[4].Text.Trim());
            }
            if (e.Row.Cells[5].Text.Trim() != "")
            {
                AmtApproved = Convert.ToDouble(e.Row.Cells[5].Text.Trim());
            }
            if (lbl_Polarity.Text.Trim() == "+")
            {
                TotAmtSpent = TotAmtSpent + AmtSpent;
                TotAmtApproved = TotAmtApproved + AmtApproved;
            }
            else if (lbl_Polarity.Text.Trim() == "-")
            {
                TotAmtSpent = TotAmtSpent - AmtSpent;
                TotAmtApproved = TotAmtApproved - AmtApproved;
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "Total Expense (Enroute)";//"<b>Total</b>";
            e.Row.Cells[0].Font.Bold = true;
            e.Row.Cells[4].Font.Bold = true;
            e.Row.Cells[4].Text = (TotAmtSpent).ToString();
            e.Row.Cells[5].Font.Bold = true;
            e.Row.Cells[5].Text = (TotAmtApproved).ToString();
        }
    }


    public void VehicleLogEntryDetails(string mTripSheetNo)
    {
        LblJourney_Log.Text = "VEHICLE LOG DETAILS";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand("usp_ViewVehicleLogEntry_Summary", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
        DataSet ds = new DataSet();


        da.Fill(ds);


        gvVehicleLogEntry.DataSource = ds;
        gvVehicleLogEntry.DataBind();

        conn.Close();

        //   Session["VSlipNo"] = null;

    }
    public void CnoteDetails(string mTripSheetNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand cmd = new SqlCommand("USP_FLEET_VIEW_CNOTE_TRIPSHEET", conn);

        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
        DataSet ds = new DataSet();

        da.Fill(ds);

        gvCnote.DataSource = ds;
        gvCnote.DataBind();

        conn.Close();

    }

    public void ChecklistDetails(string mTripSheetNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand cmd = new SqlCommand("USP_FLEET_VIEW_CHECKLIST", conn);

        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
        DataSet ds = new DataSet();

        da.Fill(ds);

        gvChecklist.DataSource = ds;
        gvChecklist.DataBind();

        conn.Close();

    }

    public void ChecklistHDR(string mTripSheetNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sqlstrCheck = "select Checked_By,Convert(varchar,Checked_Dt,113) as Checked_Date,Approved_By,Convert(varchar,Approved_Dt,113) as Approved_Date from WEBX_FLEET_CHECKLIST_HDR where TripSheetNo='" + mTripSheetNo + "'";
        SqlCommand cmdCheckHDR = new SqlCommand(sqlstrCheck, conn);
        cmdCheckHDR.CommandType = CommandType.Text;
        SqlDataReader drCheck = cmdCheckHDR.ExecuteReader();
        if (drCheck.HasRows)
        {
            while (drCheck.Read())
            {
                lblCheckedByChecklist.Text = drCheck["Checked_By"].ToString();
                lblCheckedDate.Text = drCheck["Checked_Date"].ToString();
                lblApprovedByChecklist.Text = drCheck["Approved_By"].ToString();
                lblApprovedDate.Text = drCheck["Approved_Date"].ToString();

            }
        }
        drCheck.Close();
        conn.Close();

    }
    
}

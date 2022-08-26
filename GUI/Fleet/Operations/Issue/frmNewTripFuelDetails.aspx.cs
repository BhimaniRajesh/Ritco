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
using ApplicationManager;

public partial class GUI_Fleet_Operations_Issue_frmNewTripFuelDetails : System.Web.UI.Page
{
    static string str_Connection_String = "";

    string stVSlipId = "", stStartKM = "";
    SqlConnection conn;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Session["SqlProvider"] != null)
                {
                    str_Connection_String = Session["SqlProvider"].ToString();
                    conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    conn.Open();
                }
                else
                {
                    Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
                }
            }
            catch (Exception Ex)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
            }

            stVSlipId = Request.QueryString["ID"];
            stStartKM = Request.QueryString["StartKM"];


            Session["Tripsheet"] = stVSlipId;

            TripSheet objTs = new TripSheet(str_Connection_String);

            DataTable dtKM = new DataTable();
            dtKM = objTs.ExecuteSql("  select top 1 End_KM_Read from WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where Tripsheetno='" + Request.QueryString["ID"] + "' order by End_KM_Read desc ");

            if (dtKM.Rows.Count > 0)
            {
                hdnLastKM.Value = dtKM.Rows[0]["End_KM_Read"].ToString();
            }


            BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor1);
            BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor2);
            BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor3);
            BindDropDown("USP_NEW_TRIP_BIND_CUSTOMER", "VENDORNAME", "VENDORCODE", ddlVendor4);

            //objTs.BindDropDown(ddlVendor1, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");
            //objTs.BindDropDown(ddlVendor2, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");
            //objTs.BindDropDown(ddlVendor3, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");
            //objTs.BindDropDown(ddlVendor4, "select distinct VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME");

            txtLastKM1.Text = stStartKM;

            txtCurrentKM1.Attributes.Add("OnBlur", "return CheckCurrentKM1(" + txtCurrentKM1.ClientID.ToString().Trim() + "," + txtLastKM1.ClientID.ToString().Trim() + ")");
            txtCurrentKM2.Attributes.Add("OnBlur", "return CheckCurrentKM2(" + txtCurrentKM2.ClientID.ToString().Trim() + "," + txtLastKM2.ClientID.ToString().Trim() + ")");
            txtCurrentKM3.Attributes.Add("OnBlur", "return CheckCurrentKM3(" + txtCurrentKM3.ClientID.ToString().Trim() + "," + txtLastKM3.ClientID.ToString().Trim() + ")");
            txtCurrentKM4.Attributes.Add("OnBlur", "return CheckCurrentKM4(" + txtCurrentKM4.ClientID.ToString().Trim() + "," + txtLastKM4.ClientID.ToString().Trim() + ")");

            txtDieselQty1.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
            txtDieselQty2.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
            txtDieselQty3.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
            txtDieselQty4.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");

            txtDieselRate1.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
            txtDieselRate2.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
            txtDieselRate3.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");
            txtDieselRate4.Attributes.Add("OnBlur", "javascript:CalculateDieselAmount()");

            txtDate1.Attributes.Add("OnBlur", "javascript:CheckDate()");
            txtDate2.Attributes.Add("OnBlur", "javascript:CheckDate()");
            txtDate3.Attributes.Add("OnBlur", "javascript:CheckDate()");
            txtDate4.Attributes.Add("OnBlur", "javascript:CheckDate()");

            Previous_FuelExpense();

        }
    }

    public void Previous_FuelExpense()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        //string str = "Select TripSheetNo,Place,KM_Reading,BillNo,BillDt,Diesel_Ltr,Amount,Last_Km_Read,Difference_KM,Card_Cash,Diesel_Rate,PetrolPName,EXE_AMT,EntryDate,RefNo,KMPL,COMPANY_CODE from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo = '" + Request.QueryString["ID"] + "'";

        DataTable dtVI = new DataTable();
        dtVI = objTripSheet.ExecuteSql("Select TripSheetNo,Place,KM_Reading,BillNo,Convert(varchar,BillDt,103) as BillDt,Diesel_Ltr,Amount,Last_Km_Read,Difference_KM,Card_Cash,Diesel_Rate,PetrolPName,EXE_AMT,EntryDate,RefNo,KMPL,COMPANY_CODE from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo = '" + Request.QueryString["ID"] + "'");

        int record_Count = 0;

        if (dtVI.Rows.Count > 0)
        {
            foreach (DataRow dr in dtVI.Rows)
            {
                record_Count = record_Count + 1;
                if (record_Count == 1)
                {
                    txtPlace1.Text = Convert.ToString(dr["Place"]);
                    txtCurrentKM1.Text = Convert.ToString(dr["KM_Reading"]);
                    txtLastKM2.Text = Convert.ToString(dr["KM_Reading"]);
                    txtBillNo1.Text = Convert.ToString(dr["BillNo"]);
                    txtDate1.Text = Convert.ToString(dr["BillDt"]);
                    txtDieselQty1.Text = Convert.ToString(dr["Diesel_Ltr"]);
                    txtAmount1.Text = Convert.ToString(dr["Amount"]);
                    txtLastKM1.Text = Convert.ToString(dr["Last_Km_Read"]);
                    txtDifference1.Text = Convert.ToString(dr["Difference_KM"]);
                    ddlPayment1.SelectedValue = Convert.ToString(dr["Card_Cash"]);
                    txtDieselRate1.Text = Convert.ToString(dr["Diesel_Rate"]);
                    ddlVendor1.SelectedValue = Convert.ToString(dr["PetrolPName"]);
                    txtApprvdAmt1.Text = Convert.ToString(dr["EXE_AMT"]);
                    txtRefNo1.Text = Convert.ToString(dr["RefNo"]);
                    txtKMPL1.Text = Convert.ToString(dr["KMPL"]);
                }
                if (record_Count == 2)
                {
                    txtPlace2.Text = Convert.ToString(dr["Place"]);
                    txtCurrentKM2.Text = Convert.ToString(dr["KM_Reading"]);
                    txtLastKM3.Text = Convert.ToString(dr["KM_Reading"]);
                    txtBillNo2.Text = Convert.ToString(dr["BillNo"]);
                    txtDate2.Text = Convert.ToString(dr["BillDt"]);
                    txtDieselQty2.Text = Convert.ToString(dr["Diesel_Ltr"]);
                    txtAmount2.Text = Convert.ToString(dr["Amount"]);
                    txtLastKM2.Text = Convert.ToString(dr["Last_Km_Read"]);
                    txtDifference2.Text = Convert.ToString(dr["Difference_KM"]);
                    ddlPayment2.SelectedValue = Convert.ToString(dr["Card_Cash"]);
                    txtDieselRate2.Text = Convert.ToString(dr["Diesel_Rate"]);
                    ddlVendor2.SelectedValue = Convert.ToString(dr["PetrolPName"]);
                    txtApprvdAmt2.Text = Convert.ToString(dr["EXE_AMT"]);
                    txtRefNo2.Text = Convert.ToString(dr["RefNo"]);
                    txtKMPL2.Text = Convert.ToString(dr["KMPL"]);
                }
                if (record_Count == 3)
                {
                    txtPlace3.Text = Convert.ToString(dr["Place"]);
                    txtCurrentKM3.Text = Convert.ToString(dr["KM_Reading"]);
                    txtLastKM4.Text = Convert.ToString(dr["KM_Reading"]);
                    txtBillNo3.Text = Convert.ToString(dr["BillNo"]);
                    txtDate3.Text = Convert.ToString(dr["BillDt"]);
                    txtDieselQty3.Text = Convert.ToString(dr["Diesel_Ltr"]);
                    txtAmount3.Text = Convert.ToString(dr["Amount"]);
                    txtLastKM3.Text = Convert.ToString(dr["Last_Km_Read"]);
                    txtDifference3.Text = Convert.ToString(dr["Difference_KM"]);
                    ddlPayment3.SelectedValue = Convert.ToString(dr["Card_Cash"]);
                    txtDieselRate3.Text = Convert.ToString(dr["Diesel_Rate"]);
                    ddlVendor3.SelectedValue = Convert.ToString(dr["PetrolPName"]);
                    txtApprvdAmt3.Text = Convert.ToString(dr["EXE_AMT"]);
                    txtRefNo3.Text = Convert.ToString(dr["RefNo"]);
                    txtKMPL3.Text = Convert.ToString(dr["KMPL"]);
                }
                if (record_Count == 4)
                {
                    txtPlace4.Text = Convert.ToString(dr["Place"]);
                    txtCurrentKM4.Text = Convert.ToString(dr["KM_Reading"]);
                    txtBillNo4.Text = Convert.ToString(dr["BillNo"]);
                    txtDate4.Text = Convert.ToString(dr["BillDt"]);
                    txtDieselQty4.Text = Convert.ToString(dr["Diesel_Ltr"]);
                    txtAmount4.Text = Convert.ToString(dr["Amount"]);
                    txtLastKM4.Text = Convert.ToString(dr["Last_Km_Read"]);
                    txtDifference4.Text = Convert.ToString(dr["Difference_KM"]);
                    ddlPayment4.SelectedValue = Convert.ToString(dr["Card_Cash"]);
                    txtDieselRate4.Text = Convert.ToString(dr["Diesel_Rate"]);
                    ddlVendor4.SelectedValue = Convert.ToString(dr["PetrolPName"]);
                    txtApprvdAmt4.Text = Convert.ToString(dr["EXE_AMT"]);
                    txtRefNo4.Text = Convert.ToString(dr["RefNo"]);
                    txtKMPL4.Text = Convert.ToString(dr["KMPL"]);
                }

            }

        }
    }

    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    //protected void ddlPayment1_Dispaly(object sender, EventArgs e)
    //{

    //}

    //protected void ddlPayment2_Dispaly(object sender, EventArgs e)
    //{

    //}

    //protected void ddlPayment3_Dispaly(object sender, EventArgs e)
    //{

    //}

    //protected void ddlPayment4_Dispaly(object sender, EventArgs e)
    //{

    //}

    protected void SubmitData(object sender, EventArgs e)
    {

        {
            TripSheet objTripSheet = new TripSheet(str_Connection_String);

            string mTripSheetNo = "";
            string sqlDEL = "";
            SqlCommand cmdDEL = new SqlCommand();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            //DateTime mServerDt = new DateTime;

            mTripSheetNo = Request.QueryString["ID"];
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();

            try
            {

                sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                SqlCommand sql_insert_Fuel1 = new SqlCommand("USP_FLEET_INSERT_NEW_OIL_DETAIL", conn, trans);
                sql_insert_Fuel1.CommandType = CommandType.StoredProcedure;

                if (txtLastKM1.Text.ToString() != "" && txtApprvdAmt1.Text.ToString() != "")
                {
                    sql_insert_Fuel1.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_Fuel1.Parameters.Add("@Place", SqlDbType.VarChar, 100).Value = txtPlace1.Text.ToString();
                    sql_insert_Fuel1.Parameters.Add("@KM_Reading", SqlDbType.Float).Value = Convert.ToDouble(txtCurrentKM1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@BillNo", SqlDbType.VarChar, 50).Value = txtBillNo1.Text.ToString();
                    sql_insert_Fuel1.Parameters.Add("@BillDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate1.Text.ToString().Trim(), dtfi);
                    sql_insert_Fuel1.Parameters.Add("@Diesel_Ltr", SqlDbType.Float).Value = Convert.ToDouble(txtDieselQty1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@Amount", SqlDbType.Float).Value = Convert.ToDouble(txtAmount1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@Last_Km_Read", SqlDbType.Float).Value = Convert.ToDouble(txtLastKM1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@Difference_KM", SqlDbType.Float).Value = Convert.ToDouble(txtDifference1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@Card_Cash", SqlDbType.VarChar, 50).Value = ddlPayment1.SelectedValue.ToString();
                    sql_insert_Fuel1.Parameters.Add("@Diesel_Rate", SqlDbType.Float).Value = Convert.ToDouble(txtDieselRate1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@PetrolPName", SqlDbType.VarChar, 50).Value = ddlVendor1.SelectedValue.ToString();
                    sql_insert_Fuel1.Parameters.Add("@EXE_AMT", SqlDbType.Float).Value = Convert.ToDouble(txtApprvdAmt1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@REFNO", SqlDbType.VarChar, 50).Value = txtRefNo1.Text.ToString();
                    sql_insert_Fuel1.Parameters.Add("@KMPL", SqlDbType.Float).Value = Convert.ToDouble(txtKMPL1.Text.ToString());
                    sql_insert_Fuel1.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString();
                    
                    sql_insert_Fuel1.ExecuteNonQuery();
                }

                SqlCommand sql_insert_Fuel2 = new SqlCommand("USP_FLEET_INSERT_NEW_OIL_DETAIL", conn, trans);
                sql_insert_Fuel2.CommandType = CommandType.StoredProcedure;

                if (txtLastKM2.Text.ToString() != "" && txtApprvdAmt2.Text.ToString() != "")
                {
                    sql_insert_Fuel2.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_Fuel2.Parameters.Add("@Place", SqlDbType.VarChar, 100).Value = txtPlace2.Text.ToString();
                    sql_insert_Fuel2.Parameters.Add("@KM_Reading", SqlDbType.Float).Value = Convert.ToDouble(txtCurrentKM2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@BillNo", SqlDbType.VarChar, 50).Value = txtBillNo2.Text.ToString();
                    sql_insert_Fuel2.Parameters.Add("@BillDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate2.Text.ToString().Trim(), dtfi);
                    sql_insert_Fuel2.Parameters.Add("@Diesel_Ltr", SqlDbType.Float).Value = Convert.ToDouble(txtDieselQty2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@Amount", SqlDbType.Float).Value = Convert.ToDouble(txtAmount2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@Last_Km_Read", SqlDbType.Float).Value = Convert.ToDouble(txtLastKM2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@Difference_KM", SqlDbType.Float).Value = Convert.ToDouble(txtDifference2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@Card_Cash", SqlDbType.VarChar, 50).Value = ddlPayment2.SelectedValue.ToString();
                    sql_insert_Fuel2.Parameters.Add("@Diesel_Rate", SqlDbType.Float).Value = Convert.ToDouble(txtDieselRate2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@PetrolPName", SqlDbType.VarChar, 50).Value = ddlVendor2.SelectedValue.ToString();
                    sql_insert_Fuel2.Parameters.Add("@EXE_AMT", SqlDbType.Float).Value = Convert.ToDouble(txtApprvdAmt2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@REFNO", SqlDbType.VarChar, 50).Value = txtRefNo2.Text.ToString();
                    sql_insert_Fuel2.Parameters.Add("@KMPL", SqlDbType.Float).Value = Convert.ToDouble(txtKMPL2.Text.ToString());
                    sql_insert_Fuel2.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString();
                    
                    sql_insert_Fuel2.ExecuteNonQuery();
                }


                SqlCommand sql_insert_Fuel3 = new SqlCommand("USP_FLEET_INSERT_NEW_OIL_DETAIL", conn, trans);
                sql_insert_Fuel3.CommandType = CommandType.StoredProcedure;

                if (txtLastKM3.Text.ToString() != "" && txtApprvdAmt3.Text.ToString() != "")
                {
                    sql_insert_Fuel3.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_Fuel3.Parameters.Add("@Place", SqlDbType.VarChar, 100).Value = txtPlace3.Text.ToString();
                    sql_insert_Fuel3.Parameters.Add("@KM_Reading", SqlDbType.Float).Value = Convert.ToDouble(txtCurrentKM3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@BillNo", SqlDbType.VarChar, 50).Value = txtBillNo3.Text.ToString();
                    sql_insert_Fuel3.Parameters.Add("@BillDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate3.Text.ToString().Trim(), dtfi);
                    sql_insert_Fuel3.Parameters.Add("@Diesel_Ltr", SqlDbType.Float).Value = Convert.ToDouble(txtDieselQty3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@Amount", SqlDbType.Float).Value = Convert.ToDouble(txtAmount3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@Last_Km_Read", SqlDbType.Float).Value = Convert.ToDouble(txtLastKM3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@Difference_KM", SqlDbType.Float).Value = Convert.ToDouble(txtDifference3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@Card_Cash", SqlDbType.VarChar, 50).Value = ddlPayment3.SelectedValue.ToString();
                    sql_insert_Fuel3.Parameters.Add("@Diesel_Rate", SqlDbType.Float).Value = Convert.ToDouble(txtDieselRate3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@PetrolPName", SqlDbType.VarChar, 50).Value = ddlVendor3.SelectedValue.ToString();
                    sql_insert_Fuel3.Parameters.Add("@EXE_AMT", SqlDbType.Float).Value = Convert.ToDouble(txtApprvdAmt3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@REFNO", SqlDbType.VarChar, 50).Value = txtRefNo3.Text.ToString();
                    sql_insert_Fuel3.Parameters.Add("@KMPL", SqlDbType.Float).Value = Convert.ToDouble(txtKMPL3.Text.ToString());
                    sql_insert_Fuel3.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString();

                    sql_insert_Fuel3.ExecuteNonQuery();
                }


                SqlCommand sql_insert_Fuel4 = new SqlCommand("USP_FLEET_INSERT_NEW_OIL_DETAIL", conn, trans);
                sql_insert_Fuel4.CommandType = CommandType.StoredProcedure;

                if (txtLastKM4.Text.ToString() != "" && txtApprvdAmt4.Text.ToString() != "")
                {
                    sql_insert_Fuel4.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                    sql_insert_Fuel4.Parameters.Add("@Place", SqlDbType.VarChar, 100).Value = txtPlace4.Text.ToString();
                    sql_insert_Fuel4.Parameters.Add("@KM_Reading", SqlDbType.Float).Value = Convert.ToDouble(txtCurrentKM4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@BillNo", SqlDbType.VarChar, 50).Value = txtBillNo4.Text.ToString();
                    sql_insert_Fuel4.Parameters.Add("@BillDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDate4.Text.ToString().Trim(), dtfi);
                    sql_insert_Fuel4.Parameters.Add("@Diesel_Ltr", SqlDbType.Float).Value = Convert.ToDouble(txtDieselQty4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@Amount", SqlDbType.Float).Value = Convert.ToDouble(txtAmount4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@Last_Km_Read", SqlDbType.Float).Value = Convert.ToDouble(txtLastKM4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@Difference_KM", SqlDbType.Float).Value = Convert.ToDouble(txtDifference4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@Card_Cash", SqlDbType.VarChar, 50).Value = ddlPayment4.SelectedValue.ToString();
                    sql_insert_Fuel4.Parameters.Add("@Diesel_Rate", SqlDbType.Float).Value = Convert.ToDouble(txtDieselRate4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@PetrolPName", SqlDbType.VarChar, 50).Value = ddlVendor4.SelectedValue.ToString();
                    sql_insert_Fuel4.Parameters.Add("@EXE_AMT", SqlDbType.Float).Value = Convert.ToDouble(txtApprvdAmt4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@REFNO", SqlDbType.VarChar, 50).Value = txtRefNo4.Text.ToString();
                    sql_insert_Fuel4.Parameters.Add("@KMPL", SqlDbType.Float).Value = Convert.ToDouble(txtKMPL4.Text.ToString());
                    sql_insert_Fuel4.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString();

                    sql_insert_Fuel4.ExecuteNonQuery();
                }

                if (txtAmount1.Text == "") { txtAmount1.Text = "0.00"; }
                if (txtAmount2.Text == "") { txtAmount2.Text = "0.00"; }
                if (txtAmount3.Text == "") { txtAmount3.Text = "0.00"; }
                if (txtAmount4.Text == "") { txtAmount4.Text = "0.00"; }

                if (txtApprvdAmt1.Text == "") { txtApprvdAmt1.Text = "0.00"; }
                if (txtApprvdAmt2.Text == "") { txtApprvdAmt2.Text = "0.00"; }
                if (txtApprvdAmt3.Text == "") { txtApprvdAmt3.Text = "0.00"; }
                if (txtApprvdAmt4.Text == "") { txtApprvdAmt4.Text = "0.00"; }

                double Total_Fuel_Amount_Calculated = 0;
                double Total_Fuel_Amount_Approved = 0;
                double Total_Fuel_Deviation = 0;
                double Total_Fuel_Deviation_Percentage = 0;

                string Amount1 = txtAmount1.Text.ToString();
                string Amount2 = txtAmount2.Text.ToString();
                string Amount3 = txtAmount3.Text.ToString();
                string Amount4 = txtAmount4.Text.ToString();

                string Approved1 = txtApprvdAmt1.Text.ToString();
                string Approved2 = txtApprvdAmt2.Text.ToString();
                string Approved3 = txtApprvdAmt3.Text.ToString();
                string Approved4 = txtApprvdAmt4.Text.ToString();


                Total_Fuel_Amount_Calculated = Convert.ToDouble(Amount1) + Convert.ToDouble(Amount2) + Convert.ToDouble(Amount3) + Convert.ToDouble(Amount4);
                hdnTotalAmount.Value = Total_Fuel_Amount_Calculated.ToString();

                Total_Fuel_Amount_Approved = Convert.ToDouble(Approved1) + Convert.ToDouble(Approved2) + Convert.ToDouble(Approved3) + Convert.ToDouble(Approved4);
                hdnTotalAmtApproved.Value = Total_Fuel_Amount_Approved.ToString();

                Total_Fuel_Deviation = Convert.ToDouble(Total_Fuel_Amount_Approved) - Convert.ToDouble(Total_Fuel_Amount_Calculated);
                hdnDeviationFuel.Value = Total_Fuel_Deviation.ToString();

                Total_Fuel_Deviation_Percentage = (Total_Fuel_Deviation * 100) / Total_Fuel_Amount_Calculated ;
                hdnDeviationFuelPerc.Value = Total_Fuel_Deviation_Percentage.ToString();

                SqlCommand sql_insert_Fuel_Total = new SqlCommand("USP_FLEET_INSERT_FUEL_SUMMARY", conn, trans);
                sql_insert_Fuel_Total.CommandType = CommandType.StoredProcedure;

                sql_insert_Fuel_Total.Parameters.Add("@TRIPSHEETNO", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                sql_insert_Fuel_Total.Parameters.Add("@TOT_STANDARD_FUEL", SqlDbType.Float).Value = Convert.ToDouble(hdnTotalAmount.Value.ToString());
                sql_insert_Fuel_Total.Parameters.Add("@TOT_ACTUAL_FUEL", SqlDbType.Float).Value = Convert.ToDouble(hdnTotalAmtApproved.Value.ToString());
                sql_insert_Fuel_Total.Parameters.Add("@TOT_DEVIATION_FUEL", SqlDbType.Float).Value = Convert.ToDouble(hdnDeviationFuel.Value.ToString());
                sql_insert_Fuel_Total.Parameters.Add("@TOT_DEVIATION_PERCENT_FUEL", SqlDbType.Float).Value = Convert.ToDouble(hdnDeviationFuelPerc.Value.ToString());
                
                sql_insert_Fuel_Total.ExecuteNonQuery();

                if (txtDifference1.Text.ToString() == "") { txtDifference1.Text = "0.00"; }
                if (txtDifference2.Text.ToString() == "") { txtDifference2.Text = "0.00"; }
                if (txtDifference3.Text.ToString() == "") { txtDifference3.Text = "0.00"; }
                if (txtDifference4.Text.ToString() == "") { txtDifference4.Text = "0.00"; }

                if (txtDieselQty1.Text.ToString() == "") { txtDieselQty1.Text = "0.00"; }
                if (txtDieselQty2.Text.ToString() == "") { txtDieselQty2.Text = "0.00"; }
                if (txtDieselQty3.Text.ToString() == "") { txtDieselQty3.Text = "0.00"; }
                if (txtDieselQty4.Text.ToString() == "") { txtDieselQty4.Text = "0.00"; }

                string TotalDifference = "";
                string TotalDieselQty = "";
                string TotalKMPL = "";
                string sql1 = "";

                TotalDifference = Convert.ToString(Math.Round((Convert.ToDecimal(txtDifference1.Text) + Convert.ToDecimal(txtDifference2.Text) + Convert.ToDecimal(txtDifference3.Text) + Convert.ToDecimal(txtDifference4.Text)), 2));
                TotalDieselQty = Convert.ToString(Math.Round((Convert.ToDecimal(txtDieselQty1.Text) + Convert.ToDecimal(txtDieselQty2.Text) + Convert.ToDecimal(txtDieselQty3.Text) + Convert.ToDecimal(txtDieselQty4.Text)), 2));
                TotalKMPL = Convert.ToString(Math.Round((Convert.ToDecimal(TotalDifference) / Convert.ToDecimal(TotalDieselQty)), 2));

                sql1 = " Update WEBX_FLEET_VEHICLE_ISSUE set Actual_KMPL='" + TotalKMPL + "' where VSlipNo='" + mTripSheetNo + "'";
                SqlCommand VD = new SqlCommand(sql1, conn, trans);
                VD.CommandType = CommandType.Text;
                VD.ExecuteNonQuery();


                trans.Commit();
                //trans.Rollback();
                success = true;


            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("frmNewTripSummary.aspx?ID=" + mTripSheetNo.ToString(), true);
                //Response.Redirect("frmNewTripDetailsUpdateNext.aspx?id=" + lblTripsheetno.Text.ToString() + "&VEHNO=" + txtVehno.Text + "&StartKM=" + lblStartKm.Text, true);
                //Server.Transfer("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
            }
        }

    }
}

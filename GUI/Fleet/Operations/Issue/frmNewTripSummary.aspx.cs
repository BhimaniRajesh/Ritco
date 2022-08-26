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

public partial class GUI_Fleet_Operations_Issue_frmNewTripSummary : System.Web.UI.Page
{
    static string str_Connection_String = "";
    string stVSlipId = "", strVEHNO = "", strStartKM = "";
    SqlConnection conn;

    public string modeval = "";

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

            Calculate_Total_Enroute_Fuel();
            Calculate_TotalKM();
            Calulate_Total();

        }
    }

    protected void Calculate_Total_Enroute_Fuel()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql("select TRIPSHEETNO,TOT_STANDARD_ENROUTE,TOT_ACTUAL_ENROUTE,TOT_DEVIATION_ENROUTE,TOT_DEVIATION_PERCENT_ENROUTE,TOT_STANDARD_FUEL,TOT_ACTUAL_FUEL,TOT_DEVIATION_FUEL,TOT_DEVIATION_PERCENT_FUEL  from  WEBX_FLEET_NEW_TRIP_TOTAL_ENROUTE_FUEL where TripSheetNo = '" + Request.QueryString["ID"] + "'");

        if (dt.Rows.Count > 0)
        {
            txtStandardEnroute.Text = dt.Rows[0]["TOT_STANDARD_ENROUTE"].ToString();
            txtActualEnroute.Text = dt.Rows[0]["TOT_ACTUAL_ENROUTE"].ToString();
            txtDeviationEnroute.Text = dt.Rows[0]["TOT_DEVIATION_ENROUTE"].ToString();
            txtDeviationPercEnroute.Text = dt.Rows[0]["TOT_DEVIATION_PERCENT_ENROUTE"].ToString();
            txtStandardFuel.Text = dt.Rows[0]["TOT_STANDARD_FUEL"].ToString();
            txtActualFuel.Text = dt.Rows[0]["TOT_ACTUAL_FUEL"].ToString();
            txtDeviationFuel.Text = dt.Rows[0]["TOT_DEVIATION_FUEL"].ToString();
            txtDeviationPercFuel.Text = dt.Rows[0]["TOT_DEVIATION_PERCENT_FUEL"].ToString();


        }
    }

    protected void Calculate_TotalKM()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        DataTable dtVI = new DataTable();
        dtVI = objTripSheet.ExecuteSql("SELECT SUM(KM_READ) as KM_READ FROM WEBX_FLEET_NEW_VEHICLE_LOGDETAIL where TripSheetNo = '" + Request.QueryString["ID"] + "'");

        if (dtVI.Rows.Count > 0)
        {
            txtTotalKM.Text = dtVI.Rows[0]["KM_READ"].ToString();
           
        }
    }

    protected void Calulate_Total()
    {
        if (txtStandardEnroute.Text == "") { txtStandardEnroute.Text = "0.00"; }
        if (txtActualEnroute.Text == "") { txtActualEnroute.Text = "0.00"; }
        if (txtDeviationEnroute.Text == "") { txtDeviationEnroute.Text = "0.00"; }
        if (txtDeviationPercEnroute.Text == "") { txtDeviationPercEnroute.Text = "0.00"; }
        if (txtStandardFuel.Text == "") { txtStandardFuel.Text = "0.00"; }
        if (txtActualFuel.Text == "") { txtActualFuel.Text = "0.00"; }
        if (txtDeviationFuel.Text == "") { txtDeviationFuel.Text = "0.00"; }
        if (txtDeviationPercFuel.Text == "") { txtDeviationPercFuel.Text = "0.00"; }

        txtStandardTotal.Text = Convert.ToString(Math.Round((Convert.ToDecimal(txtStandardEnroute.Text) + Convert.ToDecimal(txtStandardFuel.Text)),2));
        txtActualToal.Text = Convert.ToString(Math.Round((Convert.ToDecimal(txtActualEnroute.Text) + Convert.ToDecimal(txtActualFuel.Text)), 2));
        txtDeviationTotal.Text = Convert.ToString(Math.Round((Convert.ToDecimal(txtDeviationEnroute.Text) + Convert.ToDecimal(txtDeviationFuel.Text)),2));

        //txtDeviationPercTotal.Text = Convert.ToString(Math.Round(((Convert.ToDecimal(txtDeviationTotal.Text) * 100) / Convert.ToDecimal(txtStandardTotal.Text)),2));
        if (Convert.ToDouble(txtStandardTotal.Text) > 0.00)
        {
            txtDeviationPercTotal.Text = Convert.ToString(Math.Round(((Convert.ToDecimal(txtDeviationTotal.Text) * 100) / Convert.ToDecimal(txtStandardTotal.Text)), 2));
        }
        else
        {
            txtDeviationPercTotal.Text = "0";
        }
		if(txtTotalKM.Text == "")
		{
			txtTotalKM.Text = "0.00";
		}
		if(txtTotalKM.Text != "0.00")
		{
			txtCostPerKM.Text = Convert.ToString(Math.Round((Convert.ToDecimal(txtActualToal.Text) / Convert.ToDecimal(txtTotalKM.Text)),2));
        }
        else
        {
			txtCostPerKM.Text = "0.00";
        }
    }


    protected void SubmitData(object sender, EventArgs e)
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

        modeval = "TD";

        try
        {

            SqlCommand sql_Update = new SqlCommand("USP_FLEET_UPDATE_TOTAL_ENROUTE_FUEL", conn, trans);
            sql_Update.CommandType = CommandType.StoredProcedure;

            sql_Update.Parameters.Add("@TRIPSHEETNO", SqlDbType.VarChar, 50).Value = mTripSheetNo;
            sql_Update.Parameters.Add("@TOT_STANDARD", SqlDbType.Float).Value = Convert.ToDouble(txtStandardTotal.Text.ToString());
            sql_Update.Parameters.Add("@TOT_ACTUAL", SqlDbType.Float).Value = Convert.ToDouble(txtActualToal.Text.ToString());
            sql_Update.Parameters.Add("@TOT_DEVIATION", SqlDbType.Float).Value = Convert.ToDouble(txtDeviationTotal.Text.ToString());
            sql_Update.Parameters.Add("@TOT_DEVIATION_PERCENT", SqlDbType.Float).Value = Convert.ToDouble(txtDeviationPercTotal.Text.ToString());
            sql_Update.Parameters.Add("@TOT_KM", SqlDbType.Float).Value = Convert.ToDouble(txtTotalKM.Text.ToString());
            sql_Update.Parameters.Add("@TOT_COST_PER_KM", SqlDbType.Float).Value = Convert.ToDouble(txtCostPerKM.Text.ToString());

            sql_Update.ExecuteNonQuery();


            //string sql = "";
            //sql = "Update WEBX_FLEET_VEHICLE_ISSUE set f_closure_closekm=" + txtCloseKM.Text + ",TotAdvExp='" + mTotAdvExp + "',TotOilExp='" + mTotOilExp + "',TotRepairExp='" + mTotRepairExp + "',TotIncDedExp='" + mTotIncDedExp + "',TotEnrouteExp='" + mTotEnrouteExp + "',TotClaimsAmt='" + mTotClaimsExp + "',TotSpareExp='" + mTotSpareExp + "', PreparedBy='" + mPreparedBy + "',CheckedBy='" + mCheckedBy + "',ApprovedBy='" + mApprovedBy + "',Oper_Close_dt='" + mOPCloseDt + "',AuditedBy='" + mAuditedBy + "'" + sqlfinstr + "  Where VSlipNo ='" + mTripSheetNo + "' ";
            //SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
            //TripHeader.CommandType = CommandType.Text;
            //TripHeader.ExecuteNonQuery();



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
            //Response.Redirect("frmNewTripSummary.aspx?ID=" + mTripSheetNo.ToString(), true);
            //Response.Redirect("frmNewTripDetailsUpdateNext.aspx?id=" + lblTripsheetno.Text.ToString() + "&VEHNO=" + txtVehno.Text + "&StartKM=" + lblStartKm.Text, true);
            Response.Redirect("frmVehicleIssueSlipCloseLegWise_result.aspx?VSlipId=" + Request.QueryString["ID"] + "&mode=" + modeval, true);
        }

    }
}
        
    



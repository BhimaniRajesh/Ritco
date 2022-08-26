using System;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Fleet_Operations_Issue_frmDriverSettlement_result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string TsNO = Request.QueryString["VSlipId"];
            string Financial_Year = SessionUtilities.FinYear.ToString().Trim();
            string mTripBillNo = Request.QueryString["TripBillNo"];
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand cmd = new SqlCommand("USP_Get_Driver_Settlement_Details", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TripSheetNo", TsNO);
            cmd.Parameters.AddWithValue("@FinYear", SessionUtilities.FinYear);
            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
        }
    }
}

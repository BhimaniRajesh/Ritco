using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class Issue_frmVehicleIssueSlipNew_result : System.Web.UI.Page
{
    public string mvoucherno = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        string VSlipNo = "";
        VSlipNo = Request.QueryString["VSlipId"].ToString().Trim();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        //string sql = "select VoucherRefno from WEBX_TRIPSHEET_ADVEXP where tripsheetno='" + VSlipNo + "' and branchcode='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";
        string sql = "select VoucherRefno,AdvDate=Convert(Varchar,AdvDate,106),tripsheetno,VSlipDt=Convert(Varchar,VSlipDt,106),VehicleNo,AdvAmt,Driver_Name from WEBX_TRIPSHEET_ADVEXP A Outer Apply(select VehicleNo,VSlipDt,Driver_Name from WEBX_FLEET_VEHICLE_ISSUE I Outer Apply (SELECT Driver_Name FROM WEBX_FLEET_DRIVERMST where Driver_ID=Driver1)B where vslipno='" + VSlipNo + "')C where tripsheetno='" + VSlipNo + "' and branchcode='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";
        string sql2 = "SELECT VehicleNo ,VSlipDt ,Driver_Name FROM WEBX_FLEET_VEHICLE_ISSUE I OUTER APPLY ( SELECT    Driver_Name FROM      WEBX_FLEET_DRIVERMST WHERE     Driver_Id = Driver1 ) B WHERE     VSlipNo = '" + VSlipNo + "'";
        string sql3 = "SELECT isnull(sum(CAST(CASE WHEN ISNULL(AdvAmt,'') = '' THEN '0' ELSE AdvAmt END  AS NUMERIC(12,2))),0) TotalAdvAmt FROM WEBX_TRIPSHEET_ADVEXP  WHERE     TripSheetNo ='" + VSlipNo + "'";

        SqlCommand cmd = new SqlCommand(sql2, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblDocDtVal.Text = dr["VSlipDt"].ToString();
            lblVehicleNoVal.Text = dr["VehicleNo"].ToString();
            lblDriverNameVal.Text = dr["Driver_Name"].ToString();
        }

        dr.Close();


        SqlCommand cmd1 = new SqlCommand(sql, con);
        SqlDataAdapter sda = new SqlDataAdapter(cmd1);
        DataTable dt = new DataTable();
        sda.Fill(dt);

        gvAdvance.DataSource = dt;
        gvAdvance.DataBind();


        SqlCommand cmd2 = new SqlCommand(sql3, con);
        SqlDataReader dr2 = cmd2.ExecuteReader();
        while (dr2.Read())
        {
            lblAmountVal.Text = dr2["TotalAdvAmt"].ToString();
        }

        dr2.Close();


    }
}

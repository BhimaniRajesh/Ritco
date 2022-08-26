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

public partial class Issue_frmViewPrintVehicleIssueSlipNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string strTripSheetNo = "";
            if (Request.QueryString["VSlipNo"] != null)
            {
                
                strTripSheetNo = Request.QueryString["VSlipNo"].ToString();
                conn.Open();
                string sql = "select *from vw_tripsheet_view where VSlipNo='" + strTripSheetNo + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    //lblControllingBranch.Text = dr["Branch"].ToString();
                    lblTripsheetNo.Text = dr["VSlipNo"].ToString();
                    lblManualTripsheet.Text = dr["Manual_TripSheetNo"].ToString();
                    lblStartDate.Text = dr["sDT"].ToString();
                    lblEndDate.Text = dr["eDT"].ToString();
                    lblStartLocation.Text = dr["Tripsheet_startLocName"].ToString();
                    lblEndLocation.Text = dr["Tripsheet_EndLocName"].ToString();
                    lblCategory.Text = dr["Category"].ToString();
                    if (dr["Category"].ToString() != "Internal Usage")
                    {
                        lblCustomer.Text = dr["Custname"].ToString();
                    }
                    if (dr["From_city"].ToString() != "")
                    {
                        lblFromCity.Text = dr["From_city"].ToString();
                        lblToCity.Text = dr["To_City"].ToString();
                        lblRoute.Text = dr["Route"].ToString();
                    }
                    else
                    {
                        lblFromCity.Text = dr["RUT_FROMCOTY"].ToString();
                        lblToCity.Text = dr["RUT_TOCITY"].ToString();
                        lblRoute.Text = dr["RUTDESC"].ToString();
                    }
                    lblVehno.Text = dr["VehicleNo"].ToString();

                    lblDriver1Name.Text = dr["DRIVER_Name1"].ToString();
                    lblDriver1Licence.Text = dr["License_no1"].ToString();
                    lblDriver1LicValid.Text = dr["valdity_dt1"].ToString();
                    lblDriver1ManualCode.Text = dr["MANUAL_DRIVER_CODE1"].ToString();

                    lblDriver2Name.Text = dr["DRIVER_Name2"].ToString();
                    lblDriver2Licence.Text = dr["License_no2"].ToString();
                    lblDriver2LicValid.Text = dr["valdity_dt2"].ToString();
                    lblDriver2ManualCode.Text = dr["MANUAL_DRIVER_CODE2"].ToString();

                    lblStartKm.Text = dr["f_issue_startkm"].ToString();

                    lblFuel.Text = dr["e_issue_fuel"].ToString();

                    //lblPlace.Text = dr["AdvLoc"].ToString();
                    //lblAdvDate.Text = dr["AdvDate"].ToString();
                    //lblAmount.Text = dr["AdvAmt"].ToString();
                    //lblBranch.Text = dr["BranchCode"].ToString();
                    //lblSign.Text = dr["Signature"].ToString();
                }
                dr.Close();
                conn.Close();

                ChecklistDetails(strTripSheetNo);
                ChecklistHDR(strTripSheetNo);

                string strSel="Select VoucherRefNo,AdvLoc,convert(varchar,AdvDate,106)AdvDate,AdvAmt,THCno,BranchCode,Signature from WEBX_TRIPSHEET_ADVEXP Where TripSheetNo='" + strTripSheetNo + "'";
                SqlDataAdapter adp = new SqlDataAdapter(strSel, conn);
                DataSet ds = new DataSet();
                adp.Fill(ds);
                gvAdvPaid.DataSource = ds;
                gvAdvPaid.DataBind();
            }
        }
    }

    public void ChecklistDetails(string strTripSheetNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand cmd = new SqlCommand("USP_FLEET_VIEW_CHECKLIST", conn);

        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = strTripSheetNo;
        DataSet ds = new DataSet();

        da.Fill(ds);

        gvChecklist.DataSource = ds;
        gvChecklist.DataBind();

        conn.Close();

    }

    public void ChecklistHDR(string strTripSheetNo)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sqlstrCheck = "select Checked_By,Convert(varchar,Checked_Dt,113) as Checked_Date,Approved_By,Convert(varchar,Approved_Dt,113) as Approved_Date from WEBX_FLEET_CHECKLIST_HDR where TripSheetNo='" + strTripSheetNo + "'";
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

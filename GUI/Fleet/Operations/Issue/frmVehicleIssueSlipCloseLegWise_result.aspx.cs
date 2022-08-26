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

public partial class GUI_Fleet_Operations_Issue_frmVehicleIssueSlipCloseLegWise_result : System.Web.UI.Page
{
    public string mvoucherno = "";
    public string modeval = "";
    string mend_dt_tm = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        string VSlipNo = "";
        VSlipNo = Request.QueryString["VSlipId"].ToString().Trim();
        modeval = Request.QueryString["mode"].ToString().Trim();

        if (modeval == "Advance")
        {
            lblPageHead.Text = "Trip Advance Entry >> Submitted";
            lblHeader.Text = "Following document is Updated";
        }
        else if (modeval == "Close")
        {
            lblPageHead.Text = "Close - Operational Trip Sheet >> Submitted";
            lblHeader.Text = "Following document is Closed";
        }
        else if (modeval == "Settlement")
        {
            lblPageHead.Text = "Driver Settlement >> Submitted";
            lblHeader.Text = "Following document is Updated";
        }
        else if (modeval == "FE")
        {
            lblPageHead.Text = "Tripsheet Financial Edit >> Submitted";
            lblHeader.Text = "Following document is Updated";
        }
        else if (modeval == "TD")
        {
            lblPageHead.Text = "Close - Operational Trip Sheet >> Submitted";
            lblHeader.Text = "Following document is Updated";
        }
        else if (modeval == "TLW")
        {
            lblPageHead.Text = "Tripsheet Financial Edit >> Submitted";
            lblHeader.Text = "Following document is Updated";
        }


        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sql = "select VoucherRefno,end_dt_tm from WEBX_TRIPSHEET_ADVEXP A, webx_fleet_vehicle_issue I where I.vslipno=a.tripsheetno and tripsheetno='" + VSlipNo + "' and branchcode='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";


        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            mend_dt_tm = dr["end_dt_tm"].ToString();
            //if (mend_dt_tm == null || mend_dt_tm == "")
            {
                mvoucherno = dr["VoucherRefno"].ToString();
            }
            LblVoucherNo.Text = mvoucherno;
        }
    }
}

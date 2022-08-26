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
public partial class GUI_Fleet_Operations_Issue_EditTripsheetResult : System.Web.UI.Page
{
    public string mvoucherno = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        string VSlipNo = "";
        VSlipNo = Request.QueryString["VSlipId"].ToString().Trim();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sql = "select VoucherRefno from WEBX_TRIPSHEET_ADVEXP where tripsheetno='" + VSlipNo + "' and branchcode='" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";


        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            mvoucherno = dr["VoucherRefno"].ToString();
            LblVoucherNo.Text = mvoucherno;
        }

    }
}

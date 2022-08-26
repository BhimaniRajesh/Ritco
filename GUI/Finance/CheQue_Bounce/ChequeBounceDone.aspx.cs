using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_Finance_CheQue_Bounce_ChequeBounceDone : System.Web.UI.Page
{
    public static string VoucherNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        VoucherNo = Request.QueryString["VoucherNo"].ToString();
        lblVoucherNo.Text = Request.QueryString["VoucherNo"].ToString();
        var sqp = new SqlParameter[2];
        sqp[0] = new SqlParameter("@VoucherNo", VoucherNo);
        sqp[1] = new SqlParameter("@FinYear",SessionUtilities.FinYear);

        var dt = new DataTable();
        using (var oWebXHelper = new WebXHelper())
        {
            dt = oWebXHelper.ExecuteDataTable(CommandType.StoredProcedure, "USP_ChequeBounce_GetVoucher", sqp);
        }
        if (dt.Rows.Count > 0)
        {
            hdnTramsType.Value = dt.Rows[0]["Transtype"].ToString();
        }
    }
}
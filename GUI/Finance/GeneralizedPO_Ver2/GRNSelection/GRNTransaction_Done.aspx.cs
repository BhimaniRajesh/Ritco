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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_Voucher_Cancellation_VoucherCancellation_done : System.Web.UI.Page
{
    public string GRNnos = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        GRNnos = Request.QueryString["GRNNos"].ToString();
        DataTable dtDocket = new DataTable();

        string SQLStr = "EXEC USP_GET_GRN_Voucher_Details '" + GRNnos + "'";
        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        dgPODetails.DataSource = dtDocket;
        dgPODetails.DataBind();
    }
}

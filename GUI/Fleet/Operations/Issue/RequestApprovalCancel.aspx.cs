using System;
using System.Data;

public partial class GUI_Fleet_Operations_Issue_RequestApprovalCancel : System.Web.UI.Page
{
    #region Variable[s]
    public static string RequestNo = "";
    public static string RequestOrder = "";
    public static string Flag = "";
    #endregion
    #region Page Load Event
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                RequestNo = Convert.ToString(Request.QueryString["RequestNo"]);
                RequestOrder = Convert.ToString(Request.QueryString["RequestOrder"]);
                Flag = Convert.ToString(Request.QueryString["Flag"]);
                var objPushVehicleDriverRequest = new PushVehicleDriverRequest();
                DataTable dt = objPushVehicleDriverRequest.GetListingForCancellationonRequestNo(RequestNo, RequestOrder, Flag);
                if (dt.Rows.Count > 0)
                {
                    rptFinnalIndentDktPendingList.DataSource = dt;
                    rptFinnalIndentDktPendingList.DataBind();
                }
                if (Flag == "C")
                    lblHeader.Text = "Request Cancelled.";
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + ex.Message.Replace('\n', '_'));
        }
    }
    #endregion
}
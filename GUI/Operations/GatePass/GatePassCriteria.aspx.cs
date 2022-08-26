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

public partial class GUI_Operations_GatePass_GatePassCriteria : System.Web.UI.Page
{
    protected string dockname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnserverdate.Value = DataProvider.GetServerDate();
            txtDateFrom.Text = hdnserverdate.Value;
            txtDateTo.Text = hdnserverdate.Value;
            radDate.SelectedIndex = 0;
            dockname = SessionUtilities.DocketCalledAs;
        }
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string url = "";

        if (optgpnos.Checked == true)
            url = "?tp=0";
        else if (optdockno.Checked == true)
            url = "?tp=1";
        if (optdate.Checked == true)
            url = "?tp=2";

        url = url + "&startdate=" + txtDateFrom.Text + "&enddate=" + txtDateTo.Text;
        url = url + "&partycode=" + txtpartycode.Text + "&gatepassnos=" + txtgatepass.Text;
        url = url + "&docknos=" + txtdocknos.Text;

        Response.Redirect("UpdateGatePass.aspx" + url);
    }
}

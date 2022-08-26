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

public partial class GUI_Operations_FM_Scan_Report_Query : System.Web.UI.Page
{
    public string brcd, empcd, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = SessionUtilities.CurrentBranchCode;
        empcd = SessionUtilities.CurrentEmployeeID;
        dkt_Call = SessionUtilities.DocketCalledAs;

        Fromlc.Width = "100";
        if (!IsPostBack)
        {
            FMUtility.BindFMDocTypes(ddlDocType, "");
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string NavURL = "Result.aspx?";
        NavURL += "FromDT=" + DT.FromDate;
        NavURL += "&ToDT=" + DT.ToDate;
        NavURL += "&DOC_Type=" + ddlDocType.SelectedValue;
        NavURL += "&RO=" + Fromlc.SelectedRO;
        NavURL += "&RO_Text=" + Fromlc.SelectedRO_Text;
        NavURL += "&LO=" + Fromlc.SelectedLocation;
        NavURL += "&LO_Text=" + Fromlc.SelectedLocation_Text;
        NavURL += "&DOC_NO=" + txtDocNo.Text;

        Response.Redirect(NavURL, false);
    }
}

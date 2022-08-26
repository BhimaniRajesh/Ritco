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

public partial class GUI_Operations_FM_PendingScanReport_Query : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        Fromlc.Width = "100";

        if (!IsPostBack && !IsCallback)
        {
            FMUtility.BindFMDocTypes(ddlDocType, "");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string QS = "Result.aspx?DocType=" + ddlDocType.SelectedValue;
        QS += "&FromDT=" + DT.DateFrom.ToString("dd MMM yyyy");
        QS += "&ToDT=" + DT.DateTo.ToString("dd MMM yyyy");
        QS += "&RO=" + Fromlc.SelectedRO;
        QS += "&LO=" + Fromlc.SelectedLocation;
        Response.Redirect(QS, false);
    }
}

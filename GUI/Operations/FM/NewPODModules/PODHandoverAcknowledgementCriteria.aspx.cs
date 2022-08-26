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
using WebX.Controllers;
public partial class GUI_Operations_FM_NewPODModules_PODHandoverAcknowledgementCriteria : System.Web.UI.Page
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

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string st_ro = "", st_lo = "";
        string fromdt = DT.FromDate, todt = DT.ToDate;

        st_ro = Fromlc.SelectedRO;
        if (st_ro == "All")
        {
            st_ro = "";
        }

        st_lo = Fromlc.SelectedLocation;
        if (st_lo == "All")
        {
            st_lo = "";
        }
        var obj = new NewPODModuleController();
        var dt = obj.GetPODHandOverNumber("HQTR", st_ro, st_lo, DT.DateFrom.ToString("dd MMM yyyy"), DT.DateTo.ToString("dd MMM yyyy"), txtPODNo.Text);
        dgDockets.DataSource = dt;
        dgDockets.DataBind();
    }
}
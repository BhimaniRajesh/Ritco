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

public partial class GUI_Operations_FM_NewPODModules_PODHandoverReprint : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        
        if (!IsPostBack && !IsCallback)
        {
            ddlLocation.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_locations_all_ver1").Tables[0];
            ddlLocation.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        var obj = new NewPODModuleController();
        var dt = obj.GetDocketListForPODHandOverReprint(ddlLocation.SelectedValue, DT.DateFrom.ToString("dd MMM yyyy"), DT.DateTo.ToString("dd MMM yyyy"), txtdocno.Text);
        dgDockets.DataSource = dt;
        dgDockets.DataBind();
        
    }
}

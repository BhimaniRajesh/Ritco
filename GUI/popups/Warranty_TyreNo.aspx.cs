using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_popups_popup_tyres : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        if(!IsPostBack)
        {
            BindGrid();
            hfTyreNo.Value = Request.QueryString["hfTyreNo"].ToString();
            hTyreID.Value = Request.QueryString["hTyreID"].ToString();
            hfMFG.Value = Request.QueryString["hfMFG"].ToString();
            hfTyreCost.Value = Request.QueryString["hfTyreCost"].ToString();
            hfTOTKM.Value = Request.QueryString["hfTOTKM"].ToString();
            hfModel.Value = Request.QueryString["hfModel"].ToString();
            hfLastTreadDepth.Value = Request.QueryString["hfLastTreadDepth"].ToString();
            hfVehId.Value = Request.QueryString["hfVehId"].ToString();
            hfTotalCost.Value = Request.QueryString["hfTotalCost"].ToString();
        }
    }
    public void BindGrid()
    {
        cls_Tyre_Warranty cTyreWarranty = new cls_Tyre_Warranty(Session["SqlProvider"].ToString().Trim());
        cTyreWarranty.BindGridTyreDetails(GridView1);
    }
}

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
            hTyreID.Value = Request.QueryString["tyreId"].ToString();
            hfTyreNo.Value = Request.QueryString["tyreno"].ToString();
            hfKmRun.Value = Request.QueryString["KMRun"].ToString();
            hfTreadDepth.Value = Request.QueryString["TreadDepth"].ToString();
            hfPosition.Value = Request.QueryString["TyrePosition"].ToString();
            hfVehNO.Value = Request.QueryString["VehNumber"].ToString();
            hfMFG.Value = Request.QueryString["Manufacturer"].ToString();
            hfModel.Value = Request.QueryString["Model"].ToString();
            hfAVG_TWI.Value = Request.QueryString["LastAvgTWI"].ToString();
            hfVehId.Value = Request.QueryString["VehId"].ToString();
        }
    }
    public void BindGrid()
    {
        cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(Session["SqlProvider"].ToString().Trim());
        cTDM.VEH_NO = "";
        cTDM.BindGridTyreDetails_TyreWise(GridView1);
    }
}

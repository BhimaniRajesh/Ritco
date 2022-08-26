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
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult : System.Web.UI.Page
{
    string Type;
    string VendorCode = "", POCode = "", FromDt = "", ToDt = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Type = Request.QueryString["Type"].ToString();
            if (Request.QueryString["Fromdt"].ToString() != "NA" || Request.QueryString["Todt"].ToString() != "NA")
            {
                lblDate.Text = WebXConvert.ToDateTime(Request.QueryString["Fromdt"].ToString(), "en-GB").ToString("dd MMM yyyy") + " : " + WebXConvert.ToDateTime(Request.QueryString["Todt"].ToString(), "en-GB").ToString("dd MMM yyyy");
                FromDt = WebXConvert.ToDateTime(Request.QueryString["Fromdt"].ToString(), "en-GB").ToString("dd MMM yyyy");
                ToDt = WebXConvert.ToDateTime(Request.QueryString["Todt"].ToString(), "en-GB").ToString("dd MMM yyyy");
            }
            else
            {
                lblDate.Text = ""; FromDt = ""; ToDt = "";
            }
            if (Request.QueryString["VendorCode"].ToString() != "NA")
            {
                lblVendorCode.Text = Request.QueryString["VendorName"].ToString();
                VendorCode = Request.QueryString["VendorCode"].ToString();
            }
            else
            {
                VendorCode = "";
            }
            if (Request.QueryString["POCode"].ToString() != "NA")
            {
                lblPOCode.Text = Request.QueryString["POCode"].ToString();
                POCode = Request.QueryString["POCode"].ToString();
            }
            else
            {
                POCode = "";
            }
            BindGrid();
        }
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();
        //alter by vidya on 23 Jan 2015 [add Branch]
        //string SQLStr = "EXEC USP_GPO_Listing_For_View_Print '" + Type + "','" + VendorCode + "','" + FromDt + "','" + ToDt + "','" + POCode + "'";
        string SQLStr = "EXEC USP_GPO_Listing_For_View_Print'" + Type + "','" + VendorCode + "','" + FromDt + "','" + ToDt + "','" + POCode + "','" + SessionUtilities.CurrentBranchCode.Trim() + "'";

        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        dgPODetails.DataSource = dtDocket;
        dgPODetails.DataBind();
    }
    //protected void dgPODetails_OnRowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Label lblPOCode = (Label)e.Row.FindControl("lblPOCode");
    //        //Label HydView = (Label)e.Row.FindControl("HydView");
    //        Label HydPrint = (Label)e.Row.FindControl("HydPrint");
    //        HydPrint.Attributes.Add("onclick", "JavaScript:Popup('../ViewPrint/PO_GenerationView.aspx?PONumber=" + lblPOCode.Text.ToString() + ",1')");
    //        //HydView.Attributes.Add("onclick", "JavaScript:Popup('../ViewPrint/PO_GenerationView.aspx?PONumber=" + lblPOCode.Text.ToString() + ",0')");
    //    }
    //}
}

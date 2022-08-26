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
    string VendorCode = "", GRNCode = "", ManualGRNCode = "", FromDt = "", ToDt = "";
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
            if (Request.QueryString["GRNCode"].ToString() != "NA")
            {
                lblGRNCode.Text = Request.QueryString["GRNCode"].ToString();
                GRNCode = Request.QueryString["GRNCode"].ToString();
            }
            else
            {
                GRNCode = "";
            }
            if (Request.QueryString["ManualGRNCode"].ToString() != "NA")
            {
                lblManualGRNCode.Text = Request.QueryString["ManualGRNCode"].ToString();
                ManualGRNCode = Request.QueryString["ManualGRNCode"].ToString();
            }
            else
            {
                ManualGRNCode = "";
            }
            BindGrid();
        }
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();

        string SQLStr = "EXEC USP_GRN_Listing_For_View_Print '" + Type + "','" + VendorCode + "','" + FromDt + "','" + ToDt + "','" + GRNCode + "','" + ManualGRNCode + "'";

        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        dgPODetails.DataSource = dtDocket;
        dgPODetails.DataBind();
    }
}

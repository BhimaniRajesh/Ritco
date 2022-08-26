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
    string VendorCode = "", DDMRCode = "", DocketCode = "", FromDt = "", ToDt = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Type = Request.QueryString["Type"].ToString();
            FromDt = Request.QueryString["Fromdt"].ToString();
            ToDt = Request.QueryString["Todt"].ToString();
            VendorCode = Request.QueryString["VendorCode"].ToString();
            DDMRCode = Request.QueryString["DDMRCode"].ToString();
            //DocketCode = Request.QueryString["DocketCode"].ToString();

            BindGrid();
        }
    }
    public void BindGrid()
    {
        DataTable dtDDMRList = new DataTable();

        string SQLStr = "EXEC USP_DDMR_Listing_For_UpdateProcess_Register '" + Type + "','" + VendorCode + "','" + FromDt + "','" + ToDt + "','" + DDMRCode + "','" + DocketCode + "','" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";

        dtDDMRList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GV_DDMRList.DataSource = dtDDMRList;
        GV_DDMRList.DataBind();
    }
    
}


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

public partial class GUI_Finance_GeneralizedPO_GRNGeneration_SinglePO_GRN_DataList : System.Web.UI.Page
{
    string FromDate = "", ToDate = "", POCode = "", ManualPOCode = "", VendorCode = "";
    string VendCd = "", VendNm = "", Company="",Brcd="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsCallback && !IsPostBack)
        {
            string[] Vend_Arr = null;
            VendorCode = Request.QueryString["VendorCode"].ToString();
            if (VendorCode.ToString() != "")
            {
                Vend_Arr = VendorCode.ToString().Split('~');
                VendCd = Vend_Arr[1].ToString();
                VendNm = Vend_Arr[0].ToString();
            }
            else
            {
                VendCd = "";
                VendNm = "";
            } 
            
            FromDate = Request.QueryString["FromDate"].ToString();
            ToDate = Request.QueryString["ToDate"].ToString();
            POCode = Request.QueryString["PONo"].ToString();
            ManualPOCode = Request.QueryString["ManualPONo"].ToString();
            
            BindGrid();
        }
        VendorCode = Request.QueryString["VendorCode"].ToString();
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();
        FromDate = Convert.ToString(Request.QueryString["FromDate"]);
        ToDate = Convert.ToString(Request.QueryString["ToDate"]);
        POCode = ((Request.QueryString["PONo"] != null) ? Request.QueryString["PONo"].ToString() : "");
        ManualPOCode = ((Request.QueryString["ManualPONo"] != null) ? Request.QueryString["ManualPONo"].ToString() : "");
        FromDate = WebXConvert.ToDateTime(FromDate, "en-GB").ToString("dd MMM yy");
        ToDate = WebXConvert.ToDateTime(ToDate, "en-GB").ToString("dd MMM yy");
        Company = SessionUtilities.DefaultCompanyCode.ToString();
        Brcd=Session["Brcd"].ToString();
        string SQLStr = "EXEC USP_POList_For_AdvancePayment_Ver2 '" + FromDate + "','" + ToDate + "','" + POCode + "','" + ManualPOCode + "','" + VendCd + "','" + Brcd + "','" + Company + "'";
        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GrdPO.DataSource = dtDocket;
        GrdPO.DataBind();
    }
}

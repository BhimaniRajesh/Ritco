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
    string POType = "", FromDate = "", ToDate = "", POCode = "", ManualPOCode = "", VendorCode = "";
    string VendCd = "", VendNm = "";
    string POList = "",RO = "",LO = "",Company = "",Type = "", FabricSheet_YN="";
    protected void Page_Load(object sender, EventArgs e)
    {
        //FabricSheet_YN = Convert.ToString(Request.QueryString["FabricSheet_YN"]);
		if (!IsCallback && !IsPostBack)
        {
            string[] Vend_Arr = null;
            Type = Request.QueryString["Type"].ToString();
            if (Type != "STN")
            {
                VendorCode = Request.QueryString["VendorCode"].ToString();
                if (VendorCode.ToString() != "")
                {
                    Vend_Arr = VendorCode.ToString().Split('~');
                    VendCd = Vend_Arr[1].ToString();
                    VendNm = Vend_Arr[0].ToString();

                    tdDocketNo.Text = "PO Code";
                    tdPOType.Text = "PO Type";
                    tdManualDocketNo.Text = "Manual PO Code";
                }
                else
                {
                    VendCd = "";
                    VendNm = "";
					tdDocketNo.Text = "PO Code";
                    tdPOType.Text = "PO Type";
                    tdManualDocketNo.Text = "Manual PO Code";
                } 
            }
            else
            {
                VendCd = "";
                VendNm = "";

                tdDocketNo.Text = "STN Code";
                tdPOType.Text = "STN Type";
                tdManualDocketNo.Text = "Manual STN Code";
            }
            
            tdDocketHeader.Text = "Selected GRN Generation Criteria";
            
            POType = Convert.ToString(Request.QueryString["POTypeDesc"]);
            FromDate = Request.QueryString["FromDate"].ToString();
            ToDate = Request.QueryString["ToDate"].ToString();
            POCode = Request.QueryString["PONo"].ToString();
            ManualPOCode = Request.QueryString["ManualPONo"].ToString();
            if (POType == "--SELECT--")
            {
                LblPOType.Text = "All";
            }
            else
            {
                LblPOType.Text = POType;
            }
            lblDocketNo.Text = POCode;
            lblManualDocketNo.Text = ManualPOCode;
            lblFromDateToDate.Text = FromDate + "   -   " + ToDate;
            lblPartyCode.Text = VendorCode;
            BindGrid();
        }
        VendorCode = Request.QueryString["VendorCode"].ToString();
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();
        POType = Convert.ToString(Request.QueryString["POType"]);
        FromDate = Convert.ToString(Request.QueryString["FromDate"]);
        ToDate = Convert.ToString(Request.QueryString["ToDate"]);
        RO = Convert.ToString(Request.QueryString["RO"]);
        LO = Convert.ToString(Request.QueryString["LO"]);
        POCode = ((Request.QueryString["PONo"] != null) ? Request.QueryString["PONo"].ToString() : "");
        ManualPOCode = ((Request.QueryString["ManualPONo"] != null) ? Request.QueryString["ManualPONo"].ToString() : "");
        FromDate = WebXConvert.ToDateTime(FromDate, "en-GB").ToString("dd MMM yy");
        ToDate = WebXConvert.ToDateTime(ToDate, "en-GB").ToString("dd MMM yy");
        Company = Convert.ToString(Request.QueryString["CompanyCode"]);
        
        string SQLStr = "EXEC USP_DOCUMENT_FOR_GRN_GENERATION_VER2 '" + FromDate + "','" + ToDate + "','" + RO + "','" + LO + "','" + POCode + "','" + ManualPOCode + "','" + VendCd + "','" + POType + "','" + Company + "','" + Type + "'";
        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GrdPO.DataSource = dtDocket;
        GrdPO.DataBind();
    }
}

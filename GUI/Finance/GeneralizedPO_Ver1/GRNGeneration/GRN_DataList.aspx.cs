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

public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRN_DataList : System.Web.UI.Page
{
    string Type = "", FromDate = "", ToDate = "", POCode = "", ManualPOCode = "", VendorCode = "";
    string VendCd = "", VendNm = "";
    string POList = "";
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
            tdDocketHeader.Text = "Selected GRN Generation Criteria";
            tdDocketNo.Text = "PO Code";
            tdManualDocketNo.Text = "Manual PO Code";
            Type = Request.QueryString["Type"].ToString();
            FromDate = Request.QueryString["FromDate"].ToString();
            ToDate = Request.QueryString["ToDate"].ToString();
            POCode = Request.QueryString["PONo"].ToString();
            ManualPOCode = Request.QueryString["ManualPONo"].ToString();
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
        Type = Request.QueryString["Type"].ToString();
        FromDate = Convert.ToString(Request.QueryString["FromDate"]);
        ToDate = Convert.ToString(Request.QueryString["ToDate"]);
        POCode = ((Request.QueryString["PONo"] != null) ? Request.QueryString["PONo"].ToString() : "");
        FromDate = WebXConvert.ToDateTime(FromDate, "en-GB").ToString("dd MMM yy");
        ToDate = WebXConvert.ToDateTime(ToDate, "en-GB").ToString("dd MMM yy");

        string SQLStr = "EXEC USP_DOCUMENT_FOR_GRN_GENERATION '" + FromDate + "','" + ToDate + "','" + POCode + "','" + ManualPOCode + "','" + VendCd + "','" + Type + "'";
        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GRNData.DataSource = dtDocket;
        GRNData.DataBind();
    }
    protected void GvDocketDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            CheckBox chkBox = new CheckBox();
            chkBox.EnableViewState = true;
            chkBox.Enabled = true;
            chkBox.ID = "chkSelectAll";
            chkBox.CssClass = "chkSelectAll";
            chkBox.AutoPostBack = true;
            chkBox.Visible = true;
            e.Row.Cells[0].Controls.Add(chkBox);
            chkBox.Attributes.Add("onclick", "return SelectAllcheckBox();");
            e.Row.TableSection = TableRowSection.TableHeader;
            e.Row.HorizontalAlign = HorizontalAlign.Center;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GRNData.Rows.Count; i++)
        {
            if (((CheckBox)GRNData.Rows[i].FindControl("chkb")).Checked == true)
            {
                Label lblPOCode = (Label)GRNData.Rows[i].FindControl("GRNNO");
                if (POList == "")
                {
                    POList = lblPOCode.Text.ToString();
                }
                else
                {
                    POList = POList + "," + lblPOCode.Text.ToString();
                }
            }
        }
        Response.Redirect("GRN_DetailList.aspx?POList=" + POList + "&VendorCode=" + Request.QueryString["VendorCode"].ToString());
    }
}

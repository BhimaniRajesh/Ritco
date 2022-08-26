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
    MyFunctions fn = new MyFunctions();
    string TotalPOsno = "", Financial_Year = "";
    string Type;
    string VendorCode = "", POCode = "", ManualPOCode = "", FromDt = "", ToDt = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Type = Request.QueryString["Type"].ToString();
            txtApprovaldt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
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
                lblGRNCode.Text = Request.QueryString["POCode"].ToString();
                POCode = Request.QueryString["POCode"].ToString();
            }
            else
            {
                POCode = "";
            }
            if (Request.QueryString["ManualPOCode"].ToString() != "NA")
            {
                lblManualGRNCode.Text = Request.QueryString["ManualPOCode"].ToString();
                ManualPOCode = Request.QueryString["ManualPOCode"].ToString();
            }
            else
            {
                ManualPOCode = "";
            }
            BindGrid();
        }
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();

        string SQLStr = "EXEC USP_PO_Listing_For_Approval '" + Type + "','" + VendorCode + "','" + FromDt + "','" + ToDt + "','" + POCode + "','" + ManualPOCode + "'";

        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        dgPODetails.DataSource = dtDocket;
        dgPODetails.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (SessionUtilities.CurrentBranchCode.ToString() != "HQTR")
        {
            string ErrorMsg = "Generalized PO Can Be Approve Be Head Quarter, Branch Can’t Approve It";
            Response.Redirect("../../../ErrorPage.aspx?PageHead=" + "Generalized PO Approval" + "&ErrorMsg=" + ErrorMsg);
        }
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlTransaction trans;
        trans = conn.BeginTransaction();

        string POApprovalDt = fn.Mydate1(txtApprovaldt.Text.ToString());
        Financial_Year = Session["FinYear"].ToString();

        try
        {
            foreach (GridViewRow gr in dgPODetails.Rows)
            {
                HtmlInputCheckBox chkbox = ((HtmlInputCheckBox)gr.FindControl("chkPOno"));
                Label lblPOCode = ((Label)gr.FindControl("lblPOCode"));
                if (chkbox.Checked==true)
                {
                    string sql_Acctrans = "UPDATE webx_GENERAL_POASSET_HDR SET Finalized='Y',FinalizedDT='" + POApprovalDt + "',FinalizedBy='" + SessionUtilities.CurrentEmployeeID.ToString() + "' WHERE pocode='" + lblPOCode.Text.ToString() + "'";
                    SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_Acctrans);
                    TotalPOsno += lblPOCode.Text + ",";
                }
            }
            trans.Commit();
            TotalPOsno = TotalPOsno.Substring(0, TotalPOsno.Length - 1).ToString();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }

        conn.Close();
        Response.Redirect("POFinalizedDone.aspx?Type=PO&PONos=" + TotalPOsno);
    }
}

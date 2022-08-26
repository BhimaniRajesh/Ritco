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
    public string Type,Str;
    string VendorCode = "", GRNCode = "", ManualGRNCode = "", FromDt = "", ToDt = "";
    public int intTotalRecords;
    SqlConnection con;
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

            Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        }
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();

        string SQLStr = "EXEC USP_GRN_Listing_For_View_Print '" + Type + "','" + VendorCode + "','" + FromDt + "','" + ToDt + "','" + GRNCode + "','" + ManualGRNCode + "','"+SessionUtilities.CurrentBranchCode.ToString().Trim()+"'";

        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        dgPODetails.DataSource = dtDocket;
        intTotalRecords = dtDocket.Rows.Count;
        dgPODetails.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        foreach (GridViewRow GRN in dgPODetails.Rows)
        {
            CheckBox chkDock = (CheckBox)GRN.FindControl("chkDock");
            Label lblGRNCode = (Label)GRN.FindControl("lblPOCode");
            string GRNCode = lblGRNCode.Text;
            if (chkDock.Checked==true)
            {
                SqlTransaction trans;
                trans = con.BeginTransaction();
                try
                {
                    Str = "select count(*) from webx_GRN_HDR where isnull(Cancelled,'N')='N' AND isnull(Accounting_Y_N,'N')='N' AND GRNNO='" + GRNCode.ToString() + "'";
                    double count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Str));

                    if (count > 0)
                    {
                        Str = "UPDATE DBO.webx_GRN_HDR WITH(ROWLOCK) SET Accounting_Y_N ='Y' WHERE GRNNO='" + GRNCode.ToString() + "'";

                        Str = Str + " exec USP_GRNTransaction '1','" + GRNCode.ToString() + "','" + SessionUtilities.FinYear + "','"+SessionUtilities.DefaultCompanyCode.ToString()+"'";

                        SqlHelper.ExecuteScalar(trans, CommandType.Text, Str);
                        if (hidSelectGRN.Value == "")
                        {
                            hidSelectGRN.Value = GRNCode.ToString();
                        }
                        else
                        {
                            hidSelectGRN.Value = hidSelectGRN.Value + "," + GRNCode.ToString();
                        }
                    }

                    trans.Commit();
                }
                catch (Exception e1)
                {

                    Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
                    string msg = e1.Message.ToString();
                    msg = msg.Replace('\n', ' ');
                    msg = msg.Replace('\r', ' ');
                    trans.Rollback();
                    //Response.Redirect("../Debit Voucher/Message.aspx?" + msg);
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "GRN Accounting Posting " + "&ErrorMsg=" + msg);
                }
            }
        }
        Response.Redirect("GRNTransaction_Done.aspx?GRNNos=" + hidSelectGRN.Value.ToString(),false);
    }
}

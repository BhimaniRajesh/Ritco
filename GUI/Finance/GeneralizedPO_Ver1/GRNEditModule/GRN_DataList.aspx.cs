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
    string Type = "", FromDate = "", ToDate = "", GRNCode = "", ManualGRNCode = "", VendorCode = "";
    string VendCd = "", VendNm = "";
    string GRNList = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        MsgBox.Hide();
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
            tdDocketHeader.Text = "Selected GRN Edit Criteria";
            tdDocketNo.Text = "GRN Code";
            tdManualDocketNo.Text = "Manual GRN Code";
            Type = Request.QueryString["Type"].ToString();
            FromDate = Request.QueryString["FromDate"].ToString();
            ToDate = Request.QueryString["ToDate"].ToString();
            GRNCode = Request.QueryString["GRNNo"].ToString();
            ManualGRNCode = Request.QueryString["ManualGRNNo"].ToString();
            VendorCode = Request.QueryString["VendorCode"].ToString();
            lblDocketNo.Text = GRNCode;
            lblManualDocketNo.Text = ManualGRNCode;
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
        GRNCode = ((Request.QueryString["GRNNo"] != null) ? Request.QueryString["GRNNo"].ToString() : "");
        ManualGRNCode = ((Request.QueryString["ManualGRNNo"] != null) ? Request.QueryString["ManualGRNNo"].ToString() : "");
        FromDate = WebXConvert.ToDateTime(FromDate, "en-GB").ToString("dd MMM yy");
        ToDate = WebXConvert.ToDateTime(ToDate, "en-GB").ToString("dd MMM yy");

        string SQLStr = "EXEC USP_DOCUMENT_FOR_GRN_EDIT '" + FromDate + "','" + ToDate + "','" + GRNCode + "','" + ManualGRNCode + "','" + VendCd + "','" + Type + "'";
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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string VCD = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("TxtGrnDate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkBtnGrnDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkBtnGrnDate")).Attributes.Add("onclick", VCD);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        bool isCommited = false;
        string GrnList = "";
        try
        {
            foreach (GridViewRow gridrow in GRNData.Rows)
            {
                CheckBox chkb = (CheckBox)gridrow.FindControl("chkb");
                Label LblGrnNO = (Label)gridrow.FindControl("LblGrnNO");
                CheckBox chkbCancelled = (CheckBox)gridrow.FindControl("chkbCancelled");

                if (chkb.Checked)
                {
                    string sql = "";
                    if (chkbCancelled.Checked)
                    {
                        sql = "exec Usp_Update_Cancelled_GRN '" + LblGrnNO.Text.Trim() + "','','" + SessionUtilities.CurrentEmployeeID.ToString() + "','1'";
                    }
                    else
                    {
                        TextBox TxtGrnDate = (TextBox)gridrow.FindControl("TxtGrnDate");
                        string GrnDate = WebXConvert.ToDateTime(TxtGrnDate.Text, "en-GB").ToString("dd MMM yy");

                        sql = "exec Usp_Update_Cancelled_GRN '" + LblGrnNO.Text.Trim() + "','" + GrnDate + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','0'";
                    }
                    //throw new Exception("sql :" + sql);
                    
                    SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
                    con.Open();

                    SqlTransaction tran = con.BeginTransaction();
                    try
                    {
                        SqlHelper.ExecuteNonQuery(tran, CommandType.Text, sql);
                        tran.Commit();
                        //tran.Rollback();
                        isCommited = true;
                        GrnList += LblGrnNO.Text.Trim() + ",";
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        throw ex;
                    }
                    finally
                    {
                        if(con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }
                }
            }
        }
        catch (Exception exp)
        {
            MsgBox.Show(exp.Message);
        }
        if (isCommited)
        {
            Response.Redirect("GRN_Done.aspx?GrnList=" + GrnList);
        }
    }
}

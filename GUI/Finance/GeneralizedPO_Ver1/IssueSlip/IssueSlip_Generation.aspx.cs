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
using WebX.Controllers;


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRNCriteria : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public DataTable dt_san = new DataTable();
    DataTable dt = new DataTable("table1");
    protected void Page_Load(object sender, EventArgs e)
    {
        MsgBox.Hide();
        if (!IsPostBack)
        {
            try
            {
                BindDropDown();
                BindDropDownVehicle();
                fn.Fill_VehicleMaster_Dataset();
                VisibleTrueFalseStep1(false);
                lblIssueLoc.Text = SessionUtilities.CurrentBranchCode.ToString();
                txtIssueDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
                TxtReqDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
                txtIssueDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'13','../../../images/Date_Control_Rule_Check.aspx')");
                TxtReqDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'13','../../../images/Date_Control_Rule_Check.aspx')");
                TxtDocNo.Attributes.Add("onblur", "DocBlur('" + TxtDocNo.ClientID.ToString() + "')");
            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }
        }
    }
    public void BindDropDown()
    {
        string SQLStr = "";
        SQLStr = "SELECT '' AS CodeID, '--SELECT--' AS CodeDesc UNION SELECT CodeID,CodeDesc From Webx_master_General Where CodeType='MATCAT' And StatusCode='Y' order by CodeDesc";
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        DDLMatCat.DataSource = dt;
        DDLMatCat.DataTextField = "CodeDesc";
        DDLMatCat.DataValueField = "CodeID";
        DDLMatCat.DataBind();
    }
    public void BindDropDownVehicle()
    {
        string SQLStr = "";
        SQLStr = "SELECT '' AS CodeID, '--SELECT--' AS CodeDesc UNION SELECT CodeID,CodeDesc From Webx_master_General Where CodeType='MATCAT' And StatusCode='Y' order by CodeDesc";
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        DDLMatCat.DataSource = dt;
        DDLMatCat.DataTextField = "CodeDesc";
        DDLMatCat.DataValueField = "CodeID";
        DDLMatCat.DataBind();
    }
    protected void ddlMatCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        for (int i = 0; i < GV_Details.Rows.Count; i++)
        {
            TextBox txtMaterial = (TextBox)GV_Details.Rows[i].FindControl("txtMaterial");
            TextBox txtFixAsset = (TextBox)GV_Details.Rows[i].FindControl("txtFixAsset");
            if (DDLMatCat.SelectedValue.ToString() == "06")
            {
                txtMaterial.Visible = false;
                txtFixAsset.Visible = true;
            }
            else
            {
                txtMaterial.Visible = true;
                txtFixAsset.Visible = false;
            }
        }
        if (DDLMatCat.SelectedValue.ToString() == "01")
        {
            LblNumber.Text = "CFR MR No : ";
        }
        else if (DDLMatCat.SelectedValue.ToString() == "03")
        {
            LblNumber.Text = "Job Sheet No : ";
        }
        else
        {
            LblNumber.Text = "Document Number : ";
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        GV_Details.DataSource = dt;
        GV_Details.DataBind();
        ddlMatCat_SelectedIndexChanged(sender, e);
    }
    protected void btnStep1_Click(object sender, EventArgs e)
    {
        VisibleTrueFalseStep1(true);
        HidMatCat.Value = DDLMatCat.SelectedValue.ToString();
        HidIssueDate.Value = txtIssueDate.Text.ToString();
        fn.Fill_MaterialDetails_Dataset(DDLMatCat.SelectedValue);
        fn.Fill_Fix_Asset_Dataset(DDLMatCat.SelectedValue);
        creategrid();
        ddlMatCat_SelectedIndexChanged(sender, e);
    }
    public void creategrid()
    {
        dt_san.Clear();
        Int32 i;
        DataRow drow;
        for (i = 0; i < 5; i++)
        {
            drow = dt_san.NewRow();
            dt_san.Rows.Add(drow);
        }
        GV_Details.DataSource = dt_san;
        GV_Details.DataBind();
    }
    public void VisibleTrueFalseStep1(bool Bol)
    {
        string S = (Bol == true ? "block" : "none");
        trGrid.Style["display"] = S;
        trFinalSubmit.Visible = Bol;
        trIndexRow.Visible = Bol;
    }
    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label lblItemHeader = (Label)e.Row.FindControl("lblItemHeader");
            if (HidMatCat.Value == "01")
            {
                lblItemHeader.Text = "Packing Materials Details";
                lblItemHeader.Font.Bold = true;
            }
            else if (HidMatCat.Value == "02")
            {
                lblItemHeader.Text = "Tyre Details";
                lblItemHeader.Font.Bold = true;
            }
            else if (HidMatCat.Value == "03")
            {
                lblItemHeader.Text = "Spare Parts Details";
                lblItemHeader.Font.Bold = true;
            }
            else if (HidMatCat.Value == "04")
            {
                lblItemHeader.Text = "General Details";
                lblItemHeader.Font.Bold = true;
            }
            else if (HidMatCat.Value == "05" || HidMatCat.Value == "5")
            {
                lblItemHeader.Text = "Printing & Stationary Details";
                lblItemHeader.Font.Bold = true;
            }
            else if (HidMatCat.Value == "06" || HidMatCat.Value == "6")
            {
                lblItemHeader.Text = "Fix Asset Details";
                lblItemHeader.Font.Bold = true;
            }
            else
            {
                lblItemHeader.Text = "";
            }
        }
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        try
        {
            btn_submit.Enabled = false;
            string sql = "", TranXaction = "",IssueSlipNo="";
            string Xml_IssueSlip_HDR_Details = "<root>";
            string Xml_IssueSlip_Details = "<root>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<IssueHDR>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<ISSUEDATE>" + fn.Mydate1(txtIssueDate.Text).ToString().Trim() + "</ISSUEDATE>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<IssueLocation>" + lblIssueLoc.Text.ToString() + "</IssueLocation>";            
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<DocNo>" + TxtDocNo.Text.ToString().Trim() + "</DocNo>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<MatCat>" + DDLMatCat.SelectedValue.ToString() + "</MatCat>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<RequisitionNo>" + TxtReqNo.Text.ToString().Trim() + "</RequisitionNo>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<RequisitionDate>" + fn.Mydate1(TxtReqDate.Text).ToString().Trim() + "</RequisitionDate>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<VehicleNo>" + TxtVehicle.Text.ToString() + "</VehicleNo>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<Comments>" + TxtComments.Text.ToString().Trim() + "</Comments>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<EntryBy>" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "</EntryBy>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<CompanyCode>" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "</CompanyCode>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "<FinYear>" + Session["FinYear"].ToString() + "</FinYear>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "</IssueHDR>";
            Xml_IssueSlip_HDR_Details = Xml_IssueSlip_HDR_Details + "</root>";

            foreach (GridViewRow gridrow in GV_Details.Rows)
            {
                TextBox txtSKUCode = new TextBox();
                if (DDLMatCat.SelectedValue.ToString() == "06")
                {
                    txtSKUCode = (TextBox)gridrow.FindControl("txtFixAsset");
                }
                else
                {
                    txtSKUCode = (TextBox)gridrow.FindControl("txtMaterial");
                }
                TextBox txtqty = (TextBox)gridrow.FindControl("txtqty");
                TextBox txtIssuedQTY = (TextBox)gridrow.FindControl("txtIssuedQTY");
                TextBox txtdesc = (TextBox)gridrow.FindControl("txtdesc");
                TextBox txtRequiredQTY = (TextBox)gridrow.FindControl("txtRequiredQTY");
                
                if (txtSKUCode.Text != "")
                {
                    string[] SKUCode = txtSKUCode.Text.Split('~');
                    string SKUCD = SKUCode[1].ToString(), SKUName = SKUCode[0].ToString();
                    if (SKUCD != "")
                    {
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<IssueDetails>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<SKUCD>" + SKUCD.ToString().Trim() + "</SKUCD>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<SKUNAME>" + SKUName.ToString().Trim() + "</SKUNAME>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<Description>" + txtdesc.Text.ToString().Trim() + "</Description>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<Quantity>" + Convert.ToDecimal(txtqty.Text.ToString().Trim()) + "</Quantity>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<RequiredQTY>" + Convert.ToDecimal(txtRequiredQTY.Text.ToString().Trim()) + "</RequiredQTY>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<IssuedQTY>" + Convert.ToDecimal(txtIssuedQTY.Text.ToString().Trim()) + "</IssuedQTY>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<Brcd>" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "</Brcd>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<EntryBy>" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "</EntryBy>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "<CompanyCode>" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "</CompanyCode>";
                        Xml_IssueSlip_Details = Xml_IssueSlip_Details + "</IssueDetails>";
                    }
                }
            }

            Xml_IssueSlip_Details = Xml_IssueSlip_Details + "</root>";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlTransaction trans;
            trans = conn.BeginTransaction();

            try
            {

                string Finyear = Session["FinYear"].ToString();
                Finyear = Finyear.Substring(2, 2);
                string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
                if (CloseYear.Length == 1)
                    CloseYear = "0" + CloseYear;
                CloseYear = CloseYear.Substring(2, 2);
                string YEAR_SUFFIX = Finyear + "_" + CloseYear;
                
                sql = "usp_Generate_IssueSlip_Details";
                SqlParameter[] arParms = new SqlParameter[4];
                arParms[0] = ControllersHelper.GetSqlParameter("@Xml_IssueSlip_HDR", Xml_IssueSlip_HDR_Details.Replace("&", "&amp;").Trim(), SqlDbType.Text);
                arParms[1] = ControllersHelper.GetSqlParameter("@Xml_IssueSlip_Details", Xml_IssueSlip_Details.Replace("&", "&amp;").Trim(), SqlDbType.Text);
                arParms[2] = ControllersHelper.GetSqlParameter("@Finyear", YEAR_SUFFIX.ToString().Trim(), SqlDbType.VarChar);
                arParms[3] = ControllersHelper.GetSqlParameter("@BRCD", SessionUtilities.CurrentBranchCode.ToString().Trim(), SqlDbType.VarChar);
                DataTable ResultDtl = new DataTable();
                ResultDtl.Rows.Clear();
                ResultDtl = SqlHelper.ExecuteDataset(trans, CommandType.StoredProcedure, sql, arParms).Tables[0];
                if (ResultDtl.Rows.Count > 0)
                {
                    DataRow ResultDtlRow = ResultDtl.Rows[0];
                    if (ResultDtlRow["Status"] != DBNull.Value)
                    {
                        int status = Convert.ToInt32(ResultDtlRow["Status"]);
                        TranXaction = ResultDtlRow["Message"].ToString();

                        if (status == 0 && TranXaction != "Done")
                            throw new Exception(ResultDtlRow["Message"].ToString());
                        else
                            IssueSlipNo = ResultDtlRow["IssueSlipNo"].ToString();
                    }
                    else
                        throw new Exception("Unknown Exception");
                }
                trans.Commit();
                //trans.Rollback();
            }
            catch (Exception exp)
            {
                trans.Rollback();
                throw exp;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            Response.Redirect("IssueSlip_Done.aspx?IssueSlipNo=" + IssueSlipNo.ToString().Trim(), false);
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
        
    }
}

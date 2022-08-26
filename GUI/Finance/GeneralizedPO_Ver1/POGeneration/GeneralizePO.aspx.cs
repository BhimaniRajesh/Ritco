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
using AtlasControlToolkit;
using WebX.Controllers;

public partial class GUI_Finance_GeneralizedPO_POGeneration_GeneralizePO : System.Web.UI.Page
{
    SqlConnection con;
    public static string straccd, p;
    DataTable dt = new DataTable("table1");
    public DataTable dt_san = new DataTable();
    MyFunctions fn = new MyFunctions();
    public double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;

    protected void Page_Load(object sender, EventArgs e)
    {
        MsgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            txtpodt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtqdt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtreqdt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            BindAccount();
            VisibleTrueFalseStep1(false);
            VisibleTrueFalseStep2(true);
            BindDropDown();
            fn.Fill_Vendor_Dataset();
            con.Close();
        }
        DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
        ddlPayMode.Attributes.Add("onblur", " cahs_N_bank()");
        txtpodt.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'13','../../../images/Date_Control_Rule_Check.aspx')");
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

    private void getstring()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "select distinct vendorcode from webx_vendor_hdr";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["vendorcode"] + "'"));
        }
        dr_Location.Close();
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
                Label lblItemHeader1 = (Label)e.Row.FindControl("lblItemHeader1");
                Label lblItemHeader2 = (Label)e.Row.FindControl("lblItemHeader2");
                Label lblItemHeader3 = (Label)e.Row.FindControl("lblItemHeader3");
                lblItemHeader.Text = "Tyre Model";
                lblItemHeader.Font.Bold = true;
                lblItemHeader1.Text = "Tyre MFG";
                lblItemHeader1.Font.Bold = true;
                lblItemHeader2.Text = "Tyre Size";
                lblItemHeader2.Font.Bold = true;
                lblItemHeader3.Text = "Tyre Category";
                lblItemHeader3.Font.Bold = true;
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
                lblItemHeader.Text = "Fix Asset Details";
                lblItemHeader.Font.Bold = true;                
            }
            else if (HidMatCat.Value == "06")
            {
                lblItemHeader.Text = "Printing & Stationary Details";
                lblItemHeader.Font.Bold = true;
            }
            else
            {
                lblItemHeader.Text = "";
            }
        }
    }
    public string getnewcd()
    {
        //string sql = "Select dbo.WebX_FN_Get_Next_GPONo ('" + SessionUtilities.CurrentBranchCode + "','" + SessionUtilities.FinYear + "')";
        string sql = "exec WebX_SP_GetNextDocumentCode_FA  '" + SessionUtilities.CurrentBranchCode + "','" + SessionUtilities.FinYear + "','GPO'";
        string cd1 = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sql).ToString();
        return cd1;
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        try
        {
            string qry = "Exec Usp_Get_Date_Rule_Result '13','" + fn.Mydate1(txtpodt.Text.ToString()) + "','" + Session["Finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "'";
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;
            if (con.State == ConnectionState.Open)
                con.Close();
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr["Falg"].ToString() == "N")
                {
                    throw new Exception(dr["ErrMsg"].ToString()); 
                }
            }
            dr.Close();
            con.Close();

            btn_submit.Enabled = false;
            string sql = "", TranXaction = "", Adv_VocherNo = "";
            DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
            DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
            DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
            TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");
            TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
            TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
            TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
            TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");
            string ChqDate = fn.Mydate1(txtChqDate.Text);
            string PayMode = ddlPayMode.SelectedValue.ToString();
            string Bankaccode = ddrBankaccode.SelectedValue.ToString();
            string Cashcode = ddrCashcode.SelectedValue.ToString();
            string NetPay = txtNetPay.Text.ToString();
            string CashAmt = txtCashAmt.Text.ToString();
            string ChqAmt = txtChqAmt.Text.ToString();

            if (Convert.ToDecimal(txtadv.Text.ToString()) > 0)
            {
                if (PayMode == "Cash")
                {
                    if (CashAmt == "" || CashAmt == null)
	                {
                		throw new Exception("Please enter the cash amount"); 
	                }
                }
                else if (PayMode == "Bank")
                {
                    if (ChqAmt == "" || ChqAmt == null || txtChqNo.Text.ToString()=="")
                    {
                        throw new Exception("Please enter the cheque details");
                    }
                }
                else if (PayMode == "-1")
                {
                    throw new Exception("Please select the pay mode");
                }
            }
            
            if (ChqAmt == "" || ChqAmt == null)
                ChqAmt = "0.00";
            if (CashAmt == "" || CashAmt == null)
                CashAmt = "0.00";

            string ChqNo = txtChqNo.Text.ToString();
            string[] ARR_vendcd = Txt_Vendor.Text.Split('~');
            string ptmsptcd = ARR_vendcd[1].ToString(), ptmsptnm = ARR_vendcd[0].ToString();
            if (PayMode == "Cash")
            {
                ChqAmt = "0.00";
                ChqNo = "";
                ChqDate = "";
            }
            else if (PayMode == "Bank")
            {
                CashAmt = "0.00";
            }
            else if (PayMode == "-1")
            {
                CashAmt = "0.00";
                ChqAmt = "0.00";
                ChqNo = "";
                ChqDate = "";
            }

            string pocd = getnewcd();
            double Total_NetAmt = 0;
            Total_NetAmt = Convert.ToDouble(txtadv.Text) + Convert.ToDouble(Hnd_BalAmt.Value);
            string Xml_POASSET_HDR_Details = "<root>";
            string Xml_PO_Details = "<root>";

            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<POHDR>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<POCODE>" + pocd.Trim() + "</POCODE>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<PODATE>" + fn.Mydate1(txtpodt.Text).ToString().Trim() + "</PODATE>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<VENDORCD>" + ptmsptcd.Trim() + "</VENDORCD>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<VENDORNM>" + ptmsptnm.Trim() + "</VENDORNM>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<TOTALQTY>" + Convert.ToDecimal(Total_Qty.Value) + "</TOTALQTY>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<TOTALAMT>" + Total_NetAmt + "</TOTALAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<ATTN>" + txtkind.Text.Trim() + "</ATTN>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<ENTRYBY>" + SessionUtilities.CurrentEmployeeID + "</ENTRYBY>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<POSTATUS>" + "PO GENERATED" + "</POSTATUS>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<PENDAMT>" + Convert.ToDecimal(txtbalamt.Text.ToString()) + "</PENDAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<Brcd>" + SessionUtilities.CurrentBranchCode + "</Brcd>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<CHQDATE>" + ChqDate + "</CHQDATE>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<PAYMODE>" + PayMode.ToString() + "</PAYMODE>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<CHQNO>" + ChqNo.ToString() + "</CHQNO>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<PAIDAMT>" + Convert.ToDecimal(txtadv.Text.ToString()) + "</PAIDAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<TERMS_CONDITION>" + txtterm.Text + "</TERMS_CONDITION>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<CHQAMT>" + ChqAmt + "</CHQAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<CASHAMT>" + Convert.ToDecimal(CashAmt.ToString()) + "</CASHAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<PO_ADVAMT>" + Convert.ToDecimal(txtadv.Text.ToString()) + "</PO_ADVAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<PO_BALAMT>" + Convert.ToDecimal(txtbalamt.Text.ToString()) + "</PO_BALAMT>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<BANK_ACCODE>" + Bankaccode.ToString() + "</BANK_ACCODE>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<CASH_ACCODE>" + Cashcode.ToString() + "</CASH_ACCODE>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<MANUAL_PO_NO>" + txtManPONo.Text.ToString() + "</MANUAL_PO_NO>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<Company_Code>" + SessionUtilities.DefaultCompanyCode.ToString() + "</Company_Code>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<AccCode>" + "UNS0004" + "</AccCode>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<AccDesc>" + "Sundry Creditors - Others" + "</AccDesc>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "<MatCat>" + ddlMatCat.SelectedValue + "</MatCat>";
            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "</POHDR>";

            Xml_POASSET_HDR_Details = Xml_POASSET_HDR_Details + "</root>";

            foreach (GridViewRow gridrow in GV_Details.Rows)
            {
                TextBox txtAccCode = new TextBox();
                DropDownList ddlTyretype = new DropDownList();
                TextBox txtTyreSize = new TextBox();
                TextBox txtTyreMFG = new TextBox();
                if (ddlMatCat.SelectedValue == "01")
                {
                    txtAccCode = (TextBox)gridrow.FindControl("txtPackMaterial");
                }
                else if (ddlMatCat.SelectedValue == "02")
                {
                    txtAccCode = (TextBox)gridrow.FindControl("txtTyreModel");
                    ddlTyretype = (DropDownList)gridrow.FindControl("ddlTyreType");
                    txtTyreSize = (TextBox)gridrow.FindControl("txtTyreSize");
                    txtTyreMFG = (TextBox)gridrow.FindControl("txtMfg");
                }
                else if (ddlMatCat.SelectedValue == "03")
                {
                    txtAccCode = (TextBox)gridrow.FindControl("txtSparePart");
                }
                else if (ddlMatCat.SelectedValue == "04")
                {
                    txtAccCode = (TextBox)gridrow.FindControl("txtGeneral");
                }
                else if (ddlMatCat.SelectedValue == "05" || ddlMatCat.SelectedValue == "5")
                {
                    txtAccCode = (TextBox)gridrow.FindControl("txtFixAsset");
                }
                else if (ddlMatCat.SelectedValue == "06" || ddlMatCat.SelectedValue == "6")
                {
                    txtAccCode = (TextBox)gridrow.FindControl("txtStationary");
                }
                else
                {
                    txtAccCode = new TextBox();
                }
                TextBox txtdesc = (TextBox)gridrow.FindControl("txtdesc");
                TextBox txtqty = (TextBox)gridrow.FindControl("txtqty");
                TextBox txtperct = (TextBox)gridrow.FindControl("txtperct");
                TextBox txtDiscount = (TextBox)gridrow.FindControl("txtDiscount");
                TextBox txtrate = (TextBox)gridrow.FindControl("txtrate");
                TextBox txttot = (TextBox)gridrow.FindControl("txttot");
                HiddenField HidTotalAmount = (HiddenField)gridrow.FindControl("HidTotalAmount");
                if (txtAccCode.Text != "")
                {
                    /*string Assetcode = "", AssetName = "";
                    if (ddlMatCat.SelectedValue == "02")
                        Assetcode = txtAccCode.Text;
                    else
                    {
                        string[] Assetcd = txtAccCode.Text.Split('~');
                        Assetcode = Assetcd[1].ToString();
                        AssetName = Assetcd[0].ToString();
                    }*/
                    
                    string[] Assetcd = txtAccCode.Text.Split('~');
                    string Assetcode = Assetcd[1].ToString(),AssetName = Assetcd[0].ToString();

                    string TyreSizeCode = "", TyreSizeName = "";
                    string TyreMFGCode = "", TyreMFGName = "";
                    if (ddlMatCat.SelectedValue == "02")
                    {
                        string[] TyreSize = txtTyreSize.Text.Split('~');
                        string[] TyreMFG = txtTyreMFG.Text.Split('~');
                        TyreSizeCode = TyreSize[1].ToString();
                        TyreSizeName = TyreSize[0].ToString();
                        TyreMFGCode = TyreMFG[1].ToString();
                        TyreMFGName = TyreMFG[0].ToString();
                    }

                    if (Assetcode != "")
                    {
                        Xml_PO_Details = Xml_PO_Details + "<Other>";
                        Xml_PO_Details = Xml_PO_Details + "<pocode>" + pocd.Trim() + "</pocode>";
                        Xml_PO_Details = Xml_PO_Details + "<podate>" + fn.Mydate1(txtpodt.Text).ToString().Trim() + "</podate>";
                        Xml_PO_Details = Xml_PO_Details + "<assetcd>" + Assetcode.Trim() + "</assetcd>";
                        Xml_PO_Details = Xml_PO_Details + "<qty>" + Convert.ToDecimal(txtqty.Text.Trim()) + "</qty>";
                        Xml_PO_Details = Xml_PO_Details + "<rate>" + Convert.ToDecimal(txtrate.Text.Trim()) + "</rate>";
                        Xml_PO_Details = Xml_PO_Details + "<total>" + Convert.ToDecimal("0") + "</total>";
                        Xml_PO_Details = Xml_PO_Details + "<entryby>" + SessionUtilities.CurrentEmployeeID + "</entryby>";
                        Xml_PO_Details = Xml_PO_Details + "<location>" + SessionUtilities.CurrentBranchCode + "</location>";
                        Xml_PO_Details = Xml_PO_Details + "<narration>" + txtdesc.Text.Trim() + "</narration>";
                        Xml_PO_Details = Xml_PO_Details + "<tax_per>" + Convert.ToDouble(txtperct.Text.Trim()) + "</tax_per>";
                        Xml_PO_Details = Xml_PO_Details + "<tax_type>" + "" + "</tax_type>";
                        Xml_PO_Details = Xml_PO_Details + "<activeflag>" + "N" + "</activeflag>";
                        Xml_PO_Details = Xml_PO_Details + "<balanceqty>" + Convert.ToDecimal(txtqty.Text.Trim()) + "</balanceqty>";
                        Xml_PO_Details = Xml_PO_Details + "<Discount_Per>" + Convert.ToDecimal(txtDiscount.Text.ToString()) + "</Discount_Per>";
                        Xml_PO_Details = Xml_PO_Details + "<TyreSizeCode>" + TyreSizeCode + "</TyreSizeCode>";
                        Xml_PO_Details = Xml_PO_Details + "<TyreMFG_Code>" + TyreMFGCode + "</TyreMFG_Code>";
                        Xml_PO_Details = Xml_PO_Details + "<TyreTypeCode>" + ddlTyretype.SelectedValue.ToString() + "</TyreTypeCode>";
                        Xml_PO_Details = Xml_PO_Details + "</Other>";
                    }
                }
            }
            Xml_PO_Details = Xml_PO_Details + "</root>";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlTransaction trans;
            trans = conn.BeginTransaction();

            try
            {
                sql = "usp_Generate_PO_Asset_Details";
                SqlParameter[] arParms = new SqlParameter[3];
                arParms[0] = ControllersHelper.GetSqlParameter("@Xml_POASSET_HDR", Xml_POASSET_HDR_Details.Replace("&", "&amp;").Trim(), SqlDbType.Text);
                arParms[1] = ControllersHelper.GetSqlParameter("@Xml_PO_Details", Xml_PO_Details.Replace("&", "&amp;").Trim(), SqlDbType.Text);
                arParms[2] = ControllersHelper.GetSqlParameter("@Finyear", Session["FinYear"].ToString(), SqlDbType.VarChar);
                //GenPONo = SqlHelper.ExecuteScalar(trans, CommandType.StoredProcedure, sql, arParms).ToString();
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
                        if (status == 1)
                        {
                            Adv_VocherNo = ResultDtlRow["Voucherno"].ToString();
                        }
                    }
                    else
                        throw new Exception("Unknown Exception");
                }
                trans.Commit();
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

            Response.Redirect("PO_Done.aspx?VoucherNo=" + Adv_VocherNo + "&PONO=" + pocd, false);
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    public void BindAccount()
    {
    }
    public void VisibleTrueFalseStep1(bool Bol)
    {
        string S = (Bol == true ? "block" : "none");
        trIndexRow.Visible = Bol;
        //trGridHeader.Visible = Bol;
        trGrid.Style["display"] = S;
        trAdvAmt.Visible = Bol;
        trBalAmt.Visible = Bol;
        trProgessBar.Visible = Bol;
        trRequiDet.Visible = Bol;
        trTerms.Visible = Bol;
        trPaymentCtrl.Visible = Bol;
        trFinalSubmit.Visible = Bol;
        //VisibleTrueFalseStep2(false);
    }
    public void VisibleTrueFalseStep2(bool Bool)
    {
        trMatCat.Visible = Bool;
        trPONo.Visible = Bool;
        trVendor.Visible = Bool;
        trQutation.Visible = Bool;
        trManualPONo.Visible = Bool;
        trStep1.Visible = Bool;
    }
    public void BindDropDown()
    {
        string SQLStr = "";
        SQLStr = "SELECT '' AS CodeID, '--SELECT--' AS CodeDesc UNION SELECT CodeID,CodeDesc From Webx_master_General Where CodeType='MATCAT' And StatusCode='Y' order by CodeDesc";
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        ddlMatCat.DataSource = dt;
        ddlMatCat.DataTextField = "CodeDesc";
        ddlMatCat.DataValueField = "CodeID";
        ddlMatCat.DataBind();
    }
    protected void btnStep1_Click(object sender, EventArgs e)
    {
        VisibleTrueFalseStep1(true);
        EnableTrueFalseStep2(true);
        HidManPONo.Value = txtManPONo.Text.ToString();
        HidMatCat.Value = ddlMatCat.SelectedValue.ToString();
        HidPOdate.Value = txtpodt.Text.ToString();
        string[] ARR_vendcd = Txt_Vendor.Text.Split('~');
        HidVendorName.Value = ARR_vendcd[0].ToString();
        HidVendorCode.Value = ARR_vendcd[1].ToString();
        fn.Fill_General_Asset_Dataset(ddlMatCat.SelectedValue);
        fn.Fill_SpareParts_Dataset(ddlMatCat.SelectedValue);
        fn.Fill_TyreMFG_Dataset();
        fn.Fill_TyreModel_Dataset();
        fn.Fill_TyreSize_Dataset();
        fn.Fill_Stationary_Asset_Dataset(ddlMatCat.SelectedValue);
        fn.Fill_Fix_Asset_Dataset();
        creategrid();
        ddlMatCat_SelectedIndexChanged(sender, e);
    }
    public void EnableTrueFalseStep2(bool Bool)
    {
        txtpodt.Enabled = Bool;
        txtManPONo.Enabled = Bool;
        txtkind.Enabled = Bool;
        Txt_Vendor.Enabled = Bool;
        trStep1.Visible = Bool;
        ddlMatCat.Enabled = Bool;
    }
    protected void ddlMatCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        for (int i = 0; i < GV_Details.Rows.Count; i++)
        {
            TextBox txtPackMaterial = (TextBox)GV_Details.Rows[i].FindControl("txtPackMaterial");
            TextBox txtTyreModel = (TextBox)GV_Details.Rows[i].FindControl("txtTyreModel");
            TextBox txtSparePart = (TextBox)GV_Details.Rows[i].FindControl("txtSparePart");
            TextBox txtGeneral = (TextBox)GV_Details.Rows[i].FindControl("txtGeneral");
            TextBox txtStationary = (TextBox)GV_Details.Rows[i].FindControl("txtStationary");
            TextBox txtFixAsset = (TextBox)GV_Details.Rows[i].FindControl("txtFixAsset");
            TextBox txtMfg = (TextBox)GV_Details.Rows[i].FindControl("txtMfg");
            TextBox txtTyreSize = (TextBox)GV_Details.Rows[i].FindControl("txtTyreSize");
            DropDownList ddlTyreType = (DropDownList)GV_Details.Rows[i].FindControl("ddlTyreType");
            Label lblItemHeader1 = (Label)GV_Details.Rows[i].FindControl("lblItemHeader1");
            Label lblItemHeader2 = (Label)GV_Details.Rows[i].FindControl("lblItemHeader2");
            Label lblItemHeader3 = (Label)GV_Details.Rows[i].FindControl("lblItemHeader3");
            if (HidMatCat.Value == "01")
            {
                txtPackMaterial.Visible = true;
                txtTyreModel.Visible = false;
                txtSparePart.Visible = false;
                txtGeneral.Visible = false;
                txtStationary.Visible = false;
                txtMfg.Visible = false;
                txtTyreSize.Visible = false;
                ddlTyreType.Visible = false;
                txtFixAsset.Visible = false;
            }
            else if (HidMatCat.Value == "02")
            {
                txtPackMaterial.Visible = false;
                txtTyreModel.Visible = true;
                txtStationary.Visible = false;
                txtMfg.Visible = true;
                txtTyreSize.Visible = true;
                ddlTyreType.Visible = true;
                txtSparePart.Visible = false;
                txtGeneral.Visible = false;
                txtFixAsset.Visible = false;
                string SQl = "Select '--SELECT--' as CodeDesc,'' AS CodeID union select CodeDesc,CodeID from webx_master_general where codetype ='TYTYP'";
                DataTable dt = new DataTable();
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQl).Tables[0];
                ddlTyreType.DataTextField = "CodeDesc";
                ddlTyreType.DataValueField = "CodeID";
                ddlTyreType.DataSource = dt;
                ddlTyreType.DataBind();
            }
            else if (HidMatCat.Value == "03")
            {
                txtPackMaterial.Visible = false;
                txtTyreModel.Visible = false;
                txtSparePart.Visible = true;
                txtGeneral.Visible = false;
                txtStationary.Visible = false;
                txtMfg.Visible = false;
                txtTyreSize.Visible = false;
                ddlTyreType.Visible = false;
                txtFixAsset.Visible = false;
            }
            else if (HidMatCat.Value == "04")
            {
                txtPackMaterial.Visible = false;
                txtTyreModel.Visible = false;
                txtSparePart.Visible = false;
                txtGeneral.Visible = true;
                txtStationary.Visible = false;
                txtMfg.Visible = false;
                txtTyreSize.Visible = false;
                ddlTyreType.Visible = false;
                txtFixAsset.Visible = false;
            }
            else if (HidMatCat.Value == "05" || HidMatCat.Value == "5")
            {
                txtPackMaterial.Visible = false;
                txtTyreModel.Visible = false;
                txtSparePart.Visible = false;
                txtGeneral.Visible = false;
                txtStationary.Visible = false;
                txtMfg.Visible = false;
                txtTyreSize.Visible = false;
                ddlTyreType.Visible = false;
                txtFixAsset.Visible = true;
            }
            else
            {
                txtPackMaterial.Visible = false;
                txtTyreModel.Visible = false;
                txtSparePart.Visible = false;
                txtGeneral.Visible = false;
                txtStationary.Visible = true;
                txtMfg.Visible = false;
                txtTyreSize.Visible = false;
                ddlTyreType.Visible = false;
                txtFixAsset.Visible = false;
            }
        }
    }
}


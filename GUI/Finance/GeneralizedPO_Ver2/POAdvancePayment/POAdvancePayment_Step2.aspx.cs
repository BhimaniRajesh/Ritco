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

public partial class GUI_Finance_GeneralizedPO_GRNGeneration_SinglePO_GRN_DataList : System.Web.UI.Page
{
    string POCode = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsCallback && !IsPostBack)
        {
            POCode = Request.QueryString["POList"].ToString();
            BindGrid();
        }
    }
    public void BindGrid()
    {
        DataTable dtDocket = new DataTable();
        string SQLStr = "select pocode,VendorName=(SELECT vendorcode+' : '+vendorname FROM webx_vendor_hdr where vendorcode=VENDORCD),GrandTotal=ISNULL(totalamt,0),PO_advamt,PO_balamt from webx_GENERAL_POASSET_HDR where pocode='" + POCode + "'";
        dtDocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        if (dtDocket.Rows.Count>0)
        {
            DataRow ResultDtlRow = dtDocket.Rows[0];
            lblPOCode.Text = ResultDtlRow["pocode"].ToString();
            lblVendorCode.Text = ResultDtlRow["VendorName"].ToString();
            TxtPOAmt.Text = ResultDtlRow["GrandTotal"].ToString();
            txtbalamt.Text = ResultDtlRow["PO_balamt"].ToString();
            txtadv.Text = ResultDtlRow["PO_advamt"].ToString();
        }
    }
    protected void ButSubmit_Click(object sender, EventArgs e)
    {

        string sql = "", TranXaction = "", Adv_VocherNo="";
        try
        {
            DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
            DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
            DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
            TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");
            TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
            TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
            TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
            TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");

            string ChqNo = txtChqNo.Text.ToString();
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
                    if (ChqAmt == "" || ChqAmt == null || txtChqNo.Text.ToString() == "")
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

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlTransaction trans;
            trans = conn.BeginTransaction();
            try
            {
                sql = "UPDATE WEBX_GENERAL_POASSET_HDR SET Chqno='" + ChqNo + "',chqdate='" + ChqDate + "',PayMode='" + PayMode + "',Bank_Accode='" + Bankaccode + "',Cash_Accode='" + Cashcode + "',cashamt=" + Convert.ToDecimal(CashAmt) + ",chqamt=" + Convert.ToDecimal(ChqAmt) + " WHERE pocode='" + lblPOCode.Text.ToString().Trim() + "'";
                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, sql);

                sql = "usp_GeneralPO_Advance_Transaction_Ver2";
                SqlParameter[] arParms = new SqlParameter[2];
                arParms[0] = ControllersHelper.GetSqlParameter("@POCODE", lblPOCode.Text.ToString().Trim(), SqlDbType.Text);
                arParms[1] = ControllersHelper.GetSqlParameter("@Finyear", Session["FinYear"].ToString(), SqlDbType.VarChar);
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
            Response.Redirect("POAdvancePayment_Done.aspx?VoucherNo=" + Adv_VocherNo, false);
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
        
    }
}

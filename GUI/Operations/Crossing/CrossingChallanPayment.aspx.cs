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

public partial class GUI_Operations_Crossing_CrossingChallanPayment : System.Web.UI.Page
{
    SqlConnection conn;
    string sqlDocket = "", DateFrom, DateTO, CrossingChallan, Vendor, Financial_Year = "", NewVoucherNo = "", sql_Account = "";
    string vendorCode = "", VendorName = "", bankCode, caseCode, chqdt;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        DateFrom = Convert.ToString(Request.QueryString["DateFrom"]);
        DateTO = Convert.ToString(Request.QueryString["DateTO"]);
        CrossingChallan = Convert.ToString(Request.QueryString["CrossingChallan"]);

        Vendor = Convert.ToString(Request.QueryString["Vendor"]);
        
        txtVoucherDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        if (DateFrom != "")
        {
            f = Convert.ToDateTime(Request.QueryString["DateFrom"]);
            t = Convert.ToDateTime(Request.QueryString["DateTO"]);
        }
        else
        {
            f = System.DateTime.Now;
            t = System.DateTime.Now;
        }
        if (!IsPostBack)
        {

            CrossingChallanList();
            txtChqNo.Enabled = false;
            txtChqDate.Enabled = false;
        }
    }

    private void CrossingChallanList()
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sqlDocket = "exec usp_Crossing_for_Payment '" + CrossingChallan + "','" + f + "','" + t + "','" + Session["BRCD"].ToString() + "'";
        SqlCommand cmd = new SqlCommand(sqlDocket, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sqlDA.Fill(ds);
        CrossingChallanDetail.DataSource = ds;
        CrossingChallanDetail.DataBind();
        conn.Close();
    }
    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd;
        SqlDataReader dr;
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
            txtChqNo.Enabled = false;
            txtChqDate.Enabled = false;
            txtChqNo.Text = "";
            txtChqNo.Text = "";
            ddrBankaccode.SelectedValue = "";
            ddrBankaccode.Enabled = true;
            txtChqDate.Text = "";

            lblCash_Bank.Text = "Cash";
            ddrBankaccode.Items.Clear();
            string strSql = " select top 1 '' as asscodeval,'--Select--' as accdesc Union  select acccode as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrBankaccode.CssClass = "blackfnt";
        }
        else if (ddlPayMode.SelectedItem.Text == "Bank")
        {


            txtChqNo.Enabled = true;
            txtChqDate.Enabled = true;
            txtChqNo.Text = "";
            txtChqNo.Text = "";
            txtChqDate.Text = "";


            ddrBankaccode.Enabled = true;
            //txtChqDate.Enabled = true;
            lblCash_Bank.Text = "Bank";
            ddrBankaccode.Items.Clear();

            string strSql = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddrBankaccode.CssClass = "blackfnt";

        }
        con.Close();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        btnsubmit.Visible = false;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            string sql_VoucherNo = "usp_next_VoucherNumber";
            SqlCommand cmd = new SqlCommand(sql_VoucherNo, conn, trn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["BRCD"].ToString();
            cmd.Parameters.Add("@finyear", SqlDbType.VarChar).Value = Financial_Year.ToString();
            cmd.Parameters.Add("@NextVoucherNo", SqlDbType.VarChar).Value = "";
            SqlDataReader dr = null;
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                NewVoucherNo = Convert.ToString(dr[0]);
            }
            dr.Close();

            if (ddlPayMode.SelectedItem.Text == "Cash")
            {
                bankCode = "NULL";
                caseCode = "'" + ddrBankaccode.SelectedValue.ToString() + "'";
                chqdt = "NULL";
            }
            else
            {
                bankCode = "'" + ddrBankaccode.SelectedValue.ToString() + "'";
                caseCode = "NULL";
                chqdt = "'" + fn.Mydate(txtChqDate.Text) + "'";
                //chqdt = "'" + txtChqDate.Text + "'";
            }
            //MyFunctions fn = new MyFunctions();
            
            VendorName = fn.GetVendor_name(Vendor);
            string sqlCrossingMasterEntry = "INSERT INTO Webx_CrossingChallan_Payment_Master(VoucherNo,VendorType,VendorCode,VendorName,TotalAmtPayable,TotalDeduction,TotalNetPayable,PayMode,CashAccCode,";
            sqlCrossingMasterEntry += "ChequeNo,ChequeDate,BankAccCode,EntryBy,EntryDate,Cancel) VALUES";
            sqlCrossingMasterEntry += "('" + NewVoucherNo + "','18','" + Vendor + "','" + VendorName + "'," + txtTotalAmountPayables.Text + "," + txtTotalDeductions.Text + "," + txtTotalNetPayables.Text + ",'" + ddlPayMode.SelectedItem.Text + "'," + caseCode + ",";
            sqlCrossingMasterEntry += "'" + txtChqNo.Text + "'," + chqdt + "," + bankCode + ",'" + Session["BRCD"].ToString() + "',GetDate(),'N')";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlCrossingMasterEntry);

            foreach (GridViewRow gridrow in CrossingChallanDetail.Rows)
            {
                CheckBox CHKDET = (CheckBox)gridrow.FindControl("CHKDET");
                Label lblCrossingno = (Label)gridrow.FindControl("lblCrossingno");
                Label lblChallanDate = (Label)gridrow.FindControl("lblChallanDate");
                TextBox txtAmountpayable = (TextBox)gridrow.FindControl("txtAmountpayable");
                TextBox txtDeductions = (TextBox)gridrow.FindControl("txtDeductions");
                TextBox txtNetPayable = (TextBox)gridrow.FindControl("txtNetPayable");
                HiddenField hdnVendorCode = (HiddenField)gridrow.FindControl("hdnVendorCode");
                HiddenField hdnVendorName = (HiddenField)gridrow.FindControl("hdnVendorName");

                if (CHKDET.Checked)
                {
                    //vendorCode = hdnVendorCode.Value;
                    //VendorName = hdnVendorName.Value;

                    string sqlCrossingDetailEntry = "INSERT INTO Webx_CrossingChallan_Payment_Detail(CrossingChallanNo,ChallanDate,AmountPayable,Deduction,NetPayable,VoucherNo,Cancel,";
                    sqlCrossingDetailEntry += "EntryBy,EntryDate) VALUES";
                    sqlCrossingDetailEntry += "('" + lblCrossingno.Text + "','" + lblChallanDate.Text + "'," + txtAmountpayable.Text + "," + txtDeductions.Text + "," + txtNetPayable.Text + ",'" + NewVoucherNo + "',";
                    sqlCrossingDetailEntry += "'N','" + Session["BRCD"].ToString() + "',GetDate())";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlCrossingDetailEntry);

                    string sqlUpdateCrossing = "UPDATE Webx_Crossing_Docket_Master SET PaymentFlag='Y' WHERE CrossingChallanNo='" + lblCrossingno.Text + "'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlUpdateCrossing);

                    Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
                    sql_Account = "exec USP_CROSSINGTRANSACTION_PAYMENT  1,'" + lblCrossingno.Text + "','" + Financial_Year + "','" + Session["BRCD"].ToString() + "','" + NewVoucherNo + "'";
                    SqlCommand cmdAccount = new SqlCommand(sql_Account, conn, trn);
                    cmdAccount.ExecuteNonQuery();

                }
            }

            //trn.Rollback();
            trn.Commit();
        }
        catch (Exception e1)
        {
            //Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            //string msg = e1.Message.ToString();
            //msg = msg.Replace('\n', ' ');
            throw e1;
            trn.Rollback();
            //Response.End();

        }

        conn.Close();

        string final = "";
        final = "VoucherNo=" + NewVoucherNo;
        Response.Redirect("CrossingChallanPaymentDone.aspx?" + final);
    }
}


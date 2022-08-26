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

public partial class UserControls_MyReceiptControl : System.Web.UI.UserControl
{

    string connStr;
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["SqlProvider"] = "Data Source=124.247.224.12;Initial Catalog=Varuna_Test_Net;UID=sa;pwd=varuna@123";
        connStr = Session["SqlProvider"].ToString().Trim();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        if (!Page.IsPostBack)
        {
             txtCashAmt.Attributes.Add("onblur", "javascript:CheckCashBank_Receipt()");
             txtChqAmt.Attributes.Add("onblur", "javascript:CheckCashBank_Receipt()");
              
             string sql = "";
             SqlCommand sqlcmd;
             SqlDataReader dr;
             sql = "select Acccode as code , accdesc+':'+company_acccode as name from Vw_Tds_Recivable With(NOLOCK)";
            SqlCommand cmd_pbov = new SqlCommand(sql, con);
            SqlDataReader dr_Tds;
            dr_Tds = cmd_pbov.ExecuteReader();
            DDL_Tdstype.Items.Clear();
            DDL_Tdstype.CssClass = "blackfnt";
            DDL_Tdstype.Items.Add(new ListItem("Select", ""));
            while (dr_Tds.Read())
            {
                DDL_Tdstype.Items.Add(new ListItem(dr_Tds.GetValue(1).ToString(), dr_Tds.GetValue(0).ToString()));
            }
            dr_Tds.Close();
            DDL_Tdstype.Items.ToString().ToUpper();
            con.Close();
        }
    }


    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
            txtCashAmt.Text = txtNetPay.Text;
            Txt_ColAmt.Text = "0.00";//txtNetPay.Text;
            //txtCashAmt.Enabled = false;
            txtCashAmt.Enabled = false;
            ddrCashcode.Enabled = true;

            //txtChqAmt.Enabled = false;
            txtChqAmt.Enabled = false;
            txtChqNo.Enabled = false;
            txtChqAmt.Text = "0.00";
            txtChqNo.Text = "";
            //txtBank.Enabled = false;
            //txtChqAmt.Text = "";
            txtChqNo.Text = "";

            ddrBankaccode.SelectedValue = "";
            ddrBankaccode.Enabled = false;
            txtChqDate.Text = "";
            txtChqDate.Enabled = false;

            ddrCashcode.Items.Clear();
            string strSql = " select top 1 '' as asscodeval,'--Select--' as accdesc Union  select acccode as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrCashcode.CssClass = "blackfnt";
        }
        else if (ddlPayMode.SelectedItem.Text == "Bank")
        {
            //txtCashAmt.Enabled = false;
            txtCashAmt.Enabled = false;
            txtCashAmt.Text = "0.00";
            ddrCashcode.SelectedValue = "";
            ddrCashcode.Enabled = false;

            txtChqAmt.Enabled = true;
           // txtChqAmt.Enabled = false;
            txtChqNo.Enabled = true;
            //txtBank.Enabled = true;
            txtChqAmt.Text = txtNetPay.Text;
            Txt_ColAmt.Text = txtNetPay.Text;
           // txtCashAmt.Text = "";

            ddrBankaccode.Enabled = true;
            txtChqDate.Enabled = true;

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
        else if (ddlPayMode.SelectedItem.Text == "Both")
        {
            //txtCashAmt.Enabled = true;
            //txtChqAmt.Enabled = true;
            txtCashAmt.Text = "0.00";
            txtChqAmt.Text = "0.00";
            txtCashAmt.Enabled = true;
            txtChqAmt.Enabled = true;

            txtChqNo.Enabled = true;
            txtChqDate.Enabled = true;
            ddrBankaccode.Enabled = true;
            ddrCashcode.Enabled = true;

            ddrCashcode.Items.Clear();
            string strSql = " select top 1 '' as asscodeval,'--Select--' as accdesc Union  select acccode as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddrBankaccode.Items.Clear();
            string strSql1 = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql1, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddrCashcode.CssClass = "blackfnt";
            ddrBankaccode.CssClass = "blackfnt";
            //txtBank.Enabled = true;
        }
    }
}

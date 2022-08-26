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

public partial class GUI_Finance_Cheque_Deposit_ChqDepositVoucher_step2 : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    SqlDataAdapter da;
    MyFunctions myFunc;
    string option, chqno, chqdt, dateFrom, dateTo, Financial_Year;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        myFunc = new MyFunctions();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        string fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        if (!IsPostBack)
        {   
            string strSql = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(strSql, con);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            string option = Request.QueryString["option"];
            string datetype = Request.QueryString["datetype"];
            if (option == "1")
            {
                chqno = Request.QueryString["chqno"];
            }
            else
            {
                string strDateFrom = Request.QueryString["DateFrom"];
                string strDateTo = Request.QueryString["DateTo"];

                dateFrom = myFunc.Mydate1(strDateFrom);
                dateTo = myFunc.Mydate1(strDateTo);
            }
            if (option == "1")
            {
                dateFrom = "";
                dateTo = "";
            }
            if (option == "2")
            {
                chqno = "All";
            }

            string table = "webx_acctrans_" + fin_year;

            string sql = "exec usp_depovoucher_chqlist_ver1 '" + chqno + "','" + dateFrom + "','" + dateTo + "','" + Session["brcd"].ToString() + "','" + datetype + "','','" + table + "'";

            cmd = new SqlCommand(sql, con);
            da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            da.Fill(ds);

            dgGeneral.DataSource = ds;
            dgGeneral.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {   
        string Voucherno = myFunc.NextVoucherno(Session["brcd"].ToString(), Financial_Year);
        
        string[] VDate = txtVoucherDate.Text.Split('/');
        string VoucherDate = Convert.ToDateTime(VDate[1] + "/" + VDate[0] + "/" + VDate[2]).ToString("yyyy/MM/dd");

        SqlTransaction trans;
        trans = con.BeginTransaction();

        try
        {
            foreach (GridViewRow gr in dgGeneral.Rows)
            {
                HtmlInputCheckBox chkbox = ((HtmlInputCheckBox)gr.FindControl("chkchqno"));
                if (chkbox.Checked)
                {
                    string[] cbox = chkbox.Value.Split('|');
                    string chqindex = cbox[0].ToString();

                    string sql_Acctrans = "exec usp_ChequeTranscation_ver1 '" + Voucherno + "','" + VoucherDate + "','" + chqindex + "','" + Financial_Year + "','" + txtNarration.Text + "','" + Session["empcd"].ToString() + "','" + ddrBankaccode.SelectedValue.ToString() + "'";
                    cmd = new SqlCommand(sql_Acctrans, con, trans);
                    cmd.ExecuteNonQuery();
                }
            }
            trans.Commit();
            con.Close();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + msg);
            Response.End();
        }

        Response.Redirect("ChequeDeposit_Done.aspx?VoucherType=Cheque&VoucherNo=" + Voucherno);
    }
}

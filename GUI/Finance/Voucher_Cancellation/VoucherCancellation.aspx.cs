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

public partial class GUI_Operations_VoucherCancellation : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    public string Financial_Year = "", fin_year = "", mseg="";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }
    }
    protected void btnRows_Click(object sender, EventArgs e)
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

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();

    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtVoucherNo")).Attributes.Add("onblur", "voucherBlur('" + ((TextBox)e.Row.FindControl("txtVoucherNo")).ClientID.ToString() + "')");
            ((CheckBox)e.Row.FindControl("ChkSel")).Attributes.Add("onclick", "VisibleDate('" + ((CheckBox)e.Row.FindControl("ChkSel")).ClientID.ToString() + "','" + ((Panel)e.Row.FindControl("pnlDate")).ClientID.ToString() + "')");
            string VCD = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("txtVCDate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkBtnVCDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkBtnVCDate")).Attributes.Add("onclick", VCD);
        }
    }
    protected void submit(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString().Substring(2, 2);
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        string fin_year_table = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        string qry = "";

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        foreach (GridViewRow gr in grvcontrols.Rows)
        {
            CheckBox ChkSel = (CheckBox)gr.FindControl("ChkSel");
            TextBox txtVCDate = (TextBox)gr.FindControl("txtVCDate");
            TextBox txtVoucherNo = (TextBox)gr.FindControl("txtVoucherNo");

            if (txtVoucherNo.Text != "")
            {
                //string[] dat = txtVCDate.Text.Split('/');

                //string candate = dat[1].ToString() + "/" + dat[0].ToString() + "/" + dat[2].ToString();
                //DateTime canceldate = Convert.ToDateTime(candate);

                SqlTransaction trans;
                trans = con.BeginTransaction();
                try
                {
                    qry = "select count(*) from webx_acctrans_" + fin_year_table + " where isnull(voucher_cancel,'N')='N' and voucherno='" + txtVoucherNo.Text + "' and opertitle in('MANUAL CONTRA VOUCHER','MANUAL CREDIT VOUCHER','MANUAL DEBIT VOUCHER','MANUAL JOURNAL VOUCHER','SPECIAL COST VOUCHER')";
                    double count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, qry));

                    if (count > 0)
                    {
                        qry = "exec usp_ManualVoucherCancellation_Ver1 '" + fin_year + "','" + txtVoucherNo.Text + "','" + txtVCDate.Text + "','" + Session["empcd"].ToString() + "','" + txtcancel.Text + "'";
                        SqlCommand cmd = new SqlCommand(qry, con, trans);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        throw new Exception("You Cant Cancel Vouchers other than Manual Vouchers");
                    }
                    //qry = "UPDATE webx_acctrans_" + fin_year + " WITH(ROWLOCK) SET voucher_cancel='Y',v_closed_dt = '" + canceldate + "',comment='" + txtcancel.Text + "' where voucherno='" + txtVoucherNo.Text + "'";
                    //SqlCommand cmd = new SqlCommand(qry, con, trans);
                    //cmd.ExecuteNonQuery();

                    //qry = "UPDATE webx_vouchertrans_arch WITH(ROWLOCK) SET voucher_cancel='Y',v_closed_dt = '" + canceldate + "',Cancel_Reason='" + txtcancel.Text + "' where voucherno='" + txtVoucherNo.Text + "'";
                    //cmd = new SqlCommand(qry, con, trans);
                    //cmd.ExecuteNonQuery();

                    mseg += txtVoucherNo.Text + ",";
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
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Manual Voucher Cancellation " + "&ErrorMsg=" + msg);
                    //Response.End();
                }
            }
        }
        mseg = mseg.Substring(0, mseg.Length - 1);
        Response.Redirect("VoucherCancellation_done.aspx?vouchernos=" + mseg);
    }
}

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

public partial class GUI_Finance_Accounts_ReAssignVoucherDate : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    public string mseg;
    public static string Financial_Year = "", fin_year = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        btnrows.Attributes.Add("onclick", "javascript:return addRows()");
        btnsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");

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


    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string s = "cal.select(" + ((TextBox)e.Row.FindControl("txtnewdate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkdate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((TextBox)e.Row.FindControl("txtvoucherno")).Attributes.Add("onblur", "voucherBlur('" + ((TextBox)e.Row.FindControl("txtvoucherno")).ClientID.ToString() + "')");
            ((LinkButton)e.Row.FindControl("lnkdate")).Attributes.Add("onclick", s);
        }
    }

    protected void btnrows_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtnorows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtnorows.Text);
            }
            catch (Exception ex)
            {
                txtnorows.Text = "";
                txtnorows.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int cnt = 0;
        mseg = "";

        for (int i = 0; i < grvcontrols.Rows.Count; i++)
        {
            TextBox txtvoucherno = (TextBox)grvcontrols.Rows[i].FindControl("txtvoucherno");
            TextBox txtnewdate = (TextBox)grvcontrols.Rows[i].FindControl("txtnewdate");

            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();


            /**********************************************************************************************************
                                  YEAR SUFFIX IS NEED BECAUSE ACCTRANS TABLE IS CHANGED EVERY YEAR
             *                    IT IS A FINANCIAL YEAR STARTING FORM 1 APRIL
             * *******************************************************************************************************/


            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

            string qry = "";
            SqlTransaction trans;

            //string[] datearr = txtnewdate.Text.Split('/');
            //string newdate = datearr[1] + "/" + datearr[0] + "/" + datearr[2];

            trans = con.BeginTransaction();
            try
            {
                if (txtvoucherno.Text != "")
                {
                    string[] datearr = txtnewdate.Text.Split('/');
                    string newdate = datearr[1] + "/" + datearr[0] + "/" + datearr[2];

                    qry = "UPDATE webx_acctrans_" + fin_year + " WITH(ROWLOCK) SET transdate='" + newdate + "' where voucherno='" + txtvoucherno.Text + "' and Voucher_Cancel='N'";
                    SqlCommand cmd = new SqlCommand(qry, con, trans);
                    cmd.ExecuteNonQuery();

                    qry = "UPDATE WEBX_VOUCHERTRANS_ARCH WITH(ROWLOCK) SET transdate='" + newdate + "' where voucherno='" + txtvoucherno.Text + "' and Voucher_Cancel='N'";
                    cmd = new SqlCommand(qry, con, trans);
                    cmd.ExecuteNonQuery();

                    trans.Commit();
                    con.Close();
                    mseg += txtvoucherno.Text.ToString() + ",";

                }
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
            
        }
        //mseg = Convert.ToString(cnt) + " Vouchers Updated Successfully";
        mseg = mseg + " Vouchers Updated Successfully";
        Response.Redirect("Message.aspx?message=" + mseg);
    }

}

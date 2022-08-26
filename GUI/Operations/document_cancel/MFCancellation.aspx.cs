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

public partial class GUI_Operations_document_cancel_MFCancellation : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    public string sql = "", sql1 = "", Vno;
    public static string AcctOpenTable, finyearstart, yearSuffix, YearString;
    public static string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year = "";
    MyFunctions fn = new MyFunctions();

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

            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');


            String Year = Session["FinYear"].ToString();
            string abc = Year.Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
            yearSuffix = YearString;
            finyearstart = "01 APR " + abc;
            AcctOpenTable = "webx_acctrans_" + yearSuffix;
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
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtMFNo")).Attributes.Add("onblur", "MFBlur('" + ((TextBox)e.Row.FindControl("txtMFNo")).ClientID.ToString() + "')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < grvcontrols.Rows.Count; i++)
        {
            TextBox txtMFNumber = (TextBox)grvcontrols.Rows[i].FindControl("txtMFNo");
            CheckBox ChkSel = (CheckBox)grvcontrols.Rows[i].FindControl("ChkSel");

            if (ChkSel.Checked == true)
            {
                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();

                SqlTransaction trn;
                trn = con.BeginTransaction();

                string EntryBy = Session["empcd"].ToString();
                string UpdateBy = Session["empcd"].ToString();

                try
                {
                    string sql = "Exec usp_Manifest_Do_Cancel '" + txtMFNumber.Text + "','" + Session["empcd"].ToString().Trim() + "'";
                    SqlCommand cmdTC = new SqlCommand(sql, con, trn);
                    cmdTC.ExecuteNonQuery();

                    trn.Commit();

                    con.Close();

                }
                catch (Exception e1)
                {
                    Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
                    string msg = e1.Message.ToString();
                    msg = msg.Replace('\n', ' ');
                    trn.Rollback();
                    Response.End();
                }

            }
        }
        Response.Redirect("./MF_CancellationDone.aspx?");

    }
}

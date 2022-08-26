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

public partial class GUI_Operations_Crossing_Exception_CrossingChallanCancellation : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    public string sql = "", sql1 = "", Vno, EntryBy, VoucherNo;
    public string AcctOpenTable, finyearstart, yearSuffix, YearString;
    public string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year = "";
    MyFunctions fn = new MyFunctions();
    string TripsheetNo = "", CountTripsheetNo = "";

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
            ((TextBox)e.Row.FindControl("txtChallanNo")).Attributes.Add("onblur", "ChallanData('" + ((TextBox)e.Row.FindControl("txtChallanNo")).ClientID.ToString() + "')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {

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

        for (int i = 0; i < grvcontrols.Rows.Count; i++)
        {
            TextBox txtChallanNo = (TextBox)grvcontrols.Rows[i].FindControl("txtChallanNo");
            CheckBox ChkSel = (CheckBox)grvcontrols.Rows[i].FindControl("ChkSel");

            if (ChkSel.Checked == true)
            {
                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();

                SqlTransaction trn;
                trn = con.BeginTransaction();

                EntryBy = Session["empcd"].ToString();
                string UpdateBy = Session["empcd"].ToString();

                try
                {
                        
                    string sql_update1 = "UPDATE Webx_Crossing_Docket_Detail SET Cancel='Y' WHERE Crossingchallan='" + txtChallanNo.Text + "'";
                    SqlCommand cmdTCHDR = new SqlCommand(sql_update1, con, trn);
                    cmdTCHDR.ExecuteNonQuery();

                    string sql_update2 = "UPDATE Webx_Crossing_Docket_Master SET Cancel='Y',CancelledBy='" + EntryBy + "' WHERE CrossingchallanNo='" + txtChallanNo.Text + "'";
                    SqlCommand cmdDKT = new SqlCommand(sql_update2, con, trn);
                    cmdDKT.ExecuteNonQuery();

                    string sql_update3 = "UPDATE webx_trans_docket_status SET Delivered='N',Dely_Date=NULL,CrossingchallanNo=NULL,Op_Status=' Pending For Crossing Challan' WHERE CrossingchallanNo='" + txtChallanNo.Text + "'";
                    SqlCommand cmdTHC = new SqlCommand(sql_update3, con, trn);
                    cmdTHC.ExecuteNonQuery();

                    string sql_Account = "UPDATE " + AcctOpenTable + " set voucher_cancel='Y' where docno='" + txtChallanNo.Text + "' and Opertitle='CROSSING OPERATION' and Narration like '%WHEN CROSSING CHALLAN IS MADE%'";
                    SqlCommand cmdAccount = new SqlCommand(sql_Account, con, trn);
                    cmdAccount.ExecuteNonQuery();
                    //trn.Rollback();
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
        Response.Redirect("./CrossingChallanCancellationDone.aspx?");

    }
}

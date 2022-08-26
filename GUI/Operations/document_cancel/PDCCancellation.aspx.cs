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

public partial class GUI_Operations_document_cancel_PDCCancellation : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    public string sql = "", sql1 = "", Vno,PDCTYPE;
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
            ((TextBox)e.Row.FindControl("txtPDCNo")).Attributes.Add("onblur", "THCBlur('" + ((TextBox)e.Row.FindControl("txtPDCNo")).ClientID.ToString() + "')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < grvcontrols.Rows.Count; i++)
        {
            TextBox txtPDCNumber = (TextBox)grvcontrols.Rows[i].FindControl("txtPDCNo");
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
                    string SQL_PRSDRS = "Select PDCTY from webx_PDCHDR where PDCNO='" + txtPDCNumber.Text + "'";
                    SqlCommand cmdPRSDRS = new SqlCommand(SQL_PRSDRS, con, trn);
                    SqlDataReader drPRSDRS;
                    drPRSDRS = cmdPRSDRS.ExecuteReader();
                    string sql_update2;
                   
                    SqlCommand cmdDKT;
                    while (drPRSDRS.Read())
                    {
                        PDCTYPE = drPRSDRS["PDCTY"].ToString();
                        
                    }
                    drPRSDRS.Close();

                    if (PDCTYPE == "P")
                    {
                        sql_update2 = "Update WebX_Trans_Docket_Status  SET PRS = NULL,Delivered = 'N',Dely_Date = NULL where PRS ='" + txtPDCNumber.Text + "'";
                        cmdDKT = new SqlCommand(sql_update2, con, trn);
                        cmdDKT.ExecuteNonQuery();
                    }
                    else if (PDCTYPE == "D")
                    {
                        sql_update2 = "Update WebX_Trans_Docket_Status  SET DRS = NULL,Delivered = 'N',Dely_Date = NULL where DRS ='" + txtPDCNumber.Text + "'";
                        cmdDKT = new SqlCommand(sql_update2, con, trn);
                        cmdDKT.ExecuteNonQuery();
                    }
                    string sql_update1 = "Update webx_PDCHDR set Cancelled = 'Y',PDCCancelledOn=getdate(),PDCCancelledBy='" + EntryBy + "' where PDCNO='" + txtPDCNumber.Text + "'";
                    SqlCommand cmdTCHDR = new SqlCommand(sql_update1, con, trn);
                    cmdTCHDR.ExecuteNonQuery();

                    sql_update1 = "EXEC usp_PDCTransaction_Cancel 1,'" + txtPDCNumber.Text + "','.','" + Financial_Year + "','" + EntryBy + "',''";
                    cmdTCHDR = new SqlCommand(sql_update1, con, trn);
                    cmdTCHDR.ExecuteNonQuery();

                    //sql_update1 = "EXEC usp_PDCTransaction_Cancel 2,'" + txtPDCNumber.Text + "','.','" + Financial_Year + "','" + EntryBy + "',''";
                    //cmdTCHDR = new SqlCommand(sql_update1, con, trn);
                    //cmdTCHDR.ExecuteNonQuery();

                    //sql = "update " + AcctOpenTable + " set Voucher_Cancel='Y' WHERE docno='" + txtTHCNumber.Text + "'";
                    //cmd = new SqlCommand(sql, con, trn);
                    //cmd.ExecuteNonQuery();

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
        Response.Redirect("./PDC_CancellationDone.aspx?");

    }
}

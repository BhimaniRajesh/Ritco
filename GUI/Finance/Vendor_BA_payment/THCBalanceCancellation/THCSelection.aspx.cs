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

public partial class GUI_Finance_Vendor_BA_payment_THCBalanceCancellation_THCSelection : System.Web.UI.Page
{
    public string VoucherNo, THCNO, ManualNo, dtFrom, dtTo, VehicleNo, sql, SessionBranch, fromdt, todt, s2 = "", RouteMode = "";
    public static string AdvanceBalance, Financial_Year = "";
    public string[] VoucherArray;
    public int intTotalRecords;
    public string getVoucherno;
    int i;
    SqlCommand cmd;
    SqlDataAdapter sqlDA;
    DataSet ds;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        if (!IsPostBack)
        {
            BindGrid();
        }
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        VoucherNo = Convert.ToString(Request.QueryString["DocumentNo"]);
        THCNO = Convert.ToString(Request.QueryString["THCNO"]);
        SessionBranch = Session["BRCD"].ToString();
        lblDocType.Text = "THC";

        string str_datecls = "", str_manulthcno = "", str_vehno = "", str_voucherno = "";

        if (VoucherNo != "")
        {
            VoucherArray = VoucherNo.Split(',');

            for (i = 0; i < VoucherArray.Length; i++)
            {
                s2 += "'" + VoucherArray[i] + "',";
            }
            s2 = s2.Substring(0, s2.Length - 1);
            str_voucherno = " and T.balvoucherno in ( " + s2 + " ) ";
            sql = "select balvoucherno,Sum(netbalamt) as balanceamount,THCNO=(select [dbo].[FN_THC_VRNO_BAL](" + s2 + ")) from webx_thc_summary with(NOLOCK) where ISNULL(FromModule,'') != 'NEWMVC' AND balvoucherno=(" + s2 + ") group by balvoucherno";
        }
        else if (THCNO != "")
        {
            conn.Open();
            string sqlthcno = "select top 1 balvoucherno from webx_thc_summary with(NOLOCK) where thcno = '" + THCNO + "'";
            SqlCommand cmdTHC = new SqlCommand(sqlthcno, conn);
            SqlDataReader drTHC;
            drTHC = cmdTHC.ExecuteReader();
            sql = "";
            if (drTHC.Read())
            {
                getVoucherno = Convert.ToString(drTHC["balvoucherno"]);
                s2 = getVoucherno;
                sql = "select balvoucherno,Sum(netbalamt) as balanceamount,THCNO=(select [dbo].[FN_THC_VRNO_BAL]('" + s2 + "')) from webx_thc_summary with(NOLOCK) where ISNULL(FromModule,'') != 'NEWMVC' AND balvoucherno=('" + s2 + "') group by balvoucherno";
            }
            drTHC.Close();
        }
        if (sql != "")
        {
            cmd = new SqlCommand(sql, conn);
            sqlDA = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sqlDA.Fill(ds);

            GridTHCList.DataSource = ds;
            intTotalRecords = ds.Tables[0].Rows.Count;
            GridTHCList.DataBind();
        }
        else
        {
            Response.Redirect("../THCAdvanceCancellation/ErrorPage.aspx");
        }



    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridTHCList.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GridTHCList.Rows)
        {
            Label THCNO = (Label)gridrow.FindControl("lblTHCNO");
            Label VoucherNo = (Label)gridrow.FindControl("lblVoucherNo");

            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();

            SqlTransaction trn;
            trn = con.BeginTransaction();

            try
            {
                string[] THCNOArray = THCNO.Text.Split(',');
                for (int i = 0; i < THCNOArray.Length; i++)
                {
                    string sql_Adv_acct = "exec usp_THCTransaction_ADV_BAL_Cancel 2,'" + THCNOArray[i].ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + VoucherNo.Text + "'";
                    //Response.Write(sql_Adv_acct);
                    //Response.End();
                    SqlCommand Acct_cmd = new SqlCommand(sql_Adv_acct, con, trn);
                    Acct_cmd.ExecuteNonQuery();
                }
                string sql = "Exec usp_THCBalance_Do_Cancel '" + THCNO.Text + "','" + VoucherNo.Text + "'";
                SqlCommand cmdTC = new SqlCommand(sql, con, trn);
                cmdTC.ExecuteNonQuery();
 		cmdTC.CommandTimeout = 60;
                trn.Commit();
                //trn.Rollback();
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
            Response.Redirect("THCBalanceCacellationDone.aspx");
        }
    }
    protected void GridTHCList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputCheckBox chkyes = (HtmlInputCheckBox)(e.Row.FindControl("chkDock"));
            Label lblvoucherno = (Label)e.Row.FindControl("lblVoucherNo");

            chkyes.Attributes.Add("onclick", "javascript:return checkVoucherNo('" + chkyes.ClientID + "','" + lblvoucherno.ClientID + "')");
        }
    }
}

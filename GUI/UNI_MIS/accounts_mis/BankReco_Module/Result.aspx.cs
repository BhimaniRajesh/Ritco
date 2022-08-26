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

public partial class GUI_Finance_Fix_Asset_aaaaa : System.Web.UI.Page
{
    SqlConnection con;
    public static string straccd, p;
    DataTable dt = new DataTable("table1");
    public DataTable dt_san = new DataTable();
    MyFunctions fn = new MyFunctions();
    
    public byte byteRadButtonSelection;
    string LO = "",RO="", Bankcode = "", Fromdate = "", Todate = "";
    string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year = "";
    string openTable = "", transTable = "", DR_CR_type = "", TranType="";
    double Total_CR_amt = 0, Total_DR_amt = 0,CR_Amount=0,DR_Amount=0;
    double open_balance = 0.00;
    string DRCR = "", DRCR1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        openTable = "webx_acctopening_" + fin_year;
        transTable = "webx_acctrans_" + fin_year;

        LO = Request.QueryString["LO"].ToString().Trim();
        RO = Request.QueryString["RO"].ToString().Trim();
        Bankcode = Request.QueryString["Bankcode"].ToString().Trim();
        Fromdate = Request.QueryString["Fromdate"].ToString().Trim();
        Todate = Request.QueryString["Todate"].ToString().Trim();
        TranType = Request.QueryString["TranType"].ToString().Trim();
        Lb_RO.Text =RO;
        Lb_LO.Text = LO;
        LB_Bankcode.Text = fn.getAccountDesc("webx_acctinfo", Bankcode);
        Lb_dtaeraneg.Text = Fromdate.ToString() + "-" + Todate.ToString();
          con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
          con.Open();

        string tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) < convert(datetime, '" + Fromdate + "' ,106)";
       // Response.Write("<br>tranjaction-" + tranjaction);
        string opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + "   With(NOLOCK) where   acccode= '" + Bankcode + "'";
       //    Response.Write("<br>opening-" + opening);
        string Total_transactional = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + "  With(NOLOCK) where   Acccode= '" + Bankcode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) between convert(datetime, '" + Fromdate + "' ,106) and convert(datetime, '" + Todate + "' ,106) ";

        SqlCommand Cmd = new SqlCommand(tranjaction, con );
        SqlDataReader dtr = null;
        dtr = Cmd.ExecuteReader();
        string all_tranDr = "", all_tranCr = "", all_openDr = "", all_openCr = "", Trnas_Dr = "0", Trans_Cr = "0";
        double transactionCr = 0, transactionDr = 0, openCr = 0, openDr = 0, total_Debit = 0, total_Crebit=0,Total_Dr=0,Total_Cr=0;
                        while (dtr.Read())
                        {
                            all_tranDr = dtr["Debit"].ToString();
                            all_tranCr = dtr["Credit"].ToString();
                        }
                        //Response.Write("<br>all_tranDr-" + all_tranDr);
                        //Response.Write("<br>all_tranCr-" + all_tranCr);
                        dtr.Close();
                        if (Convert.ToDouble(all_tranDr) < Convert.ToDouble(all_tranCr))
                        {
                            transactionCr = Convert.ToDouble(all_tranCr) - Convert.ToDouble(all_tranDr);
                        }
                        else if (Convert.ToDouble(all_tranDr) > Convert.ToDouble(all_tranCr))
                        {
                            transactionDr = Convert.ToDouble(all_tranDr) - Convert.ToDouble(all_tranCr);
                        }
                        //Response.Write("<br>transactionCr-" + transactionCr);
                        //Response.Write("<br>transactionDr-" + transactionDr);
                        dtr.Close();
                        Cmd = new SqlCommand(opening, con);
                        dtr = Cmd.ExecuteReader();
                        while (dtr.Read())
                        {
                            all_openDr = dtr["opendebit_i"].ToString();
                            all_openCr = dtr["opencredit_i"].ToString();
                        }
                        dtr.Close();
                        if (Convert.ToDouble(all_openDr) < Convert.ToDouble(all_openCr))
                        {
                            openCr = Convert.ToDouble(all_openCr) - Convert.ToDouble(all_openDr);
                        }
                        else if (Convert.ToDouble(all_openDr) > Convert.ToDouble(all_openCr))
                        {
                            openDr = Convert.ToDouble(all_openDr) - Convert.ToDouble(all_openCr);
                        }
                        //Response.Write("<br>openCr-" + openCr);
                        //Response.Write("<br>openDr-" + openDr);

                        //***********Transaction  Balance   from Date - to date  Open ********************
                        Cmd = new SqlCommand(Total_transactional, con);
                        dtr = Cmd.ExecuteReader();
                        while (dtr.Read())
                        {
                            Trnas_Dr = dtr["Debit"].ToString();
                            Trans_Cr = dtr["Credit"].ToString();
                        }
                        dtr.Close();
                        Total_Dr = 0;
                        Total_Cr = 0;


                        if (Convert.ToDouble(Trnas_Dr) < Convert.ToDouble(Trans_Cr))
                        {
                            Total_Cr = Convert.ToDouble(Trans_Cr) - Convert.ToDouble(Trnas_Dr);
                        }
                        else if (Convert.ToDouble(Trnas_Dr) > Convert.ToDouble(Trans_Cr))
                        {
                            Total_Dr = Convert.ToDouble(Trnas_Dr) - Convert.ToDouble(Trans_Cr);
                        }
                        //***********Transaction  Balance   from Date - to date  Open ********************

                        total_Debit = transactionDr + openDr + Total_Dr;
                        total_Crebit = transactionCr + openCr + Total_Cr;
                        
                        if (total_Debit > total_Crebit)
                        {
                            open_balance = (total_Debit - total_Crebit);
                            DRCR = "DR";
                            lbl_Chq_Issued.Text = "Add : Cheques Issued but not presented ";
                            lbl_Chq_Recived.Text = "Less : Cheque Deposited But Not Cleared";
                        }
                        else if (total_Debit < total_Crebit)
                        {
                            open_balance = (total_Crebit - total_Debit);
                            DRCR = "CR";
                            lbl_Chq_Issued.Text = "Less : Cheques Issued but not presented ";
                            lbl_Chq_Recived.Text = "Add : Cheque Deposited But Not Cleared";
                        }
                        dtr.Close();
                        con.Close();
                        string OpenBal = string.Format("{0:0.00}", open_balance).ToString() + " <b>" + DRCR + "</b>";
                         LB_Balance_Amount.Text = OpenBal;

                         if (!IsPostBack)
                         {

                             DipsplayReport_FOR_Presented_Chq();
                         }
    }

    public void DipsplayReport_FOR_Presented_Chq()
    {

         
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";

        sql = "exec USP_Bank_Reconsilation_Module '" + Bankcode + "','" + Fromdate + "','" + Todate + "','" + transTable + "','Credit','" + TranType + "' ";
		//Response.Write(" SQL :"+sql);	
	
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_CHQ_Presented.DataSource = ds;
        GV_CHQ_Presented.DataBind();

        sql = "exec USP_Bank_Reconsilation_Module '" + Bankcode + "','" + Fromdate + "','" + Todate + "','" + transTable + "','Debit','" + TranType + "' ";
		//Response.Write(" SQL :"+sql);	

        cmd = new SqlCommand(sql, conn);
        da = new SqlDataAdapter(cmd);
        DataSet ds1 = new DataSet();
        da.Fill(ds1);
        GV_CHQ_Cleared.DataSource = ds1;
        GV_CHQ_Cleared.DataBind();
        conn.Close();   

    }
    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            Total_CR_amt = Convert.ToDouble(Credit.Text.ToString()) + Total_CR_amt;

            //Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            HiddenField Hnd_Ch_dt = (HiddenField)(e.Row.FindControl("Hnd_Ch_dt"));
            HiddenField Hnd_Flag = (HiddenField)(e.Row.FindControl("Hnd_Flag"));
            HiddenField Hnd_Comment = (HiddenField)(e.Row.FindControl("Hnd_Comment"));
            
            CheckBox chksrno = (CheckBox)(e.Row.FindControl("chksrno"));

            if (Hnd_Ch_dt.Value == "")
            {
                Hnd_Ch_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            TextBox Txt_ClearDate = (TextBox)(e.Row.FindControl("Txt_ClearDate"));
            TextBox Txt_Comment = (TextBox)(e.Row.FindControl("Txt_Comment"));
            if (Hnd_Flag.Value == "Y")
            {
                //chksrno.Enabled = false;
                Txt_ClearDate.Text = Hnd_Ch_dt.Value.ToString();
                Txt_Comment.Text = Hnd_Comment.Value.ToString();
            }
            Txt_ClearDate.CssClass = "blackfnt";
            Txt_Comment.CssClass = "blackfnt";

            chksrno.Attributes.Add("onclick", "On_OneCheck('" + chksrno.ClientID.ToString() + "')");

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTOtalCredit = (Label)(e.Row.FindControl("lblTOtalCredit"));
            lblTOtalCredit.Text = Total_CR_amt.ToString("F2");
        }
        if (DRCR == "DR")
        {

            CR_Amount = Total_CR_amt + open_balance;
            CR_AMT.Text = CR_Amount.ToString("F2") + " DR";
            DRCR1 = "DR";
        }
        else
        {
            if (Total_CR_amt > open_balance)
            {
                CR_Amount = Total_CR_amt - open_balance;
                CR_AMT.Text = CR_Amount.ToString("F2") + " DR";
                DRCR1 = "DR";
            }
            else if (Total_CR_amt < open_balance)
            {
                CR_Amount = Total_CR_amt - open_balance;
                CR_AMT.Text = CR_Amount.ToString("F2") + " CR";
                DRCR1 = "CR";
            }
        }
        


    }
    protected void GV_D_OnRowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label Credit = (Label)(e.Row.FindControl("lblCredit"));
            Total_DR_amt = Convert.ToDouble(Credit.Text.ToString()) + Total_DR_amt;
             HiddenField Hnd_Ch_dt = (HiddenField)(e.Row.FindControl("Hnd_Ch_dt"));
             TextBox Txt_ClearDate = (TextBox)(e.Row.FindControl("Txt_ClearDate"));
             TextBox Txt_Comment = (TextBox)(e.Row.FindControl("Txt_Comment"));
             Txt_ClearDate.CssClass = "blackfnt";
             Txt_Comment.CssClass = "blackfnt";
             if (Hnd_Ch_dt.Value == "")
             {
                 Hnd_Ch_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
             }
             HiddenField Hnd_Flag = (HiddenField)(e.Row.FindControl("Hnd_Flag"));
             HiddenField Hnd_Comment = (HiddenField)(e.Row.FindControl("Hnd_Comment"));
            
             CheckBox chksrno = (CheckBox)(e.Row.FindControl("chksrno"));
             if (Hnd_Flag.Value == "Y")
             {
                 //chksrno.Enabled = false;
                 Txt_ClearDate.Text = Hnd_Ch_dt.Value.ToString();
                 Txt_Comment.Text = Hnd_Comment.Value.ToString();
             }
             chksrno.Attributes.Add("onclick", "On_OneCheck('" + chksrno.ClientID.ToString() + "')");
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTOtalCredit = (Label)(e.Row.FindControl("lblTOtalCredit"));
            lblTOtalCredit.Text = Total_DR_amt.ToString("F2");
        }
        if (DRCR == "DR")
        {
            if (Total_DR_amt > CR_Amount)
            {
                DR_Amount = Total_DR_amt - CR_Amount;
                DR_CR_type = "CR";
            }
            else
            {
                DR_Amount = CR_Amount - Total_DR_amt;
                DR_CR_type = "DR";
            }
        }
        else
        {
            DR_Amount = CR_Amount + Total_DR_amt;
            DR_CR_type = DRCR1;
        }
        DR_AMT.Text = DR_Amount.ToString("F2") + " " + DR_CR_type;
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlTransaction trans;
        SqlCommand cmd;
        trans = con.BeginTransaction();
        string Sql = "";
        try
        {

            foreach (GridViewRow gridrow in GV_CHQ_Presented.Rows)
            {
                TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
                TextBox Txt_Comment = (TextBox)(gridrow.FindControl("Txt_Comment"));
                HiddenField Hnd_SRNO = (HiddenField)(gridrow.FindControl("Hnd_SRNO"));
                CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
                Label lblChqno = (Label)(gridrow.FindControl("lblChqno"));
                Label lblChqdate = (Label)(gridrow.FindControl("lblChqdate"));
                
                
                if (chksrno.Checked)
                {
		    if (Txt_ClearDate.Text != "")
                    {		
                    	Sql = "Update " + transTable + " set chqcleardate='" + fn.Mydate1(Txt_ClearDate.Text.ToString()) + "',Comment='" + Txt_Comment.Text.ToString() + "' where  srno='" + Hnd_SRNO.Value.ToString() + "'  ";
                    	cmd = new SqlCommand(Sql, con, trans);
                    	cmd.ExecuteNonQuery();

                    	Sql = "Update webx_acctrans_06_07 set chqcleardate='" + fn.Mydate1(Txt_ClearDate.Text.ToString()) + "',Comment='" + Txt_Comment.Text.ToString() + "' where    Chqno='" + lblChqno.Text + "' and convert(datetime,chqdate,106)=convert(varchar,'" + lblChqdate.Text + "',106) and acccode in (select acccode from webx_acctinfo where acccategory='BANK')";
                    	cmd = new SqlCommand(Sql, con, trans);
                   	cmd.ExecuteNonQuery();

                    	Sql = "Update webx_chq_det set chq_clear='Y'  where  Chqno='" + lblChqno.Text + "' and convert(datetime,chqdt,106)=convert(varchar,'" + lblChqdate.Text + "',106)";
                    	cmd = new SqlCommand(Sql, con, trans);
                    	cmd.ExecuteNonQuery();
		    }

                }
            }
            foreach (GridViewRow gridrow in GV_CHQ_Cleared.Rows)
            {
                TextBox Txt_ClearDate = (TextBox)(gridrow.FindControl("Txt_ClearDate"));
                TextBox Txt_Comment = (TextBox)(gridrow.FindControl("Txt_Comment"));
                HiddenField Hnd_SRNO = (HiddenField)(gridrow.FindControl("Hnd_SRNO"));
                CheckBox chksrno = (CheckBox)(gridrow.FindControl("chksrno"));
                Label lblChqno = (Label)(gridrow.FindControl("lblChqno"));
                Label lblChqdate = (Label)(gridrow.FindControl("lblChqdate"));
                if (chksrno.Checked)
                {
		    if (Txt_ClearDate.Text != "")
		    {	
                    	Sql = "Update " + transTable + " set chqcleardate='" + fn.Mydate1(Txt_ClearDate.Text.ToString()) + "',Comment='" + Txt_Comment.Text.ToString() + "' where  srno='" + Hnd_SRNO.Value.ToString() + "'  ";
                    	cmd = new SqlCommand(Sql, con, trans);
                    	cmd.ExecuteNonQuery();

                    	Sql = "Update webx_chq_det set chq_clear='Y'  where  Chqno='" + lblChqno.Text + "' and convert(datetime,chqdt,106)=convert(varchar,'" + lblChqdate.Text + "',106)";
                    	cmd = new SqlCommand(Sql, con, trans);
                    	cmd.ExecuteNonQuery();
		    }	
                }
            }
            trans.Commit();
            con.Close();
            Response.Redirect("RE_Done.aspx", false);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }
    }
}

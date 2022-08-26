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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_ViewTHCBalance : System.Web.UI.Page
{
    public double totnetpayment = 0.00;
    MyFunctions fn = new MyFunctions();
    private string voucherNo { get { return (ViewState["voucherNo"] != null) ? ViewState["voucherNo"].ToString() : ""; } set { ViewState["voucherNo"] = value; } }
    private Double total_netpayment { get { return (ViewState["total_netpayment"] != null) ? Convert.ToDouble(ViewState["total_netpayment"]) : 0; } set { ViewState["total_netpayment"] = value; } }

	private string FinYearNew { get { return (ViewState["FinYearNew"] != null) ? ViewState["FinYearNew"].ToString() : ""; } set { ViewState["FinYearNew"] = value; } }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        total_netpayment = 0;
        if (!IsPostBack)
        {
            voucherNo = Convert.ToString(Request.QueryString["advvoucher"]);
            string[] Split = voucherNo.Split(new Char[] { ',' });
            voucherNo = Convert.ToString(Split[0]);
            lblVoucherNo.Text = voucherNo;
            string print_yn = Convert.ToString(Split[1]);

            // if (Session["Client"].ToString() == "PRRL")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
            // }
            // if (Session["Client"].ToString() == "TLL")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
            // }
            // else if (Session["Client"].ToString() == "EXL")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
            // }
            // else if (Session["Client"].ToString() == "Varuna")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
            // }
            // else if (Session["Client"].ToString() == "RITCO")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            // }
            // else if (Session["Client"].ToString() == "RCPL")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
            // }
            // else if (Session["Client"].ToString() == "Agility")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
            // }
            // else if (Session["Client"].ToString() == "ASL")
            // {
                // imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
            // }
            // else
            // {
                // imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            // }
			
			 imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
			
            SqlConnection conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString().Trim());
            conn1.Open();

            string sql1 = "select convert(varchar,balvoucherdt,06) as balvoucherdt, convert(varchar,bal_Chqdate,06) as bal_Chqdate,FinYear=CAST((CASE WHEN MONTH(balvoucherdt)>3 THEN YEAR(balvoucherdt) ELSE YEAR(balvoucherdt)-1 END) AS VARCHAR(5)),* from webx_THC_SUMMARY where balvoucherNo='" + voucherNo + "'";
            SqlCommand cmd1 = new SqlCommand(sql1, conn1);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            if (dr.Read())
            {
                lblVoucherDt.Text = dr["balvoucherdt"].ToString();
                lblMode.Text = dr["bal_transtype"].ToString();
				FinYearNew =dr["FinYear"].ToString();
                if (lblMode.Text == "Cash")
                {
                    //lblPaymentAmt.Text = dr["bal_colamt"].ToString();
                    lblChequeNo.Text = "--";
                    lblChequeDt.Text = "--";
                }
                else
                {
                    //lblPaymentAmt.Text = dr["bal_Chqamt"].ToString();
                    lblChequeNo.Text = dr["bal_Chqno"].ToString();
                    lblChequeDt.Text = dr["bal_Chqdate"].ToString();
                }
                //NumberToText m = new NumberToText();
                //lblWords.Text = m.numberToText(lblPaymentAmt.Text);
                lblNarration1.Text = dr["Narration_Added"].ToString();
                lblBehati.Text = dr["BehatiDetail"].ToString();
                lblPaymentAcc.Text = dr["bal_Acccode"].ToString();
                SqlConnection conn_code = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString().Trim());
                conn_code.Open();

                string sql_code = "select Accdesc from webx_acctinfo where acccode ='" + lblPaymentAcc.Text + "'";
                SqlCommand sqlcmd1 = new SqlCommand(sql_code, conn_code);
                SqlDataReader dr1;
                dr1 = sqlcmd1.ExecuteReader();
                if (dr1.Read())
                {
                    lblPaymentAcc.Text = dr1["Accdesc"].ToString();
                }
                dr1.Close();
				
				string Financial_Year = "";
                string fin_year = "";
				
				Financial_Year = FinYearNew.ToString().Substring(2, 2);
                     		fin_year = FinYearNew.ToString();

				//if(Session["FinYear"] == null)
				//{
				//	 Financial_Year = FinYearNew.ToString().Substring(2, 2);
                     		//	 fin_year = FinYearNew.ToString();
					
				//}else{
				//	 Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
				//	 fin_year = Session["FinYear"].ToString();
				//}
				
                // string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
                // string fin_year = Session["FinYear"].ToString();
                double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
                fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

                //string sql_Amt = "select Credit from webx_vouchertrans_arch where voucherno='" + voucherNo + "'";
                string sql_Amt = "select sum(credit) as Credit from webx_acctrans_" + fin_year + " where voucherno='" + voucherNo + "'";
                sql_Amt = sql_Amt + " and acccode in (select acccode from webx_acctinfo where acccategory in('CASH','BANK'))";
                sqlcmd1 = new SqlCommand(sql_Amt, conn_code);
                dr1 = sqlcmd1.ExecuteReader();
                if (dr1.Read())
                {
                    lblPaymentAmt.Text = dr1["Credit"].ToString();
                }
                dr1.Close();
                conn_code.Close();

            }
            dr.Close();
            conn1.Close();
            BindGrid();
        }
    }
    private void BindGrid()
    {
        foreach (GridViewRow gridrow in dockdata.Rows)
        {
            Label TotNet = (Label)gridrow.FindControl("TotalNetamt");

            if (TotNet.Text != "")
            {
                totnetpayment = totnetpayment + Convert.ToDouble(TotNet.Text);
                TotNet.Text = totnetpayment.ToString();
            }
            else
            {
                totnetpayment = 0.00;
                TotNet.Text = "0.00";
            }
        }
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString().Trim());
        conn.Open();

        string sql = "SELECT Convert(varchar,actarrv_dt,03) as actarrv_dt,ul_actuwt as UnloadActualWeight,THCNO as dockno,oth_ded,THCSF,PCAMT,ADVAMT AS ADVAMT,OTHCHRG=(CASE WHEN loadOpertype='P'THEN (TEL_CHRG+LOAD_CHRG-MAMUL_CHRG) ELSE (TEL_CHRG-LOAD_CHRG-MAMUL_CHRG)END),CESSAMT AS CESSAMT,SVRCAMT AS SVCTAX,0 AS OTHDED,0 AS SVCTAXDED,tds_chrg as tdsded,tds_rate,routecd,(PCAMT-ADVAMT) as NET,Vendor_Code,Vendor_Name,pan_no,isnull(HEDU_CESS,0) as HEDU_CESS,isnull(svrc_rate,0) as svrc_rate,netbalamt ,isnull(HEDU_CESS,0)+isnull(CESSAMT,0)+isnull(SVRCAMT,0) as Svctax_cess,* FROM WEBX_THC_SUMMARY M WHERE balvoucherNo ='" + voucherNo + "'  ORDER BY THCDT";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //cmd.CommandType = CommandType.StoredProcedure;

        //da.SelectCommand.Parameters.Add("@voucherno", SqlDbType.VarChar).Value = voucherNo.ToString().Trim();
        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        total_netpayment = 0;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();

        foreach (GridViewRow gvr in dockdata.Rows)
        {
            Label netpayment = (Label)gvr.FindControl("indnetpay");
            total_netpayment += Convert.ToDouble(netpayment.Text);
        }
        if (total_netpayment > 0)
        {
            NumberToText words = new NumberToText();
            lblWords.Text = words.numberToText(lblPaymentAmt.Text);
        }
        else
        {
            lblWords.Text = "Zero Amount";
        }
        //lblPaymentAmt.Text = total_netpayment.ToString("00");
    }
    protected void dockdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }
}

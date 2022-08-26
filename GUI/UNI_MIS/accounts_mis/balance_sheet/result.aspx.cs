using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_UNI_MIS_accounts_mis_balance_sheet_result : System.Web.UI.Page
{
    DateFunction Daccess = new DateFunction();
    SqlDataReader dtr;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        main_Mod_LRS();
        main_Mod_EXP();
        main_Mod_INC();
        main_Mod_LIA();
        diff_Liability_Assets();
    }
    public void diff_Liability_Assets()
    {
        ///////////////////////////Liability///////////////////////////////
        double total_Liability = Convert.ToDouble(lblSC.Text) + Convert.ToDouble(lblRS1.Text) +
                                 Convert.ToDouble(lblSL1.Text) + Convert.ToDouble(lblUL1.Text)+
                                 Convert.ToDouble(lblCLP1.Text);
      
        ///////////////////////////Assets////////////////////////////
        double total_assets = Convert.ToDouble(lblFA1.Text) + Convert.ToDouble(lblI1.Text) +
                              Convert.ToDouble(lblCALA1.Text) + Convert.ToDouble(lblME1.Text);
                              
        
        if (total_assets > total_Liability)
        {
            double diff = (total_assets - total_Liability);
            lblPL1.Text = string.Format("{0:0.00}", diff).ToString();
            double tot = total_assets - Convert.ToDouble(lblPL1.Text);
            lblTotalA.Text = string.Format("{0:0.00}", tot).ToString();
            lblTotalL.Text = string.Format("{0:0.00}", total_Liability).ToString();
            lblBalDef.Text = "Profit and Loss Account <br> (Debit Balance)";
        }
        else if (total_assets < total_Liability)
        {
            double diff = (total_Liability - total_assets);
            lblPL1.Text = string.Format("{0:0.00}", diff).ToString();
            double tot = total_assets + Convert.ToDouble(lblPL1.Text);
            lblTotalA.Text = string.Format("{0:0.00}", tot).ToString();
            lblTotalL.Text = string.Format("{0:0.00}", total_Liability).ToString();
            lblBalDef.Text = "Profit and Loss Account <br> (Credit Balance)";
        }
        //lblTotalA.Text = string.Format("{0:0.00}", total_assets).ToString();
        //lblFA1.Text = "";
        //lblI1.Text = "";
        //lblCALA1.Text = "";
        //lblME1.Text = "";
        //lblPL1.Text = "";
    }
    public void main_Mod_LIA()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string AsOnDate = Request.QueryString["asOnDate"];
        string convDate = Daccess.return_date(AsOnDate);
        string strTranType = Request.QueryString["strTranType"];
        string branch = Request.QueryString["branch"];
        string g_code;
        string sql = "select Groupcode  from webx_groups where Acct_Prefix = 'LIA'";
        conn.Open();
        dtr = Daccess.getreader(sql);
        g_code = "";
        while (dtr.Read())
        {
            g_code = g_code + dtr["Groupcode"].ToString() + ";";
        }
        dtr.Close();
        string all_code_accinfo = all_Acc(g_code);
        double total_value = group_total_accTrans(all_code_accinfo);
        //////////////////////////
        //string info = total_value;
        //string strValueOP = "";
        //string[] arInfo = new string[1];
        //char[] splitter = { '-' };
        //arInfo = info.Split(splitter);
        //for (int x = 0; x < arInfo.Length; x++)
        //{
        //    total_value = arInfo[1];
        //}
        //////////////////////////
        lblCLP1.Text = string.Format("{0:0.00}", total_value).ToString();
        conn.Close();
    }
    public void main_Mod_INC()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string AsOnDate = Request.QueryString["asOnDate"];
        string convDate = Daccess.return_date(AsOnDate);
        string strTranType = Request.QueryString["strTranType"];
        string branch = Request.QueryString["branch"];
        string g_code;
        string sql = "select Groupcode  from webx_groups where Acct_Prefix = 'INC'";
        conn.Open();
        dtr = Daccess.getreader(sql);
        g_code = "";
        while (dtr.Read())
        {
            g_code = g_code + dtr["Groupcode"].ToString() + ";";
        }
        dtr.Close();
        string all_code_accinfo = all_Acc(g_code);
        double total_value = group_total_accTrans(all_code_accinfo);
        lblRS1.Text = string.Format("{0:0.00}", total_value).ToString();
        conn.Close();
    }
    public void main_Mod_EXP()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string AsOnDate = Request.QueryString["asOnDate"];
        string convDate = Daccess.return_date(AsOnDate);
        string strTranType = Request.QueryString["strTranType"];
        string branch = Request.QueryString["branch"];
        string g_code;
        string sql = "select Groupcode  from webx_groups where Acct_Prefix = 'EXP'";
        conn.Open();
        dtr = Daccess.getreader(sql);
        g_code = "";
        while (dtr.Read())
        {
            g_code = g_code + dtr["Groupcode"].ToString() + ";";
        }
        dtr.Close();
        string all_code_accinfo = all_Acc(g_code);
        double total_value = group_total_accTrans(all_code_accinfo);
        lblME1.Text = string.Format("{0:0.00}", total_value).ToString();
        conn.Close();
    }
    public void main_Mod_LRS()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string AsOnDate = Request.QueryString["asOnDate"];
        string convDate = Daccess.return_date(AsOnDate);
        string strTranType = Request.QueryString["strTranType"];
        string branch = Request.QueryString["branch"];
        string g_code;
        string sql = "select Groupcode  from webx_groups where Acct_Prefix = 'ASS'";
        conn.Open();
        dtr = Daccess.getreader(sql);
        g_code = "";
        while (dtr.Read())
        {
            g_code = g_code + dtr["Groupcode"].ToString() + ";";
        }
        dtr.Close();
        dtr.Dispose();
        string all_code_accinfo = all_Acc(g_code);
        double total_value = group_total_accTrans(all_code_accinfo);
        lblFA1.Text = string.Format("{0:0.00}", total_value).ToString();
        conn.Close();
        conn.Dispose();
    }
    public string all_Acc(string group_code)
    {
        string all_code = "";
        string info = group_code;
        string strValueOP = "";
        string[] arInfo = new string[1];
        char[] splitter = { ';' };
        arInfo = info.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            strValueOP = arInfo[x];
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            string sql = "select Acccode  from webx_acctinfo where Groupcode= '" + strValueOP + "'";
            conn.Open();
            dtr = Daccess.getreader(sql);

            while (dtr.Read())
            {
                all_code = all_code + dtr["Acccode"].ToString() + ";";
            }
            dtr.Close();

            conn.Close();
            conn.Close();
            conn.Dispose();
        }
        

        return all_code;
    }
    public double group_total_accTrans(string acct_code)
    {
        double groupTotal = 0;
        string info = acct_code;
        string strValueOP = "";
        string[] arInfo = new string[1];
        char[] splitter = { ';' };
        arInfo = info.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            strValueOP = arInfo[x];


            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string AsOnDate = Request.QueryString["asOnDate"];
            string convDate = Daccess.return_date(AsOnDate);
            string strTranType = Request.QueryString["strTranType"];
            string branch = Request.QueryString["branch"];
            string brcd = " and brcd = '" + branch + "'";
            string startYear = " 01 Apr 2007";
            string DateRange = " and convert(datetime, Transdate,160) between convert(varchar,'" + startYear + "',106) and convert(varchar,'" + convDate + "',106)";
            string sql = "";
            if (strTranType == "N")
            {
                sql = "select abs(isNull(sum(Debit-Credit),0.00)) as bal from webx_acctrans_07_08 where Acccode='" + strValueOP + "'" + DateRange + "";
            }
            else
            {
                sql = "select abs(isNull(sum(Debit-Credit),0.00)) as bal from webx_acctrans_07_08 where Acccode='" + strValueOP + "'" + DateRange + brcd + "";
            }
            conn.Open();
            string groupTotalDebit = "";
            string groupTotalCredit = "";
            double intgroupTotalDebit = 0;
            double intgroupTotalCredit = 0;

            dtr = Daccess.getreader(sql);

            while (dtr.Read())
            {
                groupTotalDebit = dtr["bal"].ToString() + "0";
                groupTotal = groupTotal + Convert.ToDouble(groupTotalDebit);
                if (groupTotalDebit == null && groupTotalDebit == "")
                {
                    groupTotalDebit = "0";
                }
            }
            dtr.Close();
            conn.Close();
            conn.Dispose();
        }
        
        return groupTotal;
    }
}

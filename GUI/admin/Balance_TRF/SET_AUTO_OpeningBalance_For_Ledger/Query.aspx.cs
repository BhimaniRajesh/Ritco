using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Image imgfrm = (Image)DT.FindControl("imgfrm");
        //Image imgto = (Image)DT.FindControl("imgto");

        if (!IsPostBack)
        {
          
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
       

            LT_CAT.Items.Clear();
           // LT_CAT.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select 'Creditors/Debetors Ledger' as main_category Union select distinct  main_category from webx_groups with(NOLOCK) where isnull(main_category,'')<>'' And  main_category not in ('INCOME','EXPENSES','EXPENSE')  order  by main_category";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
           // dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                LT_CAT.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(0).ToString()));
            }
            //LT_CAT.SelectedValue = "All";
            LT_CAT.SelectedIndex = 0;
            dread.Close();

            string YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
            SqlTransaction trans;

         

            conn.Close();
            SHow_ledgers();
        }

        btnShow.Attributes.Add("onclick", " javascript:return Check_Submit_Data()");
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {

        string report_mode = "", st_ro = "", st_lo = "", rpt = "", rmd = "";

 
        rmd = rptmd.SelectedValue.ToString();
 
        int finyear = Convert.ToInt16(Session["Finyear"].ToString()) - 1;
        string dtFrom = "01 APR " + finyear.ToString();
        string dtTo = "31 MAR " + Session["Finyear"].ToString();
  
        string st_cust_vend = "",st_cust_vend_name = "", rpt_SUB = "", ST_CAT = "", ST_ACC = "", ACC = "";

        for (int i = 0; i < LT_CAT.Items.Count; i++)
        {
            if (LT_CAT.Items[i].Selected == true)
            {
                if (ST_CAT == "")
                    ST_CAT =  LT_CAT.Items[i].Value.ToString() ;
                else
                    ST_CAT = ST_CAT + "," + LT_CAT.Items[i].Value.ToString() ;
            }
        }

       

        for (int i = 0; i < LT_ACC.Items.Count; i++)
        {
            if (LT_ACC.Items[i].Selected == true)
            {
                if (st_cust_vend == "")
                {
                    st_cust_vend =  LT_ACC.Items[i].Value.ToString();
                    st_cust_vend_name =  LT_ACC.Items[i].Text.ToString() ;
					st_cust_vend_name = st_cust_vend_name.ToString().Replace("\r\n", "");
                }
                else
                {
					st_cust_vend = st_cust_vend.ToString().Replace("\r\n", "");
					st_cust_vend_name = st_cust_vend_name.ToString().Replace("\r\n", "");
                    st_cust_vend = st_cust_vend + "," + LT_ACC.Items[i].Value.ToString() ;
                    st_cust_vend_name = st_cust_vend_name + "," + LT_ACC.Items[i].Text.ToString() ;
                }
            }
        }

        //rpt_SUB = rpttyp_SUB.SelectedValue.ToString();
        rpt = "2";// RD_CUST_VEND.SelectedValue.ToString();
        rpt_SUB = "1";
        string final;
        if (ST_CAT == "Creditors/Debetors Ledger")
        {
            ST_CAT = "All";
        }
        final = "?RO=" + st_ro;
        final += "&LO=" + txtBranchCode.Text.ToString();
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPT=" + rpt;
        final += "&ST_CAT=" + ST_CAT;
        final += "&ST_ACC=" + ST_ACC;
        final += "&ACC=" + ACC;
        final += "&st_cust_vend=" + st_cust_vend;
        final += "&st_cust_vend_name=" + st_cust_vend_name;
        final += "&rpt_SUB=" + rpt_SUB;
        final += "&RMD=" + rmd;
        Response.Write(final);
        //Response.End();
        //btnShow.Text = final;
        Response.Redirect("Result.aspx" + final);

    }
     
    public void SHow_ledgers()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string ST_CAT = "";

        for (int i = 0; i < LT_CAT.Items.Count; i++)
        {
            if (LT_CAT.Items[i].Selected == true)
            {
                if (ST_CAT == "")
                    ST_CAT = "'" + LT_CAT.Items[i].Value.ToString() + "'";
                else
                    ST_CAT = ST_CAT + ",'" + LT_CAT.Items[i].Value.ToString() + "'";
            }
        }
        string STr_Accounts_cls = "";
        
        int Npos1 = ST_CAT.IndexOf("All");
       
          
        if (Npos1 != 1)
        {
            LT_ACC.Items.Clear();
            //LT_ACC.Items.Add(new ListItem("All", "All"));
            if (LT_CAT.SelectedValue == "Creditors/Debetors Ledger")
            {
                string Vendor_Credit_Account_CLS = " OR Acccode  in (select distinct accthead from webx_accthead where accthead is not null )";
                string Customer_Debit_Account_CLS = " OR Acccode  in (select distinct acccode from webx_acctinfo where acccode in ('CDA0001','CDA0002','CDA0003'))";
                string Emp_Account_CLS = " OR Acccode  in (select distinct acccode from webx_acctinfo where acccode in   ('CLA0028','CLA0004','CLA0001'))";

                string sqlstr = " select acccode , accdesc+ ' : ' +acccode  from webx_acctinfo a with(NOLOCK)  inner join webx_groups g on a.groupcode=g.groupcode where activeFlag='Y' and main_category in (" + ST_CAT + ")   " + Vendor_Credit_Account_CLS + Customer_Debit_Account_CLS + Emp_Account_CLS + " order  by accdesc";
                SqlCommand cmd = new SqlCommand(sqlstr, conn);
                SqlDataReader dread = cmd.ExecuteReader();
                int i = 0;
                while (dread.Read())
                {
                    i = i + 1;
                    LT_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }
                // LT_ACC.SelectedValue = "All";
               // LT_ACC.SelectedIndex = 0;
            }
            else
            {
                string Vendor_Credit_Account_CLS = " AND Acccode not in (select distinct accthead from webx_accthead where accthead is not null )";
                string Customer_Debit_Account_CLS = " AND Acccode not in (select distinct acccode from webx_acctinfo where acccode in ('CDA0001','CDA0002','CDA0003'))";
                string Emp_Account_CLS = " AND not Acccode  in (select distinct acccode from webx_acctinfo where acccode in   ('CLA0028','CLA0004','CLA0001'))";

                string sqlstr = " select acccode , accdesc+ ' : ' +acccode  from webx_acctinfo a with(NOLOCK)  inner join webx_groups g on a.groupcode=g.groupcode where activeFlag='Y' and main_category in (" + ST_CAT + ")   " + Vendor_Credit_Account_CLS + Customer_Debit_Account_CLS + Emp_Account_CLS + " order  by accdesc";
                SqlCommand cmd = new SqlCommand(sqlstr, conn);
                SqlDataReader dread = cmd.ExecuteReader();
                int i = 0;
                while (dread.Read())
                {
                    i = i + 1;
                    LT_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }
                // LT_ACC.SelectedValue = "All";
                LT_ACC.SelectedIndex = 0;
            }
        }
        else
        {
            string Vendor_Credit_Account_CLS = " AND Acccode not in (select distinct accthead from webx_accthead where accthead is not null )";
            string Customer_Debit_Account_CLS = " AND Acccode not in (select distinct acccode from webx_acctinfo where acccode in ('CDA0001','CDA0002','CDA0003'))";
            string Emp_Account_CLS = " AND not Acccode  in (select distinct acccode from webx_acctinfo where acccode in   ('CLA0028','CLA0004','CLA0001'))";

            LT_ACC.Items.Clear();
            //LT_ACC.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select acccode , accdesc+ ' : ' +acccode  from webx_acctinfo a with(NOLOCK)  inner join webx_groups g on a.groupcode=g.groupcode where activeFlag='Y' and   main_category not in ('INCOME','EXPENSES','EXPENSE')      " + Vendor_Credit_Account_CLS + Customer_Debit_Account_CLS +  Emp_Account_CLS + "  order  by accdesc";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            int i = 0;
            while (dread.Read())
            {
                i = i + 1;
                LT_ACC.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
           // LT_ACC.SelectedValue = "All";
            LT_ACC.SelectedIndex = 0;
        }
        conn.Close();
    }
    protected void LT_CAT_SelectedIndexChanged(object sender, EventArgs e)
    {
        SHow_ledgers();
    }
}

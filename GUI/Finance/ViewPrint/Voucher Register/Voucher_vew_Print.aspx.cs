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

public partial class GUI_Operation_Singlescreen_docketentry_DocketPrint_PaidMR_MR_Summ_Popup : System.Web.UI.Page
{
    public static SqlDataReader dr;
    public string vvno, typ, yn, vdt, vnarr, vpayto, dbttot, crdtot, vbrcd, deptcode, bookcode, Entryby, acccode, acccategory, accdescbank1, chqno1, debitbank1, creditbank1, narrationbank1, accdescbank, chqno, debitbank, creditbank, narrationbank, accdesccash, debitcash, creditcash, narrationcash, chqdt, acccode1,inwords;

    protected void Page_Load(object sender, EventArgs e)
    {

        vvno = Request.QueryString["vno"];
        typ = Request.QueryString["type"];

        //string MR_Number = lblMRNo.Text;

        ///UNI_MIS/voucher%20register/FrmVoucherList.aspx?FrmDate=19/05/2007&ToDate=19/05/2007&RO=All&vtype=All&vname=All&voucherno=&location=All
        ///
        //UNI_MIS/voucher%20register/voucher_vew_print.aspx?vno=HQTR/VR/0712464&type=Contra&printyn=0
        typ = typ.ToUpper();
        if (typ == "CONTRA")
        {
            contra();

        }
        else if (typ == "CASH PAYMENT" || typ == "BANK PAYMENT")
        {
            typ = "DEBIT VOUCHER";
            pnldb_cr.Visible = true;
            for_debit();

        }
        else if (typ == "CASH RECEIPT" || typ == "BANK RECEIPT")
        {
            typ = "CREDIT VOUCHER";
            pnldb_cr.Visible = true;
            for_credit();

        }



    }



    public void for_debit()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();


        string Sql = "select a.groupcode,a.Accdesc,a.acccategory,convert(varchar,t.transdate,106) as dt1,t.* from webx_ACCTINFO a,webx_acctrans_08_09 t where a.Acccode=t.Acccode and t.voucherno='" + vvno + "' and   t.debit>0 ";
        
        SqlCommand sqlCommand = new SqlCommand(Sql,conn);

        dr = sqlCommand.ExecuteReader();

        int i = 0;
        double dt = 0;
        while (dr.Read())
        {


            vdt = dr["dt1"].ToString();
            vnarr = dr["narration"].ToString();
            vpayto = Convert.ToString(dr["payto"]);

            dbttot = Convert.ToString(dr["debit"]);
            //dt += Convert.ToDouble(dr["debit"].ToString());
            vbrcd = Convert.ToString(dr["brcd"]);
            acccode = Convert.ToString(dr["acccode"]) + " : " + Convert.ToString(dr["Accdesc"]);



        }
        dr.Close();



        //  string Sql = "select a.groupcode,a.Accdesc,a.acccategory,convert(varchar,t.transdate,106) as dt1,t.* from webx_ACCTINFO a,webx_acctrans_07_08 t where a.Acccode=t.Acccode and t.voucherno='" + vvno + "' and   t.debit>0 ";

        SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn2.Open();
        string Sql2 = "select  sum(debit) as debit,chqno,chqdate,transtype,m.acccode,narration,convert(varchar,transdate,106) as dt1,payto,m.brcd,d.Accdesc from webx_acctrans_07_08 m with (NOLOCK),webx_acctinfo d with (NOLOCK) where m.acccode=d.acccode and (d.acccategory ='CASH' or d.acccategory ='BANK') and voucherno='" + vvno + "' group by chqno,chqdate,transtype,m.acccode,narration,transdate,payto,m.brcd,d.Accdesc";
        SqlCommand sqlCommand2 = new SqlCommand(Sql2, conn2);
        SqlDataReader dr2;
        dr2 = sqlCommand2.ExecuteReader();


        while (dr2.Read())
        {

          //  dbttot = Convert.ToString(dr2["debit"]);
            acccode1 = Convert.ToString(dr2["acccode"]) + " : " + Convert.ToString(dr2["Accdesc"]);

        }
        dr2.Close();
        NumberToText n = new NumberToText();
      //  dbttot = dt.ToString("F2");
        inwords = n.numberToText(dbttot);

    }

    public void for_credit()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();

        string Sql = "select a.groupcode,a.Accdesc,a.acccategory,convert(varchar,t.transdate,106) as dt1,t.* from webx_ACCTINFO a,webx_acctrans_07_08 t where a.Acccode=t.Acccode and t.voucherno='" + vvno + "' and   t.credit>0 ";

          SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        int i = 0;
        while (dr.Read())
        {


            vdt = dr["dt1"].ToString();
            vnarr = dr["narration"].ToString();
            vpayto = Convert.ToString(dr["payto"]);
             dbttot = Convert.ToString(dr["debit"]);
            vbrcd = Convert.ToString(dr["brcd"]);
            acccode = Convert.ToString(dr["acccode"]) + " : " + Convert.ToString(dr["Accdesc"]);



        }
        dr.Close();



        //  string Sql = "select a.groupcode,a.Accdesc,a.acccategory,convert(varchar,t.transdate,106) as dt1,t.* from webx_ACCTINFO a,webx_acctrans_07_08 t where a.Acccode=t.Acccode and t.voucherno='" + vvno + "' and   t.debit>0 ";

        SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn2.Open();
        string Sql2 = "select  sum(credit) as credit,chqno,chqdate,transtype,m.acccode,narration,convert(varchar,transdate,106) as dt1,payto,m.brcd,d.Accdesc from webx_acctrans_07_08 m with (NOLOCK),webx_acctinfo d with (NOLOCK) where m.acccode=d.acccode and (d.acccategory ='CASH' or d.acccategory ='BANK') and voucherno='" + vvno + "' group by chqno,chqdate,transtype,m.acccode,narration,transdate,payto,m.brcd,d.Accdesc";
        SqlCommand sqlCommand2 = new SqlCommand(Sql2, conn2);
        SqlDataReader dr2;
        dr2 = sqlCommand2.ExecuteReader();


        while (dr2.Read())
        {

          //  dbttot = Convert.ToString(dr2["credit"]);
            acccode1 = Convert.ToString(dr2["acccode"]) + " : " + Convert.ToString(dr2["Accdesc"]);

        }
        dr2.Close();
        NumberToText n = new NumberToText();

        inwords = n.numberToText(dbttot);


    }

    public void contra()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn2.Open();
        string Sql = "Select * From  webx_acctrans_" + Session["YearVal"].ToString() + " where Voucherno='" + vvno + "' and transtype='" + typ + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        string bookcode = "";

        while (dr.Read())
        {

            vdt = dr["transdate"].ToString();
            deptcode = dr["deptcode"].ToString();
            Entryby = Convert.ToString(dr["Entryby"]);
            vbrcd = Convert.ToString(dr["brcd"]);
            acccode = Convert.ToString(dr["acccode"]);
            bookcode = Convert.ToString(dr["bookcode"]);





            string Sql2 = "select accdesc,acccategory from webx_acctinfo where acccode='" + acccode + "' order by accdesc";


            SqlCommand sqlCommand2 = new SqlCommand(Sql2, conn2);

            SqlDataReader dr2 = sqlCommand2.ExecuteReader();
            int i = 0;

            while (dr2.Read())
            {

                acccategory = dr2["acccategory"].ToString();
                if (acccategory == "BANK")
                {
                    if (i == 1)
                    {
                        accdescbank1 = acccode + "-" + dr2["accdesc"].ToString();

                        if (dr["chqno"] is DBNull)
                        {
                            chqno1 = "";
                        }
                        else
                        {
                            chqno1 = dr["chqno"].ToString();
                        }

                        debitbank1 = dr["debit"].ToString();
                        creditbank1 = dr["credit"].ToString();
                        narrationbank1 = dr["narration"].ToString();


                    }
                    if (i == 0)
                    {
                        accdescbank = acccode + "-" + dr2["accdesc"].ToString();

                        if (dr["chqno"] is DBNull)
                        {
                            chqno = "";
                        }
                        else
                        {
                            chqno = dr["chqno"].ToString();
                        }

                        debitbank = dr["debit"].ToString();
                        creditbank = dr["credit"].ToString();
                        narrationbank = dr["narration"].ToString();


                    }

                }

                else // for cash
                {
                    accdesccash = acccode + "-" + dr2["accdesc"].ToString();


                    debitcash = dr["debit"].ToString();
                    creditcash = dr["credit"].ToString();
                    narrationcash = dr["narration"].ToString();


                }



                i++;
            }
            dr2.Close();
        }
        dr.Close();

        bookcode = bookcode.ToUpper();
        if (bookcode == "CASH WITHDRAWAL")
        {
            pnlcontra_CASH_WITHDRAWAL.Visible = true;

        }
        else
        {
            pnl_contra_CASH_DEPOSIT.Visible = true;
        }
        if (narrationbank != "")
        {
            narrationcash = "";
        }





    }
}

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

public partial class VendorPayment_new_vendorbill_xls : System.Web.UI.Page
{
    //public SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    public static string str_GenerateBillNo, bill;
    public static string DOCNO;
    public static int PCAMT, tot, totOTHAMT, totSVCTAX, totCESS, totADVPAID, totOTHDED, totSVCTAXDED, totnetpay, tottdsded, tottds_rate;
    protected void Page_Load(object sender, EventArgs e)
    {

        string str_GenerateBillNo = Request.QueryString.Get("strGenerateBillNo");
        string[] Split = str_GenerateBillNo.Split(new Char[] { ',' });
        str_GenerateBillNo = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select BILLNO,VENDORNAME,VENDORBILLDT,PCAMT,OTHAMT,SVCTAX,CESSAMT,BILLDT,VENDORBILLNO,DUEDT,ADVAMT,OTHERDED,SVCTAXDED,TDS,NETAMT,* from WEBX_VENDORBILL_HDR where BILLNO='" + str_GenerateBillNo + "' ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = sqlcmd.ExecuteReader();
       
            if (dr.Read())
            {
                string BillNo = dr[0].ToString().Trim();
                string vandorname = dr[1].ToString().Trim();
                string vendorbilldate = dr[2].ToString().Trim();
                string contractamount = dr[3].ToString().Trim();
                string otheramount = dr[4].ToString().Trim();
                string servicetax = dr[5].ToString().Trim();
                string cess1 = dr[6].ToString().Trim();
                string bill_entrydate = dr[7].ToString().Trim();
                string vendorbillno = dr[8].ToString().Trim();
                string duedate = dr[9].ToString().Trim();
                string advancepaid = dr[10].ToString().Trim();
                string deduction = dr[11].ToString().Trim();
                string servicetaxdeduction = dr[12].ToString().Trim();
                string TDSdeduction = dr[13].ToString().Trim();
                string netpayable = dr[14].ToString().Trim();


                lblvendorname.Text = vandorname;
                lblvendorbilldt.Text = vendorbilldate;
                lblcontractamt.Text = contractamount;
                lblotheramount.Text = otheramount;
                lblservicetaxcharged.Text = servicetax;
                lblcess.Text = cess1;
                lblbillentrydt.Text = bill_entrydate;
                lblvendorbillnumber.Text = vendorbillno;
                lblduedt.Text = duedate;
                lbladvancepaid.Text = advancepaid;
                lbldeduction.Text = deduction;
                lblsvctaxdeduction.Text = servicetaxdeduction;
                lblTDSdeduction.Text = TDSdeduction;
                lblnetpayable.Text = netpayable;


            }
        dr.Close();
        conn.Close();
        disp();  
        }


    public void disp()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
         //string str_GenerateBillNo2 = Convert.ToString(Split[0]);
         string str_GenerateBillNo2 = Request.QueryString.Get("strGenerateBillNo");
         string[] Split = str_GenerateBillNo2.Split(new Char[] { ',' });
         str_GenerateBillNo2 = Convert.ToString(Split[0]);
         string print_yn = Convert.ToString(Split[1]);
        string sql2 = "select BILLNO, BILLSF, DOCNO, DOCSF, PCAMT, OTHAMT, SVCTAX, CESS, ADVPAID,OTHDED, SVCTAXDED, voucherNo, paydt,netpay,tdsded,tds_rate,svctaxrate,discount from WEBX_VENDORBILL_DET where BILLNO='" + str_GenerateBillNo2 + "' ";
        SqlCommand sqlcmd2 = new SqlCommand(sql2, conn);

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd2);

        DataSet ds = new DataSet();
        da.Fill(ds);


        DataTable dt = new DataTable();


        dt.Columns.Add("DOCNO", typeof(string));
        dt.Columns.Add("PCAMT", typeof(string));
        dt.Columns.Add("OTHAMT", typeof(string));
        dt.Columns.Add("SVCTAX", typeof(string));
        dt.Columns.Add("CESS", typeof(string));
        dt.Columns.Add("ADVPAID", typeof(string));
        dt.Columns.Add("OTHDED", typeof(string));
        dt.Columns.Add("SVCTAXDED", typeof(string));
        dt.Columns.Add("tds_rate", typeof(string));
        dt.Columns.Add("tdsded", typeof(string));
        dt.Columns.Add("netpay", typeof(string));

        DataRow dr3, dr4;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr3 = dt.NewRow();
            //totOTHAMT, totSVCTAX, totCESS, totADVPAID, totOTHDED, totSVCTAXDED, totnetpay, tottdsded, tottds_rate
            dr3["DOCNO"] = (drRows["DOCNO"]);

            dr3["PCAMT"] = Convert.ToInt16(drRows["PCAMT"]);
            tot += Convert.ToInt16(drRows["PCAMT"]);

            dr3["OTHAMT"] = Convert.ToInt16(drRows["OTHAMT"]);
            totOTHAMT += Convert.ToInt16(drRows["OTHAMT"]);

            dr3["SVCTAX"] = Convert.ToInt16(drRows["SVCTAX"]);
            totSVCTAX += Convert.ToInt16(drRows["SVCTAX"]);

            dr3["CESS"] = Convert.ToInt16(drRows["CESS"]);
            totCESS += Convert.ToInt16(drRows["CESS"]);

            dr3["ADVPAID"] = Convert.ToInt16(drRows["ADVPAID"]);
            totADVPAID += Convert.ToInt16(drRows["ADVPAID"]);

            dr3["OTHDED"] = Convert.ToInt16(drRows["OTHDED"]);
            totOTHDED += Convert.ToInt16(drRows["OTHDED"]);

            dr3["SVCTAXDED"] = Convert.ToInt16(drRows["SVCTAXDED"]);
            totSVCTAXDED += Convert.ToInt16(drRows["SVCTAXDED"]);

            dr3["tdsded"] = Convert.ToInt16(drRows["tdsded"]);
            tottdsded += Convert.ToInt16(drRows["tdsded"]);

            dr3["tds_rate"] = Convert.ToInt16(drRows["tds_rate"]);
            tottds_rate += Convert.ToInt16(drRows["tds_rate"]);

            dr3["netpay"] = Convert.ToInt16(drRows["netpay"]);
            totnetpay += Convert.ToInt16(drRows["netpay"]);


            dt.Rows.Add(dr3);
        }

        dr4 = dt.NewRow();
        dr4["DOCNO"] = "Total";
        dr4["PCAMT"] = tot;
        dr4["OTHAMT"] = totOTHAMT;
        dr4["SVCTAX"] = totSVCTAX;
        dr4["CESS"] = totCESS;
        dr4["ADVPAID"] = totADVPAID;
        dr4["OTHDED"] = totOTHDED;
        dr4["SVCTAXDED"] = totSVCTAXDED;
        dr4["tdsded"] = tottdsded;
        dr4["tds_rate"] = tottds_rate;
        dr4["netpay"] = totnetpay;

        dt.Rows.Add(dr4);

        GridView1.DataSource = dt;
        GridView1.DataBind();



        conn.Close();
    
    }


    ////private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    ////{
    ////    if (groupName == "BILLNO")
    ////    {
    ////        //row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
    ////        row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
    ////        row.Font.Name = "blackfnt";


    ////    }
    ////}

    //private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    //{
    //    row.Cells[0].Font.Bold = true;
    //    row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
    //    row.Cells[0].Text = "Total";
    //    row.Cells[0].CssClass = "bgbluegrey";
    //}
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;

        disp();


    }
}

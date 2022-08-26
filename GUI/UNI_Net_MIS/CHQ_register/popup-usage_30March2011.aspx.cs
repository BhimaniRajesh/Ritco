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

public partial class GUI_UNI_MIS_chequemgt_popup_usage : System.Web.UI.Page
{
    
    DateFunction Daccess = new DateFunction();
    SqlDataReader dtr,dtr2;
    public  string chqno, chqdt, entrydt, brcd, brnm, narration, banknm, chqamt, ptmsptcd, ptmsptnm, BANKBRN, depoflag, voucherNo, acccode, transdate, depoloccode, mrno, adj, nonadj, vovtype;
       
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        int adjustamt;
        if (adjustamt == null)
        {
            adjustamt = 0;
        }
        string chqnoV = Request.QueryString["id"];
        string chqno1 = "";
        string chqdt1 = "";
        string[] arInfo = new string[2];
        char[] splitter = { ',' };
        arInfo = chqnoV.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            chqno1 = arInfo[0];
            chqdt1 = arInfo[1];
        }

        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        string fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
      
        //string sql = "select *,vovtype=(select top 1 transtype  from vw_VoucherReport_08_09 where voucherno=d.voucherNo) from webx_chq_det d where chqno='" + chqno1.ToString() + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdt1.ToString() + "',106)";

        string sql = "select chqno,chqdt,entrydt,brcd,brnm,banknm,chqamt,isnull(adjustamt,0) adjustamt,ptmsptcd,ptmsptnm,bankbrn,depoflag,acccode,depoloccode,";
        sql += " b.voucherno,b.transdate,b.transtype AS vovtype from webx_chq_det a cross apply ";
        sql += " (select t.voucherno,t.transdate,t.transtype from webx_acctrans_" + fin_year + " t where t.chqno=a.chqno and t.chqdate=a.chqdt and t.acccode in(select acccode from webx_acctinfo where acccategory in('BANK','ASSET'))) b";
        sql += " where a.chqno='" + chqno1.ToString() + "' and convert(varchar,a.chqdt,106)=convert(datetime,'" + chqdt1.ToString() + "',106)";


        conn.Open();
        dtr = Daccess.getreader(sql);
        chqno = "";
        chqdt = "";
        entrydt = "";
        brcd = "";
        brnm = "";
        narration = "";
        banknm = "";
        chqamt = "";
        ptmsptcd = "";
        ptmsptnm = "";
        BANKBRN = "";
        depoflag = "";
        voucherNo = "";
        acccode = "";
        transdate = "";
        depoloccode = "";
        adj = "";
        nonadj = "";
        vovtype = "";

        while (dtr.Read())
        {
            chqno = dtr["chqno"].ToString();
            chqdt = Convert.ToDateTime(dtr["chqdt"]).ToString("dd MMM yy");
            entrydt = Convert.ToDateTime(dtr["entrydt"]).ToString("dd MMM yy");
            brcd = dtr["brcd"].ToString();
            brnm = dtr["brnm"].ToString();
            banknm = dtr["banknm"].ToString();
            chqamt = dtr["chqamt"].ToString();
            ptmsptcd = dtr["ptmsptcd"].ToString();
            ptmsptnm = dtr["ptmsptnm"].ToString();
            BANKBRN = dtr["BANKBRN"].ToString();
            depoflag = dtr["depoflag"].ToString();
            voucherNo = dtr["voucherNo"].ToString();
            acccode = dtr["acccode"].ToString();
            vovtype = dtr["vovtype"].ToString();
            if (depoflag == "N")
            {
                voucherNo = "";
                vovtype = "";
            }
            if (dtr["transdate"] is DBNull)
            { }
            else
            {
                transdate = Convert.ToDateTime(dtr["transdate"]).ToString("dd MMM yy");
            }
            depoloccode = dtr["depoloccode"].ToString();
            mrno = dtr["voucherNo"].ToString();

            adj = dtr["adjustamt"].ToString();
            Double d  = Convert.ToDouble(chqamt) - Convert.ToDouble(adj);
            if(d > 0)
                nonadj = Convert.ToString(d);
            else
                nonadj = "0.00";
        }
        dtr.Close();
        conn.Close();
        Label1.Text = chqno;
        Label2.Text = brcd;
       // Label3.Text = voucherNo;
        Label4.Text = chqamt;
        Label5.Text = chqdt;
        Label6.Text = entrydt;
        Label7.Text = banknm;
        Label8.Text = ptmsptnm;
        Label9.Text = depoloccode;
        Label10.Text = transdate;
   
        Label11.Text = adj;
        Label12.Text = nonadj;

        string sql11 = "select docno,convert(varchar,chqdt,106) as chqdt,chqamt,clamt,(select mrstype from Vw_MR_details m where m.mrsno=c.docno ) as MRSTYPE from WEBX_BILLCHQDETAIL c where chqno='" + chqno1.ToString() + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdt1.ToString() + "',106)";

        

        SqlCommand cmd = new SqlCommand(sql11, conn);
        DataTable dt1 = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt1);
        GridView1.DataSource = dt1;
        GridView1.DataBind();


    }

   
   
    
}

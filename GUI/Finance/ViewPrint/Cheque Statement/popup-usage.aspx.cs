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
    SqlDataReader dtr;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string chqno, chqdt, entrydt, brcd, brnm, narration, banknm, chqamt, ptmsptcd, ptmsptnm, BANKBRN, depoflag, voucherNo, acccode, transdate, depoloccode;
        int adjustamt;
        if (adjustamt==null)
        {
            adjustamt=0;
        }
	    string chqnoV = Request.QueryString["id"];
        string chqno1="";
        string chqdt1 = "";
        string[] arInfo = new string[2];
        char[] splitter = { ',' };
        arInfo = chqnoV.Split(splitter);
        for (int x = 0; x < arInfo.Length; x++)
        {
            chqno1 = arInfo[0];
            chqdt1 = arInfo[1];
        }
        string sql = "select chqindex,chqno,convert(varchar,chqdt,6) as chqdt,chqamt,banknm,ptmsptcd,ptmsptnm,comments,bacd,banm,brcd,brnm,empcd,empnm,adjustamt,staffcd,staffnm,CHQSTATUS,BANKBRN,chq_trf,chq_flag,recdbrcd,recdbrnm,OwnCust,DepoFlag,convert(varchar,Entrydt,6) as Entrydt,voucherNo,acccode,transdate,depoloccode,chqsf,chq_depattempt,chq_clear,chq_status,Chq_BounceAmt,chq_bounce_dt,chq_reoffer_dt from webx_chq_det where chqno='" + chqno1.ToString() + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdt1.ToString() + "',106)";
        conn.Open();
        dtr = Daccess.getreader(sql);
        chqno="";
        chqdt="";
        entrydt="";
        brcd="";
        brnm="";
        narration="";
        banknm="";
        chqamt="";
        ptmsptcd="";
        ptmsptnm="";
        BANKBRN="";
        depoflag="";
        voucherNo="";
        acccode="";
        transdate="";
        depoloccode="";
       
        while (dtr.Read())
        {
            chqno = dtr["chqno"].ToString();
            chqdt = dtr["chqdt"].ToString();
            entrydt = dtr["entrydt"].ToString();
            brcd = dtr["brcd"].ToString();
            brnm = dtr["brnm"].ToString();
            //narration = dtr["narration"].ToString();
            banknm = dtr["banknm"].ToString();
            chqamt = dtr["chqamt"].ToString();
            ptmsptcd = dtr["ptmsptcd"].ToString();
            ptmsptnm = dtr["ptmsptnm"].ToString();
            BANKBRN = dtr["BANKBRN"].ToString();
            depoflag = dtr["depoflag"].ToString();
            voucherNo = dtr["voucherNo"].ToString();
            acccode = dtr["acccode"].ToString();
            transdate = dtr["transdate"].ToString();
            depoloccode = dtr["depoloccode"].ToString();
            //adjustamt = dtr["adjustamt"].ToString();
        }
        dtr.Close();
        conn.Close();
        Label1.Text = chqno;
        Label2.Text = brcd;
        Label3.Text = voucherNo;
        Label4.Text = chqamt;
        Label5.Text = chqdt;
        Label6.Text = entrydt;
        Label7.Text = banknm;
        Label8.Text = ptmsptnm;
    }
}

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

public partial class GUI_UNI_MIS_TDS_STMT_TDS_Report : System.Web.UI.Page
{
    string Code,Code1,Sql;
    public static string strDateRange;
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    DataView dv;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        Code = Request.QueryString["Code"];
        if (Code != null && Code != "")
        {
            lblCode.Text = Code.ToString();
        }
        Code1 = Request.QueryString["Code1"];
        if (Code1 != null && Code1 != "")
        {
            lblCode.Text = Code1.ToString();
        }

        if (Code == null && Code1 == null)
        {
            lblCode.Text = "All";

        }


        lblName.Text = Request.QueryString["Name"];
        lblBranch.Text = Request.QueryString["BookLoc"];
        strDateRange = Request.QueryString["dateRange"];


        lblDtFrom.Text = strDateRange;
         

        BindGrid();
    }

   public void BindGrid()
   {
       string[] strArrDtFromTo = strDateRange.Split('-');
       string strfrmdt = strArrDtFromTo[0];
       string strtodt = strArrDtFromTo[1];


       // tot = amt-tds
       string yearSuffix = "07_08";
      
      // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");
      // conn.Open();
       string s1 = "";

       /*
sql: select m.*,(select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on m.docno=d.billno LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE where pbov_type='P' and convert(varchar,billdate,106) between Convert(datetime,'9 Nov 07',106) and convert(datetime,'15 Nov 07',106) order by pbov_type,billdate  */
       if (Code != null && Code != "")
       {
           s1 = "select 'V' AS pbov_type, (case when isnull(m.docno,'') = '' then d.voucherNo  else m.docno end) AS docno, transdate AS billdate, isnull(billamt,credit) as billamt, 0 AS svctax, 0 AS cess,isnull(m.netamt,credit) as netamt, d.brcd AS loccode, isnull(d.credit, 0) AS tds, d.pbov_code AS pbov_code,d.acccode as tdsacccode,d.oppacccode,d.oppaccount  as oppaccdesc ,d.pbov_name AS pbov_Name,d1.transtype,d1.chqno,d1.chqdt,d1.paidamt,d1.bankname,d1.paydt,d1.brcd,d1.bankbrn from (vw_acctrans_" + yearSuffix + " d with (NOLOCK) left outer join  vw_tds_vendor_records m  with (NOLOCK) on d.voucherNo=m.docno or d.docno=m.docNo ) left outer join webx_tds_paydet d1 on   m.docno=d1.billno where  d.acccode='CLA0015' and d.credit > 0 and convert(datetime,d.transdate,106) between  Convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) and (d.voucher_cancel='N' or d.voucher_cancel is null) and d.pbov_code='" + Code + "' order by d.transdate";
          
          
       }

       else if (Code1 != null && Code1 != "")
       {
          //  s1 = "select m.*,(case when pbov_code='8888' then pbov_name else  (select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) end ) as EntryNo,d.transtype,d.chqno,d.chqdt,d.paidamt as Amt,d.bankname as Bank,d.paydt,d.brcd,d.bankbrn as Branch,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on  m.docno=d.billno  LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE where pbov_code='" + Code1 + "'  and convert(varchar,billdate,106) between Convert(varchar,'" + strfrmdt + "',106) and convert(varchar,'" + strtodt + "',106) order by pbov_type,billdate"; //" + replace(loccodecls, "bbrcd", "loccode") + " ;

           s1 = "select m.*,(case when pbov_code='8888' then pbov_name else (select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) end ) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on m.docno=d.billno LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE where pbov_code='" + Code1 + "' and convert(varchar,billdate,106) between Convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) order by pbov_type,billdate";


             
       }

       else
       {
           string t = Request.QueryString["typ"].ToString();
           if (t == "r")
           {

               s1 = "select m.*,(case when pbov_code='8888' then pbov_name else (select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) end ) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on m.docno=d.billno LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE where pbov_type='P' and convert(varchar,billdate,106) between Convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) order by pbov_type,billdate";
           }
           else
           {
               s1 = "select 'V' AS pbov_type, (case when isnull(m.docno,'') = '' then d.voucherNo  else m.docno end) AS docno, transdate AS billdate, isnull(billamt,credit) as billamt, 0 AS svctax, 0 AS cess,isnull(m.netamt,credit) as netamt, d.brcd AS loccode, isnull(d.credit, 0) AS tds, d.pbov_code AS pbov_code,d.acccode as tdsacccode,d.oppacccode,d.oppaccount  as oppaccdesc ,d.pbov_name AS pbov_Name,d1.transtype,d1.chqno,d1.chqdt,d1.paidamt,d1.bankname,d1.paydt,d1.brcd,d1.bankbrn from (vw_acctrans_" + yearSuffix + " d with (NOLOCK) left outer join  vw_tds_vendor_records m  with (NOLOCK) on d.voucherNo=m.docno or d.docno=m.docNo ) left outer join webx_tds_paydet d1 on   m.docno=d1.billno where  d.acccode='CLA0015' and d.credit > 0 and convert(varchar,d.transdate,106) between  Convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) and (d.voucher_cancel='N' or d.voucher_cancel is null) order by d.transdate";

           }
           
           
           
         
       }

     //  SqlCommand sqlcmd = new SqlCommand(s1, conn);
       //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

       SqlDataAdapter da = new SqlDataAdapter(s1, Session["SqlProvider"].ToString().Trim());


       ds = new DataSet();
       da.Fill(ds);
       
       dgTDSRpt.DataSource = ds;
       ds.Tables[0].Columns.Add("amtnew");
       ds.Tables[0].Columns.Add("dt");
      foreach(DataRow dr in ds.Tables[0].Rows)
      {
          Double d = 0;
          Double c = 0;
          if (dr["tds"] is DBNull)
          {
          }
          else
          {
              c = Convert.ToDouble(dr["tds"]);
          }
          if (dr["billamt"] is DBNull)
          {
          }
          else
          {
               d = Convert.ToDouble(dr["billamt"]);
               Double t = d - c;
               dr["amtnew"] = Convert.ToString(t);

          }

          if (dr["billdate"] is DBNull)
          {
          }
          else
          {
              string sss = Convert.ToDateTime(dr["billdate"]).ToString("dd MMM yyyy");
              dr["dt"] = sss;
          }

          if (dr["pbov_code"] is DBNull && dr["pbov_Name"] is DBNull)
          {
          }
          else
          {
              dr["pbov_Name"] = dr["pbov_code"].ToString() + " : " + dr["pbov_Name"].ToString();
          }


         
          




      }

    
       dgTDSRpt.DataBind();
       //conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgTDSRpt.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            dgTDSRpt.AllowPaging = false;
         
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=TDS.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            
                BindGrid();
                dgTDSRpt.RenderControl(hw);
           
            
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }
}


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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
using System.Text;
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    private GridViewHelper helper;
    String frmdate, todate, fdate, tdate, billno, mbillno, pcode, billtype, billstatus;
    decimal totcodchg, tothldchrg, totstatechrg, tothlddlychrg, totnformchrg, totfodcharge, tototchg, subtotal, totsvctax, totcess, totheducess;
    Boolean flgxls2;
    string Number;
    string deciml;
    string _number;
    string _deciml, iamegyrl = "";
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        totcodchg = tothldchrg = totstatechrg = tothlddlychrg = totnformchrg = totfodcharge = tototchg = subtotal = totsvctax = totcess = totheducess = 0.0M;
        Initialize();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        flgxls2 = false;
        iamegyrl = "http:/123.108.47.77/WebX/GUI/images/" + Session["Client"].ToString() + "_logo.JPG";
        if (!IsPostBack)
        {
            tblall.Visible = false;
            tblbillno.Visible = false;
            Array str, str1;
            billno = Request.QueryString["Bill_No"];
                      lblbillno.Text = billno;
            lblmbillno.Text = mbillno;
            lblccode.Text = pcode;
            if (lblbillno.Text == "" && lblmbillno.Text == "")
            {
                tblall.Visible = true;
            }
            else
            {
                tblbillno.Visible = true;
                if (lblbillno.Text != "")
                {
                    lblmbillno.Visible = false;
                    lbldmbillno.Visible = false;
                }
                else
                {
                    lblbillno.Visible = false;
                    lbldbillno.Visible = false;
                }
            }
           // BindTheData();

            xls1();
        }

    }
    public void BindTheData()
    {
        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;

        //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where billno='" + billno + "'";

        //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "Billdetail");
        //GrdLoadUnload.DataSource = ds.Tables["Billdetail"];
        //GrdLoadUnload.DataBind();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void xls1()
    {
        tblxls1.Visible = true;
        
        string bno =billno;
        //old structure
        //string sql = "select d.DOCKNO,d.DOCKSF,d.DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.DACC_CHRG,d.DKTCHG,d.CODCHG,d.DIPLOMATCHG,d.OTCHG,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_docket_invoicedet i where i.dockno=d.dockno and i.docksf=d.docksf),spl_svc_req,DCCharge,DDCharge,hld_chrg,state_chrg,hld_dlychrg,nform_chrg,FODCharge,0 as diesel_chrg,D.CESS,d.trn_mod from vw_Bill_Print_XLS d,Webx_billDET b where d.dockno=b.dockno and d.docksf=b.docksf and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        //new structure
        string sql = "select d.DKTTOT as dkttot,d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS as Cessamount,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet dsxls1 = new DataSet();
        da.Fill(dsxls1, "xls1");
        GrdXLS1.DataSource = dsxls1.Tables["xls1"];
        GrdXLS1.DataBind();
        //SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "' union select * from Webx_billmst_arch where billno='" + bno + "'", cn);
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblpartyname.Text = Convert.ToString(dr["ptmsnm"]);
            lblpbillno.Text = bno;
        }
        dr.Close();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=BillDeatail.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls1);
        frm.RenderControl(htmlWrite);
        //String tag = "<img src=" + Server.MapPath("..\\..\\..\\images\\webxpress_logo.gif") + " />";
        String tag = "<img src=" + iamegyrl + " />";
        Response.Write(tag);
        Response.Write(stringWrite.ToString());
        Response.End();
        //tblxls1.Visible = false; 
    }


    //protected void xls2(object sender, EventArgs e)
    //{
    //    flgxls2 = true;
    //    tblxls2.Visible = true;
    //    GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
    //    string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkportrait")).Text;
    //    lblABillNo.Text = bno;
    //    //old structure
    //    //string sql = "select d.DOCKNO,d.DOCKSF,d.DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,d.FOV,d.DACC_CHRG,d.DKTCHG,d.CODCHG,d.DIPLOMATCHG,d.OTCHG,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_docket_invoicedet i where i.dockno=d.dockno and i.docksf=d.docksf),spl_svc_req,DCCharge,DDCharge,hld_chrg,state_chrg,hld_dlychrg,nform_chrg,FODCharge,0 as diesel_chrg,D.CESS,d.trn_mod from vw_Bill_Print_XLS d,Webx_billDET b where d.dockno=b.dockno and d.docksf=b.docksf and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
    //    //new structure
    //    string sql = "select d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
    //    SqlDataAdapter da = new SqlDataAdapter(sql, cn);
    //    DataSet dsxls2 = new DataSet();
    //    da.Fill(dsxls2, "xls2");
    //    GrdXLS2.DataSource = dsxls2.Tables["xls2"];
    //    GrdXLS2.DataBind();
    //    lblcoddod.Text = Convert.ToString(totcodchg);
    //    lblhandlecharge.Text = Convert.ToString(tothldchrg);
    //    lblstatechrg.Text = Convert.ToString(totstatechrg);
    //    lblholidaychrg.Text = Convert.ToString(tothlddlychrg);
    //    lblnformcharge.Text = Convert.ToString(totnformchrg);
    //    lblfodcharge.Text = Convert.ToString(totfodcharge);
    //    lblothercharge.Text = Convert.ToString(tototchg);
    //    lblservicetax.Text = Convert.ToString(totsvctax);
    //    lblcessontax.Text = Convert.ToString(totcess);
    //    lblhigheducess.Text = Convert.ToString(totheducess);
    //    //lblsubtotal.Text = Convert.ToString(subtotal);
    //    //SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "' union select * from Webx_billmst_arch where billno='" + bno + "'", cn);
    //    SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", cn);
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    if (dr.Read())
    //    {
    //        lbltotal.Text = Convert.ToString(dr["BillAmt"]);
    //        amtword = Convert.ToString(dr["BillAmt"]);
    //        string currency = "Rupees ";
    //        string _currency = " Paise Only";
    //        if (Convert.ToDouble(amtword) == 0)
    //        {
    //            lbltotalinword.Text = "Zero";
    //            //return;
    //        }
    //        if (Convert.ToDouble(amtword) < 0)
    //        {
    //            lbltotalinword.Text = "Invalid Value";
    //            //return;
    //        }
    //        Boolean a = amtword.Contains(".");
    //        if (a == false)
    //        {
    //            amtword = amtword + ".00";
    //        }
    //        string[] no = amtword.Split('.');
    //        if ((no[0] != null) && (no[1] != "00"))
    //        {
    //            Number = no[0];
    //            deciml = no[1];
    //            _number = (NameOfNumber(Number));
    //            _deciml = (NameOfNumber(deciml));
    //            lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
    //        }
    //        if ((no[0] != null) && (no[1] == "00"))
    //        {
    //            Number = no[0];
    //            _number = (NameOfNumber(Number));
    //            lbltotalinword.Text = currency + _number + "Only";
    //        }
    //        if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
    //        {
    //            deciml = no[1];
    //            _deciml = (NameOfNumber(deciml));
    //            lbltotalinword.Text = _deciml + _currency;
    //        }


    //        //lbltotalinword.Text = "Rs. " + Convert.ToString(dr["BillAmt"]);
    //    }
    //    dr.Close();
    //    StringWriter stringWrite;
    //    HtmlTextWriter htmlWrite;
    //    HtmlForm frm = new HtmlForm();
    //    Response.Clear();
    //    Response.AddHeader("content-disposition", "attachment;filename=Portrait.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-xls";
    //    stringWrite = new System.IO.StringWriter();
    //    htmlWrite = new HtmlTextWriter(stringWrite);
    //    Controls.Add(frm);
    //    frm.Controls.Add(tblxls2);
    //    frm.RenderControl(htmlWrite);
    //    String tag = "<img src=" + iamegyrl + " />";
    //    Response.Write(tag);
    //    Response.Write(stringWrite.ToString());
    //    Response.End();
    //    tblxls2.Visible = false;
    //}
    //protected void xls3(object sender, EventArgs e)
    //{
    //    flgxls2 = false;
    //    tblxls2.Visible = true;
    //    GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
    //    string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkportrait")).Text;
    //    lblABillNo.Text = bno;

    //    //string sql = "select d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
    //    //Change 04 March 2008
    //    string sql = "select d.DOCKNO,d.docksf,CONVERT(varchar,d.DOCKDT,106) as DOCKDT,d.CSGNCD,d.CSGNNM,d.CSGECD,d.CSGENM,d.ORGNCD,d.REASSIGN_DESTCD,d.PKGSNO,d.ACTUWT,d.CHRGWT,d.DKTTOT,D.SVCTAX as servicetax,d.FOV,d.schg13 as DACC,d.schg01 as DKTCHG,d.schg12 as CODCHG,d.schg03 as OTCHG,d.schg21 as FOD,d.uchg01 as uchg01,d.uchg02 as uchg02,d.uchg03 as uchg03,d.uchg04 as uchg04,d.uchg05 as uchg05,d.FRT_RATE,FREIGHT,INVAMT=(select sum(DECLVAL) from Webx_master_docket_invoice i where i.dockno=d.dockno),spl_svc_req,schg07 as DCCharge,schg08 as DDCharge,schg05 as hld_chrg,schg09 as state_chrg,schg10 as hld_dlychrg,schg04 as nform_chrg,schg21 as FODCharge,schg20 as diesel_chrg,D.CESS,d.trn_mod,d.hedu_cess,SCHG19 as ODACharge,SCHG11 as FOVCharge,SCHG03 as OtherCharge from vw_docket_net d,Webx_billDET b where d.dockno=b.dockno  and d.docksf=b.docksf  and b.billno='" + bno + "' order by d.trn_mod,d.DOCKDT";
    //    SqlDataAdapter da = new SqlDataAdapter(sql, cn);
    //    DataSet dsxls2 = new DataSet();
    //    da.Fill(dsxls2, "xls2");
    //    GrdXLS2.DataSource = dsxls2.Tables["xls2"];
    //    GrdXLS2.DataBind();
    //    lblcoddod.Text = Convert.ToString(totcodchg);
    //    lblhandlecharge.Text = Convert.ToString(tothldchrg);
    //    lblstatechrg.Text = Convert.ToString(totstatechrg);
    //    lblholidaychrg.Text = Convert.ToString(tothlddlychrg);
    //    lblnformcharge.Text = Convert.ToString(totnformchrg);
    //    lblfodcharge.Text = Convert.ToString(totfodcharge);
    //    lblothercharge.Text = Convert.ToString(tototchg);
    //    lblservicetax.Text = Convert.ToString(totsvctax);
    //    lblcessontax.Text = Convert.ToString(totcess);
    //    lblhigheducess.Text = Convert.ToString(totheducess);
    //    //lblsubtotal.Text = Convert.ToString(subtotal);
    //    //SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "' union select * from Webx_billmst_arch where billno='" + bno + "'", cn);
    //    SqlCommand cmd = new SqlCommand("select * from Webx_billmst where billno='" + bno + "'", cn);
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    if (dr.Read())
    //    {
    //        lbltotal.Text = Convert.ToString(dr["BillAmt"]);
    //        //lbltotalinword.Text = "Rs. " + Convert.ToString(dr["BillAmt"]);
    //        amtword = Convert.ToString(dr["BillAmt"]);
    //        string currency = "Rupees ";
    //        string _currency = " Paise Only";
    //        if (Convert.ToDouble(amtword) == 0)
    //        {
    //            lbltotalinword.Text = "Zero";
    //            //return;
    //        }
    //        if (Convert.ToDouble(amtword) < 0)
    //        {
    //            lbltotalinword.Text = "Invalid Value";
    //            //return;
    //        }
    //        Boolean a = amtword.Contains(".");
    //        if (a == false)
    //        {
    //            amtword = amtword + ".00";
    //        }
    //        string[] no = amtword.Split('.');
    //        if ((no[0] != null) && (no[1] != "00"))
    //        {
    //            Number = no[0];
    //            deciml = no[1];
    //            _number = (NameOfNumber(Number));
    //            _deciml = (NameOfNumber(deciml));
    //            lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
    //        }
    //        if ((no[0] != null) && (no[1] == "00"))
    //        {
    //            Number = no[0];
    //            _number = (NameOfNumber(Number));
    //            lbltotalinword.Text = currency + _number + "Only";
    //        }
    //        if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
    //        {
    //            deciml = no[1];
    //            _deciml = (NameOfNumber(deciml));
    //            lbltotalinword.Text = _deciml + _currency;
    //        }
    //    }
    //    dr.Close();
    //    StringWriter stringWrite;
    //    HtmlTextWriter htmlWrite;
    //    HtmlForm frm = new HtmlForm();
    //    Response.Clear();
    //    Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-xls";
    //    stringWrite = new System.IO.StringWriter();
    //    htmlWrite = new HtmlTextWriter(stringWrite);
    //    Controls.Add(frm);
    //    frm.Controls.Add(tblxls2);
    //    frm.RenderControl(htmlWrite);
    //    String tag = "<img src=" + iamegyrl + " />";
    //    Response.Write(tag);
    //    Response.Write(stringWrite.ToString());
    //    Response.End();
    //    tblxls2.Visible = false;
    //}
    public string NameOfNumber(string Number)
    {
        string GroupName = "";
        string OutPut = "";

        if ((Number.Length % 3) != 0)
        {
            Number = Number.PadLeft((Number.Length + (3 - (Number.Length % 3))), '0');
        }
        string[] Array = new string[Number.Length / 3];
        Int16 Element = -1;
        Int32 DisplayCount = -1;
        bool LimitGroupsShowAll = false;
        int LimitGroups = 0;
        bool GroupToWords = true;
        for (Int16 Count = 0; Count <= Number.Length - 3; Count += 3)
        {
            Element += 1;
            Array[Element] = Number.Substring(Count, 3);

        }
        if (LimitGroups == 0)
        {
            LimitGroupsShowAll = true;
        }
        for (Int16 Count = 0; (Count <= ((Number.Length / 3) - 1)); Count++)
        {
            DisplayCount++;
            if (((DisplayCount < LimitGroups) || LimitGroupsShowAll))
            {
                if (Array[Count] == "000") continue;
                {
                    GroupName = US[((Number.Length / 3) - 1) - Count + 1];
                }


                if ((GroupToWords == true))
                {
                    OutPut += Group(Array[Count]).TrimEnd(' ') + " " + GroupName + " ";

                }
                else
                {
                    OutPut += Array[Count].TrimStart('0') + " " + GroupName;

                }
            }

        }
        Array = null;
        return OutPut;

    }


    private string Group(string Argument)
    {
        string Hyphen = "";
        string OutPut = "";
        Int16 d1 = Convert.ToInt16(Argument.Substring(0, 1));
        Int16 d2 = Convert.ToInt16(Argument.Substring(1, 1));
        Int16 d3 = Convert.ToInt16(Argument.Substring(2, 1));
        if ((d1 >= 1))
        {
            OutPut += SNu[d1] + " hundred ";
        }
        if ((double.Parse(Argument.Substring(1, 2)) < 20))
        {
            OutPut += SNu[Convert.ToInt16(Argument.Substring(1, 2))];
        }
        if ((double.Parse(Argument.Substring(1, 2)) >= 20))
        {
            if (Convert.ToInt16(Argument.Substring(2, 1)) == 0)
            {
                Hyphen += " ";
            }
            else
            {
                Hyphen += " ";
            }
            OutPut += SNt[d2] + Hyphen + SNu[d3];
        }
        return OutPut;
    }

    private void Initialize()
    {

        SNu[0] = "";
        SNu[1] = "One";
        SNu[2] = "Two";
        SNu[3] = "Three";
        SNu[4] = "Four";
        SNu[5] = "Five";
        SNu[6] = "Six";
        SNu[7] = "Seven";
        SNu[8] = "Eight";
        SNu[9] = "Nine";
        SNu[10] = "Ten";
        SNu[11] = "Eleven";
        SNu[12] = "Twelve";
        SNu[13] = "Thirteen";
        SNu[14] = "Fourteen";
        SNu[15] = "Fifteen";
        SNu[16] = "Sixteen";
        SNu[17] = "Seventeen";
        SNu[18] = "Eighteen";
        SNu[19] = "Nineteen";
        SNt[2] = "Twenty";
        SNt[3] = "Thirty";
        SNt[4] = "Forty";
        SNt[5] = "Fifty";
        SNt[6] = "Sixty";
        SNt[7] = "Seventy";
        SNt[8] = "Eighty";
        SNt[9] = "Ninety";
        US[1] = "";
        US[2] = "Thousand";
        US[3] = "Million";
        US[4] = "Billion";
        US[5] = "Trillion";
        US[6] = "Quadrillion";
        US[7] = "Quintillion";
        US[8] = "Sextillion";
        US[9] = "Septillion";
        US[10] = "Octillion";
    }
    protected void abc(object sender, EventArgs e)
    {

        //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;

    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        //GrdLoadUnload.PageIndex = e.NewPageIndex;
        //BindTheData();
        //GrdLoadUnload.DataBind(); 
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        ////str = " ORDER BY " + e.SortExpression;
        //DataView dv = new DataView();
        //dv = ds.Tables["Dockets"].DefaultView;
        //dv.Sort = e.SortExpression;
        //GrdLoadUnload.DataSource = ds.Tables["Dockets"];
        //GrdLoadUnload.DataBind();
        ////BindTheData();
    }

    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {

        //if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        //{
        //    E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        //    E.Item.Cells[0].CssClass = "blackfnt";
        //}

    }


    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    DateTime d1;
        //    if (((Label)e.Row.FindControl("lblgendate")).Text != "" && ((Label)e.Row.FindControl("lblgendate")).Text != null)
        //    {
        //        d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblgendate")).Text);
        //        ((Label)e.Row.FindControl("lblgendate")).Text = d1.ToString("dd MMM yyyy");
        //    }
        //    if (((Label)e.Row.FindControl("lblduedate")).Text != "" && ((Label)e.Row.FindControl("lblduedate")).Text != null)
        //    {
        //        d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblduedate")).Text);
        //        ((Label)e.Row.FindControl("lblduedate")).Text = d1.ToString("dd MMM yyyy");
        //    }
        //    if (((Label)e.Row.FindControl("lblsubdate")).Text != "" && ((Label)e.Row.FindControl("lblsubdate")).Text != null)
        //    {
        //        d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblsubdate")).Text);
        //        ((Label)e.Row.FindControl("lblsubdate")).Text = d1.ToString("dd MMM yyyy");
        //    }
        //    if (((Label)e.Row.FindControl("lblcollectiondate")).Text != "" && ((Label)e.Row.FindControl("lblcollectiondate")).Text != null)
        //    {
        //        d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblcollectiondate")).Text);
        //        ((Label)e.Row.FindControl("lblcollectiondate")).Text = d1.ToString("dd MMM yyyy");
        //    }
        //    ((Label)e.Row.FindControl("lblbilltype")).Text = ((Label)e.Row.FindControl("lblbilltype")).Text == "2" ? "TBB" : ((Label)e.Row.FindControl("lblbilltype")).Text;

        //}
        ////if (Convert.ToString(Session["Client"]) == "EXL")
        ////{
        ////    e.Row.Cells[10].Visible = false;
        ////    e.Row.Cells[11].Visible = false;
        ////    e.Row.Cells[13].Visible = false;
        ////    e.Row.Cells[14].Visible = false;

        ////}
        //else if (Convert.ToString(Session["Client"]) == "PRRL")
        //{
        //    e.Row.Cells[10].Visible = false;
        //    e.Row.Cells[12].Visible = false;
        //    e.Row.Cells[13].Visible = false;
        //    e.Row.Cells[14].Visible = false;
        //}
        ////else if (Convert.ToString(Session["Client"]) == "RCI")
        ////{
        ////    e.Row.Cells[10].Visible = false;
        ////    e.Row.Cells[11].Visible = false;
        ////    e.Row.Cells[12].Visible = false;
        ////}
        //else if (Convert.ToString(Session["Client"]) == "UFL")
        //{
        //    e.Row.Cells[10].Visible = false;
        //    e.Row.Cells[11].Visible = false;
        //    e.Row.Cells[12].Visible = false;
        //    e.Row.Cells[13].Visible = false;
        //}
        //else
        //{
        //    e.Row.Cells[11].Visible = false;
        //    e.Row.Cells[12].Visible = false;
        //    e.Row.Cells[13].Visible = false;
        //    e.Row.Cells[14].Visible = false;
        //}
    }
    protected void GrdXLS1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Docket";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Bill";
            oTableCell.ColumnSpan = 17;
            oTableCell.Font.Bold = true;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblmode;
            string mode, dno, sql, invno;
            mode = ((Label)e.Row.FindControl("lblmode")).Text;
            lblmode = (Label)e.Row.FindControl("lblmode");
            if (mode == "0")
            {
                lblmode.Text = "No Mode";
            }
            else if (mode == "1")
            {
                lblmode.Text = "Air";
            }
            else if (mode == "2")
            {
                lblmode.Text = "Road";
            }
            else if (mode == "3")
            {
                lblmode.Text = "Train";
            }
            else if (mode == "4")
            {
                lblmode.Text = "Express";
            }
            dno = ((Label)e.Row.FindControl("lblinvoiceno")).Text;
            sql = "select distinct invno from Webx_master_docket_invoice where Dockno='" + dno + "'";
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand(sql, cn);
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            dr = cmd.ExecuteReader();
            invno = "";
            while (dr.Read())
            {
                invno = invno + "," + Convert.ToString(dr["invno"]);
            }
            if (invno.Length > 0)
            {
                invno = invno.Substring(1, invno.Length - 1);
            }
            dr.Close();
            ((Label)e.Row.FindControl("lblinvoiceno")).Text = invno;
        }
    }
    protected void GrdXLS2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //if (flgxls2 == false)
            //{
            //    ((Label)e.Row.FindControl("lblheader")).Visible = false;
            //}
            //else 
            //{
            //    ((Label)e.Row.FindControl("lblheader")).Visible = true;
            //}
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblmode;
            string mode, dno, sql, invno;
            mode = ((Label)e.Row.FindControl("lblmode")).Text;
            lblmode = (Label)e.Row.FindControl("lblmode");
            if (mode == "0")
            {
                lblmode.Text = "No Mode";
            }
            else if (mode == "1")
            {
                lblmode.Text = "Air";
            }
            else if (mode == "2")
            {
                lblmode.Text = "Road";
            }
            else if (mode == "3")
            {
                lblmode.Text = "Train";
            }
            else if (mode == "4")
            {
                lblmode.Text = "Express";
            }
            //dno = ((Label)e.Row.FindControl("lblinvoiceno")).Text;
            //sql = "select distinct invno from Webx_master_docket_invoice where Dockno='" + dno + "'";
            //SqlDataReader dr;
            //SqlCommand cmd = new SqlCommand(sql, cn);
            //if (cn.State == ConnectionState.Closed)
            //{
            //    cn.Open();
            //}
            //dr = cmd.ExecuteReader();
            //invno = "";
            //while (dr.Read())
            //{
            //    invno = invno + "," + Convert.ToString(dr["invno"]);
            //}
            //if (invno.Length > 0)
            //{
            //    invno = invno.Substring(1, invno.Length - 1);
            //}
            //dr.Close();
            //((Label)e.Row.FindControl("lblinvoiceno")).Text = invno;
            //if (flgxls2 == false)
            //{
            //    ((Label)e.Row.FindControl("lblinvoiceno")).Visible = false;
            //}
            //else
            //{
            //    ((Label)e.Row.FindControl("lblinvoiceno")).Visible = true;
            //}
            //lblotchg,lbltotamt

            //((Label)e.Row.FindControl("lblotchg")).Text = Convert.ToString(Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "codchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "codchg")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_chrg")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "state_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "state_chrg")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_dlychrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_dlychrg")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "nform_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "nform_chrg")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "fod") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "fod")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "otchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "otchg")));
            //((Label)e.Row.FindControl("lbltotamt")).Text = Convert.ToString(Convert.ToDecimal(((Label)e.Row.FindControl("lblotchg")).Text) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "freight") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "freight")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "dktchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "dktchg")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "dccharge") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "dccharge")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ddcharge") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "ddcharge")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "fov") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "fov")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "uchg01") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "uchg01")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "uchg02") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "uchg02")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "uchg03") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "uchg03")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "uchg04") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "uchg04")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "uchg05") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "uchg05")));
            //subtotal = subtotal + Convert.ToDecimal(((Label)e.Row.FindControl("lbltotamt")).Text);
        }
        totcodchg = totcodchg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "codchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "codchg"));
        tothldchrg = tothldchrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_chrg"));
        totstatechrg = totstatechrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "state_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "state_chrg"));
        tothlddlychrg = tothlddlychrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_dlychrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_dlychrg"));
        totnformchrg = totnformchrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "nform_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "nform_chrg"));
        totfodcharge = totfodcharge + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "fod") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "fod"));
        tototchg = tototchg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "otchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "otchg"));
        totsvctax = totsvctax + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "servicetax") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "servicetax"));
        totcess = totcess + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "cess"));
        totheducess = totheducess + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hedu_cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hedu_cess"));
    }
}

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
using System.Globalization;
using System.IO;
public partial class FrmDocketDetail : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    string[] Arr = new string[2];
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    string strqry,mainmode,submode;
    string fdate, tdate, RO, LocCode, CCode, paybaseitem, modeitem, TMode, pitmnm, mitmnm, actpaybas;
    public static string inactpaybas;
    MyFunctions fn = new MyFunctions();
    Boolean lpa, cpa;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        TMode = "";
        mainmode = Convert.ToString(Request.QueryString["mainmode"]);
        submode = Convert.ToString(Request.QueryString["submode"]);  
        //lblDateRange.Text = Convert.ToString(Request.QueryString["daterange"]);
        //lblLocation.Text = Convert.ToString(Request.QueryString["Location"]);
        Array str, str1;
        fdate = Request.QueryString["FrmDate"];
        tdate = Request.QueryString["ToDate"];
        str = fdate.Split('/');
        str1 = tdate.Split('/');
        //((string[])(str))[0]
        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
        //CultureInfo a = CultureInfo.CurrentCulture;  
        //lblDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
        lblDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate);
        TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
        RO = Request.QueryString["RO"];
        lblRO.Text = RO;
        LocCode = Request.QueryString["LocCode"];
        CCode = Request.QueryString["CCode"];
        paybaseitem = Request.QueryString["paybasitem"];
        lbllocation.Text = LocCode;
        lblccode.Text = CCode == "" ? "All" : CCode;  
        lblrpttype.Text = mainmode + " " + submode; 
        pitmnm = ""; 
        mitmnm = "";
        lpa = false;
        cpa = false;
        if (paybaseitem != "")
        {
            if (paybaseitem == "P01")
            {
                pitmnm = "paid";
            }
            else if (paybaseitem == "P02")
            {
                pitmnm = "tbb";
            }
            else if (paybaseitem == "P03")
            {
                pitmnm = "topay";
            }
            else if (paybaseitem == "P08")
            {
                pitmnm = "bod";
            }
            else if (paybaseitem == "P09")
            {
                pitmnm = "national";
            }
            else if (paybaseitem == "P04")
            {
                pitmnm = "foc";
            }
        }
        lblpaybas.Text = paybaseitem != "All" ? pitmnm.ToUpper()  : paybaseitem; 
        modeitem = Request.QueryString["modeitem"];
        //lblmode.Text = modeitem == "1" ? "Air" || modeitem == "2" ? "Road" || modeitem == "3" ? "Train" || modeitem == "4" ? "Express" : "All";  
        if (modeitem != "")
        {
            if (modeitem == "1")
            {
                lblmode.Text = "Air";
            }
            else if (modeitem == "2")
            {
                lblmode.Text = "Road";
            }
            else if (modeitem == "3")
            {
                lblmode.Text = "Train";
            }
            else if (modeitem == "4")
            {
                lblmode.Text = "Express";
            }
        }
        else
        {
            lblmode.Text = "All";
        }
        actpaybas = "";
        String sqlstr = "select codedesc,codeid from webx_master_general where codetype='paytyp' and statuscode='Y'";
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        cn.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            actpaybas = actpaybas + Convert.ToString(dr[1]).ToUpper() + ",";
        }
        string[] names = new string[] { "P04", "P09", "P08", "P03", "P02", "P01" };
        inactpaybas="";
        for (int i = 0; i <= names.Length - 1; i++)
        {
            if (actpaybas.Contains(Convert.ToString(names[i])) == false)
            {
                inactpaybas = inactpaybas + Convert.ToString(names[i]) + ",";
            }
        }
        inactpaybas = inactpaybas.Substring(0, inactpaybas.Length - 1);
        dr.Close();
        cn.Close();
        if (!IsPostBack)
        {
            selectdata();            
        }
    }
    protected void selectdata()
    {
        switch (mainmode)
        {
            case "locwise":
                if (submode == "paybaswise")
                {
                    if (paybaseitem == "All")
                    {
                        lpa = true;
                        TMode = "locpayall";
                        generatedata("webx_UNI_Sales_sum_LOC", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, paybaseitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        string[] cols = new string[1];
                        cols[0] = "report_loc";
                        helper.RegisterGroup(cols, true, true);
                        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("t_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("t_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("t_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);
                        if (P08 != false)
                        {
                            helper.RegisterSummary("b_Cnotes", SummaryOperation.Sum);
                            helper.RegisterSummary("b_wt", SummaryOperation.Sum);
                            helper.RegisterSummary("b_dkttot", SummaryOperation.Sum);
                            helper.RegisterSummary("Y3", SummaryOperation.Sum);
                        }
                        helper.RegisterSummary("tp_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("tp_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("tp_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y4", SummaryOperation.Sum);
                        helper.RegisterSummary("n_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("n_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("n_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y5", SummaryOperation.Sum);
                        helper.RegisterSummary("can", SummaryOperation.Sum);
                        helper.RegisterSummary("f_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("TotDocket", SummaryOperation.Sum);
                        helper.RegisterSummary("TotWeight", SummaryOperation.Sum);
                        helper.RegisterSummary("TotAmount", SummaryOperation.Sum);
                        helper.RegisterSummary("YTotal", SummaryOperation.Sum);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("p_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y1", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("t_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("t_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("t_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y2", SummaryOperation.Sum, "report_loc");
                        if (P08 != false)
                        {
                            helper.RegisterSummary("b_Cnotes", SummaryOperation.Sum, "report_loc");
                            helper.RegisterSummary("b_wt", SummaryOperation.Sum, "report_loc");
                            helper.RegisterSummary("b_dkttot", SummaryOperation.Sum, "report_loc");
                            helper.RegisterSummary("Y3", SummaryOperation.Sum, "report_loc");
                        }
                        helper.RegisterSummary("tp_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("tp_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("tp_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y4", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("n_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("n_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("n_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y5", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("can", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("f_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("TotDocket", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("TotWeight", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("TotAmount", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("YTotal", SummaryOperation.Sum, "report_loc");
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                        
                    }
                    else
                    {
                        TMode = "locpay";
                        generatedata("webx_UNI_Sales_sum_LOC_paybas", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, paybaseitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        string[] cols = new string[1];
                        cols[0] = "report_loc";
                        helper.RegisterGroup(cols, true, true);
                        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("Tot_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);

                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum,"report_loc");
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum,"report_loc");
                        helper.RegisterSummary("p_amt", SummaryOperation.Sum,"report_loc");
                        helper.RegisterSummary("Y1", SummaryOperation.Sum,"report_loc");
                        helper.RegisterSummary("tot_cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("tot_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Tot_amt", SummaryOperation.Sum, "report_loc");                      
                        helper.RegisterSummary("Y2", SummaryOperation.Sum,"report_loc");
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                    }
                    bindlocpaybas();
                   
                    //GrdToPayFollow.DataBind();
                }
                else if (submode == "modewise")
                {
                    if (modeitem == "All")
                    {
                        TMode = "locmodall";
                        generatedata("webx_UNI_Sales_sum_LOC_TRANMOD_All", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, modeitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        string[] cols = new string[1];
                        cols[0] = "report_loc";
                        helper.RegisterGroup(cols, true, true);
                        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("t_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("t_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("t_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);
                        helper.RegisterSummary("b_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("b_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("b_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y3", SummaryOperation.Sum);
                        helper.RegisterSummary("f_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("f_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("f_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y4", SummaryOperation.Sum);
                        helper.RegisterSummary("can", SummaryOperation.Sum);
                        helper.RegisterSummary("TotDocket", SummaryOperation.Sum);
                        helper.RegisterSummary("TotWeight", SummaryOperation.Sum);
                        helper.RegisterSummary("TotAmount", SummaryOperation.Sum);
                        helper.RegisterSummary("YTotal", SummaryOperation.Sum);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("p_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y1", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("t_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("t_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("t_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y2", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("b_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("b_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("b_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y3", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("f_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("f_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("f_dkttot", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y4", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("can", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("TotDocket", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("TotWeight", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("TotAmount", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("YTotal", SummaryOperation.Sum, "report_loc");
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                    }
                    else
                    {
                        TMode = "locmod";
                        generatedata("webx_UNI_Sales_sum_LOC_TRNMOD", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, modeitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        string[] cols = new string[1];
                        cols[0] = "report_loc";
                        helper.RegisterGroup(cols, true, true);
                        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("Tot_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);

                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("p_amt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y1", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("tot_cnotes", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("tot_wt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Tot_amt", SummaryOperation.Sum, "report_loc");
                        helper.RegisterSummary("Y2", SummaryOperation.Sum, "report_loc");
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                    }
                    bindlocmode();
                    
                }
                
                GrdToPayFollow.DataBind();
                if (lpa == true)
                {
                    string js = "<script language =\"javascript\" type=\"text/javascript\">columnhide()</script>";
                    Page.RegisterStartupScript("aaa", js);
                }
                break;
            case "custwise":
                if (submode == "paybaswise")
                {
                    if (paybaseitem == "All")
                    {
                        TMode = "cuspayall";
                        cpa = true;
                        generatedata("webx_UNI_Sales_custwise", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, paybaseitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        //string[] cols = new string[1];
                        //cols[0] = "report_loc";
                        //helper.RegisterGroup(cols, true, true);
                        //helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("t_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("t_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("t_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);
                        helper.RegisterSummary("b_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("b_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("b_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y3", SummaryOperation.Sum);
                        helper.RegisterSummary("tp_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("tp_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("tp_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y4", SummaryOperation.Sum);
                        helper.RegisterSummary("n_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("n_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("n_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y5", SummaryOperation.Sum);
                        helper.RegisterSummary("can", SummaryOperation.Sum);
                        helper.RegisterSummary("f_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("TotDocket", SummaryOperation.Sum);
                        helper.RegisterSummary("TotWeight", SummaryOperation.Sum);
                        helper.RegisterSummary("TotAmount", SummaryOperation.Sum);
                        helper.RegisterSummary("YTotal", SummaryOperation.Sum);
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                    }
                    else
                    {
                        TMode = "cuspay";
                        generatedata("webx_UNI_Sales_sum_custwise_paybas", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, paybaseitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("Tot_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                    }
                    bindcuspaybas();
                    GrdToPayFollow.DataBind();
                    if (cpa == true)
                    {
                        string js = "<script language =\"javascript\" type=\"text/javascript\">columnhide()</script>";
                        Page.RegisterStartupScript("aaa", js);
                    }
                }
                else if (submode == "modewise")
                {
                    if (modeitem == "All")
                    {
                        TMode = "cusmodall";
                        generatedata("webx_UNI_Sales_custwise_trnmod_all", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, modeitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("t_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("t_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("t_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);
                        helper.RegisterSummary("b_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("b_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("b_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y3", SummaryOperation.Sum);
                        helper.RegisterSummary("f_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("f_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("f_dkttot", SummaryOperation.Sum);
                        helper.RegisterSummary("Y4", SummaryOperation.Sum);
                        helper.RegisterSummary("can", SummaryOperation.Sum);
                        helper.RegisterSummary("TotDocket", SummaryOperation.Sum);
                        helper.RegisterSummary("TotWeight", SummaryOperation.Sum);
                        helper.RegisterSummary("TotAmount", SummaryOperation.Sum);
                        helper.RegisterSummary("YTotal", SummaryOperation.Sum);
                        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
                    }
                    else
                    {
                        TMode = "cusmod";
                        generatedata("webx_UNI_Sales_sum_custwise_trnmod", TxtFDt.Text, TxtTDt.Text, RO, LocCode, CCode, modeitem);
                        GridViewHelper helper = new GridViewHelper(this.GrdToPayFollow);
                        helper.RegisterSummary("p_Cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("p_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("p_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y1", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_cnotes", SummaryOperation.Sum);
                        helper.RegisterSummary("tot_wt", SummaryOperation.Sum);
                        helper.RegisterSummary("Tot_amt", SummaryOperation.Sum);
                        helper.RegisterSummary("Y2", SummaryOperation.Sum);
                    }
                    bindcusmode();
                    GrdToPayFollow.DataBind();
                }
                //bindmfin();
                break;
            case "empwise":
                if (submode == "paybaswise")
                {

                }
                else if (submode == "modewise")
                {

                }
                //bindmfout(); 
                break;
            case "destwise":
                if (submode == "paybaswise")
                {

                }
                else if (submode == "modewise")
                {

                }
                //binddrs(); 
                break;
            default:
                break;
        }
    }
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = row.Cells[0].Text;
            row.Cells[0].CssClass = "blackfnt";   
        }
    }
    private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    {
        //row.BackColor = System.Drawing.Color.FromName("#D4E0E7");    
        //row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].Text = "Total";
        row.Cells[0].CssClass = "blackfnt";
        //if (P08 != false)
        //{
        //    row.Cells[15].Visible = false;
        //    row.Cells[16].Visible = false;
        //    row.Cells[17].Visible = false;
        //    row.Cells[18].Visible = false;
        //}
    }
    protected void generatedata(string sp,string fd,string td,string ro,string lo,string cc,string mo)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        //exec webx_unloading_locading '01 june 07','22 june 07','All','All'
        cmd.CommandText = sp;
        cmd.Parameters.AddWithValue("@FROMDT", fd);
        cmd.Parameters.AddWithValue("@TODT", td);
        cmd.Parameters.AddWithValue("@RO", ro);
        cmd.Parameters.AddWithValue("@ORGNCD", lo);
        cmd.Parameters.AddWithValue("@LOCTYP", cc);
        cmd.Parameters.AddWithValue("@payTYP",mo);  
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        if (ds.Tables.Contains("SalesSummary")) { ds.Tables["SalesSummary"].Columns.Clear(); }
        sqlDA.Fill(ds, "SalesSummary");
        DataRow dr;
        if ((TMode == "locpayall") || (TMode == "cuspayall"))
        {
            DataColumn dc1 = new DataColumn("Y1", typeof(Decimal));
            DataColumn dc2 = new DataColumn("Y2", typeof(Decimal));
            DataColumn dc3 = new DataColumn("Y3", typeof(Decimal));
            DataColumn dc4 = new DataColumn("Y4", typeof(Decimal));
            DataColumn dc5 = new DataColumn("Y5", typeof(Decimal));
            DataColumn dc6 = new DataColumn("YTotal", typeof(Decimal));
            DataColumn dc7 = new DataColumn("TotDocket", typeof(Decimal));
            DataColumn dc8 = new DataColumn("TotWeight", typeof(Decimal));
            DataColumn dc9 = new DataColumn("TotAmount", typeof(Decimal));
            ds.Tables["SalesSummary"].Columns.Add(dc1);
            ds.Tables["SalesSummary"].Columns.Add(dc2);
            ds.Tables["SalesSummary"].Columns.Add(dc3);
            ds.Tables["SalesSummary"].Columns.Add(dc4);
            ds.Tables["SalesSummary"].Columns.Add(dc5);
            ds.Tables["SalesSummary"].Columns.Add(dc6);
            ds.Tables["SalesSummary"].Columns.Add(dc7);
            ds.Tables["SalesSummary"].Columns.Add(dc8);
            ds.Tables["SalesSummary"].Columns.Add(dc9);
            for (int i = 0; i < ds.Tables["SalesSummary"].Rows.Count; i++)
            {
                //decimal a, b;
                dr = ds.Tables["SalesSummary"].Rows[i];
                dr["Y1"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["P_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["P_wt"]));
                dr["Y2"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["t_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["t_wt"]));
                dr["Y3"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["b_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["b_wt"]));
                dr["Y4"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["tp_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["tp_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["tp_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["tp_wt"]));
                dr["Y5"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["n_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["n_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["n_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["n_wt"]));
                dr["YTotal"] = Convert.ToDecimal(dr["Y1"]) + Convert.ToDecimal(dr["Y2"]) + Convert.ToDecimal(dr["Y3"]) + Convert.ToDecimal(dr["Y4"]) + Convert.ToDecimal(dr["Y5"]);
                dr["TotDocket"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_Cnotes"]) + +Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["tp_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["tp_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["n_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["n_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["f_cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["f_cnotes"]));
                dr["TotWeight"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_wt"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_wt"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_wt"]) + +Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["tp_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["tp_wt"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["n_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["n_wt"]));
                dr["TotAmount"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_dkttot"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_dkttot"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_dkttot"]) + +Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["tp_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["tp_dkttot"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["n_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["n_dkttot"]));
            }
        }
        if ((TMode == "locpay") || (TMode == "locmod") || (TMode == "cuspay") || (TMode == "cusmod"))
        {
            DataColumn dc1 = new DataColumn("Y1", typeof(Decimal));
            DataColumn dc2 = new DataColumn("Y2", typeof(Decimal));
            ds.Tables["SalesSummary"].Columns.Add(dc1);
            ds.Tables["SalesSummary"].Columns.Add(dc2);
            for (int i = 0; i < ds.Tables["SalesSummary"].Rows.Count; i++)
            {
                //decimal a, b;
                dr = ds.Tables["SalesSummary"].Rows[i];
                dr["Y1"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["P_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["P_wt"]));
                dr["Y2"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["tot_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["tot_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["tot_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["tot_wt"]));
            }
        }
        if (TMode == "locmodall" || TMode == "cusmodall")
        {
            DataColumn dc1 = new DataColumn("Y1", typeof(Decimal));
            DataColumn dc2 = new DataColumn("Y2", typeof(Decimal));
            DataColumn dc3 = new DataColumn("Y3", typeof(Decimal));
            DataColumn dc4 = new DataColumn("Y4", typeof(Decimal));
            //DataColumn dc5 = new DataColumn("Y5", typeof(Decimal));
            DataColumn dc6 = new DataColumn("YTotal", typeof(Decimal));
            DataColumn dc7 = new DataColumn("TotDocket", typeof(Decimal));
            DataColumn dc8 = new DataColumn("TotWeight", typeof(Decimal));
            DataColumn dc9 = new DataColumn("TotAmount", typeof(Decimal));
            ds.Tables["SalesSummary"].Columns.Add(dc1);
            ds.Tables["SalesSummary"].Columns.Add(dc2);
            ds.Tables["SalesSummary"].Columns.Add(dc3);
            ds.Tables["SalesSummary"].Columns.Add(dc4);
            //ds.Tables["SalesSummary"].Columns.Add(dc5);
            ds.Tables["SalesSummary"].Columns.Add(dc6);
            ds.Tables["SalesSummary"].Columns.Add(dc7);
            ds.Tables["SalesSummary"].Columns.Add(dc8);
            ds.Tables["SalesSummary"].Columns.Add(dc9);
            for (int i = 0; i < ds.Tables["SalesSummary"].Rows.Count; i++)
            {
                dr = ds.Tables["SalesSummary"].Rows[i];
                dr["Y1"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["P_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["P_wt"]));
                dr["Y2"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["t_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["t_wt"]));
                dr["Y3"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["b_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["b_wt"]));
                dr["Y4"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["f_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["f_dkttot"]) / Convert.ToDecimal(Convert.ToDouble(ds.Tables["SalesSummary"].Rows[i]["f_wt"]) == 0.00 ? 1.00 : ds.Tables["SalesSummary"].Rows[i]["f_wt"]));
                dr["YTotal"] = Convert.ToDecimal(dr["Y1"]) + Convert.ToDecimal(dr["Y2"]) + Convert.ToDecimal(dr["Y3"]) + Convert.ToDecimal(dr["Y4"]);
                dr["TotDocket"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_Cnotes"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["f_Cnotes"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["f_Cnotes"]));
                dr["TotWeight"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_wt"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_wt"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_wt"]) +Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["f_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["f_wt"]));
                dr["TotAmount"] = (Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["P_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["P_dkttot"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["t_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["t_dkttot"]) + Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["b_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["b_dkttot"]) +Convert.ToDecimal(ds.Tables["SalesSummary"].Rows[i]["f_dkttot"] == System.DBNull.Value ? 0.00 : ds.Tables["SalesSummary"].Rows[i]["f_dkttot"]));
            }
 
        }
        GrdToPayFollow.DataSource = ds.Tables["SalesSummary"];
        if (ds.Tables["SalesSummary"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false; 
        }
    }
    protected void bindlocpaybas()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        //GrdToPayFollow.Columns.Clear();

        //if (GrdToPayFollow.Columns.Count > 1)
        //{
           // for (int i = 2; i <= GrdToPayFollow.Columns.Count; i++)
            //{
            //    GrdToPayFollow.Columns.RemoveAt(i - 1);  
            //}
        //}
        if (GrdToPayFollow.Columns.Count == 1)
        {
            BoundField bf_HelpDesk = new BoundField();
            bf_HelpDesk = new BoundField();
            bf_HelpDesk.HeaderText = "report_loc";
            bf_HelpDesk.DataField = "report_loc";
            bf_HelpDesk.HtmlEncode = false;
            bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
            bf_HelpDesk.Visible = false;
            bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
            bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
            bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            GrdToPayFollow.Columns.Add(bf_HelpDesk);


            bf_HelpDesk = new BoundField();
            ////  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
            //bf_HelpDesk.HeaderText = "SR.NO.";
            //bf_HelpDesk.DataField = "SR.No";
            ////bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
            //bf_HelpDesk.HtmlEncode = false;
            //bf_HelpDesk.ControlStyle.CssClass = "blackfnt";   
            ////bf_HelpDesk.SortExpression = "locName";
            //GrdToPayFollow.Columns.Add(bf_HelpDesk);
            if (TMode == "locpayall")
            {

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Loc Code";
                bf_HelpDesk.DataField = "loccode";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "locName";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=paid&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "t_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=tbb&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.DataField = "t_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "t_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "b_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=topay&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);
                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.DataField = "b_wt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "b_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y3";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "tp_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=bod&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "tp_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "tp_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y4";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "n_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=national&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "n_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "n_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y5";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Cancelled";
                bf_HelpDesk.DataField = "Can";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = "FOC";
                hf_HelpDesk.DataTextField = "f_cnotes";
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=foc&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "TotDocket";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=tot&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "TotWeight";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "TotAmount";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right ;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "YTotal";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
            if (TMode == "locpay")
            {
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Loc Code";
                bf_HelpDesk.DataField = "loccode";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "locName";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=" + pitmnm + "&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText = Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "Tot_cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=tot&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "Tot_wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "Tot_Amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
        }
    }
    protected void bindlocmode()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        //GrdToPayFollow.Columns.Clear();
        //Unit un;
        //un = new Unit(10);
        if (GrdToPayFollow.Columns.Count == 1)
        {

            BoundField bf_HelpDesk = new BoundField();
            bf_HelpDesk = new BoundField();
            bf_HelpDesk.HeaderText = "report_loc";
            bf_HelpDesk.DataField = "report_loc";
            bf_HelpDesk.HtmlEncode = false;
            bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
            bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
            bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
            bf_HelpDesk.Visible = false;
            bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
            bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
            bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            GrdToPayFollow.Columns.Add(bf_HelpDesk);

            if (TMode == "locmodall")
            {
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Loc Code";
                bf_HelpDesk.DataField = "loccode";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "locName";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;

                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=1&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "t_Cnotes";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=2&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "t_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "t_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataTextField = "b_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=3&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "b_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "b_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y3";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "f_Cnotes";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=4&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "f_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "f_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y4";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Cancelled";
                bf_HelpDesk.DataField = "Can";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "TotDocket";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=tot_M&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "TotWeight";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "TotAmount";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "YTotal";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
            if (TMode == "locmod")
            {
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Loc Code";
                bf_HelpDesk.DataField = "loccode";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Location";
                bf_HelpDesk.DataField = "locName";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=" + modeitem + "&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "Tot_cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "loccode";
                Arr[1] = "locname";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=tot_M&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "Tot_wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "Tot_Amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

            }
        }
      
    }
    protected void bindcuspaybas()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        //GrdToPayFollow.Columns.Clear();
        if (GrdToPayFollow.Columns.Count == 1)
        {
            if (TMode == "cuspayall")
            {
                BoundField bf_HelpDesk;
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party Code";
                bf_HelpDesk.DataField = "csgncd";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party Name";
                bf_HelpDesk.DataField = "csgnnm";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=paid&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "t_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=tbb&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "t_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "t_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "b_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=topay&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "b_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "b_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y3";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "tp_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=bod&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "tp_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "tp_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y4";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "n_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=national&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "n_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "n_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y5";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Cancelled";
                bf_HelpDesk.DataField = "Can";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "FOC";
                bf_HelpDesk.DataField = "f_cnotes";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "TotDocket";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=tot&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "TotWeight";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "TotAmount";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "YTotal";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
            if (TMode == "cuspay")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party Code";
                bf_HelpDesk.DataField = "csgncd";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party Name";
                bf_HelpDesk.DataField = "csgnnm";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataTextField = "p_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=" + pitmnm + "&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "Tot_cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=tot&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "Tot_wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "Tot_Amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
        }
    }
    protected void bindcusmode()
    {
        GrdToPayFollow.AutoGenerateColumns = false;
        GrdToPayFollow.AllowSorting = false;
        //GrdToPayFollow.Columns.Clear();
        if (GrdToPayFollow.Columns.Count == 1)
        {
            if (TMode == "cusmodall")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party Code";
                bf_HelpDesk.DataField = "csgncd";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party";
                bf_HelpDesk.DataField = "csgnnm";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Red;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=1&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();
            //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.DataTextField = "t_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=2&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "t_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "t_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "b_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=locwise&loccode1={0}&locname={1}&val=3&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "b_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "b_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y3";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                hf_HelpDesk = new HyperLinkField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "f_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=4&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "f_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "f_dkttot";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();

                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y4";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Cancelled";
                bf_HelpDesk.DataField = "Can";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "TotDocket";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=tot_M&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "TotWeight";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "TotAmount";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "YTotal";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);
            }
            if (TMode == "cusmod")
            {
                BoundField bf_HelpDesk = new BoundField();
                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party Code";
                bf_HelpDesk.DataField = "csgncd";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Party";
                bf_HelpDesk.DataField = "csgnnm";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                HyperLinkField hf_HelpDesk;
                hf_HelpDesk = new HyperLinkField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "p_Cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=" + modeitem + "&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataField = "P_wt";
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "p_amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y1";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.HeaderText =  Convert.ToString(Session["DocketCalledAs"]);
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                hf_HelpDesk.DataTextField = "Tot_cnotes";
                //hf_HelpDesk.ControlStyle.ForeColor = System.Drawing.Color.Blue;
                hf_HelpDesk.ControlStyle.Font.Underline = true;
                //hf_HelpDesk.ItemStyle.Font.Underline = true;
                Array.Clear(Arr, 0, 2);
                hf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                hf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                hf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                Arr[0] = "csgncd";
                Arr[1] = "csgnnm";
                hf_HelpDesk.DataNavigateUrlFields = Arr;
                hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?q_select=custwise&loccode1={0}&locname={1}&val=tot_M&custcode=" + CCode + "&FromDt=" + fdate + "&ToDt=" + tdate + "";
                GrdToPayFollow.Columns.Add(hf_HelpDesk);


                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "wt";
                bf_HelpDesk.DataField = "Tot_wt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Amount";
                bf_HelpDesk.DataField = "Tot_Amt";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                //bf_HelpDesk.DataFormatString = "{0:MM/dd/yyyy}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Right;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

                bf_HelpDesk = new BoundField();
                //  bf_HelpDesk.HeaderStyle.Width = Unit.Percentage(5);
                bf_HelpDesk.HeaderText = "Yield";
                bf_HelpDesk.DataField = "Y2";
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";  
                bf_HelpDesk.DataFormatString = "{0:F2}";
                bf_HelpDesk.HtmlEncode = false;
                //bf_HelpDesk.SortExpression = "locName";
                bf_HelpDesk.ItemStyle.BackColor = System.Drawing.Color.White;
                bf_HelpDesk.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                bf_HelpDesk.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GrdToPayFollow.Columns.Add(bf_HelpDesk);

            }
        }

    }
    
    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        _counter = e.NewPageIndex * GrdToPayFollow.PageSize;
        GrdToPayFollow.PageIndex = e.NewPageIndex;
        selectdata(); 
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        str = " ORDER BY " + e.SortExpression;
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "ViewMR")
        {
            //LinkButton l1;
            //string a;
            //l1 = (LinkButton)e.Item.FindControl("lblPaidDocket");
            //a = l1.Text;
            //Response.Redirect("FrmDocketDetail.aspx");
        }
    }

   protected void cmdexcel_Click(object sender, EventArgs e)
    {
        GrdToPayFollow.AllowPaging = false;
        selectdata();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        //frm.Controls.Add(GrdToPayFollow);
        GrdToPayFollow.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void GrdToPayFollow_RowCreated(object sender, GridViewRowEventArgs e)
    { 
    }
    int _counter = 0;
    Boolean P08 = true;
    protected void GrdToPayFollow_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            _counter += 1;
            Label l = (Label)e.Row.FindControl("LblSrNo");
            l.Text = _counter.ToString();
            l.DataBind();
        }
        //if ((mainmode == "locwise") || (mainmode == "custwise"))
        //{
        //    if (((submode == "paybaswise") && ((paybaseitem == "All"))) || ((submode == "modewise") && ((modeitem == "All"))))
        //    {

        //        if (actpaybas.Contains("P08") == false)
        //        {
        //            e.Row.Cells[15].Visible = false;
        //            e.Row.Cells[16].Visible = false;
        //            e.Row.Cells[17].Visible = false;
        //            e.Row.Cells[18].Visible = false;
        //            P08 = false;
        //        }
        //    }
        //}
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if ((mainmode == "locwise") || (mainmode == "custwise"))
            {
                if (submode == "paybaswise")
                {
                    if (paybaseitem == "All")
                    {
                        GridView oGridView = (GridView)sender;
                        GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                        TableCell oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.Text = "Paid";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        oTableCell.CssClass = "blackfnt";
                        //oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.Text = "TBB";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 4;
                        oTableCell.Text = "ToPay";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);

                        if (P08 != false)
                        {
                            oGridViewRow.Cells.Add(oTableCell);
                            oTableCell = new TableCell();
                            oTableCell.ColumnSpan = 4;
                            oTableCell.Text = "BOD";
                            oTableCell.CssClass = "blackfnt";
                            oTableCell.HorizontalAlign = HorizontalAlign.Center;
                            //oTableCell.Font.Bold = true;
                            oGridViewRow.Cells.Add(oTableCell);
                        }

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 4;
                        oTableCell.Text = "National";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 4;
                        oTableCell.Text = "Total";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);
                        oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
                    }
                    else
                    {
                        GridView oGridView = (GridView)sender;
                        GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                        TableCell oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        if (paybaseitem == "P01")
                        {
                            oTableCell.Text = "Paid";
                        }
                        else if (paybaseitem == "P02")
                        {
                            oTableCell.Text = "TBB";
                        }
                        else if (paybaseitem == "P03")
                        {
                            oTableCell.Text = "ToPay";
                        }
                        else if (paybaseitem == "P08")
                        {
                            oTableCell.Text = "BOD";
                        }
                        else if (paybaseitem == "P09")
                        {
                            oTableCell.Text = "National";
                        }
                        else if (paybaseitem == "P04")
                        {
                            oTableCell.Text = "FOC";
                        }
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        oTableCell.CssClass = "blackfnt";
                        // oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        // oTableCell.Font.Bold = true;
                        oTableCell.Text = "Total";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);
                        oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
                    }
                }
                else if (submode == "modewise")
                {
                    if (modeitem == "All")
                    {
                        GridView oGridView = (GridView)sender;
                        GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                        TableCell oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.Text = "Air";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.Text = "Road";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 4;
                        oTableCell.Text = "Rail";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);


                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 4;
                        oTableCell.Text = "Express";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 4;
                        oTableCell.Text = "Total";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oGridViewRow.Cells.Add(oTableCell);
                        oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
                    }
                    else
                    {
                        GridView oGridView = (GridView)sender;
                        GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                        TableCell oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.ColumnSpan = 1;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        if (modeitem == "1")
                        {
                            oTableCell.Text = "Air";
                        }
                        else if (modeitem == "2")
                        {
                            oTableCell.Text = "Road";
                        }
                        else if (modeitem == "3")
                        {
                            oTableCell.Text = "Rail";
                        }
                        else if (modeitem == "4")
                        {
                            oTableCell.Text = "Express";
                        }
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);

                        oGridViewRow.Cells.Add(oTableCell);
                        oTableCell = new TableCell();
                        oTableCell.HorizontalAlign = HorizontalAlign.Center;
                        //oTableCell.Font.Bold = true;
                        oTableCell.Text = "Total";
                        oTableCell.CssClass = "blackfnt";
                        oTableCell.ColumnSpan = 4;
                        oGridViewRow.Cells.Add(oTableCell);
                        oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
                    }
                }

            }

        }
        
    }
}

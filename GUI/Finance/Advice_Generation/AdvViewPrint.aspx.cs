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

public partial class GUI_Finance_ViewPrint_Advice_Register_AdvViewPrint : System.Web.UI.Page
{
    SqlConnection con;
    string printyn = "", Adviceno = "";
    public string border = "";
    protected void Page_PreInit(object sender, EventArgs e)
    {
        Adviceno = Request.QueryString["adviceno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        if (printyn == "Y")
        {
            border = "1";
            this.Theme = "Print";
            formbody.Attributes.Add("onload", "javascript:window.print();");
            border = "1";
        }
        else
        {
            border = "0";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();

        Adviceno = Request.QueryString["adviceno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        string fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        if (Session["Client"].ToString() == "PRRL")
        {
            imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
        }
        if (Session["Client"].ToString() == "TLL")
        {
            imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
        }
        else if (Session["Client"].ToString() == "EXL")
        {
            imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Varuna")
        {
            imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
        }
        else if (Session["Client"].ToString() == "RITCO")
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }
        else if (Session["Client"].ToString() == "RCPL")
        {
            imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Agility")
        {
            imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
        }
        else if (Session["Client"].ToString() == "ASL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
        }
        else
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }

        string sql = "EXEC usp_advice_details '" + Adviceno + "','" + Financial_Year + "'";

        //string sql = "select advicestatus,adviceno,convert(varchar,advicedt,106) as Generated_date,";
        //sql += "isnull(convert(varchar,AdvRecvDt,106),'--') as Accepted_date,";
        //sql += "Advicetype = case when advicetype='D' then 'Debit Advice' end,advice_amount,";
        //sql += "RaisedBy as Generated_brcd,isnull(RaisedOn,'--') as Accepted_brcd,";
        //sql += "Gen_Voucherno = (select top 1 voucherno from  webx_acctrans_" + fin_year + " where docno='" + Adviceno + "' and Narration like '%ADVICE GENERATED%'),";
        //sql += "Acc_Voucherno = (select top 1 voucherno from  webx_acctrans_" + fin_year + " where docno='" + Adviceno + "' and Narration like '%ADVICE ACCEPTED%'),";
        //sql += "isnull(convert(varchar,AdvRecvDt,106),'--') as AdvRecvDt,";
        //sql += "Gen_Acccategory = (select acccategory from webx_acctinfo where acccode=fromacccode),";
        //sql += "Acc_Acccategory = (select isnull(acccategory,'--') from webx_acctinfo where acccode=toacccode),";
        //sql += "Gen_Bank = (select isnull(Company_acccode+' : '+accdesc,'--') from webx_acctinfo where acccode=fromacccode and acccategory like '%Bank%'),";
        //sql += "Acc_Bank = (select isnull(Company_acccode+' : '+accdesc,'--') from webx_acctinfo where acccode=toacccode and acccategory like '%Bank%'),";
        //sql += "Gen_emp = (select isnull(userid +' : '+Name,'--') from webx_master_users where userid=AdvGenByCd),";
        //sql += "isnull((select userid +' : '+Name from webx_master_users where userid=AdvAccByCd),'--') as Acc_emp,reason as Narration";
        //sql += " from webx_advice_hdr where adviceno='" + Adviceno + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lbladviceno.Text = dr["adviceno"].ToString();
            lbladvicedt.Text = dr["Generated_date"].ToString();
            lbladvicetyp.Text = dr["Advicetype"].ToString();
            lbladvicestatus.Text = dr["advicestatus"].ToString();
            lbladviceamt.Text = dr["advice_amount"].ToString();
            lblgenloc.Text = dr["Generated_brcd"].ToString() + " : " + fn.GetLocation(dr["Generated_brcd"].ToString());
            lblaccloc.Text = dr["Accepted_brcd"].ToString() + " : " + fn.GetLocation(dr["Accepted_brcd"].ToString());
            lblgenvoucherno.Text = dr["Gen_Voucherno"].ToString();

            if (dr["advicestatus"].ToString().CompareTo("ACCEPTED") == 0)
            {
                lblaccloc.Text = dr["Accepted_brcd"].ToString();
                lblaccvoucherno.Text = dr["Acc_Voucherno"].ToString();
            }
            else if (dr["advicestatus"].ToString().CompareTo("SUBMITTED") == 0)
            {   
                //lblaccloc.Text = "--";
                lblaccvoucherno.Text = "--";
            }

            lblgendt.Text = dr["Generated_date"].ToString();
            lblaccdt.Text = dr["AdvRecvDt"].ToString();
            lblgenemp.Text = dr["Gen_emp"].ToString();
            lblaccemp.Text = dr["Acc_emp"].ToString();
            lblgenpayment.Text = dr["Gen_Acccategory"].ToString();
            lblaccpayment.Text = dr["Acc_Acccategory"].ToString();
            lblgenbanknm.Text = dr["Gen_Bank"].ToString();
            lblaccbanknm.Text = dr["Acc_Bank"].ToString();
            lblgennarration.Text = dr["Narration"].ToString();
        }

        dr.Close();
    }
}

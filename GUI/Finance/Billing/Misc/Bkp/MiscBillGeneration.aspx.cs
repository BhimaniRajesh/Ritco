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
using WebX.Controllers;

public partial class GUI_Finance_Billing_MiscBillGeneration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //btnparty.Attributes.Add("onclick", "popuplist('partycode','" + txtparty.ClientID.ToString() + "','none')");
        //btnbillcol.Attributes.Add("onclick", "popuplist('location','" + txtbillcolbranch.ClientID.ToString() + "','none')");


        if (!Page.IsPostBack)
        {

            string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            Common objCommon = new Common();
            objCommon.doCacheRoutine();
            this.Title = pagetitle;

            if (Request.QueryString["message"] != "")
            {
                lblmsg.Visible = true;
                lblmsg.Text = Convert.ToString(Request.QueryString["message"]);
            }


            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txttodate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtbilldate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            DateTime dt = DateTime.Today.AddDays(30);
            txtduedate.Text = dt.ToString("dd/MM/yyyy");
            txtbillcolbranch.Text = Session["brcd"].ToString();
            txtsubbranch.Text = Session["brcd"].ToString();
            txtsubbranch.CssClass = "blackfnt";
            txtDateFrom.CssClass = "blackfnt";
            txttodate.CssClass = "blackfnt";
            txtbilldate.CssClass = "blackfnt";
            txtduedate.CssClass = "blackfnt";

            txtparty.CssClass = "blackfnt";
            //Add Service Portion On 31 May 2015 By Bipin Rupavatiya
            DateTime curdt;
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            curdt = Convert.ToDateTime(txtbilldate.Text, enGB);
            HdnServiceTaxRate.Value = Convert.ToString(TaxRateController.GetServiceTaxRate(curdt));
            HdnEduCessRate.Value = Convert.ToString(TaxRateController.GetEduCessRate(curdt));
            HdnHEduCessRate.Value = Convert.ToString(TaxRateController.GetHEduCessRate(curdt));
            HdnSBCRate.Value = Convert.ToString(TaxRateController.GetSwachhBharatCessRate(curdt));
            //

        }

        submit.Attributes.Add("onclick", "javascript:return FSubmit()");
        svctax_yn.Attributes.Add("onclick", "javascript:fcalbillamt()");
    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string Loccode = Session["brcd"].ToString();
        //string brname = Session["brnm"].ToString();
        string Billno = GenBillno(Loccode.ToString());
        string[] strBillDt = txtbilldate.Text.Split('/');
        string[] strDutdt = txtduedate.Text.Split('/');
        string[] strfromdt = txtDateFrom.Text.Split('/');
        string[] strtodt = txttodate.Text.Split('/');
        string bbrnm = Session["brcdName"].ToString();
        string bgenempcd = Session["empcd"].ToString();
        string ptmsbrcd = Session["brcd"].ToString();
        string BILLSTATUS = "Bill Generated";
        string BILLSUBTO = " ";
        string SUBTOTEL = " ";
        string billcolptcd = " ";

        DateTime dtbill = Convert.ToDateTime(strBillDt[1] + "/" + strBillDt[0] + "/" + strBillDt[2]);
        DateTime dtdue = Convert.ToDateTime(strDutdt[1] + "/" + strDutdt[0] + "/" + strDutdt[2]);
        DateTime dtfrom = Convert.ToDateTime(strfromdt[1] + "/" + strfromdt[0] + "/" + strfromdt[2]);
        DateTime dtto = Convert.ToDateTime(strtodt[1] + "/" + strtodt[0] + "/" + strtodt[2]);

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string PTMSNM_SQL = "select custnm,custaddress,cstno,emailids from webx_custhdr WHERE CUSTCD = '" + txtparty.Text + "'";
        SqlCommand ptms_cmd = new SqlCommand(PTMSNM_SQL, conn);
        SqlDataReader dr;
        dr = ptms_cmd.ExecuteReader();

        string PTMSNM = "";
        string PTMSADDR = "";
        string PTMSTEL = "";
        string PTMSEMAIL = "";

        while (dr.Read())
        {
            PTMSNM = dr["custnm"].ToString();
            PTMSADDR = dr["custaddress"].ToString();
            PTMSTEL = dr["cstno"].ToString();
            PTMSEMAIL = dr["emailids"].ToString();
        }
        conn.Close();
        conn.Open();
        string sql = "select svctax_rate,edu_cess_rate,SbcRate=ISNULL(SbcRate,0) from webx_chargemst";
        ptms_cmd = new SqlCommand(sql, conn);
        dr = ptms_cmd.ExecuteReader();
        string svctax_rate = "";
        string edu_cess_rate = "";
        string SbcRate = "";
        while (dr.Read())
        {
            svctax_rate = dr["svctax_rate"].ToString();
            edu_cess_rate = dr["edu_cess_rate"].ToString();
            SbcRate = dr["SbcRate"].ToString();
        }

        conn.Close();

        //string PTMSNM = Convert.ToString(ptms_cmd.ExecuteScalar());

        conn.Open();
        sql = "insert into webx_billmst (BILLNO,BGNDT,BSBDT,BDUEDT,BCLDT,BCBSDT,BBRCD,BBRNM,";
        sql += "PAYBAS,PTMSCD,PTMSNM,PTMSTEL,PTMSEMAIL,PTMSADDR,REMARK,BILLAMT,PENDAMT,BILLSTATUS,BILLSUBTO,";
        sql += "SUBTOTEL,bgenempcd,ptmsbrcd,billsubbrcd,billcolbrcd,billcolptcd,warechrg,vehdetchrg,";
        sql += "dischrg,handchrg,manualbillno,svrcamt,cessamt,rentalcharg,othchrg,bdatefrom,bdateto,";
        sql += "AggrementNo,svctax_rate,cess_rate,hedu_cess,SBCAMT,SBCRATE)";
        sql += " values('" + Billno + "','" + dtbill + "',null,'" + dtdue + "',null,null,'" + Loccode + "','";
        sql += bbrnm + "','7','" + txtparty.Text + "','" + PTMSNM + "','" + PTMSTEL + "','" + PTMSEMAIL + "','";
        sql += PTMSADDR + "',NULL," + totalchrg.Text + "," + totalchrg.Text + ",'" + BILLSTATUS + "','";
        sql += BILLSUBTO + "','" + SUBTOTEL + "','" + bgenempcd + "','" + ptmsbrcd + "','" + txtsubbranch.Text + "','";
        sql += txtbillcolbranch.Text + "','" + billcolptcd + "'," + warechrg.Text + "," + vehdetchrg.Text + "," + dischrg.Text + ",";
        sql += handchrg.Text + ",'" + txtmanualbillno.Text + "','" + sertax.Text + "','" + cess.Text + "','";
        sql += rentalchrg.Text + "','" + otherchrg.Text + "','" + dtfrom + "','" + dtto + "','" + txtagrno.Text + "'," + HdnServiceTaxRate.Value + "," + HdnEduCessRate.Value + "," + HdnHEduCessRate.Value + "," + HdnSBCRate.Value + ",'" + SBC.Text + "')";

        SqlTransaction trans;
        trans = conn.BeginTransaction();
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        try
        {
            SqlCommand cmd = new SqlCommand(sql, conn, trans);
            cmd.ExecuteNonQuery();

            sql = "exec usp_MiscBillTransaction 1,'" + Billno + "','" + Financial_Year + "'";
            cmd = new SqlCommand(sql, conn, trans);
            cmd.ExecuteNonQuery();

            trans.Commit();
            conn.Close();


        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?message=" + msg);
            Response.End();

        }
        Response.Redirect("MIscbill_done.aspx?Billno=" + Billno);
        //Response.Redirect("MiscBillGeneration.aspx?message=Data has been Inserted Successfully.");
    }
    public string GenBillno(string loccode)
    {
        string NewCode = "";
        string finyear = Session["FinYear"].ToString().Substring(2, 2);
        //string finyear = Financial_Year;
        // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_next_Misc_code";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@loccode", SqlDbType.VarChar).Value = loccode.Trim();
        cmd.Parameters.Add("@finyear", SqlDbType.VarChar).Value = finyear.Trim();


        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            NewCode = Convert.ToString(dr["NewCode"]);
        }

        if (NewCode == null) NewCode = "";
        return NewCode;
    }

}

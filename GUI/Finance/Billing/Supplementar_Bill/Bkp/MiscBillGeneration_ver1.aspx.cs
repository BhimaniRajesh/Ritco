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
    DataTable dt1 = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        //btnparty.Attributes.Add("onclick", "popuplist('partycode','" + txtparty.ClientID.ToString() + "','none')");
        //btnbillcol.Attributes.Add("onclick", "popuplist('location','" + txtbillcolbranch.ClientID.ToString() + "','none')");
        lblhqtr.Text = Session["brcd"].ToString() + ":" + fn.GetLocation(Session["brcd"].ToString());
        lbladmin.Text = Session["empcd"].ToString() + ":" + fn.GetEmpName(Session["empcd"].ToString());
        RAD_Docket.Text = Session["DocketCalledAs"].ToString();
        RAD_THC.Text = Session["THCCalledAs"].ToString();
        if (!Page.IsPostBack)
        {

            for (int i = 0; i < 5; i++)
            {
                dt1.Rows.Add();
            }

            grvcontrols.DataSource = dt1;
            grvcontrols.DataBind();

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
            //

        }

        submit.Attributes.Add("onclick", "javascript:return FSubmit()");
        svctax_yn.Attributes.Add("onclick", "javascript:fcalbillamt()");
        btnparty.Attributes.Add("onclick", "popuplist('P','" + txtparty.ClientID.ToString() + "','none')");
        btnsubbranch.Attributes.Add("onclick", "popuplist('LocCode','" + txtsubbranch.ClientID.ToString() + "','none')");
        btnbillcol.Attributes.Add("onclick", "popuplist('LocCode','" + txtbillcolbranch.ClientID.ToString() + "','none')");
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
        //string totalcharge = totalchrg.Text;
        double SUBTOTEL = Convert.ToDouble(totalchrg.Text) - (Convert.ToDouble(sertax.Text) + Convert.ToDouble(cess.Text) + Convert.ToDouble(H_cess.Text));
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
            PTMSNM = dr["custnm"].ToString().Replace("\n", "");
            PTMSADDR = dr["custaddress"].ToString().Replace("\n", "");

            PTMSTEL = dr["cstno"].ToString();
            PTMSEMAIL = dr["emailids"].ToString();
        }
        conn.Close();
        conn.Open();
        string sql = "select svctax_rate,edu_cess_rate from webx_chargemst";
        ptms_cmd = new SqlCommand(sql, conn);
        dr = ptms_cmd.ExecuteReader();
        string svctax_rate = "";
        string edu_cess_rate = "";
        while (dr.Read())
        {
            svctax_rate = dr["svctax_rate"].ToString();
            edu_cess_rate = dr["edu_cess_rate"].ToString();

        }

        conn.Close();

        conn.Open();

        sql = "insert into webx_billmst (BILLNO,BGNDT,BSBDT,BDUEDT,BCLDT,BCBSDT,BBRCD,BBRNM,";
        sql += "PAYBAS,PTMSCD,PTMSNM,PTMSTEL,PTMSEMAIL,PTMSADDR,REMARK,BILLAMT,PENDAMT,BILLSTATUS,BILLSUBTO,";
        sql += "SUBTOTEL,bgenempcd,ptmsbrcd,billsubbrcd,billcolbrcd,billcolptcd,";
        sql += "manualbillno,svrcamt,cessamt,bdatefrom,bdateto,";
        sql += "AggrementNo,svctax_rate,cess_rate,hedu_cess,Narration)";
        sql += " values('" + Billno + "','" + dtbill + "',null,'" + dtdue + "',null,null,'" + Loccode + "','";
        sql += bbrnm + "','7','" + txtparty.Text + "','" + PTMSNM + "','" + PTMSTEL + "','" + PTMSEMAIL + "','";
        sql += PTMSADDR + "',NULL," + totalchrg.Text + "," + totalchrg.Text + ",'" + BILLSTATUS + "','";
        sql += BILLSUBTO + "','" + SUBTOTEL + "','" + bgenempcd + "','" + ptmsbrcd + "','" + txtsubbranch.Text + "','";
        sql += txtbillcolbranch.Text + "','" + billcolptcd + "','";
        sql += txtmanualbillno.Text + "','" + sertax.Text + "','" + cess.Text + "','";
        sql += dtfrom + "','" + dtto + "','" + txtagrno.Text + "'," + HdnServiceTaxRate.Value + "," + HdnEduCessRate.Value + "," + HdnHEduCessRate.Value + ",'" + txtMainNarration.Text + "')";

        string Acccode = "", Accdesc = "", sql_acc = "", txtamt = "", txtNarration = "";

        SqlTransaction trans;
        trans = conn.BeginTransaction();
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        try
        {
            SqlCommand cmd = new SqlCommand(sql, conn, trans);
            cmd.ExecuteNonQuery();

            string dockno = "", doctype = "";
            if (RAD_Docket.Checked)
            {
                if (txtdocThc.Text != "")
                {
                    dockno = txtdocThc.Text;
                    doctype = "DKT";
                    sql_acc = "Update webx_DOCKET_Profitability set Misc_Subtotal=" + SUBTOTEL + ",Misc_Stax=" + sertax.Text + ",Misc_Cess=" + cess.Text + ",Misc_H_Cess=" + H_cess.Text + " where dockno='" + txtdocThc.Text + "'";
                    cmd = new SqlCommand(sql_acc, conn, trans);
                    cmd.ExecuteNonQuery();
                }
            }
            else if (RAD_THC.Checked)
            {
                if (txtdocThc.Text != "")
                {
                    dockno = txtdocThc.Text;
                    doctype = "THC";
                }
            }



            //if (RAD_Docket.Checked)
            //{
            //    dockno = txtdocThc.Text;
            //    doctype = "DKT";

            //}
            //else
            //{
            //    dockno = txtdocThc.Text;
            //    doctype = "THC";
            //}
            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                Acccode = ((TextBox)gridrow.FindControl("txtAccCode")).Text.ToString();
                //TextBox txtAccdesc = ((TextBox)gridrow.FindControl("txtDescription"));
                //txtAccdesc.Enabled = true;
                //Accdesc = txtAccdesc.Text;
                Accdesc = ((TextBox)gridrow.FindControl("txtDescription")).Text.ToString();
                txtamt = ((TextBox)gridrow.FindControl("txtAmt")).Text.ToString();
                txtNarration = ((TextBox)gridrow.FindControl("txtNarration")).Text.ToString();

                if (Acccode != "")
                {

                    sql_acc = "insert into webx_billdet(Billno,totamt,Acccode,Accdesc,Narration,dockno,doctype) values(";
                    sql_acc += "'" + Billno + "','" + txtamt + "','" + Acccode + "','" + Accdesc + "','" + txtNarration + "','" + dockno + "','" + doctype + "')";

                    cmd = new SqlCommand(sql_acc, conn, trans);
                    cmd.ExecuteNonQuery();
                }
            }
            //if (Session["Client"] == "RCPL")
            //{
            //    sql = "update webx_billmst set Commission_Charges=" + Commission_chrg.Text + " where billno='" + Billno + "'";
            //    cmd = new SqlCommand(sql, conn, trans);
            //    cmd.ExecuteNonQuery();

            //}
            sql = "exec usp_SupplyBillTransaction 1,'" + Billno + "','" + Financial_Year + "'";
            cmd = new SqlCommand(sql, conn, trans);
            cmd.ExecuteNonQuery();
            sql = "exec usp_SupplyBillTransaction 2,'" + Billno + "','" + Financial_Year + "'";
            cmd = new SqlCommand(sql, conn, trans);
            cmd.ExecuteNonQuery();
            //trans.Rollback();
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
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        else
        {
            maxrows = 5;
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt1.Rows.Add();
        }

        grvcontrols.DataSource = dt1;
        grvcontrols.DataBind();
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtAccCode")).Attributes.Add("onblur", "AccBlur('" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "')");
            ((Button)e.Row.FindControl("btnAccCode")).Attributes.Add("onclick", "popuplist('AccCode','" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "','none')");
            //((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot('" + ((TextBox)e.Row.FindControl("txtAmt")).ClientID.ToString() + "','" + ((TextBox)e.Row.FindControl("txtTotAmt")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot()");
        }
    }
}

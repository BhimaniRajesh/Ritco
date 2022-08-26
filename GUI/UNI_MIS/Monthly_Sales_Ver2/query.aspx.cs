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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
public partial class GUI_UNI_MIS_Monthly_Sales_query: System.Web.UI.Page
{
    SqlConnection conn;
    public static  int loclevel, payint = 0, trnint = 0;
    public static string brcd, empcd,selyear,selmonth;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();

        string curryear = System.DateTime.Today.ToString("yy");
        if (!IsPostBack)
        {
            for (int i = 2005; i <= Convert.ToInt16(System.DateTime.Today.ToString("yyyy")); i++)
            {
                
                    ddYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
              
            }
            ddYear.SelectedValue = System.DateTime.Today.ToString("yyyy");
            selyear = ddYear.SelectedValue.ToString();
            selmonth = System.DateTime.Today.ToString("MM");
            //Response.Write("Month : " + selmonth);
            lblmonthname.Visible = true;
            rdMonth.Items[6].Text = "Year ";//- " + System.DateTime.Today.ToString("yy");
            lblmonthname.Text = "You Selected :- " + System.DateTime.Today.ToString("MMM yy");

            string SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'N','N'";

            
            SqlCommand cmd_upd = new SqlCommand(SQL_updateview, conn);
            cmd_upd.ExecuteNonQuery();
            string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            // Response.Write("<br>sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            //string loclevel = dread.GetValue(0).ToString();
            dread.Read();
            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
            //loclevel = 2;
            //Response.Write("<br>loclevel : " + loclevel);
            dread.Close();
            
            cboRO_Lo.Items.Clear();
            //cboRO_Lo_TO.Items.Clear();
            cboRO.Items.Clear();
            //cboRO_TO.Items.Clear();
            if (loclevel < 3)
            {
                //sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                //cboRO_Lo.Items.Add(new ListItem("All", "All"));
                ////cboRO_Lo_TO.Items.Add(new ListItem("All", "All"));


                sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";

                if (loclevel == 2)
                {
                    sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where loccode='" + brcd + "' order by locname";
                }
                else
                {
                    cboRO_Lo.Items.Add(new ListItem("All", "All"));

                }
            }
            else
            {
                sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
                // ROWLO.Visible = false;
                ROWLO.Style["display"] = "none";
            }
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    

                    if (loclevel < 3)
                    {
                        cboRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));

                    }
                    else
                    {
                        cboRO_Lo.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                    }
                }

            }
            cboRO.SelectedValue = "All";
            //cboRO_TO.SelectedValue = "All";
            dread.Close();

            if (loclevel == 2)
            {

                string sqlstr14 = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where  report_loc='" + brcd + "'";

                SqlCommand cmd1 = new SqlCommand(sqlstr14, conn);
                SqlDataReader dread14 = cmd1.ExecuteReader();
                {

                    while (dread14.Read())
                    {

                        cboRO_Lo.Items.Add(new ListItem(dread14.GetValue(1).ToString(), dread14.GetValue(0).ToString()));
                        cboRO_Lo.SelectedValue = "All";
                    }

                }
                dread14.Close();
            }
            //cmd = new SqlCommand(sqlstr, conn);
            //dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {

            //        cboRO_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //        cboRO_TO.SelectedValue = "All";
            //    }

            //}
            //dread.Close();

            //sqlstr = "   select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            //if (loclevel == 1)
            //{
            //    sqlstr = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            //}
            //else
            //{
            //    sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
            //    String sqlstr12 = "select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL not in ('1','2') ";

            //    cmd = new SqlCommand(sqlstr12, conn);
            //    SqlDataReader dread12 = cmd.ExecuteReader();
            //    {

            //        while (dread12.Read())
            //        {

            //            cboRO_Lo_TO.Items.Add(new ListItem(dread12.GetValue(1).ToString(), dread12.GetValue(0).ToString()));
            //            cboRO_Lo_TO.SelectedValue = "All";
            //        }

            //    }
            //    dread12.Close();
            //}
            sqlstr = "select 'All' as codedesc,'All' codedesc from webx_master_general union select codedesc,codedesc from webx_master_general where  codetype='BUT' and  statuscode='Y'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLBusTyp.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();
            DDLBusTyp.SelectedValue = "All";


            string sql_paybas = " select codeid,codedesc from  webx_master_general  where codetype='paytyp' and statuscode='Y' and codeid in ('p01','p02','p03','p04') union select 'All' as codeid,'Total'  as codedesc from webx_master_general union select 'CAN' as codeid,'Cancelled'  as codedesc from webx_master_general  ";
            SqlCommand cmspaybas=new SqlCommand( sql_paybas, conn);
            SqlDataReader drpaybas=cmspaybas.ExecuteReader();

            int ik = 0,ip=0;
            ip = 1;
            while (drpaybas.Read())
            {
                string a;
                ChkPaybas.Items.Add(Convert.ToString(drpaybas["codedesc"]));
                ChkPaybas.Items[ik].Value = Convert.ToString(drpaybas["codeid"]);
                if (ChkPaybas.Items[ik].Value == "All")
                {
                    ChkPaybas.Items[ik].Selected = true;
                }
                ik += 1;
                ip = ip + 1;
            }
            payint = ip;
            drpaybas.Close();
            string sql_Trn = " select 'All' as codeid,'Total'  as codedesc from webx_master_general union select codeid,codedesc from  webx_master_general  where codetype='trn' and statuscode='Y' union select 'CAN' as codeid,'Cancelled'  as codedesc from webx_master_general ";
            SqlCommand cmsTrn = new SqlCommand(sql_Trn, conn);
            SqlDataReader drTrn = cmsTrn.ExecuteReader();

            int ij = 0,it=0;
            it = 1;
            while (drTrn.Read())
            {

                string a;
                CheckBoxListTrn.Items.Add(Convert.ToString(drTrn["codedesc"]));
                CheckBoxListTrn.Items[ij].Value = Convert.ToString(drTrn["codeid"]);
                //CheckBoxListTrn.Items[0].Selected = true;
                // var chklist=;   chklist[i].checked=true;
                if (CheckBoxListTrn.Items[ij].Value == "All")
                {
                    CheckBoxListTrn.Items[ij].Selected = true;
                }
                ij += 1;
                it = it + 1;
            }
            trnint = it;
            drTrn.Close();
        }
        lblmonthname.Style["display"] = "none";
        conn.Close();
    }
    protected void ChkAmtChrgAll_Checked(object sender, EventArgs e)
    {
        bool Flag = ChkAmtChrgAll.Checked;
        for (int i = 0; i < ChkPaybas.Items.Count; i++)
        {
            ChkPaybas.Items[i].Selected = Flag;
        }
    }

    protected void Chkoutput_Checked(object sender, EventArgs e)
    {
        bool Flag = Chkoutput.Checked;
        for (int i = 0; i < CheckBoxListPouput.Items.Count; i++)
        {
            CheckBoxListPouput.Items[i].Selected = Flag;
        }
    }

    protected void Chktrnmod_Checked(object sender, EventArgs e)
    {
        bool Flag = Chktrnmod.Checked;
        for (int i = 0; i < CheckBoxListTrn.Items.Count; i++)
        {
            CheckBoxListTrn.Items[i].Selected = Flag;
        }
    }

    protected void rdMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblmonthname.Visible = true;
        lblmonthname.Text = "";
        selyear = ddYear.SelectedValue.ToString();
        rdMonth.Items[6].Text = "Year - " + selyear.Substring(2, selyear.Length - 2).ToString();
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)rdMonth;
         if ((rbl.Items[0].Selected))
         {
             lblmonthname.Text ="You Selected :- "+ System.DateTime.Today.ToString("MMM yy");
         }
         if ((rbl.Items[1].Selected))
         {
             lblmonthname.Text = "You Selected :- " + System.DateTime.Today.AddMonths(-1).ToString("MMM yy");
         }
         if ((rbl.Items[2].Selected))
         {
             string ftqt = "01/01/" + selyear;
             lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " +Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
         }
         if ((rbl.Items[3].Selected))
         {
             string ftqt = "04/04/" + selyear;
             lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
         }
         if ((rbl.Items[4].Selected))
         {
             string ftqt = "07/07/" + selyear;
             lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
         }
         if ((rbl.Items[5].Selected))
         {
             string ftqt = "10/10/" + selyear;
             lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
         }

         if ((rbl.Items[6].Selected))
         {
             string ftqt = "01/01/" + selyear;
             lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(11).ToString("MMM yy");
         }

         lblmonthname.CssClass = "blackfnt";
         lblmonthname.Style["display"] = "none";
    }
    protected void ddYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        selyear = ddYear.SelectedValue.ToString();

        rdMonth.Items[6].Text = "Year - " + selyear.Substring(2, selyear.Length-2).ToString();
        //RadioButtonList rbl = new RadioButtonList();
        //rbl = (RadioButtonList)rdMonth;
        if (selyear != System.DateTime.Today.ToString("yy"))
        {
            rdMonth.Items[0].Enabled = false;
            rdMonth.Items[1].Enabled = false;
        }
        else
        {
            rdMonth.Items[0].Enabled = true;
            rdMonth.Items[1].Enabled = true;
        }
        //rbl=rdMonth.Items
        if ((rdMonth.Items[0].Selected))
        {
            lblmonthname.Text = "You Selected :- " + System.DateTime.Today.ToString("MMM yy");
        }
        if ((rdMonth.Items[1].Selected))
        {
            lblmonthname.Text = "You Selected :- " + System.DateTime.Today.AddMonths(-1).ToString("MMM yy");
        }
        if ((rdMonth.Items[2].Selected))
        {
            string ftqt = "01/01/" + selyear;
            lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
        }
        if ((rdMonth.Items[3].Selected))
        {
            string ftqt = "04/04/" + selyear;
            lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
        }
        if ((rdMonth.Items[4].Selected))
        {
            string ftqt = "07/07/" + selyear;
            lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
        }
        if ((rdMonth.Items[5].Selected))
        {
            string ftqt = "10/10/" + selyear;
            lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(2).ToString("MMM yy");
        }
        if ((rdMonth.Items[6].Selected))
        {
            string ftqt = "01/01/" + selyear;
            lblmonthname.Text = "You Selected :- " + Convert.ToDateTime(ftqt).ToString("MMM yy") + " - " + Convert.ToDateTime(ftqt).AddMonths(11).ToString("MMM yy");
        }

        

        lblmonthname.CssClass = "blackfnt";
    }

    protected void cboRO_SelectedIndexChanged(object sender, EventArgs e)
    {

        //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetNoStore();
        //Response.Cache.SetExpires(DateTime.MinValue);



        //Scargoconnection conn = new Scargoconnection();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        String sqlstr = "";

        if (loclevel <= 2)
        {
            sqlstr = "select 'All' as loccode,'All'  as locname  union select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO.SelectedValue.ToString() + "' or loccode='" + cboRO.SelectedValue.ToString() + "'";
        }
        else
        {
            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
        }

        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboRO_Lo.Items.Clear();
        {

            while (dread.Read())
            {
                cboRO_Lo.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                //cboRO_Lo.SelectedValue = "All";      
            }

        }
        dread.Close();
        conn.Close();
    }

    //protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    //{

    //    //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
    //    //Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    //Response.Cache.SetNoStore();
    //    //Response.Cache.SetExpires(DateTime.MinValue);
    //    //Scargoconnection conn = new Scargoconnection();
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    String sqlstr = "";

    //    if (loclevel <= 2)
    //    {
    //        sqlstr = "select 'All' as loccode,'All'  as locname  union select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "' or loccode='" + cboRO.SelectedValue.ToString() + "' ";
    //    }
    //    else
    //    {
    //        sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
    //    }

    //    //String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "'";
    //    SqlCommand cmd = new SqlCommand(sqlstr, conn);
    //    SqlDataReader dread = cmd.ExecuteReader();
    //    cboRO_Lo_TO.Items.Clear();
    //    {

    //        while (dread.Read())
    //        {
    //            cboRO_Lo_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //            //cboRO_Lo_TO.SelectedValue = "All";     
    //        }

    //    }
    //    dread.Close();
    //    conn.Close();
    //}
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "",TYP_YEAR="",cust8888="", report_Subtype = "",report_type_st="", report_type = "",st_columnlist="", St_year = "", st_paybaslist = "", st_trnmodlist = "", st_ro = "", st_lo = "";

        St_year = ddYear.SelectedValue.ToString();

        

        for (int i = 0; i < 2; i++)
        {
            if (RTY_TY_YR.Items[i].Selected)
            {
                TYP_YEAR = RTY_TY_YR.Items[i].Value.ToString();
            }
        }

        for (int i = 0; i < 12; i++)
        {
            if (rdMonth.Items[i].Selected)
            {
                report_mode = rdMonth.Items[i].Value.ToString();
            }
        }

        for (int ik = 0; ik < 2; ik++)
        {
            if (rptSubtyp.Items[ik].Selected)
            {
                report_Subtype = rptSubtyp.Items[ik].Value.ToString();
            }
        }

        if (ChkCust8888.Checked == true)
            cust8888 = "Y";
        else
            cust8888 = "N";

            for (int ij = 0; ij < 8; ij++)
            {

                if (rpttyp.Items[ij].Selected)
                {
                    report_type = rpttyp.Items[ij].Value.ToString();
                }

                
            }

            if (rpttyp.Items[4].Selected)
            {
                report_type_st = "Date";
            }
            if (rpttyp.Items[5].Selected)
            {
                report_type_st = "Week";
            }
            if (rpttyp.Items[6].Selected)
            {
                report_type_st = "Date";
            }

        foreach (ListItem li1 in ChkPaybas.Items)
        {
            if (li1.Selected == true)
            {
                st_paybaslist = st_paybaslist + "," + li1.Value.ToString();
            }
        }

        foreach (ListItem li2 in CheckBoxListTrn.Items)
        {
            if (li2.Selected == true)
            {
                st_trnmodlist = st_trnmodlist  +"," + li2.Value.ToString();
            }
        }
        
        foreach (ListItem li3 in CheckBoxListPouput.Items)
        {
            if (li3.Selected == true)
            {
                st_columnlist = li3.Value.ToString() + "," + st_columnlist;
            }
        }

        

        st_ro = cboRO.SelectedValue.ToString();
        if (cboRO.SelectedValue.ToString() == "")
        {
            st_ro = "All";
        }

        st_lo = cboRO_Lo.SelectedValue.ToString();
        if (cboRO_Lo.SelectedValue.ToString() == "")
        {
            st_lo = "All";
        }
        string fromdt = "", todt = "";
        fromdt = txtDateFrom.Text.ToString();
        todt = txtDateTo.Text.ToString();

        st_trnmodlist = st_trnmodlist.Substring(1, st_trnmodlist.Length - 1);
        st_paybaslist = st_paybaslist.Substring(1, st_paybaslist.Length - 1);
        st_columnlist = st_columnlist.Substring(1, st_columnlist.Length - 1);
        string BUSTYP = DDLBusTyp.SelectedValue.ToString();


        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&Rmode=" + report_mode;
        final += "&Subtyp=" + report_Subtype;
        final += "&Rtyp=" + report_type;
        final += "&PaybasList=" + st_paybaslist;
        final += "&Trnlist=" + st_trnmodlist;
        final += "&ColumnList=" + st_columnlist;
        final += "&Ryear=" + St_year;
        final += "&report_type_st=" + report_type_st;
        final += "&cust8888=" + cust8888;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&TYP_YEAR=" + TYP_YEAR;
        final += "&BUSTYP=" + BUSTYP;
        
        Response.Redirect("Result.aspx" + final);

    }
    protected void RadioButtonList1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        string SQL_updateview = "";

        //conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
         
       
        conn.Open();
        if (RadioButtonList1.Items[0].Selected)
        {
            SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'N','N'";
            if (chkStax1.Checked == true)
            {
                SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'N','Y'";
            }
        }
        else
        {
            SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'Y','N'";
            if (chkStax1.Checked == true)
            {
                SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'Y','Y'";
            }
        }

        SqlCommand cmd_upd = new SqlCommand(SQL_updateview, conn);
        cmd_upd.ExecuteNonQuery();

        conn.Close();
    }
    protected void chkStax_Onchanged(object sender, EventArgs e)
    {
        conn.Open();
        string SQL_updateview = "";
      
        if (RadioButtonList1.Items[0].Selected)
        {
            SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'N','N'";
            if (chkStax1.Checked == true)
            {
                SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'N','Y'";
            }
        }
        else
        {
            SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'Y','N'";
            if (chkStax1.Checked == true)
            {
                SQL_updateview = "exec webx_update_View_VW_Monthly_sales 'Y','Y'";
            }
        }


        SqlCommand cmd_upd = new SqlCommand(SQL_updateview, conn);
        cmd_upd.ExecuteNonQuery();

        conn.Close();
    }
    
    protected void RTY_TY_YR_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RTY_TY_YR.Items[1].Selected)
        {
            ddYear.Items.Clear();
            for (int i = 2005; i <= Convert.ToInt16(System.DateTime.Today.ToString("yyyy")); i++)
            {
                string STYR1=Convert.ToString(Convert.ToInt32(i.ToString().Substring(2, 2)) + 1);
                string STYR = "";
                 STYR = i.ToString().Substring(2, 2) + "-" + STYR1;
                if (STYR1.Length == 1)
                {
                     STYR = i.ToString().Substring(2, 2) + "-0" + STYR1;
                }
                ddYear.Items.Add(new ListItem(STYR, STYR));
                //ddYear.Items.Add(new ListItem("220", "220"));
                ddYear.Enabled = true;
            }
            string ST_STYR1 = Convert.ToString(Convert.ToInt32(System.DateTime.Today.ToString("yyyy").ToString().Substring(2, 2)) + 1);
            string ST_STYR = "";
            ST_STYR = System.DateTime.Today.ToString("yyyy").ToString().Substring(2, 2) + "-" + ST_STYR1;
            if (ST_STYR1.Length == 1)
            {
                ST_STYR = System.DateTime.Today.ToString("yyyy").ToString().Substring(2, 2) + "-0" + ST_STYR1;
            }
            //ST_STYR=System.DateTime.Today.ToString("yyyy").ToString().Substring(2, 2);
            ddYear.SelectedValue = ST_STYR;// System.DateTime.Today.ToString("yyyy").ToString().Substring(2, 2) + "-" + ST_STYR;
           // selyear = ddYear.SelectedValue.ToString();
        }
        else
        {
            ddYear.Items.Clear();
            for (int i = 2005; i <= Convert.ToInt16(System.DateTime.Today.ToString("yyyy")); i++)
            {

                ddYear.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            ddYear.SelectedValue = System.DateTime.Today.ToString("yyyy");
            //selyear = ddYear.SelectedValue.ToString();
        }
    }
}

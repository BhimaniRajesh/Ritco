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

public partial class GUI_UNI_MIS_Booking_register_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear,dkt_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (!IsPostBack)
        {
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
            if (loclevel == 1)
            {
                sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                cboRO_Lo.Items.Add(new ListItem("All", "All"));
                //cboRO_Lo_TO.Items.Add(new ListItem("All", "All"));
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
                    if (loclevel == 1)
                    {
                        cboRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                        //cboRO_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
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
            
            RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)rpttyp;
         if ((rbl.Items[0].Selected))
         {
             rbl.Items[0].Text = dkt_Call + " Register";

         }
         if ((rbl.Items[1].Selected))
         {
             rbl.Items[1].Text = "Bill Register";

         }
         if ((rbl.Items[2].Selected))
         {
             rbl.Items[2].Text = "Lorry Hire Register";

         }
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

        conn.Close();
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
        string report_mode = "", report_Subtype = "", report_type = "", st_columnlist = "", St_custcd = "", st_vendcd = "", st_orderlist = "", st_ro = "", st_lo = "";
        string fromdt = "", todt = "";


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

        fromdt = txtDateFrom.Text.ToString();
        todt = txtDateTo.Text.ToString();

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)rpttyp;
        if ((rbl.Items[0].Selected))
        {
            report_type = rbl.Items[0].Value;
        }
        if ((rbl.Items[1].Selected))
        {
            report_type = rbl.Items[1].Value;
        }
        if ((rbl.Items[2].Selected))
        {
            report_type = rbl.Items[2].Value;

        }

        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";

        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";

        }

        St_custcd = txtcustcd.Text.ToString();
        st_vendcd = txtvendcd.Text.ToString();
        st_orderlist = DLLOrder.SelectedValue.ToString();

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&Rtyp=" + report_type;
        final += "&St_custcd=" + St_custcd;
        final += "&st_vendcd=" + st_vendcd;
        final += "&st_orderlist=" + st_orderlist;
        Response.Redirect("Result.aspx" + final);

    }
}

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


public partial class Tracking : System.Web.UI.Page
{
    int loclevel;
    string brcd = "";
    public static string strcust, dkt_call, thc_call;
    protected void Page_Load(object sender, EventArgs e)
    {

        dkt_call = Session["DocketCalledAs"].ToString();
        thc_call = Session["thcCalledAs"].ToString();
        

       // Session["brcd"] = "PRHO";
       // Session["empcd"] = "p1438";
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        //int loclevel;
        //string brcd = "";
        if (!IsPostBack)
        {
            //  Response.Write("< BR> abcd : " + Session["SqlProvider"]);

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            conn.Open();
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            string strrightnow1 = righnow.ToString("dd/MM/yyyy");

            righnow = righnow.AddMonths(-1);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            //  strrightnow = "01/06/2007";
            // strrightnow1 = "01/06/2007";
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow1;

            documet_type.Items.Add(new ListItem(dkt_call, "D"));
            documet_type.SelectedValue = "D";
            documet_type.Items.Add(new ListItem(thc_call, "T"));

            brcd = Session["brcd"].ToString();
            //Response.Write("<br>brcd : " + brcd);
            String sqlstr;
            String sqlstrloc = "select loc_level from webx_location where loccode='" + brcd + "'";
            // Response.Write("<br>sqlstr : " + sqlstr);
            SqlCommand cmd12 = new SqlCommand(sqlstrloc, conn);
            SqlDataReader dread12 = cmd12.ExecuteReader();
            //string loclevel = dread.GetValue(0).ToString();
            dread12.Read();
            loclevel = Convert.ToInt32(dread12.GetValue(0).ToString());
            //loclevel = 2;
            //Response.Write("<br>loclevel : " + loclevel);
            dread12.Close();

            if (loclevel < 3)
            {
               
                sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";

                if (loclevel == 2)
                {
                    sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where loccode='" + brcd + "' order by locname";
                }
                else
                {
                    cboRO_Lo.Items.Add(new ListItem("All", "All"));
                    
                }
                cboRO_Lo_TO.Items.Add(new ListItem("All", "All"));
            }
            else
            {
                sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
               
               // ROWLO.Visible = false;
                ROWLO.Style["display"] = "none";
            }
           // Response.Write("<br>sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
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
            dread.Close();

            sqlstr = "";

            //sqlstr = "   select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            if (loclevel < 3)
            {
                sqlstr = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            }
            else
            {
                sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
                String sqlstr12 = "select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL not in ('1','2') ";

                SqlCommand cmd1 = new SqlCommand(sqlstr12, conn);
                SqlDataReader dread1 = cmd1.ExecuteReader();
                {

                    while (dread1.Read())
                    {

                        cboRO_Lo_TO.Items.Add(new ListItem(dread1.GetValue(1).ToString(), dread1.GetValue(0).ToString()));
                        cboRO_Lo_TO.SelectedValue = "All";
                    }

                }
                dread1.Close();
            }
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {

                    cboRO_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                    cboRO_TO.SelectedValue = "All";
                }

            }
            dread.Close();

            if (loclevel < 3)
            {
                String sqlstr123 = "select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL not in ('1','2') and report_loc='" + brcd + "' ";

                SqlCommand cmd13 = new SqlCommand(sqlstr123, conn);
                SqlDataReader dread13 = cmd13.ExecuteReader();
                {

                    while (dread13.Read())
                    {

                        cboRO_Lo.Items.Add(new ListItem(dread13.GetValue(1).ToString(), dread13.GetValue(0).ToString()));
                        cboRO_Lo.SelectedValue = "All";
                    }

                }
                dread13.Close();
            }
          

            conn.Close();
        }

        btnShow.Attributes.Add("onClick", "javascript:return btnShowVal()");

       
    }

    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");
        string strrightnow1 = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (rbl.Items[2].Selected)
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow1;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[0].Selected)
        {
            righnow = righnow.AddMonths(-1);
            strrightnow = righnow.ToString("dd/MM/yyyy");
          //  strrightnow = "01/06/2007";
           // strrightnow1 = "01/06/2007";
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow1;
        }
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

        brcd = Session["brcd"].ToString();
        //Response.Write("<br>brcd : " + brcd);
       // String sqlstr;
        String sqlstrloc = "select loc_level from webx_location where loccode='" + brcd + "'";
        // Response.Write("<br>sqlstr : " + sqlstr);
        SqlCommand cmd12 = new SqlCommand(sqlstrloc, conn);
        SqlDataReader dread12 = cmd12.ExecuteReader();
        //string loclevel = dread.GetValue(0).ToString();
        dread12.Read();
        loclevel = Convert.ToInt32(dread12.GetValue(0).ToString());
        //loclevel = 2;
        //Response.Write("<br>loclevel : " + loclevel);
        dread12.Close();


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

    protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    {

        //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetNoStore();
        //Response.Cache.SetExpires(DateTime.MinValue);
        //Scargoconnection conn = new Scargoconnection();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        brcd = Session["brcd"].ToString();
        //Response.Write("<br>brcd : " + brcd);
        //String sqlstr;
        String sqlstrloc = "select loc_level from webx_location where loccode='" + brcd + "'";
        // Response.Write("<br>sqlstr : " + sqlstr);
        SqlCommand cmd12 = new SqlCommand(sqlstrloc, conn);
        SqlDataReader dread12 = cmd12.ExecuteReader();
        //string loclevel = dread.GetValue(0).ToString();
        dread12.Read();
        loclevel = Convert.ToInt32(dread12.GetValue(0).ToString());
        //loclevel = 2;
        //Response.Write("<br>loclevel : " + loclevel);
        dread12.Close();

        String sqlstr = "";

        if (loclevel <= 2)
        {
            sqlstr = "select 'All' as loccode,'All'  as locname  union select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "' or loccode='" + cboRO.SelectedValue.ToString() + "' ";
        }
        else
        {
            sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
        }

        //String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboRO_Lo_TO.Items.Clear();
        {

            while (dread.Read())
            {
                cboRO_Lo_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                //cboRO_Lo_TO.SelectedValue = "All";     
            }

        }
        dread.Close();
        conn.Close();
    }

    //public void BindGrid()
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string sql = "webx_UNI_CUST_TRacking";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    sqlcmd.CommandType = CommandType.StoredProcedure;

    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

    //    System.DateTime righnow = System.DateTime.Today;
    //    string strrightnow = righnow.ToString("dd/MM/yyyy");
    //    string strrightnow1 = righnow.ToString("dd/MM/yyyy");

    //    DateTime dtFrom = new DateTime();
    //    DateTime dtTo = new DateTime();

    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //   // dtfi.ShortDatePattern="
    //    dtfi.DateSeparator = "/";

    //    MyFunctions fn = new MyFunctions();


    //    //string fromdt = Request.QueryString.Get("txtDateFrom");
    //   // string Todt = Request.QueryString.Get("txtDateTo");

    //    string  fromdt = fn.Datadate(txtDateFrom.Text.ToString());
    //    string Todt = fn.Datadate(txtDateTo.Text.ToString());
    //   // Todt = fn.Datadate(Todt);

    //    {
    //        dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
    //        dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
            
    //    }

    //    string custcode1 = "";

    //    if (custcode.Text.ToString() == "")
    //    {
    //         custcode1="All";

    //    }

    //    da.SelectCommand.Parameters.Add("@fromdt", SqlDbType.DateTime).Value = fromdt.Trim();
    //    da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = Todt.Trim();
    //    da.SelectCommand.Parameters.Add("@fromRo", SqlDbType.VarChar).Value = cboRO.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@fromloc", SqlDbType.VarChar).Value = cboRO_Lo.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@toRo", SqlDbType.VarChar).Value = cboRO_TO.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@toloc", SqlDbType.VarChar).Value = cboRO_Lo_TO.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@custcode", SqlDbType.VarChar).Value = custcode1 ;
    //    da.SelectCommand.Parameters.Add("@docklist", SqlDbType.VarChar).Value = docketlist.Text;
    //    da.SelectCommand.Parameters.Add("@manuallist", SqlDbType.VarChar).Value = manuallist.Text;
    //    da.SelectCommand.Parameters.Add("@documenttype", SqlDbType.VarChar).Value = documet_type.SelectedItem.Value; 

    //    DataSet ds = new DataSet();

    //    da.Fill(ds);

    //    if (documet_type.SelectedItem.Value == "D")
    //    {
    //        dgDocket.DataSource = ds;
    //        dgDocket.DataBind();
             
    //                  dgMenifest.Visible = false;

    //        //     dgSales.DataSource = ds;
    //        //dgSales.DataBind();
    //    }
    //    if (documet_type.SelectedItem.Value == "M")
    //    {


    //        dgMenifest.DataSource = ds;
    //        dgMenifest.DataBind();
    //        dgDocket.Visible = false;
    //        //     dgSales.DataSource = ds;
    //        //dgSales.DataBind();
    //    }


    //    conn.Close();
    //}


    //protected void pgChange(object sender, GridViewPageEventArgs e)
    //{
    //        if (documet_type.SelectedItem.Value == "D")
    //        {
    //            dgDocket.PageIndex = e.NewPageIndex;
    //         }
    //         if (documet_type.SelectedItem.Value == "M")
    //         {
    //             dgMenifest.PageIndex = e.NewPageIndex;
    //         }
    //    BindGrid();

    //}

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    string party_detail = Party_code.Text.ToString();
    //    string[] party_arr;
    //    party_arr = party_detail.Split('-');
    //    string custcd = party_arr[0].ToString();
    //    // Response.Write("Cbotrnmod - " + Cbotrnmod.SelectedItem.Text.ToString());
    //    // Response.End();
    //    Response.Redirect("genbillsdone.aspx?party_code=" + custcd.ToString() + "&paybas=" + Cbopaybas.SelectedValue.ToString() + "&trnmod=" + Cbotrnmod.SelectedItem.Value.Trim() + "&fromtdate=" + txtDateFrom.Text.ToString() + "&todate=" + txtDateTo.Text.ToString());
    //}
    protected void btnShow_Click(object sender, EventArgs e)
    {
       // BindGrid();

        string final;

        string RO = cboRO.SelectedValue.ToString();
        string LO = cboRO_Lo.SelectedValue.ToString();
        string RO_TO = cboRO_TO.SelectedValue.ToString();
        string LO_TO = cboRO_Lo_TO.SelectedValue.ToString();
        string Doc_type = documet_type.SelectedValue.ToString();
        string dtFrom = txtDateFrom.Text.ToString();
        string dtTo = txtDateTo.Text.ToString();
        //string Paybas = DDLPaybas.SelectedItem.Value.ToString();
        //string trnmod = DDLMode.SelectedItem.Value.ToString();
        //string SDDLType = DDLType.SelectedItem.Value.ToString();
        //string StatusType = DDStatus.SelectedItem.Value.ToString();
        string docket_list = docketlist.Text.ToString();
         string manual_list = manuallist.Text.ToString();
         string custcd = "All"  ;// custcode.Text.ToString();
        //string final = "?billno_nos=" + billnonos;
        //final += "&checkeddockno=" + 
        final = "?RO=" + RO;
         final += "&LO=" + LO;
         final += "&RO_TO=" + RO_TO;
         final += "&LO_TO=" + LO_TO;
        final += "&dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;
        //final += "&select_list=" + select_list;
        //final += "&View_Sales=" + View_Sales;
        //final += "&Paybas=" + Paybas;
        //final += "&trnmod=" + trnmod;
        //final += "&SDDLType=" + SDDLType;
        final += "&Doc_type=" + Doc_type;
        final += "&docket_list=" + docket_list;
         final += "&manual_list=" + manual_list;
         final += "&custcd=" + custcd;
        Response.Redirect("Tracking_Result.aspx" + final);
    }
    
}

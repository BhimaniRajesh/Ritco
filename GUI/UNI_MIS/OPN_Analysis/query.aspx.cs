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

public partial class GUI_UNI_MIS_OPN_Analysis_query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;
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


            string sqlstr1 = "select codedesc,codeid from webx_master_general where codetype='TRN'";
            SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
            SqlDataReader dread1 = cmd1.ExecuteReader();
            {
               
                while (dread1.Read())
                {
                    //DDLMode.Items.Add(new ListItem(dread1.GetValue(0).ToString(), dread1.GetValue(1).ToString()));
                    DLLMode.Items.Add(new ListItem(dread1.GetValue(0).ToString(), dread1.GetValue(1).ToString()));
                }


            }
            dread1.Close();

            DLLMode.Items.Add(new ListItem("All", "All"));
            DLLMode.SelectedValue = "All";


            string sqlstr2 = "select codedesc,codeid from webx_master_general where codetype='PAYTYP'";
            SqlCommand cmd2 = new SqlCommand(sqlstr2, conn);
            SqlDataReader dread2 = cmd2.ExecuteReader();
            {

                while (dread2.Read())
                {
                    //DDLMode.Items.Add(new ListItem(dread1.GetValue(0).ToString(), dread1.GetValue(1).ToString()));
                    DLLpaybas.Items.Add(new ListItem(dread2.GetValue(0).ToString(), dread2.GetValue(1).ToString()));
                }


            }
            dread2.Close();

            DLLpaybas.Items.Add(new ListItem("All", "All"));
            DLLpaybas.SelectedValue = "All"; 
        }
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

   
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", report_Subtype = "", report_type = "", st_columnlist = "", St_paylist = "", st_trnlist= "", st_delist = "", st_ro = "", st_lo = "";
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

        St_paylist = DLLpaybas.SelectedValue.ToString();
        st_trnlist = DLLMode.SelectedValue.ToString();
        st_delist = DLLDly.SelectedValue.ToString();
        //st_orderlist = seldate.SelectedValue.ToString();

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&St_paylist=" + St_paylist;
        final += "&st_trnlist=" + st_trnlist;
        final += "&st_delist=" + st_delist;        
        Response.Redirect("Result.aspx" + final);

    }
}


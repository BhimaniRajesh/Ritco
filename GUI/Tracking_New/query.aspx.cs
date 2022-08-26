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

public partial class GUI_Tracking_New_query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        THC_Call = Session["THCCalledAs"].ToString();

        if (!IsPostBack)
        {
            string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            // Response.Write("<br>sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
           
            dread.Read();
            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
           
            dread.Close();

            documet_type.Items.Add(new ListItem(dkt_Call, "DKT"));
            documet_type.Items.Add(new ListItem(THC_Call, "THC"));
            documet_type.SelectedValue = "DKT";
            cboRO_Lo.Items.Clear();
            //cboRO_Lo_TO.Items.Clear();
            cboRO.Items.Clear();
            //cboRO_TO.Items.Clear();
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
          
            dread.Close();

           
                sqlstr = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
           
                cmd = new SqlCommand(sqlstr, conn);
                SqlDataReader dread12 = cmd.ExecuteReader();
                {

                    while (dread12.Read())
                    {

                        cboRO_Lo_TO.Items.Add(new ListItem(dread12.GetValue(1).ToString(), dread12.GetValue(0).ToString()));
                        cboRO_Lo_TO.SelectedValue = "All";
                    }

                }
                dread12.Close();
           


            string sqlstr13 = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";

            cmd = new SqlCommand(sqlstr13, conn);
            SqlDataReader dread13 = cmd.ExecuteReader();
            {

                while (dread13.Read())
                {

                    cboRO_TO.Items.Add(new ListItem(dread13.GetValue(1).ToString(), dread13.GetValue(0).ToString()));
                    cboRO_TO.SelectedValue = "All";
                }

            }
            dread13.Close();

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
        }
        conn.Close();

    }

    protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    {

       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

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

    protected void cboRO_SelectedIndexChanged(object sender, EventArgs e)
    {        
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
        string report_mode = "",st_doctyp="", report_Subtype = "", report_type = "", st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_ro = "", st_lo = "", st_ro_to = "", st_lo_to = "";
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

        st_ro_to = cboRO_TO.SelectedValue.ToString();
        if (cboRO_TO.SelectedValue.ToString() == "")
        {
            st_ro_to = "All";
        }

        st_lo_to = cboRO_Lo_TO.SelectedValue.ToString();
        if (cboRO_Lo_TO.SelectedValue.ToString() == "")
        {
            st_lo_to = "All";
        }

        st_doctyp = documet_type.SelectedValue.ToString();

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


        st_Docnolist = txtsysno.Text.ToString();
        St_Manualnolist = txtmanbo.Text.ToString();
        st_Vehnolist = txtCustRefno.Text.ToString();
        st_Freetext=txtFreeText.Text.ToString();
       

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&RO_TO=" + st_ro;
        final += "&LO_TO=" + st_lo_to;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&st_Docnolist=" + st_Docnolist;
        final += "&St_Manualnolist=" + St_Manualnolist;
        final += "&st_Vehnolist=" + st_Vehnolist;
        final += "&st_Freetext=" + st_Freetext;
        final += "&st_doctyp=" + st_doctyp;        
        Response.Redirect("Result.aspx" + final);

    }
}


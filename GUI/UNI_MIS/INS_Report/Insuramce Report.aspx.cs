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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Data.SqlClient;

public partial class GUI_UNI_MIS_DOC_Profit_Insuramce_Report : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        brcd = Session["brcd"].ToString();
        if (!IsPostBack)
        {
            string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            dread.Read();

            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
            dread.Close();

            cboRO_Lo.Items.Clear();
            cboRO.Items.Clear();
           
            if (loclevel == 1)
            {
                sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                cboRO_Lo.Items.Add(new ListItem("All", "All"));
               
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
                    if (loclevel == 1)
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
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";
        string st_ro = "", st_lo = "", report_mode = "";

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

        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&Type=" + radBtnType.SelectedValue;
        Response.Redirect("InsuramceReportResult.aspx" + final);

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
             }

        }
        dread.Close();
        conn.Close();
    }
}

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
public partial class GUI_UNI_MIS_OPN_LIFE_CYCLE_Query : System.Web.UI.Page
{

    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call, thc_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        thc_call = Session["THCCalledAs"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (!IsPostBack)
        {


            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 23/5/2014
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

            if (loclevel < 3)
            {
                if (loclevel != 1)
                {
                    sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where Report_loc='" + brcd + "' or  loccode='" + brcd + "'";
                }
                else
                {
                    sqlstr = "select top 1 '' as loccode,''  from webx_location";
                }
                cmd = new SqlCommand(sqlstr, conn);
                dread = cmd.ExecuteReader();
                cboRO_Lo.Items.Clear();
                cboRO_Lo.Items.Add(new ListItem("All", "All"));
                while (dread.Read())
                {
                    cboRO_Lo.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }
                dread.Close();
            }


            string sqlstr1 = "select codedesc,codeid from webx_master_general where codetype='TRN'";
          
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
        string report_mode = "", report_Subtype = "", report_type = "", st_columnlist = "", St_paylist = "", st_trnlist = "", st_delist = "", st_ro = "", st_lo = "";
        string fromdt = "", todt = "";


     

        st_columnlist = txtdocno.Text.ToString();
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


        string DateType = report_mode;
        string strrightnow, strrightnow1;

        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateType == "Date" || DateType == "1")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString();
        }
        else if (DateType == "Week" || DateType == "2")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today" || DateType == "3")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
       // final += "&DateType=" + report_mode;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;       
        final += "&st_columnlist=" + st_columnlist;

        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 23/5/2014


        Response.Redirect("result.aspx" + final);
    }
}

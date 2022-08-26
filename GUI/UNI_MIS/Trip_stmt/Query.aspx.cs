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

public partial class GUI_UNI_MIS_Trip_stmt_Query : System.Web.UI.Page
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
           
            // Response.Write("<br>sqlstr : " + sqlstr);
            //SqlCommand cmd = new SqlCommand(sqlstr, conn);
            //SqlDataReader dread = cmd.ExecuteReader();
            //string loclevel = dread.GetValue(0).ToString();


            string sqlstr = "select codedesc,codeid from webx_master_general where codetype='TRN'";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLMode.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }

            }
            dread.Close();


        }

        conn.Close();
    }
    

   

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", report_Subtype = "", report_type = "", st_stloc = "", st_endloc = "", st_enrutloc = "", st_thclist = "", st_mode = "", st_status = "";
        string fromdt = "", todt = "";


      
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

        st_stloc = txtxstloc.Text.ToString();
        st_endloc = txtxendloc.Text.ToString();
        st_enrutloc = txtxenrouteloc.Text.ToString();

        if (st_stloc=="")
        {
            st_stloc = "All";
        }
        if (st_endloc == "")
        {
            st_endloc = "All";
        }
        if (st_enrutloc == "")
        {
            st_enrutloc = "All";
        }

        st_thclist = txtthcnos.Text.ToString();
        st_mode = DDLMode.SelectedValue.ToString();
        st_status = cboStatus.SelectedValue.ToString();

        

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
        final = "?DateType=" + report_mode;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&Rtyp=" + report_type;
        final += "&st_stloc=" + st_stloc;
        final += "&st_endloc=" + st_endloc;
        final += "&st_enrutloc=" + st_enrutloc;
        final += "&st_thclist=" + st_thclist;
        final += "&st_mode=" + st_mode;
        final += "&st_status=" + st_status;
        Response.Redirect("Result.aspx" + final);

    }
}

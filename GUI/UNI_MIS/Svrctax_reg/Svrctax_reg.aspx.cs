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



public partial class GUI_UNI_MIS_Login_View_Login_view : System.Web.UI.Page
{

    public byte byteRadButtonSelection;
    int loclevel;
    string brcd = "";
    public static string strcust, dkt_call;
    ///uni_mis/svrctax_reg/Show_svrctax_reg.aspx?strDateRange=14%20May%2007%20-%2014%20Jun%2007&strloc=All&strro=All&party=&type=&amt=&mr=
    
    protected void Page_Load(object sender, EventArgs e)
    {
       // Button3.Attributes.Add("onclick", "javascript:return ValidateForm(" + txtDateFrom.ClientID + "," + txtDateTo.ClientID + ")");

        
        dkt_call = Session["DocketCalledAs"].ToString();
            if (!IsPostBack)
            {
                // mypanal.Visible = false;
                txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = txtDateFrom.Text;
                //popRO();
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
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

                if (loclevel == 1)
                {
                    sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                    cboRO_Lo.Items.Add(new ListItem("All", "All"));
                    
                   // cboRO_Lo_TO.Items.Add(new ListItem("All", "All"));
                }
                else
                {
                    sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";

                    // ROWLO.Visible = false;
                    ROWLO.Style["display"] = "none";
                }
                SqlCommand cmd = new SqlCommand(sqlstr, conn);
                SqlDataReader dread = cmd.ExecuteReader();
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
                dread.Close();
                //sqlstr = "   select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                //if (loclevel == 1)
                //{
                //    sqlstr = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                //}
                //else
                //{
                //    sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
                //    String sqlstr12 = "select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL not in ('1','2') ";

                //    SqlCommand cmd1 = new SqlCommand(sqlstr12, conn);
                //    SqlDataReader dread1 = cmd1.ExecuteReader();
                //    {

                //        while (dread1.Read())
                //        {

                //            cboRO_Lo_TO.Items.Add(new ListItem(dread1.GetValue(1).ToString(), dread1.GetValue(0).ToString()));
                //            cboRO_Lo_TO.SelectedValue = "All";
                //        }

                //    }
                //    dread1.Close();
                //}
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
                conn.Close();
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

    //protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    //{

    //    //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
    //    //Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    //Response.Cache.SetNoStore();
    //    //Response.Cache.SetExpires(DateTime.MinValue);
    //    //Scargoconnection conn = new Scargoconnection();
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    brcd = Session["brcd"].ToString();
    //    //Response.Write("<br>brcd : " + brcd);
    //    //String sqlstr;
    //    String sqlstrloc = "select loc_level from webx_location where loccode='" + brcd + "'";
    //    // Response.Write("<br>sqlstr : " + sqlstr);
    //    SqlCommand cmd12 = new SqlCommand(sqlstrloc, conn);
    //    SqlDataReader dread12 = cmd12.ExecuteReader();
    //    //string loclevel = dread.GetValue(0).ToString();
    //    dread12.Read();
    //    loclevel = Convert.ToInt32(dread12.GetValue(0).ToString());
    //    //loclevel = 2;
    //    //Response.Write("<br>loclevel : " + loclevel);
    //    dread12.Close();

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

    
    
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
       

    }

    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }

        else if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greter Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        //if (Page.IsValid == true)
        //{

            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            string strFinalQS = "?strDateRange=" + strDate;
            strFinalQS = strFinalQS + "&strloc=" + cboRO_Lo.SelectedValue.ToString();
            strFinalQS = strFinalQS + "&strro=" + cboRO.SelectedValue.ToString();

            strFinalQS = strFinalQS + "&party=" + txtparty.Text;
            strFinalQS = strFinalQS + "&type=" + ddlmrtype.SelectedValue.ToString();

            strFinalQS = strFinalQS + "&amt=" + txtamt.Text;
            strFinalQS = strFinalQS + "&mr=" + txtmrno.Text;


                Response.Redirect("Show_svrctax_reg.aspx" + strFinalQS);
            
            
        //}

    }
}


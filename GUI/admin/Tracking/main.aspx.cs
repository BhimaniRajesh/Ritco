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
    
  
    protected void Page_Load(object sender, EventArgs e)
    {
       // Session["brcd"] = "PRHO";
       // Session["empcd"] = "p1438";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        conn.Open();



        String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        
        SqlDataReader dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                cboRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();

        sqlstr = "   select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
        cmd = new SqlCommand(sqlstr, conn);
        dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                cboRO_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();
        
        conn.Close();
    }

    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

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
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }


    protected void cboRO_SelectedIndexChanged(object sender, EventArgs e)
    {

        //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetNoStore();
        //Response.Cache.SetExpires(DateTime.MinValue);


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //Scargoconnection conn = new Scargoconnection();
        conn.Open();

        String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO.SelectedValue.ToString() + "'";
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

    protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    {

        //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetNoStore();
        //Response.Cache.SetExpires(DateTime.MinValue);

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //Scargoconnection conn = new Scargoconnection();
        conn.Open();

        String sqlstr = "select top 1 'All' as c1,'All' as c2 from webx_location union select loccode as c1,loccode + ' : '+ locname  as c2 from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboRO_Lo_TO.Items.Clear();
        {

            while (dread.Read())
            {
                cboRO_Lo_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }

        }
        dread.Close();
        conn.Close();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "webx_UNI_CUST_TRacking";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
       // dtfi.ShortDatePattern="
        dtfi.DateSeparator = "/";

        MyFunctions fn = new MyFunctions();


        //string fromdt = Request.QueryString.Get("txtDateFrom");
       // string Todt = Request.QueryString.Get("txtDateTo");

        string  fromdt = fn.Datadate(txtDateFrom.Text.ToString());
        string Todt = fn.Datadate(txtDateTo.Text.ToString());
       // Todt = fn.Datadate(Todt);

        {
            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
            
        }

        string custcode1 = "";

        if (custcode.Text.ToString() == "")
        {
             custcode1="All";

        }

        da.SelectCommand.Parameters.Add("@fromdt", SqlDbType.DateTime).Value = fromdt.Trim();
        da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = Todt.Trim();
        da.SelectCommand.Parameters.Add("@fromRo", SqlDbType.VarChar).Value = cboRO.SelectedItem.Value;
        da.SelectCommand.Parameters.Add("@fromloc", SqlDbType.VarChar).Value = cboRO_Lo.SelectedItem.Value;
        da.SelectCommand.Parameters.Add("@toRo", SqlDbType.VarChar).Value = cboRO_TO.SelectedItem.Value;
        da.SelectCommand.Parameters.Add("@toloc", SqlDbType.VarChar).Value = cboRO_Lo_TO.SelectedItem.Value;
        da.SelectCommand.Parameters.Add("@custcode", SqlDbType.VarChar).Value = custcode1 ;
        da.SelectCommand.Parameters.Add("@docklist", SqlDbType.VarChar).Value = docketlist.Text;
        da.SelectCommand.Parameters.Add("@manuallist", SqlDbType.VarChar).Value = manuallist.Text;
        da.SelectCommand.Parameters.Add("@documenttype", SqlDbType.VarChar).Value = documet_type.SelectedItem.Value; 

        DataSet ds = new DataSet();

        da.Fill(ds);

        if (documet_type.SelectedItem.Value == "D")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
             
                      dgMenifest.Visible = false;

            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }
        if (documet_type.SelectedItem.Value == "M")
        {


            dgMenifest.DataSource = ds;
            dgMenifest.DataBind();
            dgDocket.Visible = false;
            //     dgSales.DataSource = ds;
            //dgSales.DataBind();
        }


        conn.Close();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
            if (documet_type.SelectedItem.Value == "D")
            {
                dgDocket.PageIndex = e.NewPageIndex;
             }
             if (documet_type.SelectedItem.Value == "M")
             {
                 dgMenifest.PageIndex = e.NewPageIndex;
             }
        BindGrid();

    }

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
        BindGrid();
    }
    
}

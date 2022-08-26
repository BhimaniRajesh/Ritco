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
using Microsoft.VisualBasic;     
public partial class FrmCriteria : System.Web.UI.Page
{
    SqlConnection cn;
    public string Client;
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["brcd"] = "HQTR";
        string logo = Session["logofile"].ToString();
        imgLogo.ImageUrl = "~/GUI/images/" + logo;

        if (Session["Client"] == "ASL")
        {
            Client = "ASL";
        }
       
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
            FillRO();
            FillRO2();
        }
    }
    public void FillRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // conn = new SqlConnection(sConn);
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select Loc_level,locname from webx_location where  Loc_level='1'";
        int loclvl = 0;
        string locnm = "";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();
        while (dr.Read())
        {
            loclvl= Convert.ToInt16(dr["Loc_level"]);
             locnm = dr["locname"].ToString();
        }
        dr.Close();
        if (loclvl <= 2)
        {

            if (loclvl == 1)
            {
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                da.Fill(ds, "tab");
                CmbRO.DataSource = ds;
                CmbRO.DataTextField = "c1";
                CmbRO.DataValueField = "c2";
                CmbRO.DataBind();
                CmbLoc.Items.Add("All");
            }
            else
            {
                string concat = brcd + " : " + locnm;
                CmbRO.Items.Clear();
                //CmbRO.Items.Add("Sandy");
                CmbRO.Items.Add(concat);

                CmbRO.DataBind();
                CmbRO.SelectedItem.Value = brcd;

                FillLocation();

            }

        }
        else
        {
            CmbRO.Enabled = false;
            //trro.Visible = false;
            CmbLoc.Items.Clear();
            CmbLoc.Items.Add(brcd);
        }
    }
    public void FillRO2()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // conn = new SqlConnection(sConn);
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select Loc_level,locname from webx_location where Loc_level='1'";

        int loclvl = 1;
        string locnm = "";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();
        while (dr.Read())
        {
            loclvl = Convert.ToInt16(dr["Loc_level"]);
            locnm = dr["locname"].ToString();
        }
        dr.Close();
        if (loclvl <= 2)
        {

            if (loclvl == 1)
            {
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                da.Fill(ds, "tab");
                CmbRO2.DataSource = ds;
                CmbRO2.DataTextField = "c1";
                CmbRO2.DataValueField = "c2";
                CmbRO2.DataBind();
                CmbLoc2.Items.Add("All");
            }
            else
            {
                string concat = brcd + " : " + locnm;
                CmbRO2.Items.Clear();
                //CmbRO2.Items.Add("Sandy");
                CmbRO2.Items.Add(concat);

                CmbRO2.DataBind();
                CmbRO2.SelectedItem.Value = brcd;

                FillLocation2();

            }

        }
        else
        {
            CmbRO2.Enabled = false;
            //trro.Visible = false;
            CmbLoc2.Items.Clear();
            CmbLoc2.Items.Add(brcd);
        }
    }
    public void FillLocation()
    {
        string sConn;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strro = CmbRO.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        CmbLoc.DataSource = ds;
        CmbLoc.DataTextField = "c1";
        CmbLoc.DataValueField = "loccode";
        CmbLoc.DataBind();
    }
    public void FillLocation2()
    {
        string sConn;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strro = CmbRO2.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        CmbLoc2.DataSource = ds;
        CmbLoc2.DataTextField = "c1";
        CmbLoc2.DataValueField = "loccode";
        CmbLoc2.DataBind();
    }
    protected void CmbRO_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation();    
    }
    protected void CmbRO2_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation2();
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            BtnSubmit.Text = "Processing....";
            BtnSubmit.ForeColor = System.Drawing.Color.Red;
            BtnSubmit.BackColor = System.Drawing.Color.White;
            string ro;
            if (CmbRO.Text == "")
            {
                ro = "All";
            }
            else
            {
                ro = CmbRO.Text;
            }
            //Response.Redirect("FrmToPayFollowUp.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&RO=" + ro + "&LocCode=" + CmbLoc.Text + "&CCode=" + TextBox1.Text + "");
        }
    }
    public void abc(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');    
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');    
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (radDate.SelectedItem.Text == " Last Week (Including Today)")
        {
            txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
            DateTime MyDate = DateTime.Today;
            MyDate = MyDate + TimeSpan.FromDays(-7);
            txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
            
        }
        else
        {
            if (radDate.SelectedItem.Text == " Date Range [dd/mm/yyyy]")
            {
                DateTime MyDate = DateTime.Today;
                MyDate = MyDate + TimeSpan.FromDays(-31);
              //  txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
                txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
                txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateFrom.ReadOnly = false;
                txtDateTo.ReadOnly = false;
                
            }

            if (radDate.SelectedItem.Text == " Today:")
            {
                txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = txtDateFrom.Text;
                txtDateFrom.ReadOnly = true;
                txtDateTo.ReadOnly = true;
                
            }
        }
    }
}

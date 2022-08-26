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
    protected void Page_Load(object sender, EventArgs e)
    {   
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
            FillRO();
        }
    }
    public void FillRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string s = Session["SqlProvider"].ToString().Trim();
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);

        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
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
                CmbRO.SelectedValue = "All";
                CmbRO.DataBind();
                CmbLoc.Items.Add("All");
                CmbLoc.SelectedValue = "All";
            }
            else
            {
                string concat = brcd + " : " + locnm;
                CmbRO.Items.Clear();
                CmbRO.Items.Add(concat);
                CmbRO.DataBind();
                CmbRO.SelectedItem.Value = brcd;
                FillLocation();
            }
        }
        else
        {
            string concat1 = brcd + " : " + locnm;
            CmbRO.Enabled = false;
            CmbLoc.Items.Clear();
            CmbLoc.Items.Add(brcd);
        }
    }

    public void FillLocation()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string strro = CmbRO.SelectedValue.ToString();
        string sql = "";
        if (strro == "HQTR")
        {
            sql = "select top 1 '-All-' as c1,'All' as loccode from webx_location  union Select distinct loccode+' : '+locname c1,loccode from webx_Location where  activeflag='Y'";
        }
        else
        {
            sql = "select top 1 '-All-' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "' or loccode='" + strro + "' and  activeflag='Y'";
        }

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab1");
        CmbLoc.DataSource = ds;
        CmbLoc.DataTextField = "c1";
        CmbLoc.DataValueField = "loccode";
        CmbLoc.DataBind();
        CmbLoc.SelectedValue = "All";
    }
    protected void CmbRO_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation();    
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
            Response.Redirect("FrmAdviceList.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&RO=" + ro + "&status=" + CmbStatus.Text + "&statusname=" + CmbStatus.SelectedItem.Text + "&AdviceNO=" + TxtAdviceNo.Text + "&location=" + CmbLoc.Text + "");
        }
    }
    public void abc(object source, ServerValidateEventArgs value)
    {   
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

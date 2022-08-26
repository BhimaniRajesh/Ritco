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
    //SqlConnection cn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    protected void Page_Load(object sender, EventArgs e)
    {
        //string conName = txtDateFrom.ClientID;
        //string scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
        //txtDateFrom.Attributes.Add("onclick", scriptStr);
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            cn.Open();
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;  
            FillRO();
           // FillLocation();
        }
    }
    //private void FillRO()
    //{
    //    //string str = "select * from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
    //    Session["loc"] = "HQTR";
    //    string sqlstr = "select loccode,locname from webx_location where (report_loc='" + Session["LOC"] + "' and report_loc<>loccode ) or loc_level=(select loc_level from webx_location where loc_level='1' ) order by locname";        
    //    SqlCommand cmd = new SqlCommand(sqlstr, cn);
    //    if (cn.State == ConnectionState.Closed)
    //    {
    //        cn.Open();
    //    }
       
    //   for (int i = 1;i < CmbRO.Items.Count;i++) 
    //   {
    //       if (CmbRO.Items[i].Text == "All")
    //       {
    //           CmbRO.Items.Remove("All"); 
    //       }
    //   }
    //   CmbRO.Items.Add("All"); 
    //    SqlDataReader dread;
    //    //cmd = new SqlCommand(sqlstr, conn);
    //    dread = cmd.ExecuteReader();
    //    {

    //        while (dread.Read())
    //        {
    //            CmbRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //        }

    //    }
    //    dread.Close();
    //    CmbRO.SelectedItem.Text = "All"; 
    //}
    public void FillRO()
    {
        //conatct mr. darbar for any problem related to RO & Lo
        //string sConn;
        //SqlConnection conn;

        // sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //  sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // conn = new SqlConnection(sConn);
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

    //private void FillLocation()
    //{
    //    String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + CmbRO.SelectedValue.ToString() + "' and report_loc<>loccode order by locname";
    //    if (cn.State == ConnectionState.Closed)
    //    {
    //        cn.Open(); 
    //    }
    //    CmbLoc.Items.Clear();
    //    //for (int i = 1; i < CmbLoc.Items.Count; i++)
    //    //{
    //    //    if (CmbLoc.Items[i].Text == "All")
    //    //    {
    //    //        CmbLoc.Items.Remove("All");
    //    //    }
    //    //}
    //    CmbLoc.Items.Add("All"); 
       
    //    SqlCommand cmd = new SqlCommand(sqlstr, cn);
    //    SqlDataReader dread = cmd.ExecuteReader();
    //    {

    //        while (dread.Read())
    //        {
    //            CmbLoc.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //        }

    //    }
    //    dread.Close();
    //    CmbLoc.SelectedItem.Text = "All"; 
    //}
    public void FillLocation()
    {
        string sConn;
       // SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
       // sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //conn = new SqlConnection(sConn);
        conn.Open();
        string strro = CmbRO.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.Text;
        //select loccode+':'+locname c1 from webx_location
        //ddlro.DataTextField = "-ALL-";
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        CmbLoc.DataSource = ds;
        CmbLoc.DataTextField = "c1";
        CmbLoc.DataValueField = "loccode";
        CmbLoc.DataBind();
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
            Response.Redirect("FrmToPayFollowUp.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&RO=" + ro + "&LocCode=" + CmbLoc.Text + "&CCode=" + TextBox1.Text + "");
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

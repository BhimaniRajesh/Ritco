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
public partial class query : System.Web.UI.Page
{
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE"); 
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=ecfy13;UID=sa;PWD=sa;Database=webxnet"); 
    protected void Page_Load(object sender, EventArgs e)
    {
        //String sqlstr = "select abbr_type,Codetype_new from webx_typemst  where Activeflag='Y'";
        // sqlstr = "select codedesc,codeid from webx_master_general where codetype='TRN'";
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
            //FillLocation();
            //FillLocation2();
            FillPayBas();
            FillMode();
            RadLocWise.Checked = true;
            RadPayBas.Checked = true;
            CmbLoc.Enabled = true;
            CmbRO.Enabled = true;
            CmbLoc2.Enabled = false;
            CmbRO2.Enabled = false;
            CmbPayBasis.Enabled = true;
            CmbMode.Enabled = false;  
        }
    }
    private void FillPayBas()
    {
        //String sqlstr = "select abbr_type,Codetype_new from webx_typemst where Activeflag='Y'";
        String sqlstr = "select codedesc,codeid from webx_master_general where codetype='paytyp' and statuscode='Y'";
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        for (int i = 1; i < CmbPayBasis.Items.Count; i++)
        {
            if (CmbPayBasis.Items[i].Text == "All")
            {
                CmbPayBasis.Items.Remove("All");
            }
        }
        CmbPayBasis.Items.Add("All");
        
        SqlDataReader dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                CmbPayBasis.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
            }

        }
        dread.Close();

    }
    private void FillMode()
    {
        String sqlstr = "select codedesc,codeid from webx_master_general where codetype='TRN'";
        SqlCommand cmd = new SqlCommand(sqlstr, cn);
        for (int i = 1; i < CmbMode.Items.Count; i++)
        {
            if (CmbMode.Items[i].Text == "All")
            {
                CmbMode.Items.Remove("All");
            }
        }
        CmbMode.Items.Add("All");
        
        SqlDataReader dread = cmd.ExecuteReader();
        {

            while (dread.Read())
            {
                CmbMode.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
            }

        }
        dread.Close();

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
    //    for (int i = 1; i < CmbRO.Items.Count; i++)
    //    {
    //        if (CmbRO.Items[i].Text == "All")
    //        {
    //            CmbRO.Items.Remove("All");
    //        }
    //    }
    //    CmbRO.Items.Add("All");
    //    SqlDataReader dread;
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
    //private void FillLocation()
    //{
    //    String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + CmbRO.SelectedValue.ToString() + "' and report_loc<>loccode order by locname";
    //    if (cn.State == ConnectionState.Closed)
    //    {
    //        cn.Open();
    //    }
    //    CmbLoc.Items.Clear();
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

            CmbRO.Text = "All";
            CmbRO.Enabled = false;
            //trro.Visible = false;
            CmbLoc.Items.Clear();
            CmbLoc.Items.Add(brcd);
        }




    }



    public void FillLocation()
    {
        string sConn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";
        //sConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
    protected void CmbRO2_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillLocation2();
    }
    //private void FillRO2()
    //{
    //    //string str = "select * from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";
    //    Session["loc"] = "HQTR";
    //    string sqlstr = "select loccode,locname from webx_location where (report_loc='" + Session["LOC"] + "' and report_loc<>loccode ) or loc_level=(select loc_level from webx_location where loc_level='1' ) order by locname";
    //    SqlCommand cmd = new SqlCommand(sqlstr, cn);
    //    if (cn.State == ConnectionState.Closed)
    //    {
    //        cn.Open();
    //    }
    //    for (int i = 1; i < CmbRO2.Items.Count; i++)
    //    {
    //        if (CmbRO2.Items[i].Text == "All")
    //        {
    //            CmbRO2.Items.Remove("All");
    //        }
    //    }
    //    CmbRO2.Items.Add("All");
    //    SqlDataReader dread;
    //    dread = cmd.ExecuteReader();
    //    {

    //        while (dread.Read())
    //        {
    //            CmbRO2.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //        }

    //    }
    //    dread.Close();
    //    CmbRO2.SelectedItem.Text = "All";
    //}
    //private void FillLocation2()
    //{
    //    String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + CmbRO.SelectedValue.ToString() + "' and report_loc<>loccode order by locname";
    //    if (cn.State == ConnectionState.Closed)
    //    {
    //        cn.Open();
    //    }
    //    CmbLoc2.Items.Clear();
    //    CmbLoc2.Items.Add("All");

    //    SqlCommand cmd = new SqlCommand(sqlstr, cn);
    //    SqlDataReader dread = cmd.ExecuteReader();
    //    {

    //        while (dread.Read())
    //        {
    //            CmbLoc2.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
    //        }

    //    }
    //    dread.Close();
    //    CmbLoc2.SelectedItem.Text = "All";
    //}
    public void FillRO2()
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
                //CmbRO.Items.Add("Sandy");
                CmbRO2.Items.Add(concat);

                CmbRO2.DataBind();
                CmbRO2.SelectedItem.Value = brcd;

                FillLocation2();

            }

        }
        else
        {

            CmbRO2.Text = "All";
            CmbRO2.Enabled = false;
            //trro.Visible = false;
            CmbLoc2.Items.Clear();
            CmbLoc2.Items.Add(brcd);
        }




    }



    public void FillLocation2()
    {
        string sConn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";
        //sConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
        CmbLoc2.DataSource = ds;
        CmbLoc2.DataTextField = "c1";
        CmbLoc2.DataValueField = "loccode";
        CmbLoc2.DataBind();
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
        txtDateTo.Text = txtDateTo.Text.Replace('-','/');    
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string mainmode, submode,paybaseitem,modeitem;
            mainmode = "";
            submode = "";
            paybaseitem = "";
            modeitem = "";
            if (RadLocWise.Checked == true)
            {
                mainmode = "locwise";
            }
            else if (RadCustWise.Checked == true)
            {
                mainmode = "custwise";
            }
            else if (RadDestWise.Checked == true)
            {
                mainmode = "destwise";
            }
            else if (RadEmpWise.Checked == true)
            {
                mainmode = "empwise";
            }
            if (RadPayBas.Checked == true)
            {
                submode = "paybaswise";
                paybaseitem = CmbPayBasis.Text;  

            }
            else if (RadMode.Checked == true)
            {
                submode = "modewise";
                modeitem = CmbMode.Text;  
            }
            string ro;
            if (CmbRO.Text == "")
            {
                ro = "All";
            }
            else
            {
                ro = CmbRO.Text;
            }
            Response.Redirect("FrmDocketDetail.aspx?FrmDate=" + txtDateFrom.Text + "&ToDate=" + txtDateTo.Text + "&RO=" + ro + "&LocCode=" + CmbLoc.Text + "&CCode=" + TextBox1.Text + "&mainmode=" + mainmode + "&submode=" + submode + "&paybasitem=" + paybaseitem + "&modeitem=" + modeitem + "");
        }
    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = ""; 
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

    protected void RadLocWise_CheckedChanged(object sender, EventArgs e)
    {
        if (RadLocWise.Checked == true)
        {
            RadPayBas.Enabled = true;
            RadPayBas.Checked = true;
            RadMode.Checked = false;
            CmbPayBasis.Enabled = true;  
            RadMode.Enabled = true;  
            CmbLoc.Enabled = true;
            CmbRO.Enabled = true;  
            CmbLoc2.Enabled = false;
            CmbRO2.Enabled = false;  
        }

    }
    protected void RadCustWise_CheckedChanged(object sender, EventArgs e)
    {
        if (RadCustWise.Checked == true)
        {
            RadPayBas.Enabled = true;
            RadPayBas.Checked = true;
            RadMode.Checked = false;
            CmbPayBasis.Enabled = true;  
            RadMode.Enabled = true;  
            CmbLoc.Enabled = true;
            CmbRO.Enabled = true;
            CmbLoc2.Enabled = false;
            CmbRO2.Enabled = false;
        }

    }
    protected void RadPayBas_CheckedChanged(object sender, EventArgs e)
    {
        if (RadPayBas.Checked == true)
        {
            CmbMode.Enabled = false;
            CmbPayBasis.Enabled = true; 
        }
    }
    protected void RadMode_CheckedChanged(object sender, EventArgs e)
    {
        if (RadMode.Checked == true)
        {
            CmbMode.Enabled = true;
            CmbPayBasis.Enabled = false;
        }
    }
    protected void RadDestWise_CheckedChanged(object sender, EventArgs e)
    {
        if (RadDestWise.Checked == true)
        {
            CmbLoc.Enabled = true;
            CmbRO.Enabled = true;
            CmbLoc2.Enabled = true ;
            CmbRO2.Enabled = true;
            CmbPayBasis.Enabled = false;
            CmbMode.Enabled = false;
            RadMode.Enabled = false;
            RadPayBas.Enabled = false;  
        }

    }
}

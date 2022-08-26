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



public partial class _Default : System.Web.UI.Page 
{

    int loclevel ;
    string brcd = "";

    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    //Scargoconnection s = new Scargoconnection();

    //string sConn;
   // SqlConnection conn= new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PRRL_TEST;");

    //SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=ecfy$@p@$$;Database=RCPL_ver2_live;");
    

    protected Int32 _currentPageNumber = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
               
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        //string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PRRL_TEST;";
        ////sConn = "data source=202.87.45.71;UID=sa;PWD=ecfy$@p@$$;Database=RCPL_ver2_live;";
        //conn = new SqlConnection(sConn);

       // Scargoconnection conn = new Scargoconnection();
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            String sqlstr = "select codeid,codedesc from webx_master_general where  codetype='PAYTYP' and  statuscode='Y'";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLPaybas.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();

            sqlstr = "select codedesc,codeid from webx_master_general where codetype='TRN'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLMode.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }

            }
            dread.Close();

            // sqlstr = "select level_no,level_type from webx_Hierarchy where activeflag='Y' and  level_no>'1'  order by level_no";
            // cmd = new SqlCommand(sqlstr, conn);
            // dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {
            //        cboHY.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //    }

            //}
            //dread.Close();

            brcd = Session["brcd"].ToString();
            //Response.Write("<br>brcd : " + brcd);

            sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            // Response.Write("<br>sqlstr : " + sqlstr);
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            //string loclevel = dread.GetValue(0).ToString();
            dread.Read();
            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
            //loclevel = 2;
            //Response.Write("<br>loclevel : " + loclevel);
            dread.Close();


            if (loclevel == 1)
            {
                sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
                cboRO_Lo.Items.Add(new ListItem("All","All"));
                cboRO_Lo_TO.Items.Add(new ListItem("All", "All"));
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
                    if (loclevel == 1)
                    {
                        cboRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                        cboRO_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                    }
                    else
                    {
                        cboRO_Lo.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                       
                    }
                }

            }
            cboRO.SelectedValue = "All";
            cboRO_TO.SelectedValue = "All";
            dread.Close();
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

            //sqlstr = "   select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            if (loclevel == 1)
            {
                sqlstr = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";
            }
            else
            {
                sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
                String sqlstr12 = "select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL not in ('1','2') ";

                cmd = new SqlCommand(sqlstr12, conn);
                SqlDataReader dread12 = cmd.ExecuteReader();
                {

                    while (dread12.Read())
                    {

                        cboRO_Lo_TO.Items.Add(new ListItem(dread12.GetValue(1).ToString(), dread12.GetValue(0).ToString()));
                        cboRO_Lo_TO.SelectedValue = "All";
                    }

                }
                dread12.Close();
            }
           

           

            cmd = new SqlCommand("select (codeid + ' as '+ replace((replace((replace(codedesc,' ','')),'-','_')),'/','_'))as codeid,codedesc from Webx_Master_General where codetype='CHG' and statuscode='Y'", conn);
            dread = cmd.ExecuteReader();
            Int32 i = 0;
            while (dread.Read())
            {
                string a;
                ChkAmtChrgDtl.Items.Add(Convert.ToString(dread["codedesc"]));
                ChkAmtChrgDtl.Items[i].Value = Convert.ToString(dread["codeid"]);
                i += 1;
            }
            ChkAmtChrgDtl.CssClass = "blackfnt";
            dread.Close();
            conn.Close();
            radDate.SelectedIndex = 1;
            radDate_OnSelectedIndexChange(null, null);
            //chkAll_OnCheckedChanged(null, null);
            //chkAll_OnCheckedChanged(null, null);

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

    protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    {

        //string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetNoStore();
        //Response.Cache.SetExpires(DateTime.MinValue);
        //Scargoconnection conn = new Scargoconnection();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        String sqlstr = "";

        if (loclevel <=2)
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
    //private void Button1_Click(object sender, System.EventArgs e)
    //{
    //    dgSales.DataSource = GenerateDataTable();
    //    dgSales.DataBind();

            
    //    string fileName = System.Guid.NewGuid().ToString().Replace("-", "") + ".xls";
    //    (new ExportDemo.Libraries.ExcelConvertor()).Convert(GenerateDataTable(), Server.MapPath("."), fileName);
    //    Response.Redirect(fileName);
    //}

    //private void Button2_Click(object sender, System.EventArgs e)
    //{
    //    string fileName = System.Guid.NewGuid().ToString().Replace("-", "") + ".csv";
    //    (new ExportDemo.Libraries.CSVConvertor()).Convert(GenerateDataTable(), Server.MapPath("."), fileName);
    //    Response.Redirect(fileName);
    //}


    //protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    //{
    //    switch (e.CommandName)
    //    {
    //        case "First":
    //            _currentPageNumber = 1;
    //            break;
    //        case "Last":
    //            _currentPageNumber = Int32.Parse(TotalPages.Text);
    //            break;
    //        case "Next":
    //            _currentPageNumber = Int32.Parse(CurrentPage.Text) + 1;
    //            break;
    //        case "Prev":
    //            _currentPageNumber = Int32.Parse(CurrentPage.Text) - 1;
    //            break;
    //    }

    //    BindGrid();
    //}

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string select2 = "";    
        foreach (ListItem li in CheckBoxList1.Items)
        {
            if (li.Selected == true)
            {
                select2 = select2 += "," + li.Value.ToString();
            }
        }

        string select3 = "";
     
        foreach (ListItem li1 in CheckBoxList2.Items)
        {
            if (li1.Selected == true)
            {
                // select2 = select2 += "," + select2.Append(li.Value);
                select3 = select3 += "," + li1.Value.ToString();
                //select2.ToString();
            }
        }

        string selectAmtChrg = "";

        foreach (ListItem li1 in ChkAmtChrgDtl.Items)
        {
            if (li1.Selected == true)
            {
                // select2 = select2 += "," + select2.Append(li.Value);
                selectAmtChrg = selectAmtChrg += "," + li1.Value.ToString();
                //select2.ToString();
            }
        }

        string View_Sales = "";
        string select_list = "";

        //if (select3 == "")
        //{
        //    select_list = select2 ;

        //}
        //else
        //{
        select_list = select2 + "" + selectAmtChrg + "" + select3;

       // }

        ///Response.Write("<br>" +);
        int Npos1 = select_list.IndexOf("MRSNo");
        int Npos2 = select_list.IndexOf("MRSDate");
        int Npos3 = select_list.IndexOf("BillNo");
        int Npos4 = select_list.IndexOf("Bill_Date");
        Response.Write("<br> abNpos1cd : " + Npos1);
        //Response.End;
        if (Npos1 == 0 && Npos2 == 0 && Npos3 == 0 && Npos4 == 0)
        {
            View_Sales = "vw_Docket_Sales_register";
        }
        else 
        {
            if (Npos1 > 0 && Npos2 > 0 && Npos3 > 0 && Npos4 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_All";
            }
            else if (Npos1 > 0 || Npos2 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_MR";
            }
            else if (Npos1 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_MR";
            }
            else if (Npos2 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_MR";
            }
            else if (Npos3 > 0 || Npos4 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_BIll";
            }
            else if (Npos3 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_BIll";
            }
            else if (Npos4 > 0)
            {
                View_Sales = "vw_Docket_Sales_register_BIll";
            }
            else
            {
                View_Sales = "vw_Docket_Sales_register";
            }
        }

        string final;
        string ro = cboRO.SelectedValue.ToString();
        string ro_to = cboRO_TO.SelectedValue.ToString();
        string lo = cboRO_Lo.SelectedValue.ToString();
        string lo_to = cboRO_Lo_TO.SelectedValue.ToString();
        string dtFrom = txtDateFrom.Text.ToString();
        string dtTo = txtDateTo.Text.ToString();
        string Paybas = DDLPaybas.SelectedItem.Value.ToString();
        string trnmod = DDLMode.SelectedItem.Value.ToString();
        string SDDLType = DDLType.SelectedItem.Value.ToString();
        string StatusType = DDStatus.SelectedItem.Value.ToString();
        string dockectlist = TextDockets.Text.ToString();
        string custcd1 = custcd.Text.ToString();
         //string final = "?billno_nos=" + billnonos;
//final += "&checkeddockno=" + 
        final = "?ro="+ ro;
        final += "&ro_to=" + ro_to;
        final += "&lo=" + lo;
        final += "&lo_to=" + lo_to;
        final += "&dtFrom="+dtFrom;
        final += "&dtTo=" + dtTo;
        final += "&select_list=" + select_list;
        final += "&View_Sales=" + View_Sales;
        final += "&Paybas=" + Paybas;
        final += "&trnmod=" + trnmod;
        final += "&SDDLType=" + SDDLType;
        final += "&StatusType=" + StatusType;
        final += "&dockectlist=" + dockectlist;
        final += "&custcd1=" + custcd1;
        Response.Redirect("SalesSummary_Result.aspx" + final);



    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)radDate;
        if (!(rbl.Items[0].Selected))
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
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }

    }
    //public void BindGrid()
    //{
    //    //string sConn;
    //    //SqlConnection conn;
    //    //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PRRL_TEST;";
    //    ////sConn = "data source=202.87.45.71;UID=sa;PWD=ecfy$@p@$$;Database=RCPL_ver2_live;";
    //    //conn = new SqlConnection(sConn);
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string sql = "webx_sales_register";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    sqlcmd.CommandType = CommandType.StoredProcedure;

    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

    //    System.DateTime righnow = System.DateTime.Today;
    //    string strrightnow = righnow.ToString("dd/MM/yyyy");

    //    DateTime dtFrom = new DateTime();
    //    DateTime dtTo = new DateTime();

    //   string select2 = "";
    //    //StringBuilder select2 = new StringBuilder();
       

    //    foreach (ListItem li in CheckBoxList1.Items)
    //    {
    //        if (li.Selected == true)
    //        {
    //           // select2 = select2 += "," + select2.Append(li.Value);
    //          select2 = select2 += "," + li.Value.ToString();
    //            //select2.ToString();
    //        }
    //    }

    //    string select3 = "";
    //    //StringBuilder select2 = new StringBuilder();


    //    foreach (ListItem li1 in CheckBoxList2.Items)
    //    {
    //        if (li1.Selected == true)
    //        {
    //            // select2 = select2 += "," + select2.Append(li.Value);
    //            select3 = select3 += "," + li1.Value.ToString();
    //            //select2.ToString();
    //        }
    //    }

    //    string View_Sales = "";
    //    string select_list = "";

    //    select_list = select2 + "," + select3;

    //    int Npos1 = select_list.IndexOf("MRSNo");
    //    int Npos2 = select_list.IndexOf("MRSDate");
    //    int Npos3 = select_list.IndexOf("BillNo");
    //    int Npos4 = select_list.IndexOf("billdate");
    //    Response.Write("<br> abNpos1cd : " + Npos1);
    //    //Response.End;
    //    if (Npos1 == 0 && Npos2 == 0 && Npos3 == 0 && Npos4 == 0 )
    //    {
    //        View_Sales = "vw_Uni_Docket_NET";
    //    }
    //    else 
    //    {
    //        if (Npos1 > 0 || Npos2 > 0)
    //        {
    //            View_Sales = "vw_Uni_Docket_MR_NET";
    //        }
    //        else if(Npos1 > 0 )
    //        {
    //            View_Sales = "vw_Uni_Docket_MR_NET";
    //        }
    //        else if (Npos2 > 0 )
    //        {
    //            View_Sales = "vw_Uni_Docket_MR_NET";
    //        }
    //        else if (Npos3 > 0 || Npos4 > 0)
    //        {
    //            View_Sales = "vw_Uni_Docket_Bill_NET";
    //        }
    //        else if (Npos3 > 0)
    //        {
    //            View_Sales = "vw_Uni_Docket_Bill_NET";
    //        }
    //        else if (Npos4 > 0)
    //        {
    //            View_Sales = "vw_Uni_Docket_Bill_NET";
    //        }
    //        else
    //        {
    //            View_Sales = "vw_Uni_Docket_NET";
    //        }
    //    }
        


    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //    dtfi.DateSeparator = "/";

    //    {
    //        dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
    //        dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
    //    }



    //    da.SelectCommand.Parameters.Add("@FromDt", SqlDbType.DateTime).Value = dtFrom;
    //    da.SelectCommand.Parameters.Add("@ToDt", SqlDbType.DateTime).Value = dtTo;
    //    da.SelectCommand.Parameters.Add("@Selectitem", SqlDbType.VarChar).Value = select2;
    //    da.SelectCommand.Parameters.Add("@paybas", SqlDbType.VarChar).Value = DDLPaybas.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@trnmod", SqlDbType.VarChar).Value = DDLMode.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@type", SqlDbType.VarChar).Value = DDLType.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@docklist", SqlDbType.VarChar).Value = TextDockets.Text;
    //    da.SelectCommand.Parameters.Add("@Select_view", SqlDbType.VarChar).Value = View_Sales;

    //    DataSet ds = new DataSet();
    //    DataSet ds1 = new DataSet();
    //    if (CurrentPage.Text == "")
    //    {
    //        CurrentPage.Text = "1";
    //    }
    //    else
    //    {
    //        CurrentPage.Text = _currentPageNumber.ToString();
    //    }
        
    //    da.Fill( ds, ((Convert.ToInt32(CurrentPage.Text) -1) * dgSales.PageSize), dgSales.PageSize,"Temp");
    //    da.Fill(ds1);

    //    decimal _totalRecords = ds1.Tables[0].Rows.Count;
    //    decimal _totalPages = Convert.ToDecimal(_totalRecords / dgSales.PageSize);
    //    //Convert.ToDecimal( _totalRecords / dgSales.PageSize,
    //    TotalPages.Text = (System.Math.Ceiling(Convert.ToDecimal(_totalRecords / dgSales.PageSize))).ToString();

    //    dgSales.DataSource = ds;
    //    dgSales.DataBind();
    //    conn.Close();

    //    //CurrentPage.Text = _currentPageNumber.ToString();
    //    CurrentPage.Text = _currentPageNumber.ToString();

    //    if (!Page.IsPostBack)
    //    {
    //        //_totalPages = _totalRecords / dgSales.PageSize;
    //        //TotalPages.Text = (System.Math.Ceiling(_totalPages)).ToString();
    //        TotalPages.Text = (System.Math.Ceiling(_totalPages)).ToString();
    //    }
    //    else
    //    {
    //       // _totalPages = Convert.ToInt32(TotalPages.Text);
    //       /// _totalPages = Double.Parse(TotalPages.Text);
    //    }

    //    if (_currentPageNumber == 1)
    //    {
    //        PreviousPage.Enabled = false;

    //        if (_totalPages > 1)
    //        {
    //            NextPage.Enabled = true;
    //        }
    //        else
    //        {
    //            NextPage.Enabled = false;
    //        }
    //    }
    //    else
    //    {
    //        PreviousPage.Enabled = true;

    //        if (_currentPageNumber == _totalPages)
    //        {
    //            NextPage.Enabled = false;
    //        }
    //        else
    //        {
    //            NextPage.Enabled = true;
    //        }
    //    }


    //}
    //protected void btnXLS_Click(object sender, EventArgs e)
    //{

    //}
    //protected void btnPrint_Click(object sender, EventArgs e)
    //{

    //}

    //protected void pgChange(object sender,DataGridCommandEventArgs e)
    //{
    //    dgSales.Page = e.NewPageIndex;
    //    BindGrid();
         
    //}

    //protected void pgChange(object sender, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
   
    //{
    //    dgSales.CurrentPageIndex = e.NewPageIndex;
    //    BindGrid();
    //    //dgSales.DataBind();
         
    //}

    //protected void dgSales_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //  //  string sConn;
    //  //  SqlConnection conn;
    //  // sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PRRL_TEST;";
    //  ////  sConn = "data source=202.87.45.71;UID=sa;PWD=ecfy$@p@$$;Database=RCPL_ver2_live;";
    //  //  conn = new SqlConnection(sConn);
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string sql = "webx_sales_register";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    sqlcmd.CommandType = CommandType.StoredProcedure;

    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

    //    System.DateTime righnow = System.DateTime.Today;
    //    string strrightnow = righnow.ToString("dd/MM/yyyy");

    //    DateTime dtFrom = new DateTime();
    //    DateTime dtTo = new DateTime();

    //    string select2 = "";
    //    //StringBuilder select2 = new StringBuilder();


    //    foreach (ListItem li in CheckBoxList1.Items)
    //    {
    //        if (li.Selected == true)
    //        {
    //            // select2 = select2 += "," + select2.Append(li.Value);
    //            select2 = select2 += "," + li.Value.ToString();
    //            //select2.ToString();
    //        }
    //    }

    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //    dtfi.DateSeparator = "/";

    //    {
    //        dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
    //        dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
    //    }



    //    da.SelectCommand.Parameters.Add("@FromDt", SqlDbType.DateTime).Value = dtFrom;
    //    da.SelectCommand.Parameters.Add("@ToDt", SqlDbType.DateTime).Value = dtTo;
    //    da.SelectCommand.Parameters.Add("@Selectitem", SqlDbType.VarChar).Value = select2;
    //    da.SelectCommand.Parameters.Add("@paybas", SqlDbType.VarChar).Value = DDLPaybas.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@trnmod", SqlDbType.VarChar).Value = DDLMode.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@type", SqlDbType.VarChar).Value = DDLType.SelectedItem.Value;
    //    da.SelectCommand.Parameters.Add("@docklist", SqlDbType.VarChar).Value = TextDockets.Text;


    //    DataSet ds = new DataSet();
    //    da.Fill(ds);

     

    //    dgSales.DataSource = ds;
    //    dgSales.DataBind();
    //    conn.Close();
    //}
    //ChkAmtChrgDtlAll_Checked
    protected void ChkAmtChrgAll_Checked(object sender, EventArgs e)
    {
        bool Flag = ChkAmtChrgAll.Checked;
        for (int i = 0; i < ChkAmtChrgDtl.Items.Count; i++)
        {
            ChkAmtChrgDtl.Items[i].Selected = Flag;
        }
    }
    protected void chkAll_OnCheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox111.Checked;
        for (int i = 0; i < CheckBoxList1.Items.Count; i++)
        {
            CheckBoxList1.Items[i].Selected = Flag;
        }
    }    
        protected void chkAll_OnCheckedChanged2(object sender, EventArgs e)
    {
        bool Flag = CheckBox112.Checked;
        for (int i = 0; i < CheckBoxList2.Items.Count ; i++)
        {
            CheckBoxList2.Items[i].Selected = Flag;
        }
    }
}

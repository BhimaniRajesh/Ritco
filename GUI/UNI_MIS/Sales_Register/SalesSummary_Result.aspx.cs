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
using System.Globalization;

public partial class GUI_UNI_MIS_Sales_Register_SalesSummary_Result : System.Web.UI.Page
{

    public static string strDateRange;
    public static string strro;
    public static string strloc;
    public static string strcust;
    public static string strflow;
    public static string strdt;
    //protected Int32 _currentPageNumber = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        //dgSales
      //  SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //Response.ContentType
        //Response.ContentType = "application/vnd.ms-excel";
		//Response.AddHeader("content-disposition","attachment; filename=Location_Report.xls");
        BindGrid();


    }

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

    private void BindGrid()
    {
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string sql = "webx_sales_register";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlCommand sqlcmd = new SqlCommand();

        sqlcmd.Connection = conn;
        sqlcmd.CommandType = CommandType.StoredProcedure;
        sqlcmd.CommandText = "webx_sales_register";

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        

        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

       //string select2 = "";
        
       

       // foreach (ListItem li in CheckBoxList1.Items)
       // {
       //     if (li.Selected == true)
       //     {
               
       //       select2 = select2 += "," + li.Value.ToString();
                
       //     }
       // }

       // string select3 = "";
        


       // foreach (ListItem li1 in CheckBoxList2.Items)
       // {
       //     if (li1.Selected == true)
       //     {
       //         // select2 = select2 += "," + select2.Append(li.Value);
       //         select3 = select3 += "," + li1.Value.ToString();
       //         //select2.ToString();
       //     }
       // }

       // string View_Sales = "";
       // string select_list = "";

       // select_list = select2 + "," + select3;

       // int Npos1 = select_list.IndexOf("MRSNo");
       // int Npos2 = select_list.IndexOf("MRSDate");
       // int Npos3 = select_list.IndexOf("BillNo");
       // int Npos4 = select_list.IndexOf("billdate");
       // Response.Write("<br> abNpos1cd : " + Npos1);
       // //Response.End;
       // if (Npos1 == 0 && Npos2 == 0 && Npos3 == 0 && Npos4 == 0 )
       // {
       //     View_Sales = "vw_Uni_Docket_NET";
       // }
       // else 
       // {
       //     if (Npos1 > 0 || Npos2 > 0)
       //     {
       //         View_Sales = "vw_Uni_Docket_MR_NET";
       //     }
       //     else if(Npos1 > 0 )
       //     {
       //         View_Sales = "vw_Uni_Docket_MR_NET";
       //     }
       //     else if (Npos2 > 0 )
       //     {
       //         View_Sales = "vw_Uni_Docket_MR_NET";
       //     }
       //     else if (Npos3 > 0 || Npos4 > 0)
       //     {
       //         View_Sales = "vw_Uni_Docket_Bill_NET";
       //     }
       //     else if (Npos3 > 0)
       //     {
       //         View_Sales = "vw_Uni_Docket_Bill_NET";
       //     }
       //     else if (Npos4 > 0)
       //     {
       //         View_Sales = "vw_Uni_Docket_Bill_NET";
       //     }
       //     else
       //     {
       //         View_Sales = "vw_Uni_Docket_NET";
       //     }
       // }
        


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        //{

        //    dtFrom = Convert.ToDateTime(dtFrom1, dtfi);
        //    dtTo = Convert.ToDateTime(dtTo1, dtfi);
        //}

        string fdate = Request.QueryString.Get("dtFrom");
        string tdate = Request.QueryString.Get("dtTo");

        Array str, str1;

        //fdate = Request.QueryString["FrmDate"];
        //tdate = Request.QueryString["ToDate"];
        str = fdate.Split('/');
        str1 = tdate.Split('/');
        //((string[])(str))[0]
        string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
        string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
        //CultureInfo a = CultureInfo.CurrentCulture;
        //TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);

        string dtFrom, dtTo;
        dtFrom = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        dtTo = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        

        string select_list = Request.QueryString.Get("select_list");
        string View_Sales = Request.QueryString.Get("View_Sales");

        string Paybas = Request.QueryString.Get("Paybas");
        string trnmod = Request.QueryString.Get("trnmod");
        string SDDLType = Request.QueryString.Get("SDDLType");
        string dockectlist = Request.QueryString.Get("dockectlist");
        string StatusType = Request.QueryString.Get("StatusType");
        string custcd1 = Request.QueryString.Get("custcd1");
        string ro = Request.QueryString.Get("ro");
        string ro_to = Request.QueryString.Get("ro_to");
        string lo = Request.QueryString.Get("lo");
        string lo_to = Request.QueryString.Get("lo_to");

        if (ro == "")
        {
            ro = "All";
        }
        if (ro_to == "")
        {
            ro_to = "All";
        }

        strDateRange = dtFrom + " - " + dtTo;
        lblseldet.Text = strDateRange;
        lblro.Text = ro + " - " + ro_to;
        lblloc.Text = lo + " - " + lo_to;
        
        //da.SelectCommand.Parameters.Add("@FromDt", SqlDbType.DateTime).Value = dtFrom.ToString();
        sqlcmd.Parameters.AddWithValue("@FromDt", dtFrom);
        sqlcmd.Parameters.AddWithValue("@ToDt", dtTo);
        sqlcmd.Parameters.AddWithValue("@fromRo", ro);
        sqlcmd.Parameters.AddWithValue("@toRo", ro_to);
        sqlcmd.Parameters.AddWithValue("@fromloc", lo);
        sqlcmd.Parameters.AddWithValue("@toloc", lo_to);

        sqlcmd.Parameters.AddWithValue("@Selectitem", select_list);
        sqlcmd.Parameters.AddWithValue("@paybas", Paybas);
        sqlcmd.Parameters.AddWithValue("@trnmod", trnmod);
        sqlcmd.Parameters.AddWithValue("@type", SDDLType);
        sqlcmd.Parameters.AddWithValue("@status", StatusType);
        sqlcmd.Parameters.AddWithValue("@custcode", custcd1);
        sqlcmd.Parameters.AddWithValue("@docklist", dockectlist);
        sqlcmd.Parameters.AddWithValue("@Select_view", View_Sales);
      
        //DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
        //if (CurrentPage.Text == "")
        //{
        //    CurrentPage.Text = "1";
        //}
        //else
        //{
        //    CurrentPage.Text = _currentPageNumber.ToString();
        //}
        
        //da.Fill( ds, ((Convert.ToInt32(CurrentPage.Text) -1) * dgSales.PageSize), dgSales.PageSize,"Temp");
        da.Fill(ds1);

        //decimal _totalRecords = ds1.Tables[0].Rows.Count;
        //decimal _totalPages = Convert.ToDecimal(_totalRecords / dgSales.PageSize);
        ////Convert.ToDecimal( _totalRecords / dgSales.PageSize,
        //TotalPages.Text = (System.Math.Ceiling(Convert.ToDecimal(_totalRecords / dgSales.PageSize))).ToString();

        dgSales.DataSource = ds1;
        dgSales.DataBind();
        conn.Close();

        //CurrentPage.Text = _currentPageNumber.ToString();
       // CurrentPage.Text = _currentPageNumber.ToString();

        //if (!Page.IsPostBack)
        //{
        //    //_totalPages = _totalRecords / dgSales.PageSize;
        //    //TotalPages.Text = (System.Math.Ceiling(_totalPages)).ToString();
        //    TotalPages.Text = (System.Math.Ceiling(_totalPages)).ToString();
        //}
        //else
        //{
        //   // _totalPages = Convert.ToInt32(TotalPages.Text);
        //   /// _totalPages = Double.Parse(TotalPages.Text);
        //}

        //if (_currentPageNumber == 1)
        //{
        //    PreviousPage.Enabled = false;

        //    if (_totalPages > 1)
        //    {
        //        NextPage.Enabled = true;
        //    }
        //    else
        //    {
        //        NextPage.Enabled = false;
        //    }
        //}
        //else
        //{
        //    PreviousPage.Enabled = true;

        //    if (_currentPageNumber == _totalPages)
        //    {
        //        NextPage.Enabled = false;
        //    }
        //    else
        //    {
        //        NextPage.Enabled = true;
        //    }
        //}

    }
    protected void pgChange(object sender, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        dgSales.CurrentPageIndex = e.NewPageIndex;
        BindGrid();
        //dgSales.DataBind();

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("content-disposition", "attachment; filename=Location_Report.xls");
        //BindGrid();
        string final;

        //string dtFrom, dtTo;
        //dtFrom = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
       // dtTo = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];

        string dtFrom = Request.QueryString.Get("dtFrom");
        string dtTo = Request.QueryString.Get("dtTo");

        string select_list = Request.QueryString.Get("select_list");
        string View_Sales = Request.QueryString.Get("View_Sales");

        string Paybas = Request.QueryString.Get("Paybas");
        string trnmod = Request.QueryString.Get("trnmod");
        string SDDLType = Request.QueryString.Get("SDDLType");
        string dockectlist = Request.QueryString.Get("dockectlist");
        string StatusType = Request.QueryString.Get("StatusType");
        string custcd1 = Request.QueryString.Get("custcd1");
        string ro = Request.QueryString.Get("ro");
        string ro_to = Request.QueryString.Get("ro_to");
        string lo = Request.QueryString.Get("lo");
        string lo_to = Request.QueryString.Get("lo_to");
        final = "?ro=" + ro;
        final += "&ro_to=" + ro_to;
        final += "&lo=" + lo;
        final += "&lo_to=" + lo_to;
        final += "&dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;
        final += "&select_list=" + select_list;
        final += "&View_Sales=" + View_Sales;
        final += "&Paybas=" + Paybas;
        final += "&trnmod=" + trnmod;
        final += "&SDDLType=" + SDDLType;
        final += "&StatusType=" + StatusType;
        final += "&dockectlist=" + dockectlist;
        final += "&custcd1=" + custcd1;
        Response.Redirect("SalesSummary_Result_xls.aspx" + final);

    }


    protected void dgSales_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        ////if (e.Item.ItemType = DataControlFieldHeaderCell)
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        //if (e.Item.ItemType == DataControlRowType.Header)
        //{
        //    if(DataControlRowType.Header.ToString()=="SCHG01")
        //    {
        //        String sql_abc = "select codedesc from Webx_Master_General where codetype='CHG' and statuscode='Y' and codeid='" + DataControlRowType.Header.ToString() + "'";
        //        SqlCommand cmd33 = new SqlCommand(sql_abc, cn);
        //        SqlDataReader dr3 = cmd33.ExecuteReader();
        //    }
        //}

        //conn.Close();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            dgSales.AllowPaging = false;
            dgSales.BorderWidth = 1;
            dgSales.CssClass = "blackfnt";
            dgSales.Font.Size = 8;
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=ServiceTax_Regester.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            BindGrid();
            dgSales.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();

        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }
}

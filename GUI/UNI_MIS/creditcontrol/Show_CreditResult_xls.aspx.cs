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

public partial class DOC_FLOW_Show_DocFlow : System.Web.UI.Page
{


    public static string strDateRange;
    public static string strro;
    public static string strloc;
    public static string strcust;
    public static string strflow;
    public static string strdt, rpt_type,pay_bas,pay_bas1;

    
    public static int intCurrentPageNo;
    public static int intPageSize = 10;



    //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
   // static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
 //  static string strConnection = "data source=202.87.45.71;UID=sa;PWD=ecfy$@p@$$;Database=RCPL_ver2_live";

    
    protected void Page_Load(object sender, EventArgs e)
    {
        //hypWelcome.NavigateUrl = "../../welcome.asp"; //Use an appropriate path

        //hypReport.Text = "Reports";
        //hypReport.NavigateUrl = "../reportmenu.asp"; //Use an appropriate path

        //hypFinance.Text = "Finance";
        //hypFinance.NavigateUrl = "../rpt_finance.asp"; //Use an appropriate path

        ////if (HIDCurrentPageNo.Value == "")
        //{
        //    HIDCurrentPageNo.Value = "1";
        //}

       // intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition", "attachment; filename=Credit_control.xls");


        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["DOCDate"].ToString();
            strro = Request.QueryString["RO"].ToString();
            if (strro == "-All-")
            {
                strro = "ALL";
            }
            strloc = Request.QueryString["Location"].ToString();
            if (strloc == "-All-")
            {
                strloc = "ALL";
            }
            strcust = Request.QueryString["Cust"].ToString();
            if (strcust == "")
            {
                strcust = "";
            }
            

            pay_bas = Request.QueryString["Paybasloc"].ToString();
            if (pay_bas == "-All-")
            {
                pay_bas = "ALL";
            }

            pay_bas1 = Request.QueryString["Paybascust"].ToString();
            if (pay_bas1 == "-All-")
            {
                pay_bas1 = "ALL";
            }


        }


        strflow = Request.QueryString["Flow"].ToString();
        rpt_type = Request.QueryString["rpt_type"].ToString();
        //Response.Write("strflow : " + strflow);
        //Response.Write("rpt_type : " + rpt_type);
       // Response.End();
       // strdt = Request.QueryString["DateType"].ToString();
        lblseldet.Text = strDateRange;
        lblro.Text = strro;
        lblloc.Text = strloc;
        lblcust.Text = strcust;
        //string s1, s2;
        //if (strdt == "dockdt")
        //{
        //    s1 = lbldt.Text;
        //    lbldt.Text = "Booking"+s1;
        //}
        //else
        //{
        //    s1 = lbldt.Text;
        //    lbldt.Text = "Delivry"+s1;
        //}



        DisplayDocFlow();



    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        if (strflow == "0")
        {
            if (rpt_type == "1")
            {
                GridView1.PageIndex = e.NewPageIndex;
            }
            else
            {
                GridView2.PageIndex = e.NewPageIndex;
            }
        }

        else
        {
            GridView2.PageIndex = e.NewPageIndex;
        }

        
        DisplayDocFlow();


    }



    //protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    //{
    //    switch (e.CommandName)
    //    {
    //        case "First":
    //            intCurrentPageNo = 1;
    //            break;
    //        case "Last":
    //            intCurrentPageNo = Int32.Parse(TotalPages.Text);
    //            break;
    //        case "Next":
    //            intCurrentPageNo = Int32.Parse(CurrentPage.Text) + 1;
    //            break;
    //        case "Prev":
    //            intCurrentPageNo = Int32.Parse(CurrentPage.Text) - 1;
    //            break;
    //    }

    //    //HIDCurrentPageNo.Value = intCurrentPageNo.ToString();

    //  //  DisplayDocFlow();

    //}

    private void DisplayDocFlow()
    {
        // SqlConnection sqlConn = new SqlConnection(strConnection);

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        if (strflow == "0")
        {
            if (rpt_type == "1")
            {
                sqlCommand.CommandText = "webx_Creadit_Control_Collected";
                lblflow.Text = "Location Wise - At To be collected ";

                string[] strArrDtFromTo = strDateRange.Split('-');
                sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
                sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
                sqlCommand.Parameters.AddWithValue("@RO", strro);
                sqlCommand.Parameters.AddWithValue("@ORGNCD", strloc);
                sqlCommand.Parameters.AddWithValue("@Paybas", pay_bas1);
                sqlCommand.Parameters.AddWithValue("@CSGNCD", strcust);

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

                DataSet ds = new DataSet();

                sqlDA.Fill(ds);

                GridView1.DataSource = ds;
                GridView1.DataBind();


                GridView1.Visible = true;



            }
            else
            {
                sqlCommand.CommandText = "webx_Creadit_Control_Gentnerated";
                lblflow.Text = "Location Wise - At Generated";
                string[] strArrDtFromTo = strDateRange.Split('-');
                sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
                sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
                sqlCommand.Parameters.AddWithValue("@RO", strro);
                sqlCommand.Parameters.AddWithValue("@ORGNCD", strloc);
                sqlCommand.Parameters.AddWithValue("@Paybas", pay_bas1);
                sqlCommand.Parameters.AddWithValue("@CSGNCD", strcust);

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

                DataSet ds = new DataSet();

                sqlDA.Fill(ds);

                GridView2.DataSource = ds;
                GridView2.DataBind();


                GridView2.Visible = true;


            }

        }
        else
        {
            sqlCommand.CommandText = "webx_Creadit_Control_Gentnerated_cust";
            lblflow.Text = "Customer Wise";

            string[] strArrDtFromTo = strDateRange.Split('-');
            sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
            sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
            sqlCommand.Parameters.AddWithValue("@RO", strro);
            sqlCommand.Parameters.AddWithValue("@ORGNCD", strloc);
            sqlCommand.Parameters.AddWithValue("@Paybas", pay_bas);
            sqlCommand.Parameters.AddWithValue("@CSGNCD", strcust);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet ds = new DataSet();

            sqlDA.Fill(ds);

            GridView2.DataSource = ds;
            GridView2.DataBind();


            GridView2.Visible = true;


        }
    }


        
        //Managing Date Range for input parameters to SP
       
        
       



      

        //try
        //{

        //    sqlDA.Fill(ds);

        //    GridView1.Visible = true;

        //    GridView1.DataSource = ds;
        //    GridView1.DataBind();

        //}
        //catch (Exception e)
        //{
        //    lblcust.Text = e.Message;
        //}


    //         yet to Comp


//, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtDOCFLOW");
//        sqlDA.Fill(dsPages);
   


        



    
    protected void btnXML_ServerClick(object sender, EventArgs e)
    {
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=test.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        //Select the appropriate control
       // GridView1.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();
   
    }


    public void rpt(object sender, RepeaterItemEventArgs sa)
    {

        if (sa.Item.ItemType == ListItemType.Item)
        {



            HyperLink h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11;
            h1 = (HyperLink)sa.Item.FindControl("Hyperlink1");
            h2 = (HyperLink)sa.Item.FindControl("Hyperlink2");
            h3 = (HyperLink)sa.Item.FindControl("Hyperlink3");
            h4 = (HyperLink)sa.Item.FindControl("Hyperlink4");
            h5 = (HyperLink)sa.Item.FindControl("Hyperlink5");
            h6 = (HyperLink)sa.Item.FindControl("Hyperlink6");
            h7 = (HyperLink)sa.Item.FindControl("Hyperlink7");
            h8 = (HyperLink)sa.Item.FindControl("Hyperlink8");
            h9 = (HyperLink)sa.Item.FindControl("Hyperlink9");
            h10 = (HyperLink)sa.Item.FindControl("Hyperlink10");
            h11 = (HyperLink )sa.Item.FindControl("Hyperlink11");
            if (h1.Text == "0")
            {
                h1.NavigateUrl = "";
                h1.Font.Underline = false;
            }
            if (h2.Text == "0")
            {
                h2.NavigateUrl = "";
                h2.Font.Underline = false;
            }
            if (h3.Text == "0")
            {
                h3.NavigateUrl = "";
                h3.Font.Underline = false;
            }
            if (h4.Text == "0")
            {
                h4.NavigateUrl = "";
                h4.Font.Underline = false;
            }
            if (h5.Text == "0")
            {
                h5.NavigateUrl = "";
                h5.Font.Underline = false;
            }
            if (h6.Text == "0")
            {
                h6.NavigateUrl = "";
                h6.Font.Underline = false;
            }
            if (h7.Text == "0")
            {
                h7.NavigateUrl = "";
                h7.Font.Underline = false;
            }
            if (h8.Text == "0")
            {
                h8.NavigateUrl = "";
                h8.Font.Underline = false;
            }
            if (h9.Text == "0")
            {
                h9.NavigateUrl = "";
                h9.Font.Underline = false;
            }
            if (h10.Text == "0")
            {
                h10.NavigateUrl = "";
                h10.Font.Underline = false;
            }
            
            
            if (h11.Text == "0")
            {
                h11.NavigateUrl = "";
                h11.Font.Underline = false;
            }
        }







    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton l1, l2, l3;
            l1 = (LinkButton)e.Row.FindControl("tot_buss");
            l2 = (LinkButton)e.Row.FindControl("tot_coll");
            l3 = (LinkButton)e.Row.FindControl("Tot_OS");

            l3.Text = Convert.ToString(Convert.ToDecimal(l1.Text) - Convert.ToDecimal(l2.Text));
            if (l1.Text == "0.00")
            {
                l1.Visible = false;
                e.Row.Cells[2].CssClass = "blackfnt";
                e.Row.Cells[2].Text = "0";
            }
            if (l2.Text == "0.00")
            {
                l2.Visible = false;
                e.Row.Cells[3].CssClass = "blackfnt";
                e.Row.Cells[3].Text = "0";
            }
            if (l3.Text == "0.00")
            {
                l3.Visible = false;
                e.Row.Cells[4].CssClass = "blackfnt";
                e.Row.Cells[4].Text = "0";
            }
            

            //LinkButton topay1, topay2, topay3;
            //topay1 = (LinkButton)e.Row.FindControl("ToPay_buss");
            //topay2 = (LinkButton)e.Row.FindControl("ToPay_Coll");
            //topay3 = (LinkButton)e.Row.FindControl("ToPay_OS");

            //topay3.Text = Convert.ToString(Convert.ToDecimal(topay1.Text) - Convert.ToDecimal(topay2.Text));

            LinkButton topay1, topay2, topay3, topay4, topay5;
             topay1 = (LinkButton)e.Row.FindControl("ToPay_buss");
            topay2 = (LinkButton)e.Row.FindControl("ToPay_Coll");
            topay3 = (LinkButton)e.Row.FindControl("ToPay_OS");
            topay4 = (LinkButton)e.Row.FindControl("ToPay_mrnotmade");
            topay5 = (LinkButton)e.Row.FindControl("ToPay_mrmade");

            topay3.Text = Convert.ToString(Convert.ToDecimal(topay1.Text) - Convert.ToDecimal(topay2.Text));

            if (topay1.Text == "0.00")
            {
                topay1.Visible = false;
                e.Row.Cells[5].CssClass = "blackfnt";
                e.Row.Cells[5].Text = "0";
            }

            if (topay4.Text == "0.00")
            {
                topay2.Visible = false;
                e.Row.Cells[6].CssClass = "blackfnt";
                e.Row.Cells[6].Text = "0";
            }

            if (topay5.Text == "0.00")
            {
                topay5.Visible = false;
                e.Row.Cells[7].CssClass = "blackfnt";
                e.Row.Cells[7].Text = "0";
            }


            if (topay2.Text == "0.00")
            {
                topay2.Visible = false;
                e.Row.Cells[8].CssClass = "blackfnt";
                e.Row.Cells[8].Text = "0";
            }

            if (topay3.Text == "0.00")
            {
                topay3.Visible = false;
                e.Row.Cells[9].CssClass = "blackfnt";
                e.Row.Cells[9].Text = "0";
            }

            LinkButton TBB1, TBB2, TBB3;
            TBB1 = (LinkButton)e.Row.FindControl("TBB_buss");
            TBB2 = (LinkButton)e.Row.FindControl("TBB_Coll");
            TBB3 = (LinkButton)e.Row.FindControl("TBB_OS");

            TBB3.Text = Convert.ToString(Convert.ToDecimal(TBB1.Text) - Convert.ToDecimal(TBB2.Text));


            if (TBB1.Text == "0.00")
            {
                TBB1.Visible = false;
                e.Row.Cells[10].CssClass = "blackfnt";
                e.Row.Cells[10].Text = "0";
            }
            if (TBB2.Text == "0.00")
            {
                TBB2.Visible = false;
                e.Row.Cells[11].CssClass = "blackfnt";
                e.Row.Cells[11].Text = "0";
            }
            if (TBB3.Text == "0.00")
            {
                TBB3.Visible = false;
                e.Row.Cells[12].CssClass = "blackfnt";
                e.Row.Cells[12].Text = "0";
            }
            

            LinkButton BOD1, BOD2, BOD3;
            BOD1 = (LinkButton)e.Row.FindControl("BOD_buss");
            BOD2 = (LinkButton)e.Row.FindControl("BOD_Coll");
            BOD3 = (LinkButton)e.Row.FindControl("BOD_OS");

            BOD3.Text = Convert.ToString(Convert.ToDecimal(BOD1.Text) - Convert.ToDecimal(BOD2.Text));

            if (BOD1.Text == "0.00")
            {
                BOD1.Visible = false;
                e.Row.Cells[13].CssClass = "blackfnt";
                e.Row.Cells[13].Text = "0";
            }
            if (BOD2.Text == "0.00")
            {
                BOD2.Visible = false;
                e.Row.Cells[14].CssClass = "blackfnt";
                e.Row.Cells[14].Text = "0";
            }
            if (BOD3.Text == "0.00")
            {
                BOD3.Visible = false;
                e.Row.Cells[15].CssClass = "blackfnt";
                e.Row.Cells[15].Text = "0";
            }

            LinkButton National1, National2, National3, Nat11;
            Nat11 = (LinkButton)e.Row.FindControl("Nat_Buss1");
            National2 = (LinkButton)e.Row.FindControl("National_Coll");
            National3 = (LinkButton)e.Row.FindControl("National_OS");

            National3.Text = Convert.ToString(Convert.ToDecimal(Nat11.Text) - Convert.ToDecimal(National2.Text));

            if (Nat11.Text == "0.00")
            {
                Nat11.Visible = false;
                e.Row.Cells[16].CssClass = "blackfnt";
                e.Row.Cells[16].Text = "0";
            }
            if (National2.Text == "0.00")
            {
                National2.Visible = false;
                e.Row.Cells[17].CssClass = "blackfnt";
                e.Row.Cells[17].Text = "0";
            }
            if (National3.Text == "0.00")
            {
                National3.Visible = false;
                e.Row.Cells[18].CssClass = "blackfnt";
                e.Row.Cells[18].Text = "0";
            }


            LinkButton OCT1, OCT2, OCT3;
            OCT1 = (LinkButton)e.Row.FindControl("OCT_Buss");
            OCT2 = (LinkButton)e.Row.FindControl("OCT_Coll");
            OCT3 = (LinkButton)e.Row.FindControl("OCT_OS");

            OCT3.Text = Convert.ToString(Convert.ToDecimal(OCT1.Text) - Convert.ToDecimal(OCT2.Text));

            if (OCT1.Text == "0.00")
            {
                OCT1.Visible = false;
                e.Row.Cells[19].CssClass = "blackfnt";
                e.Row.Cells[19].Text = "0";
            }
            if (OCT2.Text == "0.00")
            {
                OCT2.Visible = false;
                e.Row.Cells[20].CssClass = "blackfnt";
                e.Row.Cells[20].Text = "0";
            }
            if (OCT3.Text == "0.00")
            {
                OCT3.Visible = false;
                e.Row.Cells[21].CssClass = "blackfnt";
                e.Row.Cells[21].Text = "0";
            }

            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************
            //oTableCell = new TableCell();
            //oTableCell.Text = " ABCD";
            //oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 22;
            ////oTableCell.RowSpan = 23;
            //oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Srno";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = " Location ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "Total";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";

            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 3;

            oTableCell = new TableCell();
            oTableCell.Text = "TO Pay To Be collected";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 5;


            oTableCell = new TableCell();
            oTableCell.Text = "TBB To Be collected";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 3;


            oTableCell = new TableCell();
            oTableCell.Text = "BOD To Be collected";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 3;


            oTableCell = new TableCell();
            oTableCell.Text = "National To Be collected";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 3;


             oTableCell = new TableCell();
             oTableCell.Text = "Octroi bill";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 3;


            oGridViewRow.Cells.Add(oTableCell);


            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Buss.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Coll.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "O/S";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Buss.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "MR Not Made";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            


            oTableCell1 = new TableCell();
            oTableCell1.Text = "MR Made";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Coll.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "O/S";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Billed";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Coll.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "O/S";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Billed";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Coll.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "O/S";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Billed";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Coll.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "O/S";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Billed";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Coll.";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "O/S";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************
            
        }
    }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton l1, l2, l3;
                l1 = (LinkButton)e.Row.FindControl("TotG_buss");
                l2 = (LinkButton)e.Row.FindControl("TotG_coll");
                l3 = (LinkButton)e.Row.FindControl("TotG_OS");

                l3.Text = Convert.ToString(Convert.ToDecimal(l1.Text) - Convert.ToDecimal(l2.Text));

                if (l1.Text == "0.00")
                {
                    l1.Visible = false;
                    e.Row.Cells[2].CssClass = "blackfnt";
                    e.Row.Cells[2].Text = "0";
                }
            if (l2.Text == "0.00")
            {
                l2.Visible = false;
                e.Row.Cells[3].CssClass = "blackfnt";
                e.Row.Cells[3].Text = "0";
            }
            if (l3.Text == "0.00")
            {
                l3.Visible = false;
                e.Row.Cells[4].CssClass = "blackfnt";
                e.Row.Cells[4].Text = "0";
            }
                LinkButton Paid1, Paid2, Paid3;
                Paid1 = (LinkButton)e.Row.FindControl("PaidG_buss");
                Paid2 = (LinkButton)e.Row.FindControl("PaidG_coll");
                Paid3 = (LinkButton)e.Row.FindControl("PaidG_OS");

                Paid3.Text = Convert.ToString(Convert.ToDecimal(Paid1.Text) - Convert.ToDecimal(Paid2.Text));

                if (Paid1.Text == "0.00")
                {
                    Paid1.Visible = false;
                    e.Row.Cells[5].CssClass = "blackfnt";
                    e.Row.Cells[5].Text = "0";
                }

                if (Paid2.Text == "0.00")
                {
                    Paid2.Visible = false;
                    e.Row.Cells[6].CssClass = "blackfnt";
                    e.Row.Cells[6].Text = "0";
                }

                if (Paid3.Text == "0.00")
                {
                    Paid3.Visible = false;
                    e.Row.Cells[7].CssClass = "blackfnt";
                    e.Row.Cells[7].Text = "0";
                }

                LinkButton topay1, topay2, topay3, topay4, topay5;
                topay1 = (LinkButton)e.Row.FindControl("ToPayG_buss");
                topay2 = (LinkButton)e.Row.FindControl("ToPayG_Coll");
                topay3 = (LinkButton)e.Row.FindControl("ToPayG_OS");
                topay4 = (LinkButton)e.Row.FindControl("ToPayG_mrnotmade");
                topay5 = (LinkButton)e.Row.FindControl("ToPayG_mrmade");

                topay3.Text = Convert.ToString(Convert.ToDecimal(topay1.Text) - Convert.ToDecimal(topay2.Text));

                if (topay1.Text == "0.00")
                {
                    topay1.Visible = false;
                    e.Row.Cells[8].CssClass = "blackfnt";
                    e.Row.Cells[8].Text = "0";
                }

                if (topay4.Text == "0.00")
                {
                    topay2.Visible = false;
                    e.Row.Cells[9].CssClass = "blackfnt";
                    e.Row.Cells[9].Text = "0";
                }

                if (topay5.Text == "0.00")
                {
                    topay3.Visible = false;
                    e.Row.Cells[10].CssClass = "blackfnt";
                    e.Row.Cells[10].Text = "0";
                }


                if (topay2.Text == "0.00")
                {
                    topay2.Visible = false;
                    e.Row.Cells[11].CssClass = "blackfnt";
                    e.Row.Cells[11].Text = "0";
                }

                if (topay3.Text == "0.00")
                {
                    topay3.Visible = false;
                    e.Row.Cells[12].CssClass = "blackfnt";
                    e.Row.Cells[12].Text = "0";
                }

                LinkButton TBB1, TBB2, TBB3, TBB4, TBB5;
                TBB1 = (LinkButton)e.Row.FindControl("TBBG_buss");
                TBB2 = (LinkButton)e.Row.FindControl("TBBG_Coll");
                TBB3 = (LinkButton)e.Row.FindControl("TBBG_OS");
                TBB4 = (LinkButton)e.Row.FindControl("TBBG_Unbilled");
                TBB5 = (LinkButton)e.Row.FindControl("TBBG_Billed");

                TBB3.Text = Convert.ToString(Convert.ToDecimal(TBB1.Text) - Convert.ToDecimal(TBB2.Text));

                if (TBB1.Text == "0.00")
                {
                    TBB1.Visible = false;
                    e.Row.Cells[13].CssClass = "blackfnt";
                    e.Row.Cells[13].Text = "0";
                }

                if (TBB4.Text == "0.00")
                {
                    TBB1.Visible = false;
                    e.Row.Cells[14].CssClass = "blackfnt";
                    e.Row.Cells[14].Text = "0";
                }

                if (TBB5.Text == "0.00")
                {
                    TBB1.Visible = false;
                    e.Row.Cells[15].CssClass = "blackfnt";
                    e.Row.Cells[15].Text = "0";
                }

                if (TBB2.Text == "0.00")
                {
                    TBB1.Visible = false;
                    e.Row.Cells[16].CssClass = "blackfnt";
                    e.Row.Cells[16].Text = "0";
                }

                if (TBB3.Text == "0.00")
                {
                    TBB1.Visible = false;
                    e.Row.Cells[17].CssClass = "blackfnt";
                    e.Row.Cells[17].Text = "0";
                }

                LinkButton BOD1, BOD2, BOD3, BOD4, BOD5;
                BOD1 = (LinkButton)e.Row.FindControl("BODG_buss");
                BOD2 = (LinkButton)e.Row.FindControl("BODG_Coll");
                BOD3 = (LinkButton)e.Row.FindControl("BODG_OS");
                BOD4 = (LinkButton)e.Row.FindControl("BODG_Unbilled");
                BOD5 = (LinkButton)e.Row.FindControl("BODG_Billed");


                BOD3.Text = Convert.ToString(Convert.ToDecimal(BOD1.Text) - Convert.ToDecimal(BOD2.Text));

                if (BOD1.Text == "0.00")
                {
                    BOD1.Visible = false;
                    e.Row.Cells[18].CssClass = "blackfnt";
                    e.Row.Cells[18].Text = "0";
                }

                if (BOD4.Text == "0.00")
                {
                    BOD4.Visible = false;
                    e.Row.Cells[19].CssClass = "blackfnt";
                    e.Row.Cells[19].Text = "0";
                }

                if (BOD5.Text == "0.00")
                {
                    BOD5.Visible = false;
                    e.Row.Cells[20].CssClass = "blackfnt";
                    e.Row.Cells[20].Text = "0";
                }

                if (BOD2.Text == "0.00")
                {
                    BOD2.Visible = false;
                    e.Row.Cells[21].CssClass = "blackfnt";
                    e.Row.Cells[21].Text = "0";
                }

                if (BOD3.Text == "0.00")
                {
                    BOD3.Visible = false;
                    e.Row.Cells[22].CssClass = "blackfnt";
                    e.Row.Cells[22].Text = "0";
                }


                LinkButton Nat1, Nat2, Nat3, Nat4, Nat5;
                Nat1 = (LinkButton)e.Row.FindControl("NatG_buss");
                Nat2 = (LinkButton)e.Row.FindControl("NatG_Coll");
                Nat3 = (LinkButton)e.Row.FindControl("NatG_OS");
                Nat4 = (LinkButton)e.Row.FindControl("NatG_Unbilled");
                Nat5 = (LinkButton)e.Row.FindControl("NatG_Billed");

                Nat3.Text = Convert.ToString(Convert.ToDecimal(Nat1.Text) - Convert.ToDecimal(Nat2.Text));

                if (Nat1.Text == "0.00")
                {
                    Nat1.Visible = false;
                    e.Row.Cells[23].CssClass = "blackfnt";
                    e.Row.Cells[23].Text = "0";
                }

                if (Nat4.Text == "0.00")
                {
                    Nat4.Visible = false;
                    e.Row.Cells[24].CssClass = "blackfnt";
                    e.Row.Cells[24].Text = "0";
                }

                if (Nat5.Text == "0.00")
                {
                    Nat5.Visible = false;
                    e.Row.Cells[25].CssClass = "blackfnt";
                    e.Row.Cells[25].Text = "0";
                }

                if (Nat2.Text == "0.00")
                {
                    Nat2.Visible = false;
                    e.Row.Cells[26].CssClass = "blackfnt";
                    e.Row.Cells[26].Text = "0";
                }

                if (Nat3.Text == "0.00")
                {
                    Nat3.Visible = false;
                    e.Row.Cells[27].CssClass = "blackfnt";
                    e.Row.Cells[27].Text = "0";
                }
                LinkButton OCT1, OCT2, OCT3;
                OCT1 = (LinkButton)e.Row.FindControl("OCTG_buss");
                OCT2 = (LinkButton)e.Row.FindControl("OCTG_Coll");
                OCT3 = (LinkButton)e.Row.FindControl("OCTG_OS");

                OCT3.Text = Convert.ToString(Convert.ToDecimal(OCT1.Text) - Convert.ToDecimal(OCT2.Text));

                if (OCT1.Text == "0.00")
                {
                    OCT1.Visible = false;
                    e.Row.Cells[28].CssClass = "blackfnt";
                    e.Row.Cells[28].Text = "0";
                }

                if (OCT2.Text == "0.00")
                {
                    OCT2.Visible = false;
                    e.Row.Cells[29].CssClass = "blackfnt";
                    e.Row.Cells[29].Text = "0";
                }

                if (OCT3.Text == "0.00")
                {
                    OCT3.Visible = false;
                    e.Row.Cells[30].CssClass = "blackfnt";
                    e.Row.Cells[30].Text = "0";
                }
                LinkButton OCTM1, OCTM2, OCTM3;
                OCTM1 = (LinkButton)e.Row.FindControl("OCTM_buss");
                OCTM2 = (LinkButton)e.Row.FindControl("OCTM_Coll");
                OCTM3 = (LinkButton)e.Row.FindControl("OCTM_OS");

                OCTM3.Text = Convert.ToString(Convert.ToDecimal(OCTM1.Text) - Convert.ToDecimal(OCTM2.Text));


                if (OCTM1.Text == "0.00")
                {
                    OCTM1.Visible = false;
                    e.Row.Cells[28].CssClass = "blackfnt";
                    e.Row.Cells[28].Text = "0";
                }

                if (OCTM2.Text == "0.00")
                {
                    OCTM2.Visible = false;
                    e.Row.Cells[29].CssClass = "blackfnt";
                    e.Row.Cells[29].Text = "0";
                }

                if (OCTM3.Text == "0.00")
                {
                    OCTM3.Visible = false;
                    e.Row.Cells[30].CssClass = "blackfnt";
                    e.Row.Cells[30].Text = "0";
                }


                GridView oGridView = (GridView)sender;
                // Label billamt = (Label)oGridView.FindControl("billamt");

                GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                TableCell oTableCell1 = new TableCell();
                //Add Department
                //for first row *************
                oTableCell = new TableCell();
                oTableCell.Text = " Srno";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "Costomer/ Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.RowSpan = 2;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "Total";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";

                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 3;

                oTableCell = new TableCell();
                oTableCell.Text = "Paid";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 3;

                oTableCell = new TableCell();
                oTableCell.Text = "TO Pay";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 5;

                oTableCell = new TableCell();
                oTableCell.Text = "TBB";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 5;

                oTableCell = new TableCell();
                oTableCell.Text = "BOD";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 5;

                oTableCell = new TableCell();
                oTableCell.Text = "National";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 5;

                oTableCell = new TableCell();
                oTableCell.Text = "Octroi Bill";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 3;

                oTableCell = new TableCell();
                oTableCell.Text = "Octroi MR";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.ColumnSpan = 3;


                oGridViewRow.Cells.Add(oTableCell);


                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
                oGridView.Controls[0].Controls.RemoveAt(1);
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //Build custom header.


                GridView oGridView = (GridView)sender;
                // Label billamt = (Label)oGridView.FindControl("billamt");

                GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

                TableCell oTableCell1 = new TableCell();
                //***************************
                //*****for second row *************

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Buss.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Buss.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);



                oTableCell1 = new TableCell();
                oTableCell1.Text = "Buss.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "MR Not Made";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "MR Made";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Buss.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "UnBilled";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Billed";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);
                oTableCell1 = new TableCell();
                oTableCell1.Text = "Buss.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "UnBilled";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Billed";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Buss.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "UnBilled";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Billed";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

               

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Billed";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "MR Made";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Coll.";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "O/S";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
                oGridViewRow1.CssClass = "bgbluegrey";
                //******************************************
            }
        }
}

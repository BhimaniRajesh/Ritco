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

public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strDateRange, strloc, strro, strlogininstence, strreptype, strmr, strparty, stramt, strtype;
    DataSet ds1 = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["strDateRange"].ToString();
            Session["dt"] = strDateRange;
            strloc = Request.QueryString["strloc"].ToString();
            strro = Request.QueryString["strro"].ToString();

            strmr = Request.QueryString["mr"].ToString();
            strparty = Request.QueryString["party"].ToString();
            strtype = Request.QueryString["type"].ToString();
            stramt = Request.QueryString["amt"].ToString();


            Button1.Visible = false;


        }


        // lables......


        //  global
        if (strloc == "")
        {
            strloc = "All";
        }
        if (stramt == "")
        {
            stramt = "0";
        }

        if (strparty == "")
        {
            strparty = "All";
        }

        if (strtype == "")
        {
            strtype = "All";
        }

        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblro.Text = strro;





        DipsplayReport();


    }


    public void DipsplayReport()
    {


        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt = strArrDtFromTo[0];
        string strtodt = strArrDtFromTo[1];
        string locval = "";
        string empval = "";
        string lival = "0";
        if (strloc != "")
        {
            lblloc.Text = "All";
            // locval = "and CURRBRCD=" + strloc;
        }


      //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");
        //SqlConnection conn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;");
          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "";


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_SVCTAX_REGISTER_new";


        sqlCommand.Parameters.AddWithValue("@DATEFROM", strfrmdt);
        sqlCommand.Parameters.AddWithValue("@DATEto", strtodt);
        sqlCommand.Parameters.AddWithValue("@CUSTCD", strparty);
        sqlCommand.Parameters.AddWithValue("@MRTYP", strtype);

        sqlCommand.Parameters.AddWithValue("@MRSTATUS", "All");
        sqlCommand.Parameters.AddWithValue("@MRAMT", stramt);
        sqlCommand.Parameters.AddWithValue("@MRBRCD", strloc);
        sqlCommand.Parameters.AddWithValue("@BOOKBRCD", strloc);

        sqlCommand.Parameters.AddWithValue("@DELBRCD", strloc);
        sqlCommand.Parameters.AddWithValue("@DOCNO", strmr);

        sqlCommand.Parameters.AddWithValue("@ro", strro);


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        DataSet ds = new DataSet();

        da.Fill(ds);



        GV_Booking.DataSource = ds;

        GV_Booking.DataBind();


        if (GV_Booking.Rows.Count != 0)
        {
            GV_Booking.ShowFooter = true;

            //GV_Booking.FooterRow.CssClass = "bgbluegrey";
            GV_Booking.FooterRow.CssClass = "blackfnt";
            GV_Booking.FooterRow.Font.Bold = true;


            GV_Booking.FooterRow.Cells[5].Text = "Total";



            Double c6 = 0;
            Double c7 = 0;
            Double c8 = 0;
            Double c9 = 0;
            Double c10 = 0;
            Double c11 = 0;
            Double c12 = 0;
            Double c13 = 0;
            Double c14 = 0;
            Double c15 = 0;
            Double c16 = 0;
            Double c17 = 0;
            Double c18 = 0;
            Double c19 = 0;
            Double c20 = 0;
            Double c21 = 0;
            Double c22 = 0;
            Double c23 = 0;

            Double d1 = 0;
            Double d2 = 0;
            Double d3 = 0;

            Double e1 = 0;
            Double e2 = 0;
            Double e3 = 0;

            Double f1 = 0;
            Double f2 = 0;
            Double f3 = 0;







            foreach (DataRow dr in ds.Tables[0].Rows)
            {

                if (dr[11] is DBNull)
                {
                }
                else
                {
                    c6 += Convert.ToDouble(dr[11].ToString());
                }


                if (dr[23] is DBNull)
                {
                }
                else
                {
                    c9 += Convert.ToDouble(dr[23].ToString());
                    d1 = Convert.ToDouble(dr[23].ToString());
                   
                }

                if (dr[24] is DBNull)
                {
                }
                else
                {

                    c10 += Convert.ToDouble(dr[24].ToString());
                    e1 = Convert.ToDouble(dr[24].ToString());
                }

                if (dr[25] is DBNull)
                {
                }
                else
                {

                    c11 += Convert.ToDouble(dr[25].ToString());
                    f1 = Convert.ToDouble(dr[25].ToString());
                }

                if (dr[32] is DBNull)
                {
                }
                else
                {

                    c12 += Convert.ToDouble(dr[32].ToString());
                    e3 = Convert.ToDouble(dr[32].ToString());
                   
                }
                if (dr[33] is DBNull)
                {
                }
                else
                {

                    c13 += Convert.ToDouble(dr[33].ToString());
                    f3 = Convert.ToDouble(dr[33].ToString());
                }
                if (dr[28] is DBNull)
                {
                }
                else
                {

                    c14 += Convert.ToDouble(dr[28].ToString());

                    d2 = Convert.ToDouble(dr[28].ToString());
                   
                    
                  
                }

                if (dr[29] is DBNull)
                {
                }
                else
                {

                    c15 += Convert.ToDouble(dr[29].ToString());
                    e2 = Convert.ToDouble(dr[29].ToString());
                }

                if (dr[30] is DBNull)
                {
                }
                else
                {

                    c16 += Convert.ToDouble(dr[30].ToString());
                    f2 = Convert.ToDouble(dr[30].ToString());
                }

                if (dr[31] is DBNull)
                {
                }
                else
                {

                    c17 += Convert.ToDouble(dr[31].ToString());
                    d3 = Convert.ToDouble(dr[31].ToString());

                }
                if (dr[34] is DBNull)
                {
                }
                else
                {

                    c21 += Convert.ToDouble(dr[34].ToString());

                }

                if (dr[35] is DBNull)
                {
                }
                else
                {

                    c22 += Convert.ToDouble(dr[35].ToString());

                }


                c18 += d1 + d2 + d3;

                c19 += e1 + e2 + e3;
                
                c20 += f1 + f2 + f3;






            }


            GV_Booking.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Center;
            GV_Booking.FooterRow.Cells[6].Text = c6.ToString("F2");




            GV_Booking.FooterRow.Cells[9].HorizontalAlign = HorizontalAlign.Center;
            GV_Booking.FooterRow.Cells[9].Text = c9.ToString("F2");


            GV_Booking.FooterRow.Cells[10].Text = c10.ToString("F2");
            GV_Booking.FooterRow.Cells[11].Text = c11.ToString("F2");
            GV_Booking.FooterRow.Cells[12].Text = c14.ToString("F2");


            GV_Booking.FooterRow.Cells[13].Text = c15.ToString("F2");
            GV_Booking.FooterRow.Cells[14].Text = c16.ToString("F2");
            GV_Booking.FooterRow.Cells[15].Text = c17.ToString("F2");

            GV_Booking.FooterRow.Cells[16].Text = c12.ToString("F2");
            GV_Booking.FooterRow.Cells[17].Text = c13.ToString("F2");
         
            GV_Booking.FooterRow.Cells[18].Text = c18.ToString("F2");

            GV_Booking.FooterRow.Cells[19].Text = c19.ToString("F2");

            GV_Booking.FooterRow.Cells[20].Text = c20.ToString("F2");
            GV_Booking.FooterRow.Cells[21].Text = c21.ToString("F2");
            GV_Booking.FooterRow.Cells[22].Text = c22.ToString("F2");

        }

        if (GV_Booking.Rows.Count == 0)
        {

        }
        if (GV_Booking.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;

        }



    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Booking.PageIndex = e.NewPageIndex;

        DipsplayReport();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Booking.PageCount;
        GV_Booking.PageIndex = i;

        DipsplayReport();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_Booking.PageIndex = 0;

        DipsplayReport();


    }






    public void CustomersGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department


            //for first row *************





            oTableCell = new TableCell();
            oTableCell.Text = "MR No.";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
           // oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = Session["DocketCalledAs"].ToString()+" No.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            //  oTableCell.BorderWidth = 2;
           // oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "MR Type ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Date ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            //  oTableCell.BorderWidth = 2;
           // oTableCell.BorderStyle = BorderStyle.Solid;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Party ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            // oTableCell.BorderWidth = 2;
       //     oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Branch ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            //  oTableCell.BorderWidth = 2;
         //   oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Amount ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            // oTableCell.BorderWidth = 2;
           // oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);




            oTableCell = new TableCell();
            oTableCell.Text = "Service Tax Rate  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            // oTableCell.BorderWidth = 2;
            //oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);




            oTableCell = new TableCell();
            oTableCell.Text = "Cess Rate  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            // oTableCell.BorderWidth = 2;
         //   oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);





            oTableCell = new TableCell();
            oTableCell.Text = Session["DocketCalledAs"].ToString();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
           // oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //  oTableCell.BorderWidth =2;
           // oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.ColumnSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Other Deduction  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 3;
            // oTableCell.BorderWidth = 2;
          //  oTableCell.BorderStyle = BorderStyle.Solid;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Other Charges  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
        //   oTableCell.BorderWidth = 2;
           // oTableCell.BorderStyle = BorderStyle.Solid;
            //oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Received ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            // oTableCell.BorderWidth = 2;
         //   oTableCell.BorderStyle = BorderStyle.Solid;
          //  oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "TDS Deduction  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
           // oTableCell.BorderWidth = 2;
            //oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Net Amt  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            // oTableCell.BorderWidth = 2;
         //   oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        //}

        //if (e.Row.RowType == DataControlRowType.Footer)
        //{
            //Build custom header.


         //  GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);

        //    TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Freight ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Service Tax ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Cess ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);




            oTableCell1 = new TableCell();
            oTableCell1.Text = "Freight ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Service Tax ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Cess ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);



            oTableCell1 = new TableCell();
            oTableCell1.Text = "Freight ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Service Tax ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Cess ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Freight ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Service Tax ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Cess ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
           // oGridViewRow1.BackColor = System.Drawing.Color.AliceBlue;
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************
        }




        if (e.Row.RowType == DataControlRowType.DataRow)
        {



            string s = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("dd MMM yyyy");


            e.Row.Cells[3].Text = s;

            e.Row.Cells[2].Text = GetMRType(Convert.ToInt16(e.Row.Cells[2].Text));

            Double frt = getint(e.Row.Cells[9].Text) + getint(e.Row.Cells[12].Text) + getint(e.Row.Cells[15].Text);
            e.Row.Cells[18].Text = Convert.ToString(frt);

            Double st = getint(e.Row.Cells[10].Text) + getint(e.Row.Cells[13].Text) + getint(e.Row.Cells[16].Text);
            e.Row.Cells[19].Text = Convert.ToString(st);


            Double cess = getint(e.Row.Cells[11].Text) + getint(e.Row.Cells[14].Text) + getint(e.Row.Cells[17].Text);
            e.Row.Cells[20].Text = Convert.ToString(cess);


            //  e.Row.Cells[7].Visible = false; 

            if (e.Row.Cells[7].Text == "&nbsp;")
            {
                e.Row.Cells[7].Text = "0.00";
            }

            if (e.Row.Cells[8].Text == "&nbsp;")
            {
                e.Row.Cells[8].Text = "0.00";
            }
            if (e.Row.Cells[9].Text == "&nbsp;")
            {
                e.Row.Cells[9].Text = "0.00";
            }
            if (e.Row.Cells[10].Text == "&nbsp;" || e.Row.Cells[10].Text == "0")
            {
                e.Row.Cells[10].Text = "0.00";
            }
            if (e.Row.Cells[11].Text == "&nbsp;")
            {
                e.Row.Cells[11].Text = "0.00";
            }
            if (e.Row.Cells[12].Text == "&nbsp;")
            {
                e.Row.Cells[12].Text = "0.00";
            }
            if (e.Row.Cells[13].Text == "&nbsp;")
            {
                e.Row.Cells[13].Text = "0.00";
            }
            if (e.Row.Cells[14].Text == "&nbsp;")
            {
                e.Row.Cells[14].Text = "0.00";
            }
            if (e.Row.Cells[15].Text == "&nbsp;")
            {
                e.Row.Cells[15].Text = "0.00";
            }
            if (e.Row.Cells[16].Text == "&nbsp;")
            {
                e.Row.Cells[16].Text = "0.00";
            }
            if (e.Row.Cells[17].Text == "&nbsp;")
            {
                e.Row.Cells[17].Text = "0.00";
            }

            if (e.Row.Cells[19].Text == "&nbsp;" || e.Row.Cells[19].Text == "0")
            {
                e.Row.Cells[19].Text = "0.00";
            }
            if (e.Row.Cells[20].Text == "&nbsp;" || e.Row.Cells[20].Text == "0")
            {
                e.Row.Cells[20].Text = "0.00";
            }




        }


    }




    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    private Double getint(string s)
    {
        Double s1;
        if (s == "&nbsp;")
            s1 = 0.00;
        else
            s1 = Convert.ToDouble(s);

        return s1;
    }

    private string GetMRType(int intMRTypeValue)
    {
        string strMRType = "";
        switch (intMRTypeValue)
        {
            case 1:
                strMRType = "Paid";
                break;
            case 2:
                strMRType = "TBB";
                break;
            case 3:
                strMRType = "To Pay";
                break;
            case 4:
                strMRType = "Misc.";
                break;
            case 5:
                strMRType = "Cancelled";
                break;
            case 6:
                strMRType = "Octroi";
                break;
            case 7:
                strMRType = "Supplimentry";
                break;
            case 8:
                strMRType = "Trial TBB";
                break;
        }

        return strMRType;
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
            GV_Booking.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=ServiceTax_Regester.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DipsplayReport();
            GV_Booking.RenderControl(hw);


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

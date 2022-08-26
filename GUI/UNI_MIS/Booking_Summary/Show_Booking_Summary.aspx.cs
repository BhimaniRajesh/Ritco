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

    public static string strDateRange, strloc, strro, strlogininstence, strreptype;
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
            Button1.Visible = false;
            

        }

       


        // lables......


      //  global
        if (strloc == "")
        {
            strloc = "All";
        }
        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblro.Text = strro;
       
       

       

        DipsplayReport();


    }

    public void DipsplayReport()
    {
        

        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt= strArrDtFromTo[0];
        string strtodt= strArrDtFromTo[1];
        string locval = "";
        string empval ="";
        string lival = "0";
        if (strloc != "")
        {
            lblloc.Text = "All";
            locval = "and CURRBRCD=" + strloc;
        }

         
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql="";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());

      
          conn.Open();

          SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection=conn;
        sqlCommand.CommandType=CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_booking_summary";

      
        
        
        
         sqlCommand.Parameters.AddWithValue("@startdate", strfrmdt);
        sqlCommand.Parameters.AddWithValue("@enddate", strtodt);
        sqlCommand.Parameters.AddWithValue("@ORGNCD", strloc);
        sqlCommand.Parameters.AddWithValue("@RO", strro);

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        DataSet ds = new DataSet();  
        
        da.Fill(ds);


        ds.Tables[0].Columns.Add("Sno");
        ds.Tables[0].Columns.Add("Loc");
           ds.Tables[0].Columns.Add("per1");
           ds.Tables[0].Columns.Add("per2");
           int sno = 1;
        int od, fd, td;
        double tdoc = 0;
        double tq = 0;
            double to = 0;
            double tf = 0;
            double tw = 0;
        string rl = "BMRO";
            //ds.Tables[0].Rows["report_loc"].ToString();

        foreach (DataRow dr in ds.Tables[0].Rows)
        {




            dr["Sno"] = sno;
            sno++;
            
            dr["Loc"] = dr["loccode"].ToString() + " : " + dr["locname"].ToString();

           
         od = Convert.ToInt16(dr["Operdkt"]);
         td = Convert.ToInt16(dr["Findkt"]);
         fd = Convert.ToInt16(dr["totdkt"]);

         if (td == 0)
         {

         }
         else
         {
             
         

           dr["per2"] =   Convert.ToDouble(fd * (100 / td));
           dr["per1"] =   Convert.ToDouble(((od + fd) / td) * 100);


         }

          
         if (dr["report_loc"].ToString() == rl)
         {
             tdoc += Convert.ToDouble(dr["totdkt"]);
             tq += Convert.ToDouble(dr["Quickdkt"]);
             to += Convert.ToDouble(dr["Operdkt"]);
             tw += Convert.ToDouble(dr["TotalChgWt"]);



         }
         else
         {

             sno = 1;
         

         }

         rl = dr["report_loc"].ToString();



        }

        GridViewHelper helper = new GridViewHelper(this.GV_Booking);
        string[] cols = new string[1];
        cols[0] = "report_loc";
          //cols[1] = "ShipName";
         // cols[0].cs
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        helper.RegisterSummary("totdkt", SummaryOperation.Sum);
        helper.RegisterSummary("Quickdkt", SummaryOperation.Sum);
        helper.RegisterSummary("Operdkt", SummaryOperation.Sum);
        helper.RegisterSummary("Findkt", SummaryOperation.Sum);
        helper.RegisterSummary("TotalChgWt", SummaryOperation.Sum);


        helper.RegisterSummary("totdkt", SummaryOperation.Sum, "report_loc");
       helper.RegisterSummary("Quickdkt", SummaryOperation.Sum, "report_loc");
       helper.RegisterSummary("Operdkt", SummaryOperation.Sum, "report_loc");
       helper.RegisterSummary("Findkt", SummaryOperation.Sum, "report_loc");
       helper.RegisterSummary("TotalChgWt", SummaryOperation.Sum, "report_loc");
        helper.GroupSummary += new GroupEvent(helper_GroupSummary);

       // helper.ApplyGroupSort();
         
        GV_Booking.DataSource=ds;

        ds1 = ds;
        


        GV_Booking.DataBind();

        if (GV_Booking.Rows.Count == 0)
        {
           
        }
        if (GV_Booking.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;

        }
       
        
        
       



 





    }
    private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    {
        row.Cells[0].Font.Bold = true;
        //row.Cells[1].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].Text = "Total";
        row.Cells[0].CssClass = "bgbluegrey";
        row.Cells[0].BackColor = System.Drawing.Color.White;
        row.BackColor = System.Drawing.Color.White;
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
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
          //  row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
            row.Font.Name = "blackfnt";
            row.BackColor = System.Drawing.Color.White;
            row.Font.Bold = true;
            row.CssClass = "blackfnt";





            //row.CssClass = "blackfnt";
            //row.Cells[0].Font.Bold = true;
            //row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            //row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;


        }
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
            oTableCell.Text = " Sr.No";
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Location";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = "Total " + Session["DocketCalledAs"].ToString() + " (Booked)";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);
            
            oTableCell = new TableCell();
            oTableCell.Text = Session["DocketCalledAs"].ToString()+"  Status";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 3;

            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            //Add Employee
            oTableCell = new TableCell();
            oTableCell.Text = "(%)age of Operational Complete ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.BackColor = System.Drawing.Color.White;
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = "(%)age of Financial Complete";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.RowSpan = 2;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = "Total Charged Wt.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.RowSpan = 2;
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
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
                  oTableCell1.Text = "Quick " + Session["DocketCalledAs"].ToString();
            oTableCell1.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign= HorizontalAlign.Center;
            //oTableCell.ColumnSpan = 3;
   
             oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Operational " + Session["DocketCalledAs"].ToString();
            oTableCell1.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Financial " + Session["DocketCalledAs"].ToString();
            oTableCell1.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            //Add Employee
            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);
            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            //oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);
            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);
            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************
        }
        //BindGrid();
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
            Response.AddHeader("Content-Disposition", "attachment;Filename=Booking_Summary.xls");
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
     protected void Button1_Click(object sender, EventArgs e)
    {
         
    }

   
}

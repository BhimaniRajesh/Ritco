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
       // Session["SqlProvider"] = "Data Source=ecfy110;Initial Catalog=Webx_RLL.Net;UID=sa;pwd=sa";

       // Session["SqlProvider"] = "Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$";
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


            //Button1.Visible = false;


        }


        // lables......


        //  global
        


        DipsplayReport();


    }


    public void DipsplayReport()
    {
        strDateRange = Request.QueryString["strDateRange"].ToString();
        Session["dt"] = strDateRange;
        strloc = Request.QueryString["strloc"].ToString();
        strro = Request.QueryString["strro"].ToString();

        strmr = Request.QueryString["mr"].ToString();
        strparty = Request.QueryString["party"].ToString();
        strtype = Request.QueryString["type"].ToString();
        stramt = Request.QueryString["amt"].ToString();
        if (strloc == "")
        {
            strloc = "All";
        }
        if (strro == "")
        {
            strro = "All";
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
        SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "";


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_Stax_register";


        sqlCommand.Parameters.AddWithValue("@fromdt", strfrmdt);
        sqlCommand.Parameters.AddWithValue("@todt", strtodt);
        sqlCommand.Parameters.AddWithValue("@party", strparty);
        sqlCommand.Parameters.AddWithValue("@typ", strtype);
      
        sqlCommand.Parameters.AddWithValue("@amt", stramt);
        sqlCommand.Parameters.AddWithValue("@MRBRCD", strloc);
       
        sqlCommand.Parameters.AddWithValue("@mrsnolist", strmr);

        sqlCommand.Parameters.AddWithValue("@RO", strro);


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        DataSet ds = new DataSet();

        da.Fill(ds);



        GV_Booking.DataSource = ds;

        GV_Booking.DataBind();


    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        GV_Booking.PageIndex = e.NewPageIndex;
        
    }
    public void CustomersGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
           


            GridView oGridView = (GridView)sender;
          

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department


            //for first row *************


            oTableCell = new TableCell();
            oTableCell.Text = "SR No.";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            // oTableCell.BorderStyle = BorderStyle.Solid;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR No.";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
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
             oTableCell.RowSpan = 2;
             oTableCell.Wrap = false;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Party ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Branch ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "MR Amount ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oTableCell.Wrap = false;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = Session["DocketCalledAs"].ToString() + " No.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = Session["DocketCalledAs"].ToString() + " Date.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Bill No.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oTableCell.Wrap = false;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Bill Date.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oTableCell.Wrap = false;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Bill Sub." + "<br>" + " Loc";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oTableCell.Wrap = false;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "Service Tax" + "<br>" + " Rate  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Wrap = false;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);




            oTableCell = new TableCell();
            oTableCell.Text = "Cess Rate  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Higher Edu. "+"<br>"+" Cess Rate  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Wrap = false;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);



            oTableCell = new TableCell();
            oTableCell.Text = Session["DocketCalledAs"].ToString();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Bill";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Other Deduction  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 4;
           oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Other Charges  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan =4;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Received ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
          
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);

          

           

            oTableCell = new TableCell();
            oTableCell.Text = "TDS Deduction  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";

            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Claim Deduction";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt"; 
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = "Balance Charges  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 4;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Net/Bal Amt  ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
       

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
            oTableCell1.Wrap = false;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Cess ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text =  "Higher Edu. "+"<br>"+" Cess";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.Wrap = false;
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
            oTableCell1.Wrap = false;
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
            oTableCell1.Text = "Higher Edu. " + "<br>" + " Cess";
            oTableCell1.Wrap = false;
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
            oTableCell1.Wrap = false;
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
            oTableCell1.Text = "Higher Edu. " + "<br>" + " Cess";
            oTableCell1.Wrap = false;
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
            oTableCell1.Wrap = false;
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
            oTableCell1.Text = "Higher Edu. " + "<br>" + " Cess";
            oTableCell1.Wrap = false;
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
            oTableCell1.Wrap = false;
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
            oTableCell1.Text = "Higher Edu. " + "<br>" + " Cess";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oTableCell1.Wrap = false;
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Freight ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Service Tax ";
            oTableCell1.Wrap = false;
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
            oTableCell1.Text = "Higher Edu. " + "<br>" + " Cess";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell1.CssClass = "blackfnt";
            oTableCell1.Wrap = false;
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
           // oGridViewRow1.BackColor = System.Drawing.Color.AliceBlue;
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************
        }



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
            GV_Booking.BorderWidth = 1;
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

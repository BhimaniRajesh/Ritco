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

    public static string strDateRange, strloc, strro, strlogininstence, strreptype,strdocno;

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["strDateRange"].ToString();
            Session["dt"] = strDateRange;
            strloc = Request.QueryString["strloc"].ToString();
            strro = Request.QueryString["strro"].ToString();
            strdocno = Request.QueryString["strdocno"].ToString();
            //Button1.Visible = false;
            

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
        string strfrmdt = strArrDtFromTo[0];
        string strtodt = strArrDtFromTo[1];
        string locval = "";
        string empval = "";
        string lival = "0";
        if (strloc != "")
        {
            lblloc.Text = "All";
            locval = "and CURRBRCD=" + strloc;
        }


        //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

       // SqlConnection conn = new SqlConnection("Data Source=ECFY110;Initial Catalog=rll.net;User ID=sa;Password=sa");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_DOCKET_Profitability_report";





        sqlCommand.Parameters.AddWithValue("@FROMDT", strfrmdt);
        sqlCommand.Parameters.AddWithValue("@TODT", strtodt);
        sqlCommand.Parameters.AddWithValue("@ORGNCD", strloc);
        sqlCommand.Parameters.AddWithValue("@RO", strro);
        sqlCommand.Parameters.AddWithValue("@docklist", strdocno);

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds);

        ds.Tables[0].Columns.Add("srno");
        ds.Tables[0].Columns.Add("profit");

        int i = 1;

        foreach (DataRow dr in ds.Tables[0].Rows)
        {

            dr["srno"] = i;

            if (dr["tottal_cost"] is DBNull || dr["tottal_cost"] == "0" || dr["dkttot"] is DBNull || dr["dkttot"] == "0")
            {
                dr["profit"] = "0.00";
            }
            else
            {
                dr["profit"] = (Convert.ToDouble(dr["tottal_cost"]) * 100) / Convert.ToDouble(dr["dkttot"]);
            }

            dr["profit"] = (Convert.ToDouble(dr["profit"])).ToString("0.00") + "%";

            i++;


        }




        GV_Booking.DataSource = ds;




        GV_Booking.DataBind();
        GV_Booking.HeaderRow.Cells[2].Text = Session["DocketCalledAs"].ToString() + " No.";
        GV_Booking.HeaderRow.Cells[2].Text = Session["DocketCalledAs"].ToString() + " Date.";


        if (GV_Booking.Rows.Count == 0)
        {
            Button1.Visible = false;
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
            oTableCell.Text = " Srno";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Docket No ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Docket Date ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Origin ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Destination ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Pkgsno ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Act.Wt ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Charg Wt.";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Sub Total";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Svctax+Cess ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = " Docket Total";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Yield ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Pick Up";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
 
            oGridViewRow.Cells.Add(oTableCell);
            oTableCell.ColumnSpan = 2;

            oTableCell = new TableCell();
            oTableCell.Text = " BA";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = Session["THCCalledAs"].ToString()+ " 1";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);
 

            oTableCell = new TableCell();
            oTableCell.Text = Session["THCCalledAs"].ToString()+ " 2";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = Session["THCCalledAs"].ToString()+ " 3";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = Session["THCCalledAs"].ToString()+ " 4";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = Session["THCCalledAs"].ToString()+ " 5";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Delivery ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Total Cost ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Profit ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

           
            

           
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
             oTableCell1.Text = "PRS no";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);


             oTableCell1 = new TableCell();
             oTableCell1.Text = "BA Code";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             
             oTableCell1 = new TableCell();
             oTableCell1.Text = "THC No.";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);




             oTableCell1 = new TableCell();
             oTableCell1.Text = "THC No.";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);



             oTableCell1 = new TableCell();
             oTableCell1.Text = "THC No.";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);



             oTableCell1 = new TableCell();
             oTableCell1.Text = "THC No.";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);



             oTableCell1 = new TableCell();
             oTableCell1.Text = "THC No.";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);



             oTableCell1 = new TableCell();
             oTableCell1.Text = "DRS no";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);

             oTableCell1 = new TableCell();
             oTableCell1.Text = "Cost";
             oTableCell1.CssClass = "blackfnt";
             oGridViewRow1.Cells.Add(oTableCell1);


             
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
            Response.AddHeader("Content-Disposition", "attachment;Filename=Vehicle_Regester.xls");
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
            //lblnull.Text = ex1.Message;
        }

    }

   
}

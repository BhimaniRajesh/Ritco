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

        //if(stremp != "")
        //{
        //    lblro.Text = "All";
        //    empval= "and empcd='" + stremp+"'";
        //}
        //if (strlogininstence != "")
        //{
        //    lblli.Text = strlogininstence;
        //    lival = strlogininstence;
        //}
            

       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql="";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());

      
          conn.Open();

          SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection=conn;
        sqlCommand.CommandType=CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_delivery_performance";





        sqlCommand.Parameters.AddWithValue("@fromdt", strfrmdt);
        sqlCommand.Parameters.AddWithValue("@todt", strtodt);
        sqlCommand.Parameters.AddWithValue("@fromloc", strloc);
        sqlCommand.Parameters.AddWithValue("@fromRo", strro);

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds);

        GridViewHelper helper = new GridViewHelper(this.GV_Booking);
        string[] cols = new string[1];
        cols[0] = "report_loc";
        //cols[1] = "ShipName";
        // cols[0].cs
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        helper.RegisterSummary("Total_docket", SummaryOperation.Sum);
        helper.RegisterSummary("TotalDRS_Docket_not", SummaryOperation.Sum);
        helper.RegisterSummary("TotalDRSGEN_Docket", SummaryOperation.Sum);
        helper.RegisterSummary("gen_0", SummaryOperation.Sum);
        helper.RegisterSummary("gen_12", SummaryOperation.Sum);
        helper.RegisterSummary("gen_1", SummaryOperation.Sum);
        helper.RegisterSummary("gen_2", SummaryOperation.Sum);
        helper.RegisterSummary("gen_2More", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_not_update", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_updated", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_Update_0", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_Update_12", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_Update_1", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_Update_2", SummaryOperation.Sum);
        helper.RegisterSummary("DRS_Update_2More", SummaryOperation.Sum);


        helper.RegisterSummary("Total_docket", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("TotalDRS_Docket_not", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("TotalDRSGEN_Docket", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("gen_0", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("gen_12", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("gen_1", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("gen_2", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("gen_2More", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_not_update", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_updated", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_Update_0", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_Update_12", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_Update_1", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_Update_2", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("DRS_Update_2More", SummaryOperation.Sum, "report_loc");
 

        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
  

       

 

        
        GV_Booking.DataSource=ds;

        


        GV_Booking.DataBind();





        if (GV_Booking.Rows.Count == 0)
        {
            //lblnull.Visible = true;
            //lblnull.Text = "No Records Found For Given Criteria";
            // .Visible = false;
        }
        else
        {
            GV_Booking.HeaderRow.Cells[2].Text = Session["DocketCalledAs"].ToString() + " Arrived";
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
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].Text = "Total";
        row.Cells[0].CssClass = "bgbluegrey";
        row.Cells[0].BackColor = System.Drawing.Color.White;
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
     

     protected void Button1_Click(object sender, EventArgs e)
    {
         
    }

    //protected void zero_logic(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        HyperLinkField h1 = (HyperLinkField)e.Row.FindControl("hy1");
    //        HyperLinkField h2 = (HyperLinkField)e.Row.FindControl("hy2");
    //        HyperLinkField h3 = (HyperLinkField)e.Row.FindControl("hy3");
    //        HyperLinkField h4 = (HyperLinkField)e.Row.FindControl("hy4");
    //        HyperLinkField h5 = (HyperLinkField)e.Row.FindControl("hy5");
    //        HyperLinkField h6 = (HyperLinkField)e.Row.FindControl("hy6");
    //        HyperLinkField h7 = (HyperLinkField)e.Row.FindControl("hy7");
    //        HyperLinkField h8 = (HyperLinkField)e.Row.FindControl("hy8");
    //        HyperLinkField h9 = (HyperLinkField)e.Row.FindControl("hy9");
    //        HyperLinkField h10 = (HyperLinkField)e.Row.FindControl("hy10");
    //        HyperLinkField h11 = (HyperLinkField)e.Row.FindControl("hy11");
    //        HyperLinkField h12 = (HyperLinkField)e.Row.FindControl("hy12");
    //        HyperLinkField h13 = (HyperLinkField)e.Row.FindControl("hy13");
    //        HyperLinkField h14 = (HyperLinkField)e.Row.FindControl("hy14");
    //        HyperLinkField h15 = (HyperLinkField)e.Row.FindControl("hy15");



    //       if(h1.Text=="0")
    //       {
    //           h1.NavigateUrl="";
    //           h1.Font.Underline=false;
               
    //       }

    //       if (h2.Text == "0")
    //       {
    //           h2.NavigateUrl = "";
    //           h2.Font.Underline = false;

    //       } if (h3.Text == "0")
    //       {
    //           h3.NavigateUrl = "";
    //           h3.Font.Underline = false;

    //       } if (h4.Text == "0")
    //       {
    //           h4.NavigateUrl = "";
    //           h4.Font.Underline = false;

    //       } if (h5.Text == "0")
    //       {
    //           h5.NavigateUrl = "";
    //           h5.Font.Underline = false;

    //       } if (h6.Text == "0")
    //       {
    //           h6.NavigateUrl = "";
    //           h6.Font.Underline = false;

    //       } if (h7.Text == "0")
    //       {
    //           h7.NavigateUrl = "";
    //           h7.Font.Underline = false;

    //       } if (h8.Text == "0")
    //       {
    //           h8.NavigateUrl = "";
    //           h8.Font.Underline = false;

    //       } if (h9.Text == "0")
    //       {
    //           h9.NavigateUrl = "";
    //           h9.Font.Underline = false;

    //       } if (h10.Text == "0")
    //       {
    //           h10.NavigateUrl = "";
    //           h10.Font.Underline = false;

    //       } if (h11.Text == "0")
    //       {
    //           h11.NavigateUrl = "";
    //           h11.Font.Underline = false;

    //       } if (h12.Text == "0")
    //       {
    //           h12.NavigateUrl = "";
    //           h12.Font.Underline = false;

    //       } if (h13.Text == "0")
    //       {
    //           h13.NavigateUrl = "";
    //           h13.Font.Underline = false;

    //       } if (h14.Text == "0")
    //       {
    //           h14.NavigateUrl = "";
    //           h14.Font.Underline = false;

    //       } if (h15.Text == "0")
    //       {
    //           h15.NavigateUrl = "";
    //           h15.Font.Underline = false;

    //       }
    //    }


         
    //} 
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
            Response.AddHeader("Content-Disposition", "attachment;Filename=Delivery_Performance_Report.xls");
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

    public void onrow(Object sender, GridViewRowEventArgs e)
    {


    }
}

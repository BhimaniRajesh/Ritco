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

    public static string strDateRange, mrno, docno;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["strDateRange"].ToString();
            Session["dt"] = strDateRange;
            mrno = Request.QueryString["mrno"].ToString();
            docno = Request.QueryString["docno"].ToString();
            //Button1.Visible = false;
            

        }

  lblseldet.Text = strDateRange;
         
       

       

        DipsplayReport();


    }

    public void DipsplayReport()
    {

        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt= strArrDtFromTo[0];
        string strtodt= strArrDtFromTo[1];
        
         
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
         // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        string sql="";
     
      
          conn.Open();

          SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection=conn;
        sqlCommand.CommandType=CommandType.StoredProcedure;
        sqlCommand.CommandText = "WEBX_MR_UPDTLIST";





        sqlCommand.Parameters.AddWithValue("@DATEFROM", strfrmdt);
        sqlCommand.Parameters.AddWithValue("@DATETO", strtodt);
        sqlCommand.Parameters.AddWithValue("@MRNO", mrno);
        sqlCommand.Parameters.AddWithValue("@DOCKNO",docno );
        sqlCommand.Parameters.AddWithValue("@DOCKSF", "");
        sqlCommand.Parameters.AddWithValue("@MRTYPE", "4");


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds);
        foreach (DataRow dr in ds.Tables[0].Rows)
        {

            DateTime s;
            s =Convert.ToDateTime(dr["mrsdt"]);


            dr["mrsdt"] = s;
        }



       
         
        GV_Booking.DataSource=ds;

        


        GV_Booking.DataBind();

        if (GV_Booking.Rows.Count == 0)
        {
           
        }
        if (GV_Booking.Rows.Count <= 25)
        {
            ////LinkButton1.Visible = false;
            ////LinkButton2.Visible = false;

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

   
}

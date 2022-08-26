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

    public static string strDateRange, strven, strpo;
    DataSet ds1 = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
              //Date Range display preparation
             strDateRange = Request.QueryString["strDateRange"].ToString();
             if (strDateRange == "")
             {
                 lblseldet.Text = "-";
             }
             else
             {
                 lblseldet.Text = strDateRange;
             }
            

             strven = Request.QueryString["ven"].ToString();
             strpo = Request.QueryString["po"].ToString();


             if (strven == "")
             {
             }
             else
             {
                 lblloc.Text = strven;

             }
             if (strpo == "")
             {
                 lblro.Text = "-";
             }
             else
             {
                 lblro.Text = strpo;
                 lblseldet.Text = "-";
             }

         }



       
         //lblloc.Text = strloc;
         //lblro.Text = strro;





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
       

      //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");
        //SqlConnection conn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;");
          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "";

        string wheredtrange = " and (convert(datetime,podate,106)";

        wheredtrange = wheredtrange + "  between convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106))";



        if (strpo == "")
            // and vendorcd='" +strven+ "' 
             //" + wheredtrange + " 
            sql = "select pocode,convert(varchar,podate,106) as podt,vendorcd from webx_poasset_hdr where postatus='P' and po_loccode='" + Session["brcd"].ToString() + "'" + wheredtrange + " and pocode in (select pocode from webx_poasset_det where activeflag='N') order by pocode asc";
        else
            sql = "select pocode,convert(varchar,podate,106) as podt,vendorcd from webx_poasset_hdr where postatus='P' and po_loccode='" + Session["brcd"].ToString() + "' and pocode='" + strpo + "' and pocode in (select pocode from webx_poasset_det where activeflag='N') order by pocode asc";


        conn.Open();

        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        da.Fill(ds);



        GV_Booking.DataSource = ds;

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

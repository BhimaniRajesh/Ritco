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

    public static string strDateRange, strloc, strgrp, strgrossval;
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

            strgrp = Request.QueryString["grp"].ToString();
            strgrossval = Request.QueryString["grossval"].ToString();
            strloc = Request.QueryString["loc"].ToString();
            lblloc.Text = strloc;
            lblgrp.Text = strgrp;


           
 }


 

      DipsplayReport();


    }


    public void DipsplayReport()
    {


        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt = strArrDtFromTo[0];
        string strtodt = strArrDtFromTo[1];
 


        //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");
        //SqlConnection conn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());



        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_FA_Register";



        cmd.Parameters.AddWithValue("@mFromdt", strArrDtFromTo[0]);
        cmd.Parameters.AddWithValue("@mTodt", strArrDtFromTo[1]);
        cmd.Parameters.AddWithValue("@brcd", strloc);
        cmd.Parameters.AddWithValue("@grpcd", strgrp);
        cmd .Parameters.AddWithValue("@grossval", strgrossval);



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

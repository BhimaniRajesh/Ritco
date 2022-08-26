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

    public static string strDateRange, strloc, strro, strloc2, strro2, strlogininstence, strreptype,reppara;
     public DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            reppara = Request.QueryString["reppara"].ToString();

            if (reppara == "new")
            {

                strDateRange = Request.QueryString["strDateRange"].ToString();
                Session["dt"] = strDateRange;
                strloc = Request.QueryString["strloc"].ToString();
                strro = Request.QueryString["strro"].ToString();
                strloc2 = Request.QueryString["strloc2"].ToString();
                strro2 = Request.QueryString["strro2"].ToString();
                strreptype = Request.QueryString["reptype"].ToString();
                lblreptyp.Text = "Location Stock - Detail";

            }
            else
            {
                // strDateRange = Request.QueryString["strDateRange"].ToString();
                strDateRange = Session["dt"].ToString();
                strloc = Request.QueryString["Cur_loc"].ToString();
                strro = "All";
                strloc2 = Request.QueryString["dly_loc"].ToString();
                strro2 = "All";
                lblreptyp.Text = "Location Stock - Summary";

                //strreptype = Request.QueryString["reptype"].ToString();

            }
           
            

        }

        if (strro == "")
        {
            strro = "All";
        }
        if (strro2 == "")
        {
            strro2 = "All";
        }

        if (strloc2 == "")
        {
            strloc2 = "All";
        }
        if (strloc == "")
        {
            strloc = "All";
        }
        
        // lables......
        lblseldet.Text = strDateRange;
        lblloc.Text = strloc+" - "+strloc2;
        lblro.Text = strro+" - "+strro2;

        if (reppara == "drill")
        {

            DisplayDtl();
        }



        
        if (strreptype == "D")
        {

            DisplayDtl();
        }
        else if (strreptype == "X")
        {

            ForCSV();
        }



    }

    private void DisplayDtl()
    {
        ds.Clear();
        //SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

       // SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");

     
        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "WebxNet_LOCSTOCK_DET_New";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@from_lo", strloc);
        sqlCommand.Parameters.AddWithValue("@to_lo", strloc2);
       

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

      

        sqlDA.Fill(ds);


        double totbooked = 0,  totweigth = 0;
        double totarrived = 0, totval = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {

            switch (dr["paybas"].ToString())
            {
                case "P02":
                    dr["paybas"] = " TBB";
                    break;

                case "P03":
                    dr["paybas"] = "To Pay";
                    break;

                case "P01":
                    dr["paybas"] = " Paid";
                    break;

                case "P08":
                    dr["paybas"] = " BOD";
                    break;

                case "P06":
                    dr["paybas"] = " To Pay Billing";
                    break;

                case "P04":
                    dr["paybas"] = " FOC";
                    break;

                case "P09":
                    dr["paybas"] = " National";
                    break;






            }
            //dr["dlytype"] = "All";



            


                if (dr["dkttot"] is DBNull)
                {
                    dr["dkttot"] = "0.00";
                }
                else
                {

                    totval += Convert.ToDouble(dr["dkttot"]);
                }


                if (dr["actuwt"] is DBNull)
                {
                    dr["actuwt"] = "0.00";
                }
                else
                {
                    dr["actuwt"] = Convert.ToDouble(dr["actuwt"]).ToString("F2");

                    totweigth += Convert.ToInt16(dr["actuwt"]);
                }

             

        }

         
        

        GV_Dtl.DataSource = ds;
        GV_Dtl.DataBind();

        if (ds.Tables[0].Rows.Count != 0)
        {
            GV_Dtl.FooterRow.CssClass = "blackfnt";
            GV_Dtl.FooterRow.Font.Bold = true;


            GV_Dtl.FooterRow.Cells[5].Text = "Total";
            GV_Dtl.FooterRow.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            //GV_Dtl.FooterRow.Cells[6].Text = totbooked.ToString();
            //GV_Dtl.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Center;
            GV_Dtl.FooterRow.Cells[7].Text = totweigth.ToString("F2");
            GV_Dtl.FooterRow.Cells[7].HorizontalAlign = HorizontalAlign.Center;
            GV_Dtl.FooterRow.Cells[8].Text = totval.ToString("F2");
            GV_Dtl.FooterRow.Cells[8].HorizontalAlign = HorizontalAlign.Center;
            
        }
        if (GV_Dtl.Rows.Count == 0)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;
            Button1.Visible = false;
        }

        if (GV_Dtl.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;
            
        }

 
    
    }

    private void ForCSV()
    {
       // SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");


        //SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
     
        //sqlConn.Open();

        //SqlCommand sqlCommand = new SqlCommand();

        //sqlCommand.Connection = sqlConn;
        //sqlCommand.CommandType = CommandType.StoredProcedure;


        //sqlCommand.CommandText = "webxNET_LOCSTOCK";




        //// Managing Date Range for input parameters to SP
        //string[] strArrDtFromTo = strDateRange.Split('-');

        //sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        //sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        //sqlCommand.Parameters.AddWithValue("@loccode", strloc);
        //sqlCommand.Parameters.AddWithValue("@RO", strro);
        //sqlCommand.Parameters.AddWithValue("@loccode_to", strloc2);
        //sqlCommand.Parameters.AddWithValue("@RO_to", strro2);
        //sqlCommand.Parameters.AddWithValue("@dly_type", "All");

        //SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        //DataSet dds = new DataSet();

        //sqlDA.Fill(dds);








        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "webxNET_LOCSTOCK";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@loccode", strloc);
        sqlCommand.Parameters.AddWithValue("@RO", strro);
        sqlCommand.Parameters.AddWithValue("@loccode_to", strloc2);
        sqlCommand.Parameters.AddWithValue("@RO_to", strro2);
        sqlCommand.Parameters.AddWithValue("@dly_type", "All");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dds = new DataSet();

      sqlDA.Fill(dds);

        double totbooked = 0, totweigth = 0, totval = 0;
        double totarrived = 0.00;
        foreach (DataRow dr in dds.Tables[0].Rows)
        {

            switch (dr["paybas"].ToString())
            {
                case "P02":
                    dr["paybas"] = " TBB";
                    break;

                case "P03":
                    dr["paybas"] = "To Pay";
                    break;

                case "P01":
                    dr["paybas"] = " Paid";
                    break;

                case "P08":
                    dr["paybas"] = " BOD";
                    break;

                case "P06":
                    dr["paybas"] = " To Pay Billing";
                    break;

                case "P04":
                    dr["paybas"] = " FOC";
                    break;

                case "P09":
                    dr["paybas"] = " National";
                    break;






            }
            //dr["dlytype"] = "All";



            if (dr["arrived"] is DBNull)
            {
            }
            else
            {
                totarrived += Convert.ToDouble(dr["arrived"].ToString());
            }

            if (dr["booked"] is DBNull)
            {
                dr["booked"] = "0";
            }
            else
            {

                totbooked += Convert.ToDouble(dr["booked"]);
            }


            if (dr["dkttot"] is DBNull)
            {
                dr["dkttot"] = "0";
            }
            else
            {

                totval += Convert.ToDouble(dr["dkttot"]);
            }


            if (dr["actuwt"] is DBNull)
            {
            }
            else
            {


                totweigth += Convert.ToDouble(dr["actuwt"]);
            }



        }

        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Location_Stock.csv"), false);

        //DataTable dt = dds.Tables[0];
        //int iColCount = dt.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(dt.Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);
        //// Now write all the rows.
        //foreach (DataRow dr in dt.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();






        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("Location_Stock.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Location_Stock.csv");
        ////Response.ContentType = "application/octet-stream";
       
        //Response.BinaryWrite(btFile);
        //Response.End();



        int ind = 0;
        int a = 0;
        try
        {
            GV_Dtl.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Loaction_Stock.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayDtl();
            GV_Dtl.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }



    }

       

          




      

   
    
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Dtl.PageIndex = e.NewPageIndex;

        DisplayDtl();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Dtl.PageCount;
        GV_Dtl.PageIndex = i;

        DisplayDtl();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_Dtl.PageIndex = 0;

         DisplayDtl();


    }


  
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GV_Dtl.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Loaction_Stock.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayDtl();
            GV_Dtl.RenderControl(hw);


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

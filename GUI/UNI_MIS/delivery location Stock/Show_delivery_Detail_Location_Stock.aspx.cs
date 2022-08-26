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

    public static string strDateRange, strloc, strro, strloc2, strro2, strlogininstence, strreptype, reppara;

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
                strreptype = Request.QueryString["reptype"].ToString();

            }
            else
            {
                // strDateRange = Request.QueryString["strDateRange"].ToString();
                strDateRange = Session["dt"].ToString();
                strloc = Request.QueryString["dly_loc"].ToString();
                strro = Session["strro"].ToString();
                //strreptype = Request.QueryString["reptype"].ToString();

            }

            if (strloc == "")
            {
                strloc = "All";
            }

            // lables......
            lblseldet.Text = strDateRange;
            lblloc.Text = strloc;
            lblro.Text = strro;

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







    }

    private void DisplayDtl()
    {
        DataSet ds = new DataSet();





       SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
     //   SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");
        // SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");


        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "WebxNet_LOCSTOCK_DLY_Det_New";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@from_lo",strloc);
        //sqlCommand.Parameters.AddWithValue("@from_lo", strloc);


        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);



        sqlDA.Fill(ds);



        ////  SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_Ver2_Live;");
        //  //SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");
        //  SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //  sqlConn.Open();

        //  SqlCommand sqlCommand = new SqlCommand();

        //  sqlCommand.Connection = sqlConn;
        //  sqlCommand.CommandType = CommandType.StoredProcedure;


        //  sqlCommand.CommandText = "webx_LOCSTOCK_dly";


        //  if (strro == "")
        //  {
        //      strro = "All";

        //  }

        //  // Managing Date Range for input parameters to SP
        //  string[] strArrDtFromTo = strDateRange.Split('-');

        //  sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        //  sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        //  sqlCommand.Parameters.AddWithValue("@loccode", strloc);
        //  sqlCommand.Parameters.AddWithValue("@RO", strro);
        //  sqlCommand.Parameters.AddWithValue("@dly_type", "All");
        //  sqlCommand.Parameters.AddWithValue("@DestCD", "All");

        // SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);



        //  sqlDA.Fill(ds);


        //  GV_Dtl.DataSource = ds;


        //  ds.Tables[0].Columns.Add("d1");
        //  ds.Tables[0].Columns.Add("d2");

        //  foreach (DataRow dr in ds.Tables[0].Rows)
        //  {
        //      if (dr["dockdt"] is DBNull)
        //      {
        //          dr["d1"] = "-";
        //      }
        //      else
        //      {
        //          dr["d1"] = Convert.ToDateTime(dr["dockdt"]).ToString("dd MMM yyyy");
        //      }

        //  }
        //  foreach (DataRow dr in ds.Tables[0].Rows)
        //  {
        //      if (dr["arrv_dt"] is DBNull)
        //      {
        //          dr["d2"] = "-";
        //      }
        //      else
        //      {
        //          dr["d2"] = Convert.ToDateTime(dr["arrv_dt"]).ToString("dd MMM yyyy");
        //      }

        //  }
        GV_Dtl.DataSource = ds;

        GV_Dtl.DataBind();

        if (GV_Dtl.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;

        }

        if (ds.Tables[0].Rows.Count == 0)
        {
            Button1.Visible = false;
        }






    }

    private void ForCSV()
    {


        int ind = 0;
        int a = 0;
        try
        {
            GV_Dtl.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Delivery_location_Stock.xls");
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
        ////SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");
        //SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_Ver2_Live;");
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
        //sqlCommand.Parameters.AddWithValue("@loccode_to", "All");
        //sqlCommand.Parameters.AddWithValue("@RO_to", "All");
        //sqlCommand.Parameters.AddWithValue("@dly_type", "All");

        //SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);


        //sqlDA.Fill(ds);

        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("SandyLoc.csv"), false);

        //DataTable dt = ds.Tables[0];
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
        //fs = System.IO.File.Open(Server.MapPath("SandyLoc.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Sandy123.csv");
        ////Response.ContentType = "application/octet-stream";

        //Response.BinaryWrite(btFile);
        //Response.End();




    }


    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Dtl.PageIndex = e.NewPageIndex;

        //  DisplayDtl();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Dtl.PageCount;
        GV_Dtl.PageIndex = i;

        // DisplayDtl();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_Dtl.PageIndex = 0;

        //   DisplayDtl();


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
            Response.AddHeader("Content-Disposition", "attachment;Filename=Delivery_location_Stock.xls");
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

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

public partial class GUI_Vihicle_vehicle_2 : System.Web.UI.Page
{
    public static string strselectlist, strroute, strven, strdoctype;
    public static string strDateRange, strdoclist, strro, strlo;
    public  static DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
         if (!IsPostBack)
        {
            //Date Range display preparation
           strDateRange = Request.QueryString["StrDate"].ToString();
            strro = Request.QueryString["RO"].ToString();
            if (strro == "-All-" || strro=="")
            {
                strro = "All";
            }
            strlo = Request.QueryString["Location"].ToString();
            if (strlo == "-All-" || strlo=="")
            {
                strlo = "All";
            }

         strselectlist = Request.QueryString["seleItem"].ToString();
         strroute = Request.QueryString["Route"].ToString();
         strven = Request.QueryString["Ven"].ToString();
         strdoctype = Request.QueryString["DocType"].ToString();
         strdoclist = Request.QueryString["DocList"].ToString();
           
 


        }



       

        
        
        
        
        // lables......




        lblseldet.Text = strDateRange;
        lblro.Text = strro;
        lblloc.Text = strlo;
        lblven.Text = strven;
        lblroute.Text = strroute;
        
        if (strdoctype == "T")
        {
        lbldoctype.Text="VHC";
        }
        else if (strdoctype == "P")
        {
            lbldoctype.Text = "PRS";
        }
        else if (strdoctype == "D")
        {
            lbldoctype.Text = "DRS";
        }
        else if (strdoctype == "PD")
        {
            lbldoctype.Text = "PRS+DRS";
        }
        if (strroute == "")
        {
            lblroute.Text = "All";
            strroute = "All";
        }
        
        if (strven == "")
        {
            strven = "All";
            lblven.Text = "All";
        }


        DipsplayReport();



    

    }

    public void DipsplayReport()
    {
         


    // SqlConnection conn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;");

       SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.CommandText = "webx_THC_PRS_DRS_register_NET";


        
        //Managing Date Range for input parameters to SP
        //string[] strArrDtFromTo = strDateRange.Split('-');
        //sqlCommand.Parameters.AddWithValue("@Fromdt", strArrDtFromTo[0]);
        //sqlCommand.Parameters.AddWithValue("@todt", strArrDtFromTo[1]);
        //sqlCommand.Parameters.AddWithValue("@RO", strro);
        //sqlCommand.Parameters.AddWithValue("@ORGNCD", strlo);
        //sqlCommand.Parameters.AddWithValue("@Route", strroute);
        //sqlCommand.Parameters.AddWithValue("@Vendor", strven);
        //sqlCommand.Parameters.AddWithValue("@documenttype", strdoctype);
        //sqlCommand.Parameters.AddWithValue("@docklist", strdoclist);
        //sqlCommand.Parameters.AddWithValue("@Selectitem", "vehno,vendor_name,thcno");


            if (strro == "")
            {
            strro="All";
            }

            string[] strArrDtFromTo = strDateRange.Split('-');
            sqlCommand.Parameters.AddWithValue("@Fromdt", strArrDtFromTo[0]);
            sqlCommand.Parameters.AddWithValue("@todt", strArrDtFromTo[1]);
            sqlCommand.Parameters.AddWithValue("@RO", strro);
            sqlCommand.Parameters.AddWithValue("@ORGNCD", strlo);
            sqlCommand.Parameters.AddWithValue("@Route", strroute);
            sqlCommand.Parameters.AddWithValue("@Vendor", strven);
            sqlCommand.Parameters.AddWithValue("@documenttype", strdoctype);
            sqlCommand.Parameters.AddWithValue("@docklist", strdoclist);
            sqlCommand.Parameters.AddWithValue("@Selectitem", strselectlist);






        try
        {

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet ds1 = new DataSet();
            sqlDA.Fill(ds1);
            GV_Veh.DataSource = ds1;

            ds = ds1;

           
        }

        catch (Exception eee)
        {
            lblnull.Visible = true;
            lblnull.Text = eee.Message;

            lblnull.Text = strselectlist;

        }



        GV_Veh.DataBind();
        GV_Veh.RowStyle.BackColor = System.Drawing.Color.White;
       // GV_Veh.HeaderStyle.CssClass = "bluefnt";
        GV_Veh.RowStyle.CssClass = "blackfnt";
        GV_Veh.HeaderStyle.Font.Name = "Verdana";
        if (GV_Veh.Rows.Count == 0)
        {
          
             lblnull.Text ="No Records Found For Given Criteria";
        }

               

            

        }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Veh.PageIndex = e.NewPageIndex;

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
            GV_Veh.AllowPaging = false;
         
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Vehicle_Regester.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DipsplayReport();
                GV_Veh.RenderControl(hw);
           
            
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            //lblnull.Text = ex1.Message;
        }

    }
        
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Cust_Outstanding.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("Cust_Outstanding.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Cust_Outstanding.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
     

}

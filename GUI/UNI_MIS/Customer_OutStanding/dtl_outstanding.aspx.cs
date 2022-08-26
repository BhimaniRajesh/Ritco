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

public partial class OutStanding_dtl_outstanding : System.Web.UI.Page
{
      public static string stragefrm;
        public static string strageto;
        public static string strbilltype;
        public static string strdttype;
        public static string strdt;
        public static string lo,lo2;
        public static string myflg;
        public static DataSet ds = new DataSet();

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            myflg = Request.QueryString["flg"].ToString();
            stragefrm = Session["agefrm"].ToString();
            strageto = Session["ageto"].ToString();
            strbilltype = Session["billtype"].ToString();
            strdttype = Session["dttype"].ToString();
            strdt = Session["ASONDT"].ToString();
            //lo = Session["lo"].ToString();
            lo = Request.QueryString["lo"].ToString();
            lo2 = lo;
                //.Substring(0, 4);
           

          
            DisplayOS();


        }

    }

    public void DisplayOS()
    {
        ds.Clear();

        lblageos.Text = strageto;
        lblBillingType.Text = strbilltype;
        if(strbilltype== "" || strbilltype=="-")
        {
               lblBillingType.Text="All";
            
       
        }
        lbldatetype.Text = strdt;

        //string strConnection = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";

        //SqlConnection sqlConn = new SqlConnection(strConnection);

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;


        sqlCommand.CommandType = CommandType.StoredProcedure;


        if (myflg == "G")
        {
            sqlCommand.CommandText = "webx_outstanding_cust_Gen_ver_08_test";
        }
        else if (myflg == "S")
        {
            sqlCommand.CommandText = "webx_outstanding_cust_Sub_ver_08";
        }
        else
        {
            sqlCommand.CommandText = "webx_outstanding_cust_Coll_ver_08_test";
        }

            //Input parameter for Billing Party
            sqlCommand.Parameters.AddWithValue("@orgncd", lo2);
        sqlCommand.Parameters.AddWithValue("@AGEFROM", stragefrm);
        sqlCommand.Parameters.AddWithValue("@AGETO", strageto);
        sqlCommand.Parameters.AddWithValue("@date", strdttype);
        sqlCommand.Parameters.AddWithValue("@BILLTYP", strbilltype);
        sqlCommand.Parameters.AddWithValue("@ASONDT", strdt);



            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);



           

            sqlDA.Fill(ds);


            foreach (DataRow d in ds.Tables[0].Rows)
            {
                

                d["ptmscd"] = d["ptmscd"].ToString() + " : " + cstnm(d["ptmscd"].ToString());
            }

           
        
        
        
        //Sandy.DataSource = ds;
            //Sandy.DataBind();


        //   GridView1.AllowPaging = false;

           // GridView1.PageSize = 25;
            GridView3.DataSource = ds;
            GridView3.DataBind();



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
                GridView3.AllowPaging = false;

                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment;Filename=TDS.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter tw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

                DisplayOS(); 
                GridView3.RenderControl(hw);


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
    
    }
    protected void btnPrint_ServerClick(object sender, EventArgs e)
    {

    }
    protected void btnXML_ServerClick(object sender, EventArgs e)
    {

    }

    public string cstnm(string cd)
    {
        string cstcd = cd;
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlCommand = new SqlCommand("Select top 1 custnm from webx_custhdr where custcd='" + cstcd + "'", sqlConn);
        sqlConn.Open();
        string sa = (string)sqlCommand.ExecuteScalar();
        sqlConn.Close();
        return sa;



    }
}

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



public partial class OutStanding_Show_OutStanding : System.Web.UI.Page
{

    public static string strOSDate;
    public static string strro;
    public static string strloc;
    public static string strcust;
    public static string strbilltype;
    public static string strageos;
    public static string strdttype;
    public static string strbr_cst;
    public static Int32 outstandfrom;
    public static Int32 outstandto;
    public static string strageosDesc;
    public DataSet ds123 = new DataSet();
    public static DataSet ds1234 = new DataSet();
    //public string ro, ro1, lo, ro2, ro3;
    public double ft1, ft2, ft3;

    public double t1, t2, t3, t4, t5, tu, tt;
    public  static int i = 0;
    public  DataTable dt = new DataTable();


    protected void Page_Load(object sender, EventArgs e)
    {

        //string str = Request.QueryString.ToString();
        //Response.Write(str);



        if (!IsPostBack)
        {

            // strOSDate = Request.QueryString["OSDate"].ToString();
            i = 0;
            strro = Request.QueryString["RO"].ToString();
            strloc = Request.QueryString["Location"].ToString();
            strcust = Request.QueryString["Cust"].ToString();
            strbilltype = Request.QueryString["BillType"].ToString();
            strageos = Request.QueryString["AgeOs"].ToString();
            strdttype = Request.QueryString["DateType"].ToString();
            strbr_cst = Request.QueryString["Br_Cst"].ToString();

            if (strro == "-All-")
            {
                strro = "ALL";
            }
            strloc = Request.QueryString["Location"].ToString();
            if (strloc == "-All-")
            {
                strloc = "ALL";
            }
            strcust = Request.QueryString["Cust"].ToString();
            if (strcust == "")
            {
                strcust = "ALL";
            }

            if (strageos == "0")
            {
                strageosDesc = "0-30 days";
                outstandfrom = 0;
                outstandto = 30;

            }

            else if (strageos == "30")
            {
                strageosDesc = "31-60 days";
                outstandfrom = 31;
                outstandto = 60;
            }
            else if (strageos == "60")
            {
                strageosDesc = "61-90 days";
                outstandfrom = 61;
                outstandto = 90;
            }
            else if (strageos == "90")
            {
                strageosDesc = "91-180 days";
                outstandfrom = 91;
                outstandto = 180;
            }
            else if (strageos == "180")
            {
                strageosDesc = ">180 days";
                outstandfrom = 181;
                outstandto = 365;
            }

            else if (strageos == "U")
            {
                strageosDesc = "Undue Bills";
                outstandfrom = -365;
                outstandto = 0;
            }


            else
            {
                strageosDesc = "All";
                outstandfrom = -365;
                outstandto = 365;
            }


            if (strbilltype == "-- All --")
            {
                strbilltype = "-";
                lblBillingType.Text = "ALL";

            }

            if (strbilltype == "2")
            {
                lblBillingType.Text = "Freight Bill";
            }
            else if (strbilltype == "6")
            {
                strbilltype = "-";
                lblBillingType.Text = "Octroi Bill";

            }
            else
            {
                lblBillingType.Text = "ALL";

            }

            if (strdttype == "0")
            {
                lbldatetype.Text = "Bill Generation";

            }
            else if (strdttype == "1")
            {
                lbldatetype.Text = "Bill Submission";
            }
            else
            {
                lbldatetype.Text = "Due Date";

            }


            //Session["agefrm"] = outstandfrom;
            //Session["ageTO"] = outstandto;
            //Session["dttype"] = strdttype;
            //Session["billtype"] = strbilltype;
            //Session["ASONDT"] = "";


            if (strdttype == "0")
            {
                strdttype = "BGNDT";
            }
            else if (strdttype == "1")
            {
                strdttype = "BSBDT";
            }
            else
            {
                strdttype = "BDUEDT";
            }

            Session["agefrm"] = outstandfrom;
            Session["ageTO"] = outstandto;
            Session["dttype"] = strdttype;
            Session["billtype"] = strbilltype;
            Session["ASONDT"] = "";
            Session["lo"] = "BOMN";



            lbldtout.Text = strOSDate;
            lblBillingParty.Text = strcust;

            lblageos.Text = strageosDesc;

            DisplayOS();


        }

    }


    //UNI_MIS/Customer_OutStanding/Show_OutStanding2.aspx?OSDate=&RO=All&Location=All&Cust=&BillType=--%20All%20--&AgeOs=--%20All%20--&DateType=1&Br_Cst=1


    public void DisplayOS()
    {


        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;


        sqlCommand.CommandType = CommandType.StoredProcedure;



        if (strbr_cst == "1")
        {


            btn_gr1.Visible = true;



            //    exec webx_oustandingSummary_new3 'ALL',0,500,'BILLCOLBRCD','ALL','BDUEDT','-','' 

            //exec webx_outstanding_cust_new2 'all','-365','365','-','all','bgndt',''


            sqlCommand.CommandText = "webx_outstanding_cust_ver_08";




            //Input parameter for Billing Party
            sqlCommand.Parameters.AddWithValue("@CUSTCD", strcust);


            //Input parameter for Bill Type
            sqlCommand.Parameters.AddWithValue("@BILLTYP", strbilltype);

            //Managing Age Range for input parameters to SP
            sqlCommand.Parameters.AddWithValue("@AGEFROM", outstandfrom);
            sqlCommand.Parameters.AddWithValue("@AGETO", outstandto);



            //Input parameter for Location
            sqlCommand.Parameters.AddWithValue("@orgncd", strloc);

            //Input parameter for Date Type  
            sqlCommand.Parameters.AddWithValue("@date", strdttype);

            //Input parameter for As On Date 
            sqlCommand.Parameters.AddWithValue("@ASONDT", "");
             
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

 
            sqlDA.Fill(ds123);
         
           

            GridView1.DataSource = ds123;
            //GridView1.AllowPaging = true;
            //GridView1.PageSize = 50;
             ds123.Tables[0].Columns.Add("c1");
            foreach (DataRow dr in ds123.Tables[0].Rows)
            {
                dr["c1"] = dr["ptmscd"].ToString()+" : "+cstnm(dr["ptmscd"].ToString());
            
            }

            if (ds123.Tables[0].Rows.Count < 50)
            {
                i = 0;
            }
            ds1234.Clear();

            ds1234 = ds123;
            GridView1.DataBind();




            if (GridView1.Rows.Count != 0)
            {

                GridView1.FooterRow.Cells[1].Text = "Total :";

                GridView1.FooterRow.Cells[2].Text = tu.ToString();
                GridView1.FooterRow.Cells[3].Text = t1.ToString();
                GridView1.FooterRow.Cells[4].Text = t2.ToString();
                GridView1.FooterRow.Cells[5].Text = t3.ToString();
                GridView1.FooterRow.Cells[6].Text = t4.ToString();
                GridView1.FooterRow.Cells[7].Text = t5.ToString();
                GridView1.FooterRow.Cells[8].Text = tt.ToString();
            }




        }

        else
        {
            brngr2.Visible = true;
            sqlCommand.CommandText = "webx_outstanding_VER_08";

            //Input parameter for RO
            sqlCommand.Parameters.AddWithValue("@RO", strro);

            //Input parameter for Bill Type
            sqlCommand.Parameters.AddWithValue("@billtype", strbilltype);


            //Managing Age Range for input parameters to SP
            sqlCommand.Parameters.AddWithValue("@AGEFROM", outstandfrom);
            sqlCommand.Parameters.AddWithValue("@AGETO", outstandto);



            //Input parameter for Location
            sqlCommand.Parameters.AddWithValue("@orgncd", strloc);

            //Input parameter for Date Type  
            sqlCommand.Parameters.AddWithValue("@date", strdttype);

            //Input parameter for As On Date 
            sqlCommand.Parameters.AddWithValue("@ASONDT", "");



            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);



            DataSet ds = new DataSet();


            sqlDA.Fill(ds);



            GridViewHelper helper = new GridViewHelper(this.GridView2);
            string[] cols = new string[1];
            cols[0] = "report_loc";

            helper.RegisterGroup(cols, true, true);
            helper.GroupHeader += new GroupEvent(helper_GroupHeader);
            // helper.RegisterSummary("loccode1", SummaryOperation.Sum);
            helper.RegisterSummary("billamt_gen", SummaryOperation.Sum);
            helper.RegisterSummary("billamt_sub", SummaryOperation.Sum);
            helper.RegisterSummary("billamt_coll", SummaryOperation.Sum);


            //  helper.RegisterSummary("loccode1", SummaryOperation.Sum, "report_loc");
            helper.RegisterSummary("billamt_gen", SummaryOperation.Sum, "report_loc");
            helper.RegisterSummary("billamt_sub", SummaryOperation.Sum, "report_loc");
            helper.RegisterSummary("billamt_coll", SummaryOperation.Sum, "report_loc");

            helper.GroupSummary += new GroupEvent(helper_GroupSummary);



            GridView2.DataSource = ds;

            GridView2.DataBind();




        }

    }



    public void DisplayOS_xls()
    {
   
            SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
          sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
    sqlCommand.CommandType = CommandType.StoredProcedure;

           sqlCommand.CommandText = "webx_outstanding_cust_ver_08";

       sqlCommand.Parameters.AddWithValue("@CUSTCD", strcust);
          sqlCommand.Parameters.AddWithValue("@BILLTYP", strbilltype);
         sqlCommand.Parameters.AddWithValue("@AGEFROM", outstandfrom);
            sqlCommand.Parameters.AddWithValue("@AGETO", outstandto);
        sqlCommand.Parameters.AddWithValue("@orgncd", strloc);

              sqlCommand.Parameters.AddWithValue("@date", strdttype);
              sqlCommand.Parameters.AddWithValue("@ASONDT", "");
             
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet ddd = new DataSet();
            sqlDA.Fill(ddd);

            ddd.Tables[0].Columns.Add("c1");
            foreach (DataRow dr in ddd.Tables[0].Rows)
            {
                dr["c1"] = dr["ptmscd"].ToString() + " : " + cstnm(dr["ptmscd"].ToString());

            }

            GridView3.DataSource = ddd;


            GridView3.AllowPaging = false;

            GridView3.DataBind();

 

        }

       

    


    private void helper_GeneralSummary(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
            //  row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "sasasasqqqqqqq";
            row.Font.Name = "blackfnt";
            row.BackColor = System.Drawing.Color.White;
            row.Font.Bold = true;
            row.CssClass = "blackfnt";
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;



        }
    }

    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
            //  row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].VerticalAlign = VerticalAlign.Top;
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            row.CssClass = "blackfnt";
            row.Cells[0].Font.Bold = true;
            row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
 
        }
    }

    private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    {
        row.BackColor = System.Drawing.Color.White;
        row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].Text = " Total ";

    }





    public void pgChange(object sender, GridViewPageEventArgs e)
    {


        GridView1.PageIndex = e.NewPageIndex;

        if (e.NewPageIndex == 1)
        {
            i = 0;
        }
        else
        {
            i = (e.NewPageIndex * GridView1.PageSize) - GridView1.PageSize;
        }
        t1 = 0;
        t2 = 0;
        t3 = 0;
        t4 = 0;
        t5 = 0;
        tt = 0;
        tu = 0;
        

        DisplayOS();
 

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
          GridView1.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Customer_OutStanding.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        GridView1.AllowPaging = false;

            GridView1.BorderWidth = 1;

            DisplayOS_xls();
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

    protected void btn_csv_Click2(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GridView2.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Customer_OutStanding.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayOS();
            GridView2.AllowPaging = false;
            sasa.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }





    public string cstnm(string cd)
    {
        string cstcd = cd;
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlCommand = new SqlCommand("Select top 1 custnm from webx_custhdr where custcd='" + cstcd + "'",sqlConn);
        sqlConn.Open();
        string sa = (string)sqlCommand.ExecuteScalar();
        sqlConn.Close();
        return sa;



    }


    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DataRow dd = ds123.Tables[0].Rows[i];

            t1 += Convert.ToDouble(dd.ItemArray[3].ToString());
            t2 += Convert.ToDouble(dd.ItemArray[4].ToString());
            t3 += Convert.ToDouble(dd.ItemArray[5].ToString());
            t4 += Convert.ToDouble(dd.ItemArray[6].ToString());
            t5 += Convert.ToDouble(dd.ItemArray[7].ToString());
            tu += Convert.ToDouble(dd.ItemArray[2].ToString());
            tt += Convert.ToDouble(dd.ItemArray[1].ToString());

          

            i = i + 1;
        }
    }

}

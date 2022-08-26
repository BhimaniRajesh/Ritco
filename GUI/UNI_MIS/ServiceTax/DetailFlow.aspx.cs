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
public partial class Operation_DetailFlow : System.Web.UI.Page
{

    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    public static string mylocstr;
    public static string mycuststr;
    public static string sublocstr;
    public static string mydt;
    public static string myreppara;
    public static string strsetdt;
  
    public int HIDCurrentPageNo = 1; 
    public static string strflow;
   // static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
    // static string strConnection = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";



    

    //public static int intCurrentPageNo;
    //public static int intPageSize = 10;


    protected void Page_Load(object sender, EventArgs e)
    {

        hypWelcome.NavigateUrl = "../../welcome.asp"; //Use an appropriate path

        hypReport.Text = "Reports";
        hypReport.NavigateUrl = "../reportmenu.asp"; //Use an appropriate path

        hypFinance.Text = "Finance";
        hypFinance.NavigateUrl = "../rpt_finance.asp"; //Use an appropriate path

        
        if (!IsPostBack)
        {

            mylocstr = Request.QueryString["loc"].ToString();
           
            // sublocstr = mylocstr.Substring(0, 4);
            strsetdt = Session["dt"].ToString();

            lblseldet.Text = strsetdt;
                
            lblloc.Text = mylocstr;
            
           myreppara = Request.QueryString["reppara"].ToString();

           if (myreppara == "1")
           {
               lblstatus.Text = "Total Dockets Booked";
           }
           else if (myreppara == "2")
           {
               lblstatus.Text = "Quick Dockets";
           }
           else if (myreppara == "3")
           {
               lblstatus.Text = "Operational Dockets";
           }
           else if (myreppara == "4")
           {
               lblstatus.Text = "Financial Dockets";
           }
            


        }
        DisplayDocFlowDtl();
        


    

    }

    protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "First":
                intCurrentPageNo = 1;
                break;
            case "Last":
                intCurrentPageNo = Int32.Parse(TotalPages.Text);
                break;
            case "Next":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) + 1;
                break;
            case "Prev":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) - 1;
                break;
        }

      //  HIDCurrentPageNo.Value = intCurrentPageNo.ToString();

        DisplayDocFlowDtl();

    }

    private void DisplayDocFlowDtl()
    {
      //  SqlConnection sqlConn = new SqlConnection(strConnection);

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        //if (strflow == "0")
        //{
        sqlCommand.CommandText = "webx_booking_summaryDet";
        //}
        //else
        //{
        //    sqlCommand.CommandText = "webx_UNI_DKT_DLY_Flow_det";
        //}

                   

        
       // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strsetdt.Split('-');
        
        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@ORGNCD", mylocstr);
        //sqlCommand.Parameters.AddWithValue("@CSGNCD", mycuststr);
        sqlCommand.Parameters.AddWithValue("@RPTMODE", myreppara);
        //sqlCommand.Parameters.AddWithValue("@setdate", strsetdt);



       // sqlCommand.Parameters.AddWithValue("@FROMDT", "1 may 2007");
       // sqlCommand.Parameters.AddWithValue("@TODT", "15 may 2007");
       // sqlCommand.Parameters.AddWithValue("@ORGNCD", "AMD");
       //// sqlCommand.Parameters.AddWithValue("@CSGNCD", "");
       // sqlCommand.Parameters.AddWithValue("@RPTMODE", "1");
       //// sqlCommand.Parameters.AddWithValue("@setdate", "dockdt");





        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        DataSet dsPages = new DataSet();

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;
           // HIDCurrentPageNo.Value = "1";
            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

        //try
        //{

        //    sqlDA.Fill(ds);
       
        //    GridView1.Visible = true;

        //    GridView1.DataSource = ds;
        //    GridView1.DataBind();

        //}
        //catch (Exception e)
        //{
        //    lblcust.Text = e.Message;
        //}


        //         yet to Comp



        sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtDOCFLOW");
        sqlDA.Fill(dsPages);



        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;


            tblPageNavigation.Visible = false;
            tblButtons.Visible = false;
            //lblComment.Visible = false;
        }
        else
        {
            double dblTotalRecords = dsPages.Tables[0].Rows.Count;
            double dblTotalPages = Convert.ToDouble(System.Math.Ceiling(Convert.ToDecimal(dblTotalRecords / intPageSize)));

            //Logic for Managing Page Navigation Links
            if (intCurrentPageNo == 1)
            {
                FirstPage.Enabled = false;
                PreviousPage.Enabled = false;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }
            else if (intCurrentPageNo == dblTotalPages)
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = false;
                LastPage.Enabled = false;
            }
            else
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }

            //Logic for populating Page No.'s in Drop Down List for Page
          //  ddlPages.Items.Clear();

            ListItem lItem;

            for (int i = 1; i <= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                //ddlPages.Items.Add(lItem);

                //if (i == Convert.ToInt32(HIDCurrentPageNo.Value))
                //{
                //    ddlPages.SelectedIndex = ddlPages.Items.Count - 1;
                //}

                lItem = null;
            }

            TotalPages.Text = dblTotalPages.ToString();

            DataTable dt = new DataTable();


            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("dockno", typeof(string));
            dt.Columns.Add("DESTCD", typeof(string));
            dt.Columns.Add("csgnnm", typeof(string));
            dt.Columns.Add("csgenm", typeof(string));
            dt.Columns.Add("dockdt", typeof(string));
            dt.Columns.Add("cdeldt", typeof(string));
            //dt.Columns.Add("last_loc", typeof(string));
            dt.Columns.Add("dep_dt", typeof(string));
            dt.Columns.Add("curr_loc", typeof(string));
            dt.Columns.Add("dly_loc1", typeof(string));
            dt.Columns.Add("pkgsno", typeof(string));
            dt.Columns.Add("chrgwt", typeof(string));
            dt.Columns.Add("arrv_dt", typeof(string));
            dt.Columns.Add("dely_dt", typeof(string));
           


            DataRow dr;


            TimeSpan ts;



            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;



            //   string strHrefLink = "popupmenu2('../../finance/Billing/viewprintupdbills/billcover_Print.asp','" + drRows["BILLNO"].ToString() + "',0)";


            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;


                //  dr["aHrefLink"] = strHrefLink;

               // dr["locname"] = drRows["locname"].ToString() + " : " + drRows["loccode"].ToString();

                //*********dr[" "] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();


                dr["dockno"] = drRows["dockno"].ToString();
                dr["DESTCD"] = drRows["DESTCD"].ToString();
                dr["csgnnm"] = drRows["csgnnm"].ToString();
                dr["csgenm"] = drRows["csgenm"].ToString();
                if (drRows["dockdt"] is DBNull)
                {

                }
                else
                {
                    dr["dockdt"] = Convert.ToDateTime(drRows["dockdt"]).ToString("dd MMM yyyy ");
                
                }
                if (drRows["cdeldt"] is DBNull)
                {

                }
                else
                {
                    dr["cdeldt"] = Convert.ToDateTime(drRows["cdeldt"]).ToString("dd MMM yyyy");

                }
                if (drRows["dep_dt"] is DBNull)
                {

                }
                else
                {
                    if (drRows["dep_dt"].ToString().CompareTo("")==0)
                    {

                        dr["dep_dt"] = "-";
                    }
                    else
                    {

                        dr["dep_dt"] = Convert.ToDateTime(drRows["dep_dt"]).ToString("dd MMM yyyy");
                    }

                }
                if (drRows["arrv_dt"] is DBNull)
                {

                }
                else
                {
                    dr["arrv_dt"] = Convert.ToDateTime(drRows["arrv_dt"]).ToString("dd MMM yyyy");

                }
                if (drRows["dely_dt"] is DBNull)
                {

                }
                else
                {
                    dr["dely_dt"] = Convert.ToDateTime(drRows["dely_dt"]).ToString("dd MMM yyyy");

                }


                
                
                
                dr["curr_loc"] = drRows["DOC_CURLOC"].ToString();
                dr["dly_loc1"] = drRows["dly_loc"].ToString();
                dr["pkgsno"] = drRows["pkgsno"].ToString();
                dr["chrgwt"] = drRows["chrgwt"].ToString();
                
              


                dt.Rows.Add(dr);


                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();



            }

        }



    }
    protected void csv(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("SandyCust.csv"), false);

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
        //fs = System.IO.File.Open(Server.MapPath("SandyCust.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Sandy123.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

    }

   
}

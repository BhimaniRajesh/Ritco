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
    public static int intPageSize = 1000;
    public static string mylocstr;
    public static string mycuststr;
    public static string sublocstr;
    public static string mydt;
    public static string myreppara;
    public static string strsetdt;
    public DataTable dt = new DataTable();
    public int HIDCurrentPageNo = 1; 
    public static string strflow;

    protected void Page_Load(object sender, EventArgs e)
    {

         
        if (!IsPostBack)
        {

            mylocstr = Request.QueryString["loc"].ToString();
            strsetdt = Session["dt"].ToString();

            lblseldet.Text = strsetdt;
                
            lblloc.Text = mylocstr;
            
           myreppara = Request.QueryString["reppara"].ToString();

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
        DisplayDocFlowDtl();

    }

    private void DisplayDocFlowDtl()
    {
        dt.Columns.Clear();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "webx_delivery_performance_Det";
        string[] strArrDtFromTo = strsetdt.Split('-');
        
        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@fromloc", mylocstr);
        sqlCommand.Parameters.AddWithValue("@type", myreppara);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        DataSet dsPages = new DataSet();

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;
            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

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
             ListItem lItem;
            for (int i = 1; i <= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                

                lItem = null;
            }
            TotalPages.Text = dblTotalPages.ToString();
            Session["ddd"] = dt;
            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("dockno", typeof(string));
            dt.Columns.Add("dly_loc", typeof(string));
            dt.Columns.Add("csgnnm", typeof(string));
            dt.Columns.Add("csgenm", typeof(string));
            dt.Columns.Add("dockdt", typeof(string));
            dt.Columns.Add("cdeldt", typeof(string));
            dt.Columns.Add("last_loc", typeof(string));
            dt.Columns.Add("dep_dt", typeof(string));
            dt.Columns.Add("curr_loc", typeof(string));
            dt.Columns.Add("dly_loc1", typeof(string));
            dt.Columns.Add("pkgsno", typeof(string));
            dt.Columns.Add("chrgwt", typeof(string));
            dt.Columns.Add("arrv_dt", typeof(string));
            dt.Columns.Add("dely_dt", typeof(string));
            dt.Columns.Add("docdt_entry", typeof(string));
            dt.Columns.Add("pdcno", typeof(string));
            dt.Columns.Add("pdcdt", typeof(string));
            dt.Columns.Add("diff_days", typeof(string));
            dt.Columns.Add("pdcdt_attempt", typeof(string));
     

            DataRow dr;


            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;
                dr["dockno"] = drRows["dockno"].ToString();
                dr["dly_loc"] = drRows["dly_loc"].ToString();
                if (drRows["csgnnm"] is DBNull)
                {
                    dr["csgnnm"] = "-";
                }
                else
                {
                    dr["csgnnm"] = drRows["csgncd"].ToString() + " : " + drRows["csgnnm"].ToString();
                }

                if (drRows["csgenm"] is DBNull)
                {
                    dr["csgenm"] = "-";
                }
                else
                {

                    dr["csgenm"] = drRows["csgenm"].ToString();
                }
                if (drRows["dockdt"] is DBNull)
                {
                    dr["dockdt"] = "-";
                }
                else
                {
                    dr["dockdt"] = Convert.ToDateTime(drRows["dockdt"]).ToString("dd MMM yyyy ");
                
                }
                if (drRows["cdeldt"] is DBNull)
                {
                    dr["cdeldt"] = "-";

                }
                else
                {
                    dr["cdeldt"] = Convert.ToDateTime(drRows["cdeldt"]).ToString("dd MMM yyyy");

                }
                if (drRows["dep_dt"] is DBNull)
                {
                    dr["dep_dt"] = "-";
                }
                else
                {
                    dr["dep_dt"] = Convert.ToDateTime(drRows["dep_dt"]).ToString("dd MMM yyyy");

                }
                if (drRows["arrv_dt"] is DBNull)
                {
                    dr["arrv_dt"] = "-";
                }
                else
                {
                    dr["arrv_dt"] = Convert.ToDateTime(drRows["arrv_dt"]).ToString("dd MMM yyyy");

                }
                if (drRows["dely_dt"] is DBNull)
                {
                    dr["dely_dt"] = "-";

                }
                else
                {
                    dr["dely_dt"] = Convert.ToDateTime(drRows["dely_dt"]).ToString("dd MMM yyyy");

                }

                if (drRows["dockdt_entry"] is DBNull)
                {
                    dr["dockdt_entry"] = "-";
                }
                else
                {
                    dr["docdt_entry"] = Convert.ToDateTime(drRows["dockdt_entry"]).ToString("dd MMM yyyy ");

                }



                dr["curr_loc"] = drRows["curr_loc"].ToString();
                dr["dly_loc1"] = drRows["dly_loc"].ToString();
                dr["pkgsno"] = drRows["pkgsno"].ToString();
                dr["chrgwt"] = drRows["chrgwt"].ToString();

                dr["pdcno"] = drRows["pdcno"].ToString();
              
                if (drRows["pdcdt"] is DBNull)
                {
                    dr["pdcdt"] = "-";
                }
                else
                {
                    dr["pdcdt"] = Convert.ToDateTime(drRows["pdcdt"]).ToString("dd MMM yyyy");
                }

                dr["diff_days"] = drRows["diff_days"].ToString();
                dr["last_loc"] = drRows["last_loc"].ToString();


                if (drRows["pdcdt_attempt"] is DBNull)
                {
                    dr["pdcdt_attempt"] = "-";
                }
                else
                {
                    dr["pdcdt_attempt"] = Convert.ToDateTime(drRows["pdcdt_attempt"]).ToString("dd MMM yyyy");
                }

                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();

                if (rptBillDetails.Items.Count <= 10)
                {
                    FirstPage.Visible = false;
                    NextPage.Visible = false;
                    LastPage.Visible = false;
                    PreviousPage.Visible = false;
                
                }


            }

        }

    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("SandyCust.csv"), false);
       // DataTable dt1 = Session["ddd"];
         int iColCount = dt.Columns.Count;
        for (int i = 0; i < iColCount; i++)
        {
            sw.Write(dt.Columns[i]);
            if (i < iColCount - 1)
            {
                sw.Write(",");
            }
        }
        sw.Write(sw.NewLine);
        // Now write all the rows.
        foreach (DataRow dr in dt.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr[i]))
                {
                    sw.Write(dr[i].ToString());
                }
                if (i < iColCount - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
        }
        sw.Close();






        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("SandyCust.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "Sandy123.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();
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

            san1.Border = 1;
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Delivery_performance_detail.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayDocFlowDtl();
            san1.RenderControl(hw);


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

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

public partial class OutStanding_BillDtl : System.Web.UI.Page
{
    public static string stragefrm;
    public static string strageto;
    public static string strbilltype;
    public static string strdttype;
    public static string strdt;
    public static string lo, lo2;
    public static string myflg, strcst, strcst2;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            stragefrm = Request.QueryString["dfrm"].ToString();
            strageto = Request.QueryString["dto"].ToString();
            strbilltype = Session["billtype"].ToString();
            strdttype = Session["dttype"].ToString();
            strdt = Session["ASONDT"].ToString();
            lo2 = Request.QueryString["lo"].ToString();
            strcst = Request.QueryString["lo"].ToString();
            strcst2 = strcst;

            lblageos.Text = stragefrm + " - " + strageto;
            lblBillingParty.Text = lo2;
            lblBillingType.Text = strbilltype;
            lbldatetype.Text = strdttype;

            DisplayOS();

        }

    }

    public string GetLocation(string LocCode)
    {

        string tmpBranch = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;


        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "webx_Check_Location";


        sqlCommand.Parameters.AddWithValue("@BRCD", LocCode);

        SqlDataReader dr;

        dr = sqlCommand.ExecuteReader();




        while (dr.Read())
        {
            tmpBranch = dr["LocName"].ToString();
        }
        return (tmpBranch);

    }


    public void DisplayOS()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;


        sqlCommand.CommandType = CommandType.StoredProcedure;


        //    exec webx_oustandingSummary_new3 'ALL',0,500,'BILLCOLBRCD','ALL','BDUEDT','-','' 

        //exec webx_outstanding_cust_new2 'all','-365','365','-','all','bgndt',''

        sqlCommand.CommandText = "webx_oustandingSummary_Ver_08";


        sqlCommand.Parameters.AddWithValue("@CUSTCD", strcst2);
        sqlCommand.Parameters.AddWithValue("@AGEEFROM", stragefrm);
        sqlCommand.Parameters.AddWithValue("@AGEETO", strageto);
        sqlCommand.Parameters.AddWithValue("@Bill_loc", "");
        sqlCommand.Parameters.AddWithValue("@ORGNCD", "All");
        sqlCommand.Parameters.AddWithValue("@DATE", strdttype);
        sqlCommand.Parameters.AddWithValue("@billtype", strbilltype);
        sqlCommand.Parameters.AddWithValue("@Asondate", strdt);



        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);


        DataTable dt = new DataTable();
        dt.Columns.Add("PTMSCD", typeof(string));
        dt.Columns.Add("BILLNO", typeof(string));
        dt.Columns.Add("BILLTYPE", typeof(string));
        dt.Columns.Add("BILLCOLBRCD", typeof(string));
        dt.Columns.Add("BILLSUBBRCD", typeof(string));
        dt.Columns.Add("BGNDT", typeof(string));
        dt.Columns.Add("BSBDT", typeof(string));
        dt.Columns.Add("BDUEDT", typeof(string));
        dt.Columns.Add("OVERDAYS", typeof(string));
        dt.Columns.Add("BCLDT", typeof(string));
        dt.Columns.Add("SERVICETAXPAYABLE", typeof(string));
        dt.Columns.Add("BILLAMT", typeof(string));
        dt.Columns.Add("CLAMT", typeof(string));
        dt.Columns.Add("PENDAMT", typeof(string));

        DataRow dr;

        string cbr, sbr, tt;

        TimeSpan t;
        DateTime t1, t2;
        double tot1 = 0, tot2 = 0, tot3 = 0, tot4 = 0;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();


            dr["BILLNO"] = drRows["BILLNO"].ToString();

            dr["BILLTYPE"] = GetBillType(Convert.ToInt16(drRows["PAYBAS"].ToString()));
            dr["PTMSCD"] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();


            //cbr = GetLocation(drRows["BILLCOLBRCD"].ToString());

            dr["BILLCOLBRCD"] = drRows["BILLCOLBRCD"].ToString();// + " : " + cbr;

        //    sbr = GetLocation(drRows["BILLSUBBRCD"].ToString());

            dr["BILLSUBBRCD"] = drRows["BILLSUBBRCD"].ToString();// +" : " + sbr;
            dr["BGNDT"] = Convert.ToDateTime(drRows["BGNDT"]).ToString("dd MMM yyyy");
            if (drRows["BSBDT"] is DBNull)
            {
                dr["BSBDT"] = "-";
            }
            else
            {

                dr["BSBDT"] = Convert.ToDateTime(drRows["BSBDT"]).ToString("dd MMM yyyy");
            }

            dr["BDUEDT"] = Convert.ToDateTime(drRows["BDUEDT"]).ToString("dd MMM yyyy");

            t1 = Convert.ToDateTime(drRows["BDUEDT"]);
            t2 = System.DateTime.Today;



            tt = Convert.ToString(t2.Subtract(t1).Days);

            int te = Convert.ToInt16(tt);
            if (te <= 0)
            {
                tt = "0";
            }

            dr["OVERDAYS"] = tt;

            if (drRows["BCLDT"] is DBNull)
            {
                dr["BCLDT"] = "-";
            }
            else
            {

                dr["BCLDT"] = drRows["BCLDT"].ToString();
            }




            if (drRows["SERVICETAXPAYABLE"] is DBNull)
            {

            }
            else
            {

                dr["SERVICETAXPAYABLE"] = Convert.ToDouble(drRows["SERVICETAXPAYABLE"]).ToString("F2");
                tot1 += Convert.ToDouble(drRows["SERVICETAXPAYABLE"].ToString());
            }


            //dr["SERVICETAXPAYABLE"] = Convert.ToDouble(drRows["SERVICETAXPAYABLE"]).ToString("F2");

            //  tot1 += Convert.ToDouble(drRows["SERVICETAXPAYABLE"].ToString());


            //dr["BILLAMT"] = Convert.ToDouble(drRows["BILLAMT"]).ToString("F2");
            //tot2 += Convert.ToDouble(drRows["BILLAMT"].ToString());


            if (drRows["BILLAMT"] is DBNull)
            {

            }
            else
            {

                dr["BILLAMT"] = Convert.ToDouble(drRows["BILLAMT"]).ToString("F2");
                tot2 += Convert.ToDouble(drRows["BILLAMT"].ToString());
            }



            if (drRows["CLAMT"] is DBNull)
            {
                dr["CLAMT"] = "0.00";
            }
            else
            {

                dr["CLAMT"] = Convert.ToDouble(drRows["CLAMT"]).ToString("F2");
                tot3 += Convert.ToDouble(drRows["CLAMT"].ToString());
            }




            if (drRows["pendamt"] is DBNull)
            {
                dr["pendamt"] = "0.00";
            }
            else
            {

                dr["pendamt"] = Convert.ToDouble(drRows["pendamt"]).ToString("F2");
                tot3 += Convert.ToDouble(drRows["pendamt"].ToString());
            }

            //dr["pendamt"] = Convert.ToDouble(drRows["pendamt"]).ToString("F2");
            //tot4 += Convert.ToDouble(drRows["pendamt"].ToString());

            dt.Rows.Add(dr);


        }

        GridView1.DataSource = dt;
          GridView1.DataBind();


        GridView1.FooterRow.Cells[10].Text = "Total :";

        GridView1.FooterRow.Cells[11].Text = tot1.ToString("F2");
        GridView1.FooterRow.Cells[12].Text = tot2.ToString("F2");
        GridView1.FooterRow.Cells[14].Text = tot3.ToString("F2");
        GridView1.FooterRow.Cells[13].Text = tot4.ToString("F2");



    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;

        DisplayOS();


    }
    protected void btn_csv_Click2(object sender, EventArgs e)
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

            DisplayOS();
            GridView1.AllowPaging = false;
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

    private string GetBillType(int intBillTypeValue)
    {
        string strBillType = "";
        switch (intBillTypeValue)
        {
            case 1:
                strBillType = "Paid";
                break;
            case 2:
                strBillType = "TBB";
                break;
            case 3:
                strBillType = "To Pay";
                break;
            case 4:
                strBillType = "Misc.";
                break;
            case 5:
                strBillType = "Cancelled";
                break;
            case 6:
                strBillType = "Octroi";
                break;
            case 7:
                strBillType = "Supplimentry";
                break;
            case 8:
                strBillType = "Trial TBB";
                break;
        }

        return strBillType;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }



    protected void btnPrint_ServerClick(object sender, EventArgs e)
    {

    }
    protected void btnXML_ServerClick(object sender, EventArgs e)
    {

    }
}

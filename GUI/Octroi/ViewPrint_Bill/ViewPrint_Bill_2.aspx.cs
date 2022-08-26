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

    public static string strDateRange, strbillno, strcust, strmrtype, para, strdocno, strdocsf;
    public static SqlConnection conn;
    public  DataSet ds = new DataSet();
    string strSql;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            para = Request.QueryString["para1"].ToString();
          
            if (para == "b")
            {
                strbillno = Request.QueryString["strbillno"].ToString();
                strDateRange = "";
                strdocno = "";                
                strmrtype = "";
                //strbillno = "";
                lblmr.Text = strbillno;
                p2.Style["display"] = "block";
            }
            else if (para == "d")
            {
                strdocno = Request.QueryString["docno"].ToString();
                strDateRange = "";
                strbillno = "";
                strmrtype = "";
                
                p3.Style["display"] = "block";
                 
            }
            else
            {
                strdocno = "";
                strbillno = "";
                strcust = Request.QueryString["strcust"].ToString();
                strDateRange = Request.QueryString["strdt"].ToString();
                strmrtype = Request.QueryString["strmrtype"].ToString();
                p1.Style["display"] = "block";
           
            }
            
            DipsplayReport();
        }
       
    }

    public void DipsplayReport()
    {

        ds.Clear(); 

        string strfrmdt="";
        string strtodt="";
         
          if (strcust == "")
            {
                lblcust.Text = "All";
            }
            else
            {
                lblcust.Text = strcust;
            }

            if (strmrtype == "")
            {
                lblseldet.Text = "All";
            }
            else
            {
                lblbilltype.Text = "OCTROI";
            }

            if (strDateRange == "")
            {
                lblseldet.Text = "-";
            }

            else
            {
                string[] strArrDtFromTo = strDateRange.Split('-');
                strfrmdt = strArrDtFromTo[0];
                strtodt = strArrDtFromTo[1];
                
             //DateTime strfrmdt = Convert.ToDateTime(strArrDtFromTo[0]);
             //DateTime strtodt = Convert.ToDateTime(strArrDtFromTo[1]);
                string[] strfrmdt1 = strfrmdt.Split('/');
                string[] strtodt1 = strtodt.Split('/');

                string strdt1 = Convert.ToDateTime(strfrmdt1[1] + "/" + strfrmdt1[0] + "/" + strfrmdt1[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strtodt1[1] + "/" + strtodt1[0] + "/" + strtodt1[2]).ToString("dd MMM yy");
                lblseldet.Text = strdt1;
            }
         

          conn.Open();
         
        
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;
        cmd.CommandType = CommandType.Text;

        if (para == "a")
        {
            if (lblcust.Text.CompareTo("All") == 0)
            {
                strSql = "select billno,bgndt,ptmscd,ptmsnm,billamt from Webx_billmst where  Paybas = '6' and bgndt between '" + strfrmdt + "' and '" + strtodt + "'";
            }
            else
            {
                strSql = "select billno,bgndt,ptmscd,ptmsnm,billamt from Webx_billmst where ptmscd ='" + lblcust.Text + "'  and Paybas = '6' and bgndt between '" + strfrmdt + "' and '" + strtodt + "'";
            }
        }
        else
        {
            strSql = "select billno,bgndt,ptmscd,ptmsnm,billamt from Webx_billmst where billno ='" + strbillno + "'"; 
        }

        cmd.CommandText = strSql; 
        
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds, "tab");
        //da.Fill(ds);

        ds.Tables[0].Columns.Add("Sno");
        //ds.Tables[0].Columns.Add("bgndt");

        int sno = 1;

        //ds.Tables[0].Rows["report_loc"].ToString();

        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            dr["Sno"] = sno;
            sno++;

            string s = Convert.ToDateTime(dr["bgndt"]).ToString("dd MMM yyyy");
            dr["bgndt"] = s;
        }
         
        
        GV_Booking.DataSource=ds;
 
        GV_Booking.DataBind();
        if (GV_Booking.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;

        }
        if (GV_Booking.Rows.Count == 0)
        {
            //btn_submit.Visible = false;
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
}

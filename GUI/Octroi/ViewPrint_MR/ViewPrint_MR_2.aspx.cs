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

    public static string strDateRange, strmrno, strcust, strmrtype, para, strdocno, strdocsf;
    public static SqlConnection conn;
    public  DataSet ds = new DataSet();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            para = Request.QueryString["para1"].ToString();
          
            if (para == "m")
            {
                strmrno = Request.QueryString["strmrno"].ToString();
                strDateRange = "";
                strdocno = "";                
                strmrtype = "";
                strdocno = "";
                lblmr.Text = strmrno;
                p2.Style["display"] = "block";
            }
            else if (para == "d")
            {
                strdocno = Request.QueryString["docno"].ToString();
                strDateRange = "";
                strmrno = "";
                strmrtype = "";
                lbldoc.Text = strdocno;
                p3.Style["display"] = "block";
                 
            }
            else
            {
                strdocno = "";
                strmrno = "";
                strcust = Request.QueryString["strcust"].ToString();
                strDateRange = Request.QueryString["strdt"].ToString();
                strmrtype = Request.QueryString["strmrtype"].ToString();
                p1.Style["display"] = "block";
           
            }
            
            DipsplayReport();
        }
        /*btn_submit.Visible = false;
        foreach (GridViewRow gr in GV_Booking.Rows)
        {
            if (((CheckBox)gr.FindControl("chkbill")).Checked == true)
                btn_submit.Visible = true;
        }*/
        //chkbill.Attributes.Add("onclick", "javascript:return checked('"+ ch)");



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
                lblmrtype.Text = "OCTROI";
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
                lblseldet.Text = strDateRange;
            }
         

          conn.Open();
         
        
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;

        cmd.CommandType = CommandType.StoredProcedure;


        cmd.CommandText = "WEBX_MR_OCTORI_LIST";

        strdocsf = ".";
        //strmrtype = "";
        cmd.Parameters.AddWithValue("@DATEFROM", strfrmdt);
        cmd.Parameters.AddWithValue("@DATETO", strtodt);
        cmd.Parameters.AddWithValue("@MRNO", strmrno);
        cmd.Parameters.AddWithValue("@DOCKNO", strdocno);
        cmd.Parameters.AddWithValue("@DOCKSF", strdocsf);
        cmd.Parameters.AddWithValue("@MRTYPE", strmrtype);

         
 

        SqlDataAdapter da = new SqlDataAdapter(cmd);

      
        da.Fill(ds, "tab");
        //da.Fill(ds);


        ds.Tables[0].Columns.Add("Sno");
        ds.Tables[0].Columns.Add("mrdt");
         

        int sno = 1;

        //ds.Tables[0].Rows["report_loc"].ToString();

        foreach (DataRow dr in ds.Tables[0].Rows)
        {

            dr["Sno"] = sno;
            sno++;

            string s = Convert.ToDateTime(dr["MRSDT"]).ToString("dd MMM yyyy");
            dr["mrdt"] = s;
           
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

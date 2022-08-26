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

using Microsoft.ApplicationBlocks.Data;


public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strDateRange, strloc, strro, strloc2, strro2, strlogininstence, strreptype, reppara, sqlorg, sqlorg1, sqldest, dest_str, docketis;
    public DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            docketis = Session["DocketCalledAs"].ToString();
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
            }
            else
            {
               // strDateRange = Request.QueryString["strDateRange"].ToString();
                Session["dt"] = strDateRange;
                strloc = Request.QueryString["Cur_loc"].ToString();
                strro = "All";
                strloc2 = Request.QueryString["dly_loc"].ToString();
                strro2 = "All";
                //strreptype = Request.QueryString["reptype"].ToString();
            
            }






        }





        if (strloc2 == "" || strloc2 == "All")
        {
            strloc2 = "All";
            if (strro2 == "All" || strro2 == "")
            {
                strro2 = "All";
                dest_str = "";
                sqldest = "";


            }
            else
            {
                dest_str = " and  d.reassign_destcd in (select loccode from webx_location where report_loc='" + strro2 + "')";
                sqldest = " and  d.reassign_destcd in (select loccode from webx_location where report_loc='" + strro2 + "')";


            }

        }
        else
        {
            dest_str = " and (  d.reassign_destcd ='" +strloc2+ "' or d.reassign_destcd ='" + strro2 + "' ) ";
            sqldest = " and (  d.reassign_destcd ='" +strloc2+ "' or d.reassign_destcd ='" + strro2 +"' ) ";

        
        }

        //if (strloc2 == "All" && strro2 == "All")
        //{
        //    sqldest = "";
        
        //}


        
        if (strloc == "All" || strloc == "")
         {
             strloc = "All";

             if (strro == "All" || strro == "")
             {
                 strro = "All";
                 
                 sqlorg = " ";
                 sqlorg1 = "";

             }
             else
             {
                 sqlorg = " and  d.doc_curloc in (select loccode from webx_location where report_loc='" + strro + "')";
                 sqlorg1 = " and  d.doc_curloc in (select loccode from webx_location where report_loc='" + strro + "')";


             } 

         }
         else
         {
             sqlorg = " and (  d.doc_curloc ='" + strloc + "' or d.reassign_destcd ='" + strro + "' ) ";
             sqlorg1 = " and (  d.doc_curloc ='" + strloc + "' or d.reassign_destcd ='" + strro + "' ) ";


         }

         //if (strloc == "All" && strro == "All")
         //{
         //    sqldest = "";

         //}

        // lables......
        lblseldet.Text = strDateRange;
        lblloc.Text = strloc + " - " + strloc2;
        lblro.Text = strro + " - " + strro2;



        DipsplaySumm();
    }


    public void DipsplaySumm()
    {

        
     /*===============   old working   =================
        
        //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");


      SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
      conn.Open();


      string[] strArrDtFromTo = strDateRange.Split('-');
      string qry = "select d.reassign_destcd,reassign_destcd_nm=(select top 1 locname from webx_location where loccode=reassign_destcd),d.doc_curloc,doc_curloc_nm=(select top 1 locname from webx_location where loccode=doc_curloc),count(case when d.dockno is not null then 1 end) as TOT_DKT,count (case when d.dkt_detain ='Y' then 1 end) as TOT_DETAIN_DKT,sum(d.actuwt) as TOT_ACTUWT,Sum (case when d.paybas ='P03' then DKTTOT end) as TOT_TOPAYFRT,Sum (case when d.paybas is not null then DKTTOT end) as TOT_FRT,sum(pkgsno_pending) as TOT_PACKS from vw_docket_Net d where convert(varchar,arrv_dt,106) between convert(datetime,'" + strArrDtFromTo[0] + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106) and d.doc_curloc <> '' and d.dkt_cancel<>'Y'   and (d.dlypdcno is null and d.thcno is null)  " + sqlorg + sqldest + " and d.docksf='.' group by d.reassign_destcd,d.doc_curloc order by d.doc_curloc,d.reassign_destcd";
      SqlCommand sqlCommand = new SqlCommand(qry, conn);
     // SqlCommand sqlCommand = new SqlCommand("select d.reassign_destcd,d.doc_curloc,count (case when d.dockno is not null then 1 end) as TOT_DKT,count (case when d.dkt_detain ='Y' then 1 end) as TOT_DETAIN_DKT,sum(d.actuwt) as TOT_ACTUWT,Sum (case when d.paybas ='P03' then DKTTOT end) as TOT_TOPAYFRT,Sum (case when d.paybas is not null then DKTTOT end) as TOT_FRT,sum(pkgsno_pending) as TOT_PACKS from vw_uni_docket d where convert(varchar,arrv_dt,106) between convert(datetime,'" + strArrDtFromTo[0] + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106) and d.dkt_cancel<>'Y'   and (d.dlypdcno is null and d.thcno is null)  " + sqlorg + sqldest + " and d.docksf='.' group by d.doc_curloc,d.reassign_destcd order by d.doc_curloc,d.reassign_destcd", conn);
       
        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

      
        da.Fill(ds, "tab");

 
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            dr["reassign_destcd_nm"]=dr["reassign_destcd"].ToString()+" : "+dr["reassign_destcd_nm"].ToString();
            dr["doc_curloc_nm"] = dr["doc_curloc"].ToString() + " : " + dr["doc_curloc_nm"].ToString();


            //if(dr["TOT_TOPAYFRT"].ToString() is DBNull)
            //{
            //    dr["TOT_TOPAYFRT"] = "00000";
            //}


            if (dr["TOT_TOPAYFRT"].ToString() =="")
            {
                dr["TOT_TOPAYFRT"] = "0";
            }
            
            
            if(dr["TOT_FRT"].ToString() =="")
            {
                dr["TOT_FRT"] = "0";
            }

            if (dr["TOT_PACKS"].ToString() =="")
            {
                dr["TOT_PACKS"] = "0";
            }



        }

      * 
      * 
      * =====================================================================*/


        ds.Clear();

      SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
   // SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");


               
        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "WebxNet_LOCSTOCK_New";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@FROM_LO", strloc);
        sqlCommand.Parameters.AddWithValue("@FROM_RO", strro);
        sqlCommand.Parameters.AddWithValue("@TO_LO", strloc2);
        sqlCommand.Parameters.AddWithValue("@TO_RO", strro2);
     //   sqlCommand.Parameters.AddWithValue("@dly_type", "All");

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);



        sqlDA.Fill(ds);


        GV_Summ.DataSource = ds;




        GV_Summ.DataBind();
        if (GV_Summ.Rows.Count == 0)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;
            Button1.Visible = false;
        }

        if (GV_Summ.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;
            //Button1.Visible = false;
        }
     

    }
    
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Summ.PageIndex = e.NewPageIndex;

        DipsplaySumm();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Summ.PageCount;
        GV_Summ.PageIndex = i;

        DipsplaySumm();



    }
    public void fst(object sender, EventArgs e)
    {
        GV_Summ.PageIndex = 0;

        DipsplaySumm();

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
            GV_Summ.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Location_Stock.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DipsplaySumm();
            GV_Summ.RenderControl(hw);


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

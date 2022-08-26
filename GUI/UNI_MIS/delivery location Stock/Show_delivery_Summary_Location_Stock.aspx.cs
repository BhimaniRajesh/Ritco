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

    public static string strDateRange, strloc, strro, strloc2, strro2, strlogininstence, strreptype, reppara,sqlorg,sqlorg1,sqldest, dest_str;
    public static  DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
           
            DipsplaySumm();
        }
    }


    public void DipsplaySumm()
    {
        ds.Clear();

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
            Session["dt"] = strDateRange;
            strloc = Request.QueryString["Cur_loc"].ToString();
            strro = "All";
            

            //strreptype = Request.QueryString["reptype"].ToString();

        }




        //SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        // SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");


        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "WebxNet_LOCSTOCK_DLY_New";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');
        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblro.Text = strro;

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@from_ro", strro);
        sqlCommand.Parameters.AddWithValue("@from_lo", strloc);


        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);



        sqlDA.Fill(ds);



       /***********************************************************
        * Session["strro"] = strro;

        if (strloc == "All")
        {
            strloc = "All";

            if (strro == "All" || strro == "")
            {

                sqlorg = " ";
                sqlorg1 = "";

            }
            else
            {

                sqlorg = "and  d.reassign_destcd in (select loccode from webx_location where report_loc='" + strro + "')";


            }

        }
        else
        {
            sqlorg = "and (  d.reassign_destcd ='" + strloc + "' or d.reassign_destcd ='" + strro + "' )";


        }

        // lables......
        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblro.Text = strro;

       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_Ver2_Live;");
      conn.Open();

    


      string[] strArrDtFromTo = strDateRange.Split('-');
      string qry = "select d.reassign_destcd,count (case when d.dockno is not null then 1 end) as TOT_DKT,count (case when d.dkt_detain ='Y' then 1 end) as TOT_DETAIN_DKT,sum(d.actuwt) as TOT_ACTUWT,Sum (case when d.paybas ='P03' then DKTTOT end) as TOT_TOPAYFRT,Sum (case when d.paybas is not null then DKTTOT end) as TOT_FRT,sum(pkgsno_pending) as TOT_PACKS from vw_Docket_net d,webx_location l where convert(varchar,arrv_dt,106) between convert(datetime,'" + strArrDtFromTo[0] + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106) and d.dely_dt is null and doc_curloc=reassign_destcd and tohub_br='' and l.loccode=d.doc_curloc and d.docksf='.' " + sqlorg + "group by d.reassign_destcd order by d.reassign_destcd";
      SqlCommand sqlCommand = new SqlCommand(qry, conn);
     // SqlCommand sqlCommand = new SqlCommand("select d.reassign_destcd,d.doc_curloc,count (case when d.dockno is not null then 1 end) as TOT_DKT,count (case when d.dkt_detain ='Y' then 1 end) as TOT_DETAIN_DKT,sum(d.actuwt) as TOT_ACTUWT,Sum (case when d.paybas ='P03' then DKTTOT end) as TOT_TOPAYFRT,Sum (case when d.paybas is not null then DKTTOT end) as TOT_FRT,sum(pkgsno_pending) as TOT_PACKS from vw_uni_docket d where convert(varchar,arrv_dt,106) between convert(datetime,'" + strArrDtFromTo[0] + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106) and d.dkt_cancel<>'Y'   and (d.dlypdcno is null and d.thcno is null)  " + sqlorg + sqldest + " and d.docksf='.' group by d.doc_curloc,d.reassign_destcd order by d.doc_curloc,d.reassign_destcd", conn);
       
        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
*/
      
       // da.Fill(ds, "tab");



        GV_Summ.DataSource = ds;




        GV_Summ.DataBind();

        if (ds.Tables[0].Rows.Count == 0)
        {
            Button1.Visible = false;
        }

    }
    

    
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Summ.PageIndex = e.NewPageIndex;

       // DipsplaySumm();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Summ.PageCount;
        GV_Summ.PageIndex = i;

      //  DipsplaySumm();



    }
    public void fst(object sender, EventArgs e)
    {
        GV_Summ.PageIndex = 0;

      //  DipsplaySumm();

    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("SandyCust.csv"), false);

        DataTable dt = ds.Tables[0];
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
}

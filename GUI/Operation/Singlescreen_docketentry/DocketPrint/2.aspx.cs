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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Data.SqlClient;
  

public partial class GUI_Tracking_2 : System.Web.UI.Page
{
    public static SqlDataReader dr;
    public static SqlDataReader dr1;
    public static SqlDataReader dr2,dr3;
    public static string dockno1;
    public static string orgncd;
    public static string dockdt;
    public static string destcd;
    public static string reassign_destcd;
    public static string from_loc;
    public static string dly_loc;
    public static string doc_curloc;
    public static string service_class;
    public static string chargewt;
    public static string paybas;
    public static string trn_mod;
    public static string CSGNcd;
    public static string CSGecd;
    public static string CDELDT;
    public static string ARRV_DT ;
    public static string  dely_dt;
    public static string  PDCUPDT_ATTEMPT;
    public static string podhocleardate;
    public static string pkgsno;
    public static string thcno, thcbr, thcdt;
    public static string tcno,tcbr,tcdt;
    public static string vehno;
    public static string doc_curloc1;
    public static string POD_File;
    public static string pod;
    public static string rutcd;
    public static string docksf;
    public static string prs_no,prs_date,prs_loc;
    public static string drs_no, drs_date, drs_loc;
    public static string Bill_no, Bill_date, Bill_loc;
    public static string mr_no, mr_date, mr_loc;
    public static string oct_v_no, oct_v_date, oct_v_loc;
    public static string oct_BM_no, oct_BM_date, oct_BM_loc, oct_BM_st, lf_Gen_oct;
    public static string lo_dkt_status, lo_doc_curloc, lo_dockno, lo_dockdt, lo_pdc_loc, lo_prs_no, lo_pdc_date, lo_prs_cumm_day, lo_ls_status, lo_ls_loc, lo_ls_no, lo_ls_date, lo_ls_cumm_day, lo_tc_status, lo_tcbr, lo_tcno, lo_tcdt, lo_tc_cumm_day, lo_thc_status, lo_thcbr, lo_thcno, lo_thcdt, lo_thc_cumm_day, lo_tohub_br, lo_drs_loc, lo_drs_no, lo_drs_date, lo_drs_cumm_day;
    public static string lf_dockno, lf_docksf, lf_orgncd, lf_orgnnm, lf_destcd, lf_destnm, lf_re_destcd, lf_re_destnm, lf_paybas, lf_paybasnm, lf_dockdt, lf_dockdt_f, lf_book_cum_days, lf_msg_b, lf_bgndt, lf_bgndt_f, lf_bill_cum_days, lf_billno, lf_billsubbrcd, lf_msg_sun, lf_bsbdt, lf_bsbdt_f, lf_billsub_cum_days, lf_billcolbrcd, lf_billmrcol_cum_days, lf_mrsdt, lf_mrsdt_f, lf_mrsno, lf_mrssf, lf_mr_cum_days, lf_mrcol_cum_days, lf_finclosedt, lf_finclosedt_f, lf_msg_mrcoll, lf_billcolbrnm, lf_billsubbrnm,IF_MRSNOYN;
    MyFunctions fn = new MyFunctions();
    public static string docknotab1;
    string dockno13 = "";
    string dockno = "";
    SqlConnection cn1;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
            conn.Open();
            cn1.Open(); 
             dockno = Request.QueryString.Get("strDckNo");

            //Response.Write("<br> dockno : " + dockno);
            string sqlstr = "webxNet_Trackinfo";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {

                dockno1 = dr["dockno"].ToString();
                orgncd = dr["orgncd"].ToString();
                dockdt = dr["dockdt"].ToString();
                reassign_destcd = dr["reassign_destcd"].ToString();
                destcd = dr["destcd"].ToString();
                from_loc = dr["from_loc"].ToString();
                dly_loc = dr["dly_loc"].ToString();
                doc_curloc = dr["doc_curloc"].ToString();
                service_class = dr["service_class"].ToString();
                chargewt = dr["chargewt"].ToString();
                paybas = dr["paybas"].ToString();
                trn_mod = dr["trn_mod"].ToString();
                CSGNcd = dr["CSGNcd"].ToString();
                CSGecd = dr["CSGecd"].ToString();
                CDELDT = dr["CDELDT"].ToString();
                ARRV_DT = dr["ARRV_DT"].ToString();
                dely_dt = dr["dely_dt"].ToString();
                PDCUPDT_ATTEMPT = dr["PDCUPDT_ATTEMPT"].ToString();
                podhocleardate = dr["podhocleardate"].ToString();
                pkgsno = dr["pkgsno"].ToString();
                thcno = dr["thcno"].ToString();
                tcno = dr["tcno"].ToString();
                rutcd = dr["rutcd"].ToString();
                docksf = dr["docksf"].ToString();
                vehno = fn.GetVehicle(thcno);
                POD_File = dr["POD_File"].ToString(); ;



                if (dr["POD_File"] is DBNull)
                {
                    pod = "View Scanned POD";

                }
                else
                {
                    pod = "No POD Uploaded";
                }
            }
            dr.Close();
            string sqlstr1 = "select dockno,docksf,doc_curloc=CURLOC+' : ' + (select top 1  locname from webx_location where loccode=d.CURLOC),nEXTLOC AS tohub_br,tcno,thcno,Arrv_dt=(CASE WHEN In_Out='I' THEN atad ELSE '' END) ,actarrv_dt=(case when In_Out is null then '-' when In_Out='I' then (convert(varchar,atad,106)+' '+convert(varchar,atad,108)) end),(select top 1  convert(varchar,actdept_dt,106)+ '  ' + actdept_tm from webx_thchdr  where thcno=d.thcno and sourcehb=d.CURLOC  ) actdept_dt,(select top 1 vehno from webx_thc_summary where thcno=d.thcno ) as vehno from WebX_Trans_Docket_Track d with(NOLOCK) where dockno='" + dockno + "' order by srno ";
            SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);
            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            rptBillDetails.DataSource = ds;
            rptBillDetails.DataBind();
            //BindMovment();
            //GrdPaidFollow.DataSource = ds;
            //GrdPaidFollow.DataBind();  
         }
    }
    //protected void BindMovment()
    //{
    //    SqlDataReader drsub;
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    //DataSet ds = new DataSet();
    //    string thcno, atd, routecode, loccode, le_arrival_str,le_departure_str,ATD_Str;
    //    double le_arrival, le_departure;
    //    thcno = "";
    //    Boolean rcf;
    //    rcf = false;
    //    atd =le_arrival_str=le_departure_str= "";
    //    string sqlstr = "webx_dockt_track";
    //    DataTable dt = new DataTable();
    //    DataColumn dc0 = new DataColumn("thcno",typeof (string)) ;
    //    DataColumn dc1 = new DataColumn("location", typeof(string));
    //    DataColumn dc2 = new DataColumn("transittime", typeof(string));
    //    DataColumn dc3 = new DataColumn("sta", typeof(string));
    //    DataColumn dc4 = new DataColumn("eta", typeof(string));
    //    DataColumn dc5 = new DataColumn("ata", typeof(string));
    //    DataColumn dc6 = new DataColumn("l/e1", typeof(string));
    //    DataColumn dc7 = new DataColumn("std", typeof(string));
    //    DataColumn dc8 = new DataColumn("etd", typeof(string));
    //    DataColumn dc9 = new DataColumn("atd", typeof(string));
    //    DataColumn dc10 = new DataColumn("l/e2", typeof(string));
    //    DataColumn dc11 = new DataColumn("routecode", typeof(string));
    //    dt.Columns.Add(dc0);
    //    dt.Columns.Add(dc1);
    //    dt.Columns.Add(dc2);
    //    dt.Columns.Add(dc3);
    //    dt.Columns.Add(dc4);
    //    dt.Columns.Add(dc5);
    //    dt.Columns.Add(dc6);
    //    dt.Columns.Add(dc7);
    //    dt.Columns.Add(dc8);
    //    dt.Columns.Add(dc9);
    //    dt.Columns.Add(dc10);
    //    dt.Columns.Add(dc11);
    //    DataRow drow;
    //    SqlCommand cmd = new SqlCommand(sqlstr, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    //SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText,conn.ConnectionString);
    //    //da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
    //    cmd.Parameters.AddWithValue("@DOCKNO", dockno);
    //    conn.Open();
    //    dr = cmd.ExecuteReader();
    //    while (dr.Read())
    //    {
    //        drow = dt.NewRow();
    //        if (thcno != Convert.ToString(dr["THC_Number"])) 
    //        {
    //                rcf = true;
    //                //drow["thcno"] = Convert.ToString(dr["THC_Number"]) + " - " + Convert.ToString(dr["vehno"]);
    //                thcno = Convert.ToString(dr["THC_Number"]);
    //                atd = Convert.ToString(dr["ATD"]);
    //                if (atd != "" && atd != null && atd != "-" && atd.Length > 10)
    //                {
    //                    atd = atd.Substring(0, 11);
    //                }
    //        }
    //        drow["thcno"] = Convert.ToString(dr["THC_Number"]) + " - " + Convert.ToString(dr["vehno"]);
    //        drow["location"] = Convert.ToString(dr["sourcehb"]);
    //        drow["routecode"] = Convert.ToString(dr["routecd"]);
    //        drow["transittime"] = Convert.ToString(dr["transit_time"]);

    //        //usp_Schedule_Arrival_Departure
    //        SqlCommand cmd1 = new SqlCommand("usp_Schedule_Arrival_Departure",cn1);
    //        cmd1.CommandType = CommandType.StoredProcedure;
    //        cmd1.Parameters.AddWithValue("@startdate", atd);
    //        cmd1.Parameters.AddWithValue("@routecode", Convert.ToString(dr["routecd"]));
    //        cmd1.Parameters.AddWithValue("@loccode", Convert.ToString(dr["sourcehb"]));
    //        drsub = cmd1.ExecuteReader();
    //        while (drsub.Read())
    //        {
    //            drow["sta"] = Convert.ToString(drsub["sch_arrival_date_time"]);
    //            drow["std"] = Convert.ToString(drsub["sch_departure_date_time"]);
    //        }
    //        drsub.Close();
    //        if (drow["sta"] != "" && Convert.ToString(dr["ata"]) != null && Convert.ToString(dr["ata"]) != "" && Convert.ToString(dr["ata"]) != "-")
    //        {
    //            string sql = "Select round(convert(decimal(12,2),datediff(minute,'"+ drow["sta"] +"','" + dr["ata"] + "')/60.0),2)";
    //            cmd1 = new SqlCommand(sql, cn1);
    //            le_arrival = Convert.ToDouble(cmd1.ExecuteScalar());
    //            if (le_arrival > 0.00)
    //            {
    //                le_arrival_str = "L: " + le_arrival ;
    //            }
    //            else if (le_arrival < 0.00)
    //            {
    //                le_arrival_str = "E: " + le_arrival;
    //            }
    //            else if (le_arrival == 0.00)
    //            {
    //                le_arrival_str = "On Time";
    //            }
    //            le_arrival_str = le_arrival_str.Replace("-", "");
    //            //drow["l/e1"] = le_arrival_str;
    //        }


    //        if (drow["std"] != "" && Convert.ToString(dr["atd"]) != null && Convert.ToString(dr["atd"]) != "" && Convert.ToString(dr["atd"]) != "-")
    //        {
    //            string sql = "Select round(convert(decimal(12,2),datediff(minute,'" + drow["std"] + "','" + Convert.ToString(dr["atd"]) + "')/60.0),2)";
    //            cmd1 = new SqlCommand(sql, cn1);
    //            le_departure = Convert.ToDouble(cmd1.ExecuteScalar());
    //            if (le_departure > 0.00)
    //            {
    //                le_departure_str = "L: " + le_departure;
    //            }
    //            else if (le_departure < 0.00)
    //            {
    //                le_departure_str = "E: " + le_departure;
    //            }
    //            else if (le_departure == 0.00)
    //            {
    //                le_departure_str = "On Time";
    //            }
    //            le_departure_str = le_departure_str.Replace("-", "");
    //            drow["l/e2"] = le_departure_str;
    //        }

    //        if (rcf == true)
    //        {
    //            rcf = false;
    //            drow["sta"] = "N-A";
    //            drow["eta"] = "N-A";
    //            drow["ata"] = "N-A";
    //            drow["l/e1"] = "N-A";
    //        }
    //        else
    //        {
    //            drow["sta"] = Convert.ToString(dr["sta"]).Replace(":00:000", ""); ;

    //            if ((Convert.ToString(dr["eta"]) != "") && (Convert.ToString(dr["eta"]) != null))
    //            {
    //                drow["eta"] = Convert.ToString(dr["eta"]).Substring(0, 17);
    //            }
    //            drow["ata"] = Convert.ToString(dr["ata"]);
    //            drow["l/e1"] = le_arrival_str;
    //        }
    //        ATD_Str = Convert.ToString(dr["atd"]);
    //        if (ATD_Str=="" || ATD_Str == null)
    //        {
    //            drow["std"] = "N-A";
    //            drow["etd"] = "N-A";
    //            drow["atd"] = "N-A";
    //            drow["l/e2"] = "N-A";
    //        }
    //        else
    //        {
    //            drow["std"] = Convert.ToString(dr["std"]).Replace(":00:000", ""); ;
    //            if ((Convert.ToString(dr["etd"]) != "") && (Convert.ToString(dr["etd"]) !=null))
    //            {
    //                drow["etd"] = Convert.ToString(dr["etd"]).Substring(0,17);
    //            }
    //            drow["atd"] = Convert.ToString(dr["atd"]);
    //            drow["l/e2"] = le_departure_str;
    //        }
    //        dt.Rows.Add(drow);   
    //    }
    //    //da.Fill(ds,"table1"); 
    //    dr.Close(); 
    //    GrdPaidFollow.DataSource = dt;
    //    GrdPaidFollow.DataBind();
    //}
    public void DiplayTab1(string dockno)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());



        conn.Open();
        //dockno = Request.QueryString.Get("strDckNo");


        ////----------- Start View and Print ----------
         string sqlstr3 = "webx_Docket_view_print_net";
         SqlCommand cmd3 = new SqlCommand(sqlstr3, conn);
         cmd3.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd3);
         da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;





         //SqlDataReader dr;
         dr3 = cmd3.ExecuteReader();


         while (dr3.Read())
         {

             dockno1 = dr3["dockno"].ToString();
            

             orgncd = dr3["orgncd"].ToString();
             dockdt = dr3["dockdt"].ToString();
             thcno = dr3["thcno"].ToString();
             tcno = dr3["tcno"].ToString();

             prs_no = dr3["bkgpdcno"].ToString();
             prs_loc = dr3["pdc_loc"].ToString();
             prs_date = dr3["pdc_date"].ToString();

             tcno = dr3["tcno"].ToString();
             tcbr = dr3["tcbr"].ToString();
             tcdt = dr3["tcdt"].ToString();

             thcno = dr3["thcno"].ToString();
             thcbr = dr3["thcbr"].ToString();
             thcdt = dr3["thcdt"].ToString();

             drs_no = dr3["dlypdcno"].ToString();
             drs_loc = dr3["drs_loc"].ToString();
             drs_date = dr3["drs_date"].ToString();

             Bill_no = dr3["billno"].ToString();
             Bill_loc = dr3["bbrcd"].ToString();
             Bill_date = dr3["bgndt"].ToString();


             mr_no = dr3["mrsno"].ToString();
             mr_loc = dr3["mrsbr"].ToString();
             mr_date = dr3["mrsdt"].ToString();

             oct_v_no = dr3["voucher_no"].ToString();
             oct_v_loc = dr3["vendor_paiddt"].ToString();
             oct_v_date = dr3["vendor_paidat"].ToString();

             oct_BM_no = dr3["octroi_Doc"].ToString();
             oct_BM_loc = dr3["customer_paidat"].ToString();
             oct_BM_date = dr3["bill_mr_dt"].ToString();

             oct_BM_st = dr3["octroi_bill_mr"].ToString();
         }
         dr3.Close(); 
        //------------------------End view and Print -----
    }
    public void LifeCycleOp(string dockno)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlstr3 = "webx_life_cycle_operation_net";
        SqlCommand cmd3 = new SqlCommand(sqlstr3, conn);
        cmd3.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd3);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        dr3 = cmd3.ExecuteReader();
        while (dr3.Read())
        {
            lo_dkt_status = Convert.ToString(dr3["dkt_status"]);
            lo_doc_curloc = Convert.ToString(dr3["doc_curloc"]); 
            lo_dockno = Convert.ToString(dr3["dockno"]);
            lo_dockdt = Convert.ToString(dr3["dockdt"]);
            lo_pdc_loc = Convert.ToString(dr3["pdc_loc"]);
            lo_prs_no = Convert.ToString(dr3["prs_no"]);
            lo_pdc_date = Convert.ToString(dr3["pdc_date"]);
            lo_prs_cumm_day = Convert.ToString(dr3["prs_cumm_day"]);
            lo_ls_status = Convert.ToString(dr3["ls_status"]);
            lo_ls_loc = Convert.ToString(dr3["ls_loc"]);
            lo_ls_no = Convert.ToString(dr3["ls_no"]);
            lo_ls_date = Convert.ToString(dr3["ls_date"]);
            lo_ls_cumm_day = Convert.ToString(dr3["ls_cumm_day"]);
            lo_tc_status = Convert.ToString(dr3["tc_status"]);
            lo_tcbr = Convert.ToString(dr3["tcbr"]);
            lo_tcno = Convert.ToString(dr3["tcno"]);
            lo_tcdt = Convert.ToString(dr3["tcdt"]);
            lo_tc_cumm_day = Convert.ToString(dr3["tc_cumm_day"]);
            lo_thc_status = Convert.ToString(dr3["thc_status"]);
            lo_thcbr = Convert.ToString(dr3["thcbr"]);
            lo_thcno = Convert.ToString(dr3["thcno"]);
            lo_thcdt = Convert.ToString(dr3["thcdt"]);
            lo_thc_cumm_day = Convert.ToString(dr3["thc_cumm_day"]);
            lo_tohub_br = Convert.ToString(dr3["tohub_br"]);
            lo_drs_loc = Convert.ToString(dr3["drs_loc"]);
            lo_drs_no = Convert.ToString(dr3["drs_no"]);
            lo_drs_date = Convert.ToString(dr3["drs_date"]);
            lo_drs_cumm_day = Convert.ToString(dr3["drs_cumm_day"]);
            //lo_doc_curloc = Convert.ToString(dr3["doc_curloc"]); 
            
        }
        dr3.Close(); 
    }
    protected string getname(string a)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select top 1 locname from webx_location where loccode='" + a + "'";
        SqlCommand cmd = new SqlCommand(sql, conn); 
        string result = Convert.ToString(cmd.ExecuteScalar());
        return result; 
    }
    public void LifeCycleFin(string dockno)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlstr3 = "WEBX_LifeCycle_Fin";
        SqlCommand cmd3 = new SqlCommand(sqlstr3, conn);
        cmd3.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd3);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        dr3 = cmd3.ExecuteReader();
        while (dr3.Read())
        {
            //public static string lf_dockno, lf_docksf, lf_orgncd, lf_destcd, lf_re_destcd, 
            //lf_paybas, lf_dockdt, lf_book_cum_days, 
            //lf_msg_b, lf_bgndt, lf_bill_cum_days, lf_billno, lf_billsubbrcd, msg_sun,
            //lf_bsbdt, lf_billsub_cum_days, lf_billcolbrcd,
            //lf_mrsdt, lf_mrsno,lf_mrssf,
            //lf_mr_cum_days,lf_mrcol_cum_days,lf_finclosedt,lf_msg_coll;
            lf_dockno = Convert.ToString(dr3["dockno"]);
            lf_docksf = Convert.ToString(dr3["docksf"]);
            lf_orgncd = Convert.ToString(dr3["orgncd"]);
            lf_orgnnm = getname(Convert.ToString(dr3["orgncd"])); 
            lf_destcd = Convert.ToString(dr3["destcd"]);
            lf_destnm = getname(Convert.ToString(dr3["destcd"]));
            lf_re_destcd = Convert.ToString(dr3["reassign_destcd"]);
            lf_re_destnm = getname(Convert.ToString(dr3["reassign_destcd"]));
            lf_paybas = Convert.ToString(dr3["paybas"]);
            lf_paybasnm = GetPayMode(Convert.ToString(dr3["paybas"]));
            if (dr3["dockdt"] != System.DBNull.Value)
            {
                lf_dockdt = Convert.ToString(dr3["dockdt"]);
                lf_dockdt_f = Convert.ToDateTime(dr3["dockdt"]).ToString("dd-MMM-yyyy");
            }
            if ((lf_dockdt != null) && (lf_dockdt != ""))
            {
                lf_book_cum_days = datedifferance(lf_dockdt, lf_dockdt);
            }
            lf_msg_b = Convert.ToString(dr3["tbb_bill"]) == "Y" ?"Yes" : "No";
            if (dr3["bgndt"] != System.DBNull.Value)
            {
                lf_bgndt = Convert.ToString(dr3["bgndt"]);
                lf_bgndt_f = Convert.ToDateTime(dr3["bgndt"]).ToString("dd-MMM-yyyy");
            }

            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_bgndt != "") && (lf_bgndt != ""))
            {
                lf_bill_cum_days = datedifferance(lf_dockdt, lf_bgndt);
            }
            lf_billno = Convert.ToString(dr3["billno"]);
            lf_billsubbrcd = Convert.ToString(dr3["billsubbrcd"]);
            lf_billsubbrnm = getname(Convert.ToString(dr3["billsubbrcd"]));
            if (dr3["bsbdt"] != System.DBNull.Value)
            {
                lf_bsbdt = Convert.ToString(dr3["bsbdt"]);
                lf_bsbdt_f = Convert.ToDateTime(dr3["bsbdt"]).ToString("dd-MMM-yyyy");
            }
            //lf_bsbdt = Convert.ToString(dr3["bsbdt"]);

            lf_msg_sun = Convert.ToString(dr3["bsbdt"] == System.DBNull.Value ? "No" : "Yes");
            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_bsbdt != null) && (lf_bsbdt != ""))
            {
                lf_billsub_cum_days = datedifferance(lf_dockdt, lf_bsbdt);
            }
            lf_billcolbrcd = Convert.ToString(dr3["billcolbrcd"]);

            if(Convert.ToString(dr3["billcolbrcd"]) !="Y")
                lf_Gen_oct = "No";
            else
                lf_Gen_oct = "Yes";

            
            lf_billcolbrnm = getname(Convert.ToString(dr3["billcolbrcd"]));
            //lf_mrsdt = Convert.ToString(dr3["thcbr"]);
            //lf_mrsno = Convert.ToString(dr3["thcbr"]);
            //lf_mrssf = Convert.ToString(dr3["thcbr"]);
            //lf_mr_cum_days = Convert.ToString(dr3["thcbr"]);
            //lf_mrcol_cum_days = Convert.ToString(dr3["thcbr"]);
            if (dr3["finclosedt"] != System.DBNull.Value)
            {
                lf_finclosedt = Convert.ToString(dr3["finclosedt"]);
                lf_finclosedt_f = Convert.ToDateTime(dr3["finclosedt"]).ToString("dd-MMM-yyyy");
            }
            //lf_finclosedt = Convert.ToString(dr3["finclosedt"]);
            lf_msg_mrcoll = Convert.ToString(dr3["finclosedt"] == System.DBNull.Value ? "No" : "Yes");
            //lf_msg_coll = Convert.ToString(dr3["finclosedt"] == System.DBNull.Value ? "No" : "Yes");
             
        //}
        //dr3.Close();
        //cmd3 = new SqlCommand("select mrsno,mrsdt,docno,mrstype,mrssf from VW_billMR where DOCNO='" + lf_billno + "'", conn);
        //cmd3.CommandType = CommandType.Text;
        //dr3 = cmd3.ExecuteReader();
        //IF_MRSNOYN = "No";
        //while (dr3.Read())
        //{
            if (dr3["mrsdt"] != System.DBNull.Value)
            {
                lf_mrsdt = Convert.ToString(dr3["mrsdt"]);
                lf_mrsdt_f = Convert.ToDateTime(dr3["mrsdt"]).ToString("dd-MMM-yyyy");
            }
            lf_mrsdt = Convert.ToString(dr3["mrsdt"]);
            lf_mrsno = Convert.ToString(dr3["mrsno"]);

            if (lf_mrsno == "")
                IF_MRSNOYN = "No";
            else
                IF_MRSNOYN = "Yes";


            lf_mrssf = Convert.ToString(dr3["mrssf"]);
            //lf_mr_cum_days = Convert.ToString(dr3["thcbr"]);
            //lf_billmrcol_cum_days = Convert.ToString(dr3["thcbr"]);

            if ((lf_mrsdt != null) && (lf_mrsdt != ""))
            {
                lf_billmrcol_cum_days = datedifferance(lf_mrsdt, lf_mrsdt);
            }

            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_mrsdt != "") && (lf_mrsdt != ""))
            {
                lf_mr_cum_days = datedifferance(lf_dockdt, lf_mrsdt);
            }
            if ((lf_dockdt != null) && (lf_dockdt != "") && (lf_finclosedt != "") && (lf_finclosedt != null))
            {
                lf_mrcol_cum_days = datedifferance(lf_dockdt, lf_finclosedt);
            }
            //lf_mrcol_cum_days = Convert.ToString(dr3["thcbr"]);
        }

    }
    protected void GrdLoadUnload_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 3;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 4;
            oTableCell.Text = "Arrivals [In]"; 
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 4;
            oTableCell.Text = "Departure [Out]";
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.ColumnSpan = 1;
            oTableCell.Text = "";
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
    }
    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    Label  l1,l2,l3,l4,l5,l6,l7,l8;
        //    l1 = (Label)e.Row.FindControl("lblsta");
        //    l2 = (Label)e.Row.FindControl("lbleta");
        //    l3 = (Label)e.Row.FindControl("lblata");
        //    l4 = (Label)e.Row.FindControl("lblle1");
        //    l5 = (Label)e.Row.FindControl("lblstd");
        //    l6 = (Label)e.Row.FindControl("lbletd");
        //    l7 = (Label)e.Row.FindControl("lblatd");
        //    l8 = (Label)e.Row.FindControl("lblle2");

        //    if ((l1.Text == "N-A") && (l2.Text == "N-A") && (l3.Text == "N-A") && (l4.Text == "N-A"))
        //    {
        //        e.Row.Cells[3].Controls.Remove(l1);
        //        e.Row.Cells[3].Controls.Remove(l2);
        //        e.Row.Cells[3].Controls.Remove(l3);
        //        e.Row.Cells[3].Controls.Remove(l4);    
        //        e.Row.Cells[3].Text = "N-A";
        //        e.Row.Cells[3].ColumnSpan = 4;
        //        //e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;//FromName("#dddddd");  
        //        //function.Font.Underline = true;
        //    }

        //    if ((l5.Text == "N-A") && (l6.Text == "N-A") && (l7.Text == "N-A") && (l8.Text == "N-A"))
        //    {
        //        e.Row.Cells[7].Text = "N-A";
        //        e.Row.Cells[7].ColumnSpan = 4;
        //        e.Row.Cells[7].ForeColor = System.Drawing.Color.FromName("#dddddd");  
        //        //function.Font.Underline = true;
        //    }
        //}
    }
    protected string GetPayMode(string a)
    {
        string paybasdesc="";
        switch (a)
        {
            case "P01":
                return paybasdesc = "Paid";
            case "1":
                return paybasdesc = "Paid";
            case "P02":
                return paybasdesc = "TBB";
            case "2":
                return paybasdesc = "TBB";
            case "P03":
                return paybasdesc = "To Pay";
            case "3":
                return paybasdesc = "To Pay";
            case "P04":
                return paybasdesc = "FOC";
            case "P06":
                return paybasdesc = "Topay Billing";
            case "P07":
                return paybasdesc = "Trial TBB";
            case "P09":
                return paybasdesc = "National";
            case "P08":
                return paybasdesc = "BOD";
            case "4":
                return paybasdesc = "Octroi";
            case "6":
                return paybasdesc = "Misc. MR";
            default :
                return paybasdesc;
        }
  //      select case Paybas
  //  case "P01","1"
  //     paybasdesc="Paid"
  //  case "P02","2"
  //     paybasdesc="TBB"
  //  case "P03","3"
  //     paybasdesc="To Pay"
  //  case "P04"
  //     paybasdesc="FOC"
  //  case "P06"
  //     paybasdesc="Topay Billing"
  //  case "P07"
  //     paybasdesc="Trial TBB"
  //  case "P09"
  //     paybasdesc="National"
  //  case "P08"
  //     paybasdesc="BOD"
  //     case "4"
  //    paybasdesc="Octroi"
  //     case "6"
  //    paybasdesc="Misc. MR"
  //end select 
        
    }
	


    protected void TabsView1_OnTabChanged(object sender, CommandEventArgs e)
    {
        string abcd = e.CommandArgument.ToString();
       // Response.Write(" <br>abcd" + abcd);

        string docknotab1 = Request.QueryString.Get("strDckNo");


        if (abcd == "1")
        {
            //Response.Write(" <br>abcd" + docknotab1);
            DiplayTab1(docknotab1);
        }
        else if (abcd == "2")
        {
            LifeCycleOp(docknotab1);
        }
        else if (abcd == "3")
        {
            LifeCycleFin(docknotab1);
        }   
    }
    protected string datedifferance(string fromdt,string todt)
    {
        if (fromdt != null && fromdt != "" && todt != null && todt != "")
        {
            Array strsplitfdt, strsplittdt;
            strsplitfdt = fromdt.Split(' ');
            strsplittdt = todt.Split(' ');
            //string[] strDtFrom = strsplitfdt[0].ToString().Split('/');
            string[] strDtFrom = ((string[])(strsplitfdt))[0].Split('/');
            DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[0]), Convert.ToInt16(strDtFrom[1]));
            string[] strDtTo = ((string[])(strsplittdt))[0].Split('/');
            DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[0]), Convert.ToInt16(strDtTo[1]));
            //DateTime dt1 = new DateTime(Convert.ToDateTime(fromdt));
            //DateTime dt2 = new DateTime(Convert.ToDateTime(todt));
            System.TimeSpan diffResult = dt2.Subtract(dt1);
            return Convert.ToString(diffResult.Days);
        }
        else
        {
            return "";
        }
    }
    }

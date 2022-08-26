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
    public static string  PDCUPDT_ATTEMPT,lng;
    public static string podhocleardate;
    public static string pkgsno;
    public static string thcno, thcbr, thcdt;
    public static string tcno,tcbr,tcdt;
    public static string vehno;
    public static string doc_curloc1;
    public static string POD_File, st_codyn, st_codno, podtrack, st_codchrg, st_codamt, st_coddate, st_tobecodamt;
    public static string pod;
    public static string rutcd;
    public static string docksf;
    public static string prs_no,prs_date,prs_loc;
    public static string drs_no, drs_date, drs_loc;
    public static string Bill_no, Bill_date, Bill_loc;
    public static string mr_no, mr_date, mr_loc,st_status,st_dockno;
    public static string oct_v_no, oct_v_date, oct_v_loc;
    public static string oct_BM_no, oct_BM_date, oct_BM_loc, oct_BM_st, lf_Gen_oct;
    public static string lo_dkt_status, lo_doc_curloc, lo_dockno, lo_dockdt, lo_pdc_loc, lo_prs_no, lo_pdc_date, lo_prs_cumm_day, lo_ls_status, lo_ls_loc, lo_ls_no, lo_ls_date, lo_ls_cumm_day, lo_tc_status, lo_tcbr, lo_tcno, lo_tcdt, lo_tc_cumm_day, lo_thc_status, lo_thcbr, lo_thcno, lo_thcdt, lo_thc_cumm_day, lo_tohub_br, lo_drs_loc, lo_drs_no, lo_drs_date, lo_drs_cumm_day;
    public static string lf_dockno,call_dkt, dkt,lf_docksf, lf_orgncd, lf_orgnnm, lf_destcd, lf_destnm, lf_re_destcd, lf_re_destnm, lf_paybas, lf_paybasnm, lf_dockdt, lf_dockdt_f, lf_book_cum_days, lf_msg_b, lf_bgndt, lf_bgndt_f, lf_bill_cum_days, lf_billno, lf_billsubbrcd, lf_msg_sun, lf_bsbdt, lf_bsbdt_f, lf_billsub_cum_days, lf_billcolbrcd, lf_billmrcol_cum_days, lf_mrsdt, lf_mrsdt_f, lf_mrsno, lf_mrssf, lf_mr_cum_days, lf_mrcol_cum_days, lf_finclosedt, lf_finclosedt_f, lf_msg_mrcoll, lf_billcolbrnm, lf_billsubbrnm,IF_MRSNOYN;
    MyFunctions fn = new MyFunctions();
    public static string docknotab1;
    string dockno13 = "";
    string dockno = "";
    SqlConnection cn1;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ////cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        //    conn.Open();
           
             dockno = Request.QueryString.Get("strDckNo");
            
             call_dkt = Session["DocketCalledAs"].ToString();
            //Response.Write("<br> dockno : " + dockno);
             DataSummary(dockno);
         }
    }

    public void DataSummary(string dockno)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string sqlstr = "webxNet_Trackinfo";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {

            dockno1 = dr["dockno"].ToString() + "" + dr["docksf"].ToString();
            dkt = dr["dockno"].ToString();
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
            POD_File = dr["POD_File"].ToString();
            st_status = "";// dr["OP_status1"].ToString();
            st_dockno = "";// dr["doc_no"].ToString(); 


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
        //--reason=(select Uty_name from webx_UTYMAST with(NOLOCK) where convert(varchar,UTY_id,106)=reason ) 


        string sql_Noattempt = " select count(*) as st_no from vw_PDCTrn with(NOLOCK) where dockno+docksf='" + dockno1 + ".' ";
        SqlCommand cmd_Noattempt = new SqlCommand(sql_Noattempt, conn);
        SqlDataReader dr_Noattempt = cmd_Noattempt.ExecuteReader();

        while (dr_Noattempt.Read())
        {

            PDCUPDT_ATTEMPT = dr_Noattempt["st_no"].ToString();
            //st_dockno = dr_STstus["doc_no"].ToString();
        }

        dr_Noattempt.Close();

        string sql_STstus = " exec  webx_Docket_status '" + dockno + "' ";
        SqlCommand cmd_STstus = new SqlCommand(sql_STstus, conn);
        SqlDataReader dr_STstus = cmd_STstus.ExecuteReader();

        String status_doc = "", st_docloc = "", attech_doc = "", st_docdate = "", st_docname = "", st_docmadby = ""; ;
        while (dr_STstus.Read())
        {
            status_doc = dr_STstus["OP_status"].ToString();
            attech_doc = dr_STstus["doc_no"].ToString();
            st_docdate = dr_STstus["doc_dt"].ToString();

            st_docname = dr_STstus["docname"].ToString();
            st_docloc = dr_STstus["curr_loc"].ToString();
            st_docmadby = dr_STstus["doc_PreBy"].ToString();

            st_status = status_doc + " - " + attech_doc;
            if (st_docname.ToUpper() == "DRS")
            {
                st_status = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by <a href=\"JavaScript:OpenWindowDRS('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
            }
            if (st_docname.ToUpper() == "THC")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenWindowTHC('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                
            }
            if (st_docname.ToUpper() == "MF")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenWindow('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
                
            }
            if (st_docname.ToUpper() == "LS")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindow1ls('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
               
            }
        }
        dr_STstus.Close();

        string sql_fm = "select DocumentName from Webx_FM_Scan_Documents with(NOLOCK)  where DocketNo='" + dkt + "' ";
        SqlCommand cmd_fm = new SqlCommand(sql_fm, conn);
        SqlDataReader dr_fm = cmd_fm.ExecuteReader();
        pod = "No POD Uploaded";
        while (dr_fm.Read())
        {
            POD_File = dr_fm["DocumentName"].ToString();
            //Response.Write("<br> POD_File : " + POD_File);
            if (dr_fm["DocumentName"] is DBNull)
            {
                pod = "No POD Uploaded";
            }
            else
            {
                pod = "View Scanned POD";

            }
        }

        dr_fm.Close();

        string sql_fm1 = " select top 1  dockno from WebX_FM_FWD_DOC_Detail with(NOLOCK)  where dockno='" + dkt + "'  ";
        SqlCommand cmd_fm1 = new SqlCommand(sql_fm1, conn);
        SqlDataReader dr_fm1 = cmd_fm1.ExecuteReader();
         podtrack = "";
        while (dr_fm1.Read())
        {
    
            //Response.Write("<br> POD_File : " + POD_File);
            //podtrack = dr_fm1["POD_Y_N"].ToString();


           
                podtrack="POD Track";
            
        }

        dr_fm1.Close();



        string sql_cod_dod = "select cod_dod,declcodamt,codcollected,s.codno,codamt,dely_date=convert(varchar,dely_date,6)  from webx_master_docket d with(NOLOCK) inner join WebX_Trans_Docket_Status s with(NOLOCK) on d.dockno=s.dockno where cod_dod='y' and  s.dockno+s.docksf='" + dockno1 + "' ";
        SqlCommand cmd_codod = new SqlCommand(sql_cod_dod, conn);
        SqlDataReader dr_coddod = cmd_codod.ExecuteReader();

        while (dr_coddod.Read())
        {
            st_codyn = dr_coddod["COD_DOD"].ToString();
            if (st_codyn != "Y")
            {
                tblcod.Visible = false;
            }
            st_codno = dr_coddod["codno"].ToString();
            st_codamt = dr_coddod["codcollected"].ToString();
            //st_codchrg = dr_coddod["codchrg"].ToString();
            st_coddate = dr_coddod["dely_date"].ToString();
            st_tobecodamt = dr_coddod["codamt"].ToString();
        }

        dr_coddod.Close();


        string sqlstr1 = "select d.dockno,d.docksf,doc_curloc=CURLOC+' : ' + (select top 1  locname from webx_location where loccode=d.CURLOC),d.nEXTLOC AS tohub_br,c.tcno,c.thcno,Arrv_dt=(CASE WHEN In_Out='I' THEN atad ELSE '' END) ,actarrv_dt=(case when In_Out is null then '-' when In_Out='I' then (convert(varchar,atad,6)+' '+convert(varchar,atad,108)) end),(select top 1  convert(varchar,actdept_dt,6)+ '  ' + actdept_tm from webx_thchdr  where thcno=c.thcno and sourcehb=d.CURLOC  ) actdept_dt,(select top 1 vehno from webx_thc_summary where thcno=c.thcno ) as vehno ,drs ,prs from WebX_Trans_Docket_Track d with(NOLOCK) left outer join VW_THC_TC_Dockets c with(NOLOCK) on d.dockno=c.dockno and tcbr=CURLOC left outer join WebX_Trans_Docket_Status s  with(NOLOCK) on d.dockno=s.dockno and Curr_loc=CURLOC where  d.dockno+d.docksf='" + dockno1 + "' order by srno ";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        sqlDA.Fill(ds);
        rptBillDetails.DataSource = ds;
        rptBillDetails.DataBind();
        //  BindMovment();
        //GrdPaidFollow.DataSource = ds;
        //GrdPaidFollow.DataBind(); 
    }

    public void BindMovment(string dockno)
    {
       // SqlDataReader drsub;
       // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       // //DataSet ds = new DataSet();
       // string thcno, atd, routecode, loccode, le_arrival_str, le_departure_str, ATD_Str;
       // double le_arrival, le_departure;
       // thcno = "";
       // Boolean rcf;
       // rcf = false;
       // atd = le_arrival_str = le_departure_str = "";
       // string sqlstr = "webx_dockt_track";
       // DataTable dt = new DataTable();
       // DataColumn dc0 = new DataColumn("thcno", typeof(string));
       // DataColumn dc1 = new DataColumn("location", typeof(string));
       // DataColumn dc2 = new DataColumn("transittime", typeof(string));
       // DataColumn dc3 = new DataColumn("sta", typeof(string));
       // DataColumn dc4 = new DataColumn("eta", typeof(string));
       // DataColumn dc5 = new DataColumn("ata", typeof(string));
       // DataColumn dc6 = new DataColumn("l/e1", typeof(string));
       // DataColumn dc7 = new DataColumn("std", typeof(string));
       // DataColumn dc8 = new DataColumn("etd", typeof(string));
       // DataColumn dc9 = new DataColumn("atd", typeof(string));
       // DataColumn dc10 = new DataColumn("l/e2", typeof(string));
       // DataColumn dc11 = new DataColumn("routecode", typeof(string));
       // dt.Columns.Add(dc0);
       // dt.Columns.Add(dc1);
       // dt.Columns.Add(dc2);
       // dt.Columns.Add(dc3);
       // dt.Columns.Add(dc4);
       // dt.Columns.Add(dc5);
       // dt.Columns.Add(dc6);
       // dt.Columns.Add(dc7);
       // dt.Columns.Add(dc8);
       // dt.Columns.Add(dc9);
       // dt.Columns.Add(dc10);
       // dt.Columns.Add(dc11);
       // DataRow drow;
       // SqlCommand cmd = new SqlCommand(sqlstr, conn);
       
       // cmd.CommandType = CommandType.StoredProcedure;
       // //SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText,conn.ConnectionString);
       // //da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
       // cmd.Parameters.AddWithValue("@DOCKNO", dockno);
       // conn.Open();
       // dr = cmd.ExecuteReader();
       // tblmovement.Visible = true;
     
       // TableRow trMV1 = new TableRow();

       // TableCell tctrMV1 = new TableCell();
       //  tctrMV1.Text = "Movement";
       // tctrMV1.CssClass = "blackboldfnt";
       // tctrMV1.Wrap = false;
       // tctrMV1.ColumnSpan = 12;
       // tctrMV1.HorizontalAlign = HorizontalAlign.Center;
       // trMV1.CssClass = "bgbluegrey";
       // trMV1.Cells.Add(tctrMV1);


       // tblmovement.Rows.Add(trMV1);


       // TableRow tr11 = new TableRow();

       // TableCell tctr11 = new TableCell();
       // //TableCell tc2 = new TableCell();
       // //TableCell tc3 = new TableCell();

       // //TableCell tc4 = new TableCell();
       // //TableCell tc5 = new TableCell();
       // //TableCell tc6 = new TableCell();



       // tctr11.Text = "";
       // tctr11.CssClass = " blackboldfnt";
       // tctr11.Wrap = false;
       // tctr11.ColumnSpan = 12;
       // tr11.BackColor = System.Drawing.Color.White;
       // tr11.Cells.Add(tctr11);


       // tblmovement.Rows.Add(tr11);

       // TableRow tr12 = new TableRow();

       // TableCell tctr12 = new TableCell();

       // tctr12.Text = call_dkt + " Time Tracking";
       // tctr12.CssClass = "blackboldfnt";
       // tctr12.Wrap = false;
       // tctr12.ColumnSpan = 12;
       // tctr12.HorizontalAlign = HorizontalAlign.Center;
       // tr12.CssClass = "bgbluegrey";
       //// tr11.BackColor = System.Drawing.Color.White;
       // tr12.Cells.Add(tctr12);


       // tblmovement.Rows.Add(tr12);

       // TableRow tr21 = new TableRow();

       // TableCell tr21tc1 = new TableCell();
       // TableCell tr21tc2 = new TableCell();
       // TableCell tr21tc3 = new TableCell();
       // TableCell tr21tc4 = new TableCell();
       // TableCell tr21tc5 = new TableCell();
       // TableCell tr21tc6 = new TableCell();

       // tr21tc3.Text = "THC No./Vehicle No.";
       // tr21tc3.CssClass = "blackboldfnt";
       // //tr21tc3.Wrap = false;
       // tr21.CssClass = "bgbluegrey";
       // tr21tc3.RowSpan = 2;
       // tr21.Cells.Add(tr21tc3);

       // tr21tc4.Text = "Location";
       // tr21tc4.CssClass = "blackboldfnt";
       // tr21tc4.Wrap = false;
       // tr21.CssClass = "bgbluegrey";
       // tr21tc4.RowSpan = 2;
       // tr21.Cells.Add(tr21tc4);

       // tr21tc5.Text = "Transit Time";
       // tr21tc5.CssClass = "blackboldfnt";
       // tr21tc5.Wrap = false;
       // tr21.CssClass = "bgbluegrey";
       // tr21tc5.RowSpan = 2;
       // tr21.Cells.Add(tr21tc5);

       // tr21tc1.Text = "Arrivals [In]";
       // tr21tc1.CssClass = "blackboldfnt";
       // tr21tc1.Wrap = false;
       // tr21tc1.ColumnSpan = 4;
       // tr21.CssClass = "bgbluegrey";
       // tr21tc1.HorizontalAlign = HorizontalAlign.Center;
       // tr21.Cells.Add(tr21tc1);

       // tr21tc2.Text = "Departures [Out]";
       // tr21tc2.CssClass = "blackboldfnt";
       // tr21tc2.Wrap = false;
       // tr21tc2.ColumnSpan = 4;
       // tr21tc2.HorizontalAlign = HorizontalAlign.Center;
       // tr21.CssClass = "bgbluegrey";
       // tr21.Cells.Add(tr21tc2);

       // tr21tc6.Text = "Route Code";
       // tr21tc6.CssClass = "blackboldfnt";
       // tr21tc6.Wrap = false;
       // tr21.CssClass = "bgbluegrey";
       // tr21tc6.RowSpan = 2;
       // tr21.Cells.Add(tr21tc6);


       // tblmovement.Rows.Add(tr21);
     

       // TableRow tr2 = new TableRow();

       // TableCell tr2tc1 = new TableCell();
       // TableCell tr2tc2 = new TableCell();
       // TableCell tr2tc3 = new TableCell();

       // TableCell tr2tc4 = new TableCell();
       // TableCell tr2tc5 = new TableCell();
       // TableCell tr2tc6 = new TableCell();


       // TableCell tr2tc7 = new TableCell();
       // TableCell tr2tc8 = new TableCell();
       // TableCell tr2tc9 = new TableCell();

       // TableCell tr2tc10 = new TableCell();
       // TableCell tr2tc11 = new TableCell();
       // TableCell tr2tc12 = new TableCell();

     

       

       // tr2tc4.Text = "STA";
       // tr2tc4.CssClass = "blackboldfnt";
       // tr2tc4.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc4.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc4);

       // tr2tc5.Text = "ETA";
       // tr2tc5.CssClass = "blackboldfnt";
       // tr2tc5.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc5.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc5);

       // tr2tc6.Text = "ATA";
       // tr2tc6.CssClass = "blackboldfnt";
       // tr2tc6.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc6.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc6);

       // tr2tc7.Text = "Late/Early [Hrs.]";
       // tr2tc7.CssClass = "blackboldfnt";
       // tr2tc7.HorizontalAlign = HorizontalAlign.Center;
       // //tr2tc7.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc7);

       // tr2tc8.Text = "STD";
       // tr2tc8.CssClass = "blackboldfnt";
       // tr2tc8.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc8.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc8);

       // tr2tc9.Text = "ETD";
       // tr2tc9.CssClass = "blackboldfnt";
       // tr2tc9.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc9.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc9);

       // tr2tc10.Text = "ATD";
       // tr2tc10.CssClass = "blackboldfnt";
       // tr2tc10.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc10.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc10);

       // tr2tc11.Text = "Late/Early [Hrs.]";
       // tr2tc11.HorizontalAlign = HorizontalAlign.Center;
       // tr2tc11.CssClass = "blackboldfnt";
       //// tr2tc11.Wrap = false;
       // tr2.CssClass = "bgbluegrey";
       // tr2.Cells.Add(tr2tc11);

        

       // tblmovement.Rows.Add(tr2);


        

       // while (dr.Read())
       // {
       //     TableRow tr3 = new TableRow();

       //     TableCell tr3tc1 = new TableCell();
       //     TableCell tr3tc2 = new TableCell();
       //     TableCell tr3tc3 = new TableCell();

       //     TableCell tr3tc4 = new TableCell();
       //     TableCell tr3tc5 = new TableCell();
       //     TableCell tr3tc6 = new TableCell();


       //     TableCell tr3tc7 = new TableCell();
       //     TableCell tr3tc8 = new TableCell();
       //     TableCell tr3tc9 = new TableCell();

       //     TableCell tr3tc10 = new TableCell();
       //     TableCell tr3tc11 = new TableCell();
       //     TableCell tr3tc12 = new TableCell();

            


       //     drow = dt.NewRow();
       //     if (thcno != Convert.ToString(dr["THC_Number"]))
       //     {
       //         rcf = true;
       //         //drow["thcno"] = Convert.ToString(dr["THC_Number"]) + " - " + Convert.ToString(dr["vehno"]);
       //         thcno = Convert.ToString(dr["THC_Number"]);
       //         atd = Convert.ToString(dr["ATD"]);
       //         if (atd != "" && atd != null && atd != "-" && atd.Length > 10)
       //         {
       //             atd = atd.Substring(0, 11);
       //         }
       //     }
       //     drow["thcno"] = Convert.ToString(dr["THC_Number"]) + " - " + Convert.ToString(dr["vehno"]);
       //     drow["location"] = Convert.ToString(dr["sourcehb"]);
       //     drow["routecode"] = Convert.ToString(dr["routecd"]);
       //     drow["transittime"] = Convert.ToString(dr["transit_time"]);

       //     tr3tc1.Text = drow["thcno"].ToString();
       //     tr3tc1.CssClass = "blackfnt";
       //     //tr3tc1.Wrap = false;
       //     tr3.CssClass = "bgbluegrey";
       //     tr3.Cells.Add(tr3tc1);
       //     tr3tc1.BackColor = System.Drawing.Color.White;

       //     tr3tc2.Text = drow["location"].ToString();
       //     tr3tc2.CssClass = "blackfnt";
       //     //tr3tc1.Wrap = false;
       //     tr3.CssClass = "bgbluegrey";
       //     tr3.Cells.Add(tr3tc2);
       //     tr3tc2.BackColor = System.Drawing.Color.White;

       //     tr3tc3.Text = drow["transittime"].ToString();
       //     tr3tc3.CssClass = "blackfnt";
       //     //tr3tc1.Wrap = false;
       //     tr3.CssClass = "bgbluegrey";
       //     tr3.Cells.Add(tr3tc3);
       //     tr3tc3.BackColor = System.Drawing.Color.White;


             


       //     SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       //     cn1.Open(); 
       //     //usp_Schedule_Arrival_Departure
       //     SqlCommand cmd1 = new SqlCommand("usp_Schedule_Arrival_Departure", cn1);
       //     cmd1.CommandType = CommandType.StoredProcedure;
       //     cmd1.Parameters.AddWithValue("@startdate", atd);
       //     cmd1.Parameters.AddWithValue("@routecode", Convert.ToString(dr["routecd"]));
       //     cmd1.Parameters.AddWithValue("@loccode", Convert.ToString(dr["sourcehb"]));
       //     drsub = cmd1.ExecuteReader();
       //     while (drsub.Read())
       //     {
       //         drow["sta"] = Convert.ToString(drsub["sch_arrival_date_time"]);
       //         drow["std"] = Convert.ToString(drsub["sch_departure_date_time"]);
       //     }
       //     drsub.Close();
       //     if (drow["sta"] != "" && Convert.ToString(dr["ata"]) != null && Convert.ToString(dr["ata"]) != "" && Convert.ToString(dr["ata"]) != "-")
       //     {
       //         le_arrival_str = "";
       //         string sql = "Select round(convert(decimal(12,2),datediff(minute,'" + drow["sta"] + "','" + dr["ata"] + "')/60.0),2)";
       //         cmd1 = new SqlCommand(sql, cn1);
       //         le_arrival = Convert.ToDouble(cmd1.ExecuteScalar());
       //         if (le_arrival > 0.00)
       //         {
       //             le_arrival_str = "L: " + le_arrival;
       //         }
       //         else if (le_arrival < 0.00)
       //         {
       //             le_arrival_str = "E: " + le_arrival;
       //         }
       //         else if (le_arrival == 0.00)
       //         {
       //             le_arrival_str = "On Time";
       //         }
       //         le_arrival_str = le_arrival_str.Replace("-", "");
       //         //drow["l/e1"] = le_arrival_str;
       //     }


       //     if (drow["std"] != "" && Convert.ToString(dr["atd"]) != null && Convert.ToString(dr["atd"]) != "" && Convert.ToString(dr["atd"]) != "-")
       //     {
       //         le_departure_str = "";
       //         string sql = "Select round(convert(decimal(12,2),datediff(minute,'" + drow["std"] + "','" + Convert.ToString(dr["atd"]) + "')/60.0),2)";
       //         cmd1 = new SqlCommand(sql, cn1);
       //         le_departure = Convert.ToDouble(cmd1.ExecuteScalar());
       //         if (le_departure > 0.00)
       //         {
       //             le_departure_str = "L: " + le_departure;
       //             lng = "L";
       //         }
       //         else if (le_departure < 0.00)
       //         {
       //             le_departure_str = "E: " + le_departure;
       //             lng = "E";
       //         }
       //         else if (le_departure == 0.00)
       //         {
       //             le_departure_str = "On Time";
       //         }
       //         le_departure_str = le_departure_str.Replace("-", "");
       //         drow["l/e2"] = le_departure_str;
       //     }

       //     if (rcf == true)
       //     {
       //         rcf = false;
       //         drow["sta"] = "N-A";
       //         drow["eta"] = "N-A";
       //         drow["ata"] = "N-A";
       //         drow["l/e1"] = "N-A";

       //         tr3tc4.Text = "-N.A-";
       //         tr3tc4.CssClass = "blackfnt";
       //         //tr3tc1.Wrap = false;
       //         tr3tc4.ColumnSpan = 4;
       //         tr3tc4.HorizontalAlign = HorizontalAlign.Center;
       //         tr3.Cells.Add(tr3tc4);
       //         tr3tc4.BackColor = System.Drawing.Color.LightGray;
       //     }
       //     else
       //     {
       //         String st_sta = drow["sta"].ToString().Replace(":00:000", ""); 


       //         if ((Convert.ToString(dr["eta"]) != "") && (Convert.ToString(dr["eta"]) != null))
       //         {
       //             drow["eta"] = Convert.ToString(dr["eta"]).Substring(0, 17);
       //         }
       //         drow["ata"] = Convert.ToString(dr["ata"]);
       //         drow["l/e1"] = le_arrival_str;

       //         tr3tc4.Text = st_sta;
       //         tr3tc4.CssClass = "bluefnt";
       //         tr3tc4.ForeColor = System.Drawing.Color.Blue;
       //         //tr3tc4.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc4.HorizontalAlign = HorizontalAlign.Center;
       //         tr3.BackColor = System.Drawing.Color.White;
       //         tr3.Cells.Add(tr3tc4);

       //         tr3tc5.Text = drow["eta"].ToString();
       //         tr3tc5.CssClass = "blackfnt";
       //         tr3tc5.ForeColor = System.Drawing.Color.DeepPink;
       //         //tr3tc5. Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc5.HorizontalAlign = HorizontalAlign.Center;
       //         tr3tc5.BackColor = System.Drawing.Color.White;
       //         tr3.Cells.Add(tr3tc5);


       //         tr3tc6.Text = drow["ata"].ToString();
       //         tr3tc6.CssClass = "blackfnt";
       //        // tr3tc6.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc6.HorizontalAlign = HorizontalAlign.Center;
       //         tr3tc6.BackColor = System.Drawing.Color.White;
       //         tr3.Cells.Add(tr3tc6);


       //         tr3tc7.Text = drow["l/e1"].ToString();
       //         tr3tc7.CssClass = "blackfnt";
       //        // tr3tc1.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc7.HorizontalAlign = HorizontalAlign.Center;
       //         tr3tc7.BackColor = System.Drawing.Color.White;
       //         tr3tc7.ForeColor = System.Drawing.Color.Green;
       //         if (lng == "L")
       //         {
       //             tr3tc7.ForeColor = System.Drawing.Color.Red;
       //         }
       //         else if (lng == "E")
       //         {
       //             tr3tc7.ForeColor = System.Drawing.Color.Green;
       //         }
               
       //         tr3.Cells.Add(tr3tc7);

       //     }
       //     ATD_Str = Convert.ToString(dr["atd"]);
       //     if (ATD_Str == "" || ATD_Str == null)
       //     {
       //         drow["std"] = "-N.A- ";
       //         drow["etd"] = "-N.A- ";
       //         drow["atd"] = "-N.A- ";
       //         drow["l/e2"] = "-N.A- ";
       //         tr3tc8.Text = "-N.A-";
       //         tr3tc8.CssClass = "blackfnt";
       //         //tr3tc1.Wrap = false;
       //         tr3tc8.ColumnSpan = 4;
       //         tr3tc8.HorizontalAlign = HorizontalAlign.Center;
       //         tr3.Cells.Add(tr3tc8);
       //         tr3tc8.BackColor = System.Drawing.Color.LightGray;
       //     }
       //     else
       //     {
       //      //  drow["std"] =  drow["std"].ToString() +""+Convert.ToString(dr["std"]).Replace(":00:000", "");
       //        String st_std = drow["std"].ToString().Replace(":00:000", ""); ;
       //         if ((Convert.ToString(dr["etd"]) != "") && (Convert.ToString(dr["etd"]) != null))
       //         {
       //             drow["etd"] = Convert.ToString(dr["etd"]).Substring(0, 17);
       //         }
       //         drow["atd"] = Convert.ToString(dr["atd"]);
       //         drow["l/e2"] = le_departure_str;

       //         tr3tc8.Text = st_std;
       //         tr3tc8.CssClass = "blackfnt";
       //         tr3tc8.ForeColor = System.Drawing.Color.Blue;
       //         //tr3tc8.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc8.HorizontalAlign = HorizontalAlign.Center;
       //         tr3.BackColor = System.Drawing.Color.White;
       //         tr3.Cells.Add(tr3tc8);

       //         tr3tc9.Text = drow["etd"].ToString();
       //         tr3tc9.CssClass = "blackfnt";
       //         tr3tc9.ForeColor = System.Drawing.Color.Pink;
       //         //tr3tc9.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc9.HorizontalAlign = HorizontalAlign.Center;
       //         tr3tc9.BackColor = System.Drawing.Color.White;
       //         tr3.Cells.Add(tr3tc9);


       //         tr3tc10.Text = drow["atd"].ToString();
       //         tr3tc10.CssClass = "blackfnt";
       //        //tr3tc10.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc10.HorizontalAlign = HorizontalAlign.Center;
       //         tr3tc10.BackColor = System.Drawing.Color.White;
       //         tr3.Cells.Add(tr3tc10);


       //         tr3tc11.Text = drow["l/e2"].ToString();
       //         tr3tc11.CssClass = "blackfnt";
       //         //tr3tc1.Wrap = false;
       //         // tr3tc4.ColumnSpan = 4;
       //         tr3tc11.HorizontalAlign = HorizontalAlign.Center;
       //         tr3tc11.BackColor = System.Drawing.Color.White;
       //         tr3tc11.ForeColor = System.Drawing.Color.Green;
       //         if (lng == "L")
       //         {
       //             tr3tc11.ForeColor = System.Drawing.Color.Red;
       //         }
       //         else if (lng == "E")
       //         {
       //             tr3tc11.ForeColor = System.Drawing.Color.Green;
       //         }

       //         tr3.Cells.Add(tr3tc11);
       //     }
       //     dt.Rows.Add(drow);
       //     tr3tc12.Text = drow["routecode"].ToString();
       //     tr3tc12.CssClass = "blackfnt";
       //     //tr3tc1.Wrap = false;
       //     tr3.CssClass = "bgbluegrey";
       //     tr3.Cells.Add(tr3tc12);
       //     tr3tc12.BackColor = System.Drawing.Color.White;

       //     tblmovement.Rows.Add(tr3);

       // }
       // //da.Fill(ds,"table1"); 
       // dr.Close();
       // //GrdPaidFollow.DataSource = dt;
       // //GrdPaidFollow.DataBind();
    }
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
        tblheadache.Visible = true;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlstr3 = "webx_life_cycle_operation_net";
        SqlCommand cmd3 = new SqlCommand(sqlstr3, conn);
        cmd3.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd3);
       // da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        TableRow tr1 = new TableRow();

        TableCell tctr1 = new TableCell();
        //TableCell tc2 = new TableCell();
        //TableCell tc3 = new TableCell();

        //TableCell tc4 = new TableCell();
        //TableCell tc5 = new TableCell();
        //TableCell tc6 = new TableCell();



        tctr1.Text = "Life Cycle Operation ";
        tctr1.CssClass = "blackboldfnt";
        tctr1.Wrap = false;
        tctr1.ColumnSpan = 6;
        tctr1.HorizontalAlign = HorizontalAlign.Center;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tctr1);


        tblheadache.Rows.Add(tr1);

        TableRow tr11 = new TableRow();

        TableCell tctr11 = new TableCell();
        //TableCell tc2 = new TableCell();
        //TableCell tc3 = new TableCell();

        //TableCell tc4 = new TableCell();
        //TableCell tc5 = new TableCell();
        //TableCell tc6 = new TableCell();



        tctr11.Text = "";
        tctr11.CssClass = "blackboldfnt";
        tctr11.Wrap = false;
        tctr11.ColumnSpan = 6;
        tr11.BackColor = System.Drawing.Color.White;
        tr11.Cells.Add(tctr11);


        tblheadache.Rows.Add(tr11);


        TableRow tr2 = new TableRow();

        TableCell tr2tc1 = new TableCell();
        TableCell tr2tc2 = new TableCell();
        TableCell tr2tc3 = new TableCell();

        TableCell tr2tc4 = new TableCell();
        TableCell tr2tc5 = new TableCell();
        TableCell tr2tc6 = new TableCell();

        tr2tc1.Text = "Activity";
        tr2tc1.CssClass = "blackboldfnt";
        tr2tc1.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc1);

        tr2tc2.Text = "Status";
        tr2tc2.CssClass = "blackboldfnt";
        tr2tc2.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc2);

        tr2tc3.Text = "Document No.";
        tr2tc3.CssClass = "blackboldfnt";
        tr2tc3.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc3);

        tr2tc4.Text = "Date";
        tr2tc4.CssClass = "blackboldfnt";
        tr2tc4.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc4);

        tr2tc5.Text = "Cumulative Days";
        tr2tc5.CssClass = "blackboldfnt";
        tr2tc5.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc5);

        tr2tc6.Text = "View Document";
        tr2tc6.CssClass = "blackboldfnt";
        tr2tc6.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc6);


        tblheadache.Rows.Add(tr2);


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
            // Response.Write("<br> lo_ls_no : " + lo_ls_no);
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


            TableRow tr12 = new TableRow();

            TableCell tctr12 = new TableCell();
            //TableCell tc2 = new TableCell();
            //TableCell tc3 = new TableCell();

            //TableCell tc4 = new TableCell();
            //TableCell tc5 = new TableCell();
            //TableCell tc6 = new TableCell();



            tctr12.Text = "Activity At - " + Convert.ToString(dr3["doc_curloc"]);
            tctr12.CssClass = "blackboldfnt";
            tctr12.Wrap = false;
            tctr12.ColumnSpan = 6;
            tr12.BackColor = System.Drawing.Color.White;
            tr12.Cells.Add(tctr12);


            tblheadache.Rows.Add(tr12);



            TableRow tr3 = new TableRow();

            TableCell tr3tc1 = new TableCell();
            TableCell tr3tc2 = new TableCell();
            TableCell tr3tc3 = new TableCell();

            TableCell tr3tc4 = new TableCell();
            TableCell tr3tc5 = new TableCell();
            TableCell tr3tc6 = new TableCell();

            tr3tc1.Text = "Booked/Arrived";
            tr3tc1.CssClass = "blackfnt";
            tr3tc1.Wrap = false;
            tr3tc1.BackColor = System.Drawing.Color.White;
            tr3.Cells.Add(tr3tc1);

            tr3tc2.Text = lo_dkt_status + " : " + lo_doc_curloc;
            tr3tc2.CssClass = "blackfnt";
            tr3tc2.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3tc1.BackColor = System.Drawing.Color.White;
            tr3.Cells.Add(tr3tc2);

            tr3tc3.Text = lo_dockno;
            tr3tc3.CssClass = "blackfnt";
            tr3tc3.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3tc1.BackColor = System.Drawing.Color.White;
            tr3.Cells.Add(tr3tc3);

            tr3tc4.Text = lo_dockdt;
            tr3tc4.CssClass = "blackfnt";
            tr3tc4.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3tc1.BackColor = System.Drawing.Color.White;
            tr3.Cells.Add(tr3tc4);

            tr3tc5.Text = "0";
            tr3tc5.CssClass = "blackfnt";
            tr3tc5.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3tc1.BackColor = System.Drawing.Color.White;
            tr3.Cells.Add(tr3tc5);

            tr3tc6.Text = "<a href='JavaScript:OpenPopupWindow1(" + lo_dockno + ")'> View </a>";
            tr3tc6.CssClass = "blackfnt";
            tr3tc6.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.BackColor = System.Drawing.Color.White;
            tr3.Cells.Add(tr3tc6);


            tblheadache.Rows.Add(tr3);

            if (lo_prs_no != "" && lo_prs_no != null)
            {
                TableRow tr7 = new TableRow();

                TableCell tr7tc1 = new TableCell();
                TableCell tr7tc2 = new TableCell();
                TableCell tr7tc3 = new TableCell();

                TableCell tr7tc4 = new TableCell();
                TableCell tr7tc5 = new TableCell();
                TableCell tr7tc6 = new TableCell();

                tr7tc1.Text = "PRS";
                tr7tc1.CssClass = "blackfnt";
                tr7tc1.Wrap = false;
                tr7tc1.BackColor = System.Drawing.Color.White;
                tr7.Cells.Add(tr7tc1);

                tr7tc2.Text = lo_pdc_loc;
                tr7tc2.CssClass = "blackfnt";
                tr7tc2.Wrap = false;
                tr7.CssClass = "bgbluegrey";
                tr7tc1.BackColor = System.Drawing.Color.White;
                tr7.Cells.Add(tr7tc2);

                tr7tc3.Text = lo_prs_no;
                tr7tc3.CssClass = "blackfnt";
                tr7tc3.Wrap = false;
                tr7.CssClass = "bgbluegrey";
                tr7tc1.BackColor = System.Drawing.Color.White;
                tr7.Cells.Add(tr7tc3);

                tr7tc4.Text = lo_pdc_date;
                tr7tc4.CssClass = "blackfnt";
                tr7tc4.Wrap = false;
                tr7.CssClass = "bgbluegrey";
                tr7tc1.BackColor = System.Drawing.Color.White;
                tr7.Cells.Add(tr7tc4);

                tr7tc5.Text = lo_prs_cumm_day;
                tr7tc5.CssClass = "blackfnt";
                tr7tc5.Wrap = false;
                tr7.CssClass = "bgbluegrey";
                tr7tc1.BackColor = System.Drawing.Color.White;
                tr7.Cells.Add(tr7tc5);

                //tr7tc6.Text = "<a href='JavaScript:OpenPopupWindowPRS(" + lo_prs_no + ")'> View </a>";
                tr7tc6.Text = "<a href=\"JavaScript:OpenPopupWindowPRS('" + lo_prs_no + ",0')\">View </a>";
                tr7tc6.CssClass = "blackfnt";
                tr7tc6.Wrap = false;
                tr7.CssClass = "bgbluegrey";
                tr7.BackColor = System.Drawing.Color.White;
                tr7.Cells.Add(tr7tc6);


                tblheadache.Rows.Add(tr7);
            }


            TableRow tr4 = new TableRow();

            TableCell tr4tc1 = new TableCell();
            TableCell tr4tc2 = new TableCell();
            TableCell tr4tc3 = new TableCell();

            TableCell tr4tc4 = new TableCell();
            TableCell tr4tc5 = new TableCell();
            TableCell tr4tc6 = new TableCell();

            tr4tc1.Text = "Loading sheet made";
            tr4tc1.CssClass = "blackfnt";
            tr4tc1.Wrap = false;
            tr4tc1.BackColor = System.Drawing.Color.White;
            tr4.Cells.Add(tr4tc1);

            tr4tc2.Text = lo_ls_status + " : " + lo_ls_loc;
            tr4tc2.CssClass = "blackfnt";
            tr4tc2.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4tc1.BackColor = System.Drawing.Color.White;
            tr4.Cells.Add(tr4tc2);

            tr4tc3.Text = lo_ls_no;
            tr4tc3.CssClass = "blackfnt";
            tr4tc3.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4tc1.BackColor = System.Drawing.Color.White;
            tr4.Cells.Add(tr4tc3);

            tr4tc4.Text = lo_ls_date;
            tr4tc4.CssClass = "blackfnt";
            tr4tc4.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4tc1.BackColor = System.Drawing.Color.White;
            tr4.Cells.Add(tr4tc4);

            tr4tc5.Text = lo_ls_cumm_day;
            tr4tc5.CssClass = "blackfnt";
            tr4tc5.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4tc1.BackColor = System.Drawing.Color.White;
            tr4.Cells.Add(tr4tc5);

            
            tr4tc6.Text = "<a href=\"JavaScript:OpenPopupWindow1ls('" + lo_ls_no + ",0')\">View </a>";
            if (lo_ls_no == "" || lo_ls_no==null) 
            {
                tr4tc6.Text = " ";
            }
            tr4tc6.CssClass = "blackfnt";
            tr4tc6.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4.BackColor = System.Drawing.Color.White;
            tr4.Cells.Add(tr4tc6);


            tblheadache.Rows.Add(tr4);


            TableRow tr5 = new TableRow();

            TableCell tr5tc1 = new TableCell();
            TableCell tr5tc2 = new TableCell();
            TableCell tr5tc3 = new TableCell();

            TableCell tr5tc4 = new TableCell();
            TableCell tr5tc5 = new TableCell();
            TableCell tr5tc6 = new TableCell();

            tr5tc1.Text = "Manifest Made";
            tr5tc1.CssClass = "blackfnt";
            tr5tc1.Wrap = false;
            tr5tc1.BackColor = System.Drawing.Color.White;
            tr5.Cells.Add(tr5tc1);

            tr5tc2.Text = lo_tc_status + " : " + lo_tcbr;
            tr5tc2.CssClass = "blackfnt";
            tr5tc2.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5tc1.BackColor = System.Drawing.Color.White;
            tr5.Cells.Add(tr5tc2);

            tr5tc3.Text = lo_tcno;
            tr5tc3.CssClass = "blackfnt";
            tr5tc3.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5tc1.BackColor = System.Drawing.Color.White;
            tr5.Cells.Add(tr5tc3);

            tr5tc4.Text = lo_tcdt;
            tr5tc4.CssClass = "blackfnt";
            tr5tc4.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5tc1.BackColor = System.Drawing.Color.White;
            tr5.Cells.Add(tr5tc4);

            tr5tc5.Text = lo_tc_cumm_day;
            tr5tc5.CssClass = "blackfnt";
            tr5tc5.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5tc1.BackColor = System.Drawing.Color.White;
            tr5.Cells.Add(tr5tc5);

            tr5tc6.Text = "<a href=\"JavaScript:OpenWindow('" + lo_tcno + ",0')\">View </a>";
           
            if (lo_tcno == "" || lo_tcno == null) 
            {
                tr5tc6.Text = " ";
            }
            tr5tc6.CssClass = "blackfnt";
            tr5tc6.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5.BackColor = System.Drawing.Color.White;
            tr5.Cells.Add(tr5tc6);


            tblheadache.Rows.Add(tr5);


            TableRow tr6 = new TableRow();

            TableCell tr6tc1 = new TableCell();
            TableCell tr6tc2 = new TableCell();
            TableCell tr6tc3 = new TableCell();

            TableCell tr6tc4 = new TableCell();
            TableCell tr6tc5 = new TableCell();
            TableCell tr6tc6 = new TableCell();

            tr6tc1.Text = "THC Made";
            tr6tc1.CssClass = "blackfnt";
            tr6tc1.Wrap = false;
            tr6tc1.BackColor = System.Drawing.Color.White;
            tr6.Cells.Add(tr6tc1);

            tr6tc2.Text = lo_thc_status + " : " + lo_thcbr;
            tr6tc2.CssClass = "blackfnt";
            tr6tc2.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6tc1.BackColor = System.Drawing.Color.White;
            tr6.Cells.Add(tr6tc2);

            tr6tc3.Text = lo_thcno;
            tr6tc3.CssClass = "blackfnt";
            tr6tc3.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6tc1.BackColor = System.Drawing.Color.White;
            tr6.Cells.Add(tr6tc3);

            tr6tc4.Text = lo_thcdt;
            tr6tc4.CssClass = "blackfnt";
            tr6tc4.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6tc1.BackColor = System.Drawing.Color.White;
            tr6.Cells.Add(tr6tc4);

            tr6tc5.Text = lo_thc_cumm_day;
            tr6tc5.CssClass = "blackfnt";
            tr6tc5.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6tc1.BackColor = System.Drawing.Color.White;
            tr6.Cells.Add(tr6tc5);


            //<a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "lo_thcno") %>')> View </a>";

            //tr6tc6.Text = "<a href='JavaScript:OpenWindowTHC(" + lo_thcno + ")'> View </a>";
            tr6tc6.Text = "<a href=\"JavaScript:OpenWindowTHC('" + lo_thcno + ",0')\">View </a>";
            if (lo_thcno == "" || lo_thcno == null) 
            {
                tr6tc6.Text = " ";
            }
            tr6tc6.CssClass = "blackfnt";
            tr6tc6.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6.BackColor = System.Drawing.Color.White;
            tr6.Cells.Add(tr6tc6);




            tblheadache.Rows.Add(tr6);



            if (lo_drs_no != "" && lo_drs_no != null)
            {
                TableRow tr8 = new TableRow();

                TableCell tr8tc1 = new TableCell();
                TableCell tr8tc2 = new TableCell();
                TableCell tr8tc3 = new TableCell();

                TableCell tr8tc4 = new TableCell();
                TableCell tr8tc5 = new TableCell();
                TableCell tr8tc6 = new TableCell();

                tr8tc1.Text = "DRS";
                tr8tc1.CssClass = "blackfnt";
                tr8tc1.Wrap = false;
                tr8tc1.BackColor = System.Drawing.Color.White;
                tr8.Cells.Add(tr8tc1);

                tr8tc2.Text = lo_drs_loc;
                tr8tc2.CssClass = "blackfnt";
                tr8tc2.Wrap = false;
                tr8.CssClass = "bgbluegrey";
                tr8tc1.BackColor = System.Drawing.Color.White;
                tr8.Cells.Add(tr8tc2);

                tr8tc3.Text = lo_drs_no;
                tr8tc3.CssClass = "blackfnt";
                tr8tc3.Wrap = false;
                tr8.CssClass = "bgbluegrey";
                tr8tc1.BackColor = System.Drawing.Color.White;
                tr8.Cells.Add(tr8tc3);

                tr8tc4.Text = lo_drs_date;
                tr8tc4.CssClass = "blackfnt";
                tr8tc4.Wrap = false;
                tr8.CssClass = "bgbluegrey";
                tr8tc1.BackColor = System.Drawing.Color.White;
                tr8.Cells.Add(tr8tc4);

                tr8tc5.Text = lo_drs_cumm_day;
                tr8tc5.CssClass = "blackfnt";
                tr8tc5.Wrap = false;
                tr8.CssClass = "bgbluegrey";
                tr8tc1.BackColor = System.Drawing.Color.White;
                tr8.Cells.Add(tr8tc5);

               // tr8tc6.Text = "<a href='JavaScript:OpenWindowDRS(" + lo_drs_no + ")'> View </a>";
                tr8tc6.Text = "<a href=\"JavaScript:OpenWindowDRS('" + lo_drs_no + ",0')\">View </a>";
                tr8tc6.CssClass = "blackfnt";
                tr8tc6.Wrap = false;
                tr8.CssClass = "bgbluegrey";
                tr8.BackColor = System.Drawing.Color.White;
                tr8.Cells.Add(tr8tc6);


                tblheadache.Rows.Add(tr8);
            }



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
                lf_dockdt_f = Convert.ToDateTime(dr3["dockdt"]).ToString("dd MMM yy");
            }
            if ((lf_dockdt != null) && (lf_dockdt != ""))
            {
                lf_book_cum_days = datedifferance(lf_dockdt, lf_dockdt);
            }
            lf_msg_b = Convert.ToString(dr3["tbb_bill"]) == "Y" ?"Yes" : "No";
            if (dr3["bgndt"] != System.DBNull.Value)
            {
                lf_bgndt = Convert.ToString(dr3["bgndt"]);
                lf_bgndt_f = Convert.ToDateTime(dr3["bgndt"]).ToString("dd MMM yy");
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
                lf_bsbdt_f = Convert.ToDateTime(dr3["bsbdt"]).ToString("dd MMM yy");
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
                lf_finclosedt_f = Convert.ToDateTime(dr3["finclosedt"]).ToString("dd MMM yy");
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
                lf_mrsdt_f = Convert.ToDateTime(dr3["mrsdt"]).ToString("dd MMM yy");
            }
            lf_mrsdt = Convert.ToString(dr3["mrsdt"]);
            lf_mrsno = Convert.ToString(dr3["mrsno"]);

            if (lf_mrsno == "")
                IF_MRSNOYN = "No";
            else
                IF_MRSNOYN = "Yes";


            lf_mrssf = ".";// Convert.ToString(dr3["mrssf"]);
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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l1, l2, l3, l4, l5, l6, l7, l8;
            l1 = (Label)e.Row.FindControl("lblsta");
            l2 = (Label)e.Row.FindControl("lbleta");
            l3 = (Label)e.Row.FindControl("lblata");
            l4 = (Label)e.Row.FindControl("lblle1");
            l5 = (Label)e.Row.FindControl("lblstd");
            l6 = (Label)e.Row.FindControl("lbletd");
            l7 = (Label)e.Row.FindControl("lblatd");
            l8 = (Label)e.Row.FindControl("lblle2");

            if ((l1.Text == "N-A") && (l2.Text == "N-A") && (l3.Text == "N-A") && (l4.Text == "N-A"))
            {
                e.Row.Cells[3].Controls.Remove(l1);
                e.Row.Cells[3].Controls.Remove(l2);
                e.Row.Cells[3].Controls.Remove(l3);
                e.Row.Cells[3].Controls.Remove(l4);
                e.Row.Cells[3].Text = "N-A";
                e.Row.Cells[3].ColumnSpan = 4;
                //e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;//FromName("#dddddd");  
                //function.Font.Underline = true;
            }

            if ((l5.Text == "N-A") && (l6.Text == "N-A") && (l7.Text == "N-A") && (l8.Text == "N-A"))
            {
                e.Row.Cells[7].Text = "N-A";
                e.Row.Cells[7].ColumnSpan = 4;
                e.Row.Cells[7].ForeColor = System.Drawing.Color.FromName("#dddddd");
                //function.Font.Underline = true;
            }
        }
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

        if (abcd == "0")
        {
            DataSummary(docknotab1);
        }
        if (abcd == "1")
        {
            
            LifeCycleOp(docknotab1);
            //Response.Write(" <br>abcd" + docknotab1);
            // DiplayTab1(docknotab1);
        }
        else if (abcd == "2")
        {
            LifeCycleFin(docknotab1);
            //LifeCycleOp(docknotab1);
        }
        //else if (abcd == "3")
        //{
           
        //}
        //else if (abcd == "4")
        //{
        //    BindMovment(docknotab1);
        //} 
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

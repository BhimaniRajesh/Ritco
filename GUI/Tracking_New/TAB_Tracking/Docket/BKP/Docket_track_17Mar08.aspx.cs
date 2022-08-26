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

public partial class GUI_Tracking_New_TAB_Tracking_Docket_Docket_track : System.Web.UI.Page
{
    public static string POD,recd_person, call_dkt, status_doc, attech_doc, st_docdate, st_docname, st_docloc, st_docmadby, st_status, dockno, docksf, docket, origin, destcd, dockdt, dock_dt, curr_loc, Nextloc, from_loc, to_loc, Service_Class, pkgsno, chrgwt, PAYBASis, paybas, tranportmode, TRN_mod, Cnor, Cnee, CDELDT, dely_date, delivered, dept_dt, Arrv_dt, DATE_OF_Last_aatempt, NO_OF_aatempt, reason, cod_dod, declcodamt, codcollected, codno, codamt, POD_recDate, DocumentName, podtrack;
    public static SqlDataReader dr;
    public static string lo_dkt_status,str_dockno, lo_doc_curloc, lo_dockno, lo_dockdt, lo_pdc_loc, lo_prs_no, lo_pdc_date, lo_prs_cumm_day, lo_ls_status, lo_ls_loc, lo_ls_no, lo_ls_date, lo_ls_cumm_day, lo_tc_status, lo_tcbr, lo_tcno, lo_tcdt, lo_tc_cumm_day, lo_thc_status, lo_thcbr, lo_thcno, lo_thcdt, lo_thc_cumm_day, lo_tohub_br, lo_drs_loc, lo_drs_no, lo_drs_date, lo_drs_cumm_day;
    public static SqlDataReader dr2, dr3;
    public static string  lf_dockno, lf_Gen_oct, str_docksf, dkt, lf_docksf, lf_orgncd, lf_orgnnm, lf_destcd, lf_destnm, lf_re_destcd, lf_re_destnm, lf_paybas, lf_paybasnm, lf_dockdt, lf_dockdt_f, lf_book_cum_days, lf_msg_b, lf_bgndt, lf_bgndt_f, lf_bill_cum_days, lf_billno, lf_billsubbrcd, lf_msg_sun, lf_bsbdt, lf_bsbdt_f, lf_billsub_cum_days, lf_billcolbrcd, lf_billmrcol_cum_days, lf_mrsdt, lf_mrsdt_f, lf_mrsno, lf_mrssf, lf_mr_cum_days, lf_mrcol_cum_days, lf_finclosedt, lf_finclosedt_f, lf_msg_mrcoll, lf_billcolbrnm, lf_billsubbrnm, IF_MRSNOYN;
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        str_dockno = Request.QueryString["strDckNo"].ToString();
        str_docksf = Request.QueryString["strDcksf"].ToString();
        //dockno = Request.QueryString.ToString();
       // Response.Write("<br>dockno 123 : " + str_dockno);
        //Response.Write("<br>dockno 123 : " + str_docksf);
       // Response.End();
       call_dkt = Session["DocketCalledAs"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string sqlstr = "Webx_DOcket_TRack_summary";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = str_dockno;
        da.SelectCommand.Parameters.Add("@DOCKsf", SqlDbType.Text.ToString()).Value = str_docksf;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            dockno = dr["dockno"].ToString();
            docksf = dr["docksf"].ToString();
            docket = dr["docket"].ToString();
            origin = dr["origin"].ToString();
            destcd = dr["destcd"].ToString();
            dockdt = dr["dockdt"].ToString();
            dock_dt = dr["dock_dt"].ToString();
            curr_loc = dr["curr_loc"].ToString();
            Nextloc = dr["Nextloc"].ToString();
            from_loc = dr["from_loc"].ToString();
            to_loc = dr["to_loc"].ToString();
            Service_Class = dr["Service_Class"].ToString();
            pkgsno = dr["pkgsno"].ToString();
            chrgwt = dr["chrgwt"].ToString();
            PAYBASis = dr["PAYBASis"].ToString();
            paybas = dr["paybas"].ToString();
            tranportmode = dr["tranportmode"].ToString();
            TRN_mod = dr["TRN_mod"].ToString();
            Cnor = dr["Cnor"].ToString();
            Cnee = dr["Cnee"].ToString();
            CDELDT = dr["CDELDT"].ToString();
            dely_date = dr["dely_date"].ToString();
            delivered = dr["delivered"].ToString();
            dept_dt = dr["dept_dt"].ToString();
            Arrv_dt = dr["Arrv_dt"].ToString();
            DATE_OF_Last_aatempt = dr["DATE_OF_Last_aatempt"].ToString();
            NO_OF_aatempt = dr["NO_OF_aatempt"].ToString();
            reason = dr["reason"].ToString();
            cod_dod = dr["cod_dod"].ToString();
            declcodamt = dr["declcodamt"].ToString();
            codcollected = dr["codcollected"].ToString();
            codno = dr["codno"].ToString();
            codamt = dr["codamt"].ToString();
            POD_recDate = dr["POD_recDate"].ToString();
            DocumentName = dr["DocumentName"].ToString();
            podtrack = dr["podtrack"].ToString();

            if (dr["DocumentName"] is DBNull)
            {
                POD = "No POD Uploaded";
            }
            else
            {
                POD = "View Scanned POD";

            }

        }
        dr.Close();

        if (cod_dod == "Y")
        {
            tblcod.Visible = true;
        }
        else
        {
            tblcod.Visible = false;
        }
		
		

 		string sql_rec = " select top 1  recd_person from webx_pdctrn where dockno='"+str_dockno+"' and docksf='"+str_docksf+"' order by dely_dt desc  ";
        SqlCommand cmd_rec = new SqlCommand(sql_rec, conn);
        SqlDataReader dr_rec = cmd_rec.ExecuteReader();


		while (dr_rec.Read())
        {
			recd_person = dr_rec["recd_person"].ToString();
		}

 		dr_rec.Close();


        string sql_STstus = " exec  webx_Docket_status '" + docket + "' ";
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
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenWindowTHC('" + attech_doc + "')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";

            }
            if (st_docname.ToUpper() == "MF")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenWindow('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";

            }
            if (st_docname.ToUpper() == "LS")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindow1ls('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";

            }
            if (st_docname.ToUpper() == "CAN" || st_docname.ToUpper() == "DEN")
            {
                st_status = "<b>" + status_doc + "</b>    by " + st_docmadby + "  on <b>" + st_docdate + "</b>";

            }
        }
        dr_STstus.Close();


        string sqlstr1 = "select d.dockno,d.docksf,doc_curloc=CURLOC+' : ' + (select top 1  locname from webx_location where loccode=d.CURLOC),d.nEXTLOC AS tohub_br,c.tcno,c.thcno,Arrv_dt=(CASE WHEN In_Out='I' THEN atad ELSE '' END) ,actarrv_dt=(case when In_Out is null then '-' when In_Out='I' then (convert(varchar,atad,6)+' '+convert(varchar,atad,108)) end),(select top 1  convert(varchar,actdept_dt,6)+ '  ' + actdept_tm from webx_thchdr  where thcno=c.thcno and sourcehb=d.CURLOC  ) actdept_dt,(select top 1 vehno from webx_thc_summary where thcno=c.thcno ) as vehno ,drs ,prs from WebX_Trans_Docket_Track d with(NOLOCK) left outer join VW_THC_TC_Dockets c with(NOLOCK) on d.dockno=c.dockno and tcbr=CURLOC left outer join WebX_Trans_Docket_Status s  with(NOLOCK) on d.dockno=s.dockno and Curr_loc=CURLOC where  d.dockno+d.docksf='" + docket + "' order by srno ";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        sqlDA.Fill(ds);
        rptBillDetails.DataSource = ds;
        rptBillDetails.DataBind();









        /////////////////////////////////////////OPN

        tblheadache.Visible = true;
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        string sqlstr3 = "webx_life_cycle_operation_net";
        SqlCommand cmd3 = new SqlCommand(sqlstr3, conn);
        cmd3.CommandType = CommandType.StoredProcedure;
        da = new SqlDataAdapter(cmd3);
        // da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        TableRow tr1 = new TableRow();

        TableCell tctr1 = new TableCell();
        //TableCell tc2 = new TableCell();
        //TableCell tc3 = new TableCell();

        //TableCell tc4 = new TableCell();
        //TableCell tc5 = new TableCell();
        //TableCell tc6 = new TableCell();



        //tctr1.Text = "Life Cycle Operation ";
        //tctr1.CssClass = "blackboldfnt";
        //tctr1.Wrap = false;
        //tctr1.ColumnSpan = 6;
        //tctr1.HorizontalAlign = HorizontalAlign.Center;
        //tr1.CssClass = "bgbluegrey";
        //tr1.Cells.Add(tctr1);


        //tblheadache.Rows.Add(tr1);

        TableRow tr11 = new TableRow();

        TableCell tctr11 = new TableCell();
        //TableCell tc2 = new TableCell();
        //TableCell tc3 = new TableCell();

        //TableCell tc4 = new TableCell();
        //TableCell tc5 = new TableCell();
        //TableCell tc6 = new TableCell();



        //tctr11.Text = "";
        //tctr11.CssClass = "blackboldfnt";
        //tctr11.Wrap = false;
        //tctr11.ColumnSpan = 6;
        //tr11.BackColor = System.Drawing.Color.White;
        //tr11.Cells.Add(tctr11);


        //tblheadache.Rows.Add(tr11);


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


        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = str_dockno;
        da.SelectCommand.Parameters.Add("@DOCKsf", SqlDbType.Text.ToString()).Value = str_docksf;
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
            if (lo_ls_no == "" || lo_ls_no == null)
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





        string sqlstr4 = "WEBX_LifeCycle_Fin";
        SqlCommand cmd4 = new SqlCommand(sqlstr4, conn);
        cmd4.CommandType = CommandType.StoredProcedure;
         da = new SqlDataAdapter(cmd4);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = str_dockno;
        da.SelectCommand.Parameters.Add("@DOCKsf", SqlDbType.Text.ToString()).Value = str_docksf;
        dr3 = cmd4.ExecuteReader();
        while (dr3.Read())
        {
            //public static string lf_dockno, lf_docksf, lf_orgncd, lf_destcd, lf_re_destcd, 
            //lf_paybas, lf_dockdt, lf_book_cum_days, 
            //lf_msg_b, lf_bgndt, lf_bill_cum_days, lf_billno, lf_billsubbrcd, msg_sun,
            //lf_bsbdt, lf_billsub_cum_days, lf_billcolbrcd,
            //lf_mrsdt, lf_mrsno,lf_mrssf,
            //lf_mr_cum_days,lf_mrcol_cum_days,lf_finclosedt,lf_msg_coll;
            lf_dockno = Convert.ToString(dr3["dockno"]).Trim();
            lf_docksf = Convert.ToString(dr3["docksf"]).Trim();
            lf_orgncd = Convert.ToString(dr3["orgncd"]);
            lf_orgnnm = getname(Convert.ToString(dr3["orgncd"]));
            lf_destcd = Convert.ToString(dr3["destcd"]);
            lf_destnm = getname(Convert.ToString(dr3["destcd"]));
            lf_re_destcd = Convert.ToString(dr3["destcd"]);
            lf_re_destnm = getname(Convert.ToString(dr3["destcd"]));
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
            lf_msg_b = Convert.ToString(dr3["tbb_bill"]) == "Y" ? "Yes" : "No";
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

            if (Convert.ToString(dr3["billcolbrcd"]) != "Y")
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

    protected string getname(string a)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select top 1 locname from webx_location where loccode='" + a + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        string result = Convert.ToString(cmd.ExecuteScalar());
        return result;
    }

    protected string GetPayMode(string a)
    {
        string paybasdesc = "";
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
            default:
                return paybasdesc;
        }


    }

    protected string datedifferance(string fromdt, string todt)
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

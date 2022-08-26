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
  

public partial class GUI_Tracking_New_TAB_Tracking_Docket_Docket_OPN_Cycle : System.Web.UI.Page
{

    public static string dockno, call_dkt;
    public static string lo_dkt_status, lo_doc_curloc, lo_dockno, lo_dockdt, lo_pdc_loc, lo_prs_no, lo_pdc_date, lo_prs_cumm_day, lo_ls_status, lo_ls_loc, lo_ls_no, lo_ls_date, lo_ls_cumm_day, lo_tc_status, lo_tcbr, lo_tcno, lo_tcdt, lo_tc_cumm_day, lo_thc_status, lo_thcbr, lo_thcno, lo_thcdt, lo_thc_cumm_day, lo_tohub_br, lo_drs_loc, lo_drs_no, lo_drs_date, lo_drs_cumm_day;
    public static SqlDataReader dr2, dr3;
    protected void Page_Load(object sender, EventArgs e)
    {

        dockno = Request.QueryString["dockno"].ToString();
        //Response.Write("<br>dockno 123 : " + dockno);

        call_dkt = Session["DocketCalledAs"].ToString();

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
    }
}

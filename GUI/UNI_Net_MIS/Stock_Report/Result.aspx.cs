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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
public partial class GUI_UNI_MIS_Stock_Report_Result : System.Web.UI.Page
{

    public static string dkt_call;
    double RO_BKGSTOC = 0, RO_DLTSTOC = 0, RO_TSPSTOC = 0, RO_TOTSTOC = 0;
    double TOT_BKGSTOC = 0, TOT_DLTSTOC = 0, TOT_TSPSTOC = 0, TOT_TOTSTOC = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();

        }
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {

       

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string RO, LO, DateType, fromdt, todt;

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        
        string dtFrom = fromdt;
        string dtTo = todt;
      
        lblseldet.Text = dtFrom + " - " + dtTo;
        lblloc.Text = LO;
        lblro.Text = RO;

        string sqlLoc = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + LO + "'";
        SqlCommand cmdLoc = new SqlCommand(sqlLoc, conn);
        SqlDataReader drLoc;
        drLoc = cmdLoc.ExecuteReader();

        while (drLoc.Read())
        {
            lblloc.Text = Convert.ToString(drLoc["Loccode"]) + ":" + Convert.ToString(drLoc["Locname"]);
        }
        drLoc.Close();

        string sqlRegion = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + RO + "'";
        SqlCommand cmdRegion = new SqlCommand(sqlRegion, conn);
        SqlDataReader drRegion;
        drRegion = cmdRegion.ExecuteReader();

        while (drRegion.Read())
        {
            lblro.Text = Convert.ToString(drRegion["Loccode"]) + ":" + Convert.ToString(drRegion["Locname"]);
        }
        drRegion.Close();

        string sql_st = "exec webx_Stock_Report '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "'";
       // Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
	sqlcmd12.CommandTimeout = 300;
        //SqlDataReader dr = sqlcmd12.ExecuteReader();

        SqlDataReader dr = sqlcmd12.ExecuteReader();
        
        TableRow tr1 = new TableRow();
        TableCell tr1tc1 = new TableCell();
        TableCell tr1tc2 = new TableCell();
        TableCell tr1tc3 = new TableCell();
        TableCell tr1tc4 = new TableCell();
        TableCell tr1tc5 = new TableCell();
        TableCell tr1tc6 = new TableCell();

        tr1tc1.Text = "Sr No.";
        tr1tc1.CssClass = "blackboldfnt";
        tr1tc1.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc1);

            tr1tc2.Text = "Location";
            tr1tc2.CssClass = "blackboldfnt";
            tr1tc2.Wrap = false;
            tr1.CssClass = "bgbluegrey";
            tr1.Cells.Add(tr1tc2);

        tr1tc3.Text = "Booking Stock";
        tr1tc3.CssClass = "blackboldfnt";
        tr1tc3.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc3);

        tr1tc4.Text = "Delivery Stock";
        tr1tc4.CssClass = "blackboldfnt";
        tr1tc4.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc4);

        tr1tc5.Text = "Transhipment Stock";
        tr1tc5.CssClass = "blackboldfnt";
        tr1tc5.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc5);

        tr1tc6.Text = "Total Stock";
        tr1tc6.CssClass = "blackboldfnt";
        tr1tc6.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc6);

        tr1.BorderWidth = 1;
        tr1.BorderColor = System.Drawing.Color.Gray;
        tr1.HorizontalAlign = HorizontalAlign.Center;
        TBL_Stock.Rows.Add(tr1);

        int i = 1;
        string CRo = "", PrevRO = "";
        while (dr.Read())
        {

            CRo = dr["report_loc"].ToString();
            if (CRo != PrevRO && PrevRO != "")
            {
                TableRow tr2 = new TableRow();
                TableCell tr2tc1 = new TableCell();
                TableCell tr2tc2 = new TableCell();
                TableCell tr2tc3 = new TableCell();
                TableCell tr2tc4 = new TableCell();
                TableCell tr2tc5 = new TableCell();
                TableCell tr2tc6 = new TableCell();

                tr2tc1.Text = PrevRO;
                tr2.CssClass = "bluefnt";
                tr2tc1.ColumnSpan = 2;
                tr2.Font.Bold = true;
                tr2tc1.Wrap = false;
                tr2.Cells.Add(tr2tc1);

                tr2.BackColor = System.Drawing.Color.White;
                tr2.HorizontalAlign = HorizontalAlign.Center;
                TBL_Stock.Rows.Add(tr2);

                tr2tc3.Text = RO_BKGSTOC.ToString();
                tr2tc3.CssClass = "blckfnt";
                tr2tc3.Wrap = false;
                tr2.Cells.Add(tr2tc3);

                tr2tc4.Text = RO_DLTSTOC.ToString();
                tr2tc4.CssClass = "blckfnt";
                tr2tc4.Wrap = false;
                tr2.Cells.Add(tr2tc4);

                tr2tc5.Text = RO_TSPSTOC.ToString();
                tr2tc5.CssClass = "blckfnt";
                tr2tc5.Wrap = false;
                tr2.Cells.Add(tr2tc5);

                tr2tc6.Text = RO_TOTSTOC.ToString();
                tr2tc6.CssClass = "blckfnt";
                tr2tc6.Wrap = false;
                tr2.Cells.Add(tr2tc6);

                RO_BKGSTOC = 0;
                RO_DLTSTOC = 0;
                RO_TSPSTOC = 0;
                RO_TOTSTOC = 0;
            }

            TableRow tr3 = new TableRow();
            TableCell tr3tc1 = new TableCell();
            TableCell tr3tc2 = new TableCell();
            TableCell tr3tc3 = new TableCell();
            TableCell tr3tc4 = new TableCell();
            TableCell tr3tc5 = new TableCell();
            TableCell tr3tc6 = new TableCell();

            tr3tc1.Text = i.ToString();
            tr3tc1.CssClass = "blckfnt";
            tr3tc1.Wrap = false;
            tr3.Cells.Add(tr3tc1);
            tr3tc1.HorizontalAlign = HorizontalAlign.Center;

            tr3tc2.Text = dr["location"].ToString();
            tr3tc2.CssClass = "blckfnt";
            tr3tc2.Wrap = false;
            tr3.Cells.Add(tr3tc2);
            tr3tc2.HorizontalAlign = HorizontalAlign.Left;

            double loc_tot = Convert.ToDouble(dr["Booking_Stock"].ToString()) + Convert.ToDouble(dr["Delivery_Stock"].ToString()) + Convert.ToDouble(dr["Transhipment_Stock"].ToString());


            string rptno = "", dirlldown = "", rpttyp="";
            rptno = "1";
            rpttyp = "Booking Stock";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno + "&rpttyp=" + rpttyp;
            tr3tc3.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["Booking_Stock"].ToString() + "</u></a>";
            // tr3tc3.Text = dr["Booking_Stock"].ToString();
            tr3tc3.CssClass = "blckfnt";
            tr3tc3.Wrap = false;
            tr3.Cells.Add(tr3tc3);

            rptno = "2";
            rpttyp = "Delivery Stock";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno + "&rpttyp=" + rpttyp;
            tr3tc4.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["Delivery_Stock"].ToString() + "</u></a>";          
            //tr3tc4.Text = dr["Delivery_Stock"].ToString();
            tr3tc4.CssClass = "blckfnt";
            tr3tc4.Wrap = false;
            tr3.Cells.Add(tr3tc4);

            rptno = "3";
            rpttyp = "Transhipment Stock";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno + "&rpttyp=" + rpttyp;
            tr3tc5.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["Transhipment_Stock"].ToString() + "</u></a>";                      
           // tr3tc5.Text = dr["Transhipment_Stock"].ToString();
            tr3tc5.CssClass = "blckfnt";
            tr3tc5.Wrap = false;
            tr3.Cells.Add(tr3tc5);

            rptno = "4";
            rpttyp = "Total Stock";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno + "&rpttyp=" + rpttyp;
            tr3tc6.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + loc_tot.ToString() + "</u></a>";                      
           //tr3tc6.Text = loc_tot.ToString();
            tr3tc6.CssClass = "blckfnt";
            tr3tc6.Wrap = false;
            tr3.Cells.Add(tr3tc6);

            tr3.BorderWidth = 1;
            tr3.BorderColor = System.Drawing.Color.Gray;
            tr3.BackColor = System.Drawing.Color.White;
            tr3.HorizontalAlign = HorizontalAlign.Center;
            TBL_Stock.Rows.Add(tr3);
            PrevRO = dr["report_loc"].ToString();
            i += 1;


            TOT_BKGSTOC += Convert.ToDouble(dr["Booking_Stock"].ToString());
            TOT_DLTSTOC += Convert.ToDouble(dr["Delivery_Stock"].ToString());
            TOT_TSPSTOC += Convert.ToDouble(dr["Transhipment_Stock"].ToString());
            TOT_TOTSTOC += loc_tot;


            RO_BKGSTOC += Convert.ToDouble(dr["Booking_Stock"].ToString());
            RO_DLTSTOC += Convert.ToDouble(dr["Delivery_Stock"].ToString());
            RO_TSPSTOC += Convert.ToDouble(dr["Transhipment_Stock"].ToString());
            RO_TOTSTOC += loc_tot;

            

        }

        dr.Close();
        TableRow tr4 = new TableRow();
        TableCell tr4tc1 = new TableCell();
        TableCell tr4tc2 = new TableCell();
        TableCell tr4tc3 = new TableCell();
        TableCell tr4tc4 = new TableCell();
        TableCell tr4tc5 = new TableCell();
        TableCell tr4tc6 = new TableCell();

        tr4tc1.Text = PrevRO;
        tr4.CssClass = "bluefnt";
        tr4tc1.ColumnSpan = 2;
        tr4.Font.Bold = true;
        tr4tc1.Wrap = false;
        tr4.Cells.Add(tr4tc1);

        tr4tc3.Text = RO_BKGSTOC.ToString();
        tr4tc3.CssClass = "blckfnt";
        tr4tc3.Wrap = false;
        tr4.Cells.Add(tr4tc3);

        tr4tc4.Text = RO_DLTSTOC.ToString();
        tr4tc4.CssClass = "blckfnt";
        tr4tc4.Wrap = false;
        tr4.Cells.Add(tr4tc4);

        tr4tc5.Text = RO_TSPSTOC.ToString();
        tr4tc5.CssClass = "blckfnt";
        tr4tc5.Wrap = false;
        tr4.Cells.Add(tr4tc5);

        tr4tc6.Text = RO_TOTSTOC.ToString();
        tr4tc6.CssClass = "blckfnt";
        tr4tc6.Wrap = false;
        tr4.Cells.Add(tr4tc6);

        tr4.BorderWidth = 1;
        tr4.BorderColor = System.Drawing.Color.Gray;
        tr4.BackColor = System.Drawing.Color.White;
        tr4.HorizontalAlign = HorizontalAlign.Center;
        TBL_Stock.Rows.Add(tr4);

        TableRow tr5 = new TableRow();
        TableCell tr5tc1 = new TableCell();
        TableCell tr5tc2 = new TableCell();
        TableCell tr5tc3 = new TableCell();
        TableCell tr5tc4 = new TableCell();
        TableCell tr5tc5 = new TableCell();
        TableCell tr5tc6 = new TableCell();

        tr5tc1.Text = "Total";
        tr5.CssClass = "bluefnt";
        tr5tc1.ColumnSpan = 2;
        tr5.Font.Bold = true;
        tr5tc1.Wrap = false;
        tr5.Cells.Add(tr5tc1);

        tr5tc3.Text = TOT_BKGSTOC.ToString();
        tr5tc3.CssClass = "blckfnt";
        tr5tc3.Wrap = false;
        tr5.Cells.Add(tr5tc3);

        tr5tc4.Text = TOT_DLTSTOC.ToString();
        tr5tc4.CssClass = "blckfnt";
        tr5tc4.Wrap = false;
        tr5.Cells.Add(tr5tc4);

        tr5tc5.Text = TOT_TSPSTOC.ToString();
        tr5tc5.CssClass = "blckfnt";
        tr5tc5.Wrap = false;
        tr5.Cells.Add(tr5tc5);

        tr5tc6.Text = TOT_TOTSTOC.ToString();
        tr5tc6.CssClass = "blckfnt";
        tr5tc6.Wrap = false;
        tr5.Cells.Add(tr5tc6);

        tr5.BorderWidth = 1;
        tr5.BorderColor = System.Drawing.Color.Gray;
        tr5.BackColor = System.Drawing.Color.White;
        tr5.HorizontalAlign = HorizontalAlign.Center;
        TBL_Stock.Rows.Add(tr5);

    }

     protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        TBL_CRI.Border = 1;


        //dgDocket.AllowPaging = false;
        TBL_Stock.BorderWidth = 1;
        TBL_Stock.Font.Size =8;
        TBL_Stock.Font.Name = "verdana";
        //dgDocket.CssClass = "blackfnt";
        //dgDocket.Font.Size = 10;



        //BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Stock_Summary.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(TBL_Stock);


        //frm.Controls.Add(TBL_CRI);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();





    }
}

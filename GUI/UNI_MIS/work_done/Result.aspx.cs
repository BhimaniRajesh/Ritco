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
public partial class GUI_UNI_MIS_work_done_Result : System.Web.UI.Page
{
    string Doc_type;
    public static string strDateRange;
    public static string strro, strro_val;
    public static string strloc;
    public static string strcust, dkt_call, Rtyp,thc_call,  roval="", Preroval="";
    double dbltotdoc = 0.00, dbltols = 0.00, dbltomf = 0.00, dbltothc = 0.00, dbltoprs = 0.00, dbltodrs = 0.00;
    double totdkts = 0, totls = 0, totmf = 0, totthc = 0, totprs = 0, totdrs = 0;
    double RO_totdkts = 0, RO_totls = 0, RO_totmf = 0, RO_totthc = 0, RO_totprs = 0, RO_totdrs = 0;
    private GridViewHelper helper;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();

        dkt_call = Session["DocketCalledAs"].ToString();
        thc_call = Session["THCCalledAs"].ToString();

    }
    //protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        Label dkt_colname = (Label)e.Row.FindControl("lblColname");
    //        Label lblColthc = (Label)e.Row.FindControl("lblColthc");

    //        dkt_colname.Text ="Total "+  dkt_call + " Booked";
    //        lblColthc.Text = "Total " + thc_call + " Booked";
    //    }
    //    else if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Label lbl = (Label)e.Row.FindControl("lbldockno");
    //        dbltotdoc = dbltotdoc + Convert.ToDouble(lbl.Text);
    //        Label lblls = (Label)e.Row.FindControl("lblls");
    //        dbltols = dbltols + Convert.ToDouble(lblls.Text);
    //        Label lblmf = (Label)e.Row.FindControl("lblmf");
    //        dbltomf = dbltomf + Convert.ToDouble(lblmf.Text);
    //        Label lblthc = (Label)e.Row.FindControl("lblthc");
    //        dbltothc = dbltothc + Convert.ToDouble(lblthc.Text);
    //        Label lblprs = (Label)e.Row.FindControl("lblprs");
    //        dbltoprs = dbltoprs + Convert.ToDouble(lblprs.Text);
    //        Label lbldrs = (Label)e.Row.FindControl("lbldrs");
    //        dbltodrs = dbltodrs + Convert.ToDouble(lbldrs.Text);

    //        HiddenField lblro = (HiddenField)e.Row.FindControl("hidro");
    //        HiddenField lblroname = (HiddenField)e.Row.FindControl("hidroname");


    //        roval = lblro.Value.ToString();

    //        if (roval == Preroval )
    //        {
    //            Table table = (Table)this.dgDocket.Controls[0];
    //            GridView oGridView = (GridView)sender;
    //            int realindex = table.Rows.GetRowIndex(e.Row);
    //            GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
    //            TableCell oTableCell = new TableCell();

    //            oTableCell.Text = lblroname.Value.ToString();//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
    //            //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
    //            oTableCell.ColumnSpan = 2;
    //            oTableCell.CssClass = "blackfnt";
    //            oTableCell.Font.Bold = true;
    //            oTableCell.HorizontalAlign = HorizontalAlign.Right;
    //            oGridViewRow.Cells.Add(oTableCell);

    //            e.Row.BackColor = System.Drawing.Color.White;

    //            oTableCell.Wrap = false;
               

    //            oTableCell.HorizontalAlign = HorizontalAlign.Left;
    //            oGridViewRow.Cells.Add(oTableCell);
    //            oGridViewRow.BackColor = System.Drawing.Color.White;
    //            table.Controls.AddAt(realindex + 1, oGridViewRow);
    //        }
    //        Preroval = lblro.Value.ToString();
    //    }
    //    else if (e.Row.RowType == DataControlRowType.Footer)
    //    {
    //        Label lbl = (Label)e.Row.FindControl("lbltotnodocks");
    //        lbl.Text = dbltotdoc.ToString();
    //        Label lblls = (Label)e.Row.FindControl("lbltotnols");
    //        lblls.Text = dbltols.ToString();
    //        Label lblmf = (Label)e.Row.FindControl("lbltotnomf");
    //        lblmf.Text = dbltomf.ToString();

    //        Label lblthc = (Label)e.Row.FindControl("lbltotnothc");
    //        lblthc.Text = dbltothc.ToString();

    //        Label lblprs = (Label)e.Row.FindControl("lbltotnoprs");
    //        lblprs.Text = dbltoprs.ToString();

    //        Label lbldrs = (Label)e.Row.FindControl("lbltotnodrs");
    //        lbldrs.Text = dbltodrs.ToString();
    //    }
        

    //}
   
    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string strrightnow = "", strrightnow1 = "", dtFrom = "", dtTo = "";
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");

        string RO = Request.QueryString.Get("RO");
        if (RO == "")
        {
            RO = "All";
        }
        string LO = Request.QueryString.Get("LO");
        if (LO == "")
        {
            LO = "All";
        }
        string DateType = Request.QueryString.Get("DateType");

        // string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        if (DateType == "Date")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (DateType == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        Doc_type = Request.QueryString.Get("Rtyp");
        Rtyp = Request.QueryString.Get("Rtyp");
        string custcd = Request.QueryString.Get("St_custcd");
       // string st_vendcd = Request.QueryString.Get("st_vendcd");
        string st_orderlist = Request.QueryString.Get("st_orderlist");

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblro.Text = RO;
        lblloc.Text = LO;
        lblcust.Text = custcd;
        //st_orderlist = "";
        //if (Doc_type.ToUpper() == "THC")
        //{
        //    custcd = st_vendcd;
        //    st_orderlist = Request.QueryString.Get("st_orderlist");
        //}

        //lblflow string custcd = "";

        if (custcd.ToString() == "")
        {
            custcd = "";

        }

        if (Rtyp == "1")
        {
            if (st_orderlist == "docdt")
            {
                lblflow.Text = "Location Wise :- Documnet Date";
            }
            else
            {
                lblflow.Text = "Location Wise :- System Date";
            }
        }
        else 
        {
            if (st_orderlist == "docdt")
            {
                lblflow.Text = "Employee Wise :- Documnet Date";
            }
            else
            {
                lblflow.Text = "Employee Wise :- System Date";
            }
        }

        String SQL_grid = "exec webx_Work_done '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + st_orderlist + "','" + custcd + "','" + Rtyp + "'";

        //Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataReader dr = sqlcmd12.ExecuteReader();
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        //DataSet ds = new DataSet();

        //da.Fill(ds);


        TableRow tr1a = new TableRow();
        TableCell tr1atc1 = new TableCell();
        TableCell tr1atc2 = new TableCell();
        TableCell tr1atc3 = new TableCell();
        TableCell tr1atc4 = new TableCell();
        TableCell tr1atc5 = new TableCell();
        TableCell tr1atc6 = new TableCell();
        TableCell tr1atc7 = new TableCell();
        TableCell tr1atc8 = new TableCell();
        TableCell tr1atc9 = new TableCell();
        tr1atc1.Text = "Sr No.";
        tr1atc1.CssClass = "blackboldfnt";
        tr1atc1.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc1);

        tr1atc2.Text = "Location";
        tr1atc2.CssClass = "blackboldfnt";
        tr1atc2.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc2);

        tr1atc3.Text = "Total "+dkt_call+" Booekd";
        tr1atc3.CssClass = "blackboldfnt";
        tr1atc3.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc3);

        tr1atc4.Text = "Total LS Booekd";
        tr1atc4.CssClass = "blackboldfnt";
        tr1atc4.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc4);

        tr1atc5.Text = "Total MF Booekd";
        tr1atc5.CssClass = "blackboldfnt";
        tr1atc5.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc5);

        tr1atc6.Text = "Total " + thc_call + " Booekd";
        tr1atc6.CssClass = "blackboldfnt";
        tr1atc6.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc6);

        tr1atc7.Text = "Total PRS Booekd";
        tr1atc7.CssClass = "blackboldfnt";
        tr1atc7.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc7);

        tr1atc8.Text = "Total DRS Booekd";
        tr1atc8.CssClass = "blackboldfnt";
        tr1atc8.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc8);

        //tr1atc9.Text = "Total DRS Closed";
        //tr1atc9.CssClass = "blackboldfnt";
        //tr1atc9.Wrap = false;
        //tr1a.CssClass = "bgbluegrey";
        //tr1a.Cells.Add(tr1atc9);
        

        tr1a.HorizontalAlign = HorizontalAlign.Center;
        TBL_MonthlySales.Rows.Add(tr1a);
        //dgDocket.DataSource = ds;
        //dgDocket.DataBind();
        //dgDocket.Visible = true;
        int i=1;
        string CRo = "", PrevRO = "";
        while (dr.Read())
        {
            
            CRo = dr["report_loc"].ToString();
            if (CRo != PrevRO && PrevRO != "")
            {
                TableRow tr2a1 = new TableRow();
                TableCell tr2atc11 = new TableCell();
                TableCell tr2atc21 = new TableCell();
                TableCell tr2atc31 = new TableCell();
                TableCell tr2atc41 = new TableCell();
                TableCell tr2atc51 = new TableCell();
                TableCell tr2atc61 = new TableCell();
                TableCell tr2atc71 = new TableCell();
                TableCell tr2atc81 = new TableCell();
                TableCell tr2atc91 = new TableCell();
                tr2atc11.Text = strro_val.ToString();
                tr2atc11.CssClass = "blackfnt";
                tr2atc11.ColumnSpan = 2;
                tr2atc11.Wrap = false;
                tr2atc11.Font.Bold = true;
                tr2a1.CssClass = "bluefnt";
                tr2a1.Cells.Add(tr2atc11);

                tr2atc21.Text =RO_totdkts.ToString();
                tr2atc21.CssClass = "blackfnt";
                tr2atc21.Wrap = false;

                tr2a1.CssClass = "bgbluegrey";
                tr2a1.Cells.Add(tr2atc21);

                tr2atc31.Text = RO_totls.ToString();
                tr2atc31.CssClass = "blackfnt";
                tr2atc31.Wrap = false;
                tr2a1.CssClass = "bgbluegrey";
                tr2a1.Cells.Add(tr2atc31);

                tr2atc41.Text = RO_totmf.ToString();
                tr2atc41.CssClass = "blackfnt";
                tr2atc41.Wrap = false;
                tr2a1.CssClass = "bgbluegrey";
                tr2a1.Cells.Add(tr2atc41);

                tr2atc51.Text = RO_totthc.ToString();
                tr2atc51.CssClass = "blackfnt";
                tr2atc51.Wrap = false;
                tr2a1.CssClass = "bgbluegrey";
                tr2a1.Cells.Add(tr2atc51);

                tr2atc61.Text = RO_totprs.ToString();
                tr2atc61.CssClass = "blackfnt";
                tr2atc61.Wrap = false;
                tr2a1.CssClass = "bgbluegrey";
                tr2a1.Cells.Add(tr2atc61);

                tr2atc71.Text = RO_totdrs.ToString();
                tr2atc71.CssClass = "blackfnt";
                tr2atc71.Wrap = false;
                tr2a1.CssClass = "bgbluegrey";
                tr2a1.Cells.Add(tr2atc71);

                //tr2atc81.Text = RO_totdkts.ToString();
                //tr2atc81.CssClass = "blackfnt";
                //tr2atc81.Wrap = false;
                //tr2a1.CssClass = "blackfnt";
                //tr2a1.Cells.Add(tr2atc81);

                //tr2atc9.Text = "Total DRS Closed";
                //tr2atc9.CssClass = "blackfnt";
                //tr2atc9.Wrap = false;
                //tr2a.CssClass = "blackfnt";
                //tr2a.Cells.Add(tr2atc9);
                tr2a1.CssClass = "bluefnt";
                tr2a1.BackColor = System.Drawing.Color.White;
                tr2a1.HorizontalAlign = HorizontalAlign.Center;
                TBL_MonthlySales.Rows.Add(tr2a1);


                RO_totdkts = 0;
                 RO_totls = 0;
                 RO_totmf = 0;
                 RO_totthc = 0;
                 RO_totprs = 0;
                 RO_totdrs = 0;
            }
            


            TableRow tr2a = new TableRow();
            TableCell tr2atc1 = new TableCell();
            TableCell tr2atc2 = new TableCell();
            TableCell tr2atc3 = new TableCell();
            TableCell tr2atc4 = new TableCell();
            TableCell tr2atc5 = new TableCell();
            TableCell tr2atc6 = new TableCell();
            TableCell tr2atc7 = new TableCell();
            TableCell tr2atc8 = new TableCell();
            TableCell tr2atc9 = new TableCell();
            tr2atc1.Text = i.ToString();
            tr2atc1.CssClass = "blackfnt";
            tr2atc1.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc1);

            tr2atc2.Text = dr["loccode"].ToString() + " : " + dr["locname"].ToString();
            tr2atc2.CssClass = "blackfnt";
            tr2atc2.Wrap = false;
            tr2atc2.HorizontalAlign = HorizontalAlign.Left;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc2);

            tr2atc3.Text = dr["tot_dockets"].ToString();
            tr2atc3.CssClass = "blackfnt";
            tr2atc3.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc3);

            tr2atc4.Text = dr["tot_ls"].ToString();
            tr2atc4.CssClass = "blackfnt";
            tr2atc4.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc4);

            tr2atc5.Text = dr["tot_mf"].ToString();
            tr2atc5.CssClass = "blackfnt";
            tr2atc5.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc5);

            tr2atc6.Text = dr["tot_thc"].ToString();
            tr2atc6.CssClass = "blackfnt";
            tr2atc6.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc6);

            tr2atc7.Text = dr["tot_prs"].ToString();
            tr2atc7.CssClass = "blackfnt";
            tr2atc7.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc7);

            tr2atc8.Text = dr["tot_drs"].ToString();
            tr2atc8.CssClass = "blackfnt";
            tr2atc8.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc8);

            //tr2atc9.Text = "Total DRS Closed";
            //tr2atc9.CssClass = "blackfnt";
            //tr2atc9.Wrap = false;
            //tr2a.CssClass = "blackfnt";
            //tr2a.Cells.Add(tr2atc9);

            tr2a.BackColor = System.Drawing.Color.White;
            tr2a.HorizontalAlign = HorizontalAlign.Center;
            TBL_MonthlySales.Rows.Add(tr2a);

            i = i + 1;

            totdkts = totdkts + Convert.ToDouble(dr["tot_dockets"].ToString());
            totls = totls + Convert.ToDouble(dr["tot_ls"].ToString());
            totmf = totmf + Convert.ToDouble(dr["tot_mf"].ToString());
            totthc = totthc + Convert.ToDouble(dr["tot_thc"].ToString());
            totprs = totprs + Convert.ToDouble(dr["tot_prs"].ToString());
            totdrs = totdrs + Convert.ToDouble(dr["tot_drs"].ToString());

            RO_totdkts = RO_totdkts + Convert.ToDouble(dr["tot_dockets"].ToString());
            RO_totls = RO_totls + Convert.ToDouble(dr["tot_ls"].ToString());
            RO_totmf = RO_totmf + Convert.ToDouble(dr["tot_mf"].ToString());
            RO_totthc = RO_totthc + Convert.ToDouble(dr["tot_thc"].ToString());
            RO_totprs = RO_totprs + Convert.ToDouble(dr["tot_prs"].ToString());
            RO_totdrs = RO_totdrs + Convert.ToDouble(dr["tot_drs"].ToString());

            PrevRO = dr["report_loc"].ToString();
            strro_val = dr["report_name"].ToString();
        }

        conn.Close();

        TableRow tr2a1a = new TableRow();
        TableCell tr2atc11a = new TableCell();
        TableCell tr2atc21a = new TableCell();
        TableCell tr2atc31a = new TableCell();
        TableCell tr2atc41a = new TableCell();
        TableCell tr2atc51a = new TableCell();
        TableCell tr2atc61a = new TableCell();
        TableCell tr2atc71a = new TableCell();
        TableCell tr2atc81a = new TableCell();
        TableCell tr2atc91a = new TableCell();
        tr2atc11a.Text = strro_val;
        tr2atc11a.CssClass = "blackfnt";
        tr2atc11a.ColumnSpan = 2;
        tr2atc11a.Font.Bold = true;
        tr2atc11a.Wrap = false;
        tr2a1a.CssClass = "bluefnt";
        tr2a1a.Cells.Add(tr2atc11a);

        tr2atc21a.Text = RO_totdkts.ToString();
        tr2atc21a.CssClass = "blackfnt";
        tr2atc21a.Wrap = false;

        tr2a1a.CssClass = "bgbluegrey";
        tr2a1a.Cells.Add(tr2atc21a);

        tr2atc31a.Text = RO_totls.ToString();
        tr2atc31a.CssClass = "blackfnt";
        tr2atc31a.Wrap = false;
        tr2a1a.CssClass = "bgbluegrey";
        tr2a1a.Cells.Add(tr2atc31a);

        tr2atc41a.Text = RO_totmf.ToString();
        tr2atc41a.CssClass = "blackfnt";
        tr2atc41a.Wrap = false;
        tr2a1a.CssClass = "bgbluegrey";
        tr2a1a.Cells.Add(tr2atc41a);

        tr2atc51a.Text = RO_totthc.ToString();
        tr2atc51a.CssClass = "blackfnt";
        tr2atc51a.Wrap = false;
        tr2a1a.CssClass = "bgbluegrey";
        tr2a1a.Cells.Add(tr2atc51a);

        tr2atc61a.Text = RO_totprs.ToString();
        tr2atc61a.CssClass = "blackfnt";
        tr2atc61a.Wrap = false;
        tr2a1a.CssClass = "bgbluegrey";
        tr2a1a.Cells.Add(tr2atc61a);

        tr2atc71a.Text = RO_totdrs.ToString();
        tr2atc71a.CssClass = "blackfnt";
        tr2atc71a.Wrap = false;
        tr2a1a.CssClass = "bgbluegrey";
        tr2a1a.Cells.Add(tr2atc71a);

        //tr2atc81.Text = RO_totdkts.ToString();
        //tr2atc81.CssClass = "blackfnt";
        //tr2atc81.Wrap = false;
        //tr2a1.CssClass = "blackfnt";
        //tr2a1.Cells.Add(tr2atc81);

        //tr2atc9.Text = "Total DRS Closed";
        //tr2atc9.CssClass = "blackfnt";
        //tr2atc9.Wrap = false;
        //tr2a.CssClass = "blackfnt";
        //tr2a.Cells.Add(tr2atc9);
        tr2a1a.CssClass = "bluefnt";
        tr2a1a.BackColor = System.Drawing.Color.White;
        tr2a1a.HorizontalAlign = HorizontalAlign.Center;
        TBL_MonthlySales.Rows.Add(tr2a1a);
        dr.Close();


        TableRow tr2a1b = new TableRow();
        TableCell tr2atc11b = new TableCell();
        TableCell tr2atc21b = new TableCell();
        TableCell tr2atc31b = new TableCell();
        TableCell tr2atc41b = new TableCell();
        TableCell tr2atc51b = new TableCell();
        TableCell tr2atc61b = new TableCell();
        TableCell tr2atc71b = new TableCell();
        TableCell tr2atc81b = new TableCell();
        TableCell tr2atc91b = new TableCell();
        tr2atc11b.Text = "Total";
        tr2atc11b.CssClass = "blackfnt";
        tr2atc11b.ColumnSpan = 2;
        tr2atc11b.Wrap = false;
        tr2atc11b.Font.Bold = true;
        tr2a1b.CssClass = "bluefnt";
        tr2a1b.Cells.Add(tr2atc11b);

        tr2atc21b.Text = totdkts.ToString();
        tr2atc21b.CssClass = "blackfnt";
        tr2atc21b.Wrap = false;
        tr2atc21b.Font.Bold = true;
        tr2a1b.CssClass = "bgbluegrey";
        tr2a1b.Cells.Add(tr2atc21b);

        tr2atc31b.Text = totls.ToString();
        tr2atc31b.CssClass = "blackfnt";
        tr2atc31b.Wrap = false;
        tr2atc31b.Font.Bold = true;
        tr2a1b.CssClass = "bgbluegrey";
        tr2a1b.Cells.Add(tr2atc31b);

        tr2atc41b.Text = totmf.ToString();
        tr2atc41b.CssClass = "blackfnt";
        tr2atc41b.Wrap = false;
        tr2atc41b.Font.Bold = true;
        tr2a1b.CssClass = "bgbluegrey";
        tr2a1b.Cells.Add(tr2atc41b);

        tr2atc51b.Text = totthc.ToString();
        tr2atc51b.CssClass = "blackfnt";
        tr2atc51b.Wrap = false;
        tr2atc51b.Font.Bold = true;
        tr2a1b.CssClass = "bgbluegrey";
        tr2a1b.Cells.Add(tr2atc51b);

        tr2atc61b.Text = totprs.ToString();
        tr2atc61b.CssClass = "blackfnt";
        tr2atc61b.Wrap = false;
        tr2atc61b.Font.Bold = true;
        tr2a1b.CssClass = "bgbluegrey";
        tr2a1b.Cells.Add(tr2atc61b);

        tr2atc71b.Text = totdrs.ToString();
        tr2atc71b.CssClass = "blackfnt";
        tr2atc71b.Wrap = false;
        tr2atc71b.Font.Bold = true;
        tr2a1b.CssClass = "bgbluegrey";
        tr2a1b.Cells.Add(tr2atc71b);

        //tr2atc81.Text = totdkts.ToString();
        //tr2atc81.CssClass = "blackfnt";
        //tr2atc81.Wrap = false;
        //tr2a1.CssClass = "blackfnt";
        //tr2a1.Cells.Add(tr2atc81);

        //tr2atc9.Text = "Total DRS Closed";
        //tr2atc9.CssClass = "blackfnt";
        //tr2atc9.Wrap = false;
        //tr2a.CssClass = "blackfnt";
        //tr2a.Cells.Add(tr2atc9);
        tr2a1b.CssClass = "bluefnt";
        tr2a1b.Font.Bold = true;
        tr2a1b.BackColor = System.Drawing.Color.White;
        tr2a1b.HorizontalAlign = HorizontalAlign.Center;
        TBL_MonthlySales.Rows.Add(tr2a1b);

    }



    //protected void pgChange(object sender, GridViewPageEventArgs e)
    //{

    //    dgDocket.PageIndex = e.NewPageIndex;

    //    //   BindGrid();

    //}

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        //int ind = 0;
        //int a = 0;
        //try
        //{

        //    dgDocket.AllowPaging = false;
        //    dgDocket.BorderWidth = 1;


        //    Response.Clear();
        //    Response.AddHeader("Content-Disposition", "attachment;Filename=Booking_Register.xls");
        //    Response.Charset = "";
        //    Response.ContentType = "application/vnd.xls";
        //    System.IO.StringWriter tw = new System.IO.StringWriter();
        //    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        //    BindGrid();

        //    dgDocket.RenderControl(hw);


        //    Response.Write(tw.ToString());
        //    Response.End();

        //}
        //catch (Exception ex1)
        //{
        //    throw ex1;
        //    // lblloc.Text = ex1.Message;
        //}

        //dgDocket.AllowPaging = false;
        //dgDocket.BorderWidth = 1;
        //dgDocket.CssClass = "blackfnt";
        //dgDocket.Font.Size = 8;
        ////GrdLoadUnload.Font.Names = verdana;
        //dgDocket.BackColor = System.Drawing.Color.White;
        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-xls";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //dgDocket.RenderControl(htmlWrite);

        ////frm.Controls.Add(GrdLoadUnload);
        ////frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();

        TBL_MonthlySales.BorderStyle = BorderStyle.Double;
        TBL_MonthlySales.BorderWidth = 1;
        TBL_MonthlySales.CellSpacing = 2;

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Work_Done.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        //DipsplayReport();
        BindGrid();
        //GV_Booking.RenderControl(hw);
        TBL_MonthlySales.RenderControl(hw);
        //TBL_MonthlySales.BorderWidth = 1;
        Response.Write(tw.ToString());
        Response.End();


    }
}

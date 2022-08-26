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

public partial class GUI_UNI_MIS_DOC_Profit_result_veh : System.Web.UI.Page
{
    public static string DateType, Custcd, THC_call, strro_val, st_columnlist, report_Subtype, report_type, dkt_call, fromdt, todt, RO, LO, St_paylist, st_trnlist, st_delist, st_mode, st_status;

    double tot_dkts = 0, totinc = 0, totprsC = 0, totbaC = 0, totTHC1C = 0, totTHC2C = 0, totTHC3C = 0, totTHC4C = 0, totTHC5C = 0, totDRSC = 0, totalCost = 0, totprof = 0, totprof_per = 0;
    double proper = 0, RO_tot_dkts = 0, RO_totinc = 0, RO_totprsC = 0, RO_totbaC = 0, RO_totTHC1C = 0, RO_totTHC2C = 0, RO_totTHC3C = 0, RO_totTHC4C = 0, RO_totTHC5C = 0, RO_totDRSC = 0, RO_totalCost = 0, RO_totprof = 0, RO_totprof_per = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        dkt_call = Session["DocketCalledAs"].ToString();
        THC_call = Session["THCCalledAs"].ToString();
        BindGrid();
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        // St_paylist = Request.QueryString["St_paylist"].ToString();
        st_trnlist = Request.QueryString["St_paylist"].ToString();
        st_delist = Request.QueryString["st_delist"].ToString();
        report_Subtype = Request.QueryString["report_Subtype"].ToString();
        report_type = Request.QueryString["report_type"].ToString();
        Custcd = Request.QueryString["Custcd"].ToString();
        ///St_paylist = Request.QueryString["St_paylist"].ToString();
        st_columnlist = Request.QueryString["st_columnlist"].ToString();
        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
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
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");



        string sql_st = "exec webx_Profitability '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','','" + st_trnlist + "','" + st_delist + "','" + st_columnlist + "','" + report_type + "','" + report_Subtype + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //

        if (report_Subtype == "1")
        {
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            // lblflow.Text = dkt_call;
            dgDocket.Visible = true;
        }
        else
        {
            TBLDKTProf.Visible = true;

            TableRow TR1 = new TableRow();
            TableCell TR1CT1 = new TableCell();
            TableCell TR1CT2 = new TableCell();
            TableCell TR1CT3 = new TableCell();
            TableCell TR1CT4 = new TableCell();
            TableCell TR1CT5 = new TableCell();
            TableCell TR1CT6 = new TableCell();
            TableCell TR1CT7 = new TableCell();
            TableCell TR1CT8 = new TableCell();
            TableCell TR1CT9 = new TableCell();
            TableCell TR1CT10 = new TableCell();
            TableCell TR1CT11 = new TableCell();
            TableCell TR1CT12 = new TableCell();
            TableCell TR1CT13 = new TableCell();
            TableCell TR1CT14 = new TableCell();
            TableCell TR1CT15 = new TableCell();

            TR1CT1.Text = "Sr no.";
            TR1CT1.CssClass = "blackboldfnt";
            TR1CT1.Wrap = false;
            TR1.Cells.Add(TR1CT1);

            TR1CT2.Text = "Vehicle Type";
            if (report_Subtype == "3")
            {
                TR1CT2.Text = "Vendor Type";
            }
            TR1CT2.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT2);

            TR1CT8.Text = "Total Vehicle";
            TR1CT8.CssClass = "blackboldfnt";
            TR1CT8.Wrap = false;
            TR1.Cells.Add(TR1CT8);

            TR1CT3.Text = "Total " + THC_call;
            TR1CT3.CssClass = "blackboldfnt";
            TR1CT3.Wrap = false;
            TR1.Cells.Add(TR1CT3);

            TR1CT4.Text = "Total " + dkt_call;
            TR1CT4.CssClass = "blackboldfnt";
            TR1CT4.Wrap = false;
            TR1.Cells.Add(TR1CT4);

            TR1CT5.Text = "Total Freight";
            TR1CT5.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT5);



            TR1CT7.Text = "Total Cost";
            TR1CT7.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT7);


            TR1CT13.Text = "Profit";
            TR1CT13.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT13);

            TR1CT14.Text = "Profit %";
            TR1CT14.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT14);



            //TR1.BackColor = System.Drawing.Color.White;
            TR1.HorizontalAlign = HorizontalAlign.Center;
            TR1.CssClass = "bgbluegrey";
            TBLDKTProf.Rows.Add(TR1);

            SqlDataReader dr = sqlcmd12.ExecuteReader();
            int i = 0;
            i = 1;
            string CRo = "", PrevRO = "";
            while (dr.Read())
            {

                
                TableRow TR2 = new TableRow();
                TableCell TR2CT1 = new TableCell();
                TableCell TR2CT2 = new TableCell();
                TableCell TR2CT3 = new TableCell();
                TableCell TR2CT4 = new TableCell();
                TableCell TR2CT5 = new TableCell();
                TableCell TR2CT6 = new TableCell();
                TableCell TR2CT7 = new TableCell();
                TableCell TR2CT8 = new TableCell();
                TableCell TR2CT9 = new TableCell();
                TableCell TR2CT10 = new TableCell();
                TableCell TR2CT11 = new TableCell();
                TableCell TR2CT12 = new TableCell();
                TableCell TR2CT13 = new TableCell();
                TableCell TR2CT14 = new TableCell();
                TableCell TR2CT15 = new TableCell();

                TR2CT1.Text = i.ToString();
                TR2CT1.CssClass = "blackfnt";
                TR2CT1.Wrap = false;
                TR2.Cells.Add(TR2CT1);



                TR2CT2.Text = dr["VENDTY"].ToString();

                TR2CT2.CssClass = "blackfnt";
                TR2CT2.Wrap = false;
                TR2CT2.HorizontalAlign = HorizontalAlign.Left;
                TR2.Cells.Add(TR2CT2);
                string dirlldown = "";
                //if (report_Subtype == "2")
                //{
                //    dirlldown = "RO=All&Custcd=" + dr["VENDTY"].ToString() + "&LO=" + dr["loccode"].ToString() + "&DateType=" + DateType + "&fromdt=" + Request.QueryString.Get("fromdt") + "&todt=" + Request.QueryString.Get("todt") + "&St_paylist=" + st_trnlist + "&st_delist=" + st_delist + "&report_Subtype=1&report_type=2&st_columnlist=";
                //}
                //else
                //{
                dirlldown = "RO=All&LO=" + LO + "&Custcd=" + dr["VENDTY"].ToString() + "&DateType=" + DateType + "&fromdt=" + Request.QueryString.Get("fromdt") + "&todt=" + Request.QueryString.Get("todt") + "&St_paylist=" + st_trnlist + "&st_delist=" + st_delist + "&report_Subtype=1&report_type=3&st_columnlist=";
               // }
                TR2CT3.Text = "<a href='./result_VEH.aspx?" + dirlldown + "'><u>" + dr["totVeh"].ToString() + "</u></a>";
                TR2CT3.CssClass = "blackfnt";
                TR2CT3.Wrap = false;
                TR2.Cells.Add(TR2CT3);

                dirlldown = "RO=All&LO=" + LO + "&Custcd=" + dr["VENDTY"].ToString() + "&DateType=" + DateType + "&fromdt=" + Request.QueryString.Get("fromdt") + "&todt=" + Request.QueryString.Get("todt") + "&St_paylist=" + st_trnlist + "&st_delist=" + st_delist + "&report_Subtype=1&report_type=2&st_columnlist=";

                TR2CT4.Text = "<a href='./result_THC.aspx?" + dirlldown + "'><u>" + dr["totThc"].ToString() + "</u></a>";
                TR2CT4.CssClass = "blackfnt";
                TR2CT4.Wrap = false;
                TR2.Cells.Add(TR2CT4);

                TR2CT8.Text = dr["totDkts"].ToString();
                TR2CT8.CssClass = "blackfnt";
                TR2CT8.Wrap = false;
                TR2.Cells.Add(TR2CT8);


                TR2CT5.Text = dr["totfrt"].ToString();
                TR2CT5.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT5);


                TR2CT7.Text = dr["TOTCost"].ToString();
                TR2CT7.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT7);


                TR2CT13.Text = dr["profit"].ToString();
                if (dr["P_L"].ToString() == "L")
                {
                    TR2CT13.Text = "(" + dr["profit"].ToString() + ")";
                }
                TR2CT13.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT13);

                proper = Convert.ToDouble(dr["Profit_per"]);

                TR2CT14.Text = proper.ToString("F2") + " %";
                TR2CT14.CssClass = "blackfnt";
                TR2CT14.Wrap = false;
                TR2.Cells.Add(TR2CT14);



                TR2.BackColor = System.Drawing.Color.White;
                TR2.HorizontalAlign = HorizontalAlign.Center;
                TBLDKTProf.Rows.Add(TR2);




              


                tot_dkts += Convert.ToDouble(dr["totVeh"].ToString());
                totinc += Convert.ToDouble(dr["totThc"].ToString());
                totTHC1C += Convert.ToDouble(dr["totDkts"].ToString());
                totprsC += Convert.ToDouble(dr["totfrt"].ToString());
                totbaC += Convert.ToDouble(dr["TOTCost"].ToString());



                i += 1;
            }


            if (i == 1)
            {
                TableRow TR3 = new TableRow();
                TableCell TR3CT1 = new TableCell();

                TR3CT1.Text = "No Records Found";
                TR3CT1.CssClass = "blackboldfnt";
                TR3CT1.ForeColor = System.Drawing.Color.Red;
                TR3CT1.Wrap = false;
                TR3CT1.ColumnSpan = 14;
                TR3.Cells.Add(TR3CT1);



                TR3.BackColor = System.Drawing.Color.White;
                TR3.HorizontalAlign = HorizontalAlign.Center;
                TBLDKTProf.Rows.Add(TR3);
            }

            dr.Close();







            TableRow TR2c = new TableRow();
            TableCell TR2cCT1 = new TableCell();
            TableCell TR2cCT2 = new TableCell();
            TableCell TR2cCT3 = new TableCell();
            TableCell TR2cCT4 = new TableCell();
            TableCell TR2cCT5 = new TableCell();
            TableCell TR2cCT6 = new TableCell();
            TableCell TR2cCT7 = new TableCell();
            TableCell TR2cCT8 = new TableCell();
            TableCell TR2cCT9 = new TableCell();
            TableCell TR2cCT10 = new TableCell();
            TableCell TR2cCT11 = new TableCell();
            TableCell TR2cCT12 = new TableCell();
            TableCell TR2cCT13 = new TableCell();
            TableCell TR2cCT14 = new TableCell();
            TableCell TR2cCT15 = new TableCell();

            //TR2cCT1.Text = i.ToString();
            //TR2cCT1.CssClass = "blackfnt";
            //TR2cCT1.Wrap = false;
            //TR2c.Cells.Add(TR2cCT1);



            TR2cCT2.Text = " Total ";

            TR2cCT2.CssClass = "bluefnt";
            TR2cCT2.Font.Bold = true;
            TR2cCT2.Wrap = false;
            TR2cCT2.ColumnSpan = 2;
            TR2cCT2.HorizontalAlign = HorizontalAlign.Left;
            TR2c.Cells.Add(TR2cCT2);





            TR2cCT3.Text = tot_dkts.ToString();
            TR2cCT3.CssClass = "bluefnt";
            TR2cCT3.Wrap = false;
            TR2c.Cells.Add(TR2cCT3);

            TR2cCT4.Text = totinc.ToString();
            TR2cCT4.CssClass = "bluefnt";
            TR2cCT4.Wrap = false;
            TR2c.Cells.Add(TR2cCT4);

            TR2cCT8.Text = totTHC1C.ToString();
            TR2cCT8.CssClass = "bluefnt";
            TR2cCT8.Wrap = false;
            TR2c.Cells.Add(TR2cCT8);

            TR2cCT5.Text = totprsC.ToString("F2");
            TR2cCT5.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT5);

            TR2cCT6.Text = totbaC.ToString("F2");
            TR2cCT6.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT6);


            totprof = totprsC - totbaC;

            TR2cCT13.Text = totprof.ToString("F2");
            if (totprof < 0)
            {
                totprof = totbaC - totprsC;
                TR2cCT13.Text = "(" + totprof.ToString("F2") + ")";
            }
            TR2cCT13.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT13);

            totprof_per = (totprsC - totbaC) * 100 / totprsC;

            //TR2cCT14.Text =Convert.ToString(totalCost*100/totinc).ToString()+ " %";
            TR2cCT14.Text = totprof_per.ToString("F2") + " %";
            TR2cCT14.CssClass = "bluefnt";
            TR2cCT14.Wrap = false;
            TR2c.Cells.Add(TR2cCT14);


            TR2c.Font.Bold = true;
            TR2c.BackColor = System.Drawing.Color.White;
            TR2c.HorizontalAlign = HorizontalAlign.Center;
            TBLDKTProf.Rows.Add(TR2c);

        }




        conn.Close();
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                //Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = dkt_call + " No.";
                //lblColDockdt.Text = dkt_call + " Date";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Cells[29].Text = e.Row.Cells[29].Text.ToString("F2",0);
                Label p_l = (Label)e.Row.FindControl("p_l");
                Label Profit_per = (Label)e.Row.FindControl("Profit_per");

                double Prof_per = Convert.ToDouble(Profit_per.Text.ToString());

                e.Row.Cells[8].Text = Prof_per.ToString("F2") + " %";
                if (p_l.Text.ToString() == "L")
                {
                    e.Row.Cells[7].Text = "(" + e.Row.Cells[7].Text.ToString() + ")";
                }
                else
                {
                    e.Row.Cells[7].Text = e.Row.Cells[7].Text.ToString();
                }
            }

        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        dgDocket.PageIndex = e.NewPageIndex;


        BindGrid();

    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {

        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;


        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Docket_Profitability.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        BindGrid();
        if (report_Subtype == "1")
        {
            frm.Controls.Add(dgDocket);
        }
        else
        {
            frm.Controls.Add(TBLDKTProf);
        }


        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();





    }
}

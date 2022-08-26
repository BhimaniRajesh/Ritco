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


public partial class GUI_UNI_MIS_DOC_Profit_result_docket : System.Web.UI.Page
{
    public static string DateType,strro_val,Custcd, st_columnlist,report_Subtype, report_type, dkt_call, fromdt, todt, RO, LO, St_paylist, st_trnlist, st_delist, st_mode, st_status;

    double tot_dkts = 0, totinc = 0, totprsC = 0, totbaC = 0, totTHC1C = 0, totTHC2C = 0, totTHC3C = 0, totTHC4C = 0, totTHC5C = 0, totDRSC = 0, totalCost = 0, totprof = 0, totprof_per = 0;
    double proper=0,RO_tot_dkts = 0, RO_totinc = 0, RO_totprsC = 0, RO_totbaC = 0, RO_totTHC1C = 0, RO_totTHC2C = 0, RO_totTHC3C = 0, RO_totTHC4C = 0, RO_totTHC5C = 0, RO_totDRSC = 0, RO_totalCost = 0, RO_totprof = 0, RO_totprof_per=0;

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
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
        st_trnlist = Request.QueryString["st_trnlist"].ToString();
        st_delist = Request.QueryString["st_delist"].ToString();
        report_Subtype = Request.QueryString["report_Subtype"].ToString();
        report_type = Request.QueryString["report_type"].ToString();
        Custcd = Request.QueryString["Custcd"].ToString();
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



        string sql_st = "exec webx_Profitability '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + Custcd + "','" + st_trnlist + "','" + st_delist + "','" + st_columnlist + "','" + report_type + "','" + report_Subtype + "'";
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

            TR1CT2.Text = "Location";
            TR1CT2.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT2);

            TR1CT3.Text = "Total Docket";
            TR1CT3.CssClass = "blackboldfnt";
            TR1CT3.Wrap = false;
            TR1.Cells.Add(TR1CT3);

            TR1CT4.Text = "Total Income";
            TR1CT4.CssClass = "blackboldfnt";
            TR1CT4.Wrap = false;
            TR1.Cells.Add(TR1CT4);

            TR1CT5.Text = "Total PRS Cost";
            TR1CT5.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT5);

            TR1CT6.Text = "Total BA Cost";
            TR1CT6.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT6);

            TR1CT7.Text = "Total THC1 Cost";
            TR1CT7.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT7);

            TR1CT8.Text = "Total THC2 Cost";
            TR1CT8.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT8);

            TR1CT9.Text = "Total THC3 Cost";
            TR1CT9.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT9);

            TR1CT10.Text = "Total THC4 Cost";
            TR1CT10.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT10);

            TR1CT11.Text = "Total THC5 Cost";
            TR1CT11.CssClass = "blackboldfnt";
            TR1.Cells.Add(TR1CT11);

            TR1CT12.Text = "Total DRS Cost";
            TR1CT12.CssClass = "blackboldfnt";
            TR1CT12.Wrap = false;
            TR1.Cells.Add(TR1CT12);

            TR1CT15.Text = "Total  Cost";
            TR1CT15.CssClass = "blackboldfnt";
            TR1CT15.Wrap = false;
            TR1.Cells.Add(TR1CT15);

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

                if (report_Subtype == "2")
                {
                      CRo = dr["report_loc"].ToString();
                      if (CRo != PrevRO && PrevRO != "")
                      {
                          TableRow TR2a = new TableRow();
                          TableCell TR2aCT1 = new TableCell();
                          TableCell TR2aCT2 = new TableCell();
                          TableCell TR2aCT3 = new TableCell();
                          TableCell TR2aCT4 = new TableCell();
                          TableCell TR2aCT5 = new TableCell();
                          TableCell TR2aCT6 = new TableCell();
                          TableCell TR2aCT7 = new TableCell();
                          TableCell TR2aCT8 = new TableCell();
                          TableCell TR2aCT9 = new TableCell();
                          TableCell TR2aCT10 = new TableCell();
                          TableCell TR2aCT11 = new TableCell();
                          TableCell TR2aCT12 = new TableCell();
                          TableCell TR2aCT13 = new TableCell();
                          TableCell TR2aCT14 = new TableCell();
                          TableCell TR2aCT15 = new TableCell();

                          //TR2aCT1.Text = i.ToString();
                          //TR2aCT1.CssClass = "blackfnt";
                          //TR2aCT1.Wrap = false;
                          //TR2a.Cells.Add(TR2aCT1);



                          TR2aCT2.Text = PrevRO + " : " + strro_val;

                          TR2aCT2.CssClass = "bluefnt";
                          TR2aCT2.Font.Bold = true;
                          TR2aCT2.Wrap = false;
                          TR2aCT2.ColumnSpan = 2;
                          TR2aCT2.HorizontalAlign = HorizontalAlign.Left;
                          TR2a.Cells.Add(TR2aCT2);



                          //string dirlldown = "RO=" + RO + "&LO=" + LO + "&DateType=" + DateType + "&fromdt=" + Request.QueryString.Get("fromdt") + "&todt=" + Request.QueryString.Get("todt") + "&st_trnlist=" + st_trnlist + "&st_delist=" + st_delist + "&report_Subtype=1&report_type=1&st_delist=1";

                          TR2aCT3.Text = RO_tot_dkts.ToString();
                          TR2aCT3.CssClass = "bluefnt";
                          TR2aCT3.Wrap = false;
                          TR2a.Cells.Add(TR2aCT3);

                          TR2aCT4.Text = RO_totinc.ToString("F2");
                          TR2aCT4.CssClass = "bluefnt";
                          TR2aCT4.Wrap = false;
                          TR2a.Cells.Add(TR2aCT4);

                          TR2aCT5.Text = RO_totprsC.ToString("F2");
                          TR2aCT5.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT5);

                          TR2aCT6.Text = RO_totbaC.ToString("F2");
                          TR2aCT6.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT6);

                          TR2aCT7.Text = RO_totTHC1C.ToString("F2");
                          TR2aCT7.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT7);

                          TR2aCT8.Text = RO_totTHC2C.ToString("F2");
                          TR2aCT8.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT8);

                          TR2aCT9.Text = RO_totTHC3C.ToString("F2");
                          TR2aCT9.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT9);

                          TR2aCT10.Text = RO_totTHC4C.ToString("F2");
                          TR2aCT10.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT10);

                          TR2aCT11.Text = RO_totTHC5C.ToString("F2");
                          TR2aCT11.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT11);

                          TR2aCT12.Text = RO_totDRSC.ToString("F2");
                          TR2aCT12.CssClass = "bluefnt";
                          TR2aCT12.Wrap = false;
                          TR2a.Cells.Add(TR2aCT12);

                          TR2aCT15.Text = RO_totalCost.ToString("F2");
                          TR2aCT15.CssClass = "bluefnt";
                          TR2aCT15.Wrap = false;
                          TR2a.Cells.Add(TR2aCT15);

                          RO_totprof = RO_totalCost - RO_totinc;

                          TR2aCT13.Text = RO_totprof.ToString("F2");
                          if (RO_totprof < 0)
                          {
                              RO_totprof = RO_totinc - RO_totalCost;
                              TR2aCT13.Text = "(" + RO_totprof.ToString("F2") + ")";
                          }
                          TR2aCT13.CssClass = "bluefnt";
                          TR2a.Cells.Add(TR2aCT13);

                          RO_totprof_per = (RO_totalCost - RO_totinc) * 100 / RO_totalCost;

                          //TR2aCT14.Text =Convert.ToString(RO_totalCost*100/RO_totinc).ToString()+ " %";
                          TR2aCT14.Text = RO_totprof_per.ToString("F2") + " %";
                          TR2aCT14.CssClass = "bluefnt";
                          TR2aCT14.Wrap = false;
                          TR2a.Cells.Add(TR2aCT14);



                          TR2a.BackColor = System.Drawing.Color.White;
                          TR2a.HorizontalAlign = HorizontalAlign.Center;
                          TBLDKTProf.Rows.Add(TR2a);
                          RO_totprof = 0;
                          RO_tot_dkts = 0;
                          RO_totinc = 0;
                          RO_totprsC = 0;
                          RO_totbaC = 0;
                          RO_totTHC1C = 0;
                          RO_totTHC2C = 0;
                          RO_totTHC3C = 0;
                          RO_totTHC4C = 0;
                          RO_totTHC5C = 0;
                          RO_totDRSC = 0;
                          RO_totalCost = 0;

                      }
                }





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

                string lcd = "";
                if (report_Subtype == "3")
                {
                    TR2CT2.Text = dr["custcd"].ToString() + " : " + dr["custnm"].ToString();
                    lcd = dr["custcd"].ToString();
                }
                else
                {
                    TR2CT2.Text = dr["loccode"].ToString() + " : " + dr["locname"].ToString();
                    lcd = dr["loccode"].ToString();
                }
                TR2CT2.CssClass = "blackfnt";
                TR2CT2.Wrap = false;
                TR2CT2.HorizontalAlign = HorizontalAlign.Left;
                TR2.Cells.Add(TR2CT2);
                string dirlldown = "";
                if (report_Subtype == "2")
                {
                    dirlldown = "RO=All&Custcd=" + Custcd + "&LO=" + lcd + "&DateType=" + DateType + "&fromdt=" + Request.QueryString.Get("fromdt") + "&todt=" + Request.QueryString.Get("todt") + "&st_trnlist=" + st_trnlist + "&st_delist=" + st_delist + "&report_Subtype=1&report_type=1&st_columnlist=";
                }
                else
                {
                    dirlldown = "RO=All&LO=" + LO + "&Custcd=" + lcd + "&DateType=" + DateType + "&fromdt=" + Request.QueryString.Get("fromdt") + "&todt=" + Request.QueryString.Get("todt") + "&st_trnlist=" + st_trnlist + "&st_delist=" + st_delist + "&report_Subtype=1&report_type=1&st_columnlist=";
                }

                 
                  
                TR2CT3.Text ="<a href='./result_docket.aspx?" + dirlldown + "'><u>" +  dr["total_dockets"].ToString()+ "</u></a>";
                //if (report_Subtype == "3")
                //{
                //    TR2CT3.Text = dr["total_dockets"].ToString();
                //}
                
                TR2CT3.CssClass = "blackfnt";
                TR2CT3.Wrap = false;
                TR2.Cells.Add(TR2CT3);

                TR2CT4.Text = dr["total_income"].ToString();
                TR2CT4.CssClass = "blackfnt";
                TR2CT4.Wrap = false;
                TR2.Cells.Add(TR2CT4);

                TR2CT5.Text = dr["total_PRS_cost"].ToString();
                TR2CT5.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT5);

                TR2CT6.Text = dr["total_BS_cost"].ToString();
                TR2CT6.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT6);

                TR2CT7.Text = dr["total_THC1_cost"].ToString();
                TR2CT7.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT7);

                TR2CT8.Text = dr["total_THC2_cost"].ToString();
                TR2CT8.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT8);

                TR2CT9.Text = dr["total_THC3_cost"].ToString();
                TR2CT9.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT9);

                TR2CT10.Text = dr["total_THC4_cost"].ToString();
                TR2CT10.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT10);

                TR2CT11.Text = dr["total_THC5_cost"].ToString();
                TR2CT11.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT11);

                TR2CT12.Text = dr["total_DRS_cost"].ToString();
                TR2CT12.CssClass = "blackfnt";
                TR2CT12.Wrap = false;
                TR2.Cells.Add(TR2CT12);

                TR2CT15.Text = dr["tottal_cost"].ToString();
                TR2CT15.CssClass = "blackfnt";
                TR2CT15.Wrap = false;
                TR2.Cells.Add(TR2CT15);


                TR2CT13.Text = dr["profit"].ToString();
                if (dr["P_L"].ToString() == "L")
                {
                    TR2CT13.Text = "(" + dr["profit"].ToString()+")";
                }
                TR2CT13.CssClass = "blackfnt";
                TR2.Cells.Add(TR2CT13);

                proper = Convert.ToDouble(dr["Profit_per"]);

                TR2CT14.Text = proper.ToString("F2") +" %";
                TR2CT14.CssClass = "blackfnt";
                TR2CT14.Wrap = false;
                TR2.Cells.Add(TR2CT14);



                TR2.BackColor = System.Drawing.Color.White;
                TR2.HorizontalAlign = HorizontalAlign.Center;
                TBLDKTProf.Rows.Add(TR2);



                if (report_Subtype == "2")
                {
                    PrevRO = dr["report_loc"].ToString();
                    strro_val = dr["report_locname"].ToString();
                }

                tot_dkts +=Convert.ToDouble(dr["total_dockets"].ToString());
                totinc += Convert.ToDouble(dr["total_income"].ToString());
                totprsC += Convert.ToDouble(dr["total_PRS_cost"].ToString());
                totbaC += Convert.ToDouble(dr["total_BS_cost"].ToString());
                totTHC1C += Convert.ToDouble(dr["total_THC1_cost"].ToString());
                totTHC2C += Convert.ToDouble(dr["total_THC2_cost"].ToString());
                totTHC3C += Convert.ToDouble(dr["total_THC3_cost"].ToString());
                totTHC4C += Convert.ToDouble(dr["total_THC4_cost"].ToString());
                totTHC5C += Convert.ToDouble(dr["total_THC5_cost"].ToString());
                totDRSC +=Convert.ToDouble(dr["total_DRS_cost"].ToString()); 
                totalCost += Convert.ToDouble(dr["tottal_cost"].ToString());

                

                RO_tot_dkts += Convert.ToDouble(dr["total_dockets"].ToString());
                RO_totinc += Convert.ToDouble(dr["total_income"].ToString());
                RO_totprsC += Convert.ToDouble(dr["total_PRS_cost"].ToString());
                RO_totbaC += Convert.ToDouble(dr["total_BS_cost"].ToString());
                RO_totTHC1C += Convert.ToDouble(dr["total_THC1_cost"].ToString());
                RO_totTHC2C += Convert.ToDouble(dr["total_THC2_cost"].ToString());
                RO_totTHC3C += Convert.ToDouble(dr["total_THC3_cost"].ToString());
                RO_totTHC4C += Convert.ToDouble(dr["total_THC4_cost"].ToString());
                RO_totTHC5C += Convert.ToDouble(dr["total_THC5_cost"].ToString());
                RO_totDRSC += Convert.ToDouble(dr["total_DRS_cost"].ToString());
                RO_totalCost += Convert.ToDouble(dr["tottal_cost"].ToString());



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


            if (report_Subtype == "2")
            {
               
                    TableRow TR2b = new TableRow();
                    TableCell TR2bCT1 = new TableCell();
                    TableCell TR2bCT2 = new TableCell();
                    TableCell TR2bCT3 = new TableCell();
                    TableCell TR2bCT4 = new TableCell();
                    TableCell TR2bCT5 = new TableCell();
                    TableCell TR2bCT6 = new TableCell();
                    TableCell TR2bCT7 = new TableCell();
                    TableCell TR2bCT8 = new TableCell();
                    TableCell TR2bCT9 = new TableCell();
                    TableCell TR2bCT10 = new TableCell();
                    TableCell TR2bCT11 = new TableCell();
                    TableCell TR2bCT12 = new TableCell();
                    TableCell TR2bCT13 = new TableCell();
                    TableCell TR2bCT14 = new TableCell();
                    TableCell TR2bCT15 = new TableCell();

                    //TR2bCT1.Text = i.ToString();
                    //TR2bCT1.CssClass = "blackfnt";
                    //TR2bCT1.Wrap = false;
                    //TR2b.Cells.Add(TR2bCT1);



                    TR2bCT2.Text = PrevRO + " : " + strro_val;

                    TR2bCT2.CssClass = "bluefnt";
                    TR2bCT2.Font.Bold = true;
                    TR2bCT2.Wrap = false;
                    TR2bCT2.ColumnSpan = 2;
                    TR2bCT2.HorizontalAlign = HorizontalAlign.Left;
                    TR2b.Cells.Add(TR2bCT2);





                    TR2bCT3.Text = RO_tot_dkts.ToString();
                    TR2bCT3.CssClass = "bluefnt";
                    TR2bCT3.Wrap = false;
                    TR2b.Cells.Add(TR2bCT3);

                    TR2bCT4.Text = RO_totinc.ToString("F2");
                    TR2bCT4.CssClass = "bluefnt";
                    TR2bCT4.Wrap = false;
                    TR2b.Cells.Add(TR2bCT4);

                    TR2bCT5.Text = RO_totprsC.ToString("F2");
                    TR2bCT5.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT5);

                    TR2bCT6.Text = RO_totbaC.ToString("F2");
                    TR2bCT6.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT6);

                    TR2bCT7.Text = RO_totTHC1C.ToString("F2");
                    TR2bCT7.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT7);

                    TR2bCT8.Text = RO_totTHC2C.ToString("F2");
                    TR2bCT8.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT8);

                    TR2bCT9.Text = RO_totTHC3C.ToString("F2");
                    TR2bCT9.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT9);

                    TR2bCT10.Text = RO_totTHC4C.ToString("F2");
                    TR2bCT10.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT10);

                    TR2bCT11.Text = RO_totTHC5C.ToString("F2");
                    TR2bCT11.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT11);

                    TR2bCT12.Text = RO_totDRSC.ToString("F2");
                    TR2bCT12.CssClass = "bluefnt";
                    TR2bCT12.Wrap = false;
                    TR2b.Cells.Add(TR2bCT12);

                    TR2bCT15.Text = RO_totalCost.ToString("F2");
                    TR2bCT15.CssClass = "bluefnt";
                    TR2bCT15.Wrap = false;
                    TR2b.Cells.Add(TR2bCT15);

                    RO_totprof = RO_totalCost - RO_totinc;

                    TR2bCT13.Text = RO_totprof.ToString("F2");
                    if (RO_totprof < 0)
                    {
                        RO_totprof = RO_totinc - RO_totalCost;
                        TR2bCT13.Text = "(" + RO_totprof.ToString("F2") + ")";
                    }
                    TR2bCT13.CssClass = "bluefnt";
                    TR2b.Cells.Add(TR2bCT13);

                    RO_totprof_per = (RO_totalCost - RO_totinc) * 100 / RO_totalCost;

                    //TR2bCT14.Text =Convert.ToString(RO_totalCost*100/RO_totinc).ToString()+ " %";
                    TR2bCT14.Text = RO_totprof_per.ToString("F2") + " %";
                    TR2bCT14.CssClass = "bluefnt";
                    TR2bCT14.Wrap = false;
                    TR2b.Cells.Add(TR2bCT14);



                    TR2b.BackColor = System.Drawing.Color.White;
                    TR2b.HorizontalAlign = HorizontalAlign.Center;
                    TBLDKTProf.Rows.Add(TR2b);
                   
              
            }

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



            TR2cCT2.Text =  " Total " ;

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

            TR2cCT4.Text = totinc.ToString("F2");
            TR2cCT4.CssClass = "bluefnt";
            TR2cCT4.Wrap = false;
            TR2c.Cells.Add(TR2cCT4);

            TR2cCT5.Text = totprsC.ToString("F2");
            TR2cCT5.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT5);

            TR2cCT6.Text = totbaC.ToString("F2");
            TR2cCT6.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT6);

            TR2cCT7.Text = totTHC1C.ToString("F2");
            TR2cCT7.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT7);

            TR2cCT8.Text = totTHC2C.ToString("F2");
            TR2cCT8.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT8);

            TR2cCT9.Text = totTHC3C.ToString("F2");
            TR2cCT9.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT9);

            TR2cCT10.Text = totTHC4C.ToString("F2");
            TR2cCT10.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT10);

            TR2cCT11.Text = totTHC5C.ToString("F2");
            TR2cCT11.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT11);

            TR2cCT12.Text = totDRSC.ToString("F2");
            TR2cCT12.CssClass = "bluefnt";
            TR2cCT12.Wrap = false;
            TR2c.Cells.Add(TR2cCT12);

            TR2cCT15.Text = totalCost.ToString("F2");
            TR2cCT15.CssClass = "bluefnt";
            TR2cCT15.Wrap = false;
            TR2c.Cells.Add(TR2cCT15);

            totprof = totalCost - totinc;

            TR2cCT13.Text = totprof.ToString("F2");
            if (totprof < 0)
            {
                totprof = totinc - totalCost;
                TR2cCT13.Text = "(" + totprof.ToString("F2") + ")";
            }
            TR2cCT13.CssClass = "bluefnt";
            TR2c.Cells.Add(TR2cCT13);

            totprof_per = (totalCost - totalCost) * 100 / totalCost;

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
                e.Row.Cells[29].Text = Profit_per.Text.ToString()+" %";
                if (p_l.Text.ToString() == "L")
                {
                    e.Row.Cells[28].Text = "(" + e.Row.Cells[28].Text.ToString() + ")";
                }
                else
                {
                    e.Row.Cells[28].Text =e.Row.Cells[28].Text.ToString() ;
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

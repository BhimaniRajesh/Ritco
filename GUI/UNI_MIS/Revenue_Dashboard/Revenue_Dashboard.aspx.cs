using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_UNI_MIS_Login_View_Login_view : System.Web.UI.Page
{

    public byte byteRadButtonSelection;
    public static string strtrtype;

    protected void Page_Load(object sender, EventArgs e)
    
    {

        

        if (!IsPostBack)
        {
            lblcrmon.Text += " : " + curmonnm;
            lblprmon.Text += " : " + prmonnm;
            lblcrqr.Text += " (" + cr1 + " - " + cr3 + ")";
            lblprqr.Text += " (" + pr1 + " - " + pr3 + ")";
            lblcrmon.Font.Bold = true;
            lblprmon.Font.Bold = true;
            lblcrqr.Font.Bold = true;
            lblprqr.Font.Bold = true;
            //Label1.Visible = false;
           

        }
            

    
       



    }

    public static string curmonnm = DateTime.Now.ToString("MMMM");
    public static string prmonnm = DateTime.Now.AddMonths(-1).ToString("MMMM");

    //public static string t = ddd.Minute.ToString();

    DateTime ddd2 = DateTime.Now.AddMonths(-1);
    DateTime ddd3 = DateTime.Now.AddMonths(-2);
    

   #region  Sandy Datetime



    public enum Quarter
    {
        First = 1,
        Second = 2,
        Third = 3,
        Fourth = 4
    }

    public enum Month
    {
        January = 1,
        February = 2,
        March = 3,
        April = 4,
        May = 5,
        June = 6,
        July = 7,
        August = 8,
        September = 9,
        October = 10,
        November = 11,
        December = 12
    }

   
    public static DateTime GetEndOfQuarter(int Year, Quarter Qtr)
    {
        if (Qtr == Quarter.First)    // 1st Quarter = January 1 to March 31
            return new DateTime(Year, 3,
                   DateTime.DaysInMonth(Year, 3), 23, 59, 59, 999);
        else if (Qtr == Quarter.Second) // 2nd Quarter = April 1 to June 30
            return new DateTime(Year, 6,
                   DateTime.DaysInMonth(Year, 6), 23, 59, 59, 999);
        else if (Qtr == Quarter.Third) // 3rd Quarter = July 1 to September 30
            return new DateTime(Year, 9,
                   DateTime.DaysInMonth(Year, 9), 23, 59, 59, 999);
        else // 4th Quarter = October 1 to December 31
            return new DateTime(Year, 12,
                   DateTime.DaysInMonth(Year, 12), 23, 59, 59, 999);
    }
    public static Quarter GetQuarter(Month Month)
    {
        if (Month <= Month.March)
            // 1st Quarter = January 1 to March 31
            return Quarter.First;
        else if ((Month >= Month.April) && (Month <= Month.June))
            // 2nd Quarter = April 1 to June 30
            return Quarter.Second;
        else if ((Month >= Month.July) && (Month <= Month.September))
            // 3rd Quarter = July 1 to September 30
            return Quarter.Third;
        else // 4th Quarter = October 1 to December 31
            return Quarter.Fourth;
    }

    public static DateTime GetStartOfQuarter(int Year, Quarter Qtr)
    {
        if (Qtr == Quarter.First)    // 1st Quarter = January 1 to March 31
            return new DateTime(Year, 1, 1, 0, 0, 0, 0);
        else if (Qtr == Quarter.Second) // 2nd Quarter = April 1 to June 30
            return new DateTime(Year, 4, 1, 0, 0, 0, 0);
        else if (Qtr == Quarter.Third) // 3rd Quarter = July 1 to September 30
            return new DateTime(Year, 7, 1, 0, 0, 0, 0);
        else // 4th Quarter = October 1 to December 31
            return new DateTime(Year, 10, 1, 0, 0, 0, 0);
    }
    public static DateTime GetStartOfCurrentQuarter()
    {
        return GetStartOfQuarter(DateTime.Now.Year,
               GetQuarter((Month)DateTime.Now.Month));
    }

    public static DateTime GetEndOfCurrentQuarter()
    {
        return GetEndOfQuarter(DateTime.Now.Year,
               GetQuarter((Month)DateTime.Now.Month));
    }


    public static DateTime curr_qq = GetStartOfCurrentQuarter();
    public static string cr1 = curr_qq.ToString("MMMM");
    public static string cr2 = curr_qq.AddMonths(1).ToString("MMMM");
    public static string cr3 = curr_qq.AddMonths(2).ToString("MMMM");

      


    public static string pr1 = curr_qq.AddMonths(-3).ToString("MMMM");
    public static string pr2 = curr_qq.AddMonths(-2).ToString("MMMM");
    public static string pr3 = curr_qq.AddMonths(-1).ToString("MMMM");






    #endregion


    #region current Month
    public void curr_month()
    {
       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string sql = "";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_Revenue_Dashboard";


        strtrtype = ddltr_mode.SelectedValue.ToString();


        sqlCommand.Parameters.AddWithValue("@Report_type", "Cr_month");
        sqlCommand.Parameters.AddWithValue("@Trnmode", strtrtype);

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
       

        DataSet ds = new DataSet();
        da.Fill(ds, "tab");
        if (ds.Tables[0].Rows.Count != 0)
        {

            ds.Tables[0].Columns.Add("tot");

            ds.Tables[0].Columns.Add("tot2");
            ds.Tables[0].Columns.Add("y1");
            ds.Tables[0].Columns.Add("y2");
            ds.Tables[0].Columns.Add("y3");
            ds.Tables[0].Columns.Add("y4");

            double gtot = 0, j = 0, tot1 = 0, tot2 = 0, tot3 = 0, tot4 = 0;
            double tot5 = 0, tot6 = 0, tot7 = 0, tot8 = 0, gtot2 = 0;
            int k;
            k = ds.Tables[0].Rows.Count;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {

                dr["tot"] = Convert.ToInt16(dr["Cr_month1_docket"]) + Convert.ToInt16(dr["Cr_month_2_docket"]) + Convert.ToInt16(dr["Cr_month_3_docket"]) + Convert.ToInt16(dr["Cr_month_4_docket"]);

                if (dr["Cr_month1_docket"].ToString() == "0" || dr["Cr_month1_docket"] is DBNull || dr["Cr_month_1_dkttot"].ToString() == "0" || dr["Cr_month_1_dkttot"] is DBNull || dr["Cr_month_1_chrgwt"].ToString() == "0" || dr["Cr_month_1_chrgwt"] is DBNull)
                {
                    dr["Cr_month_1_chrgwt"] = 1;
                    dr["Cr_month_1_dkttot"] = 0;

                    dr["y1"] = Convert.ToDouble(dr["Cr_month_1_dkttot"]) / Convert.ToDouble(dr["Cr_month_1_chrgwt"]);
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");
                }
                else
                {
                    dr["y1"] = Convert.ToDouble(dr["Cr_month_1_dkttot"]) / Convert.ToDouble(dr["Cr_month_1_chrgwt"]);
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");
                }

                if (dr["Cr_month_2_docket"].ToString() == "0" || dr["Cr_month_2_docket"] is DBNull || dr["Cr_month_2_dkttot"].ToString() == "0" || dr["Cr_month_2_dkttot"] is DBNull || dr["Cr_month_2_chrgwt"].ToString() == "0" || dr["Cr_month_2_chrgwt"] is DBNull)
                {
                    dr["Cr_month_2_chrgwt"] = 1;
                    dr["Cr_month_2_dkttot"] = 0;

                    dr["y2"] = Convert.ToDouble(dr["Cr_month_2_dkttot"]) / Convert.ToDouble(dr["Cr_month_2_chrgwt"]);
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");
                }
                else
                {

                    dr["y2"] = Convert.ToDouble(dr["Cr_month_2_dkttot"]) / Convert.ToDouble(dr["Cr_month_2_chrgwt"]);
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");
                }
                if (dr["Cr_month_3_docket"].ToString() == "0" || dr["Cr_month_3_docket"] is DBNull || dr["Cr_month_3_dkttot"].ToString() == "0" || dr["Cr_month_3_dkttot"] is DBNull || dr["Cr_month_3_chrgwt"].ToString() == "0" || dr["Cr_month_3_chrgwt"] is DBNull)
                {
                    dr["Cr_month_3_chrgwt"] = 1;
                    dr["Cr_month_3_dkttot"] = 0;

                    dr["y3"] = Convert.ToDouble(dr["Cr_month_3_dkttot"]) / Convert.ToDouble(dr["Cr_month_3_chrgwt"]);
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");
                }
                else
                {

                    dr["y3"] = Convert.ToDouble(dr["Cr_month_3_dkttot"]) / Convert.ToDouble(dr["Cr_month_3_chrgwt"]);
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");
                }
                if (dr["Cr_month_4_docket"].ToString() == "0" || dr["Cr_month_4_docket"] is DBNull || dr["Cr_month_4_dkttot"].ToString() == "0" || dr["Cr_month_4_dkttot"] is DBNull || dr["Cr_month_4_chrgwt"].ToString() == "0" || dr["Cr_month_4_chrgwt"] is DBNull)
                {
                    dr["Cr_month_4_chrgwt"] = 1;
                    dr["Cr_month_4_dkttot"] = 0;

                    dr["y4"] = Convert.ToDouble(dr["Cr_month_4_dkttot"]) / Convert.ToDouble(dr["Cr_month_4_chrgwt"]);
                    dr["y4"] = Convert.ToDouble(dr["y4"]).ToString("0.00");
                }
                else
                {

                    dr["y4"] = Convert.ToDouble(dr["Cr_month_4_dkttot"]) / Convert.ToDouble(dr["Cr_month_4_chrgwt"]);
                    dr["y4"] = Convert.ToDouble(dr["y4"]).ToString("0.00");
                }


                if (dr["y1"].ToString() == "NaN")
                {
                    dr["y1"] = 0.00;
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");

                }

                if (dr["y2"].ToString() == "NaN")
                {
                    dr["y2"] = 0.00;
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");

                }

                if (dr["y3"].ToString() == "NaN")
                {
                    dr["y3"] = 0.00;
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");

                }

                if (dr["y4"].ToString() == "NaN")
                {
                    dr["y4"] = 0.00;
                    dr["y4"] = Convert.ToDouble(dr["y4"]).ToString("0.00");

                }



                dr["tot2"] = (Convert.ToDouble(dr["y1"]) + Convert.ToDouble(dr["y2"]) + Convert.ToDouble(dr["y3"]) + Convert.ToDouble(dr["y4"])) / 4;
                dr["tot2"] = Convert.ToDouble(dr["tot2"]).ToString("0.00");
                gtot += Convert.ToInt16(dr["tot"]);
                gtot2 += Convert.ToDouble(dr["tot2"]);

                tot1 += Convert.ToInt16(dr["Cr_month1_docket"]);
                tot2 += Convert.ToInt16(dr["Cr_month_2_docket"]);
                tot3 += Convert.ToInt16(dr["Cr_month_3_docket"]);
                tot4 += Convert.ToInt16(dr["Cr_month_4_docket"]);

                tot5 += Convert.ToDouble(dr["y1"]);
                tot6 += Convert.ToDouble(dr["y2"]);
                tot7 += Convert.ToDouble(dr["y3"]);
                tot8 += Convert.ToDouble(dr["y4"]);




                j += 1;

            }


            if (ds.Tables[0].Rows.Count != 1)
            {

                DataRow dr2;
                dr2 = ds.Tables[0].NewRow();

                dr2["report_loc"] = "Total";
                dr2["Cr_month1_docket"] = tot1;
                dr2["Cr_month_2_docket"] = tot2;
                dr2["Cr_month_3_docket"] = tot3;
                dr2["Cr_month_4_docket"] = tot4;
                dr2["y1"] = tot5 / (k - 1);
                dr2["y1"] = Convert.ToDouble(dr2["y1"]).ToString("0.00");
                dr2["y2"] = tot6 / (k - 1);
                dr2["y2"] = Convert.ToDouble(dr2["y2"]).ToString("0.00");
                dr2["y3"] = tot7 / (k - 1);
                dr2["y3"] = Convert.ToDouble(dr2["y3"]).ToString("0.00");
                dr2["y4"] = tot8 / (k - 1);
                dr2["y4"] = Convert.ToDouble(dr2["y4"]).ToString("0.00");

                dr2["tot"] = gtot;


                double ytot = gtot2 / (k - 1);
                dr2["tot2"] = ytot;
                dr2["tot2"] = Convert.ToDouble(dr2["tot2"]).ToString("0.00");





                ds.Tables[0].Rows.Add(dr2);


            }

        }
            GV_CURR.DataSource = ds;



            GV_CURR.DataBind();
       
        //k = GV_CURR.Rows.Count;
        //GV_CURR.Rows[5].Font.Bold = true;
        //GV_CURR.Rows[5].
            //CssClass = "bgbluegrey";
            //System.Drawing.Color.Blue;
        //GV_CURR.DataBind();
    }

        #endregion

    #region Prev Month


    public void prv_month()
    {
        //SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        //SqlConnection conn = new SqlConnection("Data Source=ECFY15;Initial Catalog=Sandy_WebxNet;Persist Security Info=True;User ID=sa;Password=sa");

        string sql = "";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_Revenue_Dashboard";


        strtrtype = ddltr_mode.SelectedValue.ToString();


        sqlCommand.Parameters.AddWithValue("@Report_type", "Pr_month");
        sqlCommand.Parameters.AddWithValue("@Trnmode", strtrtype);


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab");


        if (ds.Tables[0].Rows.Count != 0)
        {
            ds.Tables[0].Columns.Add("tot");
            ds.Tables[0].Columns.Add("tot2");
            ds.Tables[0].Columns.Add("y1");
            ds.Tables[0].Columns.Add("y2");
            ds.Tables[0].Columns.Add("y3");
            ds.Tables[0].Columns.Add("y4");

            double gtot = 0, j = 0, tot1 = 0, tot2 = 0, tot3 = 0, tot4 = 0;
            double tot5 = 0, tot6 = 0, tot7 = 0, tot8 = 0, gtot2 = 0;
            int k;
            k = ds.Tables[0].Rows.Count;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {

                dr["tot"] = Convert.ToInt16(dr["pr_month1_docket"]) + Convert.ToInt16(dr["pr_month_2_docket"]) + Convert.ToInt16(dr["pr_month_3_docket"]) + Convert.ToInt16(dr["pr_month_4_docket"]);

                if (dr["Pr_month1_docket"].ToString() == "0" || dr["Pr_month1_docket"] is DBNull || dr["Pr_month_1_dkttot"].ToString() == "0" || dr["Pr_month_1_dkttot"] is DBNull || dr["Pr_month_1_chrgwt"].ToString() == "0" || dr["Pr_month_1_chrgwt"] is DBNull)
                {
                    dr["Pr_month_1_chrgwt"] = 1;
                    dr["Pr_month_1_dkttot"] = 0;

                    dr["y1"] = Convert.ToDouble(dr["pr_month_1_dkttot"]) / Convert.ToDouble(dr["pr_month_1_chrgwt"]);
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");
                }
                else
                {
                    dr["y1"] = Convert.ToDouble(dr["pr_month_1_dkttot"]) / Convert.ToDouble(dr["pr_month_1_chrgwt"]);
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");
                }

                if (dr["Pr_month_2_docket"].ToString() == "0" || dr["Pr_month_2_docket"] is DBNull || dr["Pr_month_2_dkttot"].ToString() == "0" || dr["Pr_month_2_dkttot"] is DBNull || dr["Pr_month_2_chrgwt"].ToString() == "0" || dr["Pr_month_2_chrgwt"] is DBNull)
                {
                    dr["Pr_month_2_chrgwt"] = 1;
                    dr["Pr_month_2_dkttot"] = 0;

                    dr["y2"] = Convert.ToDouble(dr["pr_month_2_dkttot"]) / Convert.ToDouble(dr["pr_month_2_chrgwt"]);
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");
                }
                else
                {

                    dr["y2"] = Convert.ToDouble(dr["pr_month_2_dkttot"]) / Convert.ToDouble(dr["pr_month_2_chrgwt"]);
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");
                }
                if (dr["Pr_month_3_docket"].ToString() == "0" || dr["Pr_month_3_docket"] is DBNull || dr["Pr_month_3_dkttot"].ToString() == "0" || dr["Pr_month_3_dkttot"] is DBNull || dr["Pr_month_3_chrgwt"].ToString() == "0" || dr["Pr_month_3_chrgwt"] is DBNull)
                {
                    dr["Pr_month_3_chrgwt"] = 1;
                    dr["Pr_month_3_dkttot"] = 0;

                    dr["y3"] = Convert.ToDouble(dr["pr_month_3_dkttot"]) / Convert.ToDouble(dr["pr_month_3_chrgwt"]);
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");
                }
                else
                {

                    dr["y3"] = Convert.ToDouble(dr["pr_month_3_dkttot"]) / Convert.ToDouble(dr["pr_month_3_chrgwt"]);
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");
                }
                if (dr["Pr_month_4_docket"].ToString() == "0" || dr["Pr_month_4_docket"] is DBNull || dr["Pr_month_4_dkttot"].ToString() == "0" || dr["Pr_month_4_dkttot"] is DBNull || dr["Pr_month_4_chrgwt"].ToString() == "0" || dr["Pr_month_4_chrgwt"] is DBNull)
                {
                    dr["Pr_month_4_chrgwt"] = 1;
                    dr["Pr_month_4_dkttot"] = 0;

                    dr["y4"] = Convert.ToDouble(dr["pr_month_4_dkttot"]) / Convert.ToDouble(dr["pr_month_4_chrgwt"]);
                    dr["y4"] = Convert.ToDouble(dr["y4"]).ToString("0.00");
                }
                else
                {

                    dr["y4"] = Convert.ToDouble(dr["pr_month_4_dkttot"]) / Convert.ToDouble(dr["pr_month_4_chrgwt"]);
                    dr["y4"] = Convert.ToDouble(dr["y4"]).ToString("0.00");
                }


                if (dr["y1"].ToString() == "NaN")
                {
                    dr["y1"] = 0.00;
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");

                }

                if (dr["y2"].ToString() == "NaN")
                {
                    dr["y2"] = 0.00;
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");

                }

                if (dr["y3"].ToString() == "NaN")
                {
                    dr["y3"] = 0.00;
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");

                }

                if (dr["y4"].ToString() == "NaN")
                {
                    dr["y4"] = 0.00;
                    dr["y4"] = Convert.ToDouble(dr["y4"]).ToString("0.00");

                }


                dr["tot2"] = (Convert.ToDouble(dr["y1"]) + Convert.ToDouble(dr["y2"]) + Convert.ToDouble(dr["y3"]) + Convert.ToDouble(dr["y4"])) / 4;
                dr["tot2"] = Convert.ToDouble(dr["tot2"]).ToString("0.00");
                gtot += Convert.ToInt16(dr["tot"]);
                gtot2 += Convert.ToDouble(dr["tot2"]);

                tot1 += Convert.ToInt16(dr["pr_month1_docket"]);
                tot2 += Convert.ToInt16(dr["pr_month_2_docket"]);
                tot3 += Convert.ToInt16(dr["pr_month_3_docket"]);
                tot4 += Convert.ToInt16(dr["pr_month_4_docket"]);

                tot5 += Convert.ToDouble(dr["y1"]);
                tot6 += Convert.ToDouble(dr["y2"]);
                tot7 += Convert.ToDouble(dr["y3"]);
                tot8 += Convert.ToDouble(dr["y4"]);




                j += 1;

            }

            if (ds.Tables[0].Rows.Count != 1)
            {
                DataRow dr2;
                dr2 = ds.Tables[0].NewRow();

                dr2["report_loc"] = "Total";
                dr2["pr_month1_docket"] = tot1;
                dr2["pr_month_2_docket"] = tot2;
                dr2["pr_month_3_docket"] = tot3;
                dr2["pr_month_4_docket"] = tot4;
                dr2["y1"] = tot5 / (k - 1);
                dr2["y1"] = Convert.ToDouble(dr2["y1"]).ToString("0.00");
                dr2["y2"] = tot6 / (k - 1);
                dr2["y2"] = Convert.ToDouble(dr2["y2"]).ToString("0.00");
                dr2["y3"] = tot7 / (k - 1);
                dr2["y3"] = Convert.ToDouble(dr2["y3"]).ToString("0.00");
                dr2["y4"] = tot8 / (k - 1);
                dr2["y4"] = Convert.ToDouble(dr2["y4"]).ToString("0.00");

                dr2["tot"] = gtot;


                double ytot = gtot2 / (k - 1);
                dr2["tot2"] = ytot;
                dr2["tot2"] = Convert.ToDouble(dr2["tot2"]).ToString("0.00");

                ds.Tables[0].Rows.Add(dr2);
            }

        }
        
        GV_PREV.DataSource = ds;
        GV_PREV.DataBind();
    }

    #endregion

    #region curr Quater

   
    public void curr_q()
    {
       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_Revenue_Dashboard";



        strtrtype = ddltr_mode.SelectedValue.ToString();

        sqlCommand.Parameters.AddWithValue("@Report_type", "Cr_Qua");
        sqlCommand.Parameters.AddWithValue("@Trnmode", strtrtype);


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab");
        if (ds.Tables[0].Rows.Count != 0)
        {
            ds.Tables[0].Columns.Add("tot");

            ds.Tables[0].Columns.Add("tot2");
            ds.Tables[0].Columns.Add("y1");
            ds.Tables[0].Columns.Add("y2");
            ds.Tables[0].Columns.Add("y3");
            ds.Tables[0].Columns.Add("y4");

            double gtot = 0, j = 0, tot1 = 0, tot2 = 0, tot3 = 0, tot4 = 0;
            double tot5 = 0, tot6 = 0, tot7 = 0, tot8 = 0, gtot2 = 0;
            int k;
            k = ds.Tables[0].Rows.Count;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {

                dr["tot"] = Convert.ToInt16(dr["cr_Qua_1_Docket"]) + Convert.ToInt16(dr["cr_Qua_2_Docket"]) + Convert.ToInt16(dr["cr_Qua_3_Docket"]);

                if (dr["cr_Qua_1_Docket"].ToString() == "0")
                {
                    dr["y1"] = "0.00";
                }
                else
                {
                    dr["y1"] = Convert.ToDouble(dr["cr_Qua_1_dkttot"]) / Convert.ToDouble(dr["cr_Qua_1_chrgwt"]);
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");
                }

                if (dr["cr_Qua_2_Docket"].ToString() == "0")
                {
                    dr["y2"] = "0.00";
                }
                else
                {

                    dr["y2"] = Convert.ToDouble(dr["cr_Qua_2_dkttot"]) / Convert.ToDouble(dr["cr_Qua_2_chrgwt"]);
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");
                }
                if (dr["cr_Qua_3_Docket"].ToString() == "0")
                {
                    dr["y3"] = "0.00";
                }
                else
                {

                    dr["y3"] = Convert.ToDouble(dr["cr_Qua_3_dkttot"]) / Convert.ToDouble(dr["cr_Qua_3_chrgwt"]);
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");
                }


                dr["tot2"] = (Convert.ToDouble(dr["y1"]) + Convert.ToDouble(dr["y2"]) + Convert.ToDouble(dr["y3"])) / 3;
                dr["tot2"] = Convert.ToDouble(dr["tot2"]).ToString("0.00");
                gtot += Convert.ToInt16(dr["tot"]);
                gtot2 += Convert.ToDouble(dr["tot2"]);

                tot1 += Convert.ToInt16(dr["cr_Qua_1_Docket"]);
                tot2 += Convert.ToInt16(dr["cr_Qua_2_Docket"]);
                tot3 += Convert.ToInt16(dr["cr_Qua_3_Docket"]);


                tot5 += Convert.ToDouble(dr["y1"]);
                tot6 += Convert.ToDouble(dr["y2"]);
                tot7 += Convert.ToDouble(dr["y3"]);





                j += 1;

            }


            if (ds.Tables[0].Rows.Count != 1)
            {

                DataRow dr2;
                dr2 = ds.Tables[0].NewRow();

                dr2["report_loc"] = "Total";
                dr2["cr_Qua_1_Docket"] = tot1;
                dr2["cr_Qua_2_Docket"] = tot2;
                dr2["cr_Qua_3_Docket"] = tot3;

                dr2["y1"] = tot5 / (k - 1);
                dr2["y1"] = Convert.ToDouble(dr2["y1"]).ToString("0.00");
                dr2["y2"] = tot6 / (k - 1);
                dr2["y2"] = Convert.ToDouble(dr2["y2"]).ToString("0.00");
                dr2["y3"] = tot7 / (k - 1);
                dr2["y3"] = Convert.ToDouble(dr2["y3"]).ToString("0.00");

                dr2["tot"] = gtot;


                double ytot = gtot2 / (k - 1);
                dr2["tot2"] = ytot;
                dr2["tot2"] = Convert.ToDouble(dr2["tot2"]).ToString("0.00");

                ds.Tables[0].Rows.Add(dr2);
            }
        }

        GV_CURR_Q.DataSource = ds;
        GV_CURR_Q.DataBind();
    }

    # endregion

    #region Prev Quater

    public void prv_q()
    {
       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_Revenue_Dashboard";


        strtrtype = ddltr_mode.SelectedValue.ToString();


        sqlCommand.Parameters.AddWithValue("@Report_type", "Pr_Qua");
        sqlCommand.Parameters.AddWithValue("@Trnmode", strtrtype);


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab");


        if (ds.Tables[0].Rows.Count != 0)
        {
            ds.Tables[0].Columns.Add("tot");
            ds.Tables[0].Columns.Add("tot2");
            ds.Tables[0].Columns.Add("y1");
            ds.Tables[0].Columns.Add("y2");
            ds.Tables[0].Columns.Add("y3");
            ds.Tables[0].Columns.Add("y4");

            double gtot = 0, j = 0, tot1 = 0, tot2 = 0, tot3 = 0, tot4 = 0;
            double tot5 = 0, tot6 = 0, tot7 = 0, tot8 = 0, gtot2 = 0;
            int k;
            k = ds.Tables[0].Rows.Count;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {

                dr["tot"] = Convert.ToInt16(dr["Pr_Qua_1_Docket"]) + Convert.ToInt16(dr["Pr_Qua_2_Docket"]) + Convert.ToInt16(dr["pr_Qua_3_Docket"]);

                if (dr["Pr_Qua_1_Docket"].ToString() == "0" || dr["Pr_Qua_1_dkttot"] is DBNull)
                {
                    dr["y1"] = "0.00";
                }
                else
                {
                    dr["y1"] = Convert.ToDouble(dr["Pr_Qua_1_dkttot"]) / Convert.ToDouble(dr["Pr_Qua_1_chrgwt"]);
                    dr["y1"] = Convert.ToDouble(dr["y1"]).ToString("0.00");
                }

                if (dr["Pr_Qua_2_Docket"].ToString() == "0" || dr["Pr_Qua_2_dkttot"] is DBNull)
                {
                    dr["y2"] = "0.00";
                }
                else
                {

                    dr["y2"] = Convert.ToDouble(dr["Pr_Qua_2_dkttot"]) / Convert.ToDouble(dr["Pr_Qua_2_chrgwt"]);
                    dr["y2"] = Convert.ToDouble(dr["y2"]).ToString("0.00");
                }
                if (dr["Pr_Qua_3_Docket"].ToString() == "0" || dr["Pr_Qua_3_dkttot"] is DBNull)
                {
                    dr["y3"] = "0.00";
                }
                else
                {

                    dr["y3"] = Convert.ToDouble(dr["Pr_Qua_3_dkttot"]) / Convert.ToDouble(dr["Pr_Qua_3_chrgwt"]);
                    dr["y3"] = Convert.ToDouble(dr["y3"]).ToString("0.00");
                }


                dr["tot2"] = (Convert.ToDouble(dr["y1"]) + Convert.ToDouble(dr["y2"]) + Convert.ToDouble(dr["y3"])) / 3;
                dr["tot2"] = Convert.ToDouble(dr["tot2"]).ToString("0.00");
                gtot += Convert.ToInt16(dr["tot"]);
                gtot2 += Convert.ToDouble(dr["tot2"]);

                tot1 += Convert.ToInt16(dr["Pr_Qua_1_Docket"]);
                tot2 += Convert.ToInt16(dr["Pr_Qua_2_Docket"]);
                tot3 += Convert.ToInt16(dr["Pr_Qua_3_Docket"]);


                tot5 += Convert.ToDouble(dr["y1"]);
                tot6 += Convert.ToDouble(dr["y2"]);
                tot7 += Convert.ToDouble(dr["y3"]);





                j += 1;

            }


            if (ds.Tables[0].Rows.Count != 1)
            {

                DataRow dr2;
                dr2 = ds.Tables[0].NewRow();

                dr2["report_loc"] = "Total";
                dr2["Pr_Qua_1_Docket"] = tot1;
                dr2["Pr_Qua_2_Docket"] = tot2;
                dr2["Pr_Qua_3_Docket"] = tot3;

                dr2["y1"] = tot5 / (k - 1);
                dr2["y1"] = Convert.ToDouble(dr2["y1"]).ToString("0.00");
                dr2["y2"] = tot6 / (k - 1);
                dr2["y2"] = Convert.ToDouble(dr2["y2"]).ToString("0.00");
                dr2["y3"] = tot7 / (k - 1);
                dr2["y3"] = Convert.ToDouble(dr2["y3"]).ToString("0.00");

                dr2["tot"] = gtot;


                double ytot = gtot2 / (k - 1);
                dr2["tot2"] = ytot;
                dr2["tot2"] = Convert.ToDouble(dr2["tot2"]).ToString("0.00");

                ds.Tables[0].Rows.Add(dr2);

            }
        }
        GV_PREV_Q.DataSource = ds;

        GV_PREV_Q.DataBind();
    

    }

    #endregion
    protected void Button3_Click(object sender, EventArgs e)
    {
    }
    public void CustomersGridView_RowDataBound_Curr_quater(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************
            

            oTableCell = new TableCell();
            oTableCell.Text = "Region";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.RowSpan = 2;

            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = cr1;
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = cr2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = cr3; 
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Total";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);



            
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************

           


            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);





            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString(); ;
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            //oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign= HorizontalAlign.Center;
            //oTableCell.ColumnSpan = 3;

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);




            //oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";
            
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
         




            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
        }
        
    }


    public void CustomersGridView_RowDataBound_Pr_quater(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************


            oTableCell = new TableCell();
            oTableCell.Text = "Region";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.RowSpan = 2;

            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = pr1;
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = pr2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = pr3;
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Total";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);




            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************




            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);





            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            //oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign= HorizontalAlign.Center;
            //oTableCell.ColumnSpan = 3;

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);




            //oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);





            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
        }

    }

    public void CustomersGridView_RowDataBound_Cr_Month(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************


            oTableCell = new TableCell();
            oTableCell.Text = "Region";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.RowSpan = 2;

            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = "Week 1(1-7)";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Week 2(8-14)";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Week 3        (15-22) ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);



            oTableCell = new TableCell();
            oTableCell.Text = "Week 4    ."+"  " + "(23-31) ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Total";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);




            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************




            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);





            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            //oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign= HorizontalAlign.Center;
            //oTableCell.ColumnSpan = 3;

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);




            //oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);




            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
        }

    }

    public void CustomersGridView_RowDataBound_Pr_Month(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************


            oTableCell = new TableCell();
            oTableCell.Text = "Region";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.RowSpan = 2;

            oGridViewRow.Cells.Add(oTableCell);
            oTableCell = new TableCell();
            oTableCell.Text = "Week 1(1-7)";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Week 2(8-14)";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Week 3        (15-22) ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);



            oTableCell = new TableCell();
            oTableCell.Text = "Week 4    ." + "  " + "(23-31) ";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Total";
            oTableCell.CssClass = "blackfnt";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);




            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************




            //oTableCell1 = new TableCell();
            //oTableCell1.Text = " ";
            ////oTableCell.ColumnSpan = 1;
            //oGridViewRow1.Cells.Add(oTableCell1);





            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            //oTableCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            //oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign= HorizontalAlign.Center;
            //oTableCell.ColumnSpan = 3;

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);




            //oTableCell1.CssClass = "blackfnt";
            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = Session["DocketCalledAs"].ToString();
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1.CssClass = "blackfnt";

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Yeild";
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);




            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
        }

    }

    protected void ddltr_mode_SelectedIndexChanged(object sender, EventArgs e)
    {

        //Panel1.Visible = true;
        pnl1.Visible = true;
        curr_month();
        prv_month();

       curr_q();
        prv_q();
      


    }
    public void disp()
    {
        pnl1.Visible = true;
        btn_csv.Visible = false;
        curr_month();
        prv_month();

        curr_q();
        prv_q();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;

            GV_CURR.AllowPaging = false;
            GV_CURR_Q.AllowPaging = false;
            GV_PREV.AllowPaging = false;
            GV_PREV_Q.AllowPaging = false;
            
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Revenue_Dashboard_Report.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            disp();
            pnl1.RenderControl(hw);


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
     



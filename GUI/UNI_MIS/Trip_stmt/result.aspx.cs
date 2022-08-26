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

public partial class GUI_UNI_MIS_Trip_stmt_result : System.Web.UI.Page
{

    public static string DateType, fromdt, todt, Rtyp, st_stloc, st_endloc, st_enrutloc, st_thclist,st_mode,st_status;

   

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        Rtyp = Request.QueryString["Rtyp"].ToString();
        st_stloc = Request.QueryString["st_stloc"].ToString();
        st_endloc = Request.QueryString["st_endloc"].ToString();
        st_enrutloc = Request.QueryString["st_enrutloc"].ToString();
        st_thclist = Request.QueryString["st_thclist"].ToString();

        st_mode = Request.QueryString["st_mode"].ToString();
        st_status = Request.QueryString["st_status"].ToString();
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


        string sql_st = "exec webx_UNI_Trip_stmt '" + dtFrom + "','" + dtTo + "','" + st_thclist + "','" + st_stloc + "','" + st_endloc + "','" + st_mode + "','" + st_enrutloc + "','All','" + st_status + "','" + Rtyp + "'";

        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);


        if (Rtyp == "2")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            // lblflow.Text = dkt_call;
            dgDocket.Visible = true;

        }
        if (Rtyp == "3")
        {
            dgMR.DataSource = ds;
            dgMR.DataBind();
            // lblflow.Text = dkt_call;
            dgMR.Visible = true;


        }
        if (Rtyp == "1")
        {

            DGTM.DataSource = ds;
            DGTM.DataBind();
            // lblflow.Text = dkt_call;
            DGTM.Visible = true;


        }

        conn.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        if (Rtyp == "2")
        {
            dgDocket.PageIndex = e.NewPageIndex;
        }
        if (Rtyp == "3")
        {
            dgMR.PageIndex = e.NewPageIndex;
        }
        if (Rtyp == "1")
        {
            DGTM.PageIndex = e.NewPageIndex;
        }

        BindGrid();

    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
       
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 8;

        dgMR.AllowPaging = false;
        dgMR.BorderWidth = 1;
        dgMR.CssClass = "blackfnt";
        dgMR.Font.Size = 8;

        DGTM.AllowPaging = false;
        DGTM.BorderWidth = 1;
        DGTM.CssClass = "blackfnt";
        DGTM.Font.Size = 8;

        
        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Trip_stmt.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        if (Rtyp == "2")
        {
            frm.Controls.Add(dgDocket);
        }
        if (Rtyp == "3")
        {
            frm.Controls.Add(dgMR);

        }
        if (Rtyp == "1")
        {
            frm.Controls.Add(DGTM);

        }

        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

       

       

    }
    protected void DGTM_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string RTflag = "N";
            string THC_No = e.Row.Cells[4].Text.ToString();
            string route_no = e.Row.Cells[1].Text.ToString();
            string loccode = "",ATD_Str="",ATA_Str="", trtime = "", ATD = "", ETD = "", ATA = "", ETA = "", STA = "", STD = "", LE_Arrival = "", LE_Departure = "", LE_Arrival_Str = "", LE_Departure_Str = "";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
             conn.Open();

            string thc_sql0 = "exec webx_UNI_rut_timeline '" + THC_No + "','1'";
            SqlCommand sqlcmd0 = new SqlCommand(thc_sql0, conn);
            SqlDataReader dr0 = sqlcmd0.ExecuteReader();

            while (dr0.Read())
            {
                loccode = dr0["sourcehb"].ToString();
                trtime = dr0["Transit_Time"].ToString();
                ATD = dr0["ATD"].ToString().Substring(0,11).ToString();
                ATA_Str = dr0["ATA"].ToString();
                ETD = dr0["ETD"].ToString();
                ATA = dr0["ATA"].ToString();
                ETA = dr0["ETA"].ToString();
                ATD_Str = dr0["ATD"].ToString();
                if (dr0["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr0.Close();

            string sql_track0 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd01 = new SqlCommand(sql_track0, conn);
            SqlDataReader dr01 = sqlcmd01.ExecuteReader();
            while (dr01.Read())
            {
                STA = dr01["Sch_Arrival_Date_Time"].ToString();
                STD = dr01["Sch_Departure_Date_Time"].ToString();
            }
            dr01.Close();

            if( STA!="" && ATA!=null && ATA!="" && ATA!="-")
            {
                string SqlDateDiff0 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd01A = new SqlCommand(SqlDateDiff0, conn);
                SqlDataReader dr01A = sqlcmd01A.ExecuteReader();
                while (dr01A.Read())
                {
                    LE_Arrival = dr01A[0].ToString();
                    
                }
                dr01A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff01 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd01D = new SqlCommand(SqlDateDiff01, conn);
                SqlDataReader dr01D = sqlcmd01D.ExecuteReader();
                while (dr01D.Read())
                {
                    LE_Departure = dr01D[0].ToString();

                }
                dr01D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[6].Text = loccode;
            e.Row.Cells[7].Text = trtime;

          


            if (RTflag == "N")
            {
                
                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[8].Text = "-N.A-";
                e.Row.Cells[8].BackColor = System.Drawing.Color.LightGray;
               // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[9].Text = "-N.A-";
                e.Row.Cells[9].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[10].Text = "-N.A-";
                e.Row.Cells[10].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[11].Text = "-N.A-";
                e.Row.Cells[11].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[8].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
               // e.Row.Cells[8].Wrap = false;
                e.Row.Cells[9].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[10].Text = ATA_Str;
                e.Row.Cells[11].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[12].Text = "-N.A-";
                e.Row.Cells[12].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[12].ColumnSpan = 4;
                e.Row.Cells[13].Text = "-N.A-";
                e.Row.Cells[13].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[14].Text = "-N.A-";
                e.Row.Cells[14].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[15].Text = "-N.A-";
                e.Row.Cells[15].BackColor = System.Drawing.Color.LightGray;
            }
            else
            {
                e.Row.Cells[12].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
               // e.Row.Cells[12].Wrap = false;
                e.Row.Cells[13].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[14].Text = ATD_Str;
                e.Row.Cells[15].Text = LE_Departure_Str;

            }


            ///////////////////////////////////2nd Hopping
            loccode = "";
            ATD_Str = "";
            ATA_Str = "";
            trtime = "";
            ATD = "";
            ETD = "";
            ATA = "";
            ETA = "";
            STA = "";
            STD = "";
            LE_Arrival = "";
            LE_Departure = "";
            LE_Arrival_Str = "";
            LE_Departure_Str = "";

            string thc_sql1 = "exec webx_UNI_rut_timeline '" + THC_No + "','2'";
            SqlCommand sqlcmd1 = new SqlCommand(thc_sql1, conn);
            SqlDataReader dr1 = sqlcmd1.ExecuteReader();

            while (dr1.Read())
            {
                loccode = dr1["sourcehb"].ToString();
                trtime = dr1["Transit_Time"].ToString();
                ATD = dr1["ATD"].ToString();

                if (ATD == "")
                {
                    ATD = "";
                }
                else
                {
                    ATD = dr1["ATD"].ToString().Substring(0, 11).ToString();
                }
                ATA_Str = dr1["ATA"].ToString();
                ETD = dr1["ETD"].ToString();
                ATA = dr1["ATA"].ToString();
                ETA = dr1["ETA"].ToString();
                ATD_Str = dr1["ATD"].ToString();
                if (dr1["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr1.Close();

            string sql_track1 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd11 = new SqlCommand(sql_track1, conn);
            SqlDataReader dr11 = sqlcmd11.ExecuteReader();
            while (dr11.Read())
            {
                STA = dr11["Sch_Arrival_Date_Time"].ToString();
                STD = dr11["Sch_Departure_Date_Time"].ToString();
            }
            dr11.Close();

            if (STA != "" && ATA != null && ATA != "" && ATA != "-")
            {
                string SqlDateDiff1 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd11A = new SqlCommand(SqlDateDiff1, conn);
                SqlDataReader dr11A = sqlcmd11A.ExecuteReader();
                while (dr11A.Read())
                {
                    LE_Arrival = dr11A[0].ToString();

                }
                dr11A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff11 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd11D = new SqlCommand(SqlDateDiff11, conn);
                SqlDataReader dr11D = sqlcmd11D.ExecuteReader();
                while (dr11D.Read())
                {
                    LE_Departure = dr11D[0].ToString();

                }
                dr11D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[16].Text = loccode;
            e.Row.Cells[17].Text = trtime;



            if (RTflag == "Y")
            {

                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[18].Text = "-N.A-";
                e.Row.Cells[18].BackColor = System.Drawing.Color.LightGray;
                // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[19].Text = "-N.A-";
                e.Row.Cells[19].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[20].Text = "-N.A-";
                e.Row.Cells[20].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[21].Text = "-N.A-";
                e.Row.Cells[21].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[18].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[19].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[20].Text = ATA_Str;
                e.Row.Cells[21].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[22].Text = "-N.A-";
                e.Row.Cells[22].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[23].Text = "-N.A-";
                e.Row.Cells[23].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[24].Text = "-N.A-";
                e.Row.Cells[24].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[25].Text = "-N.A-";
                e.Row.Cells[25].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[22].ColumnSpan = 4;
            }
            else
            {
                e.Row.Cells[22].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[23].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[24].Text = ATD_Str;
                e.Row.Cells[25].Text = LE_Departure_Str;

            }



            ///////////////////////////////////3rd Hopping
            loccode = "";
            ATD_Str = "";
            ATA_Str = "";
            trtime = "";
            ATD = "";
            ETD = "";
            ATA = "";
            ETA = "";
            STA = "";
            STD = "";
            LE_Arrival = "";
            LE_Departure = "";
            LE_Arrival_Str = "";
            LE_Departure_Str = "";

            string thc_sql2 = "exec webx_UNI_rut_timeline '" + THC_No + "','3'";
            SqlCommand sqlcmd2 = new SqlCommand(thc_sql2, conn);
            SqlDataReader dr2 = sqlcmd2.ExecuteReader();

            while (dr2.Read())
            {
                loccode = dr2["sourcehb"].ToString();
                trtime = dr2["Transit_Time"].ToString();
                ATD = dr2["ATD"].ToString();

                if (ATD == "")
                {
                    ATD = "";
                }
                else
                {
                    ATD = dr2["ATD"].ToString().Substring(0, 11).ToString();
                }
                ATA_Str = dr2["ATA"].ToString();
                ETD = dr2["ETD"].ToString();
                ATA = dr2["ATA"].ToString();
                ETA = dr2["ETA"].ToString();
                ATD_Str = dr2["ATD"].ToString();
                if (dr2["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr2.Close();

            string sql_track2 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd12 = new SqlCommand(sql_track2, conn);
            SqlDataReader dr12 = sqlcmd12.ExecuteReader();
            while (dr12.Read())
            {
                STA = dr12["Sch_Arrival_Date_Time"].ToString();
                STD = dr12["Sch_Departure_Date_Time"].ToString();
            }
            dr12.Close();

            if (STA != "" && ATA != null && ATA != "" && ATA != "-")
            {
                string SqlDateDiff2 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd12A = new SqlCommand(SqlDateDiff2, conn);
                SqlDataReader dr12A = sqlcmd12A.ExecuteReader();
                while (dr12A.Read())
                {
                    LE_Arrival = dr12A[0].ToString();

                }
                dr12A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff12 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd12D = new SqlCommand(SqlDateDiff12, conn);
                SqlDataReader dr12D = sqlcmd12D.ExecuteReader();
                while (dr12D.Read())
                {
                    LE_Departure = dr12D[0].ToString();

                }
                dr12D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[26].Text = loccode;
            e.Row.Cells[27].Text = trtime;



            if (RTflag == "Y")
            {

                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[28].Text = "-N.A-";
                e.Row.Cells[28].BackColor = System.Drawing.Color.LightGray;
                // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[29].Text = "-N.A-";
                e.Row.Cells[29].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[30].Text = "-N.A-";
                e.Row.Cells[30].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[31].Text = "-N.A-";
                e.Row.Cells[31].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[28].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[29].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[30].Text = ATA_Str;
                e.Row.Cells[31].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[32].Text = "-N.A-";
                e.Row.Cells[32].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[32].ColumnSpan = 4;
                e.Row.Cells[33].Text = "-N.A-";
                e.Row.Cells[33].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[34].Text = "-N.A-";
                e.Row.Cells[34].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[35].Text = "-N.A-";
                e.Row.Cells[35].BackColor = System.Drawing.Color.LightGray;
            }
            else
            {
                e.Row.Cells[32].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[33].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[34].Text = ATD_Str;
                e.Row.Cells[35].Text = LE_Departure_Str;

            }



            ///////////////////////////////////4th Hopping
            loccode = "";
            ATD_Str = "";
            ATA_Str = "";
            trtime = "";
            ATD = "";
            ETD = "";
            ATA = "";
            ETA = "";
            STA = "";
            STD = "";
            LE_Arrival = "";
            LE_Departure = "";
            LE_Arrival_Str = "";
            LE_Departure_Str = "";

            string thc_sql3 = "exec webx_UNI_rut_timeline '" + THC_No + "','4'";
            SqlCommand sqlcmd3 = new SqlCommand(thc_sql3, conn);
            SqlDataReader dr3 = sqlcmd3.ExecuteReader();

            while (dr3.Read())
            {
                loccode = dr3["sourcehb"].ToString();
                trtime = dr3["Transit_Time"].ToString();
                ATD = dr3["ATD"].ToString();

                if (ATD == "")
                {
                    ATD = "";
                }
                else
                {
                    ATD = dr3["ATD"].ToString().Substring(0, 11).ToString();
                }
                ATA_Str = dr3["ATA"].ToString();
                ETD = dr3["ETD"].ToString();
                ATA = dr3["ATA"].ToString();
                ETA = dr3["ETA"].ToString();
                ATD_Str = dr3["ATD"].ToString();
                if (dr3["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr3.Close();

            string sql_track3 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd13 = new SqlCommand(sql_track3, conn);
            SqlDataReader dr13 = sqlcmd13.ExecuteReader();
            while (dr13.Read())
            {
                STA = dr13["Sch_Arrival_Date_Time"].ToString();
                STD = dr13["Sch_Departure_Date_Time"].ToString();
            }
            dr13.Close();

            if (STA != "" && ATA != null && ATA != "" && ATA != "-")
            {
                string SqlDateDiff3 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd13A = new SqlCommand(SqlDateDiff3, conn);
                SqlDataReader dr13A = sqlcmd13A.ExecuteReader();
                while (dr13A.Read())
                {
                    LE_Arrival = dr13A[0].ToString();

                }
                dr13A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff13 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd13D = new SqlCommand(SqlDateDiff13, conn);
                SqlDataReader dr13D = sqlcmd13D.ExecuteReader();
                while (dr13D.Read())
                {
                    LE_Departure = dr13D[0].ToString();

                }
                dr13D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[36].Text = loccode;
            e.Row.Cells[37].Text = trtime;



            if (RTflag == "Y")
            {

                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[38].Text = "-N.A-";
                e.Row.Cells[38].BackColor = System.Drawing.Color.LightGray;
                // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[39].Text = "-N.A-";
                e.Row.Cells[39].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[40].Text = "-N.A-";
                e.Row.Cells[40].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[41].Text = "-N.A-";
                e.Row.Cells[41].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[38].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[39].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[40].Text = ATA_Str;
                e.Row.Cells[41].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[42].Text = "-N.A-";
                e.Row.Cells[42].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[42].ColumnSpan = 4;

                e.Row.Cells[43].Text = "-N.A-";
                e.Row.Cells[43].BackColor = System.Drawing.Color.LightGray;

                e.Row.Cells[43].Text = "-N.A-";
                e.Row.Cells[43].BackColor = System.Drawing.Color.LightGray;

                e.Row.Cells[43].Text = "-N.A-";
                e.Row.Cells[43].BackColor = System.Drawing.Color.LightGray;
            }
            else
            {
                e.Row.Cells[42].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[43].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[44].Text = ATD_Str;
                e.Row.Cells[45].Text = LE_Departure_Str;

            }



            ///////////////////////////////////4th Hopping
            loccode = "";
            ATD_Str = "";
            ATA_Str = "";
            trtime = "";
            ATD = "";
            ETD = "";
            ATA = "";
            ETA = "";
            STA = "";
            STD = "";
            LE_Arrival = "";
            LE_Departure = "";
            LE_Arrival_Str = "";
            LE_Departure_Str = "";

            string thc_sql4 = "exec webx_UNI_rut_timeline '" + THC_No + "','5'";
            SqlCommand sqlcmd4 = new SqlCommand(thc_sql4, conn);
            SqlDataReader dr4 = sqlcmd4.ExecuteReader();

            while (dr4.Read())
            {
                loccode = dr4["sourcehb"].ToString();
                trtime = dr4["Transit_Time"].ToString();

                ATD = dr4["ATD"].ToString();
                        
               if(ATD=="")
               {
                   ATD = "";
               }
               else
               {
                    ATD = dr4["ATD"].ToString().Substring(0, 11).ToString();
               }
                       
               
                ATA_Str = dr4["ATA"].ToString();
                ETD = dr4["ETD"].ToString();
                ATA = dr4["ATA"].ToString();
                ETA = dr4["ETA"].ToString();
                ATD_Str = dr4["ATD"].ToString();
                if (dr4["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr4.Close();

            string sql_track4 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd14 = new SqlCommand(sql_track4, conn);
            SqlDataReader dr14 = sqlcmd14.ExecuteReader();
            while (dr14.Read())
            {
                STA = dr14["Sch_Arrival_Date_Time"].ToString();
                STD = dr14["Sch_Departure_Date_Time"].ToString();
            }
            dr14.Close();

            if (STA != "" && ATA != null && ATA != "" && ATA != "-")
            {
                string SqlDateDiff4 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd14A = new SqlCommand(SqlDateDiff4, conn);
                SqlDataReader dr14A = sqlcmd14A.ExecuteReader();
                while (dr14A.Read())
                {
                    LE_Arrival = dr14A[0].ToString();

                }
                dr14A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff14 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd14D = new SqlCommand(SqlDateDiff14, conn);
                SqlDataReader dr14D = sqlcmd14D.ExecuteReader();
                while (dr14D.Read())
                {
                    LE_Departure = dr14D[0].ToString();

                }
                dr14D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[46].Text = loccode;
            e.Row.Cells[47].Text = trtime;



            if (RTflag == "Y")
            {

                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[48].Text = "-N.A-";
                e.Row.Cells[48].BackColor = System.Drawing.Color.LightGray;
                // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[49].Text = "-N.A-";
                e.Row.Cells[49].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[50].Text = "-N.A-";
                e.Row.Cells[50].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[51].Text = "-N.A-";
                e.Row.Cells[51].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[48].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[49].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[50].Text = ATA_Str;
                e.Row.Cells[51].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[52].Text = "-N.A-";
                e.Row.Cells[52].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[52].ColumnSpan = 4;
                e.Row.Cells[53].Text = "-N.A-";
                e.Row.Cells[53].BackColor = System.Drawing.Color.LightGray;

                e.Row.Cells[54].Text = "-N.A-";
                e.Row.Cells[54].BackColor = System.Drawing.Color.LightGray;

                e.Row.Cells[55].Text = "-N.A-";
                e.Row.Cells[55].BackColor = System.Drawing.Color.LightGray;
            }
            else
            {
                e.Row.Cells[52].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[53].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[54].Text = ATD_Str;
                e.Row.Cells[55].Text = LE_Departure_Str;

            }




            ///////////////////////////////////5th Hopping
            loccode = "";
            ATD_Str = "";
            ATA_Str = "";
            trtime = "";
            ATD = "";
            ETD = "";
            ATA = "";
            ETA = "";
            STA = "";
            STD = "";
            LE_Arrival = "";
            LE_Departure = "";
            LE_Arrival_Str = "";
            LE_Departure_Str = "";

            string thc_sql5 = "exec webx_UNI_rut_timeline '" + THC_No + "','6'";
            SqlCommand sqlcmd5 = new SqlCommand(thc_sql5, conn);
            SqlDataReader dr5 = sqlcmd5.ExecuteReader();

            while (dr5.Read())
            {
                loccode = dr5["sourcehb"].ToString();
                trtime = dr5["Transit_Time"].ToString();

                ATD = dr5["ATD"].ToString();

                if (ATD == "")
                {
                    ATD = "";
                }
                else
                {
                    ATD = dr5["ATD"].ToString().Substring(0, 11).ToString();
                }


                ATA_Str = dr5["ATA"].ToString();
                ETD = dr5["ETD"].ToString();
                ATA = dr5["ATA"].ToString();
                ETA = dr5["ETA"].ToString();
                ATD_Str = dr5["ATD"].ToString();
                if (dr5["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr5.Close();

            string sql_track5 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd15 = new SqlCommand(sql_track5, conn);
            SqlDataReader dr15 = sqlcmd15.ExecuteReader();
            while (dr15.Read())
            {
                STA = dr15["Sch_Arrival_Date_Time"].ToString();
                STD = dr15["Sch_Departure_Date_Time"].ToString();
            }
            dr15.Close();

            if (STA != "" && ATA != null && ATA != "" && ATA != "-")
            {
                string SqlDateDiff5 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd15A = new SqlCommand(SqlDateDiff5, conn);
                SqlDataReader dr15A = sqlcmd15A.ExecuteReader();
                while (dr15A.Read())
                {
                    LE_Arrival = dr15A[0].ToString();

                }
                dr15A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff15 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd15D = new SqlCommand(SqlDateDiff15, conn);
                SqlDataReader dr15D = sqlcmd15D.ExecuteReader();
                while (dr15D.Read())
                {
                    LE_Departure = dr15D[0].ToString();

                }
                dr15D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[56].Text = loccode;
            e.Row.Cells[57].Text = trtime;



            if (RTflag == "Y")
            {

                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[58].Text = "-N.A-";
                e.Row.Cells[58].BackColor = System.Drawing.Color.LightGray;
                // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[59].Text = "-N.A-";
                e.Row.Cells[59].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[60].Text = "-N.A-";
                e.Row.Cells[60].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[61].Text = "-N.A-";
                e.Row.Cells[61].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[58].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[59].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[60].Text = ATA_Str;
                e.Row.Cells[61].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[58].Text = "-N.A-";
                e.Row.Cells[58].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[59].Text = "-N.A-";
                e.Row.Cells[59].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[60].Text = "-N.A-";
                e.Row.Cells[60].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[61].Text = "-N.A-";
                e.Row.Cells[61].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[52].ColumnSpan = 4;
            }
            else
            {
                e.Row.Cells[62].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[63].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[64].Text = ATD_Str;
                e.Row.Cells[65].Text = LE_Departure_Str;

            }




            ///////////////////////////////////6th Hopping
            loccode = "";
            ATD_Str = "";
            ATA_Str = "";
            trtime = "";
            ATD = "";
            ETD = "";
            ATA = "";
            ETA = "";
            STA = "";
            STD = "";
            LE_Arrival = "";
            LE_Departure = "";
            LE_Arrival_Str = "";
            LE_Departure_Str = "";

            string thc_sql6 = "exec webx_UNI_rut_timeline '" + THC_No + "','6'";
            SqlCommand sqlcmd6 = new SqlCommand(thc_sql6, conn);
            SqlDataReader dr6 = sqlcmd6.ExecuteReader();

            while (dr6.Read())
            {
                loccode = dr6["sourcehb"].ToString();
                trtime = dr6["Transit_Time"].ToString();

                ATD = dr6["ATD"].ToString();

                if (ATD == "")
                {
                    ATD = "";
                }
                else
                {
                    ATD = dr6["ATD"].ToString().Substring(0, 11).ToString();
                }


                ATA_Str = dr6["ATA"].ToString();
                ETD = dr6["ETD"].ToString();
                ATA = dr6["ATA"].ToString();
                ETA = dr6["ETA"].ToString();
                ATD_Str = dr6["ATD"].ToString();
                if (dr6["thc_number"].ToString() != THC_No)
                {
                    RTflag = "Y";
                }
            }

            dr6.Close();

            string sql_track6 = "Exec usp_Schedule_Arrival_Departure '" + ATD + "','" + route_no + "','" + loccode + "'";
            SqlCommand sqlcmd16 = new SqlCommand(sql_track6, conn);
            SqlDataReader dr16 = sqlcmd16.ExecuteReader();
            while (dr16.Read())
            {
                STA = dr16["Sch_Arrival_Date_Time"].ToString();
                STD = dr16["Sch_Departure_Date_Time"].ToString();
            }
            dr16.Close();

            if (STA != "" && ATA != null && ATA != "" && ATA != "-")
            {
                string SqlDateDiff6 = "Select round(convert(decimal(12,2),datediff(minute,'" + STA + "','" + ATA + "')/60.0),2)";
                SqlCommand sqlcmd16A = new SqlCommand(SqlDateDiff6, conn);
                SqlDataReader dr16A = sqlcmd16A.ExecuteReader();
                while (dr16A.Read())
                {
                    LE_Arrival = dr16A[0].ToString();

                }
                dr16A.Close();

            }
            if (LE_Arrival != "")
            {
                if (Convert.ToDouble(LE_Arrival) > 0)
                {
                    LE_Arrival_Str = "<font color='#ff0000'><b>L:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) < 0)
                {
                    LE_Arrival_Str = "<font color='#005b00'><b>E:</b>" + LE_Arrival + "</font>";
                }
                else if (Convert.ToDouble(LE_Arrival) == 0)
                {
                    LE_Arrival_Str = "On<br>Time";
                }

                LE_Arrival_Str = LE_Arrival_Str.Replace("-", "");
            }

            if (STD != "" && ATD != null && ATD != "" && ATD != "-")
            {
                string SqlDateDiff16 = "Select round(convert(decimal(12,2),datediff(minute,'" + STD + "','" + ATD + "')/60.0),2)";
                SqlCommand sqlcmd16D = new SqlCommand(SqlDateDiff16, conn);
                SqlDataReader dr16D = sqlcmd16D.ExecuteReader();
                while (dr16D.Read())
                {
                    LE_Departure = dr16D[0].ToString();

                }
                dr16D.Close();

            }
            if (LE_Departure != "")
            {
                if (Convert.ToDouble(LE_Departure) > 0)
                {
                    LE_Departure_Str = "<font color='#ff0000'><b>L:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) < 0)
                {
                    LE_Departure_Str = "<font color='#005b00'><b>E:</b>" + LE_Departure + "</font>";
                }
                else if (Convert.ToDouble(LE_Departure) == 0)
                {
                    LE_Departure_Str = "On<br>Time";
                }
                LE_Departure_Str = LE_Departure_Str.Replace("-", "");
            }

            e.Row.Cells[66].Text = loccode;
            e.Row.Cells[67].Text = trtime;



            if (RTflag == "Y")
            {

                RTflag = "N";
                ETD = STD.Replace(":00:000", "").ToString();
                e.Row.Cells[68].Text = "-N.A-";
                e.Row.Cells[68].BackColor = System.Drawing.Color.LightGray;
                // e.Row.Cells[8].ColumnSpan = 4;
                e.Row.Cells[69].Text = "-N.A-";
                e.Row.Cells[69].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[70].Text = "-N.A-";
                e.Row.Cells[70].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[71].Text = "-N.A-";
                e.Row.Cells[71].BackColor = System.Drawing.Color.LightGray;

            }
            else
            {
                e.Row.Cells[68].Text = "<font color='#0000ff'>" + STA.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[69].Text = "<font color='#ff00ff'>" + ETA.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[70].Text = ATA_Str;
                e.Row.Cells[71].Text = LE_Arrival_Str;

            }

            if (ATD_Str == null || ATD_Str == "")
            {
                e.Row.Cells[68].Text = "-N.A-";
                e.Row.Cells[68].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[69].Text = "-N.A-";
                e.Row.Cells[69].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[70].Text = "-N.A-";
                e.Row.Cells[70].BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[71].Text = "-N.A-";
                e.Row.Cells[71].BackColor = System.Drawing.Color.LightGray;
                //e.Row.Cells[52].ColumnSpan = 4;
            }
            else
            {
                e.Row.Cells[72].Text = "<font color='#0000ff'>" + STD.Replace(":00:000", "").ToString() + "</font>";
                e.Row.Cells[73].Text = "<font color='#ff00ff'>" + ETD.Replace(":00:000", "").ToString() + "</font>"; ;
                e.Row.Cells[74].Text = ATD_Str;
                e.Row.Cells[75].Text = LE_Departure_Str;

            }


            conn.Close();





            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
           

            oTableCell = new TableCell();
            oTableCell.Text = " Srno";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);


            oTableCell = new TableCell();
            oTableCell.Text = " Route Code ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Route Name ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Transit Hrs ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Doc No. ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = " Doc Date ";
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 3;
            oGridViewRow.Cells.Add(oTableCell);

           
                oTableCell = new TableCell();
                oTableCell.Text = "Starting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "1st Reportting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "2nd Reportting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "3rd Reportting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "4th Reportting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
                oGridViewRow.Cells.Add(oTableCell);

                oTableCell = new TableCell();
                oTableCell.Text = "5th Reportting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
                oGridViewRow.Cells.Add(oTableCell);


                oTableCell = new TableCell();
                oTableCell.Text = "6th Reportting Location ";
                oTableCell.HorizontalAlign = HorizontalAlign.Center;
                oTableCell.CssClass = "blackfnt";
                oTableCell.ColumnSpan = 10;
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
            
                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Location";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Transit Time";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.RowSpan = 2;
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "Arrivals [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Departures [In]";
                oTableCell1.CssClass = "blackfnt";
                oTableCell1.ColumnSpan = 4;
                oGridViewRow1.Cells.Add(oTableCell1);




            
                oGridViewRow1.HorizontalAlign = HorizontalAlign.Center;
                oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
                oGridViewRow1.CssClass = "bgbluegrey";
                //******************************************
           

        }

        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************
           
                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATA";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);




                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "STD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


                oTableCell1 = new TableCell();
                oTableCell1.Text = "ETD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "ATD";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);

                oTableCell1 = new TableCell();
                oTableCell1.Text = "Late/Early [Hrs.]";
                oTableCell1.CssClass = "blackfnt";
                oGridViewRow1.Cells.Add(oTableCell1);


             oGridViewRow1.HorizontalAlign = HorizontalAlign.Center;
            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************

        }

    }
}

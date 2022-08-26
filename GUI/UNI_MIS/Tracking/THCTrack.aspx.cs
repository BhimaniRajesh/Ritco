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
using System.Data.SqlClient;  

public partial class GUI_Tracking_THCTrack : System.Web.UI.Page
{
    SqlConnection conn;
    public static string st_thcno, call_thc, lng, thcno,thcsf , thcdt ,thcbr , rut_cat , routecd , routename , vendtyp ;
    public static string  vendor_code , vendor_name , tonage,  loaded , uti, vehtype , vehno , driver;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            ////cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
            //    conn.Open();

            st_thcno = Request.QueryString.Get("strDckNo");

            call_thc = Session["THCCalledAs"].ToString();
            //Response.Write("<br> dockno : " + dockno);
            DataSummary(st_thcno);
        }
    }
    public void DataSummary(string dockno)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlstr = "exec webx_TRACthc_track '" + st_thcno + "','S'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader  dr =cmd.ExecuteReader();

        while(dr.Read())
        {
            thcno = dr["thcno"].ToString();
            thcsf = dr["thcsf"].ToString();
            thcdt = dr["thcdt"].ToString();
            thcbr = dr["thcbr"].ToString();
            rut_cat = dr["rut_cat"].ToString();
            routecd = dr["routecd"].ToString();
            routename = dr["routename"].ToString();
            vendtyp = dr["vendtyp"].ToString();
            vendor_code = dr["vendor_code"].ToString();
            vendor_name = dr["vendor_name"].ToString();
            tonage = dr["tonage"].ToString();
            loaded = dr["loaded"].ToString();
            uti = dr["uti"].ToString();
            vehtype = dr["vehtype"].ToString();
            vehno = dr["vehno"].ToString();
           // driver;

           if (dr["driver1"].ToString() == null || dr["driver1"].ToString() == "")
           {
               driver = dr["driver2"].ToString() + "<BR>" + dr["DRIVER2LICNO"].ToString();
           }
           else if (dr["driver2"].ToString() == null || dr["driver2"].ToString() == "")
           {
               driver = dr["driver1"].ToString() + "<BR>" + dr["DRIVER1LICNO"].ToString();
           }
           else
           {
               driver = dr["driver1"].ToString() + "/" + dr["driver2"].ToString() + "<BR>" + dr["DRIVER1LICNO"].ToString() + "/" + dr["DRIVER2LICNO"].ToString();
           }


        }

        dr.Close();


        TableRow tr1 = new TableRow();

        TableCell tr1tc1 = new TableCell();
        TableCell tr1tc2 = new TableCell();
        TableCell tr1tc3 = new TableCell();

        tr1tc1.Text = "Location";
        tr1tc1.CssClass = "blackfnt";
        tr1tc1.HorizontalAlign = HorizontalAlign.Center;
        tr1.Cells.Add(tr1tc1);

        tr1tc2.Text = "Arrival Date & Time";
        tr1tc2.CssClass = "blackfnt";
        tr1tc2.HorizontalAlign = HorizontalAlign.Center;
        tr1.Cells.Add(tr1tc2);

        tr1tc3.Text = "Departure Date & Time";
        tr1tc3.CssClass = "blackfnt";
        tr1tc3.HorizontalAlign = HorizontalAlign.Center;
        tr1.Cells.Add(tr1tc3);
        tr1.CssClass = "bgbluegrey";
        tblmovement1.Rows.Add(tr1);
        string sqlstr1 = "exec webx_TRACthc_track_time '" + st_thcno + "'";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        SqlDataReader  dr1 =cmd1.ExecuteReader();

        while (dr1.Read())
        {
            TableRow tr2 = new TableRow();

            TableCell tr2tc1 = new TableCell();
            TableCell tr2tc2 = new TableCell();
            TableCell tr2tc3 = new TableCell();

            tr2tc1.Text = dr1["sourcehb"].ToString();
            tr2tc1.CssClass = "blackfnt";
            tr2tc1.HorizontalAlign = HorizontalAlign.Center;
            tr2.Cells.Add(tr2tc1);

            tr2tc2.Text = dr1["actarrv_dt"].ToString() + " " + dr1["actarrv_tm"].ToString();
            tr2tc2.CssClass = "blackfnt";
            tr2tc2.HorizontalAlign = HorizontalAlign.Center;
            tr2.Cells.Add(tr2tc2);

            tr2tc3.Text = dr1["actdept_dt"].ToString() + " " + dr1["actdept_tm"].ToString();
            tr2tc3.CssClass = "blackfnt";
            tr2tc3.HorizontalAlign = HorizontalAlign.Center;
            tr2.Cells.Add(tr2tc3);
            tr2.BackColor = System.Drawing.Color.White;
            tblmovement1.Rows.Add(tr2);

        }
            dr1.Close();


        


            conn.Close();
    }

    public void vehmovementsumary(string dockno)
    {
        SqlDataReader drsub;
         conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //DataSet ds = new DataSet();
        string thcno, atd, routecode, loccode, le_arrival_str, le_departure_str, ATD_Str;
        double le_arrival, le_departure;
        thcno = "";
        Boolean rcf;
        rcf = false;
        atd = le_arrival_str = le_departure_str = "";
        string sqlstr = "webx_TRACthc_track";
        DataTable dt = new DataTable();
        DataColumn dc0 = new DataColumn("thcno", typeof(string));
        DataColumn dc1 = new DataColumn("location", typeof(string));
        DataColumn dc2 = new DataColumn("transittime", typeof(string));
        DataColumn dc3 = new DataColumn("sta", typeof(string));
        DataColumn dc4 = new DataColumn("eta", typeof(string));
        DataColumn dc5 = new DataColumn("ata", typeof(string));
        DataColumn dc6 = new DataColumn("l/e1", typeof(string));
        DataColumn dc7 = new DataColumn("std", typeof(string));
        DataColumn dc8 = new DataColumn("etd", typeof(string));
        DataColumn dc9 = new DataColumn("atd", typeof(string));
        DataColumn dc10 = new DataColumn("l/e2", typeof(string));
        DataColumn dc11 = new DataColumn("routecode", typeof(string));
        dt.Columns.Add(dc0);
        dt.Columns.Add(dc1);
        dt.Columns.Add(dc2);
        dt.Columns.Add(dc3);
        dt.Columns.Add(dc4);
        dt.Columns.Add(dc5);
        dt.Columns.Add(dc6);
        dt.Columns.Add(dc7);
        dt.Columns.Add(dc8);
        dt.Columns.Add(dc9);
        dt.Columns.Add(dc10);
        dt.Columns.Add(dc11);
        DataRow drow;
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        string thcty = "M";
        cmd.CommandType = CommandType.StoredProcedure;
        //SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText,conn.ConnectionString);
        //da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        cmd.Parameters.AddWithValue("@DKTRNDNO", st_thcno);
        cmd.Parameters.AddWithValue("@TRkTYPE", thcty);
        conn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        tblmovement.Visible = true;

        //TableRow trMV1 = new TableRow();

        //TableCell tctrMV1 = new TableCell();
        // tctrMV1.Text = "Movement";
        //tctrMV1.CssClass = "blackboldfnt";
        //tctrMV1.Wrap = false;
        //tctrMV1.ColumnSpan = 12;
        //tctrMV1.HorizontalAlign = HorizontalAlign.Center;
        //trMV1.CssClass = "bgbluegrey";
        //trMV1.Cells.Add(tctrMV1);


        //tblmovement.Rows.Add(trMV1);


        //TableRow tr11 = new TableRow();

        //TableCell tctr11 = new TableCell();
        ////TableCell tc2 = new TableCell();
        ////TableCell tc3 = new TableCell();

        ////TableCell tc4 = new TableCell();
        ////TableCell tc5 = new TableCell();
        ////TableCell tc6 = new TableCell();



        //tctr11.Text = "";
        //tctr11.CssClass = " blackboldfnt";
        //tctr11.Wrap = false;
        //tctr11.ColumnSpan = 12;
        //tr11.BackColor = System.Drawing.Color.White;
        //tr11.Cells.Add(tctr11);


        //tblmovement.Rows.Add(tr11);

        TableRow tr12 = new TableRow();

        TableCell tctr12 = new TableCell();

        tctr12.Text = "Vehicle Movement Summary";
        tctr12.CssClass = "blackboldfnt";
        tctr12.Wrap = false;
        tctr12.ColumnSpan = 12;
        tctr12.HorizontalAlign = HorizontalAlign.Center;
        tr12.CssClass = "bgbluegrey";
        // tr11.BackColor = System.Drawing.Color.White;
        tr12.Cells.Add(tctr12);


        tblmovement.Rows.Add(tr12);

        TableRow tr21 = new TableRow();

        TableCell tr21tc1 = new TableCell();
        TableCell tr21tc2 = new TableCell();
        TableCell tr21tc3 = new TableCell();
        TableCell tr21tc4 = new TableCell();
        TableCell tr21tc5 = new TableCell();
        TableCell tr21tc6 = new TableCell();

        tr21tc3.Text = call_thc+" No./Vehicle No.";
        tr21tc3.CssClass = "blackboldfnt";
        //tr21tc3.Wrap = false;
        tr21.CssClass = "bgbluegrey";
        tr21tc3.RowSpan = 2;
        tr21.Cells.Add(tr21tc3);

        tr21tc4.Text = "Location";
        tr21tc4.CssClass = "blackboldfnt";
        tr21tc4.Wrap = false;
        tr21.CssClass = "bgbluegrey";
        tr21tc4.RowSpan = 2;
        tr21.Cells.Add(tr21tc4);

        tr21tc5.Text = "Transit Time";
        tr21tc5.CssClass = "blackboldfnt";
        tr21tc5.Wrap = false;
        tr21.CssClass = "bgbluegrey";
        tr21tc5.RowSpan = 2;
        tr21.Cells.Add(tr21tc5);

        tr21tc1.Text = "Arrivals [In]";
        tr21tc1.CssClass = "blackboldfnt";
        tr21tc1.Wrap = false;
        tr21tc1.ColumnSpan = 4;
        tr21.CssClass = "bgbluegrey";
        tr21tc1.HorizontalAlign = HorizontalAlign.Center;
        tr21.Cells.Add(tr21tc1);

        tr21tc2.Text = "Departures [Out]";
        tr21tc2.CssClass = "blackboldfnt";
        tr21tc2.Wrap = false;
        tr21tc2.ColumnSpan = 4;
        tr21tc2.HorizontalAlign = HorizontalAlign.Center;
        tr21.CssClass = "bgbluegrey";
        tr21.Cells.Add(tr21tc2);

        tr21tc6.Text = "Route Code";
        tr21tc6.CssClass = "blackboldfnt";
        tr21tc6.Wrap = false;
        tr21.CssClass = "bgbluegrey";
        tr21tc6.RowSpan = 2;
        tr21.Cells.Add(tr21tc6);


        tblmovement.Rows.Add(tr21);


        TableRow tr2 = new TableRow();

        TableCell tr2tc1 = new TableCell();
        TableCell tr2tc2 = new TableCell();
        TableCell tr2tc3 = new TableCell();

        TableCell tr2tc4 = new TableCell();
        TableCell tr2tc5 = new TableCell();
        TableCell tr2tc6 = new TableCell();


        TableCell tr2tc7 = new TableCell();
        TableCell tr2tc8 = new TableCell();
        TableCell tr2tc9 = new TableCell();

        TableCell tr2tc10 = new TableCell();
        TableCell tr2tc11 = new TableCell();
        TableCell tr2tc12 = new TableCell();





        tr2tc4.Text = "STA";
        tr2tc4.CssClass = "blackboldfnt";
        tr2tc4.HorizontalAlign = HorizontalAlign.Center;
        tr2tc4.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc4);

        tr2tc5.Text = "ETA";
        tr2tc5.CssClass = "blackboldfnt";
        tr2tc5.HorizontalAlign = HorizontalAlign.Center;
        tr2tc5.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc5);

        tr2tc6.Text = "ATA";
        tr2tc6.CssClass = "blackboldfnt";
        tr2tc6.HorizontalAlign = HorizontalAlign.Center;
        tr2tc6.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc6);

        tr2tc7.Text = "Late/Early [Hrs.]";
        tr2tc7.CssClass = "blackboldfnt";
        tr2tc7.HorizontalAlign = HorizontalAlign.Center;
        //tr2tc7.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc7);

        tr2tc8.Text = "STD";
        tr2tc8.CssClass = "blackboldfnt";
        tr2tc8.HorizontalAlign = HorizontalAlign.Center;
        tr2tc8.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc8);

        tr2tc9.Text = "ETD";
        tr2tc9.CssClass = "blackboldfnt";
        tr2tc9.HorizontalAlign = HorizontalAlign.Center;
        tr2tc9.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc9);

        tr2tc10.Text = "ATD";
        tr2tc10.CssClass = "blackboldfnt";
        tr2tc10.HorizontalAlign = HorizontalAlign.Center;
        tr2tc10.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc10);

        tr2tc11.Text = "Late/Early [Hrs.]";
        tr2tc11.HorizontalAlign = HorizontalAlign.Center;
        tr2tc11.CssClass = "blackboldfnt";
        // tr2tc11.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc11);



        tblmovement.Rows.Add(tr2);




        while (dr.Read())
        {
            TableRow tr3 = new TableRow();

            TableCell tr3tc1 = new TableCell();
            TableCell tr3tc2 = new TableCell();
            TableCell tr3tc3 = new TableCell();

            TableCell tr3tc4 = new TableCell();
            TableCell tr3tc5 = new TableCell();
            TableCell tr3tc6 = new TableCell();


            TableCell tr3tc7 = new TableCell();
            TableCell tr3tc8 = new TableCell();
            TableCell tr3tc9 = new TableCell();

            TableCell tr3tc10 = new TableCell();
            TableCell tr3tc11 = new TableCell();
            TableCell tr3tc12 = new TableCell();




            drow = dt.NewRow();
            if (thcno != Convert.ToString(dr["THC_Number"]))
            {
                rcf = true;
                //drow["thcno"] = Convert.ToString(dr["THC_Number"]) + " - " + Convert.ToString(dr["vehno"]);
                thcno = Convert.ToString(dr["THC_Number"]);
                atd = Convert.ToString(dr["ATD"]);
                if (atd != "" && atd != null && atd != "-" && atd.Length > 10)
                {
                    atd = atd.Substring(0, 11);
                }
            }
            drow["thcno"] = Convert.ToString(dr["THC_Number"]) + " - " + Convert.ToString(dr["vehno"]);
            drow["location"] = Convert.ToString(dr["sourcehb"]);
            drow["routecode"] = Convert.ToString(dr["routecd"]);
            drow["transittime"] = Convert.ToString(dr["transit_time"]);

            tr3tc1.Text = drow["thcno"].ToString();
            tr3tc1.CssClass = "blackfnt";
            //tr3tc1.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc1);
            tr3tc1.BackColor = System.Drawing.Color.White;

            tr3tc2.Text = drow["location"].ToString();
            tr3tc2.CssClass = "blackfnt";
            //tr3tc1.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc2);
            tr3tc2.BackColor = System.Drawing.Color.White;

            tr3tc3.Text = drow["transittime"].ToString();
            tr3tc3.CssClass = "blackfnt";
            //tr3tc1.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc3);
            tr3tc3.BackColor = System.Drawing.Color.White;





            SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn1.Open();
            //usp_Schedule_Arrival_Departure
            SqlCommand cmd1 = new SqlCommand("usp_Schedule_Arrival_Departure", cn1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@startdate", atd);
            cmd1.Parameters.AddWithValue("@routecode", Convert.ToString(dr["routecd"]));
            cmd1.Parameters.AddWithValue("@loccode", Convert.ToString(dr["sourcehb"]));
            drsub = cmd1.ExecuteReader();
            while (drsub.Read())
            {
                drow["sta"] = Convert.ToString(drsub["sch_arrival_date_time"]);
                drow["std"] = Convert.ToString(drsub["sch_departure_date_time"]);
            }
            drsub.Close();
            if (drow["sta"] != "" && Convert.ToString(dr["ata"]) != null && Convert.ToString(dr["ata"]) != "" && Convert.ToString(dr["ata"]) != "-")
            {
                le_arrival_str = "";
                string sql = "Select round(convert(decimal(12,2),datediff(minute,'" + drow["sta"] + "','" + dr["ata"] + "')/60.0),2)";
                cmd1 = new SqlCommand(sql, cn1);
                le_arrival = Convert.ToDouble(cmd1.ExecuteScalar());
                if (le_arrival > 0.00)
                {
                    le_arrival_str = "L: " + le_arrival;
                }
                else if (le_arrival < 0.00)
                {
                    le_arrival_str = "E: " + le_arrival;
                }
                else if (le_arrival == 0.00)
                {
                    le_arrival_str = "On Time";
                }
                le_arrival_str = le_arrival_str.Replace("-", "");
                //drow["l/e1"] = le_arrival_str;
            }


            if (drow["std"] != "" && Convert.ToString(dr["atd"]) != null && Convert.ToString(dr["atd"]) != "" && Convert.ToString(dr["atd"]) != "-")
            {
                le_departure_str = "";
                string sql = "Select round(convert(decimal(12,2),datediff(minute,'" + drow["std"] + "','" + Convert.ToString(dr["atd"]) + "')/60.0),2)";
                cmd1 = new SqlCommand(sql, cn1);
                le_departure = Convert.ToDouble(cmd1.ExecuteScalar());
                if (le_departure > 0.00)
                {
                    le_departure_str = "L: " + le_departure;
                    lng = "L";
                }
                else if (le_departure < 0.00)
                {
                    le_departure_str = "E: " + le_departure;
                    lng = "E";
                }
                else if (le_departure == 0.00)
                {
                    le_departure_str = "On Time";
                }
                le_departure_str = le_departure_str.Replace("-", "");
                drow["l/e2"] = le_departure_str;
            }

            if (rcf == true)
            {
                rcf = false;
                drow["sta"] = "N-A";
                drow["eta"] = "N-A";
                drow["ata"] = "N-A";
                drow["l/e1"] = "N-A";

                tr3tc4.Text = "-N.A-";
                tr3tc4.CssClass = "blackfnt";
                //tr3tc1.Wrap = false;
                tr3tc4.ColumnSpan = 4;
                tr3tc4.HorizontalAlign = HorizontalAlign.Center;
                tr3.Cells.Add(tr3tc4);
                tr3tc4.BackColor = System.Drawing.Color.LightGray;
            }
            else
            {
                String st_sta = drow["sta"].ToString().Replace(":00:000", "");


                if ((Convert.ToString(dr["eta"]) != "") && (Convert.ToString(dr["eta"]) != null))
                {
                    drow["eta"] = Convert.ToString(dr["eta"]).Substring(0, 17);
                }
                drow["ata"] = Convert.ToString(dr["ata"]);
                drow["l/e1"] = le_arrival_str;

                tr3tc4.Text = st_sta;
                tr3tc4.CssClass = "bluefnt";
                tr3tc4.ForeColor = System.Drawing.Color.Blue;
                //tr3tc4.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc4.HorizontalAlign = HorizontalAlign.Center;
                tr3.BackColor = System.Drawing.Color.White;
                tr3.Cells.Add(tr3tc4);

                tr3tc5.Text = drow["eta"].ToString();
                tr3tc5.CssClass = "blackfnt";
                tr3tc5.ForeColor = System.Drawing.Color.DeepPink;
                //tr3tc5. Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc5.HorizontalAlign = HorizontalAlign.Center;
                tr3tc5.BackColor = System.Drawing.Color.White;
                tr3.Cells.Add(tr3tc5);


                tr3tc6.Text = drow["ata"].ToString();
                tr3tc6.CssClass = "blackfnt";
                // tr3tc6.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc6.HorizontalAlign = HorizontalAlign.Center;
                tr3tc6.BackColor = System.Drawing.Color.White;
                tr3.Cells.Add(tr3tc6);


                tr3tc7.Text = drow["l/e1"].ToString();
                tr3tc7.CssClass = "blackfnt";
                // tr3tc1.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc7.HorizontalAlign = HorizontalAlign.Center;
                tr3tc7.BackColor = System.Drawing.Color.White;
                tr3tc7.ForeColor = System.Drawing.Color.Green;
                if (lng == "L")
                {
                    tr3tc7.ForeColor = System.Drawing.Color.Red;
                }
                else if (lng == "E")
                {
                    tr3tc7.ForeColor = System.Drawing.Color.Green;
                }

                tr3.Cells.Add(tr3tc7);

            }
            ATD_Str = Convert.ToString(dr["atd"]);
            if (ATD_Str == "" || ATD_Str == null)
            {
                drow["std"] = "-N.A- ";
                drow["etd"] = "-N.A- ";
                drow["atd"] = "-N.A- ";
                drow["l/e2"] = "-N.A- ";
                tr3tc8.Text = "-N.A-";
                tr3tc8.CssClass = "blackfnt";
                //tr3tc1.Wrap = false;
                tr3tc8.ColumnSpan = 4;
                tr3tc8.HorizontalAlign = HorizontalAlign.Center;
                tr3.Cells.Add(tr3tc8);
                tr3tc8.BackColor = System.Drawing.Color.LightGray;
            }
            else
            {
                //  drow["std"] =  drow["std"].ToString() +""+Convert.ToString(dr["std"]).Replace(":00:000", "");
                String st_std = drow["std"].ToString().Replace(":00:000", ""); ;
                if ((Convert.ToString(dr["etd"]) != "") && (Convert.ToString(dr["etd"]) != null))
                {
                    drow["etd"] = Convert.ToString(dr["etd"]).Substring(0, 17);
                }
                drow["atd"] = Convert.ToString(dr["atd"]);
              

                tr3tc8.Text = st_std;
                tr3tc8.CssClass = "blackfnt";
                tr3tc8.ForeColor = System.Drawing.Color.Blue;
                //tr3tc8.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc8.HorizontalAlign = HorizontalAlign.Center;
                tr3.BackColor = System.Drawing.Color.White;
                tr3.Cells.Add(tr3tc8);

                tr3tc9.Text = drow["etd"].ToString();
                tr3tc9.CssClass = "blackfnt";
                tr3tc9.ForeColor = System.Drawing.Color.DeepPink;
                //tr3tc9.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc9.HorizontalAlign = HorizontalAlign.Center;
                tr3tc9.BackColor = System.Drawing.Color.White;
                tr3.Cells.Add(tr3tc9);


                tr3tc10.Text = drow["atd"].ToString();
                tr3tc10.CssClass = "blackfnt";
                //tr3tc10.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc10.HorizontalAlign = HorizontalAlign.Center;
                tr3tc10.BackColor = System.Drawing.Color.White;
                tr3.Cells.Add(tr3tc10);


                tr3tc11.Text = drow["l/e2"].ToString();
                tr3tc11.CssClass = "blackfnt";
                //tr3tc1.Wrap = false;
                // tr3tc4.ColumnSpan = 4;
                tr3tc11.HorizontalAlign = HorizontalAlign.Center;
                tr3tc11.BackColor = System.Drawing.Color.White;
                tr3tc11.ForeColor = System.Drawing.Color.Green;
                if (lng == "L")
                {
                    tr3tc11.ForeColor = System.Drawing.Color.Red;
                }
                else if (lng == "E")
                {
                    tr3tc11.ForeColor = System.Drawing.Color.Green;
                }

                tr3.Cells.Add(tr3tc11);
            }
            dt.Rows.Add(drow);
            tr3tc12.Text = drow["routecode"].ToString();
            tr3tc12.CssClass = "blackfnt";
            //tr3tc1.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc12);
            tr3tc12.BackColor = System.Drawing.Color.White;

            tblmovement.Rows.Add(tr3);

        }
        //da.Fill(ds,"table1"); 
        dr.Close();
        //GrdPaidFollow.DataSource = dt;
        //GrdPaidFollow.DataBind();
    }




    protected void TabsView1_OnTabChanged(object sender, CommandEventArgs e)
    {
        string abcd = e.CommandArgument.ToString();
        if (abcd == "0")
        {
            DataSummary(st_thcno);
        }
        if (abcd == "1")
        {
            vehmovementsumary(st_thcno);
        }
    }
}

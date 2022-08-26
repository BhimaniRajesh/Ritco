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

public partial class GUI_Tracking_New_TAB_Tracking_THC_THC_track : System.Web.UI.Page
{
    SqlConnection conn;
    public static string st_thcno, call_thc, lng, thcno, thcsf, thcdt, thcbr, rut_cat, routecd, routename, vendtyp;
    public static string vendor_code, vendor_name, tonage, loaded, uti, vehtype, vehno, driver;
    public static string gps_thcno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        st_thcno = Request.QueryString.Get("strDckNo");

        call_thc = Session["THCCalledAs"].ToString();
        //Response.Write("<br> dockno : " + dockno);
        DataSummary(st_thcno);
        gps_thcno = st_thcno.Replace(".", "");
    }

    public void DataSummary(string dockno)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sqlstr = "exec webx_TRACthc_track '" + st_thcno + ".','S'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
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
        tr1tc1.HorizontalAlign = HorizontalAlign.Left;
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
        string sqlstr1 = "exec webx_TRACthc_track_time '" + st_thcno + ".'";
        //string sqlstr1 = "exec webx_GPSTrack_THC '" + thcno + "'";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        SqlDataReader dr1 = cmd1.ExecuteReader();

        while (dr1.Read())
        {
            TableRow tr2 = new TableRow();

            TableCell tr2tc1 = new TableCell();
            TableCell tr2tc2 = new TableCell();
            TableCell tr2tc3 = new TableCell();

            tr2tc1.Text = dr1["sourcehb"].ToString();//dr1["sourcehb"].ToString();
            tr2tc1.CssClass = "blackfnt";
            tr2tc1.HorizontalAlign = HorizontalAlign.Left;
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


        string sql_st = "exec webx_THC_TAB_Tracking '" + st_thcno + "'";
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);
        dgDocket1.DataSource = ds;
        dgDocket1.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket1.Visible = true;


        conn.Close();
    }


    //public void GPSDataTracking(string dockno)
    //{
    //    tblgpsmovement.Visible = true;
    //    conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    TableRow tr1 = new TableRow();

    //    TableCell tr1tc1 = new TableCell();
    //    TableCell tr1tc2 = new TableCell();
    //    TableCell tr1tc3 = new TableCell();

    //    tr1tc1.Text = "Location";
    //    tr1tc1.CssClass = "blackfnt";
    //    tr1tc1.HorizontalAlign = HorizontalAlign.Left;
    //    tr1.Cells.Add(tr1tc1);

    //    tr1tc2.Text = "Arrival Date & Time";
    //    tr1tc2.CssClass = "blackfnt";
    //    tr1tc2.HorizontalAlign = HorizontalAlign.Center;
    //    tr1.Cells.Add(tr1tc2);

    //    tr1tc3.Text = "Departure Date & Time";
    //    tr1tc3.CssClass = "blackfnt";
    //    tr1tc3.HorizontalAlign = HorizontalAlign.Center;
    //    tr1.Cells.Add(tr1tc3);
    //    tr1.CssClass = "bgbluegrey";
    //    tblgpsmovement.Rows.Add(tr1);
    //    //string sqlstr1 = "exec webx_TRACthc_track_time '" + st_thcno + "'";
    //    string sqlstr1 = "exec webx_GPSTrack_THC '" + thcno + "'";
    //    SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
    //    SqlDataReader dr1 = cmd1.ExecuteReader();

    //    while (dr1.Read())
    //    {
    //        TableRow tr2 = new TableRow();

    //        TableCell tr2tc1 = new TableCell();
    //        TableCell tr2tc2 = new TableCell();
    //        TableCell tr2tc3 = new TableCell();

    //        tr2tc1.Text = dr1["location"].ToString();//dr1["sourcehb"].ToString();
    //        tr2tc1.CssClass = "blackfnt";
    //        tr2tc1.HorizontalAlign = HorizontalAlign.Left;
    //        tr2.Cells.Add(tr2tc1);

    //        tr2tc2.Text = dr1["actarrv_dt"].ToString() + " " + dr1["actarrv_tm"].ToString();
    //        tr2tc2.CssClass = "blackfnt";
    //        tr2tc2.HorizontalAlign = HorizontalAlign.Center;
    //        tr2.Cells.Add(tr2tc2);

    //        tr2tc3.Text = dr1["actdept_dt"].ToString() + " " + dr1["actdept_tm"].ToString();
    //        tr2tc3.CssClass = "blackfnt";
    //        tr2tc3.HorizontalAlign = HorizontalAlign.Center;
    //        tr2.Cells.Add(tr2tc3);
    //        tr2.BackColor = System.Drawing.Color.White;
    //        tblgpsmovement.Rows.Add(tr2);

    //    }
    //    dr1.Close();





        //conn.Close();

    

}

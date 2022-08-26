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

public partial class REPORT_sfm_funnel_report_loc_wise2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string fromdt, todt, strlocation, strtxtloccode, strRegion,Branch,EmployeeCode;
    public string strActualFromDate;
    public string strActualToDate;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        fromdt = Request.QueryString["strFromDt"].ToString();
        todt = Request.QueryString["strToDt"].ToString();
        strlocation = Request.QueryString["strlocation"].ToString();
        strRegion = Request.QueryString["strRegion"].ToString();
        strtxtloccode = Request.QueryString["strtxtloccode"].ToString();
        Branch = Session["brcd"].ToString();
        EmployeeCode = Session["empcd"].ToString();

        if (fromdt == "" && todt == "")
        {
            lbldate.Text = "ALL";
        }
        else
        {
            lbldate.Text = fromdt + " TO " + todt;
        }

        if (strRegion == "--All--")
        {
            lblRegion.Text = "ALL";
        }
        else if (strRegion != "--All--")
        {
            lblRegion.Text = strRegion;
        }

        if (strlocation == "--All--" && strtxtloccode == null || strtxtloccode == "")
        {
            lblLocation.Text = "ALL";
        }
        else if (strlocation == "--All--" && strtxtloccode != "" || strtxtloccode != null)
        {
            lblLocation.Text = strtxtloccode;
        }
        else if (strlocation != "--All--" && strtxtloccode == "")
        {
            lblLocation.Text = strlocation;
        }

        BindGrid();



    }

    private void BindGrid()
    {
        conn.Open();
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl == 1)
        {

            string sql = "webx_funnal_locationwise";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd MMM yyyy");

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd MMM yyyy";
            dtfi.DateSeparator = "/";


            {
                if (fromdt != "")
                {
                    dtFrom = Convert.ToDateTime(fromdt, dtfi);
                    dtTo = Convert.ToDateTime(todt, dtfi);
                }
                else
                {
                    System.DateTime nowdate = System.DateTime.Today;
                    string todate = nowdate.ToString("dd MMM yyyy");
                    dtFrom = Convert.ToDateTime("01 Jan 1950");
                    dtTo = Convert.ToDateTime(todate);
                }

            }

            strActualFromDate = dtFrom.ToString("dd MMM yyyy");
            strActualToDate = dtTo.ToString("dd MMM yyyy");

            string location;

            location = strlocation;
            if (location == "--All--")
            {
                location = "";
            }
            else
            {
                location = strlocation;
            }

            if (strtxtloccode == "")
            {

                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
            }
            else
            {
                location = strtxtloccode;
                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;

            }



            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgCallSummary.DataSource = dv;
            dgCallSummary.DataBind();


        }
        //else if(Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        //{
           
        //    string sql = "webx_funnal_location_abc";
        //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //    sqlcmd.CommandType = CommandType.StoredProcedure;

        //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        //    System.DateTime righnow = System.DateTime.Today;
        //    string strrightnow = righnow.ToString("dd MMM yyyy");

        //    DateTime dtFrom = new DateTime();
        //    DateTime dtTo = new DateTime();

        //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //    dtfi.ShortDatePattern = "dd MMM yyyy";
        //    dtfi.DateSeparator = "/";


        //    {
        //        if (fromdt != "")
        //        {
        //            dtFrom = Convert.ToDateTime(fromdt, dtfi);
        //            dtTo = Convert.ToDateTime(todt, dtfi);
        //        }
        //        else
        //        {
        //            System.DateTime nowdate = System.DateTime.Today;
        //            string todate = nowdate.ToString("dd MMM yyyy");
        //            dtFrom = Convert.ToDateTime("01 Jan 1950");
        //            dtTo = Convert.ToDateTime(todate);
        //        }

        //    }

        //    strActualFromDate = dtFrom.ToString("dd MMM yyyy");
        //    strActualToDate = dtTo.ToString("dd MMM yyyy");

        //    string location;

        //    location = strlocation;
        //    if (location == "--All--")
        //    {
        //        location = "";
        //    }
        //    else
        //    {
        //        location = strlocation;
        //    }

        //    if (strtxtloccode == "")
        //    {

        //        da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
        //        da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
        //        da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
        //        //da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = EmployeeCode;
        //    }
        //    else
        //    {
        //        location = strtxtloccode;
        //        da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
        //        da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
        //        da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
        //        //da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = EmployeeCode;

        //    }



        //    DataSet ds = new DataSet();
        //    da.Fill(ds);

        //    DataView dv = ds.Tables[0].DefaultView;

        //    dgCallSummary.DataSource = dv;
        //    dgCallSummary.DataBind();
            
        //}
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            //conn.Open();
            string sql = "webx_funnal_locationwise_User";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd MMM yyyy");

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd MMM yyyy";
            dtfi.DateSeparator = "/";


            {
                if (fromdt != "")
                {
                    dtFrom = Convert.ToDateTime(fromdt, dtfi);
                    dtTo = Convert.ToDateTime(todt, dtfi);
                }
                else
                {
                    System.DateTime nowdate = System.DateTime.Today;
                    string todate = nowdate.ToString("dd MMM yyyy");
                    dtFrom = Convert.ToDateTime("01 Jan 1950");
                    dtTo = Convert.ToDateTime(todate);
                }

            }

            strActualFromDate = dtFrom.ToString("dd MMM yyyy");
            strActualToDate = dtTo.ToString("dd MMM yyyy");

            string location;

            location = strlocation;
            if (location == "--All--")
            {
                location = "";
            }
            else
            {
                location = strlocation;
            }

            if (strtxtloccode == "")
            {

                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = EmployeeCode;
            }
            else
            {
                location = strtxtloccode;
                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = EmployeeCode;

            }



            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgCallSummary.DataSource = dv;
            dgCallSummary.DataBind();
        }
            
        
    }
    public void pgChange(object source, DataGridPageChangedEventArgs e)
    {

        dgCallSummary.CurrentPageIndex = e.NewPageIndex;
        BindGrid();

    }
}

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

public partial class REPORT_CallSummary_Locationwise2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string fromdt, todt, strlocation, strtxtloccode, strRegion, Branch,employeecode;
    public string strActualFromDate;
    public string strActualToDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        Branch = Session["brcd"].ToString();
        employeecode = Session["empcd"].ToString();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        fromdt = Request.QueryString["strFromDt"].ToString();
        todt = Request.QueryString["strToDt"].ToString();
        strlocation = Request.QueryString["strlocation"].ToString();
        strRegion = Request.QueryString["strRegion"].ToString();
        strtxtloccode = Request.QueryString["strtxtloccode"].ToString();

        
        if (fromdt == "" && todt == "")
        {
            lblDate.Text = "ALL";
        }
        else
        {
            lblDate.Text = fromdt + " TO " + todt;
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
        string sql = "webx_call_summary_location_new";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);

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
                if (location == "")
                {
                    location = "";
                }
                else
                {
                    location = location;
                }
                employeecode = "";
            }
                
            else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
            {
                if (location == "")
                {
                    location = "";
                }
                else
                {
                    location = location;
                }
                employeecode = "";
            }
            else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
            {
                location = location;
                employeecode = employeecode;

            }
            da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
            da.SelectCommand.Parameters.Add("@Entryby", SqlDbType.VarChar).Value = employeecode;
            
        }
        else
        {
            location = strtxtloccode;
            da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
            da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;

            
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
                location = location;
                employeecode = "";
            }
            else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
            {
                location = location;
                employeecode = "";
            }
            else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
            {
                location = location;
                employeecode = employeecode;

            }

            da.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = location;
            da.SelectCommand.Parameters.Add("@Entryby", SqlDbType.VarChar).Value = employeecode;
            
        }
        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallsummaryLocation.DataSource = dv;
        dgCallsummaryLocation.DataBind();

        conn.Close();

    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgCallsummaryLocation.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    
}

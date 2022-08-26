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

public partial class REPORT_ProspectStatus2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand(); 

    function2 fn = new function2();

    public static string DtFromM, DtToM, employee, Region, location, empcd, fromdt, todt, sql_All;
    public string strActualFromDate;
    public string strActualToDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DtFromM = Request.QueryString["DtFrom"].ToString();
        DtToM = Request.QueryString["DtTo"].ToString();
        employee = Request.QueryString["emp"].ToString();
        Region = Request.QueryString["Region"].ToString();
        location = Request.QueryString["location"].ToString() == "" ? "ALL" : Request.QueryString["location"].ToString();
        
        empcd = Request.QueryString["empcd"].ToString();

        fromdt = DtFromM;
        todt = DtToM;

        if (Region == "--All--")
        {
            lblRegion.Text = "ALL";
        }
        else
        {
            lblRegion.Text = Region;
        }

        if (location == "--All--")
        {
            lblLocation.Text = "ALL";
            location = "";
        }
        else if (location == "Select")
        {
            location = "";
        }
        else
        {
            lblLocation.Text = location;
        }

        if (employee == "" || employee == null && empcd == "")
        {
            lblSalesPerson.Text = "ALL";
        }
        else
        {
            lblSalesPerson.Text = employee;// +":" + fn.GetEmployeeName(employee);
        }
        lblDateRange.Text = DtFromM + "  To  " + DtToM;

        BindGrid();
    }
    public void BindGrid()
    {
        //else if(Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        //{
        
        //}
        //else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        //{
        
        //}

        
            string branch = Session["brcd"].ToString();
            conn.Open();
            string sql = "webx_Prospect_Status";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd MMM yyyy";
            dtfi.DateSeparator = "/";

            {
                if (DtFromM != "")
                {
                    dtFrom = Convert.ToDateTime(DtFromM, dtfi);
                    dtTo = Convert.ToDateTime(DtToM, dtfi);
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

            if (employee == "--All--")
            {
                employee = "";
            }
            else
            {
                employee = employee;
            }

            if (empcd == "")
            {

                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                da.SelectCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = location;
            }
            else
            {

                employee = empcd;
                da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
                da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
                da.SelectCommand.Parameters.Add("@empcd", SqlDbType.VarChar).Value = employee;
                da.SelectCommand.Parameters.Add("@brcd", SqlDbType.VarChar).Value = location;
            }

            DataSet ds = new DataSet();
            da.Fill(ds);

            DataView dv = ds.Tables[0].DefaultView;

            dgProspectStatus.DataSource = dv;
            dgProspectStatus.DataBind();

            conn.Close();
       

    }
    public void pgChange(object source, DataGridPageChangedEventArgs e)
    {

        dgProspectStatus.CurrentPageIndex = e.NewPageIndex;
        BindGrid();

    }
}

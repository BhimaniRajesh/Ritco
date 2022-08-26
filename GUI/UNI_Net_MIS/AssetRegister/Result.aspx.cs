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
using System.IO;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_UNI_Net_MIS_AssetRegister_Result : System.Web.UI.Page
{
    public string strcust, dkt_call, asset, GrossValue, Location, method, DepFrom, EndFin, asOnFrom;
    public static string RO = "", LO = "", DLLStatus = "", RO_TO = "", LO_TO = "", DateType = "", fromdt = "", todt = "", st_Docnolist = "";
    public static string strPaybas = "", strCust = "", str_Paybas = "", strMode = "", str_Mode = "", strType = "", str_Type = "";
    DateTime startDate, endDate, currentdate;
    int noOfDays = 0;
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string Year1 = Session["FinYear"].ToString();
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        //string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
        string finyearstart = "01 APR " + YearString;
        EndFin = CloseYear + "-03-31";
        asOnFrom = Year1 + "-04-01";
        //yrstartdt = Convert.ToDateTime(finyearstart);
        currentdate = System.DateTime.Now.Date;

        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD = Request.QueryString.Get("RMD");

        DateType = Request.QueryString.Get("DateType");
        fromdt = Request.QueryString.Get("fromdt");
        todt = Request.QueryString.Get("todt");
        asset = Request.QueryString.Get("asset");
        GrossValue = Request.QueryString.Get("GrossValue");
        Location = Request.QueryString.Get("Location");
        DepFrom = Request.QueryString.Get("depfrom");

        //lblseldet.Text = dtFrom + " - " + dtTo;
        //lblloc.Text = Location;
        //lblro.Text = RO;
        //Conn.Open();
        //string sqlLoc = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + Location + "'";
        //SqlCommand cmdLoc = new SqlCommand(sqlLoc, Conn);
        //SqlDataReader drLoc;
        //drLoc = cmdLoc.ExecuteReader();

        //while (drLoc.Read())
        //{
        //    lblloc.Text = Convert.ToString(drLoc["Loccode"]) + ":" + Convert.ToString(drLoc["Locname"]);
        //}
        //drLoc.Close();
        //Conn.Close();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();
        }
    }

    public void DWN_XLS()
    {
        tblGl.Border = 1;

        dgFA.AllowPaging = false;
        dgFA.BorderWidth = 1;
        dgFA.CssClass = "blackfnt";
        dgFA.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=FARegister.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblGl);
        frm.Controls.Add(dgFA);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        if (Location == "")
        {
            Location = "";
        }
        if (asset == "ALL")
        {
            asset = "";
        }
        lblseldet.Text = fromdt + " - " + todt;
        Conn.Open();
        string SQL = "exec webx_FA_Register '" + fromdt + "','" + todt + "','" + Location + "','" + asset + "','" + GrossValue + "'";
        SqlCommand sqlcmd12 = new SqlCommand(SQL, conn);

        //Response.Write(SQL);
        //Response.End();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();

        da.Fill(ds);

        dgFA.DataSource = ds;
        dgFA.DataBind();
        dgFA.Visible = true;

        Conn.Close();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgFA.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void dgFA_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //Conn.Open();
        string days = "";
        int dayscount = 0;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label GrossValue = (Label)e.Row.FindControl("lblGrossValue");
            Label DepreciateRate = (Label)e.Row.FindControl("lblDepreciateRate");
            Label DepreciationAmount = (Label)e.Row.FindControl("lblDepreciationAmount");
            Label NetValue = (Label)e.Row.FindControl("lblNetValue");
            Label lblInstallationDate = (Label)e.Row.FindControl("lblInstallationDate");

            DateTime dt = DateTime.MinValue;
            DateTime InstDt = Convert.ToDateTime(lblInstallationDate.Text);
            DateTime asONDt = Convert.ToDateTime(asOnFrom);
            if (asONDt.Date >= InstDt.Date)
                dt = asONDt.Date;
            else
                dt = InstDt.Date;

            //string asOndate1 = dt.ToString("YYYY-MM-DD");
            string asOndate1 = Convert.ToString(dt);

            if (DepFrom == "A")
            {
            string asOnDate = System.DateTime.Now.ToString("yyyy-MM-dd");
            string SQLnew = "select datediff(dd, '" + asOndate1 + "','" + asOnDate + "' ) + dbo.calcdays(year('" + asOndate1 + "'),year('" + asOnDate + "')) as Days";
            //Response.Write(SQLnew);
            //Response.End();
            SqlCommand sqlcmdnew = new SqlCommand(SQLnew, Conn);
            SqlDataReader dr = sqlcmdnew.ExecuteReader();

            while (dr.Read())
            {
                days = Convert.ToString(dr["Days"]);
                lblDays.Text = days;
            }
            dr.Close();
            double depreciation = (Convert.ToDouble(GrossValue.Text) * Convert.ToDouble(DepreciateRate.Text) * Convert.ToDouble(days)) / 365;
            DepreciationAmount.Text = depreciation.ToString("F2");
            double net = (Convert.ToDouble(GrossValue.Text) - depreciation);
            NetValue.Text = net.ToString("F2");

        }
        else if (DepFrom == "B")
        {
            string asOnDate = System.DateTime.Now.ToString("yyyy-MM-dd");
            string SQLnew = "select datediff(dd, '" + asOndate1 + "','" + EndFin + "' ) + dbo.calcdays(year('" + asOndate1 + "'),year('" + EndFin + "')) as Days";

            days = Convert.ToString(SqlHelper.ExecuteScalar(Conn, CommandType.Text, SQLnew));
            lblDays.Text = days;

            double depreciation = (Convert.ToDouble(GrossValue.Text) * Convert.ToDouble(DepreciateRate.Text) * Convert.ToDouble(days)) / 365;
            DepreciationAmount.Text = depreciation.ToString("F2");
            double net = (Convert.ToDouble(GrossValue.Text) - depreciation);
            NetValue.Text = net.ToString("F2");
        }
        }
    }
}

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

public partial class REPORT_Prospect_RegisterReport3 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string prospect, location, fromdt, todt, daterange, calltype, value, callmade, entryby;
    function2 fn = new function2();

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        prospect = Request.QueryString["pro"].ToString();
        location = Request.QueryString["location"].ToString();
        //calltype = Request.QueryString["calltype"].ToString();
        //fromdt = Request.QueryString["fromdt"].ToString();
        //todt = Request.QueryString["todt"].ToString();
        //value = Request.QueryString["value"].ToString();
        //callmade = Request.QueryString["callmade"].ToString();
        entryby = Request.QueryString["entryby"].ToString();

        //lblDate.Text = fromdt + " : " + todt;
        lblLocation.Text = location;
        //lblProspectType.Text = calltype;
        //lblValue.Text = value;
        //lblCallMade.Text = callmade;
        lblProspectId.Text = prospect + " : " + fn.GetCompanyName(prospect);
        lblSalesPerson.Text = entryby;

        conn.Open();
        string sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, callduration,discpoint,acctcategory from webx_callentry where loccode='" + location + "'  and ProspectCode='" + prospect + "'";
        //select * from webx_CallEntry where entryby='R0011' and LocCode='blr' and ProspectCode='PR00010'

        SqlCommand sqlcmd = new SqlCommand(sql, conn);


        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        GridView1.DataSource = dv;
        GridView1.DataBind();

        conn.Close();
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {

    }
}

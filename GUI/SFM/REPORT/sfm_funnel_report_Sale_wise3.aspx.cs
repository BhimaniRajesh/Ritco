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

public partial class REPORT_sfm_funnel_report_Sale_wise3 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string prospect, entryby, fromdt, todt, daterange, calltype, sql;
    function2 fn = new function2();

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        prospect = Request.QueryString["pro"].ToString();
        entryby = Request.QueryString["entryby"].ToString();

        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();


        prospect = Request.QueryString["pro"].ToString();
        //location = Request.QueryString["location"].ToString();
        calltype = Request.QueryString["AcctCategory"].ToString();
        if (calltype == "")
        {
            calltype = "";
        }
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        //value = Request.QueryString["value"].ToString();
        //callmade = Request.QueryString["callmade"].ToString();
        entryby = Request.QueryString["entryby"].ToString();
        
        lblDate.Text = fromdt + " : " + todt;
        //lblLocation.Text = location;
        //lblProspectType.Text = calltype;
        //lblValue.Text = value;
        //lblCallMade.Text = callmade;
        lblProspectId.Text = prospect + ":" + fn.GetCompanyName(prospect);
        lblSalesPerson.Text = entryby;// +":" + fn.GetEmployeeName(entryby);


        BindGrid();
        

    }

    private void BindGrid()
    {
        conn.Open();
        //Original string sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, callduration,discpoint,acctcategory from webx_callentry where entryby like '" + entryby + "%'  and ProspectCode='" + prospect + "' AND AcctCategory like '" + calltype + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";

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
            sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, callduration,discpoint,acctcategory from webx_callentry where entryby like '" + entryby + "%'  and ProspectCode='" + prospect + "' AND AcctCategory like '" + calltype + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, callduration,discpoint,acctcategory from webx_callentry where entryby like '" + entryby + "%'  and ProspectCode='" + prospect + "' AND AcctCategory like '" + calltype + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            if (calltype == "")
            {
                sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, callduration,discpoint,acctcategory from webx_callentry where entryby like '" + entryby + "%'  and ProspectCode='" + prospect + "' AND AcctCategory like '" + calltype + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";
            }
            else
            {
                sql = "select callcode,convert(varchar,calldt,106) as calldt,calltime,personcalled, callduration,discpoint,acctcategory from webx_callentry where entryby like '" + entryby + "%'  and ProspectCode='" + prospect + "' AND AcctCategory like '" + calltype + "%' and convert(varchar,calldt,106) between convert(datetime,'" + fromdt + "',106) and convert(datetime,'" + todt + "',106)";
            }

        }

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

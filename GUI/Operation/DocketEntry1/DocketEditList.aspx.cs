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
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_DocketPrint_DocketList : System.Web.UI.Page
{
    protected string dockno, mode, agent, date1, date2, tp, sqlstr, dkt_call = "", partycode = "";

    MyFunctions fn = new MyFunctions();
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {

        dockno = Request.QueryString["dockno"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        partycode = Request.QueryString["partycode"].ToString();
        tp = Request.QueryString["tp"].ToString();

        lbldates.Text = fn.Mydate1(date1) + " ~ " + fn.Mydate1(date2);
        lbldockno.Text = dockno;

        try
        {
            dkt_call = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        try
        {
            sqlstr = "SELECT loc_level FROM webx_location WHERE loccode='" + Session["brcd"].ToString() + "'";
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        string loclevel = Convert.ToString(cmd.ExecuteScalar());



        string datestr = "", BILLNOstr = "";
        DateTime dtstartfinyear = new DateTime(Convert.ToInt16(Session["finyear"]), 4, 1);
        DateTime dtendfinyear = new DateTime(Convert.ToInt16(Session["finyear"]) + 1, 3, 31);
        bool flagedit = false;
        try
        {
            flagedit = DocketFinEditController.CheckDocketEditEligible(dockno, Convert.ToString(Session["finyear"]));
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=" + ex.Message.Replace('\n', '_') + "&detail1=" + ex.Message.Replace('\n', '_') + "");
            return;
        }
        DataTable dt = new DataTable();
        if (flagedit)
        {

            sqlstr = "SELECT distinct dockno,convert(varchar,dockdt,106) as dockdt,";
            sqlstr = sqlstr + "locroute=(orgncd + ' - ' + destcd),";
            sqlstr = sqlstr + "cityroute=(from_loc + ' - ' + to_loc),party_code as party,";
            sqlstr = sqlstr + "(select top 1 codedesc from webx_master_general where codetype='paytyp'and codeid=paybas) as paybas";
            sqlstr = sqlstr + " FROM webx_master_docket";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "'";

            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            grvdocket.DataSource = dt;
            grvdocket.DataBind();

        }


        if (dt.Rows.Count <= 0)
        {
            grvdocket.CssClass = "redfnt";
            grvdocket.HorizontalAlign = HorizontalAlign.Center;
        }

        if (dt.Rows.Count <= 0)
        {
            grvdocket.Style["display"] = "none";
            tblgrid.Style["display"] = "block";
        }
    }


    protected void lnkdockedit_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;

        HiddenField hdn = (HiddenField)lnk.Parent.FindControl("hdndockno");
        Response.Redirect("DocketFinancialEdit.aspx?dockno=" + hdn.Value);
    }


}

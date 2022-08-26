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
using WebX.Entity;
using WebX.Controllers;
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_Operations_GatePass_ViewPrint_GatePassPrint_RITCO : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string tp = Request.QueryString["tp"].ToString();
        string flagdup = "N";
        try
        {
            flagdup = Request.QueryString["flagdup"].ToString();
        }
        catch (Exception ex) { flagdup = "N"; }

        string gatepassnos = "", start = "", end = "";
        if (tp.CompareTo("0") == 0)
        {
            gatepassnos = Request.QueryString["gatepassnos"].ToString();
        }
        else if (tp.CompareTo("1") == 0)
        {
            start = Request.QueryString["start"].ToString();
            end = Request.QueryString["end"].ToString();
        }

        DataTable dt = new DataTable();

        dt = GetRitcoPrintSet(tp, gatepassnos, start, end);
        repgatepass.DataSource = dt;
        repgatepass.DataBind();
        if (dt.Rows.Count == 0)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=No Records Found.&detail1=May Session Expired&detail2=Problem in DataBase");
            return;
        }
    }

    public DataTable GetRitcoPrintSet(string tp, string gatepassnos, string start, string end)
    {
        string sqlstr = "SELECT m.dockno,m.mrsno,g.receivername,mrsdate=CONVERT(VARCHAR,m.mrsdt,103),";
        sqlstr = sqlstr + "m.orgncd AS orgnloc,m.mrsbr as mrbranch,dockdate=CONVERT(VARCHAR,m.dockdt,103),m.mrsbr AS mrbranch,";
        sqlstr = sqlstr + "col_oct AS octamt,col_octprchrg AS octprocchrg,d.pkgsno,d.chrgwt,godownname,packtype,m.paymode,";
        sqlstr = sqlstr + "d.privatemark,c.freight_diff,CONVERT(NUMERIC(12,2),netamt) AS netamt,c.SCHG01,c.SCHG03,c.SCHG08,c.SCHG14,c.SCHG17,c.UCHG06,c.UCHG08,CONVERT(NUMERIC(12,2),m.mrsamt) as mrsamt,CONVERT(NUMERIC(12,2),(m.col_stax + m.col_cess + m.col_h_cess)) as stax,CONVERT(VARCHAR,s.stockupdatedt,103) AS uldate,";
        sqlstr = sqlstr + "dc.subtotal AS freight,g.ptname,deladdr FROM webx_master_docket d ";
        sqlstr = sqlstr + " INNER JOIN webx_trans_docket_status s ON s.dockno=d.dockno ";
        sqlstr = sqlstr + " INNER JOIN webx_mr_hdr m ON m.dockno=d.dockno";
        sqlstr = sqlstr + " INNER JOIN webx_master_docket_charges dc ON dc.dockno=d.dockno";
        sqlstr = sqlstr + " INNER JOIN webx_mr_charges c ON c.dockno=d.dockno";
        sqlstr = sqlstr + " INNER JOIN webx_gatepass g ON m.mrsno=g.mrsno";
        sqlstr = sqlstr + " CROSS APPLY(SELECT godown_desc AS godownname FROM webx_godownmst WHERE godown_srno=s.godown)gdnm";
        sqlstr = sqlstr + " CROSS APPLY(SELECT (locaddr+ ' Tel. ' + CONVERT(VARCHAR,loctelno)) AS deladdr FROM webx_location WHERE loccode=d.reassign_destcd)dlad";
        sqlstr = sqlstr + " CROSS APPLY(SELECT codedesc AS packtype  FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd)pkty";
        sqlstr = sqlstr + " WHERE m.mrstype='6' AND s.docksf='.' ";

        gatepassnos = gatepassnos.Replace(",", "','");
        if (tp.CompareTo("0") == 0)
            sqlstr = sqlstr + "AND g.gatepassno IN ('" + gatepassnos + "')";
        else if (tp.CompareTo("1") == 0)
            sqlstr = sqlstr + "AND g.gatepassno BETWEEN '" + start + "' AND '" + end + "'";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
        }
        catch (Exception ex)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=DataBase Retrieval Failed.&detail1=May Session Expired&detail2=Problem in DataBase", false);
            return dt;
        }
        return dt;
    }


    protected void repgatepass_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lbldupremark = (Label)e.Item.FindControl("lbldupremark");
            Label lblrecievername = (Label)e.Item.FindControl("lblrecievedfrom");
            Label lblcontents = (Label)e.Item.FindControl("lblpacktype");
            Label lblthrough = (Label)e.Item.FindControl("lblthrough");
            if (lblrecievername.Text.Length > 12)
                lblrecievername.Text = lblrecievername.Text.Remove(12);

            if (lblthrough.Text.Length > 12)
                lblthrough.Text = lblthrough.Text.Remove(10);

            if (lblcontents.Text.Length > 12)
                lblcontents.Text = lblcontents.Text.Remove(12);
        }
    }
}

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
    string location = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string tp = Request.QueryString["tp"].ToString();
        location = Request.QueryString["Location"].ToString();
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
        string sqlstr = "SELECT d.from_loc,m.dockno,m.mrsno,g.receivername,mrsdate=CONVERT(VARCHAR,m.mrsdt,103),(select CodeDesc from webx_master_general where CodeType='PKGS' and CodeId=pkgsty) as Packing_Type,";
        sqlstr = sqlstr + " m.orgncd AS orgnloc,m.mrsbr as mrbranch,dockdate=CONVERT(VARCHAR,m.dockdt,103),m.mrsbr AS mrbranch,";
        sqlstr = sqlstr + " col_oct AS octamt,col_octprchrg AS octprocchrg,ISNULL(m.nopkgs,0) AS pkgsno,d.chrgwt,godownname=(SELECT godown_desc AS godownname FROM webx_godownmst WHERE godown_srno=s.godown),packtype,m.paymode,";
        sqlstr = sqlstr + " d.privatemark,c.freight_diff,CONVERT(NUMERIC(12,2),netamt) AS netamt,c.SCHG01,c.SCHG03,c.SCHG08,c.SCHG14,c.SCHG17,c.UCHG06,c.UCHG08,CONVERT(NUMERIC(12,2),m.mrsamt) as mrsamt,CONVERT(NUMERIC(12,2),(m.col_stax + m.col_cess + m.col_h_cess + Isnull(m.SBCTAX,0)+ Isnull(m.KKCTAX,0))) as stax,CONVERT(VARCHAR,s.stockupdatedt,103) AS uldate,";
        sqlstr = sqlstr + " STaxRate=(CASE WHEN C.SVCTAX=0.00 THEN 0.00 ELSE dbo.ufnGetServiceTaxRate(m.MRSDT) END)+(Case When ISNULL(m.SBCTAX,0)>0 THEN ISNULL(m.SBCRate,0) ELSE 0 END)+(Case When ISNULL(m.KKCTAX,0)>0 THEN ISNULL(m.KKCRate,0) ELSE 0 END), ";
        sqlstr = sqlstr + "(case when (CONVERT(NUMERIC(12,2),m.mrsamt)-(c.SCHG01+c.SCHG03+c.SCHG08+c.SCHG14+c.SCHG17+c.UCHG06+c.UCHG08+col_oct+col_octprchrg+c.svctax+c.cess+c.hedu_cess+ISNULL(c.SBCTAX,0)+ISNULL(c.KKCTAX,0)))<0 then 0 else (CONVERT(NUMERIC(12,2),m.mrsamt)-(c.SCHG01+c.SCHG03+c.SCHG08+c.SCHG14+c.SCHG17+c.UCHG06+c.UCHG08+col_oct+col_octprchrg++c.svctax+c.cess+c.hedu_cess+ISNULL(c.SBCTAX,0)+ISNULL(c.KKCTAX,0))) end) as freight,ptname=(Case When g.ptcd='C00040268' then isnull(m.CustomerName,'') else g.ptname end),deladdr FROM webx_master_docket d ";
        sqlstr = sqlstr + " INNER JOIN webx_trans_docket_status s ON s.dockno=d.dockno ";
        sqlstr = sqlstr + " INNER JOIN webx_mr_hdr m ON m.dockno=d.dockno AND m.mr_cancel='N'";
        sqlstr = sqlstr + " INNER JOIN webx_master_docket_charges dc ON dc.dockno=d.dockno";
        sqlstr = sqlstr + " INNER JOIN webx_mr_charges c ON c.mrsno=m.mrsno";
        sqlstr = sqlstr + " LEFT OUTER JOIN webx_gatepass g ON m.mrsno=g.mrsno";
        sqlstr = sqlstr + " CROSS APPLY(SELECT (locaddr+ ' Tel. ' + CONVERT(VARCHAR,loctelno)) AS deladdr FROM webx_location WHERE loccode=d.reassign_destcd)dlad";
        sqlstr = sqlstr + " OUTER APPLY(SELECT codedesc AS packtype  FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd)pkty";
        sqlstr = sqlstr + " WHERE m.mrstype='12' AND s.docksf='.'  AND (m.mrsbr='" + location + "' OR '" + location + "'='HQTR' OR g.gpbrcd='" + location + "')";
        
        gatepassnos = gatepassnos.Replace(",", "','");
        if (tp.CompareTo("0") == 0)
        {
            string sql = "select count(*) from webx_mr_hdr where mrsno='" + gatepassnos + "'";
            double cnt = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sql));
            if(cnt>0)            
                sqlstr = sqlstr + " AND (m.mrsno IN ('" + gatepassnos + "'))";
            else
                sqlstr = sqlstr + " AND (g.gatepassno IN ('" + gatepassnos + "'))";    

        }
        else if (tp.CompareTo("1") == 0)
            sqlstr = sqlstr + " AND g.gatepassno BETWEEN '" + start + "' AND '" + end + "'";
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

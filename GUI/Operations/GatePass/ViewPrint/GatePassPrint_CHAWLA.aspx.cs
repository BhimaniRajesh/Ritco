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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_GatePass_ViewPrint_GatePassPrint_CHAWLA : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      //  string mrno = Request.QueryString["gatepassnos"].ToString();
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

        dt = GetChawlaPrintSet(tp, gatepassnos, start, end);
        if (dt.Rows.Count == 0)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=DataBase Retrieval Failed.&detail1=May Session Expired&detail2=Problem in DataBase");
            return;
        }

        NumberToText ntt = new NumberToText();
        dt.Columns.Add("words", typeof(string));
        dt.Columns.Add("flagdup", typeof(string));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dt.Rows[i]["words"] = ntt.numberToText(dt.Rows[i]["mramount"].ToString());
            dt.Rows[i]["flagdup"] = flagdup;
        }

        repgatepass.DataSource = dt;
        repgatepass.DataBind();
    }


    protected void repgatepass_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string flagdup = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "flagdup"));
            Label lbldupremark = (Label)e.Item.FindControl("lbldupremark");
            Label lblrecievername = (Label)e.Item.FindControl("lblrecievername");
            Label lblparty = (Label)e.Item.FindControl("lblparty");
            if (lblrecievername.Text.Length > 10)
                lblrecievername.Text = lblrecievername.Text.Remove(10);

            if (lblparty.Text.Length > 10)
                lblparty.Text = lblparty.Text.Remove(10);

            if (flagdup.CompareTo("N") == 0)
                lbldupremark.Style["display"] = "none";
        }
    }

    public DataTable GetChawlaPrintSet(string tp, string gatepassnos, string start, string end)
    {
        string sqlstr = "SELECT gatepassno,s.dockno,CONVERT(VARCHAR,dely_date,103) AS deldate,godown_name AS godown,CONVERT(VARCHAR(8),";
        sqlstr = sqlstr + " dely_date, 108) AS deltime,g.ptname, locaddr,loccitypin,loctelno,d.orgncd AS fromloc,csgenm,d.chrgwt AS WEIGHT,";
        sqlstr = sqlstr + " freight,c.mrsamt AS mramount,pkgsno,paymode,product,paymentbas, thcno,(svctax+cess+hedu_cess) AS servicetax,";
        sqlstr = sqlstr + " SCHG08,SCHG14,UCHG05,SCHG15,privatemark,name,col_oct=ISNULL(m.col_oct,0),col_octprchrg=ISNULL(m.col_octprchrg,0) FROM webx_trans_docket_status s ";
        sqlstr = sqlstr + " INNER JOIN webx_master_docket d ON d.dockno=s.[DOCKNO] ";
        sqlstr = sqlstr + " INNER JOIN webx_mr_hdr m ON  m.dockno=d.[DOCKNO] ";
        sqlstr = sqlstr + " INNER JOIN webx_mr_charges c ON c.mrsno= m.mrsno";
        sqlstr = sqlstr + " INNER join webx_gatepass g ON g.dockno=s.[DOCKNO] ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 name FROM webx_master_users WHERE userid=g.entryby)empnm ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 vehno AS thcno FROM webx_tchdr th,webx_tctrn tc WHERE tc.tcno=th.tcno AND tc.dockno=d.dockno ORDER BY tcdt_sys DESC)tcth ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 godown_name,godown_desc FROM webx_godownmst WHERE godown_srno=s.godown OR SPDBRCD=curr_loc)G1 ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 (locaddr + ' Tel. No. '+ CONVERT(VARCHAR,loctelno)) AS locaddr FROM webx_location WHERE loccode=g.gpbrcd)gaddr ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 (loccity+' - '+locpincode) AS loccitypin FROM webx_location WHERE loccode=g.gpbrcd)gcitypin ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 loctelno FROM webx_location WHERE loccode=g.gpbrcd)gteleno ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 codedesc AS product FROM webx_master_general  WHERE codetype='PROD' and codeid=prodcd)prod ";
        sqlstr = sqlstr + " CROSS APPLY(SELECT TOP 1 codedesc AS paymentbas FROM webx_master_general WHERE codetype='PAYTYP' and codeid=d.paybas)paytyp ";
        sqlstr = sqlstr + " WHERE s.docksf='.' AND m.mrssf='.' AND m.mrstype='6' ";

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
        { }
        return dt;
    }

}

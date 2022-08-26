using System;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;


public partial class GUI_Operations_GatePass_ViewPrint_GatePassPrint_SARCO : System.Web.UI.Page
{

    #region Variable[s]
    private string ErrorMsg = string.Empty, docketNo = string.Empty, docketSF = string.Empty;
    protected string sdkt_call = "";
    SqlConnection conn;
    #endregion

    #region Event[e]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string tp = Request.QueryString["tp"].ToString();
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string docknos = string.Empty;

            if (Request.QueryString["docknos"] != null)
            {
                docknos = Convert.ToString(Request.QueryString["docknos"]);
            }

           //  docknos = "0762382,0762392,0762393";

            string sqlstr = "SELECT MR.FREIGHT as freight, MR.mrsamt AS Total, Arrived_DT=CONVERT(varchar,s.Arrived_DT,103), g.ptcd + '-' + g.ptname AS PARTY, g.gatepassno, gatepassdate=CONVERT(varchar,g.gatepassdate,103), policydt=CONVERT(varchar,insupldt,103),InvoiceAmount,orgnaddr,booktime=CONVERT(varchar,dockdt_entry,108),dockdate=CONVERT(varchar,dockdt,103),";
            sqlstr = sqlstr + " csgnaddr=(CASE csgncd WHEN '8888' THEN (csgnnm + '- ' + csgnaddr + ', ' + csgncity + ' - ' +csgnpincode) ELSE (SELECT TOP 1 custaddress FROM webx_custhdr WHERE custcd=csgncd) END),";
            sqlstr = sqlstr + " csgeaddr=(CASE csgecd WHEN '8888' THEN (csgnnm + '- ' + csgeaddr + ', ' + csgecity + ' - ' +csgepincode) ELSE (SELECT TOP 1 custaddress FROM webx_custhdr WHERE custcd=csgecd) END),";
            sqlstr = sqlstr + " (MR.svctax+MR.cess+MR.hedu_cess) AS servicetax,insupl AS policyno,policydate=CONVERT(varchar,insupldt,108),";
            sqlstr = sqlstr + " pkgsno=CONVERT(NUMERIC,pkgsno),staxpayer=(CASE stax_paidby WHEN 'T' THEN 'TRANSPORTER' WHEN 'CO' THEN 'CONSIGNOR' WHEN 'CE' THEN 'CONSIGNEE' WHEN 'P' THEN 'BILLING PARTY' END),*";
            sqlstr = sqlstr + " FROM webx_master_docket d";
            // sqlstr = sqlstr + " INNER JOIN webx_master_docket_charges c ON d.dockno=c.dockno";
            sqlstr = sqlstr + " INNER JOIN webx_trans_docket_status s ON d.dockno=s.dockno";
            sqlstr = sqlstr + " INNER JOIN webx_gatepass g ON d.dockno=g.dockno";
            sqlstr = sqlstr + " INNER JOIN webx_MR_charges MR ON MR.dockno=g.dockno";
            sqlstr = sqlstr + " CROSS APPLY (SELECT invamt As InvoiceAmount FROM  webx_trans_docket_status WHERE dockno = d.dockno)Invoice";
            sqlstr = sqlstr + " CROSS APPLY (SELECT locaddr AS orgnaddr FROM webx_location WHERE loccode=orgncd)orlc";
            sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS paybasname FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=paybas)payname";
            sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS modename FROM webx_master_general WHERE codetype='TRN' AND codeid=trn_mod)trnanme";
            sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS prodname FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd)prodname";
            sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS businessname FROM webx_master_general WHERE codetype='BUT' AND codeid=businesstype)busname";
            sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS packname FROM webx_master_general WHERE codetype='PKGS' AND codeid=pkgsty)packname";
            sqlstr = sqlstr + " CROSS APPLY (SELECT SUM(tot_cft) AS cfttot FROM WebX_Master_Docket_Invoice WHERE dockno=d.dockno)totcft";
           

            if (tp.CompareTo("0") == 0)
            {
                string strdocknos = Request.QueryString["docknos"].ToString();
                strdocknos = strdocknos.Replace(",", "','");
                sqlstr = sqlstr + " WHERE g.gatepassno IN ('" + strdocknos + "')";
            }
            else if (tp.CompareTo("1") == 0)
            {
                string start = "", end = "";
                start = Request.QueryString["start"].ToString();
                end = Request.QueryString["end"].ToString();
                sqlstr = sqlstr + " WHERE g.gatepassno BETWEEN '" + start + "' AND '" + end + "' ORDER BY g.gatepassno";
            }

            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            cmd.CommandType = CommandType.Text;

            DataSet ds = new DataSet();
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                repdocket.DataSource = ds.Tables[0];
                repdocket.DataBind();
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }

    protected void repdocket_OnItemDataBound(object sender, RepeaterItemEventArgs e)
     {
        RupeesToWords objRupeesToWords = new RupeesToWords();
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblTotalR = ((Label)e.Item.FindControl("lblTotalR"));
            Label lblTotalG = ((Label)e.Item.FindControl("lblTotalG"));

            if (!string.IsNullOrEmpty(lblTotalR.Text))
            {
                Label lblRsR = ((Label)e.Item.FindControl("lblRsR"));
                lblRsR.Text = objRupeesToWords.NumberToText(Convert.ToInt64(Math.Round(Convert.ToDouble(lblTotalR.Text.Trim()),0,MidpointRounding.AwayFromZero)));
            }

            if (!string.IsNullOrEmpty(lblTotalG.Text))
            {
                Label lblRS = ((Label)e.Item.FindControl("lblRS"));
                lblRS.Text = objRupeesToWords.NumberToText(Convert.ToInt64(Math.Round(Convert.ToDouble(lblTotalG.Text.Trim()), 0, MidpointRounding.AwayFromZero)));
            }
        }
    }
    #endregion
}
